Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8629CB5F
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430566; cv=none; b=SxiTOwcqbFKLZvf+BJU9Sv5LbjSrvASLygiSAWIFUMou939HKuNisjVJiHuDhr76ruc4P7b2tm4gAaetTnLmlki73ntZBzkwYkKyCv1YhyyUpp84poxgFWUGBo/yo7tsuKhPXq0kDuSYMUXdUL5JIP2f+LuQaSWW3lN1w/b4zQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430566; c=relaxed/simple;
	bh=nH9AzNvXgldUU/AljR6D3DexM35j63PI4USaZ9u/z9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZYPBGSzizNpDC00zP1k35dwo3xwD+o3+lzv4cfEQDiL3E1b8JPEnwItLiIc7c5p8m4pG93dA9lxhBLc+a8Z2FOlHbygL8oyOv3enWPM+onuSt6KS5CFFv8SdTJ5jEDfgIDkfloc3UncAET8pifFSffVdsBDBgrhkCDBU/j+kuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awKNC6gg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awKNC6gg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2402774851fso52408605ad.1
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430564; x=1755035364; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7WdeYwSOTTiB9deoqbpcAAZGDfkPprbWBWnuaDCaW8=;
        b=awKNC6ggNkCuJeCWrSYic979rqxgrV6c/+69KhXrq63iOoqzsiRe26Mnu8T9t51LEQ
         /KWdgQKxkRzLlo3zphSpomj0drG9MRa9+5K+r1+TQpbD1w5a0uHwvNj4+ECVg4vOMD8w
         RnbffpbJhErPBGZDsSuGi3LthVTWIOcmLbNEdLE1KKIesadQBjRiD9KYVtK2fHkqHDRN
         ufFYBUVMt7A+2q5YI7Xp9qOcUagghFGmGThxq5kL8IjnyO0mSj+95kqPoBDE/ZWEEbo6
         +07aogKEF0Tyda6eG1IxLvByYqQ+C93L9Qu2RfHmRK7kpmDQJ6K1HvlmZnRPvcpCtCXr
         dqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430564; x=1755035364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7WdeYwSOTTiB9deoqbpcAAZGDfkPprbWBWnuaDCaW8=;
        b=WAo1ZVnAmgzl0VszpHNXEEKllJ7e/ideO1twKUiJSK9VqUm3oNCrHW8g+wVkKSNw9o
         0YUoml7/sTns/sNojHLO8Lv0PEJoayu4lmn9pQoND2msNodk+wVsHDB6JGO9QNC4Fppr
         LN5rz2z29GffqBKzBXmBAQDNwIOd6rogF4Yiwhp1v9iGMlSIvVJxSLroOAgmLfTH3Obf
         GWYhH595hs/PLxciJHhw4HhFBwwrr7xA5MiwHOn+H+C994Bu5Fwa8csiMUEKlfaYKIfF
         kcr2UmBYI1KwxMKux2ocy+ISLSYWPQOC7piwCXO87JJ+iIJwU2PpDzS+stVhsdebQ5MB
         BRbQ==
X-Gm-Message-State: AOJu0YwOrp1cmyj6Q85zgluQD2749HDdV6C3HRv2QFwJ/sQheemngiHW
	BCw4VdiSRpV/BkIZe1GtZGNltiOqTW1waQ4gLrhgLRu5WADnMa0riET8
X-Gm-Gg: ASbGncvGC0YCX/tYT/snolLUpo01ZkGtvceOyj5m78M9qv3OuSIWvvYOVVm15pNK/zS
	k7ESGrOCXAKO0P/kl7qmesiR0gZQdHFb1HGhLYerkYfQhf+YeGxjn1FF/mgL0W8pdf5MLinLbnP
	NfhgXnHdO+tj3LNP6l1UdilqoHyefTtSK+HxzU0FL2kXo0DmIZYDATYqbVwAVCGQppZ9jiD/+pi
	pEM/OurgOHGkvXpSafzbuZH5xp6N9GOJKAFoCo8JRbgXXNfY3r2h1rPU2pnkABwjLptq+H9ngHN
	kSjSjVvvjc7p/zCS7S0UykSq3qnxVSqB92yMl3AAdhg+JVVxyX/X1bfIKxBygXR6XWbwbekTcHH
	voQGgL6NtpPh3o6RgICcU3OczBI4odw==
X-Google-Smtp-Source: AGHT+IGx4vPl2oXpK9VlREXkqAjZ5FwbF92y0gDsYjmBbN35wDgdgTqIRJq/vOJfOY7uEhYx/Sid4g==
X-Received: by 2002:a17:903:46cf:b0:240:48f4:40d5 with SMTP id d9443c01a7336-2429f5340a5mr8876385ad.39.1754430563927;
        Tue, 05 Aug 2025 14:49:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm140671005ad.60.2025.08.05.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:15 -0700
Subject: [PATCH RFC net-next v4 07/12] hv_sock: add netns hooks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-7-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Make NS changes not break hyperv. Guest vsocks still remain in the
global namespace always, so the behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..8862297b09a7 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		return;
 
 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
-	sk = vsock_find_bound_socket(&addr);
+	sk = vsock_find_bound_socket(&addr, vsock_global_net());
 	if (!sk)
 		return;
 

-- 
2.47.3

