Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83533A1E72
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452617; cv=none; b=QrsZau/xB086dGMdHqLKF2DU4z011pXJuqlrcHVsTSNh2o9h6XpoBMkQ93LePpqWJ+eZHXI8WvlM+XuNYMgRrNnswIl0zN+RLhUMlu2l5E+di8yyFIpzUBueesLqw8w0sY4853GA1kW7ClLeorMkmuLmobIVujosyyELGRMoqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452617; c=relaxed/simple;
	bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ak8/VGvacooQkEdKyU5d8cBq7qOB9WSCWTNeuKmWyCzz13GjSRM7++bBqH2ZEstqICJvK8dOan3aWvZbYqClAZOfEgPmb2VnrK2iUEqhYnHifKY2IerYJ7wqpP2YFz2uerL91eKYkQVTEY1HJW+/W4sKeFcjbV2mR7QPs3AtAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frAnAsCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frAnAsCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766452614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
	b=frAnAsCjAovivn13rds7bBcd40kD879BTTJWEyFhnv7/y74ims7X8GxxNTy5Qye6we4LdZ
	FxydmCpotdPHn7HnfyXOgphv2Csa2WLEtVf4RWz2zjnzeNfbNjA4WVQnEHiawaTh25iiac
	ctT/wLuvMQt/uzVlXazGet6L/d+gfOg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-1YUbhvxcOLOwB4zDtFMKVw-1; Mon, 22 Dec 2025 20:16:53 -0500
X-MC-Unique: 1YUbhvxcOLOwB4zDtFMKVw-1
X-Mimecast-MFC-AGG-ID: 1YUbhvxcOLOwB4zDtFMKVw_1766452612
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c38781efcso8516596a91.2
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 17:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766452612; x=1767057412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kavS/IpGbpS8t4JnXK8FZtjo5KbcXSe8SCEx6230Fc=;
        b=HNjxjyazNide41Uh0A66tNbPhhPrEApHU2NDPpfpHa+dDad5ClAEmRPY8hHLgdhc5J
         glRhEx1BYv30ui1CfLd/CEc9M7hy0iQJVdtfcGdUiDBFjU/DEACGe56sz+Ln50wnvvW6
         rHQMJi5dGz6ewfLLyK8Z5dAAwtrqvFAgY1g4gl9DMTvxpNfoSMv4qGbu87iwZdwARnP8
         Rd/ZT8ia7d9A9yWqk1f4ZXp90fnU6fE8xLZXdcYmvvHPgyy7IQwUeLXYuY4bxLeQVGsh
         Ix5027gwLznNWaVwhBcRe2Zz8ZR4K+i6g4e6Bzm7FQdWWQOjd9sg6MXaYuSUGvA5UY8p
         f6eg==
X-Forwarded-Encrypted: i=1; AJvYcCWeBM8kt/Le42xkmOwkd81DG7Ha6Jn8AYhMhDDs9hi6j/ZNwo6kB1h3Q0A0rxXalwH0ZQjTvwamjPV1FwNLVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsfBGNG/TkSqUkNWOEEIB9RAf7bCzwH+EYjDV3try11Cis6NW1
	DtCasaQxnmjCJIT0CDyqjWsoAwt/yPjhYJo0NuaM8OEZQkogZidDB9YX6q39uswI6MpGLYY3UjD
	cRi5Skr4oKFAKceTGRJNq88qmuG47qtk4t3pGeHmnNACVTyQTLepCO/YyT0z4lyOglT1vfaTQ8P
	wczq7JT0YWUvOCNUfBQ2NSnJHb+jrBWSU4I02vxbmfDZ4=
X-Gm-Gg: AY/fxX7PT7w9bQYfsPE8AewptagBOmIs6L+Razhd1F8E2nEKzt6ei3AmECHpwILub5T
	ZTDrryHfw/7IdMt/78KAiTEKWdHRXyVuGLFQSmfoYfVRFP/Idrr1B0HU7V+C7QEvrSEKAIg9Sfq
	OGTDo7y3tTsCcwg7rMOS564r/KPgHDawN/j3h7p/ZMleZozUpquHTTS6JmM84XUD2X/wo=
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34e921f0439mr10789724a91.35.1766452612377;
        Mon, 22 Dec 2025 17:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn7x/SBWzm7wQBhQmpSlijwdbERX85H67QKAbR4g2R9+j0TmYDnQ/NNpfbhl0rxAVecwANEG5GhCi8Yj5MAis=
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-34e921f0439mr10789709a91.35.1766452611983; Mon, 22 Dec 2025
 17:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218091050.55047-1-15927021679@163.com>
In-Reply-To: <20251218091050.55047-1-15927021679@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Dec 2025 09:16:40 +0800
X-Gm-Features: AQt7F2qZ13vyIVUk_vjRbH6oyWkePM18LxZIXnO-FMhdbQs8hi0QxoGynHxgcT8
Message-ID: <CACGkMEvbrF=g0_yedXKsccVN6vmfm+oQVbRkR1PGtQgFHH+v3g@mail.gmail.com>
Subject: Re: Implement initial driver for virtio-RDMA device(kernel)
To: Xiong Weimin <15927021679@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
	David Marchand <david.marchand@redhat.com>, Luca Boccassi <bluca@debian.org>, 
	Kevin Traynor <ktraynor@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xueming Li <xuemingl@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Chenbo Xia <chenbox@nvidia.com>, Bruce Richardson <bruce.richardson@intel.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EZuXSoJ54LSDjxfj7qsD7CCkcSFWpjkVyGWAt_kP7wo_1766452612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:11=E2=80=AFPM Xiong Weimin <15927021679@163.com> =
wrote:
>
> Hi all,
>
> This testing instructions aims to introduce an emulating a soft ROCE
> device with normal NIC(no RDMA), we have finished a vhost-user RDMA
> device demo, which can work with RDMA features such as CM, QP type of
> UC/UD and so on.
>

I think we need

1) to know the difference between this and [1]
2) the spec patch

Thanks

[1] https://yhbt.net/lore/virtio-dev/CACycT3sShxOR41Kk1znxC7Mpw73N0LAP66cC3=
-iqeS_jp8trvw@mail.gmail.com/T/#m0602ee71de0fe389671cbd81242b5f3ceeab0101

