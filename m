Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF49FC32771
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 07:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53C5361008;
	Wed, 21 Sep 2022 07:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53C5361008
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qb+pQTDG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8bcpLTkj_dc; Wed, 21 Sep 2022 07:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D37D061005;
	Wed, 21 Sep 2022 07:45:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D37D061005
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB1BC0032;
	Wed, 21 Sep 2022 07:45:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3811FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0418E4093E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0418E4093E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qb+pQTDG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C96ACxpvF_2Y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:45:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE70140906
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE70140906
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663746315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dka7ikJW3cdVu+mfUaScxh1T5dkEGzUcye3LFm9YYq0=;
 b=Qb+pQTDG1RiT7SJ9ZHbGulL+FM2stGYJbSEQGMSTvUJ+T9+1f2HPSCNVx2T3LvPlh9T6sn
 bWg9sc+HX24I6s4tCJMg9zNqXfw63XVLaUeBk9gil9rzt7hOG8LsEA1o54J6nR/2juQcxQ
 9npo+1+Egs7PgWvvS75M7ULIxi4OII8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-aVV2YHQrOimN5ceH51k7aA-1; Wed, 21 Sep 2022 03:45:14 -0400
X-MC-Unique: aVV2YHQrOimN5ceH51k7aA-1
Received: by mail-oi1-f197.google.com with SMTP id
 m21-20020a0568080f1500b00350c7fc362cso2758220oiw.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=dka7ikJW3cdVu+mfUaScxh1T5dkEGzUcye3LFm9YYq0=;
 b=AVgeHYG+qKV3aiPcVc2xKVEl2DBztgQl3XUhJLUz30LVLJVJk1Ll+S35lE+/3FFKjJ
 ie5HuBW/ejK6+m7QdoGRCgBq/iTpBG+nr8ewRgFadIjTtcXy5zPd5pmhKVNMoBeB6iNl
 VX7jfRT/7MtdLPw/EbnlYFELwdsAKWPeXZRtvdgJeJ3M/mfKsyAKOZkfn1fd377G7spk
 tAnpne/WVc4DotEJMs033bjwKqCDP+owLYO7Fxo8KeqUEfr5wYmrtLbKtkgbuYotweKE
 AmZ0P7Q0cPidyJeCUo0w0qGWjsjEOwkBI8pGL8OtCNhE24YuBZ6pGYLKnZgHJjmd9psZ
 A4dw==
X-Gm-Message-State: ACrzQf1kdhYyqKvzM3dk8dd7VBADSGnK5WmQlgOWzYz4L44zuDnTsDVC
 yNHPifP38+6Juias9ZSnDaoT70QeBOihndCvIVyRqLNuK4Ag6sah9g3l3/g4LgjqUILh8PASzR6
 dlciC9GEC/hqjiARFbqeJ5+SaL3v+YOemSceHX9WGXmpx0cBfVRzVwoGdMw==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr3207381oib.35.1663746313491; 
 Wed, 21 Sep 2022 00:45:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/OA5L9rNQz8LUbTthCKywcVV8UKYEhEXKNNedafXnV7ZqB2YNPQyTkE+NzRi24V/LpyM8mNQyMkM0qS11xuU=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr3207365oib.35.1663746313279; Wed, 21
 Sep 2022 00:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220915085048.12840-1-jasowang@redhat.com>
 <PH0PR12MB548115F4597D409F94AB1E77DC4C9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548115F4597D409F94AB1E77DC4C9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Sep 2022 15:45:02 +0800
Message-ID: <CACGkMEshK=GoBivM-mHbFBAtvqTQKF-WMwTKvDRxJ70WjVebdA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vdpa: device feature provisioning
To: Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lulu@redhat.com" <lulu@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gdawar@xilinx.com" <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

On Wed, Sep 21, 2022 at 3:17 AM Parav Pandit <parav@nvidia.com> wrote:
>
> Hi Jason,
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 15, 2022 4:51 AM
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH 0/3] vdpa: device feature provisioning
> >
> > Hi All:
> >
> > Virtio features are neogiated between the device and the drivers. This allows
> > the mediation layer like vDPA to hide some features from the driver to
> > faciliate the cross vendor live migration:
> >
> > vDPA on the source supports feature set X vDPA on the destination supports
> > feature set Y
> >
> > Management can simply provision the vDPA instance with features X&Y on
> > both source and destination to let the vDPA can be migrate-able between
> > the two vDPA devies with different features support.
> >
> > This series tries to allow the device features to be provisioned via netlink to
> > achieve this.
> Very useful series.
> Can you please add vdpa example command with and without -jp option in each of the commit logs?

Yes, I will do it in V2.

Thanks

>
> Thanks.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
