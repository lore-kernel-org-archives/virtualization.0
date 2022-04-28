Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF4AC43217
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 13:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 990C5832AA;
	Thu, 28 Apr 2022 13:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FeUCkhC_BUij; Thu, 28 Apr 2022 13:22:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 256488308A;
	Thu, 28 Apr 2022 13:22:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6647C0039;
	Thu, 28 Apr 2022 13:22:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C72DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B45EF40A63
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id krhMHrLUA8os
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19FA6401C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8PQduM8Cm6+v2eU6zkUJYKtrg0KGSwBOax3SMcC5NWw=;
 b=W6WWe3E6U8AXsgmry9eTJVCRhKqg2UXp835zoD2Du3l9nN2UoP/+OADPC8hNv+gH+Gwgvd
 ROcH+tYlTpIVQtL6B4FXF56/v5/euKG6hufu+/uClXHgheDLAzV3EJn+4+pn0YwP/OmywQ
 L641Gv985pk0XxHYfXx521d1AHc6Kw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-BD8LTTChNWCKnv6NHBz-8Q-1; Thu, 28 Apr 2022 09:22:45 -0400
X-MC-Unique: BD8LTTChNWCKnv6NHBz-8Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 l11-20020adfc78b000000b0020abc1ce7e4so1943241wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8PQduM8Cm6+v2eU6zkUJYKtrg0KGSwBOax3SMcC5NWw=;
 b=TxN8xuE1dcc9zS06LemuulCJELldllQ0CyZ4HQRnKQWvxl4a8cuRQZO3l7LGNxiDP2
 K43W3tbrlxZcJB+oIyUZNGDcR1Cq4j9R+GjpvKyQ3bD8SDUogc1xaOu+NaGlmcCGnNSO
 UZa+qgo8AuJpegkPZCaR2FtF+npQikuocrgBnIBkXONVeZBozdfFgvMOLi/CC++ZLPgC
 fQM8ku1lKdqSeJSEdxIoU/mbvFesHwbQZBRcHCj529KD8vAsld6nkwIjyLwcETs6Bpya
 WWWblLUtjFKHTwral7cxaKky6SVyGajs/WfbBHfP74DTA+ztYdbewtZZzkXc4SvvUMcE
 VwBA==
X-Gm-Message-State: AOAM5333qbjvv+2wY+Qg3LWFmKHcFz/z0tuufqRfgYg9E312Uqz0U4h4
 7zQYZ3+iyQWNRL0TB4DPLdAN9TVddKaQMnIvDJyb3Kaqb2tVLmPwviIey70z9ELrHTIEqaL/Tas
 +QqR6UIEmUj94k6q7cdS6tluw3xxPAQ33ypn4U2hWlA==
X-Received: by 2002:a1c:2185:0:b0:38f:f4ed:f964 with SMTP id
 h127-20020a1c2185000000b0038ff4edf964mr31065700wmh.115.1651152164528; 
 Thu, 28 Apr 2022 06:22:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh0SQ9LojN8eIegKUo+h+ntmqGzG2tJdfRq4/rRAMPBONENZjji/VGZxEgoBORxb2iYpBK1g==
X-Received: by 2002:a1c:2185:0:b0:38f:f4ed:f964 with SMTP id
 h127-20020a1c2185000000b0038ff4edf964mr31065683wmh.115.1651152164320; 
 Thu, 28 Apr 2022 06:22:44 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b00393f1393abfsm4680978wmq.41.2022.04.28.06.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 06:22:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] vsock/virtio: add support for device
 suspend/resume
Date: Thu, 28 Apr 2022 15:22:39 +0200
Message-Id: <20220428132241.152679-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Vilas R K <vilas.r.k@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

Vilas reported that virtio-vsock no longer worked properly after
suspend/resume (echo mem >/sys/power/state).
It was impossible to connect to the host and vice versa.

Indeed, the support has never been implemented.

This series implement .freeze and .restore callbacks of struct virtio_driver
to support device suspend/resume.

The first patch factors our the code to initialize and delete VQs.
The second patch uses that code to support device suspend/resume.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Stefano Garzarella (2):
  vsock/virtio: factor our the code to initialize and delete VQs
  vsock/virtio: add support for device suspend/resume

 net/vmw_vsock/virtio_transport.c | 197 ++++++++++++++++++++-----------
 1 file changed, 131 insertions(+), 66 deletions(-)

-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
