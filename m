Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5542A9D
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065315; cv=none; b=gcTJUm0WiC5F+A7KYH2+aRBKoLkxaXgTXRt1XXsMs1TgfIPeK37jCyJZt/K312Rxyz17lR6k20rN2leHputaNCZWEDHMosvD/yhuOMcdnG1TwVzI2sccCMvf5eFB06b4BBHvCkeUdP62pscsD3K0FPF9HrI5xJcTtZc1SrxPf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065315; c=relaxed/simple;
	bh=b42JSvuywZe+7wglo+K7VO6xLJINq/9FZ8Q+hh/Syfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjIdm9ENY8cvXoV6T0Sed4wu8HhmhdgjTEEaXCGAt80JoGgquNfwQYzNHHxbY/4vLxrVHonSrO/3/oZP+eGgrdvlUe4ifHYihrWrH7ZWRMMcg8S/Lo/B4RYU/csJYvMpPakgDFavSw85ZIwMofeWbquz/YPtJ0b8N91wJ888/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmG2m9mn; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmG2m9mn"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE19060866
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 17:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2d7AIsVEVj5L for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 17:41:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b33; helo=mail-yb1-xb33.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 01D4360832
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01D4360832
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cmG2m9mn
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01D4360832
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 17:41:52 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-e03a63ec15eso4384471276.1
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721065311; x=1721670111; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEV5pedtY2Y2FeTPODdvM+/ZX+4nHrD94jMR2RlwhT4=;
        b=cmG2m9mnCKXVFAyNys7N0RkpKxVmmyfZ1kzdCBcOyL9HcR7SPuneqZVHHt2US+xrBH
         YCLwbD1D5Nhvsr/sxRgtimurCXOpkm+I1iIKr5TnKBA/jn5kcPXakAIl5VPAsGUZhgvf
         8s8ii40wqqkT1Alm+2DEb1FGTVFYqVQR/dNVeZc4HGvV/ZjgFVs/s/uumu1N7dtegoWA
         HqzP9i9cB8oxEvGhDsbyK/xnSr8NFqsBhZqJLdYtezh7Bij4jBaCXUnkYxuF0XtFvYqg
         5rveGHlmoPEKyikV+QZFqWNiHsc+9fQUh28C5Ye4S+VoOESJQ39YcW4D9ngFxnYQGo3W
         ismw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721065311; x=1721670111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEV5pedtY2Y2FeTPODdvM+/ZX+4nHrD94jMR2RlwhT4=;
        b=QPuV0u1ZFjdqGuWlUR6iDUueqeNTSHgvq6HlJYBIREmRckxyyVvhNxvsVqNajIIU8A
         oI+ek/UDWWPqZ0+nQQpnRWii3USvUvNf0n1qrJk1XcxNPIFw5jpRYCqxJOkAULux5O8v
         pkK3o2KJUsTQzj7KtxdXYHeoo/ECB4m94IgeIokDX/NOiLnLXSgOEt6QhcwYy9qNEoY8
         jhpZqYON1rLWyGTxp0afF3rPmChtXLdFSOmajGMZo8JZOP1peB70ciFGreZBqasQXpaD
         mzF3d1rzZWyDT+d2nXCFzUbR04Vc4I3PwjWpxUmkytWCAmvXTQj2qWmMCOYHi+HKR/bD
         9MZA==
X-Forwarded-Encrypted: i=1; AJvYcCWj29gpQIKllus3FoYQYH59uPTJAAhHJS2+OHDX+Y92L/hM+Ybs2S8xU9BokpqEXpk1zX7Il302+8UsvtTqjfDvHwcdlS+sG6Df+4MyezqLUveHqGpONp5PKg==
X-Gm-Message-State: AOJu0YzKYkhYI/F1mtMFBEzTy5/hJ73WWIW3UD66Usec7XZwi3yAqhAF
	9gT5Ypbr8x+wsJBGOG0qyqUxkPdf6Ac2ekAUmkFh1j4lDZc/oLHMQCu2Ghf8gfAtaKK33eThoOn
	3ttqHbX6LJUN6nOqCSRhpJ4Ln9fY=
X-Google-Smtp-Source: AGHT+IHIN6/eBpniYpqerz8db8xwfOTyovfSRjDMk7JvYfmegjzpFKzgDJtBVYAnhNHbomijkTgVUKTNkbIU54dFkr4=
X-Received: by 2002:a05:6902:702:b0:dca:c369:fac2 with SMTP id
 3f1490d57ef6-e05d3aae365mr381626276.3.1721065311277; Mon, 15 Jul 2024
 10:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-4-amery.hung@bytedance.com> <85d64656-d8ff-1133-175f-b12f4913fccf@salutedevices.com>
In-Reply-To: <85d64656-d8ff-1133-175f-b12f4913fccf@salutedevices.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 15 Jul 2024 10:41:40 -0700
Message-ID: <CAMB2axN5jJ_uabb-rd=wdcbX9DQYvENxQjK_7ZWhM60+5fVLKA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 03/14] af_vsock: support multi-transport datagrams
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
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com, 
	kernel <kernel@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 1:25=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi! Sorry, i was not in cc, so I'll reply in this way :)

Ope. I will copy you in the next version.

>
> +static const struct vsock_transport *
> +vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
> +{
> +       const struct vsock_transport *transport;
> +
> +       transport =3D vsock_connectible_lookup_transport(cid, flags);
> +       if (transport)
> +               return transport;
> +
> +       return transport_dgram_fallback;
> +}
> +
> ^^^
>
> I guess this must be under EXPORT_SYMBOL, because it is called from
> virtio_transport_common.c, so module build fails.
>
> Thanks

Right. I will fix it by exporting vsock_dgram_lookup_transport() in patch 7=
.

Thanks!
Amery
