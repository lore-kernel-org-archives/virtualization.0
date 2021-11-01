Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554D1C433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 09:11:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C61610CA
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 09:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8C61610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACD3740131;
	Mon,  1 Nov 2021 09:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4DHPRsFW5w1M; Mon,  1 Nov 2021 09:11:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 314B1400CC;
	Mon,  1 Nov 2021 09:11:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 011FEC0012;
	Mon,  1 Nov 2021 09:11:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 949E1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 09:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7796F80CEC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 09:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_4Jhw24gYYn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 09:11:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE5E480CEB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635757890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2W7P6GktRsi14ktbeTR+//wKtS91dY+AJDqQY5GsUpU=;
 b=ApIlb+yDsbh0QdyKYkTV+sn+0YFdYKdu7vSxn3Cp9xo7H1p5yWfsvRQUYCyH18vSzPT5dj
 bC0Xqv28RenHgUxZmKrjbdFdC5TSqbjtgSZH+wZbAPrdK2CWLCQoIHTHmgY8g13rjPe5Un
 bW6QvtnLDO5G/DAt1BlfdGfhP72RuQM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-x9FaJ_B5M9-_zdhShXS5Pw-1; Mon, 01 Nov 2021 05:11:29 -0400
X-MC-Unique: x9FaJ_B5M9-_zdhShXS5Pw-1
Received: by mail-ed1-f69.google.com with SMTP id
 r25-20020a05640216d900b003dca3501ab4so14900993edx.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 02:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=2W7P6GktRsi14ktbeTR+//wKtS91dY+AJDqQY5GsUpU=;
 b=44esevkQxFlTA/fnOqOt076JEQXu3efg/q8aduZPofywbfVu9o5ymP+aQJtrtequ/o
 kjsEx5IwS0/yNjczt/Mh/+96HK6Vgu4W8pXGdoApPC+aKGCCq+tHYQrz8/IwQjpZcNnI
 AAy7W/+IuKkEuAlSR6icu7spIauFp69avpqdNgUukTlD0dTbda3axiAmeyLAnTwFN2N2
 /RumyNO6cGQ2DyBLkE6sAzkAc9JN/ltrZJTZx3RnQ1rsoFmwMIq1JYXPhmX/qO4kZMCo
 1mJCqEuaGD6AGoMmPyC1YEgEEIMedMPTL+wjyLZQU6THFhAPwSFets1AlSv8ZkgmbU3j
 buuQ==
X-Gm-Message-State: AOAM531pyZ2ibGrcI6wb0/A0nHZDTuD5zmdUDSvjA8Ue3NG1vOXiEiXH
 6Uys9xy2KQ5b2wM/YI0Dbr/kR4OG1mZTYR0EPPDMaNS2EghN57xeT47FmEFVJYCnHzMzUmg96ao
 syeHEMFQU3IDLCCWmruCx3cu7C7PfPxILdWYrT7N4gA==
X-Received: by 2002:a17:907:7215:: with SMTP id
 dr21mr16826616ejc.505.1635757888529; 
 Mon, 01 Nov 2021 02:11:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGFjVuS5ieqvbfX0iqQUSp1YKsugqWB3cvdDo7TtxlMqzMZiJotDXzX2Nh2NnX9BU8QL6UDA==
X-Received: by 2002:a17:907:7215:: with SMTP id
 dr21mr16826599ejc.505.1635757888385; 
 Mon, 01 Nov 2021 02:11:28 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107f:7087:907d:ff12:1534:78b7])
 by smtp.gmail.com with ESMTPSA id g12sm2377939edz.68.2021.11.01.02.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 02:11:27 -0700 (PDT)
Date: Mon, 1 Nov 2021 05:11:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_gpio: drop packed attribute
Message-ID: <20211101091122.442512-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Viresh Kumar <vireshk@kernel.org>,
 virtualization@lists.linux-foundation.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, linux-gpio@vger.kernel.org
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

Declaring the struct packed here is mostly harmless,
but gives a bad example for people to copy.
As the struct is packed and aligned manually,
let's just drop the attribute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
index 0445f905d8cc..25c95a034674 100644
--- a/include/uapi/linux/virtio_gpio.h
+++ b/include/uapi/linux/virtio_gpio.h
@@ -25,7 +25,7 @@ struct virtio_gpio_config {
 	__le16 ngpio;
 	__u8 padding[2];
 	__le32 gpio_names_size;
-} __packed;
+};
 
 /* Virtio GPIO Request / Response */
 struct virtio_gpio_request {
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
