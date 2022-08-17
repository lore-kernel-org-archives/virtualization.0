Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9864CC2BB41
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 06:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1414E82EB5;
	Wed, 17 Aug 2022 06:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1414E82EB5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=s/1uTUYy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLArXpnyULge; Wed, 17 Aug 2022 06:14:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F84E81B48;
	Wed, 17 Aug 2022 06:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F84E81B48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6433AC0033;
	Wed, 17 Aug 2022 06:14:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66E6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D9B74013F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D9B74013F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=s/1uTUYy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40HBk1u-moxj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E399404E2
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com
 [IPv6:2a00:1450:4864:20::649])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E399404E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:14:15 +0000 (UTC)
Received: by mail-ej1-x649.google.com with SMTP id
 go15-20020a1709070d8f00b00730ab9dd8c6so2482079ejc.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 23:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc;
 bh=Xa1Am8o4teQaaL9RutMPnLbxqHkDGkecVOS2SmaoyIs=;
 b=s/1uTUYyEaFlNWqfnApEYsQdesm4fvMpnKQOdzNeq15EnC9twMzAmYS27DYIEpoQNV
 ONiulQIKOyEaJN7vwBiVA52A3T4fcNXzcO2EhlNUv27SahrpI8qf2TkmB06MCRaqefwF
 /yeummP9sXq7fbGE66YggRyUl+gsDQWhxLKEisD400L//ndUoKIQVHn5cqERyZdfGqzW
 MxIJmnSbDnDTsusWT3OxOGRFuDKrQGwlnv+xVRnPv6dCaBuTy0G5ycxfUPP9Z6vnw8Dw
 XiMmWQtzqjM7hXitZzNVNFnrMdeE/E2XvAKW/O257aO7bzFySiL/TErWqyTrtHttYnlB
 qbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc;
 bh=Xa1Am8o4teQaaL9RutMPnLbxqHkDGkecVOS2SmaoyIs=;
 b=TQtpkUddUqqPcH3Jo19KR2r6S5pFz9eXhsGOjH1RAVyTRmdxXGG4Nl9nv4MiN3x4dT
 P+2/EuDaFphSyZ6pDWqPWbPHYkvNru25EkwmB4SM9pghgnvotrULF2LEZ1Mgp5kwaLah
 qhGtGnkQPIx+zqidPBTd3BuGTX73+I52sDd37T42gpTOGvVBnNuU1QAXjgaLJ6L9yhr0
 QOhxsJ/kiSVsqlgp1i1mN/WIhsPwKqZ+XuTSgIpWNX4nEym7uaLHxw2J/EoGmPhNcNYU
 9AFwicw9fa6FjdWwtmf/1lB9JNoOZv8wUvsqhqJtvUZWueesfUm4OrQoaIa6QnuW5Zsa
 4YHQ==
X-Gm-Message-State: ACgBeo3iHlAOAc52FbxiROeMnAueA8Bf+CdEYPACKmVLp/ZTZRfxNf3P
 dQ7qCd/lETDGU0jnJdbrZFPOStoz29lS
X-Google-Smtp-Source: AA6agR4jDLAGqFGFVp5dCXkX1JHnJoN5Z+/KOffoN15vAxyETRy5Eo2fSEJJ2790+2dor5kkVeI0mn+NTGTR
X-Received: from dvyukov-desk.muc.corp.google.com
 ([2a00:79e0:9c:201:6b03:2ace:af3d:2660])
 (user=dvyukov job=sendgmr) by 2002:a17:907:608f:b0:734:b422:42f4 with SMTP id
 ht15-20020a170907608f00b00734b42242f4mr14937896ejc.491.1660716853316; Tue, 16
 Aug 2022 23:14:13 -0700 (PDT)
Date: Wed, 17 Aug 2022 08:13:59 +0200
In-Reply-To: <20220815170444-mutt-send-email-mst@kernel.org>
Message-Id: <20220817061359.200970-1-dvyukov@google.com>
Mime-Version: 1.0
References: <20220815170444-mutt-send-email-mst@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: upstream kernel crashes
To: mst@redhat.com
Cc: axboe@kernel.dk, martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, torvalds@linux-foundation.org,
 edumazet@google.com, netdev@vger.kernel.org, c@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, andres@anarazel.de, davem@davemloft.net, linux@roeck-us.net
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
From: Dmitry Vyukov via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 15 Aug 2022 17:32:06 -0400, Michael wrote:
> So if you pass the size parameter for a legacy device it will
> try to make the ring smaller and that is not legal with
> legacy at all. But the driver treats legacy and modern
> the same, it allocates a smaller queue anyway.
>
> Lo and behold, I pass disable-modern=on to qemu and it happily
> corrupts memory exactly the same as GCP does.

Ouch!

I understand that the host does the actual corruption,
but could you think of any additional debug checking in the guest
that would caught this in future? Potentially only when KASAN
is enabled which can verify validity of memory ranges.
Some kind of additional layer of sanity checking.

This caused a bit of a havoc for syzbot with almost 100 unique
crash signatures, so would be useful to catch such issues more
reliably in future.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
