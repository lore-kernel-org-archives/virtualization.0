Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9E47532F
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465375; cv=none; b=S83hg4qx+N7p4WkEeYUg5H/BbfOgiBFhzUU6lZOqXrSW4UaBnOIhnq1QQjBIlfZnvg04a+EGQZRBZqlv0fZ+Xw8tn5akNmhABoEhUY8/drxU2LpXIzkBpFYQsBmXkdd6HSy0HK4v/51zrFgrFmddTUZmfB2VTXN1RNoyo0vJ+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465375; c=relaxed/simple;
	bh=uCvoUHgJLkGvyYy/c5odfUayoHkL5waDu8y6yeP79iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dm2o77MP0RxzsTsNfYt0/+F9iltlkiQ0/+M59B+wpoxXP/+8yDJttJ4viVUOIUfaF3OrJquKhYS8zbJ6mSSKHqFsfqaDpCCRHgyyhTlYWCdDZ7sx+N+Z6xu22kuuEfWfPF7zbpCHyk5ih3KiccXzWbBHWGh+UhRj4LSEf4BiKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=po9Unl+g; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="po9Unl+g"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so45401a91.1
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465371; x=1790070171; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM6LpgS9VGFb0LQ0PAPpvOnM3tsCZP2CYIZnpcmqmZc=;
        b=po9Unl+gvH3OWUvCTQL2cSFUiG5ITypwXqawD26v/rM4b3oFhkKCKqNKMuxFuVCZnD
         /ooY8g6bvvYWhYW4GfQUA3yqcpWm3g7pQ3Tk46EA1NtCXzgbsyXYjg5rWTidc7e7JR1R
         R3AaP2bslOSAMOf492J5WJL3Z/dPrdFpC5TiXA2C+vrwAtuncMbzjEM0dYM0liL0SIjw
         ls5NXrsXfNCa0eXWNCDMYTNE1iSH6jAAFaBWi4rNf5WXMdORsAbk+9inNcNkklkq9TK8
         ZI00NR6Ggwx8BMCMUVRmO82GJg4n5xIuO0I5qxyUkHe15WOy/53Lska1ifeiXCzbSJp0
         Bojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465371; x=1790070171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM6LpgS9VGFb0LQ0PAPpvOnM3tsCZP2CYIZnpcmqmZc=;
        b=QaVoLM5uXPpFjBc1q4GxaVxzma4GSabrka9mcEDT4jcbjOquW5PhNiIkYhQ6UrkrkZ
         GDmCMw8/oJylaV2mEUDbOy+LSTwGC/h+jojXDF3IVNZnUd30V6W3JohGxNt77uPggmXX
         Yaw+WLCj6rhHzJkSIM64mQJvIhknYisUDMRx6mcakSZ4naX/fZ6ylvLC7tliZ/aTiKol
         YKOptuYnTPhP68iOQ3aa9eT+g75pwZeuoB/hejnPJ1mEdrMXhp4U7OkbKIhqg1jKahvS
         8XnLxjs69SwciNuIh6SRb9jy1Ylbr3Dn9RfsB1m23vcAKQ+ICLzulIO7K5BjuQFs+Ggq
         yy5A==
X-Forwarded-Encrypted: i=1; AKwUvByWAtqDNDw8pcp2CYtyIl5r3O++P1IhGFGpInhtWLr9CzyVa7BQYVkx0I+4zCa49tOtI+aIk73HXe4EiSS+gA==@lists.linux.dev
X-Gm-Message-State: AFuF++mvZB1dV4YZ35Z0N4CU0dorC808YMGC3lzIHDIYNvaRAZt5MW7z
	6mRbsQ7m2u31ze/2R9LCNtr9A76XLkTAxy2jtxuufPtqwNj5iYmEePUP
X-Gm-Gg: AYBFou0Twf1z76dh/CABheG2bH/BeTgJHUm4+G9pXjtyruNCxhXzyTomFXKhsulVhb/
	FBmMlvoUwj/4rJiZGuqVdJctLZNr7BBLa8X1znbeaNsbYTyEmND/gz0ZoY38Ie0ATF5R9wdghex
	wZgP+wlzBUEI8dEaN8opsBs3wsrVh+PNF6RmAvI8TPL7ncu8p4i2MVI4tlmuXrl27O9xLapJmWb
	VHWFKYANKLLbZGWxKazg1mPoHkvxqnIq1SLnKjwDeOlerr0FOwf3dgr2IICWjJsZiA2fn/20xHx
	K7hstMRflAlPQF6Ir9dOiAvCftZO0c4o1VM/QIuMVT54ZCjBIp3uUW/9DnbpwG2isA83F1X/W2M
	xzGJIqMTmFE2+DRncPMC4FUdaN2S0CwfMXAYvKcVv5sRuxoe7bs0B8sR+18Fd/wX40A937PniL7
	0/UoKKYPWUJmNRZr9w+PRvIFUGzMbEFvbTBiL8XzJ9M/m7TxDlCfhew1rqfsyNR+Y=
X-Received: by 2002:a17:90b:3c4f:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39e110770f7mr236150a91.22.1789465371127;
        Tue, 15 Sep 2026 02:42:51 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdcb54d8sm4196291a91.6.2026.09.15.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:42:50 -0700 (PDT)
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
Subject: [PATCH 0/2] vhost-scsi: preserve event ordering and fix fallback deadlock
Date: Tue, 15 Sep 2026 17:42:42 +0800
Message-Id: <20260915094244.7900-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

The vhost-scsi event list is populated with llist_add(), but completion
walks the detached list without reversing it.

Trigger: concurrent hotplug (ln -s). Each event is inserted at the
head of the pending list. Multiple events must already be stacked on
the llist before the vhost worker runs
vhost_scsi_complete_events(false). The whole list is then detached
and walked directly, so later-enqueued events are delivered to the
guest first.

Queued hotplug and hotunplug events can therefore be delivered in
reverse order.  Fix that ordering first, then fix the fallback path
that can relock the event virtqueue mutex while already holding it.

Patch 2 is based on patch 1 because both changes update the event
completion path. The first patch is otherwise independent of the
fallback deadlock.

Sashiko AI flagged this while reviewing
the vhost-scsi event queue fix.
This is a pre-existing self-deadlock. It was reproduced in a
follow-up test.

Trigger: vq->worker == NULL. vhost_vq_work_queue() then returns false,
and a subsequent vhost_scsi_do_plug() call deadlocks. I do not know what
normal condition gets us here; the normal vhost-scsi worker detach/reset
paths do not reach this code. The only reproduction I could come up with
was killing the vhost-scsi worker. This still looks like a low-probability
condition.

Jia Jia (2):
  vhost-scsi: preserve event ordering
  vhost-scsi: do not relock event vq mutex on send_evt fallback

 drivers/vhost/scsi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

