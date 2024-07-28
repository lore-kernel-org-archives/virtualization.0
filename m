Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10979B96
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722204633; cv=none; b=JoSg/+Xqrfn/N3Z7OnwvIeDX0JWyKPRgT2X03ihFy40I+LIzB95SZ6jo/Yv5N7d29SLqpZKolYBxrGGAlslYDssOxP3nAW2Rx+WJOpEblXPeCXq9JKN5syb1+oIPQTpDgrV12xPwbCr+P/rCPUN7++0bE2ew2aXvUHcUEsG04JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722204633; c=relaxed/simple;
	bh=C0yaa1HeosGSTqketDfd4qkVnRf7BT0xSouoh4lDdU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NggjtKC/NwUBdEb6DEjOKwLSssKAz/uF9loer0YzY4XWdwLrkC/ox1UxQ6aFeAkJRDLDomCi5pqvWrauXyE4o4WcoCA9AqXdgBsStqIZMT0IW4sC3Bz37frj32khAHBA2ACurfyCYFPBl/UIS68WHiRhE61dlz8SOkKN9OWV4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdbeeLoI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdbeeLoI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0136402DD
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 22:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lc8WtJB8sRFI for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jul 2024 22:10:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CEDE0402DB
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEDE0402DB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IdbeeLoI
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEDE0402DB
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 22:10:30 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3daf0e73a5bso1993824b6e.0
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722204629; x=1722809429; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WFV5A19fkh+7kPhwlaDnoT0oehdraQfB5oPegY2HlQ=;
        b=IdbeeLoI7MfCYXaGP5HoVs0usTPLQEKZydgSoK+nuYK85TYJunI2UF0fS5+iIWrjJl
         qZOiGUFLJYBMJSavCsNSRRWtdyN+PPa+ehtOyEAVRE6vpuueIlCGdSiiSgmJosfVRZ3f
         uzPftOYcoq06XdO/1ra0UNgmYX95tzf1BsxbLkrQQbxFn+h/ZzUpKJtS3KnaBHMy20n7
         EtslX1OfO0PlpycpUqXh1ON5sLjtjyjSzaKzLqUzJFxreGBK8jilsriH2otbgKbbwzg+
         sGzaeoXwSNd8ATmJvcgkWzS0zeRciyippDup0zD2H5avIxZE17vNco2Y4YuxnEOg6FVJ
         Ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722204629; x=1722809429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WFV5A19fkh+7kPhwlaDnoT0oehdraQfB5oPegY2HlQ=;
        b=Mq/z+9AdYOvb7/XOFfZPniBXSHq/IapPZy1FszaMLkR6cJuZ5e3y+V3mwU6oh8of0D
         gtYgtSbpcLDxyPZowIxU4Fma69i649aVJxDcTV5lK0vsyO+Hyj47JoWUCe5odK7XxbYA
         TkiaEayH/+ZevQwmv/T8+I1Ilecvk8fK5oDb3Q+/XiT36GDTccc646NCYKYeTvOA/zNb
         E+kBTuX1iCbRkrq4xxgYMeH+otGNz/5lYl9BbtVBX5RIP0gWCi3asT9g7sWQQDrGETme
         B0PsLfP3PCk+Sl4FoxQO81sZ+zgR6ysBCTdMM9szu2JzELblNRfUxWuLr9TZmh+CMf03
         tq3w==
X-Forwarded-Encrypted: i=1; AJvYcCX2DclSBuFMghQmdSKDKM18v5kMWodEeIOmuPeIDD76ROuiAIbuF3tgH7BvEQRW+qH+1MReW8nY/YOmGBL2w2q1HGjebWwRyFvkgYyVgh0Jd2w870EW5thq6g==
X-Gm-Message-State: AOJu0YyTnzvAupPQCwIntF3YL+yWmpSE+lAD41+yzGRc6jScoPLZgi9L
	t3a3jaZYzpKs0CeQjKdrEswlrHPUQIXphoPM+uVtl3T+QYdMqhzqBJOjC/cqYvbrmpZEqrop1OC
	q/tElP1HL3FPqbXvoR6sQShRdLWQ=
X-Google-Smtp-Source: AGHT+IEw3+98/dkX5bsc3y2qs7kudwyMQ2dCtR9MHudb1vAPFedzvStonePBepA4fNU+r5zlDt7zwcHjsI0akqPOZ5U=
X-Received: by 2002:a05:6870:169c:b0:261:52d:1aef with SMTP id
 586e51a60fabf-267d4f5b2f5mr8312222fac.49.1722204629420; Sun, 28 Jul 2024
 15:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-3-amery.hung@bytedance.com> <8d7dc8cb-0211-8e20-2391-c16d266b8be6@salutedevices.com>
In-Reply-To: <8d7dc8cb-0211-8e20-2391-c16d266b8be6@salutedevices.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 28 Jul 2024 15:10:18 -0700
Message-ID: <CAMB2axPA6hEHJ_xm-aperc3kb221kK4RpL848pgY_sL+8RBFHA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/14] af_vsock: refactor transport lookup code
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, 
	bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:41=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi
>
> +static const struct vsock_transport *
> +vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
>                                                       ^^^ may be just 'u8=
' ?
> +{
> +       const struct vsock_transport *transport;
>                                        ^^^ do we really need this variabl=
e now?
>                                        May be shorter like:
>                                        if (A)
>                                            return transport_local;
>                                        else if (B)
>                                            return transport_g2h;
>                                        else
>                                            return transport_h2g;

Looks good to me. Will change it in the next version.

Thanks,
Amery

> +
> +       if (vsock_use_local_transport(cid))
> +               transport =3D transport_local;
> +       else if (cid <=3D VMADDR_CID_HOST || !transport_h2g ||
> +                (flags & VMADDR_FLAG_TO_HOST))
> +               transport =3D transport_g2h;
> +       else
> +               transport =3D transport_h2g;
> +
> +       return transport;
> +}
> +
>
> Thanks
