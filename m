From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v14 4/5] mm: support reporting free page blocks
Date: Mon, 21 Aug 2017 08:14:23 +0200
Message-ID: <20170821061421.GA13724@dhcp22.suse.cz>
References: <1502940416-42944-1-git-send-email-wei.w.wang@intel.com>
	<1502940416-42944-5-git-send-email-wei.w.wang@intel.com>
	<20170818134650.GC18499@dhcp22.suse.cz>
	<599A79DF.2000707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <599A79DF.2000707@intel.com>
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

On Mon 21-08-17 14:12:47, Wei Wang wrote:
> On 08/18/2017 09:46 PM, Michal Hocko wrote:
[...]
> >>+/**
> >>+ * walk_free_mem_block - Walk through the free page blocks in the system
> >>+ * @opaque1: the context passed from the caller
> >>+ * @min_order: the minimum order of free lists to check
> >>+ * @visit: the callback function given by the caller
> >The original suggestion for using visit was motivated by a visit design
> >pattern but I can see how this can be confusing. Maybe a more explicit
> >name wold be better. What about report_free_range.
> 
> 
> I'm afraid that name would be too long to fit in nicely.
> How about simply naming it "report"?

I do not have a strong opinion on this. I wouldn't be afraid of using
slightly longer name here for the clarity sake, though.
 
> >>+ *
> >>+ * The function is used to walk through the free page blocks in the system,
> >>+ * and each free page block is reported to the caller via the @visit callback.
> >>+ * Please note:
> >>+ * 1) The function is used to report hints of free pages, so the caller should
> >>+ * not use those reported pages after the callback returns.
> >>+ * 2) The callback is invoked with the zone->lock being held, so it should not
> >>+ * block and should finish as soon as possible.
> >I think that the explicit note about zone->lock is not really need. This
> >can change in future and I would even bet that somebody might rely on
> >the lock being held for some purpose and silently get broken with the
> >change. Instead I would much rather see something like the following:
> >"
> >Please note that there are no locking guarantees for the callback
> 
> Just a little confused with this one:
> 
> The callback is invoked within zone->lock, why would we claim it "no
> locking guarantees for the callback"?

Because we definitely do not want anybody to rely on that fact and
(ab)use it. This might change in future and it would be better to be
clear about that.
-- 
Michal Hocko
SUSE Labs
