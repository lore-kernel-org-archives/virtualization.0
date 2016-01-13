From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Wed, 13 Jan 2016 10:38:10 -0800
Message-ID: <CA+55aFwUHWb+y2gtKp55mwqocTjYv2xWzosvtO4K97VzPmfUSA@mail.gmail.com>
References: <CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
	<56956276.1090705@kernel.org>
	<CA+55aFxhoGB9dBArw5iy0C0RhJEVRLLPR42w--KLSn5WM2sVRQ@mail.gmail.com>
	<CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
	<20160113001824-mutt-send-email-mst@redhat.com>
	<56958467.6010808@zytor.com>
	<CA+55aFz44oYK5GD3=-Y2E7bNwmJ0Ko5GaZ+iMQDamLALiw7RqQ@mail.gmail.com>
	<20160113161704.GA13146@pd.tnic>
	<20160113182505-mutt-send-email-mst@redhat.com>
	<20160113163331.GG12897@pd.tnic>
	<20160113184003-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160113184003-mutt-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 13, 2016 at 8:42 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Oh, I think this means we need a "cc" clobber.

It's probably a good idea to add one.

Historically, gcc doesn't need one on x86, and always considers flags
clobbered. We are probably missing the cc clobber in a *lot* of places
for this reason.

But even if not necessary, it's probably a good thing to add for
documentation, and in case gcc semantcs ever change.

                  Linus
