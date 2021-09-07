Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C221C433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:21:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2E8610FF
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E2E8610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFE3340237;
	Tue,  7 Sep 2021 07:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7FfF-z78wMS4; Tue,  7 Sep 2021 07:21:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FC0F40294;
	Tue,  7 Sep 2021 07:21:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3797AC000F;
	Tue,  7 Sep 2021 07:21:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7854DC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74C7360773
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:21:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0tlSrTdknTLp
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:21:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 348026070F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630999299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaKB7upFfFLl+Pp6dLBHJb3Ed1n4Piy1w3dtvzMllDk=;
 b=ZHtZTEniAzWezeF5t/IPvGEIh2pOGPtvDAft7wK2KEvqqEH9t93BrSSSIUuHT7VJmP2umE
 K8pFXCJYCm2wuXaR8Pr4nqtwbFSf5Uo8t8fq+yxYCrht7WJgl33AIOUXOBJhOUKG3vTy6E
 n+RN07ntwLDpXxMp93V5+Qk4HTgkfNk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-4v2f1PhRPpStr8qHM7h-OA-1; Tue, 07 Sep 2021 03:21:37 -0400
X-MC-Unique: 4v2f1PhRPpStr8qHM7h-OA-1
Received: by mail-ed1-f69.google.com with SMTP id
 a23-20020aa7cf17000000b003caffcef4beso4771058edy.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Sep 2021 00:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oaKB7upFfFLl+Pp6dLBHJb3Ed1n4Piy1w3dtvzMllDk=;
 b=YVqhAKsXazU87e3SH6MZT/UCV+Jm5fIZZWYavYovxYJbyLJ0GTwGVcb3evnGDlat2r
 mMJrI4Y5zkwi83LUip2kdTWLbv0b/DGtiL/XC2BiL2EAn+TfZtrNJ3VVgunfmhjor4Wn
 VLwwKqwq78Ik57+J6at8IMRYRMeIL61v798tpxtAfe5AOvQxbmiOzlE48UJxN5YhfEz9
 4AkTI9MQu//LH3vZuWIn2P3RYW/209RPMOAdIXFc0VLJrQ42OZUNObr+Rmm7AIDI4HVp
 Xjqkql3M8ceXKr92YhuK+GNPpoc4w3LKaccezB8bkApsZkozWKRKGMa06BM7qEAWf2DV
 2MRw==
X-Gm-Message-State: AOAM530eOisqKiU7OC9ea0PIzeWsk/NycDriGKlorXqpTjFMnwjyxNqm
 EDpp3GK0Tc1/j8RQxpw4LsghPHcb1XEkEaPPK6ZTSkBDPVcd+zjXSg4WUcwogu88mfiQtEhaSZo
 lw/p169SSTJq0n3gwZyqy7blekJn9pTNOK7LcGE4TgA==
X-Received: by 2002:aa7:cd92:: with SMTP id x18mr16824600edv.325.1630999295980; 
 Tue, 07 Sep 2021 00:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Uc8T7kEgxWO5FQfq7yWolBxu7KgEZ38BIbUnYz9ZEWtsIPRwsqwwuW4waLHl5HXsZmNjuQ==
X-Received: by 2002:aa7:cd92:: with SMTP id x18mr16824591edv.325.1630999295860; 
 Tue, 07 Sep 2021 00:21:35 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id ee18sm5872580edb.62.2021.09.07.00.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 00:21:35 -0700 (PDT)
Date: Tue, 7 Sep 2021 09:21:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <20210907072133.mzyqugkob3yqm2ek@steredhat>
References: <20210906091159.66181-1-sgarzare@redhat.com>
 <BYAPR21MB1270B80C872030CA534C667EBFD29@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1270B80C872030CA534C667EBFD29@BYAPR21MB1270.namprd21.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Mon, Sep 06, 2021 at 07:10:46PM +0000, Dexuan Cui wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Monday, September 6, 2021 2:12 AM
>>
>> Add a new entry for VM Sockets (AF_VSOCK) that covers vsock core,
>> tests, and headers. Move some general vsock stuff from virtio-vsock
>> entry into this new more general vsock entry.
>>
>> I've been reviewing and contributing for the last few years,
>> so I'm available to help maintain this code.
>>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Jorgen Hansen <jhansen@vmware.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Dexuan, Jorgen, Stefan, would you like to co-maintain or
>> be added as a reviewer?
>>
>> Thanks,
>> Stefano
>
>Please skip me (I still review the hv_sock related patches).

Yep, thanks for the help with hv_vsock!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
