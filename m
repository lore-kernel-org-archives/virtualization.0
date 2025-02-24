Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DE207DF4
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379367; cv=none; b=TvIm96KLsW2rZkG3E733KSTTI8Tym7RNiWymgtqnop7VSct5EmQ1+RohsUISubJFkcUuPqsenVVHHIIrW4LB9CFTlEIDTCF20eZhf4oNXCWc47n+eY+BhFdScDsiMonyxIDq9k/wEuJWNRzBGWacWFUFu6ADrzYPz9dtEdP5HBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379367; c=relaxed/simple;
	bh=dtjB5lyx5eVjo41HPScIoxSHxdSK2RxZloMKni6QTKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9jeapS5fVCSELD/V8OBa3aP/oeCQ89kOsGw9Hx8yz3ehIMZKlLcCzMUPUiVSLtpgQnNzSAGdvUo/0bsBmYGm+W7EaVdNvLiCy4Wvoo/lU1+mZM3bPscdB2/eZ2ekrcu743YSNDoxN2MyC+34CZxrtrf+bs0K3p7f70oOu5AeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7bGiyD9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7bGiyD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740379364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtjB5lyx5eVjo41HPScIoxSHxdSK2RxZloMKni6QTKE=;
	b=h7bGiyD97fFMUzp4lOVFLfffKffqM3cOBVDRVZzhWTD2ypN+uG9guckjUcAmpTLvilIwFL
	82ZTBPUa2qcCBiq1dM4k7Rx862eMP97FE50Xq4nZ2hRaJ2RtLVKNvh00fh7RyGlIZiDzxH
	iLDaIhr1+mjARTVXim5GYEpU2xIsYPU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-Vc78ESFnPrO2SM_HYjM7TQ-1; Mon, 24 Feb 2025 01:42:42 -0500
X-MC-Unique: Vc78ESFnPrO2SM_HYjM7TQ-1
X-Mimecast-MFC-AGG-ID: Vc78ESFnPrO2SM_HYjM7TQ_1740379361
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc5a9f18afso7909348a91.1
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 22:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740379361; x=1740984161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtjB5lyx5eVjo41HPScIoxSHxdSK2RxZloMKni6QTKE=;
        b=Vt6c/8xYgMm2+ORJzZY5cBwhW8rEL7ROLxMQCtSsLYCVDwPxvJDO11GPgu7xAryjyl
         VKcv/dkN2tGGa3yQr0jeXfywoZOhG6NUaEbPoqo4K8Xsf3wLRdxmkbTmRFN2jq7+gDaZ
         rAbZlzuuaPV2nUb0E4lj1PU29riXcbYnLmWeBcnakot1ntnetObp9u+Nk8qGS1xGK89M
         1nojHnObSMLIaTg1JoocwVW7idMtSj7zWFxRkVceB/9g/k7QajN0NJS5wuEnGYkB0aFH
         TOL/auMAjp5P5JUMJN5Al/yyOxOPmRRbyMvjTOuWvM8+xTCH3u9sKiBTFkz/jkTG+k1v
         cb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTCJiToCzTchhPLD5OkwV1DfkLUErWR8fpw8qA9k/458o7XQEoufH0ECqbgSnt8oQVUlmMee08n/8FHZr4Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSb6PJxszBPmbvuXIV7et0/jkvFPsQu+KwqRWA0rSWGe33QSvM
	tXKGt49nK9oqi22oDZh0WXThXMJcNFp8R/okFkuzBOynxGRZDlveCKA2SYxkmOsAzVIY8PJMHXV
	NWAUhn5NgcVDfERaBPbFMbrgfx94M3EU3hqoJrjWhHFcG/6+WWm28zYB3Kym58GIfiXkyvMVhqe
	vvd0cutUbUCGxq3B55MJxDAO0Nyy8OGi79stZ0TNA=
X-Gm-Gg: ASbGncsDfZj3DpJvQlCTFQAHlerah0cdhvDPdBz6tfM5Dko01+kMo/p7ILZFBd4o3Tf
	jqFo9qVgCBmlBzrdSkcuTkUZk3DRro8PSPhhWBFagaHXZvR9G8Eb5eIoZ7C+mEkIHflS58tg=
X-Received: by 2002:a17:90b:2688:b0:2fa:20f4:d27a with SMTP id 98e67ed59e1d1-2fce77a6382mr22454975a91.7.1740379361493;
        Sun, 23 Feb 2025 22:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuFD2ecIhUAFhVjxb8VN9DbbzjXzl6lNulCOdvpETmdpzPozqSwQzz5CU4bcDz4WMau0RfbbIjUtCAkxFwf68=
X-Received: by 2002:a17:90b:2688:b0:2fa:20f4:d27a with SMTP id
 98e67ed59e1d1-2fce77a6382mr22454953a91.7.1740379361235; Sun, 23 Feb 2025
 22:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-2-eperezma@redhat.com>
 <CACGkMEurYAGHx1FF5YgS=T-4CDY8dn4B2sQJB_ojRxDdiqB2YQ@mail.gmail.com>
In-Reply-To: <CACGkMEurYAGHx1FF5YgS=T-4CDY8dn4B2sQJB_ojRxDdiqB2YQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Feb 2025 07:42:04 +0100
X-Gm-Features: AWEUYZnuYDjmdyQD3CYZL5hzzrYfofHBj4VHCbCLQNKiTNY5xfwbgaR5pmNcLH8
Message-ID: <CAJaqyWc6M+1dkLSMuGwauUKEOoaC-VfW5Ofn6JwYtnKYB-yjRw@mail.gmail.com>
Subject: Re: [RFC v2 1/5] vduse: add virtio_fs to allowed dev id
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QMnILA3BsiaQG-MTLHjFBCeLAVTfvJSBS-b7VesPFDQ_1740379361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Feb 22, 2025 at 1:06=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > A VDUSE device that implements virtiofs device works fine just by
> > adding the device id to the whitelist.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
>
> Let's separate this from this series.
>

Right, actually I should have said this series should be applied on
top of this sent patch:

https://lore.kernel.org/lkml/CAJaqyWdC-Tte+ao6pk22fq-mUym8C9guQFThSnG5gMxWN=
qWyXw@mail.gmail.com/T/

