Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855D5822D
	for <virtualization@lists.linux.dev>; Tue, 23 Jan 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970160; cv=none; b=QZAXU/c5b//kAMqA9oOU4dx4DXLGE5I6RReDtqrck0ubsL8be2AOTlDjWERAY1tZfhHVL3k6h89uwxXXDl1X9Gx63wPW6BFernBMiFeOiTjzoLm5g2/zUAfD19/U243MZ1WIlXBpvrsF1EtdIfCqb7P/Z3vsExBDAuxINkBSJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970160; c=relaxed/simple;
	bh=NqZesPGdhPMPIXo9vzbA31ktFf0tGVVn+vj19wjCjyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVg1jyU7HzLAkoYi9m7EjyDNEql/fh4vqCMx7dx5aqJjJx7Hx0/a8gU1LDKFAOCemq4/XU/+33uMhCKqWy2wsr7x5ga3FkSEUiXGL5z59lGhxvE2YeT15Amrxm9Q7qhw0kaUTi7j5x8MqH5EmP7P3HJ9KKaB6YZEr0t2E54q0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eucQFVrn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eucQFVrn"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d71207524dso13169805ad.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 16:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970158; x=1706574958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug/eJpZr5lllg7fGddUawSE71HAAShvEy2mnfZ3dSCI=;
        b=eucQFVrnV6lCIi8Uje3DriWOFVKgyCJnJofDz+aix1tTa4Oe33RceWVUrdsAjwMmsO
         EYOyMtKKcPyqLNDffvxVNO41xKAjSnifNXSwp96vnUSlzhPR2MifUJfTnVZsEA0UmVrP
         TPRo44DYCLJNgdCIKsMPEdzjHOWc9pLx+rRc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970158; x=1706574958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug/eJpZr5lllg7fGddUawSE71HAAShvEy2mnfZ3dSCI=;
        b=pDEI23lNpulqqxoWRhcFUTUn0uQf5vDXA/Z16+OPYSaFxE+zFRM1c0/mQPOpCP+GoD
         VcC4L/YfdICohHJdCBXUJO7aTV/UV4KyYsWldIBK5P/cI6Uy6gB2hpSCdCZwAz4iDXGk
         3FMqI2u+1bmBPKUv87+PABkYlOBHERWjjKdgX9cfOiq+Uzdzo+E6b/05Q3eFO/dNKld6
         eCPn5QmwKBHb+RSiSATKl31/PRw2sjbgY0uwaU+hAjg6bqEsYooeztC6Em07Z8/cAhPn
         HMWdauiKarrf2LxnoYeIvhCojjoD5S/hQ5XO7bA57TJQfKHidk0UbNFzd45V8OihLGRX
         HaFQ==
X-Gm-Message-State: AOJu0YzzPN8+dqsM8xUaRve0xXaZuw5q1xqY4i1PrydUZNbDfbSmoDhk
	8EeBDl21DaXqtp56wjmjAuiZlvyl/63SkezMgzTyMOdifGsdRF1doqUm56bb6g==
X-Google-Smtp-Source: AGHT+IGbHO8F/hVPNAS+cYdBXp0aETE+5zl8nFoMOWvMrZu0haS/FCh6jw4MqmTh+lKcIiTOdQpn4w==
X-Received: by 2002:a17:903:189:b0:1d5:c77c:1bad with SMTP id z9-20020a170903018900b001d5c77c1badmr3603424plg.111.1705970157756;
        Mon, 22 Jan 2024 16:35:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ki12-20020a170903068c00b001d739667fc3sm3599795plb.207.2024.01.22.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 77/82] virtio: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:52 -0800
Message-Id: <20240123002814.1396804-77-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=keescook@chromium.org;
 h=from:subject; bh=NqZesPGdhPMPIXo9vzbA31ktFf0tGVVn+vj19wjCjyg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMtLBZT/T1zFr3Pk7LIqHdfeKoLB+DZJ6nU
 eJpFhVGy+SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 Jr4wD/wNabBI/0k3KRp2JIInEpH4vZHXxi+YXYN1Q6ldFb4lgheY70n+09zwS5YCFmaS7Phow0q
 sQ3NGqc/LMQu52WIyo9eugQ66X+NsHyvKquukfCdLtx9jSzToGbIYd3DB7x1EEPHipoH7lvtgRD
 nHtsh3kq/C+p70AybGlMydqgrrPNb1DfboeLRz6rxhIfDmWVI5kH+L5Z0ZNxYR3cZC1UOdz2GsH
 KtsEbUpmOKyh2q+iG4Y4H4OtA819vV908Jkbrzzo666no9Hz7D2Hjobm86ELfkhgFZa1vC6CEDk
 8U6VsHqeS46f14sFovFnBkEUS94+Z6gIjrvogisCPd9R3N9fV9/0WsPm5aNbWjXhHnCEkAV2gEB
 aEHMvQSF+FMpizGRzlqkGgFJMIN3SlKmVZH7t/ukK0Lc4kmSKkRYvqf8JMnlbdjnpruwRJf7K+J
 s2JFixwTZjankT9R4zLLM/lfaoqTW626q9FqA+biBMk7J+INeZZ8mXCYTmjch3KoF7TCRQW0Ix5
 cZXEgUMIySr4lY4yafH6qxLzcfXHPLJPd5D38PR+eEu8djg/Lnn9abNdmb3uTneMPskrwx2EaH4
 PL3NCneQumc5tifvlHneHC5q0YWKR5J4nwuLNsc3GN0YIAGrN2jiQuCqADn3NM/LbxnUwX7Jsxw lLlz7iPwOj69EMA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..710d3bd45b4f 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -59,7 +59,7 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 
 	length -= start;
 
-	if (start + offset < offset) {
+	if (add_would_overflow(offset, start)) {
 		dev_err(&dev->dev,
 			"virtio_pci: map wrap-around %u+%u\n",
 			start, offset);
@@ -81,7 +81,7 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 	if (len)
 		*len = length;
 
-	if (minlen + offset < minlen ||
+	if (add_would_overflow(minlen, offset) ||
 	    minlen + offset > pci_resource_len(dev, bar)) {
 		dev_err(&dev->dev,
 			"virtio_pci: map virtio %zu@%u "
-- 
2.34.1

