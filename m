From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Mon, 8 Jun 2020 17:46:52 +0800
Message-ID: <bc27064c-2309-acf3-ccd8-6182bfa2a4cd@redhat.com>
References: <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
 <20200607095012-mutt-send-email-mst@kernel.org>
 <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
 <20200608021438-mutt-send-email-mst@kernel.org>
 <a1b1b7fb-b097-17b7-2e3a-0da07d2e48ae@redhat.com>
 <20200608052041-mutt-send-email-mst@kernel.org>
 <9d2571b6-0b95-53b3-6989-b4d801eeb623@redhat.com>
 <20200608054453-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200608054453-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/8 下午5:45, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2020 at 05:43:58PM +0800, Jason Wang wrote:
>>>> Looking at
>>>> pci_match_one_device() it checks both subvendor and subdevice there.
>>>>
>>>> Thanks
>>> But IIUC there is no guarantee that driver with a specific subvendor
>>> matches in presence of a generic one.
>>> So either IFC or virtio pci can win, whichever binds first.
>>
>> I'm not sure I get there. But I try manually bind IFCVF to qemu's
>> virtio-net-pci, and it fails.
>>
>> Thanks
> Right but the reverse can happen: virtio-net can bind to IFCVF first.


That's kind of expected. The PF is expected to be bound to virtio-pci to 
create VF via sysfs.

Thanks



>
