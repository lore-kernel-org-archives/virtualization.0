Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02445C001DE
	for <virtualization@archiver.kernel.org>; Tue, 20 Jun 2023 12:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7073640412;
	Tue, 20 Jun 2023 12:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7073640412
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=V7CBqsvw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dpC7YZgfH01A; Tue, 20 Jun 2023 12:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F37A440158;
	Tue, 20 Jun 2023 12:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F37A440158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB9FFC007A;
	Tue, 20 Jun 2023 12:59:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DEFBC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 12:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01B3081A39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 12:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01B3081A39
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=V7CBqsvw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iiEHMuSHbP6P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 12:59:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30DA3819BC
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30DA3819BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 12:59:20 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-5ed99ebe076so44893636d6.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687265960; x=1689857960;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RvNVFujZzQ9FH/nRDQhxgK8HOnuVe0ilksjI7/FigQ=;
 b=V7CBqsvwa7HO9941Gx9rU48fbSNnkTARJq3hU0s4FJKqNq7uyQJvuWMi48BFYirjd9
 Z+CSYTenkWtjPExrbuK55Lr4LajYIvMVcZS1i2H4hkmnnVf92/3eU5+256AdSIU7TTh1
 xwVepNxy0+wSCXEIn2FLnq5fwolgWObqyrXGJD4a4dArZIDrRTCCQbOXeliLMdRNukOE
 bfBqEL3D5v18ty2Fda4DTUDINVko/+/f9bRuKWlc9As/MXSXKCsqRSAvjLHgGSN+PYBz
 OhKP930iRzIK8HICV0ZdtEG/GKM89Wb5av0m6K808diQPwrVMMP/ZUSrK2PjzRbzzuKs
 Xiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265960; x=1689857960;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4RvNVFujZzQ9FH/nRDQhxgK8HOnuVe0ilksjI7/FigQ=;
 b=h1c1x0wOa2RqQjzDhuMdHarabMJEszv6S9cP4PdQSmel4Ehymfn0Jq5A/RS40vwq4F
 BsEz7ZhHaJJ6XGdJ20m2mpwVIAhEjKPwg8CB2tEtbPY8p72yFUHjCRPfEWhpG0WXtMnI
 awgjAm480NE28EDfO378YKNlUiv9t1kxeFEdwODAQg8W60L/e3sZpO4f2xGIw8s3cBcS
 qYgeRiWulhvY6lP07nbKpsQ4e4DINbpZ+5KSlx82BfrxGw0bI8TLTg9Xxh+pY9tsx+W5
 OdSujkmFnybVs/e26zXIuzUlI2SypzQRA77OjMkNNXrOMmEfOw/PxnKMQPZ/tPnuZIYu
 UsrQ==
X-Gm-Message-State: AC+VfDwhqU6Gvp7xUBNPpwqUUPol2Z3x/PWmzkVg88QZSgmO9QJXCS7i
 9YEHqJmbeORbU3WxVHtuYAc=
X-Google-Smtp-Source: ACHHUZ5DO7ilI0HCjRl4Lbeq4UH3F7W+AS3gn0PcL1py6Hb93MUCpM1EgmXOFtEL5TVj5cEqHyVw6w==
X-Received: by 2002:a05:6214:1306:b0:628:2e08:78b7 with SMTP id
 pn6-20020a056214130600b006282e0878b7mr5517848qvb.31.1687265959785; 
 Tue, 20 Jun 2023 05:59:19 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com.
 [35.245.174.172]) by smtp.gmail.com with ESMTPSA id
 m17-20020a0cf191000000b00631ecb1052esm1216204qvl.74.2023.06.20.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:59:19 -0700 (PDT)
Date: Tue, 20 Jun 2023 08:59:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <6491a2a6f1488_3bcfec294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <784658.1687176327@warthog.procyon.org.uk>
References: <648f36d02fe6e_33cfbc2944f@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-18-dhowells@redhat.com>
 <784658.1687176327@warthog.procyon.org.uk>
Subject: Re: [PATCH net-next v2 17/17] net: Kill MSG_SENDPAGE_NOTLAST
Mime-Version: 1.0
Cc: linux-doc@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 virtualization@lists.linux-foundation.org, dhowells@redhat.com,
 linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>,
 linux-afs@lists.infradead.org, rds-devel@oss.oracle.com,
 linux-x25@vger.kernel.org, dccp@vger.kernel.org, linux-rdma@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-hams@vger.kernel.org, mptcp@lists.linux.dev,
 Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, linux-wpan@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

David Howells wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Is it intentional to add MSG_MORE here in this patch?
> > 
> > I do see that patch 3 removes this branch:
> 
> Yeah.  I think I may have tcp_bpf a bit wrong with regard to handling
> MSG_MORE.
> 
> How about the attached version of tcp_bpf_push()?
> 
> I wonder if it's save to move the setting of MSG_SENDPAGE_NOPOLICY out of the
> loop as I've done here.  The caller holds the socket lock.
> 
> Also, I'm not sure whether to take account of apply/apply_bytes when setting
> MSG_MORE mid-message, or whether to just go on whether we've reached
> sge->length yet.  (I'm not sure exactly how tcp_bpf works).

I'm not very familiar with it either.

Instead of inferring whether MSG_MORE is safe to set, as below, sufficient to
rely on the caller to pass it when appropriate?

size = min(apply_bytes, sge->length). I doubt that size < apply_bytes is
ever intended.

And instead of this former branch

                if (flags & MSG_SENDPAGE_NOTLAST)
                        msghdr.msg_flags |= MSG_MORE;

update any caller to pass MSG_MORE instead of MSG_SENDPAGE_NOTLAST, if not yet
done so.

> 		msghdr.msg_flags = flags;
> 
> 		/* Determine if we need to set MSG_MORE. */
> 		if (!(msghdr.msg_flags & MSG_MORE)) {
> 			if (apply && size < apply_bytes)
> 				msghdr.msg_flags |= MSG_MORE;
> 			else if (!apply && size < sge->length &&
> 				 msg->sg.start != msg->sg.end)
> 				msghdr.msg_flags |= MSG_MORE;
> 		}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
