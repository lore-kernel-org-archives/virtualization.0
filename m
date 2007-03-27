From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 1/2] Ignore stolen time in the softlockup watchdog
Date: Tue, 27 Mar 2007 09:37:53 -0700
Message-ID: <46094861.7080400@goop.org>
References: <20070327053816.881735237@goop.org> <20070327054106.664262413@goop.org> <46092C9B.4030700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933127AbXC0Qhw@vger.kernel.org>
In-Reply-To: <46092C9B.4030700@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Zachary Amsden <zach@vmware.com>, James Morris <jmorris@namei.org>, Dan Hecht <dhecht@vmware.com>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chris Lalancette <clalance@redhat.com>, Rick Lindsley <ricklind@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Prarit Bhargava wrote:
> I'd like to see this patch implement/fix touch_cpu_softlockup_watchdog
> and touch_softlockup_watchdog to mimic touch_nmi_watchdog's behaviour.

Why?  Is that more correct?  It seems to me that you're interested in
whether a specific CPU has gone and locked up.  If touching the watchdog
makes it update all CPU timestamps, then you'll hide the fact that other
CPUs have locked up, won't it?

    J
