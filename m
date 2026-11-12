Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512120;
	b=d++aFfapjliTGliqcFZjZz1iyJjplasfGA0ydiYXvIGvU0jpth+FgIt5Me9RIf96igr9
	 Hqq/5hCYuhaOesPiZtY19f/HjOavYlYL8TlxZUQPZoJdhTr0wyKQXtiURkTd/zPwhfNrt
	 1JbjeLJ8E5Lfpl5nu45ahN437aNkGG5+nMGQnvJmRAOKiEYjDQc69ZyfNAjxudx00LRhu
	 nO3cPINjj2vR3kqJFp2J2sTFbTZMNfRhKD7vMRPredB4yUE9CpfaVCnwWSuWPFWaA9YdR
	 0tchfR80ylVPRwafdKHfc87tf2NbeqBcR/LKgadIqLcz00LqAcG13NRGDQopFvWwdfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=BJFoLHA4CokahnP1ZRy2zdB1+C1TptbdFuQdPlx33CA=;
	b=BBqglhHvg7/VA/ObGQwaCf1BQH94Ew/vWjvf65BLwJlik60+q7+vpvC/pa5dpCaxT2vD
	 ZoXhoCcObQJBTMO0cTRZs4wUXIxKyV09Qnnqc+5CGHl/jBKQ5EpIrN2sikZMp7+wSaAWE
	 UfIJdPSNuE4cY1wl2wCMgKE5BcJ/xgWt8Gy3xlY7eJHoLjDXLv1xZHABN2kpDEcvwXoXW
	 cXwOCMJF+9eLZod9yUg2wqHgISLgLZfkHx6IL5LWjbUICRxx4e5aNQkPahZZ3leTYQto8
	 vZKCzOInouaML/eHdY6norjMEH1vV9e/S8K1pGfZypWaFmkPji1pQz5N4pnq5vFHp+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/ivFwGC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A2606A31C;
	Thu, 12 Nov 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/ivFwGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A011C1F000C5;
	Thu, 12 Nov 2026 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512120;
	bh=BJFoLHA4CokahnP1ZRy2zdB1+C1TptbdFuQdPlx33CA=;
	h=From:To:Cc:Subject:Date;
	b=S/ivFwGCvrQwoCF1l3EFepxp5IsPdDQ0nL5W3SpTiQqio+nzAehtzLdf8AE6T9pTU
	 0rCJHppqMI22GrL8UXG85Hw+qvSo5XBaUUmw7k3aeLTB2GW7Wx/7v6kggO3WWBj72d
	 eQ0NNo/kJjqVA32w8yqtuEUcTfpu00u2fKC2o6mJ9UQTrG8emGvpTPc3BP+sjeVrky
	 Ao1NNI8JCf05K/gpSEk92jN2m9SDAhvIvt+m5emp8okoZcrwOqaWZuCi/lLCBnXAjL
	 yYVP7pEX1Bg3nvRhBBbpPo6WiWzkvJPNdaDOQ76SwStlRMd7bZhCDfcJB5rzO8oOF2
	 YeHpeeTy2NQoQ==
From: Thorsten Blum <blum@kernel.org>
To: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Thorsten Blum <blum@kernel.org>,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] arm64: paravirt: Mark steal_acc as __initdata
Date: Thu, 12 Nov 2026 20:35:14 +0100
Message-ID: <20261112193513.2655-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=blum@kernel.org; h=from:subject; bh=Ze87YzqDESuyh+YjCvx6KrexS5wUkfEUNws1BC34Irg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnfRD5e+LD+3IpPE8L37v9eWh/LcqGlurqM59TLtJj9J T5vONYc6ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJKEox/DMrdP+7kNdSksnf 97Dl9dSV/74/Kj5RL/OG+YPEgoUXL8Yy/E/7eaHwpPGKyM2r5zjqvbhZx5jydP6ntteZkkZ1ek7 Xv/MBAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

steal_acc is only written by parse_no_stealacc() and read by
pv_time_init(), both of which are __init functions.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/arm64/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 30bf61d031eb..ef77fcab7f61 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -31,7 +31,7 @@ struct pv_time_stolen_time_region {
 
 static DEFINE_PER_CPU(struct pv_time_stolen_time_region, stolen_time_region);
 
-static bool steal_acc = true;
+static bool steal_acc __initdata = true;
 static int __init parse_no_stealacc(char *arg)
 {
 	steal_acc = false;
