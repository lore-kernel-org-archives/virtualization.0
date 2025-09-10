Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABC313295
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497185; cv=none; b=FsYjgdCJD2eN1XjKgJ+i0s993K7JKOGKrmZfZRpNMgFZds54vBEUA7y6GwPHogDfBEU4/qlBNepvMcY4gFAu0jP1d5i3LE/+vgkRsg1t63t3fvv6RhzWjyThCqxdizSRrSGfnwoNZYF9mJkncHs0Zu41AFJb++5LQz9HNSuL/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497185; c=relaxed/simple;
	bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0MuDg7RlpalcMydEqPMJLFtpNTp2eqVLjt7xkamEy0mZjE3lMaG6AecKA0w3/jsnmMDRKCM7tB+bHKgfpFpVs/++vfkqBxekxeLIub6gj7I7FMsDWb0v94CtmhYWwQjfHf4ZMujcxci+z9+nC3mvGzJvB7v9A9AQJ9mj561sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hL1/IY7g; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL1/IY7g"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E16FC4051B
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 09:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWr5hbocMkLC for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Sep 2025 09:39:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=alex.bennee@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C2D4D405B3
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2D4D405B3
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hL1/IY7g
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2D4D405B3
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 09:39:42 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b0411b83aafso1074456866b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497180; x=1758101980; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=hL1/IY7ggxHYgOniZNCZPkgskc1+cQ4AGZzU3msDBtQIXRqx30k/nMI3X6CN7UjZ0/
         CS5dlO5SYpny9MyLv8bw46NrngvSTwectrXT3M4aDv+uBa15B8GTHKFtZffypODP3ksr
         isRtr9FcXC4GmVefPcw+Lh49PT8G/7eiznr2nXhheHgqd3I1yXv863ToEOCZbNYlVsXu
         hycTyO/DhH7TiO+uqi0WRw+qIIs3ARuAKzkmio4HxoyUR94Nce2wUrlKBhcR7QtZlRm1
         3QwPFmCiPP/cFtB6rasqCStVcdvcWKz7HAeE4dKdOIY+23bHKxxPfm3DbuZZ8T1dkVaJ
         tVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497180; x=1758101980;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=v/mQV6xudayznd6tPOkyE8u7vbZvmlQcGOwoHxBkTzuuPpecW9rJAXQAgDpvklzPtU
         GRjBMfQ975ZOPho0GuqJOhOpuBMmMTTowk03byJbe2kpSjj69SyMv23bdrPgnNK484V3
         akskjYQRJXMCkyAyGV9ENdqGYiVJXfT913ObiZjbH/U30ijo17btE2FvNFYHmY9wZ+zD
         1brMwBw4iHS6HQ9VhB1xnxVxMLgJImi7ocKHHw5Uf+J1KBClWnU7M8L71QnCDRMuYv05
         A9QlH7pp+zdzkDj/w5eFqjT6/fBhUVxK0KlHz0pXDyUjjkOafUPwrQ8WaArp5B7aiy8X
         XYgw==
X-Forwarded-Encrypted: i=1; AJvYcCXb/65Hlq3pdPUXR2uPwuB7Hlg66Vui4SXrye6z37eAaUULKcbe7aD6ipGNlT42P+Ti77/55JCyGyXy69KMVA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw0Po+Sk5nXdBahOsXNJL4RHIhR9dX45XB7zTMYc6IKbFmLCrzE
	wWy5xaGHqbBo7adsMMgOL9AqLar3YMxRE6QZ35YuD4OB3ggbbdzx6OBwqMrl4FWn8f8=
X-Gm-Gg: ASbGncsHomI6G0B4nDhLiIWlhS5m6GemCryLpeNf71duHMFHfSrrQ0zp5yOEnud5UMM
	GHktfSibF/GnCHmeaGqzOhCtapKdCB8qPzRwjTumuYWtc9xH6DQPoTBbmCXKDuS5YOC/Ee6cwAv
	IVMSGcvq0oixa7sqAX568USgAGOqwigy1RMf8hRkaGFak1uhOAx7KkwEXHfRHhc8ujX/Cz5oHDR
	tH0dm5VamtJtczVRIiWf/WOXIqoeKFpC6+L7dd12WvE786ULRyYJ+G73+LKwgzYXwFgY6fmPsUO
	pa76YpMM+okG3I/MGWnMBkBuhzesVVdrLTSPR97kS5IRbEBdNKozRBJD2M9V7+quCmz8nKsmujT
	qFBy0Ka0HuW6Jl33u/h8J98NlaIM7AYxQDg==
X-Google-Smtp-Source: AGHT+IEgLz62atvGYTtgWhK0IqE5DaeMbopSvx9UyamfacYq3cpWns33qwgJoigjRNFokWLtUFrPnA==
X-Received: by 2002:a17:907:97c9:b0:b04:1a1c:cb5b with SMTP id a640c23a62f3a-b04b13fd491mr1455086066b.7.1757497180392;
        Wed, 10 Sep 2025 02:39:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ac0c1sm138008066b.84.2025.09.10.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:39:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BCED35F82D;
	Wed, 10 Sep 2025 10:39:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 1/3] virtio: Add ID for virtio SPI
In-Reply-To: <20250828093451.2401448-2-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:49 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-2-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:39:38 +0100
Message-ID: <87wm6663z9.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add VIRTIO_ID_SPI definition for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
