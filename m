Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C07AC433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7462065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZrxsoNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7462065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33D3E86E82;
	Wed,  5 Aug 2020 13:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIECmVAh1kzh; Wed,  5 Aug 2020 13:43:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 811FA86C18;
	Wed,  5 Aug 2020 13:43:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BCCBC0051;
	Wed,  5 Aug 2020 13:43:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D61D0C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C4C4F86E82
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id evNs0OxDD9zp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E963086E5A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X64Xsc1z0L/QmYHsVcy3UgDLuv0e4itd0R0ewdQxVFs=;
 b=LZrxsoNIxudXn0XjtCcSRtVE9vJ7Qw0vohDwHChluAO9wYBweE8o+Om+WUc4Td/ilhfCxW
 50q4VwMYtlMgk+PuXlC8od7774nFkGDKU6Qyf5cGCbe9KH1tikDHm/i+pYmotGBAlNFTJ5
 8NMC36TDBEZg5blhUar2uj+9g6+cZkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-Cefib_TUMLaY-BEt4_fGew-1; Wed, 05 Aug 2020 09:43:41 -0400
X-MC-Unique: Cefib_TUMLaY-BEt4_fGew-1
Received: by mail-wr1-f70.google.com with SMTP id f7so13582376wrs.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X64Xsc1z0L/QmYHsVcy3UgDLuv0e4itd0R0ewdQxVFs=;
 b=cAD/wjoN//TAWlACQylCU0WogJbFwpajyvMOKJiQPEAnorCkK+idvOwsntgDQhsD3W
 G2ZMqQrHbxVFq/YwAkxVRLHLdVwYCWK5RIuVNZJlMvFDrovgWMpgc66iXobuZYuO2m/G
 K2kopGow+N9VRHOkR8tSB1hOjLphcSaXI7psF7s4NCMrvgn75NbNAm++YbeGnH56Re6C
 EdG/D33Z2qL+btvfk4nziumtopVfu3rEtJeuoWS+5iA6wJV3kn5bTCQ5TGTH98OUda9w
 TEAQms69wVxrUoE41Yggmj3kLt4x/BrDoK86RjrccuySht+geUwxGxQ4Y7Ywd/L4HStN
 HI3Q==
X-Gm-Message-State: AOAM533E6skFYAjph4epIfxEFsiIKOErw4D5DkFHV1j5FZsyvcWxArhZ
 z6juFI/GuFgGaRkaLBM0zFOxXnA6gHjyMSu1xc4bBnxnsyzXBO+6mJ5yQrhGM1+vR786cqUBQIx
 cbiqI6AEwrWpZ2UDFBL830Xm3eFPZZ54P3fCykf5Pzg==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr3524220wmc.182.1596635019135; 
 Wed, 05 Aug 2020 06:43:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7HPK5kJbXhcBrmG1OonTHBBSwSvqaL+QYwUQafnUdvO/7RhWcIcON1LYaynur3bpXqN2OHA==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr3524205wmc.182.1596635018970; 
 Wed, 05 Aug 2020 06:43:38 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 x204sm13094657wmg.2.2020.08.05.06.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:38 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/38] virtio_crypto: correct tags for config space fields
Message-ID: <20200805134226.1106164-9-mst@redhat.com>
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
Cc: linux-crypto@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
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

Since crypto is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_crypto.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index 50cdc8aebfcf..a03932f10565 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -414,33 +414,33 @@ struct virtio_crypto_op_data_req {
 
 struct virtio_crypto_config {
 	/* See VIRTIO_CRYPTO_OP_* above */
-	__u32  status;
+	__le32  status;
 
 	/*
 	 * Maximum number of data queue
 	 */
-	__u32  max_dataqueues;
+	__le32  max_dataqueues;
 
 	/*
 	 * Specifies the services mask which the device support,
 	 * see VIRTIO_CRYPTO_SERVICE_* above
 	 */
-	__u32 crypto_services;
+	__le32 crypto_services;
 
 	/* Detailed algorithms mask */
-	__u32 cipher_algo_l;
-	__u32 cipher_algo_h;
-	__u32 hash_algo;
-	__u32 mac_algo_l;
-	__u32 mac_algo_h;
-	__u32 aead_algo;
+	__le32 cipher_algo_l;
+	__le32 cipher_algo_h;
+	__le32 hash_algo;
+	__le32 mac_algo_l;
+	__le32 mac_algo_h;
+	__le32 aead_algo;
 	/* Maximum length of cipher key */
-	__u32 max_cipher_key_len;
+	__le32 max_cipher_key_len;
 	/* Maximum length of authenticated key */
-	__u32 max_auth_key_len;
-	__u32 reserve;
+	__le32 max_auth_key_len;
+	__le32 reserve;
 	/* Maximum size of each crypto request's content */
-	__u64 max_size;
+	__le64 max_size;
 };
 
 struct virtio_crypto_inhdr {
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
