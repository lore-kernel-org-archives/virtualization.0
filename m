Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4382DC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B5564E60
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B5564E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D02A83A49;
	Tue, 23 Feb 2021 13:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7v-XfoKg0HC; Tue, 23 Feb 2021 13:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC26883A3E;
	Tue, 23 Feb 2021 13:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA5F5C000A;
	Tue, 23 Feb 2021 13:01:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83777C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70BA9605ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LAz3972bErn6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ACD3600C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614085273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7olXrBgcNfrl7Xfap2MQ05IvCMZZ7nmfJl2qzSQ1mTM=;
 b=Uycqcv2BgeDhPYb8LN/Ff92nRgEq8CgOjDvcQf7ar2hu8Hzpy9+aBbDINjhr+WhMwDTD9s
 jKnUWb/LE+dmnA6MHqYiyZlVJm46lsgJrskT9N0QKwrU58VutT6MDmrJM/x8qMr8ojis48
 9h83VAjThx6lqMZTR+wBacVQyqq/uZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-P6LrD9bwNPyNnOSGt9DDxA-1; Tue, 23 Feb 2021 08:01:11 -0500
X-MC-Unique: P6LrD9bwNPyNnOSGt9DDxA-1
Received: by mail-wr1-f69.google.com with SMTP id d7so7270908wri.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 05:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7olXrBgcNfrl7Xfap2MQ05IvCMZZ7nmfJl2qzSQ1mTM=;
 b=qAoeZWaRz5gnUTsXxA80xm0acdN8BTT9rDE8/vDPZD8fWW99EIoG6XxzUzrxG97HNf
 MW0dwJx/mIyNP2NaUwxV+0VS/idCTMVDMQUh2uOJ/sKZTsFtb0Tzfxb4eoT5NeHPsxeM
 k4QLde8X+ug26vrEAsXtShszDpMG9yCYRrvcU46jcdwVswRSbTeKfOx74sYZo/1M6GUw
 evO4FNAYIgl/vtYo8i+Pi1c589tsy+lEZRajXSFNxUO3Go3A72JyxVuqCTAZi5WCQG4T
 8mDr8C5Vhab3XO+ANQI0rE+FM9t1lIiwDU5vs48xHvyHSe7jV7c800eoIyXneRV5N/LX
 sO8A==
X-Gm-Message-State: AOAM530MSZc1kHl1HKNOCVgHIEmG8c3RwL80dijRp8NulhVlpTRugOl+
 m+xSVXEAu9Per6BFsNglKODzLkzhYHIhEStyFe4rf/bAli/7uTYFw7v9Ig6tnkLOJY3fUEzMB3e
 x+GqbWZseONmRoOO8iF+FXf0o8gWL/bjWR8XOeAdr/A==
X-Received: by 2002:a05:600c:1990:: with SMTP id
 t16mr21113992wmq.27.1614085270449; 
 Tue, 23 Feb 2021 05:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgb/3q4OEcpSFHwNO4qrmyR4vFsVyf8uD9qB4e3ysKpUTQL04Mc86X1QmiWVqCMVLRx0QpsQ==
X-Received: by 2002:a05:600c:1990:: with SMTP id
 t16mr21113972wmq.27.1614085270326; 
 Tue, 23 Feb 2021 05:01:10 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id n66sm2532052wmn.25.2021.02.23.05.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 05:01:09 -0800 (PST)
Date: Tue, 23 Feb 2021 08:01:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Enable user to add/delete vdpa device
Message-ID: <20210223080038-mutt-send-email-mst@kernel.org>
References: <20210218074157.43220-1-elic@nvidia.com>
 <20210223072847-mutt-send-email-mst@kernel.org>
 <20210223123304.GA170700@mtl-vdi-166.wap.labs.mlnx>
 <20210223075211-mutt-send-email-mst@kernel.org>
 <20210223125442.GA171540@mtl-vdi-166.wap.labs.mlnx>
 <20210223075508-mutt-send-email-mst@kernel.org>
 <20210223125949.GA171769@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210223125949.GA171769@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com
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

On Tue, Feb 23, 2021 at 02:59:49PM +0200, Eli Cohen wrote:
> On Tue, Feb 23, 2021 at 07:56:16AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Feb 23, 2021 at 02:54:42PM +0200, Eli Cohen wrote:
> > > On Tue, Feb 23, 2021 at 07:52:34AM -0500, Michael S. Tsirkin wrote:
> > > > 
> > > > I think I have them in the linux next branch, no?
> > > > 
> > > 
> > > You do.
> > 
> > I guest there's a conflict with some other patch in that tree then.
> > Can you rebase please?
> > 
> 
> Parav, will send later today.

Sorry, no need to resend Parav's patches in linux-next.
Just this one ...

> > -- 
> > MST
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
