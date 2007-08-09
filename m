From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/7] Added generic lg.h in lguest directory.
Date: Wed, 8 Aug 2007 22:17:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708082214300.19189__27742.5295477316$1186625985$gmane$org@gandalf.stny.rr.com>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.310187242@goodmis.org>
	<20070809114528.da47fd77.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809114528.da47fd77.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--
On Thu, 9 Aug 2007, Stephen Rothwell wrote:

> On Wed, 08 Aug 2007 20:32:13 -0400 Steven Rostedt <rostedt@goodmis.org>
> wrote:
> >
> > Add a generic lg.h file to call the architecture specific one.
>
> Please combine this with the previous patch so that the tree will build
> at each step.

Yeah, I wanted to do that, but git got confused when I did that, and did
what I didn't want. That was, created a new file in the i386 directory,
and diffed the one in this directory.

I'm really want to keep git knowing the history of the file on moving. I
could just simply cat the two files instead. Would that be acceptible?

-- Steve
