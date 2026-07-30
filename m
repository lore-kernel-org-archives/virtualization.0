Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D0370AE1
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442315; cv=none; b=ni13NVv9ZKEXWG4lwZmgeKmQaA6XBmUXS+4eoP6jHanCMyDsUDbC1kv4riOPLRYl7ugLKSokuWhdvNb8y7dKJqrY9j/jZSk4OmCPxMdU3z1eOUFbBcNPTA86o9g1dsrYbwS8groxUI657p34w3tVYrlP4NHpsvJk5zkeu9CVLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442315; c=relaxed/simple;
	bh=ywoJVudyQly2BSU4Suu/ELob67veyV2IT2JljVMnXPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqLhtcueoc8xaFNMiznc/cz6NVJdMX89kjz5N7PysT9OJAVR22FGF+vJ/bC4oqS62Ka0FMP2x6e4gYLBml4BO1BOefUweiQRK9JJLQ2jO/sIFFObUnzCZvfTZND0i27bPgdxxO+cZFlJH8HiURVDZwGBMU+ICbU2nC2ybyRylMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRLLdsXx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRLLdsXx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so275401b3a.0
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442301; x=1786047101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
        b=cRLLdsXxWH20iPlhGoMg09jmsrhxnMQSOF/OM/0LJkJ+JooUNpUad/hbjNBJWgbrBA
         wxVndaqNiKkpmbffTv/PIJUmp7lCrYBZr8vNhqmr0sMbKYtZ7GebDXdDuQ658taxvz9B
         QGhQoDlEN6QEUi+k8btUQSR1Z5Xkh68t1vQG/i7SDwDm8kCtZ8neJ+R5JpfcU8T7jHvA
         bFul6m1JeVKk2ZZ9lWMoa2e/AfQR8cSEwrfrR5oUYHX2bxvihJUoI+KQ6MIEycF68u4D
         9CInARz7JMCuG5x6HcugarEi+4JfcR7xcCwZOYp0CeaNktP1b0cLqU6LW7MUvd5ynCwm
         cn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442301; x=1786047101;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
        b=m4r/BZCwlWX5BZ2eVJy98oBv611ao6W6Wigvzx6vU2ODKVzIjrNN65fugJOcxQd5C9
         MdXEOXIQKGla1xzLZc9a6zsEF9d+UGuwqxon5C/gHZCCpfHfHLp0nipCvhZ0WWhjwA/P
         WPUnM5usFKfqUKTiiEZdk0aIs5LMwLMFDOvtyQtiPJEgBmduzoLXz8ljIOt65CqEWZwT
         vpf9bDx5n+IRK594nH1vZV+75H+2fTjxJUmFLsnmaD3lvZ617O3BdlmLTVVNFFDUBKso
         v/Nd+UHxa/HFyiKMLN14JlZ8VNdRk/apcf7OHJ0sBjyacVdeReVvniQX5QykSTKmYftb
         gDMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8hhVRZNO1jDzVxDDjJ6WlNf5p61tt6QhTyldIuDFaUduffQV3W8rShawxCsMyvLWgCQXqnF9skQq75zua9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIXhvF7TkL92y7WKyJw9g6eiGkhDs4stHmHuaRVVbp0KxbxY2h
	Rhd9W1sg4CBzpEloasWK+E0fFRifOdKLLVL07vGc+cjgTnoDXWRGdhpF
X-Gm-Gg: AR+sD12pMObXB+i3WUKP6TzdA1EbJl0Nsr//PFGHJQ253aNxyTZxWsP7BN/VnAftcx5
	NgbL5BxHsFBQXz04eUU+ZgH+YYuaIzSFxpB2sydK7J/UosI3C+37ky99ipMBrUEFfITzh6ySSo+
	1PH4em4wJGpj0GKLB6YrhIgNx4zZOyCVvikWx1WKup3wmYNri7SRAM3gcT5m5aNlnUcf3s0Pr8G
	M/kO/jvf8w4sNrCuuNT1WlSRpTPMXewOGC91paGq7KXuQ0wzlMtKJMMZHpaoeGJMOSqNKHv7psn
	wxTbfxgQECgRx3yqJKPNDM4v4YZlO8SkBlVy7VsjnAv6yrs21VSHbJbohn+yqn4CceMkwepvPeT
	R9skXNtCkpxDGFh14XE/ySE+UxMHrd3JAEyx4n9d6BZi7wmcVAaG8ITn9ylHRH1UO6oiy4zkiXE
	deuGrK1YcMUdU7xOMDfUvNfi/J6H85FseoGrexvCvaW1nOHdNj9gBUbsgR90VsOUPKJLX4Cjt89
	q47k5uvDYK8dXFkuYf5Ue8wWTLCx9DoLDQwZXSjW2nhYodaknf6Ig==
X-Received: by 2002:a05:6a00:1391:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84ebc1f5844mr3898044b3a.8.1785442301426;
        Thu, 30 Jul 2026 13:11:41 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:40 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH net-next 3/6] hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:20 -0700
Message-Id: <20260730201123.1767-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, the special case handling of
GPADL teardown is no longer necessary. Remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 4d319c50955e..4295b96b4312 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -695,17 +695,8 @@ void netvsc_device_remove(struct hv_device *device)
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
-	/*
-	 * Revoke receive buffer. If host is pre-Win2016 then tear down
-	 * receive buffer GPADL. Do the same for send buffer.
-	 */
 	netvsc_revoke_recv_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-
 	netvsc_revoke_send_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -733,14 +724,9 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	/*
-	 * If host is Win2016 or higher then we do the GPADL tear down
-	 * here after VMBus is closed.
-	*/
-	if (vmbus_proto_version >= VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
-	}
+	/* Must do the GPADL teardown after channel is closed */
+	netvsc_teardown_recv_gpadl(device, net_device, ndev);
+	netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
-- 
2.25.1

