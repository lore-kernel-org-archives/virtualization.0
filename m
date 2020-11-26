Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA7C56202
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 15:24:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63852087C
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4osAMoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63852087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 14AAF2E252;
	Thu, 26 Nov 2020 15:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eL3L+UPRVgnL; Thu, 26 Nov 2020 15:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 96974203C4;
	Thu, 26 Nov 2020 15:24:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45B65C0891;
	Thu, 26 Nov 2020 15:24:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F9DC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 15:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5633C877B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 15:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WNbQQPF3kCJs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 15:24:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8681877EE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606404292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=os+Q+Blp9HyEuGcQTO6G5ktoOsiuGVlsUvHpEhOMdh8=;
 b=M4osAMoFJLGjunyEz3T49ccbtEZCVIT1jhBAJp4nahDGAbrQt5jaZcJoD2UWBJv0GXylvt
 1s+lW3xD4rqrvC1KonM/tKbZJrJdTO4ELWb1Lbd+AF2e56pSU9DKOxAS2B3mSc6QC78M6Z
 0sUi7B/7NUloUEJYQBYCSa5UiF6z60o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-qJk5KzTkNemcz8ltaUY8PQ-1; Thu, 26 Nov 2020 10:24:50 -0500
X-MC-Unique: qJk5KzTkNemcz8ltaUY8PQ-1
Received: by mail-wm1-f71.google.com with SMTP id y26so1347408wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 07:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=os+Q+Blp9HyEuGcQTO6G5ktoOsiuGVlsUvHpEhOMdh8=;
 b=WyxVWnFrvsiDKpkYUCZRso96wHBGA7o0qOlPcbJe11mAiFuVjGewSJ7woXucwCLDLE
 SRLLkLqjHKSUJX+A7GlUSOTjqY3alARyfpgdx4VW/JKM6VnIA7lmb2mdoyUcKrJyGigv
 AfwG+m7pifltMEWfbJRq1TgJ5SGo3a0viC/vdRSRtnI6ZdtfpD4AeQO9a/Zuem5qtS9R
 Y20J9Bf2qX0jOPSmLHsbhG/6Yf+q4Il64Rm4dGcPoStQVrLFhkVxB5GrcFxLUDc8KnMA
 hy2S0QKpgGV1idXg911wfFG8hRw0TLbMeC/mIIL7G+ncJBOtzUwj9wKYrnbGnfqMwRc4
 R1+Q==
X-Gm-Message-State: AOAM531QUSie8o11lRTjJ+ZmEOuZFznPoAK8mGDF4RVVMGQIV+sYifjp
 nX53+t4YINuSyaDfozmSen8iWCaNWCwBOegRbo7la7+5ygmoVqaHMyuMxrNSMp77LbTExP3EPcM
 C0aDw9rAG8UI3MMw9Jg9Yme5cWjGFJYG4P8qIlHnkSQ==
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr3993215wmg.55.1606404289360; 
 Thu, 26 Nov 2020 07:24:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9OI6f7Ith7j2DJeW7ukSH/WzE5q8wUVem/TW5/l5aphxSgk/jB9dGYbJEH7CwzfT2T2xyeA==
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr3993197wmg.55.1606404289170; 
 Thu, 26 Nov 2020 07:24:49 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id b14sm9723294wrx.35.2020.11.26.07.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 07:24:48 -0800 (PST)
Date: Thu, 26 Nov 2020 16:24:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 00/17] vdpa: generalize vdpa simulator
Message-ID: <20201126152446.lvf2db2u5crtv2ep@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <751e8938-8055-511c-c339-2b55dc902944@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <751e8938-8055-511c-c339-2b55dc902944@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

On Thu, Nov 26, 2020 at 05:12:30PM +0200, Max Gurtovoy wrote:
>
>On 11/26/2020 4:49 PM, Stefano Garzarella wrote:
>>This series moves the network device simulator in a new module
>>(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
>>module, allowing the possibility to add new vDPA device simulators.
>>
>>For now I removed the vdpa-blk simulator patches, since I'm still working
>>on them and debugging the iotlb issues.
>>
>>Thanks to Max that started this work! I took his patches and extended a bit.
>>
>>As Jason suggested, I simplified the "vdpa: split vdpasim to core and
>>net modules" patch, moving some changes out in small patches.
>>@Max: I put your Co-developed-by and Signed-off-by tags on these patches,
>>let me know if it is okay for you, or if there is a better way to give
>>credit to your work!
>
>Stefano,
>
>thanks for taking my initial series and bringing it to upstream level 
>and thanks Jason for your reviews.
>
>I'm ok with the tags and hopefully I'll be able to help a bit in the 
>submission in couple of weeks.

Great! :-)
I'll keep you updated.

>
>great progress !

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
