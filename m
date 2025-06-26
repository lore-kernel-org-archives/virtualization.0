Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A221323C
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905546; cv=none; b=h4UwAJedRApyef/AynqIjcCH6EV78d7n2r6fkmdZl3/m2FzcHvT4NtcQ5lIm+VF0wDZNaetQy8Gez9RNIkel1bM2ToIMuvqmaI7U7JrWFBDi9pOQ9ehFQJ8ejXUN8ABa5P3AyzN9FfHCDu/8eb7ruDsUbzdpac+uLuWuaeififM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905546; c=relaxed/simple;
	bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjNOBZQ09MTaLa9507/XTPXxJmVB4ihTKYQa8rr/0t/n6lNlGLzCp9adHwVOk5uDn6NuPFFA/8QflwfO33nTShaj6VLT0nB+Uyc59w6IcD6CWJ8WFNz7o11bzPS9yOgNZNtKRn6oPXiXot0PJTdAl5sfE6+n+X0SOrLIR3ycwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Quuhnzce; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Quuhnzce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
	b=QuuhnzcesbXO3X29s5PtuCbOegS1Sq7uZoJgCF6rkb3ph/KkDaHMl0dDQ3ZKNgat4OBIiU
	cPp59V45l1IPiGQoUgzbGzIGclDeEb/x4IZXP0/n1rJEuW+zRHsFjWoGFtZMRxiOKqlGCj
	OJPHucUbmNhSLli4FKuDwXc+Zd2W6TE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-B7_J-GT4NXifLgof9KTsVQ-1; Wed, 25 Jun 2025 22:39:02 -0400
X-MC-Unique: B7_J-GT4NXifLgof9KTsVQ-1
X-Mimecast-MFC-AGG-ID: B7_J-GT4NXifLgof9KTsVQ_1750905541
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31ff60558eso1259150a12.1
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 19:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905541; x=1751510341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
        b=Q9hnEo6zSyNl5jS52ZOB2sswef74t3S1JFyML2o+Z0OMj/MzVuzkNRss8QeJKDJ4HQ
         wdrELoyjTG8NqGxhK0ULIREYo/6rP3lX+Ji2zQ3c2wG+yT52NXvpsXqO1II0Pn7j8l8G
         wOpdeOXqQEt5JMlKoslAEcx9kWN1frb4lkJkoEuzaS0RN9dqF5Oo7D5VTUl11GYPTqXp
         Qfpz1TbvTygVmrxudTXdy/GKqkqg+cQc0YCrgAdkir9Mw6xqW4BckyENUcdhqjBhY47k
         2/UjZMbkLHVITJTl4uYYDRSgkwr3WRL+XHkE4bDx8HUeXmbAsUp9xK6Q0nLhknfc8BoV
         V2uA==
X-Forwarded-Encrypted: i=1; AJvYcCXZK6E3PJKVdNdEZ69qCMeGKOVNocssN+ens5DEFxn+Lq2ZAzBidgT7Wl7Eij50ssXTeZNTvjVaPi6CndXkOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+rNAkyO+Lfc+pMk4MBvKp9En5BF1Y7lwDSnZaF3DCdiiTTdhZ
	HCeCREvPa9xrTFLCgF13P4kN9vxhDYsNKDFnkYWJGxPC6bUESyRahnO3SP6EnjyjMOXGgxSjs9j
	OJix+1SH4iyMs8yZhCkMOWJkKIh5n5WzQCo2QQ3fyavAosfsCtdtaojnH2xIC6H12NLyud/gVO0
	11ZGolAIttuBUfrleKulgoDFfTkvJJzS2rGNm6b5an4gs=
X-Gm-Gg: ASbGncv1HWEOn24qjddNTIAl/5ckdE1+Z9rIdyP25gzL11jK7avMRO/VmyhifAvQWWM
	rGojv9Rsc07KWt8MqkkIhP2vc/OPiwTB20z4hGEIYtCi4tHMlB9cFy3+RJt0+VRQwPDmnXlN8xN
	Rs+sFN
X-Received: by 2002:a17:903:3c6b:b0:237:f757:9ad8 with SMTP id d9443c01a7336-238e9e06b68mr26265555ad.1.1750905540955;
        Wed, 25 Jun 2025 19:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeb7cSsXZgQCsbZuX3BxI9ea2eoF1dmzDHFHzV2vn7oWQ24AkuEOzAXNT7eLnpup8aMyphvstnn6ceEBYA5HM=
X-Received: by 2002:a17:903:3c6b:b0:237:f757:9ad8 with SMTP id
 d9443c01a7336-238e9e06b68mr26264205ad.1.1750905538830; Wed, 25 Jun 2025
 19:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-4-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-4-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:38:47 +0800
X-Gm-Features: Ac12FXzGBspfM0xNLFV6s_nJRqcVgjaFcF2_Hcvm4OR2ygauzrYWua0l6j8T7wo
Message-ID: <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nbWo9ixf7LyAV7SsYXI7iZ9qAUaC4FWq_nex5A93EMI_1750905541
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, we have repeated code to check the received mergeable buffer's
> length with allocated size. This commit creates a helper to do that and
> converts current code to use it.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I think it would be better to introduce this as patch 1, so a
mergeable XDP path can use that directly.

This will have a smaller changeset.

Thanks

