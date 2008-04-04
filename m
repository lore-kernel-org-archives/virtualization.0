From: Balaji Rao <balajirrao@gmail.com>
Subject: kernel BUG at drivers/virtio/virtio_ring.c:218!
Date: Fri, 4 Apr 2008 13:46:21 +0530
Message-ID: <200804041346.21618.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

I hit a bug in virtio_ring.c:218 when I was stressing virtio_net using kvm with -smp 4.

static void vring_disable_cb(struct virtqueue *_vq)
{
        struct vring_virtqueue *vq = to_vvq(_vq);

        START_USE(vq);
-->        BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
        vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
        END_USE(vq);
}

Going through the source code, I felt that this BUG_ON is not required as any CPU could race and call disable_cb when one 
cpu still believes that its enabled. To validate my understanding, I commented out the BUG_ON and everything worked 
perfectly well.

I also get a lot of "Unlikely: restart svq race" on my console. Under high load conditions, a race could occur very often 
and I'm not sure if that signals a buggy situation. We could printk_ratelimit if at all we need to retain it.

If you agree, I'll send a patch to this.

-- 
thanks and regards,
Balaji Rao
Dept. of Mechanical Engineering,
National Institute of Technology Karnataka, India
