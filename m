From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Date: Tue, 12 Jan 2016 14:25:24 -0800
Message-ID: <56957D54.5000602@zytor.com>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1452635935-5439-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/12/16 14:10, Michael S. Tsirkin wrote:
> mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
> 2 to 3 times slower than lock; addl $0,(%%e/rsp) that we use on older CPUs.
> 
> So let's use the locked variant everywhere - helps keep the code simple as
> well.
> 
> While I was at it, I found some inconsistencies in comments in
> arch/x86/include/asm/barrier.h
> 
> I hope I'm not splitting this up too much - the reason is I wanted to isolate
> the code changes (that people might want to test for performance) from comment
> changes approved by Linus, from (so far unreviewed) comment change I came up
> with myself.
> 
> Lightly tested on my system.
> 
> Michael S. Tsirkin (3):
>   x86: drop mfence in favor of lock+addl
>   x86: drop a comment left over from X86_OOSTORE
>   x86: tweak the comment about use of wmb for IO
> 

I would like to get feedback from the hardware team about the
implications of this change, first.

	-hpa
