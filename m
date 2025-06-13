Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8921DE3C8
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780221; cv=none; b=eqwwjQysfpjeLKv/PNWHjXjHNLG4Abh6fzwvwGO7gm5O/AzTHVemNQ8eU8XXl8FjFoq62IrWRjNXyyiRZqsVAkixuHG+nfiqWXhKshKpMZR34aiM73jEq4VjhB79yT52jxA+xVIyVV0o96RRs7D9kUAzubv+RTo/K2vMtsjKrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780221; c=relaxed/simple;
	bh=DbJgbMC9kNuTQ0O9LP8iTiW8/nxoO2aXmMm7k2OBOeE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OlQjC9aDQHHbm5Tmw4zRH/IuLP/AqkTJFiM5Qa4/4h3pLfgPJqGYg/7l+uPS4huUFpRkaPm//6LeQx8U9alFojw/qruLtq/CiG0xY2JQ+s/dySfm0Ax6ma0wVUayF8XdqyaZf86Oj+9byyCpX/frenvwApC/LVlM5pWwrVABNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqTIDiEx; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqTIDiEx"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso1582996276.1
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 19:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749780218; x=1750385018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy/uhLM4uWfwEUS86OoGZrfU4y1O/okTHJ9nm0xWHjw=;
        b=VqTIDiExFrwv3WTZjCP8hEtaWBaemTgwncbjgmmaUQ9gJB60LcOfPto1bPNlgvobdF
         72kNC9k6ZyCIeg7QBqvJ6DQgH0iyrOvQgMJmr/Eyi+wBScWRKcFR5b2gsI0jfZrx4YOq
         YbzI67KZykoHz/p4RdEV7HE8wzW+pmDVkWz3guKk1fx5n0sIiAgVN3mtS7PvbMj1KIKx
         aDcsMD7tKhbR0YqE2K2dLZ1uzMmWgJVYHhjSIqivi1/EM6O8ocQx0BoN5iE3yIBiN3P0
         FkGxEEytjCIRHP18vABkdWxdrem34Cxq7G4MkwoQq2chrR/nG7CPnpf60JIvfChGvgHW
         Jn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749780218; x=1750385018;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wy/uhLM4uWfwEUS86OoGZrfU4y1O/okTHJ9nm0xWHjw=;
        b=HRDOyUC84wTq0dqYDnwfp/g2oLyeSTxxfua8uvEXLgsykY52wTqtgfi+B6YmG6aEVT
         s/5Jef9CwIfbJnmMfP4tQFizAlpHmD50aJgdnWOppeD56aBDndanLVYDmmzRcO0OhhmO
         Fvv4ZTVaobNRx3ytcrX7c7ntQLNt3L+3mZB5oi7ZcIxJqa8hl+DyW8JSTPjWfylu8kKM
         mkCZD5xwwuVRMaEa1e1R+tpA4mroYWtkNvGEWxJsjVMLG/N1L5V9kbMMKN+VawCjvO4L
         Eva4AwVhwoBf4Q1psbeBESZuSiId++gB1wWkWp9xJDgJgdetv8/TdwNpfE1s4VMhHC0V
         i/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXO+MabFvJh6qSSSudCoFVCVCodQ9gMTeNHFdXVcswDUstynw3sPDZxZMinzmUqrOacJCVKtU02Hk8C+gO+NA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4P3N9XcP6puTjoyq06Ad27c37CJ5sXgUZbM71gcaMIun/0JA9
	0ik9zqXJj6DOxprUU60ijVX+mvJbZzRHvu7iY3PxY2v0cDryZdvQ9mWI
X-Gm-Gg: ASbGncsVfGkdcQ999rocQCgaYT136TRQjIXPc2LvU+IURz3GE3v7kac8xayQ/+tqGDK
	+GVERYMDtQPw54RLrSY6wMwXQHvjBRJtA+1/XatFWuSGYtfTKrCGrNBeY8UpWqo7jlI6Fp6VjYt
	+Zl8jmdQu4w4JnEqbeY6G5rBplaMv1yRDrgWJYMy7+QNZ3r3uXmh/BN42vSA5KkrwTOnweY6ToD
	ve8fH5ttgWm1IYGagsAnPS1uqxdlp2Vs1/3d1Visqz2jkSfnkPG+1HosYiMRCOkPCnGG7IUOza7
	DiVN2UASZP2uPxeUrnK63Gdp9TqPm918uMLgOPU/DmBKC3vVstje8GqMsa7WjCHIpNfJj+A+MzK
	T5a6U5ABJZkvfn3eLztY3hVKBMrca91Aco546duP9fw==
X-Google-Smtp-Source: AGHT+IGhfFBS3ucnKhn/lux2ltNMn+fnATvgUPhFfUSkE0XmjQ2hZWkK9TSYAm0wp2Sp+W2K9B+1/A==
X-Received: by 2002:a05:6902:2210:b0:e81:9b3c:b79b with SMTP id 3f1490d57ef6-e821c34749emr1626258276.45.1749780217764;
        Thu, 12 Jun 2025 19:03:37 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e820e33cb6csm786872276.50.2025.06.12.19.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:03:37 -0700 (PDT)
Date: Thu, 12 Jun 2025 22:03:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 mst@redhat.com, 
 jasowang@redhat.com
Cc: eperezma@redhat.com, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 andrew+netdev@lunn.ch, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <684b86f8d9df9_dcc4529437@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250612083213.2704-1-jasowang@redhat.com>
References: <20250612083213.2704-1-jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/2] tun: remove unnecessary tun_xdp_hdr
 structure
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Wang wrote:
> With f95f0f95cfb7("net, xdp: Introduce xdp_init_buff utility routine"),
> buffer length could be stored as frame size so there's no need to have
> a dedicated tun_xdp_hdr structure. We can simply store virtio net
> header instead.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>
