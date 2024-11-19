Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643C1482F3
	for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002179; cv=none; b=IDKAR4VsT8kohYnCeerSjhZoZA5evovTOnnds6jIBK3vqAG75ooIQ97DKV1M1Ei4XGf4Eqvo7yBLmkgZQwYyYOGVj6NHzsQklvrt8/larderacmUP6r/CBxKa4mZCFnkcF2ADlSW0eTvO0YwOwLhTWr/wIul02aBoBU1z4mBjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002179; c=relaxed/simple;
	bh=MK1mRBvffaxWaWW0lCYjKmPrzl8K+sbcDqiVDd0556I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lnABL2YsTYDROhkU4iZGn+VOSkIBTTAjuo7CIGXhmmoRd7kdL9NouhgtnizLveeiDKX29GVVZvbqk++ZAYj6WkkT++b7QOg6KMZIkNzxFtjHzj1u1bUuqGdxQNwHow+KWzgeztvWz9kF8bnMJ8eVxaxdzyQOxBuBLr7fItIh754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f75YYl5P; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f75YYl5P"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1996086b3a.2
        for <virtualization@lists.linux.dev>; Mon, 18 Nov 2024 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732002177; x=1732606977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHWWXvo/zk8M+CGH2I3FftTehJA8J+eqWoqCr9hesl4=;
        b=f75YYl5PiGcVoAj5ru75ke0v3PhkqJkLYo8mtE2MX1EUMhAEJQBZElwODdl3PFb34t
         L75LcEOW/1NnVEMIIKRWPmfv7Uf8+pxhc9Rp/fpBeJ9Dme3T4u0UKYtD4pNq7SFi06/p
         jMSw40OBmrWxeq8nz8WBpYDIaipHp0yY9vBvI7VrDM3nnjz9C1KiLruFzxjJWxIVGQNH
         ZRTrPodbBwh0OY7W0vxya1KmtHc8HznTRH2cEx/WJOoLtCb+xYkr7gJ+3GmEaoP+iT4k
         y5QhM+x1uJ7Hz5VBQcVVfWzK1PeBGJTFjN89xdT/NEVXl/xEZG62FrQ/TUZnv8qNHWep
         9cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732002177; x=1732606977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHWWXvo/zk8M+CGH2I3FftTehJA8J+eqWoqCr9hesl4=;
        b=griG65VP7aMhdGsPKuBaL8CMf8cQfP9ZIMx4dvoJIYpG2Fva+y5K1UiYZah17UN9h0
         HlVKEwfM3bZax2/fpyb8fsdzCOn6x+HKIjwxjcXGeKTaWTGN6Nm/KZgnHH0u6YSlPpHt
         dfXVPyryuk0fctd5EKbub2qDAiCeQgkb6mNx7xAyisEvp7dkXbO9Q6+LEEHJBuw/SESy
         8jhsXw91kYXTyEWMP8W7Kt2+WTiewTiFhqpkB80YNybNW2S9fFi4vtJf/j1Bbr8gPGp8
         VihGXhEdAlgsLVXc4KQHzl0gWG8eGP+bcRLy5HiRn7naw2auj7vpv8PplJcxyUDIt17z
         GGrg==
X-Gm-Message-State: AOJu0YzKx1hkQ3SQbivVchKKf+RrSkfLTpXKCLyiSes6FQMxQRHPETuL
	EUxSqeNX65BdFn8HuS4OORzT5HnfzvbGxhhtB2ZSQRX7ZFjr9FN2L5PxZbz5+Q==
X-Google-Smtp-Source: AGHT+IHXZvtTF/LYtsNOFe/pkAQ3byRvJRiS2/xU3quIwdhkPrqMzJ5N1wzpXuwG6lnYMnziCuq9Qg==
X-Received: by 2002:a05:6a00:194d:b0:71e:4ba:f389 with SMTP id d2e1a72fcca58-72476b98496mr19972325b3a.10.1732002176830;
        Mon, 18 Nov 2024 23:42:56 -0800 (PST)
Received: from QYWQT0394W.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477200a99sm7664609b3a.182.2024.11.18.23.42.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Nov 2024 23:42:56 -0800 (PST)
From: Yongji Xie <xieyongji@bytedance.com>
To: maxime.coquelin@redhat.com,
	hemant.agrawal@nxp.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vduse: relicense under GPL-2.0 OR BSD-3-Clause
Date: Tue, 19 Nov 2024 15:42:38 +0800
Message-Id: <20241119074238.38299-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dual-license the vduse kernel header file to dual
GPL-2.0 OR BSD-3-Clause license to make it possible
to ship it with DPDK (under BSD-3-Clause) for older
distros.

Signed-off-by: Yongji Xie <xieyongji@bytedance.com>
---
 include/uapi/linux/vduse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 11bd48c72c6c..68a627d04afa 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 #ifndef _UAPI_VDUSE_H_
 #define _UAPI_VDUSE_H_
 
-- 
2.39.3 (Apple Git-146)

