From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH] virtio: change config to guest endian.
Date: Wed, 23 Apr 2008 00:40:51 +1000
Message-ID: <200804230040.52116.rusty__45413.6068154641$1208875500$gmane$org@rustcorp.com.au>
References: <200804221357.34571.rusty@rustcorp.com.au>
	<200804220944.08568.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804220944.08568.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 April 2008 17:44:08 Christian Borntraeger wrote:
> Am Dienstag, 22. April 2008 schrieb Rusty Russell:
> > [Christian, Hollis, how much is this ABI breakage going to hurt you?]
>
> It is ok for s390 at the moment. We are still working on making userspace
> ready and I plan to change the guest<->host for s390 anyway. I try to make
> these changes for drivers/s390/kvm/kvm_virtio.c before 2.6.26. The main
> reason is, that we are currently limited to around 80 devices. I am not
> sure, if I should change the allocation of the virtqueues and descriptors
> to guest memory as well.

Large rings require contiguous memory, which makes guest allocation 
problematic.  512 elems at 4k pages == 5 pages.

> Back to your patch:
> I have still some ideas about virtio between little endian and big endian
> systems, but it requires more and different marshalling anyway - even on
> driver level. No idea yet how to solve that properly.

So far we've pushed such considerations onto the host.  This does mean that 
you can't virtio connect two guests directly without understanding the 
contents of the buffers so you can endian correct (eg. direct inter-guest 
networking).  inter-guest virtio is currently a party trick anyway, so I'm 
not sure it's a real issue.

> > +	vb->vdev->config->get(vb->vdev,
> > +			      offsetof(struct virtio_balloon_config, num_pages),
> > +			      &v);
>
> this is missing a sizeof(v), no?

Ah... sure enough, I fixed that in a followon patch.  Well-spotted, thanks!

Cheers,
Rusty.
