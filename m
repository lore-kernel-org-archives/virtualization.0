From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Wed, 13 Jan 2016 17:17:04 +0100
Message-ID: <20160113161704.GA13146@pd.tnic>
References: <20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
	<56956276.1090705@kernel.org>
	<CA+55aFxhoGB9dBArw5iy0C0RhJEVRLLPR42w--KLSn5WM2sVRQ@mail.gmail.com>
	<CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
	<20160113001824-mutt-send-email-mst@redhat.com>
	<56958467.6010808@zytor.com>
	<CA+55aFz44oYK5GD3=-Y2E7bNwmJ0Ko5GaZ+iMQDamLALiw7RqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz44oYK5GD3=-Y2E7bNwmJ0Ko5GaZ+iMQDamLALiw7RqQ@mail.gmail.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 03:24:05PM -0800, Linus Torvalds wrote:
> But talking to the hw people about this is certainly a good idea regardless.

I'm not seeing it in this thread but I might've missed it too. Anyway,
I'm being reminded that the ADD will change rFLAGS while MFENCE doesn't
touch them.

Do we care?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
