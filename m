From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: Too many I/O controller patches
Date: Tue, 05 Aug 2008 15:28:16 +0900 (JST)
Message-ID: <20080805.152816.105502343.taka__10779.7308628962$1217917833$gmane$org@valinux.co.jp>
References: <1217876521.20260.123.camel@nimitz> <48976A2A.9060600@gmail.com>
	<1217883036.20260.137.camel@nimitz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1217883036.20260.137.camel@nimitz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dave@linux.vnet.ibm.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> > >> But I'm not yet convinced that limiting the IO writes at the device
> > >> mapper layer is the best solution. IMHO it would be better to throttle
> > >> applications' writes when they're dirtying pages in the page cache (the
> > >> io-throttle way), because when the IO requests arrive to the device
> > >> mapper it's too late (we would only have a lot of dirty pages that are
> > >> waiting to be flushed to the limited block devices, and maybe this could
> > >> lead to OOM conditions). IOW dm-ioband is doing this at the wrong level
> > >> (at least for my requirements). Ryo, correct me if I'm wrong or if I've
> > >> not understood the dm-ioband approach.
> > > 
> > > The avoid-lots-of-page-dirtying problem sounds like a hard one.  But, if
> > > you look at this in combination with the memory controller, they would
> > > make a great team.
> > > 
> > > The memory controller keeps you from dirtying more than your limit of
> > > pages (and pinning too much memory) even if the dm layer is doing the
> > > throttling and itself can't throttle the memory usage.
> > 
> > mmh... but in this way we would just move the OOM inside the cgroup,
> > that is a nice improvement, but the main problem is not resolved...
> > 
> > A safer approach IMHO is to force the tasks to wait synchronously on
> > each operation that directly or indirectly generates i/o.
> 
> Fine in theory, hard in practice. :)
> 
> I think the best we can hope for is to keep parity with what happens in
> the rest of the kernel.  We already have a problem today with people
> mmap()'ing lots of memory and dirtying it all at once.  Adding a i/o
> bandwidth controller or a memory controller isn't really going to fix
> that.  I think it is outside the scope of the i/o (and memory)
> controllers until we solve it generically, first.

Yes, that's right. This should be solved.

But there is a good thing when you use a memory controller.
A problem occurred in a certain cgroup will be confined in its cgroup.
I think this is a great point, don't you think?

Thank you,
Hirokazu Takahashi.
