Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D47B191F94
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817865; cv=none; b=XOz9sf21ssyW1muuKmIdg44/vpAhwrouHsQLxNjZvhQuFrseLDUSDnpZLkPCrf2/4Xa3hSdN1odI0k+ONPQ67TMIcb9t0USKo8oNpxohOBeeUPwzS2Af0JEsCe1mCzWE2777C3rPql4WHhm3KtXcp4quG7WLWZMTzWe9a3DM7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817865; c=relaxed/simple;
	bh=KGTJ/FyRXR8JidJJnOWeIFkNrB7WqZ7CgklUiGF8c9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhdLm57DVK2w2AOruKrb54obJ7GCkAXqDgBD4jB+p9F5rzImihyvjta2ubadXIgv/avsu0xnBam1d1vCp2+qzQJfiHReyZjhEg9T8jP6/cchMFEaH6RkP8pfnlhxkNttoDU8KPO5quVuWCArQi7+S9WOHMd7myA7FoelaRPjMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0Hhf3nn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0Hhf3nn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caed617615so56331155ad.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 21:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817864; x=1786422664; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGTJ/FyRXR8JidJJnOWeIFkNrB7WqZ7CgklUiGF8c9c=;
        b=X0Hhf3nn1qHCKAtH7xUErUO74sHQEBdR3e2AsfJvR0zwNEuCFPTjRvBg0RhWHbMEBA
         APNoWeani/VhXcaTYRC5tCt/4BEruNS6i26jrBU7UeuTPJKpCTTUdoio554IvGzBog+7
         tgZdQaT5AGJ8yjHLHoTw5ohoV3+VB5/BhAWTma4d+50X+4KuJUg6fAi2Y8vP+OxMM9MF
         pS+L5oYbfC+QUdseJ4mqZwUQDAU1IHhmc/NPVK5xHcmHCSZ26bLmD4ZgcmTlgP0D8PDI
         Z0C5F6ETnjgetwoIeobJPg1hcU6c9gD8K2xcBV3IlxBz0/MBSOV10skqq6Lws8CHa6jJ
         Nrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817864; x=1786422664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KGTJ/FyRXR8JidJJnOWeIFkNrB7WqZ7CgklUiGF8c9c=;
        b=TtHa9Igm0ecTOoowjOazJ7dyryHa2qZYaQiOgM59wzCufpMr7bUNl9QPqpCLANogGu
         rAaIvja6tGpQfG2A98POew4Z74NtwPbIIdy/QSIi9mE4IZmZtBjpfS7vDeFPouU8w0dN
         ONKE61eZj+SPTO7b0JXznrJB7fmwFIErB3Rt78x5jtHtI/qGe5OH0ENmt+AJOPvy1exg
         pZnHQ38aIOto1a80v5izNEfNPPYqTXuWvRsvnjpmu6arra2YZaIPS3+Ru9vMw7A6Rkzt
         iyNTJ/NCOaurWjvTSD9gOelMZnrc9l/h/MaCil62NZa/4p+MJRTNj6Ix1oxyBjlhN+1m
         XA5g==
X-Forwarded-Encrypted: i=1; AHgh+RoiUwY4zMpjQQ0k+ef8vrWuPhhZtm7cRJcNFbvbg7kQmMYFby4ylRe1htMj8c+QpTy6rtFmF6bk4Vs3PJhqdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRROU5/fYDJGV959+BwB8f2JULcznoD5WjWWgpBkvOPhiC+mk8
	WqZMB0U6wBtcoGXG9ZOpOm2x1lETgpaCjETyLk56h415DJY0hQ2N0x/Lvac1E9hcCXA=
X-Gm-Gg: AR+sD13Cx1Bjz/BrnIA3wA5sFXQPV0CbkFNTigxYiX6eQjIHo9IefA2WH6XnziXZ6cy
	7YYC+D954PPGoDxLgcwizZiCXnGjmChKBYY+M0I6f+UmDvkjh3+j4fAosE8fjA4qjYCPKjGUbop
	+oEnuRqIG0krWD534VXV5vkUB9m5uMkeh/OlGabcgtwErBQbn0VYpmERu9zmd/IWzdt7i5sR9CR
	pHpuZp4xoEu7j/iHg84KAicxRympCw/B7foblW0adQQgFbFTbaiPPnLFreeahNkmrDHuX0TUaVn
	Rv4PaKWs15p08cYtN6+1xVMHKeNeiTfcFdHOtUqrfuGBPZh0JpSUhnjEV3gQrm8eXkUcr3kgUmP
	Gf8h6j66W8Na5rsA8T1XpGyey3vTdElpHhQnuyyOBN77d6ykUOkIkU4Aj3LfZLTFcL2+4n2uKFc
	Bi8UDnP6YEIAfdxVrjtuEA8dlXJKqpaIgmOT7gwq4GW89/AsR7stNLm/JKWV/KsM0=
X-Received: by 2002:a17:903:8c7:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2d05247217bmr123034885ad.43.1785817863428;
        Mon, 03 Aug 2026 21:31:03 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea21asm46196425ad.52.2026.08.03.21.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:31:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Tue,  4 Aug 2026 12:30:46 +0800
Message-Id: <20260804043046.6109-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803231911-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260803231911-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:19:30PM -0400, Michael S. Tsirkin wrote:
> pls do not post v2 as reply to v1. confuses tools. thanks!

Understood. Thanks for the reminder. I will resend the v2 patch set as a
new thread.
