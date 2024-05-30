Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAF524A6
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039511; cv=none; b=H1kj37X4EJhNdDV7DD+1IhN1/4EISPpALKJzGJv2emaQ+z1SdeBXM0H71ZO0ia0mMdcD9khMKClccxxDkeNjqFWE+fG1zxFl4y48SMQDmsSgFxOdLN2CSr5pcGtLPQ/qH5gHWPyBJwVNldAzb/mCfVBcftVTT5eur1H9DdERWjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039511; c=relaxed/simple;
	bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIoeAuc0YOaDiKQboTMI1WHKVgIs8cJWOvz16QY7Sc+RVNhqTzbmcmGs7n6cujfH8JO/fjlGtcrp7qlxm8NeVnMq9NwD2Hf36liPLxsv242ISrSYaUIk5UGyNC6Vhd94RzxjbkOMOe4z1JKTnJCWFrQIqYOQDlq2HVLoNYu6eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbkL/bDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbkL/bDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
	b=EbkL/bDyyCnbTlfMhKjg2EA73BKgum7OvOs7T2emyWNsFwqB7AhsmJ4SwXT9ieinCV5IbN
	cMoWjfLZX2crkONpqPKW39MC4cE+me8DofdxOCi9Sc7gVaYD8+DeMUPTTxpIp4vOowI/Z1
	fxpQX4UsB+I9B1u9Shx3s61Go73cH5M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-76NS_AGvMSO7Nb82lAP_Kg-1; Wed, 29 May 2024 23:25:06 -0400
X-MC-Unique: 76NS_AGvMSO7Nb82lAP_Kg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c19ebab03eso435539a91.2
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 20:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039505; x=1717644305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
        b=bWGAgHrpWqHsBWwLMyTeYTTfPkOeSWaiEjv4Nb1h9jCC/7YjnIZaURYaVgCXFU5c9b
         Tg9z+fXsmZEEkDsxuC3ubaffGNGIwClgxE8VsoGNNTC1omD/2t7RuoAgcSzwGocGkPPx
         YlzbDKiR45DupMEucZA0kOZ6ZnrCtV2fs7O+f5i1dngIONaOOkck7LvJm+AihGjM1XkJ
         0LRQO1D1JMkjsCyTjGc/z20Pa86lzBeAe35RTqzez8kch5DgpscPxdM8y1TcGrhiNq1h
         33XywrYFiEKo5IHskN8z/C8/3H5uY0UnlYvDx5sva6I35YX4Gxo/6693Eb0okUQqI0+s
         IPyw==
X-Forwarded-Encrypted: i=1; AJvYcCW6MtG1R8SMEvM5KkfAbS3cVQjs2nzXPBjOoaq7dNlaOi2io+DY70pScAnmB6wMqaDyE/tpodd/jIoIyBPPiVo+zAXYKsAySVnBknAu0Wg=
X-Gm-Message-State: AOJu0YwFG67RIqn/Y4Zp1SP/+TkjQhRamsorrriAw2NY0E19rFPXFxFA
	6bAvGk+ZsXaP1K0HomkmJQ6A5vASZJOQKTsPU5Y1OIkfixPyqF7tO5ZBpO84O1C7UJuhO76ngRZ
	2xUt4Yvo5dEsfPpJyZ4+ZbVymzVL1Rh6eBI1i8qVH7qTvhP+ruT9y4xIRJPmu5WRNrlP06UeEJG
	bS3BcLCWb1K2tVp0wKH+OshZQEFC7wcAnuAP6njVA=
X-Received: by 2002:a17:90b:360f:b0:2bf:8824:c043 with SMTP id 98e67ed59e1d1-2c1ab9fb68dmr1011589a91.18.1717039505523;
        Wed, 29 May 2024 20:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG96xKooU/90RmHTSiFiV3oOPsdUF20/3dw7DdogIGRjKcpmQnv/lRyL3JORNQzenL8VZoz7eZ4oHhGnDiVoTc=
X-Received: by 2002:a17:90b:360f:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2c1ab9fb68dmr1011570a91.18.1717039505002; Wed, 29 May 2024
 20:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:24:53 +0800
Message-ID: <CACGkMEswH8X0utO-ORZ8g-4UELfhxxDxdAaycwxUdVR2uxw_ww@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] virtio_net: separate receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This commit separates the function receive_buf(), then we wrap the logic
> of handling the skb to an independent function virtnet_receive_done().
> The subsequent commit will reuse it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

