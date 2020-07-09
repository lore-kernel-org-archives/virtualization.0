From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
Date: Thu, 9 Jul 2020 11:55:53 +0200
Message-ID: <20200709115553.2dde6ab1.pasic@linux.ibm.com>
References: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
        <1594283959-13742-3-git-send-email-pmorel@linux.ibm.com>
        <20200709105733.6d68fa53.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200709105733.6d68fa53.cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 9 Jul 2020 10:57:33 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  9 Jul 2020 10:39:19 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > If protected virtualization is active on s390, the virtio queues are
> > not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
> > negotiated. Use the new arch_validate_virtio_features() interface to
> > fail probe if that's not the case, preventing a host error on access
> > attempt

Punctuation at the end?

Also 'that's not the case' refers to the negation
'VIRTIO_F_IOMMU_PLATFORM has been negotiated',
arch_validate_virtio_features() is however part of
virtio_finalize_features(), which is in turn part of the feature
negotiation. But that is details. I'm fine with keeping the message as
is. 

> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  arch/s390/mm/init.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > index 6dc7c3b60ef6..b8e6f90117da 100644
> > --- a/arch/s390/mm/init.c
> > +++ b/arch/s390/mm/init.c
> > @@ -45,6 +45,7 @@
> >  #include <asm/kasan.h>
> >  #include <asm/dma-mapping.h>
> >  #include <asm/uv.h>
> > +#include <linux/virtio_config.h>
> >  
> >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
> >  
> > @@ -161,6 +162,32 @@ bool force_dma_unencrypted(struct device *dev)
> >  	return is_prot_virt_guest();
> >  }
> >  
> > +/*
> > + * arch_validate_virtio_features
> > + * @dev: the VIRTIO device being added
> > + *
> > + * Return an error if required features are missing on a guest running
> > + * with protected virtualization.
> > + */
> > +int arch_validate_virtio_features(struct virtio_device *dev)
> > +{
> > +	if (!is_prot_virt_guest())
> > +		return 0;
> > +
> > +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
> > +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
> 
> I'd probably use "legacy virtio not supported with protected
> virtualization".
> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
> > +		dev_warn(&dev->dev,
> > +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
> 
> "support for limited memory access required for protected
> virtualization"
> 
> ?
> 
> Mentioning the feature flag is shorter in both cases, though.

I liked the messages in v4. Why did we change those? Did somebody
complain?

I prefer the old ones, but it any case:

Acked-by: Halil Pasic <pasic@linux.ibm.com>


> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* protected virtualization */
> >  static void pv_init(void)
> >  {
> 
> Either way,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
