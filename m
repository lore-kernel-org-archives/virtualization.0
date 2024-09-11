Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E45225D7
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029252; cv=none; b=azJzP5ueechUOzMQ9bsdUpKxwVNlWSQGuQ5Eewe8vQc6O2ecsr94PRzlLZHpmTCGsDB+na44YEdc88iUiBE2I3wQy0vdANXJW8glrZLpOa8JX0GmVsMrfISp7/CgU6Cx3cM43cBQIwqDAuki8SPuq81Qn6p8PXsO49OC3yXEP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029252; c=relaxed/simple;
	bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrCHxUaOCq4CAdIe30I8w1zj5t1S9rM0lJpXMzjxEJoeG2FJCy2A9MkVDJywhUF1rB2RVBHrNOAhnCrEQTKv4vBbE9QkB6l3X/W5roZfmp6P1EpXD3be3vcQmxMEYgmDjIJMZyEF1/lPraM9BF5IXvRGqsWUroFs3Yorm27n3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAQeC71X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAQeC71X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726029250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
	b=KAQeC71XnSCFvL/j75J1UracQTYHK1rlqWh9InUWqIIhffgQgssrJwf0kvOCRrqaxKjQy2
	CXVzylT6cWtFLDJCAzCXjZLDpROd4Dw+7KX5RaHsgFddH90zqAXBmb9ja3+rKSFTahIY4y
	8b2Trx57fZFf1F2vZhK4VH3BMcy4jnE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-tOtG4By5PPa9eShOmDrzKA-1; Wed, 11 Sep 2024 00:34:09 -0400
X-MC-Unique: tOtG4By5PPa9eShOmDrzKA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8a1e91afaso6528893a91.1
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 21:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029248; x=1726634048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
        b=NR7R45j41/iMUoQhOFfCBXVwHFIlHlp+f4gif6PmcvdZ9szt79/SnsA+NGZPcc2tOM
         iuckER6Xzj4YCkhjObTjnzIGb2ZlBReq/ZjtqPNIGTNUpPdZmC2pb9DH7dEYFhENfQ4w
         EklcxAtkDBBey2CG08X9YiHjj3ajgNHYoNXe7P7/aEjdoA0sL9ETr/+nGqCprd57nh37
         jmjsWOzsonHaRMzedWZ2Uh6jihj7bO+ucFagQ//5Yout8IOcmH204UQG0vQIrQIwb8qA
         kaTcHsUfkn79Y/ddZUMlcogCzMi8fZnMCKTatIm2rSt705MmVhJtLq4HHxumpj9TThRr
         mM6g==
X-Forwarded-Encrypted: i=1; AJvYcCUiZFHhgc4++b5ZmbLKDnSYEAGI8kxoxC6npjd6n+DpDZO7XbaNN6SAimMte1i56fa4+TFlaqSNTevk/pey+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx08Hr4qsUglfzmXWg0naY8+hv4JCb+28qR++rO3GVyyuHtCirJ
	zQExV7bk8cLQWTTy0w0Exl88C1LFL3hcUgVRguvXCKbsCeenA0vJ+naQxEfkGf9639B0z/+1ZaA
	bWTKPN8TqQQobs/v5BmqB+HcCnkOdKw0kCWbde+Dl3ECFw4rO39yF4ecD2Ze+GBnV3xVc0ku/7i
	KFYaxwSyJihIzePYVBj3MR47iJ+682PuxDEcZIssw=
X-Received: by 2002:a17:90a:bc9:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2dad4de1446mr20491867a91.1.1726029247888;
        Tue, 10 Sep 2024 21:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4dNpS061+8UBWJdfO4IW4pNByqIXVWRmPrQOcYihie9tMK3d9z/PWSXQpp8WDx1xdXMfMmMHr5f0E7S37Jk=
X-Received: by 2002:a17:90a:bc9:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2dad4de1446mr20491852a91.1.1726029247513; Tue, 10 Sep 2024
 21:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:33:56 +0800
Message-ID: <CACGkMEs44Xa2ZUbAr9Db2a1M6Q_EO=DeRnDdiTNg368mGu_zdg@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we supported AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to

Should be "support".

> xdp_features.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

