package sais.darom.android.views

import android.content.Context
import android.view.LayoutInflater
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.squareup.picasso.Picasso
import sais.darom.Constants
import sais.darom.android.R
import sais.darom.android.databinding.FragmentHomeBinding
import sais.darom.android.databinding.ItemCardBinding
import sais.darom.models.Item

class ItemView(context: Context): LinearLayout(context) {
	private var titleTextView: TextView
	private var imageView: ImageView
	private var binding: ItemCardBinding

	init {
		binding = ItemCardBinding.inflate(LayoutInflater.from(context), this, true)

		imageView = binding.image
		titleTextView = binding.title
	}

	fun setup(item: Item) {
		Picasso.get().load(item.preview ?: (Constants.API_BASE + Constants.PREVIEW_EMPTY)).placeholder(R.drawable.empty).into(imageView)
		titleTextView.text = item.title
	}
}