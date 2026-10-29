Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287856;
	b=y+tTnkFN4Zu+0BThFzwZHDdOZzxoIdFr4B5VHNH+3iZoH5Lp2c910sRi0F1ZougHYCha
	 Un0i/slIRG3qHrCYv4yAz1ZFUUnberiBVG0Zh2cRaJkj5ErVVrH1C25KOc6G/rP8oO4M9
	 uYS+I3W5pvwVc2CnIR6F/ai6IE1YmSaUi4ZxHbqEj9ERA6FjtJewIm/1dpYpPqf1NQe0D
	 Jnny+9RNUT8czuw4EFJ3TPjQXSbDY850fvLv1ZgKyXkC/Mp/PfsRUR+GbYV6UDZnAw8RA
	 tnLeDam4CvzRiMJ0o7ICBLJu62m/rxp9ipRz7A/jrDbzE1aV3nzdPOISeDD79KR8JuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DGqC1UGDIxZm9DPlPdxMjl204IyeFKYUBR/la7Xo8us=;
	b=zGTz9vrA8hVCL+m8rZNucu+pXgH1WGUKm28VXbyIYmPEJs/yciJZ/0tDeFrkFYSCs5Jb
	 lja1qktU3MAMSQ2lK85stF+Gp+DzvWIDo7kkqpzbIpHdHXvcIWXq1cch1BwLhnaECK+7t
	 xUGfF40/7OF5fhqU8uDbaxPs/pzxXYxRiqFSuFCAt3UwCOExgb+8PGO30BKJ6K/2hufs1
	 2J65rkMLKmnoVMt0goy8xJg6uvHJDJpuoUGwicL/2xhR0g+Pdk5/ECiURrUwxHkFEsJrM
	 Whqxh5We3ggSBlfPGEoFj2pi5CRfceoeEZzQv5/wm6mLmieo8U55tay89v+fAn860KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YsIzwbUf;
	arc=none smtp.remote-ip=209.85.160.200
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0508606A33E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 15:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0508606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YsIzwbUf
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5363b06bcb2so47398941cf.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793287854; x=1793892654; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGqC1UGDIxZm9DPlPdxMjl204IyeFKYUBR/la7Xo8us=;
        b=YsIzwbUfDId3quxc8r8n2QUYw/a7aKjrD7xNbv0nppUdA03Bt1nT/M4esSIm+tYrwd
         RxZe2Rhc4G2QcZUV/FuslP48WYVjQAIhv7UA5U3UzDEz0LGmNY9SVAqjhZIkXL9Whzz8
         0Q5UbIXxdgFnAdWwWQUH1UgwuFc8hyKL8FMBwOmaZ0UNXMQWoS3OXrCy4qse23zvjmza
         AREYynjRCU12A+X5uV1dckLZihwJVNrSGQmORcptd3VhG7W5Kh6kwn2rTPbLrYOhHpfr
         NxI/4CWGrDFIfqRatxC1soG/mLCnNEo2nJhzPIAOFmwzCR/cIBe1dBUinexRnJ+GmQsT
         1k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287854; x=1793892654;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGqC1UGDIxZm9DPlPdxMjl204IyeFKYUBR/la7Xo8us=;
        b=UPLwpRokOD2ZJ7DpSP+Z0a/VfOtPO+VnERuRbhThy3c08RatdcU138aChLa7bk/inh
         6It8dbxaiRhqsRV6+dNL0Hz97uN/VtOLiM5/it2HMZV5yq60WO7L81wg94h+5f5dQm5l
         OL2CRvo67s/P+i6/XBeqdZTZ/0mAmnq4j0FHnwr1EUszRGoaZ7AxOo+61mdb90UwzibW
         zJ2TuAGkU3J13OvM6d+gPqLBP7ENGu40wzgSWsdMpsls3H6BGwxVH/blIo+vfycmuKTK
         MKljYbBgtxMrU+Rx1lI6j4wQq4qF98Y+3510zpLQNTPtn9BRZ8bcz3R5AihzYgGfFESK
         y0kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrqgZ0/3WqvKEGN9D/ppQhZZFvsq3PIs97EBm3vyRZZsfV4fbMhsgdPZRwgakG1sjQHRrltF1HgHXlEkOZnw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKHJj1sf28DjKdn+KXDuWQ/nzTVeUmCYf/UuJW8TtYOu4QISABA
	LqxiKZfmNhmL7Wxve4uCUwIAbodQ/SVvnySPdZ+GAIE55O+6TuFcmMvQl38l1hXOaIhWLG6iVHh
	tJyJbc6TwckM0KxzSKT29KVgKtQzO
X-Received: from qtbnn24-n2.prod.google.com ([2002:a05:622a:7918:20b0:535:30f8:65ca])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6f18:0:b0:537:8412:e659 with SMTP id d75a77b69052e-53fcbfde9afmr99269591cf.34.1793287853499;
 Thu, 29 Oct 2026 08:30:53 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:30:35 -0400
In-Reply-To: <20261029153038.3800747-1-briandaniels@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261029153038.3800747-1-briandaniels@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029153038.3800747-3-briandaniels@google.com>
Subject: [PATCH v10 2/5] media: virtio: Add V4L2 ioctl forwarding infrastructure
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

Introduce the scatterlist builder and synchronous V4L2 ioctl forwarding
via VIRTIO_MEDIA_CMD_IOCTL.

The scatterlist builder constructs virtio descriptor chains for ioctl
commands and responses, mapping 1:1 kernel memory and vmalloc buffers
directly into scatterlists when possible while falling back to a
per-session shadow buffer otherwise.

Use this infrastructure to implement VIDIOC_QUERYCAP from the virtio
configuration space along with fixed-size read, write, and read-write
V4L2 ioctls covering format negotiation, frame sizes and intervals,
control and menu queries, inputs and outputs, audio, selection, video
standards, tuners, and DV timings.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: LLM
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/Makefile              |   2 +-
 drivers/media/virtio/scatterlist_builder.c | 222 ++++++++
 drivers/media/virtio/scatterlist_builder.h |  90 +++
 drivers/media/virtio/session.h             |  28 +-
 drivers/media/virtio/virtio_media.h        |   9 +
 drivers/media/virtio/virtio_media_driver.c |  24 +-
 drivers/media/virtio/virtio_media_ioctls.c | 606 +++++++++++++++++++++
 include/uapi/linux/virtio_media.h          |  43 ++
 8 files changed, 1020 insertions(+), 4 deletions(-)
 create mode 100644 drivers/media/virtio/scatterlist_builder.c
 create mode 100644 drivers/media/virtio/scatterlist_builder.h
 create mode 100644 drivers/media/virtio/virtio_media_ioctls.c

diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makefile
index 09d9834da..f1bc8a3ce 100644
--- a/drivers/media/virtio/Makefile
+++ b/drivers/media/virtio/Makefile
@@ -2,6 +2,6 @@
 #
 # Makefile for the virtio-media device driver.
 
-virtio-media-objs := virtio_media_driver.o
+virtio-media-objs := scatterlist_builder.o virtio_media_ioctls.o virtio_media_driver.o
 
 obj-$(CONFIG_MEDIA_VIRTIO) += virtio-media.o
diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/virtio/scatterlist_builder.c
new file mode 100644
index 000000000..ae8ffee82
--- /dev/null
+++ b/drivers/media/virtio/scatterlist_builder.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
+
+/*
+ * Scatterlist builder helpers for virtio-media.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#include <linux/moduleparam.h>
+#include <linux/scatterlist.h>
+#include <linux/videodev2.h>
+#include <media/videobuf2-memops.h>
+
+#include "uapi/linux/virtio_media.h"
+#include "scatterlist_builder.h"
+#include "session.h"
+
+/*
+ * If set to %true, then the driver will always copy the data passed to the
+ * host into the shadow buffer (instead of trying to map the source memory into
+ * the SG table directly when possible).
+ */
+static bool always_use_shadow_buffer;
+module_param(always_use_shadow_buffer, bool, 0660);
+
+/* Convert a V4L2 IOCTL into the IOCTL code we can give to the host */
+#define VIRTIO_MEDIA_IOCTL_CODE(IOCTL) (((IOCTL) >> _IOC_NRSHIFT) & _IOC_NRMASK)
+
+/**
+ * scatterlist_builder_add_descriptor() - Add a descriptor to the chain.
+ * @builder: builder to use.
+ * @desc_index: index of the descriptor to add.
+ *
+ * Returns %-ENOSPC if @builder->sgs is already full.
+ */
+int scatterlist_builder_add_descriptor(struct scatterlist_builder *builder,
+				       size_t desc_index)
+{
+	if (builder->cur_sg >= builder->num_sgs)
+		return -ENOSPC;
+	builder->sgs[builder->cur_sg++] = &builder->descs[desc_index];
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_add_data() - Append arbitrary data to the descriptor
+ *                                  chain.
+ * @builder: builder to use.
+ * @data: pointer to the data to add to the descriptor chain.
+ * @len: length of the data to add.
+ *
+ * @data will either be directly referenced, or copied into the shadow buffer
+ * to be referenced from there.
+ */
+int scatterlist_builder_add_data(struct scatterlist_builder *builder,
+				 void *data, size_t len)
+{
+	const size_t cur_desc = builder->cur_desc;
+
+	if (len == 0)
+		return 0;
+
+	if (builder->cur_desc >= builder->num_descs)
+		return -ENOSPC;
+
+	if (!always_use_shadow_buffer && virt_addr_valid(data) &&
+	    virt_addr_valid(data + len)) {
+		/*
+		 * If "data" is in the 1:1 physical memory mapping then we can
+		 * use a single SG entry and avoid copying.
+		 */
+		struct page *page = virt_to_page(data);
+		size_t offset = (((size_t)data) & ~PAGE_MASK);
+		struct scatterlist *next_desc =
+			&builder->descs[builder->cur_desc];
+
+		memset(next_desc, 0, sizeof(*next_desc));
+		sg_set_page(next_desc, page, len, offset);
+		builder->cur_desc++;
+	} else if (!always_use_shadow_buffer && is_vmalloc_addr(data)) {
+		bool prev_pfn_valid = false;
+		unsigned long prev_pfn = 0;
+
+		/*
+		 * If "data" has been vmalloc'ed, we need at most one entry per
+		 * memory page but can avoid copying.
+		 */
+		while (len > 0) {
+			struct page *page = vmalloc_to_page(data);
+			unsigned long cur_pfn = page_to_pfn(page);
+			/* All pages but the first will start at offset 0. */
+			unsigned long offset =
+				(((unsigned long)data) & ~PAGE_MASK);
+			size_t len_in_page = min(PAGE_SIZE - offset, len);
+			struct scatterlist *next_desc =
+				&builder->descs[builder->cur_desc];
+
+			if (builder->cur_desc >= builder->num_descs)
+				return -ENOSPC;
+
+			/* Optimize contiguous pages */
+			if (prev_pfn_valid && (cur_pfn == prev_pfn + 1)) {
+				(next_desc - 1)->length += len_in_page;
+			} else {
+				memset(next_desc, 0, sizeof(*next_desc));
+				sg_set_page(next_desc, page, len_in_page,
+					    offset);
+				builder->cur_desc++;
+			}
+			data += len_in_page;
+			len -= len_in_page;
+			prev_pfn = cur_pfn;
+			prev_pfn_valid = true;
+		}
+	} else {
+		/*
+		 * As a last resort, copy into the shadow buffer and reference
+		 * it with a single SG entry. Calling
+		 * scatterlist_builder_retrieve_data() will be necessary to copy
+		 * the data written by the device back into @data.
+		 */
+		void *shadow_buffer =
+			builder->shadow_buffer + builder->shadow_buffer_pos;
+		struct page *page = virt_to_page(shadow_buffer);
+		unsigned long offset =
+			(((unsigned long)shadow_buffer) & ~PAGE_MASK);
+		struct scatterlist *next_desc =
+			&builder->descs[builder->cur_desc];
+
+		if (len >
+		    builder->shadow_buffer_size - builder->shadow_buffer_pos)
+			return -ENOSPC;
+
+		memcpy(shadow_buffer, data, len);
+		memset(next_desc, 0, sizeof(*next_desc));
+		sg_set_page(next_desc, page, len, offset);
+		builder->cur_desc++;
+		builder->shadow_buffer_pos += len;
+	}
+
+	sg_mark_end(&builder->descs[builder->cur_desc - 1]);
+	return scatterlist_builder_add_descriptor(builder, cur_desc);
+}
+
+/**
+ * scatterlist_builder_retrieve_data() - Retrieve a response written by the
+ *                                       device on the shadow buffer.
+ * @builder: builder to use.
+ * @sg_index: index of the descriptor to read from.
+ * @data: destination for the shadowed data.
+ *
+ * If the shadow buffer is pointed to by the descriptor at index @sg_index of
+ * the chain, then ``sg->length`` bytes are copied back from it into @data.
+ * Otherwise nothing is done since the device has written into @data directly.
+ *
+ * @data must have originally been added by scatterlist_builder_add_data() as
+ * the same size as passed to scatterlist_builder_add_data() will be copied
+ * back.
+ */
+int scatterlist_builder_retrieve_data(struct scatterlist_builder *builder,
+				      size_t sg_index, void *data)
+{
+	void *shadow_buf = builder->shadow_buffer;
+	struct scatterlist *sg;
+	void *kaddr;
+
+	/* We can only retrieve from the range of sgs currently set. */
+	if (sg_index >= builder->cur_sg)
+		return -ERANGE;
+
+	sg = builder->sgs[sg_index];
+	kaddr = pfn_to_kaddr(page_to_pfn(sg_page(sg))) + sg->offset;
+
+	if (kaddr >= shadow_buf &&
+	    kaddr < shadow_buf + builder->shadow_buffer_size) {
+		if (kaddr + sg->length >
+		    shadow_buf + builder->shadow_buffer_size)
+			return -EINVAL;
+
+		memcpy(data, kaddr, sg->length);
+	}
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_add_ioctl_cmd() - Add an ioctl command to the descriptor
+ *                                       chain.
+ * @builder: builder to use.
+ * @session: session on behalf of which the ioctl command is added.
+ * @ioctl_code: code of the ioctl to add (i.e. ``VIDIOC_*``).
+ */
+int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builder,
+				      struct virtio_media_session *session,
+				      u32 ioctl_code)
+{
+	struct virtio_media_cmd_ioctl *cmd_ioctl = &session->cmd.ioctl;
+
+	cmd_ioctl->hdr.cmd = VIRTIO_MEDIA_CMD_IOCTL;
+	cmd_ioctl->hdr.__reserved = 0;
+	cmd_ioctl->session_id = session->id;
+	cmd_ioctl->code = VIRTIO_MEDIA_IOCTL_CODE(ioctl_code);
+
+	return scatterlist_builder_add_data(builder, cmd_ioctl,
+					    sizeof(*cmd_ioctl));
+}
+
+/**
+ * scatterlist_builder_add_ioctl_resp() - Add storage to receive an ioctl
+ *                                        response to the descriptor chain.
+ * @builder: builder to use.
+ * @session: session on behalf of which the ioctl response is added.
+ */
+int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *builder,
+				       struct virtio_media_session *session)
+{
+	struct virtio_media_resp_ioctl *resp_ioctl = &session->resp.ioctl;
+
+	return scatterlist_builder_add_data(builder, resp_ioctl,
+					    sizeof(*resp_ioctl));
+}
diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/virtio/scatterlist_builder.h
new file mode 100644
index 000000000..044ea409a
--- /dev/null
+++ b/drivers/media/virtio/scatterlist_builder.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
+
+/*
+ * Scatterlist builder helpers for virtio-media.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
+#define __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
+
+#include <linux/scatterlist.h>
+
+#include "session.h"
+
+/**
+ * struct scatterlist_builder - helper to build a scatterlist from data.
+ * @descs: pool of descriptors to use.
+ * @num_descs: number of entries in descs.
+ * @cur_desc: next descriptor to be used in @descs.
+ * @shadow_buffer: pointer to a shadow buffer where elements that cannot be
+ * mapped directly into the scatterlist get copied.
+ * @shadow_buffer_size: size of @shadow_buffer.
+ * @shadow_buffer_pos: current position in @shadow_buffer.
+ * @sgs: descriptor chain to eventually pass to virtio functions.
+ * @num_sgs: total number of entries in @sgs.
+ * @cur_sg: next entry in @sgs to be used.
+ *
+ * Virtio passes data from the driver to the device (through e.g.
+ * virtqueue_add_sgs()) via a scatterlist that the device interprets as a
+ * linear view over scattered driver memory.
+ *
+ * In virtio-media, the payload of ioctls from user-space can for the most part
+ * be passed as-is, or after slight modification, which makes it tempting to
+ * just forward the ioctl payload received from user-space as-is instead of
+ * doing another copy into a dedicated buffer. This structure helps with this.
+ *
+ * virtio-media descriptor chains are typically made of the following parts:
+ *
+ * Device-readable:
+ * - A command structure, i.e. ``virtio_media_cmd_*``,
+ * - An ioctl payload (one of the regular ioctl parameters),
+ * - (optionally) arrays of &struct virtio_media_sg_entry describing the
+ *   content of buffers in guest memory.
+ *
+ * Device-writable:
+ * - A response structure, i.e. ``virtio_media_resp_*``,
+ * - An ioctl payload, that the device will write to.
+ *
+ * This structure helps laying out the descriptor chain into its @sgs member in
+ * an optimal way, by building a scatterlist adapted to the originating memory
+ * of the data we want to pass to the device while avoiding copies when
+ * possible.
+ *
+ * It is made of a pool of &struct scatterlist (@descs) that is used to
+ * build the final descriptor chain @sgs, and a @shadow_buffer where data that
+ * cannot (or should not) be mapped directly by the host can be temporarily
+ * copied.
+ */
+struct scatterlist_builder {
+	struct scatterlist *descs;
+	size_t num_descs;
+	size_t cur_desc;
+
+	void *shadow_buffer;
+	size_t shadow_buffer_size;
+	size_t shadow_buffer_pos;
+
+	struct scatterlist **sgs;
+	size_t num_sgs;
+	size_t cur_sg;
+};
+
+int scatterlist_builder_add_descriptor(struct scatterlist_builder *builder,
+				       size_t desc_index);
+
+int scatterlist_builder_add_data(struct scatterlist_builder *builder,
+				 void *data, size_t len);
+
+int scatterlist_builder_retrieve_data(struct scatterlist_builder *builder,
+				      size_t sg_index, void *data);
+
+int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builder,
+				      struct virtio_media_session *session,
+				      u32 ioctl_code);
+
+int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *builder,
+				       struct virtio_media_session *session);
+
+#endif // __VIRTIO_MEDIA_SCATTERLIST_BUILDER_H
diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/session.h
index 4ade7fb9c..6fe7ff5ae 100644
--- a/drivers/media/virtio/session.h
+++ b/drivers/media/virtio/session.h
@@ -9,17 +9,32 @@
 #ifndef __VIRTIO_MEDIA_SESSION_H
 #define __VIRTIO_MEDIA_SESSION_H
 
+#include <linux/scatterlist.h>
 #include <media/v4l2-fh.h>
 
 #include "uapi/linux/virtio_media.h"
 
+/*
+ * Size of the per-session virtio shadow and event buffers. 16K should be
+ * enough to contain everything we need.
+ */
+#define VIRTIO_SHADOW_BUF_SIZE 0x4000
+
 /**
  * struct virtio_media_session - A session on a virtio_media device.
  * @fh: file handler for the session.
  * @file: file pointer associated with the session's file handler.
  * @id: session ID used to communicate with the device.
- * @cmd: union of session-level commands. A session can have one command
- *       currently running.
+ * @cmd: union of session commands ``close`` and ``ioctl``. A session can have
+ *       one command currently running. The rest of the commands are handled by
+ *       &struct virtio_media.
+ * @resp: union of responses to session commands. A session can wait on one
+ *        command only. The rest of the responses are handled by
+ *        &struct virtio_media.
+ * @shadow_buf: shadow buffer where data to be added to the descriptor chain can
+ *              be staged before being sent to the device.
+ * @command_sgs: SG table gathering descriptors for a given command and its
+ *               response.
  * @list: link into the list of sessions for the device.
  */
 struct virtio_media_session {
@@ -30,9 +45,18 @@ struct virtio_media_session {
 	__dma_from_device_group_begin();
 	union {
 		struct virtio_media_cmd_close close;
+		struct virtio_media_cmd_ioctl ioctl;
 	} cmd;
+
+	union {
+		struct virtio_media_resp_ioctl ioctl;
+	} resp;
 	__dma_from_device_group_end();
 
+	void *shadow_buf;
+
+	struct sg_table command_sgs;
+
 	struct list_head list;
 };
 
diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
index 68299377a..a120c1014 100644
--- a/drivers/media/virtio/virtio_media.h
+++ b/drivers/media/virtio/virtio_media.h
@@ -14,6 +14,8 @@
 
 #include "uapi/linux/virtio_media.h"
 
+#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
+
 #define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
 
 /**
@@ -66,5 +68,12 @@ to_virtio_media(struct video_device *video_dev)
 int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
 			      const size_t out_sgs, const size_t in_sgs,
 			      size_t minimum_resp_len, size_t *resp_len);
+
+/* virtio_media_ioctls.c */
+
+long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg);
+extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
+
 #endif // __VIRTIO_MEDIA_H
 
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
index 10073d863..2f2e95077 100644
--- a/drivers/media/virtio/virtio_media_driver.c
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -37,10 +37,20 @@ static struct virtio_media_session *
 virtio_media_session_alloc(struct virtio_media *vv, struct file *file)
 {
 	struct virtio_media_session *session;
+	int ret;
 
 	session = kzalloc_obj(*session, GFP_KERNEL);
 	if (!session)
-		return ERR_PTR(-ENOMEM);
+		goto err_session;
+
+	session->shadow_buf = kzalloc(VIRTIO_SHADOW_BUF_SIZE, GFP_KERNEL);
+	if (!session->shadow_buf)
+		goto err_shadow_buf;
+
+	ret = sg_alloc_table(&session->command_sgs, DESC_CHAIN_MAX_LEN,
+			     GFP_KERNEL);
+	if (ret)
+		goto err_payload_sgs;
 
 	// The caller is expected to set the ID once the host assigns a value.
 	session->id = 0;
@@ -50,6 +60,13 @@ virtio_media_session_alloc(struct virtio_media *vv, struct file *file)
 	virtio_media_session_fh_add(session, file);
 
 	return session;
+
+err_payload_sgs:
+	kfree(session->shadow_buf);
+err_shadow_buf:
+	kfree(session);
+err_session:
+	return ERR_PTR(-ENOMEM);
 }
 
 /**
@@ -77,6 +94,9 @@ static void virtio_media_session_free(struct virtio_media_session *session)
 	virtio_media_session_fh_del(session);
 	v4l2_fh_exit(&session->fh);
 
+	sg_free_table(&session->command_sgs);
+
+	kfree(session->shadow_buf);
 	kfree(session);
 }
 
@@ -342,6 +362,7 @@ static const struct v4l2_file_operations virtio_media_fops = {
 	.owner = THIS_MODULE,
 	.open = virtio_media_device_open,
 	.release = virtio_media_device_close,
+	.unlocked_ioctl = virtio_media_device_ioctl,
 };
 
 static void virtio_media_release(struct v4l2_device *v4l2_dev)
@@ -394,6 +415,7 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 
 	vd = &vv->video_dev;
 	vd->v4l2_dev = &vv->v4l2_dev;
+	vd->ioctl_ops = &virtio_media_ioctl_ops;
 	vd->fops = &virtio_media_fops;
 	vd->release = video_device_release_empty;
 	strscpy(vd->name, "virtio-media", sizeof(vd->name));
diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/virtio/virtio_media_ioctls.c
new file mode 100644
index 000000000..656ecea8a
--- /dev/null
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
+
+/*
+ * Ioctl implementations for the virtio-media driver.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#include <linux/mutex.h>
+#include <linux/videodev2.h>
+#include <linux/virtio_config.h>
+#include <media/v4l2-ioctl.h>
+
+#include "scatterlist_builder.h"
+#include "virtio_media.h"
+
+/**
+ * virtio_media_send_r_ioctl() - Send a read-only ioctl to the device.
+ * @fh: file handler of the session doing the ioctl.
+ * @ioctl: ``VIDIOC_*`` ioctl code.
+ * @ioctl_data: pointer to the ioctl payload.
+ * @ioctl_data_len: length in bytes of the ioctl payload.
+ *
+ * Send an ioctl that has no driver payload, but expects a response from the
+ * host (i.e. an ioctl specified with ``_IOR``).
+ */
+static int virtio_media_send_r_ioctl(struct v4l2_fh *fh, u32 ioctl,
+				     void *ioctl_data, size_t ioctl_data_len)
+{
+	struct video_device *video_dev = fh->vdev;
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session = fh_to_session(fh);
+	struct scatterlist *sgs[3];
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
+	};
+
+	/* Command descriptor */
+	int ret = scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
+
+	if (ret)
+		return ret;
+
+	/* Response descriptor */
+	ret = scatterlist_builder_add_ioctl_resp(&builder, session);
+	if (ret)
+		return ret;
+
+	/* Response payload */
+	ret = scatterlist_builder_add_data(&builder, ioctl_data,
+					   ioctl_data_len);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to prepare command descriptor chain\n");
+		return ret;
+	}
+
+	ret = virtio_media_send_command(vv, sgs, 1, 2,
+					sizeof(struct virtio_media_resp_ioctl) +
+					ioctl_data_len, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = scatterlist_builder_retrieve_data(&builder, 2, ioctl_data);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to retrieve response descriptor chain\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_media_send_w_ioctl() - Send a write-only ioctl to the device.
+ * @fh: file handler of the session doing the ioctl.
+ * @ioctl: ``VIDIOC_*`` ioctl code.
+ * @ioctl_data: pointer to the ioctl payload.
+ * @ioctl_data_len: length in bytes of the ioctl payload.
+ *
+ * Send an ioctl that does not expect a reply beyond an error status (i.e. an
+ * ioctl specified with ``_IOW``) to the host.
+ */
+static int virtio_media_send_w_ioctl(struct v4l2_fh *fh, u32 ioctl,
+				     const void *ioctl_data,
+				     size_t ioctl_data_len)
+{
+	struct video_device *video_dev = fh->vdev;
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session = fh_to_session(fh);
+	struct scatterlist *sgs[3];
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
+	};
+
+	/* Command descriptor */
+	int ret = scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
+
+	if (ret)
+		return ret;
+
+	/* Command payload */
+	ret = scatterlist_builder_add_data(&builder, (void *)ioctl_data,
+					   ioctl_data_len);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to prepare command descriptor chain\n");
+		return ret;
+	}
+
+	/* Response descriptor */
+	ret = scatterlist_builder_add_ioctl_resp(&builder, session);
+	if (ret)
+		return ret;
+
+	ret = virtio_media_send_command(vv, sgs, 2, 1,
+					sizeof(struct virtio_media_resp_ioctl),
+					NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * virtio_media_send_wr_ioctl() - Send a read-write ioctl to the device.
+ * @fh: file handler of the session doing the ioctl.
+ * @ioctl: ``VIDIOC_*`` ioctl code.
+ * @ioctl_data: pointer to the ioctl payload.
+ * @ioctl_data_len: length in bytes of the ioctl payload.
+ * @minimum_resp_payload: minimum expected length of the response's payload.
+ *
+ * Sends an ioctl that expects a response of exactly the same size as the
+ * input (i.e. an ioctl specified with ``_IOWR``) to the host.
+ *
+ * This corresponds to what most V4L2 ioctls do. For instance
+ * ``VIDIOC_ENUM_FMT`` takes a partially-initialized &struct v4l2_fmtdesc
+ * and returns its filled version.
+ */
+static int virtio_media_send_wr_ioctl(struct v4l2_fh *fh, u32 ioctl,
+				      void *ioctl_data, size_t ioctl_data_len,
+				      size_t minimum_resp_payload)
+{
+	struct video_device *video_dev = fh->vdev;
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session = fh_to_session(fh);
+	struct scatterlist *sgs[4];
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
+	};
+
+	/* Command descriptor */
+	int ret = scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
+
+	if (ret)
+		return ret;
+
+	/* Command payload */
+	ret = scatterlist_builder_add_data(&builder, ioctl_data,
+					   ioctl_data_len);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to prepare command descriptor chain\n");
+		return ret;
+	}
+
+	/* Response descriptor */
+	ret = scatterlist_builder_add_ioctl_resp(&builder, session);
+	if (ret)
+		return ret;
+
+	/* Response payload, same as command */
+	ret = scatterlist_builder_add_descriptor(&builder, 1);
+	if (ret)
+		return ret;
+
+	ret = virtio_media_send_command(vv, sgs, 2, 2,
+					sizeof(struct virtio_media_resp_ioctl) +
+						minimum_resp_payload,
+					NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = scatterlist_builder_retrieve_data(&builder, 3, ioctl_data);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to retrieve response descriptor chain\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Macros suitable for defining ioctls with a constant size payload.
+ */
+
+#define SIMPLE_WR_IOCTL(name, ioctl, payload_t)                       \
+	static int virtio_media_##name(struct file *file, void *fh,   \
+				       payload_t *payload)            \
+	{                                                             \
+		struct v4l2_fh *vfh = file_to_v4l2_fh(file);          \
+		return virtio_media_send_wr_ioctl(vfh, ioctl, payload,\
+						  sizeof(*payload),   \
+						  sizeof(*payload));  \
+	}
+#define SIMPLE_R_IOCTL(name, ioctl, payload_t)                       \
+	static int virtio_media_##name(struct file *file, void *fh,  \
+				       payload_t *payload)           \
+	{                                                            \
+		struct v4l2_fh *vfh = file_to_v4l2_fh(file);         \
+		return virtio_media_send_r_ioctl(vfh, ioctl, payload,\
+						 sizeof(*payload));  \
+	}
+#define SIMPLE_W_IOCTL(name, ioctl, payload_t)                       \
+	static int virtio_media_##name(struct file *file, void *fh,  \
+				       payload_t *payload)           \
+	{                                                            \
+		struct v4l2_fh *vfh = file_to_v4l2_fh(file);         \
+		return virtio_media_send_w_ioctl(vfh, ioctl, payload,\
+						 sizeof(*payload));  \
+	}
+
+/*
+ * V4L2 ioctl handlers.
+ *
+ * Most of these functions just forward the ioctl to the host, for these we can
+ * use one of the SIMPLE_*_IOCTL macros. Exceptions that have their own
+ * standalone function follow.
+ */
+
+SIMPLE_WR_IOCTL(enum_fmt, VIDIOC_ENUM_FMT, struct v4l2_fmtdesc)
+SIMPLE_WR_IOCTL(g_fmt, VIDIOC_G_FMT, struct v4l2_format)
+SIMPLE_WR_IOCTL(s_fmt, VIDIOC_S_FMT, struct v4l2_format)
+SIMPLE_WR_IOCTL(try_fmt, VIDIOC_TRY_FMT, struct v4l2_format)
+SIMPLE_WR_IOCTL(enum_framesizes, VIDIOC_ENUM_FRAMESIZES,
+		struct v4l2_frmsizeenum)
+SIMPLE_WR_IOCTL(enum_frameintervals, VIDIOC_ENUM_FRAMEINTERVALS,
+		struct v4l2_frmivalenum)
+SIMPLE_WR_IOCTL(query_ext_ctrl, VIDIOC_QUERY_EXT_CTRL,
+		struct v4l2_query_ext_ctrl)
+SIMPLE_WR_IOCTL(s_dv_timings, VIDIOC_S_DV_TIMINGS, struct v4l2_dv_timings)
+SIMPLE_WR_IOCTL(g_dv_timings, VIDIOC_G_DV_TIMINGS, struct v4l2_dv_timings)
+SIMPLE_R_IOCTL(query_dv_timings, VIDIOC_QUERY_DV_TIMINGS,
+	       struct v4l2_dv_timings)
+SIMPLE_WR_IOCTL(enum_dv_timings, VIDIOC_ENUM_DV_TIMINGS,
+		struct v4l2_enum_dv_timings)
+SIMPLE_WR_IOCTL(dv_timings_cap, VIDIOC_DV_TIMINGS_CAP,
+		struct v4l2_dv_timings_cap)
+SIMPLE_WR_IOCTL(enuminput, VIDIOC_ENUMINPUT, struct v4l2_input)
+SIMPLE_WR_IOCTL(querymenu, VIDIOC_QUERYMENU, struct v4l2_querymenu)
+SIMPLE_WR_IOCTL(enumoutput, VIDIOC_ENUMOUTPUT, struct v4l2_output)
+SIMPLE_WR_IOCTL(enumaudio, VIDIOC_ENUMAUDIO, struct v4l2_audio)
+SIMPLE_R_IOCTL(g_audio, VIDIOC_G_AUDIO, struct v4l2_audio)
+SIMPLE_W_IOCTL(s_audio, VIDIOC_S_AUDIO, const struct v4l2_audio)
+SIMPLE_WR_IOCTL(enumaudout, VIDIOC_ENUMAUDOUT, struct v4l2_audioout)
+SIMPLE_R_IOCTL(g_audout, VIDIOC_G_AUDOUT, struct v4l2_audioout)
+SIMPLE_W_IOCTL(s_audout, VIDIOC_S_AUDOUT, const struct v4l2_audioout)
+SIMPLE_WR_IOCTL(g_modulator, VIDIOC_G_MODULATOR, struct v4l2_modulator)
+SIMPLE_W_IOCTL(s_modulator, VIDIOC_S_MODULATOR, const struct v4l2_modulator)
+SIMPLE_WR_IOCTL(g_selection, VIDIOC_G_SELECTION, struct v4l2_selection)
+SIMPLE_WR_IOCTL(s_selection, VIDIOC_S_SELECTION, struct v4l2_selection)
+SIMPLE_R_IOCTL(g_enc_index, VIDIOC_G_ENC_INDEX, struct v4l2_enc_idx)
+SIMPLE_WR_IOCTL(encoder_cmd, VIDIOC_ENCODER_CMD, struct v4l2_encoder_cmd)
+SIMPLE_WR_IOCTL(try_encoder_cmd, VIDIOC_TRY_ENCODER_CMD,
+		struct v4l2_encoder_cmd)
+SIMPLE_WR_IOCTL(try_decoder_cmd, VIDIOC_TRY_DECODER_CMD,
+		struct v4l2_decoder_cmd)
+SIMPLE_WR_IOCTL(g_parm, VIDIOC_G_PARM, struct v4l2_streamparm)
+SIMPLE_WR_IOCTL(s_parm, VIDIOC_S_PARM, struct v4l2_streamparm)
+SIMPLE_R_IOCTL(g_std, VIDIOC_G_STD, v4l2_std_id)
+SIMPLE_R_IOCTL(querystd, VIDIOC_QUERYSTD, v4l2_std_id)
+SIMPLE_WR_IOCTL(enumstd, VIDIOC_ENUMSTD, struct v4l2_standard)
+SIMPLE_WR_IOCTL(g_tuner, VIDIOC_G_TUNER, struct v4l2_tuner)
+SIMPLE_W_IOCTL(s_tuner, VIDIOC_S_TUNER, const struct v4l2_tuner)
+SIMPLE_WR_IOCTL(g_frequency, VIDIOC_G_FREQUENCY, struct v4l2_frequency)
+SIMPLE_W_IOCTL(s_frequency, VIDIOC_S_FREQUENCY, const struct v4l2_frequency)
+SIMPLE_WR_IOCTL(enum_freq_bands, VIDIOC_ENUM_FREQ_BANDS,
+		struct v4l2_frequency_band)
+SIMPLE_WR_IOCTL(g_sliced_vbi_cap, VIDIOC_G_SLICED_VBI_CAP,
+		struct v4l2_sliced_vbi_cap)
+SIMPLE_W_IOCTL(s_hw_freq_seek, VIDIOC_S_HW_FREQ_SEEK,
+	       const struct v4l2_hw_freq_seek)
+
+/*
+ * QUERYCAP is handled by reading the configuration area.
+ */
+
+static int virtio_media_querycap(struct file *file, void *fh,
+				 struct v4l2_capability *cap)
+{
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+
+	strscpy(cap->bus_info, "platform:virtio-media");
+	strscpy(cap->driver, VIRTIO_MEDIA_DEFAULT_DRIVER_NAME);
+
+	virtio_cread_bytes(vv->virtio_dev, 8, cap->card, sizeof(cap->card));
+
+	cap->capabilities = video_dev->device_caps | V4L2_CAP_DEVICE_CAPS;
+	cap->device_caps = video_dev->device_caps;
+
+	return 0;
+}
+
+/*
+ * s/g_input/output work with an unsigned int - recast this to a u32 so the
+ * size is unambiguous.
+ */
+
+static int virtio_media_g_input(struct file *file, void *fh, unsigned int *i)
+{
+	u32 input;
+
+	int ret = virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
+					 VIDIOC_G_INPUT, &input,
+					 sizeof(input), sizeof(input));
+	if (ret)
+		return ret;
+
+	*i = input;
+
+	return 0;
+}
+
+static int virtio_media_s_input(struct file *file, void *fh, unsigned int i)
+{
+	u32 input = i;
+
+	return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
+					  VIDIOC_S_INPUT, &input,
+					  sizeof(input), sizeof(input));
+}
+
+static int virtio_media_g_output(struct file *file, void *fh, unsigned int *o)
+{
+	u32 output;
+
+	int ret = virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
+					 VIDIOC_G_OUTPUT, &output,
+					 sizeof(output), sizeof(output));
+	if (ret)
+		return ret;
+
+	*o = output;
+
+	return 0;
+}
+
+static int virtio_media_s_output(struct file *file, void *fh, unsigned int o)
+{
+	u32 output = o;
+
+	return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
+					  VIDIOC_S_OUTPUT, &output,
+					  sizeof(output), sizeof(output));
+}
+
+/*
+ * s_std doesn't work with a pointer, so we cannot use SIMPLE_W_IOCTL.
+ */
+
+static int virtio_media_s_std(struct file *file, void *fh, v4l2_std_id s)
+{
+	int ret = virtio_media_send_w_ioctl(file_to_v4l2_fh(file), VIDIOC_S_STD,
+					&s, sizeof(s));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+const struct v4l2_ioctl_ops virtio_media_ioctl_ops = {
+	/* VIDIOC_QUERYCAP handler */
+	.vidioc_querycap = virtio_media_querycap,
+
+	/* VIDIOC_ENUM_FMT handlers */
+	.vidioc_enum_fmt_vid_cap = virtio_media_enum_fmt,
+	.vidioc_enum_fmt_vid_overlay = virtio_media_enum_fmt,
+	.vidioc_enum_fmt_vid_out = virtio_media_enum_fmt,
+	.vidioc_enum_fmt_sdr_cap = virtio_media_enum_fmt,
+	.vidioc_enum_fmt_sdr_out = virtio_media_enum_fmt,
+	.vidioc_enum_fmt_meta_cap = virtio_media_enum_fmt,
+	.vidioc_enum_fmt_meta_out = virtio_media_enum_fmt,
+
+	/* VIDIOC_G_FMT handlers */
+	.vidioc_g_fmt_vid_cap = virtio_media_g_fmt,
+	.vidioc_g_fmt_vid_overlay = virtio_media_g_fmt,
+	.vidioc_g_fmt_vid_out = virtio_media_g_fmt,
+	.vidioc_g_fmt_vid_out_overlay = virtio_media_g_fmt,
+	.vidioc_g_fmt_vbi_cap = virtio_media_g_fmt,
+	.vidioc_g_fmt_vbi_out = virtio_media_g_fmt,
+	.vidioc_g_fmt_sliced_vbi_cap = virtio_media_g_fmt,
+	.vidioc_g_fmt_sliced_vbi_out = virtio_media_g_fmt,
+	.vidioc_g_fmt_vid_cap_mplane = virtio_media_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane = virtio_media_g_fmt,
+	.vidioc_g_fmt_sdr_cap = virtio_media_g_fmt,
+	.vidioc_g_fmt_sdr_out = virtio_media_g_fmt,
+	.vidioc_g_fmt_meta_cap = virtio_media_g_fmt,
+	.vidioc_g_fmt_meta_out = virtio_media_g_fmt,
+
+	/* VIDIOC_S_FMT handlers */
+	.vidioc_s_fmt_vid_cap = virtio_media_s_fmt,
+	.vidioc_s_fmt_vid_overlay = virtio_media_s_fmt,
+	.vidioc_s_fmt_vid_out = virtio_media_s_fmt,
+	.vidioc_s_fmt_vid_out_overlay = virtio_media_s_fmt,
+	.vidioc_s_fmt_vbi_cap = virtio_media_s_fmt,
+	.vidioc_s_fmt_vbi_out = virtio_media_s_fmt,
+	.vidioc_s_fmt_sliced_vbi_cap = virtio_media_s_fmt,
+	.vidioc_s_fmt_sliced_vbi_out = virtio_media_s_fmt,
+	.vidioc_s_fmt_vid_cap_mplane = virtio_media_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane = virtio_media_s_fmt,
+	.vidioc_s_fmt_sdr_cap = virtio_media_s_fmt,
+	.vidioc_s_fmt_sdr_out = virtio_media_s_fmt,
+	.vidioc_s_fmt_meta_cap = virtio_media_s_fmt,
+	.vidioc_s_fmt_meta_out = virtio_media_s_fmt,
+
+	/* VIDIOC_TRY_FMT handlers */
+	.vidioc_try_fmt_vid_cap = virtio_media_try_fmt,
+	.vidioc_try_fmt_vid_overlay = virtio_media_try_fmt,
+	.vidioc_try_fmt_vid_out = virtio_media_try_fmt,
+	.vidioc_try_fmt_vid_out_overlay = virtio_media_try_fmt,
+	.vidioc_try_fmt_vbi_cap = virtio_media_try_fmt,
+	.vidioc_try_fmt_vbi_out = virtio_media_try_fmt,
+	.vidioc_try_fmt_sliced_vbi_cap = virtio_media_try_fmt,
+	.vidioc_try_fmt_sliced_vbi_out = virtio_media_try_fmt,
+	.vidioc_try_fmt_vid_cap_mplane = virtio_media_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane = virtio_media_try_fmt,
+	.vidioc_try_fmt_sdr_cap = virtio_media_try_fmt,
+	.vidioc_try_fmt_sdr_out = virtio_media_try_fmt,
+	.vidioc_try_fmt_meta_cap = virtio_media_try_fmt,
+	.vidioc_try_fmt_meta_out = virtio_media_try_fmt,
+
+	/* Standard handling */
+	.vidioc_g_std = virtio_media_g_std,
+	.vidioc_s_std = virtio_media_s_std,
+	.vidioc_querystd = virtio_media_querystd,
+
+	/* Input handling */
+	.vidioc_enum_input = virtio_media_enuminput,
+	.vidioc_g_input = virtio_media_g_input,
+	.vidioc_s_input = virtio_media_s_input,
+
+	/* Output handling */
+	.vidioc_enum_output = virtio_media_enumoutput,
+	.vidioc_g_output = virtio_media_g_output,
+	.vidioc_s_output = virtio_media_s_output,
+
+	/* Control handling */
+	.vidioc_query_ext_ctrl = virtio_media_query_ext_ctrl,
+	.vidioc_querymenu = virtio_media_querymenu,
+
+	/* Audio ioctls */
+	.vidioc_enumaudio = virtio_media_enumaudio,
+	.vidioc_g_audio = virtio_media_g_audio,
+	.vidioc_s_audio = virtio_media_s_audio,
+
+	/* Audio out ioctls */
+	.vidioc_enumaudout = virtio_media_enumaudout,
+	.vidioc_g_audout = virtio_media_g_audout,
+	.vidioc_s_audout = virtio_media_s_audout,
+	.vidioc_g_modulator = virtio_media_g_modulator,
+	.vidioc_s_modulator = virtio_media_s_modulator,
+
+	/* Crop ioctls */
+	/*
+	 * Not directly an ioctl (part of VIDIOC_CROPCAP), so no need to
+	 * implement.
+	 */
+	.vidioc_g_pixelaspect = NULL,
+	.vidioc_g_selection = virtio_media_g_selection,
+	.vidioc_s_selection = virtio_media_s_selection,
+
+	/* Compression ioctls */
+	/* Deprecated in V4L2. */
+	.vidioc_g_jpegcomp = NULL,
+	/* Deprecated in V4L2. */
+	.vidioc_s_jpegcomp = NULL,
+	.vidioc_g_enc_index = virtio_media_g_enc_index,
+	.vidioc_encoder_cmd = virtio_media_encoder_cmd,
+	.vidioc_try_encoder_cmd = virtio_media_try_encoder_cmd,
+	.vidioc_try_decoder_cmd = virtio_media_try_decoder_cmd,
+
+	/* Stream type-dependent parameter ioctls */
+	.vidioc_g_parm = virtio_media_g_parm,
+	.vidioc_s_parm = virtio_media_s_parm,
+
+	/* Tuner ioctls */
+	.vidioc_g_tuner = virtio_media_g_tuner,
+	.vidioc_s_tuner = virtio_media_s_tuner,
+	.vidioc_g_frequency = virtio_media_g_frequency,
+	.vidioc_s_frequency = virtio_media_s_frequency,
+	.vidioc_enum_freq_bands = virtio_media_enum_freq_bands,
+
+	/* Sliced VBI cap */
+	.vidioc_g_sliced_vbi_cap = virtio_media_g_sliced_vbi_cap,
+
+	/* Log status ioctl */
+	/* Guest-only operation */
+	.vidioc_log_status = NULL,
+
+	.vidioc_s_hw_freq_seek = virtio_media_s_hw_freq_seek,
+
+	.vidioc_enum_framesizes = virtio_media_enum_framesizes,
+	.vidioc_enum_frameintervals = virtio_media_enum_frameintervals,
+
+	/* DV Timings IOCTLs */
+	.vidioc_s_dv_timings = virtio_media_s_dv_timings,
+	.vidioc_g_dv_timings = virtio_media_g_dv_timings,
+	.vidioc_query_dv_timings = virtio_media_query_dv_timings,
+	.vidioc_enum_dv_timings = virtio_media_enum_dv_timings,
+	.vidioc_dv_timings_cap = virtio_media_dv_timings_cap,
+	.vidioc_g_edid = NULL,
+	.vidioc_s_edid = NULL,
+
+	/* For other private ioctls */
+	.vidioc_default = NULL,
+};
+
+long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct v4l2_fh *vfh = NULL;
+	struct v4l2_standard standard;
+	v4l2_std_id std_id = 0;
+	int ret;
+
+	if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags))
+		vfh = file_to_v4l2_fh(file);
+
+	mutex_lock(&vv->vlock);
+
+	/*
+	 * We need to handle a few ioctls manually because their results
+	 * rely on vfd->tvnorms, which is normally updated by the driver
+	 * as S_INPUT is called. Since we want to just pass these ioctls
+	 * through, we have to hijack them from here.
+	 */
+	switch (cmd) {
+	case VIDIOC_S_STD:
+		ret = copy_from_user(&std_id, (void __user *)arg,
+				     sizeof(std_id));
+		if (ret) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = virtio_media_s_std(file, vfh, std_id);
+		break;
+	case VIDIOC_ENUMSTD:
+		ret = copy_from_user(&standard, (void __user *)arg,
+				     sizeof(standard));
+		if (ret) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = virtio_media_enumstd(file, vfh, &standard);
+		if (ret)
+			break;
+		ret = copy_to_user((void __user *)arg, &standard,
+				   sizeof(standard));
+		if (ret)
+			ret = -EFAULT;
+		break;
+	case VIDIOC_QUERYSTD:
+		ret = virtio_media_querystd(file, vfh, &std_id);
+		if (ret)
+			break;
+		ret = copy_to_user((void __user *)arg, &std_id, sizeof(std_id));
+		if (ret)
+			ret = -EFAULT;
+		break;
+	default:
+		ret = video_ioctl2(file, cmd, arg);
+		break;
+	}
+
+	mutex_unlock(&vv->vlock);
+
+	return ret;
+}
diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virtio_media.h
index ad05d7421..c1e68d47c 100644
--- a/include/uapi/linux/virtio_media.h
+++ b/include/uapi/linux/virtio_media.h
@@ -115,4 +115,47 @@ struct virtio_media_cmd_close {
 	__le32 __reserved;
 };
 
+/**
+ * VIRTIO_MEDIA_CMD_IOCTL - Driver command for executing an ioctl.
+ *
+ * This command asks the device to run one of the ``VIDIOC_*`` ioctls on the
+ * active session.
+ *
+ * The code of the ioctl is extracted from the VIDIOC_* definitions in
+ * ``videodev2.h``, and consists of the second argument of the ``_IO*`` macro.
+ *
+ * Each ioctl has a payload, which is defined by the third argument of the
+ * ``_IO*`` macro defining it. It can be writable by the driver (``_IOW``), the
+ * device (``_IOR``), or both (``_IOWR``).
+ *
+ * If an ioctl is writable by the driver, it must be followed by a
+ * driver-writable descriptor containing the payload.
+ *
+ * If an ioctl is writable by the device, it must be followed by a
+ * device-writable descriptor of the size of the payload that the device will
+ * write into.
+ *
+ */
+#define VIRTIO_MEDIA_CMD_IOCTL 3
+
+/**
+ * struct virtio_media_cmd_ioctl - Driver command for VIRTIO_MEDIA_CMD_IOCTL.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_IOCTL.
+ * @session_id: id of the session to run the ioctl on.
+ * @code: code of the ioctl to run.
+ */
+struct virtio_media_cmd_ioctl {
+	struct virtio_media_cmd_header hdr;
+	__le32 session_id;
+	__le32 code;
+};
+
+/**
+ * struct virtio_media_resp_ioctl - Device response for VIRTIO_MEDIA_CMD_IOCTL.
+ * @hdr: header containing the status of the ioctl.
+ */
+struct virtio_media_resp_ioctl {
+	struct virtio_media_resp_header hdr;
+};
+
 #endif // _UAPI__LINUX_VIRTIO_MEDIA_H
-- 
2.56.0.317.g454f8302e1-goog

