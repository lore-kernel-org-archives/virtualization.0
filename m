Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3973459
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613024; cv=none; b=Q1qbxQnFnQD+7Mt8JKJYBLDGkXkWNVr/lQGmWZaYHfXR38YAMdFcYLfH0FJ3DUC5dRb3mCzgnmdJpN2a57hnrcm50SVb5RaIWce4FEdSYjYaFaqKnrPNmgI7El22liPkd/51fSeYBX+7XfhIo8qSEnUTIQ3BcobIIu3t+6JUEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613024; c=relaxed/simple;
	bh=7Gh/M8Zyi+t+eXsvHhqy4r72SOYBFck1SgwYl7QpDkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b96M5An1MGp8+fuzEkRJbjwzB/Lal5JHlNEBtkG8IvVWK0hDDxWPyfWVVXkxWBYg7YjGL3ayA6grGUwSAqZMV3ctFTvrF6XKMqnq0s8tprVS7dflkqAWGJisoPMLk+MnNy47xNgEY8AbjjXOtGzzY2TCr3WCnhTE/uaBgvHOAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=enyIIZU6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enyIIZU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723613022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gh/M8Zyi+t+eXsvHhqy4r72SOYBFck1SgwYl7QpDkI=;
	b=enyIIZU6Ed9GVe7ZeziOuD5Gg4T/Qt2e/5fMsGPw7/giUhArSwWkGhA1r4vv6tgEpu+AQc
	Es1Lmh/J/dYoJZH4JSy83YdEzjFZjUtSVMEnRBO6TMtDbAbs3xZnodCGs5NKDrCUz+vq/s
	XsKI9NDKUJ8vTYDFFSzW3LFjLT7VzDg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-giDE4mV-P92MnGWHjECcLg-1; Wed, 14 Aug 2024 01:23:38 -0400
X-MC-Unique: giDE4mV-P92MnGWHjECcLg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70d1a9bad5dso6544299b3a.0
        for <virtualization@lists.linux.dev>; Tue, 13 Aug 2024 22:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613017; x=1724217817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gh/M8Zyi+t+eXsvHhqy4r72SOYBFck1SgwYl7QpDkI=;
        b=YqxV4JytIdyU9pm3p7MSwVhwt16AFy1xcIVpcN064HZsBg3gt37nCznDbE5JekSeXT
         V01ytKnW3xS2BxlLaZwJ02P7Eb5q9ly/SlK1SDLjo5ARzeC4y7KJ4Q7VAW3vF+GSbThT
         2RzFG2u5zGfsPi6OKyC/DxVIK5XYqFYvOgD+fwnP8QLRSjqDB08Sy57O3pAW36TkcUIc
         B0NyKUmdQ6A/5LG0BaFHExdgEpnlb8xv+2flQaGScqZCiHXc2S62sflJ5hR+Ba2MgxAf
         QpfjqVVcqlVmyD34nvJqXyyoeesh80YV4zT+/WjW9zi7cisrA9tn8ORnBXwHrp+UHttO
         oeng==
X-Forwarded-Encrypted: i=1; AJvYcCXp4d1OuLlJO+sWf64XeO77b6uAZy6oPdLwCmi48F2MrakQwDqk37tTOyneSGtpTkuOLZbXk8FcoPDyxGIfn5cTpyQbix7qBvWPw/p7dXM=
X-Gm-Message-State: AOJu0YyJWiOF18LFHT35lMGSX8mxr1Wybu6fs1XTsG7guRlEa3qW9ljT
	D2s0Gos6KkApsG8GiHO27Az9UmujA7NYid46Z8XqZGEyI8yXEkR+LxxfClwxQzbMTq6LDnNCrwe
	mFwLvJgNzO3xxXImq6UA/MSEQE6wTQUv9NKGKdf3Jy74Syidt3D6V4gZ9CuVu3kpjU7//oiQmrh
	bdF5G6vm+aVxDb3dOEaaF5LVdpGVLzcRrG+ET9LTI=
X-Received: by 2002:a05:6a20:9c8a:b0:1c3:b143:303b with SMTP id adf61e73a8af0-1c8eafa7573mr2348526637.54.1723613016865;
        Tue, 13 Aug 2024 22:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdZRuzr5BORXPw4xiTNxfSeMsERm+uEiuPU9gtfoN69wIp+0iSWNDVdKc6GMkTcU0cZjXWT0eGwLrjrBvb11U=
X-Received: by 2002:a05:6a20:9c8a:b0:1c3:b143:303b with SMTP id
 adf61e73a8af0-1c8eafa7573mr2348504637.54.1723613016313; Tue, 13 Aug 2024
 22:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240807095118-mutt-send-email-mst@kernel.org>
 <CACGkMEvht5_yswTOGisfOhrjLTc4m4NEMA-=ws_wpmOiMjKoGw@mail.gmail.com> <20240813074018.21afe523@kernel.org>
In-Reply-To: <20240813074018.21afe523@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Aug 2024 13:23:25 +0800
Message-ID: <CACGkMEviUsiE1bj+RLfVzH7bmnL3s=Dg-uyC3WFcbNLGAPAbZA@mail.gmail.com>
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, inux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 13 Aug 2024 11:43:43 +0800 Jason Wang wrote:
> > Hello netdev maintainers.
> >
> > Could we get this series merged?
>
> Repost it with the Fixes tag correctly included.

Ok, I've posted a new version.

Thanks

>

