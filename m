From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 15:24:05 -0800
Message-ID: <CA+55aFz44oYK5GD3=-Y2E7bNwmJ0Ko5GaZ+iMQDamLALiw7RqQ__33028.8124540404$1452641072$gmane$org@mail.gmail.com>
References: <1445975631-17047-4-git-send-email-dave@stgolabs.net>
	<CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
	<56956276.1090705@kernel.org>
	<CA+55aFxhoGB9dBArw5iy0C0RhJEVRLLPR42w--KLSn5WM2sVRQ@mail.gmail.com>
	<CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
	<20160113001824-mutt-send-email-mst@redhat.com>
	<56958467.6010808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56958467.6010808@zytor.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 2:55 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Be careful with this: if it only shows up in a microbenchmark, we may
> introduce a hard-to-debug regression for no real benefit.

So I can pretty much guarantee that it shouldn't regress from a
correctness angle, since we rely *heavily* on locked instructions
being barriers, in locking and in various other situations.

Indeed, much more so than we ever rely on "smp_mb()". The places that
rely on smp_mb() are pretty few in the end.

So I think the only issue is whether sometimes "mfence" might be
faster. So far, I've never actually heard of that being the case. The
fence instructions have always sucked when I've seen them.

But talking to the hw people about this is certainly a good idea regardless.

                 Linus
