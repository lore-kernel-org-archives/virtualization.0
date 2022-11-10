Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB6C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 05:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83B1240192;
	Thu, 10 Nov 2022 05:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83B1240192
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ik/ehJvX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GLmnOzm_uOyH; Thu, 10 Nov 2022 05:05:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B723940143;
	Thu, 10 Nov 2022 05:04:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B723940143
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 883F7C0033;
	Thu, 10 Nov 2022 05:04:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD6AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55E4240183
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:04:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55E4240183
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ik/ehJvX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sKpHtf4HJ2yq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:04:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3133C4010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3133C4010C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 05:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668056695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHT7iw7almXkodunne0Nx5UpThP9sgHSR7Y/qy0zMa4=;
 b=Ik/ehJvX3sFXFXRBnmD2kqZrFtrgowsr31EPTrPSg1R5ZqMmbiiN0ZCcJ5DjnGGOphqLyC
 +G3mvZKZAi3BAGvowcedXuOHV6wvRhBOqaDtELiQ4Nzq1ySAXN7NK05+apCVeOP61FUhT/
 EFIvRm/83msKQCyKs0GB3KUjl9KKpPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-UgXYo8VkMJewKiuG1GN_XQ-1; Thu, 10 Nov 2022 00:04:54 -0500
X-MC-Unique: UgXYo8VkMJewKiuG1GN_XQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 186-20020a1c02c3000000b003cfab28cbe0so2065551wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 21:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHT7iw7almXkodunne0Nx5UpThP9sgHSR7Y/qy0zMa4=;
 b=77KAa8UsmaKOBFPOvGYe7cEtYxa2C1+y7mfMCeaTN75/pXZjic8IT60lZj/N9DM3s3
 h1m5iWTs/DlTHq1X+aVSJFyrNWh5IcjAyb9kfQY44OpskZ5EOjgeaX3fKkpJxnbLKIE5
 gggb5MQzAxvc5eD2+yNgVso9BL+01XVamdgeSbsJGedC/+CDBVYgKWNtx/sBsZ2cWEJE
 W1Pg9M8ydyi+Unfrehh+miAUcQpZPfUrk4GaO2owek+nQ5A/WFjASL2rvHwaEoH3yIe3
 2jok4UURexgy25XzGlyRkpypNdMQZbGX6fePN5esE27j6hTGGEi/yGykemsdQ4+b0bgO
 Bd5w==
X-Gm-Message-State: ACrzQf2T64tIiKvewJGvqLjDekYrB8L9EAQFUnpDgTLkYOsvYWlZNi4q
 VW+wORZDK3S3DzQOvaYIpP2CAwOkUTn6QLOIQwPyU8qA7qXaqPg59oXn0RcW1qOeWjAGsDTkXnO
 9WljiQJO/MAyjcc6uXzImdaSwqXVNQnRYxCokNe3kaQ==
X-Received: by 2002:a5d:598d:0:b0:236:8ef4:7324 with SMTP id
 n13-20020a5d598d000000b002368ef47324mr40926455wri.84.1668056692958; 
 Wed, 09 Nov 2022 21:04:52 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7Cy6n7vZ9A59gKH1yknUItYdABn1qHhTZB+YgamzQ1xGDDdIuS1j50cAfvCiDXMi+aekLTfQ==
X-Received: by 2002:a5d:598d:0:b0:236:8ef4:7324 with SMTP id
 n13-20020a5d598d000000b002368ef47324mr40926448wri.84.1668056692692; 
 Wed, 09 Nov 2022 21:04:52 -0800 (PST)
Received: from redhat.com ([2.52.23.68]) by smtp.gmail.com with ESMTPSA id
 g12-20020adffc8c000000b0022cd96b3ba6sm17090371wrr.90.2022.11.09.21.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 21:04:51 -0800 (PST)
Date: Thu, 10 Nov 2022 00:04:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
Message-ID: <20221110000433-mutt-send-email-mst@kernel.org>
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
 <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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

On Thu, Nov 10, 2022 at 03:30:59AM +0000, Angus Chen wrote:
> Hi Jason.
> 
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, November 2, 2022 1:34 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; lingshan.zhu@intel.com
> > Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
> > 
> > On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com>
> > wrote:
> > >
> > > Virtio_crypto use max_data_queues+1 to setup vqs,
> > > we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> > > We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> > > if common->num_queues is not set well,and it return -ENOENT.
> > > It is better to use -EINVAL instead.
> > 
> > I'm not sure I get this. It would be better to describe:
> > 
> > 1) what kind of issues can we see if we return -ENOENT
> > 2) why -EINVAL can help in this case
> > 
> > Thanks
> Thank you for your reply.
> We use a robot to test our dpu to get the return value of probe.
>  We often get ENOENT form ' setup_vq ' function because of device error.
> Most of time, my device can't handle queue_enable well.
> This time,we get 'ENOENT' because the device set max_data_queues bigger than num_queues.
> 
> I think EINVAL is used when the value of some parameter is wrong.

I think I agree. Jason?

> Btw,it not a big deal,I can modify the robot to workaround.
> 
> > 
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > b/drivers/virtio/virtio_pci_modern.c
> > > index c3b9f2761849..edf2e18014cd 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct
> > virtio_pci_device *vp_dev,
> > >         int err;
> > >
> > >         if (index >= vp_modern_get_num_queues(mdev))
> > > -               return ERR_PTR(-ENOENT);
> > > +               return ERR_PTR(-EINVAL);
> > >
> > >         /* Check if queue is either not available or already active. */
> > >         num = vp_modern_get_queue_size(mdev, index);
> > > --
> > > 2.25.1
> > >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
