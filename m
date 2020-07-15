From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/7] *** IRQ offloading for vDPA ***
Date: Wed, 15 Jul 2020 21:43:56 +0800
Message-ID: <70244d80-08a4-da91-3226-7bfd2019467e@redhat.com>
References: <1594565524-3394-1-git-send-email-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1594565524-3394-1-git-send-email-lingshan.zhu@intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/7/12 下午10:52, Zhu Lingshan wrote:
> Hi All,
>
> This series intends to implement IRQ offloading for
> vhost_vdpa.
>
> By the feat of irq forwarding facilities like posted
> interrupt on X86, irq bypass can  help deliver
> interrupts to vCPU directly.
>
> vDPA devices have dedicated hardware backends like VFIO
> pass-throughed devices. So it would be possible to setup
> irq offloading(irq bypass) for vDPA devices and gain
> performance improvements.
>
> In my testing, with this feature, we can save 0.1ms
> in a ping between two VFs on average.


Hi Lingshan:

During the virtio-networking meeting, Michael spots two possible issues:

1) do we need an new uAPI to stop the irq offloading?
2) can interrupt lost during the eventfd ctx?

For 1) I think we probably not, we can allocate an independent eventfd 
which does not map to MSIX. So the consumer can't match the producer and 
we fallback to eventfd based irq.
For 2) it looks to me guest should deal with the irq synchronization 
when mask or unmask MSIX vectors.

What's your thought?

Thanks


>
>
> Zhu Lingshan (7):
>    vhost: introduce vhost_call_ctx
>    kvm/vfio: detect assigned device via irqbypass manager
>    vhost_vdpa: implement IRQ offloading functions in vhost_vdpa
>    vDPA: implement IRQ offloading helpers in vDPA core
>    virtio_vdpa: init IRQ offloading function pointers to NULL.
>    ifcvf: replace irq_request/free with helpers in vDPA core.
>    irqbypass: do not start consumer or producer when failed to connect
>
>   arch/x86/kvm/x86.c              | 10 ++++--
>   drivers/vdpa/ifcvf/ifcvf_main.c | 11 +++---
>   drivers/vdpa/vdpa.c             | 46 +++++++++++++++++++++++++
>   drivers/vhost/Kconfig           |  1 +
>   drivers/vhost/vdpa.c            | 75 +++++++++++++++++++++++++++++++++++++++--
>   drivers/vhost/vhost.c           | 22 ++++++++----
>   drivers/vhost/vhost.h           |  9 ++++-
>   drivers/virtio/virtio_vdpa.c    |  2 ++
>   include/linux/vdpa.h            | 11 ++++++
>   virt/kvm/vfio.c                 |  2 --
>   virt/lib/irqbypass.c            | 16 +++++----
>   11 files changed, 181 insertions(+), 24 deletions(-)
>
