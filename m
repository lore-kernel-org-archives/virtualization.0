Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198A22B8D2
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714022; cv=none; b=aBA16l8IaWVOQMpilqiVnNXFCUM6g3W7nVsUJ0vTghRh6EYkgPe63SVs23EORas7WRriuUDiKMTkw2eDbi4f9XT0X3OLlyeFWjxqK+M2A8+TSMjyVYROvRzot8oYrjSbnjwoBdV8Q+fD27d9gbzmucLbF92k1QXp2AAxCKYF3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714022; c=relaxed/simple;
	bh=wThSVBwzmoJLTfHkfr41NVmaasgxmNoL/bVIkHKdo/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cKZp5En/d6sFuamxKiGlOsUi3YwWE+lzMwaz4Fu/2hxi7UO3EZyWJPPTGhiVj5p5BH7QjlPaTXAhhaYENtoFOuvv3KkSiEICUCMohplTz6LOnW/DPwJJd7YV/Dd6bvGxdTUOLTyyVIGCLHFgH+envGuXcHNXDIi5o80vorD2I10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqgn8BW+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqgn8BW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1KcuC1xrFnlcJ1MsHim/31AFnZb3C+RZr0o19KYuHuI=;
	b=bqgn8BW+r+Eqx5D6y/coF7qbXvAxn9gKwpWfQ+fBdk6sSq6DxWu6RJ7QDKKpcdRqdjQkyV
	1YjUHZU2YjWHHBk7vyrDg7zGKnxaRosh9MQo71l39Lo9JeCs7RrTm8ctRKL0FwrfuHkHJC
	p52B5ajqO9gBaWWnMb5Rhbs0tAJ28X8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-2Pt39GdTOnm6vltRchzIDg-1; Thu, 08 May 2025 10:20:18 -0400
X-MC-Unique: 2Pt39GdTOnm6vltRchzIDg-1
X-Mimecast-MFC-AGG-ID: 2Pt39GdTOnm6vltRchzIDg_1746714018
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acf00f500d2so81928066b.2
        for <virtualization@lists.linux.dev>; Thu, 08 May 2025 07:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714017; x=1747318817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KcuC1xrFnlcJ1MsHim/31AFnZb3C+RZr0o19KYuHuI=;
        b=WE7MWUhwh1iMd30+ocXzAbKDdc2+1v1dYtix6CcBpvrTtEDNPEZndiFca8zt//70j8
         0k0a/WxvetyL73WfrENhKkHRy8v92j7y4t3tFvz377T7/2SNL4nOEqRsFSj/PtxQeU3I
         mHAVieA8f4Cy3FAjaeL7GdJAh6vnrJ7U1on0vN/LARP/1DopsCKeFXxgO+6Dq+J9rjbe
         O3Lve0uueiYkPgdZHExKelXJh6MlwNF/lwbzTQ79lHHNwKjEPHm9niu6wwk3s00XRq91
         5CBWahmArA4aZUtdFEWOXqSlFI91pHsZF8gud1GSvbFxQPajrj3MHd5R3OCfwBvDQfGs
         CQJg==
X-Forwarded-Encrypted: i=1; AJvYcCV5XQGwOKcOOXgGemT9RM9PL9tU68qZ981iBGu5N6ye6fJ+29c19wyb46KSp34Y8JXP/pU7Ghk05H6k76Er2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGhgGohzqovXCKSr7DGB7xKEjZL75phRGMQWi1qtHEs3u8GDb5
	j43RRlYt9ogSpOuGPRoXCjYz52Ml3BL9Cv+ofUaAqB60oAj4XBQ9qrBy+cLi5r4FIxt5KrUCW5F
	U8rJDy4LocmS1SOPXbI+ZaoaiUjU9rJ/ZZUp4CCp/UOfxBNFRtRnl13cJbb6uuw2SabaRAc9m
X-Gm-Gg: ASbGnculj61cNVw3ATP0tJzGVluSJ3ZQdd/GCDu6rvUCWdz22yJrMP4WpxuK/qs9LIr
	WDL6lYSvERLQKKfez+wHo/Ez9bm1TYULyWPiloCL0k9AbPvPMdhRZRiB9UVPnKHLIB2zbUC8Ajv
	qsveADCrO2+AmSoHUwmQZpXEq0Zh09yzcWDyjsuZWtHvSWv/XFXSMwMlS/BFWLVjOsevwrHToZk
	cW6Eeg80T2OgJkD5KG6yjsV1Rrkcx8hLHWfKJHPZUYVMAXR/q9YnFXiobmWlamUDoLLS9974eO4
	+u+CrrhUlC3MCUZr9zLYVDM3Hw==
X-Received: by 2002:a17:906:a088:b0:ad2:e08:ea00 with SMTP id a640c23a62f3a-ad20e08f24bmr92964766b.9.1746714017405;
        Thu, 08 May 2025 07:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF/hUx02Zz2WoX+JCoxsMrV4CfxurR8vP/WKpaYlG35vY287928sPfk+pmToqAmT2lRFVVTA==
X-Received: by 2002:a17:906:a088:b0:ad2:e08:ea00 with SMTP id a640c23a62f3a-ad20e08f24bmr92961466b.9.1746714016846;
        Thu, 08 May 2025 07:20:16 -0700 (PDT)
Received: from localhost.localdomain ([193.207.221.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a1e60sm1089667366b.47.2025.05.08.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:20:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 0/2] vsock/test: improve sigpipe test reliability
Date: Thu,  8 May 2025 16:20:03 +0200
Message-ID: <20250508142005.135857-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4iI_P_X2hVoGECduyO5S4pRe8lmW8VXU7WlUa81SVB8_1746714018
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Running the tests continuously I noticed that sometimes the sigpipe
test would fail due to a race between the control message of the test
and the vsock transport messages.

While I was at it I also improved the test by checking the errno we
expect.

Stefano Garzarella (2):
  vsock/test: retry send() to avoid occasional failure in sigpipe test
  vsock/test: check also expected errno on sigpipe test

 tools/testing/vsock/vsock_test.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.49.0

