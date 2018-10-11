From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/3] x86: faster mb()+other barrier.h tweaks
Date: Thu, 11 Oct 2018 14:11:42 -0400
Message-ID: <20181011140837-mutt-send-email-mst__19618.8864567832$1539281388$gmane$org@kernel.org>
References: <1452635935-5439-1-git-send-email-mst@redhat.com>
	<56957D54.5000602@zytor.com>
	<20160126101921-mutt-send-email-mst@redhat.com>
	<20181011173707.26pekp65tlipvhdx@alap3.anarazel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181011173707.26pekp65tlipvhdx@alap3.anarazel.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andres Freund <andres@anarazel.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 11, 2018 at 10:37:07AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2016-01-26 10:20:14 +0200, Michael S. Tsirkin wrote:
> > On Tue, Jan 12, 2016 at 02:25:24PM -0800, H. Peter Anvin wrote:
> > > On 01/12/16 14:10, Michael S. Tsirkin wrote:
> > > > mb() typically uses mfence on modern x86, but a micro-benchmark shows that it's
> > > > 2 to 3 times slower than lock; addl $0,(%%e/rsp) that we use on older CPUs.
> > > > 
> > > > So let's use the locked variant everywhere - helps keep the code simple as
> > > > well.
> > > > 
> > > > While I was at it, I found some inconsistencies in comments in
> > > > arch/x86/include/asm/barrier.h
> > > > 
> > > > I hope I'm not splitting this up too much - the reason is I wanted to isolate
> > > > the code changes (that people might want to test for performance) from comment
> > > > changes approved by Linus, from (so far unreviewed) comment change I came up
> > > > with myself.
> > > > 
> > > > Lightly tested on my system.
> > > > 
> > > > Michael S. Tsirkin (3):
> > > >   x86: drop mfence in favor of lock+addl
> > > >   x86: drop a comment left over from X86_OOSTORE
> > > >   x86: tweak the comment about use of wmb for IO
> > > > 
> > > 
> > > I would like to get feedback from the hardware team about the
> > > implications of this change, first.
> 
> > Any luck getting some feedback on this one?
> 
> Ping?  I just saw a bunch of kernel fences in a benchmark, making me
> wonder why linux uses mfence rather than lock addl. Leading me to this
> thread.
> 
> Greetings,
> 
> Andres Freund

It doesn't do it for smp_mb any longer:

commit 450cbdd0125cfa5d7bbf9e2a6b6961cc48d29730
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Fri Oct 27 19:14:31 2017 +0300

    locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE


I didn't bother with mb() since I didn't think it's performance
critical, and one needs to worry about drivers possibly doing
non-temporals etc which do need mfence.

Do you see mb() in a benchmark then?

-- 
MST
