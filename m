Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0AFC433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 08:51:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60794613B2
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 08:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60794613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5D5740567;
	Tue, 13 Apr 2021 08:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGxZeYaZiD2R; Tue, 13 Apr 2021 08:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CCB6400B9;
	Tue, 13 Apr 2021 08:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD93C000C;
	Tue, 13 Apr 2021 08:51:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35C78C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C68E83E10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BcgdXUDGD0Q2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:51:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9F0A83E0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618303879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCposirTbsc74EjO13nDclHit9p5R2qmCz4hXiIKwZg=;
 b=TBBd6q56iYXZTl35ugoAxOmkAe41YOR0EhPjIBk8HUZTc2q7jWaFPveytIIMNZF12QEjll
 MJZAPzaaecaNUrXO5X34rh/dXXpvl8RdfZKQazQgVXOmzXNbuA5B5JP8LIHPyojbzi2DBV
 CTlEisLu+D1dreuaegNwXiDzSU/DUIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-VUhAiWeYM1WfVsiK56hWtg-1; Tue, 13 Apr 2021 04:51:17 -0400
X-MC-Unique: VUhAiWeYM1WfVsiK56hWtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAA2C83DD27;
 Tue, 13 Apr 2021 08:51:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-128.pek2.redhat.com
 [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ACD959456;
 Tue, 13 Apr 2021 08:51:07 +0000 (UTC)
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-2-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6d0666bb-7f0d-c442-13cc-9e5b715290e6@redhat.com>
Date: Tue, 13 Apr 2021 16:51:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413054733.36363-2-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xMyDPws7nMTo0NywgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gdmlydGlv
X2Rpc2FibGVfY2IgaXMgY3VycmVudGx5IGEgbm9wIGZvciBzcGxpdCByaW5nIHdpdGggZXZlbnQg
aW5kZXguCj4gVGhpcyBpcyBiZWNhdXNlIGl0IHVzZWQgdG8gYmUgYWx3YXlzIGNhbGxlZCBmcm9t
IGEgY2FsbGJhY2sgd2hlbiB3ZSBrbm93Cj4gZGV2aWNlIHdvbid0IHRyaWdnZXIgbW9yZSBldmVu
dHMgdW50aWwgd2UgdXBkYXRlIHRoZSBpbmRleC4gIEhvd2V2ZXIsCj4gbm93IHRoYXQgd2UgcnVu
IHdpdGggaW50ZXJydXB0cyBlbmFibGVkIGEgbG90IHdlIGFsc28gcG9sbCB3aXRob3V0IGEKPiBj
YWxsYmFjayBzbyB0aGF0IGlzIGRpZmZlcmVudDogZGlzYWJsaW5nIGNhbGxiYWNrcyB3aWxsIGhl
bHAgcmVkdWNlIHRoZQo+IG51bWJlciBvZiBzcHVyaW91cyBpbnRlcnJ1cHRzLgo+IEZ1cnRoZXIs
IGlmIHVzaW5nIGV2ZW50IGluZGV4IHdpdGggYSBwYWNrZWQgcmluZywgYW5kIGlmIGJlaW5nIGNh
bGxlZAo+IGZyb20gYSBjYWxsYmFjaywgd2UgYWN0dWFsbHkgZG8gZGlzYWJsZSBpbnRlcnJ1cHRz
IHdoaWNoIGlzIHVubmVjZXNzYXJ5Lgo+Cj4gRml4IGJvdGggaXNzdWVzIGJ5IHRyYWNraW5nIHdo
ZW5ldmVyIHdlIGdldCBhIGNhbGxiYWNrLiBJZiB0aGF0IGlzCj4gdGhlIGNhc2UgZGlzYWJsaW5n
IGludGVycnVwdHMgd2l0aCBldmVudCBpbmRleCBjYW4gYmUgYSBub3AuCj4gSWYgbm90IHRoZSBj
YXNlIGRpc2FibGUgaW50ZXJydXB0cy4gTm90ZTogd2l0aCBhIHNwbGl0IHJpbmcKPiB0aGVyZSdz
IG5vIGV4cGxpY2l0ICJubyBpbnRlcnJ1cHRzIiB2YWx1ZS4gRm9yIG5vdyB3ZSB3cml0ZQo+IGEg
Zml4ZWQgdmFsdWUgc28gb3VyIGNoYW5jZSBvZiB0cmlnZ2VyaW5nIGFuIGludGVydXB0Cj4gaXMg
MS9yaW5nIHNpemUuIEl0J3MgcHJvYmFibHkgYmV0dGVyIHRvIHdyaXRlIHNvbWV0aGluZwo+IHJl
bGF0ZWQgdG8gdGhlIGxhc3QgdXNlZCBpbmRleCB0aGVyZSB0byByZWR1Y2UgdGhlIGNoYW5jZQo+
IGV2ZW4gZnVydGhlci4gRm9yIG5vdyBJJ20ga2VlcGluZyBpdCBzaW1wbGUuCgoKU28gSSB3b25k
ZXIgd2hldGhlciBsYXN0X3VzZWRfaWR4IGlzIGJldHRlciwgaXQgbG9va3MgdG8gbWUgdGhlIGRl
dmljZSAKd2lsbCBuZXZlciBtb3ZlIHVzZWQgaW5kZXggImFjcm9zcyIgdGhhdDoKCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC85NDY0NzUvCgpBbmQgaXQgbG9va3MgdG8g
bWUgaXQncyBiZXR0ZXIgdG8gbW92ZSB0aGUgb3B0aW1pemF0aW9uIAooZXZlbnRfdHJpZ2dlcmVk
KSBpbnRvIGEgc2VwYXJhdGVkIHBhdGNoLgoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKystCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMjUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
aW5kZXggNzFlMTZiNTNlOWMxLi44OGYwYjE2YjExYjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiBAQCAtMTEzLDYgKzExMyw5IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgCS8qIExh
c3QgdXNlZCBpbmRleCB3ZSd2ZSBzZWVuLiAqLwo+ICAgCXUxNiBsYXN0X3VzZWRfaWR4Owo+ICAg
Cj4gKwkvKiBIaW50IGZvciBldmVudCBpZHg6IGFscmVhZHkgdHJpZ2dlcmVkIG5vIG5lZWQgdG8g
ZGlzYWJsZS4gKi8KPiArCWJvb2wgZXZlbnRfdHJpZ2dlcmVkOwo+ICsKPiAgIAl1bmlvbiB7Cj4g
ICAJCS8qIEF2YWlsYWJsZSBmb3Igc3BsaXQgcmluZyAqLwo+ICAgCQlzdHJ1Y3Qgewo+IEBAIC03
MzksNyArNzQyLDEwIEBAIHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9kaXNhYmxlX2NiX3NwbGl0KHN0
cnVjdCB2aXJ0cXVldWUgKl92cSkKPiAgIAo+ICAgCWlmICghKHZxLT5zcGxpdC5hdmFpbF9mbGFn
c19zaGFkb3cgJiBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCkpIHsKPiAgIAkJdnEtPnNwbGl0
LmF2YWlsX2ZsYWdzX3NoYWRvdyB8PSBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVDsKPiAtCQlp
ZiAoIXZxLT5ldmVudCkKPiArCQlpZiAodnEtPmV2ZW50KQo+ICsJCQkvKiBUT0RPOiB0aGlzIGlz
IGEgaGFjay4gRmlndXJlIG91dCBhIGNsZWFuZXIgdmFsdWUgdG8gd3JpdGUuICovCj4gKwkJCXZy
aW5nX3VzZWRfZXZlbnQoJnZxLT5zcGxpdC52cmluZykgPSAweDA7Cj4gKwkJZWxzZQo+ICAgCQkJ
dnEtPnNwbGl0LnZyaW5nLmF2YWlsLT5mbGFncyA9Cj4gICAJCQkJY3B1X3RvX3ZpcnRpbzE2KF92
cS0+dmRldiwKPiAgIAkJCQkJCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cpOwo+IEBAIC0x
NjA1LDYgKzE2MTEsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3Zp
cnRxdWV1ZV9wYWNrZWQoCj4gICAJdnEtPndlYWtfYmFycmllcnMgPSB3ZWFrX2JhcnJpZXJzOwo+
ICAgCXZxLT5icm9rZW4gPSBmYWxzZTsKPiAgIAl2cS0+bGFzdF91c2VkX2lkeCA9IDA7Cj4gKwl2
cS0+ZXZlbnRfdHJpZ2dlcmVkID0gZmFsc2U7Cj4gICAJdnEtPm51bV9hZGRlZCA9IDA7Cj4gICAJ
dnEtPnBhY2tlZF9yaW5nID0gdHJ1ZTsKPiAgIAl2cS0+dXNlX2RtYV9hcGkgPSB2cmluZ191c2Vf
ZG1hX2FwaSh2ZGV2KTsKPiBAQCAtMTkxOSw2ICsxOTI2LDEyIEBAIHZvaWQgdmlydHF1ZXVlX2Rp
c2FibGVfY2Ioc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gICAKPiArCS8qIElmIGRldmljZSB0cmlnZ2Vy
ZWQgYW4gZXZlbnQgYWxyZWFkeSBpdCB3b24ndCB0cmlnZ2VyIG9uZSBhZ2FpbjoKPiArCSAqIG5v
IG5lZWQgdG8gZGlzYWJsZS4KPiArCSAqLwo+ICsJaWYgKHZxLT5ldmVudF90cmlnZ2VyZWQpCj4g
KwkJcmV0dXJuOwoKCkkgZ3Vlc3Mgd2UgbmVlIHRvIGNoZWNrIHZxLT5ldmVudCBhcyB3ZWxsLgoK
VGhhbmtzCgoKPiArCj4gICAJaWYgKHZxLT5wYWNrZWRfcmluZykKPiAgIAkJdmlydHF1ZXVlX2Rp
c2FibGVfY2JfcGFja2VkKF92cSk7Cj4gICAJZWxzZQo+IEBAIC0xOTQyLDYgKzE5NTUsOSBAQCB1
bnNpZ25lZCB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUoc3RydWN0IHZpcnRxdWV1ZSAqX3Zx
KQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4g
ICAKPiArCWlmICh2cS0+ZXZlbnRfdHJpZ2dlcmVkKQo+ICsJCXZxLT5ldmVudF90cmlnZ2VyZWQg
PSBmYWxzZTsKPiArCj4gICAJcmV0dXJuIHZxLT5wYWNrZWRfcmluZyA/IHZpcnRxdWV1ZV9lbmFi
bGVfY2JfcHJlcGFyZV9wYWNrZWQoX3ZxKSA6Cj4gICAJCQkJIHZpcnRxdWV1ZV9lbmFibGVfY2Jf
cHJlcGFyZV9zcGxpdChfdnEpOwo+ICAgfQo+IEBAIC0yMDA1LDYgKzIwMjEsOSBAQCBib29sIHZp
cnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gICB7Cj4g
ICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiAgIAo+ICsJaWYg
KHZxLT5ldmVudF90cmlnZ2VyZWQpCj4gKwkJdnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZhbHNlOwo+
ICsKPiAgIAlyZXR1cm4gdnEtPnBhY2tlZF9yaW5nID8gdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxh
eWVkX3BhY2tlZChfdnEpIDoKPiAgIAkJCQkgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkX3Nw
bGl0KF92cSk7Cj4gICB9Cj4gQEAgLTIwNDQsNiArMjA2MywxMCBAQCBpcnFyZXR1cm5fdCB2cmlu
Z19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX3ZxKQo+ICAgCWlmICh1bmxpa2VseSh2cS0+YnJv
a2VuKSkKPiAgIAkJcmV0dXJuIElSUV9IQU5ETEVEOwo+ICAgCj4gKwkvKiBKdXN0IGEgaGludCBm
b3IgcGVyZm9ybWFuY2U6IHNvIGl0J3Mgb2sgdGhhdCB0aGlzIGNhbiBiZSByYWN5ISAqLwo+ICsJ
aWYgKHZxLT5ldmVudCkKPiArCQl2cS0+ZXZlbnRfdHJpZ2dlcmVkID0gdHJ1ZTsKPiArCj4gICAJ
cHJfZGVidWcoInZpcnRxdWV1ZSBjYWxsYmFjayBmb3IgJXAgKCVwKVxuIiwgdnEsIHZxLT52cS5j
YWxsYmFjayk7Cj4gICAJaWYgKHZxLT52cS5jYWxsYmFjaykKPiAgIAkJdnEtPnZxLmNhbGxiYWNr
KCZ2cS0+dnEpOwo+IEBAIC0yMDgzLDYgKzIxMDYsNyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3Zy
aW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAgCXZxLT53ZWFrX2JhcnJp
ZXJzID0gd2Vha19iYXJyaWVyczsKPiAgIAl2cS0+YnJva2VuID0gZmFsc2U7Cj4gICAJdnEtPmxh
c3RfdXNlZF9pZHggPSAwOwo+ICsJdnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZhbHNlOwo+ICAgCXZx
LT5udW1fYWRkZWQgPSAwOwo+ICAgCXZxLT51c2VfZG1hX2FwaSA9IHZyaW5nX3VzZV9kbWFfYXBp
KHZkZXYpOwo+ICAgI2lmZGVmIERFQlVHCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
