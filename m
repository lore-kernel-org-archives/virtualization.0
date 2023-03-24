Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6766C761AF
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B12561630;
	Fri, 24 Mar 2023 15:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B12561630
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CioaTP5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yqo5vrt1Rhex; Fri, 24 Mar 2023 15:36:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F03DF60F42;
	Fri, 24 Mar 2023 15:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F03DF60F42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC02AC0035;
	Fri, 24 Mar 2023 15:36:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 483F3C0035
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F76E615EC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F76E615EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zdpPs5kt-pMj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96A9360ADD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96A9360ADD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Joco4lLfDzF0rb3l626/1qV/yRiN74V9xc1/q5OsmGA=;
 b=CioaTP5m806hVsHe9I7fmZKirgQLITqFqFbq9dkg7J2SQ9KuLBjGfsYw5TRftB9TGsGarG
 9xgWAoMZfBV6fEhKBbQfZNAro5xrp1Fvh6qtBcptPSPqmyjyNZfm4VGeEOs5FDlVyuYapo
 6pzTPlTqSkNzOjBsJG08kGFCX4zmlEo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-GHlWHw14MmaD3R8RwlxD2Q-1; Fri, 24 Mar 2023 11:36:25 -0400
X-MC-Unique: GHlWHw14MmaD3R8RwlxD2Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 i42-20020a0564020f2a00b004fd23c238beso3825542eda.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Joco4lLfDzF0rb3l626/1qV/yRiN74V9xc1/q5OsmGA=;
 b=B4dyW0oKvV1GDiKwdwg8mvDUovbjoIbnHy8cUyyXCRP08XeHkyODf41E/KTvrq3PWp
 XiaPElRhyghiEMQ5KA7iGXBCJQPnHO2CgYzWMoR23/pnSSnXmDxAZTzkq4/2WaNApKiz
 1u04Km+gwdTBNyhGVnGir90iYcWDF5Ip2/h34CUgx0hBz8Z5MtZXJwinVYbFi8ZWpV5N
 zoyYte6Vq44EAjUOitRIXYV9kEVSpnqHiFT3NAT95hlHDdUKXi2o+MTeKUnpDBfilltp
 yVpHLPWKGDmb+nzOoKhnKo2n1cXohqF8eNrKYTdfpNDqaTKCe7veP7IXOAAd4VS4IOhv
 aTgg==
X-Gm-Message-State: AAQBX9dJSWIW3uSIBM+vqg+GkIEkT4VOvZJ5azCr5Ngv9I+rJ/5NuHMx
 T0Qo8j+XRzbQ6RKMPsBV/FfrUgyFSPQCin3ew2dyhQ0hNl+7Xse0sKFrYpacKokTrlrS71g25HU
 Jz+ngD2W7avpcpAIduSb3fjKWXsXcckZDNBgMFTQUYg7Cmgb7w+jpURiUtxEXPoORvFed6tICWf
 vJta1djE8GBgjdjwGosxPJk6Q5Gg==
X-Received: by 2002:aa7:db59:0:b0:4fa:7fd8:8f6a with SMTP id
 n25-20020aa7db59000000b004fa7fd88f6amr2931947edt.38.1679672184053; 
 Fri, 24 Mar 2023 08:36:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZuzjfQyZ2dlfFtpF8zvU6NLDalEKpdkp+pwvD8RtLaXEt6mmjXHL+HJgSa4wiuylnLUN+1hw==
X-Received: by 2002:aa7:db59:0:b0:4fa:7fd8:8f6a with SMTP id
 n25-20020aa7db59000000b004fa7fd88f6amr2931918edt.38.1679672183746; 
 Fri, 24 Mar 2023 08:36:23 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a509b5b000000b00501dd53dbfbsm5468613edj.75.2023.03.24.08.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:36:22 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 3/9] vringh: replace kmap_atomic() with kmap_local_page()
Date: Fri, 24 Mar 2023 16:36:01 +0100
Message-Id: <20230324153607.46836-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
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
