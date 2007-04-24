From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 22:59:18 +0200
Message-ID: <20070424205918.GA25383@elte.hu>
References: <20070327214919.800272641@goop.org>
	<20070327215827.871954359@goop.org>
	<20070423234910.50149faf.akpm@linux-foundation.org>
	<462E43A7.1050001@goop.org>
	<20070424105738.e0ce36a9.akpm@linux-foundation.org>
	<462E4969.6070802@goop.org>
	<20070424113222.ed2e1314.akpm@linux-foundation.org>
	<462E61F1.7060403@goop.org> <462E6778.7070305@goop.org>
	<1177447948.12796.66.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177447948.12796.66.camel@imap.mvista.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, john stultz <johnstul@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>, virtualization@lists.osdl.org, Chris Lalancette <clalance@redhat.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Tue, 2007-04-24 at 13:24 -0700, Jeremy Fitzhardinge wrote:
> 
> > And sched_clock's use of local_irq_save/restore appears to be absolutely
> > correct, so I think it must be triggering a bug in either the self-tests
> > or lockdep itself.
> 
> Why does sched_clock need to disable interrupts?

i concur. To me it appears not "absolutely correct" that someone 
apparently added local_irq_save/restore to sched_clock(), but "absolute 
madness". sched_clock() is _very_ performance-sensitive for the 
scheduler, do not mess with it.

	Ingo
