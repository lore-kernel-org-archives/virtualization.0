Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE479C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 05:54:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72A220842
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 05:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfN9lhAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72A220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 768888770B;
	Wed,  5 Aug 2020 05:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7nfdmlYHG+L; Wed,  5 Aug 2020 05:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8110D86DD6;
	Wed,  5 Aug 2020 05:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74C2DC0051;
	Wed,  5 Aug 2020 05:54:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15FF0C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 05:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F29C185764
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 05:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sRS7wqEIVOko
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 05:54:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 64BE58574F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 05:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596606840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dfDQG4tby0nd+utieNRaPsFTAyk7GxdbToWcw/3rz4=;
 b=HfN9lhAt93AAh1wOUz8jjomqOJY34N+Cy28ZYjYePadnA4UD8athPp25kp5BDMGEmfpoPc
 tNKaRGfdbzMGyRjYP1DoIop9ic0ODeilNBRtPHyX55uUTPj6b6xyum3QjXb1kYWeiGRiun
 a4NqNdqQIgb6kq+GLIYThnTFPiREdus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-xFmTAAppM6e3bePnSZYNjw-1; Wed, 05 Aug 2020 01:53:56 -0400
X-MC-Unique: xFmTAAppM6e3bePnSZYNjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3DB102C7ED;
 Wed,  5 Aug 2020 05:53:55 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77FF75C1BD;
 Wed,  5 Aug 2020 05:53:45 +0000 (UTC)
Subject: Re: [PATCH V5 1/6] vhost: introduce vhost_vring_call
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-2-lingshan.zhu@intel.com>
 <5e646141-ca8d-77a5-6f41-d30710d91e6d@redhat.com>
 <d51dd4e3-7513-c771-104c-b61f9ee70f30@intel.com>
 <156b8d71-6870-c163-fdfa-35bf4701987d@redhat.com>
 <20200804052050-mutt-send-email-mst@kernel.org>
 <14fd2bf1-e9c1-a192-bd6c-f1ee5fd227f6@redhat.com>
 <bf10cde9-db86-a1ac-e2a8-363735e49afb@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa18c90f-a315-7d40-cdb7-812b98a9c4f4@redhat.com>
Date: Wed, 5 Aug 2020 13:53:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bf10cde9-db86-a1ac-e2a8-363735e49afb@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, wanpengli@tencent.com, parav@mellanox.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, sean.j.christopherson@intel.com,
 virtualization@lists.linux-foundation.org, eli@mellanox.com,
 pbonzini@redhat.com
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

Ck9uIDIwMjAvOC81IOS4i+WNiDE6NDksIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4KPgo+IE9uIDgv
NS8yMDIwIDEwOjE2IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIwLzgvNCDkuIvl
jYg1OjIxLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4gwqDCoCArc3RydWN0IHZo
b3N0X3ZyaW5nX2NhbGwgewo+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGV2ZW50ZmRfY3R4ICpjdHg7
Cj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgaXJxX2J5cGFzc19wcm9kdWNlciBwcm9kdWNlcjsKPj4+
Pj4+PiArwqDCoMKgIHNwaW5sb2NrX3QgY3R4X2xvY2s7Cj4+Pj4+PiBJdCdzIG5vdCBjbGVhciB0
byBtZSB3aHkgd2UgbmVlZCBjdHhfbG9jayBoZXJlLgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+
PiBIaSBKYXNvbiwKPj4+Pj4KPj4+Pj4gd2UgdXNlIHRoaXMgbG9jayB0byBwcm90ZWN0IHRoZSBl
dmVudGZkX2N0eCBhbmQgaXJxIGZyb20gcmFjZSAKPj4+Pj4gY29uZGl0aW9ucywKPj4+PiBXZSBk
b24ndCBzdXBwb3J0IGlycSBub3RpZmljYXRpb24gZnJvbSB2RFBBIGRldmljZSBkcml2ZXIgaW4g
dGhpcyAKPj4+PiB2ZXJzaW9uLAo+Pj4+IGRvIHdlIHN0aWxsIGhhdmUgcmFjZSBjb25kaXRpb24/
Cj4+Pj4KPj4+PiBUaGFua3MKPj4+IEphc29uIEknbSBub3Qgc3VyZSB3aGF0IHlvdSBhcmUgdHJ5
aW5nIHRvIHNheSBoZXJlLgo+Pgo+Pgo+PiBJIG1lYW50IHdlIGNoYW5nZSB0aGUgQVBJIGZyb20g
VjQgc28gZHJpdmVyIHdvbid0IG5vdGlmeSB1cyBpZiBpcnEgaXMgCj4+IGNoYW5nZWQuCj4+Cj4+
IFRoZW4gaXQgbG9va3MgdG8gbWUgdGhlcmUncyBubyBuZWVkIGZvciB0aGUgY3R4X2xvY2ssIGV2
ZXJ5aGluZyBjb3VsZCAKPj4gYmUgc3luY2hyb25pemVkIHdpdGggdnEgbXV0ZXguCj4+Cj4+IFRo
YW5rcwo+IGZyb20gVjQgdG8gVjUsIHRoZXJlIGFyZSBvbmx5IHNvbWUgbWlub3IgaW1wcm92ZW1l
bnRzIGFuZCBidWcgZml4LCBnZXRfdnFfaXJxKCkgYWxtb3N0IHN0YXlzIHVudG91Y2hlZCwgbXV0
ZXggY2FuIHdvcmsgZm9yIHRoaXMsIGhvd2V2ZXIgSSBzZWUgdGhlIHZxIG11dGV4IGlzIHVzZWQg
aW4gbWFueSBzY2VuYXJpb3MuCj4gV2Ugb25seSB1c2UgdGhpcyBsb2NrIHRvIHByb3RlY3QgdGhl
IHByb2R1Y2VyIGluZm9ybWF0aW9uLCBjYW4gdGhpcyBoZWxwIHRvIGdldCBsZXNzIGNvdXBsaW5n
LCBkZWZlbnNpdmUgY29kZSBmb3IgbGVzcyBidWdzPwoKCkkgdGhpbmsgbm90LCB2cSBtdXRleCBp
cyB1c2VkIHRvIHByb3RlY3QgYWxsIHZxIHJlbGF0ZWQgZGF0YSBzdHJ1Y3R1cmUsIAppbnRyb2R1
Y2luZyBhbm90aGVyIG9uZSB3aWxsIGluY3JlYXNlIHRoZSBjb21wbGV4aXR5LgoKVGhhbmtzCgoK
Pgo+IFRoYW5rcwo+Pgo+Pj4KPj4+Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
