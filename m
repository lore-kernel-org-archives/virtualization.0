Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211970;
	b=TU7LglN5BOYD2uUD8PNLvzUpK+TUZOaGCOjWBkYm9um6YC/rzjNcfea7Dwa+C2HEwzde
	 NTDb6bH3WfTdXMvsgRu0p/tRDlEcpnBsyxOU+Vj5eoUnP5dbujc/ksIgD3KW8sKoUOlQa
	 VfPUEwKzsztzBgsyH2SEqV0xF8w1sxEqBEFui0HeJOFlzpWtdC9v0uUaqK8HcArWd7JnR
	 6OV/23P4art605BHgCKRK0DESmbgd6UcfxKV6fcg62LHnkHk/keqxglVsIeLHlYt70Feo
	 Krk7XKXD1pCBp0t7BBXquqArLYyrGfYl+TJZ0nbC1kkWBocAFJpbUaCZ32qd4iy5V9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EIk/aq/W9rVwRyOwrz6inYicDcFOQZ4YndxTsNgbVuk=;
	b=FjFcKYdqnzOqx3XKluL/yFXB9wZdSeE7N0rZnsJ3zJStDP49mPFr1In1y5zqqzYbbGnl
	 cJRLNFb+Nnt4klsHg2TCmHY9BZkwGERGeQv0CmVbxNRasc/RwC5Dl/TRaBWk13D72FOBE
	 bAJRsmXI0x6V0l8ubesTWr2t0pgU8Vy8rNjJfHUrQvILiJXprrywB6H3FiJWDOsKw6Pe+
	 G2OpXViJ2yhRBstiJ8oKThLdkIIH59ENOtndnyKkMf8L97hZxUp1dhCgr5soEFTQsGfeP
	 /dzQnSYuTQjMaHstuqKiIdJVBG3dMPVBT7LX+77NjY6aTgWuXRwo7EKPohblr+AdLdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="J/opH8yS";
	arc=none smtp.remote-ip=209.85.160.197
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D789160A260E
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 21:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D789160A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J/opH8yS
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-536778a8137so25924561cf.2
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211969; x=1795816769; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIk/aq/W9rVwRyOwrz6inYicDcFOQZ4YndxTsNgbVuk=;
        b=J/opH8ySfAxH14oXyRTd1cZHSA85ak0+tpC44S/1AYkEKxkXzFF/2GkFXTBWsVgLiv
         KlxQZm24LjwMgo+ZnevlhpSVrKRDoJCwt8yCstzhokkGUuxcVJ47tHfZxJ/VRsbV/kyA
         jxkb3eU6K53r3fretRyPuY7Snz4M/ifpc2r2bRCi7X+61Z2n+taXD3vK5KvgBRhqKmux
         9NFSCFns5UYCgBjvsdklHWDzjYfkz6S/jtpxZfHxY7oaHkjJjxp05vVROpTE5IvEQpC2
         e/gp6xGd94sQ8ok/BK9M5cKynY5ihW9K9au404wTMc5I5vHbnPdho4z6PlwhNtH7cm8R
         hDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211969; x=1795816769;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIk/aq/W9rVwRyOwrz6inYicDcFOQZ4YndxTsNgbVuk=;
        b=lAsahJIkDgjQRZnjJGYLtLgJZLq0hWAHe5mflGR2LPLb3r3IQLWgPwaQLPLnUorId4
         Oeas646rQQwpuTFMEOVX+WBBPpw9ffA5njq/Aa3tYP91EZHXEmfgaYRvg1x0REmbtkoh
         a10+dNMq+KTBZ/MvO66T2yB1B3hDEiU5p6HHOfWVh3KXOuLhWndLiEaCacPtok8JikI2
         qZjHUabFrR0/dSSVdyViBDppRZVOgqKC8iO8e1udTEWeRD0MziA3L56n8xf/ZW4SvmUD
         pZ4AepI57FEJbynhNBnWF5KYZLMbZgmXHMNE8tFwsCD2UdDvfMsZDPZ7CrJBO2Lnx6yG
         7Yxg==
X-Forwarded-Encrypted: i=1; AL+hErGsI9jAx9GRucI4U4rS9RAwpPZA3w7L8OQxvGWB0fVol2/O1D2Cm1VER8p1Qfm3V1930aBhJGOAS4u1CzFgLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/hNagQSqpwYShWknm22HXpWniW22ETQ+gGS1tB10M92HHAUrP3
	q70AG2Cue4HS9J2e8nDVgEh8ZUHOuIfPWkjRWRBcskxmZ3uBVALPsG559sqJxDtO6Ivcvhd+rPO
	zjFth8VehIdXCY8VwRJ+5Cgl/UXyJ
X-Received: from qvbq39.prod.google.com ([2002:a05:6214:8627:b0:91f:a3f:7b3b])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a15:b0:55c:234b:54a2 with SMTP id d75a77b69052e-55d76a75e7amr84488521cf.62.1795211968400;
 Fri, 20 Nov 2026 13:59:28 -0800 (PST)
Date: Fri, 20 Nov 2026 16:59:13 -0500
In-Reply-To: <20261120215916.3149345-1-briandaniels@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261120215916.3149345-1-briandaniels@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120215916.3149345-4-briandaniels@google.com>
Subject: [PATCH v11 3/6] media: virtio: Add extended controls support
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	dbassey@redhat.com, laurent.pinchart@ideasonboard.com, 
	Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

Add support for VIDIOC_G_EXT_CTRLS, VIDIOC_S_EXT_CTRLS, and
VIDIOC_TRY_EXT_CTRLS.

Extended controls carry an auxiliary array of struct v4l2_ext_control
entries and may reference userspace payload buffers. Pin userspace
control payloads using vb2_create_framevec() for the duration of the
virtio command and pass their physical memory segments to the host as an
array of struct virtio_media_sg_entry descriptors in the session shadow
buffer.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: LLM
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/scatterlist_builder.c | 302 +++++++++++++++++++++
 drivers/media/virtio/scatterlist_builder.h |  27 ++
 drivers/media/virtio/virtio_media_ioctls.c | 164 +++++++++++
 include/uapi/linux/virtio_media.h          |  13 +
 4 files changed, 506 insertions(+)

diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/virtio/scatterlist_builder.c
index ae8ffee82..63d50369f 100644
--- a/drivers/media/virtio/scatterlist_builder.c
+++ b/drivers/media/virtio/scatterlist_builder.c
@@ -220,3 +220,305 @@ int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *builder,
 	return scatterlist_builder_add_data(builder, resp_ioctl,
 					    sizeof(*resp_ioctl));
 }
+
+/**
+ * __scatterlist_builder_add_userptr() - Add user pages to @builder.
+ * @builder: builder to use.
+ * @userptr: pointer to userspace memory that we want to add.
+ * @length: length of the data to add.
+ * @sg_list: output parameter. Upon success, points to the area of the shadow
+ *           buffer containing the array of SG entries to be added to the
+ *           descriptor chain.
+ * @nents: output parameter. Upon success, contains the number of entries
+ *         pointed to by @sg_list.
+ *
+ * Data referenced by userspace pointers can be potentially large and very
+ * scattered, which could overwhelm the descriptor chain if added as-is. For
+ * these, we instead build an array of &struct virtio_media_sg_entry in the
+ * shadow buffer and reference it using a single descriptor.
+ *
+ * This function is a helper to perform that. Callers should then add the
+ * descriptor to the chain properly.
+ *
+ * Returns %-EFAULT if @userptr is not a valid user address, which is a case the
+ * driver should consider as "normal" operation. All other failures signal a
+ * problem with the driver.
+ */
+static int
+__scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
+				  unsigned long userptr, unsigned long length,
+				  struct virtio_media_sg_entry **sg_list,
+				  int *nents)
+{
+	struct sg_table sg_table = {};
+	struct frame_vector *framevec;
+	struct scatterlist *sg_iter;
+	struct page **pages;
+	const unsigned int offset = userptr & ~PAGE_MASK;
+	unsigned int pages_count;
+	size_t entries_size;
+	size_t initial_cur_framevec = builder->cur_framevec;
+	int i;
+	int ret;
+
+	if (builder->cur_framevec >= builder->num_framevecs) {
+		pr_err("Ran out of framevecs (%zu/%zu)", builder->cur_framevec,
+		       builder->num_framevecs);
+		ret = -ENOMEM;
+	}
+
+	framevec = vb2_create_framevec(userptr, length, true);
+	if (IS_ERR(framevec)) {
+		if (PTR_ERR(framevec) != -EFAULT) {
+			pr_warn("error %ld creating frame vector for userptr 0x%lx, length 0x%lx\n",
+				PTR_ERR(framevec), userptr, length);
+		} else {
+			/* -EINVAL is expected in case of invalid userptr. */
+			framevec = ERR_PTR(-EINVAL);
+		}
+		return PTR_ERR(framevec);
+	}
+
+	pages = frame_vector_pages(framevec);
+	if (IS_ERR(pages)) {
+		pr_warn("error getting vector pages\n");
+		ret = PTR_ERR(pages);
+		goto free_framevec;
+	}
+	pages_count = frame_vector_count(framevec);
+	ret = sg_alloc_table_from_pages(&sg_table, pages, pages_count, offset,
+					length, 0);
+	if (ret) {
+		pr_warn("error creating sg table\n");
+		goto free_framevec;
+	}
+
+	/* Allocate our actual SG in the shadow buffer. */
+	*nents = sg_nents(sg_table.sgl);
+	entries_size = sizeof(**sg_list) * *nents;
+	if (builder->shadow_buffer_pos + entries_size >
+	    builder->shadow_buffer_size) {
+		ret = -ENOMEM;
+		goto free_sg;
+	}
+
+	*sg_list = builder->shadow_buffer + builder->shadow_buffer_pos;
+	builder->shadow_buffer_pos += entries_size;
+
+	for_each_sgtable_sg(&sg_table, sg_iter, i) {
+		struct virtio_media_sg_entry *sg_entry = &(*sg_list)[i];
+
+		sg_entry->start = sg_phys(sg_iter);
+		sg_entry->len = sg_iter->length;
+		sg_entry->__reserved = 0;
+	}
+
+	builder->framevecs[builder->cur_framevec++] = framevec;
+
+free_sg:
+	sg_free_table(&sg_table);
+free_framevec:
+	// Only destroy the framevec if we didn't save it
+	if (builder->cur_framevec == initial_cur_framevec && framevec)
+		vb2_destroy_framevec(framevec);
+	return ret;
+}
+
+/**
+ * scatterlist_builder_add_userptr() - Add a user-memory buffer using an array
+ *                                     of &struct virtio_media_sg_entry.
+ * @builder: builder to use.
+ * @userptr: pointer to userspace memory that we want to add.
+ * @length: length of the data to add.
+ *
+ * Upon success, an array of &struct virtio_media_sg_entry referencing
+ * @userptr has been built into the shadow buffer, and that array added to the
+ * descriptor chain.
+ */
+static int scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
+					   unsigned long userptr,
+					   unsigned long length)
+{
+	int ret;
+	int nents;
+	struct virtio_media_sg_entry *sg_list;
+
+	ret = __scatterlist_builder_add_userptr(builder, userptr, length,
+						&sg_list, &nents);
+	if (ret)
+		return ret;
+
+	ret = scatterlist_builder_add_data(builder, sg_list,
+					   sizeof(*sg_list) * nents);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_add_ext_ctrls() - Add a &struct v4l2_ext_controls and its
+ *                                       controls to @builder.
+ * @builder: builder to use.
+ * @ctrls: &struct v4l2_ext_controls to add.
+ *
+ * Add @ctrls and its array of &struct v4l2_ext_control to the descriptor
+ * chain.
+ */
+int scatterlist_builder_add_ext_ctrls(struct scatterlist_builder *builder,
+				      struct v4l2_ext_controls *ctrls)
+{
+	int ret;
+
+	/* v4l2_ext_controls */
+	ret = scatterlist_builder_add_data(builder, ctrls, sizeof(*ctrls));
+	if (ret)
+		return ret;
+
+	if (ctrls->count > 0) {
+		/* array of v4l2_controls */
+		ret = scatterlist_builder_add_data(builder, ctrls->controls,
+						   sizeof(ctrls->controls[0]) *
+							   ctrls->count);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_allocate_framevecs() - Allocate the pointers to store
+ *                                            framevecs during a request.
+ * @builder: builder to use.
+ * @ctrls: &struct v4l2_ext_controls from which we determine how many framevecs
+ *         are needed
+ *
+ * The framevecs are used to pin the user pages during the request. Once the
+ * request is completed, the allocated framevecs and pointers should be freed
+ * with scatterlist_builder_free_framevecs().
+ */
+int
+scatterlist_builder_allocate_framevecs(struct scatterlist_builder *builder,
+				       struct v4l2_ext_controls *ctrls)
+{
+	int i;
+
+	builder->cur_framevec = 0;
+
+	/* Count the pointers to user memory in individual controls */
+	for (i = 0; i < ctrls->count; i++) {
+		struct v4l2_ext_control *ctrl = &ctrls->controls[i];
+
+		if (ctrl->size > 0)
+			builder->num_framevecs += 1;
+	}
+
+	if (builder->num_framevecs > 0) {
+		builder->framevecs = kzalloc_objs(struct frame_vector*,
+						  builder->num_framevecs);
+		if (!builder->framevecs) {
+			builder->num_framevecs = 0;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_free_framevecs() - Free the framevecs used during a
+ *                                        request.
+ * @builder: builder to use.
+ *
+ * Frees the framevecs allocated in scatterlist_builder_allocate_framevecs().
+ */
+void
+scatterlist_builder_free_framevecs(struct scatterlist_builder *builder)
+{
+	if (builder->cur_framevec && builder->framevecs) {
+		struct frame_vector *vec;
+
+		while (builder->cur_framevec--) {
+			vec = builder->framevecs[builder->cur_framevec];
+			vb2_destroy_framevec(vec);
+		}
+
+		kfree(builder->framevecs);
+	}
+
+	builder->framevecs = NULL;
+	builder->num_framevecs = 0;
+	builder->cur_framevec = 0;
+}
+
+/**
+ * scatterlist_builder_add_ext_ctrls_userptrs() - Add the userspace payloads of
+ *                                                a &struct v4l2_ext_controls
+ *                                                to the descriptor chain.
+ * @builder: builder to use.
+ * @ctrls: &struct v4l2_ext_controls from which we want to add the
+ *         userspace payload.
+ *
+ * Add the userspace payloads of @ctrls to the descriptor chain. This is split
+ * out of scatterlist_builder_add_ext_ctrls() because we only want to add
+ * these to the device-readable part of the descriptor chain.
+ */
+int
+scatterlist_builder_add_ext_ctrls_userptrs(struct scatterlist_builder *builder,
+					   struct v4l2_ext_controls *ctrls)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ctrls->count; i++) {
+		struct v4l2_ext_control *ctrl = &ctrls->controls[i];
+
+		if (ctrl->size > 0) {
+			unsigned long uptr = (unsigned long)ctrl->ptr;
+
+			ret = scatterlist_builder_add_userptr(builder, uptr,
+							      ctrl->size);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_retrieve_ext_ctrls() - Retrieve controls written by the
+ *                                            device on the shadow buffer,
+ *                                            if needed.
+ * @builder: builder to use.
+ * @sg_index: index of the first SG entry of the controls in the builder's
+ *            descriptor chain.
+ * @ctrls: &struct v4l2_ext_controls to copy shadow buffer data into.
+ *
+ * If the shadow buffer is pointed to by @sg_index, copy its content back into
+ * @ctrls.
+ */
+int scatterlist_builder_retrieve_ext_ctrls(struct scatterlist_builder *builder,
+					   size_t sg_index,
+					   struct v4l2_ext_controls *ctrls)
+{
+	struct v4l2_ext_control *controls_backup = ctrls->controls;
+	int ret;
+
+	ret = scatterlist_builder_retrieve_data(builder, sg_index++, ctrls);
+
+	if (ret)
+		return ret;
+
+	ctrls->controls = controls_backup;
+
+	if (ctrls->count > 0 && ctrls->controls) {
+		ret = scatterlist_builder_retrieve_data(builder, sg_index++,
+							ctrls->controls);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/virtio/scatterlist_builder.h
index 044ea409a..bced1e030 100644
--- a/drivers/media/virtio/scatterlist_builder.h
+++ b/drivers/media/virtio/scatterlist_builder.h
@@ -25,6 +25,11 @@
  * @sgs: descriptor chain to eventually pass to virtio functions.
  * @num_sgs: total number of entries in @sgs.
  * @cur_sg: next entry in @sgs to be used.
+ * @framevecs: Array of *struct frame_vector that is allocated to keep user
+ *             pages pinned until after a response is received. It is allocated
+ *             in scatterlist_builder_add_ext_ctrls_userptrs() and freed in
+ *             scatterlist_builder_retrieve_ext_ctrls().
+ * @cur_framevec: next entry in @framevecs to be used.
  *
  * Virtio passes data from the driver to the device (through e.g.
  * virtqueue_add_sgs()) via a scatterlist that the device interprets as a
@@ -69,6 +74,10 @@ struct scatterlist_builder {
 	struct scatterlist **sgs;
 	size_t num_sgs;
 	size_t cur_sg;
+
+	struct frame_vector **framevecs;
+	size_t num_framevecs;
+	size_t cur_framevec;
 };
 
 int scatterlist_builder_add_descriptor(struct scatterlist_builder *builder,
@@ -87,4 +96,22 @@ int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builder,
 int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *builder,
 				       struct virtio_media_session *session);
 
+int scatterlist_builder_add_ext_ctrls(struct scatterlist_builder *builder,
+				      struct v4l2_ext_controls *ctrls);
+
+int
+scatterlist_builder_allocate_framevecs(struct scatterlist_builder *builder,
+				       struct v4l2_ext_controls *ctrls);
+
+void
+scatterlist_builder_free_framevecs(struct scatterlist_builder *builder);
+
+int
+scatterlist_builder_add_ext_ctrls_userptrs(struct scatterlist_builder *builder,
+					   struct v4l2_ext_controls *ctrls);
+
+int scatterlist_builder_retrieve_ext_ctrls(struct scatterlist_builder *builder,
+					   size_t sg_index,
+					   struct v4l2_ext_controls *ctrls);
+
 #endif // __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/virtio/virtio_media_ioctls.c
index e92032bce..d0ea743e7 100644
--- a/drivers/media/virtio/virtio_media_ioctls.c
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -41,6 +41,8 @@ static int virtio_media_send_r_ioctl(struct v4l2_fh *fh, u32 ioctl,
 		.sgs = sgs,
 		.num_sgs = ARRAY_SIZE(sgs),
 		.cur_sg = 0,
+		.framevecs = NULL,
+		.cur_framevec = 0,
 	};
 
 	/* Command descriptor */
@@ -107,6 +109,8 @@ static int virtio_media_send_w_ioctl(struct v4l2_fh *fh, u32 ioctl,
 		.sgs = sgs,
 		.num_sgs = ARRAY_SIZE(sgs),
 		.cur_sg = 0,
+		.framevecs = NULL,
+		.cur_framevec = 0,
 	};
 
 	/* Command descriptor */
@@ -171,6 +175,8 @@ static int virtio_media_send_wr_ioctl(struct v4l2_fh *fh, u32 ioctl,
 		.sgs = sgs,
 		.num_sgs = ARRAY_SIZE(sgs),
 		.cur_sg = 0,
+		.framevecs = NULL,
+		.cur_framevec = 0,
 	};
 
 	/* Command descriptor */
@@ -215,6 +221,130 @@ static int virtio_media_send_wr_ioctl(struct v4l2_fh *fh, u32 ioctl,
 	return 0;
 }
 
+/**
+ * virtio_media_send_ext_controls_ioctl() - Send an ioctl taking extended
+ * controls as parameters to the device.
+ * @fh: file handler of the session doing the ioctl.
+ * @ioctl: ``VIDIOC_*`` ioctl code.
+ * @ctrls: &struct v4l2_ext_controls to be sent as the ioctl payload.
+ *
+ * Queues an ioctl that sends a &struct v4l2_ext_controls to the host and
+ * receives an updated version.
+ *
+ * &struct v4l2_ext_controls has a pointer to an array of
+ * &struct v4l2_ext_control, and also potentially pointers to user-space memory
+ * that we need to map properly, hence the dedicated function.
+ */
+static int virtio_media_send_ext_controls_ioctl(struct v4l2_fh *fh, u32 ioctl,
+						struct v4l2_ext_controls *ctrls)
+{
+	struct video_device *video_dev = fh->vdev;
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session = fh_to_session(fh);
+	size_t num_cmd_sgs;
+	size_t end_ctrls_sg;
+	struct v4l2_ext_control *controls_backup = ctrls->controls;
+	const u32 num_ctrls = ctrls->count;
+	struct scatterlist *sgs[64];
+	struct scatterlist_builder builder = {
+		.descs = session->command_sgs.sgl,
+		.num_descs = DESC_CHAIN_MAX_LEN,
+		.cur_desc = 0,
+		.shadow_buffer = session->shadow_buf,
+		.shadow_buffer_size = VIRTIO_SHADOW_BUF_SIZE,
+		.shadow_buffer_pos = 0,
+		.sgs = sgs,
+		.num_sgs = ARRAY_SIZE(sgs),
+		.cur_sg = 0,
+		.framevecs = NULL,
+		.cur_framevec = 0,
+	};
+	size_t resp_len = 0;
+	int i;
+
+	int ret = scatterlist_builder_allocate_framevecs(&builder, ctrls);
+
+	if (ret)
+		return ret;
+
+	/* Command descriptor */
+	ret = scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
+
+	if (ret)
+		goto free_framevecs;
+
+	/* v4l2_controls */
+	ret = scatterlist_builder_add_ext_ctrls(&builder, ctrls);
+	if (ret)
+		goto free_framevecs;
+
+	end_ctrls_sg = builder.cur_sg;
+
+	ret = scatterlist_builder_add_ext_ctrls_userptrs(&builder, ctrls);
+	if (ret)
+		goto free_framevecs;
+
+	num_cmd_sgs = builder.cur_sg;
+
+	/* Response descriptor */
+	ret = scatterlist_builder_add_ioctl_resp(&builder, session);
+	if (ret)
+		goto free_framevecs;
+
+	/* Response payload (same as input but without userptrs) */
+	for (i = 1; i < end_ctrls_sg; i++) {
+		ret = scatterlist_builder_add_descriptor(&builder, i);
+		if (ret < 0)
+			goto free_framevecs;
+	}
+
+	ret = virtio_media_send_command(vv, builder.sgs, num_cmd_sgs,
+					builder.cur_sg - num_cmd_sgs,
+					sizeof(struct virtio_media_resp_ioctl) +
+					sizeof(*ctrls),
+					&resp_len);
+
+	/* Just in case the host touched these. */
+	ctrls->controls = controls_backup;
+	if (ctrls->count != num_ctrls) {
+		v4l2_err(&vv->v4l2_dev,
+			 "device returned a number of controls different than the one submitted\n");
+	}
+	if (ctrls->count > num_ctrls)
+		return -ENOSPC;
+	if (ret < 0) {
+		/*
+		 * Even if we have received an error, we may need to read our
+		 * payloadback.
+		 */
+		if (resp_len >= sizeof(struct virtio_media_resp_ioctl) +
+		    sizeof(*ctrls)) {
+			/*
+			 * Deliberately ignore the error here as we want to
+			 * return the previous one.
+			 */
+			scatterlist_builder_retrieve_ext_ctrls(&builder,
+							       num_cmd_sgs + 1,
+							       ctrls);
+		}
+
+		goto free_framevecs;
+	}
+
+	resp_len -= sizeof(struct virtio_media_resp_ioctl);
+
+	/* Make sure that the reply's length covers our v4l2_ext_controls */
+	if (resp_len < sizeof(*ctrls))
+		return -EINVAL;
+
+	ret = scatterlist_builder_retrieve_ext_ctrls(&builder, num_cmd_sgs + 1,
+						     ctrls);
+
+free_framevecs:
+	scatterlist_builder_free_framevecs(&builder);
+	return ret;
+}
+
 /*
  * Macros suitable for defining ioctls with a constant size payload.
  */
@@ -327,6 +457,37 @@ static int virtio_media_querycap(struct file *file, void *fh,
 	return 0;
 }
 
+/*
+ * Extended control ioctls are handled mostly identically.
+ */
+
+static int virtio_media_g_ext_ctrls(struct file *file, void *fh,
+				    struct v4l2_ext_controls *ctrls)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+
+	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_G_EXT_CTRLS,
+						    ctrls);
+}
+
+static int virtio_media_s_ext_ctrls(struct file *file, void *fh,
+				    struct v4l2_ext_controls *ctrls)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+
+	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_S_EXT_CTRLS,
+						    ctrls);
+}
+
+static int virtio_media_try_ext_ctrls(struct file *file, void *fh,
+				      struct v4l2_ext_controls *ctrls)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+
+	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_TRY_EXT_CTRLS,
+						    ctrls);
+}
+
 /*
  * s/g_input/output work with an unsigned int - recast this to a u32 so the
  * size is unambiguous.
@@ -472,6 +633,9 @@ const struct v4l2_ioctl_ops virtio_media_ioctl_ops = {
 
 	/* Control handling */
 	.vidioc_query_ext_ctrl = virtio_media_query_ext_ctrl,
+	.vidioc_g_ext_ctrls = virtio_media_g_ext_ctrls,
+	.vidioc_s_ext_ctrls = virtio_media_s_ext_ctrls,
+	.vidioc_try_ext_ctrls = virtio_media_try_ext_ctrls,
 	.vidioc_querymenu = virtio_media_querymenu,
 
 	/* Audio ioctls */
diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virtio_media.h
index c1e68d47c..f117b97fc 100644
--- a/include/uapi/linux/virtio_media.h
+++ b/include/uapi/linux/virtio_media.h
@@ -158,4 +158,17 @@ struct virtio_media_resp_ioctl {
 	struct virtio_media_resp_header hdr;
 };
 
+/**
+ * struct virtio_media_sg_entry - Description of part of a scattered guest
+ *                                memory.
+ * @start: start guest address of the memory segment.
+ * @len: length of this memory segment.
+ * @__reserved: must be set to zero by the driver.
+ */
+struct virtio_media_sg_entry {
+	__le64 start;
+	__le32 len;
+	__le32 __reserved;
+};
+
 #endif // _UAPI__LINUX_VIRTIO_MEDIA_H
-- 
2.56.1.750.gf70dc682cf-goog

