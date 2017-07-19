From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v12 6/8] mm: support reporting free page blocks
Date: Wed, 19 Jul 2017 10:13:12 +0200
Message-ID: <20170719081311.GC26779__39548.2142492712$1500452019$gmane$org@dhcp22.suse.cz>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
	<596D6E7E.4070700@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <596D6E7E.4070700@intel.com>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, amit.shah@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue 18-07-17 10:12:14, Wei Wang wrote:
[...]
> Probably I should have included the introduction of the usages in
> the log. Hope it is not too later to explain here:

Yes this should have been described in the cover.
 
> Live migration needs to transfer the VM's memory from the source
> machine to the destination round by round. For the 1st round, all the VM's
> memory is transferred. From the 2nd round, only the pieces of memory
> that were written by the guest (after the 1st round) are transferred. One
> method that is popularly used by the hypervisor to track which part of
> memory is written is to write-protect all the guest memory.
> 
> This patch enables the optimization of the 1st round memory transfer -
> the hypervisor can skip the transfer of guest unused pages in the 1st round.

All you should need is the check for the page reference count, no?  I
assume you do some sort of pfn walk and so you should be able to get an
access to the struct page.
-- 
Michal Hocko
SUSE Labs
