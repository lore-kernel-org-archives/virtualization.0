From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Date: Mon, 24 Feb 2020 14:56:07 +0100
Message-ID: <20200224145607.2729f47b.pasic@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
        <20200221155602.4de41fa7.pasic@linux.ibm.com>
        <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
        <20200224010607-mutt-send-email-mst@kernel.org>
        <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
        <20200224024641-mutt-send-email-mst@kernel.org>
        <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 24 Feb 2020 17:26:20 +0800
Jason Wang <jasowang@redhat.com> wrote:

> That's better.
> 
> How about attached?
> 
> Thanks

Thanks Jason! It does avoid the translation overhead in vhost.

Tested-by: Halil Pasic <pasic@linux.ibm.com>

Regarding the code, you fence it in virtio-net.c, but AFAIU this feature
has relevance for other vhost devices as well. E.g. what about vhost
user? Would it be the responsibility of each virtio device to fence this
on its own?

I'm also a bit confused about the semantics of the vhost feature bit
F_ACCESS_PLATFORM. What we have specified on virtio level is:
"""
This feature indicates that the device can be used on a platform where
device access to data in memory is limited and/or translated. E.g. this
is the case if the device can be located behind an IOMMU that translates
bus addresses from the device into physical addresses in memory, if the
device can be limited to only access certain memory addresses or if
special commands such as a cache flush can be needed to synchronise data
in memory with the device. Whether accesses are actually limited or
translated is described by platform-specific means. If this feature bit
is set to 0, then the device has same access to memory addresses
supplied to it as the driver has. In particular, the device will always
use physical addresses matching addresses used by the driver (typically
meaning physical addresses used by the CPU) and not translated further,
and can access any address supplied to it by the driver. When clear,
this overrides any platform-specific description of whether device
access is limited or translated in any way, e.g. whether an IOMMU may be
present.
"""

I read this like the addresses may be IOVAs which require
IMMU translation or GPAs which don't.

On the vhost level however, it seems that F_IOMMU_PLATFORM means that
vhost has to do the translation (via IOTLB API).

Do I understand this correctly? If yes, I believe we should document
this properly.

BTW I'm still not 100% on the purpose and semantics of the
F_ACCESS_PLATFORM feature bit. But that is a different problem.

Regards,
Halil
