Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282A8C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 07:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 905E9400D1;
	Thu, 10 Nov 2022 07:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 905E9400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RTJ6LM+W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfjIFUxelZ26; Thu, 10 Nov 2022 07:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8872400AF;
	Thu, 10 Nov 2022 07:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8872400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4A5DC0032;
	Thu, 10 Nov 2022 07:52:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3FCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28F6660AE5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28F6660AE5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RTJ6LM+W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pC3byIRmnZHG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DD146066D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD146066D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 07:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668066719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BukYDFp+3V0lSdmBo/7OCIgvVdGhW19qZEuq21xG+s=;
 b=RTJ6LM+Wan6UFbOpU5usF1CMsFFVUaIvUL20fSBlWslZJVpHLQm1Sql4XCbbXRXGfSok5F
 vP9o9fwhsJRg8y/CUxCeNkoZ8KHsAIiuOtQEC0jEDn2WHccxFAUHreeVHSQCMwtknLP7DY
 uD3RNLWVNgBaE3h9uNcahiCsUuVTtk0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-DOukUQhZNJOwIIqxk60NSw-1; Thu, 10 Nov 2022 02:51:57 -0500
X-MC-Unique: DOukUQhZNJOwIIqxk60NSw-1
Received: by mail-pf1-f198.google.com with SMTP id
 k131-20020a628489000000b0056b3e1a9629so661002pfd.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 23:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BukYDFp+3V0lSdmBo/7OCIgvVdGhW19qZEuq21xG+s=;
 b=AbH5RiByvLG+ePyQfoHgtXx97XATtfkFw3UfWzsqS7CU/b4n8Ay14ciaJmwzAqUb8y
 AxO9wuucUAS+zhhu3HvQH4Ll9NfLFLyU4GPUMUAX4p/MJbawpZcMQ+Z/4f3rNhpNRGXD
 NlmU5gU0NPANY/acBn9fXEknq6es6KrS0D2EHjuG+8cZtscgUNwO45dmv/leFW4kggoy
 Z2X29RQrR9uGDscwzhFt4ZV6Y0wFQs86gQ+1D63LaPjeeOnz3aGunMFrAevtCGEs6gEB
 W6SYjfJWjaRI42tOhlt91jBvy7eKlIH8AR6waa6pl+ZOe+dFNCy3LGAnrekCLlKQDoLy
 V+Fg==
X-Gm-Message-State: ACrzQf1AOzjTJ3rje5nIoUqi+LE08S3sz2eS4vdYf/yxsYnFlLIteK+/
 md3lrpKZMBksw9MSlPXda6Kr0RSp6M+X0DtknLiweO5cwlzHXzp5d52iIhmnp/jv17lMFUF+y66
 WffIddrfVO5cbeuIoY3ZcO30pfUS9bucq4oneJmltBQ==
X-Received: by 2002:a05:6a00:3017:b0:56c:d93a:ac5f with SMTP id
 ay23-20020a056a00301700b0056cd93aac5fmr2047778pfb.48.1668066716034; 
 Wed, 09 Nov 2022 23:51:56 -0800 (PST)
X-Google-Smtp-Source: AMsMyM62llp4+rX7BDLVjqGS33okh97ITleFTCr5eit2hngy1azqFGjBcv7rs8d1DCZ+cEAoJNFZhw==
X-Received: by 2002:a05:6a00:3017:b0:56c:d93a:ac5f with SMTP id
 ay23-20020a056a00301700b0056cd93aac5fmr2047760pfb.48.1668066715600; 
 Wed, 09 Nov 2022 23:51:55 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 d10-20020a17090a628a00b0020669c8bd87sm2444283pjj.36.2022.11.09.23.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 23:51:55 -0800 (PST)
Date: Thu, 10 Nov 2022 08:51:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: fix potential memory leak during the release
Message-ID: <20221110075142.f6yr7wagqa33rjjn@sgarzare-redhat>
References: <20221109154213.146789-1-sgarzare@redhat.com>
 <20221109124430-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221109124430-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

On Wed, Nov 09, 2022 at 12:47:19PM -0500, Michael S. Tsirkin wrote:
>On Wed, Nov 09, 2022 at 04:42:13PM +0100, Stefano Garzarella wrote:
>> Before commit 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
>> we call vhost_vdpa_iotlb_unmap(v, iotlb, 0ULL, 0ULL - 1) during the
>> release to free all the resources allocated when processing user IOTLB
>> messages through vhost_vdpa_process_iotlb_update().
>> That commit changed the handling of IOTLB a bit, and we accidentally
>> removed some code called during the release.
>>
>> We partially fixed with commit 037d4305569a ("vhost-vdpa: call
>> vhost_vdpa_cleanup during the release") but a potential memory leak is
>> still there as showed by kmemleak if the application does not send
>> VHOST_IOTLB_INVALIDATE or crashes:
>>
>>   unreferenced object 0xffff888007fbaa30 (size 16):
>>     comm "blkio-bench", pid 914, jiffies 4294993521 (age 885.500s)
>>     hex dump (first 16 bytes):
>>       40 73 41 07 80 88 ff ff 00 00 00 00 00 00 00 00  @sA.............
>>     backtrace:
>>       [<0000000087736d2a>] kmem_cache_alloc_trace+0x142/0x1c0
>>       [<0000000060740f50>] vhost_vdpa_process_iotlb_msg+0x68c/0x901 [vhost_vdpa]
>>       [<0000000083e8e205>] vhost_chr_write_iter+0xc0/0x4a0 [vhost]
>>       [<000000008f2f414a>] vhost_vdpa_chr_write_iter+0x18/0x20 [vhost_vdpa]
>>       [<00000000de1cd4a0>] vfs_write+0x216/0x4b0
>>       [<00000000a2850200>] ksys_write+0x71/0xf0
>>       [<00000000de8e720b>] __x64_sys_write+0x19/0x20
>>       [<0000000018b12cbb>] do_syscall_64+0x3f/0x90
>>       [<00000000986ec465>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Let's fix calling vhost_vdpa_iotlb_unmap() on the whole range in
>> vhost_vdpa_remove_as(). We move that call before vhost_dev_cleanup()
>> since we need a valid v->vdev.mm in vhost_vdpa_pa_unmap().
>> vhost_iotlb_reset() call can be removed, since vhost_vdpa_iotlb_unmap()
>> on the whole range removes all the entries.
>>
>> The kmemleak log reported was observed with a vDPA device that has `use_va`
>> set to true (e.g. VDUSE). This patch has been tested with both types of
>> devices.
>>
>> Fixes: 037d4305569a ("vhost-vdpa: call vhost_vdpa_cleanup during the release")
>> Fixes: 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>It's fine, just pls don't say "potential" here in the subject, let's
>avoid pleonasms

Got it, I'll avoid in the future.

>- it's a memory leak, yes it triggers under some coditions
>but little is unconditional in this world :)

Nothing could be more true :-)

>
>No need to repost.
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
