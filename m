Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D6264A9E
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952216; cv=none; b=IRc9+M4F+yODNzhZ8yQ1a2h07cXzeWk54vuLv74ONsYs8fv93S+b98TtxrfVavUao4mkH8XbxhUSDFCiPRIGewmlsOseaKd4cvvuiD5AAlDtL069FeJyCZIx53CFd3L0gYdNX4gNTRkTBh8trYe4qMXiDzD5IZFvU8iOIRdnG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952216; c=relaxed/simple;
	bh=lz+21+pXWAdvl2nNDlkXW3ZFI2U/V3++gCtr1F/cu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fLctFP13u2L9PE898qOcFZeYehbS/wTcwrMH3nQVhzETlCAUTxtPqq8BqCUmM3KqGh+Lvh1fH1pnH9kv7kF4Uv9KiU7RCOq+bBpOOZwi+33a3XXtX8IQnCzEWey0fB3yMEvQblNLjzEl9EGvYZwRH5sAAM3DxXrdDuZAuYtfX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsB9wMXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsB9wMXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
	b=gsB9wMXK+0ghL3q7a/L5hYCT42ZoFaw016gabU6JxZMqPN4g/bZL0KvgGkQ+hr+g4s0Y7N
	uD69kk6iFdWwGesLC2YWzzeV1yRJ7CQ3uJJ2dzgMgJ0UGHexCoE8bBOnaGNILo7popICzv
	Av0mngneEKamVoZROGDHWRIk+J7gi+Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-JgumQKpIPdGzIpI1-I7t4w-1; Mon, 15 Sep 2025 12:03:32 -0400
X-MC-Unique: JgumQKpIPdGzIpI1-I7t4w-1
X-Mimecast-MFC-AGG-ID: JgumQKpIPdGzIpI1-I7t4w_1757952211
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b07c2924d53so241957866b.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 09:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952211; x=1758557011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
        b=kfEV12EKC5Lsvcg8KX/k6/QVjG8nEZcyNE5YHIOhRk06d8NXr3Fy2k+0/HrbhT4DSF
         JpM06X0OrNQRBhllIgjCWbjVawQUQ7NqXAZqXlXua5+0TaGTyp9ZgGeIQ4UYTMPQwn2t
         CCveuYXAhWIBT5HkqS1V1oV2lWjM0L+oVhfLsq1eMaBVpVu4oi1nxtIiHS+EORxUNifX
         3g+nq6tgk9FTXCaC6ZpGXs9dUo6UaxDKoh7Zi4ohOPSLxMy2fPDmtCY4y7AUbMs1wlO8
         1TscQ9mO4gbpwqSyxIVjzW4ky8FmiRfaPWyScGZNCq7St9MX5I0uL++DSvOxsfPNl6ci
         TSFg==
X-Forwarded-Encrypted: i=1; AJvYcCUm4mY2RBKy5FhGmW6hDj8/q7/yYEnvCFtGCk+X1v3LxczeU1vqgGw5GWJWO5WjtDOX92KxrwVZ2EqNyePbUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXzmXM0WAyuzXHBdgk8JuDGybDyT+xf7i06VxjVSUsYz6ilBog
	RTTLNdMmafKs/hZGVdiQ0pU0T81ddoEnQcQX+6ooaRWez5xRqcYUbD/Bsz47rQ4tUgk4ErKwJUy
	uzwh1wiyozmfakr00SsXTqZGzbeih2Lg3BdEv/O2hNFWJP4Fe4NitVKTwGDPIdnXBQBjx
X-Gm-Gg: ASbGncsLPhVRuo32ketes+hotDwmi2xSNIk2IRQkA/ECTBaC185AODsXGn4MgiVSZV+
	V8cYNriccNC9q9jjvMcSxZ0K71sE10RgcGVY7TfXv/Cz/lP1O1qpVrNFbhXIaY4hrTDH0A9zPdx
	70xRx796qU6paS+QSA8GMNccE0bU3JyxrvOjQB1gpZWiwIyI5UxMuiI6ffEzdeTf1zpMPPn+fO6
	e9Us8OAPSj3Hmiqx/stVtFD2BF3ctQxKlb4W0l0FcoZfnC8ljDqjACoK1egN313qnPcUslZxgmd
	4DsxHeavMsp1igAwE1p3zrymPNyj
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305642766b.27.1757952211050;
        Mon, 15 Sep 2025 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNtSBH6QlKSIfQdtkhP6WbRqJLxZsgUpRv3jEYGQSqAMd7B74yXmlLS/60ot7X5iMC+KioIg==
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305636166b.27.1757952210298;
        Mon, 15 Sep 2025 09:03:30 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd413sm988048866b.71.2025.09.15.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 3/3] vhost-net: flush batched before enabling notifications
Message-ID: <7b0c9cf7c81e39a59897b3a76d159aa0580b2baa.1757952021.git.mst@redhat.com>
References: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JMPg11ErDFU8WORwvAgqXNbOAqO1BZ9SdSEwT1v6A3I_1757952211
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is spotted.
This caused unexpected side effects as the new logic is reused for
several other error conditions.

A previous patch reverted 8c2e6b26ffe2. Now, bring the performance
back up by flushing batched buffers before enabling notifications.

Link: https://lore.kernel.org/all/20250915024703.2206-2-jasowang@redhat.com
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 57efd5c55f89..72ecb8691275 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -782,11 +782,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (head == vq->num) {
 			if (unlikely(busyloop_intr)) {
 				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev,
-								vq))) {
-				vhost_disable_notify(&net->dev, vq);
-				continue;
-			}
+			} else {
+				/* Flush batched packets before enabling
+				 * virtqueue notifications to reduce
+				 * unnecessary virtqueue kicks.
+				 */
+				vhost_tx_batch(net, nvq, sock, &msg);
+
+				if (unlikely(vhost_enable_notify(&net->dev,
+								 vq))) {
+					vhost_disable_notify(&net->dev, vq);
+					continue;
+				}
 			break;
 		}
 
-- 
MST

