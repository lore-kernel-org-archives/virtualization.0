Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607EAC761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 13:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBA41817AD;
	Tue,  4 Apr 2023 13:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBA41817AD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J0nGUGS7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7YjkfTebecp; Tue,  4 Apr 2023 13:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 813A18174F;
	Tue,  4 Apr 2023 13:14:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 813A18174F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A072C0036;
	Tue,  4 Apr 2023 13:14:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 641B0C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4072D81766
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4072D81766
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zr3p6ySTfkPN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BF718174F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BF718174F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680614044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Joco4lLfDzF0rb3l626/1qV/yRiN74V9xc1/q5OsmGA=;
 b=J0nGUGS75cgM9BFw2ADSbmUvV/faYyLbm5Sdf9YczvlsNO7MFnn9igMschQIRH6KxW6+fX
 IH4D+eQLpvwgGnnR3QaSN5JxmemTrzagq8Z6xHcBnPSrGDQRceizRk8MAteqYhMTEyDI0h
 NjzfU5KzZSpiKWCo6bBxfptEDMuV2PI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-OUmTfHZTPOe8kXpgLKzikA-1; Tue, 04 Apr 2023 09:14:02 -0400
X-MC-Unique: OUmTfHZTPOe8kXpgLKzikA-1
Received: by mail-qk1-f200.google.com with SMTP id
 n129-20020a374087000000b0074a2ff16363so3443530qka.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 06:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680614041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Joco4lLfDzF0rb3l626/1qV/yRiN74V9xc1/q5OsmGA=;
 b=1jR2bwYxmM2805bremszmriPYvsHp5WJw7o8dq4BwUHFvTyjACngRSK8WR8fDlUjBO
 /leSNmifWrD4RIvCsGSvszOqzx9bN2YzfGSXy3xlxSKrOhc+DL0r9K5UwJ9NECMwGSXA
 IQ+VgD0NOzQfaXQI4Ov3adZyzr2+/8o+fwWt3WGJShKvIzRxaicF+gK73dM737827aSv
 iu8MPMdtZBtIjxRso89/PCNKh12AkyPcMeqNiyKhTXt/wsn2xbmyWAq6KmTJZjGhXlPG
 0CJ+mY57ew+9HbGufT7eJ8zkMn5GJ4pubBUGyaHwQCz7A9dk3YccHxYFAoTIS+KpInXQ
 Z/1w==
X-Gm-Message-State: AAQBX9fbipha+B6XYsxy26MHT+hRbdsftLLYCtTZ4QTCZklwwI963xQl
 aqyu0lznwWqq79vMvGPbwtu1lt0u6Re6N5u1sE+h+NmTxxg09zEaQeLkvbqhX1Yg5vfsnhuc9lD
 MiX/fOW/KqV20Xmzn2TuVxViPp9wlVQKClL+eStkrVzmXsWayoznc0QMZObwBAodUUgudUUS/PY
 SvKhH8MHCZZ+3CJUoEDz+lLGojPA==
X-Received: by 2002:ac8:5c49:0:b0:3e4:ce24:99b3 with SMTP id
 j9-20020ac85c49000000b003e4ce2499b3mr3287156qtj.15.1680614041303; 
 Tue, 04 Apr 2023 06:14:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350brY/Pkl/M1hP9EeGxvOvXLmaF54NVKkQ6nW90huVm/ErW3Sapthn6YeLniPqPbLx51QU8jeQ==
X-Received: by 2002:ac8:5c49:0:b0:3e4:ce24:99b3 with SMTP id
 j9-20020ac85c49000000b003e4ce2499b3mr3287110qtj.15.1680614040964; 
 Tue, 04 Apr 2023 06:14:00 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 z5-20020ac87105000000b003e64303bd2dsm2841837qto.63.2023.04.04.06.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 06:14:00 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v5 3/9] vringh: replace kmap_atomic() with kmap_local_page()
Date: Tue,  4 Apr 2023 15:13:20 +0200
Message-Id: <20230404131326.44403-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404131326.44403-1-sgarzare@redhat.com>
References: <20230404131326.44403-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
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

kmap_atomic() is deprecated in favor of kmap_local_page() since commit
f3ba3c710ac5 ("mm/highmem: Provide kmap_local*").

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

This commit reuses a "boiler plate" commit message from Fabio, who has
already did this change in several places.

Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v3:
    - credited Fabio for the commit message
    - added reference to the commit that deprecated kmap_atomic() [Jason]
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
