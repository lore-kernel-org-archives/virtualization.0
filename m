Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96B137930
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845600; cv=none; b=YW8u4uq+oFrk2rlQ8bRUPakFRv2YTP1s369D2xTBDDrdYdY3ARG/V7GV2fhYawkF0PWmqVZP6WKPYITf4Cgr9kURVtUi99jkHZLciBexNoKxo+5S5Rupp8MLZSfM1afLffGAeG/bnsub4FBoy9/02WRi0ScRvbk/sxBCND0G9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845600; c=relaxed/simple;
	bh=MGa9Z+XMKoNXcWSNjsXUJf9A9dDcVntcNWws2ioK92A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crkHl4cHwMVFlIapetAkXAEWyOezcVHWV+5pigqwgTisRLB17nregAFuKnxAx/3AqcCgdIiPz1+PU0js26xircnsajcx4UhRpNU/bhRo3SQo25ZzvgEDd/Dl3TUd9xV8nA9q9IoGsobFhX/iQA/DERNAGIA64PMQGZf+tCCQGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObTykBfF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObTykBfF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so51905ad.0
        for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 12:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742845596; x=1743450396; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzTfUAD+ubxSxcRWiQNVlkzHInPHF8YG9aMVD/9Buo=;
        b=ObTykBfF3F1+UJu/Fdxgnyopij6wgmmSU+E4Dye2jK9nW9VNumqqIdNjPZ7QQj0c94
         KRp0+mf/FKZJN6wEDIifSgewtvgkoVmh+qiIdv+QC7k7UjTCSW74uSCd9jPaCix5TNSi
         sILuPic29mY28VxzZwxnSapWCXAbXOCmIYxswln4t/w9Svgtfjil1an9+85l6sq/At51
         C2lXhCZcI0qmoPawa313EZUJ3vrRe4AQy0yOUlB1dlOXrVoQdGJ+lBKGv61pJ28wJ6EE
         eADDmF2lyyqDSVb7wlMDudmCVH9Ik+1ys28Z20xx1gwXyDMVLv4toj2wDj+RYEeyUC1H
         tu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845596; x=1743450396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrzTfUAD+ubxSxcRWiQNVlkzHInPHF8YG9aMVD/9Buo=;
        b=s2Y6JKC4Wc3bA1ZMarHqY2bW3h7m/ksNm4DRl54AXFrbGmppuwI+0ShDmmZ+icUYoL
         4TujxH+xLwtoQVmil3xbfbDZE0muLSezCtY8Sn8iEbtBd63tWRBkeEYE0qHbGYBrhZgG
         hM4mdNC5IXuabDxoh20em7wHzsfTWnLCuCLkP5SBZYQ4st2s2bhpPz7s3SXYI6RSXbFG
         L8AKGFWO9J2VYiLv9NX8boXjDicuooYa2O3TTlWTQ+z54puco2hR13VcTz4lWIZjo2uM
         raQG4PnmzX0PNsVZhg2UI1fkEq8iroBFi62f3RKSB7RcL+G8rz4+yGs1tn5JwJNZIKdy
         WiJw==
X-Forwarded-Encrypted: i=1; AJvYcCUGyqgQ6jykFKVEPahCmeiAfJffSOYGT4LGW8a/5lJmKffk3D/d4WIAmH0ipHTQk34jDzTMnYb4dcIJJzfmpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye65q2pqJce71JM1EcqgE79Db/FhgNosQX+ND4w3clPx7VE1US
	9BI7PggMc8YIFiN/N3xIvY4lSn64OjMdOK6NrfRzJggOnaR0V6qRTWQUmk0/jOX1I+84uKyeSIi
	W3dVLym1LPVuthyleO4A1bd211cvxC7qTdioq
X-Gm-Gg: ASbGncsA7o+unRJLJVY9MEjS7qZVHMNg2eQ3fPR8kJSxgqR5z8WxmzEgTOcX4oe55E4
	d9UEfhvRbZX5em8ovoCeZTVhVnI84x+2x2dBiBvWGRF9LjiF65vv1i4gU6eW56vvXVydOtzgPSF
	5hzjPD81YleaFlVQTnin6d3lGWATPZmYVFFLG6QlwDC+0IS8iL2duRfSeQj4Od/HA+83I=
X-Google-Smtp-Source: AGHT+IEzEJbvdguVz7wlOoAmjYfMgRXxuV/ZTxzCdgp0SxDyPLpdbn3v2LVYJxcHF97qNoir/CYkElC2NXK5jb1a7HE=
X-Received: by 2002:a17:902:d505:b0:223:ff93:322f with SMTP id
 d9443c01a7336-227982abd4fmr5356755ad.2.1742845595786; Mon, 24 Mar 2025
 12:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-5-almasrymina@google.com> <Z-GHXCOgP0pZBSlS@mini-arch>
In-Reply-To: <Z-GHXCOgP0pZBSlS@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 12:46:23 -0700
X-Gm-Features: AQ5f1Jq28M7yfy88YYEv6Cp39eNsmSWafLu0RQhyhop8yesTxg9Zcsyp-y3frMU
Message-ID: <CAHS8izNjdDwtf-Zb+wbmWW4k6+9=fnpY4XO_G=xMu4M-TaMw5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/9] net: devmem: Implement TX path
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:25=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/08, Mina Almasry wrote:
> > Augment dmabuf binding to be able to handle TX. Additional to all the R=
X
> > binding, we also create tx_vec needed for the TX path.
> >
> > Provide API for sendmsg to be able to send dmabufs bound to this device=
:
> >
> > - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> > - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> >
> > Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> > implementation, while disabling instances where MSG_ZEROCOPY falls back
> > to copying.
> >
> > We additionally pipe the binding down to the new
> > zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> > instead of the traditional page netmems.
> >
> > We also special case skb_frag_dma_map to return the dma-address of thes=
e
> > dmabuf net_iovs instead of attempting to map pages.
> >
> > The TX path may release the dmabuf in a context where we cannot wait.
> > This happens when the user unbinds a TX dmabuf while there are still
> > references to its netmems in the TX path. In that case, the netmems wil=
l
> > be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
> > this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> >
> > Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the mea=
t
> > of the implementation came from devmem TCP RFC v1[1], which included th=
e
> > TX path, but Stan did all the rebasing on top of netmem/net_iov.
> >
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > ---
> >
> > v6:
> > - Retain behavior that MSG_FASTOPEN succeeds even if cmsg is invalid
> >   (Paolo).
> > - Rework the freeing of tx_vec slightly to improve readability. Now it
> >   has its own err label (Paolo).
> > - Squash making unbinding scheduled work (Paolo).
> > - Add comment to clarify that net_iovs stuck in the transmit path hold
> >   a ref on the underlying dmabuf binding (David).
> > - Fix the comment on how binding refcounting works on RX (the comment
> >   was not matching the existing code behavior).
> >
> > v5:
> > - Return -EFAULT from zerocopy_fill_skb_from_devmem (Stan)
> > - don't null check before kvfree (stan).
> >
> > v4:
> > - Remove dmabuf_tx_cmsg definition and just use __u32 for the dma-buf i=
d
> >   (Willem).
> > - Check that iov_iter_type() is ITER_IOVEC in
> >   zerocopy_fill_skb_from_iter() (Pavel).
> > - Fix binding->tx_vec not being freed on error paths (Paolo).
> > - Make devmem patch mutually exclusive with msg->ubuf_info path (Pavel)=
.
> > - Check that MSG_ZEROCOPY and SOCK_ZEROCOPY are provided when
> >   sockc.dmabuf_id is provided.
> > - Don't mm_account_pinned_pages() on devmem TX (Pavel).
> >
> > v3:
> > - Use kvmalloc_array instead of kcalloc (Stan).
> > - Fix unreachable code warning (Simon).
> >
> > v2:
> > - Remove dmabuf_offset from the dmabuf cmsg.
> > - Update zerocopy_fill_skb_from_devmem to interpret the
> >   iov_base/iter_iov_addr as the offset into the dmabuf to send from
> >   (Stan).
> > - Remove the confusing binding->tx_iter which is not needed if we
> >   interpret the iov_base/iter_iov_addr as offset into the dmabuf (Stan)=
.
> > - Remove check for binding->sgt and binding->sgt->nents in dmabuf
> >   binding.
> > - Simplify the calculation of binding->tx_vec.
> > - Check in net_devmem_get_binding that the binding we're returning
> >   has ifindex matching the sending socket (Willem).
> > ---
> >  include/linux/skbuff.h                  |  17 +++-
> >  include/net/sock.h                      |   1 +
> >  net/core/datagram.c                     |  48 ++++++++++-
> >  net/core/devmem.c                       | 105 ++++++++++++++++++++++--
> >  net/core/devmem.h                       |  61 +++++++++++---
> >  net/core/netdev-genl.c                  |  64 ++++++++++++++-
> >  net/core/skbuff.c                       |  18 ++--
> >  net/core/sock.c                         |   6 ++
> >  net/ipv4/ip_output.c                    |   3 +-
> >  net/ipv4/tcp.c                          |  50 ++++++++---
> >  net/ipv6/ip6_output.c                   |   3 +-
> >  net/vmw_vsock/virtio_transport_common.c |   5 +-
> >  12 files changed, 330 insertions(+), 51 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 14517e95a46c..67a7e069a9bf 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1707,13 +1707,16 @@ static inline void skb_set_end_offset(struct sk=
_buff *skb, unsigned int offset)
> >  extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
> >
> >  struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
> > -                                    struct ubuf_info *uarg);
> > +                                    struct ubuf_info *uarg, bool devme=
m);
> >
> >  void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
> >
> > +struct net_devmem_dmabuf_binding;
> > +
> >  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
> >                           struct sk_buff *skb, struct iov_iter *from,
> > -                         size_t length);
> > +                         size_t length,
> > +                         struct net_devmem_dmabuf_binding *binding);
> >
> >  int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
> >                               struct iov_iter *from, size_t length);
> > @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff =
*skb,
> >  static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
> >                                         struct msghdr *msg, int len)
> >  {
> > -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter,=
 len);
> > +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter,=
 len,
> > +                                    NULL);
> >  }
> >
> >  int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
> >                            struct msghdr *msg, int len,
> > -                          struct ubuf_info *uarg);
> > +                          struct ubuf_info *uarg,
> > +                          struct net_devmem_dmabuf_binding *binding);
> >
> >  /* Internal */
> >  #define skb_shinfo(SKB)      ((struct skb_shared_info *)(skb_end_point=
er(SKB)))
> > @@ -3697,6 +3702,10 @@ static inline dma_addr_t __skb_frag_dma_map(stru=
ct device *dev,
> >                                           size_t offset, size_t size,
> >                                           enum dma_data_direction dir)
> >  {
> > +     if (skb_frag_is_net_iov(frag)) {
> > +             return netmem_to_net_iov(frag->netmem)->dma_addr + offset=
 +
> > +                    frag->offset;
> > +     }
> >       return dma_map_page(dev, skb_frag_page(frag),
> >                           skb_frag_off(frag) + offset, size, dir);
> >  }
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8daf1b3b12c6..59875bed75e7 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1816,6 +1816,7 @@ struct sockcm_cookie {
> >       u32 tsflags;
> >       u32 ts_opt_id;
> >       u32 priority;
> > +     u32 dmabuf_id;
> >  };
> >
> >  static inline void sockcm_init(struct sockcm_cookie *sockc,
> > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > index f0693707aece..09c74a1d836b 100644
> > --- a/net/core/datagram.c
> > +++ b/net/core/datagram.c
> > @@ -63,6 +63,8 @@
> >  #include <net/busy_poll.h>
> >  #include <crypto/hash.h>
> >
> > +#include "devmem.h"
> > +
> >  /*
> >   *   Is a socket 'connection oriented' ?
> >   */
> > @@ -692,9 +694,49 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *sk=
b,
> >       return 0;
> >  }
> >
> > +static int
> > +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *fr=
om,
> > +                           int length,
> > +                           struct net_devmem_dmabuf_binding *binding)
> > +{
> > +     int i =3D skb_shinfo(skb)->nr_frags;
> > +     size_t virt_addr, size, off;
> > +     struct net_iov *niov;
> > +
> > +     /* Devmem filling works by taking an IOVEC from the user where th=
e
> > +      * iov_addrs are interpreted as an offset in bytes into the dma-b=
uf to
> > +      * send from. We do not support other iter types.
> > +      */
> > +     if (iov_iter_type(from) !=3D ITER_IOVEC)
> > +             return -EFAULT;
> > +
> > +     while (length && iov_iter_count(from)) {
> > +             if (i =3D=3D MAX_SKB_FRAGS)
> > +                     return -EMSGSIZE;
> > +
> > +             virt_addr =3D (size_t)iter_iov_addr(from);
> > +             niov =3D net_devmem_get_niov_at(binding, virt_addr, &off,=
 &size);
> > +             if (!niov)
> > +                     return -EFAULT;
> > +
> > +             size =3D min_t(size_t, size, length);
> > +             size =3D min_t(size_t, size, iter_iov_len(from));
> > +
> > +             get_netmem(net_iov_to_netmem(niov));
> > +             skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), o=
ff,
> > +                                    size, PAGE_SIZE);
> > +             iov_iter_advance(from, size);
> > +             length -=3D size;
> > +             i++;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
> >                           struct sk_buff *skb, struct iov_iter *from,
> > -                         size_t length)
> > +                         size_t length,
> > +                         struct net_devmem_dmabuf_binding *binding)
> >  {
> >       unsigned long orig_size =3D skb->truesize;
> >       unsigned long truesize;
> > @@ -702,6 +744,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, str=
uct sock *sk,
> >
> >       if (msg && msg->msg_ubuf && msg->sg_from_iter)
> >               ret =3D msg->sg_from_iter(skb, from, length);
> > +     else if (unlikely(binding))
> > +             ret =3D zerocopy_fill_skb_from_devmem(skb, from, length, =
binding);
> >       else
> >               ret =3D zerocopy_fill_skb_from_iter(skb, from, length);
> >
> > @@ -735,7 +779,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, stru=
ct iov_iter *from)
> >       if (skb_copy_datagram_from_iter(skb, 0, from, copy))
> >               return -EFAULT;
> >
> > -     return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
> > +     return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
> >  }
> >  EXPORT_SYMBOL(zerocopy_sg_from_iter);
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 0cf3d189f06c..393e30d72dc8 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -17,6 +17,7 @@
> >  #include <net/netdev_rx_queue.h>
> >  #include <net/page_pool/helpers.h>
> >  #include <net/page_pool/memory_provider.h>
> > +#include <net/sock.h>
> >  #include <trace/events/page_pool.h>
> >
> >  #include "devmem.h"
> > @@ -54,8 +55,10 @@ static dma_addr_t net_devmem_get_dma_addr(const stru=
ct net_iov *niov)
> >              ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
> >  }
> >
> > -void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding=
 *binding)
> > +void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
> >  {
> > +     struct net_devmem_dmabuf_binding *binding =3D container_of(wq, ty=
peof(*binding), unbind_w);
> > +
> >       size_t size, avail;
> >
> >       gen_pool_for_each_chunk(binding->chunk_pool,
> > @@ -73,8 +76,10 @@ void __net_devmem_dmabuf_binding_free(struct net_dev=
mem_dmabuf_binding *binding)
> >       dma_buf_detach(binding->dmabuf, binding->attachment);
> >       dma_buf_put(binding->dmabuf);
> >       xa_destroy(&binding->bound_rxqs);
> > +     kvfree(binding->tx_vec);
> >       kfree(binding);
> >  }
> > +EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
> >
> >  struct net_iov *
> >  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> > @@ -119,6 +124,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dm=
abuf_binding *binding)
> >       unsigned long xa_idx;
> >       unsigned int rxq_idx;
> >
> > +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> > +
> > +     /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
> > +      * erase.
> > +      */
> > +     synchronize_net();
> > +
> >       if (binding->list.next)
> >               list_del(&binding->list);
> >
>
> One thing forgot to mention: we should probably do the same for the
> allocation path? Move the binding->id allocation to the end of the
> routine to make sure we 'post' fully initialized bindings? Otherwise,
> net_devmem_bind_dmabuf migh race with the sendmsg?

Ah, good point. Although sane userspace will wait for the bind to
finish to get the id, and then pass the id to sendmsg. Only userspace
looking for trouble will be able to trigger any race here, but yes we
should handle that a bit better.

--
Thanks,
Mina
