Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DE3C9EF3
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153105; cv=none; b=R3NuUBXNRKsaZUM40hCX3SW0v23gh+7ceQKhZbL1p8H8n1CAo26bJ/HWbcDBm+X8e57hs1En1Z0ZRLculpNkkF/IpNRSS7Sp5Ti2dr+92cpzErJKeMS6dWmB0FpwOz+ghyhqLKOH5a2g2WZsi8uZ+yvNf+sCxCvmnOVSwMX1Veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153105; c=relaxed/simple;
	bh=l5YEmWYK8/Y3ph5NALenxmFaM+rW0GWkK6+CQ1OOri4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLOnlIGSNqk1IyvmI8Xwx+JJqWc/JosshyJa6PYQZeEv/mRFWtiu4f57AYAhuxTt9Q7bRAHE2oplmbjaTBNBbjy1DQDxbeyqrUZBB1k2BysiZwF6B4qmqVWTwCGTBrJ1IspUiFBb+FPeSWaUh4qqRU9ngW2MWQUdFQ7/IUJvdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqK8ZHiH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqK8ZHiH"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-364f7c42c62so539248a91.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778153104; x=1778757904; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5YEmWYK8/Y3ph5NALenxmFaM+rW0GWkK6+CQ1OOri4=;
        b=nqK8ZHiHVzYo3tLWXpFtCAV1DbPaMMuY91GbIevVLBhQs3htGLA8wtMLWMSrntLOHx
         pYHzA6aF0TeDuwbSd6SYLEEE9H4swlabW8AKwBBcM8CCcPWmeQEaBM9vD/YJVr6nhfx4
         HrDsfg/OB2l9b1Q1tyJ92BCaKu3wONONiM+renPd6QUC1EFksJOts3i/Qh71zabhgNEP
         XCh/aXLSZGBKu9xcZkUnCOqxLczGDqs1hxmANFS7dXNuzZ0CS9mSHXQrNHX+5fJttKdo
         76fcwKtFTR0rWfEWMbN/1aHeutyfESbl5myaoBJeRfxHIaDEC8k7ed6MyI81SLqe6r2v
         d6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778153104; x=1778757904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5YEmWYK8/Y3ph5NALenxmFaM+rW0GWkK6+CQ1OOri4=;
        b=oPzOd6iup/z43ngzuoqpPA1WkjvaElzCL/GE0sqDHLJKD637fYsepi1/lO44lIFMba
         /BobqlkJUfNY85uHIfEA/rBAb06KtJYbuvbCusnXwefH859pii6l8skbmsG/+HX09+yh
         82DbFrmYvhr+TD3CvCFnj+CBCiiRmjQKpQhR66GHlc2yfQt4s5p8CbRNdX3XAN9edhny
         YbVLW9uDm4JX0D5NDz9tZtcS2lXZ+GEJCIrXRKZaAn+9gGqce/Fn5m/PJy+uAYidvdSF
         R+9eS/BQWjlIQKrSQ8M2svkiEaiHbArDjZ2GNSdxPmUa+s3WaAOi7PbszAJanp04td7P
         aLKA==
X-Gm-Message-State: AOJu0YyH9g+Enz+OEd11O0Ejn2r081QMiL1gCk2MNYIPUe+M1FBgdr+E
	CLgwenupYjRw9pfHD2vinaoq98NzNYstQm8/t8cMf3dlSW+lJ/5Vft2s
X-Gm-Gg: AeBDieuAG9mOPvUt9xk58rnt/jzwyQF0w4KKJ/iWsN5f6zRNCV2249CKk4kn/Y0isTI
	xZUUI9vEogPGhZ4LwMUMq6PDCdUQBrgU+BgQbvrJlTfh9vitFVirQBP3RGE0Bn24FvM2Fy4opKc
	x66WXeMwzyT9Fqt7fHtd2h3c7jvpzCIdoE+CBzOOq74J1AnX7AxHgK0Z41OW5sclgawHB9E7bIE
	UDJ8LjjrjV9AVEIkmMbLl911GY99qCd0YN9DGoeDetuyinhv41sSbpiEdXzRpRtz30ouTJqQPjN
	bHbXoPimsMLhSTNBMFmAq5d2qpjcF4RWTtHXmYmRLERYM7ooTvBssG37Ut6TXS8EU2qIqux0MV1
	JJPEY3mVp52JpV6YdlU3TphKlllLsLf0ylChNUHBMMf2VcOnD6tvK8NkUyIs29vQ4BU1MJDLs11
	Op7FzrkoxtlqxLuWs+R1XkjJ+2frGyY9RLdERXedAwPy+6aA==
X-Received: by 2002:a17:90a:d003:b0:366:173c:9a94 with SMTP id 98e67ed59e1d1-366173c9ea1mr1540715a91.14.1778153103518;
        Thu, 07 May 2026 04:25:03 -0700 (PDT)
Received: from gmail.com ([114.249.134.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4bc7558sm5844469a91.2.2026.05.07.04.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:25:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@kernel.org>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH v3] virtio: rtc: tear down old virtqueues before restore
Date: Thu,  7 May 2026 19:24:58 +0800
Message-Id: <20260507112458.3674326-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425130233-mutt-send-email-mst@kernel.org>
References: <20260425160906.677660-1-physicalmtea@gmail.com> <20260425130233-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael, Peter,

Gentle ping on this one.

I checked linux-next and mst's vhost tree today and still do not see it
there. Since v3 already has Peter's Reviewed-by and there were no further
technical comments, should I resend it or can it be queued as-is?

Thanks,
Jia Jia
