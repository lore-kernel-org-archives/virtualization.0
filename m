Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0977BC43461
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 12:45:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E4E611AF
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 12:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E4E611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 451C8400F5;
	Thu,  8 Apr 2021 12:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ach9X_gSf3X9; Thu,  8 Apr 2021 12:45:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E651A401BA;
	Thu,  8 Apr 2021 12:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD9D6C000C;
	Thu,  8 Apr 2021 12:45:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B154AC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 12:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92DF1400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 12:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrO3dEfW7Mqa
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 12:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F721400F5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617885952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUXfy+VSEEl5j5H1dI8KuFyJtEablKEBo7YiZjGApMQ=;
 b=d+Tk0snq7ZeE9A3HvBluWtPN2N7SbPGzliqlrkPli91q8+MUquuo68WKnr5fWIdcAmHcey
 WKURXMg8tXPO2P15bhk149MyUOIURZVnWa17gOx+gYUbGO8EZwlFEmuNhK0UBhF4NNGJ9H
 r+BcoS3op9XXRHoh51dywQ0/OFWiWoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-2XSbkMFuMOG4WjyQOgRVEg-1; Thu, 08 Apr 2021 08:45:50 -0400
X-MC-Unique: 2XSbkMFuMOG4WjyQOgRVEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10930195D562;
 Thu,  8 Apr 2021 12:45:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-93.pek2.redhat.com
 [10.72.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79BFB60BF1;
 Thu,  8 Apr 2021 12:45:43 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] virito_pci: add timeout to reset device operation
To: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org
References: <20210408081109.56537-1-mgurtovoy@nvidia.com>
 <20210408081109.56537-2-mgurtovoy@nvidia.com>
 <2bead2b3-fa23-dc1e-3200-ddfa24944b75@redhat.com>
 <a00abefe-790d-8239-ac42-9f70daa7a25c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93221213-8fc3-96ef-7e89-b7c03bea5322@redhat.com>
Date: Thu, 8 Apr 2021 20:45:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a00abefe-790d-8239-ac42-9f70daa7a25c@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: nitzanc@nvidia.com, oren@nvidia.com, cohuck@redhat.com
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

CuWcqCAyMDIxLzQvOCDkuIvljYg1OjQ0LCBNYXggR3VydG92b3kg5YaZ6YGTOgo+Cj4gT24gNC84
LzIwMjEgMTI6MDEgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzQvOCDkuIvl
jYg0OjExLCBNYXggR3VydG92b3kg5YaZ6YGTOgo+Pj4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjIGFm
dGVyIHdyaXRpbmcgMCB0byBkZXZpY2Vfc3RhdHVzLCB0aGUgZHJpdmVyIE1VU1QKPj4+IHdhaXQg
Zm9yIGEgcmVhZCBvZiBkZXZpY2Vfc3RhdHVzIHRvIHJldHVybiAwIGJlZm9yZSByZWluaXRpYWxp
emluZyB0aGUKPj4+IGRldmljZS4gSW4gY2FzZSB3ZSBoYXZlIGEgZGV2aWNlIHRoYXQgd29uJ3Qg
cmV0dXJuIDAsIHRoZSByZXNldAo+Pj4gb3BlcmF0aW9uIHdpbGwgbG9vcCBmb3JldmVyIGFuZCBj
YXVzZSB0aGUgaG9zdC92bSB0byBzdHVjay4gU2V0IHRpbWVvdXQKPj4+IGZvciAzIG1pbnV0ZXMg
YmVmb3JlIGdpdmluZyB1cCBvbiB0aGUgZGV2aWNlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1h
eCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCAxMCArKysrKysrKystCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgCj4+PiBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPj4+IGluZGV4IGNjMzQxMmE5NmExNy4uZGNlZTYxNmU4
ZDIxIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+
Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+Pj4gQEAgLTE2Miw2
ICsxNjIsNyBAQCBzdGF0aWMgaW50IHZwX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2Rl
diA9IHRvX3ZwX2RldmljZSh2ZGV2KTsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19wY2lf
bW9kZXJuX2RldmljZSAqbWRldiA9ICZ2cF9kZXYtPm1kZXY7Cj4+PiArwqDCoMKgIHVuc2lnbmVk
IGxvbmcgdGltZW91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDE4MDAwMCk7Cj4+PiDC
oCDCoMKgwqDCoMKgIC8qIDAgc3RhdHVzIG1lYW5zIGEgcmVzZXQuICovCj4+PiDCoMKgwqDCoMKg
IHZwX21vZGVybl9zZXRfc3RhdHVzKG1kZXYsIDApOwo+Pj4gQEAgLTE2OSw5ICsxNzAsMTYgQEAg
c3RhdGljIGludCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+IMKgwqDC
oMKgwqDCoCAqIGRldmljZV9zdGF0dXMgdG8gcmV0dXJuIDAgYmVmb3JlIHJlaW5pdGlhbGl6aW5n
IHRoZSBkZXZpY2UuCj4+PiDCoMKgwqDCoMKgwqAgKiBUaGlzIHdpbGwgZmx1c2ggb3V0IHRoZSBz
dGF0dXMgd3JpdGUsIGFuZCBmbHVzaCBpbiBkZXZpY2UgCj4+PiB3cml0ZXMsCj4+PiDCoMKgwqDC
oMKgwqAgKiBpbmNsdWRpbmcgTVNJLVggaW50ZXJydXB0cywgaWYgYW55Lgo+Pj4gK8KgwqDCoMKg
ICogU2V0IGEgdGltZW91dCBiZWZvcmUgZ2l2aW5nIHVwIG9uIHRoZSBkZXZpY2UuCj4+PiDCoMKg
wqDCoMKgwqAgKi8KPj4+IC3CoMKgwqAgd2hpbGUgKHZwX21vZGVybl9nZXRfc3RhdHVzKG1kZXYp
KQo+Pj4gK8KgwqDCoCB3aGlsZSAodnBfbW9kZXJuX2dldF9zdGF0dXMobWRldikpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAodGltZV9hZnRlcihqaWZmaWVzLCB0aW1lb3V0KSkgewo+Pgo+Pgo+
PiBXaGF0IGhhcHBlbnMgaWYgdGhlIGRldmljZSBmaW5pc2ggdGhlIHJlc3QgYWZ0ZXIgdGhlIHRp
bWVvdXQ/Cj4KPgo+IFRoZSBkcml2ZXIgd2lsbCBzZXQgVklSVElPX0NPTkZJR19TX0ZBSUxFRCBh
bmQgb25lIGNhbiByZS1wcm9iZSBpdCAKPiBsYXRlciBvbiAoZS5nIGJ5IHJlLXNjYW5uaW5nIHRo
ZSBwY2kgYnVzKS4KCgpPaywgc28gZG8gd2UgbmVlZCB0aGUgZmx1c2ggdGhyb3VnaCB2cF9zeW5j
aHJvbml6ZV92ZWN0b3JzKCkgaGVyZT8KClRoYW5rcwoKCj4KPgo+Pgo+PiBUaGFua3MKPj4KPj4K
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJnZkZXYtPmRldiwgInZpcnRpbzog
ZGV2aWNlIG5vdCByZWFkeS4gIgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
QWJvcnRpbmcuIFRyeSBhZ2FpbiBsYXRlclxuIik7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVBR0FJTjsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgbXNsZWVwKDEpOwo+Pj4gK8KgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIC8qIEZsdXNoIHBl
bmRpbmcgVlEvY29uZmlndXJhdGlvbiBjYWxsYmFja3MuICovCj4+PiDCoMKgwqDCoMKgIHZwX3N5
bmNocm9uaXplX3ZlY3RvcnModmRldik7Cj4+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
