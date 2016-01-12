From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 10:04:13 -0800
Message-ID: <CA+55aFxarbsXdebbcrB=590qtagh178hhxr5ST+qr7XnjZkgpg@mail.gmail.com>
References: <1445975631-17047-1-git-send-email-dave@stgolabs.net>
	<1445975631-17047-4-git-send-email-dave@stgolabs.net>
	<CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
	<20160112193027-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160112193027-mutt-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 9:45 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> By the way, the comment in barrier.h says:
>
> /*
>  * Some non-Intel clones support out of order store. wmb() ceases to be
>  * a nop for these.
>  */
>
> and while the 1st sentence may well be true, if you have
> an SMP system with out of order stores, making wmb
> not a nop will not help.
>
> Additionally as you point out, wmb is not a nop even
> for regular intel CPUs because of these weird use-cases.
>
> Drop this comment?

We should drop it, yes. We dropped support for CONFIG_X86_OOSTORE
almost two years ago. See commit 09df7c4c8097 ("x86: Remove
CONFIG_X86_OOSTORE") and it was questionable for a long time even
before that (perhaps ever).

So the comment is stale.

We *do* still use the non-nop rmb/wmb for IO barriers, but even that
is generally questionable. See our "copy_user_64.S" for an actual use
of "movnt" followed by sfence. There's a couple of other cases too. So
that's all correct, but the point is that when we use "movnt" we don't
actually use "wmb()", we are doing assembly, and the assembly should
just use sfence directly.

So it's actually very questionable to ever make even the IO
wmb()/rmb() functions use lfence/sfence. They should never really need
it.

But at the same time, I _really_ don't think we care enough. I'd
rather leave those non-smp barrier cases alone as historial unless
somebody can point to a case where they care about the performance.

We also do have the whole PPRO_FENCE thing, which we can hopefully get
rid of at some point too.

                 Linus
