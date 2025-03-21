Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8898233133
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595373; cv=none; b=e/EY0LisQFHbQunPIGw2m3NoHntTjDk/qra8f0//q67BXQYa5BqP+7ULYS0nLSzuA0btaN3tzpT2UttP2Sj1gmE1MofDiB9apKTqG/5gO4WZLQ7KGsS2fQhf9JFAAj0V+PF6K7pF2TGA4a42DzmnfBc3Dk/Ej1UvedBEnd7iUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595373; c=relaxed/simple;
	bh=xTN8uHl1SeuIX+6Go9vzBRBl5rKlx9/gkpF9UMsFCuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIw8aqvEm7WfdBsyXiPrFmqa2KhUkzi0l1J11aoHPcY/P/FgxY+LD0pDQ3mw17OewLhJoiWYZzd/k+jBB/jZ3fhjIhiPtr2LZ3/mSA4Nrw8oRG8bc7fgW8q6n8LFkv58dJxlT+Eklx6C9OuSP3A4+onYGF+kuey+O3Vusmtjd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUn6aqSW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUn6aqSW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so75795ad.0
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 15:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595370; x=1743200170; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KM/OqzMgVHyAstUImFrYrGve1V5xobanjZKdFyJS9w=;
        b=zUn6aqSWksR29KVYY49f2o4aVE3hT5fWU7EDDfL1sOOSx2ASEx52FZ3u3J/2l2UEKH
         y4OaHwCrbmnXBgFch8SNA9SXyiJXcvN+RBqSpYh7VUqomxNGdKhjACR+rost7dPSuFTc
         ygUshskMvocwuB+7xFOnpmwgWaLM1lW41azD+xOkFJQ+XmwqFZ2XpeeWT7eWtB1yX3BD
         EFujb8tnxQaYD3ICTbAr0+kSsJmaMfP56i+a+VmwYyJjQ3yf3sWO4qMAAqdrKFDEQ/0W
         l+FXFAWK7dNN5ClqUwwFAjfCoE23F2Bj7ZUIzekuIW3Vh9wBQZ7MuXSN3MFCb4xymW/1
         KQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595370; x=1743200170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KM/OqzMgVHyAstUImFrYrGve1V5xobanjZKdFyJS9w=;
        b=HWyv810S1UM/KxBQ72JNDuiO6aTj6B8ZQyqKMG3EBwNHpoI5ps5WS3QOIE64GAefzw
         cbTTjbrkqxSqBNzZGosrvpH0mwiAD3Wojs8K0GebRSLjwEcWzp7mQ1z6qYNWDbmXVYYc
         797QWwnHNLUdP1nYjQB0OrW/TyK56o68+sJn9dGNZ5qLyXXcjl4PsvvZk3XXhOSJz2+M
         jNg3CDA/9MYZLO1htifqL53kmWt6ejI9UbFP1HsGjU0NOHtxFbaZYGuguVaWBx//sKbA
         Q4GHTRz7rfFepRP0xe/lmRA1luGPYdQcew2dDNYm1wgOivQXbTLM6+8dlrsRqvjOTQ2C
         NJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWOrAe+eNVLpsx6cyXQB3Nq/KON83WmKB3idd5yad+WNUpAGPvszds9Y330CUGzYFVqOJpvGcY9t8fB4Y7C9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf7eNj/hXJdMFAeOzlPm6bQOQRHqPtmS5KHOsn08f9sLPAAktz
	lregD3kqNKdaBaek0OsXEaDybu1JDBIOe5hMHfyzHqz4DmJnkladdy/qc2XlNK60KkJSiEi3fCz
	hPFq8ZLMEf92oKVQH/tHKEN74Zkqj6NxRm1YL0daEfEm6/O9QoUmBaT0=
X-Gm-Gg: ASbGncsP2AFapZTRAV/VZ62ZKoDOL5CyoZ9BowUk6YZw3CW51S1HQN9ZCyV7cAfJcAu
	wf4mtBF0hF4FVdA2CBIjjSLLKeIUFa8+9Qsj7t/eYXMt0qxrkC2XWGT/bbwGGK2C0jqdYva7Xxy
	01sgVAzHIE3NC+QaGda5CrGYNuq/mxxwBe8MKAHxCsht8eYMsldxaGzSE=
X-Google-Smtp-Source: AGHT+IFB6PSWq8585YC3bfe4eP32Yir6EYNkFzXJi8bOkq8iwWtXfNlhA5baw0lPh6UvS7ldsM4iZisORLPef1bKOlA=
X-Received: by 2002:a17:903:19e4:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22799f6adb8mr317095ad.7.1742595369962; Fri, 21 Mar 2025
 15:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-4-almasrymina@google.com> <8fb48d36-f5ce-40ce-bb05-b4c342da8b4f@redhat.com>
In-Reply-To: <8fb48d36-f5ce-40ce-bb05-b4c342da8b4f@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Mar 2025 15:15:57 -0700
X-Gm-Features: AQ5f1JqTqeE1hEQJimNEPqykmM1XOpBm4kOaF6t5YahF7_VNclL_518XjsZaXEs
Message-ID: <CAHS8izNu6biiVg==pri8PeDVP9unZthGrwSj4fGr84o61sLFgg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] net: devmem: TCP tx netlink api
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:39=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/8/25 10:40 PM, Mina Almasry wrote:
> > From: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Add bind-tx netlink call to attach dmabuf for TX; queue is not
> > required, only ifindex and dmabuf fd for attachment.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v3:
> > - Fix ynl-regen.sh error (Simon).
> >
> > ---
> >  Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
> >  include/uapi/linux/netdev.h             |  1 +
> >  net/core/netdev-genl-gen.c              | 13 +++++++++++++
> >  net/core/netdev-genl-gen.h              |  1 +
> >  net/core/netdev-genl.c                  |  6 ++++++
> >  tools/include/uapi/linux/netdev.h       |  1 +
> >  6 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index 36f1152bfac3..e560b05eb528 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -743,6 +743,18 @@ operations:
> >              - defer-hard-irqs
> >              - gro-flush-timeout
> >              - irq-suspend-timeout
> > +    -
> > +      name: bind-tx
> > +      doc: Bind dmabuf to netdev for TX
> > +      attribute-set: dmabuf
> > +      do:
> > +        request:
> > +          attributes:
> > +            - ifindex
> > +            - fd
> > +        reply:
> > +          attributes:
> > +            - id
> >
> >  kernel-family:
> >    headers: [ "linux/list.h"]
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index 7600bf62dbdf..7eb9571786b8 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -219,6 +219,7 @@ enum {
> >       NETDEV_CMD_QSTATS_GET,
> >       NETDEV_CMD_BIND_RX,
> >       NETDEV_CMD_NAPI_SET,
> > +     NETDEV_CMD_BIND_TX,
> >
> >       __NETDEV_CMD_MAX,
> >       NETDEV_CMD_MAX =3D (__NETDEV_CMD_MAX - 1)
> > diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> > index 996ac6a449eb..f27608d6301c 100644
> > --- a/net/core/netdev-genl-gen.c
> > +++ b/net/core/netdev-genl-gen.c
> > @@ -99,6 +99,12 @@ static const struct nla_policy netdev_napi_set_nl_po=
licy[NETDEV_A_NAPI_IRQ_SUSPE
> >       [NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] =3D { .type =3D NLA_UINT, },
> >  };
> >
> > +/* NETDEV_CMD_BIND_TX - do */
> > +static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABU=
F_FD + 1] =3D {
> > +     [NETDEV_A_DMABUF_IFINDEX] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [NETDEV_A_DMABUF_FD] =3D { .type =3D NLA_U32, },
> > +};
> > +
> >  /* Ops table for netdev */
> >  static const struct genl_split_ops netdev_nl_ops[] =3D {
> >       {
> > @@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[]=
 =3D {
> >               .maxattr        =3D NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
> >               .flags          =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> >       },
> > +     {
> > +             .cmd            =3D NETDEV_CMD_BIND_TX,
> > +             .doit           =3D netdev_nl_bind_tx_doit,
> > +             .policy         =3D netdev_bind_tx_nl_policy,
> > +             .maxattr        =3D NETDEV_A_DMABUF_FD,
> > +             .flags          =3D GENL_CMD_CAP_DO,
> > +     },
> >  };
> >
> >  static const struct genl_multicast_group netdev_nl_mcgrps[] =3D {
> > diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> > index e09dd7539ff2..c1fed66e92b9 100644
> > --- a/net/core/netdev-genl-gen.h
> > +++ b/net/core/netdev-genl-gen.h
> > @@ -34,6 +34,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
> >                               struct netlink_callback *cb);
> >  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info=
);
> >  int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *inf=
o);
> > +int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info=
);
> >
> >  enum {
> >       NETDEV_NLGRP_MGMT,
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 2b774183d31c..6e5f2de4d947 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -931,6 +931,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, st=
ruct genl_info *info)
> >       return err;
> >  }
> >
> > +/* stub */
> > +int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info=
)
> > +{
> > +     return 0;
> > +}
> > +
> >  void netdev_nl_sock_priv_init(struct list_head *priv)
> >  {
> >       INIT_LIST_HEAD(priv);
>
> I'm sorry, but this chunck does not apply cleanly anymore.
>
> Please rebase.
>
> Disclaimer: unfortunately I must note that due to the long backlog
> pending and the upcoming merge window, I'm unsure I'll be able to
> process the next revision before the net-next closing.
>

Thanks Paolo. I have also been under the weather the last couple of
days so I haven't even been able to repost. I guess I'll repost after
the merge window if netdev closes today.

--
Thanks,
Mina
