From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Fri, 07 Sep 2012 13:20:57 +0200
Message-ID: <5049D899.60705@redhat.com>
References: <20120906084736.GF17656@redhat.com> <50486BB2.7070108@redhat.com>
	<20120906094442.GA22816@redhat.com> <50487382.8030303@redhat.com>
	<20120906105301.GC32325@redhat.com>
	<5048935A.8090308@redhat.com> <87wr06hg0l.fsf@rustcorp.com.au>
	<20120907054202.GA3452@redhat.com>
	<87vcfqfia1.fsf@rustcorp.com.au> <5049BE0E.6040202@redhat.com>
	<20120907105335.GB17211@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120907105335.GB17211@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, yvugenfi@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 07/09/2012 12:53, Michael S. Tsirkin ha scritto:
> Let us start with what is broken currently. Looking at
> it very closely, I think the answer is nothing.
> Even migration in qemu is not broken as you claimed initially.

Correct, migration would be broken as soon as QEMU starts using
MUST_TELL_HOST.  I'm trying to think ahead, since we have many ideas
floating around on the implementation of ballooning.

If you implement the mlock/munlock trick, you must start using
MUST_TELL_HOST in QEMU to advertise it to guests, and migration breaks.

> Next, consider the interface proposed here. You defacto declare
> all existing drivers buggy.

No, only Windows (and it is buggy, it calls tell_host last).  Linux and
BSD drivers do negotiate MUST_TELL_HOST, and are not buggy.

> This is a wrong thing to do.
> You also use two feature bits for a single simple thing,
> this is inelegant.

True, but the choice is:

1) add a once-only hack to QEMU that fixes migration of
VIRTIO_BALLOON_F_MUST_TELL_HOST;

2) always advertise VIRTIO_BALLOON_F_MUST_TELL_HOST.  If you do this,
guests cannot use anymore silent deflate, which is a regression.

3) use two bits.  One tells the device that the driver supports chatty
deflate; one tells the driver that the device supports silent deflate.

So in the end you do use two feature bits for two different things.
Plus, both feature bits are "positive" and I'm happy.

> Last, let us consider how existing feature can be used
> in the hypervisor. If driver did not ack
> MUST_TELL_HOST, it is *not* buggy but it means we can not
> do munlock. This applies to current windows drivers.
> If driver *did* ack MUST_TELL_HOST, we can munlock
> and mlock back on leak.
> Seems useful, driver support is already there,
> so removing the MUST_TELL_HOST bit seems like a bad idea.

Indeed, repurposing MUST_TELL_HOST to WILL_TELL_HOST is better than
killing it.

Paolo
