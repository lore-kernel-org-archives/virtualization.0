Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9921DC433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 03:32:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA8D64EFD
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 03:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA8D64EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A9A0543093;
	Thu, 18 Mar 2021 03:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47pNdA7lR24v; Thu, 18 Mar 2021 03:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F2DD41566;
	Thu, 18 Mar 2021 03:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22EFAC000B;
	Thu, 18 Mar 2021 03:32:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F9F0C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0919C4EDD1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vNY78eLC8-Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:32:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E30FE4EDCC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616038344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLTPt0xOZQl9IIcVBTaP1P5SgdeBnCH6KEmvNhfyD0k=;
 b=AEgF7MEhf4DplFSfJ8eT+AI25s1ztyeJ534JLSgNSs+oEOI0K3HXd+sIPg0HKg5Cm7hzeo
 7yZ5u1fszkvA0VGWQbI+YodlRkwVUPufyDskjjVsCamwoz5WpPi5d39dtFjPcI6ctmE6ti
 lIDCEWtGWDzOOZBUIhEiUcFCtglfVWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-e1GUImQ-P96rYKksfeWs3g-1; Wed, 17 Mar 2021 23:32:22 -0400
X-MC-Unique: e1GUImQ-P96rYKksfeWs3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846D31084C83;
 Thu, 18 Mar 2021 03:32:20 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-131.pek2.redhat.com
 [10.72.13.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 923922B431;
 Thu, 18 Mar 2021 03:31:58 +0000 (UTC)
Subject: Re: [PATCH v4 14/14] vdpa_sim_blk: add support for vdpa management
 tool
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210315163450.254396-1-sgarzare@redhat.com>
 <20210315163450.254396-15-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <94bb9e5a-a1b9-2e0d-d5ec-c6a3eaebea88@redhat.com>
Date: Thu, 18 Mar 2021 11:31:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315163450.254396-15-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

CtTaIDIwMjEvMy8xNiDJz87nMTI6MzQsIFN0ZWZhbm8gR2FyemFyZWxsYSDQtLXAOgo+IEVuYWJs
ZSB0aGUgdXNlciB0byBjcmVhdGUgdkRQQSBibG9jayBzaW11bGF0b3IgZGV2aWNlcyB1c2luZyB0
aGUKPiB2ZHBhIG1hbmFnZW1lbnQgdG9vbDoKPgo+ICAgICAgIyBTaG93IHZEUEEgc3VwcG9ydGVk
IGRldmljZXMKPiAgICAgICQgdmRwYSBtZ210ZGV2IHNob3cKPiAgICAgIHZkcGFzaW1fYmxrOgo+
ICAgICAgICBzdXBwb3J0ZWRfY2xhc3NlcyBibG9jawo+Cj4gICAgICAjIENyZWF0ZSBhIHZEUEEg
YmxvY2sgZGV2aWNlIG5hbWVkIGFzICdibGswJyBmcm9tIHRoZSBtYW5hZ2VtZW50Cj4gICAgICAj
IGRldmljZSB2ZHBhc2ltOgo+ICAgICAgJCB2ZHBhIGRldiBhZGQgbWdtdGRldiB2ZHBhc2ltX2Js
ayBuYW1lIGJsazAKPgo+ICAgICAgIyBTaG93IHRoZSBpbmZvIG9mIHRoZSAnYmxrMCcgZGV2aWNl
IGp1c3QgY3JlYXRlZAo+ICAgICAgJCB2ZHBhIGRldiBzaG93IGJsazAgLWpwCj4gICAgICB7Cj4g
ICAgICAgICAgImRldiI6IHsKPiAgICAgICAgICAgICAgImJsazAiOiB7Cj4gICAgICAgICAgICAg
ICAgICAidHlwZSI6ICJibG9jayIsCj4gICAgICAgICAgICAgICAgICAibWdtdGRldiI6ICJ2ZHBh
c2ltX2JsayIsCj4gICAgICAgICAgICAgICAgICAidmVuZG9yX2lkIjogMCwKPiAgICAgICAgICAg
ICAgICAgICJtYXhfdnFzIjogMSwKPiAgICAgICAgICAgICAgICAgICJtYXhfdnFfc2l6ZSI6IDI1
Ngo+ICAgICAgICAgICAgICB9Cj4gICAgICAgICAgfQo+ICAgICAgfQo+Cj4gICAgICAjIERlbGV0
ZSB0aGUgdkRQQSBkZXZpY2UgYWZ0ZXIgaXRzIHVzZQo+ICAgICAgJCB2ZHBhIGRldiBkZWwgYmxr
MAo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQu
Y29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0t
Cj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCA3NiArKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltX2Jsay5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gaW5k
ZXggNjQzYWUzYmM2MmMwLi41YmZlMWMyODE2NDUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltX2Jsay5jCj4gQEAgLTM3LDcgKzM3LDYgQEAKPiAgICNkZWZpbmUgVkRQQVNJTV9CTEtf
U0VHX01BWAkzMgo+ICAgI2RlZmluZSBWRFBBU0lNX0JMS19WUV9OVU0JMQo+ICAgCj4gLXN0YXRp
YyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9ibGtfZGV2Owo+ICAgc3RhdGljIGNoYXIgdmRwYXNp
bV9ibGtfaWRbVklSVElPX0JMS19JRF9CWVRFU10gPSAidmRwYV9ibGtfc2ltIjsKPiAgIAo+ICAg
c3RhdGljIGJvb2wgdmRwYXNpbV9ibGtfY2hlY2tfcmFuZ2UodTY0IHN0YXJ0X3NlY3Rvciwgc2l6
ZV90IHJhbmdlX3NpemUpCj4gQEAgLTI0MSwxMSArMjQwLDIzIEBAIHN0YXRpYyB2b2lkIHZkcGFz
aW1fYmxrX2dldF9jb25maWcoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHZvaWQgKmNvbmZpZykK
PiAgIAlibGtfY29uZmlnLT5ibGtfc2l6ZSA9IGNwdV90b192ZHBhc2ltMzIodmRwYXNpbSwgU0VD
VE9SX1NJWkUpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fYmxrX2lu
aXQodm9pZCkKPiArc3RhdGljIHZvaWQgdmRwYXNpbV9ibGtfbWdtdGRldl9yZWxlYXNlKHN0cnVj
dCBkZXZpY2UgKmRldikKPiArewo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IGRldmljZSB2ZHBh
c2ltX2Jsa19tZ210ZGV2ID0gewo+ICsJLmluaXRfbmFtZSA9ICJ2ZHBhc2ltX2JsayIsCj4gKwku
cmVsZWFzZSA9IHZkcGFzaW1fYmxrX21nbXRkZXZfcmVsZWFzZSwKPiArfTsKPiArCj4gK3N0YXRp
YyBpbnQgdmRwYXNpbV9ibGtfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29u
c3QgY2hhciAqbmFtZSkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciBkZXZfYXR0
ciA9IHt9Owo+ICsJc3RydWN0IHZkcGFzaW0gKnNpbWRldjsKPiAgIAlpbnQgcmV0Owo+ICAgCj4g
KwlkZXZfYXR0ci5tZ210X2RldiA9IG1kZXY7Cj4gKwlkZXZfYXR0ci5uYW1lID0gbmFtZTsKPiAg
IAlkZXZfYXR0ci5pZCA9IFZJUlRJT19JRF9CTE9DSzsKPiAgIAlkZXZfYXR0ci5zdXBwb3J0ZWRf
ZmVhdHVyZXMgPSBWRFBBU0lNX0JMS19GRUFUVVJFUzsKPiAgIAlkZXZfYXR0ci5udnFzID0gVkRQ
QVNJTV9CTEtfVlFfTlVNOwo+IEBAIC0yNTQsMjkgKzI2NSw2OCBAQCBzdGF0aWMgaW50IF9faW5p
dCB2ZHBhc2ltX2Jsa19pbml0KHZvaWQpCj4gICAJZGV2X2F0dHIud29ya19mbiA9IHZkcGFzaW1f
YmxrX3dvcms7Cj4gICAJZGV2X2F0dHIuYnVmZmVyX3NpemUgPSBWRFBBU0lNX0JMS19DQVBBQ0lU
WSA8PCBTRUNUT1JfU0hJRlQ7Cj4gICAKPiAtCXZkcGFzaW1fYmxrX2RldiA9IHZkcGFzaW1fY3Jl
YXRlKCZkZXZfYXR0cik7Cj4gLQlpZiAoSVNfRVJSKHZkcGFzaW1fYmxrX2RldikpIHsKPiAtCQly
ZXQgPSBQVFJfRVJSKHZkcGFzaW1fYmxrX2Rldik7Cj4gLQkJZ290byBvdXQ7Cj4gLQl9Cj4gKwlz
aW1kZXYgPSB2ZHBhc2ltX2NyZWF0ZSgmZGV2X2F0dHIpOwo+ICsJaWYgKElTX0VSUihzaW1kZXYp
KQo+ICsJCXJldHVybiBQVFJfRVJSKHNpbWRldik7Cj4gICAKPiAtCXJldCA9IHZkcGFfcmVnaXN0
ZXJfZGV2aWNlKCZ2ZHBhc2ltX2Jsa19kZXYtPnZkcGEsIFZEUEFTSU1fQkxLX1ZRX05VTSk7Cj4g
KwlyZXQgPSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJnNpbWRldi0+dmRwYSwgVkRQQVNJTV9CTEtf
VlFfTlVNKTsKPiAgIAlpZiAocmV0KQo+ICAgCQlnb3RvIHB1dF9kZXY7Cj4gICAKPiAgIAlyZXR1
cm4gMDsKPiAgIAo+ICAgcHV0X2RldjoKPiAtCXB1dF9kZXZpY2UoJnZkcGFzaW1fYmxrX2Rldi0+
dmRwYS5kZXYpOwo+IC1vdXQ6Cj4gKwlwdXRfZGV2aWNlKCZzaW1kZXYtPnZkcGEuZGV2KTsKPiAg
IAlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIF9fZXhpdCB2ZHBhc2ltX2Js
a19leGl0KHZvaWQpCj4gK3N0YXRpYyB2b2lkIHZkcGFzaW1fYmxrX2Rldl9kZWwoc3RydWN0IHZk
cGFfbWdtdF9kZXYgKm1kZXYsCj4gKwkJCQlzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRldikKPiAgIHsK
PiAtCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9ICZ2ZHBhc2ltX2Jsa19kZXYtPnZkcGE7Cj4g
KwlzdHJ1Y3QgdmRwYXNpbSAqc2ltZGV2ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IHZkcGFz
aW0sIHZkcGEpOwo+ICsKPiArCV92ZHBhX3VucmVnaXN0ZXJfZGV2aWNlKCZzaW1kZXYtPnZkcGEp
Owo+ICt9Cj4gKwo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfbWdtdGRldl9vcHMgdmRwYXNp
bV9ibGtfbWdtdGRldl9vcHMgPSB7Cj4gKwkuZGV2X2FkZCA9IHZkcGFzaW1fYmxrX2Rldl9hZGQs
Cj4gKwkuZGV2X2RlbCA9IHZkcGFzaW1fYmxrX2Rldl9kZWwKPiArfTsKPiAgIAo+IC0JdmRwYV91
bnJlZ2lzdGVyX2RldmljZSh2ZHBhKTsKPiArc3RhdGljIHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lk
IGlkX3RhYmxlW10gPSB7Cj4gKwl7IFZJUlRJT19JRF9CTE9DSywgVklSVElPX0RFVl9BTllfSUQg
fSwKPiArCXsgMCB9LAo+ICt9Owo+ICsKPiArc3RhdGljIHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1n
bXRfZGV2ID0gewo+ICsJLmRldmljZSA9ICZ2ZHBhc2ltX2Jsa19tZ210ZGV2LAo+ICsJLmlkX3Rh
YmxlID0gaWRfdGFibGUsCj4gKwkub3BzID0gJnZkcGFzaW1fYmxrX21nbXRkZXZfb3BzLAo+ICt9
Owo+ICsKPiArc3RhdGljIGludCBfX2luaXQgdmRwYXNpbV9ibGtfaW5pdCh2b2lkKQo+ICt7Cj4g
KwlpbnQgcmV0Owo+ICsKPiArCXJldCA9IGRldmljZV9yZWdpc3RlcigmdmRwYXNpbV9ibGtfbWdt
dGRldik7Cj4gKwlpZiAocmV0KQo+ICsJCXJldHVybiByZXQ7Cj4gKwo+ICsJcmV0ID0gdmRwYV9t
Z210ZGV2X3JlZ2lzdGVyKCZtZ210X2Rldik7Cj4gKwlpZiAocmV0KQo+ICsJCWdvdG8gcGFyZW50
X2VycjsKPiArCj4gKwlyZXR1cm4gMDsKPiArCj4gK3BhcmVudF9lcnI6Cj4gKwlkZXZpY2VfdW5y
ZWdpc3RlcigmdmRwYXNpbV9ibGtfbWdtdGRldik7Cj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+
ICtzdGF0aWMgdm9pZCBfX2V4aXQgdmRwYXNpbV9ibGtfZXhpdCh2b2lkKQo+ICt7Cj4gKwl2ZHBh
X21nbXRkZXZfdW5yZWdpc3RlcigmbWdtdF9kZXYpOwo+ICsJZGV2aWNlX3VucmVnaXN0ZXIoJnZk
cGFzaW1fYmxrX21nbXRkZXYpOwo+ICAgfQo+ICAgCj4gICBtb2R1bGVfaW5pdCh2ZHBhc2ltX2Js
a19pbml0KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
