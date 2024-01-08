Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F151C29
	for <virtualization@lists.linux.dev>; Mon,  8 Jan 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVFU+WVp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28d0052beb0so1095662a91.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jan 2024 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704728777; x=1705333577; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ABIEatGvpONoYLEnM8zujVINLyFvWCQbpURBZGHqyc=;
        b=CVFU+WVpMV4WWOFWkLVmYayBgv0ovt/5OIPO8WwUZu3AH2L9JXgvGEm7h63Y/M0TkO
         tTKqfhWz3vHx5BfbLmGDr06NojqAlpC8HUv21Z9KDdX324yTr2Ak5ghfVlUF3HOf0tPR
         XyobnuB2vhVFePfPrsZUvXwXGS1e2Q+mr4UYAO+z/wGq+oDZ8zH0XaEY9Z/X/ZB6uRAm
         03+igHNpXOjvaO616zTL7Noh7aNfCMKJq6FTFdfrW03J3R8WysOjU4GNFi8m8t9DAcSG
         1a5+QZQjy26+LzBz7Kl+3dcoYjHNFaduWgNiWyfS4oYpoOvYC8eu2r8Sm6YWWI9qfOPN
         jsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728777; x=1705333577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ABIEatGvpONoYLEnM8zujVINLyFvWCQbpURBZGHqyc=;
        b=daZFtAI/IgzFZQSoQ7Dz6BBeIvodIx6ZBXNm5CSQ1k1aiNvxnrvCz2w62YV5wt++Kc
         MRX4fXAa2g7dehDv4SQNkGvyvV6nL1vBO8/tZHJjdPRJTJq9VNdlgDpaY0f+As8ZNpwD
         sTfS3dk8KuF0HbI841g/wdhrerNvFyX5qBJMIEaOH5rfV5Uu0J20F8Pqyac7X3XHZbfe
         VrtxS2Xos+8Q+14vsmG8E9tCfqkXJVjWYFIf0QD54leQgzJ3S59jDoGrGge8k3NbOON8
         rtWS1V+iE0ZRKsTSakArrQt9nl1VLel2xGI5FbxJRsZfN0e4MKFYqrxfd45Usi/oMZmw
         kk3Q==
X-Gm-Message-State: AOJu0YzBc60yPqOzqRdkLOVQt4fQaSkNFCejr2InUA0lyXUcNtlKQz4s
	ftshqV7+XJLNNXl/m9lWeARYo/KYqoCAlAp4A8s=
X-Google-Smtp-Source: AGHT+IHZJe1ZY74k1Lg4LUidpgawMu0QAPQhvu8GZrpY+cE2pAX9oNfGVAG8ljK3e18QPKlpOElMC5jvPt+GMAfHuo0=
X-Received: by 2002:a17:90a:d315:b0:28c:d85:9807 with SMTP id
 p21-20020a17090ad31500b0028c0d859807mr1131248pju.78.1704728776801; Mon, 08
 Jan 2024 07:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-5-linyunsheng@huawei.com> <1a66f99173de36e1ae639569582feaf76202361d.camel@gmail.com>
 <705e59c2-6f46-5d39-b8da-8e2310904d71@huawei.com>
In-Reply-To: <705e59c2-6f46-5d39-b8da-8e2310904d71@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Jan 2024 07:45:40 -0800
Message-ID: <CAKgT0UdLA820trYGWkgNR8KFX=QbFbiR_AcrWXwFwrmQzaVmKA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] vhost/net: remove vhost_net_page_frag_refill()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 1:06=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/1/6 0:06, Alexander H Duyck wrote:
> >>
> >>  static void handle_tx_copy(struct vhost_net *net, struct socket *sock=
)
> >> @@ -1353,8 +1318,7 @@ static int vhost_net_open(struct inode *inode, s=
truct file *f)
> >>                      vqs[VHOST_NET_VQ_RX]);
> >>
> >>      f->private_data =3D n;
> >> -    n->page_frag.page =3D NULL;
> >> -    n->refcnt_bias =3D 0;
> >> +    n->pf_cache.va =3D NULL;
> >>
> >>      return 0;
> >>  }
> >> @@ -1422,8 +1386,9 @@ static int vhost_net_release(struct inode *inode=
, struct file *f)
> >>      kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
> >>      kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
> >>      kfree(n->dev.vqs);
> >> -    if (n->page_frag.page)
> >> -            __page_frag_cache_drain(n->page_frag.page, n->refcnt_bias=
);
> >> +    if (n->pf_cache.va)
> >> +            __page_frag_cache_drain(virt_to_head_page(n->pf_cache.va)=
,
> >> +                                    n->pf_cache.pagecnt_bias);
> >>      kvfree(n);
> >>      return 0;
> >>  }
> >
> > I would recommend reordering this patch with patch 5. Then you could
> > remove the block that is setting "n->pf_cache.va =3D NULL" above and ju=
st
> > make use of page_frag_cache_drain in the lower block which would also
> > return the va to NULL.
>
> I am not sure if we can as there is no zeroing for 'struct vhost_net' in
> vhost_net_open().
>
> If we don't have "n->pf_cache.va =3D NULL", don't we use the uninitialize=
d data
> when calling page_frag_alloc_align() for the first time?

I see. So kvmalloc is used instead of kvzalloc when allocating the
structure. That might be an opportunity to clean things up a bit by
making that change to reduce the risk of some piece of memory
initialization being missed.

That said, I still think reordering the two patches might be useful as
it would help to make it so that the change you make to vhost_net is
encapsulated in one patch to fully enable the use of the new page pool
API.
