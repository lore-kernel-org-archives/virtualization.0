From: Andi Kleen <ak@suse.de>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 6 Jun 2007 14:18:28 +0200
Message-ID: <200706061418.28967.ak@suse.de>
References: <C28C5EAB.1024D%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765130AbXFFMSv@vger.kernel.org>
In-Reply-To: <C28C5EAB.1024D%keir@xensource.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Keir Fraser <keir@xensource.com>
Cc: Jan Beulich <jbeulich@novell.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org


> 
> Yes, this could be an issue. Is there any way to get an interrupt or MCE
> when thermal throttling occurs?

Yes you can get an thermal interrupt from the local APIC. See the Linux
kernel source. Of course there would be still a race window.

On the other hand some timing issues on throttling are probably 
the smallest of the users' problems when it really happens.

Standard Linux just ignores it.

-Andi
