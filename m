Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CC0C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FEBF84482;
	Fri, 31 Mar 2023 07:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FEBF84482
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iilXVRBP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sn6pfUJn8M2E; Fri, 31 Mar 2023 07:13:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDDA284499;
	Fri, 31 Mar 2023 07:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDDA284499
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D20DC0036;
	Fri, 31 Mar 2023 07:13:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D75DAC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAFF840578
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:13:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAFF840578
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iilXVRBP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyNa5QXVvQhY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:13:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8E07400F3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8E07400F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680246783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbj2AVGF1WXOqLTCXZnSczyZWz0UiEcYEZC2FxVEVpY=;
 b=iilXVRBPuMgbBzM0aZCpuIDuHlJ94DRSc3Osfrz2HqncVCQ2JADxk1OSZqMWTWg24OIyMm
 AcXFNKHOZmLXf+CjEY8Uexkt6ddxjQ41GrK60rvbMnebLL6oLub1t5OfgalayVujLTSSLE
 iOLdQdWxN/Soer7T2vQL8XgLpCZ89/w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-OFDBGeAnPj2v7ijsVuE2ZQ-1; Fri, 31 Mar 2023 03:13:02 -0400
X-MC-Unique: OFDBGeAnPj2v7ijsVuE2ZQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 q13-20020a5085cd000000b004af50de0bcfso31007174edh.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 00:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680246781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbj2AVGF1WXOqLTCXZnSczyZWz0UiEcYEZC2FxVEVpY=;
 b=S1BdkYB6jt5tr2YLBZ/NWhxrA6V/+8gqczHmOdzqhUAsVCW9twcC4uNxlqOuBtnnPx
 b6jNRciCzLuYAvHGZD9einXCR7s7+weowFjgYNL27Fsy0NQYq7jVIb1ciDmMwvGAmhEM
 CCynaeaj/yUiroeXkZyu4XkPunqQCMJb7SgA6ALA/qZSQcp6yPHEiVodWBr3V3+AAou2
 qn0JXLinX9KDH+vnrcp2gVCfTTHKfsr5K5AqtdNSbpLjTFczy25v1o8MJFLgnqkBMuop
 Qa7AguHs/jBNjxgNN5zR2UEcmnuWljnD12g8qkHF0yJftFThGUDRSetVCl4N3LN0TYao
 TEnQ==
X-Gm-Message-State: AAQBX9dlMhel7ix29DmgJu2wMmvF8WzTVW0hFsIHK7IX4ouG9otMaRkn
 siA4y4sLHRoBr2wwq2SczWqGWNxN2Mcn8K6h0xfllNkuTmhamsqQwnXvvNL9EObV1ct6s3hsEQV
 /1dbxF5rDf1WZsiMd8lQc5lkQfEzvupZcoL+C91H1QA==
X-Received: by 2002:aa7:c786:0:b0:4fb:eda4:c093 with SMTP id
 n6-20020aa7c786000000b004fbeda4c093mr24871261eds.13.1680246781233; 
 Fri, 31 Mar 2023 00:13:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/r5+oajO+A5DGt7yB7jTmm7QBPI4K7mKeRbZE0bW0nNZD4Ae6DGvs+vyDmX8r4UvfHK6pig==
X-Received: by 2002:aa7:c786:0:b0:4fb:eda4:c093 with SMTP id
 n6-20020aa7c786000000b004fbeda4c093mr24871241eds.13.1680246780883; 
 Fri, 31 Mar 2023 00:13:00 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 h27-20020a50cddb000000b004c19f1891fasm688400edj.59.2023.03.31.00.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 00:13:00 -0700 (PDT)
Date: Fri, 31 Mar 2023 09:12:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 2/4] vsock/vmci: convert VMCI error code to
 -ENOMEM on receive
Message-ID: <7pypi573nxgwz7vrgd2cwcrtha4abijutlsgtnxrwcgaatdjbz@cwnq5dlurfhs>
References: <4d34fac8-7170-5a3e-5043-42a9f7e4b5b3@sberdevices.ru>
 <9fd06ca5-ace9-251d-34af-aca4db9c3ee0@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <9fd06ca5-ace9-251d-34af-aca4db9c3ee0@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 30, 2023 at 11:18:36PM +0300, Arseniy Krasnov wrote:
>
>
>On 30.03.2023 23:13, Arseniy Krasnov wrote:
>> This adds conversion of VMCI specific error code to general -ENOMEM. It
>> is needed, because af_vsock.c passes error value returned from transport
>> to the user, which does not expect to get VMCI_ERROR_* values.
>
>@Stefano, I have some doubts about this commit message, as it says "... af_vsock.c
>passes error value returned from transport to the user ...", but this
>behaviour is implemented only in the next patch. Is it ok, if both patches
>are in a single patchset?

Yes indeed it is not clear. In my opinion we can do one of these 2
things:

1. Update the message, where we can say that this is a preparation patch
    for the next changes where af_vsock.c will directly return transport
    values to the user, so we need to return an errno.

2. Merge this patch and patch 3 in a single patch.

Both are fine for my point of view, take your choice ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
