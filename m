Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6064DC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 04:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E039682C21;
	Wed,  9 Feb 2022 04:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OxHeVOzlsyl0; Wed,  9 Feb 2022 04:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E79982BE5;
	Wed,  9 Feb 2022 04:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66873C001A;
	Wed,  9 Feb 2022 04:21:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0A2C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF51F400F6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZaIdTqXpm9QS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:21:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C489C400CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644380509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3BqN70XFYwy8dmYrTT0pR/AuWTTmgK4Xwa4KvhO/0ZM=;
 b=YynKFFEB2xzTlhHznKtqX8b7+Cx6IyHjQBx19mIhOJcn0evzQUdRth1CbkNZQoisssoOCT
 guRED/q7y+ziZP0JqHiqsf8NQI4EGMSa5xKUVHazkxCkmzj+pxrgUqYr/GEm1ts+mGK6xR
 BZ8PT1FRoCbdbvSsq/yU2j/avL012r0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-8pzFZkISMtC04fbkCYd7kg-1; Tue, 08 Feb 2022 23:21:48 -0500
X-MC-Unique: 8pzFZkISMtC04fbkCYd7kg-1
Received: by mail-lj1-f197.google.com with SMTP id
 a13-20020a2eb54d000000b0023f5f64ae4fso541048ljn.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 20:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3BqN70XFYwy8dmYrTT0pR/AuWTTmgK4Xwa4KvhO/0ZM=;
 b=fzV/RaZZXACog1ei8lufP4AgVqhtmx/R9I/5k9SVHyx3QUHGlNoT5mJ4dNzVoTwAu3
 GdmAv/6IVjbWAUUn6ObHXMV3pldtrHXVnGc94hDvAKneDBPEEC+CcGut4cV3JDFL7VtA
 wXrraetscjU+vmjUhQ/UT+EVtLMqiqc6ptrPZ0I2ryUYCJsyYvmaIWjetIlC7JovV9/M
 Wosm3v2dEjiA7rIprtrDpmMw1/HaZsckrjs4GExitNy5NYshLnkkLvoJ4+ciMspxw+2Z
 xZbbVc1qN5g8co67wjGOViZ5tLvXRLWrSYG8rHus9HwcqfyYZmz2RwIgbAXY/XALhKf1
 bfEg==
X-Gm-Message-State: AOAM5301W7qzDbCinZ0tTP4PXJz4DJPom27sp3rrCNOxxv8QOf9JlR3m
 Gnn/gPeXw5Fq4xAmnGVGotNA5+gmKXD0bBoUSQtWklcPM2kVnajuG0aWDHBS80Xu+izyvc7YszW
 91V8/LqwfnIC7JNXxSgvggSRhnUPapHK/lbUWGCH40spT3YjHhhrv/NWoTw==
X-Received: by 2002:a05:6512:39c6:: with SMTP id
 k6mr310154lfu.199.1644380506966; 
 Tue, 08 Feb 2022 20:21:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVYYypj/6GW5UHMyOBXeJC+jbnVDlGLvx86+l1eiL77ZqPBfak0Yk8KnpKpOLeHjk1QP8JpKC1731kUazhSlU=
X-Received: by 2002:a05:6512:39c6:: with SMTP id
 k6mr310142lfu.199.1644380506777; 
 Tue, 08 Feb 2022 20:21:46 -0800 (PST)
MIME-Version: 1.0
References: <CALAgD-5+Ryzmj4iziL4J0yb7ehXZS8geqaj3ZfH462rgCRdxqA@mail.gmail.com>
 <20220208155726-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220208155726-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Feb 2022 12:21:35 +0800
Message-ID: <CACGkMEt6fU0s9wspqChJYiE-HPxXEbzsdKdksL8f0X8NNO-=LQ@mail.gmail.com>
Subject: Re: one question about your patch "vhost: log dirty page correctly"
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, Xingyu Li <xli399@ucr.edu>,
 kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

Adding lists.

On Wed, Feb 9, 2022 at 4:58 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Feb 08, 2022 at 11:37:00AM -0800, Xingyu Li wrote:
> > Hi Jason,
> >
> > Sorry to disturb you. I have a question about your Linux kernel
> > patch-- 1981e4c9a97("vhost: log dirty page correctly"). I noted that the commit
> > message says that the fix tag of this patch is 6b1e6cc7855b ("vhost: new device
> > IOTLB API"). It also says that the bug occured when try to log GIOVA.However,
> > when I look at the the commit diff of the 6b1e6cc7855b, I do not find the
> > related contents to modify the vhost_log_write() or some log-related functions.
> > Can you give me some guidance on this?

So the logic is: 6b1e6cc7855b doesn't touch vhost_log_write() so the
log is wrong since vhost_log_write() is based on GPA. That's why I
wrote 1981e4c9a97 where I translated GIOVA to GPA before doing the
log.

> >
> > --
> > Yours sincerely,
> > Xingyu
>
> Pls CC mailing list on questions. I have a policy against replying
> off list.

Right.

Thanks

>
> Thanks!
>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
