Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4378D292
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OawGmaT1"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5466A41675
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:03:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5466A41675
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OawGmaT1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oxb1ibh0rpdX
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 06:03:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D194F414EA
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D194F414EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699509816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aizM3ELlXHXW7JfsEczOmSTmLbm7Vpen9q9fzHEgyOk=;
	b=OawGmaT1SxUL+OEdSDYoRxhE4eNQ6XaVlowMKU0UREvSnHEJ06OceHT6SVE7aV/n/oAl1E
	bP8tHkN6uhETRGuxVBjNGKZh+82JZDUx/aOYr5bs+UeXK2iZleSzxKzl+zvtthWd0fDEfA
	jkN5LZr0zrLk+LqyzDt88Gic3JdxJJA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-I2_4ENBHPMS1NRkyorKI1w-1; Thu, 09 Nov 2023 01:03:35 -0500
X-MC-Unique: I2_4ENBHPMS1NRkyorKI1w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fe7cc7cso477965e87.2
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 22:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699509813; x=1700114613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aizM3ELlXHXW7JfsEczOmSTmLbm7Vpen9q9fzHEgyOk=;
        b=xLxN8miRPIb+xIl44GxWcxgefXft/dUeVi3wFjf6kwLS/r0amf9Y3nl/4O4QU0g6oc
         /4qtDfNuNvXLG0MxLwzIKpCODd60nZ+qNNnYtA46rd4hfwZRQHVE8pJ/XcuqqMuYme5Q
         C4F9wDnCC4+7u6tQNIE+ZqxEQOOB0j3W7KhEDC2hKUB90mxXbBsXvk3y8fzjp9xU607i
         t9G0wNdayBN6NNXdgSwhqJJcEMcFrWTjeyWX7I52Khiv3j/vkPJ5AgfKHnlKjeUhd/1R
         5fSwasKk5Z0mh6jRTUjBivKNUZ8+7aLPU0+Imez+/8MPLz/YBO0K7vkH0J97UOKKXoDW
         NAVQ==
X-Gm-Message-State: AOJu0Yzxrc+hG/TK62moDGHupLet7CQG5Rf/V/NH3rQEwy3l++9htxDb
	88fHHQ7+Sf0IU/ie1SWmN/d8b/crsRrHmpADfmNR6LP9PKK/Th5+Sk5D9LGOi/b7srtyLTy/Jrm
	pqi50hpWSDJd4+PsZ0Vt3ev/u6npvjC/KQnW76rFLl+NH5fldXCeXQZfjIA==
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id d23-20020a194f17000000b005032debbbc1mr411122lfb.22.1699509813660;
        Wed, 08 Nov 2023 22:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYsjgTD24MZnXktKx7aRviir9RZpQgol0T8Q0VdFoaD8xNFvxps4WomMhc0qsMn/K7CszOgRlSkSBitpfIyVI=
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id
 d23-20020a194f17000000b005032debbbc1mr411106lfb.22.1699509813388; Wed, 08 Nov
 2023 22:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:03:22 +0800
Message-ID: <CACGkMEss6=0ZcmEV-YNSVXiH48TzT1A_VdqrUHbLNn=qW5835g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/21] virtio_net: move core structures to virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:13=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Move some core structures (send_queue, receive_queue, virtnet_info)
> definitions and the relative structures definitions into the
> virtio_net.h file.
>
> That will be used by the other c code files.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

