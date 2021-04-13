Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C186BC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:33:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CF3613AE
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CF3613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27F5082F31;
	Tue, 13 Apr 2021 14:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3a62Ye0Yogjn; Tue, 13 Apr 2021 14:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0AA98193E;
	Tue, 13 Apr 2021 14:33:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 990E6C000C;
	Tue, 13 Apr 2021 14:33:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB75C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E14F82F31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Ewe-d4umgIK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:33:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 096258193E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618324424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03mb4LEKGQSjGCDEyQg3KiQjDam/TziPkhfoQlj9YcM=;
 b=cwYyv36Qg5F5Cbi9QMzwh7kdGRZjTn35dLqcBhayv9m3Q+65/bDE7TjpdOLvl4EhTvR7E7
 Fcj+1cyhHr0zIJo9woMrgFYZUOr14lfiSF8Xxo4O6Fhk6BZICx/52gklIoyAjwtGDgDmdG
 YsdB2wjxuqJeXsYV9MZDHbzX9gmeVyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-tBFzrOMnPAGdANcSVhlf9w-1; Tue, 13 Apr 2021 10:33:42 -0400
X-MC-Unique: tBFzrOMnPAGdANcSVhlf9w-1
Received: by mail-wm1-f70.google.com with SMTP id
 z2-20020a1cf4020000b029010f4ec9a348so3102621wma.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=03mb4LEKGQSjGCDEyQg3KiQjDam/TziPkhfoQlj9YcM=;
 b=cDF0YTL6XscfGOCm/I/KDnewAtEYrDNHjrCCWoIWPEE1/yuHQydRqmr3EY40MV7eua
 ZWBt7suTXGeVmUEKDNEKX6KSRMcxa56bFtbt84EvhO06nS8WPprb/BkHHju086i51ZYw
 EoZJPMzEnSwZLsKso8oyXPqIjc9wkxhKnkpMa651o8w6jRCkNZH65Zp/5RCX0DbYPZgw
 NjNR8yK1yMsLwOddsi7GdsTD7zM+BTOL3M7xMk0+kdmHoYFe1uIMItjmiNhjZ8szHf+9
 vQCbf+VTSs2vr059s/hN4UarhheVp9voiWPKRsgzWOaZeVKf2mwrmeT5dR2xR+bbtJoQ
 zU+A==
X-Gm-Message-State: AOAM533K2b4GZa3vcwgPlIfUreCn/mlemldS4cJ4aqIvs8V2rMn+b8KE
 ZExwJ4Ty5rdf2v9ZTHyr8fRkPqsBYqqPZG2enV+nnx4aztleUja0gWLktjHL/G5n1TWoxQVfRHn
 pDBiBC9ihqEPEroius2N6JgFHi0uDTcZA/Wfacce+/A==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr282044wmh.187.1618324421410; 
 Tue, 13 Apr 2021 07:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTe7rBlLKqCoWn++/O8Aw6yKwfkrflupGRE+nGP0iUf29tGd26k1V89INwAeu3NGikNplrxg==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr282029wmh.187.1618324421247; 
 Tue, 13 Apr 2021 07:33:41 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id c6sm19518494wri.32.2021.04.13.07.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 07:33:40 -0700 (PDT)
Date: Tue, 13 Apr 2021 10:33:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
Message-ID: <20210413100314-mutt-send-email-mst@kernel.org>
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-3-mst@redhat.com>
 <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
MIME-Version: 1.0
In-Reply-To: <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMDQ6NTM6MzJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS80LzEzIOS4i+WNiDE6NDcsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBUaGVyZSBhcmUgY3VycmVudGx5IHR3byBjYXNlcyB3aGVyZSB3ZSBwb2xsIFRYIHZx
IG5vdCBpbiByZXNwb25zZSB0byBhCj4gPiBjYWxsYmFjazogc3RhcnQgeG1pdCBhbmQgcnggbmFw
aS4gIFdlIGN1cnJlbnRseSBkbyB0aGlzIHdpdGggY2FsbGJhY2tzCj4gPiBlbmFibGVkIHdoaWNo
IGNhbiBjYXVzZSBleHRyYSBpbnRlcnJ1cHRzIGZyb20gdGhlIGNhcmQuICBVc2VkIG5vdCB0byBi
ZQo+ID4gYSBiaWcgaXNzdWUgYXMgd2UgcnVuIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCBidXQg
dGhhdCBpcyBubyBsb25nZXIgdGhlCj4gPiBjYXNlLCBhbmQgaW4gc29tZSBjYXNlcyB0aGUgcmF0
ZSBvZiBzcHVyaW91cyBpbnRlcnJ1cHRzIGlzIHNvIGhpZ2gKPiA+IGxpbnV4IGRldGVjdHMgdGhp
cyBhbmQgYWN0dWFsbHkga2lsbHMgdGhlIGludGVycnVwdC4KPiA+IAo+ID4gRml4IHVwIGJ5IGRp
c2FibGluZyB0aGUgY2FsbGJhY2tzIGJlZm9yZSBwb2xsaW5nIHRoZSB0eCB2cS4KPiA+IAo+ID4g
U2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+IC0t
LQo+ID4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyICsrCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gaW5kZXggODJlNTIwZDJj
YjEyLi4xNmQ1YWJlZDU4MmMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gQEAgLTE0MjksNiArMTQy
OSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcG9sbF9jbGVhbnR4KHN0cnVjdCByZWNlaXZlX3F1
ZXVlICpycSkKPiA+ICAgCQlyZXR1cm47Cj4gPiAgIAlpZiAoX19uZXRpZl90eF90cnlsb2NrKHR4
cSkpIHsKPiA+ICsJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gPiAgIAkJZnJlZV9v
bGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiA+ICAgCQlfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+
IAo+IAo+IEFueSByZWFzb24gdGhhdCB3ZSBkb24ndCBuZWVkIHRvIGVuYWJsZSB0aGUgY2IgaGVy
ZT8KCkdvb2QgcG9pbnQgLi4uIHByb2JhYmx5IG9ubHkgaWYgdGhlIHZxIGlzbid0IGVtcHR5IC4u
LgoKPiBBbmQgYXMgd2UgZGlzY3Vzc2VkIGluIHRoZSBwYXN0LCBpdCdzIHByb2JhYmx5IHRoZSB0
aW1lIHRvIGhhdmUgYSBzaW5nbGUKPiBOQVBJIGZvciBib3RoIHR4IGFuZCByeD8KPiAKPiBUaGFu
a3MKCgpEb25udS4gSSdkIGxpa2UgdG8gZ2V0IGEgbWluaW1hbCBidWdmaXggaW4sIHJlZmFjdG9y
aW5nIG9uIHRvcCAuLi4KCj4gCj4gPiAgIAl9Cj4gPiBAQCAtMTU4Miw2ICsxNTgzLDcgQEAgc3Rh
dGljIG5ldGRldl90eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5l
dF9kZXZpY2UgKmRldikKPiA+ICAgCWJvb2wgdXNlX25hcGkgPSBzcS0+bmFwaS53ZWlnaHQ7Cj4g
PiAgIAkvKiBGcmVlIHVwIGFueSBwZW5kaW5nIG9sZCBidWZmZXJzIGJlZm9yZSBxdWV1ZWluZyBu
ZXcgb25lcy4gKi8KPiA+ICsJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ICAgCWZy
ZWVfb2xkX3htaXRfc2ticyhzcSwgZmFsc2UpOwo+ID4gICAJaWYgKHVzZV9uYXBpICYmIGtpY2sp
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
