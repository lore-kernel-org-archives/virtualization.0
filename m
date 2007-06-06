From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 14:46:59 +0200
Message-ID: <4666C8E3.76E4.0078.0@novell.com>
References: <C28C5EAB.1024D%keir@xensource.com> <200706061418.28967.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200706061418.28967.ak@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>, Keir Fraser <keir@xensource.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

>>> Andi Kleen <ak@suse.de> 06.06.07 14:18 >>>
>
>>=20
>> Yes, this could be an issue. Is there any way to get an interrupt or =
MCE
>> when thermal throttling occurs?
>
>Yes you can get an thermal interrupt from the local APIC. See the Linux
>kernel source. Of course there would be still a race window.
>
>On the other hand some timing issues on throttling are probably=20
>the smallest of the users' problems when it really happens.

Not if this results in your box hanging - I think throttling is exactly =
intended
to keep the box alive as long as possible (and I've seen throttling in =
action,
with the box happily recovering from the situation - after having seen it =
a
few times I checked and found the fan covered with dust).

>Standard Linux just ignores it.

Jan
