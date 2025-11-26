Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C5347DD
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137924; cv=none; b=n8KQ8FEVAVoVFkRLyjCZ6nozywM6TyJ0Ki9PjElUo0hWV6EOMX87LAZGm+HXc4lFIkteC1eh19pkAsS7q7tDYrpAYl/UJ7SB+5lo9VY5pC5Q2IiuIg6PQuOmu1Txa/XNGequ+bavOTfDXVf6jku+c4GEuKKHJRuJ9FgfmlN7Pr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137924; c=relaxed/simple;
	bh=9IyvSK4NGPHO4fuFRUIAoekh2Pyy3yq0MdSh3GgP3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjXFkQy/K2ajxSj3sNAaz3fqctEvTXNxSuC3tJ9CYIMoNYSB41YRQuhzhBjK5BaDOlAZpE4K2NCuEB228UEoXP/7fr2icgr05Rk+E7h04Ry2wVMJIIJqt3dkWpCo34ntubSAhpaWYcFIgT0b5NmitshBN+mA7EZ1dK8zu8fBFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGSfXKH9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGSfXKH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
	b=OGSfXKH9GL+D7bhVC43zsE+Oic4BIYpGDS43JnS/uCaFauqpSCqufMvrxuyxwjU0rY0V+9
	0zH/IEpSWP7QyH0DJdW5RBCP0ouJTcB2+mOf1kSuH9qxV/KLOZB6bSz+bEgS/I9SbXF+Nt
	2hS1497hkv2WUvW1QMzt/57KbQIZSlY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-bAaLvlJ3PM2oTuWTsfPf2g-1; Wed, 26 Nov 2025 01:18:40 -0500
X-MC-Unique: bAaLvlJ3PM2oTuWTsfPf2g-1
X-Mimecast-MFC-AGG-ID: bAaLvlJ3PM2oTuWTsfPf2g_1764137919
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso6988094a91.3
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137919; x=1764742719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
        b=Vt1VBI6LtJtRLkDHM9gyoh9Of0M1q0o58EK1AtTNJiy8p/P3ZSSLIkasa5JVbYd0zb
         q1e7G8FQh6V9KqyhQcerm1OkiAkBqCIlcGhc5vaObkK2YoljZZRUGbM3vLGPiZPHp++x
         m81B8NpKDp+9T4CoQIrWAjhkbehuwG8wPObtEktTTfXAWGKOLwhOtGicsR96OcxHGK5b
         laP4ieLoT84ghmXTsHNJntRMPwF63Yw+0KQDcPYxtJhGuY1ck4ByMVals3wn5NhsKlDT
         sksyZRSflwlNI/DMaZturUhNShCMmjZfO1nrpOaXcpTNB44mL2Wv6OeOMD073u70R11V
         CzWw==
X-Forwarded-Encrypted: i=1; AJvYcCViOiclGYVYcOB8kxYjhz6fXZtDuj+wc/N3cB4208snCU4sD7Ym6+h+FM8wtsZjIXS3wfoL4QyEpF4wS0yTjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI4sBJJeMhrcDwOpWnI+63zBEbI9bb0bRapg1gCAh+xsmwjGOy
	Cd53/HvepSwkAENQkQdk8GRtPMtfH3PgkaH/TmFHLdMVWNFHBPwQ4y8ovK68ZrpJr8Q87GpElG5
	zJpNRoyW/9CzhJLphVgtY+utLwasojZSLtvrtHfWju/FBIrsN//5W/KYJwgQHTkAX9bRNxaa6Rq
	Rz2mXlcGHsdvfKmpxhd4fWODZwEiK2eTtRsJE7ZWrBnJU=
X-Gm-Gg: ASbGncsVJM8nAVqym+OihOFPefecB25ULGwgddhSjILtbnVK7sl/w7/qlhIIemrI9EP
	siKKT5yQVcCu8AQJmFEuPDae9dxZM1r9GP4Eqx5srVfEDWc2dfXhfhSz73hX/aUNEFsw/ow5Qw9
	KxwSS+xsX/yrqP5wQEvqN3scY0/oBm34qwX3GQnkCjrE+tk1VhUr0Q9ne5MjSZYF08xwM=
X-Received: by 2002:a17:90b:280d:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-3475ec0f397mr5733492a91.16.1764137919246;
        Tue, 25 Nov 2025 22:18:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhRJldpd1OviU1vEEpkzZI2Tkr6ToasHRbqSGmjMSAi+R/5zZDXEphzASNpDnCWhFCs+nIjE+SnB6J4DOjgAg=
X-Received: by 2002:a17:90b:280d:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-3475ec0f397mr5733479a91.16.1764137918886; Tue, 25 Nov 2025
 22:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251120022950.10117-1-jasowang@redhat.com> <20251125194202.49e0eec7@kernel.org>
In-Reply-To: <20251125194202.49e0eec7@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:18:25 +0800
X-Gm-Features: AWmQ_bn5sM2oyO_hdA7aO1WikB4cbE8JxiHO9Gu_Ovx5iCRUVPSo0zJRLtZg_zg
Message-ID: <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
Subject: Re: [PATCH net V2] vhost: rewind next_avail_head while discarding descriptors
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lCBQq5dvx-Y_gXEyVY0P6d_bo2nG9pibs_qJmsXKzw8_1764137919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 20 Nov 2025 10:29:50 +0800 Jason Wang wrote:
> > Subject: [PATCH net V2] vhost: rewind next_avail_head while discarding =
descriptors
>
> >  drivers/vhost/net.c   | 53 ++++++++++++++++++------------
> >  drivers/vhost/vhost.c | 76 +++++++++++++++++++++++++++++++++++--------
> >  drivers/vhost/vhost.h | 10 +++++-
>
> Hm, is this targeting net because Michael is not planning any more PRs
> for the 6.18 season?

Basically because it touches vhost-net. I need inputs for which tree
we should go for this and future modifications that touch both vhost
core and vhost-net.

Thanks

>

