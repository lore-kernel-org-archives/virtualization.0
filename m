Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675793590A9
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325300; cv=pass; b=Zm88nsb8oxnFer/CQVTZPNqh8W/so6SZgfghMCxr6k2KjhkeeP8e7Dy8lg5jh5AR0CLb+jdAECGrNPyjAqP/M+vFtWiTBBJlsBbrYQnyHIZsyMivbaQ0IhsYErNJsjBKHO+tB+vxqHzaMYIqmJvybx7qAzKuafJUToQWGulBuMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325300; c=relaxed/simple;
	bh=0MmwDt0N+cjGTBkLO+1REp2Kd6NP3k+zduo/AMzi+Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNbOHcfTPvNSNFl6itqxVdHqCxqv1gn4UISZpN2ieonk9hCxXH18ScVWjCFp4+UGmWSppc2MSEvch8q9wQPi5xYbR1w3yx+4bgxToT0OVoO1LvnHs0sWNXvXJvYabRAkOstYUcy0rMuAL5yxx5P51eVHiIpihHRs8tWpXz7swwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKu+TiGC; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKu+TiGC"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5094e1d17d3so5674901cf.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 07:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325297; cv=none;
        d=google.com; s=arc-20240605;
        b=h6kh2DcMlrt1a4iGYYhAmKiWAGl2rdhjIh3SvbfLIVp9R26o+XgRRU0zgTuxQeERe8
         NqalTYp0LuS+YHFjntDOQukgtQW1pZoxhfELIjhA/XbrBARLCo6fetqE4ATC+a0wSPQ7
         5LCLZ71SoQbKRdLBmq3zcSkFonDBE/xK+7q6Y0nZCna1H+JlF9wbSgyOqinrPsQgxAK8
         SSuJjME8DEgcTTVovRDrjU7gRDCBkbbYX6bfP73LmPTsWBdepaZAA0wOFJMz8D7Wxzd6
         lsoC+gCKHtO+KsZIdS1xdev7+4+a8dM42ioUkYrdJdGDU8alhd+I9tkNutvSQ11x+dKJ
         pq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        fh=yuctJR8NrAbW05Lhz+MvorFvDxvcL+NxcrfrsYGVZ+o=;
        b=e1SsO1UU8aZskPZPWqktR4e0WMBqGB2fKw2gHuk9HL3eAxmwd/fJhOuU5YO82dO0un
         ph9+xGeC5Ev3StnuCVvFjEy6f6JRLQldEo4hs2tX8dVg3x6KgvHV8bFn0Oc6xwChtFze
         5CVdJzpMEJM25tmo/G1JewVXo62E53/HJEceLIC+RXU+D7HzaMDhuvGTpObFCy6m0nu/
         RtZ8BMCZ2B6tO25FeVsfia3UVZpS8uGj9Q0CkBiFw3F5Y0OHaheRU3mFcGOJEBBX2SsI
         VFQc5UrsowatoykYmb/31Db80HHKjD1sK9vt4FfQCf+9PIWxNZbuMIMe33fjDjz1iP1x
         ci2A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773325297; x=1773930097; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        b=SKu+TiGCv5dkSxUxJQ0hLujswTOfqm9NpO/t83aLAUBvK7oom2dmHk3SPSq+olF0rP
         kLKjXR9qOGjCv021t8SIXE4OKPnilOkTv+0SVIcvgIjIYqZaxTwe+8XUxvW1vWPN5Yn2
         na14dNiBcD3iMDPa6AiKrnRl6FEtmzEuwskCIkt5bYR8eC15hAg258IEiADipi2bhLpc
         TkpApV7ZiZcYyCLU6yExrkAEJ3V1Y8F7wJb5r+hT5exVHnszpEV1wUPuqdg26E9zTVuU
         xwUSBHfBBlM7a8hjIP7YrwWwTu79PxraGYHt3PG3iU/FHpkl6/1v8Ewj5849L1UbEYnX
         Yeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325297; x=1773930097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        b=V8YIsaqpjxeudnoE+TJtQf3GzOweUqKT4aF2rFSF4qHJqxMQ3gxZhbTRoV8ak33q0x
         Nl/VIDQj412n+cL1HW+W/osyCVf2QhoRAuqTASURHgECi0TZ4IPBY9vlXWAEOjFn3ZYS
         YO+7IZBoPrX/3qPchKL5bguuySqDH9DmJ8Kg0ceEQ3Gmjbya93xNw8sj+Pj7sMCD9ecr
         vjBRp7PSmtvta5E0iUIqbLor41ot0Xeo+78Svy26K2fcGT9FrzVvGb8Vd5ZxhwLEkwBM
         bV7WN76MCNi0uRnXiATy8barqkoUjwxhSPD0TdJgKLcnDb1QPYFsHx+uWiZ019M23wmK
         +UXg==
X-Forwarded-Encrypted: i=1; AJvYcCUY3Macy9CCm1OkLCbLZhd1mXvStKlbEz9qtAgummweWzNImw8kI1UmdISCoTnxo18rO+myfw+xTiSgBMyYew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0+Ywd+xK12jfEVTh3kfOEQWxXTyOEu+GSr8o3thuFkesNoMhv
	LkV+metonVLBn2c97fSsFBrvIuGXq6MXSd+UF5Mbbi1EMN2bTvB782D4lf3UCJ+bfooXyfAMnTn
	53cFbtAfeXB0KTs2mv9Peo5/dY/MU55OXHYzXLk/G
X-Gm-Gg: ATEYQzw8aivW6Kn+ApCLt6iYOPCeKOjp8qeZx7izFBCDdiRi6Zgs4hrqfOVE8W8Nn/W
	jokg9CB0FcplIzBq3DwfOvuUam9vQXhnFbbEvs30X2AmXn7e39BokImbSo8Hr8hODgzKLcxAqW0
	TpaIMNAYFJG1lk9Obmtb86GF8nF+iCCkhxpemLeZ80EcARzj74YmSALGSobEyhJp88IanEQMQTP
	TpUzwuq2Np2L+7q13IFrwEqQWSbEcqLDPqKwxTuPMWGjNx8VldIpUMQr/kbLbzAKzd7B+o7ZGY5
	uY5ZLda6
X-Received: by 2002:a05:622a:14c:b0:501:1795:9d52 with SMTP id
 d75a77b69052e-50939fc1863mr86449811cf.33.1773325296875; Thu, 12 Mar 2026
 07:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-4-simon.schippers@tu-dortmund.de> <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
 <20260312094447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260312094447-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 15:21:25 +0100
X-Gm-Features: AaiRm519R7QoAd18JWvrdvhH1ifA15H5AznmUpI-fEIpOmq2LTIYuzUlf4ZNyAg
Message-ID: <CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb=Qr7OTKW2R7Ldixg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Mar 12, 2026 at 02:17:16PM +0100, Eric Dumazet wrote:
> > On Thu, Mar 12, 2026 at 2:06=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> > >
> > > This patch moves the check for available free space for a new entry i=
nto
> > > a separate function. As a result, __ptr_ring_produce() remains logica=
lly
> > > unchanged, while the new helper allows callers to determine in advanc=
e
> > > whether subsequent __ptr_ring_produce() calls will succeed. This
> > > information can, for example, be used to temporarily stop producing u=
ntil
> > > __ptr_ring_peek() indicates that space is available again.
> > >
> > > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > > ---
> > >  include/linux/ptr_ring.h | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > > index 534531807d95..a5a3fa4916d3 100644
> > > --- a/include/linux/ptr_ring.h
> > > +++ b/include/linux/ptr_ring.h
> > > @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_rin=
g *r)
> > >         return ret;
> > >  }
> > >
> > > +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> > > +{
> > > +       if (unlikely(!r->size) || r->queue[r->producer])
> >
> > I think this should be
> >
> >        if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
> >
> > And of course:
> >
> > @@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring=
 *r)
> >  static inline bool __ptr_ring_empty(struct ptr_ring *r)
> >  {
> >         if (likely(r->size))
> > -               return !r->queue[READ_ONCE(r->consumer_head)];
> > +               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]=
);
> >         return true;
> >  }
>
>
> I don't understand why it's necessary. consumer_head etc are
> all lock protected.
>
> queue itself is not but we are only checking it for NULL -
> it is fine if compiler reads it in many chunks and not all
> at once.
>
> > @@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
> > ptr_ring *r, int consumer_head)
> >          * besides the first one until we write out all entries.
> >          */
> >         while (likely(head > r->consumer_tail))
> > -               r->queue[--head] =3D NULL;
> > +               WRITE_ONCE(r->queue[--head], NULL);
> >
> >         r->consumer_tail =3D consumer_head;
> >  }
> >
> >
> > Presumably we should fix this in net tree first.
>
>
> Maybe this one yes but I am not sure at all - KCSAN is happy.
>

Hmmm.. what about this trace ?

BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
__ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
__ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
__ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
__skb_array_consume include/linux/skb_array.h:98 [inline]
pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
dequeue_skb net/sched/sch_generic.c:297 [inline]
qdisc_restart net/sched/sch_generic.c:402 [inline]
__qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
qdisc_run include/net/pkt_sched.h:120 [inline]
net_tx_action+0x379/0x590 net/core/dev.c:5793
handle_softirqs+0xb9/0x280 kernel/softirq.c:622
do_softirq+0x45/0x60 kernel/softirq.c:523
__local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
local_bh_enable include/linux/bottom_half.h:33 [inline]
bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
__ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
skb_array_produce include/linux/skb_array.h:44 [inline]
pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
dev_qdisc_enqueue net/core/dev.c:4144 [inline]
__dev_xmit_skb net/core/dev.c:4188 [inline]
__dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
dev_queue_xmit include/linux/netdevice.h:3384 [inline]
__bpf_tx_skb net/core/filter.c:2153 [inline]
__bpf_redirect_common net/core/filter.c:2197 [inline]
__bpf_redirect+0x862/0x990 net/core/filter.c:2204
____bpf_clone_redirect net/core/filter.c:2487 [inline]
bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
bpf_prog_53f18857bc887b09+0x22/0x2a
bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
__bpf_prog_run include/linux/filter.h:723 [inline]
bpf_prog_run include/linux/filter.h:730 [inline]
bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
PREEMPT(full)
Tainted: [W]=3DWARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/24/2026
