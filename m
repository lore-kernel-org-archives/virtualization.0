Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D67C4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:31:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01144227C3
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 05:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01144227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8DA5E87D4C;
	Mon,  7 Dec 2020 05:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id io3TDoMxfaas; Mon,  7 Dec 2020 05:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0391587D36;
	Mon,  7 Dec 2020 05:31:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8EDAC0FA7;
	Mon,  7 Dec 2020 05:31:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A42D5C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9300286F06
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C98YaEmzp8lu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:31:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E017786D17
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 05:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607319083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d55VwrXw/oQIP2ez330kLeMcIKkbjKXF47nSb09mhYg=;
 b=OF/QjSdB2GaL2kiL9COkpovjZdcUAwQCkYxeQ2hCSFqslBEwtx73ArryZjS/0eV9AQjh2s
 jBpD4yM5xvD4R0i0EAqRFKXJbWE3nIS6Zdyx59DBSDhd3nH8I2tjgNl+Fr1BK7wp0EN9gA
 J09J9+/NeY7Xc11R01RkcrwBuM65ej8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-1Bb0k3JvOu6PW9sbZ4OsJQ-1; Mon, 07 Dec 2020 00:31:19 -0500
X-MC-Unique: 1Bb0k3JvOu6PW9sbZ4OsJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A660A107ACE4;
 Mon,  7 Dec 2020 05:31:18 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8F545D9DC;
 Mon,  7 Dec 2020 05:31:00 +0000 (UTC)
Subject: Re: [PATCH v3 15/19] vdpa_sim: set vringh notify callback
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-16-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d9403e25-41a2-cfbe-efa9-8952b8e1b881@redhat.com>
Date: Mon, 7 Dec 2020 13:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-16-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvNCDkuIrljYgxOjA1LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gSW5z
dGVhZCBvZiBjYWxsaW5nIHRoZSB2cSBjYWxsYmFjayBkaXJlY3RseSwgd2UgY2FuIGxldmVyYWdl
IHRoZQo+IHZyaW5naF9ub3RpZnkoKSBmdW5jdGlvbiwgYWRkaW5nIHZkcGFzaW1fdnFfbm90aWZ5
KCkgYW5kIHNldHRpbmcgaXQKPiBpbiB0aGUgdnJpbmdoIG5vdGlmeSBjYWxsYmFjay4KPgo+IFN1
Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+CgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiB2MzoKPiAtIGNsZWFy
ZWQgbm90aWZ5IGR1cmluZyByZXNldCBbSmFzb25dCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYyB8IDIzICsrKysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jCj4gaW5kZXggMDNhODcxN2Y4MGVhLi4xMjQzYjAyNDg4ZjcgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC0xMjMsNiArMTIzLDE3IEBAIHN0YXRpYyBzdHJ1
Y3QgdmRwYXNpbSAqZGV2X3RvX3NpbShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gICAJcmV0dXJuIHZk
cGFfdG9fc2ltKHZkcGEpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIHZkcGFzaW1fdnFfbm90
aWZ5KHN0cnVjdCB2cmluZ2ggKnZyaW5nKQo+ICt7Cj4gKwlzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVl
dWUgKnZxID0KPiArCQljb250YWluZXJfb2YodnJpbmcsIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1
ZSwgdnJpbmcpOwo+ICsKPiArCWlmICghdnEtPmNiKQo+ICsJCXJldHVybjsKPiArCj4gKwl2cS0+
Y2IodnEtPnByaXZhdGUpOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgdmRwYXNpbV9xdWV1ZV9y
ZWFkeShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdW5zaWduZWQgaW50IGlkeCkKPiAgIHsKPiAg
IAlzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZxID0gJnZkcGFzaW0tPnZxc1tpZHhdOwo+IEBA
IC0xMzQsNiArMTQ1LDggQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9xdWV1ZV9yZWFkeShzdHJ1Y3Qg
dmRwYXNpbSAqdmRwYXNpbSwgdW5zaWduZWQgaW50IGlkeCkKPiAgIAkJCSAgKHVpbnRwdHJfdCl2
cS0+ZHJpdmVyX2FkZHIsCj4gICAJCQkgIChzdHJ1Y3QgdnJpbmdfdXNlZCAqKQo+ICAgCQkJICAo
dWludHB0cl90KXZxLT5kZXZpY2VfYWRkcik7Cj4gKwo+ICsJdnEtPnZyaW5nLm5vdGlmeSA9IHZk
cGFzaW1fdnFfbm90aWZ5Owo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2ZHBhc2ltX3ZxX3Jl
c2V0KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLAo+IEBAIC0xNDcsNiArMTYwLDggQEAgc3RhdGlj
IHZvaWQgdmRwYXNpbV92cV9yZXNldChzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwKPiAgIAl2cS0+
cHJpdmF0ZSA9IE5VTEw7Cj4gICAJdnJpbmdoX2luaXRfaW90bGIoJnZxLT52cmluZywgdmRwYXNp
bS0+ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzLAo+ICAgCQkJICBWRFBBU0lNX1FVRVVFX01B
WCwgZmFsc2UsIE5VTEwsIE5VTEwsIE5VTEwpOwo+ICsKPiArCXZxLT52cmluZy5ub3RpZnkgPSBO
VUxMOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCB2ZHBhc2ltX3Jlc2V0KHN0cnVjdCB2ZHBh
c2ltICp2ZHBhc2ltKQo+IEBAIC0yMjMsMTAgKzIzOCwxMCBAQCBzdGF0aWMgdm9pZCB2ZHBhc2lt
X25ldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAkJc21wX3dtYigpOwo+ICAg
Cj4gICAJCWxvY2FsX2JoX2Rpc2FibGUoKTsKPiAtCQlpZiAodHhxLT5jYikKPiAtCQkJdHhxLT5j
Yih0eHEtPnByaXZhdGUpOwo+IC0JCWlmIChyeHEtPmNiKQo+IC0JCQlyeHEtPmNiKHJ4cS0+cHJp
dmF0ZSk7Cj4gKwkJaWYgKHZyaW5naF9uZWVkX25vdGlmeV9pb3RsYigmdHhxLT52cmluZykgPiAw
KQo+ICsJCQl2cmluZ2hfbm90aWZ5KCZ0eHEtPnZyaW5nKTsKPiArCQlpZiAodnJpbmdoX25lZWRf
bm90aWZ5X2lvdGxiKCZyeHEtPnZyaW5nKSA+IDApCj4gKwkJCXZyaW5naF9ub3RpZnkoJnJ4cS0+
dnJpbmcpOwo+ICAgCQlsb2NhbF9iaF9lbmFibGUoKTsKPiAgIAo+ICAgCQlpZiAoKytwa3RzID4g
NCkgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
