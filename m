Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B1329C5D
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334696; cv=none; b=iVTrN3lCDRsnmqvdqA1wccklur5XEIePgzmFY4fteiBtYl9xcklCcIBsZgK6R18f7nzKGmS+03cQIbrZwWphVg81XN9VcAD/UiMi+zWi7ly8NOW5Ff8KJ4Y56W9Q+MyXgnnS3idnAOvvbjL7QdFM2jNmU4hXy4zwqKgkGe3pzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334696; c=relaxed/simple;
	bh=MuFoqSXPuLC7mZdpb7+pS1mI6Pzog4fHqbrI6/r2Fik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnjMOmKRxnSOzIvGyeTmYjKlzJRAPZ8yAbEp8HOKlGCWZVJUY/sfYiKG+GYQzXlUBztH03MDosDjlgMa1SsZVZhWJMmrYatZFVfP5bjub+wtWQZuRyRFJRpjhX9QTkb8oHvh9kxxQgLOqwgcUbOmxTAILPbc6yDBWmRbmGc5t34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJWYU+6u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJWYU+6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
	b=XJWYU+6uD2TNlbVBS1FWSfq/vP8XVoyGeNQVA2MIuhO/W4T8uQBNHQgULFu1ufsrLZrJlY
	lFTx9xa+7BzUc6E0ZglUBSgSsLJ1mcbujDT0vhlLqJzytcH4lFSPmNaTFKhsd58bsoLE/y
	/U0BTvNl50SHvZA1e3jAbGdy75xr+Ms=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6KC12TrAPauQtWh11efLWg-1; Fri, 28 Nov 2025 07:58:11 -0500
X-MC-Unique: 6KC12TrAPauQtWh11efLWg-1
X-Mimecast-MFC-AGG-ID: 6KC12TrAPauQtWh11efLWg_1764334691
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-787c609417aso14464697b3.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334691; x=1764939491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
        b=ZTMLrcsWBJhQFlApCU0B0OiP/IFo7vIBz8M2FiOMW+2sfqFARzHP/3F9hsCpr5aWpu
         qHsEJD2ZOwVYpUQUaZcT6msZEoJSwwktbAiwU8W1XrV+AGQBY0IH/KzNHjWxtLWmjiIx
         SmQNTY/e7evXTDD8pVq560p0/8KwsRwC6ZM8BY3gQXnZwI71FPEdiNoRRsKnTpIXAZNR
         imQNnOeLz8ESU/VZoNMEO1OMx2lKj4eKKu+OhW9EwoZVn3adv56icPQ8cMk+bxfRVNWT
         TAi9kJCkPbtMWQOs/y5LdAz51vOhukugtNBj9WOLB3fsZmDv2vhfergygy2vEfHTQ/pD
         DgJg==
X-Forwarded-Encrypted: i=1; AJvYcCXQgqMRV/VF3ZNnn5QqMp65knxxn2SyX51L64g5Va2t+Bw5GIt0AnfsEPY22/noZK1OIKsZtsLmDP1DztjcUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGb36AkvBxBCzPDkZBGjziZZduI/gVfRTVOCVEPFAii5t6H76n
	IUgXlb/Zf4GXcJbSy3Y9dCQL6wR/dhCtDufIsXMkUw2uE86acoykYB7CURu1zYKJc9hCzj9nYir
	w3qbZ30KEoZaOoVQgtqcnPZ3gcWLaCgymCK9F1mHnaxu1/9n1S34a5FxYfQHakmJyTIU5ar6RMR
	WkdPWGIpIuHIuodvaYnWIDa0fYkxLHnXSZPlhxyuwGIow=
X-Gm-Gg: ASbGnct1PnFL6+pjIUE/iO1tMIUxWia5ergbdMNbcDL+Oi4KfG7LKlf1gUXSQ3q5hEl
	0XodgabI4tiqEKOXMoYJGHrC9ZJ/xErr/bNvxfXQZwvMzVZUtnaLppgP/xywRe3DWRHEhL3XABH
	DawlJ3KebwWzr1ihjD94kjM5LAs/eJK6VOj/Vu8edYSub5JVk8zrDOXw7l436l66CJ
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id 00721157ae682-78a8b47f539mr225392557b3.2.1764334691009;
        Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6o2vx3XDXGg+LlkIovRC1qPDpHivJwIyySPFZW+LOu2PT9QpULnJt3ZozP3PJjgQPuJtToIp2pCOkRf4ONwA=
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id
 00721157ae682-78a8b47f539mr225392307b3.2.1764334690627; Fri, 28 Nov 2025
 04:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-5-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-5-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:57:59 +0100
X-Gm-Features: AWmQ_bkpqINzOqnBww77x7L-xnpoIyN1fhsiEmRMn1madN6s7Ak0j6O_sI0bIl0
Message-ID: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9HLGam0-Rz4zJ5N0CxsdWQPJW-hkqiIyTHq-DD0tdHY_1764334691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Now that all potential callers of bio_chain_endio have been
> eliminated, completely prohibit any future calls to this function.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index aa43435c15f..2473a2c0d2f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio=
)
>         return parent;
>  }
>
> +/**
> + * This function should only be used as a flag and must never be called.
> + * If execution reaches here, it indicates a serious programming error.
> + */
>  static void bio_chain_endio(struct bio *bio)
>  {
> +       BUG_ON(1);

The below call is dead code and should be removed. With that, nothing
remains of the first patch in this queue ("block: fix incorrect logic
in bio_chain_endio") and that patch can be dropped.

>         bio_endio(bio);
>  }
>
> --
> 2.34.1
>

Thanks,
Andreas

