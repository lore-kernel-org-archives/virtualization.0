Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2B213E8E
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391749; cv=none; b=iTkLkLLvCptMA8RD7oBFTxNx096XjRBlONdHo0/cVivBjDGXsxy9ugVvwn5ZWGAF+czmryq9/LA+DIto1NX4GFmdNxfw8jDHHAvbI8HyOIAwnYvvkq9ppZGVrAOu7UGfry4nfVZ0naewqHPO6rIQ3oyrZBfuo5H+Q9TpaZkkhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391749; c=relaxed/simple;
	bh=S0WUQVrhkQicldekjF4GKviGn6B69CGhdyo0bJtSBWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NNGg/CDuh4FHUg325k0evGFcH5K+FPRKlgqsv7XZSZDP+xEch7WvUC87y/lB+Hv7rUsChT/d+G3U/pMimIeIv1pHP0FFf+zajMgJ5sOR5BUA2P/bk9WDI7zubxV6UWnxz6Zu42ps21mjGQF0D8GbB5XBgf3XBYuMPU7OxYN6YRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqUuEskE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqUuEskE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747391745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gl3II1YoTJkscJoXMvEMwnP/tUZSypibSL6ABl9jAH8=;
	b=FqUuEskEnGuXOfqtQBL754Zc4w9Q8297P6JA3X4cwabF5A7OJuHmeOZkcAbQH+6njFa8xi
	BH710m8YAsL1Wq3xY6Uei+2qN3IuY7g1+2GcuO9miNc5wtFkISRGZ+0g3srfcuQWhOmUw5
	JKIYDFMH2Hz8ACI7OkhZsqoq4fi9kZQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-m5DhQukVOvGy33r79o3BbQ-1; Fri, 16 May 2025 06:35:43 -0400
X-MC-Unique: m5DhQukVOvGy33r79o3BbQ-1
X-Mimecast-MFC-AGG-ID: m5DhQukVOvGy33r79o3BbQ_1747391743
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442f4a3851fso16439415e9.1
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 03:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747391742; x=1747996542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gl3II1YoTJkscJoXMvEMwnP/tUZSypibSL6ABl9jAH8=;
        b=Q+Z1BO04So8af6fzfSJEOMJprNC1hGaLJyLqdrKBl2sXvbMj/GexWqEBsILINxbNnK
         6O87X7n3hJPmCCazel3RU4R2a1KezpPPrhO/7J8rJgbxpUP/5I+MJw5wY+Pw5/A171YU
         PBg9B9b29+N3B3ilxzefdajEHDsMHZD+pJ/eS4+qJhE2ILeJAqbfEDdZ9lpD/BovRfJS
         CqgyHXRBcgOSRnEOanldZ89cNQnmk9JI5fn/iUx3DwEBG5mhkKOmqfBXRcUbDNb7X8up
         mAODe8cgxERvjYnv1RfQQBx3s4cO298qHbgI68FDe0vmypXb74loyIXZRYSQOqC7rN2t
         OJBw==
X-Forwarded-Encrypted: i=1; AJvYcCUuxqHvClyphwEThrzfrFO88eR5rkRRr5ShNGVUDMq83IikoxOb3kF+skzm1I5V3f47z1VA24cGnB0eevML0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcUAPYN1RnZ0sFkLAvoNBSz4HJvTGm2cDfzVE5Ebf6s1Klojtm
	I3+zXlAh57CLWYRXj/zyp8LSjjQL9xw4PN6YaRfa0iSdJ1T4TFrdrNseVbjsvS3JwkvYOqU0SYb
	S1HPMzLGffl0dFtzbHiu4c4TIlVzscjXdVypRSK4SIcAC9fEtbnS4nXf1wqjDBO052KXkrkKuho
	Pm
X-Gm-Gg: ASbGnctEqK6Bcue9h1nuz0P4ndPvu3/ZfhHaESbtiqXj5VHdpHhkbKsTEfWAconpmCY
	RD46A5Z9B6IOQS9nBEaz7ITRWOVj1lL5P77PM2ftjrhrCaGrZHg5GWeLGr9TNc4zkJO6rdWdaKP
	Jz2Raom/DmOI8kcTP0Pf8+tBSby+LoJ50od66vhZlkfsFYQ+F23Dq619wviBeGuKvbFuax2XAp3
	gyYUXJuglH4VJV94wID5m6BdEU6s+/yPVc3Fi3rp3gUuFJqmonhlOvsFG53uOPwL2B1IxPTZvQA
	xhsmbQ==
X-Received: by 2002:a05:600c:548d:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-442ff03c228mr17793705e9.30.1747391741871;
        Fri, 16 May 2025 03:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXyXwiGL6JnUUITg4CCL5G4m0j/QcmgnKRf2NDiCcluMbNiZMpefB0iq78TXPZWHqUG74L5A==
X-Received: by 2002:a05:600c:548d:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-442ff03c228mr17793385e9.30.1747391741323;
        Fri, 16 May 2025 03:35:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85a3b1sm83295175e9.0.2025.05.16.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 03:35:40 -0700 (PDT)
Date: Fri, 16 May 2025 06:35:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20250516060737-mutt-send-email-mst@kernel.org>
References: <20250324054333.1954-1-jasowang@redhat.com>
 <20250324060127.2358-1-jasowang@redhat.com>
 <20250407041729-mutt-send-email-mst@kernel.org>
 <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
 <20250408073317-mutt-send-email-mst@kernel.org>
 <CACGkMEtmDM4_ZbAi4O8OUwZaPZnGLKEhnXkQGStFmeXETJtpkA@mail.gmail.com>
 <20250514091029-mutt-send-email-mst@kernel.org>
 <20250514102109-mutt-send-email-mst@kernel.org>
 <CACGkMEsTwcKHQfp5skDHE6mp-tdK88oKteU2ZtKY19ik8HgN0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsTwcKHQfp5skDHE6mp-tdK88oKteU2ZtKY19ik8HgN0A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RVNnzueDg5JJhtH9C_02GVOkgegdJYD5uynlOPsqWC8_1747391743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 16, 2025 at 09:30:01AM +0800, Jason Wang wrote:
> On Wed, May 14, 2025 at 10:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, May 14, 2025 at 10:19:05AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Apr 09, 2025 at 12:06:03PM +0800, Jason Wang wrote:
> > > > On Tue, Apr 8, 2025 at 7:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Apr 08, 2025 at 03:02:35PM +0800, Jason Wang wrote:
> > > > > > On Mon, Apr 7, 2025 at 4:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> > > > > > > > This patch introduces virtqueue ops which is a set of the callbacks
> > > > > > > > that will be called for different queue layout or features. This would
> > > > > > > > help to avoid branches for split/packed and will ease the future
> > > > > > > > implementation like in order.
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
> > > > > > > >  1 file changed, 67 insertions(+), 29 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > index a2884eae14d9..ce1dc90ee89d 100644
> > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
> > > > > > > >       size_t event_size_in_bytes;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +struct vring_virtqueue;
> > > > > > > > +
> > > > > > > > +struct virtqueue_ops {
> > > > > > > > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> > > > > > > > +                unsigned int total_sg, unsigned int out_sgs,
> > > > > > > > +                unsigned int in_sgs, void *data,
> > > > > > > > +                void *ctx, bool premapped, gfp_t gfp);
> > > > > > > > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
> > > > > > > > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > > > > > > > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > > > > > > > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > > > > > > > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> > > > > > > > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx);
> > > > > > > > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > > > > > > > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > > > > > > > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > > > > > > > +     void (*reset)(struct vring_virtqueue *vq);
> > > > > > > > +};
> > > > > > >
> > > > > > > I like it that it's organized but
> > > > > > > I worry about the overhead of indirect calls here.
> > > > > >
> > > > > > We can switch to use INDIRECT_CALL_X() here
> > > > >
> > > > > If you think it's cleaner.. but INDIRECT_CALL is all chained
> > > >
> > > > Yes, and it would be problematic as the number of ops increased.
> > > >
> > > > > while a switch can do a binary search.
> > > > >
> > > >
> > > > Do you mean a nested switch?
> > >
> > > Not sure what is nested. gcc does a decent job of optimizing
> > > switches. You have 4 types of ops:
> > > packed/packed in order/split/split in order
> > >
> > > So:
> > >
> > > enum {
> > >       VQ_SPLIT,
> > >       VQ_SPLIT_IN_ORDER,
> > >       VQ_PACKED,
> > >       VQ_PACKED_IN_ORDER,
> > > }
> > >
> > >
> > > I do not see how it is worse?
> > >
> > >
> >
> >
> >
> > Actually, here is an idea - create an array of ops:
> >
> >
> >
> > enum vqtype {
> >         SPLIT,
> >         SPLIT_IN_ORDER,
> >         PACKED,
> >         PACKED_IN_ORDER,
> >         MAX
> > };
> >
> >
> > struct ops {
> >         int (*add)(int bar);
> > };
> >
> > extern int packed(int);
> > extern int packedinorder(int);
> > extern int split(int);
> > extern int splitinorder(int);
> >
> > const struct ops allops[MAX] = { [SPLIT] = {split}, [SPLIT_IN_ORDER] = { splitinorder}, [PACKED] = { packed }, [PACKED_IN_ORDER] = {packedinorder}};
> >
> > int main(int argc, char **argv)
> > {
> >         switch (argc) {
> >                 case 0:
> >                         return allops[PACKED].foo(argc);
> >                 case 1:
> >                         return allops[SPLIT].foo(argc);
> >                 default:
> >                         return allops[PACKED_IN_ORDER].foo(argc);
> 
> This still looks like an indirection call as we don't call the symbol
> directly but need to load the function address into a register.

See below.



> >         }
> > }
> >
> >
> > I tested this and compiler is able to elide the indirect calls.
> 
> I've tried the following:
> 
> struct virtqueue_ops split_ops = {
>         .add = virtqueue_add_split,
>         .get = virtqueue_get_buf_ctx_split,
>         .kick_prepare = virtqueue_kick_prepare_split,
>         .disable_cb = virtqueue_disable_cb_split,
>         .enable_cb_delayed = virtqueue_enable_cb_delayed_split,
>         .enable_cb_prepare = virtqueue_enable_cb_prepare_split,
>         .poll = virtqueue_poll_split,
>         .detach_unused_buf = virtqueue_detach_unused_buf_split,
>         .more_used = more_used_split,
>         .resize = virtqueue_resize_split,
>         .reset = virtqueue_reset_split,
> };
> 
> struct virtqueue_ops packed_ops = {
>         .add = virtqueue_add_packed,
>         .get = virtqueue_get_buf_ctx_packed,
>         .kick_prepare = virtqueue_kick_prepare_packed,
>         .disable_cb = virtqueue_disable_cb_packed,
>         .enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
>         .enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
>         .poll = virtqueue_poll_packed,
>         .detach_unused_buf = virtqueue_detach_unused_buf_packed,
>         .more_used = more_used_packed,
>         .resize = virtqueue_resize_packed,
>         .reset = virtqueue_reset_packed,
> };
> 
> const struct virtqueue_ops *all_ops[VQ_TYPE_MAX] = { [SPLIT] = &split_ops,
>                                                      [PACKED] = &packed_ops};
> 
> unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
>         if (vq->event_triggered)
>                 vq->event_triggered = false;
> 
>         switch (vq->layout) {
> case SPLIT:
>                 return all_ops[SPLIT]->enable_cb_prepare(vq);
>                 break;
>         case PACKED:
>                 return all_ops[PACKED]->enable_cb_prepare(vq);
>                 break;
>         default:
>                 BUG();
>                 break;
>         }
> 
> return -EFAULT;
> }
> EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> 
> Compilers gives me (when RETPOLINE is enabled):
> 
> ffffffff8193a870 <virtqueue_enable_cb_prepare>:
> ffffffff8193a870:       f3 0f 1e fa             endbr64
> ffffffff8193a874:       e8 47 68 93 ff          callq
> ffffffff812710c0 <__fentry__>
> ffffffff8193a879:       80 bf 8e 00 00 00 00    cmpb   $0x0,0x8e(%rdi)
> ffffffff8193a880:       74 07                   je
> ffffffff8193a889 <virtqueue_enable_cb_prepare+0x19>
> ffffffff8193a882:       c6 87 8e 00 00 00 00    movb   $0x0,0x8e(%rdi)
> ffffffff8193a889:       8b 87 80 00 00 00       mov    0x80(%rdi),%eax
> ffffffff8193a88f:       85 c0                   test   %eax,%eax
> ffffffff8193a891:       74 15                   je
> ffffffff8193a8a8 <virtqueue_enable_cb_prepare+0x38>
> ffffffff8193a893:       83 f8 01                cmp    $0x1,%eax
> ffffffff8193a896:       75 20                   jne
> ffffffff8193a8b8 <virtqueue_enable_cb_prepare+0x48>
> ffffffff8193a898:       48 8b 05 49 03 4a 01    mov
> 0x14a0349(%rip),%rax        # ffffffff82ddabe8 <all_ops+0x8>
> ffffffff8193a89f:       48 8b 40 28             mov    0x28(%rax),%rax
> ffffffff8193a8a3:       e9 b8 d8 9b 00          jmpq
> ffffffff822f8160 <__x86_indirect_thunk_array>
> ffffffff8193a8a8:       48 8b 05 31 03 4a 01    mov
> 0x14a0331(%rip),%rax        # ffffffff82ddabe0 <all_ops>
> ffffffff8193a8af:       48 8b 40 28             mov    0x28(%rax),%rax
> ffffffff8193a8b3:       e9 a8 d8 9b 00          jmpq
> ffffffff822f8160 <__x86_indirect_thunk_array>
> ffffffff8193a8b8:       0f 0b                   ud2
> ffffffff8193a8ba:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> 
> indirection call is still being mitigated via thunk.



This is because you put the pointers there, and the pointers
are not const themselves.


const struct virtqueue_ops * const all_ops[VQ_TYPE_MAX] 

should do the trick.



Here is the example I wrote:

enum vqtype {
        SPLIT,
        SPLIT_IN_ORDER,
        PACKED,
        PACKED_IN_ORDER,
        MAX
};


struct ops {
        int (*foo)(int bar);
};

extern int packed(int);
extern int packedinorder(int);
extern int split(int);
extern int splitinorder(int);

const struct ops splitops = { split };
const struct ops packedops = { packed };
const struct ops packedinorderops = { packedinorder };
const struct ops splitinorderops = { splitinorder };

const struct ops *const allopsp[MAX] = { [SPLIT] = &splitops, [SPLIT_IN_ORDER] = &splitinorderops, [PACKED] = &packedops, [PACKED_IN_ORDER] = &packedinorderops};
const struct ops allops[MAX] = { [SPLIT] = {split}, [SPLIT_IN_ORDER] = { splitinorder}, [PACKED] = { packed }, [PACKED_IN_ORDER] = {packedinorder}};

int foo(int argc)
{
        switch (argc) {
                case 0:
                return allops[PACKED].foo(argc);
                case 1:
                return allops[SPLIT].foo(argc);
                case 2:
                return allops[PACKED_IN_ORDER].foo(argc);
                case 3:
                return allops[SPLIT_IN_ORDER].foo(argc);
                default:
                return 0;
        }
}
extern int foo(int argc);
int bar(int argc)
{
        switch (argc) {
                case 0:
                return allopsp[PACKED]->foo(argc);
                case 1:
                return allopsp[SPLIT]->foo(argc);
                case 2:
                return allopsp[PACKED_IN_ORDER]->foo(argc);
                case 3:
                return allopsp[SPLIT_IN_ORDER]->foo(argc);
                default:
                return 0;
        }
}
extern int bar(int argc);
int main(int argc, char **argv)
{
        foo(argc);
        bar(argc);
        return 0;
}



then:
$ gcc -c -O2 -ggdb main.c
$ objdump -r -ld main.o

main.o:     file format elf64-x86-64
mst@tuck:~$ objdump -r -ld main.o

main.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <foo>:
foo():
/home/mst/main.c:29
   0:   83 ff 02                cmp    $0x2,%edi
   3:   74 2a                   je     2f <foo+0x2f>
   5:   7f 12                   jg     19 <foo+0x19>
   7:   85 ff                   test   %edi,%edi
   9:   74 1d                   je     28 <foo+0x28>
   b:   ff cf                   dec    %edi
   d:   75 2a                   jne    39 <foo+0x39>
/home/mst/main.c:33
   f:   bf 01 00 00 00          mov    $0x1,%edi
  14:   e9 00 00 00 00          jmp    19 <foo+0x19>
                        15: R_X86_64_PLT32      split-0x4
/home/mst/main.c:29
  19:   83 ff 03                cmp    $0x3,%edi
  1c:   75 1b                   jne    39 <foo+0x39>
/home/mst/main.c:37
  1e:   bf 03 00 00 00          mov    $0x3,%edi
  23:   e9 00 00 00 00          jmp    28 <foo+0x28>
                        24: R_X86_64_PLT32      splitinorder-0x4
/home/mst/main.c:31
  28:   31 ff                   xor    %edi,%edi
  2a:   e9 00 00 00 00          jmp    2f <foo+0x2f>
                        2b: R_X86_64_PLT32      packed-0x4
/home/mst/main.c:35
  2f:   bf 02 00 00 00          mov    $0x2,%edi
  34:   e9 00 00 00 00          jmp    39 <foo+0x39>
                        35: R_X86_64_PLT32      packedinorder-0x4
/home/mst/main.c:41
  39:   31 c0                   xor    %eax,%eax
  3b:   c3                      ret

000000000000003c <bar>:
bar():
/home/mst/main.c:43
  3c:   eb c2                   jmp    0 <foo>

Disassembly of section .text.startup:

0000000000000000 <main>:
main():
/home/mst/main.c:60
   0:   48 83 ec 18             sub    $0x18,%rsp
/home/mst/main.c:61
   4:   89 7c 24 0c             mov    %edi,0xc(%rsp)
   8:   e8 00 00 00 00          call   d <main+0xd>
                        9: R_X86_64_PLT32       foo-0x4
/home/mst/main.c:62
   d:   8b 7c 24 0c             mov    0xc(%rsp),%edi
  11:   e8 00 00 00 00          call   16 <main+0x16>
                        12: R_X86_64_PLT32      foo-0x4
/home/mst/main.c:64
  16:   31 c0                   xor    %eax,%eax
  18:   48 83 c4 18             add    $0x18,%rsp


compiler was able to figure out they are the same.



> The way I can think so far is something like this that passess the
> function symbol to the macro:
> 
> #define VIRTQUEUE_CALL(vq, split_fn, packed_fn, ...)    \
>         ({                                              \
>         typeof(split_fn(vq, ##__VA_ARGS__)) ret;        \
>         switch ((vq)->layout) {                 \
>         case SPLIT:                                     \
>                 ret = split_fn(vq, ##__VA_ARGS__);      \
>                 break;                                  \
>         case PACKED:                                    \
>                 ret = packed_fn(vq, ##__VA_ARGS__);     \
>                 break;                                  \
>         default:                                        \
>                 BUG();                                  \
>                 ret = (typeof(ret))-EFAULT;             \
>                 break;                                  \
>         }                                               \
>         ret;                                            \
> })
> 
> Then I can't see RETPOLINE for indirect calls.
> 
> Thanks

So check out my hack I think a bit cleaner?
Or really we can do e.g. two INDIRECT calls chained,
I will think if we can combine it with the array hack
maybe.






> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > >
> > >
> > >
> > >
> > >
> > >
> > > > >
> > > > > > (but I'm not sure we
> > > > > > should worry about it too much as ndo_ops or qdiscs doesn't use that).
> > > > >
> > > > >
> > > > > And that's why we ended up with xdp, no? the stack's too heavy ...
> > > > >
> > > > > > > How about a switch statement instead?
> > > > > > >
> > > > > > > struct vring_virtqueue {
> > > > > > >         enum vring_virtqueue_ops ops;
> > > > > > >
> > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> > > > > > >  {
> > > > > > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > >
> > > > > > >         switch (vq->ops) {
> > > > > > >          VQ_PACKED:
> > > > > > >          VQ_SPLIT:
> > > > > > >          VQ_IN_ORDER:
> > > > > > >         }
> > > > > > >
> > > > > > >
> > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > Actually, the matrix will be 2*2:
> > > > > >
> > > > > > PACKED, SPLIT, PACKED_IN_ORDER, SPLIT_IN_ORDER
> > > > >
> > > > > Confused. Same amount of enums as ops structures in your approach, no?
> > > >
> > > > I meant in this series, we will have 4 ops not 3.
> > > >
> > > > >
> > > > >
> > > > > > And will be doubled if a new layout is implemented.
> > > > > >
> > > > > > If we open them such a switch will spread in a lot of places in the code.
> > > > > >
> > > > > > Thanks
> > > >
> > > > Thanks
> > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > >  struct vring_virtqueue {
> > > > > > > >       struct virtqueue vq;
> > > > > > > >
> > > > > > > > +     struct virtqueue_ops *ops;
> > > > > > > > +
> > > > > > > >       /* Is this a packed ring? */
> > > > > > > >       bool packed_ring;
> > > > > > > >
> > > > > > > > @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +struct virtqueue_ops split_ops;
> > > > > > > > +
> > > > > > > >  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> > > > > > > >                                              struct vring_virtqueue_split *vring_split,
> > > > > > > >                                              struct virtio_device *vdev,
> > > > > > > > @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> > > > > > > >               return NULL;
> > > > > > > >
> > > > > > > >       vq->packed_ring = false;
> > > > > > > > +     vq->ops = &split_ops;
> > > > > > > >       vq->vq.callback = callback;
> > > > > > > >       vq->vq.vdev = vdev;
> > > > > > > >       vq->vq.name = name;
> > > > > > > > @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_virtqueue *vq)
> > > > > > > >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +struct virtqueue_ops packed_ops;
> > > > > > > > +
> > > > > > > >  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> > > > > > > >                                              struct vring_virtqueue_packed *vring_packed,
> > > > > > > >                                              struct virtio_device *vdev,
> > > > > > > > @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> > > > > > > >       vq->broken = false;
> > > > > > > >  #endif
> > > > > > > >       vq->packed_ring = true;
> > > > > > > > +     vq->ops = &packed_ops;
> > > > > > > >       vq->dma_dev = dma_dev;
> > > > > > > >       vq->use_dma_api = vring_use_dma_api(vdev);
> > > > > > > >
> > > > > > > > @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_virtqueue *vq, u32 num)
> > > > > > > >       return -ENOMEM;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +struct virtqueue_ops split_ops = {
> > > > > > > > +     .add = virtqueue_add_split,
> > > > > > > > +     .get = virtqueue_get_buf_ctx_split,
> > > > > > > > +     .kick_prepare = virtqueue_kick_prepare_split,
> > > > > > > > +     .disable_cb = virtqueue_disable_cb_split,
> > > > > > > > +     .enable_cb_delayed = virtqueue_enable_cb_delayed_split,
> > > > > > > > +     .enable_cb_prepare = virtqueue_enable_cb_prepare_split,
> > > > > > > > +     .poll = virtqueue_poll_split,
> > > > > > > > +     .detach_unused_buf = virtqueue_detach_unused_buf_split,
> > > > > > > > +     .more_used = more_used_split,
> > > > > > > > +     .resize = virtqueue_resize_split,
> > > > > > > > +     .reset = virtqueue_reset_split,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct virtqueue_ops packed_ops = {
> > > > > > > > +     .add = virtqueue_add_packed,
> > > > > > > > +     .get = virtqueue_get_buf_ctx_packed,
> > > > > > > > +     .kick_prepare = virtqueue_kick_prepare_packed,
> > > > > > > > +     .disable_cb = virtqueue_disable_cb_packed,
> > > > > > > > +     .enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
> > > > > > > > +     .enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
> > > > > > > > +     .poll = virtqueue_poll_packed,
> > > > > > > > +     .detach_unused_buf = virtqueue_detach_unused_buf_packed,
> > > > > > > > +     .more_used = more_used_packed,
> > > > > > > > +     .resize = virtqueue_resize_packed,
> > > > > > > > +     .reset = virtqueue_reset_packed,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> > > > > > > >                                        void (*recycle)(struct virtqueue *vq, void *buf))
> > > > > > > >  {
> > > > > > > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> > > > > > > >  {
> > > > > > > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > > >
> > > > > > > > -     return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> > > > > > > > -                                     out_sgs, in_sgs, data, ctx, premapped, gfp) :
> > > > > > > > -                              virtqueue_add_split(vq, sgs, total_sg,
> > > > > > > > -                                     out_sgs, in_sgs, data, ctx, premapped, gfp);
> > > > > > > > +     return vq->ops->add(vq, sgs, total_sg,
> > > > > > > > +                         out_sgs, in_sgs, data, ctx, premapped, gfp);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /**
> > > > > > > > @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
> > > > > > > >  {
> > > > > > > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > > >
> > > > > > > > -     return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> > > > > > > > -                              virtqueue_kick_prepare_split(vq);
> > > > > > > > +     return vq->ops->kick_prepare(vq);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> > > > > > > >
> > > > > > > > @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
> > > > > > > >  {
> > > > > > > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > > >
> > > > > > > > -     return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> > > > > > > > -                              virtqueue_get_buf_ctx_split(vq, len, ctx);
> > > > > > > > +     return vq->ops->get(vq, len, ctx);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> > > > > > > >
> > > > > > > > @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> > > > > > > >  {
> > > > > > > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > > >
> > > > > > > > -     if (vq->packed_ring)
> > > > > > > > -             virtqueue_disable_cb_packed(vq);
> > > > > > > > -     else
> > > > > > > > -             virtqueue_disable_cb_split(vq);
> > > > > > > > +     return vq->ops->disable_cb(vq);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > > > > > > >
> > > > > > > > @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> > > > > > > >       if (vq->event_triggered)
> > > > > > > >               vq->event_triggered = false;
> > > > > > > >
> > > > > > > > -     return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> > > > > > > > -                              virtqueue_enable_cb_prepare_split(vq);
> > > > > > > > +     return vq->ops->enable_cb_prepare(vq);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > > > > > > >
> > > > > > > > @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
> > > > > > > >               return false;
> > > > > > > >
> > > > > > > >       virtio_mb(vq->weak_barriers);
> > > > > > > > -     return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx) :
> > > > > > > > -                              virtqueue_poll_split(vq, last_used_idx);
> > > > > > > > +     return vq->ops->poll(vq, last_used_idx);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> > > > > > > >
> > > > > > > > @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> > > > > > > >       if (vq->event_triggered)
> > > > > > > >               vq->event_triggered = false;
> > > > > > > >
> > > > > > > > -     return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> > > > > > > > -                              virtqueue_enable_cb_delayed_split(vq);
> > > > > > > > +     return vq->ops->enable_cb_delayed(vq);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> > > > > > > >
> > > > > > > > @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> > > > > > > >  {
> > > > > > > >       struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > > >
> > > > > > > > -     return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> > > > > > > > -                              virtqueue_detach_unused_buf_split(vq);
> > > > > > > > +     return vq->ops->detach_unused_buf(vq);
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> > > > > > > >
> > > > > > > >  static inline bool more_used(const struct vring_virtqueue *vq)
> > > > > > > >  {
> > > > > > > > -     return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> > > > > > > > +     return vq->ops->more_used(vq);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /**
> > > > > > > > @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > > > > > >       if (recycle_done)
> > > > > > > >               recycle_done(_vq);
> > > > > > > >
> > > > > > > > -     if (vq->packed_ring)
> > > > > > > > -             err = virtqueue_resize_packed(vq, num);
> > > > > > > > -     else
> > > > > > > > -             err = virtqueue_resize_split(vq, num);
> > > > > > > > +     err = vq->ops->resize(vq, num);
> > > > > > > >
> > > > > > > >       return virtqueue_enable_after_reset(_vq);
> > > > > > > >  }
> > > > > > > > @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
> > > > > > > >       if (recycle_done)
> > > > > > > >               recycle_done(_vq);
> > > > > > > >
> > > > > > > > -     if (vq->packed_ring)
> > > > > > > > -             virtqueue_reset_packed(vq);
> > > > > > > > -     else
> > > > > > > > -             virtqueue_reset_split(vq);
> > > > > > > > +     vq->ops->reset(vq);
> > > > > > > >
> > > > > > > >       return virtqueue_enable_after_reset(_vq);
> > > > > > > >  }
> > > > > > > > --
> > > > > > > > 2.42.0
> > > > > > >
> > > > >
> >

