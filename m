From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v15 4/5] mm: support reporting free page blocks
Date: Mon, 28 Aug 2017 16:09:58 +0200
Message-ID: <20170828140958.GO17097__39693.8628088266$1503929422$gmane$org@dhcp22.suse.cz>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-5-git-send-email-wei.w.wang@intel.com>
	<20170828133326.GN17097@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170828133326.GN17097@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, willy@infradead.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon 28-08-17 15:33:26, Michal Hocko wrote:
> On Mon 28-08-17 18:08:32, Wei Wang wrote:
> > This patch adds support to walk through the free page blocks in the
> > system and report them via a callback function. Some page blocks may
> > leave the free list after zone->lock is released, so it is the caller's
> > responsibility to either detect or prevent the use of such pages.
> > 
> > One use example of this patch is to accelerate live migration by skipping
> > the transfer of free pages reported from the guest. A popular method used
> > by the hypervisor to track which part of memory is written during live
> > migration is to write-protect all the guest memory. So, those pages that
> > are reported as free pages but are written after the report function
> > returns will be captured by the hypervisor, and they will be added to the
> > next round of memory transfer.
> 
> OK, looks much better. I still have few nits.
> 
> > +extern void walk_free_mem_block(void *opaque,
> > +				int min_order,
> > +				bool (*report_page_block)(void *, unsigned long,
> > +							  unsigned long));
> > +
> 
> please add names to arguments of the prototype

And one more thing. Your callback returns bool and true usually means a
success while you are using it to break out from the loop. This is
rather confusing. I would expect iterating until false is returned so
the opposite than what you have. You could also change this to int and
return 0 on success and < 0 to break out. 

-- 
Michal Hocko
SUSE Labs
