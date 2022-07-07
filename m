Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEC2C43334
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 07:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0CDA83E11;
	Thu,  7 Jul 2022 07:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0CDA83E11
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHb4hoVv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a-laEsvZ5ai2; Thu,  7 Jul 2022 07:36:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 614ED83147;
	Thu,  7 Jul 2022 07:36:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 614ED83147
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3647DC0033;
	Thu,  7 Jul 2022 07:36:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32233C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 07:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F192C4176A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 07:36:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F192C4176A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHb4hoVv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZGykN7r1H6lw
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 07:36:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB44541730
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB44541730
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 07:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657179370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=saWM6e0JyDJvaXahV2V2qjYz2t3C6FHDQTH/SnTXHP4=;
 b=UHb4hoVvN4CWXOu1WG9/yZh7h5yZQXlreF6CmJwgY/nGQsJ+D+2YCgKtmlmuKWrZ0Mwgpa
 /LdZMDEvBR5hKhgeDy2w+cxd3USlb0D+wfelQprNu3kY0TkqS0PaqbBYCoDusJcP65/51X
 UkFz4fbk+63CfxiK3/+GpW8Kjw0oikE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-ewK7WjXPMUGe5SgH5_5aiQ-1; Thu, 07 Jul 2022 03:36:09 -0400
X-MC-Unique: ewK7WjXPMUGe5SgH5_5aiQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 f20-20020adfc994000000b0021d4aca9d0eso2932879wrh.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jul 2022 00:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=saWM6e0JyDJvaXahV2V2qjYz2t3C6FHDQTH/SnTXHP4=;
 b=HtVCBXZOL4nlL0+YSWexO/9qzmfOlIEsh+iITpLop+Vpwe7LqA9GQFtH05YQuR9IW4
 YJulsE0zJj2f0901ZtoZlAxjnHcDImgnkXMxIwkmGgruI4xDhdKE9AA2TcRgBIY/4bUY
 03jnAISncScc2GvSUUrzNAaGxiqBdg2QNZxdqF2DQdeoRFzuPbdEWsOddyc4E4bIK32C
 LbJzZyzjhnZDUVVlSs/Hy8qPDBUmWFSJroHYKDqOW3/r+30XcPHTUM9QmIJm2+EHy+bt
 t0c9V6KnlAz6CO4uRCJzHOYS2enpfyiNOfsBrE8Wi+jpWWo3Az2ilz9x9lCVWRw7PFkc
 7e+g==
X-Gm-Message-State: AJIora+JeDG4C8G+S8H9DAYjsLJnxq+bzT+GvIADcVnMXAa6N2TBqMLu
 p6owupGQm7yl2m6aNBY7ts2NSW4zaHjcGXYvZcaBUwFecnxz8PbP3d6y/Fj59OZ7k09lYAcrVp3
 Ds10LB5Lef1luxU+IH3NOncDmkWsciKxiNZhXLbn16g==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id
 c14-20020adffb0e000000b0021a34a25ca9mr42440919wrr.472.1657179367985; 
 Thu, 07 Jul 2022 00:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veceZbRH21fUsnX5CJPHgyNSm2DA1xoK5v3xI4IRUNTkGEIyvFlyIF8/UWpVCYqC2UtKuKaQ==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id
 c14-20020adffb0e000000b0021a34a25ca9mr42440823wrr.472.1657179366892; 
 Thu, 07 Jul 2022 00:36:06 -0700 (PDT)
Received: from redhat.com ([2.52.154.68]) by smtp.gmail.com with ESMTPSA id
 r11-20020adfce8b000000b0021d77625d90sm5440581wrn.79.2022.07.07.00.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jul 2022 00:36:06 -0700 (PDT)
Date: Thu, 7 Jul 2022 03:36:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: Re: [PATCH v2 2/4] virtio_test: move magic number in code as defined
 constant
Message-ID: <20220707033233-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
 <20220707010036-mutt-send-email-mst@kernel.org>
 <8c15f97f-df6d-9ec5-b9d3-c42350cde887@sjtu.edu.cn>
MIME-Version: 1.0
In-Reply-To: <8c15f97f-df6d-9ec5-b9d3-c42350cde887@sjtu.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Thu, Jul 07, 2022 at 02:17:19PM +0800, Guo Zhi wrote:
> On 2022/7/7 13:09, Michael S. Tsirkin wrote:
> > On Thu, Jul 07, 2022 at 10:44:07AM +0800, Guo Zhi wrote:
> > > We should avoid using magic numbers directly.
> > Not necessarily. For repeated values - I guess.
> > But this kind of thing:
> > 
> > 	#define BUF_SIZE 1024
> > 	int buf_size = BUF_SIZE;
> > 
> > brings no benefit IMHO.
> > 
> > And this has cost - values are now removed from code.
> 
> Firstly, as a test, user will have to change the config to test virtio and
> vhost frequently. If these magic number are put together like these, change
> will be more easier.

If tweaking these is useful for users we should add a command line flags
as opposed to asking users to tweak code.

> Secondly, many configs will be repeated, such as MAX_SG_FRAGS, even if some
> varibale only appear once, subsequent upgrade of virtio_test will use these
> variable in other place. For example, in this series of patch, patch 4/4
> will use RINGSIZE to set INDIRECTS_BUF_SIZE.
> 
> > > Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>

Isn't there some way to use the size we get as 1st parameter of kmalloc?

> > > ---
> > >   tools/virtio/virtio_test.c | 18 +++++++++++-------
> > >   1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > > index 95f78b311..1ecd64271 100644
> > > --- a/tools/virtio/virtio_test.c
> > > +++ b/tools/virtio/virtio_test.c
> > > @@ -20,7 +20,10 @@
> > >   #include "../../drivers/vhost/test.h"
> > >   #define RANDOM_BATCH -1
> > > -
> > > +#define ALIGN 4096
> > > +#define RINGSIZE   256
> > > +#define TEST_BUF_NUM 0x100000
> > > +#define BUF_SIZE   1024
> > >   /* Unused */
> > >   void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> > > @@ -100,8 +103,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
> > >   	if (info->vq)
> > >   		vring_del_virtqueue(info->vq);
> > > -	memset(info->ring, 0, vring_size(num, 4096));
> > > -	vring_init(&info->vring, num, info->ring, 4096);
> > > +	memset(info->ring, 0, vring_size(num, ALIGN));
> > > +	vring_init(&info->vring, num, info->ring, ALIGN);
> > >   	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
> > >   					 false, vq_notify, vq_callback, "test");
> > >   	assert(info->vq);
> > > @@ -115,7 +118,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
> > >   	info->idx = dev->nvqs;
> > >   	info->kick = eventfd(0, EFD_NONBLOCK);
> > >   	info->call = eventfd(0, EFD_NONBLOCK);
> > > -	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> > > +	r = posix_memalign(&info->ring, PAGE_SIZE, vring_size(num, ALIGN));
> > >   	assert(r >= 0);
> > >   	vq_reset(info, num, &dev->vdev);
> > >   	vhost_vq_setup(dev, info);
> > This is actually doing more than what commit log says.
> > 
> > > @@ -131,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> > >   	dev->vdev.features = features;
> > >   	INIT_LIST_HEAD(&dev->vdev.vqs);
> > >   	spin_lock_init(&dev->vdev.vqs_list_lock);
> > > -	dev->buf_size = 1024;
> > > +	dev->buf_size = BUF_SIZE;
> > > 
> > > 
> > > This seems to have zero added value.
> > > 
> Since the reason above and other magic number have been set as a defined
> constant, change here for simplicity and consistency.
> > >   	dev->buf = malloc(dev->buf_size);
> > >   	assert(dev->buf);
> > >           dev->control = open("/dev/vhost-test", O_RDWR);
> > > @@ -396,7 +399,8 @@ int main(int argc, char **argv)
> > >   done:
> > >   	vdev_info_init(&dev, features);
> > > -	vq_info_add(&dev, 256);
> > > -	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
> > > +	vq_info_add(&dev, RINGSIZE);
> > > +
> > > +	run_test(&dev, &dev.vqs[0], delayed, batch, reset, TEST_BUF_NUM);
> > >   	return 0;
> > 
> > This replacement does not buy us anything either.
> RINGSIZE will be used in other place in subsequent modification.
> > 
> > >   }
> > > -- 
> > > 2.17.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
