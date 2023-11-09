Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BA1CA95
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0DTZgeZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A01FA60F22
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 11:31:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A01FA60F22
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c0DTZgeZ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ft_J2ixjrR74
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 11:31:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F10BC60F02
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 11:31:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F10BC60F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699529493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QOLIHzEKPeNCh/zgabkL+jzDMFaxREx6dKV9oDb1WM=;
	b=c0DTZgeZpox98DZZeJBZDvBeozfjQ+cRRmpDHaEDn3DSJyD3IsIA26+NXqR7H9vQjhA/fm
	bzsg2zOIYNkqaxQoa3m3n0nCuz4SEQWIKbrfEIdl6HVxkDJljNNAFJ1v1OBVxDC3DYPXdN
	s6wMneR5CNyYn4NzxgVtT89tgMUKHxY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-YBMHnyMjP5qLDxCoViabog-1; Thu, 09 Nov 2023 06:31:31 -0500
X-MC-Unique: YBMHnyMjP5qLDxCoViabog-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d3f71f49cso2032726d6.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 03:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699529179; x=1700133979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QOLIHzEKPeNCh/zgabkL+jzDMFaxREx6dKV9oDb1WM=;
        b=Z9+WoZK5IuUF9J6UdomGCXCFpxufMCyWFpOhaK0aBam9VwvpLLL1sAU5yEQ0OE2hHI
         nIdk4szAwvDv4lkKMiT/FdWG0zts/oFiEmSQtytCiXm15lFWWI794JBqkNcvYi9At1ir
         S6hzcAsFfrYqd2ieo1/0YWpXHyvLkl65tpQURZTlri3yMCHH0rbnO/QL/y503+AJO1XW
         /8aGfZXpsqTIncyfG3CRD86EzzcWCksmuFO+zhSCEgCtTnCbLEbz6CJQ4QotEul2ykVK
         PsimZM8piDI5JAf2bVS2BRovt8DG/UZRWTU5J/6LG/QD9P4QmKUh4ybpWad7iFfv1qex
         i4ow==
X-Gm-Message-State: AOJu0YyZF0jG39zzVSXxd5TTBypszDDFUx+EcACcBMFwr8ehFmpgDNB8
	Yctn3a/egfRSu8n3NsVnEBftBx3sVAPom3bEmjfijZs6LDAWv0Wb+yBygQGJmwqdWqvLZaldEbQ
	t6z0aO8/Uuuldp3wGRW0S0dR+Xvjo54iq8D5Fi6Vk8Q==
X-Received: by 2002:a05:620a:45a9:b0:76e:f686:cad5 with SMTP id bp41-20020a05620a45a900b0076ef686cad5mr5084603qkb.5.1699529179545;
        Thu, 09 Nov 2023 03:26:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzhfzLTv0xAs1B5hXemffnBR5aKAeewM9gbMza+Bp+J3sYeUTQb2pJEf4lKCHCpO5xH8zhig==
X-Received: by 2002:a05:620a:45a9:b0:76e:f686:cad5 with SMTP id bp41-20020a05620a45a900b0076ef686cad5mr5084586qkb.5.1699529179275;
        Thu, 09 Nov 2023 03:26:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a415200b007659935ce64sm1923132qko.71.2023.11.09.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:26:18 -0800 (PST)
Message-ID: <3f8e80f702eaceb7491ba7117663034eb48cff3d.camel@redhat.com>
Subject: Re: [PATCH net] virtio_net: fix missing dma unmap for resize
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 virtualization@lists.linux-foundation.org
Date: Thu, 09 Nov 2023 12:26:16 +0100
In-Reply-To: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
References: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-11-06 at 16:18 +0800, Xuan Zhuo wrote:
> For rq, we have three cases getting buffers from virtio core:
>=20
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
>=20
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
>=20
> That will leak some memory, because I did not release the pages referred
> by the unused buffers.
>=20
> If we do such script, we will make the system OOM.
>=20
>     while true
>     do
>             ethtool -G ens4 rx 128
>             ethtool -G ens4 rx 256
>             free -m
>     done
>=20
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling merge=
able buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

@Micheal, @Jason: this fix LGTM, but I guess it deserve an explicit ack
from you before merging, thanks!

Paolo

