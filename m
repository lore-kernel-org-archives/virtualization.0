Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770D2F83B4
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211141; cv=none; b=a2ewvjRb+WdgYVDpa1tJ4W0fUhbxNTkL8WUKACLpAr+dPqieBjXzoaOL5QADHYmo8VD7dr+vHzxDAiuSiQtOdB/IYdjG8P8z6hCgAQUtUEbK4OR0rOzU14lrEUmJbUiBo/evrqWHcvfkHGDCVhBPEmQaqUJTj8P8aVSlfN4sVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211141; c=relaxed/simple;
	bh=BnbygAsl8Dx4wWRa3lp7WuWFbtimSRJj/t9AgFbug00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqn095HdQdEn0E2Nj275LtOYuTo5Pk5ctcJbdY8RbwihU4ftFyQCfsEpjvhrXA2Tece5rG8RiXGpiCQR3GaoF67m5E3xmOGt1FT2yCk1J7yzSI4JUAOBegSvWms4g7qfvGKPLRUJHiiY1CV6AklhX8AAhdz6hDTm+SqvKC4dQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7/y8kzq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7/y8kzq"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b2400dcc55eso46960466b.0
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758211138; x=1758815938; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnbygAsl8Dx4wWRa3lp7WuWFbtimSRJj/t9AgFbug00=;
        b=N7/y8kzqdpE1HgtRLFdJw6Ks1kqgGvtivn5mnyNVhracyHQHvU5oX3sssj8DmVXgyJ
         0BQuOJJy8fgKCn36RZBBLTS4nV7LD6sv0zYUcUv+/AxztL4J1CQyFuhtO3yOBpx9vLI7
         bUC28Uvrtyb7EVH2pcZMvFCAwzPI4Kp9U83KiH2/hGLOedfHQcPkGoOYXxMagzj0PP/p
         KXnqqYcoKoae+nZru6ao56pEug5OjJpNKyqh/wNNCfRyBbQwVbigNhCl2xgRRAgTNDSv
         qebRrxFWQEG49bT7D3qUH2WLPYfAowZA4pNzKQiP3I4yDQyBmdn6/guiy6Ci0GbmHIrb
         e8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211138; x=1758815938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnbygAsl8Dx4wWRa3lp7WuWFbtimSRJj/t9AgFbug00=;
        b=mIHwTibFfLVhzxnaQOYNVtYJltwyyzVvnJ4GOfqKbuKHQ+SlMUTzVh0t8NMiFJ2+Ia
         ERgLcw/yb29UowDOVjvlU1ErS5bmZsZNWytOuBm55Mn82vve4lq5beefW3UPKIO0mlhp
         T5RBFdu6XRje+7bYlL/7jfKaz383mQHL5ZINFjrZfEQhonIaxL6YIHDQ9N1ABagg2pvK
         nJprQ1w4/62ivn1tgo3ZjiLx9w/TL+674EGRqTzJ7wqMnKojtFxdX4s/HPV09/sMxTs5
         iJtlQpNgTQlpEVGLEhO0HNBFm0e6wWlCvNRJGnyE7fU9ybfUghegcox8tzpFe17bdRTB
         1Z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbkQzy6pa9Ee/LXPlCivJLqSyOWB374j/RxVYGa0xj0EdNzG3bv3RL2tT0qs6kqXEoI8tFQDQSDTf3e/uAqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9GCN4Xk1lRYfPjWzJjMZthJASK2mqSaR6uFq4pB0xmb7Pl6vQ
	3TqShnXPreoNhKDu839dk1uvjTq7N3BnfuqY4Hge3LPvS+etCpbZblUc
X-Gm-Gg: ASbGnctGuCjOj1kQc6NQbw3ARoWTv4nZIeOPV8TV7IEWg13i8WpF/qOzx5Q8oWTsybR
	0ud8RNBRTKueGmR+evadXqrNobU99nDMuXaagoFq0e2NSnlJLGW2CbtVmvfNq2ag0y5++civ2PT
	yHD0Dsju/+UprRHMKH2GNLnuCdlnZpv+lilVmFO5KgZ7fWjS/FGPOEFxoQ+iDPQAWbPBc4ZddLi
	ftfKb4i8zRO2nGy6RcRpmIQ6dM1LfviojFXmfVxTKq6QJ1ZCCp7quXjMG+SHkt61EbJschL8Q1k
	5tVxfASvmlWXKyc0hGXf7BMY/PO7o/yART5B9+aoCEuhvVtmX2tPuBPVrOLTbOGo1CJFsB2/sWH
	SxTvkAqgUBeMkBK/ofUJNtyn52Lf7zUGoTNB8MA+1gn1F1gjwYs3pZyJJGZGKRDfPI9Uo
X-Google-Smtp-Source: AGHT+IEamsg+VBhCg1Lnmf79ffLdz+G7xL4OSv0lxnsoJ8h5Ioo+r205TSmpJSHOPFxqKmgywIfMwg==
X-Received: by 2002:a17:906:6a1f:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b1bb086959emr787373866b.12.1758211137544;
        Thu, 18 Sep 2025 08:58:57 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f4390csm216682466b.10.2025.09.18.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:58:56 -0700 (PDT)
Message-ID: <5a9aa16aafbcd8235a70f25249b94de6a897fc14.camel@gmail.com>
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: stable@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>, Amit
 Shah	 <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev
Date: Thu, 18 Sep 2025 17:58:55 +0200
In-Reply-To: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> Hi,
>=20
> I would like to request backporting 5326ab737a47 ("virtio_console: fix
> order of fields cols and rows") to all LTS kernels.
>=20
> I'm working on QEMU patches that add virtio console size support.
> Without the fix, rows and columns will be swapped.
>=20
> As far as I know, there are no device implementations that use the
> wrong order and would by broken by the fix.
>=20
> Note: A previous version [1] of the patch contained "Cc: stable" and
> "Fixes:" tags, but they seem to have been accidentally left out from
> the final version.
>=20
> [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.=
com/
>=20
> Thanks,
> Filip Hejsek

Sorry, that patch might actually end up being reverted, so please wait
until this clears up. We are still debating whether the Linux
implementation or the spec should be changed.

Best regards,
Filip Hejsek
