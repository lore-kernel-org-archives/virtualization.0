Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E6DC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 01:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECA144010E;
	Thu,  9 Dec 2021 01:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjv0_j7T7sVo; Thu,  9 Dec 2021 01:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 411A14027F;
	Thu,  9 Dec 2021 01:36:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11D03C002F;
	Thu,  9 Dec 2021 01:36:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFA2C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DAAC6069D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:36:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPyc5frjKSU5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:36:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E174560657
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639013774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XJW80026i/GBZ5oyPV2ba4rxjEezQs1xWLlg3r0O+70=;
 b=hDvZj1etrF7qvFvG3kzmUnkR4HWGd7Z0CFMqSAxRx3suhXuY5aNSL3NtyKTgAeX7d/OvJp
 R81OKteReeDxpxLITAk6Omuu77cBsfTonGKYV5ocOzDAbKnPqCvFyIZndMNjioavHs1JE5
 lOFIeMzhC+HCH+HbYHSk9ngH68qP324=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-n9y4EEyxOJq323cAvnpwLw-1; Wed, 08 Dec 2021 20:36:10 -0500
X-MC-Unique: n9y4EEyxOJq323cAvnpwLw-1
Received: by mail-lf1-f71.google.com with SMTP id
 i6-20020a0565123e0600b00417d29eede4so1906051lfv.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 17:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XJW80026i/GBZ5oyPV2ba4rxjEezQs1xWLlg3r0O+70=;
 b=Qg4jocqmG4po09c4PDtJ9Ikg1I15rKC6l6NuSy69KVttKPxVX+xCvMgw4O9HvLlxpB
 ieXZ6Wyv711YI/2ZbWikHUyzDdBAEixhaw18U/BEvKLTdpUuQ/cP7hSGCaFBo/i7gzgt
 KD4Kb/6fmlrENxFh6DEnLa3LPtrvkEJu7r6rl4VvxY42FKMv61hTLAErSBKoA48ml1eb
 NxsGqijukYiFDXWZL99LayOFh1GPIKOKeFjaTrZfZM6L/ImRGO2p+vnaz7qlzE7+xNM3
 YmZSBMvfsPwxKi4/t+Y6D9cjAfjgNlsNSl+hJ0R+xPvULthoTSbs8cQ8BGwmaOXpHZZy
 /xkQ==
X-Gm-Message-State: AOAM531gO52heUMOg0fP7Fb4guDVU261J805nX4xALJMxVEq7jSFgsvx
 r4Y6sYcMPl9F351j3RkGZ9j6+UI9YWZOJslt+7kVqF+eXXvSCMzeLgji0b/B6OHAScqjzSJlT8D
 MPKLYc+AQmUFCBqBzm7pBWTU4/xnzcqSc0/7C4X3Pk3WlIPos78Kv7tKsiA==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr3028434lfe.84.1639013768368; 
 Wed, 08 Dec 2021 17:36:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8J1VPAV96S00Uw0dCVroQwlkXFJSpzZnIw7YKczXAqM/Jt192jeskKg8NjCgbMws3kukfkxCO5ANHkPRUvog=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr3028414lfe.84.1639013768200; 
 Wed, 08 Dec 2021 17:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-6-michael.christie@oracle.com>
 <CACGkMEu20xRvunwv=h-rWhRcnmmn4rDPqp1uMKMSBrZrtixu9w@mail.gmail.com>
 <6dfa3975-54a7-5389-b593-e6269681e94b@oracle.com>
In-Reply-To: <6dfa3975-54a7-5389-b593-e6269681e94b@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 09:35:57 +0800
Message-ID: <CACGkMEsQ-PP8nW8_SXp_-gNG5dsh9y6fwuRiNA_PVd37f5Jkpw@mail.gmail.com>
Subject: Re: [PATCH 5/7] vhost_vsock: simplify vhost_vsock_flush()
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On Thu, Dec 9, 2021 at 1:35 AM <michael.christie@oracle.com> wrote:
>
> On 12/7/21 9:53 PM, Jason Wang wrote:
> > On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> From: Andrey Ryabinin <arbn@yandex-team.com>
> >>
> >> vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
> >> before vhost_work_dev_flush(&vsock->dev). This seems pointless
> >> as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
> >> in a row doesn't do anything useful, one is just enough.
> >>
> >> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> >> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> ---
> >>  drivers/vhost/vsock.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> index 2339587bcd31..1f38160b249d 100644
> >> --- a/drivers/vhost/vsock.c
> >> +++ b/drivers/vhost/vsock.c
> >> @@ -703,11 +703,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> >>
> >>  static void vhost_vsock_flush(struct vhost_vsock *vsock)
> >>  {
> >> -       int i;
> >> -
> >> -       for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
> >> -               if (vsock->vqs[i].handle_kick)
> >> -                       vhost_work_dev_flush(vsock->vqs[i].poll.dev);
> >>         vhost_work_dev_flush(&vsock->dev);
> >>  }
> >
> > Is this better to be consistent with vhost-net so that we can simply
> > remove the vhost_vsock_flush() wrapper here.
> >
>
> I didn't understand that comment.
>
> Did you mean consistent as they both have vhost_vsock/net_flush functions
> or as in they prefer to not have one line wrappers?
>
> Before and after this patchset, both net and vsock have a vhost_vsock/net_flush
> function, so maybe you didn't mean that.
>
> I think the wrapper is not very useful and could be removed. However,
> I thought vsock preferred wrappers because we have vhost_vsock_free
> which is just a wrapper around kfree. I also noticed test.c is a
> fan of one line wrappers, but I see net and scsi do not do that.

Ok, then I'm fine with this.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
