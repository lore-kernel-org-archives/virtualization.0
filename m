Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A5DC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 17:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 159EC6115F;
	Wed, 22 Feb 2023 17:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 159EC6115F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=bqL/NTLX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kma472XsrYuT; Wed, 22 Feb 2023 17:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 929AC60D4E;
	Wed, 22 Feb 2023 17:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 929AC60D4E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BF4FC0032;
	Wed, 22 Feb 2023 17:22:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C790C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 17:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0771C40545
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 17:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0771C40545
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=bqL/NTLX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VWqyIue6XX1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 17:22:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41D4B4053D
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41D4B4053D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 17:22:42 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id fp16so8238546qtb.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urt54I/eS/8HI+o0VQThaLcMNHDkXdGsGwBFBUqrL/o=;
 b=bqL/NTLXKGEuL+4m3vQ7ek/8ys4mzYnaQ01HjVZjpjK5gJ0l1od5y20SrxcEZciafi
 wd0dLcVAOjsXK8vlzgbS75ZagoJykvR+i3ffLgfZS9rixLb/OCXsFQ0ttJ369FfW/W+h
 YUz2fvNigpgpsH4FhuH5CKYuJDrOJT7cGaqXVrkaNbe/3QTo9ABey8iGP6GkZbLj8E6d
 U955eINgy9LZrlpUkGsUFA54jZj1D1ZHlvmAXkpbhl+X+Y2vtXCNRz3DZH15e+d3ryl0
 ppqjaDrRuMyjKBTiC2QP3KvchryigCXWtD5rHwXr8e81b1HqhwDXNUPNfiFzxUUx2eBk
 rwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=urt54I/eS/8HI+o0VQThaLcMNHDkXdGsGwBFBUqrL/o=;
 b=TJre+SGNqJcWQHY7s9hkVcJaukwDW/qbmnyB3JH9g7frgBcIpnxAkdo7JZEA2TuS45
 7rA83peG7WrKyhAya+8j2eNpdx+EkSHyqnSV420c8RlOq7FrtMYyhvu8dZjzP+GKObpD
 2Lme870imeYjJdvx+RhtB8hPuHyg2vytsADefTZJ/kLUek1TAC4s+QbRJi9fomP+IW5i
 xgJgVD/DOW1wUS8tY78P+aMoC2UvaEQ0dBjCdyCf0JWJty3YUISw2A4lZ1WrkZQi1lvF
 HlLpgeRCcgmfN8Xtk5lXi92OHcfIiNjmObxzAJ4Fuux5lv7q6JAJ5uApOVMdk5O9pyFB
 qEBw==
X-Gm-Message-State: AO0yUKULbS71EmeSbIFzoR8XgZTrxXNBUehUB3zGX7evdkjMJBFn1VpR
 hSDIFuZM458q9e7iEyibNYI=
X-Google-Smtp-Source: AK7set8i+vR9JM1Pw3Dm3JrVqhd82Rxrlt8ctyIHuZQSTvzdEikyUMZhaJazcG+yjybr3la6bn52KQ==
X-Received: by 2002:a05:622a:610:b0:3b8:6930:ee6 with SMTP id
 z16-20020a05622a061000b003b869300ee6mr322025qta.21.1677086561106; 
 Wed, 22 Feb 2023 09:22:41 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com.
 [34.150.157.240]) by smtp.gmail.com with ESMTPSA id
 oq21-20020a05620a611500b0074235fc7a69sm1560889qkn.68.2023.02.22.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Feb 2023 09:22:40 -0800 (PST)
Date: Wed, 22 Feb 2023 12:22:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <63f64f6053a19_189d62088a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230222110534-mutt-send-email-mst@kernel.org>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
 <Y/TltJnD4k5hB6Z1@nanopsycho>
 <63f4ed716af37_d174a20880@willemb.c.googlers.com.notmuch>
 <Y/XLIs+4eg7xPyF0@nanopsycho>
 <63f6314d678bc_2ab6208a@willemb.c.googlers.com.notmuch>
 <20230222110534-mutt-send-email-mst@kernel.org>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Mime-Version: 1.0
Cc: Jiri Pirko <jiri@resnulli.us>, vmireyno@marvell.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Michael S. Tsirkin wrote:
> On Wed, Feb 22, 2023 at 10:14:21AM -0500, Willem de Bruijn wrote:
> > Either including the link that Michael shared or quoting the relevant
> > part verbatim in the commit message would help, thanks.
> > 
> > Thinking it over, my main concern is that the prescriptive section in
> > the spec does not state what to do when the value is clearly garbage,
> > as we have seen with syzkaller.
> > 
> > Having to sanitize input, by dropping if < ETH_HLEN or > length, to
> > me means that the device cannot trust the field, as the spec says it
> > should. 
> 
> Right. I think the implication is that if device detects and illegal
> value it's OK for it to just drop the packet or reset or enter
> a broken mode until reset.
> 
> By contrast without the feature bit the header size can be
> used as a hint e.g. to size allocations but you must
> recover if it's incorrect.
> 
> And yes tap seems to break if you make it too small or if you make
> it huge so it does not really follow the spec in this regard.
> 
> Setting the flag will not fix tap because we can't really
> affort breaking all drivers who don't set it. But it will
> prepare the ground for when tens of years from now we
> actually look back and say all drivers set it, no problem.
> 
> So that's a good reason to ack this patch.

I also have no concerns with the commit itself. It would become an
issue only if tap would support it and trust hdr_len unconditionally.

Acked-by: Willem de Bruijn <willemb@google.com>
 
> However if someone is worried about this then fixing tap
> so it recovers from incorrect header length without
> packet loss is a good idea.
> 
> > Sanitization is harder in the kernel, because it has to support all
> > kinds of link layers, including variable length.
> > 
> > Perhaps that's a discussion for the spec rather than this commit. But
> > it's a point to clarify as we add support to the code.
> 
> -- 
> MST
> 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
