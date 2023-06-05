Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B88BC7EE24
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 08:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 827E660DE5;
	Mon,  5 Jun 2023 08:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 827E660DE5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h78vZjrb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Q0vXqJLnkFN; Mon,  5 Jun 2023 08:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12A8E60C03;
	Mon,  5 Jun 2023 08:17:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12A8E60C03
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA07EC007A;
	Mon,  5 Jun 2023 08:17:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39788C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 007414051F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:17:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 007414051F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h78vZjrb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0w0C4X-5ge06
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:17:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C563403AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C563403AA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685953049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WTa5uBKoWlBL4OKjdUilTsvXazsAa+Thz3GpkiKSHlc=;
 b=h78vZjrbp73JZ7i7PMLEGd8dv1DXCjwkbcRGBDhmAqeNTLlefPdxpQhRYr2jynw60dUKSo
 +o0Mbj3xAFChSxzd4OPQ/G1zUMT1HGhA1ZLA1LZyNRb5ARDrdpOJsYwWwKEWFzqQknxc/D
 zpCJJ7RVRU3sgI7v4qr/VMRsfuDydpY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-HvvlMbXRPZWUttHCn5kVXg-1; Mon, 05 Jun 2023 04:17:28 -0400
X-MC-Unique: HvvlMbXRPZWUttHCn5kVXg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f7f713eeb0so71380661cf.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 01:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685953048; x=1688545048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTa5uBKoWlBL4OKjdUilTsvXazsAa+Thz3GpkiKSHlc=;
 b=HJ45Tq37bQ1NTLiQKAT9FAL8gL4oUQy+Vb+J0jiwzDxDzGxICy7Fjbs2O6csy5lWdW
 uvqKtMWDJ/9QniEEMIJv+9Rr/O9uXqawLp/+vDEYs9sZdnslXvjx9qQYecaZMziw2mDw
 Ch44dYWKLZqd8ho8bDSgx7pXmdadX55n/C0q8YdozdHwX8BNo9zaXDyqDIYWdYsOY6/i
 AQ+1romVIw3pmR7lMpJ6HgpF8F19WmLwCp54PTWfsGkfXITkI+7AwI4Xcpq/BbkpOJOF
 z5rWrFLgLStvj32dEQ18U8f/FORH5wQSn5JIAAK5WLe7WzIzZDqjr378OheE+DD0JDa6
 Y9pA==
X-Gm-Message-State: AC+VfDwcb0i28DYG8tuommnSJ68qgm+0M8W/1A5MC8Z6YkC9q0/NAd+W
 M2QfI9w1I2k2xVeFojXI3gbMmdrG5WovaGMV7yn+pzc/UMfdX7yUeNMeMIBmMFeAssT+fJjpZ2m
 m+NiKm3xGBrFlTDtRYS38OjEcZY6YCeoL4KBm6upvJw==
X-Received: by 2002:ad4:5dc6:0:b0:625:aa49:c345 with SMTP id
 m6-20020ad45dc6000000b00625aa49c345mr5626878qvh.57.1685953048213; 
 Mon, 05 Jun 2023 01:17:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ck6zccCkV6ZHcKm+GbVvGixKzHQxHzfmaEMOom+EzRulvwz867ReHd8wvmYTqyz8Sgzr03Q==
X-Received: by 2002:ad4:5dc6:0:b0:625:aa49:c345 with SMTP id
 m6-20020ad45dc6000000b00625aa49c345mr5626870qvh.57.1685953047990; 
 Mon, 05 Jun 2023 01:17:27 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 bu17-20020ad455f1000000b00623819de804sm4410683qvb.127.2023.06.05.01.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:17:27 -0700 (PDT)
Date: Mon, 5 Jun 2023 10:17:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Message-ID: <z52qxx5mhw7pzgvafn6qgxpwz4dt2l7aetfqtkjf2qql7npnan@tpo3cvbcwnjj>
References: <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
 <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
 <20230602073559-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230602073559-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, drivers@pensando.io
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

On Fri, Jun 02, 2023 at 07:36:26AM -0400, Michael S. Tsirkin wrote:
>On Thu, May 18, 2023 at 09:34:25AM +0200, Stefano Garzarella wrote:
>> I think we should do one of these things, though:
>> - mask VIRTIO_F_RING_PACKED in the stable kernels when
>> VHOST_GET_FEAETURES is called
>> - backport this patch on all stable kernels that support vhost-vdpa
>>
>> Maybe the last one makes more sense.
>>
>> Thanks,
>> Stefano
>
>OK which patches do you want to go to stable exactly?

Initially I was thinking this entire series, but I think it's too
risky, so on second thoughtwhat do you think about this:

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8c1aefc865f0..ac2152135b23 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)

         features = ops->get_device_features(vdpa);

+       /*
+        * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
+        * packed virtqueue well yet, so let's filter the feature for now.
+        */
+       features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
+
         if (copy_to_user(featurep, &features, sizeof(features)))
                 return -EFAULT;

I can send the patch ASAP and we can apply it before this series.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
