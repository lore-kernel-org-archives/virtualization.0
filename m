Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1873C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850032065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vjlh1AbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850032065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4C57C20401;
	Wed,  5 Aug 2020 13:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwZTNAdTWlrN; Wed,  5 Aug 2020 13:44:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 697A92152A;
	Wed,  5 Aug 2020 13:44:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54261C0051;
	Wed,  5 Aug 2020 13:44:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35546C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0C3E28820F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sxwYHUQ3ygQB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 71E5B881A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vN/9HN97A/Ugw3D0Jvhp+JbXzLKFGpnuu9RYydUjNE=;
 b=Vjlh1AbAPgG3bOlh02mjjPec13SoOOMKd8EGD7sWGpbPWxfsc98ol9FRLDEuC2MPSut50X
 fNQSX8KWGpoJy07TNwjUBbCu03pd7VmHzQczpqkYJYHrS6dbKUDvsp6mefv/GWaEqPTgYm
 fe7m2lc1sytVWVh2GD1RqDSQDS8huPc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-DomkS46tPkeitD4yx1Xf3A-1; Wed, 05 Aug 2020 09:44:26 -0400
X-MC-Unique: DomkS46tPkeitD4yx1Xf3A-1
Received: by mail-wm1-f72.google.com with SMTP id p23so2474894wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2vN/9HN97A/Ugw3D0Jvhp+JbXzLKFGpnuu9RYydUjNE=;
 b=UE172qO1PD/ymevPKkUUmTW2DfEpVYcjFIY5wfxTA1p2jcRMfF3mU1WOU5Y+T2/b8V
 d9wLZAOmriy6QutbknZI9fKczb/WkgS/KRWNGbUmaAYCdgyXqnrlOYwrxoZjLQnoT+8M
 oux69/pPhNUwCB36z1zDRw3P8Bx0nv9atr3lS3iLJz4EHbse7utWqUNt3s5FJ21OuRhQ
 tDJCmh8d//QV4m5kFvQiU+Qv0GMs/zwv19GdNNtgOV+QRa1Oe6tfaEeX4NYTEF4reVG8
 abJMSy8bThMGzXugEzt/gjkRNdtD0H+V6VRQ05S19NPrsR0aoBUdvfREoqAkS9nR4qs1
 vB8g==
X-Gm-Message-State: AOAM530R9t/U9bIet1rjIy4cNdAxdIgBAioeCYbtY1GF+9L3xZkLU2eT
 JlYmvVRBc1ftpiWVouLWNJjmISQR4f4urHsDWSz70zrRJ2DaZEK567IZP65LqGZ0hTpFv3mvsgx
 SwKZs2E8CXq0supS3zXLuLyVmO25MH83eqiltp86ViA==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr3374863wmb.178.1596635065852; 
 Wed, 05 Aug 2020 06:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmniM9W5lxfG5OVlWrJIftYWunBp9QME57w+VcOK3P/UiXZQDwUzDQdDREKoZWY3QgAfUYbg==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr3374854wmb.178.1596635065695; 
 Wed, 05 Aug 2020 06:44:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 c17sm2899239wrc.42.2020.08.05.06.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:25 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 25/38] virtio_config: disallow native type fields (again)
Message-ID: <20200805134226.1106164-26-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

_Generic version allowed __uXX types but that is no longer necessary:

Transitional devices should all use __virtioXX types (and __leXX for
fields not present in the legacy devices).
Modern ones should use __leXX.
_uXX type would be a bug.
Let's prevent that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7fa000f02721..441fd6dd42ab 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -304,13 +304,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 				 __u8: (x), \
 				 __le16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
 				 __le32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
-				 __le64: virtio64_to_cpu((vdev), (__force __virtio64)(x)), \
-				 default: _Generic((x), \
-						  __u8: (x), \
-						  __u16: virtio16_to_cpu((vdev), (__force __virtio16)(x)), \
-						  __u32: virtio32_to_cpu((vdev), (__force __virtio32)(x)), \
-						  __u64: virtio64_to_cpu((vdev), (__force __virtio64)(x)) \
-						  ) \
+				 __le64: virtio64_to_cpu((vdev), (__force __virtio64)(x)) \
 				 ) \
 		)
 
@@ -330,13 +324,7 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 				 __u8: (x), \
 				 __le16: (__force __le16)cpu_to_virtio16((vdev), (x)), \
 				 __le32: (__force __le32)cpu_to_virtio32((vdev), (x)), \
-				 __le64: (__force __le64)cpu_to_virtio64((vdev), (x)), \
-				 default: _Generic((m), \
-						  __u8: (x), \
-						  __u16: (__force __u16)cpu_to_virtio16((vdev), (x)), \
-						  __u32: (__force __u32)cpu_to_virtio32((vdev), (x)), \
-						  __u64: (__force __u64)cpu_to_virtio64((vdev), (x)) \
-						  ) \
+				 __le64: (__force __le64)cpu_to_virtio64((vdev), (x)) \
 				 ) \
 		)
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
