From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 10:57:38 -0700
Message-ID: <20070424105738.e0ce36a9.akpm@linux-foundation.org>
References: <20070327214919.800272641@goop.org>
	<20070327215827.871954359@goop.org>
	<20070423234910.50149faf.akpm@linux-foundation.org>
	<462E43A7.1050001@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462E43A7.1050001@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Bhargava <prarit@redhat.com>, Thomas@smtp2.linux-foundation.org, Lindsley <ricklind@us.ibm.com>, Prarit@smtp2.linux-foundation.org, john stultz <johnstul@us.ibm.com>, Zachary@smtp2.linux-foundation.org, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>, virtualization@lists.osdl.org, Chris Lalancette <clalance@redhat.com>, Paul Mackerras <paulus@samba.org>, Rick@smtp2.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 24 Apr 2007 10:51:35 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > It seems fairly sensitive to .config settings.  See
> > http://userweb.kernel.org/~akpm/config-sony.txt
> >   
> 
> I haven't tried your config yet, but I haven't managed to reproduce it
> by playing with the usual suspects in my config (SMP, PREEMPT).  Any
> idea about which config changes make the difference?

I said that because the damn thing went away when I was hunting it down
because I lost the config and was unable to remember the right combination
of debug settings.  Fortunately it later came back so I took care to
preserve the config.

> Hm, is it caused by using sched_clock() to generate the printk
> timestamps while generating the lock test output?

Conceivably.  What does that locking API test do?

I was using printk timestamps and netconsole at the time.
