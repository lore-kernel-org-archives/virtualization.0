From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Subject: Re: RFC: I/O bandwidth controller (was Re: Too many I/O controller
	patches)
Date: Thu, 07 Aug 2008 12:01:15 +0900
Message-ID: <1218078075.3803.149.camel__40693.2295453318$1218078201$gmane$org@sebastian.kern.oss.ntt.co.jp>
References: <20080804.175126.193692178.ryov@valinux.co.jp>
	<1217870433.20260.101.camel@nimitz>
	<1217985189.3154.57.camel@sebastian.kern.oss.ntt.co.jp>
	<4899D464.1070506@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4899D464.1070506@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: balbir@linux.vnet.ibm.com
Cc: xen-devel@lists.xensource.com, uchida@ap.jp.nec.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, Dave Hansen <dave@linux.vnet.ibm.com>, ngupta@google.com, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-08-06 at 22:12 +0530, Balbir Singh wrote:
> > *** Goals
> >   1. Cgroups-aware I/O scheduling (being able to define arbitrary
> > groupings of processes and treat each group as a single scheduling
> > entity).
> >   2. Being able to perform I/O bandwidth control independently on each
> > device.
> >   3. I/O bandwidth shaping.
> >   4. Scheduler-independent I/O bandwidth control.
> >   5. Usable with stacking devices (md, dm and other devices of that
> > ilk).
> >   6. I/O tracking (handle buffered and asynchronous I/O properly).
> > 
> > The list of goals above is not exhaustive and it is also likely to
> > contain some not-so-nice-to-have features so your feedback would be
> > appreciated.
> > 
> 
> Would you like to split up IO into read and write IO. We know that read can be
> very latency sensitive when compared to writes. Should we consider them
> separately in the RFC?
Oops, I somehow ended up leaving your first question unanswered. Sorry.

I do not think we should consider them separately, as long as there is a
proper IO tracking infrastructure in place. As you mentioned, reads can
be very latecy sensitive, but the read case could be treated as an
special case IO controller/IO tracking subsystem. There certainly are
optimization opportunities. For example, in the synchronous I/O patch ww
could mark bios with the iocontext of the current task, because it will
happen to be originator of that IO. By effectively caching the ownership
information in the bio we can avoid all the accesses to struct page,
page_cgroup, etc, and reads would definitively benefit from that. 
