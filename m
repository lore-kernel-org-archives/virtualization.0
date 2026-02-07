Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D103254A7
	for <virtualization@lists.linux.dev>; Sat,  7 Feb 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458184; cv=none; b=SV13ubi/Yabz5y9rY4MFsgihykaPl9D7TCUeY0d6kI7IiDAMmeyBdAXHoUdZyfI5ANGUFv6iMKyNctUj4VUdFc7oOLcovSa3OUjGHZz72svHtJ9kQzkyyKWi+nipVHofnzJQsWidImfdO4neHOTUrF79bmNDIxrnY+Ujnt99gw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458184; c=relaxed/simple;
	bh=Emfr+9M3FTLUOX6E+ELk+kwQTMeILIbImZa7UA1b9mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ujytz9RsurvSaxzS0WR5uw5V3VR34cpeazrVrsdbRMffKP2W92VAbK/X0LkwuKJOWevszmhJ9I6f6v2sCIqWEJvm5PJpR/IZuS9GirDDSxDsplup8Bo11NffnGLWRgWAc3c9YlSnEIZH8FRa6tOb4NKvny+5EyDCkXCLVJoF4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5sg9NrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5sg9NrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770458180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgkhHo4dkLMI6TIjRYX8zZ+2vJLI82aDL+YBdRqg+7o=;
	b=P5sg9NrSw4V+Ioj9uLWBh/ahc2O/3T5Vn5/GLKBPoIXDV2qtqHqEGFKNcuzCbJC8kLey/m
	zPkVVaDjPwF50GVZsTFdtuqyU4hDXK2Ku9aULMh6njhVV32Q9+Miv7T/Rj+ZQImY4xL83W
	fp2WOrGfODEJbozQPRft9zjgxm9NHf0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-5dG0iWNBOK2e3OCVBIKSmw-1; Sat, 07 Feb 2026 04:56:19 -0500
X-MC-Unique: 5dG0iWNBOK2e3OCVBIKSmw-1
X-Mimecast-MFC-AGG-ID: 5dG0iWNBOK2e3OCVBIKSmw_1770458178
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-480686b3b4cso39826485e9.0
        for <virtualization@lists.linux.dev>; Sat, 07 Feb 2026 01:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458178; x=1771062978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgkhHo4dkLMI6TIjRYX8zZ+2vJLI82aDL+YBdRqg+7o=;
        b=gN9aaiXXlVt5nJHXQ+4wZ6WJl+5C81s2GO8Cb6euQZT5ibM+HmTWUDH1Fv+XDp2Jaz
         xCTTu6XvbgPoAb6P3nKwqWuWcwqXFjNGLhy0Ci8wzqyfI8Tp6TcLH9Wh8nfMqw0XmLuN
         deI9/4Z3S38kkdrPVbxG1RPJiV5FVUIj5A4TUvwZYkFW0cKaeg8zOuaM3QcsMdRB6zre
         Shj46zpd87bEFcKyUiHWoR7Ynie1ZWdITWa/CErpfn5FSBM3mENJSALxR/obiENmIi6H
         +gThNF3vNdMDxX+g0US4dc+gvsd0sHgPQPhZXcWDixyP0QCDaqPsGeJVFy9BBH3cuaNY
         n0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUveEnTrbButynqhbwM+8CGPgjtzr8EjpOUXR6ukQGl0bJHhKisZi5TKpLO0t2FfAdg4O18AJUIKCU6N9hpxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyInNobz2CJG9VOKRGgJQlL7UUKCFjd8aIyZ+TYx+QkkUeyOctC
	j4bMf8Jaa7gP7JowjhBSLvLgkE8eDz+V0HBYSMBJqijTpRMVDQUI+SmxJ3cnk2ylB1ULmuneoB5
	Fj1A+NdOgvw1YZEg7B9+hvckrtrTd4+mJUEQHwhky9hVNdNHRsKz8GU4bZYej+9nyBU8E
X-Gm-Gg: AZuq6aIIgvCvivCdr1qOYYc1l56lADTCxw3u8mTviROV4K409ssjR8h2HUSWHAYBlMF
	Z+CIgKZ2sbZcPnYa7BTPVEWuW+WYs84dRIW17n+rSblgyE9qFowXaby3/5+BRlmW5RDdbJoA8iZ
	3FYePkDk/rKs8tZdts+X4ice4Vlq1rdSl1ys3jpiSZb0sL8Tj+Qp43ZgL+JjNYBPtvza0cVYOxB
	T1EXbPPLmUe1w0nRFFzQxniKXRmqaVSMhkZGbsVtNnowZ42djP8NOlV40SV7RIg36dd0GD83hnu
	j8hBows6brS5UEep4xGYAZwLo+xCO/JuH1U/8eaMXyW6WWP/GKPy0Vwj81oopwun2/Eo8/XJqX7
	TakLRMpLjuMYU7VTKUZK+jH5Qvz4iEDVCvg==
X-Received: by 2002:a05:600c:64c6:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483201fffeamr73947495e9.3.1770458178041;
        Sat, 07 Feb 2026 01:56:18 -0800 (PST)
X-Received: by 2002:a05:600c:64c6:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483201fffeamr73947285e9.3.1770458177554;
        Sat, 07 Feb 2026 01:56:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040a3cesm68665225e9.3.2026.02.07.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:56:16 -0800 (PST)
Date: Sat, 7 Feb 2026 04:56:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, pabeni@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260207045416-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
 <20260206191308.7fdbfef4@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260206191308.7fdbfef4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7aUuafVt-ZYEfz_siVPXglaWUSLx5Y3TqRU1PGGi6Jc_1770458178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2026 at 07:13:08PM -0800, Jakub Kicinski wrote:
> On Fri, 6 Feb 2026 17:31:54 +0530 Srujana Challa wrote:
> > Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> > align with kernel's standard RSS key length. Add validation for RSS
> > key size against spec minimum (40 bytes) and driver maximum. When
> > validation fails, gracefully disable RSS features and continue
> > initialization rather than failing completely.
> 
> Hm, FWIW clang says:
> 
> drivers/net/virtio_net.c:6841:31: warning: result of comparison of constant 256 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
>  6841 |                 } else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>       |                            ~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Which is kinda annoying because the value was increased in net-next.
> If Machael wants this backported then we need to keep the check
> and follow up in net-next? We could try to cast the u32 away but
> that feels dirty..


I'd say yes. the warning is harmless.
so
patch 1 - this code
patch 2 - replace with BUILD_BUG_ON

but i ask then whether this code was actually tested against net-next.

-- 
MST

