Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B945C6FD1D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 10:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EA90410D2;
	Mon, 20 Mar 2023 10:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EA90410D2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=DnD94Rnr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKMAWM8T_Rfs; Mon, 20 Mar 2023 10:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 519E94099E;
	Mon, 20 Mar 2023 10:18:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 519E94099E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA5DC0071;
	Mon, 20 Mar 2023 10:18:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82054C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FA6560BC8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FA6560BC8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=DnD94Rnr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tEqRVw2-yarP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BC2060BB6
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BC2060BB6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 10:18:51 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 o11-20020a05600c4fcb00b003eb33ea29a8so7131824wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112; t=1679307529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n18OP7vPSdiYnBPUq25VSrwcsl/zefO9nV/TBkIRO8M=;
 b=DnD94Rnrhftphu8V7H9+J6dJiS8600LbsNonmDQLt9/v1zm3iv8gwtMhB5EQPm+KKe
 Ao4gALqE0mftVT5D3H4SU3Kr+wBU5VSnEdDrnzOvJxUM8X/mbYC0xeQv3zudaVbTOmPE
 PFycjDlUWjFjbRbn81I19M11WHUN85eIYwuRUm6HNKk8qk7GG6qJZvelmtVkgHeAHVtj
 q4GeSK4e16hFae8tnXf1+Lx2tuvNdL3IVuR5dMHlQ9lIepJHwEz3OasD4DwFnXfCSuV7
 sJHLJwfu3ill9swpTTsn3lEAVUzPERMrN74nbxmmm6p4eEZE6JPjZkfZ9P6fuIt4Cor8
 ooCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679307529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n18OP7vPSdiYnBPUq25VSrwcsl/zefO9nV/TBkIRO8M=;
 b=Vn2lY0ttGhqYfasBBM1XhQ7W8t6Zp+1FzIGCaS1leyHfxNIQRPVN9qXSAew/6dSEu2
 80uwph3ezraGeEh+4lfDc1DCfsee/oPFcBLliKvlnly+zBiqkl1Ew2vkxvFSCnOIuTwO
 N/mjEy0xPc3qwoY/8rfAawlQR+9fb47QM3/Wmizp9NIq5rdAzJ/tBO3ompVHL7b6kiwT
 HPy9AwSQ6erJqNM4VilD0FcDyRClbqv+O5PC/BZdPVBT7d8cCsljqCWo4T3A1zmfqecX
 5dOqG1qs+ByoiL525ODk0NsOVwl2QxB/jgj3P8E+egWrmRQVAKgoWfFivdxz/phGFgJc
 cu1g==
X-Gm-Message-State: AO0yUKULX7XczKCkjGbDGlpZ3WtMJKBlsLUDlQbe5hpygMFlVOvLx8Kk
 42n1sDXPjcZ54YknEqeUzUBi575vd8/8J7Vt2bU=
X-Google-Smtp-Source: AK7set96UsSp9JEvMCd4yhEXgjA21NiWcJy31Gf0bOubwMKnumYeXOBNO9sKv642OppzUqarHCGaog==
X-Received: by 2002:a05:600c:314d:b0:3eb:3945:d3fd with SMTP id
 h13-20020a05600c314d00b003eb3945d3fdmr32919273wmo.14.1679307529074; 
 Mon, 20 Mar 2023 03:18:49 -0700 (PDT)
Received: from alvaro-dell.. (bzq-84-110-153-254.static-ip.bezeqint.net.
 [84.110.153.254]) by smtp.gmail.com with ESMTPSA id
 q2-20020a1ce902000000b003ed1fa34bd3sm10031509wmc.13.2023.03.20.03.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 03:18:48 -0700 (PDT)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] vdpa/snet: support the suspend vDPA callback
Date: Mon, 20 Mar 2023 12:18:17 +0200
Message-Id: <20230320101817.680402-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
References: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

When suspend is called, the driver sends a suspend command to the DPU
through the control mechanism.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_ctrl.c |  6 ++++++
 drivers/vdpa/solidrun/snet_main.c | 15 +++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
index 54909549a00..7bbbbd08e6f 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -15,6 +15,7 @@
 enum snet_ctrl_opcodes {
 	SNET_CTRL_OP_DESTROY = 1,
 	SNET_CTRL_OP_READ_VQ_STATE,
+	SNET_CTRL_OP_SUSPEND,
 };
 
 #define SNET_CTRL_TIMEOUT	        2000000
@@ -316,3 +317,8 @@ int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
 	return snet_ctrl_read_from_dpu(snet, SNET_CTRL_OP_READ_VQ_STATE, idx, state,
 				       sizeof(*state));
 }
+
+int snet_suspend_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_SUSPEND, 0);
+}
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index daeb69d00ed..96830e58211 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -483,6 +483,20 @@ static void snet_set_config(struct vdpa_device *vdev, unsigned int offset,
 		iowrite8(*buf_ptr++, cfg_ptr + i);
 }
 
+static int snet_suspend(struct vdpa_device *vdev)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+	int ret;
+
+	ret = snet_suspend_dev(snet);
+	if (ret)
+		SNET_ERR(snet->pdev, "SNET[%u] suspend failed, err: %d\n", snet->sid, ret);
+	else
+		SNET_DBG(snet->pdev, "Suspend SNET[%u] device\n", snet->sid);
+
+	return ret;
+}
+
 static const struct vdpa_config_ops snet_config_ops = {
 	.set_vq_address         = snet_set_vq_address,
 	.set_vq_num             = snet_set_vq_num,
@@ -508,6 +522,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 	.set_status             = snet_set_status,
 	.get_config             = snet_get_config,
 	.set_config             = snet_set_config,
+	.suspend		= snet_suspend,
 };
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
index a4213e97cfc..6dbb95fe2b7 100644
--- a/drivers/vdpa/solidrun/snet_vdpa.h
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -201,5 +201,6 @@ void psnet_create_hwmon(struct pci_dev *pdev);
 void snet_ctrl_clear(struct snet *snet);
 int snet_destroy_dev(struct snet *snet);
 int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state);
+int snet_suspend_dev(struct snet *snet);
 
 #endif //_SNET_VDPA_H_
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
