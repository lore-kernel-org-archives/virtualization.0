Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D3C433B4
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 02:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2A161450
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 02:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2A161450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BF8F6079A;
	Thu, 29 Apr 2021 02:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gxQ9N6f7ip8; Thu, 29 Apr 2021 02:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26E2B60D4E;
	Thu, 29 Apr 2021 02:19:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9A1BC000E;
	Thu, 29 Apr 2021 02:19:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB4EC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 041094187D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kE8CuG8-yaFr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D24D4186D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 02:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619662737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDHW1GjShJjBXMVMkRd2LW6Z0k5jQYIAFZdHKIa1zSo=;
 b=W1bknPeMYgfcWzf0kCijYO7Qn5DbAaXDBaTWlpNmyuAqVw48GzymBTaRKDiIdn4JBmwIaO
 dCCU3gBADT4UUnZvrnnThl3tHHlLrBKB4gGG47eGub6MTXZc/X9yMWLJz9QQAFW8veZLJ4
 y6bONjpminuSdZBFOEkrFPUA7pUj5rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-gi_7TphcNau8938lt_LzvQ-1; Wed, 28 Apr 2021 22:18:52 -0400
X-MC-Unique: gi_7TphcNau8938lt_LzvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCEC6107ACF3;
 Thu, 29 Apr 2021 02:18:50 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-162.pek2.redhat.com
 [10.72.13.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65FA7226FD;
 Thu, 29 Apr 2021 02:18:45 +0000 (UTC)
Subject: Re: [PATCH] virtio-net: enable SRIOV
To: "Walukiewicz, Miroslaw" <Miroslaw.Walukiewicz@intel.com>,
 Arkadiusz Kudan <arkadiusz.kudan@codilime.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210426102135.227802-1-arkadiusz.kudan@codilime.com>
 <625a6618-bb59-8ccc-bf1c-e29ac556b590@redhat.com>
 <MWHPR1101MB209476B1939ADB73C57E71AC9E409@MWHPR1101MB2094.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5616038a-6a96-9a25-c2e2-7fa216b76126@redhat.com>
Date: Thu, 29 Apr 2021 10:18:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR1101MB209476B1939ADB73C57E71AC9E409@MWHPR1101MB2094.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jayagopi,
 Geetha" <geetha.jayagopi@intel.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzQvMjgg5LiL5Y2IOTozMiwgV2FsdWtpZXdpY3osIE1pcm9zbGF3IOWGmemBkzoK
PiBISSBKYXNvbiwKPgo+IFlvdSBhcmUgcmlnaHQgaGVyZS4gV2UgZGlkIG5vdCBjYXRjaCB5b3Vy
IGNoYW5nZSBpbiBkcml2ZXIgYW5kIHRoZSBTUklPViBmbGFnIGlzIHNldCBjb3JyZWN0bHkgYXMg
eW91IHN0YXRlZC4KPgo+IFdlIHdhbnQgdG8gb3JjaGVzdHJhdGUgdGhlIEhXIGltcGxlbWVudGF0
aW9uIG9mIFZGcyBhbmQgUEZzIGZvciB2aXJ0aW8tbmV0IHVzaW5nIGxpYnZpcnQuCj4KPiBUaGUg
aXNzdWUgdGhhdCB3ZSB3YW50IHRvIHJlc29sdmUgaXMgdGhhdCB0aGVyZSBpcyBubyAubmRvX2dl
dF92Zl9jb25maWcgQ2FsbGJhY2sgaW1wbGVtZW50ZWQgaW4gdmlydGlvLW5ldCBkcml2ZXIgYXMg
b3RoZXIgTklDJ3MgZHJpdmVycyBoYXZlLCBjYWxsZWQgYnkgbGlidmlydC4KPiBTZWUgaHR0cHM6
Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jI0wyOTk2LCBmb3IgZXhhbXBsZQo+IFRoaXMgY2FsbGJh
Y2sgcmVhbGx5IHNob3VsZCBjcmVhdGUgYSBtaW5pbWFsIGNvbmZpZ3VyYXRpb24gaW5zaWRlIG9m
IGRyaXZlciwgYnV0IHdlIGNhbm5vdCBhdm9pZCBpdC4KCgpUaGUgcmVhc29uIGZvciBub3QgaW1w
bGVtZW50aW5nIHRoYXQgY2FsbGJhY2sgaXMgYmVjYXVzZSB0aGUgYXR0cmlidXRlcyAKYXJlIG5v
dCBpbXBsZW1lbnRlZCBpbiB0aGUgdmlydGlvIHNwZWMuCgpXZSdyZSB3b3JraW5nIG9uIGFkZGlu
ZyBtYW5hZ2VtZW50IHBsYW5lIHRvIHZpcnRpbyBzcGVjWzFdLgoKCj4KPiBBbm90aGVyIGlzc3Vl
IGlzIGxhY2sgb2Ygc3lzZnMgZnJvIHZpcnR1YWwgZnVuY3Rpb25zIC9zeXMvY2xhc3MvbmV0L2Vu
czgwMWYwL2RldmljZS92aXJ0Zm5YICh3aGVyZSBYIGlzIFZGIG51bWJlciBhbmQgZW5zODAxZm8g
aXMgaXRzIFBGIG5ldGRldiksCgoKV2hhdCBoYXJkd2FyZSBkaWQgeW91IHVzZT8KCkknbSB1c2lu
ZyBpZmN2ZiAodGhlIGhhcmR3YXJlIG5vdCB0aGUgdmRwYSBkcml2ZXIpIGFuZCBpdCB3b3JrcyBs
aWtlIGEgCmNoYXJtOgoKIyBwd2QKL3N5cy9idXMvcGNpL2RyaXZlcnMvdmlydGlvLXBjaS8wMDAw
OjA3OjAwLjAKIyBlY2hvIDQgPiBzcmlvdl9udW12ZnMKIyBscyB8IGdyZXAgdmlydGZuCnZpcnRm
bjAKdmlydGZuMQp2aXJ0Zm4yCnZpcnRmbjMKClRoYW5rcwoKWzFdIApodHRwczovL2xpc3RzLm9h
c2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjEwMS9tc2cwMDA0Ny5odG1s
CgoKPgo+IENvdWxkIHlvdSBhZHZpc2UgdXMsIGhvdyB3ZSBjYW4gc29sdmUgb3VyIGlzc3VlIGFu
ZCBkcml2ZSB1cyB0byBwcm9wZXIgc29sdXRpb24/Cj4KPiBSZWdhcmRzLAo+Cj4gTWlyZWsKPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4gU2VudDogd3RvcmVrLCAyNyBrd2lldG5pYSAyMDIxIDA0OjQ0Cj4gVG86IEFy
a2FkaXVzeiBLdWRhbiA8YXJrYWRpdXN6Lmt1ZGFuQGNvZGlsaW1lLmNvbT47IHZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBXYWx1a2lld2ljeiwgTWlyb3NsYXcgPE1pcm9zbGF3LldhbHVr
aWV3aWN6QGludGVsLmNvbT4KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW8tbmV0OiBlbmFi
bGUgU1JJT1YKPgo+Cj4g5ZyoIDIwMjEvNC8yNiDkuIvljYg2OjIxLCBBcmthZGl1c3ogS3VkYW4g
5YaZ6YGTOgo+PiBXaXRoIGluY3JlYXNpbmcgaW50ZXJlc3QgZm9yIHZpcnRpbywgTklDIGhhdmUg
YXBwZWFyZWQgdGhhdCBwcm92aWRlCj4+IFNSSU9WIHdpdGggUEYgYXBwZWFyaW5nIGluIHRoZSBo
b3N0IGFzIGEgdmlydGlvIG5ldHdvcmsgZGV2aWNlIGFuZAo+PiBwcm9iYWJseSBtb3JlIHNpbWls
aWFyIE5JQ3Mgd2lsbCBlbWVyZ2UuCj4+IGlnYl91aW8gb2YgRFBESyBvciBwY2ktcGYtc3R1YiBj
YW4gYmUgdXNlZCB0byBwcm92aWRlIFNSSU9WLCBob3dldmVyCj4+IHRoZXJlIGFyZSBoeXBlcnZp
c29ycy9WTU1zIHRoYXQgcmVxdWlyZSBWRnMsIHdoaWNoIGFyZSB0byBiZSBQQ0kKPj4gcGFzc3Ro
cnVlZCB0byBhIFZNLCB0byBoYXZlIGl0cyBQRiB3aXRoIG5ldHdvcmsgcmVwcmVzZW50YXRpb24g
aW4gdGhlCj4+IGtlcm5lbC4gRm9yIHZpcnRpby1uZXQgYmFzZWQgUEZzLCB2aXJ0aW8tbmV0IGNv
dWxkIGRvIHRoYXQgYnkKPj4gcHJvdmlkaW5nIGJvdGggU1JJT1YgaW50ZXJmYWNlIGFuZCBuZXRk
ZXYgcmVwcmVzZW50YXRpb24uCj4+Cj4+IEVuYWJsZSBTUklPViB2aWEgVklSVElPX0ZfU1JfSU9W
IGZlYXR1cmUgYml0IGlmIHRoZSBkZXZpY2Ugc3VwcG9ydHMKPj4gaXQuCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEFya2FkaXVzeiBLdWRhbiA8YXJrYWRpdXN6Lmt1ZGFuQGNvZGlsaW1lLmNvbT4KPj4g
U2lnbmVkLW9mZi1ieTogTWlyb3NsYXcgV2FsdWtpZXdpY3ogPE1pcm9zbGF3LldhbHVraWV3aWN6
QGludGVsLmNvbT4KPj4gLS0tCj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDEgKwo+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBpbmRleAo+
PiAwODI0ZTY5OTllNDkuLmEwM2FhN2U5OTY4OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiBAQCAtMzI0
OSw2ICszMjQ5LDcgQEAgc3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3RhYmxlW10g
PSB7Cj4+ICAgIAo+PiAgICBzdGF0aWMgdW5zaWduZWQgaW50IGZlYXR1cmVzW10gPSB7Cj4+ICAg
IAlWSVJUTkVUX0ZFQVRVUkVTLAo+PiArCVZJUlRJT19GX1NSX0lPViwKPj4gICAgfTsKPgo+IFNv
IEknbSBzdXByaXNlZCB0aGF0IGl0IG5lZWRzIHRvIGJlIGVuYWJsZWQgcGVyIGRldmljZS4gV2Ug
aGFkOgo+Cj4gc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpIHsKPiAgIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZkZXYpOwo+ICAgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBjaV9kZXYgPSB2cF9kZXYtPnBjaV9kZXY7Cj4KPiAg
IMKgwqDCoMKgwqDCoMKgIGlmICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1NSX0lPVikp
ICYmCj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBj
aV9maW5kX2V4dF9jYXBhYmlsaXR5KHBjaV9kZXYsCj4gUENJX0VYVF9DQVBfSURfU1JJT1YpKQo+
ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fdmlydGlvX3NldF9iaXQodmRldiwg
VklSVElPX0ZfU1JfSU9WKTsgfQo+Cj4gQW5kIEkgaGFkIHVzZWQgdGhpcyBkcml2ZXIgZm9yIFNS
SU9WIHZpcnRpby1wY2kgaGFyZHdhcmUgZm9yIG1vcmUgdGhhbiBvbmUgeWVhci4KPgo+IFRoYW5r
cwo+Cj4KPj4gICAgCj4+ICAgIHN0YXRpYyB1bnNpZ25lZCBpbnQgZmVhdHVyZXNfbGVnYWN5W10g
PSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
