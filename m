Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4D28684
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451245; cv=none; b=c+pPZziPnitDaMNF9kwM9vQ4p7oNTXqLwWJATt3Z0Z9t6vnFBR6UH9LIwHknccfKNbV8dqKXNlS+G9zqbMk+ZiHTetF9l/wyyR0bjbZht5ZoRgDK4zxhe0uywkxVoSZ8kCfCQdsHGwqYfpzjCZNfZpJSzsdyPZgxR34NmSG3Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451245; c=relaxed/simple;
	bh=52B59EF4+Qike1E1hse4ywDaNMu5si+7dpn1ePMJmBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s02QS7z0f6tsmxPmiYbIXVo3gB9JvNC4oz1mbC549p9Q7wpS4AHiliuKXCpqIhcNMafCQvJ1uVdDIhhsHMjEh7mg+OWuGKainzplRyi5fdwUC0b3FwJFSUUkfMkZs40jdsoiYTDduOKT7L6IzIZc6yFwznlelI77q1e/YfoGBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5HpXs5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5HpXs5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52B59EF4+Qike1E1hse4ywDaNMu5si+7dpn1ePMJmBM=;
	b=b5HpXs5FXCNFBNMJVpRmsK8M5bBAoshKQgpaDyAcMixnZ4JRA6M/a4ZSH9WhoLEIhQg419
	epPnmRnCkuV3qn1HygYeMULXotTp9EQm6+8657z+i59lyD4bvzSIgE+SClHZjF+Zg3t3w2
	ATBRq9wnwWnfYYtE9sPk8H/crAyKLbo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-3EjDtZt5MZWAIOheU6pZHQ-1; Thu, 05 Dec 2024 21:14:01 -0500
X-MC-Unique: 3EjDtZt5MZWAIOheU6pZHQ-1
X-Mimecast-MFC-AGG-ID: 3EjDtZt5MZWAIOheU6pZHQ
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7251d37eac5so1903547b3a.0
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 18:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733451240; x=1734056040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52B59EF4+Qike1E1hse4ywDaNMu5si+7dpn1ePMJmBM=;
        b=jkJR9nVWMM76uyx2re797AyZM3PnGHoc3IcTyMXhdy+SxezCTIvd547BaYg+WD8T25
         x8SC9W7QWcTvJV56koGyAtdnavT5EghXOFzZH3P9ELJG0BPkeNlzVCvauOAdyl2EvmBg
         YGTRpARFDfesbowT0qnDBI+NxvrK2ObeED/Xi0JgAMpHPo1ZsDh0OUUo6BjkwEV4krLq
         2uKw1L1AZqTuQKucnPTd3Mlhtp/DBaPhoMQGjEKSBDgpbW7X8vpWEVoP5qsGUY8tTp5I
         Tj2nES7BWbMEp4kAScMXT3v9YD5yTRnGgFY5bHdrGYcsgZPzNXk/vAj4NCOOoV9rQipz
         dI1g==
X-Gm-Message-State: AOJu0Yyx8u6SREbG21WuDfil7k/vRVb5LEx5NoOdnDdYRNGh2FGDrJlf
	JgF7mBsuTcfuhMPz2eycEEQsp756b0cBAQrjHmNc6VQMh/uLtyTR/n5eKEZX29etXeYYgr1bzWS
	rGgHuqNmfF0hpNQ3AEeeoWi3AZcBb7ZpyLJWD1Qf0cXHbrtRBYzOeGuJ0PgituHIQdbTBt4PyVo
	oy14VLSpjb6yk5fInkBV5VwbvKWj4AtXbmy5PYCKU=
X-Gm-Gg: ASbGncuz1NevM1V9lS3OYNqzNZgq8vqxxx7fZP/PRaiyOcdxYr3KvRcDYqjgWdt4E/Y
	xdXYGxomvqw4hTZ/iyS03vAmNDNeD+bqE1Q==
X-Received: by 2002:a17:90b:1344:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2ef6ab29247mr2280755a91.33.1733451240546;
        Thu, 05 Dec 2024 18:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoyWBvL42D5I+BKxxZpJ8z8W7yojfHD1r0mUIPdrlJIdJf6rKoqA7FX/g1u6TBTKpROREgMAXrwnDSyeEO/DA=
X-Received: by 2002:a17:90b:1344:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2ef6ab29247mr2280726a91.33.1733451240167; Thu, 05 Dec 2024
 18:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com> <20241121134002.990285-2-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-2-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:13:45 +0800
Message-ID: <CACGkMEt0tcE8USpCefbDTU+cTO=31ABwwXg1=zbYvBjRGWXM9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa/octeon_ep: handle device config change events
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	Satha Rao <skoteshwar@marvell.com>, schalla@marvell.com, vattunuru@marvell.com, 
	ndabilpuram@marvell.com, jerinj@marvell.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wcaPswyRZEYDncO2N5Bgk0l8ar8hS8wKkk34YAPmRWc_1733451240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:43=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> From: Satha Rao <skoteshwar@marvell.com>
>
> The first interrupt of the device is used to notify the host about
> device configuration changes, such as link status updates. The ISR
> configuration area is updated to indicate a config change event when
> triggered.
>
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

