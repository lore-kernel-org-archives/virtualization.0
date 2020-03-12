From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Thu, 12 Mar 2020 09:37:32 +0100
Message-ID: <3e1373f4-6ade-c651-ddde-6f04e78382f9@redhat.com>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Cc: Hui Zhu <teawaterz@linux.alibaba.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12.03.20 08:49, Hui Zhu wrote:
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> This is an example in a VM with 1G memory 1CPU:
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
>=20
> usemem --punch-holes -s -1 800m &
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
>=20
> (qemu) device_add virtio-balloon-pci,id=3Dballoon1
> (qemu) info balloon
> balloon: actual=3D1024
> (qemu) balloon 624
> (qemu) info balloon
> balloon: actual=3D624
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    153600 kB
>=20
> THP number decreased more than 800M.
> The reason is usemem with punch-holes option will free every other page
> after allocation.  Then 400M free memory inside the guest kernel is
> fragmentation pages.
> The guest kernel will use them to inflate the balloon.  When these
> fragmentation pages are freed, THP will be split.
>=20
> This commit tries to handle this with add a new flag
> VIRTIO_BALLOON_F_THP_ORDER.
> When this flag is set, the balloon page order will be set to the THP or=
der.
> Then THP pages will be freed together in the host.
> This is an example in a VM with 1G memory 1CPU:
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
>=20
> usemem --punch-holes -s -1 800m &
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
>=20
> (qemu) device_add virtio-balloon-pci,id=3Dballoon1,thp-order=3Don
> (qemu) info balloon
> balloon: actual=3D1024
> (qemu) balloon 624
> (qemu) info balloon
> balloon: actual=3D624
>=20
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    583680 kB
>=20
> The THP number decreases 384M.  This shows that VIRTIO_BALLOON_F_THP_OR=
DER
> can help handle the THP split issue.


Multiple things:

I recently had a similar discussion with Alex [1] and I think this needs
more thought.

My thoughts:

1. You most certainly want to fallback to allocating pages in a smaller
granularity once you run out of bigger allocations. Sacrifice
performance for memory inflation, which has always been the case and
which is what people expect to happen. (e.g., to shrink the page cache
properly)

2. You are essentially stealing THPs in the guest. So the fastest
mapping (THP in guest and host) is gone. The guest won't be able to make
use of THP where it previously was able to. I can imagine this implies a
performance degradation for some workloads. This needs a proper
performance evaluation.

3. The pages you allocate are not migrateable, e.g., for memory
offlining or alloc_contig_range() users like gigantic pages or soon
virtio-mem. I strongly dislike that. This is IMHO a step backwards. We
want to be able to migrate or even split-up and migrate such pages.

Assume the guest could make good use of a THP somewhere. Who says it
wouldn't be better to sacrifice a huge balloon page to be able to use
THP both in the guest and the host for that mapping? I am not convinced
stealing possible THPs in the guest and not being able to split them up
is really what we want performance wise.


4. I think we also want a better mechanism to directly inflate/deflate
higher/order pages and not reuse the 4k inflate/deflate queues.

5. I think we don't want to hard code such THP values but let the host
tell us the THP size instead, which can easily differ between guest and
host.

Also, I do wonder if balloon compaction in the guest will already result
in more THP getting used again long term. Assume the guest compacts
balloon pages into a single THP again. This will result in a bunch of
DONTNEED/WILLNEED in the hypervisor due to inflation/deflation. I wonder
if the WILLNEED on the sub-pages of a candidate THP in the host will
allow to use a THP in the host again.


[1]
https://lore.kernel.org/linux-mm/939de9de-d82a-aed2-6a51-57a55d81cbff@red=
hat.com/

>=20
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 57 ++++++++++++++++++++++++++---=
--------
>  include/linux/balloon_compaction.h  | 14 ++++++---
>  include/uapi/linux/virtio_balloon.h |  4 +++
>  3 files changed, 54 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index 7bfe365..1e1dc76 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -175,18 +175,31 @@ static unsigned fill_balloon(struct virtio_balloo=
n *vb, size_t num)
>  	unsigned num_pfns;
>  	struct page *page;
>  	LIST_HEAD(pages);
> +	int page_order =3D 0;
> =20
>  	/* We can only do one array worth at a time. */
>  	num =3D min(num, ARRAY_SIZE(vb->pfns));
> =20
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +		page_order =3D VIRTIO_BALLOON_THP_ORDER;
> +
>  	for (num_pfns =3D 0; num_pfns < num;
>  	     num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page =3D balloon_page_alloc();
> +		struct page *page;
> +
> +		if (page_order)
> +			page =3D alloc_pages(__GFP_HIGHMEM |
> +					   __GFP_KSWAPD_RECLAIM |
> +					   __GFP_RETRY_MAYFAIL |
> +					   __GFP_NOWARN | __GFP_NOMEMALLOC,
> +					   page_order);
> +		else
> +			page =3D balloon_page_alloc();
> =20
>  		if (!page) {
>  			dev_info_ratelimited(&vb->vdev->dev,
> -					     "Out of puff! Can't get %u pages\n",
> -					     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +				"Out of puff! Can't get %u pages\n",
> +				VIRTIO_BALLOON_PAGES_PER_PAGE << page_order);
>  			/* Sleep for at least 1/5 of a second before retry. */
>  			msleep(200);
>  			break;
> @@ -206,7 +219,7 @@ static unsigned fill_balloon(struct virtio_balloon =
*vb, size_t num)
>  		vb->num_pages +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, -1);
> +			adjust_managed_page_count(page, -(1 << page_order));
>  		vb->num_pfns +=3D VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
> =20
> @@ -223,13 +236,20 @@ static void release_pages_balloon(struct virtio_b=
alloon *vb,
>  				 struct list_head *pages)
>  {
>  	struct page *page, *next;
> +	int page_order =3D 0;
> +
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
> +		page_order =3D VIRTIO_BALLOON_THP_ORDER;
> =20
>  	list_for_each_entry_safe(page, next, pages, lru) {
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, 1);
> +			adjust_managed_page_count(page, 1 << page_order);
>  		list_del(&page->lru);
> -		put_page(page); /* balloon reference */
> +		if (page_order)
> +			__free_pages(page, page_order);
> +		else
> +			put_page(page); /* balloon reference */
>  	}
>  }
> =20
> @@ -893,19 +913,21 @@ static int virtballoon_probe(struct virtio_device=
 *vdev)
>  		goto out_free_vb;
> =20
>  #ifdef CONFIG_BALLOON_COMPACTION
> -	balloon_mnt =3D kern_mount(&balloon_fs);
> -	if (IS_ERR(balloon_mnt)) {
> -		err =3D PTR_ERR(balloon_mnt);
> -		goto out_del_vqs;
> -	}
> +	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_THP_ORDER)) {
> +		balloon_mnt =3D kern_mount(&balloon_fs);
> +		if (IS_ERR(balloon_mnt)) {
> +			err =3D PTR_ERR(balloon_mnt);
> +			goto out_del_vqs;
> +		}
> =20
> -	vb->vb_dev_info.migratepage =3D virtballoon_migratepage;
> -	vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
> -	if (IS_ERR(vb->vb_dev_info.inode)) {
> -		err =3D PTR_ERR(vb->vb_dev_info.inode);
> -		goto out_kern_unmount;
> +		vb->vb_dev_info.migratepage =3D virtballoon_migratepage;
> +		vb->vb_dev_info.inode =3D alloc_anon_inode(balloon_mnt->mnt_sb);
> +		if (IS_ERR(vb->vb_dev_info.inode)) {
> +			err =3D PTR_ERR(vb->vb_dev_info.inode);
> +			goto out_kern_unmount;
> +		}
> +		vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
>  	}
> -	vb->vb_dev_info.inode->i_mapping->a_ops =3D &balloon_aops;
>  #endif
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>  		/*
> @@ -1058,6 +1080,7 @@ static unsigned int features[] =3D {
>  	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
> +	VIRTIO_BALLOON_F_THP_ORDER,
>  };
> =20
>  static struct virtio_driver virtio_balloon_driver =3D {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon=
_compaction.h
> index 338aa27..4c9164e 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -100,8 +100,12 @@ static inline void balloon_page_insert(struct ball=
oon_dev_info *balloon,
>  				       struct page *page)
>  {
>  	__SetPageOffline(page);
> -	__SetPageMovable(page, balloon->inode->i_mapping);
> -	set_page_private(page, (unsigned long)balloon);
> +	if (balloon->inode) {
> +		__SetPageMovable(page, balloon->inode->i_mapping);
> +		set_page_private(page, (unsigned long)balloon);
> +	} else {
> +		set_page_private(page, 0);
> +	}
>  	list_add(&page->lru, &balloon->pages);
>  }
> =20
> @@ -116,8 +120,10 @@ static inline void balloon_page_insert(struct ball=
oon_dev_info *balloon,
>  static inline void balloon_page_delete(struct page *page)
>  {
>  	__ClearPageOffline(page);
> -	__ClearPageMovable(page);
> -	set_page_private(page, 0);
> +	if (page_private(page)) {
> +		__ClearPageMovable(page);
> +		set_page_private(page, 0);
> +	}
>  	/*
>  	 * No touch page.lru field once @page has been isolated
>  	 * because VM is using the field.
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/v=
irtio_balloon.h
> index a1966cd7..a2998a9 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -36,10 +36,14 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages *=
/
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisonin=
g */
> +#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Balloon page order to thp orde=
r */
> =20
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> =20
> +/* The order of the balloon page */
> +#define VIRTIO_BALLOON_THP_ORDER 9
> +
>  #define VIRTIO_BALLOON_CMD_ID_STOP	0
>  #define VIRTIO_BALLOON_CMD_ID_DONE	1
>  struct virtio_balloon_config {
>=20


--=20
Thanks,

David / dhildenb
