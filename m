Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E49C4743C
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 19:02:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D039E61002
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 19:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D039E61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7820640289;
	Mon, 21 Jun 2021 19:02:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RMmDOBokImAY; Mon, 21 Jun 2021 19:02:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3119440015;
	Mon, 21 Jun 2021 19:02:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECEF1C000E;
	Mon, 21 Jun 2021 19:02:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81C3DC000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 19:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55520404B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 19:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GaKifQlVd6N2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 19:02:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76B94403DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624302160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t4nTBVm6oy+3JIkEZh+pQ7A07CqilJib+PKS9NOLN6c=;
 b=OV7wtOGY2yIbMhUpv1wcbOORTwprl45nARKp+OwLUq58TcX1oNORjuYI71A7o2fvZzVGuP
 EqUI+OCWncvHdmiQaaBM59F0b50vyTcvw2uGkTb1qCR7CKhZIDAPpny9fquLsHcJVl1q/M
 qNsWKyheW9Fq4GiMt853mH/+LmPz7Uc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-0GuIsSACPWulHNWHt8OTpg-1; Mon, 21 Jun 2021 15:02:39 -0400
X-MC-Unique: 0GuIsSACPWulHNWHt8OTpg-1
Received: by mail-wr1-f69.google.com with SMTP id
 k25-20020a5d52590000b0290114dee5b660so8751662wrc.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 12:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t4nTBVm6oy+3JIkEZh+pQ7A07CqilJib+PKS9NOLN6c=;
 b=aloNNuyi321u/LP5lBlSjN9HLeu1UDL6kZVRW5uibHUpOe/Ia1mWJ07HRG0+IT66rM
 Wy0p7Jt699HYHqcum6Utr5AGc6VI2cWAskugk/vo5fZmEAjSqp5L2UuCI8G0BZxOhcwf
 RsFjiBPWU8bdPH5uqAZFrzJuCutvxfNXk8M9N8txxLt4wiYpv+DT6B58ALIY0QaQsTFw
 KhXX3dvao89tX1jJqzKtVJDv4JozwIW7+ZBhjtCRQ3W/7wz/gJBxcnc+60RcCRxdJ95c
 gPrYv7WMFcPDLnALhy+14AQyhp6GfbMT7V6jm/QxA6HQOfzcyTPiTzWSZrNdIQ5WgVS1
 wcpw==
X-Gm-Message-State: AOAM532iNHTxcmgDbBPxeEbC+kRaE247MdnEnObNCVFPDT/bDXK2zKdV
 6/3zy581nQ5WPoNxltQVCBcLY5DTrU6V4T8VhO0lPtytx+A6rm/Nk5xiAcvrSHWoesmTTYnOKG+
 9GdkE+BUr2gbMoM/BqdQ1sCN6I72S6EM009SfPKK2UA==
X-Received: by 2002:a1c:9895:: with SMTP id
 a143mr28697583wme.158.1624302157995; 
 Mon, 21 Jun 2021 12:02:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIym+Kqwn0g2XmY5hu8xWQygedShFaccTRqlgFj+vU/VKW+LszZezJYBBI4t+19M3QUjQtlA==
X-Received: by 2002:a1c:9895:: with SMTP id
 a143mr28697571wme.158.1624302157894; 
 Mon, 21 Jun 2021 12:02:37 -0700 (PDT)
Received: from redhat.com ([77.126.22.11])
 by smtp.gmail.com with ESMTPSA id k16sm19459817wrn.96.2021.06.21.12.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 12:02:37 -0700 (PDT)
Date: Mon, 21 Jun 2021 15:02:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: Patches that were reviewed
Message-ID: <20210621150202-mutt-send-email-mst@kernel.org>
References: <20210621125237.GC143139@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210621125237.GC143139@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Mon, Jun 21, 2021 at 03:52:37PM +0300, Eli Cohen wrote:
> Hi Michael,
> 
> There have been several patches that were sent and reviewed during the
> last few weeks. I can't find them in your linux-next branch and we're
> already in 5.13-rc7.
> 
> Can you advice how I can track which patches you intend to merge?
> 
> Thanks,
> Eli

Hi Eli,
I'll push my branch in a day or two, then you will see it.
Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
