Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213413;
	b=ztXgjn33Yu2t/hNxVhguWsDHNVFpvIpAwlaylvWN3uIgXbaT311M+AlbkSPNLmsv7kuz
	 +IE5Gef4reZ5ab5UREfwYr6PkKIudiSXR3cCc1gYbKvqPcokN2wTFEBJ5Az3ljUKutsvD
	 lCKh8g0MMw/oa0an6Sk6BACZLaeUPp75mxoY+Pnb4Kf+E1QUlbAlwd28xtXLetV1LShqL
	 4jdCPh6AQm9H8WQmhVV9Lw+VdEbPA1Z9IXyzeVhDZSISMUwv+fbpNg+8H1V4A2lJtbjHj
	 pMnn/v1pLM5kNIf0+YDb8BQaePakOJD+6YRgtzJJSquhuvhxDEUcpfOdii8sWp9rPuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+iKqDabG33UXDvji/dCrtjNC9lWMOkzIVMwPcSG5sMQ=;
	b=XjWKPokiUMRyXi1nRU+tLeRuII66zcWcG3qJonbANivFrpCKf3XOqvOKLsPat8C1atpb
	 17h3nurnlgJurpvowH+zy+KeW1YS58PMqKXCcjctxosYMEexHuf9UV5kMwRWlNCr5wto4
	 FAZFw50ZjQCLB3B4KIH4+dCLH2T+prv5QWZPPuQ/xyfnad3OcvOd8VSw20yKCRsXKD4aB
	 ednhfSOISJps1aujfvtaMkriy3aSr4vIpxE9Yrwfsu/F89/zl0QVIpPccJui7FkwihRwB
	 ejHlODz8C5cLwLKFlKusu9IfjQwwHzIy696bBCThQztYlxrXS/npajZ2hM5if5PDCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGzPrQJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE67606A33D
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGzPrQJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EB51F000C6;
	Fri, 20 Nov 2026 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795213412;
	bh=+iKqDabG33UXDvji/dCrtjNC9lWMOkzIVMwPcSG5sMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGzPrQJ0BXfPRevachtMlkg1US0Z6ZKP2r4tuKZqnB6LqCyjEeFxErkvag6pJ3NZi
	 acwix5l1xTCZvGePpaacMckClw1izdp8VlNDcUnyCKMSQ0VvUo4zw9tYernjGlSHm2
	 yL19vLM58aRIJCaUvqd9JU9cRD7r0zqp1XM8y/LAchaTmpYFqzxjGDeGhzWrLOVOpP
	 4XlcVYDrDJ4EPQz+hZ+3bTP8q1pMr7QOvy2RG3BcskupdjH+TNarBrQ1E9jhAQNiN9
	 XbtsR1jzq5mzeiBopaQLFaSVP/HcQ4pDqqrR1SkddXsQhVd0Dq9JUTPD6HR+dQB5XT
	 5g7DlYgifmoKQ==
Message-ID: <sashiko-outbox-226255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/6] media: virtio: Add extended controls support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261120215916.3149345-4-briandaniels@google.com>
References: <20261120215916.3149345-1-briandaniels@google.com>
 <20261120215916.3149345-4-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:23:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 15 potential
issues to consider:
- [High] media: virtio: framevecs array leak in
  scatterlist_builder_free_framevecs()
- [High] media: virtio: pinned page and framevec leak on error in
  virtio_media_send_ext_controls_ioctl()
- [High] media: virtio: unchecked and unrestored ctrls->count in
  virtio_media_send_ext_controls_ioctl()
- [High] media: virtio: sgs index passed as desc_index in
  virtio_media_send_ext_controls_ioctl()
- [High] media: virtio: stack buffers mapped for DMA in
  scatterlist_builder_add_data()
- [Medium] media: virtio: missing return on framevec exhaustion in
  __scatterlist_builder_add_userptr()
- [Medium] media: virtio: unpinned writable user pages not marked dirty
  in scatterlist_builder_free_framevecs()
- [Medium] media: virtio: __scatterlist_builder_add_userptr() converts
  -EFAULT to -EINVAL for control pointers
- [Medium] media: virtio: gfp_mask =3D 0 passed to
  sg_alloc_table_from_pages() in __scatterlist_builder_add_userptr()
- [Medium] media: virtio: builder->framevecs leak in
  scatterlist_builder_free_framevecs()
- [Medium] media: virtio: missing return on framevec overflow in
  __scatterlist_builder_add_userptr()
- [Low] media: virtio: duplicate shadow buffer copy in
  scatterlist_builder_add_userptr()
- [Low] media: virtio: missing endian conversions on
  virtio_media_sg_entry and kernel-doc mismatch
- [Low] media: virtio: kernel-doc and num_framevecs init mismatch in
  scatterlist_builder
- [Low] media: virtio: missing cpu_to_le64()/cpu_to_le32() in
  __scatterlist_builder_add_userptr()
--

commit 4bce5e6699b198a30ba3d3b14cac75e70807d014
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add extended controls support

This commit adds V4L2 extended control ioctl handlers (VIDIOC_G_EXT_CTRLS,
VIDIOC_S_EXT_CTRLS, and VIDIOC_TRY_EXT_CTRLS) to virtio-media, along with
scatterlist builder helpers to pin userspace control payloads and pass their
physical segments to the host via the session shadow buffer.

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c, inside
__scatterlist_builder_add_userptr() (lines 264-268), does the capacity check
on builder->cur_framevec >=3D builder->num_framevecs forget to return after
setting ret =3D -ENOMEM? Execution continues to sg_alloc_table_from_pages(),
which overwrites ret, and then writes past the end of builder->framevecs at
line 316 (or dereferences NULL). In addition,
scatterlist_builder_allocate_framevecs() (line 407) resets
builder->cur_framevec =3D 0 without resetting builder->num_framevecs =3D 0 =
before
accumulating the count.

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c, at lines 264-268 of
__scatterlist_builder_add_userptr(), should the builder->cur_framevec >=3D
builder->num_framevecs branch return -ENOMEM immediately instead of falling
through to pin pages and write out of bounds to
builder->framevecs[builder->cur_framevec++] at line 316?

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c, inside
__scatterlist_builder_add_userptr() (lines 271-279), why is -EFAULT from
vb2_create_framevec() converted into -EINVAL? The V4L2 extended control ioc=
tls
(and the function's own kernel-doc comment at line 243) require -EFAULT whe=
n a
control payload pointer references an invalid userspace address.

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c, inside
__scatterlist_builder_add_userptr() (lines 289-290), should
sg_alloc_table_from_pages() use GFP_KERNEL instead of 0 for its gfp_mask?
This path runs in sleepable ioctl process context right after GFP_KERNEL
allocations, and passing 0 disables direct reclaim, kswapd reclaim, IO, and=
 FS
operations, which can cause spurious -ENOMEM failures under memory pressure.

[Severity: Low]
In drivers/media/virtio/scatterlist_builder.c, inside
__scatterlist_builder_add_userptr() (lines 311-312), sg_entry->start and
sg_entry->len are declared as __le64 and __le32 in struct
virtio_media_sg_entry (include/uapi/linux/virtio_media.h, lines 168-172), so
assigning sg_phys(sg_iter) and sg_iter->length without cpu_to_le64() and
cpu_to_le32() triggers Sparse endianness warnings. Also, struct
scatterlist_builder in drivers/media/virtio/scatterlist_builder.h (lines
28-32 and 78-80) is missing a @num_framevecs kernel-doc entry.

[Severity: Low]
In drivers/media/virtio/scatterlist_builder.c, inside
__scatterlist_builder_add_userptr() (lines 305-306), sg_list is already
allocated inside builder->shadow_buffer, yet scatterlist_builder_add_userpt=
r()
(lines 351-352) passes sg_list to scatterlist_builder_add_data(). When
always_use_shadow_buffer is enabled, scatterlist_builder_add_data() copies
sg_list into builder->shadow_buffer a second time and consumes double the
shadow buffer space.

[Severity: High]
In drivers/media/virtio/scatterlist_builder.c, when
scatterlist_builder_add_ext_ctrls() (lines 374-385) passes ctrls and
ctrls->controls to scatterlist_builder_add_data() (lines 67-118), can this =
map
kernel stack memory directly for DMA? Both video_usercopy() (which places
struct v4l2_ext_controls in its stack buffer sbuf) and v4l_g_ctrl() /
v4l_s_ctrl() (which allocate struct v4l2_ext_controls and struct
v4l2_ext_control on the stack) pass stack addresses here. Because stack
addresses satisfy virt_addr_valid() when CONFIG_VMAP_STACK=3Dn and
is_vmalloc_addr() when CONFIG_VMAP_STACK=3Dy, scatterlist_builder_add_data()
maps the stack pages directly into virtqueue scatterlists instead of bounci=
ng
them through builder->shadow_buffer, violating the DMA API.

[Severity: Low]
In drivers/media/virtio/scatterlist_builder.h (lines 28-32 and 78-80), the
kernel-doc comment for struct scatterlist_builder omits @num_framevecs and
names scatterlist_builder_add_ext_ctrls_userptrs() and
scatterlist_builder_retrieve_ext_ctrls() instead of
scatterlist_builder_allocate_framevecs() and
scatterlist_builder_free_framevecs(). In
drivers/media/virtio/scatterlist_builder.c, the kernel-doc for
__scatterlist_builder_add_userptr() (line 243) also documents returning
-EFAULT on an invalid userptr while line 277 rewrites it to -EINVAL, and
scatterlist_builder_allocate_framevecs() (line 407) resets
builder->cur_framevec =3D 0 without initializing builder->num_framevecs =3D=
 0.

[Severity: High]
In drivers/media/virtio/scatterlist_builder.c, does
scatterlist_builder_free_framevecs() (lines 439-448) leak builder->framevecs
when builder->cur_framevec is 0? scatterlist_builder_allocate_framevecs()
(lines 417-418) allocates builder->framevecs whenever at least one control =
has
ctrl->size > 0, so if an error occurs before the first framevec is recorded
(for example, vb2_create_framevec() fails on the first control pointer),
kfree(builder->framevecs) is skipped and builder->framevecs is set to NULL.

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c, inside
scatterlist_builder_free_framevecs() (lines 439-448), kfree(builder->framev=
ecs)
is guarded by builder->cur_framevec, so failing before the first framevec is
added leaks the builder->framevecs array.

[Severity: Medium]
In drivers/media/virtio/scatterlist_builder.c,
__scatterlist_builder_add_userptr() (line 270) pins user control payload pa=
ges
as writable via vb2_create_framevec(userptr, length, true), but
scatterlist_builder_free_framevecs() (lines 442-445) unpins them with
vb2_destroy_framevec() without marking them dirty first. Should it call
set_page_dirty_lock() on the frame_vector_pages() before destroying the
framevec, as the videobuf2 memops backends do, so host writes to reclaimable
or file-backed user pages are not lost?

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c, inside
virtio_media_send_ext_controls_ioctl() (lines 281 and 295-299), end_ctrls_sg
is saved from builder.cur_sg (an index into builder.sgs[]), but the response
loop passes i to scatterlist_builder_add_descriptor(&builder, i), which
indexes builder.descs[i] (drivers/media/virtio/scatterlist_builder.c, line
41). If a precedingvmalloc buffer spans multiple non-contiguous physical
pages, scatterlist_builder_add_data() uses multiple builder.descs[] entries
for a single builder.sgs[] entry, causing the response chain to point at the
wrong descriptors.

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c, inside
virtio_media_send_ext_controls_ioctl(), do the early error returns at lines
313-314 (return -ENOSPC when ctrls->count > num_ctrls) and lines 337-338
(return -EINVAL when resp_len < sizeof(*ctrls)) bypass the free_framevecs
label? Returning directly leaks builder.framevecs and all struct frame_vect=
or
instances and leaves the userspace payload pages permanently pinned.

[Severity: High]
In drivers/media/virtio/virtio_media_ioctls.c, inside
virtio_media_send_ext_controls_ioctl() (lines 308-341), ctrls->count is
checked against num_ctrls before scatterlist_builder_retrieve_ext_ctrls()
copies the shadow buffer response back into ctrls, and ctrls->count is not
restored to num_ctrls when the device returns ctrls->count > num_ctrls. When
the shadow buffer is used, scatterlist_builder_retrieve_ext_ctrls()
(drivers/media/virtio/scatterlist_builder.c, lines 509-523) overwrites
ctrls->count with the unvalidated value from the shadow buffer after the
check; and because extended control ioctls set INFO_FL_ALWAYS_COPY, leaving
ctrls->count > num_ctrls on return causes v4l2_compat_put_array_args() and
v4l_print_ext_controls() to read past the end of the kernel controls array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120215916.3149=
345-1-briandaniels@google.com?part=3D3
