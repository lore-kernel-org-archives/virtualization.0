Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13F612DF
	for <virtualization@lists.linux.dev>; Tue, 23 Jan 2024 00:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970757; cv=none; b=jSBOV2GhsgUU0pkt+jLYCykH83bD6lTskeeAkciy3lJJG56btnOHM4xMCJP0Itz0/ZOEesq7XfHzr0eQ4n4A4xevwObCVBWIEIc6tykkV1TPDTSH3d15XL3CU6KPhwzy2PUkYC7g7Csljttv7Qcpbi1MnRH5cIClv8jQ27qQyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970757; c=relaxed/simple;
	bh=wEJz6ncP+qRtXKX7k2D+joSrafVF4O5OSdQFr3cojK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLBLCXQDu/zxeKe11MnT+LmuI/1qiIHdDRr+z7KqwQ4n3V87KpZ2Y5m1HA48ZIVHiUlAONILUR99LpE9MxeWYDkScDailtBXmOxLiBlrzV2oNbwYTGETN03maGGL00AV2Xar0iXN27FTL3XLieGiQvf1p+QE4uqLtIy5OLfJ1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hIhsQRd8; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIhsQRd8"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e0ed26cc5eso1075708a34.3
        for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 16:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970755; x=1706575555; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOtaS8Q/PpRJgiodelWT3IFfX/962bDrzicKtXvnvo8=;
        b=hIhsQRd8mG05PAwup7xHg2BcRAtHfg+W91CqWBd9+XCh68I2L7kpZ3dw5ViHrOyQ3I
         zgKyWf3furufuQ+NMXmX7NXD8r4LASrEsz2/J6h457GOmBzvBlxg3HfvgCMdUNhkoPW9
         f22+laGqjb2ANWly81cGUuff/AzryOTofMZX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970755; x=1706575555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOtaS8Q/PpRJgiodelWT3IFfX/962bDrzicKtXvnvo8=;
        b=ZN374+BK2fzClgZDcLBMsHXyS+0HYWtCpzMVMzrg77EP4V7/yOivZj6BF4jTvo1463
         J0ldM2FBe6DosdQF/i3gTWf5RTvRDWaqDeXdcqEWegvWvKsC9YMyR2mkDBhGDUkYMJcu
         mMAhbeggi5dhChi1gMcTPhUo0DKUyfejlQ1cn4WSJDS+LXJcHTd/z04E9iTuCK/MSttM
         IVj3zYRKseHFa8Pmyp3u2+jysblb641paqwdiHeRuyFcWDbocPfUOZr9NQwOKJvLF0Y7
         V0+Qj7HBbCedi1r0AIeXt7FOnZ+7CMC02Ih7NtkZH+xUkmIiCCQ5jVhINTd1PNW3/G68
         Hhyw==
X-Gm-Message-State: AOJu0YxwjGL7qmib0tTpn0nDCvVMCzizRT69bVV1fFfGn22UaflIrOyy
	6AulVFcLPu1dYAMIQUGsbV2Y/XX/djMVsjwnUAGyn5rbaZg4zh9JfcsXo5QaLQ==
X-Google-Smtp-Source: AGHT+IGQwShADBm43GhljCU0u40cOaLZ1q4WsuoH3YKek1HoSlz9pHA07/Hox4IaetxxaQSRrpFeCQ==
X-Received: by 2002:a05:6358:99a0:b0:176:3e0d:9910 with SMTP id j32-20020a05635899a000b001763e0d9910mr4500624rwb.0.1705970755199;
        Mon, 22 Jan 2024 16:45:55 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g4-20020aa78744000000b006d9bb4400f0sm10234582pfo.88.2024.01.22.16.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:54 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 32/82] vringh: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:07 -0800
Message-Id: <20240123002814.1396804-32-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=keescook@chromium.org;
 h=from:subject; bh=wEJz6ncP+qRtXKX7k2D+joSrafVF4O5OSdQFr3cojK4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHD0u3YhpYy/8Dc5chh0+01JehokeF1vpzI
 BT65uKVfgWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JpFyEACdChSCT4Y0X47ea6T+PsrgS42Vou9eXn9FDMWCPIbD1kW1gHAFP1FAqkYnEij+0625LYZ
 2RtZVv0zZFrtRaGdtFZFQFDJTSr6QNj3uxivVtsmwb1pLXXDnFTFWikADuH5v60qkgSrb2bTZMY
 knyNpBo6L+ItzkaxgMhFX1rtdBM2iTj2HOYKmNkYIwvxCNExT4h+7TKnDNipWpdd5EwB3nV3F2p
 1pExl5eEqmY2Ma6oIf7cypf/bIKRIjUW1Ilre5bbCngLzeYZMqOG35bUlr3WC3w88nu6tYBXolx
 Erl0eGsiamN+wyuoxNKoT/h+WyXer3JpoxEq/sl38I39B23XaYVff/d+6Suvc+F3tV6jNdbyaem
 JxwjjNG4ksbLc5PdSetTuaRGyP3xwIiVRJmS3tlng0ghnRbKVS/FFw+qU64g1HMXFJ/qj6Ldypv
 ORamulyXPJU2FWA/g8/Ld+OnSQn41XCT6619haypc24tpwo9TMSlKhckwkeIgqTxMWBfiha0co8
 ANuXzPXBosDOYCZNhGhwsT9JNpMKS9otU4fcb4uoJ2RtASuAmGm82JgroIBM/MhrLeYmlZOwIk4
 jIzar8S+YFZz03aIUIiOxVH9cIhd+DZLz1UZb5Pc9SBnZc4u8HlyhSQOPf8eOZtvyR3Q+n8534w TxS3x9dEXm4+h9g==
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

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/vhost/vringh.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 7b8fd977f71c..07442f0a52bd 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -145,6 +145,8 @@ static inline bool range_check(struct vringh *vrh, u64 addr, size_t *len,
 			       bool (*getrange)(struct vringh *,
 						u64, struct vringh_range *))
 {
+	u64 sum;
+
 	if (addr < range->start || addr > range->end_incl) {
 		if (!getrange(vrh, addr, range))
 			return false;
@@ -152,20 +154,20 @@ static inline bool range_check(struct vringh *vrh, u64 addr, size_t *len,
 	BUG_ON(addr < range->start || addr > range->end_incl);
 
 	/* To end of memory? */
-	if (unlikely(addr + *len == 0)) {
+	if (unlikely(U64_MAX - addr == *len)) {
 		if (range->end_incl == -1ULL)
 			return true;
 		goto truncate;
 	}
 
 	/* Otherwise, don't wrap. */
-	if (addr + *len < addr) {
+	if (check_add_overflow(addr, *len, &sum)) {
 		vringh_bad("Wrapping descriptor %zu@0x%llx",
 			   *len, (unsigned long long)addr);
 		return false;
 	}
 
-	if (unlikely(addr + *len - 1 > range->end_incl))
+	if (unlikely(sum - 1 > range->end_incl))
 		goto truncate;
 	return true;
 
-- 
2.34.1

