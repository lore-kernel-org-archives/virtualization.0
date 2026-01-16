Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E503081D6
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598952; cv=none; b=tw3ELa4tRhp4sx2rlfdseCuaVDBwuAvGywfmdfb/7MTLtgUo2ibI9mFpMpyCCywVfyelxL7aN792QjPd7+bXirfppqmaBCFf6NVnGwzjv7zajasdTQ11YTIZhObUA0N2A9ZFsU164mAvGPl0ECBIrNm4pLrAXnzerVahnVToXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598952; c=relaxed/simple;
	bh=QFGTndIZnCvd5tocHyARHg0OdzlZifxdeujSy28wwJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpAAOszMIfT6KmbC1rSOuJQtWWGYpt0MPh91zxJXbWQ4TdUSkEhMYWMIlFXhIAcW4BRC2Mpgev/hEdFubkl3GeLP/Pg+3zIqKOsuKJRi7GB+Q957gRnRr2FOxkFgfzecHIoAJdBWXst4xf5tn5B+4LrhYocIYTf4CuthvhwSY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYRKKDYv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYRKKDYv"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78f99901ed5so23484827b3.3
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598946; x=1769203746; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=TYRKKDYvgHEcLwkpvZLTADvsMhYKi9ccveLpMks42aIs4AivYoXsnzZtoQoDjaz7em
         6ccOobOURxBF/OpJVnugKg77HYR9eWQaWVwJiCrGcb+p/kNUC4kvJlGGFqdZzxr1JuIV
         cfRtXqhnQn2XjR+E4y74PHJ/mhpOXxF9N8yHWzd7noC4dNv2YN1BqVRcG1VEWcpHPtiV
         SGpm1LVmxGM/Hzfdap1yB18R30Bx4lk0BGQbQP4kbKMS6hX6d3azzn0qAyQwuJxgsfuW
         mcO42SsYRf6vu2V8krDZjUvdbM+ISf9Yvc3qe0qUgyb/h8L/3Tga0ZtWo2h1bBtB6UbI
         WTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598946; x=1769203746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=kDUd4PVW2cD/AgoWooApIeNLSgU0tj0bhCGX7ClOkgB4mMfv2XUdHFoVN+TDYKye7s
         7knLS6jc8sORvOVynbnjO4cObTDPGRVycRFf7s3o2uXceGz2KuxYM6pYe56b9T3lrsnM
         aePtkN8oZASurbzYm8rcJlAh4jwCXdqm7UNUPUxJO4VytH6n39WnS/K2zyVJ328lA9bf
         w8/lN+ctWJK+fcgDOr2qfVtnoe7OB02Hc7a+xufOr0mxrfxjhgIkRpHm0LNZU3OQxM8O
         5TOXybk2WnTqlmk7CLwg4Q3nImgiI3qXTchPeJkxncNMzSUqgthaMNOj5an2HrSIY7/1
         RCig==
X-Forwarded-Encrypted: i=1; AJvYcCWW97oRgYyh2uD7GqR0UXIQx3wDYAXHCkDGr0/KN5/tn/fHYXmxq5cyNi/NJn6ZiOfCN0INxyBZi9vtx3wH9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YylRh+CVjFJHiZ6E90PSX58RljkE9Yr3X+FAgTBhTkPQpRbUYVJ
	6R8xgNED/CcYR4nNHzmOtnQT185Q2YikeRFkZXeWl32T+DNI3p2Rw/PC
X-Gm-Gg: AY/fxX64d/YAs50z6emhc+6wUbohmIcYbKFE0BXTudbH3JKuI/8M7KPgi7xVMyIZ8co
	P/tnS/osvQ5BrLTk5rCFcDgFbCTikePsJaBCzwe2R0EwiU7hKgHZjl43KeiNxNNoLPbYH18MRum
	kfKhlGYB86Y+/E65hTYmkJPwg72fYWH1kJAwZfAdvd0Nw2mCGTIYAsYXjtzSgYttkcjIFHajz6g
	/XhrVI/FXRbarUVsHQcoULmBUNBNvAef6vQwsajata90KSSvkvOGGH3zpkwxC2/7Ff+N1NmlE8v
	pKITOyxbsTbfBmQB5lx0Qg5IdO1Q5YIvxQ2524zjET3iEgXfcBfB/o96wKum2THyjbiekpk/2SA
	nAW4qrEuNx2eZOimB1oCSIc/hrV1XCVDse64M5zlw7Y1vCn6NE/3haJ3NZ8ENirjmbz8rm5lefw
	zoHcjB/Vva
X-Received: by 2002:a05:690c:e3ea:b0:793:ad61:b5d3 with SMTP id 00721157ae682-793c52e44e4mr31233967b3.31.1768598946238;
        Fri, 16 Jan 2026 13:29:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6882ea7sm13097717b3.44.2026.01.16.13.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:05 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:44 -0800
Subject: [PATCH net-next v15 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-4-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
index 694d70710ff0..79b65bdf05db 100644
--- a/tools/testing/selftests/vsock/settings
+++ b/tools/testing/selftests/vsock/settings
@@ -1 +1 @@
-timeout=300
+timeout=1200

-- 
2.47.3

