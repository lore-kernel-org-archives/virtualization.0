Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038737BE92
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886338; cv=none; b=ZB0Ty/Zgtj2N5mhm8n1qDe8XqN5TMX+2umSUbupm1cJS47UEqOUeM3mpI6DIYzkvXcQyZ+CeMXhjq2ik1Kk5IYDKG45Te1UKiVNtQ42eucueE2ITDP69UbwON723T9YZDbtlxMvK7gtZFJKSWF6tNj9WPKq2dMaTchGCUADvg5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886338; c=relaxed/simple;
	bh=ZIS40BN/lVEtVVMEAyUeO8Q0LmXvqKfPsebwIKGBEeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNVBkGosvsZTrX/oLyAhToA369CgH5HBwH0XNXkEMJNJBx7n06AtJbW3qv3iKuLm4FzaDbcGxRgU/5NngLeAIy7rSLAzAFYu7j6/5R/4FzCNcj8qJ+2g/wVSsZBVdMNqQ7/EyfK0xfua6V9NGkZtG+Y7ZGxI/TnapWWVL7iMm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDzx3dHZ; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDzx3dHZ"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7980ca83937so38367417b3.1
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886336; x=1772491136; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cemh6Unm8avZ318Zd18G/NSlRGlTIfX9gcE2w2y6Xk=;
        b=KDzx3dHZ5vqJ4dUl81CIrbbedC4TVZ89dcDu0+O5G+PaYllzs61mX7Ak3prDfaBhjI
         areSTbfJvxYdg/zIyESlfUeRxCp6fZ4MpHvzh4NtbAV5dxJbTPBE3viD68puJudYYpUg
         lKCfyW3d+L634BzYLIVDvoBlIMlRVCaT0Efqgkts/yE+Jwi3CfhZsD5OVgyX6OglqSdT
         BbWsTK04ntXZuINOuhfL5pqIEdlHKUe6aCC2qJa7ycYpSa4bfdnS3B6rzQ7+LzbkGRFU
         T8TG65lM8vjWnmCnWiTnD61ueU85ZUaDpEAyPCjR64lNCKtNfI1ywifoN1J3CB/qVs0j
         s3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886336; x=1772491136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0cemh6Unm8avZ318Zd18G/NSlRGlTIfX9gcE2w2y6Xk=;
        b=AUw/IF6WS4eyOD0c8EFYtpUh/jdRunHQ9DH37btqYlKCtoVluarWTbrymsc73iqMxu
         kKpfdoGWSPBoaC8SzUXvhFtUjKyYT7NRN1s4/ZEB05jCWjB6DSXVqFiCqSDVk8w2sKsx
         k9O17ku23ZmBSjGAJV2TuQTVgiBxIiXDQkkDx6Lk2A7bPPja9k29hP9mnw+v0PLU3x1C
         GP9xCV/rZNi4UrAyNP4MJ1wdeWz0J84RlUifx7FeQkM8nQkUXBS2E4Gwt+nRU5CgYG0F
         d7LoreihI9TIo6sRqRsAQ79s2XF0ZPRsQv/FMSUj+XBdjqQ0UDeberMuiEC0O0LZ9Gyn
         6HpA==
X-Gm-Message-State: AOJu0Yyu7QDD0QFYzhmYGjFhj6Ul7K71Ajgjn24ToinBnj3DrRqzezXW
	8s6FLYENrPtmDPRF2Yi3xBf/QFsMR6FSuZxa3qreGxjMAAs5UBm9zXsX
X-Gm-Gg: ATEYQzyxliI3Yr5ONE7b2gWZmeht9QslezUOgO4wsHCXr4HMPoAQfG+RllGp+BMIzHN
	kUgL6PSiulhG/s45zLDghg02G5yZRTklTOuJ2rhumgsmQ3KXOI/+1atzEVGQrZszjn9uYGcYyOW
	B+7GnMTqWlUBBgAiqYS0TBDr/9xodvLtc38CtVDuP4610MHxn3k2VezjkmCkZmTHywjQr6/g6s2
	ZfB2B7eo/xr1pw74nWMijbsC/MeMyZ028XioiBClIwRKU4vLlnDdF3SZKz1V71M+3LumVpcWTZi
	DKmCPwZJ224C0CFanitaE36Vy5xzVGUyj9eaMISZUVTVxeY4k6Z+lmC53RPiQdnjdtLxGrlaTJQ
	WWAFL8l5I4eHO5vHQIvNU4ACH3bjhgGjRhuQ2WJIZm2bUslM2aPjd3uUyYz+P8EjAHdaQMSi9Mw
	qStihVqqNaYalmE0gpmSwDCw==
X-Received: by 2002:a05:690c:d89:b0:796:34f7:8ea2 with SMTP id 00721157ae682-79828fd308cmr92461117b3.31.1771886335647;
        Mon, 23 Feb 2026 14:38:55 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd87fa2sm37132007b3.28.2026.02.23.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 23 Feb 2026 14:38:34 -0800
Subject: [PATCH net v3 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-vsock-ns-write-once-v3-3-c0cde6959923@meta.com>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
In-Reply-To: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 kuniyu@google.com, ncardwell@google.com
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update the vsock child_ns_mode documentation to include the new
write-once semantics of setting child_ns_mode. The semantics are
implemented in a preceding patch in this series.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- update language to clarify language that first value is locked, but subsequent
  writes succeed.
---
 Documentation/admin-guide/sysctl/net.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index c10530624f1e..3b2ad61995d4 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -594,6 +594,9 @@ Values:
 	  their sockets will only be able to connect within their own
 	  namespace.
 
+The first write to ``child_ns_mode`` locks its value. Subsequent writes of the
+same value succeed, but writing a different value returns ``-EBUSY``.
+
 Changing ``child_ns_mode`` only affects namespaces created after the change;
 it does not modify the current namespace or any existing children.
 

-- 
2.47.3

