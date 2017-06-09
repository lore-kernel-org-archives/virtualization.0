From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v11 0/6] Virtio-balloon Enhancement
Date: Fri, 9 Jun 2017 11:18:42 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73925B11D__4566.98228740624$1497007135$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, June 9, 2017 6:42 PM, Wang, Wei W wrote:
> To: virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org; qemu-
> devel@nongnu.org; virtualization@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-mm@kvack.org; mst@redhat.com;
> david@redhat.com; Hansen, Dave <dave.hansen@intel.com>;
> cornelia.huck@de.ibm.com; akpm@linux-foundation.org;
> mgorman@techsingularity.net; aarcange@redhat.com; amit.shah@redhat.com;
> pbonzini@redhat.com; Wang, Wei W <wei.w.wang@intel.com>;
> liliang.opensource@gmail.com
> Subject: [PATCH v11 0/6] Virtio-balloon Enhancement
> 
> This patch series enhances the existing virtio-balloon with the following new
> features:
> 1) fast ballooning: transfer ballooned pages between the guest and host in
> chunks, instead of one by one; and
> 2) cmdq: a new virtqueue to send commands between the device and driver.
> Currently, it supports commands to report memory stats (replace the old statq
> mechanism) and report guest unused pages.

v10->v11 changes:
1) virtio_balloon: use vring_desc to describe a chunk;
2) virtio_ring: support to add an indirect desc table to virtqueue;
3)  virtio_balloon: use cmdq to report guest memory statistics.

> 
> Liang Li (1):
>   virtio-balloon: deflate via a page list
> 
> Wei Wang (5):
>   virtio-balloon: coding format cleanup
>   virtio-balloon: VIRTIO_BALLOON_F_PAGE_CHUNKS
>   mm: function to offer a page block on the free list
>   mm: export symbol of next_zone and first_online_pgdat
>   virtio-balloon: VIRTIO_BALLOON_F_CMD_VQ
> 
>  drivers/virtio/virtio_balloon.c     | 781 ++++++++++++++++++++++++++++++++--
> --
>  drivers/virtio/virtio_ring.c        | 120 +++++-
>  include/linux/mm.h                  |   5 +
>  include/linux/virtio.h              |   7 +
>  include/uapi/linux/virtio_balloon.h |  14 +
>  include/uapi/linux/virtio_ring.h    |   3 +
>  mm/mmzone.c                         |   2 +
>  mm/page_alloc.c                     |  91 +++++
>  8 files changed, 950 insertions(+), 73 deletions(-)
> 
> --
> 2.7.4
