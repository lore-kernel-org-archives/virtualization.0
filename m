Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661114;
	b=cLB9bZwqFHQwJ1KaTO3DyRxp3bcGZ1pR6XO/fKLxAP1atCWRudUe2ku38rEpmalSLNzO
	 aFtlAOs+ihTZdeEUtRd2l1L3GYujfy5vRPPIs8M8vV3ZkdZ/87ILxN+VJsj8PjE8sFgns
	 mlIJsWVzSWb7j55TeFSip5/NQ5N6ApMhtnFz9eC6L1RPzb57yRhsjD7YdcGP3aIkxOnwG
	 d9MmjL3n94oaALqwGMYFbsNmhfedcyDBuq4cf2n6UP2JLLw7Z/TDqoBtqf84rawdFe/Na
	 6Ea/wBjYM05r+euzv7n1NqZwk42GYR7Z8XwF5d408qnBJfcOVflx4JUY5EnqhH1X59A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
	b=XaleG5xMk8AN+ILs3J4jscVV+D480WRpl4KVYHzh5pTi5Rp5mYdQoAQfepRluwX33+B+
	 CX+qn6AKAlG+wz6lo2cnnlPJh0nw+4ziczyoZiNctCi+gc+JCnWeXd1v8YUKf+JB9uUD7
	 TNIOgG1KVq7Wt7Z3rVYbiL+U5TM5Uxqc+IPuMm9PyK0W+nPfcuzzNE9IxIDd62eIRW8zC
	 HaG7Dyea+B7sfPqemN6cF5FTPSxFySPA5ILAQpvenLp4+zzGsDbdwc/1vxWiY12MSDwor
	 U3I3UbImwsLZOqGjVSMDuQlDWekN3D3alEQ8D6VJpx3qyALZ2m2k4UzmWqhx0axA8zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=eXnyETL1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4D606A32E
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B4D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=eXnyETL1
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679aeeddc6bso6295980d50.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661113; cv=none;
        d=google.com; s=arc-20260327;
        b=Q44sMAV09m27dXnSpJcPeetLk6NH347pZruL1SBRsmAt83x6DG3V3UMY14AKqGj3ni
         Se0TpwTBxsCn4fCllsLPtmtCPPdx9apzBhMymmpRlFA/VKbRikakF4MQiIMQ60J10pHX
         gP3Y1Ds7voJv/fRUn7jSykcUv7WE3FoTT0m8yNN9JVAo2GJ82/d7vLYk3DV084DwHicX
         4QYg8Du8TrRLVLfy62iKzUaUg+0lp9JWvbfVL+oKgMDkMEzfn+3UGIFfOmo8yvSRxyjy
         VVy9NVic2fJ5yfPkDlGLbVe2Kw70X/RIF94O1jOOtSSHhbhJdDAuGgTC/LRni2nqrYfQ
         ACmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
        fh=T1SGKtYsL8uY21+zKsyJfZxKX4qiVkUDir2LmxlS/e4=;
        b=OYRIlhKuCdnV1mVqVcHvBYlAvN7aiOclD+UGWcH4rsRKy9aVxE/lyjPjgMJQCSUKRQ
         HsK6LnyK/TXWj948jOweATpyEoYyM80weOy0koVqNOjNz9eR75FUI5a1eOKSKkvM0x1D
         akkKkieQbvRRsOrhYQ6CoGjRo++NjsgCQpTWkvhAXfQAD37BJ3aHJJPLOuhzY1Na5d7a
         Avtt44B5VE6icmfLJUeXhHm7r0NdWkugTwQmnLkGip+3rwu6RGTYmldR0jmAF86e/95x
         IMXVqYsAiscrZhY49N5Uo6gRjnCEw3KDAy3rlTLwp/ttTaQ4jUvbxbPsLDpuHX/sz/ar
         37bQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661113; x=1796265913; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
        b=eXnyETL1FRE5INrDPf2wfXoEKpR4znaYA6VNFWghPDyejmeKtx5sdDEKack383yGQP
         j5AqUCm53l6HRMiEw7kVgqf4o9u0aqlx8CGAsK6iP7Vyfi/77QDs1ntsDHzMSVNjnE/8
         0qmUEKTaJ0hfK0C1FgTznhgZRplnTyTNzMWkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661113; x=1796265913;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
        b=g8+sQSZ6myKwBYwRRqjl7fAPQBGxNSMCHjwc7wpzpEXNv+ohKkX5cyndg5vI4/eZXM
         PFfQzSIXGsRf2kbW0+0cXaqOQMn0IOP2oZMYkzZB3Scuhim0k7Reok54kQ+RTGig5B7x
         ajj0J7OXn/Pthjsof2dC7AK7NizATAKvjNVhKDlNKAsjtc1DVsDRhN/uyQ35+35qfVeE
         LlDVlNPohVl91UYalm691RAUbCtKYmLPsMBxw5m2yK4Q3G80y3QgMpJ15qOBx7g27iNU
         ov7fxlH5MP0AEIxjZvnvKSZ/BiqUj2vKpBMvODZXI8Tmxla0szSoWY4p2r9N8mVJcixr
         CFIA==
X-Forwarded-Encrypted: i=1; AL+hErELBX+nNk0sMZqZKOkGYpRXOKgQcHOtdEZnaQVktCTj+ksVYir+NvWTwuAEO+dUC9Z010Js7Sk2uBKdzqT0Rw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/PSbHYhqNP71nzPUz2dFZ+eSlSSgEVbknUH6/YQfSBdc8b4WT2
	CS96W2Kj1GXIwWLSLQLi0/0eSjgh0H8n3yzLXLa/ZjyxvKnRW9oY6meSK4haL6pLhMiTnoChzZc
	ai8eQ8pdeV45WAeinaKEXJ7ZBY417uD+/iuZZn4QvWA==
X-Gm-Gg: AZFdTZdpRX2DpKf5mwUbVe/DqXiLOkpReyTnNQbWbdIfne5utDq2PFLy3TOREM3iPka
	EzLoDnUk9BK9oU44jLA91fGQrJRng8a6sxAMSw/HHQvyLNVg911C0xnhK42Bj0EQmLQC95Q3zuH
	uOXEOL5ySKG2Gmx4WvHSaF0aS5UwPkYf3e5bOKLnjN7Ys8nd5DNy39zUCZHz01zst+2h7Du2FoH
	vZiqaa8WkL08VvMdU4gum34OB+oKgHNLFrpd7t3AZXE9kyGJpXvfgrrMjwo/G7+3Qd7uwV6kl7O
	CKXXMpb4VNJoW72dIPCnVIJhh47PGdI+MxrAgL7M0bbBP3ffhm1IupLIm+bkSBKn3YybToC23Ap
	kkukyJKCcBc+PZqAMrcctfs83sSPoimteTQqB0hTIzMyWW/+1eoZqnAj/wV9RQKHC/4MmqfharO
	kJAtr60wIBR/mvMIGgo+7Olm1lefjqe8djwEQde6POd6T6MlZESdXW+Q/zRcMFa6p1QrWcDJ6M1
	JflxQP2F+FKkKaIgqBiKNpXKUnC5QC0Bg7f
X-Received: by 2002:a05:690e:419a:b0:67d:b673:101 with SMTP id
 956f58d0204a3-67df44dc404mr5165849d50.84.1795661112974; Wed, 25 Nov 2026
 18:45:12 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:12 -0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:12 -0800
X-Gm-Features: Aa3M54pIe0_40ib3Wr2ZZ2KWGpKerFTo6l3_rNQezi8pNSta7xAy8v1Ghx_XCsY
Message-ID: <CAFaZ9eopsb3vgcpzOjiZ500oafv02QzNV3dEUrvOMN1vV90RuQ@mail.gmail.com>
Subject: [PATCH 6.12.y 3/4] virtio_balloon: factor out virtballoon_quiesce()
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Denis V. Lunev" <den@openvz.org>

commit 29536a923a9412812eb3e378258019b54538a220 upstream.

virtballoon_remove() stops all of the balloon's asynchronous work (the
free page reporting worker, the inflate/deflate and stats workers, the
OOM notifier and the free page shrinker) before tearing the device
down. A following change needs the same teardown from a .shutdown
handler, so move it into a virtballoon_quiesce() helper.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-3-den@openvz.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c67b29e5f799..726aef5be178 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1121,26 +1121,39 @@ static void remove_common(struct virtio_balloon *vb)
 	vb->vdev->config->del_vqs(vb->vdev);
 }

-static void virtballoon_remove(struct virtio_device *vdev)
+/*
+ * Stop all asynchronous balloon work. The device must still be alive so that
+ * in-flight requests can drain via the host before it is reset or freed.
+ */
+static void virtballoon_quiesce(struct virtio_balloon *vb)
 {
-	struct virtio_balloon *vb = vdev->priv;
+	struct virtio_device *vdev = vb->vdev;

-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);

-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		cancel_work_sync(&vb->report_free_page_work);
+}
+
+static void virtballoon_remove(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	virtballoon_quiesce(vb);
+
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
-	}

 	remove_common(vb);
 	kfree(vb);
