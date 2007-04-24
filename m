From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/4] Ignore stolen time in the softlockup watchdog
Date: Tue, 24 Apr 2007 13:48:32 -0700
Message-ID: <462E6D20.5000108@goop.org>
References: <20070327214919.800272641@goop.org>	<20070327215827.871954359@goop.org>	<20070423234910.50149faf.akpm@linux-foundation.org>	<462E43A7.1050001@goop.org>	<20070424105738.e0ce36a9.akpm@linux-foundation.org>	<462E4969.6070802@goop.org>	<20070424113222.ed2e1314.akpm@linux-foundation.org>	<462E61F1.7060403@goop.org>	<462E6778.7070305@goop.org> <20070424133359.f18bce78.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423017AbXDXUsL@vger.kernel.org>
In-Reply-To: <20070424133359.f18bce78.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>, john stultz <johnstul@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>, virtualization@lists.osdl.org, Chris Lalancette <clalance@redhat.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> It's weird.  And I don't think the locking selftest code calls
> sched_clock() (or any other time-related thing) at all, does it?
>   

I guess it ends up going through the scheduler, which does use it. 
But... <shrug>

    J
