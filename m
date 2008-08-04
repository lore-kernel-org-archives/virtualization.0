From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: Too many I/O controller patches
Date: Mon, 04 Aug 2008 13:50:36 -0700
Message-ID: <1217883036.20260.137.camel__27981.1457534835$1217883462$gmane$org@nimitz>
References: <20080804.175126.193692178.ryov@valinux.co.jp>
	<1217870433.20260.101.camel@nimitz>  <489748E6.5080106@gmail.com>
	<1217876521.20260.123.camel@nimitz>  <48976A2A.9060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48976A2A.9060600@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: righi.andrea@gmail.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2008-08-04 at 22:44 +0200, Andrea Righi wrote:
> Dave Hansen wrote:
> > On Mon, 2008-08-04 at 20:22 +0200, Andrea Righi wrote:
> >> But I'm not yet convinced that limiting the IO writes at the device
> >> mapper layer is the best solution. IMHO it would be better to throttle
> >> applications' writes when they're dirtying pages in the page cache (the
> >> io-throttle way), because when the IO requests arrive to the device
> >> mapper it's too late (we would only have a lot of dirty pages that are
> >> waiting to be flushed to the limited block devices, and maybe this could
> >> lead to OOM conditions). IOW dm-ioband is doing this at the wrong level
> >> (at least for my requirements). Ryo, correct me if I'm wrong or if I've
> >> not understood the dm-ioband approach.
> > 
> > The avoid-lots-of-page-dirtying problem sounds like a hard one.  But, if
> > you look at this in combination with the memory controller, they would
> > make a great team.
> > 
> > The memory controller keeps you from dirtying more than your limit of
> > pages (and pinning too much memory) even if the dm layer is doing the
> > throttling and itself can't throttle the memory usage.
> 
> mmh... but in this way we would just move the OOM inside the cgroup,
> that is a nice improvement, but the main problem is not resolved...
> 
> A safer approach IMHO is to force the tasks to wait synchronously on
> each operation that directly or indirectly generates i/o.

Fine in theory, hard in practice. :)

I think the best we can hope for is to keep parity with what happens in
the rest of the kernel.  We already have a problem today with people
mmap()'ing lots of memory and dirtying it all at once.  Adding a i/o
bandwidth controller or a memory controller isn't really going to fix
that.  I think it is outside the scope of the i/o (and memory)
controllers until we solve it generically, first.

-- Dave
