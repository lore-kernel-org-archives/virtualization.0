Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BD8ECAAD1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 13:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 792F0416B9;
	Tue, 30 Aug 2022 13:45:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 792F0416B9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F6jjyjAi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zoaB0_2RSqM7; Tue, 30 Aug 2022 13:45:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 922A1416AC;
	Tue, 30 Aug 2022 13:45:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 922A1416AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67D78C0032;
	Tue, 30 Aug 2022 13:45:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B428AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89501416AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89501416AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GuGlq3JCVdSO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:45:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 453E7416B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 453E7416B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661867106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4TQ3D3Ecv0JVJq75Mysm7I94dQGdbTCqUokREWAuRr0=;
 b=F6jjyjAijh0C8RdnqZ8OD0MM1tckLyYPKjnqr5n6GM3nhyUNck05ygEjt4EmsN4ALG/9JV
 +0B2EDA0tOI5jbGcgTe0i4zDtJhnAengrhw8ZFTkIYGPq0YEkQzzg3D+SAozl9aJSYWikq
 w+THmLmrqelgaX6Nn2Ajw2lMvSRDu5U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-zs8hMW-jMfyyrYqB5godrg-1; Tue, 30 Aug 2022 09:45:05 -0400
X-MC-Unique: zs8hMW-jMfyyrYqB5godrg-1
Received: by mail-wm1-f69.google.com with SMTP id
 f7-20020a1c6a07000000b003a60ede816cso2025933wmc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 06:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=4TQ3D3Ecv0JVJq75Mysm7I94dQGdbTCqUokREWAuRr0=;
 b=NNpxb2QyPQ24Xm3fg4pJXlZg572GBpqqLvXOFoK5qjoZ/kdCBuC+91NSszSgcRK+sN
 uEXNSCTUKk6cOZ+N+y38eMsSBVUtvIK6qS2o6GpigR1p67f88ooiW9HA4vcHAyYzDiG3
 3SF7NTTwsOKGgdxH7rr5Qg6142w1zHHYftG48XakpQjkwxZ/DGJC22jVggY3oMyz2H4t
 PJVKzLH4d9HfbZkxRdQwGd4zt82utImeAAmiH3MYDUkxjZ5bdLOGedvOsurybByw2BBe
 2py2sf1CX6xA2LUWfmtFmD+D9QC7v5HnL5PAsDnqQa+FrQnDJ2FO5AzZRCYGhsM03Qni
 RKGQ==
X-Gm-Message-State: ACgBeo1bjMk5eLWgi0r/cMRWP8++Iot2DzulBSw8BxPuDZb0O8aveazR
 cYZb32AcNYnxyIypHzZWWbWzCDkk/Rc3WEuBeTjpNc9cmf8PZV1ftMbCP4UNgc6lgP4Nzxz0c4C
 hcYxGE2hmqj73s1Ee9+UBf8gvOeswsFD5H2onmJfiJA==
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id
 c14-20020a05600c0ace00b003a5b495854dmr9620572wmr.86.1661867102645; 
 Tue, 30 Aug 2022 06:45:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7kE0OkvnuES7vDthBiH8iXuZiew08diUgUfwuPstZZgb2cSBtaApqD4FeCYJF2b3SOm8jHEg==
X-Received: by 2002:a05:600c:ace:b0:3a5:b495:854d with SMTP id
 c14-20020a05600c0ace00b003a5b495854dmr9620557wmr.86.1661867102326; 
 Tue, 30 Aug 2022 06:45:02 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 r8-20020a5d6948000000b00226a5187528sm9535421wrw.48.2022.08.30.06.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 06:45:01 -0700 (PDT)
Date: Tue, 30 Aug 2022 09:44:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220830094441-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
 <20220811035817-mutt-send-email-mst@kernel.org>
 <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 10:02:31AM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > > >
> > > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > > >
> > > >         According to specification [1], "For the device-specific configuration
> > > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> > > >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> > > >         and aligned accesses for 32 and 64 bit wide fields.".
> > > >
> > > >         Current version of the configuration structure:
> > > >
> > > >             struct virtio_bt_config {
> > > >                 __u8  type;
> > > >                 __u16 vendor;
> > > >                 __u16 msft_opcode;
> > > >             } __attribute__((packed));
> > > >
> > > >         has both 16bit fields non-aligned.
> > > >
> > > >         This commit fixes it.
> > > >
> > > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > > >
> > > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > > >
> > > >     This is all true enough, but the problem is
> > > >     1. changing uapi like this can't be done, will break userspace
> > > >     2. the driver has more issues and no one seems to want to
> > > >        maintain it.
> > > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > > >     to merge it for this release.
> > > >
> > > > This is very sad. We already use this driver in our projects.
> > >
> > > Really?  Can you step up to maintain it? Then we can fix the issues
> > > and it won't be broken.
> >
> > Just a reminder that I'm waiting for a response on that.
> > I just don't know enough about bluetooth.
> 
> Just a heads up that Marcel is on vacation, he did mention that he had
> done some work to update virtio_bt thus why I didn't apply any of the
> changes yet.

Any update? when does Marcel return?

> > --
> > MST
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
