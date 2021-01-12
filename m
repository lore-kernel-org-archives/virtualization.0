Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24EAC433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:47:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5576223117
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 19:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5576223117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 21B992043F;
	Tue, 12 Jan 2021 19:47:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZP4eqlSxMRLJ; Tue, 12 Jan 2021 19:47:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 53FD120431;
	Tue, 12 Jan 2021 19:47:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C0ADC088B;
	Tue, 12 Jan 2021 19:47:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D8D4C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5C1078601B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GhOeYHrNQ851
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 70D2485FED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:47:00 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id y22so4191121ljn.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 11:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nLuzLYNt5T8osq7JXeaiHrLO6+i9dEnVYqGJgVkKi9Y=;
 b=vYfNW4936VSfsfaE4FPjVdNXto4N/M6kGen+8Mc9PnTNtkt3FVhlO9Lji+rTbggdvU
 efVCBHX+QBBFFLAFdKchQ9dGckH15dNbIkoMq40g8WcfI8bO4r8omaKScS211OynYzio
 pwt0Af28IscLBvCfEPiZOP32LiaGnrTdwTR8t01o0T8cix8TCiWYtr2bztCZ7EK7HmeC
 CG3gbo/QgzsMZwhBldrnwCNwPwwfDG8/cDqA3S16bIuaw2LV5L8InT8eWdbL5WxiA1iD
 rB3byLm4YjGBcbnHqTtCMuvlbGkrDi88jaoc8oqgOVG7r/OokbENWKJ7gGq16KhulWI0
 HrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nLuzLYNt5T8osq7JXeaiHrLO6+i9dEnVYqGJgVkKi9Y=;
 b=OtSbVC25xBllw5txmnJMLCmBRTZGaGpGhq7ikLWe1q/I4NAzvRrELjP7SvxpnIJFzJ
 9aPbOVPuP/GSo6yGxIqAP3J7jiNSNBfMNjcsvQxeb2pzXFpJhyh96p3Rd/GRMzudPymO
 hXSrJyBIaiQpH7a/OUsko41XDStO9EmMcdM5hRUrOR9Bgh0waCm7tCp9Lv1peEwQwtRD
 +GyWLKeKJuxfj4tGopJWWxsOWgiRu+ITR17EZVUtiuFLkfN8/cJbrXlG1kNtKRshRa0g
 MZYfVFdukthQ/iCqPAdQKdsJlbXJjItKY1/2iq0QdGiDGTO019MRHakwnVXgzafuhVUv
 DbLw==
X-Gm-Message-State: AOAM532KWJASlkRSpNDVRVDysWqdcVICv3cryxzHFWScxPQqhp18Mgwq
 vRdylqY5KIX56llrHgIackYrtdipc3noBs5PnNA=
X-Google-Smtp-Source: ABdhPJwZhBCGKnrIy2pClnDTPtHGtrdA4y52ofV0ZvmD0av1lZET+wEvea6DglcSlWgjWslhNj+O3PtSrJmX0zO8gd8=
X-Received: by 2002:a2e:878a:: with SMTP id n10mr350199lji.236.1610480818432; 
 Tue, 12 Jan 2021 11:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <20210112194143.1494-4-yuri.benditovich@daynix.com>
In-Reply-To: <20210112194143.1494-4-yuri.benditovich@daynix.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Jan 2021 11:46:46 -0800
Message-ID: <CAADnVQ++1_voT2fZ021ExcON0KfHtA8MyHc-WYe-XXJoPTD6ig@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program
 type
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemb@google.com>,
 Network Development <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, gustavoars@kernel.org,
 "David S. Miller" <davem@davemloft.net>, nogikh@google.com,
 bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 12, 2021 at 11:42 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> This program type can set skb hash value. It will be useful
> when the tun will support hash reporting feature if virtio-net.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  drivers/net/tun.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 7959b5c2d11f..455f7afc1f36 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2981,6 +2981,8 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
>                 prog = NULL;
>         } else {
>                 prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
> +               if (IS_ERR(prog))
> +                       prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SCHED_CLS);

You've ignored the feedback and just resend? what for?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
