Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE69BC54EE9
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 16:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF78684182;
	Thu,  8 Sep 2022 16:40:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF78684182
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X+c0i3pU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjFU2JSJUMpq; Thu,  8 Sep 2022 16:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 73F7284188;
	Thu,  8 Sep 2022 16:40:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73F7284188
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50B9EC0032;
	Thu,  8 Sep 2022 16:40:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D767C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 16:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 640496F8F5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 16:40:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 640496F8F5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X+c0i3pU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GsYlhFbcm9Nt
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 16:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 942BC61201
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 942BC61201
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662655249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkfsc+Qd/gwYAug2VWPkSKKYrJX5Z5R+zOqDD2izm4g=;
 b=X+c0i3pUUEaTcNgdz0UA/nW4yyQhQ/3Q1PsdzXbCbzaxd2qC6D++QFYxqV/gY3P6mkDSX2
 gP2OkcH5J2Z2GAdr+R7efVplkYlfIJKqPD0ct5+38AqjJ/ymWegxL0uXaZFk29/UePirpv
 KpqueaRu7SBk/7lkIsS/cc5+P1ySr9Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-rnet4zcFNmi8nws--hOyvg-1; Thu, 08 Sep 2022 12:40:46 -0400
X-MC-Unique: rnet4zcFNmi8nws--hOyvg-1
Received: by mail-qt1-f200.google.com with SMTP id
 fv24-20020a05622a4a1800b003445e593889so14799241qtb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Sep 2022 09:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=pkfsc+Qd/gwYAug2VWPkSKKYrJX5Z5R+zOqDD2izm4g=;
 b=NQrzwxvxT3EDv/X3F+oFbzoVimIPPzPakEvov3U16pj6zl8EVnoQSZhTBKVl5rxRus
 VCav8w0FcI5i+eVfUlnYT02A3YjTwWAiwkTfNLatmj6qMXHjmiHDS108RQ7V4YTdf/8a
 aURXrXoHjnd2zhsv3QKz9CMoOvw3hkQAqC/cJES/XpdKX+ZGgD4WLtzpgAqSCsslWHc7
 +AXTr3vj77Za4/WQ0C89UERHnM4d+yFBFNCWmKQ7s6JY5vLkOeRN5i1zVZWPvgA/+SwP
 5GgX3aYl8MzQCSSOLmOW5qCDBje3Zvx8jZJSKfBcu680BjGL7MGnCmjslUtcicpL+bSC
 NVxg==
X-Gm-Message-State: ACgBeo0MfZHawfMrKiIGWmCNF6iasOGCyYx2BAXXVGxnFW9nyMZIzWuv
 9IWJyTuldCRGgRgyQ8Q+3iqBWp8YIJ3nututV21p8x1mQq+yH903AWWJhtcFxgD6iWTyn6UBR7r
 G/5FlYgHsgHqN2EYlrCtw5h3jO0qEH0uocIZEzyqC1A==
X-Received: by 2002:a05:620a:14aa:b0:6cb:e3a2:311b with SMTP id
 x10-20020a05620a14aa00b006cbe3a2311bmr904219qkj.266.1662655245503; 
 Thu, 08 Sep 2022 09:40:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53cNBgQZY4hEhzYVT/VkqEs1YXNR9ifPFn0pnI+C10iK7Hb4Aw/802twYiNtloEdpZjdtoJg==
X-Received: by 2002:a05:620a:14aa:b0:6cb:e3a2:311b with SMTP id
 x10-20020a05620a14aa00b006cbe3a2311bmr904197qkj.266.1662655245128; 
 Thu, 08 Sep 2022 09:40:45 -0700 (PDT)
Received: from redhat.com ([45.144.113.243]) by smtp.gmail.com with ESMTPSA id
 v38-20020a05622a18a600b0035a7070e909sm701989qtc.38.2022.09.08.09.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Sep 2022 09:40:44 -0700 (PDT)
Date: Thu, 8 Sep 2022 12:40:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220908123911-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
 <20220811035817-mutt-send-email-mst@kernel.org>
 <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
 <20220830094441-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220830094441-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 mgo@opensynergy.com, Marcel Holtmann <marcel@holtmann.org>
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

On Tue, Aug 30, 2022 at 09:45:02AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 11, 2022 at 10:02:31AM -0700, Luiz Augusto von Dentz wrote:
> > Hi Michael,
> > 
> > On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > > > >
> > > > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > > > >
> > > > >         According to specification [1], "For the device-specific configuration
> > > > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> > > > >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> > > > >         and aligned accesses for 32 and 64 bit wide fields.".
> > > > >
> > > > >         Current version of the configuration structure:
> > > > >
> > > > >             struct virtio_bt_config {
> > > > >                 __u8  type;
> > > > >                 __u16 vendor;
> > > > >                 __u16 msft_opcode;
> > > > >             } __attribute__((packed));
> > > > >
> > > > >         has both 16bit fields non-aligned.
> > > > >
> > > > >         This commit fixes it.
> > > > >
> > > > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > > > >
> > > > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > > > >
> > > > >     This is all true enough, but the problem is
> > > > >     1. changing uapi like this can't be done, will break userspace
> > > > >     2. the driver has more issues and no one seems to want to
> > > > >        maintain it.
> > > > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > > > >     to merge it for this release.
> > > > >
> > > > > This is very sad. We already use this driver in our projects.
> > > >
> > > > Really?  Can you step up to maintain it? Then we can fix the issues
> > > > and it won't be broken.
> > >
> > > Just a reminder that I'm waiting for a response on that.
> > > I just don't know enough about bluetooth.
> > 
> > Just a heads up that Marcel is on vacation, he did mention that he had
> > done some work to update virtio_bt thus why I didn't apply any of the
> > changes yet.
> 
> Any update? when does Marcel return?


Annnnnnd ... this is falling between the chairs again?
Guys if anyone wants to use this driver it needs a maintainer.

> > > --
> > > MST
> > >
> > 
> > 
> > -- 
> > Luiz Augusto von Dentz

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
