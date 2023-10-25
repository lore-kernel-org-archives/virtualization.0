Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C8C07545
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 16:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 343E881428;
	Wed, 25 Oct 2023 16:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 343E881428
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JeEwiZos
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x5wJnCKQXmVB; Wed, 25 Oct 2023 16:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA64F81429;
	Wed, 25 Oct 2023 16:31:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA64F81429
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9A7C0071;
	Wed, 25 Oct 2023 16:31:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31774C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0595940146
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:31:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0595940146
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JeEwiZos
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id icFjmSt_1cZr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:31:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC6D740144
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 16:31:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC6D740144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698251498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owj/IgbM605bV8Yu7nR7E/zNBKuxTVn/TxVFSd4A+Wg=;
 b=JeEwiZosqbfq1VG+Nuu/8waWlwGuyZ8Z6ve81TMcHGxGPTxKhkUQ3mkeGKNEREnxRiRG2G
 /t+Q8vqvL/yBnQIV6D5mQJ0lqThgORHfdX/zfFauiljf8E19bH/gVrqqikiWittwa44ZmI
 9ldxo99eWFHqxnsp6y8jQxK53jxe7Ww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-T13XA7YdMXuXAOTfP8FUYA-1; Wed, 25 Oct 2023 12:31:37 -0400
X-MC-Unique: T13XA7YdMXuXAOTfP8FUYA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4083717431eso35659905e9.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 09:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698251496; x=1698856296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owj/IgbM605bV8Yu7nR7E/zNBKuxTVn/TxVFSd4A+Wg=;
 b=tRLQ/mvG7C91xGW6QX8a56cOrKrKguld6REuKPnvzuLsl14iAaQU0IBwmY3v//dRyl
 w7Ib60HF4oMXR8tyzbk6wISs6grjcw4n5iHyMRD+XrKsvcKWLWloQtv+LHYXK3YgNM+Z
 1t0dcUSPVmhYqRmkiVeaO77r0ZZRUsbBCPuiE5onuqDgfhuvi4RzMIoVeF/7T/WjAboe
 SpTR/A/a86yLF3Zr5nHwhaPWYZt7Kp2RwPrIDIJfDZejt0GtynH1dWGARdypbQyF9YjA
 RsioRmCIw0HtAhGCjbdEGLpEgP6AI3zHfuWjCXR7JYG7/EAGf0zFSAYm6/yed7fLi3hq
 0pyg==
X-Gm-Message-State: AOJu0YwqegGkxX9j0oaCgr4F4ok9rbD6Y8Zc08G5ZCGW787EwueD+swR
 6WYOxuKGYpyeCBIv/ua8p7WyPbRPUEuXM+9nmFsSj9iY9e1RukoOqyE4J9GLJ8e8/WP82BWa7Tq
 AY8qgRv/86ssZkyl4/Jh3NW6wHf2f/tdTAZAIaBp1UA==
X-Received: by 2002:a05:600c:1d22:b0:408:4475:8cc1 with SMTP id
 l34-20020a05600c1d2200b0040844758cc1mr13426459wms.35.1698251496406; 
 Wed, 25 Oct 2023 09:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDm9/V4aKQCUkrPB+NkD3U1VePFB4INruAwiAqMqgKfjYNyEo1VUV9pgHR3nBbainlDQFKXQ==
X-Received: by 2002:a05:600c:1d22:b0:408:4475:8cc1 with SMTP id
 l34-20020a05600c1d2200b0040844758cc1mr13426436wms.35.1698251496049; 
 Wed, 25 Oct 2023 09:31:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a05600c159600b004075d5664basm210861wmf.8.2023.10.25.09.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:31:35 -0700 (PDT)
Date: Wed, 25 Oct 2023 12:31:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
Message-ID: <20231025122913-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-7-yishaih@nvidia.com>
 <20231024165210-mutt-send-email-mst@kernel.org>
 <5a83e6c1-1d32-4edb-a01c-3660ab74d875@nvidia.com>
 <20231025060501-mutt-send-email-mst@kernel.org>
 <03c4e0da-7a5c-44bc-98f8-fca8228a9674@nvidia.com>
 <20231025094118-mutt-send-email-mst@kernel.org>
 <c6c849b6-e1ff-4319-a199-5abcac032a25@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <c6c849b6-e1ff-4319-a199-5abcac032a25@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Wed, Oct 25, 2023 at 05:03:55PM +0300, Yishai Hadas wrote:
> > Yes - I think some kind of API will be needed to setup/cleanup.
> > Then 1st call to setup would do the list/use dance? some ref counting?
> 
> OK, we may work to come in V2 with that option in place.
> 
> Please note that the initialization 'list/use' commands would be done as
> part of the admin queue activation but we can't enable the admin queue for
> the upper layers before that it was done.

I don't know what does this mean.

> So, we may consider skipping the ref count set/get as part of the
> initialization flow with some flag/detection of the list/use commands as the
> ref count setting enables the admin queue for upper-layers which we would
> like to prevent by that time.

You can init on 1st use but you can't destroy after last use.
For symmetry it's better to just have explicit constructor/destructor.


> > 
> > And maybe the API should just be
> > bool virtio_pci_admin_has_legacy_io()
> 
> This can work as well.
> 
> In that case, the API will just get the VF PCI to get from it the PF +
> 'admin_queue' context and will check internally that all current 5 legacy
> commands are supported.
> 
> Yishai

Yes, makes sense.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
