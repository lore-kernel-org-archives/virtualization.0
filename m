Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B832C433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 13:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0D1E82E5F;
	Thu,  6 Jan 2022 13:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDNePtCU50wH; Thu,  6 Jan 2022 13:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A13A882D14;
	Thu,  6 Jan 2022 13:00:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8933BC0030;
	Thu,  6 Jan 2022 13:00:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13CDAC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E79106FBE0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sTn0JIVIhKos
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:00:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 528766FBDA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641474053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=nwzCKRlarcXm1RHufaPsJW9CI1uQM/UHS6c0Nx6knro=;
 b=Fucu49jY671i6KGsWAFJ/4EIgggWgDSXbRacLghyVJ4EvarqtyfjPdhtqpt022b6pFJIhI
 SGEBMqpnoVSAFQXOzFUARmWMLFPkr77+DVmYLYbVkwyYvzCmXeUIZeI0RL1dwArimMxkoZ
 XMsHcrhRnaoPaw0GfDNBge8Jolusf/o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-L00oteHmMP6BjwIUo4XLpQ-1; Thu, 06 Jan 2022 08:00:52 -0500
X-MC-Unique: L00oteHmMP6BjwIUo4XLpQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 w2-20020adfbac2000000b001a540eeb812so542058wrg.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 05:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=nwzCKRlarcXm1RHufaPsJW9CI1uQM/UHS6c0Nx6knro=;
 b=ejNhSW64CLy5rLcU2nKfNKeTKeyCkprJKt5Bzhy5BInu6xA+AtQD5tNQ+jqEoAJJDh
 aS+GGJlsouaGoF6kgtP7Owm3GhinS81W8psCs+2N1DVUbVbnuQOB7LA777J2s7hi7+vF
 DFMgmGOV5dTcUy6aYMt+u02pkjQeIoaYlA3cnerTYNM4XrGDWOf+EqlnvaFGNOOPM7A8
 s/+oGRjHU/0HOB+Grgl5sX0a2OUuHs4uC6HbL/OWdpRCtHkl7SwiQZcBrOb10/KFApFH
 k9EShs0VgtfZlgw7LupE3RnNj3Mp8CGjvXSs4VEZZmnH0s1wG0pA/HgEjGDevQ/WGaNU
 xiUw==
X-Gm-Message-State: AOAM533bPfIS+HiXPv8KG3ikDEWuM/IHQVplv/8qflYbuQVjcqvHmZeu
 1RvDF6js7pqVNuMjZMHW/HMBCO7pOtBUaTwJXavkhayZAH+qRm9uOp3/Px+toNJ26fZLsRScMxG
 5EtFkVpgS27Ii7BGx8bzcLL7qWp2VBkG/U1dwttQe8g==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr50571960wrc.29.1641474050937; 
 Thu, 06 Jan 2022 05:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8sjEET+CFZdglHMPDN4E8uNhAyHPhpS/seTRaepk7Pmro3HZna6jkZjGbwE/mzv/D/1wVFg==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr50571942wrc.29.1641474050718; 
 Thu, 06 Jan 2022 05:00:50 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
 by smtp.gmail.com with ESMTPSA id o8sm2436559wry.20.2022.01.06.05.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 05:00:50 -0800 (PST)
Date: Thu, 6 Jan 2022 08:00:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: mark ring unused on error
Message-ID: <20220106130046.422417-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 virtualization@lists.linux-foundation.org
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

A recently added error path does not mark ring unused when exiting on
OOM, which will lead to BUG on the next entry in debug builds.

TODO: refactor code so we have START_USE and END_USE in the same function.

Fixes: fc6d70f40b3d ("virtio_ring: check desc == NULL when using indirect with packed")
Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 028b05d44546..962f1477b1fa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1197,8 +1197,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	if (virtqueue_use_indirect(_vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
 						    in_sgs, data, gfp);
-		if (err != -ENOMEM)
+		if (err != -ENOMEM) {
+			END_USE(vq);
 			return err;
+		}
 
 		/* fall back on direct */
 	}
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
