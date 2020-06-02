From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Tue, 2 Jun 2020 15:12:27 +0800
Message-ID: <e722bb62-2a72-779a-f542-1096e8f609b8@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010809-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200602010809-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/2 下午1:09, Michael S. Tsirkin wrote:
> On Fri, May 29, 2020 at 04:03:02PM +0800, Jason Wang wrote:
>> Note that since virtio specification does not support get/restore
>> virtqueue state. So we can not use this driver for VM. This can be
>> addressed by extending the virtio specification.
> Looks like exactly the kind of hardware limitation VDPA is supposed to
> paper over within guest. So I suggest we use this as
> a litmus test, and find ways for VDPA to handle this without
> spec changes.


Yes, and just to confirm, do you think it's beneficial to extend virtio 
specification to support state get/set?

Thanks


>
