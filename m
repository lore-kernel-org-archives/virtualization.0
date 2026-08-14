Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8B46AA8C
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708601; cv=none; b=VRlQ0rnDX3EXyokKArcm7epL50hJOgvF2StOrsHb7tcL6lhxSZHYO0sJhcO/d2CjJNMA3Bj3pmYX8/gNUYsFsex1AWAlD1D+3Go7o7HYIekQSMhYe73VqvggsFlP3xfBb8AogOL71KFy/A5r8ykjrWPd1xM05EGvWyCCc2hPS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708601; c=relaxed/simple;
	bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNW4zFKgUgV1B/IZgCMR+SfPBAGxRdPNwP3xKKvor5TXLHYaZ0q3XfXHssHJ50mochH/4fzdi7kSi0YCXe7QWWss5NqUkdV28dzhaw0jct8yYysboVbtiu4FPKMA9+bFjLVqsEO4svDRmz407ldZ+v5V1SH4iPZnnA+II+k0xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu7sf53n; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu7sf53n"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so749158b3a.1
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708600; x=1787313400; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
        b=Fu7sf53ny5pxUFKQYZoUurRhQ7o/arTOyf2HmmmFFwRpnUlzL67T+9QxgYaeMCyEy1
         ra7mqZmeSk2zHRBlOCZVjfeKybmMgyBHbsi/LM9ossQs/CI0wm+2W+cbwinLQ/hRLt3A
         xnFP+2ea2+Q3EFELRzYfUhODgSvJJMBHoxX3lvPo5MQJl1ZUqGCarn/r7u25v+fIbGMd
         XgrxerHGV/kZk9IxBFAu9kuSfl6Atksyj8vs39pPni4t6JxljVitQvlbTnwXVPSb2wzw
         H0rRjQgnMFrRE1LQQeaG7MM81qf1JY2dO8ZeNDZDcougkLMp4T743Vcfubm8Dur194Pv
         zEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708600; x=1787313400;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
        b=FnG7jk0JbQwKx4oWtufbjtmvO0Pgae0ksizDPTL1sBVy2q5uhfMChwtWr3dU2OKHlH
         5bBWi7QB/M8mGegr8h2Kes3NOEHl0jE5tjf3SBxVTAylh5CtGt9dCvLIjHsVHrrAiCcv
         SCA0ACwnKsygxWaKmfyoEdK/QLS0S5kp/YxfsTEOcrvJWI6laK7IKvoQv+AUWzphJO0M
         tDxK2HJqh/RkVcJUO/DGzu2+gqcmgqO2LXfYFZVSd+PrkVRy919PAsrJ896LL6xmDAF+
         AM33Kot0VtafWL+9VWAJzuepI2FmuNH9cALQh1Dd4N4WKWtcI3Osk41GfZ5SIKU97Ya2
         hjxw==
X-Forwarded-Encrypted: i=1; AHgh+RpMBi1TXGuQLwDr4DDHUhM2ysZIQX4VVwiPON4lH7x0BsZZy8K//dSaa1hjZfGCPMjSuAx7A4PQtV5Xx7HKyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yylr7HLiz3w4a+paoaigsnMi4FPlKY8L5TV8o3kG9oQGY/AUbIe
	QBFfSu3nylkniQ7liPhU4gSQ8m//oIPIfKn7oRAt3X5eCHIIBpeFZ8b2
X-Gm-Gg: AR+sD11NzyUopP0NPKL88KfPRnoBE4hJVxUCwzLLqUU+lMB5r1yO5l/SWXNgMCEnY5a
	5woEWiw8bR9u+MOklCsJ420mabz/LrrGTRtvp+FKOmIUmJQuBdVuwqTNwxdxQQePzB7jhO7l6Df
	KvUTFnEXBWoGQz1xHeLLiog1JV8seS2gCCCQ0/kmYFjasn+BGR8RRsdgsn7DM/hQUWBSWeuqEgL
	OGWZUt6/uzXt+mcYpatE5Hpk0CgmzjVmO/wZOlKPNsMYLfFlj3RnT/T8U/RUXeNkIQRVPyB67ju
	oElSgEZwpNf7QNlSF0hsvSA9I2IAnIc7SCkm1nYBdsICv4CYaO6fWrNs6zc7UD1pBXO3JXNb0Fy
	/x/GDFFC8qToBnCK6YLW23sQZW4Faetryt0/BWoU2r2Vf0MRG/WihHIPwVzQVkW90FflNpTRmgV
	9l1z+DWnWj1Oz41a7iyftpc/ENHbhllBoWYLtWn9bl00Rk84108EkUGgO6B7Ty
X-Received: by 2002:a05:6a00:b48:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84fde41c7a4mr5213758b3a.31.1786708599236;
        Fri, 14 Aug 2026 04:56:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm366669b3a.11.2026.08.14.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:56:38 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: Jia Jia <physicalmtea@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 19:56:12 +0800
Message-Id: <20260814115612.127842-2-physicalmtea@gmail.com>
In-Reply-To: <an7KyotZ5vZOURu2@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com> <20260814072903.124991-4-physicalmtea@gmail.com> <an7KyotZ5vZOURu2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Will we do the same in vhost-net? If yes, all the callers will call
> vhost_init_device_iotlb() with dev.iotlb NULL, so should we remove
> that behaviour and add the check we are adding here inside the
> vhost_init_device_iotlb()?
>
> Or there is an use case where vhost_init_device_iotlb() is called with
> an already initialized dev.iotlb ?

I will check whether there is any valid use case for calling
vhost_init_device_iotlb() with an already initialized dev->iotlb. If
there is no such use case, I will move the check into
vhost_init_device_iotlb() and apply the same change to vhost-net as
well.

Thanks,
Jia
