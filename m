Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC833065D
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465143; cv=none; b=cL0l9GaCjui4AOENYDuUAWoidJ+MiBq7FZTxLhIyZ0kv+Jqt5b6sU5CXxiuI0T5JUj1z5gZSgUfB46JTU8KqzCi/lVz+tc9cijw3/hqE+1s7NmrQrJQkL/q0Auwpv/sooRO6091rcRRrqPrMGOBDgOztoXIG1C4nqXZyPt8tRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465143; c=relaxed/simple;
	bh=fd00Wus97TEsl6E5DYU4/Hrs3GDTrR2HO6/SGrtj5EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aaras9MCq0uAt3afrHagFSfFeamNEC71S6oe/FcAa8extLk/lkATApJ1vbUBPpSNUexwBZeWZ7ZeRtwUlaBYbps09Rqy56CiqSILEIeYN4/9pn/PRE9wgkfbhaJeLEdNK/EC+Cl6tRIjKIvPyLu2FA/n8CSjiE0o86m9MP6T8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FslpxIA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FslpxIA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768465134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fd00Wus97TEsl6E5DYU4/Hrs3GDTrR2HO6/SGrtj5EA=;
	b=FslpxIA5Nupzev53uiJhqMQTa9kVzR56Cx6Xrv79OcgE45K46Uaik1VrkevN8fiGQXn64V
	ZhUYmQQKf05dW9xEQjMcbPjekQDFE4IUoCwS9rQllhVgXgLL4ITakqxdmtV1GtT62Ytw4i
	U5z93hjLTFiWPiLMNU5BfcPRycIQIbU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Vsj1TWbLNsCfhBVElRRQcg-1; Thu, 15 Jan 2026 03:18:53 -0500
X-MC-Unique: Vsj1TWbLNsCfhBVElRRQcg-1
X-Mimecast-MFC-AGG-ID: Vsj1TWbLNsCfhBVElRRQcg_1768465132
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so1095192a91.3
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768465132; x=1769069932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fd00Wus97TEsl6E5DYU4/Hrs3GDTrR2HO6/SGrtj5EA=;
        b=H/yPJKeVdU65CdhLoP3kZLeYJFVALarFsN7MaF3v8fmpyUaDeE/QRjPEGI338j9uq2
         R27jGuPQ23OJLpBAc0vDMtFVEbJQZkbHcaweEq6l43QjNnA2AHEVTdu4nCag6jxn4d+/
         oguCx6gHDSkRjIzeU9xCuhj3Dxqp1Se71ntw8Omfuu2Nl+OPRS1Pn/Dv4v1CLea7oEyn
         qVXvC50WVp6EMYkNXsl7jnVpgyGMxa2pe3qMx1n2WiVSEJtu3cNJGjsZmT6eOfBi3Ezp
         ox3pCvEaHHYaP6FPkTh8AP6IezENUOzftzQQezQDFxgGlATF9lvaZM9QQtonuE+VKBiW
         5sBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvaMJnUHdxSHNlRimg0104spjC44CwcN4efY0rcspT3iZPWFZRsZKEr4qLUrQ1RT/CVXGfMsL5bZOPWWVc9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0bGpO2DdxA9QK7ME2cLs8sdxH++s954QLHzuVs+PzG/5CLpMv
	L2OmAij1HbxCI1es8bjIFHXrsAhCy6xlHXLCEl2m6iUwrFBVitWu99plOAvuDUnURC4ewFs8IAG
	jAW4VE5DJyxqeVHVI1M0EI9N/XR7UnSgFED745exmjS0M6t+p0JejVcQKLxzCiT99Ro9OH6Rvql
	nWwKxQGibOC45fKj5ZfWSldMCGcPBODpJ/y4z4WXAbo38=
X-Gm-Gg: AY/fxX5rwr64b4p9uo0/qtJWLm0Or2w/S+Av8hQXTnNOUDRxqMmrB2OwlWxeNF0T9+7
	ZBh2+1Y0Df2FflQp37vfKPiV7XiOG4ilnEMNJPntPJPuy319GkYcJMpgice7Y3R/tBcxIn0KtSx
	7RQAzfuKSEOjrbZcyJFF5/XjYYBd77A8rq0M4/ezSeVkjiK0dLOdR1dsYLcltmUWJzSL8=
X-Received: by 2002:a17:90b:3503:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-3510b0b0300mr5266100a91.12.1768465132061;
        Thu, 15 Jan 2026 00:18:52 -0800 (PST)
X-Received: by 2002:a17:90b:3503:b0:340:c64d:38d3 with SMTP id
 98e67ed59e1d1-3510b0b0300mr5266082a91.12.1768465131664; Thu, 15 Jan 2026
 00:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-13-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-13-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 16:18:37 +0800
X-Gm-Features: AZwV_Qgaosp5F0nCgROBdt9qcwMNylj-0fpSnCxLd1S_aHBkT7dIm1zX5n5Jepw
Message-ID: <CACGkMEufmPwPDDEn7G=NyxJ7=ULxYAsomZT82y8W+bQ_Z8hTUA@mail.gmail.com>
Subject: Re: [PATCH v12 12/13] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LJSjiildjAMvO1Y2_Us_e1SOcoPKGfP_UtknYuL7wHk_1768465132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Assume API version 0 if the VDUSE instance does not call
> VDUSE_GET_API_VERSION to maintain compatibility.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

