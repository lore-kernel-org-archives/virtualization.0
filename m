Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23B3C07E9D
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B4FB61112;
	Thu, 29 Sep 2022 07:45:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B4FB61112
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CkilKVF2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Awz6kupaBKcL; Thu, 29 Sep 2022 07:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 982ED60B5C;
	Thu, 29 Sep 2022 07:45:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 982ED60B5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79906C0033;
	Thu, 29 Sep 2022 07:45:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09C1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D15FD83EE1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D15FD83EE1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CkilKVF2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5he1k5lWWqQh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:45:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F6C183EDD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F6C183EDD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664437535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zWJsAExGybprfQynqdKMBRlg2doVn4b4qt5YmimPnR4=;
 b=CkilKVF2HW6dUTyYjqc8DSVFLbCs3jXHEPCvgnu/ZTkoUEn2n+gKtBcDOOVBngHR5tyh2B
 69V90A+/dqMNT4j1lKyibkutKn/59p6kLl68pT9jXPDjxzZ4HIFXE+pXghoU51HZjxKY5z
 d5b6KSiVwvQ2RZlupJ8z5GFpKb/04cg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-382-tCysT89FNG-fSM2f4kiqBA-1; Thu, 29 Sep 2022 03:45:34 -0400
X-MC-Unique: tCysT89FNG-fSM2f4kiqBA-1
Received: by mail-wr1-f69.google.com with SMTP id
 i1-20020adfa501000000b0022cd1e1137bso198484wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=zWJsAExGybprfQynqdKMBRlg2doVn4b4qt5YmimPnR4=;
 b=XgDIwG9Q2IT4tKXb/nnYkjG6FVY6xgV7zrmqx2PaDCNskUKHdkSxhLrLhc8i7jGChr
 IQbaTqL3whCck+4sAnhQe0yNHevIZuT+aH4M9JrYhWgH7e4xxslnFQKCX7dA4G18fjGa
 Q7OUP/1cDZzaXZtcw0FCvc8aj+ESyhbYX5X9mMi8zgGwIdPKPi5KI6YO93smhlKvolPC
 J8vAFGf0CxTYM6nkqBzHe6PvXvWUR3JXedMFeUxDzsYFCJXNEHTwvMHrx1LPB9rq0aKg
 4vKUuN5m2I9bxZBoqpFnARPCWO8C4GEyFKLhw2UQv6l3p+5LQF4IQciJh2cOtExxeEGR
 T75A==
X-Gm-Message-State: ACrzQf3J8bwJf1JmHjct8FCkO/041G2mV3xRZurgqkZ9LBT0Eyv+seKB
 LhOSsN+CdIQ5QYByEKMN6ZrrCCbjZqOfwGN9n76F5PTfjJhplgsTvfKCNNhOZpWQMdduf05Lxxg
 IWfh+mp9UvCyW0dZH1kJe58T042Vzp9/hF6CAmxRcww==
X-Received: by 2002:a05:600c:1d25:b0:3b4:92de:fb28 with SMTP id
 l37-20020a05600c1d2500b003b492defb28mr1250845wms.202.1664437533525; 
 Thu, 29 Sep 2022 00:45:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7//5174xIAzSBNj4+/G3/jgYEv0dMBZb93dtFXpdguZzKULQ8pnrSgT+aUJPEn+0uu9lSIBg==
X-Received: by 2002:a05:600c:1d25:b0:3b4:92de:fb28 with SMTP id
 l37-20020a05600c1d2500b003b492defb28mr1250833wms.202.1664437533265; 
 Thu, 29 Sep 2022 00:45:33 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 k1-20020a5d5181000000b00228da845d4dsm5970119wrv.94.2022.09.29.00.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:45:32 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:45:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
Message-ID: <20220929033858-mutt-send-email-mst@kernel.org>
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
 <20220928091512-mutt-send-email-mst@kernel.org>
 <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
 <20220929032021-mutt-send-email-mst@kernel.org>
 <CAJs=3_AgfyZkWhwK3pycSs49=k-q+9mpD3pyjG0us+ke60RqmQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_AgfyZkWhwK3pycSs49=k-q+9mpD3pyjG0us+ke60RqmQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Thu, Sep 29, 2022 at 10:29:09AM +0300, Alvaro Karsz wrote:
> > OK so virtio_blk_config->max_discard_seg is unused without
> > VIRTIO_BLK_F_DISCARD.
> 
> 
> Yes, if I understood the spec correctly,
> virtio_blk_config->max_discard_seg is relevant if VIRTIO_BLK_F_DISCARD
> is negotiated, and virtio_blk_config->max_secure_erase_seg is relevant
> if VIRTIO_BLK_F_SECURE_ERASE is negotiated.
> 
> What should I do?
> Should I fix the patch?

I don't know. You guys are storage experts I'm a virtio guy.
And from virtio POV I have a question about this code:

+               virtio_cread(vdev, struct virtio_blk_config,
+                            secure_erase_sector_alignment, &v);
+
+               /* secure_erase_sector_alignment should not be zero, the device should set a
+                * valid number of sectors.
+                */
+               if (!v) {
+                       dev_err(&vdev->dev,
+                               "virtio_blk: secure_erase_sector_alignment can't be 0\n");
+                       err = -EINVAL;
+                       goto out_cleanup_disk;
+               }

So this will prevent us from ever exposing a device
with secure_erase_sector_alignment set to 0.
Same for max_secure_erase_sectors and max_secure_erase_seg.
What can the value 0 mean here? I don't know, maybe "get actual
value from some other place".


An alternative is to put this code in a validate
callback and clear VIRTIO_BLK_F_SECURE_ERASE.

However, this means that even if host exposes VIRTIO_BLK_F_SECURE_ERASE
the host can not be sure guest will use secure erase.
Is this or can be a security problem?
If yes let's be strict and fail probe as current code does.
If not let's be flexible and ensure forward compatibility.



-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
