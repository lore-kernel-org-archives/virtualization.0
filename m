Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DA29B8DC
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124516; cv=none; b=HuIoiHc/29fHCd1BKvR3sbVbhePvnrA7mGUcAq4NhjXA0RoMGRzeFUZBkdLSGEcaZrt5zPitaHk/mcBsC3dk+MEDpTdboCbX0RaspHbxGKjzfffbw76BzYAuQgm9SNLSAVOOZ0xEZJeYEpHBJ4v3o5RPAufrbYOgmEyl42vVh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124516; c=relaxed/simple;
	bh=fk4qbcimRIVrb/YTG3/0Q28P2xDHbRO2d0TV3Hpr9nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2sqWkgOj3xnFkEQuRmS0O1iha9l4IHneoKYV/lkS5JTY0gR4wFcIo7NRvuiKcInwz0+ExrJWnlRgItgN2QtPkP+r16CrwLLf29NacJxS2hb23Rh6D8dxXDFz6PrqTIhvLpL6UWI51QKlbpSJE+FLOnXrSX3QGYgOqNx8Q0V93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyNsbwHT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyNsbwHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759124513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kslRQf6+HX/+lCOPEQ+nRCdpHTGfTTmG8vjQfJ7ses=;
	b=CyNsbwHTUkzBF7SQuhFXANcfPr6dxvuX2h5nfw45041urvzJxw69+u11cbgo8NJ+qvVXmk
	rfruVNBfPrIyHntJNqqofPe/SEPnZ2N9Qhf7Oee//OhBtlDymdVbGgQOyd3AV715HKBE83
	f5XX4hlkP9Z2EN99QSta5qExk4Fu5kY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-PLPLXKI3P_W9x_-MHVTLtg-1; Mon, 29 Sep 2025 01:41:51 -0400
X-MC-Unique: PLPLXKI3P_W9x_-MHVTLtg-1
X-Mimecast-MFC-AGG-ID: PLPLXKI3P_W9x_-MHVTLtg_1759124511
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63541ee6187so5105092d50.2
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 22:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759124511; x=1759729311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kslRQf6+HX/+lCOPEQ+nRCdpHTGfTTmG8vjQfJ7ses=;
        b=AH8UE5Lr4OMmP091KoOUxprXmRXaO0zxw2/Kz4AkUwjPpO4C5AsFlHld2xU3e2vIcJ
         eWKnygvBHuekHDg0s6cr4aFY/Qx4j/1qejI+u7KMzowkrrkiqFlE6Q9fS+7KR/X6/1CO
         q+82i0AHYjmxqCkXzqpewmzKy8ScWFbNowgw76gFRDMVa/Mw92X1OLO91A6mQlCOwYfj
         wyogWQ+Ww/FA9xzNWtqrSuroIrL/M+yilKagEea3l2zTXNgLBcaoiPuDy9So12bsWBGY
         oDLjvGVVpJUCu0wxOVOugbfebzpcM5hXaMYhRdY9bl+XY0/Ybv22/Wr/I4o00OyzNlVK
         eoaA==
X-Forwarded-Encrypted: i=1; AJvYcCUFaXpUP0qB87aYmOO8aVxA5/ljkFw8SV6naVKJjVeBoyCyGmr0FBwIoGWv+dL/Am/rWoWhon+toQwIjuBziw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2E8xGF1XQejwiOKHl1SlkVsR58XFf3hEfgxc6fyIejuZen51D
	CorQpsylBzy7c0OlMe3k4UNVwCaSN3ps229brM9iT1EI1w2JHsWAw44W6auK8PSNXiOovSMdik1
	5VhyfkQbJQGmIDagJUMT74mPln/IwkEJZoCHnhQCwWRG0v8u1VUyKgn6CPVx3pzcsIjKEerJJIk
	lfBTYCws6mZLHG2UiLHdFbPAKA2vYS5xXGoeWkehbu0eY=
X-Gm-Gg: ASbGnctVVL2MW36ffZVxzVPbD8Fx6pFeK7agQjnTvOKZs/zc3jDG58+1z9Lfp3elulJ
	tZnZWnNpT3p33ISNj2cuXrTkgP9l3zlbDtxGh1ao07FYZlWJ2Sc02k55BI1mEUEOyGBuiLkVEk7
	leBJ/6YhT/Jbqh50Zj8mVSk9zUX/oErCqTwsoO0yoQF06AvGw7q6cCTf+jKRoQXC18aqKQmn55H
	nHxZ3w2
X-Received: by 2002:a53:de4f:0:b0:635:4ece:20a2 with SMTP id 956f58d0204a3-6361a84f588mr14971439d50.39.1759124511272;
        Sun, 28 Sep 2025 22:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN/KuwMGiaQ4Y71OKlWvzfV2Hk0k9ZHHw2NbLQ62CQzUn41nWnAvu5q3iEOvsbLHhIP2zwhwc4xZ3MQ8EELmQ=
X-Received: by 2002:a53:de4f:0:b0:635:4ece:20a2 with SMTP id
 956f58d0204a3-6361a84f588mr14971424d50.39.1759124510955; Sun, 28 Sep 2025
 22:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926103421-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926103421-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:41:13 +0200
X-Gm-Features: AS18NWCfZLmE4sIylnvDwOwGoN7qyazMg0qrjMKhNVJd3otrQDdqka3G_TAQqNQ
Message-ID: <CAJaqyWfeiAiNOBtGoEYK7PLncXLMO+wZ=Gse+=X0FO65qQO4LQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add multiple address spaces support to VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yymjSUfWSpBFJFShgZ9leT7Ee0C3bobUgez8933wGFs_1759124511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:26PM +0200, Eugenio P=C3=A9rez wrote:
> > PATCH v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
>
> ???
>
> I think copy_to_user returns an unsigned value: the number of bytes copie=
d.
>
>
> static __always_inline unsigned long __must_check
> copy_from_user(void *to, const void __user *from, unsigned long n)
> {
>         if (!check_copy_size(to, n, false))
>                 return n;
> #ifdef INLINE_COPY_FROM_USER
>         return _inline_copy_from_user(to, from, n);
> #else
>         return _copy_from_user(to, from, n);
> #endif
> }
>
>
> so, how does the patch work then?
>

copy_from_user returns the number of bytes that could not be copied.
For example when the object size in the kernel is less than n bytes
long, check_copy_size returns false and copy_from_user returns n, the
amount of size requested to copy.

