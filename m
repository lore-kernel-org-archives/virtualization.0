Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7D8BF8
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359020; cv=none; b=uRaMNRDeV6+d+VT1+xNSgrwWant24u3a00m3uHS2lnIYaA8rUA5ScpEM1gHHxPcCVb/t3f0DV0UdFcMGhq39rPO5MpI+IHfaXg7mXhuRitedn1h1bH4211iPaoic58YwWxMMnSFv2gGkTvAWRlWzXg0EDA3C4MD+WjmybqyiPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359020; c=relaxed/simple;
	bh=vGz7XalA+DwSK9K/tkRIZY0thTuAAAN1yO0jG7/qLOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPq//yg4ZNF/2MA+PfLV640bNh32mK9WIjL2LMy2Zz0stVetyRvyWgEe6E6Qc/jTVmYfLT3hv+HQ/xm92UgKdPYU5LXL72LwLWE1zVWAx9SjOFVcQge5uLL9aHQ8Bpr8po9rkEIBEkXKH+JV/OM0J/7WsgCRk+htYhIvWvDZlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N88KEHqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N88KEHqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747359016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNvk8Uev/FPSQich67Pqbj9ceyu9nBXiLvXbmRhhRWY=;
	b=N88KEHqYCBUznzDNpxylSndob5GZ6Zl8b0UklJGn0EWgsx8by09kvL+J1nWmrw/T+jn7Bb
	t4zjhaRGT6AT+ps/1RNMkQ5W5T85n3xBdNLzczI/+7YGN2XkOxP/rMCYEFNysNLp9h1S5i
	vA40ZT7emjfpzU6vkok3YfmAd7cMnfI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-u98IGamMOryzxuC6NZZVJQ-1; Thu, 15 May 2025 21:30:15 -0400
X-MC-Unique: u98IGamMOryzxuC6NZZVJQ-1
X-Mimecast-MFC-AGG-ID: u98IGamMOryzxuC6NZZVJQ_1747359014
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30e7f19c8cfso434731a91.2
        for <virtualization@lists.linux.dev>; Thu, 15 May 2025 18:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747359014; x=1747963814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNvk8Uev/FPSQich67Pqbj9ceyu9nBXiLvXbmRhhRWY=;
        b=pjC7wZHZ5EUbaCStOBAXoEuN8IulgWIM5iWT+5kbPrYjDPhWV2ET7HV1IGenWV+KLs
         qR8o3SERwknnhZaUqcY2z9cKbbz7OBcRhv5/TlCxKOXzkHD5eG0ieglfyR8K4aNq+Cei
         D+Ak7UTlGwoZOmu3ZGp1opfEEhrbhshwxKQVg3BVFEcJfvsmcd5w5mB93sHYI/816Usp
         j1/h/gqS0Kg6C+tQGpvzct9qoFkIi8UG6bT5ZLXPCpLHfkBHvRYYuPItbpFWxge/EKso
         TDOu1w/1VZ6VWT+gMr8LHTVbLEViRcdR4tPgfu2tGn8ogYR2Pk+cxOVKLTArcN6Kw3tN
         /t7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQcwWEExbjw8oVNBRZxMokJnHp2mX8gdNm+xKl2e6JA0HxSlqfAxSetGtOPQVIxL+/PH3LqmE+8HHJshCfxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaaJMfPlj8cjk+zRaKv1KuhZDSColoPcz5+ffm+4K3rAFlPgQw
	Qu1DtrZRum3K7nBjwSFy2bGplOpq1Yk8XiunffddIUmokc2mVBKPq6iZY9cJe+iZ01xb+4Z6q/i
	vp18rskYG1ijcJpJn2ZCw2ePj6NeLDBv8TwQHE4ZbCh3LP9HVf0bWFPnUe/8YG/2N33HnEWefFX
	YpoTMmdTFrktKzpMlNA0JIiSdxu6Dw4hXixkKohpAc+sI=
X-Gm-Gg: ASbGncuaEYvmdB1BS5lOfkFZdVbOJP2WfOAYRcoauR7YPcBzPtDDxzoovxtCIOxgsay
	JYAKHzX6m1LebJtCsfZcA5a341i8U2w12+V7fXkZVXXFgGzA/c14L1hUWBarqjnjYoPdKzA==
X-Received: by 2002:a17:90b:3905:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-30e7d5a96d7mr1945230a91.25.1747359013836;
        Thu, 15 May 2025 18:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQMgxjzPP35wRl1TzvgpbBsXt4d0xz8Jzs2chg8T6eM1C8EnBElWjXpg2igaCCxTdFpVQEeVe3lGYnetaycxY=
X-Received: by 2002:a17:90b:3905:b0:2fe:b8ba:62de with SMTP id
 98e67ed59e1d1-30e7d5a96d7mr1945192a91.25.1747359013197; Thu, 15 May 2025
 18:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-1-jasowang@redhat.com>
 <20250407041729-mutt-send-email-mst@kernel.org> <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
 <20250408073317-mutt-send-email-mst@kernel.org> <CACGkMEtmDM4_ZbAi4O8OUwZaPZnGLKEhnXkQGStFmeXETJtpkA@mail.gmail.com>
 <20250514091029-mutt-send-email-mst@kernel.org> <20250514102109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250514102109-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:30:01 +0800
X-Gm-Features: AX0GCFtPhvwMSwTiJsZE1JRw-WPc8MJUUmj-N8b3Z86BURQVHWjdY7YKeZjRJE4
Message-ID: <CACGkMEsTwcKHQfp5skDHE6mp-tdK88oKteU2ZtKY19ik8HgN0A@mail.gmail.com>
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6B1tuO6XQ6UMSTGMNalA1RGtEUmceL_4ZEp9NvmUJig_1747359014
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 10:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, May 14, 2025 at 10:19:05AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Apr 09, 2025 at 12:06:03PM +0800, Jason Wang wrote:
> > > On Tue, Apr 8, 2025 at 7:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > > >
> > > > On Tue, Apr 08, 2025 at 03:02:35PM +0800, Jason Wang wrote:
> > > > > On Mon, Apr 7, 2025 at 4:20=E2=80=AFPM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> > > > > > > This patch introduces virtqueue ops which is a set of the cal=
lbacks
> > > > > > > that will be called for different queue layout or features. T=
his would
> > > > > > > help to avoid branches for split/packed and will ease the fut=
ure
> > > > > > > implementation like in order.
> > > > > > >
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-=
----------
> > > > > > >  1 file changed, 67 insertions(+), 29 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/vi=
rtio_ring.c
> > > > > > > index a2884eae14d9..ce1dc90ee89d 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
> > > > > > >       size_t event_size_in_bytes;
> > > > > > >  };
> > > > > > >
> > > > > > > +struct vring_virtqueue;
> > > > > > > +
> > > > > > > +struct virtqueue_ops {
> > > > > > > +     int (*add)(struct vring_virtqueue *_vq, struct scatterl=
ist *sgs[],
> > > > > > > +                unsigned int total_sg, unsigned int out_sgs,
> > > > > > > +                unsigned int in_sgs, void *data,
> > > > > > > +                void *ctx, bool premapped, gfp_t gfp);
> > > > > > > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *=
len, void **ctx);
> > > > > > > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > > > > > > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > > > > > > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > > > > > > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueu=
e *vq);
> > > > > > > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last=
_used_idx);
> > > > > > > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > > > > > > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > > > > > > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > > > > > > +     void (*reset)(struct vring_virtqueue *vq);
> > > > > > > +};
> > > > > >
> > > > > > I like it that it's organized but
> > > > > > I worry about the overhead of indirect calls here.
> > > > >
> > > > > We can switch to use INDIRECT_CALL_X() here
> > > >
> > > > If you think it's cleaner.. but INDIRECT_CALL is all chained
> > >
> > > Yes, and it would be problematic as the number of ops increased.
> > >
> > > > while a switch can do a binary search.
> > > >
> > >
> > > Do you mean a nested switch?
> >
> > Not sure what is nested. gcc does a decent job of optimizing
> > switches. You have 4 types of ops:
> > packed/packed in order/split/split in order
> >
> > So:
> >
> > enum {
> >       VQ_SPLIT,
> >       VQ_SPLIT_IN_ORDER,
> >       VQ_PACKED,
> >       VQ_PACKED_IN_ORDER,
> > }
> >
> >
> > I do not see how it is worse?
> >
> >
>
>
>
> Actually, here is an idea - create an array of ops:
>
>
>
> enum vqtype {
>         SPLIT,
>         SPLIT_IN_ORDER,
>         PACKED,
>         PACKED_IN_ORDER,
>         MAX
> };
>
>
> struct ops {
>         int (*add)(int bar);
> };
>
> extern int packed(int);
> extern int packedinorder(int);
> extern int split(int);
> extern int splitinorder(int);
>
> const struct ops allops[MAX] =3D { [SPLIT] =3D {split}, [SPLIT_IN_ORDER] =
=3D { splitinorder}, [PACKED] =3D { packed }, [PACKED_IN_ORDER] =3D {packed=
inorder}};
>
> int main(int argc, char **argv)
> {
>         switch (argc) {
>                 case 0:
>                         return allops[PACKED].foo(argc);
>                 case 1:
>                         return allops[SPLIT].foo(argc);
>                 default:
>                         return allops[PACKED_IN_ORDER].foo(argc);

This still looks like an indirection call as we don't call the symbol
directly but need to load the function address into a register.

>         }
> }
>
>
> I tested this and compiler is able to elide the indirect calls.

I've tried the following:

struct virtqueue_ops split_ops =3D {
        .add =3D virtqueue_add_split,
        .get =3D virtqueue_get_buf_ctx_split,
        .kick_prepare =3D virtqueue_kick_prepare_split,
        .disable_cb =3D virtqueue_disable_cb_split,
        .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
        .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
        .poll =3D virtqueue_poll_split,
        .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
        .more_used =3D more_used_split,
        .resize =3D virtqueue_resize_split,
        .reset =3D virtqueue_reset_split,
};

struct virtqueue_ops packed_ops =3D {
        .add =3D virtqueue_add_packed,
        .get =3D virtqueue_get_buf_ctx_packed,
        .kick_prepare =3D virtqueue_kick_prepare_packed,
        .disable_cb =3D virtqueue_disable_cb_packed,
        .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
        .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
        .poll =3D virtqueue_poll_packed,
        .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
        .more_used =3D more_used_packed,
        .resize =3D virtqueue_resize_packed,
        .reset =3D virtqueue_reset_packed,
};

const struct virtqueue_ops *all_ops[VQ_TYPE_MAX] =3D { [SPLIT] =3D &split_o=
ps,
                                                     [PACKED] =3D &packed_o=
ps};

unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
{
        struct vring_virtqueue *vq =3D to_vvq(_vq);

        if (vq->event_triggered)
                vq->event_triggered =3D false;

        switch (vq->layout) {
case SPLIT:
                return all_ops[SPLIT]->enable_cb_prepare(vq);
                break;
        case PACKED:
                return all_ops[PACKED]->enable_cb_prepare(vq);
                break;
        default:
                BUG();
                break;
        }

return -EFAULT;
}
EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);

Compilers gives me (when RETPOLINE is enabled):

ffffffff8193a870 <virtqueue_enable_cb_prepare>:
ffffffff8193a870:       f3 0f 1e fa             endbr64
ffffffff8193a874:       e8 47 68 93 ff          callq
ffffffff812710c0 <__fentry__>
ffffffff8193a879:       80 bf 8e 00 00 00 00    cmpb   $0x0,0x8e(%rdi)
ffffffff8193a880:       74 07                   je
ffffffff8193a889 <virtqueue_enable_cb_prepare+0x19>
ffffffff8193a882:       c6 87 8e 00 00 00 00    movb   $0x0,0x8e(%rdi)
ffffffff8193a889:       8b 87 80 00 00 00       mov    0x80(%rdi),%eax
ffffffff8193a88f:       85 c0                   test   %eax,%eax
ffffffff8193a891:       74 15                   je
ffffffff8193a8a8 <virtqueue_enable_cb_prepare+0x38>
ffffffff8193a893:       83 f8 01                cmp    $0x1,%eax
ffffffff8193a896:       75 20                   jne
ffffffff8193a8b8 <virtqueue_enable_cb_prepare+0x48>
ffffffff8193a898:       48 8b 05 49 03 4a 01    mov
0x14a0349(%rip),%rax        # ffffffff82ddabe8 <all_ops+0x8>
ffffffff8193a89f:       48 8b 40 28             mov    0x28(%rax),%rax
ffffffff8193a8a3:       e9 b8 d8 9b 00          jmpq
ffffffff822f8160 <__x86_indirect_thunk_array>
ffffffff8193a8a8:       48 8b 05 31 03 4a 01    mov
0x14a0331(%rip),%rax        # ffffffff82ddabe0 <all_ops>
ffffffff8193a8af:       48 8b 40 28             mov    0x28(%rax),%rax
ffffffff8193a8b3:       e9 a8 d8 9b 00          jmpq
ffffffff822f8160 <__x86_indirect_thunk_array>
ffffffff8193a8b8:       0f 0b                   ud2
ffffffff8193a8ba:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

indirection call is still being mitigated via thunk.

The way I can think so far is something like this that passess the
function symbol to the macro:

#define VIRTQUEUE_CALL(vq, split_fn, packed_fn, ...)    \
        ({                                              \
        typeof(split_fn(vq, ##__VA_ARGS__)) ret;        \
        switch ((vq)->layout) {                 \
        case SPLIT:                                     \
                ret =3D split_fn(vq, ##__VA_ARGS__);      \
                break;                                  \
        case PACKED:                                    \
                ret =3D packed_fn(vq, ##__VA_ARGS__);     \
                break;                                  \
        default:                                        \
                BUG();                                  \
                ret =3D (typeof(ret))-EFAULT;             \
                break;                                  \
        }                                               \
        ret;                                            \
})

Then I can't see RETPOLINE for indirect calls.

Thanks

>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> >
> >
> >
> >
> >
> >
> > > >
> > > > > (but I'm not sure we
> > > > > should worry about it too much as ndo_ops or qdiscs doesn't use t=
hat).
> > > >
> > > >
> > > > And that's why we ended up with xdp, no? the stack's too heavy ...
> > > >
> > > > > > How about a switch statement instead?
> > > > > >
> > > > > > struct vring_virtqueue {
> > > > > >         enum vring_virtqueue_ops ops;
> > > > > >
> > > > > > }
> > > > > >
> > > > > >
> > > > > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct v=
irtqueue *_vq,
> > > > > >  {
> > > > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > >
> > > > > >         switch (vq->ops) {
> > > > > >          VQ_PACKED:
> > > > > >          VQ_SPLIT:
> > > > > >          VQ_IN_ORDER:
> > > > > >         }
> > > > > >
> > > > > >
> > > > > > }
> > > > > >
> > > > > >
> > > > > > What do you think?
> > > > >
> > > > > Actually, the matrix will be 2*2:
> > > > >
> > > > > PACKED, SPLIT, PACKED_IN_ORDER, SPLIT_IN_ORDER
> > > >
> > > > Confused. Same amount of enums as ops structures in your approach, =
no?
> > >
> > > I meant in this series, we will have 4 ops not 3.
> > >
> > > >
> > > >
> > > > > And will be doubled if a new layout is implemented.
> > > > >
> > > > > If we open them such a switch will spread in a lot of places in t=
he code.
> > > > >
> > > > > Thanks
> > >
> > > Thanks
> > >
> > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > +
> > > > > > >  struct vring_virtqueue {
> > > > > > >       struct virtqueue vq;
> > > > > > >
> > > > > > > +     struct virtqueue_ops *ops;
> > > > > > > +
> > > > > > >       /* Is this a packed ring? */
> > > > > > >       bool packed_ring;
> > > > > > >
> > > > > > > @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(stru=
ct vring_virtqueue_split *vring_split,
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +struct virtqueue_ops split_ops;
> > > > > > > +
> > > > > > >  static struct virtqueue *__vring_new_virtqueue_split(unsigne=
d int index,
> > > > > > >                                              struct vring_vir=
tqueue_split *vring_split,
> > > > > > >                                              struct virtio_de=
vice *vdev,
> > > > > > > @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_vi=
rtqueue_split(unsigned int index,
> > > > > > >               return NULL;
> > > > > > >
> > > > > > >       vq->packed_ring =3D false;
> > > > > > > +     vq->ops =3D &split_ops;
> > > > > > >       vq->vq.callback =3D callback;
> > > > > > >       vq->vq.vdev =3D vdev;
> > > > > > >       vq->vq.name =3D name;
> > > > > > > @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(stru=
ct vring_virtqueue *vq)
> > > > > > >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callb=
ack);
> > > > > > >  }
> > > > > > >
> > > > > > > +struct virtqueue_ops packed_ops;
> > > > > > > +
> > > > > > >  static struct virtqueue *__vring_new_virtqueue_packed(unsign=
ed int index,
> > > > > > >                                              struct vring_vir=
tqueue_packed *vring_packed,
> > > > > > >                                              struct virtio_de=
vice *vdev,
> > > > > > > @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_vi=
rtqueue_packed(unsigned int index,
> > > > > > >       vq->broken =3D false;
> > > > > > >  #endif
> > > > > > >       vq->packed_ring =3D true;
> > > > > > > +     vq->ops =3D &packed_ops;
> > > > > > >       vq->dma_dev =3D dma_dev;
> > > > > > >       vq->use_dma_api =3D vring_use_dma_api(vdev);
> > > > > > >
> > > > > > > @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(str=
uct vring_virtqueue *vq, u32 num)
> > > > > > >       return -ENOMEM;
> > > > > > >  }
> > > > > > >
> > > > > > > +struct virtqueue_ops split_ops =3D {
> > > > > > > +     .add =3D virtqueue_add_split,
> > > > > > > +     .get =3D virtqueue_get_buf_ctx_split,
> > > > > > > +     .kick_prepare =3D virtqueue_kick_prepare_split,
> > > > > > > +     .disable_cb =3D virtqueue_disable_cb_split,
> > > > > > > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_spli=
t,
> > > > > > > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_spli=
t,
> > > > > > > +     .poll =3D virtqueue_poll_split,
> > > > > > > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_spli=
t,
> > > > > > > +     .more_used =3D more_used_split,
> > > > > > > +     .resize =3D virtqueue_resize_split,
> > > > > > > +     .reset =3D virtqueue_reset_split,
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct virtqueue_ops packed_ops =3D {
> > > > > > > +     .add =3D virtqueue_add_packed,
> > > > > > > +     .get =3D virtqueue_get_buf_ctx_packed,
> > > > > > > +     .kick_prepare =3D virtqueue_kick_prepare_packed,
> > > > > > > +     .disable_cb =3D virtqueue_disable_cb_packed,
> > > > > > > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_pack=
ed,
> > > > > > > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_pack=
ed,
> > > > > > > +     .poll =3D virtqueue_poll_packed,
> > > > > > > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_pack=
ed,
> > > > > > > +     .more_used =3D more_used_packed,
> > > > > > > +     .resize =3D virtqueue_resize_packed,
> > > > > > > +     .reset =3D virtqueue_reset_packed,
> > > > > > > +};
> > > > > > > +
> > > > > > >  static int virtqueue_disable_and_recycle(struct virtqueue *_=
vq,
> > > > > > >                                        void (*recycle)(struct=
 virtqueue *vq, void *buf))
> > > > > > >  {
> > > > > > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct=
 virtqueue *_vq,
> > > > > > >  {
> > > > > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > >
> > > > > > > -     return vq->packed_ring ? virtqueue_add_packed(vq, sgs, =
total_sg,
> > > > > > > -                                     out_sgs, in_sgs, data, =
ctx, premapped, gfp) :
> > > > > > > -                              virtqueue_add_split(vq, sgs, t=
otal_sg,
> > > > > > > -                                     out_sgs, in_sgs, data, =
ctx, premapped, gfp);
> > > > > > > +     return vq->ops->add(vq, sgs, total_sg,
> > > > > > > +                         out_sgs, in_sgs, data, ctx, premapp=
ed, gfp);
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virt=
queue *_vq)
> > > > > > >  {
> > > > > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > >
> > > > > > > -     return vq->packed_ring ? virtqueue_kick_prepare_packed(=
vq) :
> > > > > > > -                              virtqueue_kick_prepare_split(v=
q);
> > > > > > > +     return vq->ops->kick_prepare(vq);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> > > > > > >
> > > > > > > @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virt=
queue *_vq, unsigned int *len,
> > > > > > >  {
> > > > > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > >
> > > > > > > -     return vq->packed_ring ? virtqueue_get_buf_ctx_packed(v=
q, len, ctx) :
> > > > > > > -                              virtqueue_get_buf_ctx_split(vq=
, len, ctx);
> > > > > > > +     return vq->ops->get(vq, len, ctx);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> > > > > > >
> > > > > > > @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtq=
ueue *_vq)
> > > > > > >  {
> > > > > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > >
> > > > > > > -     if (vq->packed_ring)
> > > > > > > -             virtqueue_disable_cb_packed(vq);
> > > > > > > -     else
> > > > > > > -             virtqueue_disable_cb_split(vq);
> > > > > > > +     return vq->ops->disable_cb(vq);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > > > > > >
> > > > > > > @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepar=
e(struct virtqueue *_vq)
> > > > > > >       if (vq->event_triggered)
> > > > > > >               vq->event_triggered =3D false;
> > > > > > >
> > > > > > > -     return vq->packed_ring ? virtqueue_enable_cb_prepare_pa=
cked(vq) :
> > > > > > > -                              virtqueue_enable_cb_prepare_sp=
lit(vq);
> > > > > > > +     return vq->ops->enable_cb_prepare(vq);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > > > > > >
> > > > > > > @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_=
vq, unsigned int last_used_idx)
> > > > > > >               return false;
> > > > > > >
> > > > > > >       virtio_mb(vq->weak_barriers);
> > > > > > > -     return vq->packed_ring ? virtqueue_poll_packed(vq, last=
_used_idx) :
> > > > > > > -                              virtqueue_poll_split(vq, last_=
used_idx);
> > > > > > > +     return vq->ops->poll(vq, last_used_idx);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> > > > > > >
> > > > > > > @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct=
 virtqueue *_vq)
> > > > > > >       if (vq->event_triggered)
> > > > > > >               vq->event_triggered =3D false;
> > > > > > >
> > > > > > > -     return vq->packed_ring ? virtqueue_enable_cb_delayed_pa=
cked(vq) :
> > > > > > > -                              virtqueue_enable_cb_delayed_sp=
lit(vq);
> > > > > > > +     return vq->ops->enable_cb_delayed(vq);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> > > > > > >
> > > > > > > @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(str=
uct virtqueue *_vq)
> > > > > > >  {
> > > > > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > > >
> > > > > > > -     return vq->packed_ring ? virtqueue_detach_unused_buf_pa=
cked(vq) :
> > > > > > > -                              virtqueue_detach_unused_buf_sp=
lit(vq);
> > > > > > > +     return vq->ops->detach_unused_buf(vq);
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> > > > > > >
> > > > > > >  static inline bool more_used(const struct vring_virtqueue *v=
q)
> > > > > > >  {
> > > > > > > -     return vq->packed_ring ? more_used_packed(vq) : more_us=
ed_split(vq);
> > > > > > > +     return vq->ops->more_used(vq);
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue =
*_vq, u32 num,
> > > > > > >       if (recycle_done)
> > > > > > >               recycle_done(_vq);
> > > > > > >
> > > > > > > -     if (vq->packed_ring)
> > > > > > > -             err =3D virtqueue_resize_packed(vq, num);
> > > > > > > -     else
> > > > > > > -             err =3D virtqueue_resize_split(vq, num);
> > > > > > > +     err =3D vq->ops->resize(vq, num);
> > > > > > >
> > > > > > >       return virtqueue_enable_after_reset(_vq);
> > > > > > >  }
> > > > > > > @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *=
_vq,
> > > > > > >       if (recycle_done)
> > > > > > >               recycle_done(_vq);
> > > > > > >
> > > > > > > -     if (vq->packed_ring)
> > > > > > > -             virtqueue_reset_packed(vq);
> > > > > > > -     else
> > > > > > > -             virtqueue_reset_split(vq);
> > > > > > > +     vq->ops->reset(vq);
> > > > > > >
> > > > > > >       return virtqueue_enable_after_reset(_vq);
> > > > > > >  }
> > > > > > > --
> > > > > > > 2.42.0
> > > > > >
> > > >
>

