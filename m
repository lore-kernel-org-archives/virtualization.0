Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E8CC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE1D382026;
	Thu,  2 Mar 2023 11:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE1D382026
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ctzjy7IO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EET4pSxNw_pn; Thu,  2 Mar 2023 11:34:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6309781454;
	Thu,  2 Mar 2023 11:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6309781454
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41529C0035;
	Thu,  2 Mar 2023 11:34:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF068C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA5B681F4A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA5B681F4A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8JPfqKKQ3gQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0593681EAD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0593681EAD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMUvg2hEs0iMx2dm3/Jg9b5hv2Rlumo7TQ+47EWr+7I=;
 b=ctzjy7IOsAmMYwZl40ufDvLIa2wuuX6J+zq1xNXP8sMVbwInEE+g4OZiYsPKo8sWGo7XI5
 xinc91Ze2rKv22+4JFjPIC2t4wMEn7vGBa9vved+mgrIcsw6XmRSJ3Kjh7pK5QYlS6NL40
 L1CTmL5hBv5QLb1wshdTZ2xSbtIDdD4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-45ajeA3uMemiHjmcxYEwqA-1; Thu, 02 Mar 2023 06:34:40 -0500
X-MC-Unique: 45ajeA3uMemiHjmcxYEwqA-1
Received: by mail-qv1-f69.google.com with SMTP id
 e9-20020a0cf749000000b00571f1377451so8751967qvo.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMUvg2hEs0iMx2dm3/Jg9b5hv2Rlumo7TQ+47EWr+7I=;
 b=acQ2eutYdlvHOQCtUy5lJfveQStmWTslbRjO99dhvmYW5MyDUXJ9L+uT6Opr9Ujdr9
 aQDURcaqMnNgrlTAYmhs0kOndPphbUv11aFyBKNPYo8kfuMnoSZP1/cncoZLboZUCemC
 W4UlkZ9L38nlmDmuO+iO3vGJtm6Jl5zwiZ9bbzhVxTcSsTNw8Gzrrlm2ik921nqCgWLq
 LJhOpV33758YkHuZise0sOIOu1sw/7GF1ZI0b63zqhxWnt3sYsbHzWl/e41cXFZ+dSeC
 j6Qt+rSVERmxf9p+77bqvzdgQEUbKQPfpfyJMTIWJEf5waE96a9FOskcu2qlQnmRZynj
 +l1A==
X-Gm-Message-State: AO0yUKWy+UITppFqKJ7SdAuNIkS8Qdjj+n4OXuJaCLGcrrfkYmyPE/kT
 w6/B6edC132LGVdBWipii4T3wmaujshc7fpX2oO8/Q6+l+egpEIIHncB7hIvazgLLBY3MuSr4N4
 sIaxxl9V44vI00eNRRkGwZrfdzNS6GUTgg20CFBKmwlLtMJbTkS/hX4IICy/RrPZFx7l7zHwACm
 WaR55Hsbeklw/gL+j64CGua4g=
X-Received: by 2002:ac8:5850:0:b0:3bf:d6ad:5236 with SMTP id
 h16-20020ac85850000000b003bfd6ad5236mr15655327qth.32.1677756879213; 
 Thu, 02 Mar 2023 03:34:39 -0800 (PST)
X-Google-Smtp-Source: AK7set9TavRztcG0ZSYQlhYEtTPhNvB2VmTMeHABCwp3UyKfmeGcD6URaSgRaErRo454+a/9s5fAlA==
X-Received: by 2002:ac8:5850:0:b0:3bf:d6ad:5236 with SMTP id
 h16-20020ac85850000000b003bfd6ad5236mr15655295qth.32.1677756878884; 
 Thu, 02 Mar 2023 03:34:38 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 o12-20020ac8698c000000b003ba19e53e43sm10084156qtq.25.2023.03.02.03.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:34:38 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/8] vringh: replace kmap_atomic() with kmap_local_page()
Date: Thu,  2 Mar 2023 12:34:16 +0100
Message-Id: <20230302113421.174582-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302113421.174582-1-sgarzare@redhat.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

kmap_atomic() is deprecated in favor of kmap_local_page().

With kmap_local_page() the mappings are per thread, CPU local, can take
page-faults, and can be called from any context (including interrupts).
Furthermore, the tasks can be preempted and, when they are scheduled to
run again, the kernel virtual addresses are restored and still valid.

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels,
otherwise it only disables migration).

The code within the mappings/un-mappings in getu16_iotlb() and
putu16_iotlb() don't depend on the above-mentioned side effects of
kmap_atomic(), so that mere replacements of the old API with the new one
is all that is required (i.e., there is no need to explicitly add calls
to pagefault_disable() and/or preempt_disable()).

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v2:
    - added this patch since checkpatch.pl complained about deprecation
      of kmap_atomic() touched by next patch

 drivers/vhost/vringh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index a1e27da54481..0ba3ef809e48 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1220,10 +1220,10 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(iov.bv_page);
+	kaddr = kmap_local_page(iov.bv_page);
 	from = kaddr + iov.bv_offset;
 	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	return 0;
 }
@@ -1241,10 +1241,10 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(iov.bv_page);
+	kaddr = kmap_local_page(iov.bv_page);
 	to = kaddr + iov.bv_offset;
 	WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	return 0;
 }
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
