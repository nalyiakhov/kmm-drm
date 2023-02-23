package sais.darom.android

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import org.imaginativeworld.whynotimagecarousel.ImageCarousel
import org.imaginativeworld.whynotimagecarousel.model.CarouselItem
import sais.darom.android.databinding.FragmentItemBinding
import sais.darom.android.views.DescriptionView
import sais.darom.models.Item

class ItemFragment: Fragment() {
	private var binding: FragmentItemBinding? = null
	private var carouselView: ImageCarousel? = null
	private var titleTextView: TextView? = null
	private var descriptionTextView: TextView? = null
	private var descriptionsView: LinearLayout? = null
	private var buyButton: Button? = null

	private lateinit var item: Item

	override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
		binding = FragmentItemBinding.inflate(inflater)
		return binding!!.root
	}

	override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
		super.onViewCreated(view, savedInstanceState)

		carouselView = binding?.carousel
		carouselView?.registerLifecycle(lifecycle)
		carouselView?.imagePlaceholder = ContextCompat.getDrawable(view.context, R.drawable.empty )

		titleTextView = binding?.itemTitle
		descriptionTextView = binding?.itemDescription
		descriptionsView = binding?.itemDescriptions
		buyButton = binding?.buyButton

		item = Json.decodeFromString(arguments?.getString("item", "{}") ?: "{}")

		setupViews()
	}

	private fun setupViews() {
		val list = mutableListOf<CarouselItem>()
		for (imageUrl in item.previewImages) {
			list.add(CarouselItem(imageUrl = imageUrl))
		}
		carouselView?.setData(list)

		titleTextView?.text = item.title
		descriptionTextView?.text = item.descr
		buyButton?.text = item.priceString

		context?.let {
			for (description in item.getDescriptions()) {
				val descriptionView = DescriptionView(it)
				descriptionView.setup(description.key,  description.value)
				descriptionsView?.addView(descriptionView)
			}
		}
	}
}