Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03248C433ED
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 07:54:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AD261370
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 07:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AD261370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13DC583D17;
	Wed, 12 May 2021 07:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yvKs-qb7IP2f; Wed, 12 May 2021 07:54:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6D183D0E;
	Wed, 12 May 2021 07:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47A77C000D;
	Wed, 12 May 2021 07:53:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0AF6C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA01E4019A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhMguWROvpa4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:53:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5079340015
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620806035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLqmlEuhp9K1sh6b2eNpoKDd7Zyatg2EsHuk0cVSHtk=;
 b=WfE4gz+wBlgT29vm0OEus9W1AYOZbdvOaW4Er6BXtkCR6kg9SSzeRSJE/piC5TkUSrXkqw
 cGpIqPfhtS06m2iDI1yRkz9ZNGvr8XZtaIuioQhnzf0sXkgJdCNqNDFlwwib92nBB9mkZY
 O/Bpe9VnPdjXdRHN3CpYWHRWbWavtMQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-fM3S8tl1MZSqwjvpwWCqQA-1; Wed, 12 May 2021 03:53:51 -0400
X-MC-Unique: fM3S8tl1MZSqwjvpwWCqQA-1
Received: by mail-wm1-f71.google.com with SMTP id
 o126-20020a1c28840000b0290149b8f27c99so2699239wmo.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oLqmlEuhp9K1sh6b2eNpoKDd7Zyatg2EsHuk0cVSHtk=;
 b=GEQ+BhEaguJwzTo5AbehujZYRM7V5WAM/84Cd2jHBPeEVv4fG7dfCxUiat0RE6vvRN
 Cbu+IxnANR1PSct2pC0Qg2BnkBJuh3G0Bn50b8Yig9+GT8GZigAmo8aULgLuxpo4H9Ca
 alZXggzzB0CQgO2OK67zxO4GF6XW8HJoQrJtm5cHAqNMyVNGIroiXo4Ov0V4YE1vU06A
 GYyOm9XeviR/rzMFyOyPAhsjWNJGxEwAjFT2EwGAPfk02Rdgo8mExXcCFErXpcaN909D
 ZfJMKjhqmqsT8u5HJEJ131C2ltn5lsMwniIVEtbVA79MUzq01fUtLKVH22rOIAFW1nQT
 R4Pw==
X-Gm-Message-State: AOAM533z4FaBrXaSb79eAuIEHGkZvTE32qrWOKwGzH17tqJruVtEkeH9
 jJbPGkt9hGBdLlWXEhReAzHPSLxPPbjgB/8X46B3iPpizoVwwMqLPcWdFVvtf+Rq1LTKwYykuK3
 zk13epRiDUZyaWc2u8I9vccbDN6ONjDj/3DySRvD0pg==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr44251691wru.235.1620806030328; 
 Wed, 12 May 2021 00:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWcYC1ZJV5ndKMfy0hWhlyn1mCsM2dWyCgry1CQpLkZu4SNNu5gsMBIrowg+nFlYrSK1Mh7g==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr44251663wru.235.1620806030104; 
 Wed, 12 May 2021 00:53:50 -0700 (PDT)
Received: from redhat.com ([2a10:8004:640e:0:d1db:1802:5043:7b85])
 by smtp.gmail.com with ESMTPSA id r2sm31252563wrv.39.2021.05.12.00.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 May 2021 00:53:49 -0700 (PDT)
Date: Wed, 12 May 2021 03:53:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210511061740-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mapfelba@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elic@nvidia.com,
 Lingshan Zhu <lingshan.zhu@intel.com>
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgMDQ6NDM6MTNBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiAKPiAtLS0tLSDljp/lp4vpgq7ku7YgLS0tLS0KPiA+IAo+ID4g5ZyoIDIwMjEvNC8y
MSDkuIvljYg0OjAzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiBPbiBXZWQsIEFw
ciAyMSwgMjAyMSBhdCAwMzo0MTozNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPj4g
5ZyoIDIwMjEvNC8xMiDkuIvljYg1OjIzLCBKYXNvbiBXYW5nIOWGmemBkzoKPiA+ID4+PiDlnKgg
MjAyMS80LzEyIOS4i+WNiDU6MDksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPiA+Pj4+
IE9uIE1vbiwgQXByIDEyLCAyMDIxIGF0IDAyOjM1OjA3UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4gPiA+Pj4+PiDlnKggMjAyMS80LzEwIOS4iuWNiDEyOjA0LCBNaWNoYWVsIFMuIFRzaXJr
aW4g5YaZ6YGTOgo+ID4gPj4+Pj4+IE9uIEZyaSwgQXByIDA5LCAyMDIxIGF0IDEyOjQ3OjU1UE0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Pj4+Pj4+IOWcqCAyMDIxLzQvOCDkuIvljYgx
MTo1OSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiA+ID4+Pj4+Pj4+IE9uIFRodSwgQXBy
IDA4LCAyMDIxIGF0IDA0OjI2OjQ4UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Pj4+
Pj4+Pj4gVGhpcyBwYXRjaCBtYW5kYXRlcyAxLjAgZm9yIHZEUEEgZGV2aWNlcy4gVGhlIGdvYWwg
aXMgdG8gaGF2ZSB0aGUKPiA+ID4+Pj4+Pj4+PiBzZW1hbnRpYyBvZiBub3JtYXRpdmUgc3RhdGVt
ZW50IGluIHRoZSB2aXJ0aW8KPiA+ID4+Pj4+Pj4+PiBzcGVjIGFuZCBlbGltaW5hdGUgdGhlCj4g
PiA+Pj4+Pj4+Pj4gYnVyZGVuIG9mIHRyYW5zaXRpb25hbCBkZXZpY2UgZm9yIGJvdGggdkRQQSBi
dXMgYW5kIHZEUEEgcGFyZW50Lgo+ID4gPj4+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+Pj4gdUFQSSBzZWVt
cyBmaW5lIHNpbmNlIGFsbCB0aGUgdkRQQSBwYXJlbnQgbWFuZGF0ZXMKPiA+ID4+Pj4+Pj4+PiBW
SVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggaW1wbGllcyAxLjAgZGV2aWNlcy4KPiA+ID4+
Pj4+Pj4+Pgo+ID4gPj4+Pj4+Pj4+IEZvciBsZWdhY3kgZ3Vlc3RzLCBpdCBjYW4gc3RpbGwgd29y
ayBzaW5jZSBRZW11IHdpbGwgbWVkaWF0ZSB3aGVuCj4gPiA+Pj4+Pj4+Pj4gbmVjZXNzYXJ5IChl
LmcgZG9pbmcgdGhlIGVuZGlhbiBjb252ZXJzaW9uKS4KPiA+ID4+Pj4+Pj4+Pgo+ID4gPj4+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+
Pj4+Pj4+PiBIbW0uIElmIHdlIGRvIHRoaXMsIGRvbid0IHdlIHN0aWxsIGhhdmUgYSBwcm9ibGVt
IHdpdGgKPiA+ID4+Pj4+Pj4+IGxlZ2FjeSBkcml2ZXJzIHdoaWNoIGRvbid0IGFjayAxLjA/Cj4g
PiA+Pj4+Pj4+IFllcywgYnV0IGl0J3Mgbm90IHNvbWV0aGluZyB0aGF0IGlzIGludHJvZHVjZWQg
aW4gdGhpcwo+ID4gPj4+Pj4+PiBjb21taXQuIFRoZSBsZWdhY3kKPiA+ID4+Pj4+Pj4gZHJpdmVy
IG5ldmVyIHdvcmsgLi4uCj4gPiA+Pj4+Pj4gTXkgcG9pbnQgaXMgdGhpcyBuZWl0aGVyIGZpeGVz
IG9yIHByZXZlbnRzIHRoaXMuCj4gPiA+Pj4+Pj4KPiA+ID4+Pj4+PiBTbyBteSBzdWdnZXN0aW9u
IGlzIHRvIGZpbmFsbHkgYWRkIGlvY3RscyBhbG9uZyB0aGUgbGluZXMKPiA+ID4+Pj4+PiBvZiBQ
Uk9UT0NPTF9GRUFUVVJFUyBvZiB2aG9zdC11c2VyLgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gVGhl
biB0aGF0IG9uZSBjYW4gaGF2ZSBiaXRzIGZvciBsZWdhY3kgbGUsIGxlZ2FjeSBiZSBhbmQgbW9k
ZXJuLgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gQlRXIEkgbG9va2VkIGF0IHZob3N0LXVzZXIgYW5k
IGl0IGRvZXMgbm90IGxvb2sgbGlrZSB0aGF0Cj4gPiA+Pj4+Pj4gaGFzIGEgc29sdXRpb24gZm9y
IHRoaXMgcHJvYmxlbSBlaXRoZXIsIHJpZ2h0Pwo+ID4gPj4+Pj4gUmlnaHQuCj4gPiA+Pj4+Pgo+
ID4gPj4+Pj4KPiA+ID4+Pj4+Pj4+IE5vdGUgMS4wIGFmZmVjdHMgcmluZyBlbmRpYW5uZXNzIHdo
aWNoIGlzIG5vdCBtZWRpYXRlZCBpbiBRRU1VCj4gPiA+Pj4+Pj4+PiBzbyBRRU1VIGNhbid0IHBy
ZXRlbmQgdG8gZGV2aWNlIGd1ZXN0IGlzIDEuMC4KPiA+ID4+Pj4+Pj4gUmlnaHQsIEkgcGxhbiB0
byBzZW5kIHBhdGNoZXMgdG8gZG8gbWVkaWF0aW9uIGluIHRoZQo+ID4gPj4+Pj4+PiBRZW11IHRv
IHVuYnJlYWsgbGVnYWN5Cj4gPiA+Pj4+Pj4+IGRyaXZlcnMuCj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+
Pj4+IFRoYW5rcwo+ID4gPj4+Pj4+IEkgZnJhbmtseSB0aGluayB3ZSdsbCBuZWVkIFBST1RPQ09M
X0ZFQVRVUkVTIGFueXdheSwgaXQncwo+ID4gPj4+Pj4+IHRvbyB1c2VmdWwgLi4uCj4gPiA+Pj4+
Pj4gc28gd2h5IG5vdCB0ZWFjaCBkcml2ZXJzIGFib3V0IGl0IGFuZCBiZSBkb25lIHdpdGggaXQ/
IFlvdQo+ID4gPj4+Pj4+IGNhbid0IGVtdWxhdGUKPiA+ID4+Pj4+PiBsZWdhY3kgb24gbW9kZXJu
IGluIGEgY3Jvc3MgZW5kaWFuIHNpdHVhdGlvbiBiZWNhdXNlIG9mIHZyaW5nCj4gPiA+Pj4+Pj4g
ZW5kaWFuLW5lc3MgLi4uCj4gPiA+Pj4+PiBTbyB0aGUgcHJvYmxlbSBzdGlsbC4gVGhpcyBjYW4g
b25seSB3b3JrIHdoZW4gdGhlIGhhcmR3YXJlIGNhbiBzdXBwb3J0Cj4gPiA+Pj4+PiBsZWdhY3kg
dnJpbmcgZW5kaWFuLW5lc3MuCj4gPiA+Pj4+Pgo+ID4gPj4+Pj4gQ29uc2lkZXI6Cj4gPiA+Pj4+
Pgo+ID4gPj4+Pj4gMSkgdGhlIGxlYWdjeSBkcml2ZXIgc3VwcG9ydCBpcyBub24tbm9ybWF0aXZl
IGluIHRoZSBzcGVjCj4gPiA+Pj4+PiAyKSBzdXBwb3J0IGEgdHJhbnNpdGlvbmFsIGRldmljZSBp
biB0aGUga2VucmVsIG1heSByZXF1aXJlcyB0aGUKPiA+ID4+Pj4+IGhhcmR3YXJlCj4gPiA+Pj4+
PiBzdXBwb3J0IGFuZCBhIGJ1cmRlbiBvZiBrZXJuZWwgY29kZXMKPiA+ID4+Pj4+Cj4gPiA+Pj4+
PiBJJ2QgcmF0aGVyIHNpbXBseSBkcm9wIHRoZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQKPiA+ID4+
Pj4gTXkgcG9pbnQgaXMgdGhpcyBwYXRjaCBkb2VzIG5vdCBkcm9wIGxlZ2FjeSBzdXBwb3J0LiBJ
dCBtZXJlbHkgbWFuZGF0ZXMKPiA+ID4+Pj4gbW9kZXJuIHN1cHBvcnQuCj4gPiA+Pj4KPiA+ID4+
PiBJIGFtIG5vdCBzdXJlIEkgZ2V0IGhlcmUuIFRoaXMgcGF0Y2ggZmFpbHMgdGhlIHNldF9mZWF0
dXJlIGlmIFZFUlNJT05fMQo+ID4gPj4+IGlzIG5vdCBuZWdvdGlhdGVkLiBUaGlzIG1lYW5zOgo+
ID4gPj4+Cj4gPiA+Pj4gMSkgdkRQQSBwcmVzZW50cyBhIG1vZGVybiBkZXZpY2UgaW5zdGVhZCBv
ZiB0cmFuc2l0b25hbCBkZXZpY2UKPiA+ID4+PiAyKSBsZWdhY3kgZHJpdmVyIGNhbid0IGJlIHBy
b2JlZAo+ID4gPj4+Cj4gPiA+Pj4gV2hhdCBJJ20gbWlzc2luZz8KPiA+ID4+Cj4gPiA+PiBIaSBN
aWNoYWVsOgo+ID4gPj4KPiA+ID4+IERvIHlvdSBhZ3JlZSB0byBmaW5kIHRoZSB3YXkgdG8gcHJl
c2VudCBtb2Rlcm4gZGV2aWNlPyBXZSBuZWVkIGEKPiA+ID4+IGNvbmNsdXNpb24KPiA+ID4+IHRv
IG1ha2UgdGhlIG5ldGxpbmsgQVBJIHdvcmsgdG8gbW92ZSBmb3J3YXJkLgo+ID4gPj4KPiA+ID4+
IFRoYW5rcwo+ID4gPiBJIHRoaW5rIHdlIG5lZWQgYSB3YXkgdG8gc3VwcG9ydCBsZWdhY3kgd2l0
aCBubyBkYXRhIHBhdGggb3ZlcmhlYWQuIHFlbXUKPiA+ID4gc2V0dGluZyBWRVJTSU9OXzEgZm9y
IGEgbGVnYWN5IGd1ZXN0IGFmZmVjdHMgdGhlIHJpbmcgZm9ybWF0IHNvIGl0IGRvZXMKPiA+ID4g
bm90IHJlYWxseSB3b3JrLiBUaGlzIHNlZW1zIHRvIHJ1bGUgb3V0IGVtdWxhdGluZyBjb25maWcg
c3BhY2UgZW50aXJlbHkKPiA+ID4gaW4gdXNlcnNwYWNlLgo+ID4gCj4gPiAKPiA+IFNvIEknZCBy
YXRoZXIgZHJvcCB0aGUgbGVnYWN5IHN1cHBvcnQgaW4gdGhpcyBjYXNlLiBJdCBuZXZlciB3b3Jr
IGZvcgo+ID4gdkRQQSBpbiB0aGUgcGFzdCBhbmQgdmlydGlvLXZEUEEgZG9lc24ndCBldmVuIG5l
ZWQgdGhhdC4gTm90ZSB0aGF0Cj4gPiBBQ0NFU1NfUExBVEZPUk0gaXMgbWFuZGF0ZWQgZm9yIGFs
bCB0aGUgdkRQQSBwYXJlbnRzIHJpZ2h0IG5vdyB3aGljaAo+ID4gaW1wbGllcyBtb2Rlcm4gZGV2
aWNlIGFuZCBMRS4gSSB3b25kZXIgd2hhdCdzIHRoZSB2YWx1ZSBmb3Igc3VwcG9ydGluZwo+ID4g
bGVnYWN5IGluIHRoaXMgY2FzZSBvciBkbyB3ZSByZWFsbHkgZW5jb3VyYWdlIHZlbmRvcnMgdG8g
c2hpcCBjYXJkIHdpdGgKPiA+IGxlZ2FjeSBzdXBwb3J0IChlLmcgZW5kaWFuIHN1cHBvcnQgaW4g
dGhlIGhhcmR3YXJlKT8KPiAKPiBIaSBNaWNoYWVsOgo+IAo+IEFueSB0aG91Z2h0cyBvbiB0aGlz
IGFwcHJvYWNoPwo+IAo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBkcm9wcGluZyBsZWdhY3kg
c3VwcG9ydCB3aWxsIHNpbXBsaWZ5IGEgbG90IG9mIHN0dWZmcy4KPiAKPiBUaGFua3MKClNvIGJh
c2ljYWxseSB0aGUgbWFpbiBjb25kaXRpb24gaXMgdGhhdCBzdHJvbmcgbWVtb3J5IGJhcnJpZXJz
IGFyZW4ndApuZWVkZWQgZm9yIHZpcnRpbywgc21wIGJhcnJpZXJzIGFyZSBlbm91Z2guCkFyZSB0
aGVyZSBhcmNoaXRlY3R1cmVzIGJlc2lkZXMgeDg2ICh3aGVyZSBpdCdzIGtpbmQgb2YgdHJ1ZSAt
IGFzIGxvbmcgYXMKb25lIGRvZXMgbm90IHVzZSBub24tdGVtcG9yYWxzKSB3aGVyZSB0aGF0IGlz
IHRydWU/CklmIGFsbCB0aGVzZSBhcmNoaXRlY3R1cmVzIGFyZSBMRSB0aGVuIHdlIGRvbid0IG5l
ZWQgdG8gd29ycnkKYWJvdXQgZW5kaWFuIHN1cHBvcnQgaW4gdGhlIGhhcmR3YXJlLgoKSW4gb3Ro
ZXIgd29yZHMgSSBndWVzcyB5ZXMgd2UgY291bGQgaGF2ZSBxZW11IGxpbWl0IHRoaW5ncyB0byB4
ODYgYW5kCnRoZW4ganVzdCBwcmV0ZW5kIHRvIHRoZSBjYXJkIHRoYXQgaXQncyB2aXJ0aW8gMS4K
U28gZW5kaWFuLW5lc3Mgd2UgY2FuIGFkZHJlc3MuCgpQcm9ibGVtIGlzIHZpcnRpbyAxIGhhcyBl
ZmZlY3RzIGJleW9uZCB0aGlzLiB0aGluZ3MgbGlrZSBoZWFkZXIgc2l6ZQp3aXRoIG1lcmdlYWJs
ZSBidWZmZXJzIG9mZiBmb3IgdmlydGlvIG5ldC4KClNvIEkgYW0gaW5jbGluZWQgdG8gc2F5IGxl
dCB1cyBub3QgZG8gdGhlICJwcmV0ZW5kIGl0J3MgdmlydGlvIDEiIGdhbWUKaW4gcWVtdS4gIExl
dCB1cyBiZSBob25lc3QgdG8gdGhlIGNhcmQgYWJvdXQgd2hhdCBoYXBwZW5zLgpCdXQgaWYgeW91
IHdhbnQgdG8gbGltaXQgdGhpbmdzIHRvIHg4NiBlaXRoZXIgaW4ga2VybmVsIG9yIGluIHFlbXUs
CnRoYXQncyBvayBieSBtZS4KCj4gCj4gPiAKPiA+IAo+ID4gPgo+ID4gPiBTbyBJIHRoaW5rIHdl
IHNob3VsZCBhZGQgYW4gaW9jdGwgYWxvbmcgdGhlIGxpbmVzIG9mCj4gPiA+IHByb3RvY29sIGZl
YXR1cmVzLiBUaGVuIEkgdGhpbmsgd2UgY2FuIHJlc2VydmUgZmVhdHVyZSBiaXRzCj4gPiA+IGZv
ciBjb25maWcgc3BhY2UgZm9ybWF0OiBsZWdhY3kgTEUsIGxlZ2FjeSBCRSwgbW9kZXJuLgo+ID4g
Cj4gPiAKPiA+IFdlIGhhZCBWSE9TVF9TRVRfVlJJTkdfRU5ESUFOIGJ1dCB0aGlzIHdpbGwgY29t
cGxpY2F0ZXMgYm90aCB0aGUgdkRQQQo+ID4gcGFyZW50IGFuZCBtYW5hZ2VtZW50LiBXaGF0J3Mg
bW9yZSBpbXBvcnRhbnQsIGxlZ2FjeSBiZWhhdmlvdXIgaXMgbm90Cj4gPiByZXN0cmljdGllZCBi
eSB0aGUgc3BlYy4KPiA+IAo+ID4gCj4gPiA+Cj4gPiA+IFF1ZXJ5aW5nIHRoZSBmZWF0dXJlIGJp
dHMgd2lsbCBwcm92aWRlIHVzIHdpdGggaW5mbyBhYm91dAo+ID4gPiB3aGF0IGRvZXMgdGhlIGRl
dmljZSBzdXBwb3J0LiBBY2tpbmcgdGhlbSB3aWxsIHRlbGwgZGV2aWNlCj4gPiA+IHdoYXQgZG9l
cyBndWVzdCBuZWVkLgo+ID4gCj4gPiAKPiA+IEkgdGhpbmsgdGhpcyBjYW4gd29yaywgYnV0IEkg
d29uZGVyIGhvdyBtdWNoIHdlIGNhbiBnYWluIGZyb20gc3VjaAo+ID4gY29tcGxleGl0aXkuCj4g
PiAKPiA+IFRoYW5rcwo+ID4gCj4gPiAKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4KPiA+
ID4+Pgo+ID4gPj4+Pj4gdG8gaGF2ZSBhIHNpbXBsZSBhbmQgZWFzeQo+ID4gPj4+Pj4gYWJzdGFy
Y3Rpb24gaW4gdGhlIGtlbnJlbC4gRm9yIGxlZ2FjeSBkcml2ZXIgaW4gdGhlIGd1ZXN0LAo+ID4g
Pj4+Pj4gaHlwZXJ2aXNvciBpcyBpbgo+ID4gPj4+Pj4gY2hhcmdlIG9mIHRoZSBtZWRpYXRpb246
Cj4gPiA+Pj4+Pgo+ID4gPj4+Pj4gMSkgY29uZmlnIHNwYWNlIGFjY2VzcyBlbmRpYW4gY29udmVy
c2lvbgo+ID4gPj4+Pj4gMikgdXNpbmcgc2hhZG93IHZpcnRxdWV1ZSB0byBjaGFuZ2UgdGhlIGVu
ZGlhbiBpbiB0aGUgdnJpbmcKPiA+ID4+Pj4+Cj4gPiA+Pj4+PiBUaGFua3MKPiA+ID4+Pj4gSSdk
IGxpa2UgdG8gYXZvaWQgc2hhZG93IHZpcnRxdWV1ZSBoYWNrcyBpZiBhdCBhbGwgcG9zc2libGUu
Cj4gPiA+Pj4+IExhc3QgSSBjaGVja2VkIHBlcmZvcm1hbmNlIHdhc24ndCBtdWNoIGJldHRlciB0
aGFuIGp1c3QgZW11bGF0aW5nCj4gPiA+Pj4+IHZpcnRpbyBpbiBzb2Z0d2FyZS4KPiA+ID4+Pgo+
ID4gPj4+IEkgdGhpbmsgdGhlIGxlZ2FjeSBkcml2ZXIgc3VwcG9ydCBpcyBqdXN0IGEgbmljZSB0
byBoYXZlLiBPciBkbyB5b3Ugc2VlCj4gPiA+Pj4gYW55IHZhbHVlIHRvIHRoYXQ/IEkgZ3Vlc3Mg
Zm9yIG1lbGxhbm94IGFuZCBpbnRlbCwgb25seSBtb2Rlcm4gZGV2aWNlIGlzCj4gPiA+Pj4gc3Vw
cG9ydGVkIGluIHRoZSBoYXJkd2FyZS4KPiA+ID4+Pgo+ID4gPj4+IFRoYW5rcwo+ID4gPj4+Cj4g
PiA+Pj4KPiA+ID4+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+Pgo+ID4gPj4+Pj4+Pj4+IC0tLQo+ID4gPj4+
Pj4+Pj4+ICDCoMKgwqAgaW5jbHVkZS9saW51eC92ZHBhLmggfCA2ICsrKysrKwo+ID4gPj4+Pj4+
Pj4+ICDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+ID4gPj4+Pj4+Pj4+
Cj4gPiA+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPiA+ID4+Pj4+Pj4+PiBpbmRleCAwZmVmZWI5NzY4NzcuLmNmZGU0ZWM5
OTliNCAxMDA2NDQKPiA+ID4+Pj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4g
Pj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiA+Pj4+Pj4+Pj4gQEAgLTYs
NiArNiw3IEBACj4gPiA+Pj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+
Cj4gPiA+Pj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4gPiA+
Pj4+Pj4+Pj4gIMKgwqDCoCAjaW5jbHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPiA+ID4+Pj4+
Pj4+PiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+ID4gPj4+Pj4+Pj4+
ICDCoMKgwqAgLyoqCj4gPiA+Pj4+Pj4+Pj4gIMKgwqDCoMKgICogdkRQQSBjYWxsYmFjayBkZWZp
bml0aW9uLgo+ID4gPj4+Pj4+Pj4+IEBAIC0zMTcsNiArMzE4LDExIEBAIHN0YXRpYyBpbmxpbmUg
aW50Cj4gPiA+Pj4+Pj4+Pj4gdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1NjQKPiA+ID4+Pj4+Pj4+PiBmZWF0dXJlcykKPiA+ID4+Pj4+Pj4+PiAgwqDCoMKgIHsK
PiA+ID4+Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4gPiA+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIC8qIE1hbmRhdGluZyAxLjAgdG8gaGF2ZSBzZW1hbnRpY3Mgb2YKPiA+ID4+Pj4+Pj4+PiBu
b3JtYXRpdmUgc3RhdGVtZW50cyBpbgo+ID4gPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
dGhlIHNwZWMuICovCj4gPiA+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghKGZlYXR1cmVz
ICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKSkKPiA+ID4+Pj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+Pj4+Pj4+Pj4gKwo+ID4gPj4+Pj4+Pj4+ICDCoMKg
wqDCoMKgwqDCoCB2ZGV2LT5mZWF0dXJlc192YWxpZCA9IHRydWU7Cj4gPiA+Pj4+Pj4+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG9wcy0+c2V0X2ZlYXR1cmVzKHZkZXYsIGZlYXR1
cmVzKTsKPiA+ID4+Pj4+Pj4+PiAgwqDCoMKgIH0KPiA+ID4+Pj4+Pj4+PiAtLQo+ID4gPj4+Pj4+
Pj4+IDIuMjUuMQo+ID4gCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
