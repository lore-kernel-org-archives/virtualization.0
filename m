Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD16C433E7
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 08:01:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C06F20BED
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 08:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEVigo86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C06F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 672DB87ADD;
	Tue, 13 Oct 2020 08:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2r5zeNDA-IR; Tue, 13 Oct 2020 08:00:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBEDD87ABB;
	Tue, 13 Oct 2020 08:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D85E6C07FF;
	Tue, 13 Oct 2020 08:00:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AEDCC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5DFA887AE1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0b-MQeHYJyBw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:00:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 462D187ABB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602576054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XX+2jM3RBMDFVnq+P3ujbLXIB6bjiYY3xDsMh5SMjUE=;
 b=cEVigo86zFHy+5uKL0jGnQToKJq6umD4uoEcZZq12dmDlKAXAJ9AxE9XMRpWRS9Z0lqL2L
 msM7KOK09O7CH5EyK2w0aWiCCo4Ack4BAurBnQCyp0dom+VKMdXKgWL78Q5FuWHvcrOPlk
 VjwYVb3y5btpelOqIzNcNHibudnwxRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-UrkiDKutO5uicmsmJQomUA-1; Tue, 13 Oct 2020 04:00:52 -0400
X-MC-Unique: UrkiDKutO5uicmsmJQomUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 530031015ED6;
 Tue, 13 Oct 2020 08:00:50 +0000 (UTC)
Received: from [10.72.13.59] (ovpn-13-59.pek2.redhat.com [10.72.13.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7D986EF7C;
 Tue, 13 Oct 2020 08:00:33 +0000 (UTC)
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <958b69c3-0321-d5cb-4c12-702795925583@redhat.com>
 <2dc4bd12-9f23-7caa-b1ec-f3403d36e065@intel.com>
 <83529dac-7b87-aec9-55f0-85face47e7b6@redhat.com>
 <b1cad8f9-67c4-dbb7-6edc-66be2f6ba08f@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9be8c60c-a111-5de7-3551-93f03ecda445@redhat.com>
Date: Tue, 13 Oct 2020 16:00:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b1cad8f9-67c4-dbb7-6edc-66be2f6ba08f@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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

Ck9uIDIwMjAvMTAvMTMg5LiL5Y2IMzoxNiwgSmllIERlbmcgd3JvdGU6Cj4KPiBPbiAyMDIwLzEw
LzEyIDExOjQzLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIwLzEwLzEyIOS4iuWNiDEw
OjQ1LCBKaWUgRGVuZyB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMjAyMC8xMC8xMCAxMToxNCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+Pgo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2aXJ0cXVl
dWVfa2ljayh2cSk7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHRpbWVfbGVmdCA9IHdh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmdmktPmNvbXBsZXRpb24sIAo+Pj4+PiBhZGFwLT50
aW1lb3V0KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdGltZV9sZWZ0KSB7Cj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJmFkYXAtPmRldiwgIm1zZ1slZF06IGFkZHI9
MHgleCB0aW1lb3V0LlxuIiwgCj4+Pj4+IGksIG1zZ3NbaV0uYWRkcik7Cj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4+Cj4+Pj4K
Pj4+PiBZb3UgZG9uJ3Qgc2V0IGVycm9yIG51bWJlciBoZXJlLiBJcyB0aGlzIGludGVuZGVkPwo+
Pj4+Cj4+Pj4gQW5kIHVzaW5nIGEgdGltZW91dCBoZXJlIGlzIG5vdCBnb29kLCBhbmQgaWYgdGhl
IHJlcXVlc3QgaXMgCj4+Pj4gZmluaXNoZWQganVzdCBhZnRlciB0aGUgdGltZW91dCwgaW4gdGhl
IG5leHQgeGZlciB5b3UgbWF5IGhpdCB0aGUgCj4+Pj4gZm9sbG93aW5nIGNoZWNrLgo+Pj4+Cj4+
Pj4gSXQncyBiZXR0ZXIgdG8gdXNlIGVpdGhlciBpbnRlcnJ1cHQgaGVyZS4KPj4+Pgo+Pj4gQ291
bGQgeW91IGNoZWNrIHRoZSBJMkMgZHJpdmVycyBpbiB0aGUga2VybmVsID8gVGhlIAo+Pj4gIndh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCIgbWVjaGFuaXNtCj4+PiBpcyBjb21tb25seSB1c2Vk
IGJ5IEkyQyBidXMgZHJpdmVycyBpbiB0aGVpciBpMmNfYWxnb3JpdGhtLm1hc3Rlcl94ZmVyLgo+
Pgo+Pgo+PiBUaGVyZSdzIGEgbWFqb3IgZGlmZmVyZW5jZSBiZXR3ZWVuIHZpcnRpby1pMmMgYW5k
IG90aGVyIGRyaXZlcnMuIEluIAo+PiB0aGUgY2FzZSBvZiB2aXJ0aW8sIHRoZSBkZXZpY2UgY291
bGQgYmUgYSBzb2Z0d2FyZSBkZXZpY2UgZW11bGF0ZWQgYnkgCj4+IGEgcmVtb3RlIHByb2Nlc3Mu
IFRoaXMgbWVhbnMgdGhlIHRpbWVvdXQgbWlnaHQgbm90IGJlIHJhcmUuCj4+Cj4+IEkgZG9uJ3Qg
c2VlIGhvdyB0aW1lb3V0IGlzIHByb3Blcmx5IGhhbmRsZWQgaW4gdGhpcyBwYXRjaCAoZS5nIGRp
ZCAKPj4geW91IG5vdGljZSB0aGF0IHlvdSBkb24ndCBzZXQgYW55IGVycm9yIHdoZW4gdGltZW91
dD8gb3IgaXMgdGhpcyAKPj4gaW50ZW5kZWQ/KQo+Pgo+IFRoZSBiYWNrZW5kIHNvZnR3YXJlIG1h
eSBvcGVyYXRlIHRoZSBwaHlzaWNhbCBkZXZpY2UuIFRoZSB0aW1lb3V0IAo+IGRlcGVuZHMgb24g
aG93IHRoZSBiYWNrZW5kIGlzIGRlc2lnbmVkLgo+IEhlcmUgaWYgdGhlIHRpbWVvdXQgaGFwcGVu
cywgaXQgd2lsbCByZXR1cm4gdGhlIGFjdHVhbCBudW1iZXIgb2YgCj4gbWVzc2FnZXMgc3VjY2Vz
c2Z1bGx5IHByb2Nlc3NlZCB0byB0aGUgSTJDIGNvcmUuCj4gTGV0IHRoZSBJMkMgY29yZSBkZWNp
ZGVzIGhvdyB0byBkbyBuZXh0LgoKClNvIGxldCdzIGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcgY2Fz
ZToKCjEpIGRyaXZlcjp2aXJ0aW9faTJjX2FkZF9tc2cobXNnQSkKMikgZHJpdmVyOnRpbWVvdXQs
IGFuZCByZXR1cm4gdG8gSTJDIGNvcmUKMykgZHJpdmVyOnZpcnRpb19pMmNfYWRkX21zZyhtc2dC
KQo0KSBkZXZpY2U6IGNvbXBsZXRlIG1zZ0EKNSkgZHJpdmVyOiB2aXJ0cXVldWVfZ2V0X2J1Zigp
IHJldHVybnMgbXNnQSwgc2luY2UgdGhlIHRva2VuIGlzIGFsd2F5cyAKdmktPnZtc2csIHRoZSBk
cml2ZXIgbWF5IHRoaW5rIG1zZ0IgaGFzIGJlZW4gY29tcGxldGVkLgoKCj4KPiBUaGFua3MuCj4K
Pj4KPj4+Cj4+Pj4KPj4+Pj4gKwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1zZyA9IChzdHJ1Y3Qg
dmlydGlvX2kyY19tc2cgKil2aXJ0cXVldWVfZ2V0X2J1Zih2cSwgJmxlbik7Cj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCAvKiB2bXNnIHNob3VsZCBwb2ludCB0byB0aGUgc2FtZSBhZGRyZXNzIHdpdGgg
JnZpLT52bXNnICovCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoKCF2bXNnKSB8fCAodm1zZyAh
PSAmdmktPnZtc2cpKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJmFk
YXAtPmRldiwgIm1zZ1slZF06IGFkZHI9MHgleCB2aXJ0cXVldWUgCj4+Pj4+IGVycm9yLlxuIiwK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpLCBtc2dzW2ldLmFkZHIpOwo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IH0KPj4+Pgo+Pj4+Cj4+Pj4gU28gSSB0aGluayB3ZSBjYW4gcmVtb3ZlIHRoaXMgY2hlY2suIENv
bnNpZGVyIG9ubHkgb25lIGRlc2NyaXB0b3IgCj4+Pj4gd2lsbCBiZSB1c2VkIGF0IG1vc3QsIHVu
bGVzcyB0aGVyZSdzIGEgYnVnIGluIHRoZSBkZXZpY2UgKGFuZCBubyAKPj4+PiBvdGhlciBkcml2
ZXIgdG8gdGhlIHNpbWlsYXIgY2hlY2spLCB3ZSBzaG91bGQgbm90IGhpdCB0aGlzLgo+Pj4+Cj4+
Pj4gQnR3LCBhcyBJIHJlcGxpZWQgaW4gdGhlIHByZXZpb3VzIHZlcnNpb24sIHRoZSBkZXZpY2Ug
c2hvdWxkIGJlIAo+Pj4+IGNhY3BhYmxlIG9mIGRlYWxpbmcgb2YgYSBiYXRjaCBvZiByZXF1ZXN0
cyB0aHJvdWdoIHRoZSB2aXJ0cXVldWUsIAo+Pj4+IG90aGVyd2lzZSBpdCdzIG1lYW5pbmdsZXNz
IHRvIHVzZSBhIHF1ZXVlIGhlcmUuCj4+Pj4KPj4+IFdlIHNob3VsZCBub3QgYXNzdW1lIHRoZXJl
IGlzIG5vIGJ1ZyBpbiB0aGUgZGV2aWNlLiBJIGRvbid0IHRoaW5rIHdlIAo+Pj4gY2FuIHJlbW92
ZSB0aGlzIGNoZWNrIGlmIHdlIHdhbnQgb3VyIGNvZGUgdG8gYmUgcm9idXN0Lgo+Pgo+Pgo+PiBD
YW4geW91IHRlbGwgd2hlbiBhdCB3aGljaCBjYXNlIHlvdSBtYXkgaGl0ICF2bXNnIG9yIHZtc2cg
IT0gdmktPnZtc2c/Cj4+Cj4gTm9ybWFsbHksIGl0IHdvbid0IGhpdCBoZXJlLiBCdXQgdGhlIEFQ
SSAidmlydHF1ZXVlX2dldF9idWYiIHRlbGxzIG1lCj4gIkl0ICptYXkgKnJldHVybiBOVUxMIG9y
IHRoZSAiZGF0YSIgdG9rZW4gaGFuZGVkIHRvIHZpcnRxdWV1ZV9hZGRfKigpLiIKCgpOb3RlIHRo
YXQgd2UgaGFkIHRoZSBmb2xsb3dpbmcgY2hlY2sgYWxyZWFkeSBpbiB2aXJ0cXVldWVfZ2V0X2J1
Zl9jdHgoKSwgCnNvIHRoZSB0aGUgdmlydGlvIGNvcmUgaGFkIGFscmVhZHkgaGF2ZSB0aGUgYWJp
bGl0eSB0byBmaWd1cmUgb3V0IHRoZSAKd3JvbmcgaGVhZC4KCiDCoMKgwqAgaWYgKHVubGlrZWx5
KGlkID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkgewogwqDCoMKgIMKgwqDCoCBCQURfUklORyh2
cSwgImlkICV1IG91dCBvZiByYW5nZVxuIiwgaWQpOwogwqDCoMKgIMKgwqDCoCByZXR1cm4gTlVM
TDsKIMKgwqDCoCB9CiDCoMKgwqAgaWYgKHVubGlrZWx5KCF2cS0+cGFja2VkLmRlc2Nfc3RhdGVb
aWRdLmRhdGEpKSB7CiDCoMKgwqAgwqDCoMKgIEJBRF9SSU5HKHZxLCAiaWQgJXUgaXMgbm90IGEg
aGVhZCFcbiIsIGlkKTsKIMKgwqDCoCDCoMKgwqAgcmV0dXJuIE5VTEw7CiDCoMKgwqAgfQoKQW5k
IHdoZW4gaXQgcmV0dXJucyBhIE5VTEwsIGl0J3Mgbm90IG5lY2Vzc2FyaWx5IGFuIGVycm9yIG9m
IHRoZSBkZXZpY2UsIAppdCBtaWdodCBqdXN0IHJlcXVpcmUgbW9yZSB0aW1lIHRvIGZpbmlzaCB0
aGUgcHJvY2Vzc2luZy4KCgo+Cj4gRnJvbSB0aGUgcGVyc3BlY3RpdmUgb2YgYSBjYWxsZXIsIEkg
anVzdCBkb24ndCBjYXJlIHdoZW4gaXQgaGFwcGVucy4KPiBUbyBtYWtlIHRoZSBjb2RlIHJvYnVz
dCwgd2hhdCBJIGNhcmUgYWJvdXQgaXMgd2hhdCBJIHNob3VsZCBkbyBpZiB0aGlzIAo+IGlzIG5v
dCBvdXIgY2FzZQo+IHNpbmNlIHRoZSBkb2Mgc2F5cyBpdCptYXkgKmhhcHBlbi4KPgo+IElmIHlv
dSBpbnNpc3Qgb24gcmVtb3ZpbmcgdGhpcyBjaGVjaywgSSB3aWxsIHJlbW92ZSAidm1zZyAhPSB2
aS0+dm1zZyIgCj4gYW5kIGtlZXAgdGhlIGNoZWNrIGZvciAhdm1zZy4KPiBBcyBEYW4gcmVwb3J0
ZWQgaW4gdjIsIHdlIHNob3VsZCBhdCBsZWFzdCBjaGVjayBoZXJlIGZvciBOVUxMLgo+Cj4gVGhh
bmtzLgo+Cj4+Cj4+Cj4+PiBBcyBJIHNhaWQsIGN1cnJlbnRseSwgd2UgYXJlIHVzaW5nIHRoZSB2
aXJ0cXVldWUgdG8gc2VuZCB0aGUgbXNnIG9uZSAKPj4+IGJ5IG9uZSB0byB0aGUgYmFja2VuZC4g
VGhlIG1lY2hhbmlzbSBpcyBkZXNjcmliZWQgaW4gdGhlIHNwZWMuIAo+Pgo+Pgo+PiBXaGljaCBw
YXJ0IG9mIHRoZSBzcGVjIGRlc2NyaWJlcyBzdWNoICJvbmUgYnkgb25lIiBtZWNoYW5pc20/IElm
IAo+PiB0aGVyZSBpcyBvbmUsIEknZCBoYXBwaWx5IGdpdmUgYSBOQUNLIHNpbmNlIGl0IGRvZXNu
J3QgcmVxdWlyZSBhIAo+PiBxdWV1ZSB0byB3b3JrIHdoaWNoIGlzIGNvbmZsaWN0IHdpdGggdGhl
IGNvbmNlcHQgb2YgdGhlIHZpcnRxdWV1ZS4KPj4KPj4KPiBXaGF0J3MgdGhlIGNvbmNlcHQgb2Yg
dGhlIHZpcnRxdWV1ZSA/wqAgV2h5IGRvIHlvdSB3YW50IHRvIHJlc3RyaWN0IGhvdyAKPiB1c2Vy
cyB1c2UgdmlydHF1ZXVlID8KCgpTbyBJIHRoaW5rIHRoZXJlJ3Mgc29tZSBtaXN1bmRlcnN0YW5k
aW5nIGhlcmUuIFRoZSBwb2ludCBpcyBub3QgdG8gCnJlc3RyaWN0IGhvdyB0byB1c2UgdmlydHF1
ZXVlLgoKV2hhdCBJIG1lYW50IGlzOgoKLSB3ZSBzaG91bGQgbm90IGludmVudCBhIGRldmljZSB3
aXRoIGEgdmlydHF1ZXVlIHRoYXQgY2FuIG9ubHkgYWNjZXB0IApvbmUgYnVmZmVyIGF0IGEgdGlt
ZQotIEkgZG9uJ3Qgc2VlIGFueSBtZWNoYW5pc20gbGlrZSAib25lIGJ5IG9uZSIgZGVzY3JpYmVk
IGluIHRoZSBzcGVjLCBzbyAKaXQncyBvayBidXQgaWYgaXQnZCBoYXBwZW4gdG8gaGF2ZSwgSSB3
aWxsIE5BQ0sKCgo+Cj4gSXQncyBsaWtlIHlvdSBwcm92aWRlIGEgd2F0ZXIgZ2xhc3MgdG8gdXNl
ci4gVGhlIHVzZXIgY2FuIGZpbGwgYSBmdWxsIAo+IGdsYXNzIG9mIHdhdGVyIGFuZCBkcmlua3Mg
b25jZSBvcgo+IGZpbGwgaGFsZiBhIGdsYXNzIG9mIHdhdGVyIGFuZCBkcmluayB0d2ljZS4gSXQg
aXMgYSB1c2VyIGJlaGF2aW9yIGFuZCAKPiBzaG91bGQgbm90IGJlIHJlc3RyaWN0ZWQgYnkKPiB0
aGUgZ2xhc3MgcHJvdmlkZXIuCgoKVGhhdCdzIG15IHBvaW50IGFzIHdlbGwsIHdlIHNob3VsZCBu
b3QgZGVzY3JpYmUgdGhlICJvbmNlIiBiZWhhdmlvciBpbiAKdGhlIHNwZWMuCgoKPgo+IFRoYW5r
cy4KPgo+Cj4+PiBUaGFua3MuCj4+Pgo+Pj4KPj4+Pgo+Pj4+PiArCj4+Pj4+Cj4+Pj4+ICsKPj4+
Pj4gKyNpZm5kZWYgX1VBUElfTElOVVhfVklSVElPX0kyQ19ICj4+Pj4+ICsjZGVmaW5lIF9VQVBJ
X0xJTlVYX1ZJUlRJT19JMkNfSAo+Pj4+PiArCj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4KPj4+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9faWRzLmg+Cj4+Pj4+ICsjaW5jbHVkZSA8
bGludXgvdmlydGlvX2NvbmZpZy5oPgo+Pj4+PiArCj4+Pj4+ICsvKioKPj4+Pj4gKyAqIHN0cnVj
dCB2aXJ0aW9faTJjX2hkciAtIHRoZSB2aXJ0aW8gSTJDIG1lc3NhZ2UgaGVhZGVyIHN0cnVjdHVy
ZQo+Pj4+PiArICogQGFkZHI6IGkyY19tc2cgYWRkciwgdGhlIHNsYXZlIGFkZHJlc3MKPj4+Pj4g
KyAqIEBmbGFnczogaTJjX21zZyBmbGFncwo+Pj4+PiArICogQGxlbjogaTJjX21zZyBsZW4KPj4+
Pj4gKyAqLwo+Pj4+PiArc3RydWN0IHZpcnRpb19pMmNfaGRyIHsKPj4+Pj4gK8KgwqDCoCBfX2xl
MTYgYWRkcjsKPj4+Pj4gK8KgwqDCoCBfX2xlMTYgZmxhZ3M7Cj4+Pj4+ICvCoMKgwqAgX19sZTE2
IGxlbjsKPj4+Pj4gK307Cj4+Pj4KPj4+Pgo+Pj4+IEknbSBhZnJhaWQgdGhpcyBpcyBub3QgY29t
cGxldGUuIEUuZyB0aGUgc3RhdHVzIGlzIG1pc3NlZC4KPj4+Pgo+Pj4+IEkgc3VzcGVjdCB3aGF0
IHZpcnRpby1zY3NpIHVzZSBpcyBiZXR0ZXIuIFdoaWNoIHNwbGl0IHRoZSBpbiBmcm9tIAo+Pj4+
IHRoZSBvdXQgaW5zdGVhZCBvZiByZXVzaW5nIHRoZSBzYW1lIGJ1ZmZlci4gQW5kIGl0IGNhbiBl
YXNlIHRoZSAKPj4+PiB1QVBJIGhlYWRlciBleHBvcnQuCj4+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+
Pj4+Cj4+Pgo+Pj4gSSB0aGluayBmb2xsb3dpbmcgZGVmaW5pdGlvbiBpbiB1QVBJIGZvciB0aGUg
c3RhdHVzIGlzIGVub3VnaC4KPj4+IFRoZXJlIGlzIG5vIG5lZWQgdG8gcHJvdmlkZSBhICJ1OCIg
c3RhdHVzIGluIHRoZSBzdHJ1Y3R1cmUuCj4+Pgo+Pj4gLyogVGhlIGZpbmFsIHN0YXR1cyB3cml0
dGVuIGJ5IHRoZSBkZXZpY2UgKi8KPj4+ICNkZWZpbmUgVklSVElPX0kyQ19NU0dfT0vCoMKgwqAg
MAo+Pj4gI2RlZmluZSBWSVJUSU9fSTJDX01TR19FUlLCoMKgwqAgMQo+Pj4KPj4+IFlvdSBjYW4g
c2VlIGFuIGV4YW1wbGUgaW4gdmlydGlvX2Jsay4KPj4+Cj4+PiBJbiB0aGUgc3BlYzoKPj4+Cj4+
PiBzdHJ1Y3QgdmlydGlvX2Jsa19yZXEgewo+Pj4gbGUzMiB0eXBlOwo+Pj4gbGUzMiByZXNlcnZl
ZDsKPj4+IGxlNjQgc2VjdG9yOwo+Pj4gdTggZGF0YVtdOwo+Pj4gdTggc3RhdHVzOwo+Pj4gfTsK
Pj4+Cj4+PiBJbiB2aXJ0aW9fYmxrLmgsIHRoZXJlIGlzIG9ubHkgZm9sbG93aW5nIGRlZmluaXRp
b25zLgo+Pj4KPj4+ICNkZWZpbmUgVklSVElPX0JMS19TX09LwqDCoMKgIMKgwqDCoCAwCj4+PiAj
ZGVmaW5lIFZJUlRJT19CTEtfU19JT0VSUsKgwqDCoCAxCj4+PiAjZGVmaW5lIFZJUlRJT19CTEtf
U19VTlNVUFDCoMKgwqAgMgo+Pj4KPj4KPj4gdmlydGlvLWJsayBpcyBhIGJhZCBleGFtcGxlLCBp
dCdzIGp1c3QgdG9vIGxhdGUgdG8gZml4LiBGb3IgYW55IG5ldyAKPj4gaW50cm9kdWNlZCB1QVBJ
IGl0IHNob3VsZCBiZSBhIGNvbXBsZXRlIG9uZS4KPj4KPj4gVGhhbmtzCj4+Cj4gSSBjaGVja2Vk
IGEgcmVsYXRpdmVseSBuZXcgZGV2aWNlICJ2aXJ0aW9fZnMiLgo+IEkgZm91bmQgZm9sbG93aW5n
IGRlZmluaXRpb24gaW4gc3BlYyBidXQgbm90IGluIHVBUEkgYWxzby4KPgo+IHN0cnVjdCB2aXJ0
aW9fZnNfcmVxIHsKPiAvLyBEZXZpY2UgLXJlYWRhYmxlIHBhcnQKPiBzdHJ1Y3QgZnVzZV9pbl9o
ZWFkZXIgaW47Cj4gdTggZGF0YWluW107Cj4gLy8gRGV2aWNlIC13cml0YWJsZSBwYXJ0Cj4gc3Ry
dWN0IGZ1c2Vfb3V0X2hlYWRlciBvdXQ7Cj4gdTggZGF0YW91dFtdOwo+IH07Cj4KPiBTbyBpcyB0
aGlzIGFsc28gYSBiYWQgZXhhbXBsZSB3aGljaCBoYXMgbm90IGJlZW4gZml4ZWQgeWV0LgoKCkNj
IFN0ZWZhbiBmb3IgdGhlIGFuc3dlci4KCgo+IE9yIHdoYXQncyB5b3VyIG1lYW4gYWJvdXQgImNv
bXBsZXRlIiBoZXJlID8gSXMgdGhlcmUgYW55IGRlZmluaXRpb24gCj4gYWJvdXQgImNvbXBsZXRl
IHVBUEkiID8KCgpNeSB1bmRlcnN0YW5kaW5nIGl0IHNob3VsZCBjb250YWluIGFsbCB0aGUgZmll
bGRzIGRlZmluZWQgaW4gdGhlIHZpcnRpbyAKc3BlYy4KClRoYW5rcwoKCj4KPiBUaGFua3MuCj4K
Pgo+Pgo+Pj4gVGhhbmtzLgo+Pj4KPj4+Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
