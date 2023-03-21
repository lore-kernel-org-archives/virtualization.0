Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E92CC74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 238B640BF7;
	Tue, 21 Mar 2023 15:42:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 238B640BF7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPycb34Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tpK0cAlVK04Y; Tue, 21 Mar 2023 15:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 96CE240BEF;
	Tue, 21 Mar 2023 15:42:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96CE240BEF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71996C008C;
	Tue, 21 Mar 2023 15:42:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51950C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17A014189B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17A014189B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPycb34Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kl3ihz-uFlxa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16B1541890
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16B1541890
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679413359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/nQNcXvQOfjQfrlKnDNrxxtzxnlaUxAliAI/vatFyI=;
 b=XPycb34ZWqt3/WASZcAndvS/9O+4DuG7WiTwCFLGd9mob9ULQHXK3nHr7FkYJC7fZQzrIa
 cUkhazqa+g2XzmH2vwFL+cvP2AS7X7xRBNnrHo7pf+eAV4G4S7nDo70J4sK+G3X9XxQzLB
 kNf1bpeYyNUlIk5QjBMTXxD0hwnmPOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-BtXgKwzfNDOjMvn-OpiiFA-1; Tue, 21 Mar 2023 11:42:38 -0400
X-MC-Unique: BtXgKwzfNDOjMvn-OpiiFA-1
Received: by mail-wm1-f69.google.com with SMTP id
 o42-20020a05600c512a00b003ed26fa6ebdso6076721wms.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679413357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/nQNcXvQOfjQfrlKnDNrxxtzxnlaUxAliAI/vatFyI=;
 b=RPqIjHguuB5tTGXkpVNojJdphjU5HUEk/LHMMfysf7Y528e5fJ7hVVfaBovXda4KCN
 s6Tww1qza2vLK0RJKTLtlC52M9Rd6VJBEZ+IxcMs2yJFRk1CMn8hSST2GDQTQvHfshU1
 dL/4NLmFLC5GJ7kKMCqvkKKtQIDe21a6O7p7PTZuzoGXUJBLzPkJysB0zWUj5ULpcnQ2
 RUeH0RXAA1GCgGLos0J6/dLlCDvxltpstXFxy8e3Kyu5obbSOLaaB2eaFWBA3k9/teg+
 d5Jm2IuCYv10MHSwJCYQMG+XbsfL3AjN0Ipk6sbZGijNw2v+tm3nKfRGaLu9T/j82ZOF
 Zvaw==
X-Gm-Message-State: AO0yUKXG2RUwCo9GuM6Yv7KtcbXt4eVXD2dZw1/R5zjyk8ETHKdQKgFK
 EJWUbxyjaakls2GtyPHztKkP5XkV2sCH6+2PFTeSTSvWB3Dk23NAZfiC7mnED7AHg4hDRoSWRqW
 qOL9rHgPzX2+XkeqEzWdBTNIJJnQn9PtUb9OfUXE0KiT+QVfSSUOc1mv54WPK+1j0KBOazlolrZ
 237V6BAB6TZh7tmR3v380+1d+s9g==
X-Received: by 2002:a05:6000:10c3:b0:2d2:6a31:b868 with SMTP id
 b3-20020a05600010c300b002d26a31b868mr2602316wrx.27.1679413357354; 
 Tue, 21 Mar 2023 08:42:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set/e7guuybvidSucOQAc9fidioCV858cDkY1wJhAUIbIQvY6mOovHetJt1xqlgoBWZ+wGjbLUQ==
X-Received: by 2002:a05:6000:10c3:b0:2d2:6a31:b868 with SMTP id
 b3-20020a05600010c300b002d26a31b868mr2602288wrx.27.1679413357024; 
 Tue, 21 Mar 2023 08:42:37 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 n2-20020adffe02000000b002cfeffb442bsm11582490wrr.57.2023.03.21.08.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 08:42:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 3/8] vringh: replace kmap_atomic() with kmap_local_page()
Date: Tue, 21 Mar 2023 16:42:23 +0100
Message-Id: <20230321154228.182769-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154228.182769-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
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
