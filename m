Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B420E708
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332784; cv=none; b=XdSlM4bXYClyTNQIhIvSEWtLs0Cl/xkcUBfFnynISdSyE8TnWRDZczDXcM10mgv9ftyc0+OfA+C7PEGVD5paWo3GHbtg4dF1zIuE/jUZSfFIS4bwRqjl3PxrRvZTE89PCHFVTSBcrG5bFw59Jz34KeUGGJGkn9E/UFfgARcaIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332784; c=relaxed/simple;
	bh=8Ab9F84XIlzq+KQFTzL7F7Vf8T4NAHkFDfAeuEbXrmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0HGnw8lylugPFEccerSUx9MkRdEBi7Gnt911r45MdXS9JxJVRtFhdogRWi+fnIVBSTTMUqbkldirOoH1v4mMy4Y3MR6y6YikRbX/Epa7bolyxNN61lAx3y2lRgWD9vXAn5vFq1vq29xQ3ZfvBlJxJaZaiwu3W/XUrmsWfg/+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6Tnv5PY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6Tnv5PY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so395425a12.1
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733332780; x=1733937580; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ab9F84XIlzq+KQFTzL7F7Vf8T4NAHkFDfAeuEbXrmU=;
        b=e6Tnv5PY7ciFhEesinU1b1PtdXdw35FLdvLf++lBFWOlAF7zpy1PslzdBzs2D1tBzA
         21if+ks9SgrYnCdS8ZBl6rypjQCVkJzphrTXvx/lsqNVQSEHP49d1vKDfL2F/jt4/WWV
         nODsumNHcWsNXTlbSBfPAtElRSt69kMkJSAK9QbEWGCPNOtpFoTHxgaO0xSfkMXGPtQ5
         +BM0FXV7L/EY+V55WxPc+OPK8/21Pxr+xh8+1jXEIik8lj9TmTmJ/Xf3ocyDCbc624+e
         Mhrz7V/p8RG+01rjhb671+YKK/VMXYZtEAsb0jGec0THoIlXLGuQXwfUhMU1mhlF+Qsl
         9i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332780; x=1733937580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ab9F84XIlzq+KQFTzL7F7Vf8T4NAHkFDfAeuEbXrmU=;
        b=IkULFLd4JLDkf2YVuzdePpubEunsW2FED5o59ldDxUkHNAxM7zAqnA3euF/vvetLVk
         eVEyit7iMu6/eCGZF+t4IE/LeWPC221hpEudQ7YkluOYXATw0UNQgch2vgQr4wCpRVKA
         DvCIVJtGEhxWqkcffmVu1MVEl/fo1mqed9f1dN+iR0mFpahn+EIlOEYa7d+B0fxdE4O0
         OoN8DFWRKZN/jiszdfF82X9oPXTtAMLTMuclU6WRNy18twdcAKQ5FKyyiai4xXPMTFr/
         vRLGv+8vFOEMbb5ndclP5nT14HD+ddZa61NaDXpu46XwTo8iwZQFLeVeSZC1C8ULKqoF
         hnPA==
X-Forwarded-Encrypted: i=1; AJvYcCV84yo+rI7Fmkf6lrr6a23iepLOp5suroLPChxW4Jo9id0f8/dOdViF+NFBp064NG2TrPB+ZV9bcU3TrScLgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVHytcX0kfBvszUqZ//khHRbaF+yp+i8MV/SoaqXH1A1JnvSey
	fVJ3d1KoI+zzbHAkkJbPA6VU6OvHxhnqEC+BP60oSSy6hs9CgC2HO6GdYtbmUZ+HEFnvc3GvpwT
	hGA1Hvvjz2pK7froUL+6GVX72Ucc=
X-Gm-Gg: ASbGncsOHK8215LqbQMQwdmsDIsS4cPXSU2MxTq2LxCJVurdBDO4LXErxbRdhZ1QtVR
	8t+/Q8fPYMYaVPMtuKHKDTXiKIiCdVA==
X-Google-Smtp-Source: AGHT+IEa0fsyUbQrhwttv9+/s4yicsvN66QUv+yFBGh3ieRI5nPDHpvSHZukhpUcstFNWklB7beLmdh9Be28zhrHMJU=
X-Received: by 2002:a05:6402:322:b0:5d1:10d4:c7c5 with SMTP id
 4fb4d7f45d1cf-5d110d4ca51mr5237053a12.31.1733332778342; Wed, 04 Dec 2024
 09:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
In-Reply-To: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Dec 2024 12:19:26 -0500
Message-ID: <CAJSP0QXbv-fua7si4mDyO3sR=A2UMWMZC1voXWgrQhbd_zicAA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL
 for non-virtualized environments
To: t.ampelikiotis@virtualopensystems.com
Cc: virtio-dev@lists.oasis-open.org, anna@virtualopensystems.com, 
	a.rigo@virtualopensystems.com, m.paolino@virtualopensystems.com, 
	s.raho@virtualopensystems.com, chou.kensou@jp.panasonic.com, 
	wminer@linuxfoundation.org, jsmoeller@linuxfoundation.org, 
	virtualization@lists.linux.dev, stefanha@redhat.com, 
	xuanzhuo@linux.alibaba.com, sgarzare@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 10:38, <t.ampelikiotis@virtualopensystems.com> wrote:
>
> From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
>
> We would like to share with you an RFC for the Virtio-loopback
> technology which we have been working on at Virtual Open Systems in
> the context of the Automotive Grade Linux community (Software defined
> Vehicles expert group)
>
> We previously presented this activity (see [1]) and now we come back
> to you with latest development and updates.
>
> We believe that the technology is more mature today and we would like
> to assess the community interest in the technology itself and in
> merging the code.
>
> Below we provide a brief description of the technology, recent
> updates and a short comparison with vDUSE that might be seen as a
> similar technology.
>
> 1. Overview:
> -------
>
> Virtio-loopback is a hardware abstraction layer (HAL) designed for
> non-virtualized environments based on virtio. The main objective is
> to enable applications communication with vhost-user devices in a
> non-virtualized environment.

I don't see anything related to vhost-user in the patch. It seems to
be a virtio-mmio interface between the kernel driver and userspace?

Stefan
