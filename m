From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 12:59:58 -0800
Message-ID: <CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
References: <1445975631-17047-1-git-send-email-dave@stgolabs.net>
	<1445975631-17047-4-git-send-email-dave@stgolabs.net>
	<CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
	<56956276.1090705@kernel.org>
	<CA+55aFxhoGB9dBArw5iy0C0RhJEVRLLPR42w--KLSn5WM2sVRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFxhoGB9dBArw5iy0C0RhJEVRLLPR42w--KLSn5WM2sVRQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 12:54 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jan 12, 2016 at 12:30 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> I recall reading somewhere that lock addl $0, 32(%rsp) or so (maybe even 64)
>> was better because it avoided stomping on very-likely-to-be-hot write
>> buffers.
>
> I suspect it could go either way. You want a small constant (for the
> isntruction size), but any small constant is likely to be within the
> current stack frame anyway. I don't think 0(%rsp) is particularly
> likely to have a spill on it right then and there, but who knows..
>
> And 64(%rsp) is  possibly going to be cold in the L1 cache, especially
> if it's just after a deep function call. Which it might be. So it
> might work the other way.
>
> So my guess would be that you wouldn't be able to measure the
> difference. It might be there, but probably too small to really see in
> any noise.
>
> But numbers talk, bullshit walks. It would be interesting to be proven wrong.

Here's an article with numbers:

http://shipilev.net/blog/2014/on-the-fence-with-dependencies/

I think they're suggesting using a negative offset, which is safe as
long as it doesn't page fault, even though we have the redzone
disabled.

--Andy
