Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E759939
	for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7IS8eqG"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-593efe46fc2so638348eaf.2
        for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 09:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703179040; x=1703783840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k/akrlSrIkTy3hb1h59+fzAYQnpfHVd+WuEcLTR0W4=;
        b=B7IS8eqGybXwI5a7nl2uWCkJuaiULmvBH/+8azM1dO0sH1Wwcd3Pj1XgHP0c5NFMCq
         qukAHqjotNnZYsH1so73bJFeZXkvRwTWZmfFwgkGdP1ntvKYosFHPwaanUcMozeFWoHN
         ts+RviaqvmrurP/jGWwn8w7cYGfvauFN6ZbBShTumdrJdJo1WZeFW5uJVRYUbKU8ylo9
         6XTMmWhJ8+DCfPzCz0dDd9XKviZcQ7JBGKjpEofm2e9HtZtOLRPO8CrSqc5uQVykQ7jY
         GEl5lkXgxDfm9uxzblu5iE3xs0KaxB9r3JZ33bHwlwhQs6ZiYqOIIW1XWWi4rHYCoRFI
         mNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179040; x=1703783840;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6k/akrlSrIkTy3hb1h59+fzAYQnpfHVd+WuEcLTR0W4=;
        b=hjH3bnfQO+hxPPnr7KhEpD4nZ1jVUGB+0QVxfpBB7491FUoMP4FSKy1Z6l9yof4gQK
         h6KrnljyVt6AYqGyXWKkac5bGJ1GTkXzWI2c9YCsJgF0NJ/UYZYAOSP5pazCIn53qX+L
         ECeOfaDwq3wJsJzIta/FymdrwgiwtUB8TivKQiqjVPaAo3F0E7yX9JxLZW8T/8KEn2w9
         QQ+emDbtZOlGMXUPPSc/Dc6V0rERzQHq3BVYw+CrPvPCROTBEykJsDkpiRKXXE6YYBps
         1Y4yw14eKJ2IGJYrQqjIbyzuaEp0OJWNwkPwidOPs2L/ZBKDW4Pu8+L0c4CqkYfeCgho
         Um9g==
X-Gm-Message-State: AOJu0Yzz5yO121GxTr9ciklfxIM9n1kUb7A43vxTp0kySvYYsa8363ya
	isHouK6zHWxOq8EGzhHSMT8=
X-Google-Smtp-Source: AGHT+IFki5T/xVwmQL5dFmzj3FLdojbmNHX5QYyCXzO6/5w9UYlzrO/BVHdyKVcnD9nmaK33+NEfQg==
X-Received: by 2002:a05:6358:724a:b0:172:ae6e:bdd4 with SMTP id i10-20020a056358724a00b00172ae6ebdd4mr57936rwa.7.1703179040274;
        Thu, 21 Dec 2023 09:17:20 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id bo9-20020a05621414a900b0067f7b0904c3sm755136qvb.83.2023.12.21.09.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:17:19 -0800 (PST)
Date: Thu, 21 Dec 2023 12:17:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev
Cc: Mina Almasry <almasrymina@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 David Howells <dhowells@redhat.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, 
 =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, 
 Shakeel Butt <shakeelb@google.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <6584731f9eab1_82de3294d0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231220214505.2303297-2-almasrymina@google.com>
References: <20231220214505.2303297-1-almasrymina@google.com>
 <20231220214505.2303297-2-almasrymina@google.com>
Subject: Re: [PATCH net-next v3 1/3] vsock/virtio: use skb_frag_*() helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mina Almasry wrote:
> Minor fix for virtio: code wanting to access the fields inside an skb
> frag should use the skb_frag_*() helpers, instead of accessing the
> fields directly. This allows for extensions where the underlying
> memory is not a page.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v2:
> 
> - Also fix skb_frag_off() + skb_frag_size() (David)
> - Did not apply the reviewed-by from Stefano since the patch changed
> relatively much.
> 
> ---
>  net/vmw_vsock/virtio_transport.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index f495b9e5186b..1748268e0694 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -153,10 +153,10 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  				 * 'virt_to_phys()' later to fill the buffer descriptor.
>  				 * We don't touch memory at "virtual" address of this page.
>  				 */
> -				va = page_to_virt(skb_frag->bv_page);
> +				va = page_to_virt(skb_frag_page(skb_frag));
>  				sg_init_one(sgs[out_sg],
> -					    va + skb_frag->bv_offset,
> -					    skb_frag->bv_len);
> +					    va + skb_frag_off(skb_frag),
> +					    skb_frag_size(skb_frag));
>  				out_sg++;
>  			}
>  		}

If there are requests for further revision in the series, can send
this virtio cleanup on its own to get it off the stack.

> -- 
> 2.43.0.472.g3155946c3a-goog
> 


