Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F0193064
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383890; cv=none; b=AG3HaiRHOMbh0Z60E5nraeHG/eIhWutLmon/MeKxM308abE+e3DUVo1eIKsLmlldqm4yC6uPSGKK5TggrGnhk1tw2AMOHg2IJep6lyXNVUqxghBMpjNB3zIztEF+T5ulsaDuTOaW8nki2K4xlclMEXnYAPpCKOtmR1ct2cu7JRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383890; c=relaxed/simple;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi2Omd1Q+YHb6XTxe6ZPvE052DLBnguknCJd9R4mIzQY0Ub+wFpgxWT+Dls1mGGUOTg2sdd2WLtlpwF39Kn5JkELwqNhFdJzxGmCcJapP0R3UKo9Y8fkQ2Bt+iDVcWwIvwpsj8I+H9fas5/V87S/uKHRGcK/o7ru/8qWFRQ/Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHaidylg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHaidylg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	b=eHaidylgv+DotOSaDLvT9TEjVOqCChpM7kzwxY9jt5HVWbqGMeSCpjTRRc7754L2LGzmr0
	S00dwI+rgjj193W5raNP4S85N3HwUGdFKwyPsumk/8TSwxbNHMyo0CDoghojAhdUSi4MYK
	K4KRZU8Dp/A2KnsrUCZLdzK+t+fJYIA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-oFniFKWsMJ2T7ifm906QPA-1; Thu, 05 Dec 2024 02:31:26 -0500
X-MC-Unique: oFniFKWsMJ2T7ifm906QPA-1
X-Mimecast-MFC-AGG-ID: oFniFKWsMJ2T7ifm906QPA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee9e92a577so645388a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 23:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383885; x=1733988685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
        b=IWXnA9ZQj03f64j5XBxlf55FUOQn9ZuLDHAr2fg8kO8ZFjr/31Rr7CHx4GQqiQm7jy
         1ah0BL7aCxtdhdB7MG9qVyZ9fFHymDsgN9GicDj61QhlFtiRMzDcDy21h4JWLkR5zf99
         UYgDarakYTYabKl/2QE1wYSpYRXrPpue3imE+x4moz/xnOS8y4uEDTt9WAKn1TwMlCSm
         r28JZg2xtCj3zW78WY5vZpqoQXMkFtQK00y5U2hXUQpj6W36ICkVNzWMx1Vf85oIwKa3
         3YZZgxWbi1xANEcaPilOOsTH23adSoBwfqzOuerq6z/eilsc1ePGm2ocRX9zqPpdVZ7y
         yrSA==
X-Gm-Message-State: AOJu0Ywkt4Sao0V0hTgMjuc0cWuOndkYwD5SJNQbXKyhaG4/wWILL0R+
	E0nLyekHRpxa2/cAQgdX9EefyA4bfF/AUud15fFH8YGgsuNTAvdUQ236qG2+bHNWhqS2x+ul6ea
	pi9DX3tN5rnKbmYHKvSwK2z5EMuu2tsEIXj/GUaGWG2gIghbIzHD85BY5cA6knOLk4rJ0phbkRw
	CS1MsLX60Xt8TdMkRhK2OqEL1qAULnhnI8kolvNh0=
X-Gm-Gg: ASbGncsSP+b3dRC4HayIxPxWB/5AonHMjinfIf8PArHXtKfmtAn7hbe4DbmaGSd+rV5
	SwZeZ7UWmA5j/GMzcECzQHqnEN/+UTvRsmH8u
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id 98e67ed59e1d1-2ef41c99386mr3511951a91.18.1733383885274;
        Wed, 04 Dec 2024 23:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Uz6s1s92mheWZ482J+Pms58UfnRdPDzgkeV+DuxdzrY+WXQ6wsaWOBD+r2THsCYKuaICd9UQwkstxAvMEhs=
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id
 98e67ed59e1d1-2ef41c99386mr3511918a91.18.1733383884870; Wed, 04 Dec 2024
 23:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-4-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:13 +0800
Message-ID: <CACGkMEsmAtguhDbYbgzs0f_ynsDy2UwYR3jun+J_OQQwuXGWSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce virtnet_sq_free_unused_buf_done()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YSEjOTwwrcZJgCZ_fSzuNW-8kzOoEf1jvgKjocX8-yY_1733383885
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> This will be used in the following commits, to ensure DQL reset occurs
> iff. all unused buffers are actually recycled.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

