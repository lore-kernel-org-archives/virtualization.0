From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: don't zero ballooned pages
Date: Mon, 31 Jul 2017 09:51:54 +0200
Message-ID: <20170731075153.GD15767__16162.8163107254$1501487523$gmane$org@dhcp22.suse.cz>
References: <1501474413-21580-1-git-send-email-wei.w.wang@intel.com>
	<20170731065508.GE13036@dhcp22.suse.cz>
	<597EDF3D.8020101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <597EDF3D.8020101@intel.com>
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
Cc: mst@redhat.com, mawilcox@microsoft.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, zhenwei.pi@youruncloud.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon 31-07-17 15:41:49, Wei Wang wrote:
> On 07/31/2017 02:55 PM, Michal Hocko wrote:
> >On Mon 31-07-17 12:13:33, Wei Wang wrote:
> >>Ballooned pages will be marked as MADV_DONTNEED by the hypervisor and
> >>shouldn't be given to the host ksmd to scan.
> >Could you point me where this MADV_DONTNEED is done, please?
> 
> Sure. It's done in the hypervisor when the balloon pages are received.
> 
> Please see line 40 at
> https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c

And one more thing. I am not familiar with ksm much. But how is
MADV_DONTNEED even helping? This madvise is not sticky - aka it will
unmap the range without leaving any note behind. AFAICS the only way
to have vma scanned is to have VM_MERGEABLE and that is an opt in:
See Documentation/vm/ksm.txt
"
KSM only operates on those areas of address space which an application
has advised to be likely candidates for merging, by using the madvise(2)
system call: int madvise(addr, length, MADV_MERGEABLE).
"

So what exactly is going on here? The original patch looks highly
suspicious as well. If somebody wants to make that memory mergable then
the user of that memory should zero them out.
-- 
Michal Hocko
SUSE Labs
