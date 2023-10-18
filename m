Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04683CDB483
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 13:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 710CE41B95;
	Wed, 18 Oct 2023 13:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 710CE41B95
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGenaonJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqWrP9JUU3x9; Wed, 18 Oct 2023 13:31:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 907A041B5D;
	Wed, 18 Oct 2023 13:31:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 907A041B5D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 745D4C0039;
	Wed, 18 Oct 2023 13:31:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 385E6C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 13:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11F734057F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 13:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11F734057F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGenaonJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0SLTv6TgUYQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 13:31:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76B4740220
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 13:31:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76B4740220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697635859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEXGwMCG6NmoQSfVuziNVwS9xQqZtdPUm0GnfFJdAXE=;
 b=NGenaonJkAraq6zAnGaDgATwSyyyVv34Z1YYDa+TZHUbzr1UcqiZ+OVYlzjwvycN2QaF6t
 eVYPJndzr44xKmZxugup6TQZzeuRfkddih9C9gn5aEP7lQ79MDP6f+lXePMNKJ/1JpfOrU
 Vd4TacAK7643+DuNVokOMvUsCV/WMzc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-6udq_9LYOvS6epgHppcxfQ-1; Wed, 18 Oct 2023 09:30:57 -0400
X-MC-Unique: 6udq_9LYOvS6epgHppcxfQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-775d995f92aso884547785a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 06:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635857; x=1698240657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEXGwMCG6NmoQSfVuziNVwS9xQqZtdPUm0GnfFJdAXE=;
 b=Bk6KXM4W2fz0srICMDKKcWZhyJ8MQxWiH8e8VAyOlPgBcK8/WXOnHDfPXzzsVgbPbu
 /tiR8/xCqyuYRD+7HH15uqb+17lWe+C7rf58Po6qxUeb/Xi1SeehQdyh4nurxMZklLMq
 Q4Zs+JZKUWpuMFH3qg+eQGK/+lKf7qTu55q+ZHD8xUliaCjwe3Hwoe6arJcLExUja3oU
 GPimS2an+oJQUmiQoEg/f4b5H7zUdhyrVOmuO+17pmpOQdBPL22NKuYeZzclKAhHueJh
 GJoJv4vwkv2qrwAwHqawgdD8+CqDlyhYTYzapoKFqc88pRBohfJ1//+cDOCldNdpY3Pe
 I9ZQ==
X-Gm-Message-State: AOJu0YxbVhzcCq+mPnPxp8hqVCUZB+kOeb0++O9bWTKah+RbKOjeCFPO
 gXiWYRKbmSmmGRr7aQkXbLLqubeIx+9M+lPYldUnnCoCyNvLFbnO7QztbGznJdWUEqsohiZD/3N
 TTbjTD68hjFOqFeC+yZwJvH0As6HCEBg0h7YxdPOeAA==
X-Received: by 2002:a05:620a:370f:b0:772:64bb:441e with SMTP id
 de15-20020a05620a370f00b0077264bb441emr6272095qkb.36.1697635856806; 
 Wed, 18 Oct 2023 06:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNVeWDmRPz+YvnvmaBsLxz6uYHRhB8ieHrkfALvgnYyPg30Bws8YCVi6m+vxuhCvx3UbO0og==
X-Received: by 2002:a05:620a:370f:b0:772:64bb:441e with SMTP id
 de15-20020a05620a370f00b0077264bb441emr6272060qkb.36.1697635856370; 
 Wed, 18 Oct 2023 06:30:56 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 t27-20020a05620a035b00b0076cda7eab11sm1459228qkm.133.2023.10.18.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:30:56 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:30:52 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [virtio-comment] Re: virtio-sound: release control request
 clarification
Message-ID: <ZS/eDMsOCSatnX90@fedora>
References: <ZS6mA6/EsmvDVlTC@fedora>
 <1a54feab-5de9-4b39-a4ce-7ff22e23cf52@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <1a54feab-5de9-4b39-a4ce-7ff22e23cf52@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

Hello Anton,

thanks for the response. I added some inline comments.

On Wed, Oct 18, 2023 at 10:06:05AM +0900, Anton Yakovlev wrote:
> Hi Matias,
> 
> 
> On 18.10.2023 00:19, Matias Ezequiel Vara Larsen wrote:
> > Hello,
> > 
> > This email is to clarify the VirtIO specification regarding the RELEASE
> > control request. Section 5.14.6.6.5.1 [1] states the following device
> > requirements for the RELEASE control request:
> > 1. The device MUST complete all pending I/O messages for the specified
> > stream ID.
> > 2. The device MUST NOT complete the control request while there are
> > pending I/O messages for the specified stream ID.
> > 
> > The 1) requirement does not indicate what "complete" means. Does it mean
> > that the pending I/O messages in the tx queue shall be outputted in the
> > host, i.e., consumed by the audio backend? Or, completion means simply
> > to put the requests in the used-ring without consuming them?
> 
> Here "to complete" means moving the buffers to the used list in vring.
> Technically, the specification only requires that the device "return" all
> referenced DMA memory to the guest before completing the RELEASE control
> request. What the device actually does with these I/O messages is
> implementation dependent and is not within the scope of the specification.
> Thus...
> 
> 

Thank you, I got it. If I correctly understand you, after RELEASE is
issued, the specs specify only that the device should "return" all
buffers or "complete" them. Device implementations MAY or MAY NOT
playback them. In other words, the specification does not specify if
consumption should occur. I had interpreted this to mean that the guest
intended to output those buffers, leaving the device implementation with
no option but to do so.

> > Regarding 2), I interpret it as "the device shall wait until all I/O
> > messages are proceeded to complete the RELEASE control request".
> 
> ...you can do this way if you really need to.
> 
> 
> > Currently, the kernel driver seems not expecting such a delay when the
> > RELEASE command is sent. If I understand correctly, the kernel driver
> > first sends the RELEASE command and waits a fixed amount of time until
> > the device can process it. Then, the driver waits a fixed amount of time
> > until all pending IO messages are completed. If the device follows the
> > specification and waits until all messages IO are completed to issue the
> > completion of the RELEASE command, the kernel driver may timeout. The
> > time to complete N IO messages in the TX queue could be proportional
> > with the number of pending messages.
> 
> The default timeout for control requests in the ALSA driver is 1 second. In
> theory, this time should be enough to completely reproduce/fill the 500ms
> buffer, and complete all requests, including the RELEASE control request. If
> the device fails to do this, then most likely there are some problems with the
> implementation.
> 

Thanks for clarifying. Sorry to repeat myself, the point I want to make
is that the virtsnd_pcm_sync_stop() function that sends the RELEASE
control request uses virtsnd_ctl_msg_send_sync(). Message timeouts are
set up by the "msg_timeout_ms" module parameter. The timeout is the same
as for other control requests, such as SET_PARAM and PREPARE, but these
commands do not require flushing a queue, so I wondered how the timeout
could be the same.

> 
> > In our device implementation [2], RELEASE is handled as follows:
> > - Drop all messages in the TX queue without outputting in the host.
> > - Complete the RELEASE control request.
> > 
> > This seems to be working, however, I can observe that sometimes there
> > are still requests in the TX queue when we get RELEASE. Those requests
> > are never reproduced in the host.
> > 
> > My questions are:
> > - In the specification, should we modify it to clarify that all pending
> >    IO messages in the device are discarded during RELEASE, that is, not
> >    output to the host, but signaled to the guest as completed?
> 
> No, we shouldn't. See comment above.
> 
> 
> > - According to the specification, should the driver wait in RELEASE an
> >    amount of time proportional to the number of periods yet to be
> >    reproduced?
> 
> This is purely a matter of driver implementation. It is possible to implement
> the driver without timeouts, but this would be a bad idea. Because bugs in the
> device could lead to an infinite wait in the kernel.
> 
> 

I agree, thanks.

Matias.

> Best regards,
> 
> > 
> > Thanks, Matias.
> > 
> > [1]
> > https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.2%2fcsd01%2fvirtio%2dv1.2%2dcsd01.html&umid=31e1136e-6322-4698-9f1d-d631ac36403e&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-586f0596c89224a3bc9e20df81eaea8933bb129a
> > [2]
> > https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-sound
> 
> -- 
> Anton Yakovlev
> Senior Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
