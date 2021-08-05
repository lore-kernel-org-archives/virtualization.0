Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D09C4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 12:05:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F34161152
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 12:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F34161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D82CF403C6;
	Thu,  5 Aug 2021 12:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nGSF6k_kzCsd; Thu,  5 Aug 2021 12:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F88E402FA;
	Thu,  5 Aug 2021 12:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10951C001A;
	Thu,  5 Aug 2021 12:05:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61621C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4190C4029F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cLixKiPDd1De
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:05:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B36240133
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628165144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BD9Bdk7LapSC4iqOIR9UtEzV9hQiC2n6cCV9aHTiFF4=;
 b=KGufp2uVonJm2YlMgltaL9cn4d+DxUfbnhvkaYDbERe3QkRly+Oc9+TEnechtcGIjJYjBP
 KHqd1lyKG/Q+rCYLfVZkc/NiZ/8F5npmFS4ZWBFS4hBUw/gvqtr3LfIqzOoJPwuaQsDt68
 dKGiWeaIomR7g1N5TWx3OtokfF6zYe4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-whEv2MXKPvalcP6Fn6aCMA-1; Thu, 05 Aug 2021 08:05:42 -0400
X-MC-Unique: whEv2MXKPvalcP6Fn6aCMA-1
Received: by mail-ed1-f69.google.com with SMTP id
 x1-20020a05640218c1b02903bc7f97f858so3043180edy.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 05:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BD9Bdk7LapSC4iqOIR9UtEzV9hQiC2n6cCV9aHTiFF4=;
 b=azVxzQkDgyHtC+NG7muvh5b3WhKmjAhTptSRYK2EwFRoQvZ5qfIkTuQnxPuqWJ4Z38
 S3PoFYXfuebjTVFZrrgJ02BzZEhLU0+G58IYtP0b7DDcSL/G1WD4iGvEhzm8I2gWMbLY
 kI3SSNUAb4McRytvDHK0EnIxI/2DFsJRCPjUREoFJp1cStBeF5gFx7r70jOSH6iTDoUi
 ANXLt0TvxfqC9i5AcMryqyOdoj7Ch1Y37dLTNM3LGmneVqpHUpJfuc2ITaASul2+5FAl
 01qfC+DID0OBKoUYUMWuvyV9rQ5xL3NF+Z1dURpnJXFlFgfQaFKqeoTXByOv7Fel5rot
 F7FQ==
X-Gm-Message-State: AOAM530kwGBbazrc6XlOHgdupBtssQ+gNhq48hhD2snVg7U/biR9T78l
 lqE74CNEfLcmV+qzW5mJDu/qVv5G/mqrgrHWyZfzPlp3/rt9lTkMHSyooTrB7C1f2Xji8dvEeBj
 bwQTFCi4wRIdM3smYA0hwjCO+g/wkMIsVLynRcPPsPA==
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr6076048edr.300.1628165141710; 
 Thu, 05 Aug 2021 05:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeLdRZye8O0hQwlQfo95V4/QcfMmBd7pgu7mrhsCqZqcD4E/ptkEoJp0oqehO1L3uuD6+u8g==
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr6076031edr.300.1628165141579; 
 Thu, 05 Aug 2021 05:05:41 -0700 (PDT)
Received: from redhat.com ([2.55.141.248])
 by smtp.gmail.com with ESMTPSA id e7sm1650574ejt.80.2021.08.05.05.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 05:05:40 -0700 (PDT)
Date: Thu, 5 Aug 2021 08:05:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210805080428-mutt-send-email-mst@kernel.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548144534E9F3324D64CADCEDCF29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548144534E9F3324D64CADCEDCF29@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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

On Thu, Aug 05, 2021 at 10:13:11AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, August 5, 2021 3:28 PM
> > 
> > On Wed, Jun 16, 2021 at 10:11:49PM +0300, Parav Pandit wrote:
> > > Currently user cannot set the mac address and mtu of the vdpa device.
> > > This patchset enables users to set the mac address and mtu of the vdpa
> > > device once the device is created.
> > > If a vendor driver supports such configuration user can set it
> > > otherwise user gets unsupported error.
> > 
> > This makes sense to me overall. People are used to use netlink to set these
> > parameters, and virtio does not necessarily have a way to set all device
> > parameters - they can be RO in the config space.
> 
> Yes. this series enables it to RO when driver doesn't support setting it.
> When driver supports it, it is RW.
> 
> Do I need to rebase + resend?
> Please let me know.

Can't hurt.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
