Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E637FF60
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203890; cv=none; b=hI4IZU9s6jR0TvWVQAWRdjm7PSIuZ6Cg80I2YlEhnCN4UnKMNab3Nh0QmWAR1Y+bwLiiXttoYtliiMlLO/HI1k3kaqzGoxQMFkhI0pfwO4TXU/bgQWOsurm6lsqhjXcYVCCbXOAFpV1fjUdGPvxqizuxPJ6+m+eWiWNApdeQhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203890; c=relaxed/simple;
	bh=T2GpveXf86xU4PJdOWIIi5lBw5gHgOvqTYsANeAQESM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPOz0CtlseDCamN0l0FR+esBTk3gRqCWQpK/vblQaB791FUKAiHLUi6HS0y2G7GwCBN6PgbSjjkrtR401EUazCBdzLE78THc6HNuGhanqVIeZ2mt/kbUSge+do03rMzydqEvDXNT7fBmnPiVFDtz4g0Rbd8c6JrTLpgzx6f/cXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyF+jMS2; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyF+jMS2"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so544236a91.1
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789203888; x=1789808688; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i5SaSEoCo9RleDHysc9IxVyTl6w7IzP28iEqT/KO1Rk=;
        b=nyF+jMS2sKqHlN1zqpgK5A3q/pTon20Sk7FAH8XteRcFWVGC0vHmrpdImhJ4gxH2FH
         4sbQAb3HFi5fsapJejHdx370PPUcPjqTFYbENU0vfpY7+TNTXS8YWkufjkDzPgfUVbLS
         1me+LO2calVvqOtlX0epkmZywo+C4XcIU4CZDBfFVjjHOytpvMW5WcqkT7DZneafOtOm
         hwDmyyjr9p3duG9Qlg5k++dHl47CVKjlPLdR3CUQzKvp9LqpZRkBCdp2lMmZED31jULR
         SsGZKUXfrW+USY2O8lJp7cCjKw4RY/i/g3sNEC+0CjYZqTpJZcKtj7b+NMs2nctnuFx5
         VTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203888; x=1789808688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5SaSEoCo9RleDHysc9IxVyTl6w7IzP28iEqT/KO1Rk=;
        b=kXCBFFY7i8QRGJisrdAbvwaJRdy7WEBIQvCQMf7Xweo3jWwhw4utfWwEB9u831wcDh
         aCfmrJxI3u5XRxmh3abCmsNoKVn2vIuA6QeXDfw0zi9JkY4x5N1ZhtFWk0YKpq2cBBF1
         HnxvgI20AxCNbzSe9MULPvOdBcvzfOh5vXtNgR/LOZPmJK4zXlpflT1kyWp4A9XyZnta
         bXXsNxUTa/vWPHL2hBHK9i1xtX+RZJZVZ2a5TTGUS8NmReMK+jZVQloDvWOV84OGIIK7
         R5TNFtMsd1t0kCZT4QlSdSFYQAqg1xfWu96WISMOH1o4CD4Hd1u+j/4KxPacvosoG9zs
         T5Zg==
X-Gm-Message-State: AFuF++lOhIwm4rqikwyZCr+4w8yY/wpwl3T1lDT5FzFO8oTNC8abfINa
	HOXTHlm3mrzYoapRigH3gCj9L5crk++JFvuVElwrW6xPSUUosNa/YIBB
X-Gm-Gg: AYBFou0WI/3LWgF4c9uWdXNGcfZpWDNPe3iDsQGQa+XhQOC/8+w7syfUGGpDjVi8wpv
	sdrcNt3s7EDN/u98BKRyxiNGPm55SIIbSegCx3s8vfcQOck0/6QhqxkLIUQA8wrLG6mUQoPZDxL
	IZyEHcWumRTaB4MZm2ZXrtRnDULJPsuCDn2c0B06gGpYDvh2+7I9fNMuuQ4e9Wzze1gPDySVT4s
	nC4t0L6w2uKm0S1l8Q6u35cnljk9JOjSP8EIqWxyEhd4SWMdjs5JIpOemOfsrLq4OLGgnyPIb/i
	9SiJYDDKvuwurus5s758FNeH/V+1IIOl9LqaxKaYurjb0cjGY1g0XlcriiIT+xTRXDBxta6J1w7
	jqiyAPsPG6cDjlwYLN3RyA0QMeDUcl23nOhAIx82VZkoIKG3Tf8Qw+87bcTzWLk999AT/fsyLp0
	d9wuTFQSxKrA3FdniXEi6rrBoWNlll8gAd4VyGiyAI68g77/NI8vtOwLcC2qABgaXZMWN+82c=
X-Received: by 2002:a17:90b:5246:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39d9bc67660mr14176109a91.1.1789203888155;
        Sat, 12 Sep 2026 02:04:48 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f7390csm12345338eec.26.2026.09.12.02.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:04:47 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-scsi: do not relock event vq mutex on send_evt fallback
Date: Sat, 12 Sep 2026 17:04:20 +0800
Message-Id: <20260912090420.47439-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_send_evt() is called with the event virtqueue mutex held.
If the worker is gone, the fallback currently calls
vhost_scsi_complete_events(), which tries to acquire the same mutex again
and deadlocks the caller.

Split event completion into a helper for callers that already hold the
mutex and a locking wrapper for the event worker. Use the helper on the
fallback path.

Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel.org/
Fixes: b1b2ce58ed23 ("vhost-scsi: Handle vhost_vq_work_queue failures for events")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Sashiko AI flagged this while reviewing
the vhost-scsi event queue fix.
This is a pre-existing self-deadlock. It was reproduced in a follow-up test.

Trigger: vq->worker == NULL. vhost_vq_work_queue() then returns false,
and a subsequent vhost_scsi_do_plug() call deadlocks. I do not know what
normal condition gets us here; the normal vhost-scsi worker detach/reset
paths do not reach this code. The only reproduction I could come up with
was killing the vhost-scsi worker. This still looks like a low-probability
condition.

 drivers/vhost/scsi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a32..7c905e9ad 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -630,19 +630,26 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 	vhost_scsi_log_write(vq, vq_log, log_num);
 }
 
-static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
+/* Caller must hold the event virtqueue mutex. */
+static void __vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
 {
-	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct vhost_scsi_evt *evt, *t;
 	struct llist_node *llnode;
 
-	mutex_lock(&vq->mutex);
 	llnode = llist_del_all(&vs->vs_event_list);
 	llist_for_each_entry_safe(evt, t, llnode, list) {
 		if (!drop)
 			vhost_scsi_do_evt_work(vs, evt);
 		vhost_scsi_free_evt(vs, evt);
 	}
+}
+
+static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
+{
+	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
+
+	mutex_lock(&vq->mutex);
+	__vhost_scsi_complete_events(vs, drop);
 	mutex_unlock(&vq->mutex);
 }
 
@@ -1829,7 +1836,7 @@ vhost_scsi_send_evt(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 
 	llist_add(&evt->list, &vs->vs_event_list);
 	if (!vhost_vq_work_queue(vq, &vs->vs_event_work))
-		vhost_scsi_complete_events(vs, true);
+		__vhost_scsi_complete_events(vs, true);
 }
 
 static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
