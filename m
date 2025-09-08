Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0419343B
	for <virtualization@lists.linux.dev>; Mon,  8 Sep 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331046; cv=none; b=jKbZjYhO674xq3jqWJ87/Xq3ANEzlaQJP8KPHUvEr5Nkyy3w1HdZUDHcsmPelt1R9pkYJk5/hJlSQDfcxclheBkJLvAcAJZZbJYjz6fSOWPz4+Tcs2qy7bLzwas9mQEYUiYjOXe0951YumBbguiloeLteojj18RV6cuTBPSDnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331046; c=relaxed/simple;
	bh=Sj8wR8loCfL+BL8BD9MhAr7hzFXWSWyg2zKZVcz1Tcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTI0M05hthWqn/sYvB12GGAZ6VlVIXxTwuSJmVyvH+hB85+VW4VGHi+qPJ+uwuRWx8tTtG3dnEgxFSdz1sbFUMCVCUVbrmItoUqQEZcwKogJE3Sn3R7Dz8lW6SQIs+9lQTytnPeHqmRbPzdqZYzz0LqpL4e1nMf4MpAIeBMMUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBHSBJcl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBHSBJcl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e249a4d605so3413901f8f.3
        for <virtualization@lists.linux.dev>; Mon, 08 Sep 2025 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757331043; x=1757935843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj8wR8loCfL+BL8BD9MhAr7hzFXWSWyg2zKZVcz1Tcw=;
        b=DBHSBJclh76x29MxEzkZ5llNPTMS6JZlO/AzSvEtzdqQWGSpJhkux8xESPkTiDytia
         JosQRocVkxR4lPDLg7PpSyt9b0wjSnoByvaiGFZ/7yKSatcLa9bYA9eEnH9kcjf0SB1d
         rq3WlQn8RIU+havy4frDDVQMsrjZrHN1JeLheHoLMYd9zw3Vvmc4f+8Vmon8Wsiqeezw
         788GjScQy8PCGbqucNAFX93RD5nt9RcWy2zocuHE4btcIdLxUXGpIHd4jfqvv9YvrLgv
         MX/7QWvFT+3fivhK5O8IM2vdI34HggjIFhsfSo0CzPX7EHifFW7NJfSS6Z6jyQfrXtEt
         elyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331043; x=1757935843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj8wR8loCfL+BL8BD9MhAr7hzFXWSWyg2zKZVcz1Tcw=;
        b=Bjt9UU213QxzFJecEQ/tamsqqEsGP/QQNh5Xwy2vhgjFp49+k3N2T72oPd45/22w4T
         M2BGq087s+F4ny5qMEZIHSMTu1njL/mCOzJF+pXaW4mKrjfsFMOiRxWWPR2GhoEo9YUE
         bM9RVeMNtiHvvPUgtSWB/Q+TCXryHIQXRV85JYupLlDNPucL5ZyHIgw+yEkvWGYXaYcx
         KHcSlXx1BqCfXhzEzNe5FuZ1tvtqUBl0MZTW3uUP7sSgsLMY4kLRLVYGKdCos73RkXTI
         GEHjOBBtFpIjwdNyjUgthbhntU96L5oeeeDp3EZT/HjZ7f7ey8Ixnc5YVbXvy8RG/QtI
         zmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHqI+wSwPqsRvShjLCVYh4wzZAUAKrin0YRpTZ5S1cA37zsS9ylJJobFmW48sR1PoQoeCyGQKmO0FeOjuMoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxype/Cf+5aAvePl0tQ9bqkz3jUbzGUe01EtRknf8GOYXKdcZ2
	qLSsBE97+ZjaGoRGgVrRKp0I/KRGUVKDLbtDsveG+jvBZLeOATK80o9/
X-Gm-Gg: ASbGncuBt1rr5e+kxonIfsqthaaSYuysVOd/EG+zVefIsy2OpxRGZYM1yjWpTXbbTH1
	cAcpiOFdg0NQkEM+P1s2VYa5LW/ZVIO2atKHicsSSzII/N6S2rTik6292CPgAFnWP8Q9Uw/84MG
	ryBeJDA4+1bVjU4ogZSlGglP6rbsVv5XTrBFtM4iWaz1OeNxc3z4INzehtFaY0pbvRLoJ14O+Um
	MlfPVRcKdRD+aXSA7iKjVJhVMTYquQ1AASZ6/dbwwOoM8MpGNy4Ref6H+db+2wCX8Aa5V4S59TC
	S+mqtTdYM23szo8zXk/WTrFJAyVRtKKZ6+cfGs/gtfVknjn7JeJlvKsIHahdnHuIVKYEx4pRH0K
	3VgS4mmiiBXfNxg2mqwxPqnirl3WXYoJGrysSAJGbuEmxd+eVbcnWYxEoH63kqhfFpNNgzdjaaV
	8LCVMqBhhu7eMM4ahP6F21FanaRmHIrfW/zLR5zz/OkQRC7qri9A==
X-Google-Smtp-Source: AGHT+IEZdRqdKNRzQ4aKulSAXapzR+SOfXlwIt3eDMJ2N5BvZ9uT+IJmtyIpieQvOG69VDCQJ1Rvmw==
X-Received: by 2002:a05:6000:1a8d:b0:3e4:5717:3684 with SMTP id ffacd0b85a97d-3e6462581a2mr6930466f8f.40.1757331042368;
        Mon, 08 Sep 2025 04:30:42 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de45dce11sm61430105e9.10.2025.09.08.04.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:30:41 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Leander Kieweg <kieweg.leander@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tiny/bochs: Convert dev_err() to drm_err()
Date: Mon,  8 Sep 2025 13:29:15 +0200
Message-ID: <20250908112926.41182-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818113530.187440-1-kieweg.leander@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping on this patch.

Is this change still of interest? I'm happy to make any changes or
rebase if needed.

Thanks,
Leander Kieweg
