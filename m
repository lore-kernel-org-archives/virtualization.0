Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E01D26E7
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845774; cv=none; b=b4UVkyBaGOabYiSfrTvU/8aB3wEZkz9rmeR/4rd7TN8xtHmVLR7BEh25dzBGm1+t6lrOxAfEm3pcwSNhxt0H5zWOmid5cVW7U9Ud6YgtMRUkEkPdecsV9oICJW5RSYLAtuSjYDYZq4NtrX+OnS6bRFHDFuV58gjorn0cCHb6qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845774; c=relaxed/simple;
	bh=ESF8HNfQuBgJctBd8Wbfrf3fbvtN7SVW+NouVhQec20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5zgxbqcXW8KLKY/qiETDnCA9RncEc9e3Fmg1yvY8GklJflicqTmrtSutxQLoFqGHuXH/SLtXNgRzQ2DkmyJJ0nVDdwL4/iks16V8u0OAUdFIgCGU2+k/Xl1BdMOKVip7Fm5mcYUTxTanpna+IcS3LP9oKAd+CnPlAxcfW+s6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzzJda0S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzzJda0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESF8HNfQuBgJctBd8Wbfrf3fbvtN7SVW+NouVhQec20=;
	b=KzzJda0SOxflAGlkD0nx4646oDmTkylVt3d4UwyFtFcwA1hp949yCKdP+kOyEsH/TyS0rf
	RHLfZF8lkQQKZj4Ter+WAR4ZY1AQN5iXtBXOYRhfcP2jn9vhqyL2nM+jL/UWQPqrbABZHx
	hWLdrXN3RNbdbIzB3ZSMf5sv6koiYgU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-aW_aqUCgMJeUtlstnG9w3A-1; Fri, 25 Oct 2024 04:42:50 -0400
X-MC-Unique: aW_aqUCgMJeUtlstnG9w3A-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e5a1eefeeso2096107b3a.3
        for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 01:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845769; x=1730450569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESF8HNfQuBgJctBd8Wbfrf3fbvtN7SVW+NouVhQec20=;
        b=nl+XyCRsHHXpmhD18AUEIksXezPadNzbRVa1z8j1Kibr2RuTx4G8yFfugKQvwfNWWB
         RQ3ck19ZKJhhoKukRWTUREPiIFdQufADfPLuBbpikIjj8c5B1vORFSxxQ/SyTxKGyTVN
         bLt9nw5zqxALperbGqwiVTNFVQlm2k7W41AmYq5btP1OsQTLjvrdhVvI6ihTGOcgTC8Z
         y6z2I0gLFCE6xFihY3+3OF9RS2oQ6Jc7924TJ/pz6nGy5Pk/4L17hTTzhc/MB6I+HqOz
         oSa244RsjmJiLYENbmpcfimn0PMtg+gDQc3QwF9VzpwwS5IipPGSxuALaaywyWtkxeF1
         N/fw==
X-Forwarded-Encrypted: i=1; AJvYcCXySkwQVnpb5Fe76WWHEXXyLIzsmAR7DMLQiO6UieF0hIzGezwAh1neqLUzI/vIhYEFgBltLYu8yOp8MZdK1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKBrtterXXTSjwPJz8CjdrzhaQYifSWaDNCDBb+g89coGNX9XC
	yWpgtEGGmSkI4QWq8t+8F1EMnjm73KdbcY2auUkUDzsS98MBBcyKhmXmo4xu3SmlGvABwisI814
	rIH5chh11Fh4m/7sX1lk+1i28x+gf5ZunscNQxsL/9EZi/B6PHEYkQExYDTWRre1OHYPa1nSp76
	Wiv9wJTuH6fBDI5dkP3s2k4WcilA+JbAvOqTSql/8=
X-Received: by 2002:a05:6a21:1698:b0:1d9:9b2:8c2a with SMTP id adf61e73a8af0-1d978bae307mr12136711637.34.1729845769455;
        Fri, 25 Oct 2024 01:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqWP1hxccUA1MVos/H7lZp0gFmu6rQMfRQw9i+PiAUNz6qgFFpbHPa8aaG7pIBJG1XwjsjvD0LL1HzXXPt6VY=
X-Received: by 2002:a05:6a21:1698:b0:1d9:9b2:8c2a with SMTP id
 adf61e73a8af0-1d978bae307mr12136687637.34.1729845769020; Fri, 25 Oct 2024
 01:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241021134040.975221-1-dtatulea@nvidia.com> <20241021134040.975221-3-dtatulea@nvidia.com>
In-Reply-To: <20241021134040.975221-3-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 16:42:37 +0800
Message-ID: <CACGkMEsOpz1S4Dhx2PPb1kdYc4f2SxX-55QT6px2TF1g9R_A+g@mail.gmail.com>
Subject: Re: [PATCH vhost 2/2] vdpa/mlx5: Fix suboptimal range on iotlb iteration
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> The starting iova address to iterate iotlb map entry within a range
> was set to an irrelevant value when passing to the itree_next()
> iterator, although luckily it doesn't affect the outcome of finding
> out the granule of the smallest iotlb map size. Fix the code to make
> it consistent with the following for-loop.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

