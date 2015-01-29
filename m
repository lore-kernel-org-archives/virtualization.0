From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Thu, 29 Jan 2015 12:54:34 +0200
Message-ID: <20150129105434.GC8600@redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20150122014343.GG27371@voom.fritz.box>
	<20150128165945.530d3a11.cornelia.huck@de.ibm.com>
	<20150129001132.GE14681@voom>
	<20150129102400.100982a3@oc7435384737.ibm.com>
	<20150129100145.GB10150@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150129100145.GB10150@voom.fritz.box>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: virtualization@lists.linux-foundation.org, Thomas Huth <thuth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 29, 2015 at 09:01:45PM +1100, David Gibson wrote:
> On Thu, Jan 29, 2015 at 10:24:00AM +0100, Thomas Huth wrote:
> > 
> >  Hi,
> > 
> > On Thu, 29 Jan 2015 11:11:32 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > On Wed, Jan 28, 2015 at 04:59:45PM +0100, Cornelia Huck wrote:
> > > > On Thu, 22 Jan 2015 12:43:43 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > 
> > > > > On Thu, Dec 11, 2014 at 02:25:07PM +0100, Cornelia Huck wrote:
> > > > > > With virtio-1, we support more than 32 feature bits. Let's extend both
> > > > > > host and guest features to 64, which should suffice for a while.
> > > > > > 
> > > > > > vhost and migration have been ignored for now.
> > > > > 
> > > > > [snip]
> > > > > 
> > > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > > > index f6c0379..08141c7 100644
> > > > > > --- a/include/hw/virtio/virtio.h
> > > > > > +++ b/include/hw/virtio/virtio.h
> > > > > > @@ -55,6 +55,12 @@
> > > > > >  /* A guest should never accept this.  It implies negotiation is broken. */
> > > > > >  #define VIRTIO_F_BAD_FEATURE		30
> > > > > >  
> > > > > > +/* v1.0 compliant. */
> > > > > > +#define VIRTIO_F_VERSION_1              32
> > > > > 
> > > > > This is already in the kernel header, isn't it?
> > > 
> > > > 
> > > > Yes. But nearly all files include this header but not the kernel
> > > > header.
> > > 
> > > Can't you change that?  Or this file include the kernel header?
> >  
> > AFAIK non-KVM code should never try to include one of the Linux headers
> > to avoid breaking on non-Linux platforms (for example <linux/types.h> is
> > not available on OS X, see http://patchwork.ozlabs.org/patch/424655/ ).
> > So it's a little bit ugly to define these things twice, but it seems
> > the only way to stay portable.
> 
> Ah, yeah, good point.

I do intend to write a script to import more headers from linux,
changing them on the fly to drop dependency on linux/types.h
etc.

If someone wants to beat me to it, so much the better.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
