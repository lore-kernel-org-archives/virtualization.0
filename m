From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 07:15:31 -0700
Message-ID: <4666C183.9060008@goop.org>
References: <20070522140941.802382212@goop.org> <46668EC6.76E4.0078.0@novell.com> <466686E2.4040004@goop.org> <200706061226.11326.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761148AbXFFOPv@vger.kernel.org>
In-Reply-To: <200706061226.11326.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, virtualization@lists.osdl.org, Xen-devel <xen-devel@lists.xensource.com>, Chris Wright <chrisw@sous-sol.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Bohac <jbohac@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> I once had some code in there to do that, implemented in very boneheaded
>> way with a spinlock to protect the "last time returned" variable.  I
>> expect there's a better way to implement it.
>>     
>
> But any per CPU setup likely needs this to avoid non monotonicity 

Yeah.  The point I didn't quite make was that this should be something
that the clock core should handle rather than dealing with it in every
clocksource.

    J
