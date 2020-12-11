Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F02C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 02:53:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B25223E51
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 02:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B25223E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5E9786CEC;
	Fri, 11 Dec 2020 02:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0voTlnZ6qO9; Fri, 11 Dec 2020 02:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEF1B86CDB;
	Fri, 11 Dec 2020 02:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B63C6C0893;
	Fri, 11 Dec 2020 02:53:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 693B5C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 573C286CDB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z6FXqtOqvJJN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3454F86CD7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 02:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607655205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiPKVpWH0fdM5YM+mTSeR5QhSR34AtKMUPbWzUzsqyo=;
 b=VuXDdMVxmoGJjdcNJJLHv3LIb5JinUW3n9vXWVQaWzKH5JAojHfmNwhpGHgJIXmHojgJ6t
 YS6wg+UW5dJtPuU0tyUvcGSgI3ZQYNa5uYOBZJoy5SoWgIIswSxFKyBqrcdCZ8MlrS9ndM
 F9zlOsRF2PWSqQ0cKGmWcRG9gMK+55E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-BHb0Ua15ObWprHt7XAFhdQ-1; Thu, 10 Dec 2020 21:53:21 -0500
X-MC-Unique: BHb0Ua15ObWprHt7XAFhdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11177180A097;
 Fri, 11 Dec 2020 02:53:20 +0000 (UTC)
Received: from [10.72.12.185] (ovpn-12-185.pek2.redhat.com [10.72.12.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BA1A60BF1;
 Fri, 11 Dec 2020 02:53:07 +0000 (UTC)
Subject: Re: [PATCH net] vhost_net: fix high cpu load when sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1607514504-20956-1-git-send-email-wangyunjian@huawei.com>
 <20201209074832-mutt-send-email-mst@kernel.org>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB61ADF@DGGEMM533-MBX.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f95f061c-dcac-9d56-94a0-50ef683946cd@redhat.com>
Date: Fri, 11 Dec 2020 10:52:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB61ADF@DGGEMM533-MBX.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 xudingke <xudingke@huawei.com>, "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjAvMTIvOSDkuIvljYg5OjI3LCB3YW5neXVuamlhbiB3cm90ZToKPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIFttYWlsdG86bXN0
QHJlZGhhdC5jb21dCj4+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgOSwgMjAyMCA4OjUwIFBN
Cj4+IFRvOiB3YW5neXVuamlhbiA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPj4gQ2M6IGphc293
YW5nQHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Owo+PiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBMaWxpanVuIChKZXJyeSkgPGplcnJ5LmxpbGlq
dW5AaHVhd2VpLmNvbT47Cj4+IGNoZW5jaGFuZ2h1IDxjaGVuY2hhbmdodUBodWF3ZWkuY29tPjsg
eHVkaW5na2UgPHh1ZGluZ2tlQGh1YXdlaS5jb20+Cj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0
XSB2aG9zdF9uZXQ6IGZpeCBoaWdoIGNwdSBsb2FkIHdoZW4gc2VuZG1zZyBmYWlscwo+Pgo+PiBP
biBXZWQsIERlYyAwOSwgMjAyMCBhdCAwNzo0ODoyNFBNICswODAwLCB3YW5neXVuamlhbiB3cm90
ZToKPj4+IEZyb206IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPj4+Cj4+
PiBDdXJyZW50bHkgd2UgYnJlYWsgdGhlIGxvb3AgYW5kIHdha2UgdXAgdGhlIHZob3N0X3dvcmtl
ciB3aGVuIHNlbmRtc2cKPj4+IGZhaWxzLiBXaGVuIHRoZSB3b3JrZXIgd2FrZXMgdXAgYWdhaW4s
IHdlJ2xsIG1lZXQgdGhlIHNhbWUgZXJyb3IuIFRoaXMKPj4+IHdpbGwgY2F1c2UgaGlnaCBDUFUg
bG9hZC4gVG8gZml4IHRoaXMgaXNzdWUsIHdlIGNhbiBza2lwIHRoaXMKPj4+IGRlc2NyaXB0aW9u
IGJ5IGlnbm9yaW5nIHRoZSBlcnJvci4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBZdW5qaWFuIFdh
bmcgPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy92aG9zdC9u
ZXQuYyB8IDI0ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aG9zdC9uZXQuYyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMgaW5kZXgKPj4+IDUzMWEwMGQ3
MDNjZC4uYWM5NTBiMTEyMGY1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC9uZXQuYwo+
Pj4gKysrIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+Pj4gQEAgLTgyOSwxNCArODI5LDggQEAgc3Rh
dGljIHZvaWQgaGFuZGxlX3R4X2NvcHkoc3RydWN0IHZob3N0X25ldCAqbmV0LAo+Pj4gc3RydWN0
IHNvY2tldCAqc29jaykKPj4+Cj4+PiAgIAkJLyogVE9ETzogQ2hlY2sgc3BlY2lmaWMgZXJyb3Ig
YW5kIGJvbWIgb3V0IHVubGVzcyBFTk9CVUZTPyAqLwo+Pj4gICAJCWVyciA9IHNvY2stPm9wcy0+
c2VuZG1zZyhzb2NrLCAmbXNnLCBsZW4pOwo+Pj4gLQkJaWYgKHVubGlrZWx5KGVyciA8IDApKSB7
Cj4+PiAtCQkJdmhvc3RfZGlzY2FyZF92cV9kZXNjKHZxLCAxKTsKPj4+IC0JCQl2aG9zdF9uZXRf
ZW5hYmxlX3ZxKG5ldCwgdnEpOwo+Pj4gLQkJCWJyZWFrOwo+Pj4gLQkJfQo+Pj4gLQkJaWYgKGVy
ciAhPSBsZW4pCj4+PiAtCQkJcHJfZGVidWcoIlRydW5jYXRlZCBUWCBwYWNrZXQ6IGxlbiAlZCAh
PSAlemRcbiIsCj4+PiAtCQkJCSBlcnIsIGxlbik7Cj4+PiArCQlpZiAodW5saWtlbHkoZXJyIDwg
MCB8fCBlcnIgIT0gbGVuKSkKPj4+ICsJCQl2cV9lcnIodnEsICJGYWlsIHRvIHNlbmRpbmcgcGFj
a2V0cyBlcnIgOiAlZCwgbGVuIDogJXpkXG4iLCBlcnIsCj4+PiArbGVuKTsKPj4+ICAgZG9uZToK
Pj4+ICAgCQl2cS0+aGVhZHNbbnZxLT5kb25lX2lkeF0uaWQgPSBjcHVfdG9fdmhvc3QzMih2cSwg
aGVhZCk7Cj4+PiAgIAkJdnEtPmhlYWRzW252cS0+ZG9uZV9pZHhdLmxlbiA9IDA7Cj4+IE9uZSBv
ZiB0aGUgcmVhc29ucyBmb3Igc2VuZG1zZyB0byBmYWlsIGlzIEVOT0JVRlMuCj4+IEluIHRoYXQg
Y2FzZSBmb3Igc3VyZSB3ZSBkb24ndCB3YW50IHRvIGRyb3AgcGFja2V0Lgo+IE5vdyB0aGUgZnVu
Y3Rpb24gdGFwX3NlbmRtc2coKS90dW5fc2VuZG1zZygpIGRvbid0IHJldHVybiBFTk9CVUZTLgoK
CkkgdGhpbmsgbm90LCBpdCBjYW4gaGFwcGVuIGlmIHdlIGV4Y2VlZHMgc25kYnVmLiBFLmcgc2Vl
IHR1bl9hbGxvY19za2IoKS4KClRoYW5rcwoKCj4KPj4gVGhlcmUgY291bGQgYmUgb3RoZXIgdHJh
bnNpZW50IGVycm9ycy4KPj4gV2hpY2ggZXJyb3IgZGlkIHlvdSBlbmNvdW50ZXIsIHNwZWNpZmlj
YWxseT8KPiBDdXJyZW50bHkgYSBndWVzdCB2bSBzZW5kIGEgc2tiIHdoaWNoIGxlbmd0aCBpcyBt
b3JlIHRoYW4gNjRrLgo+IElmIHZpcnRpbyBoZHIgaXMgd3JvbmcsIHRoZSBwcm9ibGVtIHdpbGwg
YWxzbyBiZSB0cmlnZ2VyZWQuCj4KPiBUaGFua3MKPgo+Pj4gQEAgLTkyNSwxOSArOTE5LDExIEBA
IHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShzdHJ1Y3Qgdmhvc3RfbmV0Cj4+PiAqbmV0
LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+Pj4KPj4+ICAgCQkvKiBUT0RPOiBDaGVjayBzcGVjaWZp
YyBlcnJvciBhbmQgYm9tYiBvdXQgdW5sZXNzIEVOT0JVRlM/ICovCj4+PiAgIAkJZXJyID0gc29j
ay0+b3BzLT5zZW5kbXNnKHNvY2ssICZtc2csIGxlbik7Cj4+PiAtCQlpZiAodW5saWtlbHkoZXJy
IDwgMCkpIHsKPj4+IC0JCQlpZiAoemNvcHlfdXNlZCkgewo+Pj4gKwkJaWYgKHVubGlrZWx5KGVy
ciA8IDAgfHwgZXJyICE9IGxlbikpIHsKPj4+ICsJCQlpZiAoemNvcHlfdXNlZCAmJiBlcnIgPCAw
KQo+Pj4gICAJCQkJdmhvc3RfbmV0X3VidWZfcHV0KHVidWZzKTsKPj4+IC0JCQkJbnZxLT51cGVu
ZF9pZHggPSAoKHVuc2lnbmVkKW52cS0+dXBlbmRfaWR4IC0gMSkKPj4+IC0JCQkJCSUgVUlPX01B
WElPVjsKPj4+IC0JCQl9Cj4+PiAtCQkJdmhvc3RfZGlzY2FyZF92cV9kZXNjKHZxLCAxKTsKPj4+
IC0JCQl2aG9zdF9uZXRfZW5hYmxlX3ZxKG5ldCwgdnEpOwo+Pj4gLQkJCWJyZWFrOwo+Pj4gKwkJ
CXZxX2Vycih2cSwgIkZhaWwgdG8gc2VuZGluZyBwYWNrZXRzIGVyciA6ICVkLCBsZW4gOiAlemRc
biIsIGVyciwKPj4+ICtsZW4pOwo+Pj4gICAJCX0KPj4+IC0JCWlmIChlcnIgIT0gbGVuKQo+Pj4g
LQkJCXByX2RlYnVnKCJUcnVuY2F0ZWQgVFggcGFja2V0OiAiCj4+PiAtCQkJCSAiIGxlbiAlZCAh
PSAlemRcbiIsIGVyciwgbGVuKTsKPj4+ICAgCQlpZiAoIXpjb3B5X3VzZWQpCj4+PiAgIAkJCXZo
b3N0X2FkZF91c2VkX2FuZF9zaWduYWwoJm5ldC0+ZGV2LCB2cSwgaGVhZCwgMCk7Cj4+PiAgIAkJ
ZWxzZQo+Pj4gLS0KPj4+IDIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
