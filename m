Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFECC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 12:08:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D1164F29
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 12:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D1164F29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A30983E09;
	Tue,  2 Mar 2021 12:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jv9zCsoQkPUB; Tue,  2 Mar 2021 12:08:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E99781A1C;
	Tue,  2 Mar 2021 12:08:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 237EEC000A;
	Tue,  2 Mar 2021 12:08:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E171BC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF82183A15
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jSZOj6s5pcHB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:08:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B159881A1C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614686903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGBva5DKxG/huAqoNDsaExI9eBFrJH4w3rCGjKd3xQk=;
 b=Ov5xxR18Kaf70Kx0zqqvfsMQCF6l76gJ8/CNmnX5QthXMCCOM8EKeE78oxTzU7IrKeP8i7
 lB5PH3gaCQbNxIEcbAV1CT0RXL3PiycElaMRbh6JLVlzm49KnaciB+YRsF3xQPgdjceUaX
 0aWEWSrcw63VlLQ3/f61IUaeXPbL1pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-i0WMWG6vPjGrowIkJsoFNQ-1; Tue, 02 Mar 2021 07:08:21 -0500
X-MC-Unique: i0WMWG6vPjGrowIkJsoFNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6FEA1868408;
 Tue,  2 Mar 2021 12:08:19 +0000 (UTC)
Received: from gondolin (ovpn-113-150.ams2.redhat.com [10.36.113.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C84C60C05;
 Tue,  2 Mar 2021 12:08:14 +0000 (UTC)
Date: Tue, 2 Mar 2021 13:08:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210302130812.6227f176.cohuck@redhat.com>
In-Reply-To: <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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

T24gTW9uLCAxIE1hciAyMDIxIDExOjUxOjA4ICswODAwCkphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPiBPbiAyMDIxLzMvMSA1OjI1IOS4iuWNiCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gT24gRnJpLCBGZWIgMjYsIDIwMjEgYXQgMDQ6MTk6MTZQTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZTogIAo+ID4+IE9uIDIwMjEvMi8yNiAyOjUzIOS4iuWNiCwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOiAgCgo+ID4+PiBDb25mdXNlZC4gV2hhdCBpcyB3cm9uZyB3
aXRoIHRoZSBhYm92ZT8gSXQgbmV2ZXIgcmVhZHMgdGhlCj4gPj4+IGZpZWxkIHVubGVzcyB0aGUg
ZmVhdHVyZSBoYXMgYmVlbiBvZmZlcmVkIGJ5IGRldmljZS4gIAo+ID4+Cj4gPj4gU28gdGhlIHNw
ZWMgc2FpZDoKPiA+Pgo+ID4+ICIKPiA+Pgo+ID4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQt
b25seSBmaWVsZCwgbWF4X3ZpcnRxdWV1ZV9wYWlycyBvbmx5IGV4aXN0cyBpZgo+ID4+IFZJUlRJ
T19ORVRfRl9NUSBpcyBzZXQuCj4gPj4KPiA+PiAiCj4gPj4KPiA+PiBJZiBJIHJlYWQgdGhpcyBj
b3JyZWN0bHksIHRoZXJlIHdpbGwgYmUgbm8gbWF4X3ZpcnRxdWV1ZV9wYWlycyBmaWVsZCBpZiB0
aGUKPiA+PiBWSVJUSU9fTkVUX0ZfTVEgaXMgbm90IG9mZmVyZWQgYnkgZGV2aWNlPyBJZiB5ZXMg
dGhlIG9mZnNldG9mKCkgdmlvbGF0ZXMKPiA+PiB3aGF0IHNwZWMgc2FpZC4KPiA+Pgo+ID4+IFRo
YW5rcyAgCj4gPiBJIHRoaW5rIHRoYXQncyBhIG1pc3VuZGVyc3RhbmRpbmcuIFRoaXMgdGV4dCB3
YXMgbmV2ZXIgaW50ZW5kZWQgdG8KPiA+IGltcGx5IHRoYXQgZmllbGQgb2Zmc2V0cyBjaGFuZ2Ug
YmVhc2VkIG9uIGZlYXR1cmUgYml0cy4KPiA+IFdlIGhhZCB0aGlzIHBhaW4gd2l0aCBsZWdhY3kg
YW5kIHdlIG5ldmVyIHdhbnRlZCB0byBnbyBiYWNrIHRoZXJlLgo+ID4KPiA+IFRoaXMgbWVyZWx5
IGltcGxpZXMgdGhhdCB3aXRob3V0IFZJUlRJT19ORVRfRl9NUSB0aGUgZmllbGQKPiA+IHNob3Vs
ZCBub3QgYmUgYWNjZXNzZWQuIEV4aXN0cyBpbiB0aGUgc2Vuc2UgImlzIGFjY2Vzc2libGUgdG8g
ZHJpdmVyIi4KPiA+Cj4gPiBMZXQncyBqdXN0IGNsYXJpZnkgdGhhdCBpbiB0aGUgc3BlYywgam9i
IGRvbmUuICAKPiAKPiAKPiBPaywgYWdyZWUuIFRoYXQgd2lsbCBtYWtlIHRoaW5ncyBtb3JlIGVh
aXNlci4KClllcywgdGhhdCBtYWtlcyBtdWNoIG1vcmUgc2Vuc2UuCgpXaGF0IGFib3V0IGFkZGlu
ZyB0aGUgZm9sbG93aW5nIHRvIHRoZSAiQmFzaWMgRmFjaWxpdGllcyBvZiBhIFZpcnRpbwpEZXZp
Y2UvRGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UiIHNlY3Rpb24gb2YgdGhlIHNwZWM6CgoiSWYg
YW4gb3B0aW9uYWwgY29uZmlndXJhdGlvbiBmaWVsZCBkb2VzIG5vdCBleGlzdCwgdGhlIGNvcnJl
c3BvbmRpbmcKc3BhY2UgaXMgc3RpbGwgcHJlc2VudCwgYnV0IHJlc2VydmVkLiIKCihEbyB3ZSBu
ZWVkIHRvIHNwZWNpZnkgd2hhdCBhIGRldmljZSBuZWVkcyB0byBkbyBpZiB0aGUgZHJpdmVyIHRy
aWVzIHRvCmFjY2VzcyBhIG5vbi1leGlzdGluZyBmaWVsZD8gV2UgY2Fubm90IHJlYWxseSBtYWtl
IGFzc3VtcHRpb25zIGFib3V0CmNvbmZpZyBzcGFjZSBhY2Nlc3NlczsgdmlydGlvLWNjdyBjYW4g
anVzdCBjb3B5IGEgY2h1bmsgb2YgY29uZmlnIHNwYWNlCnRoYXQgY29udGFpbnMgbm9uLWV4aXN0
aW5nIGZpZWxkcy4uLiBJIGd1ZXNzIHRoZSBkZXZpY2UgY291bGQgaWdub3JlCndyaXRlcyBhbmQg
cmV0dXJuIHplcm9lcyBvbiByZWFkPykKCkkndmUgb3BlbmVkIGh0dHBzOi8vZ2l0aHViLmNvbS9v
YXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzk4IGZvciB0aGUKc3BlYyBpc3N1ZXMuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
