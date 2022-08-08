Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD518C25B06
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 636FF826AA;
	Mon,  8 Aug 2022 10:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 636FF826AA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFAql5z2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eklxuz53oka8; Mon,  8 Aug 2022 10:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21468826E5;
	Mon,  8 Aug 2022 10:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21468826E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E494CC0033;
	Mon,  8 Aug 2022 10:31:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08A70C0033
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD568415E2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD568415E2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFAql5z2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k1rnMMeh9vdS
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:31:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D386F4151E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D386F4151E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659954669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XvPrsjTvSRvoKVmqojs3rSzxL2OS329sfzMWHSZ4M50=;
 b=GFAql5z2TIeA62I7XleLC58YPAvWmz/Ry9NkxxGtsUryxC9et8iswVJzPzmzxm2CdKXZpk
 BtMt7FF0zNBJy2SEhm3aYzssAdWhUnvzuaT0g/ZNbnlmCDBLyJuzsTZIVSra8JJ0SUuA9b
 +OHcdyYhf/EyVFDg9Widi9ZMuEuZC5g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-NPfNTXOeOQ-uYoq9vmOasA-1; Mon, 08 Aug 2022 06:31:08 -0400
X-MC-Unique: NPfNTXOeOQ-uYoq9vmOasA-1
Received: by mail-qt1-f199.google.com with SMTP id
 i19-20020ac85e53000000b00342f05b902cso3385651qtx.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=XvPrsjTvSRvoKVmqojs3rSzxL2OS329sfzMWHSZ4M50=;
 b=iPR5PdO50vVNW92AuV3JhPtwkZ5w6T9TCsV2gylkZfTa7oPnpyyXJZpGB7fY7REI+Y
 QA1qruIHlq2KGsd2WEO7LcAEtZPT59Duke68FlK9Z+cXXknzOmL4hhr9HOL/yLbDymdK
 +sipN7K1v1JbS6fgaaq0RS6qhagI/5czk/QIXvN1fka2/kHXs9tIUgqmiA+Y4OtNpdNK
 xJnld68YEAHYGH6UqNjFEZ9oPftwZrbYGBpIdmSRWkez2fJTz7D0u4iKYuFdyT12DW0e
 XiA77UEb28GtA7HamuhOSBFJPv3AHryIOX47tRsw7v9egTLjHKU7BXT+p6JIS4lCLprn
 IVVA==
X-Gm-Message-State: ACgBeo0Fp8O5ATrTCj4hQaFy3L1T8UjJSCfzgdDvL4rbROiIfPGxulmt
 kw/7F2JdmvW0WkxJhR2FhFOqMNVWGzK7ENoWqAK91HEtGKxYmb5o1Jd1zzkyxD12y4gFaoXdjUX
 wwMOzfHSC41eJYidtyq+Tl78QUiBsCnMOQ3ruaT9iCg==
X-Received: by 2002:a37:8a44:0:b0:6b5:f371:a183 with SMTP id
 m65-20020a378a44000000b006b5f371a183mr13302334qkd.492.1659954668395; 
 Mon, 08 Aug 2022 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/yFs0KjeGd8bKDfXwYhjua9yB0wwXzaxZKsQn6plBoppBAz4IclCsn96TyP1BAgwx2AsEgg==
X-Received: by 2002:a37:8a44:0:b0:6b5:f371:a183 with SMTP id
 m65-20020a378a44000000b006b5f371a183mr13302320qkd.492.1659954668196; 
 Mon, 08 Aug 2022 03:31:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05620a454c00b006b928ba8989sm844240qkp.23.2022.08.08.03.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:31:07 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:31:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 2/9] hv_sock: disable SO_RCVLOWAT support
Message-ID: <20220808103101.iknoveb7vgsrkxp6@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <58f53bef-62f4-fd63-472c-dcd158439b09@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <58f53bef-62f4-fd63-472c-dcd158439b09@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 03, 2022 at 01:53:23PM +0000, Arseniy Krasnov wrote:
>For Hyper-V it is quiet difficult to support this socket option,due to
>transport internals, so disable it.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
