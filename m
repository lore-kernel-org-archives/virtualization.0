From: Balaji Rao <balajirrao@gmail.com>
Subject: Re: kernel BUG at drivers/virtio/virtio_ring.c:218!
Date: Sat, 5 Apr 2008 19:23:39 +0530
Message-ID: <200804051923.39933.balajirrao__4135.74161143533$1207404217$gmane$org@gmail.com>
References: <200804041346.21618.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804041346.21618.balajirrao@gmail.com>
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
Cc: kvm-devel@lists.sourceforge.net, borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 04 April 2008 01:46:21 pm Balaji Rao wrote:
> Hi Rusty,
> 
> I hit a bug in virtio_ring.c:218 when I was stressing virtio_net using kvm with -smp 4.
> 
> static void vring_disable_cb(struct virtqueue *_vq)
> {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
>         START_USE(vq);
> -->        BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
>         vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
>         END_USE(vq);
> }
> 
> Going through the source code, I felt that this BUG_ON is not required as any CPU could race and call disable_cb when one 
> cpu still believes that its enabled. To validate my understanding, I commented out the BUG_ON and everything worked 
> perfectly well.
> 
> I also get a lot of "Unlikely: restart svq race" on my console. Under high load conditions, a race could occur very often 
> and I'm not sure if that signals a buggy situation. We could printk_ratelimit if at all we need to retain it.
> 
> If you agree, I'll send a patch to this.
> 
Christian Borntraeger CCed.

BTW, this is with respect to kvm.git, not a version prior to 

commit 4265f161b6bb7b31163671329b1142b9023bf4e3
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Fri Mar 14 14:17:05 2008 +0100

    virtio: fix race in enable_cb


The above commit does not fix the problem.I see this oops even today. There is a race happening between calls to enable_cb 
and disable_cb.
-- 
regards,
Balaji Rao
Dept. of Mechanical Engineering,
National Institute of Technology Karnataka, India
