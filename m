From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 2/3] x86: drop a comment left over from X86_OOSTORE
Date: Tue, 12 Jan 2016 22:25:28 +0000
Message-ID: <20160112222528.4a1d9b64__9782.74372541836$1452640344$gmane$org@lxorguk.ukuu.org.uk>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
	<1452635935-5439-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1452635935-5439-3-git-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrey Konovalov <andreyknvl@google.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 13 Jan 2016 00:10:19 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> The comment about wmb being non-nop is a left over from before commit
> 09df7c4c8097 ("x86: Remove CONFIG_X86_OOSTORE").
> 
> It makes no sense now: if you have an SMP system with out of order
> stores, making wmb not a nop will not help.

There were never any IDT Winchip systems with SMP support, and they were
the one system that could enable OOSTORE (and it was worth up to 30% on
some workloads). The fencing it had was just for DMA devices.

Alan
