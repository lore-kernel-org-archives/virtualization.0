Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD817BA1
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281760; cv=none; b=rNirMn9OhbWGyz8X7aAWdM9mglRslh/gTSN5lQx0Xkg/ESOLBpdC+c0FJD1oTp2InB2DLpK+47jYD4vuJgyhcz8+vbb9iHI4HOBtv2emj7cb0i+wZxHjkd0GbTri0CVKcCdU0o74IoEalOvKH58wKlwiiM5qAF+hddfpRCL1KrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281760; c=relaxed/simple;
	bh=MgmdEGHRndukdNTSVbD12RLjVRhCo7fsl9QialTQEYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzk6tUv3/oY3rE2VII3dCLYmBmSp44+lO8qBXlDzNrYbrs8PRNiho0wyWWdw+TWmvxnOMisO7Ay2dabOjR5telqCOwaL2nqk7gmnTswqQ/Yx2cbxCp5JOgu4zM0tL8RuYT+JBBVWResM88otsfGJDBczgkmoy60dcmRY2QjBTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNdAPONs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNdAPONs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733281757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgmdEGHRndukdNTSVbD12RLjVRhCo7fsl9QialTQEYY=;
	b=FNdAPONsZ3lSniFMZ+jKnVCiA+DD2AWhnReReSeszfE55MLv4xXHFKGMqUJdEx0Il1Z5Gx
	aiIVWTo/d0O79AlBXhYUUoXX7QNarm86/6OIRJaGV+WQo9cGRp3KChTN9wQUOCDQdKZjzt
	VQlc3TZ7bN4VMjUiiAH9YO24/F+wvLo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-OIGYqhOyN9SUD2htvZMFKw-1; Tue, 03 Dec 2024 22:09:16 -0500
X-MC-Unique: OIGYqhOyN9SUD2htvZMFKw-1
X-Mimecast-MFC-AGG-ID: OIGYqhOyN9SUD2htvZMFKw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eea4f2bba0so3374996a91.1
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 19:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281755; x=1733886555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgmdEGHRndukdNTSVbD12RLjVRhCo7fsl9QialTQEYY=;
        b=rL+AOxbpCEIUfm2AfQgPCZTslBr83lqGZF6V47gu+5TW1y+C2Ya7x40d45My3ECGAo
         upJQbKquR3MJXDW7pgW9PKIn2LlYD0GiofCQJ6xDlHpCiw3aRoNo5c+byDSni7F7aSL5
         y7NIK9zsGFjGs8wEdFCJ7iQD9sDEBCECqxdp/nN073ZGMCMCzUgRgEXLb4dN7huRZU5d
         Jz1n8d5qRQbnoLceHoCNIs7n0EEyLPsvENPRA/3xsJqD3fn8bjs+iPxTr7qds4TOZbUy
         fWmn0ewPYnGSXAiM4ahqcBnEXQlyMWNHEQs3Kq7yxE+KjqJXi1VASoxw12Zo0kXZOkxV
         Lymg==
X-Forwarded-Encrypted: i=1; AJvYcCXtakLoLYt6inuAJlof4M0HCDzmlm/WzVAQbSCGPpMzeVxDNVlnuAEIa1Xm0L2bbMilfRozliRLozJIwTLZAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+1W1v7BgmQQyKNM3gd3L0gwYjuAlvWYgMywMBhc7feGzj3SAg
	kqrjByNoEN0Owv/dZ8SINwhb0kRxDQdebaDy27AiQY7SKvHHgzlG01raHLHecNTSOpri0k9Ecnv
	iRUI5pe8aGH4gzvBrDfkYDpXaHAuBHxthpTiIvmE5VvY22sNYf3qnXf5fGzE+onF6VE1VsmHZU3
	I2tJZaegDaaO5FVHp93RREEcOwf7CXslC2VUU/E5s=
X-Gm-Gg: ASbGnctAzjenvhxz3PoR94P2jVW8uvcbRrosjtC5p9aQlVahsmcY2/x2TAcRBY3ry0J
	Aa0l0G7ovWxsWBpln9PnswnAPUBMqF92u
X-Received: by 2002:a17:90b:4fcf:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2ef0120fa09mr6191076a91.19.1733281755686;
        Tue, 03 Dec 2024 19:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRyq5Kar+YPrt0fIQIwOO5QkraST31h47uN6/R67k+FK85B3TAjImC5ClI7yR+Xz7aE0hgCtXnDh0broXLhKQ=
X-Received: by 2002:a17:90b:4fcf:b0:2ee:c457:bf83 with SMTP id
 98e67ed59e1d1-2ef0120fa09mr6191042a91.19.1733281755308; Tue, 03 Dec 2024
 19:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
 <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 11:09:04 +0800
Message-ID: <CACGkMEvWNb0XVYjm+bOSaFB-U2Fi4H22pwXvQBq1-5T-DqANMg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: implement kick_vq_with_data callback
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: lkp@intel.com, mst@redhat.com, angus.chen@jaguarmicro.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, oe-kbuild-all@lists.linux.dev, 
	llvm@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2GNqZjt4zkUmRqt0iS0pOzqxikxyhVjGq1T91a6dMc4_1733281756
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:37=E2=80=AFAM Yuxue Liu yuxue.liu@jaguarmicro.com
<yuxue.liu@jaguarmicro.com> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> Implement the kick_vq_with_data vDPA callback.
> On kick, we pass the next available data to the hardware by writing it in
> the kick offset.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
> v2: fix build error for kernel test robot
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

