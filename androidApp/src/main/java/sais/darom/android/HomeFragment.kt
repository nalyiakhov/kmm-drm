package sais.darom.android

import android.opengl.Visibility
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
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.modules.SerializersModule
import sais.darom.UserData
import sais.darom.android.data.ItemAdapter
import sais.darom.android.databinding.FragmentHomeBinding
import sais.darom.customCoroutineScope
import sais.darom.models.Item
import sais.drm.SharedRes

class HomeFragment: Fragment() {
    private var binding: FragmentHomeBinding? = null
    private var gridView: GridView? = null
    private var emptyLayout: View? = null
    private var progressBar: ProgressBar? = null

    private lateinit var items: ArrayList<Item>
    private lateinit var itemAdapter: ItemAdapter

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

        customCoroutineScope.launch {
            try {
                loadData()
            } catch (ex: Exception) {
                withContext(Dispatchers.Main) {
                    context?.let {
                        Toast.makeText(it, ex.localizedMessage, Toast.LENGTH_LONG)
                    }
                }
            } finally {
                withContext(Dispatchers.Main) {
                    progressBar?.visibility = View.GONE
                }
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        binding = null
    }

    private suspend fun loadData() {
        items = ArrayList(UserData.itemsService.loadItems())

        withContext(Dispatchers.Main) {
            setupViews()
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