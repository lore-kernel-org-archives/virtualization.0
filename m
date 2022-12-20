Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B2AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 18:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B968F81D7D;
	Tue, 20 Dec 2022 18:28:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B968F81D7D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=P6hHUtJo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvO5laofR2zs; Tue, 20 Dec 2022 18:28:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3099B81066;
	Tue, 20 Dec 2022 18:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3099B81066
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9018C0035;
	Tue, 20 Dec 2022 18:28:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3BFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 18:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF8074047D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 18:28:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF8074047D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=P6hHUtJo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sZY1a80NG2jW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 18:28:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9945403F5
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9945403F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 18:28:00 +0000 (UTC)
Received: by mail-ua1-x931.google.com with SMTP id p9so3050820uam.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jIT6fF5gjfLCiNasKGkoBaNWOPI0QJSFqW2RO835jA4=;
 b=P6hHUtJo+wZUfhtWkXLr7H5eONR4z7bhH+Dd2Pu6drAyozwW4Rmg8/cKU8uE2blr6B
 LBqB/IA5soQBF/NJC9w1ZoA1WTNThXvPrSBXhGDO5adDpwfZTyNvBRcpxLR44EaKQAXr
 LMTe8WU4WxF9iwSS+ufRzydfXNyS1eqTqceEBQNsua9BdPYWt0iDRDpDuAVR6WqHtHk4
 HbBSpxSx7hz7S0VBS+iwOpnwzVKP48t2fYpiesyaxy9JLSIx9Y+JwQ1i+hwehk66oVlU
 bTFOivWkCoswK20RW4abWK/USW+wBBXiemserv92pOLn7FwgXN86lUPfCSqDOnYC81lC
 NZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIT6fF5gjfLCiNasKGkoBaNWOPI0QJSFqW2RO835jA4=;
 b=q4VZn4XLNpyMbEKryQFIvavg6x9JmkJDOWQUtvtxlYuB0/WvzZ2OcfO3skwe+V0GEM
 8bangxv5DwP5R0IHsPS6XHqENTmkFP2hJRTvGcYb4lMOCR01N3tgXuNZtzYmvPlwAWra
 Bw9VXIoMR8FS84TzJYDYscYG/Uey4WffjDrodG55lBFMy6iBb9sOsBrCOODJuhgPDeEN
 xxoXH61PA/taBEZ+n9cFam/LmLIr3F8XyIGviLi4DhDajIt/PgaVoyH5CfDsg9spPWM/
 P2w3pupgKDQum2i29TmDWjSQaOYAUB27q8VIItBNGLrsefJeedniNBe578fvFv4PZXB5
 DnxA==
X-Gm-Message-State: ANoB5pkjk/uRHZJuPe6BFTb7BXlEx7/ZsippolVRIjMBWHAn5OU0N4h6
 z5toesn+ADnEjjp9QScNpGqQb2Y4gxDq42TRzqY=
X-Google-Smtp-Source: AA0mqf4cCuDAam2bj0nbK1acGmhmPmCV5Sx0C10cMjh7B1N9LbnOouKDGjfvDFI1xq5STO7LuL2meHifp9VbWAhqqPs=
X-Received: by 2002:ab0:3194:0:b0:418:f8f7:d9d7 with SMTP id
 d20-20020ab03194000000b00418f8f7d9d7mr41242563uan.116.1671560879538; Tue, 20
 Dec 2022 10:27:59 -0800 (PST)
MIME-Version: 1.0
References: <82b18028-7246-9af9-c992-528a0e77f6ba@linaro.org>
In-Reply-To: <82b18028-7246-9af9-c992-528a0e77f6ba@linaro.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 20 Dec 2022 13:27:22 -0500
Message-ID: <CAF=yD-KEwVnH6PRyxbJZt4iGfKasadYwU_6_V+hHW2s+ZqFNcw@mail.gmail.com>
Subject: Re: kernel BUG in __skb_gso_segment
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: willemb@google.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, syzkaller@googlegroups.com, liuhangbin@gmail.com,
 joneslee@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 20, 2022 at 8:21 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Hi,
>
> There's a bug [1] reported by syzkaller in linux-5.15.y that I'd like
> to squash. The commit in stable that introduces the bug is:
> b99c71f90978 net: skip virtio_net_hdr_set_proto if protocol already set
> The upstream commit for this is:
> 1ed1d592113959f00cc552c3b9f47ca2d157768f
>
> I discovered that in mainline this bug was squashed by the following
> commits:
> e9d3f80935b6 ("net/af_packet: make sure to pull mac header")
> dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
>
> I'm seeking for some guidance on how to fix linux-5.15.y. From what I
> understand, the bug in stable is triggered because we end up with a
> header offset of 18, that eventually triggers the GSO crash in
> __skb_pull. If I revert the commit in culprit from linux-5.15.y, we'll
> end up with a header offset of 14, the bug is not hit and the packet is
> dropped at validate_xmit_skb() time. I'm wondering if reverting it is
> the right thing to do, as the commit is marked as a fix. Backporting the
> 2 commits from mainline is not an option as they introduce new support.
> Would such a patch be better than reverting the offending commit?

If both patches can be backported without conflicts, in this case I
think that is the preferred solution.

If the fix were obvious that would be an option. But the history for
this code indicates that it isn't. It has a history of fixes for edge
cases.

Backporting the two avoids a fork that would make backporting
additional fixes harder. The first of the two is technically not a
fix, but evidently together they are for this case. And the additional
logic and risk backported seems manageable.

Admittedly that is subjective. I can help take a closer look at a
custom fix if consensus is that is preferable.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
