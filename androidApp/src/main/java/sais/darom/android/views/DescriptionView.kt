package sais.darom.android.views

import android.content.Context
import android.view.LayoutInflater
import android.widget.LinearLayout
import android.widget.TextView
import sais.darom.android.databinding.ItemDescriptionBinding

class DescriptionView(context: Context): LinearLayout(context) {
	private var binding: ItemDescriptionBinding
	private var nameTextView: TextView?
	private var valueTextView: TextView?

	init {
		binding = ItemDescriptionBinding.inflate(LayoutInflater.from(context), this, true)

		nameTextView = binding.name
		valueTextView = binding.value
	}

	fun setup(name: String, value: String) {
		nameTextView?.text = name
		valueTextView?.text = value
	}
}