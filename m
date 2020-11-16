Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A5DC4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:41:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90A2206A5
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0zaiLKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90A2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05EB285F2F;
	Mon, 16 Nov 2020 09:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0jIDL8WeIxoy; Mon, 16 Nov 2020 09:41:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88C6585EC1;
	Mon, 16 Nov 2020 09:41:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68ACAC0891;
	Mon, 16 Nov 2020 09:41:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D0B7C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2239A2010C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cv9ftMJowv6e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:41:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 0135E1FC7D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:41:22 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id y7so13566095pfq.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 01:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6fzRGcF2f5tFoFwvys8VZBGWlajGvKg0DJjdpbzuzA0=;
 b=O0zaiLKi1+9kzKuXt6zMbdQp7SWpKVbP5X+apVBf1Ka0Sv193qIywfMTjjObYceO/x
 4TMxVq3CmbgKaS+TzuJ8VPZY/4QSz703OazPWQ0Utr9gXbGLgwrO2FKbHfhwmxO1yiEX
 +zZ1kIo8FczNcuSVIkPyfHJZLG7tGGNSenBpFgEYCCsEQ75gtMsVV3odtNArzljpXDAM
 NoNE2KEMAc4mZxyNqLKkP9r/AmH8ofDHWve8hw/S8GEgXcqIw1U5llg/5QdOSOn9Ivf9
 5u0ZPw7riMlWYPo50/1g3Ufft+U6OKw/b48035moyungQ2zDVcCdDzTehjdf9k05Ne17
 j+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6fzRGcF2f5tFoFwvys8VZBGWlajGvKg0DJjdpbzuzA0=;
 b=rUuYT8K36cUXh+wDExkce/SN/rRU6cFiYabcv3FoWfu9SvoZvdPaaq4twoD5tvBmI6
 uXhsksqGL44A1hChA/+1MznbKB7x8MLs2/ymkv7CBp3enp28aqMqA7GfaJZVcXI/LeD9
 4hvmTb50jux5XOxvGtu7LKLzMQY2IoOQ405ZSCpVsvkbW67joxwJ+zG6JtInZYbRU2pd
 y4nXCsQszO22Xd7hSoku610OP3jRFZWBwwtNtNx8kZro2VsMvOAaLpivJoVFKwUOQzK6
 og7EFtkDEB+LhyBEkm+rXgNO5zSPUOmp6FxAWgU4mkxcON5RvMe71Je8qHrABNWWuWqg
 hkDg==
X-Gm-Message-State: AOAM5314IImbQVzkR7/xvkt5yEL/ROhtzJEnwKyney1cbrVNF8Hfmfij
 i2kDyw35ElGSobfuWa2v7pE5xWFpyN/6oWf44to=
X-Google-Smtp-Source: ABdhPJwLKgoLxaacjkG7SIPtuYJkviJKA9xPpSof+g1KvR10O+DaOAcWHUOjKYEXWTbI1BD4y+7CmXKaI5ipjoUk2n0=
X-Received: by 2002:a62:7bcc:0:b029:18b:5859:d5e1 with SMTP id
 w195-20020a627bcc0000b029018b5859d5e1mr12906812pfc.40.1605519682660; Mon, 16
 Nov 2020 01:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20201112064005.349268-1-parav@nvidia.com>
In-Reply-To: <20201112064005.349268-1-parav@nvidia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Nov 2020 09:41:11 +0000
Message-ID: <CAJSP0QXN2VGgKwQ_qL3Fr0dAYDviZcFDgUrE8FhHZwBm9wpBoQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Introduce vdpa management tool
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, elic@nvidia.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

Great! A few questions and comments:

How are configuration parameters passed in during device creation
(e.g. MAC address, number of queues)?

Can configuration parameters be changed at runtime (e.g. link up/down)?

Does the configuration parameter interface distinguish between
standard and vendor-specific parameters? Are they namespaced to
prevent naming collisions?

How are software-only parent drivers supported? It's kind of a shame
to modprobe unconditionally if they won't be used. Does vdpatool have
some way of requesting loading a parent driver? That way software
drivers can be loaded on demand.

What is the benefit of making it part of iproute2? If there is not a
significant advantage like sharing code, then I suggest using a
separate repository and package so vdpatool can be installed
separately (e.g. even on AF_VSOCK-only guests without Ethernet).

Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
