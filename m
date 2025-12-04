Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC733891A
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873986; cv=none; b=LvVcFUE/A6F3i+vDQWgT2RyW0xYopWU5jWjrx8s79S1S/EIXZVyZ5oyrjzd+y401Hq2hFI+4BM4XpZRp+67O452D/qlRaAauEPC6djmZyisRs9xKqicglKULxoCzpU2kI9sttzwJrdap1LlnW1eitaa1xCxFN8nDboX6Jag1/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873986; c=relaxed/simple;
	bh=U9oqYD8QqVco85OjsLcOc0NF89rNr6m4KIRicJtMbD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LnzIEe1C3cG7LRdt0YMGjlQJninQ/dYd21qWxlV/wgy+msdZbJTNyoM2SrUQZ33mrGiYLgiTYkqtvkjFVLwpOWoVfZT1yLyMfrgwROb3Qi5H0iYmiVwRJAt6GfRPdQrgqp6NL05mkd7HN42ldZcvRTg9mgWMpo2TTw1X5JWyqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xob4gbRG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xob4gbRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2yFMUqLe/o9uuKbtlkQxrxzXv2xPssroLSz5ViTCdw=;
	b=Xob4gbRGhvRxiSUBqewNgRC+IXX8Lz8ZWpvgFAydr1d4BAUZGSWdVswiqTMWA2cnGkIQIK
	7wwSwvo3bOHnAbV/z56X7PptlU9jklrrjTMM4Ag8ivdkh0SpqleM9En2JrUmUNUKTYhY1W
	onQYQqmuzDjF3kTbgZSc2yN+WzIWJXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ecITyD6SM5WbnoNdjy5y0g-1; Thu, 04 Dec 2025 13:46:22 -0500
X-MC-Unique: ecITyD6SM5WbnoNdjy5y0g-1
X-Mimecast-MFC-AGG-ID: ecITyD6SM5WbnoNdjy5y0g_1764873982
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b366a76ffso725073f8f.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873981; x=1765478781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2yFMUqLe/o9uuKbtlkQxrxzXv2xPssroLSz5ViTCdw=;
        b=DyC4s1myoVLuGIOfEEClTLDYtWIpv4FF5Cw3/l9MCUqeX9IRmfUk9BGI6XyX/BUslv
         /GJL0ggT3ZcOP0YATP9OyK5ga/OnPWvP0Je3elIoSfcB9x2LdGzxXGmiNwimyHuuxsoj
         wTbvR84rg9nWjyFz/Zv1SHSjHtA4F2O4BnCaWQ5lCtxJeyVALSpMjAzxyvZA2sjip9kK
         W7GMPDxqZ9haeXWHPSmWavHhXWW6Lqc4I4p4wzJ/tTWqPv2mUm10zxIfaF/fKh4NhfLI
         BtW4b0sdsrbsUHAUhVBQqGgTf1PdGiGzzy+jabQYLVJ7DeCX8fmHUv0sLxVFfyyGG76d
         ZDFg==
X-Forwarded-Encrypted: i=1; AJvYcCWyhJYIyKdSF4vOQPtC08d2YadtXa+ElJNYYJUoeqwg1qmqTRCaznZNt23FGJ+bCDw2TqM3TrY9b0HPFmm1yA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2W/3XL37Ed1sz8Hnq68B62wPPjIlOx3CGPeexnaVNByFPG8Dz
	N3XW6rUXROoYNxYGm36q+peflXAwa+lNgUxeSzTsfjWF90OwKfSsl9+MZpWI/t+WIK7mkQTaJRO
	B3gAADMIb9IWodfB4C3TXV1w5qNvpReit+JaQmRnVNTqWCyAgeHpNeGh94r14xkfmxk8r
X-Gm-Gg: ASbGncsH/rSnURU9e4QChkrLn04J5SGFnTWM2tHbg5HWmfpkHGo4wZj//x1p3+nS179
	s8YsGoNQoUEISFlq3pArH1SubhL4qsnDXHrJ/g8hmMC0AoQr2x+sut73ersuIr/WM8bnFPFcLnx
	mIxOs05d4hHNXEDPz7MNgU4qJxJSzbrsjmJy5w151RDtVz5KU+WzK2TtSr619Z5/sFcpstp6r+b
	fgGOrzMMtKQqE4G5mA7OvpPLVdyhlVSCY2m0pQ8ghl3hKvcu65joUeJ8107NlD57pkhIFI6ZnAS
	AUMfOziphjxmh0h5KaFNhteLxqCIeWa5TScL28rO5jhW0/z++hT3dsnPg8V/i3scsDf1DAEGWUc
	=
X-Received: by 2002:a05:6000:2012:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42f7980aa83mr4984117f8f.17.1764873981350;
        Thu, 04 Dec 2025 10:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYLE9RbIhX+QOqFFMM8YJLzJ6Vysf1B8Q7WGfGgIDXBzfqWVvKngTTfkahfjQiIE3GKb9mQA==
X-Received: by 2002:a05:6000:2012:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42f7980aa83mr4984091f8f.17.1764873980868;
        Thu, 04 Dec 2025 10:46:20 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee5bsm4560903f8f.16.2025.12.04.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:20 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 08/14] tools/virtio: pass KCFLAGS to module build
Message-ID: <5473e5a5dfd2fcd261a778f2017cac669c031f23.1764873799.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WxDZhrtIfDgHWJh_7h3AgOKFzyPogweYEVAyWGRsrhc_1764873982
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Update the mod target to pass KCFLAGS with the in-tree vhost driver
include path. This way vhost_test can find vhost headers.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index e25e99c1c3b7..a60316211df6 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -20,8 +20,9 @@ CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../
 CFLAGS += -pthread
 LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
+BUILD=KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C `pwd`/../.. V=${V}
 mod:
-	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
+	${BUILD} M=`pwd`/vhost_test
 
 #oot: build vhost as an out of tree module for a distro kernel
 #no effort is taken to make it actually build or work, but tends to mostly work
-- 
MST

