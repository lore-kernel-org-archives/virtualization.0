Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CEDC433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 13:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0F2E408FE;
	Mon, 28 Nov 2022 13:10:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0F2E408FE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgYD3Xu9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LFy0dW05dD2m; Mon, 28 Nov 2022 13:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22F13408F4;
	Mon, 28 Nov 2022 13:10:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22F13408F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA970C0035;
	Mon, 28 Nov 2022 13:10:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E48A8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 13:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B212860593
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 13:10:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B212860593
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GgYD3Xu9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXBoQ0ZfO6BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 13:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F08B860A77
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F08B860A77
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669641015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tG1zMiwdOY9O7mrEYW6ArphNZnozJi7hc/+tTcFVOb4=;
 b=GgYD3Xu9JlOPulNSxciGArnJ6KrpBIDrh9CfBLriFXcny+9XYjMsuWiNtYbxSBdbJYMDJn
 YEEpCLi7aRa/Cb5FOastXM7pYMVKaCQZaqNltDnILlxUpi5P1pIRpQZPu378tFS7dW6TPK
 woO3pzcjYVlFsGW1coMXGpwA2hGEGUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-Nwwut6T6NtGaISPy2dw2Yg-1; Mon, 28 Nov 2022 08:10:14 -0500
X-MC-Unique: Nwwut6T6NtGaISPy2dw2Yg-1
Received: by mail-wm1-f71.google.com with SMTP id
 z15-20020a1c4c0f000000b003cf6f80007cso3681602wmf.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 05:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG1zMiwdOY9O7mrEYW6ArphNZnozJi7hc/+tTcFVOb4=;
 b=Imix8zGeBZBB9fPTmz05UTfO6Yp3ylufq7juuhXIWYoYt2HZ8bBTASIAKF8h9gcCKi
 MleHRaqYam8MZ5VkIDVbaEA1TarLyi45FR+dknrubCaxmDjU3fz7k68CnTx5/8yqcRqA
 4PdhP9Ck+JF+TmpblZdA1ceON1JwExZAE1+sxe1zs0GSbOgNALmyW+IvcKrwzJjb/wvG
 /Dw72yutAa35JUUyAhPoW6vNqo6TlL8i64TaCLuuw4G+zdg6mX9+8uP4i7ctcQjgCZvD
 nD0VN4VRgsomba/ZNLOuzo7pasrV5gMUtxtfbz8lTgyh/9sSz8SE1LBxjceymff95sj4
 HPqg==
X-Gm-Message-State: ANoB5pnSuq28z7icw3zpCp2Due6WBcni8izYzUv4aZ2JU4qv21PpnbOG
 1thoi5xFXVNO8SBQl12k7kxecvBq7bFx9JgXR6xjTGl+gydoqrit6oImpAx1pV3ejIVls5Vg8/4
 3yjBMR6dP0wLd2HWVzPcEoBww2Nc8CIjTqYwM7/6YVg==
X-Received: by 2002:a05:6000:105:b0:236:64e6:8c04 with SMTP id
 o5-20020a056000010500b0023664e68c04mr30902213wrx.579.1669641013398; 
 Mon, 28 Nov 2022 05:10:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6dQQZXu6s2F8m0nrdL8TAKZisB38/fekquSxxxPYuklf3PUYQKVHFhVB063xtDQTa9/B3MgA==
X-Received: by 2002:a05:6000:105:b0:236:64e6:8c04 with SMTP id
 o5-20020a056000010500b0023664e68c04mr30902187wrx.579.1669641013140; 
 Mon, 28 Nov 2022 05:10:13 -0800 (PST)
Received: from redhat.com ([2.52.149.178]) by smtp.gmail.com with ESMTPSA id
 p7-20020adfe607000000b00241fea203b6sm10930244wrm.87.2022.11.28.05.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 05:10:12 -0800 (PST)
Date: Mon, 28 Nov 2022 08:10:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <20221128070238-mutt-send-email-mst@kernel.org>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
 <Y4SUOPX2WRFiuB7n@kadam>
 <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dan Carpenter <error27@gmail.com>, harshit.m.mogalapalli@gmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 28, 2022 at 12:13:10PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 28, 2022 at 01:58:00PM +0300, Dan Carpenter wrote:
> > On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
> > > On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
> > > > Add a limit to 'config->vq_num' which is user controlled data which
> > > > comes from an vduse_ioctl to prevent large memory allocations.
> > > >
> > > > This is found using static analysis with smatch.
> > > >
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > > ---
> > > > v1->v2: Change title of the commit and description, add a limit to
> > > > 	vq_num.
> > > >
> > > > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
> > > > Only compile and boot tested.
> > > > ---
> > > > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
> > > > 1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index 35dceee3ed56..31017ebc4d7c 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
> > > > 	if (config->config_size > PAGE_SIZE)
> > > > 		return false;
> > > >
> > > > +	if (config->vq_num > 0xffff)
> > > 
> > > What about using U16_MAX here?
> > 
> > Where is the ->vq_num stored in a u16?  I looked for this but didn't
> > see it.
> 
> I thought vq_num referred to the number of elements in the vq (like
> .get_vq_num_max), since this patch wants to limit to 0xffff.
> 
> But it actually refers to the number of virtqueue, so @Harshit why do we
> limit it to 0xffff?
> 
> Maybe we should explain it in the commit message or in a comment.
> 
> Thanks,
> Stefano

This limit is somewhat arbitrary.
However, currently virtio pci and ccw are limited to a 16 bit vq number.
While MMIO isn't it is also isn't used with lots of VQs due to
current lack of support for per-vq interrupts.
Thus, the 0xffff limit on number of VQs corresponding
to a 16-bit VQ number seems sufficient for now.

Feel free to put the above in a code comment.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
