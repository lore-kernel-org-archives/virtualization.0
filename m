From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler
	instrumentation
Date: Thu, 3 Jan 2008 14:15:13 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801031413410.5746__41963.8627012775$1199387932$gmane$org@gandalf.stny.rr.com>
References: <20080103071609.478486470@goodmis.org>
	<20080103072226.776141236@goodmis.org>
	<20080103092104.GE10813@elte.hu>
	<Pine.LNX.4.58.0801030849180.1468@gandalf.stny.rr.com>
	<20080103181651.GC3627@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080103181651.GC3627@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Gregory Haskins <ghaskins@novell.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Steven Rostedt <srostedt@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 3 Jan 2008, Chris Wright wrote:

>
> Yes, paravirt ops have a well-specified calling convention (register
> based).  There was a cleanup that Andi did that caused the problem
> because it removed all the "fastcall" annotations since -mregparm=3
> is now always on for i386.  Since MCOUNT disables REGPARM the calling
> convention changes (caller pushes to stack, callee expects register)
> chaos ensues.  I sent a patch to fix that quite some months back, but
> it went stale and I neglected to update it.  Would you like me to dig
> it up refresh and resend?

Chris, thanks for the refresher.

I'm going to see if we can remove the REGPARM hack and change the way
mcount does its calls. Maybe this will fix things for us.

-- Steve
