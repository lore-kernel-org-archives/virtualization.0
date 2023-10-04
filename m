Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE40DE7C4E2
	for <virtualization@archiver.kernel.org>; Wed,  4 Oct 2023 16:42:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10DAF6148D;
	Wed,  4 Oct 2023 16:42:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10DAF6148D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DiMHtwGq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gx25AAZ_hYim; Wed,  4 Oct 2023 16:42:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 601F261477;
	Wed,  4 Oct 2023 16:42:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 601F261477
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26420C0039;
	Wed,  4 Oct 2023 16:42:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A99B2C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 833304222E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 833304222E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DiMHtwGq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsiOuZk1hZmh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:42:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B91541F89
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Oct 2023 16:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B91541F89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696437749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQchYUvGxxsCc4djV8D5Ngra+tr0SbVapL0lFjxteFg=;
 b=DiMHtwGq+rzc8Q/CkVaNoWXtk0XM8TvkEOg00wnfhlNXy1G4ALNiRAvnS3oxs7+A364pWH
 pdAi1lo1ysFfzTyWAkJ9aRpeAY4OuIblCERSEdbNo7eXIlfbz4xpzb06iuLGFXsgtseQ0p
 oeSpDP1Fi+8UzmjhaG++eYvDUiUXsEs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-weruEEvUORu4el99lYjjPw-1; Wed, 04 Oct 2023 12:42:25 -0400
X-MC-Unique: weruEEvUORu4el99lYjjPw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77593f7173eso1892785a.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Oct 2023 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437745; x=1697042545;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PQchYUvGxxsCc4djV8D5Ngra+tr0SbVapL0lFjxteFg=;
 b=R9af8ssvBLfT2OESN26DKjk95c/6qD+4+4tWDKFasTg47UOXvFvnFSgsgcjY1ugK9f
 5RpvwNU8eBOVMSG0CVgRsWiLZEkWuTKF2x+MZzipXbxubLSWQovaEflcLIsa2EB7TPKZ
 H/3K2Ke+GO7GH/aQulFQWCTTdyPH2uwmqg1KpUP+rojBUotSszyNs7HROPJkPaXO1BXm
 h8zXpIu0BdXoMD/ZA23ZI2Cgw9EjkQ5QiY7pijedIaFcpyYAEnj/ghxmgJrhtN+rgT2d
 VuYNuv76alS5r0t6V9CwOZ1vIQLBKxQ+LhmFepY6dnTYd0BYuH2h1Dtsv7sf/k353XFM
 8kZg==
X-Gm-Message-State: AOJu0YwZLsBxJlHC74Vl6SFoc/JXB2qsjsiA77KipDBMo136CZHtCbaT
 a2+9RYcxA9YV7xG93SZoHxAXtEs9xh5zzcZhQlZNLNWdmpd2Ta5+mEmueJmUmEgTo9MeHjNDKUQ
 3U2vSgFeLoQKzH+6OStGFkJaPyqHJY0bf/89FNejnGQ==
X-Received: by 2002:a05:620a:258f:b0:767:1d7e:ec40 with SMTP id
 x15-20020a05620a258f00b007671d7eec40mr3175086qko.1.1696437745124; 
 Wed, 04 Oct 2023 09:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt9ZzO3ODQL872WyKfk3Dg3TgfHXkRo+gA8ZChzf0rtqBB4Wiu+lGNy76VPmqz4kqAeDz51Q==
X-Received: by 2002:a05:620a:258f:b0:767:1d7e:ec40 with SMTP id
 x15-20020a05620a258f00b007671d7eec40mr3175068qko.1.1696437744855; 
 Wed, 04 Oct 2023 09:42:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 o15-20020ae9f50f000000b0076cb1eff83csm1387058qkg.5.2023.10.04.09.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:24 -0700 (PDT)
Date: Wed, 4 Oct 2023 18:42:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <zilryvqespe5k4d3xjer2fcrseqo3yu3lvairvobvop6shqvsz@gzdmzpujxzkx>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <4nwo6nd2ihjqsoqnjdjhuucqyc4fhfhxk52q6ulrs6sd2fmf7z@24hi65hbpl4i>
 <aef9a438-3c61-44ec-688f-ed89eb886bfd@salutedevices.com>
 <5ae3b08d-bcbb-514c-856a-94c538796714@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <5ae3b08d-bcbb-514c-856a-94c538796714@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Oct 04, 2023 at 07:22:04PM +0300, Arseniy Krasnov wrote:
>
>
>On 04.10.2023 08:25, Arseniy Krasnov wrote:
>>
>>
>> On 03.10.2023 19:26, Stefano Garzarella wrote:
>>> Hi Arseniy,
>>>
>>> On Sun, Oct 01, 2023 at 12:02:56AM +0300, Arseniy Krasnov wrote:
>>>> Hello,
>>>>
>>>> this patchset contains second and third parts of another big patchset
>>>> for MSG_ZEROCOPY flag support:
>>>> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sber=
devices.ru/
>>>>
>>>> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>>>> suggested to split it for three parts to simplify review and merging:
>>>>
>>>> 1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>>>> =A0 link below)
>>>> 2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>>>> =A0 tx completions) and update for Documentation/. <-- this patchset
>>>> 3) Updates for tests and utils. <-- this patchset
>>>>
>>>> Part 1) was merged:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3D71b263e79370348349553ecdf46f4a69eb436dc7
>>>>
>>>> Head for this patchset is:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3D236f3873b517acfaf949c23bb2d5dec13bfd2da2
>>>>
>>>> Link to v1:
>>>> https://lore.kernel.org/netdev/20230922052428.4005676-1-avkrasnov@salu=
tedevices.com/
>>>>
>>>> Changelog:
>>>> v1 -> v2:
>>>> * Patchset rebased and tested on new HEAD of net-next (see hash above).
>>>> * See per-patch changelog after ---.
>>>
>>> Thanks for this new version.
>>> I started to include vsock_uring_test in my test suite and tests are
>>> going well.
>>>
>>> I reviewed code patches, I still need to review the tests.
>>> I'll do that by the end of the week, but they looks good!
>>
>> Thanks for review! Ok, I'll wait for tests review, and then send next
>> version.
>
>Got your comments from review. I'll update patches by:
>1) Trying to avoid touching util.c/util.h

I mean, we can touch it ;-) but for this case it looks like we don't
need most of that functions to be there.

At least for now. If we need them to be used in more places, then it
makes sense.

>2) Add new header with functions shared between util vsock_perf and
>tests

We can do this also later in another PR as cleanup if you prefer.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
