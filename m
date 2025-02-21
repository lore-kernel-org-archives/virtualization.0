Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25E1DA53
	for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100378; cv=none; b=SwnoRhWKOwJqS+4HjZ1vuz3qO+JdUsK9g6+q0b6TxmQJiZH0DiEQsQMUQa/X5OEuvN3w84DEjqmfDi4o7YrZ6iEupUOwru2DYifcKI9sbxE/cazfsXXMG2e4PpSC9dqStTecYOtjaDeHvmI0ye+r3N8zHGQugSCrG226YbRH99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100378; c=relaxed/simple;
	bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UodT1fNblctkgXW1b+ztvMnGyONRGSZXVLplChtO/hU2RwVOUnLrfloDvkrNP1vG2zGVGD6oc1s78Hd1Ar7KEWYjnKpeT1yhPVoGy3s06DU3DLqMm6KUDB8JOr5VSENPcB58rEYgr0nOxq1ytN1YY75vUia7HRcl0VV33uoEEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMhE0wdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMhE0wdj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
	b=UMhE0wdjntk/SC0jXR7Is/t1BFsTVOgExCqEXSkKvHOwc+Z0I7lJCpSIHMI2wccFznpZSI
	AilLbBME2+DSuJ2M78dE+jSBX3DCeqsrXrJBFiQMX8VJJrmNjwUQrSpJKgYT8Njy8G/YyF
	r6K0PPPMyKgVU240Xxsv1SjEUjHMHSo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-qLWt_55XM2-QZBTVEK8KiQ-1; Thu, 20 Feb 2025 20:12:54 -0500
X-MC-Unique: qLWt_55XM2-QZBTVEK8KiQ-1
X-Mimecast-MFC-AGG-ID: qLWt_55XM2-QZBTVEK8KiQ_1740100373
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so5053107a91.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 17:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100373; x=1740705173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
        b=i7sgPd4hw+ois+BDX/C4MBM5M+n/VhS1VjzRe/8ia6emDSDyjb6zZtLveRY0VJGsPw
         vqtiIJUxgFcdvv9VyQiTlXCyF/EM3dTKH4S2TP/QY3FTCC62X8RngsoGyuo4locA3qpY
         JUFQT8vvUE/jQo9cRgwwVSKn9paCzJrh6xlALn2EuIQU014F5d2do7pmQkbadkhCZc9G
         57GEMk+PIZjYJERVtA7CO+Tdvg0i3zvKyRh9UTDL/YEgAAR1Aa8jbGsZkyKqfUPqlXvp
         CEL0KSfpS7ja7WEtsw8KW59ZewAVWoZYMpgcZy+QYZ0cpEm7+B7IpjTIecIa2SwLpm3U
         Rpyw==
X-Forwarded-Encrypted: i=1; AJvYcCWGOrGUklTm8zOEU2ehZy3bowQlaL6A5TcfWKmKTpMqPLNDddaPmsPcCbLpVqPnAemZRF8V56r5cxc8Zg6dBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6TTp8dtyNXZDFhMusdzHWJjMd8uzj2LBb394H2tr9PqQmclTP
	+CmPWdz2iDQ+vknKgh374EAx1e2nOn0YSMYQh9AAwiKXLj2LwgKY9gVfax7JqYmwx6csCySWS9a
	M1+Ipn/B00UUINGb/6uoByIdO6oYM43DDe2LNxBS39bypEArBz3veiK7Ee9Ip1BpzJdADwChCEe
	pUdhUIEcYWIIE8CfAg/Tq4XM8/fqDT50BttQfA4ik=
X-Gm-Gg: ASbGncuDnSX+ueSTVLTCfO3GleLBVTugDsSJnCLwNY8Tg3GpHRQjrUqETjQHKI19rSl
	tuhwgSj7TwPlOXDK6KjWZsFr3xceZGw1HyoI/n9UapzTYPsPsKbg2ZI147tpwo7s=
X-Received: by 2002:a17:90b:5310:b0:2ea:696d:732f with SMTP id 98e67ed59e1d1-2fce7b271a4mr2148908a91.29.1740100373613;
        Thu, 20 Feb 2025 17:12:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnQJ9hWU4v+2TwwECUtm6Pf8c9YX7B6ZUHd/Hqnqd2kx0Bc2ftH5qx2hCH5z2BE+GZRURxv4Goas3NlmOaXUg=
X-Received: by 2002:a17:90b:5310:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2fce7b271a4mr2148854a91.29.1740100372927; Thu, 20 Feb 2025
 17:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220193732.521462-2-dtatulea@nvidia.com>
In-Reply-To: <20250220193732.521462-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:12:41 +0800
X-Gm-Features: AWEUYZkw-CTw854l_MFE994dYvtfLs30K1XdrnaRr8wNLayyzmZm48vwiDxgk6A
Message-ID: <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
Subject: Re: [PATCH vhost v2] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org, 
	Cong Meng <cong.meng@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dm-4KBHDcOlyRtTu28ovNQmbI484Fgu3y7i5jZHUQcQ_1740100373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> create_user_mr() has correct code to count the number of null keys
> used to fill in a hole for the memory map. However, fill_indir()
> does not follow the same to cap the range up to the 1GB limit
> correspondingly. Fill in more null keys for the gaps in between,
> so that null keys are correctly populated.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Reported-by: Cong Meng <cong.meng@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

