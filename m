Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F23477E20
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465392; cv=none; b=c70xpmIOZVjQ71LZklGVShRrAWJNjPOpmZ3FKMIlJTWejSh+Nu1dVFI6edRJweUILMpryW05FzsCnVMntvsZO2JXSe8IEzowjAKoRIEQ+UhpyrgjM+0Rbw3L9INU9ZqqcWuVlMzTvxCXEKzy+BG8fZLBaFVBtvVF1fjUCSU2sbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465392; c=relaxed/simple;
	bh=Y/Ynb8CMg23HSLFnvahuALwqonYoPmDH12RAnxUrtaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhMAQVcwHrBo3C/EGbD7Fe+vbBQavHsqumuiVMOO9DUtoMtxt5waC0uIuhIZz3NZPvkeQUInfiVjoHV+7UwW0t+hV7x+PbZNBfi2I8LKE1MjBxrcl9WCxY0hBvyJT+QUqlwkROi7pm2TUuilO5WRLoOYe+KOWbxlMQJoNb01Eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLWzqkUp; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLWzqkUp"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f01363so21844705ad.2
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465386; x=1790070186; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5e+gRweobBjhlv/HMhSt0aHVe80wymGJQQad+R8SpY=;
        b=mLWzqkUprwxYcfB6pJ61IlP0WNuV1ECdrF8cOWZcJvlp22IlysT+Rn2bbmuz+ES4BZ
         RtkyEXXMC662tT9L2UUsklqyCKkS2a8kwL1/vaYpbmfayZ4aTG/V3/Y2xlLE5b4v+lJ/
         /D6ct4JRs2yMWY1sbx9Imd02CN3ej4NtjSHE14SzvNs4FUw1IDvV72RQZznSG74UX0Sy
         xJ6JMfQimqKSuBYf9Ac5R6Cvw28nmCNIGzxD/4ps1YZ2jxx7bNAE/tqWAdUvyH0bUGMl
         Pu3JbW6erLVPiMnCJO/ASQb4tQv774itJ8KK0BvKP8mh5ewHdgp3AlRcQryvo0pLqQHV
         cidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465386; x=1790070186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5e+gRweobBjhlv/HMhSt0aHVe80wymGJQQad+R8SpY=;
        b=WjZRJbrJDNtCBoZDpg0rR8XlZv7KOvxbQ9UmdxQYHI7zODSPWosr6Oo+gveM468cx+
         XCPNL4qzaWVqx037DVLDxfK3f9cu+a4ln1MW0vYLreMSaY3wd5X+/hsN5ZrP+wrZL08p
         nWmNQl3wYHSuSqjx6Pc8+1yxRwHsdqhYhFOqRGojlLXU535d/PHsiI6aP47KOm8RzFgd
         DaHtxM+Pi0qfe0t54pzE55gnBt6H2xZjMjTgk9foQe2z6TOzsRe7G4DJCQ/KyNolVe3E
         u3ZBDPL9+Z8+gJe+Zkqe/lefNSZerQVlXZSAuGHq2Ce40kark199MlKJU3z3g/p1lbPe
         CHCA==
X-Forwarded-Encrypted: i=1; AKwUvByW2IKd0z4SpBL6cjXVwgxNuiAHDTkjS/xBb1cHFTZp/EwIyhr7nVlFejUTdChnEfbHURnNDL8QZMccMNzPCg==@lists.linux.dev
X-Gm-Message-State: AFuF++k8Pmcud3kp+uWQ9lSzOWcOfh5iSJv0oQhVE2LjlyQa8tHkTJYE
	N6Fd6TVqOxY77+ilRdrSZTScfU1Mb5HAW0B6A4Gk+1k8KcUX/7dAJbeBQELteg==
X-Gm-Gg: AYBFou2Ob/c39ojow5r3u9UJIlx5qNgnWNcp+LtPBOxxjmMmgZNf1mQtffUn/+Nool0
	+Kr8S8dxFtSgWgO4c6owFJLgvUsfDQRgdVZ/UC11kA4ccwwQFwfl5NIs24/Y/3liWBe+ZAdlp/6
	56+Fp1tKnsz15J+aMA0nkjwSeU2QFBGr9BFYFCaNpmiVV8X8Lh1WaSf24nHodVzouZ3Bz7YFo/7
	Bd5wMUZAX6YSRltYFhmUvY/TLVAMTF0NEPi/geoBh7UaPPLmSFeiPj/hM7/CeylYLsNc8cmm9Uw
	7fAXv2miHMhh0LVf3JDhtAgFxfFAWBVSgZBc3KC+st7XaB5NpQxVUPCqdWVRVM7rWAx7C6nZWMC
	OhfpSS0jMxxSONNXnWRvqUmMGM7CecuR+jI8m8F7TzGJf9hJ2tlhEsl/HnGqMksZllLT4OD+zA6
	o+ft1Lzf03CjxyEcY9LXZBHCOHkBezMV6VC7Dx755GId9jkU64Kp1UPEnAUH6H3rA=
X-Received: by 2002:a17:90a:c2cd:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-39df2a10424mr10688797a91.15.1789465386330;
        Tue, 15 Sep 2026 02:43:06 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd0ada3sm4269410a91.8.2026.09.15.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:43:06 -0700 (PDT)
From: physicalmtea@gmail.com
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	nab@linux-iscsi.org,
	asias@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vhost-scsi: do not relock event vq mutex on send_evt fallback
Date: Tue, 15 Sep 2026 17:42:44 +0800
Message-Id: <20260915094244.7900-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915094244.7900-1-physicalmtea@gmail.com>
References: <20260915094244.7900-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

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
Reviewed-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 37f681aab..9cd181cb1 100644
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
 	llnode = llist_reverse_order(llist_del_all(&vs->vs_event_list));
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
-- 
2.34.1


