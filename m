Return-Path: <SRS0=tvPF=IP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C4C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 03:59:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B3B64F7F
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 03:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B3B64F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CC0E82C2E;
	Wed, 17 Mar 2021 03:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryoH3nxvRzvo; Wed, 17 Mar 2021 03:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2672A82ADD;
	Wed, 17 Mar 2021 03:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07B48C000B;
	Wed, 17 Mar 2021 03:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0370CC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E58E44E578
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xJybrXtS4cdu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED86C4D827
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 03:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615953549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ndZ/EPGx75V6OcMRIv9fS1gIYZrKaTsBexZg2LyBVk=;
 b=hqI13kmO66VBuFF8MqpTHqNtTisSlK7SSH8lQMEN5utDjWuNAC/LQ/m0Ok00R/V5sh/bFe
 5E15bT/tlYAy9DiDl+XLANX8JpIN45AKt0VhTvkIfG7aHwbiULui2FGI793A7uo5lEEugN
 ZAkU4XBHerEgUoDuTbsmnjyVf7Nz91s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-clyX9_PcOj2OvZ5sHHJCgg-1; Tue, 16 Mar 2021 23:59:05 -0400
X-MC-Unique: clyX9_PcOj2OvZ5sHHJCgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9B2F363A1;
 Wed, 17 Mar 2021 03:59:03 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-188.pek2.redhat.com
 [10.72.12.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E32CC19706;
 Wed, 17 Mar 2021 03:58:57 +0000 (UTC)
Subject: Re: [PATCH V4 6/7] vDPA/ifcvf: verify mandatory feature bits for vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-7-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3188205d-250f-8dfe-c271-50be5c1e2e58@redhat.com>
Date: Wed, 17 Mar 2021 11:58:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-7-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvMy8xNSDPws7nMzo0NSwgWmh1IExpbmdzaGFuINC0tcA6Cj4gdkRQQSByZXF1cmVz
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBhcyBhIG11c3QsIHRoaXMgY29tbWl0Cj4gZXhhbWlu
ZXMgdGhpcyB3aGVuIHNldCBmZWF0dXJlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hh
biA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmMgfCAxMiArKysrKysrKysrKysKPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmggfCAgMSArCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgIDUg
KysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5jCj4gaW5kZXggZWE2YTc4NzkxYzliLi40ZjI1N2M0YjJmNzYgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiBAQCAtMjI0LDYgKzIyNCwxOCBAQCB1NjQgaWZjdmZfZ2V0
X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gICAJcmV0dXJuIGh3LT5od19mZWF0dXJl
czsKPiAgIH0KPiAgIAo+ICtpbnQgaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZj
dmZfaHcgKmh3LCB1NjQgZmVhdHVyZXMpCj4gK3sKPiArCXN0cnVjdCBpZmN2Zl9hZGFwdGVyICpp
ZmN2ZiA9IHZmX3RvX2FkYXB0ZXIoaHcpOwo+ICsKPiArCWlmICghKGZlYXR1cmVzICYgQklUX1VM
TChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSAmJiBmZWF0dXJlcykgewo+ICsJCUlGQ1ZGX0VS
UihpZmN2Zi0+cGRldiwgIlZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBub3QgbmVnb3RpYXRlZFxu
Iik7CgoKU2hvdWxkIGJlICJpcyBub3QgbmVnb3RpYXRlZCIuCgpPdGhlcndpc2U6CgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+ICsJCXJldHVybiAtRUlOVkFM
Owo+ICsJfQo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgdm9pZCBpZmN2Zl9yZWFkX25l
dF9jb25maWcoc3RydWN0IGlmY3ZmX2h3ICpodywgdTY0IG9mZnNldCwKPiAgIAkJCSAgIHZvaWQg
KmRzdCwgaW50IGxlbmd0aCkKPiAgIHsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBpbmRleCBk
YmI4YzEwYWEzYjEuLmY3NzIzOWZjMTY0NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+
IEBAIC0xMjMsNiArMTIzLDcgQEAgdm9pZCBpb193cml0ZTY0X3R3b3BhcnQodTY0IHZhbCwgdTMy
ICpsbywgdTMyICpoaSk7Cj4gICB2b2lkIGlmY3ZmX3Jlc2V0KHN0cnVjdCBpZmN2Zl9odyAqaHcp
Owo+ICAgdTY0IGlmY3ZmX2dldF9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPiAgIHU2
NCBpZmN2Zl9nZXRfaHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4gK2ludCBpZmN2
Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHU2NCBmZWF0dXJlcyk7
Cj4gICB1MTYgaWZjdmZfZ2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQp
Owo+ICAgaW50IGlmY3ZmX3NldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlk
LCB1MTYgbnVtKTsKPiAgIHN0cnVjdCBpZmN2Zl9hZGFwdGVyICp2Zl90b19hZGFwdGVyKHN0cnVj
dCBpZmN2Zl9odyAqaHcpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
bWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDI1ZmI5ZGZl
MjNmMC4uZWE5M2VhN2ZkNWRmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTE3
OSw2ICsxNzksMTEgQEAgc3RhdGljIHU2NCBpZmN2Zl92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgc3RhdGljIGludCBpZmN2Zl92ZHBhX3NldF9mZWF0
dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1NjQgZmVhdHVyZXMpCj4gICB7Cj4g
ICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+ICsJaW50IHJl
dDsKPiArCj4gKwlyZXQgPSBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKHZmLCBmZWF0dXJlcyk7
Cj4gKwlpZiAocmV0KQo+ICsJCXJldHVybiByZXQ7Cj4gICAKPiAgIAl2Zi0+cmVxX2ZlYXR1cmVz
ID0gZmVhdHVyZXM7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
