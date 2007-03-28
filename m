From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 3/4] Locally disable the softlockup watchdog rather than touching it
Date: Wed, 28 Mar 2007 15:50:04 +0200
Message-ID: <200703281550.04224.ak@suse.de>
References: <20070327214919.800272641@goop.org> <20070327215828.085422178@goop.org> <460A6EC0.4020701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751722AbXC1Nua@vger.kernel.org>
In-Reply-To: <460A6EC0.4020701@redhat.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Prarit Bhargava <prarit@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Hawkes <hawkes@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 28 March 2007 15:33, Prarit Bhargava wrote:
> 
> Jeremy Fitzhardinge wrote:
> >
> > I haven't really worked out how this should interact with the nmi
> > watchdog; touch_nmi_watchdog() still ends up calling
> > touch_softlockup_watchdog(), so there's still some redundancy here.
> >
> >   
> 
> touch_nmi_watchdog is attempting to tickle _all_ CPUs softlockup watchdogs.

It is supposed to only touch the current CPU, just like it only touches
the NMI watchdog on the current CPU.


> 
> Currently, the code is incorrect -- it is calling 
> touch_softlockup_watchdog which touches only the current CPU's 
> softlockup watchdog.

Sounds correct to me.

-Andi

> 
