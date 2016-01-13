From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Wed, 13 Jan 2016 17:53:20 +0100
Message-ID: <20160113165319.GJ12897@pd.tnic>
References: <56956276.1090705@kernel.org>
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
Content-Disposition: inline
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 13, 2016 at 06:42:48PM +0200, Michael S. Tsirkin wrote:
> Oh, I think this means we need a "cc" clobber.

Btw, does your microbenchmark do it too?

Because, the "cc" clobber should cause additional handling of flags,
depending on the context. It won't matter if the context doesn't need
rFLAGS handling in the benchmark but if we start using LOCK; ADD in the
kernel, I can imagine some places where mb() is used and rFLAGS are
live, causing gcc to either reorder code or stash them away...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
