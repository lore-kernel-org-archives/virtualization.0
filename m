Return-Path: <SRS0=fPht=DW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C3C43467
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 07:07:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529EA2223F
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 07:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0PvNWvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529EA2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE53E88089;
	Thu, 15 Oct 2020 07:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e2SLlXgSiRIG; Thu, 15 Oct 2020 07:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C3E638808A;
	Thu, 15 Oct 2020 07:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA126C0052;
	Thu, 15 Oct 2020 07:07:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B11DAC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 07:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9FFC88878F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 07:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3whTb2VpWl4z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 07:07:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 387F78846C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602745626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkSKShzeLcy22X3w3XcMG/ba8hPxXu9C8gEKNB4MCzs=;
 b=b0PvNWvtAftdV7hklhyOslxjSQQZ75v/axFbPdAkg7h8+qVsYyF81f98XI5RVSdUM7Mg8t
 gtzxOEAHK1KrfYbH8YMNUS92/GeP4D3lYMhaZPPkT3y+Y/OxHJWPMNwFCsLwtEnAQKMLJY
 PDk8qCr3F7FH/TR+3xhKPvtedUI512A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-ZNdk-CVUNoeXzgA7M33rng-1; Thu, 15 Oct 2020 03:07:02 -0400
X-MC-Unique: ZNdk-CVUNoeXzgA7M33rng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF5648030BA;
 Thu, 15 Oct 2020 07:06:59 +0000 (UTC)
Received: from [10.72.13.96] (ovpn-13-96.pek2.redhat.com [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36AD075132;
 Thu, 15 Oct 2020 07:06:44 +0000 (UTC)
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <958b69c3-0321-d5cb-4c12-702795925583@redhat.com>
 <2dc4bd12-9f23-7caa-b1ec-f3403d36e065@intel.com>
 <83529dac-7b87-aec9-55f0-85face47e7b6@redhat.com>
 <b1cad8f9-67c4-dbb7-6edc-66be2f6ba08f@intel.com>
 <9be8c60c-a111-5de7-3551-93f03ecda445@redhat.com>
 <3c648e84-3c29-2cfe-65e2-eb377feb67b2@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61037faa-651f-bef5-02ec-1a53aa939108@redhat.com>
Date: Thu, 15 Oct 2020 15:06:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c648e84-3c29-2cfe-65e2-eb377feb67b2@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjAvMTAvMTQg5LiL5Y2INDozNywgSmllIERlbmcgd3JvdGU6Cj4KPiBPbiAyMDIwLzEw
LzEzIDE2OjAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgdmlydHF1ZXVlX2tpY2sodnEpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgdGltZV9sZWZ0ID0gCj4+Pj4+Pj4gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZ2
aS0+Y29tcGxldGlvbiwgYWRhcC0+dGltZW91dCk7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
ICghdGltZV9sZWZ0KSB7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2Vycigm
YWRhcC0+ZGV2LCAibXNnWyVkXTogYWRkcj0weCV4IAo+Pj4+Pj4+IHRpbWVvdXQuXG4iLCBpLCBt
c2dzW2ldLmFkZHIpOwo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFlvdSBkb24ndCBzZXQg
ZXJyb3IgbnVtYmVyIGhlcmUuIElzIHRoaXMgaW50ZW5kZWQ/Cj4+Pj4+Pgo+Pj4+Pj4gQW5kIHVz
aW5nIGEgdGltZW91dCBoZXJlIGlzIG5vdCBnb29kLCBhbmQgaWYgdGhlIHJlcXVlc3QgaXMgCj4+
Pj4+PiBmaW5pc2hlZCBqdXN0IGFmdGVyIHRoZSB0aW1lb3V0LCBpbiB0aGUgbmV4dCB4ZmVyIHlv
dSBtYXkgaGl0IHRoZSAKPj4+Pj4+IGZvbGxvd2luZyBjaGVjay4KPj4+Pj4+Cj4+Pj4+PiBJdCdz
IGJldHRlciB0byB1c2UgZWl0aGVyIGludGVycnVwdCBoZXJlLgo+Pj4+Pj4KPj4+Pj4gQ291bGQg
eW91IGNoZWNrIHRoZSBJMkMgZHJpdmVycyBpbiB0aGUga2VybmVsID8gVGhlIAo+Pj4+PiAid2Fp
dF9mb3JfY29tcGxldGlvbl90aW1lb3V0IiBtZWNoYW5pc20KPj4+Pj4gaXMgY29tbW9ubHkgdXNl
ZCBieSBJMkMgYnVzIGRyaXZlcnMgaW4gdGhlaXIgCj4+Pj4+IGkyY19hbGdvcml0aG0ubWFzdGVy
X3hmZXIuCj4+Pj4KPj4+Pgo+Pj4+IFRoZXJlJ3MgYSBtYWpvciBkaWZmZXJlbmNlIGJldHdlZW4g
dmlydGlvLWkyYyBhbmQgb3RoZXIgZHJpdmVycy4gSW4gCj4+Pj4gdGhlIGNhc2Ugb2YgdmlydGlv
LCB0aGUgZGV2aWNlIGNvdWxkIGJlIGEgc29mdHdhcmUgZGV2aWNlIGVtdWxhdGVkIAo+Pj4+IGJ5
IGEgcmVtb3RlIHByb2Nlc3MuIFRoaXMgbWVhbnMgdGhlIHRpbWVvdXQgbWlnaHQgbm90IGJlIHJh
cmUuCj4+Pj4KPj4+PiBJIGRvbid0IHNlZSBob3cgdGltZW91dCBpcyBwcm9wZXJseSBoYW5kbGVk
IGluIHRoaXMgcGF0Y2ggKGUuZyBkaWQgCj4+Pj4geW91IG5vdGljZSB0aGF0IHlvdSBkb24ndCBz
ZXQgYW55IGVycm9yIHdoZW4gdGltZW91dD8gb3IgaXMgdGhpcyAKPj4+PiBpbnRlbmRlZD8pCj4+
Pj4KPj4+IFRoZSBiYWNrZW5kIHNvZnR3YXJlIG1heSBvcGVyYXRlIHRoZSBwaHlzaWNhbCBkZXZp
Y2UuIFRoZSB0aW1lb3V0IAo+Pj4gZGVwZW5kcyBvbiBob3cgdGhlIGJhY2tlbmQgaXMgZGVzaWdu
ZWQuCj4+PiBIZXJlIGlmIHRoZSB0aW1lb3V0IGhhcHBlbnMsIGl0IHdpbGwgcmV0dXJuIHRoZSBh
Y3R1YWwgbnVtYmVyIG9mIAo+Pj4gbWVzc2FnZXMgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZCB0byB0
aGUgSTJDIGNvcmUuCj4+PiBMZXQgdGhlIEkyQyBjb3JlIGRlY2lkZXMgaG93IHRvIGRvIG5leHQu
Cj4+Cj4+Cj4+IFNvIGxldCdzIGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcgY2FzZToKPj4KPj4gMSkg
ZHJpdmVyOnZpcnRpb19pMmNfYWRkX21zZyhtc2dBKQo+PiAyKSBkcml2ZXI6dGltZW91dCwgYW5k
IHJldHVybiB0byBJMkMgY29yZQo+PiAzKSBkcml2ZXI6dmlydGlvX2kyY19hZGRfbXNnKG1zZ0Ip
Cj4+IDQpIGRldmljZTogY29tcGxldGUgbXNnQQo+PiA1KSBkcml2ZXI6IHZpcnRxdWV1ZV9nZXRf
YnVmKCkgcmV0dXJucyBtc2dBLCBzaW5jZSB0aGUgdG9rZW4gaXMgCj4+IGFsd2F5cyB2aS0+dm1z
ZywgdGhlIGRyaXZlciBtYXkgdGhpbmsgbXNnQiBoYXMgYmVlbiBjb21wbGV0ZWQuCj4+Cj4+Cj4g
SWYgdGhpcyBjYXNlIGRvZXMgaGFwcGVuLCBpdCBpcyBleGFjdGx5IGEgY2FzZSB0aGF0IHRoZSBj
b25kaXRpb24gCj4gIigoIXZtc2cpIHx8ICh2bXNnICE9ICZ2aS0+dm1zZykpIiBhcmUgbWV0LgoK
CkkgbWF5IG1pc3Mgc29tZXRoaW5nLCBidXQgeW91IGFsd2F5cyB1c2UgdmktPnZtc2cgYXMgdG9r
ZW4gc28gdm1zZyBpcyAKZXF1YWwgdG8gJnZpLT52bXNnIGhlcmUKCgo+IEN1cnJlbnRseSwgdGhl
IHRpbWVvdXQgdmFsdWUgaXMgaGFyZC1jb2RlZCBpbiB0aGUgZHJpdmVyLiBHZW5lcmFsbHkgCj4g
c3BlYWtpbmcsIHRpbWVvdXQgcmFyZWx5IGhhcHBlbnMuCgoKV2VsbCwgaXQncyBiZXR0ZXIgdG8g
bm8gaGF2ZSBzdWNoIGFzc3VtcHRpb24gY29uc2lkZXIgdGhlIGRldmljZSBjb3VsZCAKYmUgYSBl
bXVsYXRlZCBvbmUuCgoKPiBJdCBjYW4gYWxzbyBiZSBkZXNpZ25lZCBhcyBhIGRldmljZSBjb25m
aWd1cmF0aW9uIGlmIG5lZWRlZC4KCgpJbiBhbnkgY2FzZSwgdGhlIHRpbWVvdXQgc2hvdWxkIGJl
IGhhbmRsZWQgY29ycmVjdGx5IHJlZ2FyZGxlc3Mgb2YgaXRzIApmcmVxdWVuY3kuCgoKPgo+IFRo
YW5rcy4KPgo+Pj4KPj4+IFRoYW5rcy4KPj4+Cj4+Pj4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4gKwo+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2bXNnID0gKHN0cnVjdCB2aXJ0aW9faTJjX21zZyAqKXZp
cnRxdWV1ZV9nZXRfYnVmKHZxLCAKPj4+Pj4+PiAmbGVuKTsKPj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgLyogdm1zZyBzaG91bGQgcG9pbnQgdG8gdGhlIHNhbWUgYWRkcmVzcyB3aXRoICZ2aS0+dm1z
ZyAqLwo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoKCF2bXNnKSB8fCAodm1zZyAhPSAmdmkt
PnZtc2cpKSB7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmYWRhcC0+
ZGV2LCAibXNnWyVkXTogYWRkcj0weCV4IHZpcnRxdWV1ZSAKPj4+Pj4+PiBlcnJvci5cbiIsCj4+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpLCBtc2dzW2ldLmFkZHIpOwo+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCB9Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFNvIEkgdGhpbmsgd2UgY2FuIHJlbW92ZSB0aGlz
IGNoZWNrLiBDb25zaWRlciBvbmx5IG9uZSBkZXNjcmlwdG9yIAo+Pj4+Pj4gd2lsbCBiZSB1c2Vk
IGF0IG1vc3QsIHVubGVzcyB0aGVyZSdzIGEgYnVnIGluIHRoZSBkZXZpY2UgKGFuZCBubyAKPj4+
Pj4+IG90aGVyIGRyaXZlciB0byB0aGUgc2ltaWxhciBjaGVjayksIHdlIHNob3VsZCBub3QgaGl0
IHRoaXMuCj4+Pj4+Pgo+Pj4+Pj4gQnR3LCBhcyBJIHJlcGxpZWQgaW4gdGhlIHByZXZpb3VzIHZl
cnNpb24sIHRoZSBkZXZpY2Ugc2hvdWxkIGJlIAo+Pj4+Pj4gY2FjcGFibGUgb2YgZGVhbGluZyBv
ZiBhIGJhdGNoIG9mIHJlcXVlc3RzIHRocm91Z2ggdGhlIHZpcnRxdWV1ZSwgCj4+Pj4+PiBvdGhl
cndpc2UgaXQncyBtZWFuaW5nbGVzcyB0byB1c2UgYSBxdWV1ZSBoZXJlLgo+Pj4+Pj4KPj4+Pj4g
V2Ugc2hvdWxkIG5vdCBhc3N1bWUgdGhlcmUgaXMgbm8gYnVnIGluIHRoZSBkZXZpY2UuIEkgZG9u
J3QgdGhpbmsgCj4+Pj4+IHdlIGNhbiByZW1vdmUgdGhpcyBjaGVjayBpZiB3ZSB3YW50IG91ciBj
b2RlIHRvIGJlIHJvYnVzdC4KPj4+Pgo+Pj4+Cj4+Pj4gQ2FuIHlvdSB0ZWxsIHdoZW4gYXQgd2hp
Y2ggY2FzZSB5b3UgbWF5IGhpdCAhdm1zZyBvciB2bXNnICE9IHZpLT52bXNnPwo+Pj4+Cj4+PiBO
b3JtYWxseSwgaXQgd29uJ3QgaGl0IGhlcmUuIEJ1dCB0aGUgQVBJICJ2aXJ0cXVldWVfZ2V0X2J1
ZiIgdGVsbHMgbWUKPj4+ICJJdCAqbWF5ICpyZXR1cm4gTlVMTCBvciB0aGUgImRhdGEiIHRva2Vu
IGhhbmRlZCB0byB2aXJ0cXVldWVfYWRkXyooKS4iCj4+Cj4+Cj4+IE5vdGUgdGhhdCB3ZSBoYWQg
dGhlIGZvbGxvd2luZyBjaGVjayBhbHJlYWR5IGluIAo+PiB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHgo
KSwgc28gdGhlIHRoZSB2aXJ0aW8gY29yZSBoYWQgYWxyZWFkeSBoYXZlIHRoZSAKPj4gYWJpbGl0
eSB0byBmaWd1cmUgb3V0IHRoZSB3cm9uZyBoZWFkLgo+Pgo+PiDCoMKgwqAgaWYgKHVubGlrZWx5
KGlkID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkgewo+PiDCoMKgwqAgwqDCoMKgIEJBRF9SSU5H
KHZxLCAiaWQgJXUgb3V0IG9mIHJhbmdlXG4iLCBpZCk7Cj4+IMKgwqDCoCDCoMKgwqAgcmV0dXJu
IE5VTEw7Cj4+IMKgwqDCoCB9Cj4+IMKgwqDCoCBpZiAodW5saWtlbHkoIXZxLT5wYWNrZWQuZGVz
Y19zdGF0ZVtpZF0uZGF0YSkpIHsKPj4gwqDCoMKgIMKgwqDCoCBCQURfUklORyh2cSwgImlkICV1
IGlzIG5vdCBhIGhlYWQhXG4iLCBpZCk7Cj4+IMKgwqDCoCDCoMKgwqAgcmV0dXJuIE5VTEw7Cj4+
IMKgwqDCoCB9Cj4+Cj4+IEFuZCB3aGVuIGl0IHJldHVybnMgYSBOVUxMLCBpdCdzIG5vdCBuZWNl
c3NhcmlseSBhbiBlcnJvciBvZiB0aGUgCj4+IGRldmljZSwgaXQgbWlnaHQganVzdCByZXF1aXJl
IG1vcmUgdGltZSB0byBmaW5pc2ggdGhlIHByb2Nlc3NpbmcuCj4+Cj4KPiBUaGF0J3Mgd2h5IHdl
IGp1c3QgcmV0dXJuZWQgdGhlIGFjdHVhbCBudW1iZXIgb2YgbWVzc2FnZXMgc3VjY2Vzc2Z1bGx5
IAo+IHByb2Nlc3NlZCBpbiB0aGlzIGNhc2UsCj4gYW5kIGxldCB0aGUgSTJDIGNvcmUgdG8gdHJ5
IG9uZSBtb3JlIHRpbWUuCj4KPiBBY3R1YWxseSB3ZSBoYXZlIG5vIGlkZWEgaWYgdGhpcyBpcyBh
IGRldmljZSBlcnJvciBvciBub3QuIFRyeSBvbmUgCj4gbW9yZSB0aW1lIGNhbiBhbHNvIGZhaWwg
aWYgaXQgaXMgYSBiYWNrZW5kIGVycm9yLgo+IE9mIGNvdXJzZSwgdGhlcmUgaXMgYW5vdGhlciBv
cHRpb24uIFdlIGNhbiByZXR1cm4gZXJyb3IgZm9yIHRpbWVvdXQsIAo+IG5vIG1hdHRlciB3aGF0
IHJlYXNvbi4KPgo+IFRoYW5rcy4KPgo+Cj4+Cj4+Pgo+Pj4gRnJvbSB0aGUgcGVyc3BlY3RpdmUg
b2YgYSBjYWxsZXIsIEkganVzdCBkb24ndCBjYXJlIHdoZW4gaXQgaGFwcGVucy4KPj4+IFRvIG1h
a2UgdGhlIGNvZGUgcm9idXN0LCB3aGF0IEkgY2FyZSBhYm91dCBpcyB3aGF0IEkgc2hvdWxkIGRv
IGlmIAo+Pj4gdGhpcyBpcyBub3Qgb3VyIGNhc2UKPj4+IHNpbmNlIHRoZSBkb2Mgc2F5cyBpdCpt
YXkgKmhhcHBlbi4KPj4+Cj4+PiBJZiB5b3UgaW5zaXN0IG9uIHJlbW92aW5nIHRoaXMgY2hlY2ss
IEkgd2lsbCByZW1vdmUgInZtc2cgIT0gCj4+PiB2aS0+dm1zZyIgYW5kIGtlZXAgdGhlIGNoZWNr
IGZvciAhdm1zZy4KPj4+IEFzIERhbiByZXBvcnRlZCBpbiB2Miwgd2Ugc2hvdWxkIGF0IGxlYXN0
IGNoZWNrIGhlcmUgZm9yIE5VTEwuCj4+Pgo+Pj4gVGhhbmtzLgo+Pj4KPj4+Pgo+Pj4+Cj4+Pj4+
IEFzIEkgc2FpZCwgY3VycmVudGx5LCB3ZSBhcmUgdXNpbmcgdGhlIHZpcnRxdWV1ZSB0byBzZW5k
IHRoZSBtc2cgCj4+Pj4+IG9uZSBieSBvbmUgdG8gdGhlIGJhY2tlbmQuIFRoZSBtZWNoYW5pc20g
aXMgZGVzY3JpYmVkIGluIHRoZSBzcGVjLiAKPj4+Pgo+Pj4+Cj4+Pj4gV2hpY2ggcGFydCBvZiB0
aGUgc3BlYyBkZXNjcmliZXMgc3VjaCAib25lIGJ5IG9uZSIgbWVjaGFuaXNtPyBJZiAKPj4+PiB0
aGVyZSBpcyBvbmUsIEknZCBoYXBwaWx5IGdpdmUgYSBOQUNLIHNpbmNlIGl0IGRvZXNuJ3QgcmVx
dWlyZSBhIAo+Pj4+IHF1ZXVlIHRvIHdvcmsgd2hpY2ggaXMgY29uZmxpY3Qgd2l0aCB0aGUgY29u
Y2VwdCBvZiB0aGUgdmlydHF1ZXVlLgo+Pj4+Cj4+Pj4KPj4+IFdoYXQncyB0aGUgY29uY2VwdCBv
ZiB0aGUgdmlydHF1ZXVlID/CoCBXaHkgZG8geW91IHdhbnQgdG8gcmVzdHJpY3QgCj4+PiBob3cg
dXNlcnMgdXNlIHZpcnRxdWV1ZSA/Cj4+Cj4+Cj4+IFNvIEkgdGhpbmsgdGhlcmUncyBzb21lIG1p
c3VuZGVyc3RhbmRpbmcgaGVyZS4gVGhlIHBvaW50IGlzIG5vdCB0byAKPj4gcmVzdHJpY3QgaG93
IHRvIHVzZSB2aXJ0cXVldWUuCj4+Cj4+IFdoYXQgSSBtZWFudCBpczoKPj4KPj4gLSB3ZSBzaG91
bGQgbm90IGludmVudCBhIGRldmljZSB3aXRoIGEgdmlydHF1ZXVlIHRoYXQgY2FuIG9ubHkgYWNj
ZXB0IAo+PiBvbmUgYnVmZmVyIGF0IGEgdGltZQo+PiAtIEkgZG9uJ3Qgc2VlIGFueSBtZWNoYW5p
c20gbGlrZSAib25lIGJ5IG9uZSIgZGVzY3JpYmVkIGluIHRoZSBzcGVjLCAKPj4gc28gaXQncyBv
ayBidXQgaWYgaXQnZCBoYXBwZW4gdG8gaGF2ZSwgSSB3aWxsIE5BQ0sKPj4KPj4KPiBUaGFua3Mg
Zm9yIHlvdXIgY2xhcmlmaWNhdGlvbi4gSSBkaWRuJ3QgcmVzdHJpY3QgaG93IHRvIHVzZSB0aGUg
Cj4gdmlydHF1ZXVlIGluIHRoZSBzcGVjLgo+IFRoZSBjb2RlIGlzIGp1c3Qgb25lIGltcGxlbWVu
dGF0aW9uLiBJJ2QgbGlrZSB0byBoYXZlIHRoaXMgc2ltcGxlIAo+IGRyaXZlciBiZWVuIG1lcmdl
ZCBmaXJzdC4KPiBJdCBtYXkgaGF2ZSBvcHRpbWl6YXRpb24gaW4gdGhlIGZ1dHVyZSBhY2NvcmRp
bmcgdG8gdGhlIG5lZWRzLgo+Cj4gVGhhbmtzLgo+Cj4KPj4+Cj4+PiBJdCdzIGxpa2UgeW91IHBy
b3ZpZGUgYSB3YXRlciBnbGFzcyB0byB1c2VyLiBUaGUgdXNlciBjYW4gZmlsbCBhIAo+Pj4gZnVs
bCBnbGFzcyBvZiB3YXRlciBhbmQgZHJpbmtzIG9uY2Ugb3IKPj4+IGZpbGwgaGFsZiBhIGdsYXNz
IG9mIHdhdGVyIGFuZCBkcmluayB0d2ljZS4gSXQgaXMgYSB1c2VyIGJlaGF2aW9yIAo+Pj4gYW5k
IHNob3VsZCBub3QgYmUgcmVzdHJpY3RlZCBieQo+Pj4gdGhlIGdsYXNzIHByb3ZpZGVyLgo+Pgo+
Pgo+PiBUaGF0J3MgbXkgcG9pbnQgYXMgd2VsbCwgd2Ugc2hvdWxkIG5vdCBkZXNjcmliZSB0aGUg
Im9uY2UiIGJlaGF2aW9yIAo+PiBpbiB0aGUgc3BlYy4KPj4KPj4KPj4+Cj4+PiBUaGFua3MuCj4+
Pgo+Pj4KPj4+Pj4gVGhhbmtzLgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiArCj4+Pj4+Pj4K
Pj4+Pj4+PiArCj4+Pj4+Pj4gKyNpZm5kZWYgX1VBUElfTElOVVhfVklSVElPX0kyQ19ICj4+Pj4+
Pj4gKyNkZWZpbmUgX1VBUElfTElOVVhfVklSVElPX0kyQ19ICj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsj
aW5jbHVkZSA8bGludXgvdHlwZXMuaD4KPj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19p
ZHMuaD4KPj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19jb25maWcuaD4KPj4+Pj4+PiAr
Cj4+Pj4+Pj4gKy8qKgo+Pj4+Pj4+ICsgKiBzdHJ1Y3QgdmlydGlvX2kyY19oZHIgLSB0aGUgdmly
dGlvIEkyQyBtZXNzYWdlIGhlYWRlciBzdHJ1Y3R1cmUKPj4+Pj4+PiArICogQGFkZHI6IGkyY19t
c2cgYWRkciwgdGhlIHNsYXZlIGFkZHJlc3MKPj4+Pj4+PiArICogQGZsYWdzOiBpMmNfbXNnIGZs
YWdzCj4+Pj4+Pj4gKyAqIEBsZW46IGkyY19tc2cgbGVuCj4+Pj4+Pj4gKyAqLwo+Pj4+Pj4+ICtz
dHJ1Y3QgdmlydGlvX2kyY19oZHIgewo+Pj4+Pj4+ICvCoMKgwqAgX19sZTE2IGFkZHI7Cj4+Pj4+
Pj4gK8KgwqDCoCBfX2xlMTYgZmxhZ3M7Cj4+Pj4+Pj4gK8KgwqDCoCBfX2xlMTYgbGVuOwo+Pj4+
Pj4+ICt9Owo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBJJ20gYWZyYWlkIHRoaXMgaXMgbm90IGNvbXBs
ZXRlLiBFLmcgdGhlIHN0YXR1cyBpcyBtaXNzZWQuCj4+Pj4+Pgo+Pj4+Pj4gSSBzdXNwZWN0IHdo
YXQgdmlydGlvLXNjc2kgdXNlIGlzIGJldHRlci4gV2hpY2ggc3BsaXQgdGhlIGluIGZyb20gCj4+
Pj4+PiB0aGUgb3V0IGluc3RlYWQgb2YgcmV1c2luZyB0aGUgc2FtZSBidWZmZXIuIEFuZCBpdCBj
YW4gZWFzZSB0aGUgCj4+Pj4+PiB1QVBJIGhlYWRlciBleHBvcnQuCj4+Pj4+Pgo+Pj4+Pj4gVGhh
bmtzCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gSSB0aGluayBmb2xsb3dpbmcgZGVmaW5pdGlv
biBpbiB1QVBJIGZvciB0aGUgc3RhdHVzIGlzIGVub3VnaC4KPj4+Pj4gVGhlcmUgaXMgbm8gbmVl
ZCB0byBwcm92aWRlIGEgInU4IiBzdGF0dXMgaW4gdGhlIHN0cnVjdHVyZS4KPj4+Pj4KPj4+Pj4g
LyogVGhlIGZpbmFsIHN0YXR1cyB3cml0dGVuIGJ5IHRoZSBkZXZpY2UgKi8KPj4+Pj4gI2RlZmlu
ZSBWSVJUSU9fSTJDX01TR19PS8KgwqDCoCAwCj4+Pj4+ICNkZWZpbmUgVklSVElPX0kyQ19NU0df
RVJSwqDCoMKgIDEKPj4+Pj4KPj4+Pj4gWW91IGNhbiBzZWUgYW4gZXhhbXBsZSBpbiB2aXJ0aW9f
YmxrLgo+Pj4+Pgo+Pj4+PiBJbiB0aGUgc3BlYzoKPj4+Pj4KPj4+Pj4gc3RydWN0IHZpcnRpb19i
bGtfcmVxIHsKPj4+Pj4gbGUzMiB0eXBlOwo+Pj4+PiBsZTMyIHJlc2VydmVkOwo+Pj4+PiBsZTY0
IHNlY3RvcjsKPj4+Pj4gdTggZGF0YVtdOwo+Pj4+PiB1OCBzdGF0dXM7Cj4+Pj4+IH07Cj4+Pj4+
Cj4+Pj4+IEluIHZpcnRpb19ibGsuaCwgdGhlcmUgaXMgb25seSBmb2xsb3dpbmcgZGVmaW5pdGlv
bnMuCj4+Pj4+Cj4+Pj4+ICNkZWZpbmUgVklSVElPX0JMS19TX09LwqDCoMKgIMKgwqDCoCAwCj4+
Pj4+ICNkZWZpbmUgVklSVElPX0JMS19TX0lPRVJSwqDCoMKgIDEKPj4+Pj4gI2RlZmluZSBWSVJU
SU9fQkxLX1NfVU5TVVBQwqDCoMKgIDIKPj4+Pj4KPj4+Pgo+Pj4+IHZpcnRpby1ibGsgaXMgYSBi
YWQgZXhhbXBsZSwgaXQncyBqdXN0IHRvbyBsYXRlIHRvIGZpeC4gRm9yIGFueSBuZXcgCj4+Pj4g
aW50cm9kdWNlZCB1QVBJIGl0IHNob3VsZCBiZSBhIGNvbXBsZXRlIG9uZS4KPj4+Pgo+Pj4+IFRo
YW5rcwo+Pj4+Cj4+PiBJIGNoZWNrZWQgYSByZWxhdGl2ZWx5IG5ldyBkZXZpY2UgInZpcnRpb19m
cyIuCj4+PiBJIGZvdW5kIGZvbGxvd2luZyBkZWZpbml0aW9uIGluIHNwZWMgYnV0IG5vdCBpbiB1
QVBJIGFsc28uCj4+Pgo+Pj4gc3RydWN0IHZpcnRpb19mc19yZXEgewo+Pj4gLy8gRGV2aWNlIC1y
ZWFkYWJsZSBwYXJ0Cj4+PiBzdHJ1Y3QgZnVzZV9pbl9oZWFkZXIgaW47Cj4+PiB1OCBkYXRhaW5b
XTsKPj4+IC8vIERldmljZSAtd3JpdGFibGUgcGFydAo+Pj4gc3RydWN0IGZ1c2Vfb3V0X2hlYWRl
ciBvdXQ7Cj4+PiB1OCBkYXRhb3V0W107Cj4+PiB9Owo+Pj4KPj4+IFNvIGlzIHRoaXMgYWxzbyBh
IGJhZCBleGFtcGxlIHdoaWNoIGhhcyBub3QgYmVlbiBmaXhlZCB5ZXQuCj4+Cj4+Cj4+IENjIFN0
ZWZhbiBmb3IgdGhlIGFuc3dlci4KPj4KPj4KPj4+IE9yIHdoYXQncyB5b3VyIG1lYW4gYWJvdXQg
ImNvbXBsZXRlIiBoZXJlID8gSXMgdGhlcmUgYW55IGRlZmluaXRpb24gCj4+PiBhYm91dCAiY29t
cGxldGUgdUFQSSIgPwo+Pgo+Pgo+PiBNeSB1bmRlcnN0YW5kaW5nIGl0IHNob3VsZCBjb250YWlu
IGFsbCB0aGUgZmllbGRzIGRlZmluZWQgaW4gdGhlIAo+PiB2aXJ0aW8gc3BlYy4KPj4KPj4gVGhh
bmtzCj4+Cj4gT0suIEkgbm90aWNlZCB0aGlzIGlzbid0IHN0cmljdGx5IGltcGxlbWVudGVkIGlu
IHRoZSBjdXJyZW50IHZpcnRpbyAKPiBjb2Rlcy4KPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBh
bHJlYWR5IGEgY29uc2Vuc3VzLiBJIHdpbGwgZm9sbG93IGl0IGlmIHRoaXMgCj4gaXMgdGhlIG9w
aW5pb24gb2YgdGhlIG1ham9yaXR5LgoKClBsZWFzZSBkbyB0aGF0LCB0aGlzIGZvcmNlcyB1cyB0
byBtYWludGFpbiB1QUJJIGNvbXBhdGliaWxpdHkgd2hpY2ggaXMgCndoYXQgTGludXggdHJ5IHRv
IG1haW50YWluIGZvciBldmVyLgoKVGhhbmtzCgoKPgo+IFRoYW5rcy4KPgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
