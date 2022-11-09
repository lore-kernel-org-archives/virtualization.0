Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B6C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 10:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FF2A4019D;
	Wed,  9 Nov 2022 10:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FF2A4019D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBS/5H4w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hl6PvHqPcHfO; Wed,  9 Nov 2022 10:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BA5440B15;
	Wed,  9 Nov 2022 10:25:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BA5440B15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 089C8C0033;
	Wed,  9 Nov 2022 10:25:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48976C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EFBA813A2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EFBA813A2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HBS/5H4w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3O5f0vEHyPhs
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8434E81358
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8434E81358
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667989510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=auSM+70YRosWZy5ukGqkwDOs/DSEICJ2nlPZ92XyH9s=;
 b=HBS/5H4w+eivkySfPKHLwZOm+1Hn7eDmvB/3HrgdA7QkVJ04Dv7WmW7lYjiOktfT6x1t8k
 lO9Z/Az64W4MbUrtbyu/GoBlGdHHbmXdH+wyKNTsU+eZn4O7l9IlT401gzSy3airWk01b0
 WfT3to+zBWY857d9bTmnUg4vyJDI5og=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-529-3cIKskk8NMS4HGfhmGyhKA-1; Wed, 09 Nov 2022 05:25:09 -0500
X-MC-Unique: 3cIKskk8NMS4HGfhmGyhKA-1
Received: by mail-qk1-f200.google.com with SMTP id
 ay43-20020a05620a17ab00b006fa30ed61fdso15244631qkb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 02:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auSM+70YRosWZy5ukGqkwDOs/DSEICJ2nlPZ92XyH9s=;
 b=ZzEuc1AbPbLO3G+xt/5Yee2TXII81m2ZjjQDnqrRvGWGH192zeuXJJOXJz7KW7sYAf
 1Hwyq9S/eQ/jw6cGeuWp2F2A5atJKSBWg9MCksefQ38vyV3b43j8r/5F1QDhrADwPC31
 M2gXtHbJ4k9D8JvBHtDsNVA8qVZUoAlerg0MpZtELcY2+xJFR7tvI0x8VvUVApVS8Wuy
 Ej7sh7b7oYNcpOOnjJOPMQCGqyDH//6LQ0UmxN4D5ax35sEQUWE/01h9g3lobB9I2fYu
 8FiG12hROY61gddD3otAxEga7+bAHVDu7/ppNLVQ56oYmVyr5bw8xVAF+bEB+uW3oAxe
 kNow==
X-Gm-Message-State: ACrzQf0x1bAEiLoojVoXcxF+W8gGDMjrN9OZ1Af8Yb+9PpvwSb3yh8B9
 NxDesCZpHOkMMmI6guL5hXTiv55jtK94uyL4esJKplU4WQTJUL7tqhzHX+iEol/zMyP7WybZvYd
 3eZYCen5Ly05SSAOnZc8C5RSYg9lni7MrjDvyYceJUzpFWOVdKWkZnBqB8KSHrkz8wbevnilpiG
 98w/s2WsiQ0FZfvUALbQ==
X-Received: by 2002:a05:620a:e11:b0:6fa:7435:a409 with SMTP id
 y17-20020a05620a0e1100b006fa7435a409mr23294697qkm.51.1667989508304; 
 Wed, 09 Nov 2022 02:25:08 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7kIiD5hF1VgY+01R04+NKJB6TMPdY1YIPB/qSgWreKxEVuImtPVMcdEaGEZOnk3bJsKCVWaA==
X-Received: by 2002:a05:620a:e11:b0:6fa:7435:a409 with SMTP id
 y17-20020a05620a0e1100b006fa7435a409mr23294682qkm.51.1667989507953; 
 Wed, 09 Nov 2022 02:25:07 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bj10-20020a05620a190a00b006fa313bf185sm10827522qkb.8.2022.11.09.02.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 02:25:07 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/2] vhost: fix ranges when call vhost_iotlb_itree_first()
Date: Wed,  9 Nov 2022 11:25:01 +0100
Message-Id: <20221109102503.18816-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

v2:
- Patch 2: Replaced Fixes tag with the right one [Jason]

v1: https://lore.kernel.org/virtualization/20221108103437.105327-1-sgarzare@redhat.com/

While I was working on vringh to support VA in vringh_*_iotlb()
I saw that the range we use in iotlb_translate() when we call
vhost_iotlb_itree_first() was not correct IIUC.
So I looked at all the calls and found that in vhost.c as well.

I didn't observe a failure and I don't have a reproducer because
I noticed the problem by looking at the code.

Maybe we didn't have a problem, because a shorter range was being
returned anyway and the loop stopped taking into account the total
amount of bytes translated, but I think it's better to fix.

Thanks,
Stefano

Stefano Garzarella (2):
  vringh: fix range used in iotlb_translate()
  vhost: fix range used in translate_desc()

 drivers/vhost/vhost.c  | 4 ++--
 drivers/vhost/vringh.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
