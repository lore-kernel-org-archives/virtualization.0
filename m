Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D61BA89B
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845744; cv=none; b=C5VtlIPYZz1WtGlGycoJF10S5b+3zH4REUyD9NB66WD3/i/hozwP0mmIkWAO5xw7sT4QQSoGwyL2WPRij59axj3tfZkz+DcC5vAoGHHhE3Sikuz59St5ZdijfAHA4oOma0xrTHSpzYChYtd1SkNwkVROkRP70JEQeBHeaRLvaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845744; c=relaxed/simple;
	bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA2QwAC2fLohqKCi6mQWgAZgWDYgVzrDDyikeYExjWZ6KVvxiXFKV4v8gf6lKapkJGWnsARFrDUcs2FfplvHi0dNyOF+DX5P8A31ORooPC4zYIW5EmMALJvjZc/bvYtz2RxU8A9eTBCquRXic085j7zFm1eBTPLSfn5CqC4mNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uxr0taeO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uxr0taeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
	b=Uxr0taeOBKh/eY/gtMOD5f1DMchWMCN4yXnFZe/Jw9xDoVGIhGunMTIRRkxd4wOom6T1y3
	RGQJxfB46lHHs1FpFsT+v+G6jBqC9NEd0TfLAUUkPNSkz3/tJqoLfAsDDDrfiX9c/0xxKH
	QNLkM58cXEsta4KV6EGGkYrYG5vwFSg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-HJ0lTLC0OaGMBy7MCcx6Xw-1; Fri, 25 Oct 2024 04:42:20 -0400
X-MC-Unique: HJ0lTLC0OaGMBy7MCcx6Xw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e7858820eso2120643b3a.2
        for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 01:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845739; x=1730450539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa6jPLAUyoylgiVXw+EMDWO7dRDSrn4n1a/XLj2kxcs=;
        b=diVMvSxM0v8z2UshQuoGP0tFAulwiOuanFrzB9/QXzLeflDHi3ojOhKZhQMsllTvXS
         uSOFMklg4kE4zVRl2lpnfSzeLPwROWMWjVeBCU2awe2PBoWVaHhFwe0qfthAlxRjN4z7
         HSFWvYHr7UnPcUbGH/bgdq8/167jnk0qvX5A2jCRUVawvcumf9TF0pezjKhI1qXQwAxY
         0z0wEGYhFvZLJED8rZySM5pQkX4KxkCXUCl96PTukrz9z9VNIMHHFIZNE7dLlhb7vOLs
         8A4yBEqMVInIMquhdnqit6a20zFRvFAU+Wsx8epj06KK6lHW/P2QJ5tewge78JONj1lO
         M22g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6QSsivMzmaHI1FftSjlnbFRoentK+Ur5tFNQLtpHuVdCNWWdN4CAr0DzJNCfmBeYGJwE7saJdOA/VFn42w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuMbDZwI3J7PJDOUlVTjeY/ovhqzzNCr4d4KcJ28RefBnG3VD+
	tFm0SaQPcwtZFigYDih8QBDqs7//oVWHXHjrdaoJy/gNQz/+vLOiDbcIxKkHQ1bGTwAoscT0quv
	CGZ27Z0oLKLrXFK9q79q8FVgOI2l53IeRorBe0g1SnTohHs05lsES6Ccd3WpCyeWIDN9aWZ5zdJ
	5j6sRh647iSNuokFdKaZ67Sk6+DQf2C3tPudVeyIU=
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id d2e1a72fcca58-72030b992eemr10914875b3a.24.1729845739458;
        Fri, 25 Oct 2024 01:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyONlkxsszC6bt2HwLRo0KgqsF5/esIacDeqECLFtgNld+V9hMbY+nI2xXS/5AUrgS8dzn+R2BzN6meo0fD9c=
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id
 d2e1a72fcca58-72030b992eemr10914845b3a.24.1729845738965; Fri, 25 Oct 2024
 01:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <20241021134040.975221-2-dtatulea@nvidia.com>
In-Reply-To: <20241021134040.975221-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:42:07 +0800
Message-ID: <CACGkMEsmp3q=TQr7qUhdqtAw4ALLXYagn=BKZegks-=CAsF_XQ@mail.gmail.com>
Subject: Re: [PATCH vhost 1/2] vdpa/mlx5: Fix PA offset with unaligned
 starting iotlb map
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> When calculating the physical address range based on the iotlb and mr
> [start,end) ranges, the offset of mr->start relative to map->start
> is not taken into account. This leads to some incorrect and duplicate
> mappings.
>
> For the case when mr->start < map->start the code is already correct:
> the range in [mr->start, map->start) was handled by a different
> iteration.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

