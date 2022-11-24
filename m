Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD8FC4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 08:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 10AB640C90;
	Thu, 24 Nov 2022 08:08:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10AB640C90
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=b5A6pNLP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVw0J0_8a-cu; Thu, 24 Nov 2022 08:08:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C95F40146;
	Thu, 24 Nov 2022 08:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C95F40146
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F405C0033;
	Thu, 24 Nov 2022 08:08:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB8EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 08:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27F094021C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 08:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27F094021C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=b5A6pNLP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQCSVddTlI-k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 08:08:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24E0F401FF
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24E0F401FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 08:08:23 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id c129so911721oia.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 00:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gm4D/L7UK6GmbrG/xD5Jwp3lpkFNi2Qnmd8/RSf7tn8=;
 b=b5A6pNLPmZ2UDhKTDkPDnP0rSjAHCQsa+lpbF2Pnbam4MwPWDUDvfh+otxa+nbigyU
 jfiyDzUqVZC9rMqQunOeeqOfeV5raK2tT24nJrdlN4zwzTIM5EtK783wJfPqjSlJ9bsW
 p7b2nfQqYlkljo7BScr2u5N5B24HQB6UNdL8imuZZkFyVne//PCndzoLeX9mCo/iD3yQ
 d+ZSTQj84M+ipZ6rrFL/PxXnY4rYEY6//CQzYTzQlrO7FRH8KSIP73KBPI/OPY+9wGZC
 wZ0bt0/D+wwcIPRi8ZWo0GMgJo/Evn9vT2YfBm5eLqzdyIovtiEcS7pETAGAKufdGIa9
 KHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gm4D/L7UK6GmbrG/xD5Jwp3lpkFNi2Qnmd8/RSf7tn8=;
 b=wZV1L6OANycPqQeMVjdjfKiXYcctILCY1n4LJLm0PmIlgecGrfOUWaO1WaNKkRpg8Z
 nGUSUU1Z3OdYNpk74yWAkNr4GrB5mUvRtNRg891svhZzTGtUk15TFjrowRxyQts4kp5M
 Qgrq9Jr9csncoRY7iE7gk6ko+NTcosRD/278Rdw4iZAJSY8uaDDLk7xKh237WctCPC48
 DwEbIT//MBA2zvMGP8fgi69YZal/9jAaVt0ioKL+2p54wxyJrxwMAUKkbGDmDCxW6U4W
 zXiQhmIOC+fla3EdVt8X+U9rcIzBEi2ueD1ZLrlnIa0iU4M5ABF7NfAk7Jw9N0JxPi58
 EeVg==
X-Gm-Message-State: ANoB5pl56erZJu5gnY9+4pMXan4S6qcc7Qmyq4KLew8WgRFTkvfzYsZS
 uBffi39FcmTyYMIKbfkGB80Fuyygux9onkNikwMjRA==
X-Google-Smtp-Source: AA0mqf4e8Bkl4Dh3rGbZ+B5cdG9YKmDUwwZn1GBnQo/cmjx9g3pMrN7CJ8FiSfDTeqcHvrLBC71TkrYAZsDLT2Yh5lM=
X-Received: by 2002:aca:1112:0:b0:35a:6d81:204a with SMTP id
 18-20020aca1112000000b0035a6d81204amr5866213oir.102.1669277302091; Thu, 24
 Nov 2022 00:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1b8d59e1-8702-8b81-f82c-a743116da799@nvidia.com>
 <20221124014300-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221124014300-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 24 Nov 2022 10:07:46 +0200
Message-ID: <CAJs=3_DJzeGV4KEtTdXAo2SaSQh5UiuT9+0Kvqq3exbs2ZYBLQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

Thanks for your comments.

> > +     /* Pass the data to the user */
> > +     if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
> > +             ret = -EFAULT;
> > +             goto out;
>
>
> there nothing here to "goto out" following is sufficient I guess :-


You're right, but like Michael said, it will be pretty easy to forget
adding a goto statement if adding more code to the function.

> > +     memset(&lifetime, 0, sizeof(lifetime));
> > +
>
>
> you can remove memset 0 call here and declare initialize struct var
> something like totally untested :-
>
>
>         struct virtio_blk_lifetime lifetime = { };


>
> Yes, that's a bit cleaner, but there should be no space between {}:
>         struct virtio_blk_lifetime lifetime = {};


I will fix it in the next version.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
