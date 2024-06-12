Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B674AD5D
	for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158339; cv=none; b=B3DJ8MjNY+Ekz0uSM4VYYR0vdkTRjqwQEPkRhXpdux5KtW6kshAfpmgEOIQ60Qk8boQybZSEM8ZVBBeXlHOZ9IapAPeap1/kfDMF8zr7Oy3Fa0XM1AJQzqwW0bNzItrTHCUSXlHEgVsLL0+YglX3KrPJZyZE8p/0hQSmYfS2TJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158339; c=relaxed/simple;
	bh=ow+WRcEvA3pNIVVf3fLydRk6hOHg4krSLYZQDJrwoAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WgIjk7qMan+oMihUYVIfPYivZANe3n4VaOkwNK0mzGuxS+lP0EUr1XCsIWBd7sXObc4BtW4Lk6o97LAnvWO9KY7AyiohTYKIuomek5MkJm6319YB/ABWQP67s6P5sAPkUBYGuAi/n4DGpN/52rERPNMAHUY+8XJ02Qmi+YvHX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YswApsq3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YswApsq3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe71fc2ab1so274430276.1
        for <virtualization@lists.linux.dev>; Tue, 11 Jun 2024 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718158337; x=1718763137; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHlMYhGZxnwsaOysx25sfHBbHxJf0WYTlqBZxa9fVCg=;
        b=YswApsq3hB/RFpLWwo2i75naIBgcO+QSCAbc0Nk8QF7G8xsZ3U3kQyRJgXsjj3UZ3G
         rpACY8NusMzdr2b4nois0uz1rRElLl07j7wojs/GbC+Ifsxe3Vjci5n4Y+wziTt0fGC+
         yqYVq4+Vp24UfBs+ZbeMkLnzPTkb2azg+iJ7K1xKxgbplZeGplDnIJDKejtILDgXWmCm
         FhnVL4x5LlHnR1e8c1jmza5Z9YhXNv5a9EjUBBPbmaZd/ucld4x3/XrwV0Q6gQN58mS0
         on7XK1jALdfj0e+oIOB/7Bnu/cdfcyycDC+9pMxnRR8E91NINXH4BPqLUNHlRGj3EhhW
         6FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718158337; x=1718763137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHlMYhGZxnwsaOysx25sfHBbHxJf0WYTlqBZxa9fVCg=;
        b=t+YPXgLKbkhikItDVLUeTnPPFgMFczzeAgKPDHiKGO+czNe49D4Jm6Sy+xaWq7icDQ
         HMQJ3xYVJETQ+Omlpws/JOcvRsxOoA4OuR9S0HKdnHLfYJTCqwp5Tpkfwi74lU9KlC/j
         InxFwYaIyJVEKh3WYRFll3YDFf9sUqqYuf9gmCf/DB79nLlb4z0jfj+HJDSppbUYUDaw
         xHrf2YpdAy5qlRmkw6b5HQWtcyir7omxPw8tdWcNj/EcBlBSMO+R02U1P/sJszgXzdiO
         r0eAGePrBq3wCIwmiyM06lMHnKl5W2TtekFkD1EWF2APUR/pq4qWfbK0SaHfbG+uI/kt
         le+w==
X-Forwarded-Encrypted: i=1; AJvYcCXkQL3qgFz6SKGyhUnmUuPIUdJ0Eqn6/c8Zc86RfV7CkOIDKgJj+/eLOLsr6tWiPvlzGy/HR7TukEojunhkU/2JaHXpw1rcn2SlguuvaIs=
X-Gm-Message-State: AOJu0Yz4fSXRYR0Va5wJyKeMA4X2JtN50YY5+wCVKYlqCyb6we3GEaNj
	pOca9a+b6CW/3+y1aFHx/RiwqYx+LD3taonoG8kC2enq2NY4QDiTsRaLdVb+T+8FFffLw79yLKl
	dRpBaoA==
X-Google-Smtp-Source: AGHT+IGt4ud5/3/G+1KJieAAEUKdvmhQo9Yatp2D5Uch0hGD63q/smE91xVBjPLMSedGoXwnETr8/GQkwf7q
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6634:9477:a468:5a8c])
 (user=yuanchu job=sendgmr) by 2002:a25:8702:0:b0:dfa:b352:824c with SMTP id
 3f1490d57ef6-dfe66b65314mr108148276.7.1718158337485; Tue, 11 Jun 2024
 19:12:17 -0700 (PDT)
Date: Tue, 11 Jun 2024 19:12:07 -0700
In-Reply-To: <20240612021207.3314369-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240612021207.3314369-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612021207.3314369-2-yuanchu@google.com>
Subject: [PATCH v2 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dan Williams <dan.j.williams@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..5e661f39e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.45.2.505.gda0bf45e8d-goog

