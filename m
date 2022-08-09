Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E630C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AC8B60E33;
	Tue,  9 Aug 2022 21:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AC8B60E33
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxNxTs8h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZBw3H0NvnCtO; Tue,  9 Aug 2022 21:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6865360A47;
	Tue,  9 Aug 2022 21:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6865360A47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29582C0032;
	Tue,  9 Aug 2022 21:38:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAA74C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9141660E2C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9141660E2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-B7znz6N9MY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C73AA60A47
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C73AA60A47
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660081078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ztztfwk3eGNvIXOHWQfVDpsH3XjILSneZ9jjlUxeWPo=;
 b=DxNxTs8hyAr4uz4+FOWixmPAYMeFla5NIYYgWfjRcFuhbVBAzkAB9QMSnD7OqBv1uUtS+d
 vUnATi2dKoWqEg8VfoXtqAN9lp7jNM3rf/ayq/G2Pm7y+t4x85kUoPCLXjO7qwhYYM3VEA
 Bjn6tfcL+JCclCh7BuTHnYlyMHG63ok=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-Dn3hCDC0MBi8XxidldlFkw-1; Tue, 09 Aug 2022 17:37:57 -0400
X-MC-Unique: Dn3hCDC0MBi8XxidldlFkw-1
Received: by mail-ed1-f71.google.com with SMTP id
 z3-20020a056402274300b0043d4da3b4b5so7920351edd.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 14:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=Ztztfwk3eGNvIXOHWQfVDpsH3XjILSneZ9jjlUxeWPo=;
 b=D87y9d8yrGXsRLxo8JTJP8h36VEqJa8jKaYttO8iHQTm8K3n5C0xSRTznQ5+smVeZg
 u5mn3KyUmaA2gqDidDQe5xjQH8Bwfb+tpeVcWKCsk/93b+SXGxzp1VNAw48Yu95eBVng
 KRZbaVYZd0DdHbDR5nGM9MQAhY2e5HOhl3H5jbCieN/PUsXFa9kXtw66kcIzsc+mL/YW
 Mz89JP+O4KXLKWR8fNUlhydlI2PiVDU+feaK4wCSXhBLHr8nuM2cSBsUKIZzbrwFCtID
 TiuxPtJBU+Jst0sDbcC5yJimhvUYH6+oquWjm1L7m7M/rZCwSGjHUnOE0QlbDr84nS5u
 bTRQ==
X-Gm-Message-State: ACgBeo1FSPUT9mU2srvaxC/l2qpo45qwi3DjC+VZAkI99KXhmeCKgJT7
 DXLuvRQxAeBQc6WYl7tO6h5+NEfMY1sJAZUgukyR2DilmIdmznx8AgvCLSCnoQBTK8klLanet+g
 nHFAUqpqkmLKVymKrFZuOfzfedywB2CggeQWmIVOGYw==
X-Received: by 2002:a17:906:9bd5:b0:730:a07d:9534 with SMTP id
 de21-20020a1709069bd500b00730a07d9534mr18573477ejc.747.1660081076221; 
 Tue, 09 Aug 2022 14:37:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7PBBLOg3oOf/LpqkL6PQun5UXsnR9CBTXcI6X6KKVG+Dw+GTbZ2lRKou9vxROUgue3Jk9JDw==
X-Received: by 2002:a17:906:9bd5:b0:730:a07d:9534 with SMTP id
 de21-20020a1709069bd500b00730a07d9534mr18573467ejc.747.1660081076056; 
 Tue, 09 Aug 2022 14:37:56 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 ec33-20020a0564020d6100b004418c7d633bsm1248308edb.18.2022.08.09.14.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 14:37:55 -0700 (PDT)
Date: Tue, 9 Aug 2022 17:37:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809173542-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDc6MTg6MzBQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+ID4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIgMzowOSBQTQo+IAo+ID4gPj4gRnJvbTogU2ktV2Vp
IExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gPj4gU2VudDogVHVlc2RheSwgQXVndXN0
IDksIDIwMjIgMjozOSBQTSBDdXJyZW50bHkgaXQgaXMgbm90LiBOb3QgYQo+ID4gPj4gc2luZ2xl
IHBhdGNoIG5vciB0aGlzIHBhdGNoLCBidXQgdGhlIGNvbnRleHQgZm9yIHRoZSBldmVudHVhbCBn
b2FsIGlzCj4gPiA+PiB0byBhbGxvdyBYRFAgb24gYSBNVFU9OTAwMCBsaW5rIHdoZW4gZ3Vlc3Qg
dXNlcnMgaW50ZW50aW9uYWxseSBsb3dlcgo+ID4gPj4gZG93biBNVFUgdG8gMTUwMC4KPiA+ID4g
V2hpY2ggYXBwbGljYXRpb24gYmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5n
IG10dSB0byAxNTAwCj4gPiB0byBzZW5kIHBhY2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2ZSA5SyBw
YWNrZXRzPwo+IAo+IEJlbG93IGRldGFpbHMgZG9lc27igJl0IGFuc3dlciB0aGUgcXVlc3Rpb24g
b2YgYXN5bW1ldHJ5LiA6KQo+IAo+ID4gSSB0aGluayB2aXJ0aW8tbmV0IGRyaXZlciBkb2Vzbid0
IGRpZmZlcmVudGlhdGUgTVRVIGFuZCBNUlUsIGluIHdoaWNoIGNhc2UKPiA+IHRoZSByZWNlaXZl
IGJ1ZmZlciB3aWxsIGJlIHJlZHVjZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUgd2hl
biBtdHUgaXMKPiA+IGxvd2VyZWQgZG93biB0byAxNTAwIGZyb20gOTAwMC4gCj4gSG93PyBEcml2
ZXIgcmVkdWNlZCB0aGUgbVh1IHRvIDE1MDAsIHNheSBpdCBpcyBpbXByb3ZlZCB0byBwb3N0IGJ1
ZmZlcnMgb2YgMTUwMCBieXRlcy4KPiAKPiBEZXZpY2UgZG9lc24ndCBrbm93IGFib3V0IGl0IGJl
Y2F1c2UgbXR1IGluIGNvbmZpZyBzcGFjZSBpcyBSTyBmaWVsZC4KPiBEZXZpY2Uga2VlcCBkcm9w
cGluZyA5SyBwYWNrZXRzIGJlY2F1c2UgYnVmZmVycyBwb3N0ZWQgYXJlIDE1MDAgYnl0ZXMuCj4g
VGhpcyBpcyBiZWNhdXNlIGRldmljZSBmb2xsb3dzIHRoZSBzcGVjICIgVGhlIGRldmljZSBNVVNU
IE5PVCBwYXNzIHJlY2VpdmVkIHBhY2tldHMgdGhhdCBleGNlZWQgbXR1Ii4KCgpUaGUgIm10dSIg
aGVyZSBpcyB0aGUgZGV2aWNlIGNvbmZpZyBmaWVsZCwgd2hpY2ggaXMKCiAgICAgICAgLyogRGVm
YXVsdCBtYXhpbXVtIHRyYW5zbWl0IHVuaXQgYWR2aWNlICovCgp0aGVyZSBpcyBubyBndWFyYW50
ZWUgZGV2aWNlIHdpbGwgbm90IGdldCBhIGJpZ2dlciBwYWNrZXQuCkFuZCB0aGVyZSBpcyBubyBn
dWFyYW50ZWUgc3VjaCBhIHBhY2tldCB3aWxsIGJlIGRyb3BwZWQKYXMgb3Bwb3NlZCB0byB3ZWRn
aW5nIHRoZSBkZXZpY2UgaWYgdXNlcnNwYWNlIGluc2lzdHMgb24KYWRkaW5nIHNtYWxsZXIgYnVm
ZmVycy4KCgo+IFNvLCBJIGFtIGxvc3Qgd2hhdCB2aXJ0aW8gbmV0IGRldmljZSB1c2VyIGFwcGxp
Y2F0aW9uIGlzIHRyeWluZyB0byBhY2hpZXZlIGJ5IHNlbmRpbmcgc21hbGxlciBwYWNrZXRzIGFu
ZCBkcm9wcGluZyBhbGwgcmVjZWl2ZSBwYWNrZXRzLgo+IChpdCBkb2VzbuKAmXQgaGF2ZSBhbnkg
cmVsYXRpb24gdG8gbWVyZ2VhYmxlIG9yIG90aGVyd2lzZSkuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
