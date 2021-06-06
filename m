Return-Path: <SRS0=BGPi=LA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7AEC4743D
	for <virtualization@archiver.kernel.org>; Sun,  6 Jun 2021 21:38:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CF9613EF
	for <virtualization@archiver.kernel.org>; Sun,  6 Jun 2021 21:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CF9613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93645607BB;
	Sun,  6 Jun 2021 21:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id agtLtTirpR7w; Sun,  6 Jun 2021 21:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972B060668;
	Sun,  6 Jun 2021 21:38:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 673DAC000D;
	Sun,  6 Jun 2021 21:38:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C014C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 21:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21E378308A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 21:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RQp93GR8Riwl
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 21:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0145B82F49
 for <virtualization@lists.linux-foundation.org>;
 Sun,  6 Jun 2021 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623015498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8vWFElkad4xNWgmx0I+aoxZCO6IO2dGLstVg+nWwfUo=;
 b=TStet7YtYPYJ2DAAFefIKIHhrcklJ8Ua+8iXC+b9lrZwI84rFz2c+oyumWYKi5stA2jWjP
 aMLAb/nF+ek5IhSNU1CokQzF/3gHncmS63HsEpxnGmUvgGC/mlg0WO/SFOHNvJk0juBFpt
 TpgKJwmmFMJvZN8m90r3K67dEo9Js18=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-YULLmhxaN0Cf2IMHFTZcrA-1; Sun, 06 Jun 2021 17:38:16 -0400
X-MC-Unique: YULLmhxaN0Cf2IMHFTZcrA-1
Received: by mail-wr1-f71.google.com with SMTP id
 z3-20020adfdf830000b02901198337bc39so6672520wrl.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 14:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8vWFElkad4xNWgmx0I+aoxZCO6IO2dGLstVg+nWwfUo=;
 b=dFAWSkd4/0tIxkzIJujgzzEjwwacwSTbPlWcVZcbXKmjD21etcMhXk5EWsgraZub33
 Jg29FT4jUFfaL8mxREVRlGnJZjcj+c5ITUonp5w3AzDEB6uPadYVv/o/F4GfXrEKNLX8
 xp/cuoC3igpRGzdVR2UaIrsEitsw9c8GbaKz/M+ebYlTJajQe84GhOlfieqzoXzPrFe4
 cR3E4o/IlxSZjoW2lkHu7x/qnkZpWFgMR8nzopGzHDoIFBrBEh6j9ik4jlxMHE9tm4Mo
 HITeYetWGHEUlZ0UmF8rpv1cGVT0L1X6ZqUTKVvaeN96tn/LaT7mRD5XNjHpxg63AWbd
 dlrw==
X-Gm-Message-State: AOAM532EzWQQkDnCug5Z30tsM5NUUd33ZbYhCp0qwkRgJ/1Xqofae9Xi
 sJxHMmqAym983UNfCtzQo9PWU4IKoNG59afhrCvO3NOyq9F/bNtH7NeNqT4/GdPgsZpSJnRYxM4
 xWmezlM427iKiIWePSqX6vHfVSvB0Z9Is/7RDO4O+ig==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr14032991wrq.211.1623015495396; 
 Sun, 06 Jun 2021 14:38:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyt6kdW6kz81qWNAuTISPh8IMxZ/HVu3CPXbCOF9gWPx3gDF8OxvM7tsfqrMdvRN6AozYH9g==
X-Received: by 2002:a5d:460a:: with SMTP id t10mr14032982wrq.211.1623015495219; 
 Sun, 06 Jun 2021 14:38:15 -0700 (PDT)
Received: from redhat.com ([147.161.12.158])
 by smtp.gmail.com with ESMTPSA id i15sm3192666wmq.23.2021.06.06.14.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jun 2021 14:38:14 -0700 (PDT)
Date: Sun, 6 Jun 2021 17:38:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gautam Dawar <gdawar@xilinx.com>
Subject: Re: Security hole in vhost-vdpa?
Message-ID: <20210606173637-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB6980228A5EA2D021A3F9F47BB1399@BY5PR02MB6980.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB6980228A5EA2D021A3F9F47BB1399@BY5PR02MB6980.namprd02.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
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

On Sun, Jun 06, 2021 at 02:39:48PM +0000, Gautam Dawar wrote:
> Hi All,
> 
>  
> 
> This is in continuation to my findings noted in Bug 213179 and discussions we
> have had in the last couple of weeks over emails.
> 
>  
> 
> Today, I published the first patch for this issue which adds timeout based wait
> for completion event and also logs a warning message to alert the user/
> administrator of the problem.

Can't close just finish without waiting for userspace?
Then notify userspace about any buffers that did not complete ...


> As a next step, the idea is to implement a mechanism to allow vhost-vdpa module
> notify userspace app (QEMU) to close the fd corresponding to the vhost-vdpa
> character device when it is waiting for the completion event in
> vhost_vdpa_remove(). Jason confirmed this by saying that we need a new eventfd/
> ioctl to receive hot remove request from kernel.
> 
>  
> 
> Although, we can proceed to implement changes for the part described above but
> I feel that that the problem is much deeper than that. This mechanism will just
> request the userspace to close the fd and let vhost-vdpa proceed with the
> clean-up. However, IMHO things should be under more control of kernel space
> than the user space.
> 
>  
> 
> The problem I am trying to highlight is that a malicious user-space application
> can render any module registering a vDPA device to hang in their
> de-initialization sequence. This will typically surface when
> vdpa_device_unregister() is called from the function responsible for module
> unload leading rmmod commands to not return, forever.
> 
>  
> 
> To prove my point, I created a simple C program (test_vdpa.c) that opens the
> vhost-vdpa character device and never exits. The logs (test_logs.txt) show that
> after registering the vDPA device from sfc driver, vhost-vdpa module creates
> the char device /dev/vhost-vdpa-0  for it. As this is available to all apps in
> the userspace, the malicious app (./block_vdpa_unload) opens this device and
> goes to infinite sleep. At this time, when module unload (rmmod sfc) is called,
> it hangs and the following print informs the user/admin of this state with
> following message:
> 
> [ 8180.053647]  vhost-vdpa-0: vhost_vdpa_remove waiting for /dev/vhost-vdpa-0
> to be closed
> 
>  
> 
> Finally, when block_vdpa_unload is killed, vhost_vdpa_remove() unblocks and sfc
> module is unloaded.
> 
>  
> 
> With such application running in userspace, a kernel module (that registered
> corresponding vDPA device) will hang during unload sequence. Such control of
> the userspace application on the system resources should certainly be
> prevented.
> 
> To me, this seems to be a serious issue and requires modifications in the way
> it is currently handled in vhost-vdpa (and other modules (VFIO?) with similar
> implementation).
> 
> Let me know what you think.
> 
>  
> 
> Regards,
> 
> Gautam Dawar
> 

> #include <sys/stat.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <errno.h>
> 
> int main(int argc, char **argv)
> {
>    unsigned int index;
>    char dev_path[30];
>    int fd;
> 
>    if (argc != 2) {
> 	   printf("Usage: %s <vhost-vdpa device index>\n", argv[0]);
> 	   return -1;
>    }
> 
>    index = strtoul(argv[1], NULL, 10);
> 
>    snprintf(dev_path, sizeof(dev_path), "/dev/vhost-vdpa-%u", index);
>    fd = open(dev_path, O_RDWR);
>    if(fd < 0)
>    {
>        printf("Failed to open %s, errno: %d!\n", dev_path, errno);
>        return 1;
>    }
> 
>    printf("Blocking unload of driver that registered vDPA device"
> 	  " corresponding to cdev %s created by vhost-vdpa\n", dev_path);
>    while (1)
> 	   sleep(1);
> 
>    close(fd);
>    return 0;
> }

> [root@ndr730p ~]# ~/create_vdpa_device.sh
> 
> [root@ndr730p ~]# ll /dev/vhost-vdpa-0
> crw------- 1 root root 240, 0 Jun  6 19:59 /dev/vhost-vdpa-0
> 
> [root@ndr730p ~]# ./block_vdpa_unload 0 &
> [1] 10930
> Blocking unload of driver that registered vDPA device corresponding to cdev /dev/vhost-vdpa-0 created by vhost-vdpa
> 
> [root@ndr730p ~]# rmmod sfc
> [ 8179.010520] sfc_ef100 0000:06:00.4: ef100_vdpa_delete: Calling vdpa unregister device
> [ 8180.053647]  vhost-vdpa-0: vhost_vdpa_remove waiting for /dev/vhost-vdpa-0 to be closed
> 
> [root@ndr730p ~]# kill -9 10930
> [ 8218.392897] sfc_ef100 0000:06:00.0: shutdown successful
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
