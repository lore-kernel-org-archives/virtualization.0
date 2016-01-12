From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 13:37:38 -0800
Message-ID: <CA+55aFyuR1YCZjC9++E4kpvRxgoM4sqzhNaS27EZPFh9CuKjYg@mail.gmail.com>
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
	<CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 12:59 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> Here's an article with numbers:
>
> http://shipilev.net/blog/2014/on-the-fence-with-dependencies/

Well, that's with the busy loop and one set of code generation. It
doesn't show the "oops, deeper stack isn't even in the cache any more
due to call chains" issue.

But yes:

> I think they're suggesting using a negative offset, which is safe as
> long as it doesn't page fault, even though we have the redzone
> disabled.

I think a negative offset might work very well. Partly exactly
*because* we have the redzone disabled: we know that inside the
kernel, we'll never have any live stack frame accesses under the stack
pointer, so "-4(%rsp)" sounds good to me. There should never be any
pending writes in the write buffer, because even if it *was* live, it
would have been read off first.

Yeah, it potentially does extend the stack cache footprint by another
4 bytes, but that sounds very benign.

So perhaps it might be worth trying to switch the "mfence" to "lock ;
addl $0,-4(%rsp)" in the kernel for x86-64, and remove the alternate
for x86-32.

I'd still want to see somebody try to benchmark it. I doubt it's
noticeable, but making changes because you think it might save a few
cycles without then even measuring it is just wrong.

                 Linus
