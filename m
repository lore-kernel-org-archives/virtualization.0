Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E8C433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:19:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694B46103E
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 07:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 694B46103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 313D740475;
	Tue,  7 Sep 2021 07:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZjBR7reG7Ad2; Tue,  7 Sep 2021 07:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD49A4044E;
	Tue,  7 Sep 2021 07:19:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F86C000F;
	Tue,  7 Sep 2021 07:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C823CC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3D5380E7F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:19:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwAaVqlycVl6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:19:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14E7C80E65
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630999159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJ+BQHl0jBl7TBG1tqREEvwhD9MCuAV7riDwhB45i0Q=;
 b=GnYetg2tkLZQnANYfJ3tSscfAC37VNO9dSirt3pda3jOdPjC6i44kT1bUlLc8J0/Ha5Chl
 A/gSrkoqPvrES7lbGNugj7SpDUdMCH8+iy4A8VQpInpWoETx9dc2wdSV13+bscdozvrtLP
 NbsmjtdPHsw99SOfoWD9JG9W44+6lkQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-EBZSKnpcPVy9pncvdYfx7g-1; Tue, 07 Sep 2021 03:19:13 -0400
X-MC-Unique: EBZSKnpcPVy9pncvdYfx7g-1
Received: by mail-ed1-f72.google.com with SMTP id
 w18-20020aa7cb52000000b003c95870200fso4624736edt.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Sep 2021 00:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SJ+BQHl0jBl7TBG1tqREEvwhD9MCuAV7riDwhB45i0Q=;
 b=SdUDVvVLEfpiCfHF7UE9VJDPvhrejcMRw0nnmvOHwuTpIlf+K9b0symk3gw80M19t0
 +thCtLKoiPSHY+Tez/K12By+BTy8Fbr9AVyiFlrnnSYV5rN63IRbGims+1EeMr2ZxgN8
 GodAPaQzpx++lM07Rm0na+mFv6aQAf1uTLdMTUVA0WGQmlxcgTmzCScsnJMxzro/THQK
 /Cv6Oh8muiQcNw0N0T56Sa1oKzGBmkj5PXpd0tJUPxEfXoqQHn6UYISpyjjVjiauCray
 hFcUSN/Jpozazv7DI3licZM1Z1LWem3kFmvgT0y2Q39fq5GQ06+7nX3oeNt4KReayHRT
 FI1w==
X-Gm-Message-State: AOAM533rZJPCnIPQ/N6JCmzAI09w30L595ryZt5ot+y0u5Ky/MufxCfg
 IvEDflKLOWD7cVYsCokHMuSQjfeZcByYOLveJfvqkvtAcuAuMfLh8fBNyR2wIjE9SQaojPo17FH
 4HlFMXvyz3AFQGYnXVmorKlyF/BCwPVLco7FB1Pf8fQ==
X-Received: by 2002:a50:8ad7:: with SMTP id k23mr17205128edk.310.1630999152308; 
 Tue, 07 Sep 2021 00:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpO8ZRCV3gq3aPjZE3eB6TifvVjWEdqq6Grmkwr7q3eq7TIU5OWKnXbaQl5M7Z42F15H2Fvw==
X-Received: by 2002:a50:8ad7:: with SMTP id k23mr17205116edk.310.1630999152132; 
 Tue, 07 Sep 2021 00:19:12 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id lu4sm4923354ejb.103.2021.09.07.00.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 00:19:11 -0700 (PDT)
Date: Tue, 7 Sep 2021 09:19:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <20210907071909.qooj2opczrklljwi@steredhat>
References: <20210906091159.66181-1-sgarzare@redhat.com>
 <YTYWkupSYR29IMuM@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YTYWkupSYR29IMuM@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Sep 06, 2021 at 02:24:34PM +0100, Stefan Hajnoczi wrote:
>On Mon, Sep 06, 2021 at 11:11:59AM +0200, Stefano Garzarella wrote:
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
>
>Please skip me for now. I'm available if you take an extended period of
>time off and other special situations but don't have enough time to play
>an active role.

Yep, thanks for that!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
