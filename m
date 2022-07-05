Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F2CC43334
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 07:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54B3B81D5C;
	Tue,  5 Jul 2022 07:14:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54B3B81D5C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbSXLA1n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7mtqsx2f2pw; Tue,  5 Jul 2022 07:14:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1549281C93;
	Tue,  5 Jul 2022 07:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1549281C93
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5DDCC0032;
	Tue,  5 Jul 2022 07:14:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71907C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 458B260AA7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 458B260AA7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QbSXLA1n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k57nEO0iy7o2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3B0960A8C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3B0960A8C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657005266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4giCAN0BxKc778vWtSSTjZu8pniT4NMZr4y0gV4ab5g=;
 b=QbSXLA1nGNsfL4a6dcdZZDagb0berUXgxKOobbKyb0wcuhBiZOAemkVNDpJCTNaOWcfv87
 A1xf8+3sL099HAqbXw2yjdOnLOQ3k2h4uqax4yQmEor7fTEn4Qr4ElRCqlnYhmEyNYQXIh
 Lj/9xAlsTjw3ST+SiR5EUXVXRWG9LJk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-izZIxNCQOruE1TelGdvH0A-1; Tue, 05 Jul 2022 03:14:25 -0400
X-MC-Unique: izZIxNCQOruE1TelGdvH0A-1
Received: by mail-wr1-f72.google.com with SMTP id
 e6-20020adfc846000000b0021d2af9adb6so1657572wrh.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 00:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4giCAN0BxKc778vWtSSTjZu8pniT4NMZr4y0gV4ab5g=;
 b=Aa1XRgdIf1uTiPsEZT3fI6Izfz5WkIXiu6fC0H10k/FPomiI8sdLqjuN0OLCFk5jWc
 i3TP7KraDwfKgxaqirsk/zvm1Qc2KSl+P+6LAiEXWqkAgqiRBQJnwAeWYb3nstrRwJYR
 1QnqKMw0v7Al9XVDHJlpdDS6qixplYXLfw/7ONq4HI49tH9bf95UVSieTV5NFynCpy2e
 a7dxKfz8GZALossThsUkz2ofvPkD1VBh1H8SRhiFdSFo0GWtxOQmXGRbEOZ9BZHaAaxd
 P1Oxiuu/gvtO9d2CVSVC2CmgP+74aEUFMCT506U9O/3EWH71wE63Vopn6ntL/kCswZtl
 WoWw==
X-Gm-Message-State: AJIora8GJGudxVVsc0rDmX58x74lHZi9lrJGEv8K21qWL74m1NtNHdns
 yzSCMUix9BJwIvfCC+W1YbQpFI4cAo078ovF3H/ZvaekcKSoVwujMcz1gyIOLrPZuF1ECO7jKQo
 hhFATZ08ssEfpnvkx42wnFT63ccqYuIa6FVTBclltrg==
X-Received: by 2002:a05:600c:219a:b0:3a1:816e:47da with SMTP id
 e26-20020a05600c219a00b003a1816e47damr28318205wme.36.1657005264247; 
 Tue, 05 Jul 2022 00:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcW9e9eTalezNtaWJSnF5gbHxxCeW7lqs+IDLr/j+gAKlupZwbA3tlhTxkIM9It+mdfQXIUg==
X-Received: by 2002:a05:600c:219a:b0:3a1:816e:47da with SMTP id
 e26-20020a05600c219a00b003a1816e47damr28318198wme.36.1657005264087; 
 Tue, 05 Jul 2022 00:14:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 v13-20020a1cf70d000000b0039747cf8354sm21868103wmh.39.2022.07.05.00.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 00:14:23 -0700 (PDT)
Date: Tue, 5 Jul 2022 09:14:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/6] tools/virtio: fix build
Message-ID: <20220705071420.24slcba3racqjmx6@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-2-sgarzare@redhat.com>
 <20220704150706-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220704150706-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jul 04, 2022 at 03:07:15PM -0400, Michael S. Tsirkin wrote:
>On Mon, Jul 04, 2022 at 07:16:56PM +0200, Stefano Garzarella wrote:
>> Fix the build caused by the following changes:
>> - phys_addr_t is now defined in tools/include/linux/types.h
>> - dev_warn_once() is used in drivers/virtio/virtio_ring.c
>> - linux/uio.h included by vringh.h use INT_MAX defined in limits.h
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Post this separately?

Yep, sure!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
