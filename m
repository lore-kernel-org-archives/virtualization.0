Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE822620E4
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254788; cv=none; b=W0PE5FTCjXJCtwA5by8KIV08ANPrE+9RRHLKi4eyJ2juAEqwubpYZhQG6OWa5sXTy6NloW11i/Hgqd4O64jgN+M1RyvSuRytTkAR7SCagvrq4IuiHvfXWVFzVouYPkQhnPMbnrLGCKyfYo2MwN+MaCfBHJGrjG5O8Fm1t56KMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254788; c=relaxed/simple;
	bh=IR1GJIw1WogTr/OB4lNYncQ1ZxCQwr6Kq+gJH+Iw0t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leCgK80Od/21PQRPUlVbRwdEZxigjuL7emy9qMQO59k7nV3czaztnNXBI30AWyfQDSTPxLnJhpzVyg+DqI4uptZLFoihdZXymj2nAeWUZigYxGrUKsxbknTS264L50L0N112A+TGBSV4T3SZ/WG9Mxrpurbz1CqLBCInCZazQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdzt+Ip/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdzt+Ip/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765254784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7tlj801JGEwEviglxOLZTOSOnNkUWu4oKsf3XJ8MAU=;
	b=hdzt+Ip/5KPBlNgVqwVJcUZnnn8YW54v/OTfTPGXMx1YJS09DGzpb7+F2+yhxjDBbaDm+n
	jHLMOqyEAlbA24+Tex/tcM6I/YbVDy6Kny2X2FIvxLFNCU2dj0gLtW8/EFLMC2mM+2ORkW
	y4MTJ11emn7EyoWou/qOfVTEU1QtFQ8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-X9Kln-DlN0eJTJVLNBx2EA-1; Mon, 08 Dec 2025 23:32:58 -0500
X-MC-Unique: X9Kln-DlN0eJTJVLNBx2EA-1
X-Mimecast-MFC-AGG-ID: X9Kln-DlN0eJTJVLNBx2EA_1765254777
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3438744f11bso10165452a91.2
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 20:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254777; x=1765859577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7tlj801JGEwEviglxOLZTOSOnNkUWu4oKsf3XJ8MAU=;
        b=QQObUX00mWu5zOyqMkxlBAbd59c9ARZskiYKEia/+7EEiThiXqg/pYKSqNSRiwp7Jt
         juGsEQrto38LNNRglg5SBHhhcW4qKiUNmkWKej4JejXdCMyVEjJko2XWpx0zrKCczdG6
         6/QuUEkTZWHYERRtHTXV90zRsrw5HCr9/RmnLVQciWHFCSsPJqjcMYcMr8HkeuW7pnCx
         DILc9Hj4TPshAQ6SDD/d+LZu8jzfgsHpK/wkMZV/seTg5uSHRPIfsXpqZjd9+/TRoANs
         rFCSUlaA6XY9f6XKI1eVyBR7XMNaiImwzlJLO5jG5yjjfxg4EDCrC+Nw5Czb5rjpCUAg
         k0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWimwtmHNaITpLwuHjr5m+L7lkv+NRzjxZ7mUaMeML9+f6gyyu7ShMHW0lRpyI/eC3QJe1/XqI9Uk9b1SJGfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8Sm67QTkj5oUrI5MeTWuZeVFVuhQejfF3i45Kmxc4+rmxiGf1
	9sY1nzhjVq/+VhtHdfmygQzzUc5CQVE0b8FPiPcfgPJD04yuuaUss51QNVspxoxpzQmXCufMEM+
	kMCbgg/2D/AeLaAU4GZ+ayidQgxqYvHTZk0+yY4SusgMxJ+Th8w+bVFAA8hR6SrIQzgzXfs9hbh
	apL8AxQitGvtxWqxUjFjRFyYiT29n3Pe9lzI24NUvZzTE=
X-Gm-Gg: ASbGncvEQ1aQPvchqqLmJXsTUZ9wfIk99CikU7OYI6OoeYEaIJM9nlseuriYqKVcfvM
	eyvD1+Bvwy29iORNon5x58VFACgM57UaSPZZR0WpvyG0E2kDlNYFYuAk+NMvnfE0FiLrJR4Lcd/
	KCxMSvnDx7PD+9sG8kXS35aQFdQsAIsX2S0UfSEotyxNJx9j0hWunhRmzlQFmP564B7Q==
X-Received: by 2002:a17:90b:4b02:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-349a24e1417mr6855267a91.5.1765254777264;
        Mon, 08 Dec 2025 20:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdw0M8LAPWgyO/elXlfshz40Rlioju2PuyFc9XLzszeCdo7ctlmBpq76QMP0pwFL39U8NEhUcTgC3HIYBdbo8=
X-Received: by 2002:a17:90b:4b02:b0:340:e521:bc73 with SMTP id
 98e67ed59e1d1-349a24e1417mr6855241a91.5.1765254776843; Mon, 08 Dec 2025
 20:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251209022258.4183415-1-maobibo@loongson.cn> <20251209022258.4183415-2-maobibo@loongson.cn>
In-Reply-To: <20251209022258.4183415-2-maobibo@loongson.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Dec 2025 12:32:45 +0800
X-Gm-Features: AQt7F2oiXNzEXvaoIJ5PYmQS-SgPLwwMhAbf5fZFgBwLJ4Ewmxplg8YGZKVBbKg
Message-ID: <CACGkMEu3rhZy6hiZ14AvXgXLz2KvwvcU81KNrP_XsM475ZM=Nw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] crypto: virtio: Add spinlock protection with
 virtqueue notification
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	wangyangxin <wangyangxin1@huawei.com>, kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	stable@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q-EcKbt3bhEb3yjO2z7By9XtzzYM7UlYSy4dDnvRReA_1765254777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 10:23=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> When VM boots with one virtio-crypto PCI device and builtin backend,
> run openssl benchmark command with multiple processes, such as
>   openssl speed -evp aes-128-cbc -engine afalg  -seconds 10 -multi 32
>
> openssl processes will hangup and there is error reported like this:
>  virtio_crypto virtio0: dataq.0:id 3 is not a head!
>
> It seems that the data virtqueue need protection when it is handled
> for virtio done notification. If the spinlock protection is added
> in virtcrypto_done_task(), openssl benchmark with multiple processes
> works well.
>
> Fixes: fed93fb62e05 ("crypto: virtio - Handle dataq logic with tasklet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

