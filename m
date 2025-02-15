Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEA158851
	for <virtualization@lists.linux-foundation.org>; Sat, 15 Feb 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739599510; cv=none; b=FaHrcQvU5o+V0HhZIpsZpjVa2Z881voDX7i/DlKcZ3EF9uDjqyCb9Kiw1ojoaBOk7cvWZ0CfjRJLSLTU9nhkPOVSDG4F/+BgYrpp37/IKIGkbw4mUJ9so6HFh/FCMq3D7UlUv99jZP+kT4OWeKtp8kV4EbXWnCZpwcfJoG+oF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739599510; c=relaxed/simple;
	bh=p2c/thFQqA2f6zTlTTsMJKHXAHt05q1wXjQfa65msec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZsgcfQqTbYj7EBPtO4wsSDBlcxysF1nmyWMyC6UQNEXMOsOy1GNPM+Yf7XChsCsmKlK8oo0dSdoUT6d66U8sFevFqRWwoTvFuMA9W91gul10ALAeLWYPJVvRTn3mxdHEp3QaEkEAFGJ0PsMrjgCHUKTgZEEiwTvISuU9KuPGQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=yoWg3/39; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yoWg3/39"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A630440BBF
	for <virtualization@lists.linux-foundation.org>; Sat, 15 Feb 2025 06:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VepafBrBq2WQ for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Feb 2025 06:05:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5F09740E35
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F09740E35
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=yoWg3/39
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5F09740E35
	for <virtualization@lists.linux-foundation.org>; Sat, 15 Feb 2025 06:05:05 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso5653078a91.0
        for <virtualization@lists.linux-foundation.org>; Fri, 14 Feb 2025 22:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739599504; x=1740204304; darn=lists.linux-foundation.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0i3rAU9TgZ1Zz0MhhHSh60Ea+b9QKMgq4pEb6ogGOM=;
        b=yoWg3/39ZWvcAA6SEZ4PdLZxNDvsrYEHpg9BVDQQJjlbCQKDg+SM0zZHg2Rdo2mJ1X
         a9OyNW9ajpML+vIul7mBV6hEIhmSm0T9RaN6yrN3zMBAA+jteqZRK2IgerXhRLOX0ksO
         Clkth+08K6d+LsihcVjx5j8PCw7HRbke/3gFCK6xhuPeTLr3lMdeBgFbBvL0OLXogDCL
         6sdcMdPScLkVnz/fWcKr9hi6lJqH+5onFaRIYF2DNnVz9JLaJ6ik0grE5nh/ZVhcka24
         FeSp4VGZhwnL7TZz272zsoLuMmvIB1gejjxzSZrQQg1r0KCppEQdnFRcJspeIEXaUMZB
         q5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739599504; x=1740204304;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0i3rAU9TgZ1Zz0MhhHSh60Ea+b9QKMgq4pEb6ogGOM=;
        b=IyCZvIXWss83LREwakyg9rtFo9elRj728jHDT0Hjd6qaJmLzOxIFEP7bdybeq1+MpV
         BC/gmYgeDKtXhRgC9PZxnU+caL8xEV7LUsp7+uK5TLnfhCIK78D9EFeMZ81ZP8nFsa+w
         mXP66fuFNpRId69kEtm42+5s+4zziyDSVfN9QL9uJx69tnSRt+IhCcplonKW/FiK9uWO
         +4n1e6VP28diHTdNJkRUR1cQenNXJ58Xbw03MekLl6nhkraTSUF6njP6nMsP0rp70DVj
         I+nuW9HKrODSxLZMYt5S/2GDTHLU56R9CVg2pkCuozPd7THxM4XL1UMrZUpIhgd+UEnA
         VT/g==
X-Forwarded-Encrypted: i=1; AJvYcCWaT2Gs3o09iSZg5yEDrFrZ6v2lugvwH+xzy+qPaPeuTQ6B7b9kW4V8GFYFQh9wbca1mWbSxVOFPwdCHgd5QQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzlD120ivdxhEzAz6joCNSmfjiuyCO2r3hiwxqUgc5DeBXv/BcS
	HjAFzM+N4U3+eVzan4uKInojOPhWcH26PQqubOcbPuiRR2eemsQb5NGvNrdFvtQ=
X-Gm-Gg: ASbGnctEj2MizOVhtux/mo7B8GDpWRFTRBD0jklKnjvjRR6gqlrB/dh2GoypWq/bWIr
	6+RPmRQMUtymO7AwQD4J+4zPTXZQK0ArsJ7Fas8KNs7SMCxEuCxwEZz6st69o0B9Aa3Oeddr0TM
	/yvBAmMnIXL+phRoBPW+HzHHiE80mYdTuBv/bkgPdnZiSGBjg6g0UJWxoSqqPDp/s5dQb/eM+3R
	U+x3frJozaXkwodjuYcglLkIgRixPxY5VjsoLIxUrFGf5pV3RtHdeCv26HAmlo6uIxWIjbhcAsG
	dFjfqsDIPVZBWH8k7Zs=
X-Google-Smtp-Source: AGHT+IFsNJehBsouPtXrJ7NS9YGEa4MnrstGirWvcWdd4oXF0UxNUAuboQan1xDS6hUFV2zvLI2IVw==
X-Received: by 2002:a05:6a00:21d5:b0:730:74f8:25c8 with SMTP id d2e1a72fcca58-732617bfb2cmr3520739b3a.11.1739599504057;
        Fri, 14 Feb 2025 22:05:04 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324276169fsm4215019b3a.140.2025.02.14.22.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 22:05:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Feb 2025 15:04:50 +0900
Subject: [PATCH net-next v2] tun: Pad virtio headers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
X-B4-Tracking: v=1; b=H4sIAIEusGcC/z2Oyw6DIBBFf8XMujQMvqqr/kfjAnGoLIotoNEY/
 72ENi5v7twzZwdPzpCHNtvB0WK8mWwM4pKBGqV9EjNDzCC4KDlixfpZa3KeNRVh0Wsucq0gXr8
 dabMm0gMsBWZpDdD9GkefOaLDvz7J8REXBYqcszBbVkUml0XTc1W3S5XWo/FhclsSXDDNk4vA/
 HRZkCEjVUh+E9iUtbwPcrNmvarpBd1xHF+oDfLB5wAAAA==
X-Change-ID: 20250116-buffers-96e14bf023fc
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
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

tun simply advances iov_iter when it needs to pad virtio header,
which leaves the garbage in the buffer as is. This will become
especially problematic when tun starts to allow enabling the hash
reporting feature; even if the feature is enabled, the packet may lack a
hash value and may contain a hole in the virtio header because the
packet arrived before the feature gets enabled or does not contain the
header fields to be hashed. If the hole is not filled with zero, it is
impossible to tell if the packet lacks a hash value.

In theory, a user of tun can fill the buffer with zero before calling
read() to avoid such a problem, but leaving the garbage in the buffer is
awkward anyway so replace advancing the iterator with writing zeros.

A user might have initialized the buffer to some non-zero value,
expecting tun to skip writing it. As this was never a documented
feature, this seems unlikely.

The overhead of filling the hole in the header is negligible when the
header size is specified according to the specification as doing so will
not make another cache line dirty under a reasonable assumption. Below
is a proof of this statement:

The first 10 bytes of the header is always written and tun also writes
the packet itself immediately after the packet unless the packet is
empty. This makes a hole between these writes whose size is: sz - 10
where sz is the specified header size.

Therefore, we will never make another cache line dirty when:
sz < L1_CACHE_BYTES + 10
where L1_CACHE_BYTES is the cache line size. Assuming
L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.

sz <= 20 according to the current specification so we even have a
margin of 5 bytes in case that the header size grows in a future version
of the specification.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Dropped the code to set num_buffers to 1.
- Incorporated a grammatical improvement suggested by Michael S.
  Tsirkin.
- Added an explanation of this patch's risk suggested by Michael S.
  Tsirkin.
- Noted that it will not make another cache line dirty.
- Added an error check.
- Link to v1: https://lore.kernel.org/r/20250213-buffers-v1-1-ec4a0821957a@daynix.com
---
 drivers/net/tun_vnet.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index fd7411c4447ffb180e032fe3e22f6709c30da8e9..58b9ac7a5fc4084c789fe94fe36b5f8631bf1fa4 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -143,7 +143,8 @@ static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
 		return -EFAULT;
 
-	iov_iter_advance(iter, sz - sizeof(*hdr));
+	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+		return -EFAULT;
 
 	return 0;
 }

---
base-commit: f54eab84fc17ef79b701e29364b7d08ca3a1d2f6
change-id: 20250116-buffers-96e14bf023fc
prerequisite-change-id: 20241230-tun-66e10a49b0c7:v6
prerequisite-patch-id: 871dc5f146fb6b0e3ec8612971a8e8190472c0fb
prerequisite-patch-id: 2797ed249d32590321f088373d4055ff3f430a0e
prerequisite-patch-id: ea3370c72d4904e2f0536ec76ba5d26784c0cede
prerequisite-patch-id: 837e4cf5d6b451424f9b1639455e83a260c4440d
prerequisite-patch-id: ea701076f57819e844f5a35efe5cbc5712d3080d
prerequisite-patch-id: 701646fb43ad04cc64dd2bf13c150ccbe6f828ce
prerequisite-patch-id: 53176dae0c003f5b6c114d43f936cf7140d31bb5

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

