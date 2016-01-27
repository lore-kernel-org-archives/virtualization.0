From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Date: Wed, 27 Jan 2016 15:14:09 +0100
Message-ID: <20160127141409.GQ6357@twins.programming.kicks-ass.net>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
	<56957D54.5000602@zytor.com>
	<20160126101921-mutt-send-email-mst@redhat.com>
	<56A7E722.7030701@zytor.com>
	<20160127120222-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160127120222-mutt-send-email-mst@redhat.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 27, 2016 at 04:07:56PM +0200, Michael S. Tsirkin wrote:
> mwait_idle is the only one that calls smp_mb and not mb()
> I couldn't figure out why - original patches did mb()
> there.

That probably wants changing. That said, running UP kernels on affected
hardware is 'unlikely' :-)
