From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Fri, 7 Sep 2012 08:42:02 +0300
Message-ID: <20120907054202.GA3452@redhat.com>
References: <1346917610-14568-1-git-send-email-pbonzini@redhat.com>
	<20120906084736.GF17656@redhat.com> <50486BB2.7070108@redhat.com>
	<20120906094442.GA22816@redhat.com> <50487382.8030303@redhat.com>
	<20120906105301.GC32325@redhat.com> <5048935A.8090308@redhat.com>
	<87wr06hg0l.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wr06hg0l.fsf@rustcorp.com.au>
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
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, yvugenfi@redhat.com, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2012 at 09:15:46AM +0930, Rusty Russell wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> > Instead, VIRTIO_NET_F_HOST_MUST_SEND_GARP would be a "negative" feature:
> > if set, the host _may not_ rely on the guest to send a gARP.  Similarly
> > if VIRTIO_BALLOON_F_MUST_TELL_HOST is set, the guest _may not_ use
> > ballooned pages directly.
> >
> > There are _no_ other negative features besides
> > VIRTIO_BALLOON_F_MUST_TELL_HOST in the spec, and for a good
> > reason---because they're broken.
> >
> > (Hmm, actually we have one, VIRTIO_BLK_F_RO.  It is also a bit broken,
> > but it is not so important because it depends on user input more than
> > hypervisor version).
> 
> Yes, this is the key observation, and an important lesson for the
> future.  Thanks!
> Note that these two negative features were in the original spec, where
> it's assumed that every device supports them.  That's not explicitly
> documented, however.

I'm curious what would we do for the future? I tried to imagine that _RO
was not in the original spec, so virtio-blk expects a r/w device.
Now we can not add _RW - old hypervisors do not set it, and old
drivers do not ack it.
What would a new flag with equivalent functionality be?

> I like killing the totally unused feature.
> 
> Cheers,
> Rusty.

I tried verifying that it is unused. And found this:
Linux drivers currently try to ack this feature if it is there,
so do BSD drivers. Both from v1. And they tell host before leak.
So that is fine.

But looking at windows drivers:
https://github.com/YanVugenfirer/kvm-guest-drivers-windows/blob/master/Balloon/sys/balloon.c
they do *not* ack this bit, and BalloonLeak calls TellHost at the last
line.

So it looks like a bug: we should teach driver to tell host first on leak?
Yan, Vadim, can you comment please?

Also if true, looks like this bit will be useful to detect a fixed driver on
the hypervisor side - to avoid unmapping such pages? Rusty what do you
think?

-- 
MST
