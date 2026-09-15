Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CA47D44A
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465383; cv=none; b=onpfsrLVJGn+sE05pxnVfRUFeVYuwkSt89oFG71R3OQaXL6OAR978elIzF00gpB1H8cvtjUzdejnzLmwA2jKUpV332Iq1nzt+yiZV9QahMd5ZOfubVQraMGUtAGwN5nlPbzYJ2YeFBups9k5ELiit97fkRR8igyLqDq29WgpYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465383; c=relaxed/simple;
	bh=DSm67Fef0PwVMY0lwmqgSFdetPGHsbit/KuByND9Tmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBrPr7eRMWePDyoTXapB+KFWWIq+U5D+E4NXo01rz6WqTXIrQW09nG3GvOl2IB/cf2IXnNbz9dDDW0EBNmur8d4cMzOy4ZkUkr0vsjgTc09nH5VIxnLvfARC2AR/b8ITOKZw3CHTnR6e6VpwZ1Kq/U7A9gfkJLR+NB4HdCDiErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QscLu3Rh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QscLu3Rh"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso449975ad.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465379; x=1790070179; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69mrxJexhH+mB0/KG77Jb3FUWESkIXl1gYvn5Rky+CA=;
        b=QscLu3RhyNTw9hN2unQ2Yb5cx5vBvSE8vyqZWJOa4TYY/8SJAAFTD1Bga3xfdxKnIn
         1+qsrZzVXTATTi6Ibj0EUHXv+ZVAmqIwAfWPtF1zoqVaqSCh6DZaFimKOPmzpvoxFgMZ
         H23RL9Kkj3r1PrHJGTf4AliK8LUu305tkM4agUynoHaDQQ/j4WGxiZ+/b0mCqdnQnAju
         /cISuTPh/xKzNc4P1knb/LH7nFoJUmmNuFYvK/4Rf3YnopjNgx0E4VybuPL1KC2ZmUnI
         dSOb4gm1H53uOdN5+h+7la9jOJM2QlBtgp6iCpwrg3XMCUerz3XSn9lYqi47QRtiroa6
         8JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465379; x=1790070179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=69mrxJexhH+mB0/KG77Jb3FUWESkIXl1gYvn5Rky+CA=;
        b=crX6UOyLS4FqfXtufSIgscqQybQGn55fBP08jDbPEBWlaVzdpJ2CqEQJP3k3miElqf
         9Lgt+S34f5ACCbL7pEM4ooXqhAo6x/olkBWwtOZpS1jsKRFTNgN7ZIHYmfASvxIn3bCZ
         Z403IVkmr0AwN0H6pEzZOqId+CWVWJI0puB1v9HQi1tlT+hjq2kUUoNZWUyWn9Yog8yb
         kduuwIid8s8Ic8JnCZoeAim5I1I6++IlxBFMlbWSMVeSMA6xyZfJrYmClmh96yQqux7o
         nsyTHDERtFc3+1fSYQCRulPD8dfVo9DH3/Rw02JuyJk9ZiTm3BKFDhJByEAiQtXoS90j
         r1oA==
X-Forwarded-Encrypted: i=1; AKwUvBwrEmab8WZIY8kaMsMCAtz/UBwzL3XpkTD0TdNSf+elB+9SNGDG7Q1jykw50ZUR4Xbhr2gJfrdGIbhP2wY+WA==@lists.linux.dev
X-Gm-Message-State: AFuF++nHij2Mgkk92HR2ZZnkEBLv4MdOm/7QxXoRyqKlIf/XFfGRS2rj
	mSJ2sp9v+hMTTw1O/T1LZXdXnD8qENhiQ9JObp8m0yuSoh7zV+sIqKrO
X-Gm-Gg: AYBFou3swu93nzvSUDQOP9o+jd6E1ND7iyt8oEFiOI91njwi/7N9Uzd3yWYpKSvLFVp
	0zIv62zHYr/acECaMHpUdoXhetd5lsqPw7FYn0BrDDI9Ju5F0xTkci4t0QaVG9by2wkW6gui1Fr
	6ypBEKQNhRm3e5bvemVckONK1WUW5OhSy8LeZ4jOyD7wkCL494VrLNj48akTzVlUfeUICkVvwbA
	aKryz7PhlBeG8YmL68H4f5OQSnD8cmcppqLHPT6vPUITCX9BvSbWum8xGy1TpE8qqGR9m6GSrgq
	7vxSwTq5rCpUQ0Fsym4PMhNVpcrjddrGZbe5lgXSK67qY3F59by2Q75x5ON7dHo8tkuw3M21vpG
	8Lyu6BIz6BDP5v0U7nCS7dfuAZAaXgq8qQQGCu31TgMvf1RJjC3VXOjla/zC6TwgxspcUXPe3Lw
	fZIxTwpSPLsyi4h0/PCgXl+GTIIdRqlAF7I3d83B/OPpF87KlO2dzrd01sLYNCofk=
X-Received: by 2002:a17:903:40c6:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd837a6aeemr5238465ad.4.1789465378664;
        Tue, 15 Sep 2026 02:42:58 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfbeca2sm63625345ad.45.2026.09.15.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:42:58 -0700 (PDT)
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
Subject: [PATCH 1/2] vhost-scsi: preserve event ordering
Date: Tue, 15 Sep 2026 17:42:43 +0800
Message-Id: <20260915094244.7900-2-physicalmtea@gmail.com>
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

vhost_scsi_send_evt() uses llist_add(), so pending events are LIFO.
vhost_scsi_complete_events() walks the detached list directly.
This can deliver a later hotplug or hotunplug event before an earlier
one.

Reverse the detached list before processing it.
This keeps delivery in enqueue order.

Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7a1f39a32..37f681aab 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -637,7 +637,7 @@ static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
 	struct llist_node *llnode;
 
 	mutex_lock(&vq->mutex);
-	llnode = llist_del_all(&vs->vs_event_list);
+	llnode = llist_reverse_order(llist_del_all(&vs->vs_event_list));
 	llist_for_each_entry_safe(evt, t, llnode, list) {
 		if (!drop)
 			vhost_scsi_do_evt_work(vs, evt);
-- 
2.34.1


