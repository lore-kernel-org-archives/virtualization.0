From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
 entry.S
Date: Wed, 8 Aug 2007 09:26:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708080924590.7236__34080.1152553924$1186579902$gmane$org@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
	<p738x8mrv4m.fsf@bingen.suse.de>
	<Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 8 Aug 2007, Steven Rostedt wrote:

> On Wed, 8 Aug 2007, Andi Kleen wrote:
>
> >>  paranoid_restore\trace:
> >>       RESTORE_ALL 8
> >> -     iretq
> >> +     INTERRUPT_RETURN
> >
> >I suspect Xen will need much more changes anyways because of its
> >ring 3 guest. Are these changes sufficient for lguest?
>
>
> The above was what I was replying to.

If you were talking about the general iretq => INTERRUPT_RETURN, then the
answer is "Yes, they are sufficient". The first version of lguest ran the
guest kernel in ring 3 (using dual page tables for guest kernel and guest
user).  The current version I'm pushing runs lguest in ring 1, and the
entry.S code  worked for both.

-- Steve
