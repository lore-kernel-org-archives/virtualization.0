From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/25] [PATCH] turn priviled operations into macros in
 entry.S
Date: Thu, 9 Aug 2007 08:17:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708090813450.29847__43049.2959254936$1186661984$gmane$org@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<200708081138.23018.ak@suse.de>
	<Pine.LNX.4.58.0708080740490.5921@gandalf.stny.rr.com>
	<200708081424.49896.ak@suse.de>
	<Pine.LNX.4.58.0708080835350.6751@gandalf.stny.rr.com>
	<p738x8mrv4m.fsf@bingen.suse.de>
	<Pine.LNX.4.58.0708080919330.7236@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0708080924590.7236@gandalf.stny.rr.com>
	<20070808133001.GD14419@one.firstfloor.org>
	<Pine.LNX.4.58.0708080936070.7516@gandalf.stny.rr.com>
	<46BAA447.9010504@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BAA447.9010504@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lguest@ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, Andi Kleen <andi@firstfloor.org>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

--
On Wed, 8 Aug 2007, Jeremy Fitzhardinge wrote:

> Steven Rostedt wrote:
> > 	/*
> > 	 * x86 arch doesn't have an easy way to find out where
> > 	 * gs is located. So we need to read the MSR. But first
> > 	 * we need to save off the rcx, rax and rdx.
> >
> Why don't you store it in gs?  movq %gs:my_gs_base, %rax?

Because it can't be trusted.  After the swapgs, we are pointing to the RW
section of the HV. But by running the guest kernel in ring 1, we have no
protection from the guest writing into that area too. So we can't put
anything in that section and expect it to be safe after jumping to guest
code.  The only trusted values, is jumping in after getting there by an
interrupt, where the hardware places the values onto the stack.

But with Andi's comments, I realized I can point the gs pointer to the
RO area. And make a constant offset that will point up into the RW area,
so we could save the stack and replace it.

-- Steve
