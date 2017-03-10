From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v7 kernel 3/5] virtio-balloon: implementation of
	VIRTIO_BALLOON_F_CHUNK_TRANSFER
Date: Fri, 10 Mar 2017 19:37:28 +0800
Message-ID: <58C28FF8.5040403__22688.98856496$1489145778$gmane$org@intel.com>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170309141411.GZ16328@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, virtio-dev@lists.oasis-open.org, Amit Shah <amit.shah@redhat.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Liang Li <liang.z.li@intel.com>, Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liliang324@gmail.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/09/2017 10:14 PM, Matthew Wilcox wrote:
> On Fri, Mar 03, 2017 at 01:40:28PM +0800, Wei Wang wrote:
>> From: Liang Li <liang.z.li@intel.com>
>> 1) allocating pages (6.5%)
>> 2) sending PFNs to host (68.3%)
>> 3) address translation (6.1%)
>> 4) madvise (19%)
>>
>> This patch optimizes step 2) by transfering pages to the host in
>> chunks. A chunk consists of guest physically continuous pages, and
>> it is offered to the host via a base PFN (i.e. the start PFN of
>> those physically continuous pages) and the size (i.e. the total
>> number of the pages). A normal chunk is formated as below:
>> -----------------------------------------------
>> |  Base (52 bit)               | Size (12 bit)|
>> -----------------------------------------------
>> For large size chunks, an extended chunk format is used:
>> -----------------------------------------------
>> |                 Base (64 bit)               |
>> -----------------------------------------------
>> -----------------------------------------------
>> |                 Size (64 bit)               |
>> -----------------------------------------------
> What's the advantage to extended chunks?  IOW, why is the added complexity
> of having two chunk formats worth it?  You already reduced the overhead by
> a factor of 4096 with normal chunks ... how often are extended chunks used
> and how much more efficient are they than having several normal chunks?
>

Right, chunk_ext may be rarely used, thanks. I will remove chunk_ext if 
there is no objection from others.

Best,
Wei
