Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2388177992
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168488; cv=none; b=hIKfIt4Dhmjpq1o2rpqwRYJiQ+Qqh0Zn0+bU/Ix8OlOEwzziLQss0n9llfQ3bUx6t6UMtLU8Q25N1IeobDYKfLhO/fRX70Qpyr0wS5dUBcm7SNCB+37Fm01jj1BKYgkVmr34AqcuWAwV+V3rX+hXbx40fsSnkSeImooOYE6GSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168488; c=relaxed/simple;
	bh=ewPtrkqvk7tD3P+mpp0by+kAXiz3ZKe4MhDOXA8p8qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=UVn4YFLXyn5nkP8firMlPkE6huRaLmz7als7FJ+8EiSDqhuNPBBX15WTqraDg6Ue3Od22noF2w2TurobzoP1P5tv++a6joPxlUFqbFCdf/CQkn6G0xOyRSo7CzQUEGAFgf/maf3LMdP8f9TtI8bOUf90bDmHL92Dk2XJEvq/3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=n5nbcUqE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="n5nbcUqE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CEF160A41
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZP7KEPT7kr5 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Sep 2024 09:01:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E11060A40
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E11060A40
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=n5nbcUqE
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E11060A40
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 09:01:25 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso8719729a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Sep 2024 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168483; x=1727773283; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqdM7AXxfnozdS0h/go68YV5to8QygcNOYorhOUDEHE=;
        b=n5nbcUqE+1gGLyQaPJJ76dZZm38eWIfa5YfLietzJ32q/5BHNuGjHEeX4vu5hHARfh
         T1Le+6Rrtr7eSz2NopenZPKnlcR2+k9HhdowSqEKinHeZah2ms1uI590bdmrPCKI7MwG
         jxV/cOjM+uQqthrDT4m92JazpfJiqC9bcObzLG6MjM5MukjtkW5nxVKBlUI0vsoQ9+8l
         jWnsbMHNLLW+woNL/paZTa8sbK1S5jVJF7hgJMVVH0vojHDvuRZIIHj1SOZygIgqFuNH
         v3bhaPfqAv3G9ePGJO3K1GuKSFyjjNzaKNkrnRErk+c8RaT4DmOl39DRTKY5z89oGfI8
         V2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168483; x=1727773283;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqdM7AXxfnozdS0h/go68YV5to8QygcNOYorhOUDEHE=;
        b=l73rvzDEJImu1vPDpKRQZYZm73hgNpHZPLhHTWydQ93hf5sO2dxct37lNxQZ6nTFxz
         5QWVRnNUJGNVcbaaBNjMWCsAXd0KR81kuvbV9FoBEymrb2dpYq5JZ4U+4+8BBOITVBXY
         BP/sNEF2+gkOIvnGTR3E6IJIMHGPMmoQTnwT/orfRuQMh8TMS0HOaj+vAneygvHhfqyP
         QdcjaYU+oq6VMrr8/JLhvH6lqNbAahsXu7PHoeuYo/4EmFTeeSspf9PRnF1a8RfFPMDm
         0Fi5nsLX+6v++2d/THnohzhJ2nyEYfe5QgB+ppl4yb+wUb2HBTLNv12xk6pBwKGh1OWl
         WhHA==
X-Forwarded-Encrypted: i=1; AJvYcCVTzeZjbbdVf52oLbQ3pfhpFLu0FhnMGGQ7DFJ4wiDoePpPLweleIqnD+SpzyBdprCLdbj8U1M1Qv6ZPwDoNw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxqhLrWpz+MMRXQsfmfxTecnOHOKNg8Lod3z62BFgKPbVis5Mrh
	1O+zhsEZj2E8oJ80zxm5Namvh25zkiewxa9eP2SYHcnabyxTRpqqunPOEGhc17k=
X-Google-Smtp-Source: AGHT+IFYf5KaP4Pzb9vgh1qbbep/BjQkKcAMhxJhINPSfPa8KAAu/uVDRcfMAnuh0Cd6Ah0QYwKNXQ==
X-Received: by 2002:a05:6402:34c9:b0:5c5:cda5:9328 with SMTP id 4fb4d7f45d1cf-5c5cdfa04e3mr2809831a12.4.1727168483131;
        Tue, 24 Sep 2024 02:01:23 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5c5cf4c52aesm526635a12.59.2024.09.24.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:09 +0200
Subject: [PATCH RFC v4 4/9] tap: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-4-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

tap used to simply advance iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This is especially
problematic when tap starts to allow enabling the hash reporting
feature; even if the feature is enabled, the packet may lack a hash
value and may contain a hole in the virtio header because the packet
arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tap can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so fill the buffer in tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 77574f7a3bd4..ba044302ccc6 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -813,7 +813,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
 		    sizeof(vnet_hdr))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		iov_iter_zero(vnet_hdr_len - sizeof(vnet_hdr), iter);
 	}
 	total = vnet_hdr_len;
 	total += skb->len;

-- 
2.46.0

