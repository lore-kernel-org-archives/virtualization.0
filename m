From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 0/4] x86: faster mb()+documentation tweaks
Date: Thu, 14 Jan 2016 12:39:34 +0100
Message-ID: <20160114113934.GC19941@pd.tnic>
References: <1452715911-12067-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452715911-12067-1-git-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 13, 2016 at 10:12:22PM +0200, Michael S. Tsirkin wrote:
> mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
> 2 to 3 times slower than lock; addl that we use on older CPUs.
> 
> So let's use the locked variant everywhere.
> 
> While I was at it, I found some inconsistencies in comments in
> arch/x86/include/asm/barrier.h
> 
> The documentation fixes are included first - I verified that
> they do not change the generated code at all. They should be
> safe to apply directly.
> 
> The last patch changes mb() to lock addl. I was unable to
> measure a speed difference on a macro benchmark,
> but I noted that even doing
> 	#define mb() barrier()
> seems to make no difference for most benchmarks
> (it causes hangs sometimes, of course).
> 
> HPA asked that the last patch is deferred until we hear back from
> intel, which makes sense of course. So it needs HPA's ack.
> 
> I hope I'm not splitting this up too much - the reason is I wanted to isolate
> the code changes (that people might want to test for performance)
> from comment changes approved by Linus, from (so far unreviewed) changes
> I came up with myself.
> 
> Changes from v2:
> 	add patch adding cc clobber for addl
> 	tweak commit log for patch 2
> 	use addl at SP-4 (as opposed to SP) to reduce data dependencies
> 
> Michael S. Tsirkin (4):
>   x86: add cc clobber for addl
>   x86: drop a comment left over from X86_OOSTORE
>   x86: tweak the comment about use of wmb for IO

First three look ok to me regardless of what happens with 4. So applied.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
