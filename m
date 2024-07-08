Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8ED25634
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426229; cv=none; b=cwSfkxr99FIHtIBP9uhlPQ1aQn8gAqab6ZxohTX+CFJ4vuRFV4KPvevogOfoO5uMd036pOimLdNNYRd2yFIjfoGbJ3/IQH4zG4EGNWpAKEA3wxPp6TGx2CKavE1B6GP4Rl8hdEIv0kXFGtuT9923TxxMUCxRyEt1gTMwn5zz8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426229; c=relaxed/simple;
	bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUgSISLhu/kg3gnZ6h0B120Nk4zCm4DBeGeZxENIexwZeOZSxq8sNhCzcTgoT3zLQJdeZ15hk1MiHOduCPLXccdX5+N9AQSI+JiAcUC1ryq1W8ji/RWMJqw1BwxlAYBrwu1xLSd/beGc92mGzyjfoqFGAR99v2alQrUbeGN7AYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+RNzjST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+RNzjST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
	b=T+RNzjSTO/xHgl86QTjdiUcC6UjiZ5ZOyVO82gCJ60hMLt1rxKp6HGs163YbKUHJFwlnmR
	0ZefJnA9kG0cJRy0q42+xt+snMLys39VPg0T8JCzQj+TJRykK2yVjMP/J14GOB9S4zGxqm
	0GDgAEmi85J4Ml9BSAMu92BtLrltcmI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-P64qauVHOOORDtVFR4vTkQ-1; Mon, 08 Jul 2024 04:10:24 -0400
X-MC-Unique: P64qauVHOOORDtVFR4vTkQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c961f68638so3876077a91.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 01:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426223; x=1721031023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
        b=bTg9+vgp/xGcYCjKjkvW1jefsk4z9s15JdzMLxYcVqbWfFhWudoc1GWQq235Nm1a2Y
         ps/7lDBR8q9L9HbfqLJNG3tkTMww30Jxgv3hXoJSzhPzfay7GrKqVdA3lb7DNT9gDda8
         9U3k3JDb64smssORCPjqx1ubqcRzYkvtGZFLPOhwuf7mtpy0PsXO4r5Amj2PfaP6GNcS
         X00KxsVfH/H57eFzWrgl9EpsufKVx8i4WeFYpOVYMmTC+FRmMm7yIU+4RjXw7OUd04Wj
         MAWVTCu5kz5E8wl+PUIkMQMcQtEHay5AvPoWqewqmZkYH+P+4/YIROAGoovjf1D3IumE
         iofw==
X-Forwarded-Encrypted: i=1; AJvYcCVh8peu8nPQ/xVMYNhK8THx989MwkUx0G5uZNItTUEPFwZ//QRUuP7o47vygdLvZ9Q6NmJohl8JmwtO2GDrTCXAYsq1VrH4SpDDiDJC16U=
X-Gm-Message-State: AOJu0Yzlafy32roJUmcLdmNe0yVDqNFNSZ710/SAZcT9gL12JJVsXY9G
	FsEoLXinRl6gH6kyjWhnszX40SaLx58H3fRaGWXDkOm1x2VOdYuZHnkcg+AjMJ6EwkEIUTSqHMN
	dat5I2h5ntVaFLDny5d0RdDQE0+EDCGSoOpfxWldGqeh8xn1W8g8ql+ltzpCf6CqJORbkIe69rd
	NVkeJHU9fWV02baC5JLUKRffKwq5drdvqs6usiB18=
X-Received: by 2002:a17:90b:23d6:b0:2c9:a151:490e with SMTP id 98e67ed59e1d1-2c9a15153dbmr8352848a91.18.1720426223151;
        Mon, 08 Jul 2024 01:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3jzysrr8JPHGiFGX+E23ysYUxoH7WdqJzqCtsY1jBZGjVa2BZrehl9IuU0V6yjZwl3A3Ox61aacTd6khZXQ=
X-Received: by 2002:a17:90b:23d6:b0:2c9:a151:490e with SMTP id
 98e67ed59e1d1-2c9a15153dbmr8352833a91.18.1720426222760; Mon, 08 Jul 2024
 01:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 16:10:11 +0800
Message-ID: <CACGkMEsorUJC0fN=QWbb=K+_ShJcyqSGYRPV=omSJRe=SQfU5A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/10] virtio_net: xsk: rx: support recv merge mode
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

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Support AF-XDP for merge mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

