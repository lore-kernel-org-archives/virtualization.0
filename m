Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A0FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 20 Dec 2021 23:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87D93402C4;
	Mon, 20 Dec 2021 23:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mR8Aqd9QFhBb; Mon, 20 Dec 2021 23:06:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FF8D40270;
	Mon, 20 Dec 2021 23:06:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E063C002F;
	Mon, 20 Dec 2021 23:06:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC526C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C49B660E3C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MNIoREj2StfP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:06:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0460A6076C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640041574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEHMiAq9vdS3tFIazyfylWAmTGiUgQc497at2F3jzF4=;
 b=VaIXH6oABA+L7XXw6I962OGXLF7h5oIRcPdHAVQnQM1eV9Ppw4t9gcaAv4eEwOk7WrT3Vv
 9MKu13pIMXGrUoeHrfGpNt57CN9HsYEhumpw9l+IWl2zsjoAZBM1Jo44HWsBnWIBgGJSRW
 g5+a+L5/PM5iYI4Htnxcjza3gxvA86E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-nHyQTPWbO1mjbZ4XGvInFQ-1; Mon, 20 Dec 2021 18:06:13 -0500
X-MC-Unique: nHyQTPWbO1mjbZ4XGvInFQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 l11-20020a056402254b00b003f6a9bd7e81so8690527edb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NEHMiAq9vdS3tFIazyfylWAmTGiUgQc497at2F3jzF4=;
 b=1LxMWDkXP44I9vCke16JfHNEQAF5kvynogT+xjkyxIaOjyEBinF8Ela28a2kNGdin7
 a3FkIaC0hytlLC7soFmBFu4bxcVEPBO4Iz+9US/vOp4Os3IQfZe9ohL8B2nk4vv5L2OA
 V1RM4AO24JO4UzlNskxU4iTj6roAP3Kms0UgT8OzdwHoRFNe3gib0E0wROBvqSFHvomP
 wKn79UGrOA0OGVzeM2upyainjhOPu0siXZNuWNfeeRUVEF5s+Uaqj5/m6+LNPu4pLXuY
 Hv2/nfwp+re9881w5xWM/XIhG6u4d6AvLoCy/QKoEbCyA9+QcbDLqlkL/8+/7VX6XdrM
 cQtQ==
X-Gm-Message-State: AOAM533QQcA+HF27Lp/wWIuztQiMnQdCfUNJ0v+NMCz/dat4Y5e+B0Q4
 cyYa7I6H8igOO3kl8N956rbT6K6tg62rarFlZ95XuoE+44bw5IJ4pgIBrzAwdw7Tea1/rXHAf3A
 4yRAwnATVtaf8nK9yGyk5j9/Dj0mVjfI97oQ5KN9xKg==
X-Received: by 2002:a17:906:38c9:: with SMTP id r9mr323564ejd.69.1640041572428; 
 Mon, 20 Dec 2021 15:06:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLuJeGKRXUMTefzTaE9Yvi1xD+us101vreqECr8RvPdGCe6ckZLAovFn1k026XGNKf41H2Tg==
X-Received: by 2002:a17:906:38c9:: with SMTP id r9mr323553ejd.69.1640041572287; 
 Mon, 20 Dec 2021 15:06:12 -0800 (PST)
Received: from redhat.com ([2.55.141.192])
 by smtp.gmail.com with ESMTPSA id e4sm6045615ejs.13.2021.12.20.15.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 15:06:11 -0800 (PST)
Date: Mon, 20 Dec 2021 18:06:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Ahern <dsahern@gmail.com>
Subject: Re: [iproute2-next v2 4/4] vdpa: Enable user to set mtu of the vdpa
 device
Message-ID: <20211220180507-mutt-send-email-mst@kernel.org>
References: <20211217080827.266799-1-parav@nvidia.com>
 <20211217080827.266799-5-parav@nvidia.com>
 <a38a9877-4b01-22b3-ac62-768265db0d5a@gmail.com>
 <20211218170602-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548189EBA8346A960A0A409FDC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211220070136-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E1BA270A1992AC0E52A8DC7B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8df990f1-7067-b336-f97a-85fe98882fb9@gmail.com>
MIME-Version: 1.0
In-Reply-To: <8df990f1-7067-b336-f97a-85fe98882fb9@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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

On Mon, Dec 20, 2021 at 02:11:44PM -0700, David Ahern wrote:
> On 12/20/21 12:11 PM, Parav Pandit wrote:
> >> After consideration, this future proofing seems like a good thing to have.
> > Ok. I will first get kernel change merged, after which will send v3 for iproute2.
> 
> this set has been committed; not sure what happened to the notification
> from patchworks bot.

OK in that case it's too late, so maybe let's worry about supporting
extensions later when we actually need them, in particular when linux
better supports mtu > 64k.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
