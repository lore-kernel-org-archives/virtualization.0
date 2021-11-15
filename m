Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C8C433EF
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 06:31:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4034463217
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 06:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4034463217
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 792B080DE0;
	Mon, 15 Nov 2021 06:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5LFJsuna1n6k; Mon, 15 Nov 2021 06:31:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9EA080DA8;
	Mon, 15 Nov 2021 06:31:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80F8EC001E;
	Mon, 15 Nov 2021 06:31:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8ED3C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC6FE40383
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POdTpsztnxWz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:31:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 505FF40381
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636957887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKw5hh21vSY9tJGq5TQGGMzjeEhb4KZJl3nC+APkHAw=;
 b=VDBuVpo8hyzJRzWDJ/7l9orbhQsSVaGgu1tLdDqetNPnX7yZXQDCGkZ9SOc7o8155/rV6i
 mGKtv/77yq6AJ6lOBWVyjlUQzZX3KQY15ggPULykrybOq+1Bnb68BwoMiOnrMtFf5ry+AP
 oOPUuI5Ey9CPAJW0LbX2xOhsB37FKoY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-mmUDxujlMpuPrBqb-G0I4Q-1; Mon, 15 Nov 2021 01:31:26 -0500
X-MC-Unique: mmUDxujlMpuPrBqb-G0I4Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 q26-20020ac2515a000000b0040adfeb8132so495583lfd.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Nov 2021 22:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AKw5hh21vSY9tJGq5TQGGMzjeEhb4KZJl3nC+APkHAw=;
 b=dQ6BVyL3DKj8EWOLHGw6pKNwjtJoe5h/8Vl5EoL0fHFDsnxugjZHTosSw7ERrPMapA
 sL3qOKQTSK1PBe87WihmQ+sE+ApBUy0PIo7kY0RgEixLmEvcUQm1WAfVvuWHRR5oFWyn
 r4UyurAyOBYMD+sjThAZVX1Zs3FJqdsr0+4NZmIKIiiytEbRXxvmXCUlMdMHKtme6p5b
 1d3fLEyKr2EGBzhdJbYMnm+3eoTiXbVjAdhmzFtJG/dS1ihvrYYGRLE2SW3CAugE+rQf
 AF8X2W1npoxuxe3nfhAAYMiU+LmvDLqtO7ZUb6HeSrD+9eznRU9O9XCgwrkDPv9J00nI
 Y6Mw==
X-Gm-Message-State: AOAM531KdLB9hIfW4Xfop0///tRtSjq8WDM0mvBUMjPxZRJLSb5Byhvc
 W/A+ARhZi7DO/EXid3Jp0KmwwPmErNARwuIv2gDTVG3hyFKvsZLXaDsIFNnVSAsAlEmhrbJQ8V0
 dt3pLeTfpBQo2B6CkKvYy7QVt3pbQSXY6k/sud/mjoaVKPt7N46iOqxpVnQ==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr32969015lfv.629.1636957884567; 
 Sun, 14 Nov 2021 22:31:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhCXpQW+uhN4aZuE7ggmodsT/FOiKVWEhzHk/2/XPeBtXhqIkksYPEHX7bpcV7TL2plaT3nAov0V6oj8aE+vA=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr32969003lfv.629.1636957884384; 
 Sun, 14 Nov 2021 22:31:24 -0800 (PST)
MIME-Version: 1.0
References: <10b3825413da4a73ac8cdce9eca5e860@baidu.com>
In-Reply-To: <10b3825413da4a73ac8cdce9eca5e860@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Nov 2021 14:31:13 +0800
Message-ID: <CACGkMEszkt9w9sbSqT9kAE+t=cm5S48rc6bnvGpYy_rvFEXjhw@mail.gmail.com>
Subject: Re: question about vdpa_mgmt_dev
To: "Liu,Feng(INF)" <liufeng32@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Nov 15, 2021 at 2:08 PM Liu,Feng(INF) <liufeng32@baidu.com> wrote:
>
> Hi Experts
>         I have read the upstream code about vdpa, and I notice that there is a new struct vdpa_mgmt_dev have been added.
>         Every driver implements dev_add() interface, such as mlx5 use mlx5_vdpa_dev_add(). This interface completes the creation of the vdpa device, hardware initialization and system registration. And I found that only netlink will call the dev_add() interface, in vdpa_nl_cmd_dev_add_set_doit(). While the probe() function just register vdpa_mgmt_dev without call dev_add()
>         So, my questions are:
>         Does it create a vdpa device only through the netlink interface?

Yes, this is the plan, and we're working on converting all the drivers
to support that.

> The system scans the PCI device and does not automatically create the corresponding vdpa device?

It's a choice for the vDPA parent driver but we suggest creating vDPA
via netlink(), this gives a persistent method for the management
layer.

Thanks

>
>
> Thanks
> Feng
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
