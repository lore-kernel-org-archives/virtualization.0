Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407785;
	b=wfxdQwJzxzmTAypVAnU8rw61snQUz+88UNVV7Kdur5+e8j4tKq6SpqvgndlCbZ3mrOTF
	 nsUV8hUDiU+/SFXeNnoUMPgaXW6I3/dPljmFv1XW5S+uTAy1sMABAeIJ0+y8ZtghPrXS6
	 ThBoFTzTagudchrCZgyH+VTldytgOMpDGqOEal5Jn2cTijSLL1htSS37fiNo3OHBKskiK
	 KtkDFl1HoLaInraJ53NfSA2Hg9025CCitH9Ej5z6t8freCiQYC7U/WIg6h1xiF+6+kLEZ
	 1p7hylYxETJH1IMf8553D0VTHZEBZFKchgGtcxYWWSjHXrDeVxLrICmkfVLiOEGPjRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z7nPTI5arwtfLvJ1u0SNc3tfHxfngmeM3rWmqkRPFe0=;
	b=VHD3D9T5CIT4GXIAbw0A3kwhZdAsZwTeaMLO9G0aBX3ubhIUxfoRPOlY9Of2Lnv/MzJA
	 nskTkObZ46RLVped8fxlPjTmyF0BcNXJfoeQzrSdzkTmAFpYx+9ZoFjvUC7PUBoBsmwgW
	 KGjXykYVFdFvw1jzf7WKM/NMO6HiNjqdmhR63PH65AqX1xmqtGCG+KuqwJs8ZweZHuFPV
	 AAFcwY5p91S+TvvwV/aanE19hz+MOXRo9zxScubtfBfCH2r8fIjiiLujVEhnS2IDDi5qC
	 X+3T31AwxGtqeNvdRGgpyTBbhT7tRukEOt2D72Q1k4oeVDVFOx0RzhTdbIm/NUM7pnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=M+xHdcAp;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249D606A31E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 04:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7249D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=M+xHdcAp
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-949664ee41cso328720585a.3
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 20:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795407783; x=1796012583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7nPTI5arwtfLvJ1u0SNc3tfHxfngmeM3rWmqkRPFe0=;
        b=M+xHdcAp6BeU5tBmp4oNNFgFZg2dBwPvzFz4dQJQW6YdDI7UoTm/A5isR6dsNfNYD3
         pUFiMFjz6QKF4vl3OoK4ZnbVSHwP/jILojzxRzVMW2/+ppwLC9BYqjLAE30pXz8fcRlN
         iHAbMDRI6BX2dHU6OTw6EckNmvdxoLPKNtPWXjZDHZIvRqvKr9nfHK6vVYEz/2jj74Bs
         uBsELsUWDk0KBYeCeOhFzHlcyE3CkMPTr/SFmBQ35uBWVqsLLIT00lfb9hzxc+FB/Fzi
         IIN5F5a4XfV8zZzMx+iGmkKMhS/Z9FNk6SSvMHMVER0uD2uC6DFCjIHyw1EiZIHQFe/g
         JhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407783; x=1796012583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7nPTI5arwtfLvJ1u0SNc3tfHxfngmeM3rWmqkRPFe0=;
        b=wHeshdTNVAz6A92O5AFpqZtA3EyclGtpuNE7rKerrihW+lgAfKBjwC1en6sBL6Ijel
         oCEHFzp62TT9AsdtN7eM2KiwU5VsiY3j+8gc+Yma5Kxq/yUBZXGBviSIck2H98fNpHB8
         fOqIKQc2FOqZKGLkylsfHzyOEpGdryiyCRAHJf9+yvJ7HIHWHVQg06G8xbUBZodPyiJE
         BYVM43IAWy9uItN/0uBxMikHhcW4U1tGnQ+dDojnn1nEfsancoMkYvCVRqWlV6ybXJ7R
         YQ7wgTsycLtUI6ADcEQgrNaN26Zb/e8B/lE18BfCxvsnMUZs//SFUliRMq+off+66JL6
         PCTw==
X-Forwarded-Encrypted: i=1; AL+hErF0uji5SUQA+LNrcfEbvg2B814s+rkU94sSjYXFKcfoW6vYUgERaRwFNdCEiyhr7CTdB291MSyWr3E7D+xtPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8bTFqxvT5vVRL9WCV9xhACz92tKtT7qJzZSDqRjCK/8NdW6TEF
	3cBou9gpaNhvaNIfzAmD3TUs0mwkYvSy0GJHTJN3JFYhkOdLvXROL2zoOWXJefXo4Q==
X-Gm-Gg: AZFdTZf1VZEAUBvNdyWpNcHGuGuRrOJMRbT1uKPt2/M7aBf7xL2w+D/Y8/bTXNmXUxh
	8R4Y5MnjlcNY2Jz+uqC2cm0ur0FaRhQda5lLypEX5D93QZrC+YBRe5s/OI0a7fFyrEh0VUjE4v3
	bEGJnbLs0eJiGTvPikiaV4aR7qk8ct4Mjp9pFz04wkv7EMZFkZd9cZZj2rLNqG2oKsRd8OrxKE3
	k3gpSvxfTKXqcIsYCyTaMiqsMe29L3FYpY1+uUJHLmqWpBiE9Dx7BG8LiBIIa2vIyr49UDK6b5F
	ijp/R3oOjBmar/xQwiUUwFQRkwnXqPeEKYiUxT+3qvL1NiGRRxsOrCTeRnJtsnDvDarro41oP65
	XlbcYFfrej4Nr5XkTJv/z/E/TFfbiIz9hVMdSFkFz+Ia21wac5ry/GHYJUf7FLj6kn63vNJ/1fp
	ufYlrQFInL3SCd3wUBczCsAE6r6IjSWbRBNUZ9JBL5IovDhmzf3TcPTn71MvR2/H7yujAx1kWU0
	FelUWjo0SUglFPcJbRkiZOSyWLnGgWRmoyYQYqAGahp9ploINGIXLND6zB2e17XxnW30E9zfvRc
	pkqe4sVs9JFAdF5TG8L+FtpQi5EhW+IpV/Pk395EUrdZsDiqQu7H
X-Received: by 2002:a05:620a:4397:b0:93c:8e3f:3036 with SMTP id af79cd13be357-949ba827abemr1807820185a.4.1795407783349;
        Sun, 22 Nov 2026 20:23:03 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34a38bsm717421185a.13.2026.11.22.20.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:23:03 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] vhost/net: ignore extra words in VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 23:22:59 -0500
Message-ID: <20261123042259.3484334-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 333c515d1896 ("vhost-net: allow configuring extended features")
added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
words from user space, copies the words it supports, and then reads
every remaining word, one at a time, to check that it is zero.

That loop has no upper bound and no scheduling point. A caller can pass
a count of U64_MAX and a pointer into a large zero-filled mapping. The
ioctl then stays in the kernel for as long as the mapping is readable,
and a fatal signal is not handled until it ends. On a v6.18 debug kernel
booted with preempt=none, two such calls from a non-root user, each on a
4 GiB mapping, froze a 2-CPU VM for 56 s with soft lockup reports.

The check is not needed: the extra words can only hold features that
this kernel does not know about, and they are never stored. Drop the
loop and ignore them. A nonzero extra word is now ignored instead of
failing with EOPNOTSUPP. Unsupported bits in the words the kernel knows
still fail with EOPNOTSUPP.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Cc: stable@vger.kernel.org # v6.17+
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Drop the loop instead of rejecting counts above one page (Michael).
- v1: https://lore.kernel.org/r/20261122120919.1718445-1-hengyul@cs.unc.edu

I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on the vhost tree at 44293796526f with KASAN and lockdep. With a
count of U64_MAX on a 1 GiB zero-filled mapping, the ioctl now returns
at once (before: EFAULT after 27.4 s), and a SIGKILL sent during the
call no longer waits for the walk. Counts of 0, 2, 3, 512 and 514 with
zero words succeed as before. Unsupported bits in the first two words
still give EOPNOTSUPP. A nonzero third word now succeeds instead of
giving EOPNOTSUPP. VHOST_GET_FEATURES_ARRAY is unchanged.
 drivers/vhost/net.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 631855064b3d..f6b59def4a21 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1802,18 +1802,6 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
 			return -EFAULT;
 
-		/*
-		 * Any feature specified by user-space above
-		 * VIRTIO_FEATURES_BITS is not supported by definition.
-		 */
-		for (i = copied; i < count; ++i) {
-			if (copy_from_user(&features, featurep + 1 + i,
-					   sizeof(features)))
-				return -EFAULT;
-			if (features)
-				return -EOPNOTSUPP;
-		}
-
 		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 			if (all_features[i] & ~vhost_net_features[i])
 				return -EOPNOTSUPP;

base-commit: 44293796526f4343639f87b2acc53811c78b5d54
-- 
2.53.0

