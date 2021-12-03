Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F25C433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 16:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C425831D6;
	Fri,  3 Dec 2021 16:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePpXZLWHDc5a; Fri,  3 Dec 2021 16:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6920982771;
	Fri,  3 Dec 2021 16:57:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3073EC006E;
	Fri,  3 Dec 2021 16:57:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C489C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 16:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B27F40263
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 16:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxrlnrrHWjja
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 16:56:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6F8340157
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 16:56:57 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 x3-20020a05683000c300b0057a5318c517so4016170oto.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Dec 2021 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=AJr6Qe8CmBog6fB3TwA4tpkEoCiIknifXdVOwalv0Bc=;
 b=OhNb9hAXEFm2e3Pxw4XHiAx7MWclXGGkzrZzqvYL5vZyyw/qNDDf+xBQAYS5gNM5Dr
 1/C48dUw8hqrhP338+zra70ygAD/iGCLaCDhZRVjNUNUr5k9vCSzT0Uriido/tDcJHIV
 HWwHbOdVziSn/jW8gu0qMRnQykQvQvJAlylVIZRocPO4yJxjRKs1Rrn3S9rn58b3mrTz
 q6mzyQL0BPH2GuP0G9WuQ0cj3XxWAZhl0k+1gKMyCbRr26PguhYsaor4oMXogSPYQrfi
 o+VDUD8uLo/h7S2FCjuH4HuSo4PFCbBxXj884jr4oNwEbkBX81onD8tt5ove3txL3bmD
 G4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=AJr6Qe8CmBog6fB3TwA4tpkEoCiIknifXdVOwalv0Bc=;
 b=IvEVPZqJe3WnqSCuTxKUnO7i8asRAAmwKMzdNy1C92Ws16pVidlNqzUcZ16QzPMLv6
 QnlZBFmKNwP0Ykykpc0i5EnsxVg3gBV/8MUtApd6Hzz4bCZaEbW3QGvbbTMmptq4/iZ+
 pjKQc64hHoU590iuu60LGodmI4IuL9NGfyET5Hjgzz8fYvA/e0cHLlr62n08Bx11HV/K
 Esb8/MR7R244PJzNsaq4ak6iN/wXsZ9u1j/2Jj7oCN5qoaI0ys0VY3Df4c/lwNhY7FxN
 EYXPgb/c5upPMD/ePALr0oyi7PHVJ4pUI8ds3vqgAYVC9LRMVNSW5aJ4C3rf9H4QSmwX
 VlCg==
X-Gm-Message-State: AOAM530wGsU0PA9pPt0nTTagWShoAT4XfKGAchaoRMUEwxTEtnhUd9Y7
 8gmBxoPXd+XS3yUnLIt73GA=
X-Google-Smtp-Source: ABdhPJyyNyVp+OanpDa2j57rmTai20OUB4w6oTfC93/56KQzNMqP4MdZ6hdhPhMqXf58ql3BraITZg==
X-Received: by 2002:a9d:7758:: with SMTP id t24mr17437788otl.264.1638550616832; 
 Fri, 03 Dec 2021 08:56:56 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id i3sm668960ooq.39.2021.12.03.08.56.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 08:56:56 -0800 (PST)
Message-ID: <7472fe36-b0a9-d731-8c2f-20be0411b96c@gmail.com>
Date: Fri, 3 Dec 2021 09:56:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [iproute2-next 0/4] vdpa tool to query and set config layout
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, stephen@networkplumber.org,
 netdev@vger.kernel.org
References: <20211202042239.2454-1-parav@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211202042239.2454-1-parav@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

On 12/1/21 9:22 PM, Parav Pandit wrote:
> This series implements querying and setting of the mac address and mtu
> device config fields of the vdpa device of type net.
> 
> An example of query and set as below.
> 
> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
> 
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
> 
> $ vdpa dev config show -jp
> {
>     "config": {
>         "bar": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500,
>         }
>     }
> }
> 
> patch summary:
> patch-1 updates the kernel headers
> patch-2 implements the query command
> patch-3 implements setting the mac address of vdpa dev config space
> patch-4 implements setting the mtu of vdpa dev config space
> 
> 
> Parav Pandit (4):
>   vdpa: Update kernel headers
>   vdpa: Enable user to query vdpa device config layout
>   vdpa: Enable user to set mac address of vdpa device
>   vdpa: Enable user to set mtu of the vdpa device
> 
>  include/uapi/linux/virtio_net.h |  81 +++++++++++++
>  vdpa/include/uapi/linux/vdpa.h  |   7 ++
>  vdpa/vdpa.c                     | 198 ++++++++++++++++++++++++++++++--
>  3 files changed, 277 insertions(+), 9 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_net.h
> 

please update man page(s)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
