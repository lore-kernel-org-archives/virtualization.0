Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3777650
	for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geK9on1Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3a9b9634dso40525ad.0
        for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 13:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703194807; x=1703799607; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB0ZY+nBxKTPkORzoQ6ZJO9teY19uCFlT+Q333mOXAc=;
        b=geK9on1QaXZ5haUHYYpx1SC0bp/cvtVsRMqfDg3ZvLsuOt682V7MzA8Hn8ORYaH/Pu
         xmuNK/5dW9cOCEmVQ/VmzWHdozy0Lrs1FB9O1PXglIxa1ZODC883opKMW/Ox40OjGXVe
         tqEnUsf1lg94xj0w7K8DDJytUVznCAI/MdTOPsnTSjLaoPByktdW1IZODtqsdUMBNgHv
         Zmd0GIGgvM3+mj2CCw5K/GRrJIKvydtgT5KzP6DHxDX5b/3Stk88wBd0tpdr+6kLnoFf
         wpdQ9C3xk1iyS+UgrXOmmWqnFgHJ+dwEi7kfSNhQfsdurGBslXRm6y34KGf8TMNjNaCE
         luQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194807; x=1703799607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UB0ZY+nBxKTPkORzoQ6ZJO9teY19uCFlT+Q333mOXAc=;
        b=CcfEaVdH4xgslUqlecRA5/Pj3QVYxug9vphLxbyaEpLgCbwz1Hv6dE+9fqcdbz6tMu
         n8ky2CeknCUfPBxuuo33KppGJGGdv+rlTUTENUaPaKRnWG1yHQ7lU5XtdXrYUaPAfIml
         pKZsXfNKhHvB/CUfv7WvajPCivIdYn8TfpujlMEfrLUHpobU1/KEDkjsSAwLGidmwblS
         xHP403rD6Xqf2RqT66wdsPA+3vIplxCaPzIPo9UEh+ZPfXzvd1V/DZtqitpiQ+ZYmnmt
         0g+W1d6PJdKGi1U3F7jubkmxtF0g6x0o4owJIvvQfEGPJiTVzC1xDEO813vpiPT+aXZS
         uMSQ==
X-Gm-Message-State: AOJu0YwodhAvO59Op+JjB6cENdAn3e7onnF5D4jRWDlbmvj9+GtHGosP
	LJdnPm0gLUyRN3Nt7Rhx+e1heVV+IT+swIdP9e7KLic7qMBP
X-Google-Smtp-Source: AGHT+IF80tZmsHPhE6wyckD/RAEBLEIynH1gwHeElMtN5TBkrj7syIFvBO/ajk9EvH4/NsPHbKo1N7hcl3mhL8zriwA=
X-Received: by 2002:a17:902:e84b:b0:1d3:a238:77ad with SMTP id
 t11-20020a170902e84b00b001d3a23877admr40283plg.18.1703194806799; Thu, 21 Dec
 2023 13:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com> <20231220214505.2303297-2-almasrymina@google.com>
In-Reply-To: <20231220214505.2303297-2-almasrymina@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 21 Dec 2023 13:39:55 -0800
Message-ID: <CALvZod6bwWBuRZ8BCjUiyec2wR6hBSwrdcEzEM6d+9UdmCQBGA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] vsock/virtio: use skb_frag_*() helpers
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:45=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Minor fix for virtio: code wanting to access the fields inside an skb
> frag should use the skb_frag_*() helpers, instead of accessing the
> fields directly. This allows for extensions where the underlying
> memory is not a page.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
