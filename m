Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637405;
	b=1R+2g78WtVlroCyOj0fxDKdvom5WiW4mA2PfXhKhaCBRctYE/JxC0N0AN8RcC2z1ROhm
	 yAdUpxN34xn3djwKecQZldQ1AQkksV1acNW/jXVIs9q6Q5LlK7Lz0t30u5mYPESjowWdo
	 OYWV8sfjK/K6gZnDaWhGTE1qWZQCnd4+mdU/b3EelyPWwBsvgv/Zex09p95gIvzjOHyRK
	 dR461E81AVAfzmJypBWQ1edHdQ0dOUgHzm3JGKrsxTojFiCryvzXgeifU53oYRvn/kvxV
	 Xh3VsAgt2hwAbnZrQpv2RAEGSXKkwDqjebAwPeQoW5lBsoOnZZcID2PrXkUR722k80g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637405;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
	b=naRsWhtQWq1ZzkMgr4lL9w85kkc+k2kVkbzN6wToNzE+OpvZtt27w6nOltXMW9AZRNcf
	 ywdCJfKp36+9xg6AQ9kAkRYSwt3ZQIa6B0ZjhQhX4FSbrm/sDz03ls4hAnWZThpJLZbQ3
	 pSKd+eSxjUY8GC0JE0cDZ/dsj+bIpccBK0MzqsjH85xV/9NvmlgY0GrNm4XPN8kwm3LlT
	 ONxSL0uhjqDLPnn8H92xc38cdhw+MSe6BHNY3RpjbrUu046CG8rDTizBJKLOWx5vJ0341
	 1IvKs3zv87h5AZQoTl3QeH4LYZbD9eT3IMPI2ip4RYSpH0sBN2MAHy/RtUu1ThbD3Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frm8arju;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7960A18B2
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 16:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE7960A18B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=frm8arju
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793637404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
	b=frm8arjuxIQ8w9kQuc85X0daWm5KbPTmRZzFfXTIauO/zp/5mSckIR9PV6bGNoWotCLVNy
	hgAmnv14iBzXrzvWUuxOmNl50mv1WF4u53aoJcCCZ2CzM3ISfLnpZQve2UrOWzH7VOGcNt
	JDv32FQhyR7QaXybdiQ6MaMdxh3O4sQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-SD4xaE1mNCGgLOwjfVpiOQ-1; Mon, 02 Nov 2026 11:36:42 -0500
X-MC-Unique: SD4xaE1mNCGgLOwjfVpiOQ-1
X-Mimecast-MFC-AGG-ID: SD4xaE1mNCGgLOwjfVpiOQ_1793637401
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so33744925e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 08:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637400; x=1794242200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmxkjQHYZxu5Fni0akKQ9coEAC1dNmzFGp5ph6xLMkQ=;
        b=PKaAAhl6yL0GaDjFFfYUo8NEQzXdZEH0kJyzGjWHrKb6vhjdfbNK8ojzICo1w9KFts
         juxApNaQn446VdYR+YiELoiUI6FjXWod+tti3Qch1+wWXrQkzwlh/lMTmd1PzhN+R6My
         lHWtCdBpOKNoWsEmXWkvdZCkaPQQBkk/xJSJQSjiZX2gwNUk3P+RQIzmqwi8wNdV7U+m
         npp81NMeKL6BmmGFF0M2dIvgM4pL1sKqYtidZsboDFwW63suYVlfxm/bmp9zUKsBZBf6
         1RZ6WK4mCW9yqDxdr2hsBjsBll40IQaWDaiiQw4TMz9jDp8pR+c4agLWK0aHvYirSXVD
         4amA==
X-Forwarded-Encrypted: i=1; AKwUvBzVRm1yW9/wXoPkOh57/gMRBZLPexg4mkBVB6yV5D6lmpOjvyMum5hw0ddfU53lm+ozHMgMKAe50N2pfuVaFw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIFosgTFL9/JHdpmRtu5M1bKeiSLUohNuYKy6J2oVI09tmPgu4W
	WsXaOeAHC4eYjFPUS49Q9tBrwR4VdlXGhXCyA0pQzKzPXED+sfCCrBRS2EzMtBjE8PazsYEamnw
	p0CJ9XUWoRDBRpwm9CAlcFEbHrcq9ou+OL21xtiFCJ7g4cmLT4KaWZ0CK1cXrEzKlOuU1
X-Gm-Gg: AYBFou0Dipbz/FizrqQBa3stMY84zmuzV6q1wIM5tqs37kwPqDtuz51Ua69wiGXhROv
	IlQuJIuo4KXjqoTNpzChfFbegWOaNdRsoE3TTQa4kf+8Ik9g4Z6CP2Ld+OZEsePj9EnENEV7VL2
	m7iPsiAA0aZREh2vEn2gUh8tOFgLtsteigfi+WGxI3U6nn3EM8mLJcTpXo6ra0KX4MAhEdXjgHA
	p+ShuRO9GE6UvoMoXbEmziCMZv2nrSz6E7fCjJ7XgHRFgEfBtneqAhRflOSWN8zICrau5yAPOpf
	zEtxb1AIxXmaPSIIEabuy8v84n/nAPOAklgij6KkWl3ZbbYnD5pZ2uQNgAd5TRJg1YPHVY1mJ30
	ebqbKQRLYTRkGbxUfHfyyTGDCPsBGxRwsfhQwnh+5Eg==
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b0b9ff2129mr79309945e9.15.1793637400507;
        Mon, 02 Nov 2026 08:36:40 -0800 (PST)
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b0b9ff2129mr79309335e9.15.1793637399951;
        Mon, 02 Nov 2026 08:36:39 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm455824455e9.3.2026.11.02.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:36:39 -0800 (PST)
Date: Mon, 2 Nov 2026 11:36:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if destroying
 the QP fails
Message-ID: <20261102113629-mutt-send-email-mst@kernel.org>
References: <20261016035851.771496-1-oss.patchbox@gmail.com>
 <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
 <CAGG=RgB2NYmjugQrVOiKyfPF=_aU47CY_JXGmCLQ-kOe4Cxp0A@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAGG=RgB2NYmjugQrVOiKyfPF=_aU47CY_JXGmCLQ-kOe4Cxp0A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Phedyc9PB_7Ggu7NgwHFKiyrtqQcMU0_9LeULcjGkeQ_1793637401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2026 at 10:56:31PM -0400, Yuho Choi wrote:
> On Fri, 16 Oct 2026 at 12:01, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > This commit message is long and hard to read. Could you make it
> > shorter and more readable please?
> >
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Cc: stable@vger.kernel.org
> > Nothing against the change. But it does not deserve a fixes tag.
> >
> > > +             /* The QP still owns its buffers */
> > >               mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
> > While here, could you improve the error message please?
> > mlx5_vdpa_warn(..., "destroy %s qp 0x%x failed %s\n", vqp->fw ? "fw" : "sw");
> 
> Thanks for the review, Dragos. I'll send a v2 with a shorter commit
> message, the improved warning, and without the Fixes and stable tags.

didn't get a v2

