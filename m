From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 05/20] virtio: support more feature
	bits
Date: Wed, 28 Jan 2015 16:59:45 +0100
Message-ID: <20150128165945.530d3a11.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20150122014343.GG27371@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150122014343.GG27371@voom.fritz.box>
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
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Jan 2015 12:43:43 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Dec 11, 2014 at 02:25:07PM +0100, Cornelia Huck wrote:
> > With virtio-1, we support more than 32 feature bits. Let's extend both
> > host and guest features to 64, which should suffice for a while.
> > 
> > vhost and migration have been ignored for now.
> 
> [snip]
> 
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index f6c0379..08141c7 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -55,6 +55,12 @@
> >  /* A guest should never accept this.  It implies negotiation is broken. */
> >  #define VIRTIO_F_BAD_FEATURE		30
> >  
> > +/* v1.0 compliant. */
> > +#define VIRTIO_F_VERSION_1              32
> 
> This is already in the kernel header, isn't it?
> 

Yes. But nearly all files include this header but not the kernel
header.
