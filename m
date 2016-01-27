From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Date: Wed, 27 Jan 2016 16:07:56 +0200
Message-ID: <20160127120222-mutt-send-email-mst@redhat.com>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
	<56957D54.5000602@zytor.com>
	<20160126101921-mutt-send-email-mst@redhat.com>
	<56A7E722.7030701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56A7E722.7030701@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 26, 2016 at 01:37:38PM -0800, H. Peter Anvin wrote:
> On 01/26/16 00:20, Michael S. Tsirkin wrote:
> > On Tue, Jan 12, 2016 at 02:25:24PM -0800, H. Peter Anvin wrote:
> > 
> > Hi hpa,
> > Any luck getting some feedback on this one?
> > 
> 
> Yes.  What we know so far is that *most* cases it will work, but there
> are apparently a few corner cases where MFENCE or a full-blown
> serializing instruction is necessary.  We are trying to characterize
> those corner cases and see if any of them affect the kernel.

It would be very interesting to know your findings.

Going over the manual I found one such case, and then going over the
kernel code I found some questionable uses of barriers - it would be
interesting to find out what some other cases are.

So I think it's probably useful to find out the full answer, anyway.

Awaiting the answers with interest.

> Even if they are, we can probably make those barriers explicitly
> different, but we don't want to go ahead with the change until we know
> where we need to care.
> 
> 	-hpa

Thanks!

Now that you definitely said there are corner cases, I poked some more
at the manual and found one:
	CLFLUSH is only ordered by the MFENCE instruction. It is not guaranteed
	to be ordered by any other fencing or serializing instructions or by
	another CLFLUSH instruction. For example, software can use an MFENCE
	instruction to ensure that previous stores are included in the
	write-back.

There are instances of this in mwait_play_dead,
clflush_cache_range, mwait_idle_with_hints, mwait_idle ..

A comment near pcommit_sfence includes an example
flush_and_commit_buffer code which is interesting -
it assumes sfence flushes clflush.

So it appears that pcommit_sfence in that file is wrong then?
At least on processors where it falls back on clflush.

mwait_idle is the only one that calls smp_mb and not mb()
I couldn't figure out why - original patches did mb()
there.


Outside core kernel - drm_cache_flush_clflush, drm_clflush_sg,
drm_clflush_virt_range.

Then there's gru_start_instruction in drivers/misc/sgi-gru/.

But otherwise drivers/misc/sgi-gru/ calls clflush in gru_flush_cache
without calling mb() - this could be a bug.


Looking at all users, it seems that only mwait_idle calls  smp_mb,
around clflush, others call mb().

So at least as a first step, maybe it makes sense to scope this down
somewhat by changing mwait_idle to call mb() and then optimizing
__smp_mb instead of mb?

I'll post v3 that does this.


-- 
MST
