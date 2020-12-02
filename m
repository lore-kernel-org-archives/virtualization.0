Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A63C64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 05:48:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8711221FC
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 05:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8711221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B93AB86D36;
	Wed,  2 Dec 2020 05:48:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zng_PvuGmYqw; Wed,  2 Dec 2020 05:48:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F61686B1C;
	Wed,  2 Dec 2020 05:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E39B1C163C;
	Wed,  2 Dec 2020 05:48:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31AE8C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1EBBE2E202
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epC1PZpj0StQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:48:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 7C8C02E1FB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 05:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606888123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCYBZnVFwcJcfwEuD0pQ/djq4n14JKN2dFyCj8tmsog=;
 b=EIDnRKLwM3o2NWDRksxhwiahi7P2E4qD9ZrtbmMST/Zu0TTgrjBD3FJv9DYMW9hZZgpnTf
 W4+akToSIMiFgCZDjLwkekjTWSpSpMHMnPwWYOJ9rp5DVMQN43xzl5Qc2tJH5fsPDOHzW3
 P7N/CRDkahaZA/bGi68tm93wYAhWhgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-JnDDeUHHMruWjKpDLQ1-8A-1; Wed, 02 Dec 2020 00:48:39 -0500
X-MC-Unique: JnDDeUHHMruWjKpDLQ1-8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 225CE18C89DE;
 Wed,  2 Dec 2020 05:48:38 +0000 (UTC)
Received: from [10.72.13.145] (ovpn-13-145.pek2.redhat.com [10.72.13.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4611D5C1B4;
 Wed,  2 Dec 2020 05:48:31 +0000 (UTC)
Subject: Re: [External] Re: [PATCH 0/7] Introduce vdpa management tool
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <5b2235f6-513b-dbc9-3670-e4c9589b4d1f@redhat.com>
 <CACycT3sYScObb9nN3g7L3cesjE7sCZWxZ5_5R1usGU9ePZEeqA@mail.gmail.com>
 <182708df-1082-0678-49b2-15d0199f20df@redhat.com>
 <CACycT3votu2eyacKg+w12xZ_ujEOgTY0f8A7qcpbM-fwTpjqAw@mail.gmail.com>
 <7f80eeed-f5d3-8c6f-1b8c-87b7a449975c@redhat.com>
 <CACycT3uw6KJgTo+dBzSj07p2P_PziD+WBfX4yWVX-nDNUD2M3A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <594b2086-802f-1053-2866-a25d4a327876@redhat.com>
Date: Wed, 2 Dec 2020 13:48:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uw6KJgTo+dBzSj07p2P_PziD+WBfX4yWVX-nDNUD2M3A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, elic@nvidia.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMSDkuIvljYg1OjU1LCBZb25namkgWGllIHdyb3RlOgo+IE9uIFR1ZSwgRGVj
IDEsIDIwMjAgYXQgMjoyNSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMC8xMS8zMCDkuIvljYgzOjA3LCBZb25namkgWGllIHdyb3RlOgo+Pj4+
PiBUaGFua3MgZm9yIGFkZGluZyBtZSwgSmFzb24hCj4+Pj4+Cj4+Pj4+IE5vdyBJJ20gd29ya2lu
ZyBvbiBhIHYyIHBhdGNoc2V0IGZvciBWRFVTRSAodkRQQSBEZXZpY2UgaW4gVXNlcnNwYWNlKQo+
Pj4+PiBbMV0uIFRoaXMgdG9vbCBpcyB2ZXJ5IHVzZWZ1bCBmb3IgdGhlIHZkdXNlIGRldmljZS4g
U28gSSdtIGNvbnNpZGVyaW5nCj4+Pj4+IGludGVncmF0aW5nIHRoaXMgaW50byBteSB2MiBwYXRj
aHNldC4gQnV0IHRoZXJlIGlzIG9uZSBwcm9ibGVt77yaCj4+Pj4+Cj4+Pj4+IEluIHRoaXMgdG9v
bCwgdmRwYSBkZXZpY2UgY29uZmlnIGFjdGlvbiBhbmQgZW5hYmxlIGFjdGlvbiBhcmUgY29tYmlu
ZWQKPj4+Pj4gaW50byBvbmUgbmV0bGluayBtc2c6IFZEUEFfQ01EX0RFVl9ORVcuIEJ1dCBpbiB2
ZHVzZSBjYXNlLCBpdCBuZWVkcyB0bwo+Pj4+PiBiZSBzcGxpdHRlZCBiZWNhdXNlIGEgY2hhcmRl
diBzaG91bGQgYmUgY3JlYXRlZCBhbmQgb3BlbmVkIGJ5IGEKPj4+Pj4gdXNlcnNwYWNlIHByb2Nl
c3MgYmVmb3JlIHdlIGVuYWJsZSB0aGUgdmRwYSBkZXZpY2UgKGNhbGwKPj4+Pj4gdmRwYV9yZWdp
c3Rlcl9kZXZpY2UoKSkuCj4+Pj4+Cj4+Pj4+IFNvIEknZCBsaWtlIHRvIGtub3cgd2hldGhlciBp
dCdzIHBvc3NpYmxlIChvciBoYXZlIHNvbWUgcGxhbnMpIHRvIGFkZAo+Pj4+PiB0d28gbmV3IG5l
dGxpbmsgbXNncyBzb21ldGhpbmcgbGlrZTogVkRQQV9DTURfREVWX0VOQUJMRSBhbmQKPj4+Pj4g
VkRQQV9DTURfREVWX0RJU0FCTEUgdG8gbWFrZSB0aGUgY29uZmlnIHBhdGggbW9yZSBmbGV4aWJs
ZS4KPj4+Pj4KPj4+PiBBY3R1YWxseSwgd2UndmUgZGlzY3Vzc2VkIHN1Y2ggaW50ZXJtZWRpYXRl
IHN0ZXAgaW4gc29tZSBlYXJseQo+Pj4+IGRpc2N1c3Npb24uIEl0IGxvb2tzIHRvIG1lIFZEVVNF
IGNvdWxkIGJlIG9uZSBvZiB0aGUgdXNlcnMgb2YgdGhpcy4KPj4+Pgo+Pj4+IE9yIEkgd29uZGVy
IHdoZXRoZXIgd2UgY2FuIHN3aXRjaCB0byB1c2UgYW5vbnltb3VzIGlub2RlKGZkKSBmb3IgVkRV
U0UKPj4+PiB0aGVuIGZldGNoaW5nIGl0IHZpYSBhbiBWRFVTRV9HRVRfREVWSUNFX0ZEIGlvY3Rs
Pwo+Pj4+Cj4+PiBZZXMsIHdlIGNhbi4gQWN0dWFsbHkgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gaW4gVkRVU0UgaXMgbGlrZQo+Pj4gdGhpcy4gIEJ1dCBzZWVtcyBsaWtlIHRoaXMgaXMgc3Rp
bGwgYSBpbnRlcm1lZGlhdGUgc3RlcC4gVGhlIGZkIHNob3VsZAo+Pj4gYmUgYmluZGVkIHRvIGEg
bmFtZSBvciBzb21ldGhpbmcgZWxzZSB3aGljaCBuZWVkIHRvIGJlIGNvbmZpZ3VyZWQKPj4+IGJl
Zm9yZS4KPj4KPj4gVGhlIG5hbWUgY291bGQgYmUgc3BlY2lmaWVkIHZpYSB0aGUgbmV0bGluay4g
SXQgbG9va3MgdG8gbWUgdGhlIHJlYWwKPj4gaXNzdWUgaXMgdGhhdCB1bnRpbCB0aGUgZGV2aWNl
IGlzIGNvbm5lY3RlZCB3aXRoIGEgdXNlcnNwYWNlLCBpdCBjYW4ndAo+PiBiZSB1c2VkLiBTbyB3
ZSBhbHNvIG5lZWQgdG8gZmFpbCB0aGUgZW5hYmxpbmcgaWYgaXQgZG9lc24ndCBvcGVuZWQuCj4+
Cj4gWWVzLCB0aGF0J3MgdHJ1ZS4gU28geW91IG1lYW4gd2UgY2FuIGZpcnN0bHkgdHJ5IHRvIGZl
dGNoIHRoZSBmZAo+IGJpbmRlZCB0byBhIG5hbWUvdmR1c2VfaWQgdmlhIGFuIFZEVVNFX0dFVF9E
RVZJQ0VfRkQsIHRoZW4gdXNlIHRoZQo+IG5hbWUvdmR1c2VfaWQgYXMgYSBhdHRyaWJ1dGUgdG8g
Y3JlYXRlIHZkcGEgZGV2aWNlPyBJdCBsb29rcyBmaW5lIHRvCj4gbWUuCgoKWWVzLCBzb21ldGhp
bmcgbGlrZSB0aGlzLiBUaGUgYW5vbnltb3VzIGZkIHdpbGwgYmUgY3JlYXRlZCBkdXJpbmcgCmRl
dl9hZGQoKSBhbmQgdGhlIGZkIHdpbGwgYmUgY2FycmllZCBpbiB0aGUgbXNnIHRvIHVzZXJzcGFj
ZS4KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
