Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D98343200
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873998; cv=none; b=PnKxyYxP8achpR/qQRQopPPtQhaIEZVaeMhuuC64Lg3IqOk77buylzXbjipVEJFZJnwR4rGPgf4wVExzoAnIoM5PKWdO3Mz7o/sg0whVIXNCorFMXPoVg6+b/TIiXd7tOod4/YJ7DuHsjAB0oeob8c6PGow2pDejC19MxHW851Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873998; c=relaxed/simple;
	bh=IEtXuDI05kjah7HjVuRtixkvphhBYOmv8vR/RvO5sXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ndlexca162KpQfjyoZTIet8RhaIVK1dH3abpghF9NYJcjTPc/wc6ngKsXgSLl/xqF9L/bJWQwbdq5kDp2hcSGHPWC2/LS1eyRrSN82BYqMBzPMDBisOZVaP4HKrqdyZT1mw5ORZwUBW/i6dA87Dd9SXN1CpcFJoLoEzNol5cgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpZoaJKF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpZoaJKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDIzAT7spvOSoiJwYYzX0+cw80wGi4yD1jO1sJyzphs=;
	b=DpZoaJKFcNDvC5QOXJ40DY6S8wKmlbCvdGBhEoUbTTthcXoCY5Jmj2U9diRvk+j8wzxjXg
	AQ3oljqJOJDk9ltEcjd6HYV2ItkGs7p/3RX00/eHNBBsLSLsaAj/Y8J36iBBqNOJUpcRlc
	uUGiIIWbOQMhQr6mwELte47G6u4OWU8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-iaN3Q5eVP3GdKbxEBjLulQ-1; Thu, 04 Dec 2025 13:46:33 -0500
X-MC-Unique: iaN3Q5eVP3GdKbxEBjLulQ-1
X-Mimecast-MFC-AGG-ID: iaN3Q5eVP3GdKbxEBjLulQ_1764873993
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47788165c97so7958995e9.0
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873992; x=1765478792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDIzAT7spvOSoiJwYYzX0+cw80wGi4yD1jO1sJyzphs=;
        b=I9cTlXakJ75hRc1YGzmmIl3NzPI5utL6cQWNbHZ2PN28CBnW9qy4IprR64BC3LuIue
         d+2CHl9vmVsy0G17r6FNe7KE61t8h2lO0fk5kl60DNRM984D4Ndcpt3Hkv3XGQBCt4Ng
         hd6xiW/ohV9t11g2Ormp1FbgyCzCDKAQ/57sepFyDStW4jy8w4NIiIzaVa7UCNEWT75+
         U8FNdOAjYgEFknVKVHriZqxyjxt79n+6KKUkKZjf9l8Qb4MJGLLM+Ge9yV4Qf6JVjIPv
         9gcZolkFONpX+Frm5wZCtCoAAy7EX6JPOWhoU1RYgxUfVafxT0F8/QqhtMLVokH5xqp+
         BJPw==
X-Forwarded-Encrypted: i=1; AJvYcCXXM2+8OWtzOm+HDiSnQ00xlu/l3uSEnVgYTOVAsTZkYb/cCd7uZiEVrwyqnpRrvarHQ3c/eP8uxjR7j61eRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFvBzpHwIrY2tAWa2aLyWDZGCwiEcJo+/GR7wQk+4UO6OQ+BUX
	+J4K3nFKMKpNcb1LLvGVvkGnQUwbdYoBLgsXI6CFNiOkAXKd6f1RoadvrNOYhL0KlNqZ+k2kUj2
	VSspiqc7tAjPNK/3Hhk6v3GtROi+hw3bbHX/1z/FjxqpQkJEplABTY1fLE28yGwhHwpcJ8k7WV/
	Oc
X-Gm-Gg: ASbGncsSAQ4yvbKcQc9GiFrlcN9YtGmauisL55i2FPWBB/Apy6SkfWTjxEuMA0qr703
	EQlDwnaHcXp9XeWxA0m0Z7ZLJt/Y4x7CclWhsEqpZqhBta+hmKyicREWygZ2JmhPfb+B3GGx6So
	pA5vsR11kRdVofktINpv5ujMYY6+d9jCojXsti4btA+evNtnXb7HBnV1F08RWLnG9S6fC/bzjP/
	m8v7aA892BIqZFMmva7/UyOUcxi+6ajmX2MCOIul4ABE2hqggEEMNT/CNRpIQWjynAfaVKkBvb0
	nQiBYBawNLV6rHav7xUj6wRqkV+PZmBQLMfVQegX3atLc84znKpkxbeZ3vF2eMK5ydWt7WkYU4Q
	=
X-Received: by 2002:a05:600c:1f1a:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-4792aee7ce4mr76219735e9.3.1764873992479;
        Thu, 04 Dec 2025 10:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYKBDBMfx75UryIOe9fLQONFJGHzJqiMzQj9hyszKvigX32PExgNGBunsWaL5UZGnky8UGLg==
X-Received: by 2002:a05:600c:1f1a:b0:477:7b16:5fa6 with SMTP id 5b1f17b1804b1-4792aee7ce4mr76219375e9.3.1764873991968;
        Thu, 04 Dec 2025 10:46:31 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02ba67sm53351585e9.2.2025.12.04.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:31 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 13/14] tools/virtio: fix up oot build
Message-ID: <33968faa7994b86d1f78057358a50b8f460c7a23.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VuJyVCY_8xcAajgmJh8eC2w9WiKPEOgj1M0i3z7ygxw_1764873993
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

oot build tends to help uncover bugs so it's worth keeping around,
as long as it's low effort.
add stubs for a couple of macros virtio gained recently,
and disable vdpa in the test build.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile    |  5 +++--
 tools/virtio/oot-stubs.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/oot-stubs.h

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index a60316211df6..2cac5fd4b979 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -38,8 +38,9 @@ OOT_CONFIGS=\
 	CONFIG_VHOST_NET=n \
 	CONFIG_VHOST_SCSI=n \
 	CONFIG_VHOST_VSOCK=n \
-	CONFIG_VHOST_RING=n
-OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
+	CONFIG_VHOST_RING=n \
+	CONFIG_VHOST_VDPA=n
+OOT_BUILD=KCFLAGS="-include "`pwd`"/oot-stubs.h -I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
 oot-build:
 	echo "UNSUPPORTED! Don't use the resulting modules in production!"
 	${OOT_BUILD} M=`pwd`/vhost_test
diff --git a/tools/virtio/oot-stubs.h b/tools/virtio/oot-stubs.h
new file mode 100644
index 000000000000..69e059cd14d6
--- /dev/null
+++ b/tools/virtio/oot-stubs.h
@@ -0,0 +1,10 @@
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/virtio_features.h>
+
+#ifndef VIRTIO_FEATURES_BITS
+#define VIRTIO_FEATURES_BITS 128
+#endif
+#ifndef VIRTIO_U64
+#define VIRTIO_U64(b)           ((b) >> 6)
+#endif
-- 
MST

