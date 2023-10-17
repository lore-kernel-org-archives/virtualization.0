Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DCFCDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 13:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB87240A78;
	Tue, 17 Oct 2023 13:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB87240A78
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVj5TX1u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoHAEJZ_H4gU; Tue, 17 Oct 2023 13:45:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38390416F4;
	Tue, 17 Oct 2023 13:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38390416F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C2EEC0072;
	Tue, 17 Oct 2023 13:45:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 106E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF9244040B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF9244040B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cVj5TX1u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xFEtSjuTzKwr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:45:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9BEF404D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9BEF404D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697550299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tLalsWUBQv2eaq8XqLFym011Xwo+8KxiqgnVaF0bHE=;
 b=cVj5TX1ucVJY+o3zprPW1InM9E9NI6xCIvyKNA6TXL9PX3ZQv+bGzkly72eXtenXgz+7OG
 Ga2pfw1ZBpFvviHAZFJ1fASe6+o4Pp34YaXPx1t/uKUg3oSRaOHG+px+nBHGpsO1dxIY6w
 kTE9IkZKeJi7XynpOPuz/+0Ni0D7XrE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-DnSI1D-6No6koWos332gxA-1; Tue, 17 Oct 2023 09:44:34 -0400
X-MC-Unique: DnSI1D-6No6koWos332gxA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7788fb069abso17212485a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697550273; x=1698155073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tLalsWUBQv2eaq8XqLFym011Xwo+8KxiqgnVaF0bHE=;
 b=lHmneMsG2wuDAlAwYRvhu4f2pAzWrupatn2psZeFbLg+T4ApUY0hb4We6d0cR0CLzC
 hdLqADmBi9tqRrl+tkyqnoxU2Hk07Dxs2zU0gETWQSMZ06gj0lQsdRo39A9otVd/Ffvk
 0mCIFuyts6uevmnsEeEKHCUbWmAU0zQP50ayniDkH74PUm3/97Q3sZJG0NMq9hU+fgil
 D7CPmBpziVlIY/0hwCmXRDKyO90x/qVg9mZPfBcTvBdL1r+UNWlBoMIZ3YsIOsk4vVYP
 qEfyK3boSObjW+dHA5bu5UQtScLyqRJJ30YqeI7O34nfEqthe+syz8YwiAUBtVWNteZX
 t4+w==
X-Gm-Message-State: AOJu0YwVdMowA9wBPiLcE453D6fR01b8QPKmXMkviUxhuf4TL+5ucs1B
 w+8d3eQXb3ibAiL2bMCLvbHjSJHx9amyVpm+NTa6HyTQYhP7qJZf37QP5lGILCJVp/b2rLu480n
 QW2TSAicSbcx93b0g1NOsimTBhAZmhacd4+XtqoJX3Q==
X-Received: by 2002:a05:620a:2805:b0:76c:ea67:38e4 with SMTP id
 f5-20020a05620a280500b0076cea6738e4mr2488822qkp.12.1697550273487; 
 Tue, 17 Oct 2023 06:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe/+gx4ZMW+d11WxvZrwWfW/nhQceCO+qSf3H80xnXqpxE9FmqN+oFuFeKDByPH/ByeaqMpQ==
X-Received: by 2002:a05:620a:2805:b0:76c:ea67:38e4 with SMTP id
 f5-20020a05620a280500b0076cea6738e4mr2488793qkp.12.1697550273066; 
 Tue, 17 Oct 2023 06:44:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 w17-20020a05620a149100b0076cbcf8ad3bsm649455qkj.55.2023.10.17.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:44:32 -0700 (PDT)
Date: Tue, 17 Oct 2023 15:44:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [RFC PATCH] vdpa_sim: implement .reset_map support
Message-ID: <kuiqvqcspmx2fo6sylivhzopxnsxlqxahicgbp3lrltewz2puj@bka6ceakl6x3>
References: <1697185420-27213-1-git-send-email-si-wei.liu@oracle.com>
 <4o4yuuezigilikolv2paxb7icrsm3gdnj5aeoe47uotzju7xve@s5vqaafrppdv>
 <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
MIME-Version: 1.0
In-Reply-To: <2222edd1-4eb1-4b06-87ef-df2d4f591931@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Fri, Oct 13, 2023 at 10:29:26AM -0700, Si-Wei Liu wrote:
>Hi Stefano,
>
>On 10/13/2023 2:22 AM, Stefano Garzarella wrote:
>>Hi Si-Wei,
>>
>>On Fri, Oct 13, 2023 at 01:23:40AM -0700, Si-Wei Liu wrote:
>>>RFC only. Not tested on vdpa-sim-blk with user virtual address.
>>
>>I can test it, but what I should stress?
>Great, thank you! As you see, my patch moved vhost_iotlb_reset out of 
>vdpasim_reset for the sake of decoupling mapping from vdpa device 
>reset. For hardware devices this decoupling makes sense as platform 
>IOMMU already did it. But I'm not sure if there's something in the 
>software device (esp. with vdpa-blk and the userspace library stack) 
>that may have to rely on the current .reset behavior that clears the 
>vhost_iotlb. So perhaps you can try to exercise every possible case 
>involving blk device reset, and see if anything (related to mapping) 
>breaks?

I just tried these steps without using a VM and the host kernel hangs
after adding the device:

[root@f38-vm-build ~]# modprobe virtio-vdpa
[root@f38-vm-build ~]# modprobe vdpa-sim-blk
[root@f38-vm-build ~]# vdpa dev add mgmtdev vdpasim_blk name blk0
[   35.284575][  T563] virtio_blk virtio6: 1/0/0 default/read/poll queues
[   35.286372][  T563] virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
[   35.295271][  T564] vringh:

Reverting this patch (so building "vdpa/mlx5: implement .reset_map 
driver op") worked here.

>
>>
>>>Works fine with vdpa-sim-net which uses physical address to map.
>>
>>Can you share your tests? so I'll try to do the same with blk.
>Basically everything involving virtio device reset in the guest, e.g.  
>reboot the VM, remove/unbind then reprobe/bind the virtio-net 
>module/driver, then see if device I/O (which needs mapping properly) is 
>still flowing as expected. And then everything else that could trigger 
>QEMU's vhost_dev_start/stop paths ending up as passive vhos-vdpa 
>backend reset, for e.g. link status change, suspend/hibernate, SVQ 
>switch and live migration. I am not sure if vdpa-blk supports live 
>migration through SVQ or not, if not you don't need to worry about.
>
>>
>>>
>>>This patch is based on top of [1].
>>>
>>>[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>>
>>The series does not apply well on master or vhost tree.
>>Where should I apply it?
>Sent the link through another email offline.

Received thanks!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
