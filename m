Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C24416
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFTJ1YNd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53438833CE
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53438833CE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NFTJ1YNd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OL20Zx10U76P
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 03:24:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A18B0833A3
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A18B0833A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703129080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHxQu02SYazsrBNgSm9QUIsflXPuv5a/PcFERlVjNUo=;
	b=NFTJ1YNdQXAQL6RnE/J/2W5JidvBs2Azogzb2iHueXMYL7pVDZMY8l/zX6DUZrN2nfF5By
	x+G57aAcrX0b/78tlbDW00ncCqfVJPbw34x3vWN32vLMLrGsCHGt7cDsFfj5vwZkgir0Xr
	eqZY7wSdTqgUTzrs58UXeYdMnE3Dl6w=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-sx6fpR6NNsa8YR4HH-g_Pg-1; Wed, 20 Dec 2023 22:24:39 -0500
X-MC-Unique: sx6fpR6NNsa8YR4HH-g_Pg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9fe44d7daso380788b6e.1
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 19:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129078; x=1703733878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHxQu02SYazsrBNgSm9QUIsflXPuv5a/PcFERlVjNUo=;
        b=TQLwelDR7xn+TRYqEHe7Zn8T0BA2bKhGf/xP1rDgn2WVYrLDCBMjjUsi3eMFuV7Gth
         d3D0roZte8e0YGxw8k+aJsIGVp3rLTuvlzZAraXUFRzWqXal7Pzt6JE8x62rZhsF+fI6
         k/MY74chkEe2vyczP7V9Scjld9wSdpV83nHobg/jky/owmCEms2SaUDHgZuRNiDumKHT
         Ckj6Kt1y+p/YXM6bWmCs2ywnh34U0PErkiUlGw6NXvF6/KyN+4Mb9kENRS3uYRMIbkYH
         p+FuMsGW5m5ulNJHupjU6JJ9rr77Z9KgGZnJ1RpgfsKNBvGXIeInuq3wFe2LnOqtzqSA
         nC4Q==
X-Gm-Message-State: AOJu0Yx+oXpZBu5LAr0inUQiwjfgn0ROqAARpBGDWksUvtF2JCNDG38F
	5Iny0o9W5Tr6qwE1SX93Ijcc4qe+wQWH9RbhZ8XyJZZPgzvCBGHsb8NP5vSRS2lkfAFmT2fhCmu
	VtuhmeGHGakx9RKPJwn8AzkYYOTKzoD91Xxfkmze76jJcRBZBvJBDXOSKPl73JBESkDII
X-Received: by 2002:a05:6808:6488:b0:3ba:d81:841e with SMTP id fh8-20020a056808648800b003ba0d81841emr23342141oib.55.1703129078221;
        Wed, 20 Dec 2023 19:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00B5MqiCtP8rbI/LhjOATB9MRRGfZEUti684nR8rhW/w6ofqzWcn9EIv3Dk72aaIuYAHO808gyfbE2qcpoUw=
X-Received: by 2002:a05:6808:6488:b0:3ba:d81:841e with SMTP id
 fh8-20020a056808648800b003ba0d81841emr23342114oib.55.1703129077680; Wed, 20
 Dec 2023 19:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com> <20231207080353.6575-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231207080353.6575-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 11:24:26 +0800
Message-ID: <CACGkMEt56t6i-afVv=qLR4sOg9e783T4YTfHFEekLmqB6-FDfw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Introduce helper virtqueue_get_dma_premapped(), then the driver
> can know whether dma unmap is needed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Looks good.

Thanks

