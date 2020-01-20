From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Mon, 20 Jan 2020 16:43:53 +0800
Message-ID: <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Shahaf Shuler <shahafs@mellanox.com>, Rob Miller <rob.miller@broadcom.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Gunthorpe <jgg@mellanox.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "Tian, Kevin" <kevin.>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/19 =E4=B8=8B=E5=8D=885:07, Shahaf Shuler wrote:
> Friday, January 17, 2020 4:13 PM, Rob Miller:
> Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
>>> On 2020/1/17 =E4=B8=8B=E5=8D=888:13, Michael S. Tsirkin wrote:
>>>> On Thu, Jan 16, 2020 at 08:42:29PM +0800, Jason Wang wrote:
> [...]
>
>>>> + * @set_map:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Set device memory mapping, optional
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 and only needed for device that using
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 device specific DMA translation
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (on-chip IOMMU)
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @iotlb: vhost memory mapping to be
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 used by the vDPA
>>>> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Returns integer: success (0) or error (< 0)
>>> OK so any change just swaps in a completely new mapping?
>>> Wouldn't this make minor changes such as memory hotplug
>>> quite expensive?
> What is the concern? Traversing the rb tree or fully replace the on-chi=
p IOMMU translations?
> If the latest, then I think we can take such optimization on the driver=
 level (i.e. to update only the diff between the two mapping).


This is similar to the design of platform IOMMU part of vhost-vdpa. We=20
decide to send diffs to platform IOMMU there. If it's ok to do that in=20
driver, we can replace set_map with incremental API like map()/unmap().

Then driver need to maintain rbtree itself.


> If the first one, then I think memory hotplug is a heavy flow regardles=
s. Do you think the extra cycles for the tree traverse will be visible in=
 any way?


I think if the driver can pause the DMA during the time for setting up=20
new mapping, it should be fine.


>  =20
>
>> My understanding is that the incremental updating of the on chip IOMMU
>> may degrade the=C2=A0 performance. So vendor vDPA drivers may want to =
know
>> all the mappings at once.
> Yes exact. For Mellanox case for instance many optimization can be perf=
ormed on a given memory layout.
>
>> Technically, we can keep the incremental API
>> here and let the vendor vDPA drivers to record the full mapping
>> internally which may slightly increase the complexity of vendor driver=
.
> What will be the trigger for the driver to know it received the last ma=
pping on this series and it can now push it to the on-chip IOMMU?


For GPA->HVA(HPA) mapping, we can have flag for this.

But for GIOVA_>HVA(HPA) mapping which could be changed by guest, it=20
looks to me there's no concept of "last mapping" there. I guess in this=20
case, mappings needs to be set from the ground. This could be expensive=20
but consider most application uses static mappings (e.g dpdk in guest).=20
It should be ok.

Thanks


>
>> We need more inputs from vendors here.
>>
>> Thanks
>
