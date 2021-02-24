Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2B2C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:15:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B9464D79
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B9464D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF7864C8BF;
	Wed, 24 Feb 2021 09:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lYY_vUx6Wycy; Wed, 24 Feb 2021 09:15:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 350804C9E3;
	Wed, 24 Feb 2021 09:15:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3CFC000B;
	Wed, 24 Feb 2021 09:15:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA80C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CAA94309A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wx3SwjtuGF1h
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:15:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49BB943098
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614158109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1thcThqP7wAoJT76dYbtDdFPL4dmNokbFwdWPI9mbg=;
 b=JSPxXjjfWdSL7ZVOz+ksWA0rxJaHHt15Zd0AViFo5o7gR2wrGLe4MizO+mo19pt49EQUD+
 5ip3mC8f8c3KuQS8RgTsT7xOFnE4GQ5x27E3/0+ULrE9frIkXZTCNpo30EoysVRzBcqzgy
 mqdSLvUBFPXSqC1DC58zxmI0ZFBzCCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-NVurPHJWMc23KnQGxguxdA-1; Wed, 24 Feb 2021 04:15:05 -0500
X-MC-Unique: NVurPHJWMc23KnQGxguxdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CD3F86A065;
 Wed, 24 Feb 2021 09:15:04 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EC8A60C4D;
 Wed, 24 Feb 2021 09:14:58 +0000 (UTC)
Subject: Re: [PATCH linux-next 9/9] vdpa/mlx5: Forward only packets with
 allowed MAC address
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-10-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a11fb961-8901-054c-594b-ccb09dbaa817@redhat.com>
Date: Wed, 24 Feb 2021 17:14:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224061844.137776-10-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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

Ck9uIDIwMjEvMi8yNCAyOjE4IOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+IEZyb206IEVs
aSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Cj4gQWRkIHJ1bGVzIHRvIGZvcndhcmQgcGFja2V0
cyB0byB0aGUgbmV0IGRldmljZSdzIFRJUiBvbmx5IGlmIHRoZQo+IGRlc3RpbmF0aW9uIE1BQyBp
cyBlcXVhbCB0byB0aGUgY29uZmlndXJlZCBNQUMuIFRoaXMgaXMgcmVxdWlyZWQgdG8KPiBwcmV2
ZW50IHRoZSBuZXRkZXZpY2UgZnJvbSByZWNlaXZpbmcgdHJhZmZpYyBub3QgZGVzdGluZWQgdG8g
aXRzCj4gY29uZmlndXJlZCBNQUMuCgoKSnVzdCB0byBjb25maXJtLCB0aGlzIHdpbGwgb25seSBh
cHBseSB0byB1bmljYXN0IHBhY2tldCBhbmQgd2Ugd2lsbCAKc3RpbGwgbGV0IG11bHRpY2FzdC9i
cm9hZGNhc3QgdG8gZ28/CgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxl
bGljQG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlh
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDg0ICsr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNl
cnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiBpbmRleCA1MWEzZmM0Y2RlNGQuLjliNTgwYzY3YWNkYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiBAQCAtMTQ3LDcgKzE0Nyw4IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbmV0IHsK
PiAgIAlzdHJ1Y3QgbXV0ZXggcmVzbG9jazsKPiAgIAlzdHJ1Y3QgbWx4NV9mbG93X3RhYmxlICpy
eGZ0Owo+ICAgCXN0cnVjdCBtbHg1X2ZjICpyeF9jb3VudGVyOwo+IC0Jc3RydWN0IG1seDVfZmxv
d19oYW5kbGUgKnJ4X3J1bGU7Cj4gKwlzdHJ1Y3QgbWx4NV9mbG93X2hhbmRsZSAqcnhfcnVsZV91
Y2FzdDsKPiArCXN0cnVjdCBtbHg1X2Zsb3dfaGFuZGxlICpyeF9ydWxlX21jYXN0Owo+ICAgCWJv
b2wgc2V0dXA7Cj4gICAJdTE2IG10dTsKPiAgIH07Cj4gQEAgLTEyOTQsMjEgKzEyOTUsMzQgQEAg
c3RhdGljIGludCBhZGRfZndkX3RvX3RpcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAg
IAlzdHJ1Y3QgbWx4NV9mbG93X3RhYmxlX2F0dHIgZnRfYXR0ciA9IHt9Owo+ICAgCXN0cnVjdCBt
bHg1X2Zsb3dfYWN0IGZsb3dfYWN0ID0ge307Cj4gICAJc3RydWN0IG1seDVfZmxvd19uYW1lc3Bh
Y2UgKm5zOwo+ICsJc3RydWN0IG1seDVfZmxvd19zcGVjICpzcGVjOwo+ICsJdm9pZCAqaGVhZGVy
c19jOwo+ICsJdm9pZCAqaGVhZGVyc192Owo+ICsJdTggKmRtYWNfYzsKPiArCXU4ICpkbWFjX3Y7
Cj4gICAJaW50IGVycjsKPiAgIAo+IC0JLyogZm9yIG5vdywgb25lIGVudHJ5LCBtYXRjaCBhbGws
IGZvcndhcmQgdG8gdGlyICovCj4gLQlmdF9hdHRyLm1heF9mdGUgPSAxOwo+IC0JZnRfYXR0ci5h
dXRvZ3JvdXAubWF4X251bV9ncm91cHMgPSAxOwo+ICsJc3BlYyA9IGt2emFsbG9jKHNpemVvZigq
c3BlYyksIEdGUF9LRVJORUwpOwo+ICsJaWYgKCFzcGVjKQo+ICsJCXJldHVybiAtRU5PTUVNOwo+
ICsKPiArCXNwZWMtPm1hdGNoX2NyaXRlcmlhX2VuYWJsZSA9IE1MWDVfTUFUQ0hfT1VURVJfSEVB
REVSUzsKPiArCWZ0X2F0dHIubWF4X2Z0ZSA9IDI7Cj4gKwlmdF9hdHRyLmF1dG9ncm91cC5tYXhf
bnVtX2dyb3VwcyA9IDI7Cj4gICAKPiAtCW5zID0gbWx4NV9nZXRfZmxvd19uYW1lc3BhY2UobmRl
di0+bXZkZXYubWRldiwgTUxYNV9GTE9XX05BTUVTUEFDRV9CWVBBU1MpOwo+ICsJbnMgPSBtbHg1
X2dldF9mbG93X25hbWVzcGFjZShuZGV2LT5tdmRldi5tZGV2LAo+ICsJCQkJICAgICBNTFg1X0ZM
T1dfTkFNRVNQQUNFX0JZUEFTUyk7Cj4gICAJaWYgKCFucykgewo+IC0JCW1seDVfdmRwYV93YXJu
KCZuZGV2LT5tdmRldiwgImdldCBmbG93IG5hbWVzcGFjZVxuIik7Cj4gLQkJcmV0dXJuIC1FT1BO
T1RTVVBQOwo+ICsJCW1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwgImZhaWxlZCB0byBnZXQg
ZmxvdyBuYW1lc3BhY2VcbiIpOwo+ICsJCWVyciA9IC1FT1BOT1RTVVBQOwo+ICsJCWdvdG8gZXJy
X25zOwo+ICAgCX0KPiAgIAo+ICAgCW5kZXYtPnJ4ZnQgPSBtbHg1X2NyZWF0ZV9hdXRvX2dyb3Vw
ZWRfZmxvd190YWJsZShucywgJmZ0X2F0dHIpOwo+IC0JaWYgKElTX0VSUihuZGV2LT5yeGZ0KSkK
PiAtCQlyZXR1cm4gUFRSX0VSUihuZGV2LT5yeGZ0KTsKPiArCWlmIChJU19FUlIobmRldi0+cnhm
dCkpIHsKPiArCQllcnIgPSBQVFJfRVJSKG5kZXYtPnJ4ZnQpOwo+ICsJCWdvdG8gZXJyX25zOwo+
ICsJfQo+ICAgCj4gICAJbmRldi0+cnhfY291bnRlciA9IG1seDVfZmNfY3JlYXRlKG5kZXYtPm12
ZGV2Lm1kZXYsIGZhbHNlKTsKPiAgIAlpZiAoSVNfRVJSKG5kZXYtPnJ4X2NvdW50ZXIpKSB7Cj4g
QEAgLTEzMTYsMzcgKzEzMzAsNjcgQEAgc3RhdGljIGludCBhZGRfZndkX3RvX3RpcihzdHJ1Y3Qg
bWx4NV92ZHBhX25ldCAqbmRldikKPiAgIAkJZ290byBlcnJfZmM7Cj4gICAJfQo+ICAgCj4gLQlm
bG93X2FjdC5hY3Rpb24gPSBNTFg1X0ZMT1dfQ09OVEVYVF9BQ1RJT05fRldEX0RFU1QgfCBNTFg1
X0ZMT1dfQ09OVEVYVF9BQ1RJT05fQ09VTlQ7Cj4gKwloZWFkZXJzX2MgPSBNTFg1X0FERFJfT0Yo
ZnRlX21hdGNoX3BhcmFtLCBzcGVjLT5tYXRjaF9jcml0ZXJpYSwgb3V0ZXJfaGVhZGVycyk7Cj4g
KwlkbWFjX2MgPSBNTFg1X0FERFJfT0YoZnRlX21hdGNoX3BhcmFtLCBoZWFkZXJzX2MsIG91dGVy
X2hlYWRlcnMuZG1hY180N18xNik7Cj4gKwltZW1zZXQoZG1hY19jLCAweGZmLCBFVEhfQUxFTik7
Cj4gKwloZWFkZXJzX3YgPSBNTFg1X0FERFJfT0YoZnRlX21hdGNoX3BhcmFtLCBzcGVjLT5tYXRj
aF92YWx1ZSwgb3V0ZXJfaGVhZGVycyk7Cj4gKwlkbWFjX3YgPSBNTFg1X0FERFJfT0YoZnRlX21h
dGNoX3BhcmFtLCBoZWFkZXJzX3YsIG91dGVyX2hlYWRlcnMuZG1hY180N18xNik7Cj4gKwlldGhl
cl9hZGRyX2NvcHkoZG1hY192LCBuZGV2LT5jb25maWcubWFjKTsKPiArCj4gKwlmbG93X2FjdC5h
Y3Rpb24gPSBNTFg1X0ZMT1dfQ09OVEVYVF9BQ1RJT05fRldEX0RFU1QgfAo+ICsJCQkgIE1MWDVf
RkxPV19DT05URVhUX0FDVElPTl9DT1VOVDsKPiAgIAlkZXN0WzBdLnR5cGUgPSBNTFg1X0ZMT1df
REVTVElOQVRJT05fVFlQRV9USVI7Cj4gICAJZGVzdFswXS50aXJfbnVtID0gbmRldi0+cmVzLnRp
cm47Cj4gICAJZGVzdFsxXS50eXBlID0gTUxYNV9GTE9XX0RFU1RJTkFUSU9OX1RZUEVfQ09VTlRF
UjsKPiAgIAlkZXN0WzFdLmNvdW50ZXJfaWQgPSBtbHg1X2ZjX2lkKG5kZXYtPnJ4X2NvdW50ZXIp
Owo+IC0JbmRldi0+cnhfcnVsZSA9IG1seDVfYWRkX2Zsb3dfcnVsZXMobmRldi0+cnhmdCwgTlVM
TCwgJmZsb3dfYWN0LCBkZXN0LCAyKTsKPiAtCWlmIChJU19FUlIobmRldi0+cnhfcnVsZSkpIHsK
PiAtCQllcnIgPSBQVFJfRVJSKG5kZXYtPnJ4X3J1bGUpOwo+IC0JCW5kZXYtPnJ4X3J1bGUgPSBO
VUxMOwo+IC0JCWdvdG8gZXJyX3J1bGU7Cj4gKwluZGV2LT5yeF9ydWxlX3VjYXN0ID0gbWx4NV9h
ZGRfZmxvd19ydWxlcyhuZGV2LT5yeGZ0LCBzcGVjLCAmZmxvd19hY3QsCj4gKwkJCQkJCSAgZGVz
dCwgMik7Cj4gKwo+ICsJaWYgKElTX0VSUihuZGV2LT5yeF9ydWxlX3VjYXN0KSkgewo+ICsJCWVy
ciA9IFBUUl9FUlIobmRldi0+cnhfcnVsZV91Y2FzdCk7Cj4gKwkJbmRldi0+cnhfcnVsZV91Y2Fz
dCA9IE5VTEw7Cj4gKwkJZ290byBlcnJfcnVsZV91Y2FzdDsKPiArCX0KPiArCj4gKwltZW1zZXQo
ZG1hY19jLCAwLCBFVEhfQUxFTik7Cj4gKwltZW1zZXQoZG1hY192LCAwLCBFVEhfQUxFTik7Cj4g
KwlkbWFjX2NbMF0gPSAxOwo+ICsJZG1hY192WzBdID0gMTsKPiArCWZsb3dfYWN0LmFjdGlvbiA9
IE1MWDVfRkxPV19DT05URVhUX0FDVElPTl9GV0RfREVTVDsKPiArCW5kZXYtPnJ4X3J1bGVfbWNh
c3QgPSBtbHg1X2FkZF9mbG93X3J1bGVzKG5kZXYtPnJ4ZnQsIHNwZWMsICZmbG93X2FjdCwKPiAr
CQkJCQkJICBkZXN0LCAxKTsKPiArCWlmIChJU19FUlIobmRldi0+cnhfcnVsZV9tY2FzdCkpIHsK
PiArCQllcnIgPSBQVFJfRVJSKG5kZXYtPnJ4X3J1bGVfbWNhc3QpOwo+ICsJCW5kZXYtPnJ4X3J1
bGVfbWNhc3QgPSBOVUxMOwo+ICsJCWdvdG8gZXJyX3J1bGVfbWNhc3Q7Cj4gICAJfQo+ICAgCj4g
KwlrdmZyZWUoc3BlYyk7Cj4gICAJcmV0dXJuIDA7Cj4gICAKPiAtZXJyX3J1bGU6Cj4gK2Vycl9y
dWxlX21jYXN0Ogo+ICsJbWx4NV9kZWxfZmxvd19ydWxlcyhuZGV2LT5yeF9ydWxlX3VjYXN0KTsK
PiArCW5kZXYtPnJ4X3J1bGVfdWNhc3QgPSBOVUxMOwo+ICtlcnJfcnVsZV91Y2FzdDoKPiAgIAlt
bHg1X2ZjX2Rlc3Ryb3kobmRldi0+bXZkZXYubWRldiwgbmRldi0+cnhfY291bnRlcik7Cj4gICBl
cnJfZmM6Cj4gICAJbWx4NV9kZXN0cm95X2Zsb3dfdGFibGUobmRldi0+cnhmdCk7Cj4gK2Vycl9u
czoKPiArCWt2ZnJlZShzcGVjKTsKPiAgIAlyZXR1cm4gZXJyOwo+ICAgfQo+ICAgCj4gICBzdGF0
aWMgdm9pZCByZW1vdmVfZndkX3RvX3RpcihzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAg
IHsKPiAtCWlmICghbmRldi0+cnhfcnVsZSkKPiArCWlmICghbmRldi0+cnhfcnVsZV91Y2FzdCkK
PiAgIAkJcmV0dXJuOwo+ICAgCj4gLQltbHg1X2RlbF9mbG93X3J1bGVzKG5kZXYtPnJ4X3J1bGUp
Owo+ICsJbWx4NV9kZWxfZmxvd19ydWxlcyhuZGV2LT5yeF9ydWxlX21jYXN0KTsKPiArCW5kZXYt
PnJ4X3J1bGVfbWNhc3QgPSBOVUxMOwo+ICsJbWx4NV9kZWxfZmxvd19ydWxlcyhuZGV2LT5yeF9y
dWxlX3VjYXN0KTsKPiArCW5kZXYtPnJ4X3J1bGVfdWNhc3QgPSBOVUxMOwo+ICAgCW1seDVfZmNf
ZGVzdHJveShuZGV2LT5tdmRldi5tZGV2LCBuZGV2LT5yeF9jb3VudGVyKTsKPiAgIAltbHg1X2Rl
c3Ryb3lfZmxvd190YWJsZShuZGV2LT5yeGZ0KTsKPiAtCj4gLQluZGV2LT5yeF9ydWxlID0gTlVM
TDsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2tpY2tfdnEoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
