From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFCv2 00/12] Introduce host-side virtio queue and CAIF Virtio.
Date: Thu, 6 Dec 2012 12:27:50 +0200
Message-ID: <20121206102750.GF10837@redhat.com>
References: <871ug75vp1.fsf@rustcorp.com.au>
	<1354718230-4486-1-git-send-email-sjur@brendeland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1354718230-4486-1-git-send-email-sjur@brendeland.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur@brendeland.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, virtualization@lists.linux-foundation.org, Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 05, 2012 at 03:36:58PM +0100, Sjur Br=E6ndeland wrote:
> Feedback on this patch-set is appreciated, particularly on structure
> and code-reuse between vhost.c and the host-side virtio-queue.
> I'd also like some suggestions on how to handle the build configuration
> better - currently there are some unnecessary build dependencies.

Rusty seems to disagree but one of the concerns people have about vhost
is security; so I value getting as much static checking as we can.  This
discards __user annotations so this doesn't work for me.

I also have concerns about how much overhead an indirect function
call on each 2 byte access would have.

After thinking about this I think there's no way without using a
preprocessor. But using a preprocessor it's not very bad: we'll have to
make everything inline in header but that's not terrible as the
functions are pretty short: it's less about code size and more about
avoiding code duplication.

Basically like this:

/* Legal values for VIRTIO_HOST_MODE */
#define VIRTIO_HOST_KERNEL 0
#define VIRTIO_HOST_USER 1

#if defined(VIRTIO_HOST_H) && VIRTIO_HOST_H !=3D VIRTIO_HOST_MODE
#error "Header included twice with VIRTIO_HOST_MODE redefined"
#endif

#ifndef VIRTIO_HOST_H
/* Besides serving as a double inclusion guard, this
 * verifies that multiple inclusions define VIRTIO_HOST_MODE
 * consistently.
 */
#define VIRTIO_HOST_H VIRTIO_HOST_MODE

#ifndef VIRTIO_HOST_MODE
#error "Must define VIRTIO_HOST_MODE to VIRTIO_HOST_KERNEL or VIRTIO_HOST_U=
SER"
#endif

#if VIRTIO_HOST_MODE =3D=3D VIRTIO_HOST_KERNEL
#define __virtio_host_user
#define __virtio_host_put_user(x, ptr) ({*(ptr) =3D (__typeof__(*(ptr)))(x)=
; 0;})
#else
#define __virtio_host_user __user
#define __virtio_host_put_user(x, ptr) __put_user(x, ptr)
#endif

static inline
int vhost_add_used(struct virtio_host_vq *vq, unsigned int head, int len)
{
        struct vring_used_elem __virtio_host_user *used;

        /* The virtqueue contains a ring of used buffers.  Get a pointer to=
 the
         * next entry in that used ring. */
        used =3D &vq->used->ring[vq->last_used_idx % vq->num];
        if (__virtio_host_put_user(head, &used->id)) {


...


#endif

Users will have to

#define VIRTIO_HOST_MODE VIRTIO_HOST_USER
#include "linux/virtio_host.h"

or

#define VIRTIO_HOST_MODE VIRTIO_HOST_KERNEL
#include "linux/virtio_host.h"

-- =

MST
