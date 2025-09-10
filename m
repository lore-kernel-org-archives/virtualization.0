Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52672BEC45
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497390; cv=none; b=FSEKKvUeGUzPSOryjhc91V4P1DkExs11qgAiX7w++b+hJb4/kZJedo+8TiyzJbSpaKkq1V7XwQl75nt7sdor7oGwCWKrK1XFp8YlKq9WGZT8c3oo/5F2OAnN2z+T1khg8ccVCeyJp6c6mDPFnOrvOQdagfg5rFFvBJEJ+fP/F9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497390; c=relaxed/simple;
	bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ParOLilVH3TQbfQuqbIwmbm8fx4Hwc3A1kicDz5Pp49xxSvsDIvsukA0WzRe6c+CsWv5mX3vzeCPueU9cEruWiqYCBYu38oqhfpJdqJp8R4Mzs+ueq4TyVFMB0m2ab+/sVc9N/dFk4Maxc5Sv0xO7BFuAH6R5q/hwDKHP97blEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skRTR0NT; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skRTR0NT"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EF1440FBB
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 09:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RGl0xgum25qa for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Sep 2025 09:43:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex.bennee@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6448F40F72
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6448F40F72
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=skRTR0NT
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6448F40F72
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 09:43:08 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-b0449b1b56eso963186666b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Sep 2025 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497386; x=1758102186; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=skRTR0NTzAC+oh+ywEJq3aRtyoZPu69urbpp2lMrSyNowAUsqj/yYsuo7P1ce+eaMY
         vFLlwBEVY7bRGyQqxjZ18h8D93peMEN4g+eVF33UHU74MAjQrEn1OVJyLDRCiPj8ZgSS
         Dpdgb811dlC6lZ6baf0igcQMyKsq2YQeCgb0u8grCK8z+ur+pUFc41QjL/R4wzAA110V
         xPkEyNLyO1SXMd7ZG/k3+mX2v7BS4bxci+fpDoz8ki3xyZZAVWEeuREDdoxpLkFuxIvK
         q86DGpMweDwbSifgJLxjgMCqVUN+ANtTOzOrVywBwqJNWbX2TqGJVB7j3Ljw3cEc+CPm
         N59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497386; x=1758102186;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=d573ScnzLu2A8GDknEBJniXnhVaBYdIOqBR96sKnxk+23oDlCk6dBc1UjSqcGjjOL8
         lWObzMTsq0XGQ/ZaqDUL/4VUAH9kh3Em6LJ7HftyPMlyuTjWyAmtyYLP4LOd3erduBkt
         z6Wujd/PqXcux/d6Og6ZVqwkroqM4PyBtz2dIudhxFFQ/tzQmgg0Gbei8asusePNg28P
         bn6mYkKljlZ8MWqv3xgRVaAKWFFG2h4i6O6uY1Stp1E4RPC66DKI47lUqnIsURMEpVqO
         spayJ5C8wME5aeoVdeb9jFW8+ibN+wN094S0TcgO+cfkXewPJoeVUXwFuH/YsWYHXvNw
         G0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG/2H5DhfvkABXx6cUiIvjFTlOi9QsnG/q3Ss1YkEpjQIE6dfpA26D4ri4bfqXRkae91zkLH48qlWcyLM6tA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy1Q+A4W+kmNrpxDqRIuH2OYKeUXA9XFSXmm7VRvNewBikWP+pn
	Sc7F5RFtvo4Knu2kwL0S6So5Kezc0x0Pzzb/P73Sh71h8VkaEJmbxsFPaRKgjxlduH8=
X-Gm-Gg: ASbGncv/Kz0ix5yXC+4y9y4M5hjVo1tIBIox8eyKf5SGkSv03XXKS07FYSEhf77DrQN
	G0k65iP286qtN867A7p3Q73WkLuz09ixK/RqMMvI7UDaz1sIoj+/jogN7ugAUsA98vPwsLis5MD
	Kwd2j8s9GoU7w54UIXbj5sKUjaSJB3tcRf1aWTbqgGaPiZJm0aNBsDIhLMAf8h/FCgcs22zA34T
	3kaXmBmaQDvVMhfPg2Dpe9rQjG2SnNuc+VZV2vVGXRRcGMCSUcOAGwgP+CGh+zEUt19hdjWjsEY
	rQDrDZ3RO2eDBxk43Km624w6uhnl/o47+R+GJ1Dn7K+r9hZH7OGMqnMZVnjOdMRaqBse06QdIqN
	M1kry/IZR3kUzmGUj/s87vEE=
X-Google-Smtp-Source: AGHT+IFWuLSyNubOEP+haT1kxcJlsnbQvIZV9vTCdS/TLhc04cY3/upnJwzgMXGylHLDI8GWpEssXw==
X-Received: by 2002:a17:907:7f93:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b04b145f591mr1268961666b.9.1757497386292;
        Wed, 10 Sep 2025 02:43:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830bb83bsm136246666b.42.2025.09.10.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:43:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BC8215F82D;
	Wed, 10 Sep 2025 10:43:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 2/3] virtio-spi: Add virtio-spi.h
In-Reply-To: <20250828093451.2401448-3-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:50 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-3-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:43:04 +0100
Message-ID: <87qzwe63tj.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add virtio-spi.h header for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
