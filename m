Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF23AEB32
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442320; cv=none; b=eND94bjz00b5f80xbJPT/tS6RxMlFfWhrNyEXzzVV9MUpNdrOzdPhgWLkKrX1pnwUis9ovbws3eyqxSxhikGuiijwZWzqb4aalBDA+jGwpRDA0/Gb6jxf8zPAdO01yHsXYU61ZUE9rl70yUDgyGxRQWcz8QlItzmvywnc+w6SqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442320; c=relaxed/simple;
	bh=bgehGYxVvOhqrzJ9g+V/DTye3Nic7PErqY7Gl161rk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYYWDjUN7LZBB5hB/4je5Y5qMfWyuu04Uy/pWvPv6cZDeo+pM3U3exJxfBxAVRvvlDYpAC5GbmSH5kzvPkP/LPcga5qVapQ9RIsmmAvTTDWJWBLHj2eA/I90a9xlmVqFeKocjHJHDioCoGrUa2plDEbh6DdjgfBT/6asL6zmosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6J2gyWr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6J2gyWr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e27035206so363876b3a.3
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442304; x=1786047104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
        b=p6J2gyWrvdEfm0Hithh9q4jpEWT2Q7oRdP+NwfJYhnc+b1zRozYIp/b0UFW5dnmpsa
         upg0uVO7pOaPWQgdG8deFbu8LJMBy/WDg8DiJ1V1QVFSO+cSqbnWS5f2ogLOuk4WLI4V
         ItRYnN5dL59ggpFGpmT4993BN24hpsFJfgqjEAgV17hNkh+2/DapPzaI0Md82zpAz4VN
         3GO0DM84L2P+Ze6H76pXnJXl+19YoMaDhjnSLImrAp4UHcSoVQByDAF0Awfg5mPEdy2d
         WIWdMKE0k+ukXPIDebhnCD1+oJpquaIjDGYQ0jhhkVkG3CxwMJxDpR3c73ugGr4Xi0mZ
         L6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442304; x=1786047104;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
        b=NW2n/6bgU5QcGbCfX2VZlOYuJtqLxSiRe7Jcq5hduMuU9cWP9ngfgxefPSTMyZXSCg
         eGbdnRZRwUHMom7th49FSm+iwFbNfWJ5h295F6dKoPTFa9rtCzniaaSb8/Cym547F/8g
         BF0ez5pQIrwIxFt4HCceUfqFcXuH6RP62IZ07vvKmh6nvzsfB1zhfHSUHOFaSj9Goo4h
         AbKgGkxdYx3g9iS5WxVln6EmSyeLHaAS9AlAX9twqdDc3QZcJBf1CFIOkVgfQ0nofGNz
         h3qQKn5brmjnSw7BHBMGXHEBIRt7yDjlNhVv2DkRo/trIY3kay12yieoQ0joUtfSRLAp
         F0BA==
X-Forwarded-Encrypted: i=1; AHgh+RoWDQpfSsM9EXYn85w5QJgAHehJFWqwiXbLU/3TuOfrib0gOjwKA3s/R5LkQ94g2WF21pMpALx5iNKgYNy9nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHfXfj5XRZau+h920aXb72mjM7isuP3muLRJfakYj+TS8B30DG
	lc/iW7u0tLMGAQBcq+RY59hb8my4BnWbxSmPwx9Xc8emgHOvDx0ichVd
X-Gm-Gg: AR+sD13JnGnU/q4PPErS+Tfx5drIsRQKuM+mAKgxflx0vxorbo+B9mR/BwpNfqdyUi3
	58iMxKp2ACrwe036TObyX79vsF60RFVzzMkilX+K+bpgr/Mph3pHx+F9pSgzD+ZWkVO0zNrxem/
	8q/TlIoMvRI6hqhsr7SmhZ5VIaF2ru0wRV2/XsNCAQGfuitqm9Uvdde+QWSr1ls6g/4q13ESB9h
	xTc7Tyzs/KvywFAK+c9/bO3EyZHcnjqdV8h2JaBCSqcUoc4j7PfxljYR0d2QP3CQu+W703Mw+sm
	e5orBZuMWojsR1ffZRI0ftBdkud9TqlYXu+/aSjCSMW9MKECpbcECc6mIc10mH70v8qFGdTsxoh
	SI4jmk0iV8Q1TeZKAH7qpPDWT8lNUsYED7qm6zPpVnkGFe90nUQb/BqNQeXJImeYSoCe6EV1TK7
	5g05jj9DqAVXpMwzvEjSW2j8BVD5qWwuAuJnxqFg5hTo4n3bx9/wQM0vOhLsmGwNopfMBgUicXy
	1DXwipl8H95xcYOs8HflwpA4BO73/oNv2GnCnuIa5U=
X-Received: by 2002:a05:6a00:c82:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84ebc22e874mr3531492b3a.21.1785442303585;
        Thu, 30 Jul 2026 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:42 -0700 (PDT)
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
Subject: [RESEND PATCH 4/6] drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:21 -0700
Message-Id: <20260730201123.1767-5-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older synthetic video protocols. Remove the support.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index f0ef627b4898..cea1ea2595cd 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -17,7 +17,7 @@
 #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
 #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
 
-/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
+/* Support for WIN7 and WIN8 is removed. #define's retained for reference. */
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
 #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
@@ -557,23 +557,12 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 		return ret;
 	}
 
-	/* Negotiate the protocol version with host */
-	switch (vmbus_proto_version) {
-	case VERSION_WIN10:
-	case VERSION_WIN10_V5:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		if (!ret)
-			break;
-		fallthrough;
-	case VERSION_WIN8:
-	case VERSION_WIN8_1:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
-		break;
-	default:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		break;
-	}
-
+	/*
+	 * Negotiate the protocol version with host. Since support for hosts
+	 * older than WIN10 has been removed from Linux, only negotiate the
+	 * WIN10 version.
+	 */
+	ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
 	if (ret) {
 		drm_err(dev, "Synthetic video device version not accepted %d\n", ret);
 		goto error;
@@ -581,11 +570,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 
 	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
-	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
-		ret = hv_drm_get_supported_resolution(hdev);
-		if (ret)
-			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	}
+	ret = hv_drm_get_supported_resolution(hdev);
+	if (ret)
+		drm_err(dev, "Failed to get supported resolution from host, use default\n");
 
 	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
-- 
2.25.1

