From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
	entry.S
Date: Wed, 8 Aug 2007 15:29:26 +0200
Message-ID: <20070808132926.GC14419__43483.5730855868$1186580038$gmane$org@one.firstfloor.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
	<p738x8mrv4m.fsf@bingen.suse.de>
	<Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, Andi Kleen <andi@firstfloor.org>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

> When I said "this part of the code I don't fully understand" I was not
> talking about entry.S.  I understand entry.S very well, but the comment
> was originally on the paranoid_restore code. Which I thought had to deal
> with NMIs and such that I didn't worry about that I simply did the
> default.

The paranoid path is used for more than just NMIs; it's also used for MCEs,
stack faults, double faults or debug exceptions. Anything that might
happen with a invalid stack or unknown GS state or system in other unknown
state.

If you can guarantee your hypervisor never injects any of those it could be ignored; 
but at least losing debug exceptions would be probably not nice.

> 
> >>  paranoid_restore\trace:
> >>       RESTORE_ALL 8
> >> -     iretq
> >> +     INTERRUPT_RETURN
> >
> >I suspect Xen will need much more changes anyways because of its
> >ring 3 guest. Are these changes sufficient for lguest?

This was really a general comment not especially applying to the 
paranoid path.

-Andi
