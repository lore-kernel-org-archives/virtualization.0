Return-Path: <SRS0=BGPi=LA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE45C47096
	for <virtualization@archiver.kernel.org>; Sun,  6 Jun 2021 13:29:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248DB613D4
	for <virtualization@archiver.kernel.org>; Sun,  6 Jun 2021 13:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248DB613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D202B40243;
	Sun,  6 Jun 2021 13:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t4vwN7bAMBMP; Sun,  6 Jun 2021 13:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA6FF40153;
	Sun,  6 Jun 2021 13:29:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB5EDC000D;
	Sun,  6 Jun 2021 13:29:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74FE2C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 13:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E0AC6078B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 13:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnp_O5XqeAap
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 13:29:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B129A6069D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 13:29:10 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id h16so8217375pjv.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hYcKAmYrkT12yrCkZCPxBOfTA321ZJWoXkYrMXfOxJ0=;
 b=WQueEqbo2NBlKjvZ6KO/rLFnz5TpCCSTcmQMDcf8qtQHRJyp6tjkvQqjMDDvRWNvg/
 ojY8msMKfjue0x9xNFLV3t9l/kCCZeo4JZAtzeTrJkJn3SFMywdU2rbl7Bd9WakOBlRt
 YAkrkqMw8+KgLDVnCzFAlNQ2pzF9dRv5CMtiVoVq1m4MkFGfG+VbcraT09mYoB0nW95S
 S4POp00X3jRUtpk/R9SiR0aACf9o8cOZZo8DgNZhtn9cFN5sK4dLesBr9cQ176nXSfwd
 miSgxm/3GlEik79UCHguP4u3DWg9W5kiYmjWSfiZLY9AHLffbf2fsBGYawntp6VsMINT
 VOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hYcKAmYrkT12yrCkZCPxBOfTA321ZJWoXkYrMXfOxJ0=;
 b=EDp/CcQ0KyFKMev9xQ9gv4hIw59Gk08sXI8TxcUKvX8GGbKDSFO/PQ03XW11n0XfPD
 aiEt2+IEI2ZzxoS+fI1spOkjxDVkd7VEbUhkMU6ylILuwXtijouWRABbRAn5A7lUDXLT
 6NeKmmjv4+0IUhp2uVMX9mWCUKA3KhLuU9lpSFqjOhDQuOy7PfSSmmXJ6cAI7zeiLk7M
 6TIYrFY+DEhD2TuI/feHOMO9oaMvNVyBzlt5vxEC/SC0OrqfUO+1nFDne086xcuXzkrl
 qTJmknaxaRrD3ZylyGDhNIS2meD18HxTdzDr3RDF9j54DplpTQKuSW+NtKouEUKFCHYb
 TRtQ==
X-Gm-Message-State: AOAM530IGI2awoDg69fs0ZqIBBJmi5nR6GB1OKV+eS6oCTaAOshHI/o3
 35r2tJhbP72ayjTxekp8FjY=
X-Google-Smtp-Source: ABdhPJyj2di16bPb/HKfLXkHVUGrsIbLZuBW9vI9YNQDT8Dz2RXLca9RdoJpECF8q1i5AX0DFaPRow==
X-Received: by 2002:a17:90b:4504:: with SMTP id
 iu4mr15678423pjb.110.1622986150087; 
 Sun, 06 Jun 2021 06:29:10 -0700 (PDT)
Received: from ndr730u.nd.solarflarecom.com ([182.71.24.30])
 by smtp.googlemail.com with ESMTPSA id bv3sm8252826pjb.1.2021.06.06.06.29.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 06 Jun 2021 06:29:09 -0700 (PDT)
From: Gautam Dawar <gdawar.xilinx@gmail.com>
To: 
Subject: [PATCH] vhost-vdpa: log warning message if vhost_vdpa_remove gets
 blocked
Date: Sun,  6 Jun 2021 18:59:09 +0530
Message-Id: <20210606132909.177640-1-gdawar.xilinx@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, martinh@xilinx.com,
 hanand@xilinx.com
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

From: Gautam Dawar <gdawar@xilinx.com>

If some module invokes vdpa_device_unregister (usually in the module
unload function) when the userspace app (eg. QEMU) which had opened
the vhost-vdpa character device is still running, vhost_vdpa_remove()
function will block indefinitely in call to wait_for_completion().

This causes the vdpa_device_unregister caller to hang and with a
usual side-effect of rmmod command not returning when this call
is in the module_exit function.

This patch converts the wait_for_completion call to its timeout based
counterpart (wait_for_completion_timeout) and also adds a warning
message to alert the user/administrator about this hang situation.

To eventually fix this problem, a mechanism will be required to let
vhost-vdpa module inform the userspace of this situation and
userspace will close the descriptor of vhost-vdpa char device.
This will enable vhost-vdpa to continue with graceful clean-up.

Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
---
 drivers/vhost/vdpa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bfa4c6ef554e..572b64d09b06 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1091,7 +1091,11 @@ static void vhost_vdpa_remove(struct vdpa_device *vdpa)
 		opened = atomic_cmpxchg(&v->opened, 0, 1);
 		if (!opened)
 			break;
-		wait_for_completion(&v->completion);
+		wait_for_completion_timeout(&v->completion,
+					    msecs_to_jiffies(1000));
+		dev_warn_ratelimited(&v->dev,
+				     "%s waiting for /dev/%s to be closed\n",
+				     __func__, dev_name(&v->dev));
 	} while (1);
 
 	put_device(&v->dev);
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
