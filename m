Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC8381C4
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144098; cv=none; b=YMWAT/0Gjrn7ti2l3mukqzxjKS8ipH5Fp3O8z7T8KfAQ1t4aYQrOfzzZobTJmESLnG8f4ruNFvsGTbF8d8zHnwmsvx2thRFB1CojHvg/HYYf18+GBhS6D47xZwblAP2QF9b729KjUXogiKJ1+f5MpnkLhQN/BEjLnn10cmwBA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144098; c=relaxed/simple;
	bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG63fnBlkUCsBC+w2CZaCaIxDrifDEXwO/4XUIulRJBxSUi1FgYlX4Un7oBDzkgppHCd7PlGybfo5dbxLrRe98IJHhZkSYTkAzA2sA+JZsxRBKq+VgBoDNj5ybmknfMBFTwDiE9GRQO1qqxGwUn2WG4ooaSYTXPsc6neTaRkp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1tLnYjh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1tLnYjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755144096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
	b=e1tLnYjhiaz0ESI847grQftu4i3U34HBBq9mR+f6ikFkvjXQ+xG/uBFbpmS4vL05LMiR7r
	Ht4xktO6SHi8BFC64bEwB11bgVCy1E9DZBEpkjDnN4F8jMjuZEAqpXb1/w6tzzAEt2hzkf
	NqCKgxBNEzaX/DdhCiFEOyPb38NONkk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-7rf8JcaiNSOFSBb5zySfAQ-1; Thu, 14 Aug 2025 00:01:32 -0400
X-MC-Unique: 7rf8JcaiNSOFSBb5zySfAQ-1
X-Mimecast-MFC-AGG-ID: 7rf8JcaiNSOFSBb5zySfAQ_1755144091
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323267c0292so520204a91.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 21:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144091; x=1755748891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+IcJ9QjPVmPeRoFB5qG4f11pCnEuZsgs4iWvpgqCc4=;
        b=fEU2nw/PV2JI83MOI94GDalxQGcunz5cz4PKH8P9aObDCnHlGnm6rih1wDEc4ByUsD
         hvBV7z23s4iQjJJ8eg3gXVQIf/c60xVE4ffWizgRPRYwIr1oC7RVrhiLCj+83NYfrtiK
         z//3ka5y4M/2tykT3JgMvX93D/GboeXmMHLjls42/fQAimL6kgNMXa5hhLo4Qz80cxGV
         HuTx1gggmYlBaEn+Q277RuTtTzI8AkmCzm+bqipI2uRCXwoVdU0uCQzC9M6SIdZSKaZI
         0Y027mQWnVCrEl5g2TCY1o7IqqedT3AtpaGwL70THax7TtCT2qcomE6OkUT6YAyK1huS
         RBXA==
X-Forwarded-Encrypted: i=1; AJvYcCXqLpVUAR/1vM10QMcRtjetrTbPbRnsIMOs8MA6hX96rbltLpzuCToI3Mg3Kml0y9llUPdiXTJJaqHuQRH2Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq8ASBdVRPJEoKVcrXzCnFAA88Jj4FmGW0ZneSb+ezL47Y0iqv
	VFSBNZFKYFKefjq0WnaRSOKKsOZvj1j8urj9xrnlvu7wczJz+mfo2FvkcSh7pIfRWz+WO2PWqda
	WYTKuUDX4MizHq22ywEi32vgNvFVRwg/q/z3LvA3+dMCpTps/7TRByFdq1xf+Mjm4Kzhqe2+ysV
	Sw2ZFsubu1dhX8J/Luxw7bF7IvA8Yt+sNSKuC+nlfdl64=
X-Gm-Gg: ASbGncsIceKbKoj9eMnqHxgLClcv3/LsSOPALpDp7QhDg1q0PpYvihZJYRX05x93XiZ
	0vmdKCx0ZyIQxEF9rW2tol+vIzVYvBuFX/t9Xsv3LPck/zOkEQLSvocwswkDSoaxALUyQ0eHF37
	BtTf19ESz34ZPP7+HPHnJisA==
X-Received: by 2002:a17:90a:e7ce:b0:321:9536:4b69 with SMTP id 98e67ed59e1d1-32327b590d4mr2435290a91.27.1755144091267;
        Wed, 13 Aug 2025 21:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlgZcQQu+mkUi1deC7sDjvQ9QuH1SATW4bpi1PSZYoAkkkYuzX31t0W1PcNStDaF/dAIVS1DhTpkg+BudaI2w=
X-Received: by 2002:a17:90a:e7ce:b0:321:9536:4b69 with SMTP id
 98e67ed59e1d1-32327b590d4mr2435217a91.27.1755144090770; Wed, 13 Aug 2025
 21:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250814023554epcas5p4b3dcab50835e2da4749be1be135def20@epcas5p4.samsung.com>
 <20250813172307.7d5603e0@kernel.org> <20250814023607.3888932-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814023607.3888932-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 12:01:18 +0800
X-Gm-Features: Ac12FXxgn-t3KycHNHz_KyALlzCrfoNrRoAOOEeUSfgRjxzlZkWqFGNrg_7ImpI
Message-ID: <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jh_Q2NzCzWprKNbbTQ7bv0TxeLT44RYyw6SFgRqWH7g_1755144091
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung.com=
> wrote:
>
> On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > Sounds like a fix people may want to backport. Could you repost with
> > an appropriate Fixes tag added, pointing to the earliest commit where
> > the problem can be observed?
>
> This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414633"
> After this patch, during `virtnet_poll`, function `virtnet_poll_cleantx`
> will be invoked, which will wakeup tx queue and clear queue state.
> If you agree with it, I will repost with this Fixes tag later.
>
> Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")

Could you please explain why it is specific to RX NAPI but not TX?

Thanks

