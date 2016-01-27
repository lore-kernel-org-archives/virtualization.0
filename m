From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 5/5] x86: drop mfence in favor of lock+addl
Date: Wed, 27 Jan 2016 19:56:37 +0200
Message-ID: <20160127195314-mutt-send-email-mst@redhat.com>
References: <1453904765-11073-1-git-send-email-mst@redhat.com>
	<1453904765-11073-6-git-send-email-mst@redhat.com>
	<CA+55aFzcDiKjz8yzRf9ET7Qc-qeNFP5bO0qW7o2cB9G9=yXHng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzcDiKjz8yzRf9ET7Qc-qeNFP5bO0qW7o2cB9G9=yXHng@mail.gmail.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrey Konovalov <andreyknvl@google.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 27, 2016 at 09:37:45AM -0800, Linus Torvalds wrote:
> On Wed, Jan 27, 2016 at 7:10 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > -#define __smp_mb()     mb()
> > +#define __smp_mb()     asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
> 
> So this doesn't look right for x86-64. Using %esp rather than %rsp.
> How did that even work for you?
> 
>                 Linus

Oops, didn't test this version properly.
Pls disregard, I'll repost after some proper testing.

-- 
MST
