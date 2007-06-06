From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 14/33] xen: xen time implementation
Date: Wed, 6 Jun 2007 14:53:20 +0200
Message-ID: <200706061453.20798.ak@suse.de>
References: <C28C5EAB.1024D%keir@xensource.com> <200706061418.28967.ak@suse.de>
	<4666C8E3.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4666C8E3.76E4.0078.0@novell.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jan Beulich <jbeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Keir Fraser <keir@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 06 June 2007 14:46:59 Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 06.06.07 14:18 >>>
> >
> >> 
> >> Yes, this could be an issue. Is there any way to get an interrupt or MCE
> >> when thermal throttling occurs?
> >
> >Yes you can get an thermal interrupt from the local APIC. See the Linux
> >kernel source. Of course there would be still a race window.
> >
> >On the other hand some timing issues on throttling are probably 
> >the smallest of the users' problems when it really happens.
> 
> Not if this results in your box hanging 

Yes it shouldn't hang. Just saying that some non monotonicity in the returned
values under this abnormal condition is probably not the world's end.

-Andi
