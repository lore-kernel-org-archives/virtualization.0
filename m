Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027404;
	b=Hu5Ou6UABquToj42LjgpaAPS2VNs1hRFzsL6RRvs0/jDXq6PJTa0RyhTrb4nNp0xoIpu
	 VknumavDQayyNvV0UPPyJfHtRX/ZXLc4IXgy46jQa6Wrn3uFgzubZseAUgHUgz3lqAD7L
	 D5B/YWtMypum5OtFPrAidEy1jI2Yh5KV2BlLkPFXKkLE3SYKpf4UcBd6sqowr1n0ENm7h
	 KlvnY/yddtcXXfTIge8PHGNaQ7zCXgajal1ICnSWg2CEq/tJiaHoZr0UvEt2BFWTQzImV
	 qDiy0zIhX4kbradNGx6Q3GRCBz/7toeYb1Bap1fViJXTMQJeXA3XeU6zf7tcemMf/bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027404;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=hdqkyE3cMmVjZdiqL7neZ4CIjAaefrQUqkPMqmDXm1o=;
	b=0QjJPNmNEMIyTgTOEFTvTqT1IxGDspmVtKXEMq53Kff9aWGU7cCQ2ni+fjP3P3Qhwzww
	 5WrB5oTPzjqSHzUXmUMnUq169iv1Kwfce78u8Ipgzy8qkrnNhR158x2ysMOsEtykWy1Rw
	 OV+9QZCEvqIB9sV1oa5SqNxAQ6G+ej1AwGaieo+qvVw0vZC/LmV8Vjivm4/Egb7uaNmIP
	 XzMqhuxLRbC1/mi7OYdF22HTSd0wR0m0lpRGQE1RIdTE4nOr10UrR5Tw+qi6UIdm1z0iL
	 FRmfVUR9utVqQOBYj5qrvwH7fWV5Qi38p22moF9oGG/5cJRA2t6N0cuIf4uNtmjE6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JC4gY4O3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1D606A31B
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D1D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JC4gY4O3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793027402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hdqkyE3cMmVjZdiqL7neZ4CIjAaefrQUqkPMqmDXm1o=;
	b=JC4gY4O3Fm57IeFYUYuGqLs5NkVFkPz8bM3ZVdPNXXdkYuwhgE/ARKEdjmUF2awr+iuqHw
	A/navDOFvsCZ9O0WlpcROPnCp4hPwjFReaRrBX1g4iOejj2evXaquO3BF0pmpyPWhizy6s
	nK/RP407mI1Z3MhdqeooY0EPICRDh9o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-qZo7zp92MQGrAZc2v75t5Q-1; Mon, 26 Oct 2026 11:10:01 -0400
X-MC-Unique: qZo7zp92MQGrAZc2v75t5Q-1
X-Mimecast-MFC-AGG-ID: qZo7zp92MQGrAZc2v75t5Q_1793027400
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so1721667f8f.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027400; x=1793632200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdqkyE3cMmVjZdiqL7neZ4CIjAaefrQUqkPMqmDXm1o=;
        b=LwYednVnXxxxCyWgZoy3cMEVQ+dbIxptunlt0bKt3eTdD4gzBC5RQ57uG5tUKd5SsK
         dYlmwizOOEs/16ekJgqZSWrwap5nBT8umjp5bhAvKphtGiSe0RwoExvsf7u6tPEQQ/3w
         idSn5dpf4P2vGU+I+hx9x16H/lPquo5NNZg4MHt6r9cF6pSrqG/IRvPP0zXwXOmIC7+D
         9lKMNGo+mdOoT1sUDBsxIRDxqWUnl/6KM3dVmYq77ndrxkkgN2Ye5oFvC4LqbzwRGA2K
         FdB/i+dCBAe06A8h5wqSHxahXLO9OjItd8OdEWbog39qRUOvFNt8WimbxtdcXz1MxbZn
         UVSw==
X-Forwarded-Encrypted: i=1; AKwUvBxggVBZhSTJaR6smEq3sxlZ09wzj4mO6fJsN2XLpO9slmJSSfTVNJCP4LigB6eE7f7GDG474rN7zMBplvZ7Jg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJTBm5bZGdj1x5f1ODmZ7SjiygGgxQy6hQ50l2V0AWn+woqBwOF
	3kgfW9w9vmgKJq9kZHJU3LvmELXjxwXedfafdtZsJByNt6YbFmL4z20748FrCT9jfPKsNmA+4XK
	UgpZfqvG44XGC0+9DbY1NM6KsNEz8VQ6D47/6TWER57eDg//93A3sjvRl5UnyTTBFNOJT
X-Gm-Gg: AYBFou2YYYuuuIrjeMamS6AS4HtUoZ2+hPWG8i+JbzSBI/2WMil+15W5TR47wHSUbce
	jJ/y/PBDJHyLA9jocEM1KaLbD2hINr/Wj7SWJwrfOAH/qBG0qNZ/b61tpbAUlyjXsToinlpDD4L
	qDp9VUx4yrsvH7nyZUiP0KyY9HCeQNzzCRZm/QVC2jL5bQyvZyS2y8gTa2pPSXcVUMmpupZW8JR
	Wq+H1JnEXAm8HrTAkCp650vPc396x3ifvA2ZmTlDvj011GPkCAc+f5GimdgDtDKEvMJC7o8l2q4
	qzj9cX1RupfU+yZuJxaValEsFtROSibPAsFRET2jPKDGuYeYE52uyRcRKrIHBCDA3YE=
X-Received: by 2002:a5d:5405:0:b0:48a:f0cd:8712 with SMTP id ffacd0b85a97d-48e3eba30c9mr9661359f8f.50.1793027399441;
        Mon, 26 Oct 2026 08:09:59 -0700 (PDT)
X-Received: by 2002:a5d:5405:0:b0:48a:f0cd:8712 with SMTP id ffacd0b85a97d-48e3eba30c9mr9661300f8f.50.1793027398857;
        Mon, 26 Oct 2026 08:09:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb902sm17773862f8f.24.2026.10.26.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:09:58 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:09:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Ruben Hakobyan <hruben@meta.com>,
	David Hildenbrand <david@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: [PATCH 2/2] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <6668d51dbda117d05d2eddd47db6ad69baab8b0c.1793026707.git.mst@redhat.com>
References: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HcnxM6GMK63fhj4n5G_pzWHSdCar9_TIa-fh2XxxZM4_1793027400
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

Note: if the virtqueue is broken, wait_event on
virtqueue_get_buf hangs.  This is a pre-existing issue:
the old single-buffer code had the same hang.

Reported-by: Ruben Hakobyan <hruben@meta.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested. Ruben, could you pls help test?

 drivers/virtio/virtio_balloon.c | 48 ++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f6c2dff33f8a..363519fa890d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -202,25 +202,47 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
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
+		virtqueue_kick(vq);
 
-	return 0;
+		/* When host has read buffer, this completes via balloon_ack.
+		 * We report pages as individual buffers, so arm the callback
+		 * to only interrupt once all the queued buffers have been
+		 * used: otherwise we would get one interrupt per page.
+		 */
+		for (i = 0; i < nents; i++) {
+			unsigned int unused;
+
+			virtqueue_enable_cb_delayed_max(vq);
+			wait_event(vb->acked,
+				   virtqueue_get_buf(vq, &unused));
+			virtqueue_disable_cb(vq);
+		}
+	}
+
+	return err;
 }
 
 static void set_page_pfns(struct virtio_balloon *vb,
-- 
MST

