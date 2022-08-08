Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B844CC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 11:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FFD881C67;
	Mon,  8 Aug 2022 11:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FFD881C67
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Meln5ggV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dKj6gN7cx1J; Mon,  8 Aug 2022 11:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 880D681450;
	Mon,  8 Aug 2022 11:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 880D681450
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D0BEC0032;
	Mon,  8 Aug 2022 11:22:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7140FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3987960E24
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3987960E24
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Meln5ggV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUbdcRNtv5HH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D52AA60E1D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D52AA60E1D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659957770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URbW2eSWd9Zk4XsSgq7TMx84SxxtNx0WE1Teja98lDs=;
 b=Meln5ggVtFtV7fMXRCk93yxBCAC0N3HI5JzgFdrHH+8PwgA+CFEqp8SuwdfiT3P9OJBiF+
 RaYhEYxaiEuG4nHD443rdfDrFEEov299f6XdF8ZrtJnh6pL+Yzst1AZ7575G4/vZULMPh3
 GW8PvilMYKdQbQ1YXT2PLjsJ+1yBjnU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-3UciDMaBMNe9jROU12hlFg-1; Mon, 08 Aug 2022 07:22:49 -0400
X-MC-Unique: 3UciDMaBMNe9jROU12hlFg-1
Received: by mail-qv1-f72.google.com with SMTP id
 o9-20020a0cecc9000000b0047491274bb1so4274656qvq.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 04:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=URbW2eSWd9Zk4XsSgq7TMx84SxxtNx0WE1Teja98lDs=;
 b=SLBz7bmM80SNo/9DXMMSj7W1A0+YJZp+qJP9hJqMjojjUp2PJKlI8MyltchMOAFf63
 ZGcCp+1llABxYTiWpCy/uZPT0L8uo9Vw9RMfbzRxKWFydUyYb7IpCx1TsCJ+Og4jAi7J
 T6GlKc/5G7noO6uB4Qg7yxu6GaSDacm3GnOqIgey6cspHwzmLhkMuNsqKikM2UriLmys
 RdHETKhzV36ybcP66RcXU2iBGp5/iywh9i2G4bRK4SRTdT03XHRcydmtLxrAPEiblMDQ
 p3ainqjIEafTlJ30TgTTH+JrAYhza541dq+mIu+3aC2rEtp8Cs6FMKjo9VjA513/COvw
 kfkw==
X-Gm-Message-State: ACgBeo1QUiFsc4BAeevotn5MA96gKHN3JioNhu43Xosc/h+0dEuQOaa5
 d4bKRyRSjAief8eBp9XtRWytMLCmQZXB7XGNa4xLq8O2u3lWfQxEiWDVB4HZd3N5hEMf6brA/gn
 zhQc9hLrcEp87vLryuSQWyelSj1ynBqt7wWc4ugS7pw==
X-Received: by 2002:ac8:7d4c:0:b0:31f:344c:d843 with SMTP id
 h12-20020ac87d4c000000b0031f344cd843mr15965569qtb.391.1659957769098; 
 Mon, 08 Aug 2022 04:22:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Y11HcDyoSXw2Ny4GAR0UM/JIRPfgg4DREbcZuxzaq//Kny6tPDJul5MmPL+netL0Z9mFe1A==
X-Received: by 2002:ac8:7d4c:0:b0:31f:344c:d843 with SMTP id
 h12-20020ac87d4c000000b0031f344cd843mr15965542qtb.391.1659957768859; 
 Mon, 08 Aug 2022 04:22:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 g3-20020a05620a40c300b006b919c6749esm7398094qko.91.2022.08.08.04.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 04:22:48 -0700 (PDT)
Date: Mon, 8 Aug 2022 13:22:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220808112239.jwzrp7krsyk6za5s@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
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

Hi Arseniy,

On Wed, Aug 03, 2022 at 01:48:06PM +0000, Arseniy Krasnov wrote:
>Hello,
>
>This patchset includes some updates for SO_RCVLOWAT:

I have reviewed all the patches, run tests and everything seems okay :-)

I left some minor comments and asked Bryan and Vishnu to take a better 
look at VMCI patches.

In general I ask you to revisit the patch descriptions a bit (for 
example adding a space after punctuation). The next version I think can 
be without RFC.

Remember to send it with the net-next tag.
Note: net-next is closed for now since we are in the merge window.
It should re-open in a week (you can check here: 
http://vger.kernel.org/~davem/net-next.html).

I'll be on vacation the next 2 weeks (Aug 15 - 28), but I'll try to 
check out your patches!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
