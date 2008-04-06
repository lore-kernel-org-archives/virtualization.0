From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: kernel BUG at drivers/virtio/virtio_ring.c:218!
Date: Sun, 6 Apr 2008 17:26:33 +1000
Message-ID: <200804061726.33918.rusty__5225.67832745171$1207466930$gmane$org@rustcorp.com.au>
References: <200804041346.21618.balajirrao@gmail.com>
	<200804051923.39933.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804051923.39933.balajirrao@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Balaji Rao <balajirrao@gmail.com>
Cc: kvm-devel@lists.sourceforge.net, borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 06 April 2008 00:53:39 Balaji Rao wrote:
> On Friday 04 April 2008 01:46:21 pm Balaji Rao wrote:
> > Hi Rusty,
> >
> > I hit a bug in virtio_ring.c:218 when I was stressing virtio_net using
> > kvm with -smp 4.
> >
> > static void vring_disable_cb(struct virtqueue *_vq)
> > {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >
> >         START_USE(vq);
> > -->        BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
> >         vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
> >         END_USE(vq);
> > }
> >
> > Going through the source code, I felt that this BUG_ON is not required as
> > any CPU could race and call disable_cb when one cpu still believes that
> > its enabled. To validate my understanding, I commented out the BUG_ON and
> > everything worked perfectly well.
> >
> > I also get a lot of "Unlikely: restart svq race" on my console. Under
> > high load conditions, a race could occur very often and I'm not sure if
> > that signals a buggy situation. We could printk_ratelimit if at all we
> > need to retain it.
> >
> > If you agree, I'll send a patch to this.
>
> Christian Borntraeger CCed.

Hi Balaji,

Interesting case.... can you put a '#define DEBUG' at the top of 
drivers/virtio/virtio_ring.c and re-run?

The reason we don't simply remove that check is that interrupt bugs are nasty 
to track down, usually leading to performance problems rather than outright 
breakage.

Thanks!
Rusty.
