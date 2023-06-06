Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFF1C77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 19:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08694612DC;
	Tue,  6 Jun 2023 19:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08694612DC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W+uinIdU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krZ8arINIZme; Tue,  6 Jun 2023 19:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E816612CE;
	Tue,  6 Jun 2023 19:22:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E816612CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55DA3C0037;
	Tue,  6 Jun 2023 19:22:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2642C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85B16417C1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:22:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85B16417C1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W+uinIdU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y_2eyERa02Y4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:22:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B93AC400FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B93AC400FC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686079339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUiR8R2yhnCA8XHZqBvAU05l0nORi9hAzto5VZrSZRg=;
 b=W+uinIdUPS1ryIyQVMyow1Y22khvuv492PsqMQwsnHCfJpT9OC/94VEpYIS/qFQXE1BWd6
 Tr146c2ZZUPYMqcJ51MM4JStqy+PssD0vDFOoeXBjuc6uW2t7peHl4uJc2qdqwuPJWGhK5
 P/Wkx9srDm4g5OwvEXln90G+Z22Ul1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-9vVSkk50OA6R_rxuUb5m9A-1; Tue, 06 Jun 2023 15:22:18 -0400
X-MC-Unique: 9vVSkk50OA6R_rxuUb5m9A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso1297048f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 12:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686079337; x=1688671337;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUiR8R2yhnCA8XHZqBvAU05l0nORi9hAzto5VZrSZRg=;
 b=j6ZHtshSqcdrtGMxs8Iau2BQ7PgShZJnBKF6iay5ZElAa8heQXHWqWURY2AuYIy+ja
 7z1b7nRBba7fH150C+iryxK/ReBkgv6aEnF/GZPwZT8wdHWtt3vggYcRhuQ/Ksi5u+eA
 LtJHakub31ZDXo6ACtO8iITVdwk/dv+442OzH2Dn6khvy8Fy1GNlsoBeyxj0VZ+56wYD
 4dAiFduD3xoYI6oLB6ikhnrYm1mKsANFgaW1e0EdUZ0Svqb0+M56mWPXpd1IwDlt/Rbi
 +0cXeg6l3wfH22l0opTSMJz470Z3zY/a1bGE9SqQBUECfBPIL1jG0DwJATQJZpb7xZ4E
 SAcg==
X-Gm-Message-State: AC+VfDx9qSkQW2vXzO19KeFXvopDw6Dvz3wNePW6fKPqNpzLT2NZ9sui
 1s7IcP7bZAIzl8827TC39+P3NNxzhmTE66gvi1N8XUax94/inhCTlruDMyIo9k3QSBIdQvGiWsa
 eikDnJC7fn1aH++MdVu1VF0I+8XemcPhd6hzxTEv+4g==
X-Received: by 2002:adf:ea0a:0:b0:30e:52de:9ccf with SMTP id
 q10-20020adfea0a000000b0030e52de9ccfmr1561622wrm.68.1686079337043; 
 Tue, 06 Jun 2023 12:22:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bu6dy1FLDImrg2san5tdn0REqfqJKg/m5GktKOLZqyduyXaMDhCxkD8M78JpMnroJ0tXCfw==
X-Received: by 2002:adf:ea0a:0:b0:30e:52de:9ccf with SMTP id
 q10-20020adfea0a000000b0030e52de9ccfmr1561603wrm.68.1686079336698; 
 Tue, 06 Jun 2023 12:22:16 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 k16-20020a056000005000b003079986fd71sm13488602wrx.88.2023.06.06.12.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 12:22:16 -0700 (PDT)
Date: Tue, 6 Jun 2023 15:22:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] vhost: Fix crash during early
 vhost_transport_send_pkt calls
Message-ID: <20230606152033-mutt-send-email-mst@kernel.org>
References: <20230605185730.6560-1-michael.christie@oracle.com>
 <yocmdeykp2no67yaopvc3on6hqmwt2gavuhchxfl3appfsapg2@qhcor7x5e7mi>
 <efd1b26e-0286-e3a8-5343-3ff196788832@oracle.com>
MIME-Version: 1.0
In-Reply-To: <efd1b26e-0286-e3a8-5343-3ff196788832@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jun 06, 2023 at 12:19:10PM -0500, Mike Christie wrote:
> On 6/6/23 4:49 AM, Stefano Garzarella wrote:
> > On Mon, Jun 05, 2023 at 01:57:30PM -0500, Mike Christie wrote:
> >> If userspace does VHOST_VSOCK_SET_GUEST_CID before VHOST_SET_OWNER we
> >> can race where:
> >> 1. thread0 calls vhost_transport_send_pkt -> vhost_work_queue
> >> 2. thread1 does VHOST_SET_OWNER which calls vhost_worker_create.
> >> 3. vhost_worker_create will set the dev->worker pointer before setting
> >> the worker->vtsk pointer.
> >> 4. thread0's vhost_work_queue will see the dev->worker pointer is
> >> set and try to call vhost_task_wake using not yet set worker->vtsk
> >> pointer.
> >> 5. We then crash since vtsk is NULL.
> >>
> >> Before commit 6e890c5d5021 ("vhost: use vhost_tasks for worker
> >> threads"), we only had the worker pointer so we could just check it to
> >> see if VHOST_SET_OWNER has been done. After that commit we have the
> >> vhost_worker and vhost_task pointers, so we can now hit the bug above.
> >>
> >> This patch embeds the vhost_worker in the vhost_dev, so we can just
> >> check the worker.vtsk pointer to check if VHOST_SET_OWNER has been done
> >> like before.
> >>
> >> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > =

> > We should add:
> > =

> > Reported-by: syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com
> =

> =

> Ok. Will do.
> =

> =

> >> -=A0=A0=A0 }
> >> +=A0=A0=A0 vtsk =3D vhost_task_create(vhost_worker, &dev->worker, name=
);
> >> +=A0=A0=A0 if (!vtsk)
> >> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
> >>
> >> -=A0=A0=A0 worker->vtsk =3D vtsk;
> >> +=A0=A0=A0 dev->worker.kcov_handle =3D kcov_common_handle();
> >> +=A0=A0=A0 dev->worker.vtsk =3D vtsk;
> > =

> > vhost_work_queue() is called by vhost_transport_send_pkt() without
> > holding vhost_dev.mutex (like vhost_poll_queue() in several places).
> > =

> > If vhost_work_queue() finds dev->worker.vtsk not NULL, how can we
> > be sure that for example `work_list` has been initialized?
> > =

> > Maybe I'm overthinking since we didn't have this problem before or the
> > race is really short that it never happened.
> =

> Yeah, I dropped the READ/WRITE_ONCE use because I didn't think we needed
> it for the vhost_vsock_start case, and for the case you mentioned above, I
> wondered the same thing as you but was not sure so I added the same
> behavior as before. When I read memory-barriers.txt, it sounds like we've
> been getting lucky.

Yea READ/WRITE_ONCE is one of these things. Once you start adding
them it's hard to stop, you begin to think it's needed everywhere.
To actually know you need a language lawyer (READ/WRITE_ONCE
is a compiler thing not a CPU thing).

> I'll add back the READ/WRITE_ONCE for vtsk access since that's what we are
> keying off as signaling that the worker is ready to be used. I didn't see
> any type of perf hit when using it, and from the memory-barriers.txt doc
> it sounds like that's what we should be doing.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
