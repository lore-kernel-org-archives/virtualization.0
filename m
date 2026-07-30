Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359D3CB54E
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442312; cv=none; b=HVs9KQP+THfCTK2y+mBtrCGZ88db/7VDQGzbPONpmZ33Wk46OvpWYaGzQGIOXeGg2rUH19VzbaFulU9bwTBrZFU5rHW2UsyKeMvH0BaxdN4j00YStftlc6L3fcYcOr05x/mHSuHAWYd0At6Q9PksPOe0aRIKSAMefU0O55dzdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442312; c=relaxed/simple;
	bh=ZdvgeoWh2TerW5rE/vqKIpMlNmv0bCF+vIbf9z8+9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYzM2pjMjl2m55NG90ygyeUgDrdeRGYg7UsRzofVP7OQiTsIhshE+7M1Qa30VkL6c2ztNm88sivHB9TNf+vNv7jFEF4kXcIIWWN/PDgobhJY930mtAURPrfRlKHws8T+aniE2hZrwCi/QlctqkgcQ/Ca4nSDN4mjS6AskGUavX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdQ774uV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdQ774uV"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbb7926836eso120479a12.3
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442306; x=1786047106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
        b=OdQ774uVYYY9HG1C9ITZdZz6Is7o9pLwKlJlIkLcWYre4I5rRfTvnkotrp7PkVBKjs
         SbrYtGIqleVRrcGK3DuzEx8tRwAXt2QW8u/ochuhpIMIKfGh8gZuW/FgVDDSQvGCXjDS
         UZoMl8uMray50XdImapVOjVbyWUMRU0uQR41r6YbSMbHh0yuD5ejHxZYNuNYAagY9DnP
         tzpr3vBWvCT8gCAvFKIvTckCSucc7lGonb/Er9c4+xad/zFu+wqabZ3c1hD7JrQd+2MJ
         vfNG8TgCFVUsEKBXefYchjIuLgT3b126FmERZrM8Dgk41V2YGUYQ6/q9iH+yEAmZFV1b
         VG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442306; x=1786047106;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7nssRnI5PbZKyunLFrMTG5kzkBNYctSVirvyP8FTcY=;
        b=LtlG5JG4JBREuh386VEbt8XAFBoAyOgKzsv1ZdazXFW9uHD9rqx4QDBUAdSdXAUSGE
         kSiPrgMb4PcihD+oR/+BI4K7r915+uDUc0sJetXwuYNZbuZDw1ULY3W70e7JPL3H5xW2
         yj8awdEhRnoAt9jGU/7VqkUo6N+wUP+MIPdsX00ZzaHO5EwMA+Qi7qehTYRB1WqEA0zE
         AB9nkmyhuEERLx0VaQudlolXb6f5JLAGEpWfhvcZUJJhgCil8+4VKGB5QRAKbSnxr4qd
         umIyNwMpsMnhD9l4HDUYcp/n+AyQawmK+qYBKh0gV0zv8TLHiOrGlWpB8jdX55W+q9sk
         GXjg==
X-Forwarded-Encrypted: i=1; AHgh+RrA9KqzfhRWH54858kINcyOC/dEW7OCO0UZD6JW5Wv3ZvhGJxgdYtrztlW8A3xBk0OITV3XnbapAuL1Q/JJuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhB4GG/xFkspovW3m36OqsE/IdiKlKagrFSXun/JKTVURZTdSY
	57htZ9dyWAVSJz0+iB3FcF70p6sUMI3uSokINcYe5aOGjACX91rc05yf
X-Gm-Gg: AR+sD11X7qvtMl+6NHaMufWAveCal67ov0yVevEuHFpLnnCWV2ZHCSlQrrOD/7r2eKl
	9e79X8cXYtF6lm9Ay1EHA96Vct0yJ4juxLLUERShqaA2RngQkI7gYI3mx86egh4bTiumj6GSFu4
	hnp1y9DR6rv0Tz994Xtjg3EGozPUp/OycKe+IVWguDmz657h1noPCN2Knv/bxfPdSjbvi0EuUcs
	s1myLi+tZtlWMV9V4CLE37fu9NXW0kR3d4Hqch2eptMc4CtLMzgi3/0f5a3e2QjDdUokStZXaWX
	b/qlj72c24bEYqsvlPEF0q0tjAWJx78XsEX56KDXWzjHJwwWP57ufas09VDSnYZR1rSEQMlW3AT
	JrPKjPCXOWeY/yqi4jrQmHNVDNuSpvIRr4LPt4vjGkXKBDzJlE+O9T1YniDfvw7xd9XGso8KHp7
	0p1cPk95Vq2zEdHt00i0ohREAQsoRl5CtuEMYyoYUnoIMqxcp+QBWIyu6iCZhRiXGydWNDzbRn1
	JOPjTpZzLxVwjgtTyu3gWaVqSghsrKcvXducwjQyzs=
X-Received: by 2002:a05:6a00:1741:b0:848:5b1e:aec2 with SMTP id d2e1a72fcca58-84ebc3e39b5mr3714867b3a.54.1785442305476;
        Thu, 30 Jul 2026 13:11:45 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
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
Subject: [RESEND PATCH 5/6] scsi: storvsc: Remove support for storvsc protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:22 -0700
Message-Id: <20260730201123.1767-6-mhklinux@outlook.com>
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
to support older storvsc protocols. Remove the support and associated
special case code. However, support for the protocol for Windows
Server 2012R2 and Win8.1 (protocol version 6.0) is *not* removed
because it is activiely used by HvLite in the paravisor for Azure VMs.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/scsi/storvsc_drv.c | 53 +++++++-------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 571ea549152b..095fce47c5f1 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -47,9 +47,15 @@
  * V1 RC < 2008/1/31: 1.0
  * V1 RC > 2008/1/31:  2.0
  * Win7: 4.2
- * Win8: 5.1
- * Win8.1: 6.0
- * Win10: 6.2
+ * Win8/WS2012: 5.1
+ * Win8.1/WS2012R2: 6.0 (also for HvLite paravisor in Azure)
+ * Win10/WS2016: 6.2
+ *
+ * Protocol versions earlier than Win8.1 are no longer supported since
+ * Win8.1/WS2012R2 and earlier hosts are no longer supported by Linux.
+ * But protocol version 6.0 is retained since it is used by the HvLite
+ * paravisor in Azure. The #define's for the earlier versions remain
+ * for the historical record.
  */
 
 #define VMSTOR_PROTO_VERSION(MAJOR_, MINOR_)	((((MAJOR_) & 0xff) << 8) | \
@@ -218,7 +224,6 @@ struct vmscsi_request {
 static const int protocol_version[] = {
 		VMSTOR_PROTO_VERSION_WIN10,
 		VMSTOR_PROTO_VERSION_WIN8_1,
-		VMSTOR_PROTO_VERSION_WIN8,
 };
 
 
@@ -1601,13 +1606,12 @@ static int storvsc_sdev_configure(struct scsi_device *sdevice,
 	sdevice->no_write_same = 1;
 
 	/*
-	 * If the host is WIN8 or WIN8 R2, claim conformance to SPC-3
+	 * If the host is WIN8 R2, claim conformance to SPC-3
 	 * if the device is a MSFT virtual device.  If the host is
 	 * WIN10 or newer, allow write_same.
 	 */
 	if (!strncmp(sdevice->vendor, "Msft", 4)) {
 		switch (vmstor_proto_version) {
-		case VMSTOR_PROTO_VERSION_WIN8:
 		case VMSTOR_PROTO_VERSION_WIN8_1:
 			sdevice->scsi_level = SCSI_SPC_3;
 			break;
@@ -1703,28 +1707,6 @@ static enum scsi_timeout_action storvsc_eh_timed_out(struct scsi_cmnd *scmnd)
 	return SCSI_EH_RESET_TIMER;
 }
 
-static bool storvsc_scsi_cmd_ok(struct scsi_cmnd *scmnd)
-{
-	bool allowed = true;
-	u8 scsi_op = scmnd->cmnd[0];
-
-	switch (scsi_op) {
-	/* the host does not handle WRITE_SAME, log accident usage */
-	case WRITE_SAME:
-	/*
-	 * smartd sends this command and the host does not handle
-	 * this. So, don't send it.
-	 */
-	case SET_WINDOW:
-		set_host_byte(scmnd, DID_ERROR);
-		allowed = false;
-		break;
-	default:
-		break;
-	}
-	return allowed;
-}
-
 static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 						struct scsi_cmnd *scmnd)
 {
@@ -1738,21 +1720,6 @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *host,
 	u32 payload_sz;
 	u32 length;
 
-	if (vmstor_proto_version <= VMSTOR_PROTO_VERSION_WIN8) {
-		/*
-		 * On legacy hosts filter unimplemented commands.
-		 * Future hosts are expected to correctly handle
-		 * unsupported commands. Furthermore, it is
-		 * possible that some of the currently
-		 * unsupported commands maybe supported in
-		 * future versions of the host.
-		 */
-		if (!storvsc_scsi_cmd_ok(scmnd)) {
-			scsi_done(scmnd);
-			return 0;
-		}
-	}
-
 	/* Setup the cmd request */
 	cmd_request->cmd = scmnd;
 
-- 
2.25.1

