From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 02/46] virtio: use u32, not bitmap for features
Date: Sat, 29 Nov 2014 19:34:12 +0200
Message-ID: <20141129173412.GH22746@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-3-git-send-email-mst@redhat.com>
	<20141128134457.37e427ce.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141128134457.37e427ce.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: rusty@au1.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>, Siva Yerramreddy <yshivakrishna@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, dahi@linux.vnet.ibm.com, Amit Shah <amit.shah@redhat.com>, linux390@de.ibm.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 28, 2014 at 01:44:57PM +0100, Cornelia Huck wrote:
> On Thu, 27 Nov 2014 22:07:41 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > It seemed like a good idea to use bitmap for features
> > in struct virtio_device, but it's actually a pain,
> > and seems to become even more painful when we get more
> > than 32 feature bits.  Just change it to a u32 for now.
> > 
> > Based on patch by Rusty.
> > 
> > Suggested-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > index d34ebfa..ab95a4c 100644
> > --- a/drivers/virtio/virtio_pci.c
> > +++ b/drivers/virtio/virtio_pci.c
> > @@ -120,8 +120,7 @@ static void vp_finalize_features(struct virtio_device *vdev)
> >  	vring_transport_features(vdev);
> > 
> >  	/* We only support 32 feature bits. */
> 
> I think you can kill this comment...

Why? It's still true for virtio pci at this point, that's why we
just do iowrite32 here.

> > -	BUILD_BUG_ON(ARRAY_SIZE(vdev->features) != 1);
> > -	iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
> > +	iowrite32(vdev->features, vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
> 
> ...and add blanks around '+', as you're touching this line anyway.
> 
> >  }
> > 
> >  /* virtio config->get() implementation */
> 
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
