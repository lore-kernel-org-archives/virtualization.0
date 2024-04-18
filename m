Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C839657CF
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420568; cv=none; b=oOdvaiUQOwcJr2bybYNcfwofir6m8GdYuH4NOoB3ka925LVgqDvfyeTBM/Gg1Lv2T/HClFVRgU11ErPUv/HH2Sw2l4JCfaRx/FgqUMEeCTwjvFDVG2+foPDTwDxTPpb6cOy554CD48doqJsZB0X/o/qFns/+STyEA1i9z1a1vRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420568; c=relaxed/simple;
	bh=GNh+VuNzvsRb/wOJoe/wrB+bC4lFliOIDgQ1UmO/juM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4mtbioDXkcgZcqJLIm6ERyGTTxIwNc0FickY5kdotRGYB3iZR+IdjwNpc/UrCSukFzBnlndSiLBWr8AkM5tmB0t0WA2jXSMs7XSK25dnDy6zEu9I885pTLNcVOzSQ9CA7H+XS8Aih+eo0nAgZwmfpdTkajMqQw7KebqVfUWbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JM1DZ/Lm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM1DZ/Lm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNh+VuNzvsRb/wOJoe/wrB+bC4lFliOIDgQ1UmO/juM=;
	b=JM1DZ/LmT9I64+NvGTEFDrcRTpu89xDtstnYwB067OEwk8kDKTZ9vuXTPwlwa6GstZTyTw
	Q6Z1PjkmGrmTwm7xyNLthWv6YviUZ7j2HYVtdQlJy3e37TvDPCcspEZo74kRB0txBtm1Fc
	3FKAdbgWjnVDXK6Z72FLkJN2aE4VHu4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122--7voNbBYMo2hHc_QPuUXPw-1; Thu, 18 Apr 2024 02:09:23 -0400
X-MC-Unique: -7voNbBYMo2hHc_QPuUXPw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so986104b3a.1
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420562; x=1714025362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNh+VuNzvsRb/wOJoe/wrB+bC4lFliOIDgQ1UmO/juM=;
        b=kiaUF4Nyn5V3C09De3bcwroZrWglgddLCHx0xcVuggpZ4DetCJeoaUITekar+WCCPu
         mFQD0BpPvdVxRvL76wfnYLvTmrWW6/gvve+AEYqMludVTajMgD3vdPH7zh4mMZ8u71Eg
         2KqdMGJkoTE3MXpovEfL1XheM1XPjOBuJL1+209z6L+KvbIz317EPYvGrIlbJCN1kvtm
         N0aYgy6dOfTkQlCfEuXhpcQWSPqRmub9ZmtfmneThDLT2ft6zxV/CeLM1ti0QC7PfQCX
         nLMg2XZSgehW1mfW9lchPZbyGM/TQNpkLSYEh06pxqIE9uJnN11Ihagaxk3gSTYP0ufO
         ciMw==
X-Gm-Message-State: AOJu0YwQgCZLpy+XnA4NxsIyhXsP0VlLW532HqB+JA9grJAPJksWRArD
	65afndD7sVlYZ2Yb4vV3C2RxHzwi5sfwS64g17A5fo1MXzj4EksWdxFMXW5DsX16Wd+SQh40JUV
	LIGkCS1+3/doyOFd1L7YouIoNvFLh3AZ2cVV08QnvqHoNpZKLrk7CCthlhaOE4vCk/yj+mKQuWq
	9y/yxZ6OtDcU5gWUsw0Wvhby4mjCfbMTisbo3XBr+A4GwCSwkAKA==
X-Received: by 2002:a05:6a00:1804:b0:6ea:8b0c:584 with SMTP id y4-20020a056a00180400b006ea8b0c0584mr2437373pfa.9.1713420561778;
        Wed, 17 Apr 2024 23:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4PuWAAI2IJNnqNjFq7oH4FtTLkvSea/kyne1VD2dr00iqkn8rtuNOFi3+3bHz+qXVRWU9xXnO6/bB2lAJ6gA=
X-Received: by 2002:a05:6a00:1804:b0:6ea:8b0c:584 with SMTP id
 y4-20020a056a00180400b006ea8b0c0584mr2437356pfa.9.1713420561452; Wed, 17 Apr
 2024 23:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:09:10 +0800
Message-ID: <CACGkMEvkbJ2j6J=nxfh3FNQRhNBa0Wr6Kyz=6r458edgxo65RA@mail.gmail.com>
Subject: Re: [PATCH vhost 2/6] virtio_ring: enable premapped mode whatever use_dma_api
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we have virtio DMA APIs, the driver can be the premapped
> mode whatever the virtio core uses dma api or not.
>
> So remove the limit of checking use_dma_api from
> virtqueue_set_dma_premapped().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

