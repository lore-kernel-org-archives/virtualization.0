Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A0EC7EE23
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 08:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 166064148B;
	Wed,  7 Jun 2023 08:48:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 166064148B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IuzNSaXw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGGg7vTz7lXG; Wed,  7 Jun 2023 08:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55CD54088A;
	Wed,  7 Jun 2023 08:48:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55CD54088A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E85CC007A;
	Wed,  7 Jun 2023 08:48:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE48BC0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 965E360FE0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:48:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 965E360FE0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IuzNSaXw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5J-VYJ29FDzm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8C4B60D89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8C4B60D89
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686127694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rfk+TW1VVpROfSAkMkf5abZ7iZ0acpkZ/A9xmZuaubA=;
 b=IuzNSaXwDHetRSkNp0T9wPKDnC6WW7e0M9h/cDetN5d7wnzk1bb6/yTV94fpJJZbE0HEaz
 Aefxj36YZxVm8kG50GKo9xkxmxJeEpO5yTUHf47i4vAJcCFfihctMNvWtCLqWePC+2W61M
 hWIxJAgtqY75y3StleJ6cWBjV2esrCg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-04Qv58ZuMR-VoLYRBPFeCA-1; Wed, 07 Jun 2023 04:48:13 -0400
X-MC-Unique: 04Qv58ZuMR-VoLYRBPFeCA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-977c516686aso441312466b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jun 2023 01:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686127692; x=1688719692;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rfk+TW1VVpROfSAkMkf5abZ7iZ0acpkZ/A9xmZuaubA=;
 b=hUEXNhjC9uano1HO3OBRh30RZ3BXU2KN6r9DY3Pq6n90hzWMfSGlOXBtvXuWgiELPt
 PT1wDTRTKFFTHCSKIx2ObzDV/OBUG8tVF9EjOnnh0K783QTW14QrN/7NZysaKXZp/zoC
 pNfyl0Lkvm/1RiAly11I8pNZwKPjrILm1Q13/FA/O8gtmHU1I9V7HCCWXFTcjoAMDCtw
 5nHiNLAcLABsBlW2WUjWJbdOPsDRzh/VQr3pkxiPXOeW5GcVTAXCrL2CQMaw110PuNwN
 qCDa8saey/mEMyP74zthqw0J5v1BGOuhV6EdD5xqcl866XiBey2Up0LNjsTv6cYwjRdM
 XbGg==
X-Gm-Message-State: AC+VfDwf7GHRXWYrVSPcT02VxgrLGYsw+pIrapzmQQwfibWqClg4d1aj
 5uDhPPA2X9VdxLAPLuvrXyedm1QUPRy8INpv7wSoLim6p58JJuVWd9CZnoW6/5KcRD/IADsrp/l
 q13/ivr4p0k/jZtiSxP0AnnoBNjwbQHZ4+6MvyV1HIg==
X-Received: by 2002:a17:907:a426:b0:94f:2852:1d2b with SMTP id
 sg38-20020a170907a42600b0094f28521d2bmr5174569ejc.72.1686127692241; 
 Wed, 07 Jun 2023 01:48:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nTPs5al3qFnY75IK7RFOavn30jPaEWSzE1dkS7RwaAlr6YCds7ytDrG1xB664g9uEA6wIRw==
X-Received: by 2002:a17:907:a426:b0:94f:2852:1d2b with SMTP id
 sg38-20020a170907a42600b0094f28521d2bmr5174560ejc.72.1686127691869; 
 Wed, 07 Jun 2023 01:48:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 bv26-20020a170906b1da00b0096f78953b77sm6686409ejb.147.2023.06.07.01.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 01:48:11 -0700 (PDT)
Date: Wed, 7 Jun 2023 10:48:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] vhost: Fix crash during early
 vhost_transport_send_pkt calls
Message-ID: <b6dq53u5774cgefej7azqmsq2jlhdr565adakqcubj4nn4vskz@jphq53j7z7wh>
References: <20230605185730.6560-1-michael.christie@oracle.com>
 <yocmdeykp2no67yaopvc3on6hqmwt2gavuhchxfl3appfsapg2@qhcor7x5e7mi>
 <efd1b26e-0286-e3a8-5343-3ff196788832@oracle.com>
MIME-Version: 1.0
In-Reply-To: <efd1b26e-0286-e3a8-5343-3ff196788832@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jun 06, 2023 at 12:19:10PM -0500, Mike Christie wrote:
>On 6/6/23 4:49 AM, Stefano Garzarella wrote:
>> On Mon, Jun 05, 2023 at 01:57:30PM -0500, Mike Christie wrote:
>>> If userspace does VHOST_VSOCK_SET_GUEST_CID before VHOST_SET_OWNER we
>>> can race where:
>>> 1. thread0 calls vhost_transport_send_pkt -> vhost_work_queue
>>> 2. thread1 does VHOST_SET_OWNER which calls vhost_worker_create.
>>> 3. vhost_worker_create will set the dev->worker pointer before setting
>>> the worker->vtsk pointer.
>>> 4. thread0's vhost_work_queue will see the dev->worker pointer is
>>> set and try to call vhost_task_wake using not yet set worker->vtsk
>>> pointer.
>>> 5. We then crash since vtsk is NULL.
>>>
>>> Before commit 6e890c5d5021 ("vhost: use vhost_tasks for worker
>>> threads"), we only had the worker pointer so we could just check it to
>>> see if VHOST_SET_OWNER has been done. After that commit we have the
>>> vhost_worker and vhost_task pointers, so we can now hit the bug above.
>>>
>>> This patch embeds the vhost_worker in the vhost_dev, so we can just
>>> check the worker.vtsk pointer to check if VHOST_SET_OWNER has been done
>>> like before.
>>>
>>> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>>
>> We should add:
>>
>> Reported-by: syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com
>
>
>Ok. Will do.
>
>
>>> -=A0=A0=A0 }
>>> +=A0=A0=A0 vtsk =3D vhost_task_create(vhost_worker, &dev->worker, name);
>>> +=A0=A0=A0 if (!vtsk)
>>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>>>
>>> -=A0=A0=A0 worker->vtsk =3D vtsk;
>>> +=A0=A0=A0 dev->worker.kcov_handle =3D kcov_common_handle();
>>> +=A0=A0=A0 dev->worker.vtsk =3D vtsk;
>>
>> vhost_work_queue() is called by vhost_transport_send_pkt() without
>> holding vhost_dev.mutex (like vhost_poll_queue() in several places).
>>
>> If vhost_work_queue() finds dev->worker.vtsk not NULL, how can we
>> be sure that for example `work_list` has been initialized?
>>
>> Maybe I'm overthinking since we didn't have this problem before or the
>> race is really short that it never happened.
>
>Yeah, I dropped the READ/WRITE_ONCE use because I didn't think we needed
>it for the vhost_vsock_start case, and for the case you mentioned above, I
>wondered the same thing as you but was not sure so I added the same
>behavior as before. When I read memory-barriers.txt, it sounds like we've
>been getting lucky.

Yep, it happened to me too before I highlighted it :-)

>
>I'll add back the READ/WRITE_ONCE for vtsk access since that's what we are
>keying off as signaling that the worker is ready to be used. I didn't see
>any type of perf hit when using it, and from the memory-barriers.txt doc
>it sounds like that's what we should be doing.
>

LGTM, I just wonder if RCU on dev->worker can save us from future
problems, but maybe better to do it in the next release.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
