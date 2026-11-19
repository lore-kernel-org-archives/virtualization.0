Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089787;
	b=EJmtJJmVl4auKS/u+k2Hce2QSnP3YlDKP4rT3Qv4R1yZ6rgMkB1GYfv0J9IXila1O0MY
	 /ytckwRJqSf97eAsR//EDnGY2lTP/m596WxMHJ0P4yvPXpf3lsEPRlF6MnOTrRgO6mg+s
	 r8u6klkHqiCC2CE5UWsCqwERXcdPEAaIF++Dmaqx5KyKPicTfd1kwD0hNCL69OAaq/h3B
	 M4736fU8ciRI2iLD7WqXE4DUn8bwZ/rlAtbr7QeKDpGBJtklH3PGFhAXTWNmhpkXTLeU3
	 zSYWXEurVLKKGkV9hYEDCfHL7CZ+AOyF6j9ePLu8aNj3tSpF3GjBkvG96dhdr3lyywQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089787;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=VZKBiBZ5EwpyOapUDbG3ayhblSKLTElB/6S59DDHCAw=;
	b=c8XmtamBK2DcnMg1fX24YyenQTJt1Z9CaeBq8/abnaS/etpI24ndMT9nDQsDJn3HeCkL
	 p7MISnqBYdI5u1MswosSAm0wKU/V0HkLsxsRn2hNxT9eXNdShgBqJ/v/FIrPnd5oJtW1q
	 dNpOdezcmxuBgiQIqQN075xXHfZW9dazTzp/vKmGZsdfEt5xod3+D7lADLaNvBMKGLvOC
	 tOV4iRkYKl0kcA/CFCdb3Rkzn9utYgSHvzjiD30Lsd7Y6DF79tqkgsFR3l+de3uKilKFc
	 t2MoAs/1RUOd34vaz0enJo8a5J5v2Gki6B2nHPLklv9vGAS7MIrsgBoP4xabG83lt0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="hxmeRVj/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA2606A32F
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FFA2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hxmeRVj/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZKBiBZ5EwpyOapUDbG3ayhblSKLTElB/6S59DDHCAw=;
	b=hxmeRVj/Ab8q1ncCqWCzhLQP5voT/v3EPfiMg+tHTK3snytqbZlfCxisYYDhJqIqKVi5ko
	nrivAs27kqtcuExM3wPqcrorm+FFI1U6GiUSxyUaFOnYcsAu2psLP9KRn1UzlEI+uiL5va
	K/uNGBjHvxBbRmKYXRzLWQ1rJpdXa+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-q-UqNeLxO1OwIoKpsheWNA-1; Thu, 19 Nov 2026 07:03:02 -0500
X-MC-Unique: q-UqNeLxO1OwIoKpsheWNA-1
X-Mimecast-MFC-AGG-ID: q-UqNeLxO1OwIoKpsheWNA_1795089781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso17092565e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089781; x=1795694581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZKBiBZ5EwpyOapUDbG3ayhblSKLTElB/6S59DDHCAw=;
        b=IKLb8ggSYOGPIN3J+qq6x599N0U3TjG0bgVwpKVeiJKuw8sSVWcrhlw9rGpPevx6lf
         +Kv1mDrH1hDsp1Sae8aRj/jMtaB4C1uDtr0O7GcSesUKiRp046W+V17A9s47KT8zdLc5
         btYajmfoNxHmAnJj47ddy5p61+LIOJz3VLO8jQBg4kGv4hhjjDGkID4mvGWzW0ScY52p
         1zN/+XmlmCGAc7FNjrnl8Sc/+Ef6v39i1LbJ85pOG23pkBCIbXBulzNU7YQ2Ob8aizXW
         QNgnzbJwfPohKvJYux2czRH/4iAIMycEGUweHkJliZidjkZWyXjhmsvULx9WnefEOiiU
         rnIA==
X-Forwarded-Encrypted: i=1; AL+hErGHtO1pEMEmEfIUWMj1Veog9P0bF8wzK7eWWcF1y3VvhmU5FC9hf4XxcKYrwHOJzAyIBlysrhv05dXlF/c4tw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8WjnCTNm0NMcx97CPtUqR3Aa+DVTKLtjnW5w3WADa43MFK2mYJ
	OmuySKb0e9xW8vmYAhVrfkKtslzMOOuNj1poczzbmbsnuzfBSgGu3TQ6rJEc/RM0YdGSNSs0J9I
	aqUzXBUuc7uWo/U9T24aibuCSr6RXUU5H1Qn1+pt560zv7AlTzvvtfREtJd9v2JIF/2uB
X-Gm-Gg: AYBFou3a6ypSTNinoAReanZLf/sM5vAOfKaiBXtOyc2I9MZdpe8VSMQv6ZHh/n9ol2J
	0kd/muainRyx/Iv2ZIM14++MpJYpw9UiFzpDhrqrbSAC+ftlGtnxakoqTe8tFdzTDF3v+GCaolN
	u/sG6JmpbNBUq1uHJ9BKYivLff1iM1+7rDL4llJqK9ikvtduUB+GYlfiPC8GzjS1TYmUcD/PIac
	LK1OUfLZUns/GTL+qAdffbVmikozcA9Xtm8Objv0DQF/R7PM590ujTE4VmJuaQKe9FOe8x1YuTV
	ZC5Neky80GHMBt5ftpBX394Gq9NAoaaEaTkyzRDrbBzv0IWK+BXAuewQUYoP3g26FknvFJSleiU
	DZqfQSgBL3ryTZMsEGf4BJfWl2lfTJ+/O+WpswLnrkng=
X-Received: by 2002:a05:600d:6507:10b0:4bb:8636:dd7d with SMTP id 5b1f17b1804b1-4bb8636dd9bmr16333965e9.24.1795089781184;
        Thu, 19 Nov 2026 04:03:01 -0800 (PST)
X-Received: by 2002:a05:600d:6507:10b0:4bb:8636:dd7d with SMTP id 5b1f17b1804b1-4bb8636dd9bmr16333235e9.24.1795089780568;
        Thu, 19 Nov 2026 04:03:00 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526541fsm46002405e9.0.2026.11.19.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:59 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v11 6/7] virtio_balloon: add DEVICE_INIT_REPORTED feature
Message-ID: <65c518234ce31fac3f6ed436455dcb415d4b1189.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7R_DKnSCSURmTXQ1HarubE4t6n1gdwjqhuYspRLLbYc_1795089781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED (bit 6) device feature.
When negotiated, the host zeros reported pages on reclaim.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 drivers/virtio/virtio_balloon.c     | 33 ++++++++++++++++++++++++++---
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8c1b47ec17a29..4c6630c5f9599 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/cc_platform.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -205,7 +206,9 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	struct scatterlist *entry;
+	unsigned int len, i;
+	int err;
 
 	/* We should always be able to add these buffers to an empty queue. */
 	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
@@ -221,9 +224,24 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	virtqueue_kick(vq);
 
 	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
 
-	return 0;
+	if (!pr_dev_info->host_zeroes_pages)
+		return 0;
+
+	/*
+	 * Only a fully initialized batch may be marked reported when reported
+	 * pages are treated as zeroed. A short completion does not identify
+	 * which pages were initialized, so reject the entire batch.
+	 * Subtract each entry to avoid overflowing a total-length accumulator.
+	 */
+	for_each_sg(sg, entry, nents, i) {
+		if (len < entry->length)
+			return -EIO;
+		len -= entry->length;
+	}
+
+	return len ? -EIO : 0;
 }
 
 static void set_page_pfns(struct virtio_balloon *vb,
@@ -1043,6 +1061,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 #if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
 		vb->pr_dev_info.order = 5;
 #endif
+		if (virtio_has_feature(vb->vdev,
+				      VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED))
+			vb->pr_dev_info.host_zeroes_pages = true;
 
 		vb->pr_dev_info.capacity = capacity;
 		err = page_reporting_register(&vb->pr_dev_info);
@@ -1189,6 +1210,11 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
+	    page_poisoning_enabled_static())
+		__virtio_clear_bit(vdev,
+				   VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+
 	/*
 	 * Disable indirect descriptors to avoid memory allocation in
 	 * virtqueue_add during page reporting.
@@ -1205,6 +1231,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a372805d4..17de46c629c2e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED	6 /* Host zeroes reported pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
MST

