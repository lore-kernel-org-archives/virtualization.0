Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905122129B
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766628822; cv=none; b=c6UpTjCgpPXSjhBKFIj2qFe6r7Juj/pZseV14U6XTVLBN9xkTcLF92VyEuKfCppKKyKLIqBQVsR2YPvbJdwBL+6Jj3t6KZth210sZ6q+gm3O/NH0KCY+O09gX73cj9IhKJNNLkWYWcoBc/bg3++xgt8M2xfMQt6c4BzemTvqPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766628822; c=relaxed/simple;
	bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJbxrIxGS+9R1oMf+X3Ar8IzvRefus1yWFswvEK8zWVl0Rh0qWhulo0nFNqoM2C8wPb+2DpsF5wWdxgUrMQ+gPmui9pmlmfH9HrVEfNsQjjp4YaKrGA+Ol/W5wYI5Klv0TTMZmnldl9YovtpmImX4vUcwSw4alJvAPBK9BRvl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUAXBxL/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUAXBxL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766628819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
	b=QUAXBxL/D/x/8Nm5E36UZfbqhOudhhUrrT+WPzF4bDSb3+3uSg15pScX3SUjGNjmn+FHNy
	DbpYy7wkY20PGJRQcgEFsHFbwmuY16HIMFLqx+IbwG8mrXoZU3kgO3g2mqJdmLg4U8l2Z9
	9xH1iPQZpEyDIBAwkjKUWHDVNWkSB0g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-rb_RYS-PMZO12US7C5BiVw-1; Wed, 24 Dec 2025 21:13:38 -0500
X-MC-Unique: rb_RYS-PMZO12US7C5BiVw-1
X-Mimecast-MFC-AGG-ID: rb_RYS-PMZO12US7C5BiVw_1766628817
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso6220920a91.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 18:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766628817; x=1767233617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YpexbkHgi8MYJCeKGa6NmPLNo8dJlqBsM1QFzG+dqc=;
        b=QoxY2MgZV/SmPS1whcgTH299P3TWxyIvYCXq85MWSBAjrSfvqn/QLsxWhYDa5f18lE
         48W2tWc0FwGbwvKb9uDvKr4LPGqfFxBLxvhV4TramHNDBULrSLeOsnlUKgjskaGK/gWH
         QNLO9ybU5K4KcjeIPrtWwV1VNeZONgZFeu7hGw5G2pLTZNrvkJui1mchXcA44DYLSDY6
         a3Hm9/9zgMv4G6STLCFkdsIpGmGmt+MsfJBiD/+o8Gy42Yn+PFx/jtyPyfPoG+MFRhZe
         DpZnW8i9YAeVWUmWtGRNpkpoJ+MXtuyQGaSU0AqC97gdRjwHWky5XDh6pb8eogrb6IEK
         Au4A==
X-Forwarded-Encrypted: i=1; AJvYcCU97O0iKZD6XpttFRVJeX5zKjW2kEQdjNSD9+A8GEkM+zzi1XOytWYaO2Zy8RqmkV3tpc7gicx0qc06DQEHEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrEgpdUVbWIg9NC7aRP39DIE2C1H74SMZSxZ8xCIlpBbvEsMIU
	y20cjYqYMa3ier9mhMfEtj6er5SKx5OLDCtz8RA7zjPGvsHVQytQ3LvhGqG2QHg5mqW7a85IeNs
	+GyRf2t1Pb9QUv7yhTxMrFEAmyDaFa1YzUQRqSkiaPkaP5siEtvPbbrGrMS+cY2pswE6mQZxLCQ
	pUEj1doUCl5yNLu74UIUR/GBOohFws/F8DgvnChoOtS50=
X-Gm-Gg: AY/fxX6m3TnUC2uuevXuKuBhBNmePiYiPrZWNEXfpAZScLuv6Fr7Vxi32OKs6YiIoIQ
	qjs8fmHj5ZETWB4amPrtAiiePVwBt/RNwAmbWMGuNONC4ax58EXbBHrR8DGSPII9pgxc0vnv3Sg
	ZhcqiCxgvWhkSbMhyBnWsTsQtlXMgejwM/R+xt4nUxeEL8wMm17zO8Qh54WFMgG7sL20I2
X-Received: by 2002:a17:90b:17cf:b0:34b:75f4:96d3 with SMTP id 98e67ed59e1d1-34e71d80c4bmr18119998a91.5.1766628816967;
        Wed, 24 Dec 2025 18:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwhbsMVHrIOb+o/clMZRBZzzVHUxqhhpyOgjv8QLYkGMTunA2LZlvhWcPpsC0hOAXEzKg6bxSfXCXXoKtYoEA=
X-Received: by 2002:a17:90b:17cf:b0:34b:75f4:96d3 with SMTP id
 98e67ed59e1d1-34e71d80c4bmr18119967a91.5.1766628816541; Wed, 24 Dec 2025
 18:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218091050.55047-1-15927021679@163.com> <CACGkMEvbrF=g0_yedXKsccVN6vmfm+oQVbRkR1PGtQgFHH+v3g@mail.gmail.com>
 <3a4733b.8bcf.19b4fb2b303.Coremail.15927021679@163.com>
In-Reply-To: <3a4733b.8bcf.19b4fb2b303.Coremail.15927021679@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 10:13:25 +0800
X-Gm-Features: AQt7F2qv14pEjpotcQVKXINUs_y7jmmFmHc1_NfnTrxSaTXcN2AvZ9sBp2_RjGE
Message-ID: <CACGkMEtZUpTG5fG5+JvJw=4RGDo89xoXQjkLyLnWVXHx1gUW7g@mail.gmail.com>
Subject: Re: Re: Implement initial driver for virtio-RDMA device(kernel)
To: =?UTF-8?B?54aK5Lyf5rCR?= <15927021679@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
	David Marchand <david.marchand@redhat.com>, Luca Boccassi <bluca@debian.org>, 
	Kevin Traynor <ktraynor@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xueming Li <xuemingl@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Chenbo Xia <chenbox@nvidia.com>, Bruce Richardson <bruce.richardson@intel.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KPL3_LzowOpG0zTpc4x6oeHChQEJbDZZ3yICkLmDJmk_1766628817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 5:32=E2=80=AFPM =E7=86=8A=E4=BC=9F=E6=B0=91 <159270=
21679@163.com> wrote:
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> At 2025-12-23 09:16:40, "Jason Wang" <jasowang@redhat.com> wrote:
> >On Thu, Dec 18, 2025 at 5:11=E2=80=AFPM Xiong Weimin <15927021679@163.co=
m> wrote:
> >>
> >> Hi all,
> >>
> >> This testing instructions aims to introduce an emulating a soft ROCE
> >> device with normal NIC(no RDMA), we have finished a vhost-user RDMA
> >> device demo, which can work with RDMA features such as CM, QP type of
> >> UC/UD and so on.
> >>
> >
> >I think we need
> >
> >1) to know the difference between this and [1]
> >2) the spec patch
> >
> >Thanks
> >
>
> >[1] https://yhbt.net/lore/virtio-dev/CACycT3sShxOR41Kk1znxC7Mpw73N0LAP66=
cC3-iqeS_jp8trvw@mail.gmail.com/T/#m0602ee71de0fe389671cbd81242b5f3ceeab010=
1
>
>
> Sorry, I can't access this webpage link. Is there another way to view it?

How about this?

https://lore.kernel.org/virtio-comment/20220511095900.343-1-xieyongji@byted=
ance.com/

Thanks

