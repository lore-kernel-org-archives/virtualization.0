From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Thu, 9 Mar 2017 06:14:11 -0800
Message-ID: <20170309141411.GZ16328__14198.1909903281$1490017485$gmane$org@bombadil.infradead.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org, Amit Shah <amit.shah@redhat.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Liang Li <liang.z.li@intel.com>, Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liliang324@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 03, 2017 at 01:40:28PM +0800, Wei Wang wrote:
> From: Liang Li <liang.z.li@intel.com>
> 1) allocating pages (6.5%)
> 2) sending PFNs to host (68.3%)
> 3) address translation (6.1%)
> 4) madvise (19%)
> 
> This patch optimizes step 2) by transfering pages to the host in
> chunks. A chunk consists of guest physically continuous pages, and
> it is offered to the host via a base PFN (i.e. the start PFN of
> those physically continuous pages) and the size (i.e. the total
> number of the pages). A normal chunk is formated as below:
> -----------------------------------------------
> |  Base (52 bit)               | Size (12 bit)|
> -----------------------------------------------
> For large size chunks, an extended chunk format is used:
> -----------------------------------------------
> |                 Base (64 bit)               |
> -----------------------------------------------
> -----------------------------------------------
> |                 Size (64 bit)               |
> -----------------------------------------------

What's the advantage to extended chunks?  IOW, why is the added complexity
of having two chunk formats worth it?  You already reduced the overhead by
a factor of 4096 with normal chunks ... how often are extended chunks used
and how much more efficient are they than having several normal chunks?
