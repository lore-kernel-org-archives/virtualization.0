Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF8C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 04:27:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15A120867
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 04:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15A120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21E238738A;
	Mon,  7 Dec 2020 04:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKzO9uGBbMeD; Mon,  7 Dec 2020 04:27:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 742E087144;
	Mon,  7 Dec 2020 04:27:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 635ADC0893;
	Mon,  7 Dec 2020 04:27:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 043EEC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB1632E1B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XllqkezcWbUq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:27:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 55DA42D47F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607315255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFoxhbNduukcap6r+01I62kypDZmOjRAARCOf6fwshE=;
 b=gUDu+vylhB88Lkf+KQDmrtU5lVs/K28X5E62OrP7I9PJu4ebjZqjT1IHIMNtLLbwgE3SBV
 MqcIzCtad3fVk5dRCQw+i7oygTG/3K1DDp7g41AjBMK+ppVe0wBoq+pyXoGKCSGs00MxQR
 J7Hnfg+iT1CJQg1W9DjdV5XMRZPkkqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-erg1_CrfOmuWwfa7PI4a9Q-1; Sun, 06 Dec 2020 23:27:31 -0500
X-MC-Unique: erg1_CrfOmuWwfa7PI4a9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A29B7107ACE8;
 Mon,  7 Dec 2020 04:27:30 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC2A010016FA;
 Mon,  7 Dec 2020 04:27:21 +0000 (UTC)
Subject: Re: [RFC PATCH 5/8] vhost: allow userspace to bind vqs to CPUs
To: Mike Christie <michael.christie@oracle.com>, sgarzare@redhat.com,
 stefanha@redhat.com, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
 <1607068593-16932-6-git-send-email-michael.christie@oracle.com>
 <4546ef72-da7c-df9e-53be-c937a5437436@redhat.com>
 <30746f1c-ed8c-d2ae-9513-54fca8f52739@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea5fa99c-7d8f-b7de-42f1-691dc26dc3d2@redhat.com>
Date: Mon, 7 Dec 2020 12:27:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30746f1c-ed8c-d2ae-9513-54fca8f52739@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjAvMTIvNSDkuIrljYgxMjozMiwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBPbiAxMi80
LzIwIDI6MDkgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjAvMTIvNCDkuIvljYgz
OjU2LCBNaWtlIENocmlzdGllIHdyb3RlOgo+Pj4gK3N0YXRpYyBsb25nIHZob3N0X3ZyaW5nX3Nl
dF9jcHUoc3RydWN0IHZob3N0X2RldiAqZCwgc3RydWN0IAo+Pj4gdmhvc3RfdmlydHF1ZXVlICp2
cSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCBfX3VzZXIgKmFyZ3Ap
Cj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3Qgdmhvc3RfdnJpbmdfc3RhdGUgczsKPj4+ICvCoMKg
wqAgaW50IHJldCA9IDA7Cj4+PiArCj4+PiArwqDCoMKgIGlmICh2cS0+cHJpdmF0ZV9kYXRhKQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChj
b3B5X2Zyb21fdXNlcigmcywgYXJncCwgc2l6ZW9mIHMpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUZBVUxUOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAocy5udW0gPT0gLTEpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCB2cS0+Y3B1ID0gcy5udW07Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IDA7Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgaWYgKHMubnVtID49IG5yX2NwdV9p
ZHMpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiArCj4+PiArwqDCoMKg
IGlmICghZC0+b3BzIHx8ICFkLT5vcHMtPmdldF93b3JrcXVldWUpCj4+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiArCj4+PiArwqDCoMKgIGlmICghZC0+d3EpCj4+PiArwqDC
oMKgwqDCoMKgwqAgZC0+d3EgPSBkLT5vcHMtPmdldF93b3JrcXVldWUoKTsKPj4+ICvCoMKgwqAg
aWYgKCFkLT53cSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+ICsKPj4+
ICvCoMKgwqAgdnEtPmNwdSA9IHMubnVtOwo+Pj4gK8KgwqDCoCByZXR1cm4gcmV0Owo+Pj4gK30K
Pj4KPj4KPj4gU28gb25lIHF1ZXN0aW9uIGhlcmUuIFdobyBpcyBpbiBjaGFyZ2Ugb2YgZG9pbmcg
dGhpcyBzZXRfY3B1PyBOb3RlIAo+PiB0aGF0wqBzY2hlZF9zZXRhZmZpbml0eSgyKSByZXF1aXJl
cyBDQVBfU1lTX05JQ0UgdG8gd29yaywgc28gSSB3b25kZXIgCj4+IHdoZXRoZXIgb3Igbm90IGl0
J3MgbGVnYWwgZm9yIHVucHJpdmlsZWdlZCBRZW11IHRvIGRvIHRoaXMuCj4KPgo+IEkgd2FzIGhh
dmluZyBxZW11IGRvIGl0IHdoZW4gaXQncyBzZXR0aW5nIHVwIHRoZSB2cXMgc2luY2UgaXQgaGFk
IHRoZSAKPiBpbmZvIHRoZXJlIGFscmVhZHkuCj4KPiBJcyBpdCBub3JtYWxseSB0aGUgdG9vbCB0
aGF0IG1ha2VzIGNhbGxzIGludG8gcWVtdSB0aGF0IGRvZXMgdGhlIAo+IG9wZXJhdGlvbnMgdGhh
dCByZXF1aXJlIENBUF9TWVNfTklDRT8gCgoKTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0IG9u
bHkgbWF0dGVyIHNjaGVkdWxpbmcuIEFuZCB0aGlzIHBhdGNoIHdhbnRzIAp0byBjaGFuZ2UgdGhl
IGFmZmluaXR5IHdoaWNoIHNob3VsZCBjaGVjayB0aGF0IGNhcGFiaWxpdHkuCgoKPiBJZiBzbywg
dGhlbiBJIHNlZSB0aGUgaW50ZXJmYWNlIG5lZWRzIHRvIGJlIGNoYW5nZWQuCgoKQWN0dWFsbHks
IGlmIEkgcmVhZCB0aGlzIHBhdGNoIGNvcnJlY3RseSBpdCByZXF1aXJlcyBlLmcgcWVtdSB0byBt
YWtlIAp0aGUgZGVjaXNpb24gaW5zdGVhZCBvZiB0aGUgbWFuYWdlbWVudCBsYXllci4gVGhpcyBt
YXkgYnJpbmcgc29tZSAKdHJvdWJsZXMgdG8gZm9yIGUuZyB0aGUgbGlidmlydCBlbXVsYXRvcnBp
blsxXSBpbXBsZW1lbnRhdGlvbi4KClRoYW5rcwoKWzFdIApodHRwczovL2FjY2Vzcy5yZWRoYXQu
Y29tL2RvY3VtZW50YXRpb24vZW4tdXMvcmVkX2hhdF9lbnRlcnByaXNlX2xpbnV4LzcvaHRtbC92
aXJ0dWFsaXphdGlvbl90dW5pbmdfYW5kX29wdGltaXphdGlvbl9ndWlkZS9zZWN0LXZpcnR1YWxp
emF0aW9uX3R1bmluZ19vcHRpbWl6YXRpb25fZ3VpZGUtbnVtYS1udW1hX2FuZF9saWJ2aXJ0Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
