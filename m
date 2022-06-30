Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E77C43334
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 19:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4A3F84676;
	Thu, 30 Jun 2022 19:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4A3F84676
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LHwwShjZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AAXyZgn3dJZh; Thu, 30 Jun 2022 19:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55EAD84048;
	Thu, 30 Jun 2022 19:16:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55EAD84048
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A4DBC002D;
	Thu, 30 Jun 2022 19:16:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45B58C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20E5C84673
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:16:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20E5C84673
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4eVjQK87aQDm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:16:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41FC28466E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41FC28466E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656616580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=YfIy+4gvd/lbZdQIcXGuL2bNS8ZcX5l36dLsXmKY+tU=;
 b=LHwwShjZBFQAJFxOEfjXp+DzR8E2MUzek1FaD/jZi524h5AcVYzvgiSg6yD4IcchgsCJgF
 Lmtsr4TePFcQOfNNsw4FEHOg4DR1c9rpA+20zXEJa0vlLCGmAtCxCttu49OKmEhTW3KsmO
 b6hqwSMui6xuKPCJMWpL7p7QER67xF4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-JJ7sMBryPaSuKugEMA22xg-1; Thu, 30 Jun 2022 15:16:19 -0400
X-MC-Unique: JJ7sMBryPaSuKugEMA22xg-1
Received: by mail-wr1-f71.google.com with SMTP id
 u9-20020adfa189000000b0021b8b3c8f74so3331930wru.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 12:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=YfIy+4gvd/lbZdQIcXGuL2bNS8ZcX5l36dLsXmKY+tU=;
 b=v1GPJVp6W5L5iYfb98mBlxS7GslMt4tCPuJE1nhU/UhgllP2DbAFbFiCDn4qvPuLpq
 TLi362hiriUPEIsKj7H283rmYWRu23bUW9Tw+KlOkkYKmVcP0t6CKcI9aN+9TUQU1+RU
 ntX022BXMuV4VYdFcrmqROsWgyWCU6f2it/oGlCWDArRmb38o6SP6/ELvTJoVQXtb9n0
 HSsJQ2V1jol9hDfYpIIz9eSWDgzNRUeepfvBlJG01DaGn5Y+wS8BOb3JICWALZXd4ZtX
 cSU66xG2ryO+27jx8czKi9jS/4SJGlkuZ+yypsZMhwWcKxGQlz5Q3aW+X23aMgNhXnz+
 L8Tg==
X-Gm-Message-State: AJIora/ncocz8lcDbnsIwIhjVlnAN9clyd8q1SFBTRvgoEp7Z+e6k1jV
 BvwLMWAalW6enCBXdhQRrh6BhQASlZUsv4bGt1qyZYjkz+j1PhX5b1PB13tWiMIXEN1jGVoNay1
 E64w5UJWQdjCatfO0dgJ5icalEjpyAb6qIi4lMTbQww==
X-Received: by 2002:a5d:584e:0:b0:21c:e4db:35e with SMTP id
 i14-20020a5d584e000000b0021ce4db035emr9821064wrf.192.1656616577942; 
 Thu, 30 Jun 2022 12:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIKmZuYR4ZzwFuRRqKsirvt0WLtvLcOYn6IIXl1lJjoxm21cIWDoqwMpYY9h/B+uEIpeJSmA==
X-Received: by 2002:a5d:584e:0:b0:21c:e4db:35e with SMTP id
 i14-20020a5d584e000000b0021ce4db035emr9821043wrf.192.1656616577714; 
 Thu, 30 Jun 2022 12:16:17 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d6e53000000b002102b16b9a4sm20128454wrz.110.2022.06.30.12.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 12:16:17 -0700 (PDT)
Date: Thu, 30 Jun 2022 15:16:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: VIRTIO_HARDEN_NOTIFICATION is broken
Message-ID: <20220630191559.16738-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>,
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

This option doesn't really work and breaks too many drivers.
Not yet sure what's the right thing to do, for now
let's make sure randconfig isn't broken by this.

Fixes: c346dae4f3fb ("virtio: disable notification hardening by default")
Cc: "Jason Wang" <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index e1556d2a355a..afb9051e0125 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -31,11 +31,12 @@ if VIRTIO_MENU
 
 config VIRTIO_HARDEN_NOTIFICATION
         bool "Harden virtio notification"
+        depends on BROKEN
         help
           Enable this to harden the device notifications and suppress
           those that happen at a time where notifications are illegal.
 
-          Experimental: Note that several drivers still have bugs that
+          Experimental: Note that several drivers still have issues that
           may cause crashes or hangs when correct handling of
           notifications is enforced; depending on the subset of
           drivers and devices you use, this may or may not work.
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
