Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1217A374191
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632291; cv=none; b=HWYHDW72va1KrYsYvPdDZ+Gse6DosLTDvQvBc7I3Ek8OaRbTNn5yadFO5K0g0kypTbcih74bRF5Cyh70c0/tqFTx3qhk6Lah2X577unK4KTY/9niIw1zQN7Oone9A94YQglvAMrQt4tcuguk3H5+h3mMg+QpXVSTAmW8p3CwTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632291; c=relaxed/simple;
	bh=2qvxf/62yttfNIZNAODh63qlXVSL99Ksrx5/ufwbejY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=DVSBOOui/s5wwh9JChd5cUQh7xzE/DZJjhCpG4lfwqelzzDjdx/R7gSocRSvUoKfcUvw3FtA5N/IwzcA/yNxFr0DzEl5HPvVl+Ddh+Wp57pTiondWmk8G9TwAuFN8q/duYOt7F9QLOyOyGgzzkQSXV/pWc4AD/bqs2MdSgAHoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUXXe7xE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUXXe7xE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769632288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=6AqTWTOgRm78zpGWundx5DPK3QN0XJ8tGQTS1p8e64k=;
	b=XUXXe7xETErab3wRuyukJ0+lVBhbKkaCcNv8QLKZwc4IIIOHcz3YCrmR6f3vNH/wlZJpjk
	RnC4h+hm/NmAXYcWToR0nweZcgFZTxuS7xUNA6G2dCk/ERzre7e1N9gkt+KnsEx7+IwE5O
	OR9QHTRzknUlppVd6rQJVsvP5dNvT5I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ryVUMIs-Mam_mETG-lKR0Q-1; Wed, 28 Jan 2026 15:31:26 -0500
X-MC-Unique: ryVUMIs-Mam_mETG-lKR0Q-1
X-Mimecast-MFC-AGG-ID: ryVUMIs-Mam_mETG-lKR0Q_1769632285
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so2289915e9.3
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 12:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632285; x=1770237085;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AqTWTOgRm78zpGWundx5DPK3QN0XJ8tGQTS1p8e64k=;
        b=QC1+c75dE8kKYeVaTUoItSt5sy61/itf3Cclorm1sqHFz8jCJnQ6WEZTRmXiBc6i8o
         gMVG1ZUDzMPQYydiP0CC3BB58q/Y3yVvE51xVMyOy2NqWS1XDd1+F2nSju9URGP4AB3E
         Wl+5r/U6aCuHts7GP1T6+ME3IwTElef8bQTO0CSu1pjVfCYEhsT0BWed57o9cAgl1mwz
         HZdfMdHHGEBj8WaWqCTZX64S4tyue9wT/ZZrGWueqldvd8X9X70XYrcdbmv3LkF5fkA2
         aXdh77ifS7aLmBv/PO40dBYwyLI+TFpjnh0Zllq6u7V1JawODNrJ+mZk9/iLh4bmWsj9
         kyxw==
X-Forwarded-Encrypted: i=1; AJvYcCWYtgE3V+NsTN7zeMPn/n9HbBApTTxT+EZ1y+SmF9HkCFPiJKHqtwD+U9hbb0AgPaEGbibJqvqaDvyBr0fw+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd7uXelTT7zpgZIUUn55JDYyDSzivEQ9H1mqc7nhJIqJd2v6WD
	5NwqNM83qfkQJ/t0EhxzX4rkT5AVaY7Ygj5BURfq7kPP1XZjZ53ASBFUkpc2Bhj1k/mNXE3DtKh
	TVwciSEc5gFfbW/DQguEQwIvXxxLHGbzmMtiqAXVynOPJwSaMNDFebzaKTzyFP1Or7zD6
X-Gm-Gg: AZuq6aKyQKOYrwHifp6YLLcTLNCKOV6sJgLG0VznEpKm8aKICyno8c2g2iYhleMu4d8
	ArZfMwCk+Z5A9lTTszsPHBgidIob+bp4zNQosMBzz5M1Mvgvesr+nXnvXSsicYOgCcS/M/dq3Qy
	fyUvJVjmSnSVXsmOsL+7SyWgBP7zOW0F/UP3JBlJ1aB1uTBiHrbXMm2M6znqwJ6oNZa9/Zs3L+h
	iY7YLxMY4v0k57eU/p8cUzYJV8lT/MEFz6wifjUFlzl5RHQE1nleISUHD4B18rFDmBZtZFPbEho
	Z6SKwaUO3VaDcM2zp7IljuXHX6zKaqzpojry0oluya49dw9nEqoQVlFNhcMrhegdtDFqQdhGd0g
	/hwwXhSyiaawdOe/osad69AKXxO4g/r/mxw==
X-Received: by 2002:a05:600c:6995:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48069c92c03mr93433835e9.31.1769632285340;
        Wed, 28 Jan 2026 12:31:25 -0800 (PST)
X-Received: by 2002:a05:600c:6995:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-48069c92c03mr93433305e9.31.1769632284808;
        Wed, 28 Jan 2026 12:31:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066beeaf9sm161529595e9.6.2026.01.28.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 12:31:24 -0800 (PST)
Date: Wed, 28 Jan 2026 15:31:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 15/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <ce44f61af415521e00ab7492aa16d3d19f00bd5e.1769632071.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1WWTuzUlChkOWcYcjRJm_tvJazGchHRM4SaOVAIGvKg_1769632285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
last. This eliminates the padding from aligning the struct size on
ARCH_DMA_MINALIGN.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v2:
	move event_lock and event_run too, to keep
	event things logically together, as suggested by
	Stefano Garzarella.

Note: this is the only change in v3 and it's cosmetic, so I am
not reposting the whole patchset.


 net/vmw_vsock/virtio_transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 999a0839726a..b333a7591b26 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -55,15 +55,6 @@ struct virtio_vsock {
 	int rx_buf_nr;
 	int rx_buf_max_nr;
 
-	/* The following fields are protected by event_lock.
-	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
-	 */
-	struct mutex event_lock;
-	bool event_run;
-	__dma_from_device_group_begin();
-	struct virtio_vsock_event event_list[8];
-	__dma_from_device_group_end();
-
 	u32 guest_cid;
 	bool seqpacket_allow;
 
@@ -77,6 +68,15 @@ struct virtio_vsock {
 	 */
 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+	/* The following fields are protected by event_lock.
+	 * vqs[VSOCK_VQ_EVENT] must be accessed with event_lock held.
+	 */
+	struct mutex event_lock;
+	bool event_run;
+	__dma_from_device_group_begin();
+	struct virtio_vsock_event event_list[8];
+	__dma_from_device_group_end();
 };
 
 static u32 virtio_transport_get_local_cid(void)
-- 
MST

