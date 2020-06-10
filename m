From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RESEND V2] vdpa: introduce virtio pci driver
Date: Wed, 10 Jun 2020 14:16:26 +0800
Message-ID: <0964bd2d-8329-a091-41ed-a9b912ec4283@redhat.com>
References: <20200610054951.16197-1-jasowang@redhat.com>
 <20200610020728-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200610020728-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/10 下午2:07, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 01:49:51PM +0800, Jason Wang wrote:
>> This patch introduce a vDPA driver for virtio-pci device. It bridges
>> the virtio-pci control command to the vDPA bus. This will be used for
>> developing new features for both software vDPA framework and hardware
>> vDPA feature.
>>
>> Compared to vdpa_sim, it has several advantages:
>>
>> - it's a real device driver which allow us to play with real hardware
>>    features
>> - type independent instead of networking specific
>>
>> Note that since virtio specification does not support get/restore
>> virtqueue state. So we can not use this driver for VM. This can be
>> addressed by extending the virtio specification.
>>
>> Consider the driver is mainly for testing and development for vDPA
>> features, it can only be bound via dynamic ids to make sure it's not
>> conflict with the drivers like virtio-pci or IFCVF.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> error: sha1 information is lacking or useless (drivers/vdpa/Kconfig).
>
> which tree is this on top of?


Your vhost.git vhost branch, HEAD is bbea3bcfd1d6 vdpa: fix typos in the 
comments for __vdpa_alloc_device()

Do I need to use other branch?

Thanks


>
