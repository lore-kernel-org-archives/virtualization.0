Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807FBC4708C
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 03:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8ADF813F8;
	Tue,  6 Dec 2022 03:07:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8ADF813F8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R5II33Q9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7DUzEgsYsqVM; Tue,  6 Dec 2022 03:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79C41813AF;
	Tue,  6 Dec 2022 03:07:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79C41813AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41C91C0033;
	Tue,  6 Dec 2022 03:07:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30F8FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 03:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9FF4606BF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 03:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9FF4606BF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R5II33Q9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lg6qjzYMwlzV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 03:07:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ED99606AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1ED99606AA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 03:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670296063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkXMQkrm86pEDBJ+OXSxWtvjX0737EP7Ca7fdFrkS84=;
 b=R5II33Q9PWKim/PEhv3Pw0VJZByBi4Y6aExB1TVy4KFrjobW0LAXGsyI36xPsA4FioMNxs
 CwQOcD9Fycfevh8CtohKhcNLdiTCc4UsvVlulrk0xB+O0sgEfmfX8K/pxoVveSmns8R1dH
 GOA5XQgx6Fq/AGC8WvWUvLtc0JraaUM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-jW5VL-dyMvKaME5jRfDOnw-1; Mon, 05 Dec 2022 22:07:41 -0500
X-MC-Unique: jW5VL-dyMvKaME5jRfDOnw-1
Received: by mail-oi1-f199.google.com with SMTP id
 a5-20020aca1a05000000b00359de30f06dso6023064oia.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 19:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EkXMQkrm86pEDBJ+OXSxWtvjX0737EP7Ca7fdFrkS84=;
 b=Gg/pxEyMw6lGd3JBPtByo8BFzvGiYY8a0AEt63t1W9hc2uQRq+4LApR/7SyY6YjJ7f
 VxOL+8yfy1NTJBBmIS5tbDqZkxNWu/+HXHWbWXogVvgG47IySjFFMAxTdVSLc5I15kKR
 pUv7D/0EafnI7mIrRZ/QPiwOWLo2znOpth5+dEP8lUz1+lG+Jys06m2J452Dj4Cgr1Oq
 P5u8wLe+PQXqRRS55fmvz7QL9n7dDIJpTnz582GTUZREbedGD5hadmkjG363JhV49gva
 VtJWU3DmNDkF/Keudy3h1zYIEWXNy61n4A8nHh4Ld3pCNEJleekzNss/FCL5ThQD5Gi5
 2xfA==
X-Gm-Message-State: ANoB5plHE9+6kcNsa8Lq8/aLTBjk79xt99pG2r5e0GUZ7kui91k3M8LS
 XZORrI6mKClF3clfQoxh5Ere5HTI8WU03PYRiF2rNPucSxHJ0uDjRSm92KtCTdQs5OcOPSWQUTj
 rtx+RJdHpXEik2OAYUf2J+FByUxLdWI6iZs0GHdzBMqu1UI841U583bVmyQ==
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id
 a18-20020aca1a12000000b0035c303dfe37mr3893179oia.35.1670296061020; 
 Mon, 05 Dec 2022 19:07:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5T4zc76OXFd7S30MyQNVEUQ+DFnrgAFptipJXbeS3XW3EkLFYTBYdXDcCV6Pho7gKpCBtpc2D245cN0etm3wM=
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id
 a18-20020aca1a12000000b0035c303dfe37mr3893172oia.35.1670296060799; Mon, 05
 Dec 2022 19:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20221129143335.1902170-1-alvaro.karsz@solid-run.com>
 <9cc0448a-7a69-727c-a27e-32a27b7cd5e4@redhat.com>
 <CAJs=3_AOoY=8GmMEbQfz2LDGPVWHgU5pw5Levs8rBTsSwfUdpg@mail.gmail.com>
 <CAJs=3_A+4hdcrHEiuQv+z_4SHoKNQ8F5qJYDA8SkOBk+SZFwWA@mail.gmail.com>
In-Reply-To: <CAJs=3_A+4hdcrHEiuQv+z_4SHoKNQ8F5qJYDA8SkOBk+SZFwWA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Dec 2022 11:07:29 +0800
Message-ID: <CACGkMEsn2Pcg3fvAFMf01r7VNs3FY8BzYr7ZPQ81f8bzzGHm4Q@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: vdpa: new SolidNET DPU driver.
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, virtualization@lists.linux-foundation.org
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

On Tue, Dec 6, 2022 at 12:55 AM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> > We must send a  SNET_MSG_DESTROY message to the DPU before removing the device.
> > This remove() makes sure that if somehow remove was called
> > before/without reset, the DPU will receive this message.
>
> I meant that the message must be sent before the PCI device is removed.
> The message is sent from the vDPA reset cb, and the reset in the PCI
> remove cb makes sure that PCI remove wasn't called without calling
> vDPA reset.
> I can remove it if you think that this is not required.

The reset is usually done during probe:

E.g register_virtio_device() or vhost_vdpa_open().

If it's not required, let's remove but if it is a must for your
hardware, we need keep it.

Thanks

>
>
> Alvaro
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
