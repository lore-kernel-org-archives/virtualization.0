From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 12:30:46 -0800
Message-ID: <56956276.1090705@kernel.org>
References: <1445975631-17047-1-git-send-email-dave@stgolabs.net>
	<1445975631-17047-4-git-send-email-dave@stgolabs.net>
	<CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/12/2016 09:20 AM, Linus Torvalds wrote:
> On Tue, Jan 12, 2016 at 5:57 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> #ifdef xchgrz
>> /* same as xchg but poking at gcc red zone */
>> #define barrier() do { int ret; asm volatile ("xchgl %0, -4(%%" SP ");": "=r"(ret) :: "memory", "cc"); } while (0)
>> #endif
>
> That's not safe in general. gcc might be using its redzone, so doing
> xchg into it is unsafe.
>
> But..
>
>> Is this a good way to test it?
>
> .. it's fine for some basic testing. It doesn't show any subtle
> interactions (ie some operations may have different dynamic behavior
> when the write buffers are busy etc), but as a baseline for "how fast
> can things go" the stupid raw loop is fine. And while the xchg into
> the redzoen wouldn't be acceptable as a real implementation, for
> timing testing it's likely fine (ie you aren't hitting the problem it
> can cause).

I recall reading somewhere that lock addl $0, 32(%rsp) or so (maybe even 
64) was better because it avoided stomping on very-likely-to-be-hot 
write buffers.

--Andy
