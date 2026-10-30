Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358704;
	b=NgOTfRzgNzdL/MSR3WprBCf/VeO1HAZXfNzL+QP8SxSpgJIuIO4ZbdfTA9NW40wvJgg0
	 mx4kvYTWIMQg1ER/3b2/fk6nDe+GGhdLImc4/J0A+1qYD3IzqG7KqI1q+9AmhccaJNFQg
	 apcbg93a7mX3cNv44vZK2fkOJfIwlX/XgRKCXA4P5LRchFi9fvgMf4BqbCnX0FR9h94wc
	 BQn/dRWFyl2rD/ZImx1wPN/P0ZPnkgNDx22cWqvVPab6cYm3ZDEmKmmyYSFleiFotn7Z8
	 10XKHQDQaSy1gqAoFiBD/RqSUg5Ovne6ZGSCn7EDcAaNKTEI+yj6uQQ8YIEErc6nBRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=jCYK5v4XQQfPSvL9dOgHNb6hBySDbFEoE4OZWzTPLKA=;
	b=Z/CuXwW0p122wI8XH/Jllu7GCgxh6bb9h9G3EzPIqB4kwnmhOTedeZjL2CNNgjLWQpq4
	 hiB0zG/9OFcNGRn0jVd1W+ORceNFtCbVP2kpAWAL82Pg0bj4DibOPvwqz7sczZ0w2WjY9
	 nIvJDRi9dTGocqdhzXHsW5FZNHuLUv4Ome0Xvc+m/wZr6O7EHFmAQelZQ6Noz7lBirGet
	 jbxfpDJ8yvhSGLzwuFMUUH9/7e0JEJxuqtxdXSLRGp7gQfRhXJ0PuZOlwVtYHxcafzHXs
	 3h4FiiIZskT7DtpZjbUrE1Z2IupcfqR5XTSnORJFfomxxlifK7lvUsetfnhWUOcrmxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owvbKBV8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E78606A31E;
	Fri, 30 Oct 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owvbKBV8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C661F000C1;
	Fri, 30 Oct 2026 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358704;
	bh=jCYK5v4XQQfPSvL9dOgHNb6hBySDbFEoE4OZWzTPLKA=;
	h=From:To:Cc:Subject:Date;
	b=owvbKBV8NNXg7Lj9OtB7rK6tEk1LNVkciZy7BwCanHi5LSGeiA6x2gLKueQ8c2i23
	 XhI48ioSIeiVvmL+11wmp2ExvH1DuoXGQ33RfoEH+ePUnSxc9eGIJmTiP8g0vfp2e7
	 g0A2cHxY0dnFa90IRqxP5TtvJdPAt+FRiPvrXkas7yFCfDRSclAQsdj+iWPaCTljwZ
	 7eE1xA58ufSFejivZ+AscUFazYJcy6BHY1bv8R6CXxeHtvzkibhZvfsMgmNezYhEy+
	 pzuPqXw4pFAzVPk1oJeLqyjsFglnFd13MdV3wBpY/C3homtUiRykPmHIj6qHCWG7NA
	 eM3p243lOyTqg==
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
Subject: [PATCH] arm64: paravirt: Mark steal_acc as __initdata
Date: Fri, 30 Oct 2026 12:10:55 +0100
Message-ID: <20261030111053.114812-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=736; i=blum@kernel.org; h=from:subject; bh=kuEW+4WESnxfN5I5tznjdeP1HfZYuuQX1do2/C1S0eo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlPqm0VPQqnHZBard7GLrtw8+3q400zE7/MkMoVXCPFF 3bn8unPHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRlTcYGeamXv+0SXefoXNe cF7q355Up/1Kvgsv/5r6WXfZrT+757gy/C8WC7BiXPSuhiOat36OxHEfhfkKk6OvFJy7kea4pPW KFyMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

steal_acc is only written by parse_no_stealacc() and read by
pv_time_init(), both of which are __init functions.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/arm64/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 572efb96b23f..df2e90092f47 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -31,7 +31,7 @@ struct pv_time_stolen_time_region {
 
 static DEFINE_PER_CPU(struct pv_time_stolen_time_region, stolen_time_region);
 
-static bool steal_acc = true;
+static bool steal_acc __initdata = true;
 static int __init parse_no_stealacc(char *arg)
 {
 	steal_acc = false;
