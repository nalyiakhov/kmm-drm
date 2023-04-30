package sais.darom.android

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.GridView
import android.widget.ProgressBar
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import sais.darom.UserData
import sais.darom.android.data.ItemAdapter
import sais.darom.android.databinding.FragmentHomeBinding
import sais.darom.android.views.CustomToast
import sais.darom.customCoroutineScope
import sais.darom.models.Item
import sais.drm.SharedRes

class HomeFragment: Fragment() {
    private var binding: FragmentHomeBinding? = null
    private var gridView: GridView? = null
    private var emptyLayout: View? = null
    private var progressBar: ProgressBar? = null

    private lateinit var itemAdapter: ItemAdapter
    private var items: ArrayList<Item> = arrayListOf()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        binding = FragmentHomeBinding.inflate(inflater)

        val bind = binding!!
        gridView = bind.grid
        emptyLayout = bind.layoutNoData.emptyData
        progressBar = bind.progressBar

        return bind.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        progressBar?.visibility = View.VISIBLE

        loadData()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        binding = null
    }

    private fun loadData() {
        customCoroutineScope.launch {
            try {
                items = ArrayList(UserData.itemsService.loadItems())
            } catch (ex: Exception) {
                withContext(Dispatchers.Main) {
                    context?.let {
                        CustomToast.show(SharedRes.strings.loading_error.getString(it))
                    }
                }
            } finally {
                withContext(Dispatchers.Main) {
                    setupViews()
                    progressBar?.visibility = View.GONE
                }
            }
        }
    }

    private fun setupViews() {
        emptyLayout?.visibility = if (items.isNotEmpty()) View.GONE else View.VISIBLE

        itemAdapter = ItemAdapter(requireContext(), items)
        gridView?.adapter = itemAdapter

        binding?.let {
            val controller = Navigation.findNavController(it.root)

            gridView?.onItemClickListener = AdapterView.OnItemClickListener { _, _, position, _ ->
                val item = items.getOrNull(position) ?: return@OnItemClickListener

                val bundle = Bundle()
                bundle.putString("item", Json.encodeToString(item))
                controller.navigate(R.id.nav_item, bundle)
            }
        }
    }
}