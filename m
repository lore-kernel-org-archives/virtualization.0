Return-Path: <SRS0=gqJU=JY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE75C433B4
	for <virtualization@archiver.kernel.org>; Tue, 27 Apr 2021 02:44:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A792613B0
	for <virtualization@archiver.kernel.org>; Tue, 27 Apr 2021 02:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A792613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0539D8316A;
	Tue, 27 Apr 2021 02:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjtXd-AwQen2; Tue, 27 Apr 2021 02:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADB1B82D2F;
	Tue, 27 Apr 2021 02:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D793C000F;
	Tue, 27 Apr 2021 02:44:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19F17C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 02:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7CCF60ABB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 02:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXQ3yuTL8JZh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 02:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9C51606B6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 02:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619491453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9t6HPD50NoeAQXyHmZQufw+PUx5Y2vTcwzjnMztmhfk=;
 b=i4LOmEFC57mgNtrAy80zAibP07ULajM2p26Gg9U4KC6pH9Z8FssmkAiCclYbPnbIDaryrq
 WOct7ZA1dvi49QA+QCXahVBDFVKGra9l4Ohb5Xxbu3ySypEoIzs3v4Fb55SJI12A3zZUr2
 6AIYwfo8qRjCOHtVbZiXlFKTjo06FD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-2UCijym4OnKKmfQixEZelQ-1; Mon, 26 Apr 2021 22:44:11 -0400
X-MC-Unique: 2UCijym4OnKKmfQixEZelQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 112AE1006C83;
 Tue, 27 Apr 2021 02:44:10 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-221.pek2.redhat.com
 [10.72.13.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E412B19D7D;
 Tue, 27 Apr 2021 02:44:01 +0000 (UTC)
Subject: Re: [PATCH] virtio-net: enable SRIOV
To: Arkadiusz Kudan <arkadiusz.kudan@codilime.com>,
 virtualization@lists.linux-foundation.org
References: <20210426102135.227802-1-arkadiusz.kudan@codilime.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <625a6618-bb59-8ccc-bf1c-e29ac556b590@redhat.com>
Date: Tue, 27 Apr 2021 10:43:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210426102135.227802-1-arkadiusz.kudan@codilime.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org,
 Miroslaw Walukiewicz <Miroslaw.Walukiewicz@intel.com>, mst@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvMjYg5LiL5Y2INjoyMSwgQXJrYWRpdXN6IEt1ZGFuIOWGmemBkzoKPiBXaXRo
IGluY3JlYXNpbmcgaW50ZXJlc3QgZm9yIHZpcnRpbywgTklDIGhhdmUgYXBwZWFyZWQgdGhhdCBw
cm92aWRlCj4gU1JJT1Ygd2l0aCBQRiBhcHBlYXJpbmcgaW4gdGhlIGhvc3QgYXMgYSB2aXJ0aW8g
bmV0d29yayBkZXZpY2UKPiBhbmQgcHJvYmFibHkgbW9yZSBzaW1pbGlhciBOSUNzIHdpbGwgZW1l
cmdlLgo+IGlnYl91aW8gb2YgRFBESyBvciBwY2ktcGYtc3R1YiBjYW4gYmUgdXNlZCB0byBwcm92
aWRlIFNSSU9WLAo+IGhvd2V2ZXIgdGhlcmUgYXJlIGh5cGVydmlzb3JzL1ZNTXMgdGhhdCByZXF1
aXJlIFZGcywgd2hpY2ggYXJlCj4gdG8gYmUgUENJIHBhc3N0aHJ1ZWQgdG8gYSBWTSwgdG8gaGF2
ZSBpdHMgUEYgd2l0aCBuZXR3b3JrCj4gcmVwcmVzZW50YXRpb24gaW4gdGhlIGtlcm5lbC4gRm9y
IHZpcnRpby1uZXQgYmFzZWQgUEZzLAo+IHZpcnRpby1uZXQgY291bGQgZG8gdGhhdCBieSBwcm92
aWRpbmcgYm90aCBTUklPViBpbnRlcmZhY2UgYW5kCj4gbmV0ZGV2IHJlcHJlc2VudGF0aW9uLgo+
Cj4gRW5hYmxlIFNSSU9WIHZpYSBWSVJUSU9fRl9TUl9JT1YgZmVhdHVyZSBiaXQgaWYgdGhlIGRl
dmljZQo+IHN1cHBvcnRzIGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJrYWRpdXN6IEt1ZGFuIDxh
cmthZGl1c3oua3VkYW5AY29kaWxpbWUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pcm9zbGF3IFdh
bHVraWV3aWN6IDxNaXJvc2xhdy5XYWx1a2lld2ljekBpbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDA4MjRlNjk5OWU0OS4uYTAzYWE3ZTk5Njg5IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+IEBAIC0zMjQ5LDYgKzMyNDksNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRpb19k
ZXZpY2VfaWQgaWRfdGFibGVbXSA9IHsKPiAgIAo+ICAgc3RhdGljIHVuc2lnbmVkIGludCBmZWF0
dXJlc1tdID0gewo+ICAgCVZJUlRORVRfRkVBVFVSRVMsCj4gKwlWSVJUSU9fRl9TUl9JT1YsCj4g
ICB9OwoKClNvIEknbSBzdXByaXNlZCB0aGF0IGl0IG5lZWRzIHRvIGJlIGVuYWJsZWQgcGVyIGRl
dmljZS4gV2UgaGFkOgoKc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCnsKIMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZkZXYpOwogwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBjaV9kZXYgPSB2cF9kZXYtPnBjaV9kZXY7CgogwqDC
oMKgwqDCoMKgwqAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfU1JfSU9WKSkgJiYK
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX2ZpbmRf
ZXh0X2NhcGFiaWxpdHkocGNpX2RldiwgClBDSV9FWFRfQ0FQX0lEX1NSSU9WKSkKIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3ZpcnRpb19zZXRfYml0KHZkZXYsIFZJUlRJT19GX1NS
X0lPVik7Cn0KCkFuZCBJIGhhZCB1c2VkIHRoaXMgZHJpdmVyIGZvciBTUklPViB2aXJ0aW8tcGNp
IGhhcmR3YXJlIGZvciBtb3JlIHRoYW4gCm9uZSB5ZWFyLgoKVGhhbmtzCgoKPiAgIAo+ICAgc3Rh
dGljIHVuc2lnbmVkIGludCBmZWF0dXJlc19sZWdhY3lbXSA9IHsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
