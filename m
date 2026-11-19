Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118823;
	b=rkRJLaZ460/mEHJurP/G/bXAZlYhunaDUOju1bUal8NobIHb5PnCBkFyCpifZhIq+mt+
	 6B3qCaMvyYkPSq+DeCXwXpODKgyCXZr0AHq/gJrnpJMIlwZ0jreNtr/yFgGagBL9b065f
	 F5p7qwGRtRhc3dJJZwMbMkNIN4ALr6dqRICthLM8XMquqVk7pUDbLzicp1bI82ClVpq4R
	 Ay425s7ADnIS7HBhCp2lPOZplcSV8dX6HsoqFSGVniJWGmNN5w90yHUCCBCB8IL/vI0hR
	 Z2EXV8Xtiqzv+Q45HrUUNFoGi7xwM/guUBpA8EjvK2KCVpuI2sdXj3m2+0eoZ3ZjImA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JE65ESt/gGhAnJwqKYj0Id/abPPd8MJA3QlWIIkVZhs=;
	b=RZuj459m1To7TGZhJxJ1oQfY7YSVQJAoX8ztKFCvSRlwZgDeRxP+xouUAlj2OOBTYnBv
	 o30FbiZFBa+ESRNjnTH+dluQOSECuOt34wS3uE3yio4jNu6d4wch15o4zmF9FUv812K9/
	 rfYNHfmivqB5AOnlUoEMeENex3BGjoKY9adssVpLhto8mIyj5203EKvtkzFm68fBNFZTD
	 LkhCp93qXdXBEeJeJO7h8AQnd9p1uRoiJv7NIcEDnSf5Jv4ql+Qdaa96y+KLhYC7AIz53
	 jOWvQ6WWz6uicWtv7OnwUjDDRs3rM9BSpk6so8NJPdzSVZN0Dm934usoTAk0qWLb38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fw7xv3J1;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996B606A320
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 20:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B996B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fw7xv3J1
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-844a8bf7e25so110591a34.1
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795118822; x=1795723622; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JE65ESt/gGhAnJwqKYj0Id/abPPd8MJA3QlWIIkVZhs=;
        b=fw7xv3J1UM3MSLLXos5UUDjqRAS5uhv8lYmgv2bWveSacRV2I2CW29xWTRD3gUSvm3
         0yxGeIJDRdvP9BMN610Bj02QFbJVr5lbbeT5a0JejUPnfAvkoc1HTOwW68gETQ3JVgOa
         AAzHwtL6D5QgaYkO1FEiPQ6vVcPKl+MlVmpUK4aL7bBNMYKILzYTtAQ44Lb3/VIIhkEu
         XPaIZxInPLbYdTPJiFd2E9kE2X+r97p6/g2lRn4rG1u9cEOYgIBF71k965Ivp/Zy6jZg
         Q/SA0WcoaGe5z4FZ2LFqHW+n6AEtSci4IkzinUFOmWT6sGTGsT5/GefuxpA2HOoNK8n/
         KNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795118822; x=1795723622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JE65ESt/gGhAnJwqKYj0Id/abPPd8MJA3QlWIIkVZhs=;
        b=WNLir7xFjBLOlGNN1dtPUiptGdqguBhw1qba/xjkukbcDqNHc9oZKFxiNQotGj6MI4
         0EWAXb31Qcy5XTER0Hpl4n79Rpdn/mszH/xid638ttMpsqho1/Ud6BzzTRs1uJ/f3GzY
         3ne2o/PIiKWQg5ZUfCOIJQHkJNYwMBebEHnQuzbMergAS+w6cuKNoDjNV4MZDYkgRwly
         UBSZzGaHa4c4oS2Cxale8fhXY71Usg8qxzyAx3u/PZI0FntZAzXWGmZPUKZ3M8sfsC5N
         UwiKYe90YzgiebIM8dOiI8kfv2cAkq1WyC1vsU6tauiYWF+6Q0lpAAQUY57MXuBkGeJf
         BFCw==
X-Forwarded-Encrypted: i=1; AL+hErEqgF2J8sNDk8MdE1QBbby8a+gMYlcHiR7E3iB0qTLavuGQ89nr2w2EhbEYHpITfcEWpInCa1ebdQ5qS4N3Vg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9bpUnrFkYMAhIBkoiNZN0/4OoAohNacoCcRAGJw7KqyLvkYROx
	Dr3Aza5JEiFECjokpBfkIkPdBwGB5WlsUvKOJDUoDJO/8AUBaJeiy4A6
X-Gm-Gg: AYBFou1AXCjHURFINyk2c6d9cZ0Ka0FOwvt78NZvDZZpUQ8mtEXKUUai+fV1eu38Bzx
	apHPBYfVPxfKOcDPw3DRVH6/ZccH7nFcf7yoGJ1HDQFvB7kNCCbZ5bgvq2RmeC3HZ888ZoKZ6o2
	5Xey7RQl9/bRbJswzq514zDo/ZP5oIt6kn/1mpOLzoKxNbYwn7Id9y2R8QuSaPG2gPqRW8BT7OE
	r0frA8TAi04FOjwthgiKS483p6SVZIa/tYwiStS5tJcX1BpUyrgkSS+otwSJ6v0IgM/h38R8OkF
	MEsaZlx/1oYN/uWLyizB48em40lDdONcv1yUpJPfWLdL+lQ+K/UJQVt2bvhLZQmEH1/p44jXR6K
	IkslJ+OdoD6ofJZRt5vxZRr2RCxDUk4bPsfP87DuOgKOlpIcUHpYXfCRiVyX5Ty4JNC9nl43Rhl
	sydWj3RV3dMEwU36qWNB+dJgtSB2X7Zb7P7evokjOcuDNCt056sF2TOG6fnQpopZ6eUEYoedXpK
	MOgCMcmsukC8bX28Co31KAby0GzmNSSxx5qzkvrxhQAP7iv+HHsXphXICq9DjALj/6G94tQF4lo
	od95JEaCbK6FgSwWZ64jciE=
X-Received: by 2002:a05:6830:2303:b0:862:a48e:24df with SMTP id 46e09a7af769-86315946010mr1248188a34.15.1795118821640;
        Thu, 19 Nov 2026 12:07:01 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168bdba0sm476103a34.7.2026.11.19.12.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:07:01 -0800 (PST)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Kyle McMartin <jkkm@meta.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit DMA
Date: Thu, 19 Nov 2026 12:06:54 -0800
Message-ID: <20261119200654.1048266-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261109184253.531677-1-vlad.wing@gmail.com>
References: <20261109184253.531677-1-vlad.wing@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael, Jason,

Gentle ping on this one. Without it, the virtio-net function of the
DSC2-200 in OCI bare-metal hosts stops completing TX once the IOMMU
hands it IOVAs above 2^48. With iommu.forcedac=1, virtio_net hangs
in probe instead.

The patch still applies cleanly to current mainline (v7.4-rc3). If you
would rather have the quirk cover every virtio function under
subsystem 108e:1200 instead of only virtio-net, I can respin it that
way.

Thanks,
Vlad
