Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C665DC433ED
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 02:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D6461002
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 02:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D6461002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0818240472;
	Tue,  6 Apr 2021 02:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqpetHMsE5hO; Tue,  6 Apr 2021 02:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F74340471;
	Tue,  6 Apr 2021 02:03:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69005C000C;
	Tue,  6 Apr 2021 02:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 102A3C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 02:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3BA684056
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 02:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LB1mxrw_GsK7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 02:03:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D90248404A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 02:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617674615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NE0jWj+e38GjOmQ3dzCrwVMGgnT57rdacD0LpLJtGWM=;
 b=GhYyhSFoJqPrReLnRtFe8YWTUSboDP4pXrVGMg8DgKRf8RwzLbDQvir/DaU7ZTn3BkIZFq
 ODFovFIETrdXTrHHVF7pyd1Uf7WUDuOkxNYrVVVXj0jzTJ/qP81/rNjsbVglr1uYVOWso+
 KBwjnYczIi4uedh2hY35VcFi+aG/jg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271--1dPHH2oMvmRLN28cKfmKw-1; Mon, 05 Apr 2021 22:03:32 -0400
X-MC-Unique: -1dPHH2oMvmRLN28cKfmKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC20287A82A;
 Tue,  6 Apr 2021 02:03:30 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 586F21C4;
 Tue,  6 Apr 2021 02:03:24 +0000 (UTC)
Subject: Re: [PATCH net] virtio_net: Do not pull payload in skb->head
To: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20210402132602.3659282-1-eric.dumazet@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61d05135-3a25-b145-769f-ee7c72f46d7b@redhat.com>
Date: Tue, 6 Apr 2021 10:03:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210402132602.3659282-1-eric.dumazet@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

CtTaIDIwMjEvNC8yIM/Czuc5OjI2LCBFcmljIER1bWF6ZXQg0LS1wDoKPiBGcm9tOiBFcmljIER1
bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Cj4KPiBYdWFuIFpodW8gcmVwb3J0ZWQgdGhhdCBj
b21taXQgMzIyNmIxNThlNjdjICgibmV0OiBhdm9pZCAzMiB4IHRydWVzaXplCj4gdW5kZXItZXN0
aW1hdGlvbiBmb3IgdGlueSBza2JzIikgYnJvdWdodCAgYSB+MTAlIHBlcmZvcm1hbmNlIGRyb3Au
Cj4KPiBUaGUgcmVhc29uIGZvciB0aGUgcGVyZm9ybWFuY2UgZHJvcCB3YXMgdGhhdCBHUk8gd2Fz
IGZvcmNlZAo+IHRvIGNoYWluIHNrX2J1ZmYgKHVzaW5nIHNrYl9zaGluZm8oc2tiKS0+ZnJhZ19s
aXN0KSwgd2hpY2gKPiB1c2VzIG1vcmUgbWVtb3J5IGJ1dCBhbHNvIGNhdXNlIHBhY2tldCBjb25z
dW1lcnMgdG8gZ28gb3Zlcgo+IGEgbG90IG9mIG92ZXJoZWFkIGhhbmRsaW5nIGFsbCB0aGUgdGlu
eSBza2JzLgo+Cj4gSXQgdHVybnMgb3V0IHRoYXQgdmlydGlvX25ldCBwYWdlX3RvX3NrYigpIGhh
cyBhIHdyb25nIHN0cmF0ZWd5IDoKPiBJdCBhbGxvY2F0ZXMgc2ticyB3aXRoIEdPT0RfQ09QWV9M
RU4gKDEyOCkgYnl0ZXMgaW4gc2tiLT5oZWFkLCB0aGVuCj4gY29waWVzIDEyOCBieXRlcyBmcm9t
IHRoZSBwYWdlLCBiZWZvcmUgZmVlZGluZyB0aGUgcGFja2V0IHRvIEdSTyBzdGFjay4KPgo+IFRo
aXMgd2FzIHN1Ym9wdGltYWwgYmVmb3JlIGNvbW1pdCAzMjI2YjE1OGU2N2MgKCJuZXQ6IGF2b2lk
IDMyIHggdHJ1ZXNpemUKPiB1bmRlci1lc3RpbWF0aW9uIGZvciB0aW55IHNrYnMiKSBiZWNhdXNl
IEdSTyB3YXMgdXNpbmcgMiBmcmFncyBwZXIgTVNTLAo+IG1lYW5pbmcgd2Ugd2VyZSBub3QgcGFj
a2luZyBNU1Mgd2l0aCAxMDAlIGVmZmljaWVuY3kuCj4KPiBGaXggaXMgdG8gcHVsbCBvbmx5IHRo
ZSBldGhlcm5ldCBoZWFkZXIgaW4gcGFnZV90b19za2IoKQo+Cj4gVGhlbiwgd2UgY2hhbmdlIHZp
cnRpb19uZXRfaGRyX3RvX3NrYigpIHRvIHB1bGwgdGhlIG1pc3NpbmcKPiBoZWFkZXJzLCBpbnN0
ZWFkIG9mIGFzc3VtaW5nIHRoZXkgd2VyZSBhbHJlYWR5IHB1bGxlZCBieSBjYWxsZXJzLgo+Cj4g
VGhpcyBmaXhlcyB0aGUgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiwgYnV0IGNvdWxkIGFsc28gYWxs
b3cgdmlydGlvX25ldAo+IHRvIGFjY2VwdCBwYWNrZXRzIHdpdGggbW9yZSB0aGFuIDEyOGJ5dGVz
IG9mIGhlYWRlcnMuCj4KPiBNYW55IHRoYW5rcyB0byBYdWFuIFpodW8gZm9yIGhpcyByZXBvcnQs
IGFuZCBoaXMgdGVzdHMvaGVscC4KPgo+IEZpeGVzOiAzMjI2YjE1OGU2N2MgKCJuZXQ6IGF2b2lk
IDMyIHggdHJ1ZXNpemUgdW5kZXItZXN0aW1hdGlvbiBmb3IgdGlueSBza2JzIikKPiBSZXBvcnRl
ZC1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiBMaW5rOiBodHRw
czovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9uZXRkZXYvbXNnNzMxMzk3Lmh0bWwKPiBDby1EZXZl
bG9wZWQtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Cj4gQ2M6ICJNaWNoYWVs
IFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4KPiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPiBDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKPiAtLS0KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+
ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgfCAxMCArKysrKysrLS0tCj4gICBpbmNsdWRl
L2xpbnV4L3ZpcnRpb19uZXQuaCB8IDE0ICsrKysrKysrKy0tLS0tCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXgg
ODJlNTIwZDJjYjEyMjlhMGM3YjlmZDBkZWYzZTRhNzEzNTUzNjQ3OC4uMDgyNGU2OTk5ZTQ5OTU3
ZjdhYWY3Yzk5MGY2MjU5NzkyZDQyZjMyYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtNDA2LDkgKzQw
NiwxMyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLAo+ICAgCW9mZnNldCArPSBoZHJfcGFkZGVkX2xlbjsKPiAgIAlwICs9IGhkcl9w
YWRkZWRfbGVuOwo+ICAgCj4gLQljb3B5ID0gbGVuOwo+IC0JaWYgKGNvcHkgPiBza2JfdGFpbHJv
b20oc2tiKSkKPiAtCQljb3B5ID0gc2tiX3RhaWxyb29tKHNrYik7Cj4gKwkvKiBDb3B5IGFsbCBm
cmFtZSBpZiBpdCBmaXRzIHNrYi0+aGVhZCwgb3RoZXJ3aXNlCj4gKwkgKiB3ZSBsZXQgdmlydGlv
X25ldF9oZHJfdG9fc2tiKCkgYW5kIEdSTyBwdWxsIGhlYWRlcnMgYXMgbmVlZGVkLgo+ICsJICov
Cj4gKwlpZiAobGVuIDw9IHNrYl90YWlscm9vbShza2IpKQo+ICsJCWNvcHkgPSBsZW47Cj4gKwll
bHNlCj4gKwkJY29weSA9IEVUSF9ITEVOICsgbWV0YXNpemU7Cj4gICAJc2tiX3B1dF9kYXRhKHNr
YiwgcCwgY29weSk7Cj4gICAKPiAgIAlpZiAobWV0YXNpemUpIHsKPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+IGlu
ZGV4IDk4Nzc1ZDdmYTY5NjMyZTJjMmRhMzBiNTgxYTY2NmY3ZmJiOTRiNjQuLmI0NjVmOGYzZTU1
NGYyN2NlZDQ1YzM1ZjU0ZjExM2NmNmRjZTFmMDcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC92aXJ0aW9fbmV0LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+IEBAIC02
NSwxNCArNjUsMTggQEAgc3RhdGljIGlubGluZSBpbnQgdmlydGlvX25ldF9oZHJfdG9fc2tiKHN0
cnVjdCBza19idWZmICpza2IsCj4gICAJc2tiX3Jlc2V0X21hY19oZWFkZXIoc2tiKTsKPiAgIAo+
ICAgCWlmIChoZHItPmZsYWdzICYgVklSVElPX05FVF9IRFJfRl9ORUVEU19DU1VNKSB7Cj4gLQkJ
dTE2IHN0YXJ0ID0gX192aXJ0aW8xNl90b19jcHUobGl0dGxlX2VuZGlhbiwgaGRyLT5jc3VtX3N0
YXJ0KTsKPiAtCQl1MTYgb2ZmID0gX192aXJ0aW8xNl90b19jcHUobGl0dGxlX2VuZGlhbiwgaGRy
LT5jc3VtX29mZnNldCk7Cj4gKwkJdTMyIHN0YXJ0ID0gX192aXJ0aW8xNl90b19jcHUobGl0dGxl
X2VuZGlhbiwgaGRyLT5jc3VtX3N0YXJ0KTsKPiArCQl1MzIgb2ZmID0gX192aXJ0aW8xNl90b19j
cHUobGl0dGxlX2VuZGlhbiwgaGRyLT5jc3VtX29mZnNldCk7Cj4gKwkJdTMyIG5lZWRlZCA9IHN0
YXJ0ICsgbWF4X3QodTMyLCB0aGxlbiwgb2ZmICsgc2l6ZW9mKF9fc3VtMTYpKTsKPiArCj4gKwkJ
aWYgKCFwc2tiX21heV9wdWxsKHNrYiwgbmVlZGVkKSkKPiArCQkJcmV0dXJuIC1FSU5WQUw7Cj4g
ICAKPiAgIAkJaWYgKCFza2JfcGFydGlhbF9jc3VtX3NldChza2IsIHN0YXJ0LCBvZmYpKQo+ICAg
CQkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAgIAkJcF9vZmYgPSBza2JfdHJhbnNwb3J0X29mZnNl
dChza2IpICsgdGhsZW47Cj4gLQkJaWYgKHBfb2ZmID4gc2tiX2hlYWRsZW4oc2tiKSkKPiArCQlp
ZiAoIXBza2JfbWF5X3B1bGwoc2tiLCBwX29mZikpCj4gICAJCQlyZXR1cm4gLUVJTlZBTDsKPiAg
IAl9IGVsc2Ugewo+ICAgCQkvKiBnc28gcGFja2V0cyB3aXRob3V0IE5FRURTX0NTVU0gZG8gbm90
IHNldCB0cmFuc3BvcnRfb2Zmc2V0Lgo+IEBAIC0xMDIsMTQgKzEwNiwxNCBAQCBzdGF0aWMgaW5s
aW5lIGludCB2aXJ0aW9fbmV0X2hkcl90b19za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYiwKPiAgIAkJ
CX0KPiAgIAo+ICAgCQkJcF9vZmYgPSBrZXlzLmNvbnRyb2wudGhvZmYgKyB0aGxlbjsKPiAtCQkJ
aWYgKHBfb2ZmID4gc2tiX2hlYWRsZW4oc2tiKSB8fAo+ICsJCQlpZiAoIXBza2JfbWF5X3B1bGwo
c2tiLCBwX29mZikgfHwKPiAgIAkJCSAgICBrZXlzLmJhc2ljLmlwX3Byb3RvICE9IGlwX3Byb3Rv
KQo+ICAgCQkJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gICAJCQlza2Jfc2V0X3RyYW5zcG9ydF9o
ZWFkZXIoc2tiLCBrZXlzLmNvbnRyb2wudGhvZmYpOwo+ICAgCQl9IGVsc2UgaWYgKGdzb190eXBl
KSB7Cj4gICAJCQlwX29mZiA9IHRobGVuOwo+IC0JCQlpZiAocF9vZmYgPiBza2JfaGVhZGxlbihz
a2IpKQo+ICsJCQlpZiAoIXBza2JfbWF5X3B1bGwoc2tiLCBwX29mZikpCj4gICAJCQkJcmV0dXJu
IC1FSU5WQUw7Cj4gICAJCX0KPiAgIAl9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
