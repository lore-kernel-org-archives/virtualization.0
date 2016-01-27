From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 5/5] x86: drop mfence in favor of lock+addl
Date: Wed, 27 Jan 2016 09:37:45 -0800
Message-ID: <CA+55aFzcDiKjz8yzRf9ET7Qc-qeNFP5bO0qW7o2cB9G9=yXHng__48707.2028955028$1453916291$gmane$org@mail.gmail.com>
References: <1453904765-11073-1-git-send-email-mst@redhat.com>
	<1453904765-11073-6-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453904765-11073-6-git-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrey Konovalov <andreyknvl@google.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 27, 2016 at 7:10 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> -#define __smp_mb()     mb()
> +#define __smp_mb()     asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")

So this doesn't look right for x86-64. Using %esp rather than %rsp.
How did that even work for you?

                Linus
