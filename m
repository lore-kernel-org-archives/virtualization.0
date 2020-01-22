From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Wed, 22 Jan 2020 14:18:01 +0800
Message-ID: <26fa6211-6625-6dc6-f5df-7a124d8c53ae@redhat.com>
References: <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
 <AM0PR0502MB379553984D0D55FDE25426F6C3330@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <d69918ca-8af4-44b2-9652-633530d4c113@redhat.com>
 <20200120174933.GB3891@mellanox.com>
 <2a324cec-2863-58f4-c58a-2414ee32c930@redhat.com>
 <20200121004047-mutt-send-email-mst@kernel.org>
 <b9ad744e-c4cd-82f9-f56a-1ecc185e9cd7@redhat.com>
 <20200121031506-mutt-send-email-mst@kernel.org>
 <20200121140456.GA12330@mellanox.com>
 <20200121091636-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200121091636-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Shahaf Shuler <shahafs@mellanox.com>, Rob Miller <rob.miller@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "Tian, Kevin" <kevin>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/21 =E4=B8=8B=E5=8D=8810:17, Michael S. Tsirkin wrote:
> On Tue, Jan 21, 2020 at 02:05:04PM +0000, Jason Gunthorpe wrote:
>> On Tue, Jan 21, 2020 at 03:15:43AM -0500, Michael S. Tsirkin wrote:
>>>> This sounds more flexible e.g driver may choose to implement static =
mapping
>>>> one through commit. But a question here, it looks to me this still r=
equires
>>>> the DMA to be synced with at least commit here. Otherwise device may=
 get DMA
>>>> fault? Or device is expected to be paused DMA during begin?
>>>>
>>>> Thanks
>>> For example, commit might switch one set of tables for another,
>>> without need to pause DMA.
>> I'm not aware of any hardware that can do something like this
>> completely atomically..
> FWIW VTD can do this atomically.
>
>> Any mapping change API has to be based around add/remove regions
>> without any active DMA (ie active DMA is a guest error the guest can
>> be crashed if it does this)
>>
>> Jason
> Right, lots of cases are well served by only changing parts of
> mapping that aren't in active use. Memory hotplug is such a case.
> That's not the same as a completely static mapping.


For hotplug it should be fine with current Qemu since it belongs to=20
different memory regions. So each dimm should have its own dedicated map=20
entries in IOMMU.

But I'm not sure if the merging logic in current vhost memory listener=20
may cause any trouble, we may need to disable it.

Thanks


>
