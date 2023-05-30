Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E19DC77B7A
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 16:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F84A60BFE;
	Tue, 30 May 2023 16:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F84A60BFE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dvgYvcBL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f00fSRnztAux; Tue, 30 May 2023 16:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 702BF60ADC;
	Tue, 30 May 2023 16:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 702BF60ADC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 519C8C0037;
	Tue, 30 May 2023 16:17:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89FF9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FB8141795
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FB8141795
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dvgYvcBL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNYrqV7BMApT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A849B400C5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A849B400C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685463431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PXXxKnRvMOF+CPjYfKEygZupqtBPL6uEzDsFClnEJ3U=;
 b=dvgYvcBLbTGFSyjk5z8hb7BwSPwXD2ZtVHYQDxemzQLVmu/GLve97kyR63B1uYprT9SEaS
 ZsyoTm/JZfKFYjAD3Q8Dtrddp2TjzjOIyeWGbZIGwk3sMl6PUmgApQsBZ2DyIWte9OFNDQ
 a8q7caySfQNfn1hpokUJAFFns/DJk2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-NfsMd6ODP_KxSz4ssbpUDw-1; Tue, 30 May 2023 12:17:07 -0400
X-MC-Unique: NfsMd6ODP_KxSz4ssbpUDw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6fa001cedso14136735e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 09:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685463426; x=1688055426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXXxKnRvMOF+CPjYfKEygZupqtBPL6uEzDsFClnEJ3U=;
 b=G5WbVvkrxyCEy876EhsLpb5UBDOD3je3ss+UCeDRb5Oxq5CkkpRc+bOp+P1wVSl/Z6
 mgZSwh5NbgHiSPg9kWYXZG684DblRCIfoKyyXGdR3kPHbDYaqpoaSTNZL0oAKJsC2MIA
 ppWlqkX95sXYUUQAeGIcg3KH9ANm51jCCexNRAAhHg5aeSLcSZSiyiiUf76HgiLgnE0i
 h0FSnqkisHIylYx5wmE7jilwofAwdtOi2qP1LGHMTmIezj3fl44n8FmA11bz65te8YWD
 JuhS18Sqx7X98dhhDsHRjXuR2qFtfhBfnMnnpXl8zG6JyKnrHIKNu09immyPZgVY1e+G
 5W6Q==
X-Gm-Message-State: AC+VfDwrCjWGs1V98t94/pVMXAlWMsxeYpvP1fosGcbLe7bBn0gSL9To
 JerBhZ6VFgvm6yesXnr1TzV7zlNXXRdotHkocWv8i6k009el+aL1t0khQQBysYBIfbZUnHi3+9x
 KAVdsg3QkaEy3hPRnNyQAGXvCG2DMZ9ls1qBzxY6UPw==
X-Received: by 2002:a05:600c:3787:b0:3f6:1e6:d5a2 with SMTP id
 o7-20020a05600c378700b003f601e6d5a2mr1912247wmr.4.1685463426375; 
 Tue, 30 May 2023 09:17:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JJkBsRON0rkAHj+JwffsCltg3bPYMz+mQckZWzt5fCsTTE3DG9uwIij60afTolUjor/lsmQ==
X-Received: by 2002:a05:600c:3787:b0:3f6:1e6:d5a2 with SMTP id
 o7-20020a05600c378700b003f601e6d5a2mr1912237wmr.4.1685463426114; 
 Tue, 30 May 2023 09:17:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003f42ceb3bf4sm17673875wml.32.2023.05.30.09.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 09:17:05 -0700 (PDT)
Date: Tue, 30 May 2023 18:17:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Message-ID: <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
References: <0000000000001777f605fce42c5f@google.com>
 <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, May 30, 2023 at 11:09:09AM -0500, Mike Christie wrote:
>On 5/30/23 11:00 AM, Stefano Garzarella wrote:
>> I think it is partially related to commit 6e890c5d5021 ("vhost: use
>> vhost_tasks for worker threads") and commit 1a5f8090c6de ("vhost: move
>> worker thread fields to new struct"). Maybe that commits just
>> highlighted the issue and it was already existing.
>
>See my mail about the crash. Agree with your analysis about worker->vtsk
>not being set yet. It's a bug from my commit where I should have not set
>it so early or I should be checking for
>
>if (dev->worker && worker->vtsk)
>
>instead of
>
>if (dev->worker)

Yes, though, in my opinion the problem may persist depending on how the
instructions are reordered.

Should we protect dev->worker() with an RCU to be safe?

>
>One question about the behavior before my commit though and what we want in
>the end going forward. Before that patch we would just drop work if
>vhost_work_queue was called before VHOST_SET_OWNER. Was that correct/expected?

I think so, since we ask the guest to call VHOST_SET_OWNER, before any
other command.

>
>The call to vhost_work_queue in vhost_vsock_start was only seeing the
>works queued after VHOST_SET_OWNER. Did you want works queued before that?
>

Yes, for example if an application in the host has tried to connect and
is waiting for a timeout, we already have work queued up to flush as
soon as we start the device. (See commit 0b841030625c ("vhost: vsock:
kick send_pkt worker once device is started")).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
