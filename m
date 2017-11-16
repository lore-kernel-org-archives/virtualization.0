From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter
	real idle path
Date: Thu, 16 Nov 2017 10:47:28 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711161039050.2191__44964.0781073414$1510825666$gmane$org@nanos>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
	<20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.20.1711152240010.2146@nanos>
	<20171116084555.it2hqajxxd6ld5tq@hirez.programming.kicks-ass.net>
	<13a3a5c5-ec14-131f-fe6a-01700783de81@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <13a3a5c5-ec14-131f-fe6a-01700783de81@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu0@gmail.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Quan Xu <quan.xu03@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 16 Nov 2017, Quan Xu wrote:
> On 2017-11-16 16:45, Peter Zijlstra wrote:
> 
> I really have considered this factor, and try my best not to interfere with
> scheduler/idle code.
>
> if irq_timings code is ready, I can use it directly. I think irq_timings
> is not an easy task, I'd like to help as much as I can.

It's not a question whether irq_timings code is ready or not.

The infrastructure is there. I said that before and I'm happy to repeat:

 All parties who need this kind of prediction should:

     1) Talk to each other

     2) Work together to make it usable for _ALL_ use cases

 AFAICT, that never happened. Otherwise there would be either progress on
 that or at least a reasonable explanation WHY it cannot be done.

Peter and myself made it entirely clear several times in the past that this
must be solved at the generic level without any magic hackery in random
places. But the only thing we've seen so far is the magic hackery coming
around in a different flavour some time after we rejected the last one.

We can play that game forever. The outcome is extremly predictable.

Thanks,

	tglx
