Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD6C433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:41:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64D522DFA
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64D522DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 41BCC20462;
	Tue, 12 Jan 2021 20:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DMiobrbpeemn; Tue, 12 Jan 2021 20:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4FD5920031;
	Tue, 12 Jan 2021 20:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34EE4C0893;
	Tue, 12 Jan 2021 20:40:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34305C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 226D685C92
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:40:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6AaZr3eOSiPP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:40:55 +0000 (UTC)
X-Greylist: delayed 00:11:51 by SQLgrey-1.7.6
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2D1B585BA9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:40:55 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id s19so916243oos.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GOqyNTF7gtUKPVXIMkVFT3geI3snsFvpWMRi06NItYY=;
 b=ZhmlJV62BeU9fJsGlfyvETF+LCKlVC2NajZUVYu+YTBpcA7oEZg+f+cRZvbeGR/wRn
 OE8OA5J2WD9Pyviogsk4vAUx0oNQmVzR8vJjuNxc6R/JAdYYrMuliwJOKaeispULA4s3
 Paz/kpI+jzpctNP+2Igp6sNge3FY1sSX/OxQO1Mm77d4BSdi0VixLEpB9NM9zsJDNE17
 nTGyKfNHi0f22Ba4gFcYkm4igDeQKN59JTV5QfhwG9iHkwNEih7lMpfyyre20lo295AS
 5hblNfZ5Rfz6/jFNkOzYEb9rWjcEeyiCbtE5JTqFWgE0Ik2pVEOWGwT+0JfXpFcHqAKJ
 wqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GOqyNTF7gtUKPVXIMkVFT3geI3snsFvpWMRi06NItYY=;
 b=dpxf425O6LP053BvGdnc2zzC/30KBFX7Smp2xEWOxZTMEpuH55+a57xKMNAcG/kbJd
 oyyAnTlUEdeRG+9dwNZzhaxrhDFank8LsgomRsLdF18S+lIy0w71D2lZherigDaVUcu7
 4+pTWsEL5Jui10Hty5xF8Y1k+I29bTxla+agluQ7Ae5939aDS3sf7eL74G1HBsvwTFRf
 TEXDZANxSzEQNTvM5kgbkUKb/1VfdK64rrIw5fjLkbi4FgThja57mA8YEI7/H8Jxd6mX
 y9tctOtBf76zEuv1KhAAWmAi26UmAN9empprxbSEfea1yYQiuQM70vyvVKsm9vc3FvW0
 4Tag==
X-Gm-Message-State: AOAM532h2REE2W2TdTdDALvoFrdaXG0b/wrGuxrRzY10P0UihIO3J236
 pq8ncRbeq6+06TJPGE5kE25UrwMN/KtqrMcUcH7+Kw==
X-Google-Smtp-Source: ABdhPJz/+VG3D8S0Su6wBVIT9oU9vLMwvxqzB/oumqqIsu0lWVXQRoNiE9y/Wv8b1dAsLKpTLLAHvt9lQNMSp/UwXic=
X-Received: by 2002:a4a:d396:: with SMTP id i22mr552498oos.55.1610484054385;
 Tue, 12 Jan 2021 12:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <20210112194143.1494-4-yuri.benditovich@daynix.com>
In-Reply-To: <20210112194143.1494-4-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 12 Jan 2021 22:40:42 +0200
Message-ID: <CAOEp5Ocz-xGq5=e=WY0aipEYHEhN-wxekNaAiqAS+HsOF8TcDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program
 type
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, 
 rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org, 
 herbert@gondor.apana.org.au, steffen.klassert@secunet.com, 
 pablo@netfilter.org, decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, 
 elver@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc: Yan Vugenfirer <yan@daynix.com>
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

On Tue, Jan 12, 2021 at 9:42 PM Yuri Benditovich
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
>                 if (IS_ERR(prog))
>                         return PTR_ERR(prog);
>         }

Comment from Alexei Starovoitov:
Patches 1 and 2 are missing for me, so I couldn't review properly,
but this diff looks odd.
It allows sched_cls prog type to attach to tun.
That means everything that sched_cls progs can do will be done from tun hook?
sched_cls assumes l2 and can modify the packet.
I think crashes are inevitable.

> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
