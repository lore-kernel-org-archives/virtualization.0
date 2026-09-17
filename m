Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E34B7A39
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668313; cv=none; b=P5kmDmDDnXO1+dMn37WTlnmtDElMlY/QTq3BzG78QeH2gEdJoyszrVBGSINVVz0dAqeOa8exhRktn1ZDwePzHmhOltW+bqAM0zW5ztCSkW9bPKK0JDZeg7i2Z+DgUbFIMJl2fWk4Tys4svn/ga1AQtkM8aovFbPAkF0vsYJI7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668313; c=relaxed/simple;
	bh=kf0jGc6CTouXIrzPjKNqmwa96cKrAHXGeGh9eknlGtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3GGTmjWKSOnaRwLYv00CZgCxFPP9m0svS2Mp7Vgv23aiLe4VVRCz3ME1zxS3B2DdnWd2M6SqLPTb0D7nSZbtVUR6fwUp7KFThawGzSinB6mAErvVo7MwNL0ibmY/fNJQYN2qP8d6GsfZQ5SGU+E8kNUneILHsU5sAK9vj2xqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAmT4tnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAmT4tnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6421A1F000FF;
	Thu, 17 Sep 2026 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668311;
	bh=fDzt+OVenJS5vtDuk/fGdr2ZOgV8PiMBi7mDJANfMDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAmT4tnEKfZS3BTU3PsWsPQob+3bDid90Xqf0jBPsv4K+QLVX5nfHsIcK+KTw/Hj8
	 rJdc+MaumcVZ83BVUX9mDQ5gIT+0xH2TcLZr6bUkT515lpomuhy34MyewK2gf3SVZk
	 iOh8FXiXGKnTdSXOfL6pxohFuKwyOKgr+BVdOmQIe+5V6wyBFYEd4cmlMaobiXLkk1
	 xPXDRgO7zp3rw+dwzIGf7QymI983fgYSb9ysa6hDRZG1yGW6uzQVJjxGjy1JGUEpHf
	 nKUojyjahRAjp34q2QzJs9AgXJsQ9qihfBLeOxDtia9YbUnB9K8C8y3nfswztOrcIL
	 F32WEbOl2RpaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] media: virtio: Add scatterlist builder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, media-ci@linuxtv.org
In-Reply-To: <20260917171921.2810550-4-briandaniels@google.com>
References: <20260917171921.2810550-1-briandaniels@google.com>
 <20260917171921.2810550-4-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 18:05:10 +0000
Message-Id: <20260917180511.6421A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] virtio-media: premature unpinning of user memory enables DMA c=
orruption
- [High] virtio-media: PFN truncation causes contiguity logic flaws and out=
-of-bounds access
- [High] virtio-media: host-modified array sizes leak kernel memory to user=
space
- [High] virtio-media: arbitrary length additions unalign shadow buffer acc=
esses
- [High] virtio-media: untrusted b->type modification causes NULL pointer d=
eref
- [High] virtio-media: bypassing DMA API for userptrs breaks IOMMU
- [High] virtio-media: unsafe use of pfn_to_kaddr() on HIGHMEM pages
- [Medium] virtio-media: native endian values assigned to little-endian vir=
tio fields
- [Medium] virtio-media: virt_addr_valid() checks wrong buffer boundary
- [Medium] virtio-media: off-by-one check rejects exact-fit shadow buffer r=
eads
- [Medium] virtio-media: uninitialized __reserved field leaks shadow buffer=
 memory
- [Low] virtio-media: hardcoded macro shadows dynamic builder buffer size
--

commit 4dd8f3c6017ed958f6f6c62e6f9831a3dfd4ee1d
Author: Alexandre Courbot <gnurou@gmail.com>
Date:   Thu Sep 17 17:19:19 2026 +0000

    media: virtio: Add scatterlist builder

This commit adds a scatterlist builder utility to construct scatterlists for
virtio commands from V4L2 structures.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> index 0000000000000..97925b2771aea
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.c

[ ... ]

> @@ -56,515 +56,515 @@ int scatterlist_builder_add_data(struct scatterlist=
_builder *builder,
> +	const size_t cur_desc =3D builder->cur_desc;
> +
> +	if (len =3D=3D 0)
> +		return 0;
> +
> +	if (builder->cur_desc >=3D builder->num_descs)
> +		return -ENOSPC;
> +
> +	if (!always_use_shadow_buffer && virt_addr_valid(data + len)) {

[Severity: Medium]
Does `virt_addr_valid()` validate the end of the buffer here? Should we
be checking the start address `data` instead, to ensure `virt_to_page(data)`
doesn't receive an invalid pointer?

> +		/*
> +		 * If "data" is in the 1:1 physical memory mapping then we can
> +		 * use a single SG entry and avoid copying.
> +		 */
> +		struct page *page =3D virt_to_page(data);

[ ... ]

> +	} else if (!always_use_shadow_buffer && is_vmalloc_addr(data)) {
> +		int prev_pfn =3D -2;
> +
> +		/*
> +		 * If "data" has been vmalloc'ed, we need at most one entry per
> +		 * memory page but can avoid copying.
> +		 */
> +		while (len > 0) {
> +			struct page *page =3D vmalloc_to_page(data);
> +			int cur_pfn =3D page_to_pfn(page);

[Severity: High]
Since `page_to_pfn()` returns an `unsigned long`, could storing it in
`int cur_pfn` truncate the value on systems with sparse maps or where
physical memory exceeds 16TB?

If truncation occurs and the first page truncates to `-1`, it satisfies
`cur_pfn =3D=3D prev_pfn + 1`. Would this bypass the descriptor allocation
and cause an out-of-bounds array write to `(next_desc - 1)->length` while
`builder->cur_desc` is `0`?

[ ... ]

> +	} else {
> +		/*
> +		 * As a last resort, copy into the shadow buffer and reference
> +		 * it with a single SG entry. Calling
> +		 * scatterlist_builder_retrieve_data() will be necessary to copy
> +		 * the data written by the device back into @data.
> +		 */
> +		void *shadow_buffer =3D
> +			builder->shadow_buffer + builder->shadow_buffer_pos;
> +		struct page *page =3D virt_to_page(shadow_buffer);
> +		unsigned long offset =3D
> +			(((unsigned long)shadow_buffer) & ~PAGE_MASK);
> +		struct scatterlist *next_desc =3D
> +			&builder->descs[builder->cur_desc];
> +
> +		if (len >
> +		    builder->shadow_buffer_size - builder->shadow_buffer_pos)
> +			return -ENOSPC;
> +
> +		memcpy(shadow_buffer, data, len);
> +		memset(next_desc, 0, sizeof(*next_desc));
> +		sg_set_page(next_desc, page, len, offset);
> +		builder->cur_desc++;
> +		builder->shadow_buffer_pos +=3D len;

[Severity: High]
Since `len` can be an arbitrary size (e.g., from `v4l2_ext_control` arrays),
could this leave `shadow_buffer_pos` unaligned?=20

Later allocations of `struct virtio_media_sg_entry` arrays at this offset
might result in unaligned memory writes, which could trigger kernel panics
on architectures enforcing strict alignment.

[ ... ]

> +int scatterlist_builder_retrieve_data(struct scatterlist_builder *builde=
r,
> +				      size_t sg_index, void *data)
> +{
> +	void *shadow_buf =3D builder->shadow_buffer;
> +	struct scatterlist *sg;
> +	void *kaddr;
> +
> +	/* We can only retrieve from the range of sgs currently set. */
> +	if (sg_index >=3D builder->cur_sg)
> +		return -ERANGE;
> +
> +	sg =3D builder->sgs[sg_index];
> +	kaddr =3D pfn_to_kaddr(page_to_pfn(sg_page(sg))) + sg->offset;

[Severity: High]
If the scatterlist contains user pages (like those from
`vb2_create_framevec()`), they might reside in HIGHMEM on 32-bit platforms.

Does calling `pfn_to_kaddr()` on a HIGHMEM page without a direct linear
virtual mapping pose a risk of memory corruption or triggering a BUG/WARN
with `CONFIG_DEBUG_VIRTUAL`?

> +
> +	if (kaddr >=3D shadow_buf &&
> +	    kaddr < shadow_buf + VIRTIO_SHADOW_BUF_SIZE) {

[Severity: Low]
The `builder` struct tracks its buffer size dynamically in
`shadow_buffer_size`.=20

By using the hardcoded `VIRTIO_SHADOW_BUF_SIZE` macro here, might this
incorrectly reject valid reads or allow out-of-bounds access if the
builder is instantiated with a custom size?

> +		if (kaddr + sg->length >=3D shadow_buf + VIRTIO_SHADOW_BUF_SIZE)
> +			return -EINVAL;

[Severity: Medium]
The `>=3D` operator appears to reject retrievals that fit exactly into the
shadow buffer. If `kaddr + sg->length` perfectly aligns with the end of
the buffer, shouldn't this be considered a valid scenario rather than
returning `-EINVAL`?

[ ... ]

> +int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builde=
r,
> +				      struct virtio_media_session *session,
> +				      u32 ioctl_code)
> +{
> +	struct virtio_media_cmd_ioctl *cmd_ioctl =3D &session->cmd.ioctl;
> +
> +	cmd_ioctl->hdr.cmd =3D VIRTIO_MEDIA_CMD_IOCTL;
> +	cmd_ioctl->session_id =3D session->id;
> +	cmd_ioctl->code =3D VIRTIO_MEDIA_IOCTL_CODE(ioctl_code);

[Severity: Medium]
The virtio specification requires structures passed between guest and host
to be little-endian.=20

Since `cmd_ioctl->session_id` and `cmd_ioctl->code` are `__le32` fields,
shouldn't we use `cpu_to_le32()` conversions here to prevent endianness
mismatches on big-endian guests?

[ ... ]

> +static int
> +__scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
> +				  unsigned long userptr, unsigned long length,
> +				  struct virtio_media_sg_entry **sg_list,
> +				  int *nents)
> +{

[ ... ]

> +	/* Allocate our actual SG in the shadow buffer. */
> +	*nents =3D sg_nents(sg_table.sgl);
> +	entries_size =3D sizeof(**sg_list) * *nents;
> +	if (builder->shadow_buffer_pos + entries_size >
> +	    builder->shadow_buffer_size) {
> +		ret =3D -ENOMEM;
> +		goto free_sg;
> +	}
> +
> +	*sg_list =3D builder->shadow_buffer + builder->shadow_buffer_pos;

[Severity: High]
As mentioned earlier, if `shadow_buffer_pos` was advanced by an unaligned
length, this `sg_list` array will be placed at an unaligned offset.

> +	builder->shadow_buffer_pos +=3D entries_size;
> +
> +	for_each_sgtable_sg(&sg_table, sg_iter, i) {
> +		struct virtio_media_sg_entry *sg_entry =3D &(*sg_list)[i];
> +
> +		sg_entry->start =3D sg_phys(sg_iter);
> +		sg_entry->len =3D sg_iter->length;
> +	}

[Severity: High]
`sg_phys()` returns a raw CPU physical address, which bypasses the DMA API
(such as `dma_map_sg()`). On platforms where the virtio device sits behind
an IOMMU, will the host device attempt to use raw physical addresses
instead of IOVAs, causing IOMMU faults?

[Severity: Medium]
Similar to the ioctl cmd structure, `sg_entry->start` and `sg_entry->len`
are `__le64` and `__le32` fields. Should these native values be converted
using `cpu_to_le64()` and `cpu_to_le32()`?

[Severity: Medium]
Does leaving the `__reserved` field of the `sg_entry` structure
uninitialized risk leaking stale shadow buffer contents to the host
device?

> +
> +free_sg:
> +	sg_free_table(&sg_table);
> +
> +done:
> +	vb2_destroy_framevec(framevec);
> +	return ret;
> +}

[Severity: Critical]
`vb2_destroy_framevec()` unpins the user pages before the virtio command
is actually sent to the host.=20

Because the pages are unpinned before DMA occurs, could the guest kernel
reassign these pages to another process, potentially allowing the host
device to corrupt arbitrary memory?

[ ... ]

> +int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *buil=
der,
> +					size_t sg_index, struct v4l2_buffer *b,
> +					struct v4l2_plane *orig_planes)
> +{
> +	int ret;
> +
> +	ret =3D scatterlist_builder_retrieve_data(builder, sg_index++, b);
> +	if (ret)
> +		return ret;

[Severity: High]
The device response directly overwrites `b`, including its `length` field.=
=20

If an untrusted host maliciously inflates `b->length` (the number of planes=
),
could this cause `copy_to_user()` in the V4L2 core to read past the end
of the allocated kernel buffers, leaking adjacent kernel memory to userspac=
e?

> +
> +	if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
> +		b->m.planes =3D orig_planes;

[Severity: High]
Because `b->type` is also overwritten by the host, it can be changed from
single-planar to multi-planar.=20

In the single-planar case, `orig_planes` is initialized as `NULL`. Would
modifying the type trick the driver into setting `b->m.planes =3D NULL`,
which later causes a NULL pointer dereference (or `check_object_size` panic
under `CONFIG_HARDENED_USERCOPY`) when the V4L2 core attempts to copy it
to userspace?

[ ... ]

> +int scatterlist_builder_retrieve_ext_ctrls(struct scatterlist_builder *b=
uilder,
> +					   size_t sg_index,
> +					   struct v4l2_ext_controls *ctrls)
> +{
> +	struct v4l2_ext_control *controls_backup =3D ctrls->controls;
> +	int ret;
> +
> +	ret =3D scatterlist_builder_retrieve_data(builder, sg_index++, ctrls);

[Severity: High]
Here again, `ctrls->count` is blindly overwritten with untrusted host data.

If the host inflates `ctrls->count`, could this bypass validation checks
that occurred earlier on the original struct, leading to out-of-bounds
kernel memory leaks when `copy_to_user()` copies the controls back?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917171921.2810=
550-1-briandaniels@google.com?part=3D3
