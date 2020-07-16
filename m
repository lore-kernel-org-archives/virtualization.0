From: teawater <teawaterz@linux.alibaba.com>
Subject: Re: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
Date: Thu, 16 Jul 2020 16:25:00 +0800
Message-ID: <CEB4BCB7-E146-4F62-A8AC-8641B5469963@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-2-git-send-email-teawater@gmail.com>
 <20200716024114-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <virtio-dev-return-7569-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200716024114-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:43=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 10:41:51AM +0800, Hui Zhu wrote:
>> diff --git a/include/uapi/linux/virtio_balloon.h =
b/include/uapi/linux/virtio_balloon.h
>> index dc3e656..4d0151a 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -37,6 +37,7 @@
>> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free =
pages */
>> #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page =
poisoning */
>> #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
>> +#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous =
pages */
>>=20
>> /* Size of a PFN in the balloon interface. */
>> #define VIRTIO_BALLOON_PFN_SHIFT 12
>=20
> So how does the guest/host interface look like?
> Could you write up something about it?

Continuous pages are report by num_pfns and pfns in virtio_balloon too.
The function to set pfns is set_page_pfns_size in =
https://github.com/teawater/linux/blob/balloon_conts/drivers/virtio/virtio=
_balloon.c#L221

static void set_page_pfns_size(struct virtio_balloon *vb,
                               __virtio32 pfns[], struct page *page,
                               size_t size)
{
        /* Set the first pfn of the continuous pages.  */
        pfns[0] =3D cpu_to_virtio32(vb->vdev, =
page_to_balloon_pfn(page));
        /* Set the size of the continuous pages.  */
        pfns[1] =3D (__virtio32) size;
}

Each of continuous pages need 2 pfn.
The first pfn of the pages is set to pfns[0].  The size of the pages is =
set to pfns[1].

The pfn is 32 bits.
So the max order of inflate continuous pages is =
VIRTIO_BALLOON_INFLATE_MAX_ORDER.
#define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * =
BITS_PER_BYTE - \
                                                    1 - PAGE_SHIFT), =
(MAX_ORDER-1))

The max page number of deflate continuous pages is =
VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM.
#define VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM (((__virtio32)~0U) >> =
PAGE_SHIFT)

Best,
Hui=
