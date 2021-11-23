Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5269C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 04:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45FE780D5E;
	Tue, 23 Nov 2021 04:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Is1tNrg6haO7; Tue, 23 Nov 2021 04:13:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02D2680D98;
	Tue, 23 Nov 2021 04:13:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7B9AC002E;
	Tue, 23 Nov 2021 04:13:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98E5FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CD3B401D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFEwugvPQK22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:13:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF17B40219
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 04:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637640786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ph1TOkVRVJZ0jQEXGshzxIVlkYeNDfONV+sQAMGUFbw=;
 b=WZeEDPazEZLzUQm5MsUIx3Qbhvl/+RPvyGPbTgYra2tk8mXIVnUvsV5pAEoDS20vtDMIx7
 3qUz+3xREePTeBKzVk0HdPDHW40kNSwfhg5IsHoGusxH1V/w0N2vCr7ApnNfnP2QLBSF3u
 eHSBVCTME3plyncsSNMxZXEp8ps9VEU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-lcDwK7WHMc66Mby_jxRKTw-1; Mon, 22 Nov 2021 23:13:04 -0500
X-MC-Unique: lcDwK7WHMc66Mby_jxRKTw-1
Received: by mail-lj1-f199.google.com with SMTP id
 u28-20020a2ea17c000000b0021126b5cca2so770424ljl.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 20:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ph1TOkVRVJZ0jQEXGshzxIVlkYeNDfONV+sQAMGUFbw=;
 b=ym6f63GznoRNDgkmwiVQ3VjSJxMjfgAZDyvPyB4TvIRXT4Jbgf1kFxeX8ds8MaLsCF
 mFcUtXMEMe2Z/6o8OyX5ka1ugl6uVtPolzQOOkS3bNEH5sYqksE7c12hAVEv+4QwN3Z9
 VArngM5ZY6xt5CEjGZAycxfDGWNOuQf5duamQ7WSJADBD8VauBUhxci7U9gGoSfDQAvF
 DgochW0H/nOTqltqX7hvLodm79PywKQ+qWhz8av3yz8SpGRxteH7OBN56QMqQbfWJVyh
 2u50xlzbpQFBk7ggHx0dWSufsghDgUFrs9ikBYOfycYvpPqZ11gLrINprcRy67RhdyFw
 cq0g==
X-Gm-Message-State: AOAM5320N8TrooDOwd18kaK41vfOBKNnbvsekdBp4etdcwrZaqpLM5+k
 IGkygd3Zbbw9Z/RcypQQb7v3yIovj1lvZlGQBamZKGQSXZc/h3bvRTkS9H5hw/+cZ6u8p6Lew8z
 HPdWX+rK+n1HhP65mNoX83p+ZJ0BPuAjuxzPLyCXBgJ/Vre/WQNHKRTjjAw==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr1714470ljw.217.1637640783095; 
 Mon, 22 Nov 2021 20:13:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1XKSp5o6YaM93E2NH2xZ/FKDrjFK5qLFTZGKmo0qWX1VnWK9vDWf52/6Mgz7371s3SqvgoDGqTrTY023CcVc=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr1714447ljw.217.1637640782897; 
 Mon, 22 Nov 2021 20:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20211122122221.56-1-longpeng2@huawei.com>
 <PH0PR12MB54811F4CC671312DFB2FACCDDC609@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54811F4CC671312DFB2FACCDDC609@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Nov 2021 12:12:49 +0800
Message-ID: <CACGkMEsDmqwWdw51NKftjhcGr6z9ynP8dcqDiaQY=soTXTSBDg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Longpeng\(Mike\)" <longpeng2@huawei.com>
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

On Tue, Nov 23, 2021 at 11:12 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Longpeng(Mike) <longpeng2@huawei.com>
> > Sent: Monday, November 22, 2021 5:52 PM
> >
> > From: Longpeng <longpeng2@huawei.com>
> >
> > The system will crash if we put an uninitialized iova_domain, this could
> > happen when an error occurs before initializing the iova_domain in
> > vdpasim_create().
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000000 ...
> > RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
> > ...
> > Call Trace:
> >  <TASK>
> >  put_iova_domain+0x29/0x220
> >  vdpasim_free+0xd1/0x120 [vdpa_sim]
> >  vdpa_release_dev+0x21/0x40 [vdpa]
> >  device_release+0x33/0x90
> >  kobject_release+0x63/0x160
> >  vdpasim_create+0x127/0x2a0 [vdpa_sim]
> >  vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
> >  vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
> >  genl_family_rcv_msg_doit+0x112/0x140
> >  genl_rcv_msg+0xdf/0x1d0
> >  ...
> >
> > So we must make sure the iova_domain is already initialized before put it.
> >
> > In addition, we may get the following warning in this case:
> > WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
> >
> > So we must make sure the iova_cache_put() is invoked only if the
> > iova_cache_get() is already invoked. Let's fix it together.
> >
> > Signed-off-by: Longpeng <longpeng2@huawei.com>
>
> Can you please add the fixes tag here so that older kernels can take this fix?
>

I guess it's 4080fc106750 ("vdpa_sim: use iova module to allocate IOVA
addresses")

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
