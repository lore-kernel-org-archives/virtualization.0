From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH for QEMU v2] virtio-balloon: Add option cont-pages to set VIRTIO_BALLOON_VQ_INFLATE_CONT
Date: Thu, 26 Mar 2020 08:20:12 +0100
Message-ID: <B47DD070-AB50-4A43-BE7E-D4F17921891F@redhat.com>
References: <575FA585-343A-4246-830B-C1CB3153B7E0@linux.alibaba.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575FA585-343A-4246-830B-C1CB3153B7E0@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
To: teawater <teawaterz@linux.alibaba.com>
Cc: Hui Zhu <teawater@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, mojha@codeaurora.org, pagupta@redhat.com, aquini@redhat.com, namit@vmware.com, david@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org



> Am 26.03.2020 um 08:06 schrieb teawater <teawaterz@linux.alibaba.com>:
>=20
> =EF=BB=BFPing.
>=20

On paid leave this week. Will try to have a look next week, but it could tak=
e a bit longer.

Cheers

> Thanks,
> Hui
>=20
>> 2020=E5=B9=B43=E6=9C=8823=E6=97=A5 00:04=EF=BC=8CHui Zhu <teawater@gmail.=
com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> If the guest kernel has many fragmentation pages, use virtio_balloon
>> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
>> the balloon pages.
>> Set option cont-pages to on will open flags VIRTIO_BALLOON_VQ_INFLATE_CON=
T
>> and set continuous pages order to THP order.
>> Then It will get continuous pages PFN from VQ icvq use use madvise
>> MADV_DONTNEED release the THP page.
>> This will handle the THP split issue.
>>=20
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>> hw/virtio/virtio-balloon.c                      | 32 ++++++++++++++++++++=
+----
>> include/hw/virtio/virtio-balloon.h              |  4 +++-
>> include/standard-headers/linux/virtio_balloon.h |  4 ++++
>> 3 files changed, 35 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index a4729f7..88bdaca 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -34,6 +34,7 @@
>> #include "hw/virtio/virtio-access.h"
>>=20
>> #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>> +#define CONT_PAGES_ORDER   9
>>=20
>> typedef struct PartiallyBalloonedPage {
>>    ram_addr_t base_gpa;
>> @@ -65,7 +66,8 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloon=
edPage *pbp,
>>=20
>> static void balloon_inflate_page(VirtIOBalloon *balloon,
>>                                 MemoryRegion *mr, hwaddr mr_offset,
>> -                                 PartiallyBalloonedPage *pbp)
>> +                                 PartiallyBalloonedPage *pbp,=20
>> +                                 bool is_cont_pages)
>> {
>>    void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>>    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
>> @@ -76,6 +78,13 @@ static void balloon_inflate_page(VirtIOBalloon *balloo=
n,
>>    /* XXX is there a better way to get to the RAMBlock than via a
>>     * host address? */
>>    rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
>> +
>> +    if (is_cont_pages) {
>> +        ram_block_discard_range(rb, rb_offset,
>> +                                BALLOON_PAGE_SIZE << CONT_PAGES_ORDER);
>> +        return;
>> +    }
>> +
>>    rb_page_size =3D qemu_ram_pagesize(rb);
>>=20
>>    if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
>> @@ -361,9 +370,10 @@ static void virtio_balloon_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
>>            trace_virtio_balloon_handle_output(memory_region_name(section.=
mr),
>>                                               pa);
>>            if (!qemu_balloon_is_inhibited()) {
>> -                if (vq =3D=3D s->ivq) {
>> +                if (vq =3D=3D s->ivq || vq =3D=3D s->icvq) {
>>                    balloon_inflate_page(s, section.mr,
>> -                                         section.offset_within_region, &=
pbp);
>> +                                         section.offset_within_region, &=
pbp,
>> +                                         vq =3D=3D s->icvq);
>>                } else if (vq =3D=3D s->dvq) {
>>                    balloon_deflate_page(s, section.mr, section.offset_wit=
hin_region);
>>                } else {
>> @@ -618,9 +628,12 @@ static size_t virtio_balloon_config_size(VirtIOBallo=
on *s)
>>    if (s->qemu_4_0_config_size) {
>>        return sizeof(struct virtio_balloon_config);
>>    }
>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
>> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
>>        return sizeof(struct virtio_balloon_config);
>>    }
>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
>> +        return offsetof(struct virtio_balloon_config, pages_order);
>> +    }
>>    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>        return offsetof(struct virtio_balloon_config, poison_val);
>>    }
>> @@ -646,6 +659,10 @@ static void virtio_balloon_get_config(VirtIODevice *=
vdev, uint8_t *config_data)
>>                       cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>>    }
>>=20
>> +    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAG=
ES)) {
>> +        config.pages_order =3D cpu_to_le32(CONT_PAGES_ORDER);
>> +    }
>> +
>>    trace_virtio_balloon_get_config(config.num_pages, config.actual);
>>    memcpy(config_data, &config, virtio_balloon_config_size(dev));
>> }
>> @@ -816,6 +833,11 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>>            virtio_error(vdev, "iothread is missing");
>>        }
>>    }
>> +
>> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
>> +        s->icvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_ou=
tput);
>> +    }
>> +
>>    reset_stats(s);
>> }
>>=20
>> @@ -916,6 +938,8 @@ static Property virtio_balloon_properties[] =3D {
>>                    VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>>    DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>>                    VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>> +    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
>> +                    VIRTIO_BALLOON_F_CONT_PAGES, false),
>>    /* QEMU 4.0 accidentally changed the config size even when free-page-h=
int
>>     * is disabled, resulting in QEMU 3.1 migration incompatibility.  This=

>>     * property retains this quirk for QEMU 4.1 machine types.
>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
>> index d1c968d..61d2419 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>>=20
>> typedef struct VirtIOBalloon {
>>    VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>>    uint32_t free_page_report_status;
>>    uint32_t num_pages;
>>    uint32_t actual;
>> @@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
>>    uint32_t host_features;
>>=20
>>    bool qemu_4_0_config_size;
>> +
>> +    uint32_t pages_order;
>> } VirtIOBalloon;
>>=20
>> #endif
>> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/st=
andard-headers/linux/virtio_balloon.h
>> index 9375ca2..ee18be7 100644
>> --- a/include/standard-headers/linux/virtio_balloon.h
>> +++ b/include/standard-headers/linux/virtio_balloon.h
>> @@ -36,6 +36,8 @@
>> #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM    2 /* Deflate balloon on OOM */=

>> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT    3 /* VQ to report free pages *=
/
>> #define VIRTIO_BALLOON_F_PAGE_POISON    4 /* Guest is using page poisonin=
g */
>> +#define VIRTIO_BALLOON_F_CONT_PAGES    5 /* VQ to report continuous page=
s */
>> +
>>=20
>> /* Size of a PFN in the balloon interface. */
>> #define VIRTIO_BALLOON_PFN_SHIFT 12
>> @@ -51,6 +53,8 @@ struct virtio_balloon_config {
>>    uint32_t free_page_report_cmd_id;
>>    /* Stores PAGE_POISON if page poisoning is in use */
>>    uint32_t poison_val;
>> +    /* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
>> +    uint32_t pages_order;
>> };
>>=20
>> #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
>> --=20
>> 2.7.4
>>=20
>=20
