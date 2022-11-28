Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F147C43217
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 11:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B493B402A6;
	Mon, 28 Nov 2022 11:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B493B402A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6JENAT8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ_BcDe0E8kY; Mon, 28 Nov 2022 11:13:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A96B40266;
	Mon, 28 Nov 2022 11:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A96B40266
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B07CDC0032;
	Mon, 28 Nov 2022 11:13:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AED61C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 11:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C257605A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 11:13:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C257605A4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6JENAT8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rsiD5xljMB4L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 11:13:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B78960594
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B78960594
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669633999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n885n92m/I4LkalAJyIaZBFKS7m7GqbH7HaZ/6MYOpI=;
 b=i6JENAT8Gg8ho4Lp0ggAML+IyQscPHNSxrpOwX4COtkoaGql3vpJu1yWEV3Y3eZQRZ62xt
 LHLpEEYn5Cmln3nkUwWN7dNaeyhrOsyk2MEM4WtlXSHXrl/K0fvcFk++Hctq63ee5BqEb+
 9ifzyFNFMRNJ2pJQH0ot3Eu3FbilO7E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-A2vhQlXKPWmff9FlzXXiAw-1; Mon, 28 Nov 2022 06:13:17 -0500
X-MC-Unique: A2vhQlXKPWmff9FlzXXiAw-1
Received: by mail-wm1-f70.google.com with SMTP id
 c126-20020a1c3584000000b003cfffcf7c1aso8475392wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 03:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n885n92m/I4LkalAJyIaZBFKS7m7GqbH7HaZ/6MYOpI=;
 b=hZ1WpTGhfdXoiDbdCfwKOSSXL6RNTL6aLocp+vFHi+F+fk+iYYWGAge7gW7FDewKs4
 yTlhqpi/EFhPBDd9JS4kFqJWkCo2EWOkAHlmxD+REQgnNRDrCANWgU/IcG3lpiPScMpv
 I4+cnIOmWNmBBKuM/KuSN5HHFxoZwPMM441UyUGNJaxk1FIwdOqmaVPeVBFG7wBPUCiq
 XZ6Svvr9+QGnZoPr7lpuL2GvO4dtJfLOUx7nRkD3jDMeFXXn4ogqdCcidVZNT6Hi+LRt
 oGU+1SHPdmYs+E5yln0ObZWdHgPWVGuSTUPzrPvRr1/VFup838OXMOU6WRxTAeQ8PX7n
 hEGA==
X-Gm-Message-State: ANoB5plXDjAAVZ9zpQuYKrIKAuxDN86fazN+udGVnFJZFRYovD4rnC5N
 VEvHC/AAaeNMWr300WH1RcU27+f62lmhaduu5tXCYMI7ciTjvZQbVvN8ViUh426KfPPM0epXoFi
 rrHIap53AIL2jvwDy6r3093PgmWzxrdX7SXLfLhvP7w==
X-Received: by 2002:adf:dd07:0:b0:23a:2311:b72 with SMTP id
 a7-20020adfdd07000000b0023a23110b72mr23924287wrm.147.1669633996685; 
 Mon, 28 Nov 2022 03:13:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5J2/sBKnl+vG7mrgkt/RBZFkd1JITHauZT0SPEGgQXNwoqP2YELKNPLOM2ZlRYFq0xcWA2kA==
X-Received: by 2002:adf:dd07:0:b0:23a:2311:b72 with SMTP id
 a7-20020adfdd07000000b0023a23110b72mr23924274wrm.147.1669633996453; 
 Mon, 28 Nov 2022 03:13:16 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 e5-20020a05600c4e4500b003b492753826sm14305668wmq.43.2022.11.28.03.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 03:13:15 -0800 (PST)
Date: Mon, 28 Nov 2022 12:13:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <error27@gmail.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
 <Y4SUOPX2WRFiuB7n@kadam>
MIME-Version: 1.0
In-Reply-To: <Y4SUOPX2WRFiuB7n@kadam>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S . Tsirkin" <mst@redhat.com>, harshit.m.mogalapalli@gmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Gautam Dawar <gautam.dawar@xilinx.com>,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 28, 2022 at 01:58:00PM +0300, Dan Carpenter wrote:
>On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
>> > Add a limit to 'config->vq_num' which is user controlled data which
>> > comes from an vduse_ioctl to prevent large memory allocations.
>> >
>> > This is found using static analysis with smatch.
>> >
>> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> > ---
>> > v1->v2: Change title of the commit and description, add a limit to
>> > 	vq_num.
>> >
>> > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
>> > Only compile and boot tested.
>> > ---
>> > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
>> > 1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> > index 35dceee3ed56..31017ebc4d7c 100644
>> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
>> > 	if (config->config_size > PAGE_SIZE)
>> > 		return false;
>> >
>> > +	if (config->vq_num > 0xffff)
>>
>> What about using U16_MAX here?
>
>Where is the ->vq_num stored in a u16?  I looked for this but didn't
>see it.

I thought vq_num referred to the number of elements in the vq (like 
.get_vq_num_max), since this patch wants to limit to 0xffff.

But it actually refers to the number of virtqueue, so @Harshit why do we 
limit it to 0xffff?

Maybe we should explain it in the commit message or in a comment.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
