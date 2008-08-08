From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: RFC: I/O bandwidth controller
Date: Fri, 08 Aug 2008 20:39:44 +0900 (JST)
Message-ID: <20080808.203944.29203232.taka__4134.82915978438$1218195776$gmane$org@valinux.co.jp>
References: <1217985189.3154.57.camel@sebastian.kern.oss.ntt.co.jp>
	<4899D464.1070506@linux.vnet.ibm.com>
	<1218078075.3803.149.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1218078075.3803.149.camel@sebastian.kern.oss.ntt.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: fernando@oss.ntt.co.jp
Cc: xen-devel@lists.xensource.com, uchida@ap.jp.nec.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, righi.andrea@gmail.com, agk@sourceware.org, dave@linux.vnet.ibm.com, ngupta@google.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> > Would you like to split up IO into read and write IO. We know that read can be
> > very latency sensitive when compared to writes. Should we consider them
> > separately in the RFC?
> Oops, I somehow ended up leaving your first question unanswered. Sorry.
> 
> I do not think we should consider them separately, as long as there is a
> proper IO tracking infrastructure in place. As you mentioned, reads can
> be very latecy sensitive, but the read case could be treated as an
> special case IO controller/IO tracking subsystem. There certainly are
> optimization opportunities. For example, in the synchronous I/O patch ww
> could mark bios with the iocontext of the current task, because it will
> happen to be originator of that IO. By effectively caching the ownership
> information in the bio we can avoid all the accesses to struct page,
> page_cgroup, etc, and reads would definitively benefit from that. 

FYI, we should also take special care of pages being reclaimed, the free
memory of the cgroup these pages belong to may be really low.
Dm-ioband is doing this.

Thanks,
Hirokazu Takahashi.
