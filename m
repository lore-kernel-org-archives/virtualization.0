Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5B42AB1
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029195; cv=none; b=LWx3Sw7mf4zBWwKE1urwQ55OJ404tw2jhxEq9QbGO6T15U+kNEBlQWTGhV6eP4eAY0AZHsBKn8QShtEIg9+Z8uu+u7qdS6bDHHb7+F1c4rIweOhJdxfTKdYBEkIGHBGy1D8mZ+sPssaJXc+y8VNogiKZZa81c/jLUWhL/y62Bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029195; c=relaxed/simple;
	bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq42gpIEkMsgqRS5293U6rY8i54tFaCOgEDtKzZe5gIGIjKFniJ27ltUs9BpyI5yUEsIiIx+nd/UsMuHI6z+1rSTzUF66vldHXUSWJyRwo3H5iZRvbJ3VBeoI9MvDpOcE3OaxYQTqMZdMXnh6tJ4qyVZnfrpbZrncxHeEBe5h8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EoQABhVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoQABhVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726029192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
	b=EoQABhVW7YGshumeWTpGLHelEfIPd4WS4pFPx20nLZlhrL8P5DAkIovb+KHkwfRjxQAn3U
	AVm7HAk8KgGRfBX2YBXneTuCObA6r9DeX7jE4myBypThzsG2RzGYeBSzcKj5blsxc6xq1d
	mjnrtYxGoJ6ajL8wAE6+EzQ4CQ5jOgw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-h19A2ECmMwWklHm5yd_nDw-1; Wed, 11 Sep 2024 00:33:07 -0400
X-MC-Unique: h19A2ECmMwWklHm5yd_nDw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d889fc26e7so6438948a91.3
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 21:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029186; x=1726633986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
        b=clZb+2ncpaeDwpV5eygO1CticxXXL0qW1zpNttyWIUmwH7Us+lbJ+KodLCyM3jpu/6
         QJvkUkbHvryXEk/SJq1iONV8XNGU/5p6myB3Yg+ke08hD4EWokHAxDLo3e/CF5gGwHal
         HWGcbj0vDNU625ToszWAX42xTFVFL65mELVEMUT86GsoBUemhuwBQx794VLkH1WFa4lD
         QYAB4JIkcqEdlspZw4To8wALpkva6DyPcLAAbeakYE2M/+J9PqUjQYaH6ogwZxKbO+4+
         9YheGlJULZ+67Mg9M6N+W3Gha/nfQkaPZadmLjdlUlYqepGZjO9+sitkAlARctTOO5B8
         Pb3g==
X-Forwarded-Encrypted: i=1; AJvYcCXnqaWOLzSCtSKfJnY+umbNRSVauVJ8MVCuL6X+IDwBYpq+2rzH0id9wBCyQe3MtPWXrHqxX+f/CqjtbGbOVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZHyIc9DKwI7m6sDWq28JOu+dXGENlU0OKpi9S53ComyvH4RO0
	U6nknMF3/jKEq8cMugpNScRsxXdiiiQeq4x2uhQDcWoo+rVndYf7ycxe/T9bhWf1ZqpKU5/A10F
	AnSMFq8D5OyZSJQZAbete3d/CFzJbK9kRPHGHekcYj4pqwn9Iv9MAIsYcRyemgKXL02tOfFqh68
	x6efRx3Y08irWYmZMIvogd//RkglhNs5yglArbFqc=
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id 98e67ed59e1d1-2dad517f7afmr15824632a91.29.1726029186408;
        Tue, 10 Sep 2024 21:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3GVsn/LMGACZj1UXWZbjl/jqpQUo45nERNKW3tBta8SrZSl+483DwLY/qxFy+Bc3SjR46sSWGjFODet9XREc=
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id
 98e67ed59e1d1-2dad517f7afmr15824604a91.29.1726029186020; Tue, 10 Sep 2024
 21:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:32:54 +0800
Message-ID: <CACGkMEvvKsypiOmdhWKjNhXJ9fS5SVYQFzK=KtTr1DdyMOv8mw@mail.gmail.com>
Subject: Re: [PATCH net-next 11/13] virtio_net: xsk: tx: handle the
 transmitted xsk buffer
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

On Tue, Aug 20, 2024 at 3:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> buffer) by the last bits of the pointer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I suggest squashing this into the previous patch which looks more
logical and complete.

Thanks

