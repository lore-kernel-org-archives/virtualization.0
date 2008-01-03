From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler
	instrumentation
Date: Thu, 3 Jan 2008 08:58:51 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801030849180.1468__34736.3073881299$1199369007$gmane$org@gandalf.stny.rr.com>
References: <20080103071609.478486470@goodmis.org>
	<20080103072226.776141236@goodmis.org>
	<20080103092104.GE10813@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080103092104.GE10813@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@sous-sol.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Gregory Haskins <ghaskins@novell.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Steven Rostedt <srostedt@redhat.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


[Added Chris Wright, Rusty and Virt list because they were involved with
this issue before]

On Thu, 3 Jan 2008, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > +# function tracing might turn this off:
> > +config REGPARM
> > +	bool
> > +	depends on !MCOUNT
> > +	default y
>
> are you sure -pg really needs this?

Nope! Arnaldo and I only carried it because you had it ;-)

> I just carried this along the years
> and went the path of least resistence, but we should not be
> reintroducing the !REGPARM build mode for the kernel. I'd not be
> surprised if there were a few issues with REGPARM + mcount, but we have
> to figure it out before merging ...

Hmm, I know paravirt-ops had an issue with mcount in the RT tree. I can't
remember the exact issues, but it did have something to do with the way
parameters were passed in.

Chris, do you remember what the issues were?

I'm also thinking that this is only an i386 issue.

Thanks,

-- Steve
