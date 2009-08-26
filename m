From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 2/2] vhost_net: a kernel-level virtio server
Date: Wed, 26 Aug 2009 15:40:59 +0200
Message-ID: <200908261540.59900.arnd__1012.70651580325$1251294383$gmane$org@arndb.de>
References: <cover.1250693417.git.mst@redhat.com>
	<200908252140.41295.rusty@rustcorp.com.au>
	<20090825175016.GA15790@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090825175016.GA15790@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 25 August 2009, Michael S. Tsirkin wrote:
> >  I'd like to avoid that here,
> > though it's kind of ugly.  We'd need VHOST_GET_FEATURES (and ACK) to take a
> > struct like:
> > 
> >       u32 feature_size;
> >       u32 features[];

Hmm, variable length ioctl arguments, I'd rather not go there.
The ioctl infrastructure already has a length argument encoded
in the ioctl number. We can use that if we need more, e.g.

/* now */
#define VHOST_GET_FEATURES     _IOR(VHOST_VIRTIO, 0x00, __u64)
/*
 * uncomment if we run out of feature bits:

struct vhost_get_features2 {
	__u64 bits[2];
};
#define VHOST_GET_FEATURES2     _IOR(VHOST_VIRTIO, 0x00, \
			struct  vhost_get_features2)
 */

> Thinking about this proposal some more, how will the guest
> determine the size to supply the GET_FEATURES ioctl?

Wait, the *guest*?

Maybe I misunderstood something in a major way here, but
I expected the features to be negotiated between host
user space (qemu) and host kernel, as well as between
guest and qemu (as they are already), but never between
guest and kernel.

I would certainly expect the bits to be distinct from
the virtio-net feature bits. E.g. stuff like TAP frame
format opposed to TCP socket frame format (length+date)
is something we need to negotiate here but that the
guest does not care about.

> Since we are a bit tight in 32 bit space already,
> let's just use a 64 bit integer and be done with it?

Can't hurt, but don't use a struct unless you think
we are going to need more than 64 bits.

	Arnd <><
