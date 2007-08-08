From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
 entry.S
Date: Wed, 8 Aug 2007 10:01:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708080952020.7744__47221.8071380214$1186581974$gmane$org@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
	<p738x8mrv4m.fsf@bingen.suse.de>
	<Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
	<20070808132926.GC14419@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070808132926.GC14419@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


--
On Wed, 8 Aug 2007, Andi Kleen wrote:

> > When I said "this part of the code I don't fully understand" I was not
> > talking about entry.S.  I understand entry.S very well, but the comment
> > was originally on the paranoid_restore code. Which I thought had to deal
> > with NMIs and such that I didn't worry about that I simply did the
> > default.
>
> The paranoid path is used for more than just NMIs; it's also used for MCEs,
> stack faults, double faults or debug exceptions. Anything that might
> happen with a invalid stack or unknown GS state or system in other unknown
> state.
>
> If you can guarantee your hypervisor never injects any of those it could be ignored;
> but at least losing debug exceptions would be probably not nice.

For now it does ignore them. But that's something to work on
for later versions of lguest64.  I want lguest out in the public and
working for the general case. I don't plan on ignoring the paranoid
section forever. But it's more on an anomaly for now. But you are right, I
want the debug stuff working. But I also need to walk before I can run ;-)


>
> >
> > >>  paranoid_restore\trace:
> > >>       RESTORE_ALL 8
> > >> -     iretq
> > >> +     INTERRUPT_RETURN
> > >
> > >I suspect Xen will need much more changes anyways because of its
> > >ring 3 guest. Are these changes sufficient for lguest?
>
> This was really a general comment not especially applying to the
> paranoid path.

Ah, OK, I assumed you were talking about just the previous code. But
rereading your post, I see it was more general.  Sorry, for the
miscommunication.

-- Steve
