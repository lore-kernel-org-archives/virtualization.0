From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Mon, 10 Sep 2012 07:51:42 +0200
Message-ID: <504D7FEE.20008@redhat.com>
References: <50486BB2.7070108@redhat.com> <20120906094442.GA22816@redhat.com>
	<50487382.8030303@redhat.com> <20120906105301.GC32325@redhat.com>
	<5048935A.8090308@redhat.com> <87wr06hg0l.fsf@rustcorp.com.au>
	<20120907054202.GA3452@redhat.com> <87vcfqfia1.fsf@rustcorp.com.au>
	<20120907104306.GA17211@redhat.com>
	<87sjatf6iv.fsf@rustcorp.com.au>
	<20120908223724.GB20588@redhat.com>
	<87fw6qfya7.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fw6qfya7.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, yvugenfi@redhat.com, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 10/09/2012 03:43, Rusty Russell ha scritto:
>> Now that vfio is upstream and work on qemu integration
>> is being worked on, we might finally see people using this bit
>> to allow memory overcommit with device assignment.
> That was left-field.... so you're saying some guest might pull a page
> from the balloon and DMA to it, and the vfio device needs to know in
> advance that it's going to do it?

Not the vfio device, but the page needs to be pinned with mlock so the
effect is the same.

> But what will we do if the guest doesn't ack the bit?

Just pin the whole memory.

Paolo

> ie. I don't think it can really be optional.
