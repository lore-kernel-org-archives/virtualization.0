Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB23DA7F3
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700224; cv=none; b=iaXf5pk2H3LrdCUSiz6Lj3eNYijSAVo2YsStrrQMiWO9dzY5TYl+7NIHTm1/yOO/g+61b4+wEVY9yH0FAGZD65Xf5eaDPUfPdHHGGF7gmvyIiE8JdMpH6g63up9/BoW/ZeEAAJA3xPJ4EWGhaX4cJtjPNc9qG0sR5uN4eB2fv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700224; c=relaxed/simple;
	bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZqD3Ij1v8H5RvlRZEmpy8Ndi6mJ04qX85zPhhX8Z7kx3VrOfN8VyApoi8IFBkQ579GPSsO/xzCU6s8tgariOw/Rkx90s5CMk+EpldOCN4U89jT6UykhEzcGsimThJcIaCr/hjB6gbg/3NGgebJJifAOQqJ9uKNDLtVamNJ8exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvRKpXXi; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvRKpXXi"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ec6188so1374085ad.3
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700216; x=1790305016; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
        b=gvRKpXXirhFRtFpFjqEsRyHwjim2glp02m4QJa+3++ATh2LPV5LdAIE64CU7UND3UX
         hJIouEPqCaZ4k3Lb0e5D+VoW1LfkkOCi7YMmS0PlAKtD80T5EVJeb7QKnnJkW/mo9QUz
         PasFGjYih6yfmFamAJUd4pvBMII+jbFt3WPZjhqipKXVuSCBlfaDuhrEV09xynv9moKZ
         dw8VbKXhkioUxQ1leNhqVb2A2qyGzQtTGAgpOmXFmY4OIMUB/IeCkzPUUZrZQh/l8yRV
         cXivuM4sAI3LlemRC8aC1tIahU5i8OBsADOZ0HZq+ZKTjHYEhgcX3ehoVCNRH6myPzs7
         4S4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700216; x=1790305016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WH/rnE12a+uaVlNTry7gwUg4MsviWYt1nqi8WX9vXi4=;
        b=IXqjBumh/3EvYAp0cUKme1q/xBbb1MEP8dSewPWnrCIDd1aLwXMRJJJ99pbK4WqDrh
         jTdmbMO3LaiRUlyG/rR1h3tSKwUpzx02efSKmQUZherCEiFAMou7CzwI9LBukRlcrioY
         2O4jZ8Pv4Y4B+hlGIQACIq1aP8hfTAhc+fGEoHaha96aMbUJiTfM31nsX2qpUYJyDMuE
         YGazLBPDxhfSIeiQtxaWDoVvkEG+8TqcHg/OG99v6nYtIZjm0k85hIlAsxFKuwqhFKgn
         WykeIwS7mfxTI2RuLMdkbrc+m1+oZqy8RTzvnJeH+vnjAOCAo8uDLvI43GnZcPNPabFz
         TthA==
X-Forwarded-Encrypted: i=1; AKwUvBwHvBQ9ov9D6v14i9T4ezxX/qpf94eZ4f8mM5Nrqk/ysUu4ku+jOkkmKd/bQsORhG7mP7qW+yrVGKYG3W96Hw==@lists.linux.dev
X-Gm-Message-State: AFuF++nv3P1DEpNO6n2Gkqi6Mg4dg04mHj92+X1sOdoBRnrOOdTEe8yL
	wYOsg+HOzb8W3iIigP7A2PLVMNPDktbVJwcCu8G00CVJyjwKn6NkuNLu
X-Gm-Gg: AYBFou25ODCAQmWTQSEL2CeVGFKr3mmMUwGd7d2YOx0NuQua43ucm6ypqikWaHMzN7J
	Zo3S3x6O+jB8hOT7PYRVyhFekrltLFkI3sVmZrwRcSJnDpgTg6yhIS4rXxVaxCw25kjdiG2D5ht
	ZDcGidlDbqy9WuYSesorU+Q4lNASBYgDpSSz70mI85cMKP7HdeaAQBhlcFF9WPOfFaPvm2RuM0P
	8Tdp7fu3iDJk+g7qJX9ng9PhDszgbWMQk8l0M2WAUtTh7gJ3LAdErlS0VoOTEGJvAfe1GKHpFxp
	KK4aMxRT0Df2tP7SUkUeHeakbdA2CFuV8soTSMrmsEIyJC+cJLJ4uUQ7Kpr/BSXqyLJaj2Af4sM
	a0Rm3YswexxmrhSCwM7h29qO8aSNHr96UUgRbeLiS+SbJowGcovm8y/UFzeKmR0df9dOfJLMz47
	yTk+AUPRbK7Jn13yLdFiSPyAq2g4G1NDtQsmbaBHlNjtShQcpYUi4Iee2YW/fk4dSH
X-Received: by 2002:a17:903:2f8f:b0:2dd:ad74:ac32 with SMTP id d9443c01a7336-2ddb1baf0a0mr24255345ad.27.1789700216039;
        Thu, 17 Sep 2026 19:56:56 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::c570])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75b52e2sm734085ad.60.2026.09.17.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:56:55 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races the delayed close
Date: Thu, 17 Sep 2026 20:56:50 -0600
Message-ID: <20260918025650.15990-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LGTM.

Should this need a Fixes: tag and possibly a Cc: stable@vger.kernel.org?
