Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058817;
	b=R4gOaI52PJ7DRQXvdhxko0RVSj5ApMsl46qZeeyXM6DAArnWUb5NONI5I9MC2evAN91j
	 l8SspbDz3GAeW4V4uxksTJTOpjq4zAf5S1/JI+uZDOKPF3oXY3l/KtGSWd5bhuq034ZqW
	 uiXV9Qbtn1kUvil1PaP2339x579Q7dsuUfk5/+vUBq3ub2vHzqGpoPi1Lr3wOXHMdQF2/
	 7Cvc7AJ+iJYysNkQUfb+ivuKeG6v5Vc54/r8D7ZHKLyw0iwNn82nbm2vAr8fHXUMWkkX6
	 RDAsEiwCK0C1C52UyeycqIKbggHG3Ji4M1qfHyafUX1Jny9PukNI0dClyCTanfGwqag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058817;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=aHUF1M+fidDDJ3+WmYV9zM0U4gJMDdswMRaltUWboIo=;
	b=cr5OqmmmXKPg48sDS3t+ofQ4aj5FkaW4Qsf5+igAlYjmZXLelZAmhy+euo2QiSbLHbNS
	 eFtQiONjQZZ/o6EtxxDvYA5mh/VCicJiHNbtPbN+AR9Y8s33dkefmNborBO5VKZEYvtyS
	 +4sSMW6pqwbpZQD8iSCTXzeWhx9X9P7Ej9DQV6O46Af/ZmknXfovNC6kcm5AGrt1mHgV6
	 Jf4J8bQQ51GBSmtgq6UixwdhHpXg/TuUrrhG+b/KHOtFrJRvO3wTkhrGg+T30bzVtCSdM
	 Ltk58fazkDN44iyR6EXbfcKf3CcQwyV7DjS1G2mDSK87gExzn097mibjqWNHkl+406A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Td0BjPVH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36499606A329
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 23:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36499606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Td0BjPVH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793058816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHUF1M+fidDDJ3+WmYV9zM0U4gJMDdswMRaltUWboIo=;
	b=Td0BjPVHV8L99qccxgDXxISwV/v/3qs1kTSquZ81z97CDmjMSkWPoONcbyWZM3sGqT0oDi
	GQ7OFrlk3ZFXzRMCAirjEzuRR+TsoswPkmhHPqwJh4pAemyDx4583+3RD2o5JLkm/8LB/I
	gH4tW+Rim9Eui24lUdsPiThlzhJ9AKI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-7mRvdbIINS6TrsbieDuLFw-1; Mon, 26 Oct 2026 19:53:32 -0400
X-MC-Unique: 7mRvdbIINS6TrsbieDuLFw-1
X-Mimecast-MFC-AGG-ID: 7mRvdbIINS6TrsbieDuLFw_1793058812
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so26408825e9.2
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058811; x=1793663611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHUF1M+fidDDJ3+WmYV9zM0U4gJMDdswMRaltUWboIo=;
        b=fj2yvV48/WJjhWzChIxDMAMkf949GR7/Zdk6gu3/cjGpL8ngXFskzTYKE2pLLS4uON
         7l0Qk+i4X1lu256L8xMi/6D5F7/3FKbEG66BaRXKiYxsV/5Lr5bcFlI5Rvc3eyW+yQSL
         bgMrD49Z33u/G5K+OUKeHdFv0AALZApwjgsVsGTTlyyH+ssnq4Nb5jldllQGc+Vur9Fe
         d1Vzg4z8VomzU2LuO+YqP92igGDW4t2eZNLuhFV/Kicj0hYvGcLPFmbC+OyXYxfVWZ7D
         U08+3zde/NoaWT6OKWoF4Gc1zpQAnKnm322Kk7A3rllKq7gRwiPBQwIYkuuoMOUXznNf
         vCbA==
X-Forwarded-Encrypted: i=1; AKwUvBxSrSqu5FfC5xfRzrQfEHLPNyu+uPqSQ/vk5T6xAeYRO3VskHkkMfyalEVMlFH7Ajia/8Vc3KHw4y6HpDBqWQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIy4QVTg1g7q9X0mrOQ0EbtWdphf3aAxCfGILWPLDByKhHfXw1i
	Kr6KS/D4vo5Tt3Jaq98UomF4TYnqr2AFz1KQWWNY71YIIRSUMUsQXe5X0IFG9cVIZZxCczDlcbF
	jJU8gk1lGS46rIMC1Hqu75gxtxCLVw8sGrZFXLPHZjBV3udgZPW+fimz4lRgfDZW6a16K
X-Gm-Gg: AYBFou0i9LVGYdINN9UXXJlP62gVLu9QyDfDXcpSVEgRmuJSlOuPpLbBEYKYmjBwk1F
	xc+8d1Y+f305XAcrLuthKkf4h+L7c1wVvWkZIQinklFWV/6Xzyx1U2HlAJE+71qLGsv/r3a4iN7
	lAk0yMRLdpJ+mpLJjYMby+gMzquIV0ciAeW2jV1A/s/eZXjOE8pInBlf6SDIK9UqDW55cGHE/m9
	IZM2kNRCBnf8oa1lX7UGcGJTbMv+AbpZ6SBweB3ES4LRGCMLd0wmhlp0bJHJfctmXCZ8P4ohegH
	PaeCZZnZuJDqWJW2+c1Y7cUThTf/ZAoGHefCpzmgGombPROwwKX9818Tkj/GSqpvYtw=
X-Received: by 2002:a05:600c:3114:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4a35acc772dmr152484425e9.19.1793058811504;
        Mon, 26 Oct 2026 16:53:31 -0700 (PDT)
X-Received: by 2002:a05:600c:3114:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4a35acc772dmr152484055e9.19.1793058811049;
        Mon, 26 Oct 2026 16:53:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a0e2sm280919645e9.13.2026.10.26.16.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:53:29 -0700 (PDT)
Date: Mon, 26 Oct 2026 19:53:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Ruben Hakobyan <hruben@meta.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 2/2] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <02257263433b001cd0a55a52486857df81dd4246.1793057483.git.mst@redhat.com>
References: <32e21059adb6cb1fd08c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <32e21059adb6cb1fd08c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AcC6OeeXiI9IqDQf471BU-rGsRtatTb1VEYV1OkpKmQ_1793058812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The virtio_balloon driver reports a scatter-gather list of free pages
to the VMM so it may discard unused pages.

For an arm64 kernel with 64 KiB pages, the default reporting and
allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
report contains a sufficient number of large entries, we will end up
with a descriptor chain that represents over 4 GiB of memory. This
violates virtio spec, which says:
	Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;

Specifically, submitting $2^{32}$ or more breaks Rust-VMM.

Submit each reported page as a separate virtqueue buffer instead of one
buffer with an sg list of all pages.  This also avoids indirect
descriptor allocation (kmalloc in the reporting path).

To avoid multiple buffers causing interrupt storms, keep callbacks
disabled while we wait for an event.

TODO: as an alternative, keep using virtqueue_enable_cb_delayed
but add buffers after there's space in the ring.

Note: if the virtqueue is broken, wait_event on
virtqueue_get_buf hangs.  This is a pre-existing issue:
the old single-buffer code had the same hang.

Reported-by: Ruben Hakobyan <hruben@meta.com>
Cc: Ruben Hakobyan <hruben@meta.com>
Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    changes since v1:
        keep callbacks disabled while draining: get_buf re-arms the used
        event for the next buffer, reintroducing an interrupt per page.
        Disable the reporting vq callbacks at probe, and only arm the
        delayed callback to wait.

 drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f6c2dff33f8a..b88b463488e0 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -202,25 +202,53 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
 	struct virtqueue *vq = vb->reporting_vq;
-	unsigned int unused, err;
+	unsigned int i, err = 0;
 
 	/* We should always be able to add these buffers to an empty queue. */
-	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
+	for (i = 0; i < nents; i++) {
+		struct scatterlist one;
 
-	/*
-	 * In the extremely unlikely case that something has occurred and we
-	 * are able to trigger an error we will simply display a warning
-	 * and exit without actually processing the pages.
-	 */
-	if (WARN_ON_ONCE(err))
-		return err;
+		sg_init_table(&one, 1);
+		sg_set_page(&one, sg_page(&sg[i]), sg[i].length,
+			    sg[i].offset);
+		err = virtqueue_add_inbuf(vq, &one, 1, &sg[i], GFP_NOWAIT);
 
-	virtqueue_kick(vq);
+		/*
+		 * In the extremely unlikely case that something has occurred
+		 * and we are able to trigger an error we will simply display
+		 * a warning and exit without actually processing the pages.
+		 */
+		if (WARN_ON_ONCE(err)) {
+			nents = i;
+			break;
+		}
+	}
 
-	/* When host has read buffer, this completes via balloon_ack */
-	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	if (nents) {
+		unsigned int unused;
 
-	return 0;
+		virtqueue_kick(vq);
+
+		/* When host has read buffer, this completes via balloon_ack. */
+		i = 0;
+		wait_event(vb->acked, ({
+			for (;;) {
+				virtqueue_disable_cb(vq);
+				while (virtqueue_get_buf(vq, &unused))
+					i++;
+
+				/* Stop waiting if device used all that we added. */
+				if (i >= nents)
+					break;
+
+				if (virtqueue_enable_cb_delayed_max(vq))
+					break;
+			}
+			i >= nents;
+		}));
+	}
+
+	return err;
 }
 
 static void set_page_pfns(struct virtio_balloon *vb,
@@ -635,8 +663,11 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
+		/* We re-enable callbacks after add, when we want them. */
+		virtqueue_disable_cb(vb->reporting_vq);
+	}
 
 	return 0;
 }
-- 
MST

