import React, {useEffect, useState} from 'react'
import SkinItem from './SkinItem.jsx'

export default function Clothes({data}) {
  const handleSkinChange = (e) => {
    data.find((o, i) => {
      if(o.name === e.name) {
        data[i].currentValue = e.currentValue
        return
      }
    })

    fetch('https://rpx-appearance/applyClothes', {method: 'POST', body: JSON.stringify({
      values: data
    })})
  }

  return (
    <div className="clothingMenu">
      <div className="clothingMenu_options">
        {data.map((i, k) => <SkinItem data={i} key={k} onSkinChange={handleSkinChange} />)}
      </div>
    </div>
  )
}