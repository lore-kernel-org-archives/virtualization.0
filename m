Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9E13AD39
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459948; cv=none; b=eAJivSsGd7Ay1E9nER6nyx9qck3tuClI/huPhMp6H/g/K/q/6SG+AVT/Irkv/xpXcOgrtRtAlZ3Bjlt9GYCKtxatxnTREc15AAbMP6QSjbTiqWG9IkKkhMoX/Vm96yJRqbZ0ef5LPNvM6NXbVSZfL9M3c6ezGXoAAFjJtlG+CO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459948; c=relaxed/simple;
	bh=AXLP2KyrAqjaejcHnTbI8HMVGaKN1T0qdKQjIwPuqBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uO/l2T1fEJDd4v4b49xVejwGknAiPWzkvG6E8lelFi2qqMcWMaH4MX4MtwNmk7O/zLwRHBlNds4lCUr52t89LbhOOnfAdZmixC/IAq66RhldvmLBi4FAgBmSbqTz3YBIfbdtiqzdWWOQHixvudLKZmhvO83gJAaklRd2vTtQ5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/hszYfE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/hszYfE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9537340431
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBIjGxPsP7bk for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 07:45:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 72421401AD
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72421401AD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/hszYfE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72421401AD
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 07:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728459943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
	b=N/hszYfEObKgx116tEpVQrFNhfm3vU8hYN7NTrRUrfB6YWrkHQftQEHIEiPalmpIYHQWNl
	cXsQW9kGuKaKR+GTYQ08sSUIWuLNmKtJe32BCau5s5NaQGuLRkNiajxCWVhyfo7SUZOy0W
	Qqd6KCJpwWelCR0RWbdz4SVOu3B5y4Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-8ZaHkH_FPuaxCrK6LFJOLg-1; Wed, 09 Oct 2024 03:45:27 -0400
X-MC-Unique: 8ZaHkH_FPuaxCrK6LFJOLg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e18d5b9a25so8411004a91.2
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459911; x=1729064711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
        b=hhT8Axrf5fwUPYZ8USAmxYwEmKiWG3jk1PIsBPDpWmANRKNX4AFcJns9EXXWGYrKCG
         cjfJkJHGumGl0Jk8LNcwRkZao0GnwgHK6D/QjN34h8P1q0G7Q4PS+O5O95fH2py/7pUl
         yUR/4aeh5Am0+ziu44S4ECp3OjGMOqQyOjl8w5PQ372h4vIP8msWoKy3RbEuyuEjVA+j
         gncI6ZPZOUZCuW7Gj9uRjRI055YwkwuYHdlyrI2lejCZZI7TLUkiu4QUJ3XEAclbKcNd
         RM/b6FR4foiTkBTer6+ebbLmkYP1KOnOsPaB2qu4k9/xCO6BmrVcDZQSxPtMykUPvqvc
         CZSg==
X-Forwarded-Encrypted: i=1; AJvYcCXbfuRFI2l5EofxKgfnqtlMvqdj3JVnSJlrVn+QtkyNYAMov84LItJTzLi1s8OFlPEGqlaSl1UdzA3CeL4mnA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxnBXV1UVwKRGONHzyVydM4ebqUwnPCb7JiI1b2XiW4LPyA8Y5Q
	6TIBqyOXYzvarhA3pW3JD9/k4kpeaFh8fmcz0Dj5QAUKdZ1AvCqczqctH0EKgETaaWdGgaVxCUL
	F8R3DHChhsfW168vOsSrUrwLCrTGQxriPvB5xLXMvrz1aXYUApulq/+R+MocTqPw2uNEP0qb/nL
	hicdDVGXPUhCRvTk9LAs0YU8nRq4g5st4A6OfMMukw32mJ7v9C4I/yeg==
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id 98e67ed59e1d1-2e2a2587e6cmr1772594a91.40.1728459911731;
        Wed, 09 Oct 2024 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXS3Vu8tqbV1XHkGBTCNaL2VDRz7beWlworvX+yKRqbV5bgZG5ofneJzBijB1Dsili4oRB7g3ygL6aKFSPxI=
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id
 98e67ed59e1d1-2e2a2587e6cmr1771623a91.40.1728459881543; Wed, 09 Oct 2024
 00:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com> <20241008-rss-v5-5-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-5-f3cf68df005d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:44:30 +0800
Message-ID: <CACGkMEt054F1AZP7V0ocbUce_AvQV_Cw-K21y7Ky1gWa=eSpCA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 05/10] tun: Pad virtio header with zero
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
>
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

This sounds like an independent fix that is worth going to -net first.

Thanks

> ---
>  drivers/net/tun_vnet.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 7c7f3f6d85e9..c40bde0fdf8c 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -138,7 +138,8 @@ static inline int tun_vnet_hdr_put(int sz, struct iov=
_iter *iter,
>         if (copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*hdr))
>                 return -EFAULT;
>
> -       iov_iter_advance(iter, sz - sizeof(*hdr));
> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +               return -EFAULT;
>
>         return 0;
>  }
>
> --
> 2.46.2
>

