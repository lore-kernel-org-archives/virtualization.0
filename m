From: David Rientjes via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: Balloon pressuring page cache
Date: Sat, 1 Feb 2020 16:21:25 -0800 (PST)
Message-ID: <alpine.DEB.2.21.2002011618340.227600@chino.kir.corp.google.com>
References: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
 <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
Reply-To: David Rientjes <rientjes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tyler Sanderson <tysand@google.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 29 Jan 2020, Tyler Sanderson wrote:

> > > A primary advantage of virtio balloon over other memory reclaim
> > > mechanisms is that it can pressure the guest's page cache into shrinking.
> > >
> > > However, since the balloon driver changed to using the shrinker API
> > > <
> > https://github.com/torvalds/linux/commit/71994620bb25a8b109388fefa9e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9
> > > this
> > > use case has become a bit more tricky. I'm wondering what the intended
> > > device implementation is.
> > >
> > > When inflating the balloon against page cache (i.e. no free memory
> > > remains) vmscan.c will both shrink page cache, but also invoke the
> > > shrinkers -- including the balloon's shrinker. So the balloon driver
> > > allocates memory which requires reclaim, vmscan gets this memory by
> > > shrinking the balloon, and then the driver adds the memory back to the
> > > balloon. Basically a busy no-op.
> > >
> > > If file IO is ongoing during this balloon inflation then the page cache
> > > could be growing which further puts "back pressure" on the balloon
> > > trying to inflate. In testing I've seen periods of > 45 seconds where
> > > balloon inflation makes no net forward progress.
> > >
> > > This wasn't a problem before the change to the shrinker API since forced
> > > balloon deflation only occurred via the OOM notifier callback which was
> > > invoked only after the page cache had depleted.
> > >
> > > Is this new busy behavior working as intended?
> >
> > Please note that the shrinker will only be registered in case we have
> > VIRTIO_BALLOON_F_DEFLATE_ON_OOM - (which is AFAIK very rare) - to
> > implement automatic balloon deflation when the guest is under memory
> > pressure.
> 
> 
> > Are you actually experiencing issues with that or did you just stumble
> > over the code?
> >
> 
> We have a use case that is encountering this (and that registers
> DEFLATE_ON_OOM). We can work around this, but it does seem inefficient.
> I understand there were good reasons for moving away from the OOM notifier
> callback, but I'm wondering if the balloon driver could specify a "nice"
> level to the shrinker API that would cause it to be reclaimed from only as
> a last resort?
> 

Shrinkers aren't priority based so I don't think there's a non-hacky way 
to avoid reclaiming from them, it's not the correct way to implement a
reclaim callback unless the objects can be fairly freed compared to other 
shrinkers.  The oom notifier callbacks are the canonical way for global 
reclaim to free memory only as a last resort.
