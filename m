Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7C40756E
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099253; cv=none; b=qKEW84GMlHI7mMUDnizDHfrtbGckj09he9O7PaZgK3fymJs4vO12NapsyScdAjyZ+ReCIoKhD4tPHGyFO2PFFAnjBMe3LJCP3nqSlofo1yqvs6ep+k/3vI5Wz8CuaKxly0O1KEYD87B9pRQmXVzUk8QCL/BkFbp/NBOScB181IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099253; c=relaxed/simple;
	bh=PVwIXQQ5/WGjpPJCRs7zgHzHTHu6X07EUwTtNa24yqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwtYFu/eeHwc5hJDG+R/BsG4NcsW55s3FCGvIWAoW9rXRYjh56cfv/eqVHdxtGcGdS4g5VCR2HKbqSPMVkIa7JGb23PDeKXRk/USPgcN4iBMjzzAzbFre76/YommueQpoKnMxTRoxVub0Q2o9nYs7zw4hBBFtwma2ZFLgn3DHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys2QZUX0; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys2QZUX0"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a7906f463dso608288a91.3
        for <virtualization@lists.linux.dev>; Sun, 04 Oct 2026 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791099244; x=1791704044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATqBSGgki2so7eu3mfXFJfLMGYQGWd86CLIs5RcaLgw=;
        b=Ys2QZUX0HYgAQL4YXJZBA05ip0njgerqZEyJcB6ns+KCHuAbl2wZxyHeXHwjnG0leI
         jeNtqBRzDE8jWr9C2UTfC9ENzq/pAfoL7nhIeTUXpJTln8ITOmRyV9EnZXc9Gx3wxCeQ
         v17zFs/0xvcyc0F4Yih/DIu1A6n94Z5cssiGAOnlg7sm7CkN3eum4JFglxnNJ2YQV/kz
         MY6HH+YBVrXCrxe2raxwVw1ItlvKCTENPZSQgllFvEqJep0o5XD/0a2sOX3pQw43888u
         67oMHbJWM8Jgo63/Lx6/vKT8hCbCpewHiEUr6759dD0ZuHEyEro64bzsogbN+HNMG4Hx
         HMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791099244; x=1791704044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATqBSGgki2so7eu3mfXFJfLMGYQGWd86CLIs5RcaLgw=;
        b=L/ldkA12CFUm//dAosxW9SD6cIGwMgWYPFbjMaiIjmN5hABl5Zs+BF85qppM/UpF32
         skK++ATU95304MtFXI/ge5I5SNZ1Lqo/zvNeIRGIYwlKG277KhyaMTguqXY8z4JiHbl1
         rBQYJ0edByW9OpOVPdRjOujPim0OTZ1SzEueyQgaJ9F5HkVCOjduTMaR5sHpO/GCRik3
         FgoMvfJWY3D7cMQhNipTwVXAISjkBOlYrBwCo8Vk+dKV7db9qL5t8DiNbStSULo4Dwso
         6g1h3fNnixOGz3zkdqLIonnhNat4xIfUvrwZqIFJJwvtkfTK8XoWdjO1TwDROp+qGrwS
         dRzw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ2zuY2mhg57QBuhp7+sZ7FH1tS6DVubv+Puq7WbQJSnV8vF0bn6KC/PzGCcUlKJvEO0/716Gl49A1mk4/lg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKGOkBN3xwXUvZEKF5ZfFS4zEXAenJQHJQ0e85oVL61If9eP6JY
	5VzQRtJ1p8i62HX4I+U5MpGrOb2S0yIUfGDcvaWMdZLD1t1974vZCrL5
X-Gm-Gg: AYBFou1PnTv1upWnuajUWRC6smoHWacjY4IuzI/0+a8TJXN5uV21KaBOYwPbu/HxaIO
	L87yB7z2SCUSGBjP4iRHLodlsQHW0PwK6UsvI8O6rsa7hm1zsHpIG81c1/zzWfKuabXNhCBEn4U
	1rcKoGtK+xJtrSqf8VHZnwGNN+WtPAHfjav4+jfNXxcUIMS0cA1o6/Vqcjm+6RB5BjS8ZBFEb9+
	bJRwvgBZ1kdWzp1pe7B+xhl6WELlZ8bzJsMGlsanLRDsfzcDVtEz1/j46L0z2mZ6h8XFI5tw4qA
	Htdqo2PwX+sdt6G9TR8fAXtcDw3xlpFrnjOs2/va+nYHJeiEMb3Wu1L5Aht3FAEwm+pVEGQFK8m
	YI4gKyL2u/Z9CTay1qSbkKNE1VLEogQoLb6LJyySvDj5uopBJ4aDT+ezMg0cIGEIJkhEHd9GF0U
	GOZ5UnBV3+yt0BzGZtFi98xZoyteAtvc5jUULwL7vUZmTwCLHhKPzhS+zDRT9MnP9NFKDea8j+2
	RpMIYv6iZY=
X-Received: by 2002:a17:90b:5310:b0:3a7:b2d4:e411 with SMTP id 98e67ed59e1d1-3a7b2d4e54cmr2200992a91.21.1791099244227;
        Sun, 04 Oct 2026 00:34:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4f3911sm5749884a91.15.2026.10.04.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 00:34:03 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
Date: Sun,  4 Oct 2026 16:33:35 +0900
Message-ID: <20261004073341.4034680-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179108986364.434549.5339286904514687491@kernel.org>
References: <20260930044147.3818241-1-4ncienth@gmail.com> <179108986364.434549.5339286904514687491@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both findings are valid.  V2 validates hdr->len before allocation and sizes
the skb from the declared payload, which also avoids the 32-bit addition
overflow.  I am posting it as a separate thread per netdev policy.  Thank you
for the review.

pw-bot: cr
