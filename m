Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598234;
	b=P6gAiT6G3qCO+n7VUGZIjjP/NUPpYEczg2lNVdsRtaTFiSO8wrX1UlXXjKbteRdcaexm
	 ZH5uJ69a4pd5UFrwDQqkpug1ciD0ldwOw6JSASWJsUZLwsD6j2wLcAyMPssOrQV3iLKoZ
	 O4x/BuR0EH+hVic0ZRYGg+8VcrjwuGrqx3IxxF4b4C8GzZQJ9CJZ4LbRs8rgCaZwCAnr0
	 zE4qptvxm9v3We7yhGMoBMwoq+DeG6zLciNVqCtLdyHTdVS558vkQqubLZafoRTMSI0MP
	 4odHgwoqb6Tds13h+DOdvMH8+xWCmYSTc7YWOkrmQ7k/kGnCD1uY/hNuzZjy2Fqc5iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598234;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
	b=ZvM7RWPbYEAwA6F6gckLN5xD5Qr7qi+dwNgepqTOIhh1EiPUtbX42sNbmG2bV3HFbQbv
	 bdjpmyP2Sj9q9V7Kvli5ldEAjsNUObWW0XlUa2bcLMTxW79YodzXE37Z4E4VJT6eUQ8qx
	 wb184ID80SSFgOLyAci/1TdArZMO24lGE6YoZdSlBQeU72abuwIUfrX5xYfS6EwheOT2G
	 XtrYWaXc7DDlaIRiIm5nhBGeedyRwsywQTi2fVvGobA6bxQJCh8NL4Pj3oeSveZM68psH
	 iNx2v6laxiuTJcbe2HYJuVnLUDnAqaFp2vX/G1kGpPsqfXYyKBLwhBZq9GdR/lAn1ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ciGEVnWH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE8606A68F
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 09:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BACE8606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ciGEVnWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795598232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
	b=ciGEVnWHm+m6pmaqeVd7C4zNrSasb5/wyhZP9jyIabcJ7+O+bSbHDGQLXuL1LUSFgqgl0B
	umFC8NXHXe/TE0DSNV5kE+wJvOLcoiIZNFoARE6BbWMkGegSv/VaxX1sllsNp0ND0AiFEj
	sWL9mx0JdcvSzslgMKWP/8azpLPkGC8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-ON3vwA8COt-vrY0utvhIYA-1; Wed, 25 Nov 2026 09:17:10 +0000
X-MC-Unique: ON3vwA8COt-vrY0utvhIYA-1
X-Mimecast-MFC-AGG-ID: ON3vwA8COt-vrY0utvhIYA_1795598230
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-85d630e451aso5140264a34.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 01:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598230; x=1796203030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
        b=TjznbnBMvXFZWWpPiLbzwmsfflNptkyZt+xwSmahyqkh2Uktl7XqRSnYOOivJXXlY+
         KL2BymQgLPFh+Zi7xQTEIlVAZA7BZvmY8NTp7tAB8gr1Q5vIC40Yngy47lh6OWuVtv4c
         FgKPc3JL99qb3LseCFxRFtWeVvobEnL75AwCiODFVZb6GtTny6/MkfUTPThJqBOgdEQT
         N4b8QpKJH56TxvvMpLPMil8z+LOxo+Vefw0h7a7YHNQQsZ5zx1rENgIDD07yMPUwPzKA
         loT54ZAWKoe0e8p5kZhrN2GyRP1XQuv086H7JxAkPkYHM9g8kkd6IsOZYS08fHt77sUB
         gMPA==
X-Forwarded-Encrypted: i=1; AL+hErF5/ajgpE0RsXIq+wqGcwLl8US9CqzgB878cCEtuo66vaaGKWFfjhq1BfEfT9KRmk8hnvx/ttpQwOxrQvCrFQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9rH3BXvUtyKrtUJuWjDp6duAZuqCQrFa1wY5LDfKpqwd5T/br1
	e1IzlVynsDNfuq54PiTRL7Ex4Bz9NWPmR8vrbfzx6QNn/7PLVj2kvrcMvapoMRTyCHuzc4+5GL8
	84pccksupvWwwlyHr1ZGlzEKnwf69Tzyb4ZJtHfOElHtaiY6N2sP0J1N596aiVdHgp1rqARHmxv
	V3wixrLx/LLDtJJjwdXisCQk3Ok+lvY9Q0YrZuAIpyXVc=
X-Gm-Gg: AZFdTZfN0Mm1mrcOrEAEF7n27TFm/9D6jRkImOocM16fHNSoALPs+o2q7XkX9tX8IIW
	5h7YAxyJBDBxVBAe8aBC+sLKGmwyv0yGCDmgAMZfvcKAejQekWK87OjUTD/hNLfNU9kE8yQN2LN
	VnUC+pedw17u9CjtWkayY6cIneY4gg12vqh+qZI/+GL+tG85aau3JPWo/mAaYk4BESYMdq4RE+v
	zax83s67w3z3pDP
X-Received: by 2002:a05:6830:6816:b0:862:c3f1:634c with SMTP id 46e09a7af769-86315a059cbmr19500994a34.25.1795598229893;
        Wed, 25 Nov 2026 01:17:09 -0800 (PST)
X-Received: by 2002:a05:6830:6816:b0:862:c3f1:634c with SMTP id
 46e09a7af769-86315a059cbmr19500980a34.25.1795598229514; Wed, 25 Nov 2026
 01:17:09 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261125083947.263216-1-afaria@redhat.com> <20261125083947.263216-2-afaria@redhat.com>
 <ad36d8e4-27af-4c6a-b3af-984118434797@wdc.com>
In-Reply-To: <ad36d8e4-27af-4c6a-b3af-984118434797@wdc.com>
From: Alberto Faria <afaria@redhat.com>
Date: Wed, 25 Nov 2026 09:16:33 +0000
X-Gm-Features: Aa3M54oSeBIW-vwAXD8TpkpgkEkcEGIL-t9H6mGs9BbDZ7mXBgrqV757jr0lyIM
Message-ID: <CAELaAXwH8-gn+nuD96gDSeKZMgKZjX22Q-hVywXbQL8si6S1Pw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] virtio_blk: add fua write support
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowangio@gmail.com>, dlemoal@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H-rM-bdcgQNpIYP0ntmcPf8y-4iLxdFyU6uXW6awU5U_1795598230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 9:07=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
> On 11/25/26 9:39 AM, Alberto Faria wrote:
> > +     /*
> > +      * Do not advertise FUA when the device is zoned, since we
> > +      * would not be able to handle it on REQ_OP_ZONE_APPEND.
> > +      */
> > +     if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> > +         virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
> > +         !(lim.features & BLK_FEAT_ZONED))
> > +             lim.features |=3D BLK_FEAT_FUA;
> > +
>
> Can you elaborate why?

The virtio spec currently only defines FUA for OUT requests, so there
would be no way to pass on the REQ_FUA to the device on a zone append.

Alberto

