From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH v6 kernel 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Tue, 10 Jan 2017 06:43:23 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3C34EE1E@shsmsx102.ccr.corp.intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
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
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi guys,

Could you help to review this patch set?

Thanks!
Liang

> -----Original Message-----
> From: Li, Liang Z
> Sent: Wednesday, December 21, 2016 2:52 PM
> To: kvm@vger.kernel.org
> Cc: virtio-dev@lists.oasis-open.org; qemu-devel@nongnu.org; linux-
> mm@kvack.org; linux-kernel@vger.kernel.org; virtualization@lists.linux-
> foundation.org; amit.shah@redhat.com; Hansen, Dave;
> cornelia.huck@de.ibm.com; pbonzini@redhat.com; mst@redhat.com;
> david@redhat.com; aarcange@redhat.com; dgilbert@redhat.com;
> quintela@redhat.com; Li, Liang Z
> Subject: [PATCH v6 kernel 0/5] Extend virtio-balloon for fast (de)inflating &
> fast live migration
> 
> This patch set contains two parts of changes to the virtio-balloon.
> 
> One is the change for speeding up the inflating & deflating process, the main
> idea of this optimization is to use {pfn|length} to present the page
> information instead of the PFNs, to reduce the overhead of virtio data
> transmission, address translation and madvise(). This can help to improve the
> performance by about 85%.
> 
> Another change is for speeding up live migration. By skipping process guest's
> unused pages in the first round of data copy, to reduce needless data
> processing, this can help to save quite a lot of CPU cycles and network
> bandwidth. We put guest's unused page information in a {pfn|length} array
> and send it to host with the virt queue of virtio-balloon. For an idle guest with
> 8GB RAM, this can help to shorten the total live migration time from 2Sec to
> about 500ms in 10Gbps network environment. For an guest with quite a lot
> of page cache and with little unused pages, it's possible to let the guest drop
> it's page cache before live migration, this case can benefit from this new
> feature too.
> 
> Changes from v5 to v6:
>     * Drop the bitmap from the virtio ABI, use {pfn|length} only.
>     * Enhance the API to get the unused page information from mm.
> 
> Changes from v4 to v5:
>     * Drop the code to get the max_pfn, use another way instead.
>     * Simplify the API to get the unused page information from mm.
> 
> Changes from v3 to v4:
>     * Use the new scheme suggested by Dave Hansen to encode the bitmap.
>     * Add code which is missed in v3 to handle migrate page.
>     * Free the memory for bitmap intime once the operation is done.
>     * Address some of the comments in v3.
> 
> Changes from v2 to v3:
>     * Change the name of 'free page' to 'unused page'.
>     * Use the scatter & gather bitmap instead of a 1MB page bitmap.
>     * Fix overwriting the page bitmap after kicking.
>     * Some of MST's comments for v2.
> 
> Changes from v1 to v2:
>     * Abandon the patch for dropping page cache.
>     * Put some structures to uapi head file.
>     * Use a new way to determine the page bitmap size.
>     * Use a unified way to send the free page information with the bitmap
>     * Address the issues referred in MST's comments
> 
> Liang Li (5):
>   virtio-balloon: rework deflate to add page to a list
>   virtio-balloon: define new feature bit and head struct
>   virtio-balloon: speed up inflate/deflate process
>   virtio-balloon: define flags and head for host request vq
>   virtio-balloon: tell host vm's unused page info
> 
>  drivers/virtio/virtio_balloon.c     | 510
> ++++++++++++++++++++++++++++++++----
>  include/linux/mm.h                  |   3 +
>  include/uapi/linux/virtio_balloon.h |  34 +++
>  mm/page_alloc.c                     | 120 +++++++++
>  4 files changed, 621 insertions(+), 46 deletions(-)
> 
> --
> 1.9.1
