Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFABC433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:59:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5EB610D1
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5EB610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E74B849A2;
	Wed,  7 Apr 2021 03:59:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8dNObWTplKW; Wed,  7 Apr 2021 03:59:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E96908486D;
	Wed,  7 Apr 2021 03:59:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD17DC000B;
	Wed,  7 Apr 2021 03:59:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 509E2C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:59:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E533405A6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h93K_hEKb_MN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 476AC405A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617767973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbdzZKbu0jWRSxoW9WX97yCods4Yf2nVcH42qZBPxYE=;
 b=JCYsUBoiohWCaGH7EilxbP1EHxL1n+YjZlvYQ3aSieaWJev2AzRjf0IRLP6+wSJj5F61Jx
 Q32eA1U2qkQb68qQ5BHa9ySXmUU1Qj/kuxRnjHNOvOyDysOc4FsCJFhtiHGwWf3c1+iBvF
 DqtyE6ou876+9AsgjUKz4H2mvztDzXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-bmfaylXcMqC2-sxTTSI9ew-1; Tue, 06 Apr 2021 23:59:32 -0400
X-MC-Unique: bmfaylXcMqC2-sxTTSI9ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550911005D4F;
 Wed,  7 Apr 2021 03:59:31 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-69.pek2.redhat.com
 [10.72.12.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C5835D743;
 Wed,  7 Apr 2021 03:59:26 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 05/14] vdpa: Enable user to set mac and mtu
 of vdpa device
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-6-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <33eed433-0f2a-e4cb-77fa-0d4cc4d8a046@redhat.com>
Date: Wed, 7 Apr 2021 11:59:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-6-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com
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

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiAkIHZkcGEgZGV2IGFk
ZCBuYW1lIGJhciBtZ210ZGV2IHZkcGFzaW1fbmV0Cj4KPiAkIHZkcGEgZGV2IGNvbmZpZyBzZXQg
YmFyIG1hYyAwMDoxMToyMjozMzo0NDo1NSBtdHUgOTAwMAo+Cj4gJCB2ZHBhIGRldiBjb25maWcg
c2hvdwo+IGJhcjogbWFjIDAwOjExOjIyOjMzOjQ0OjU1IGxpbmsgdXAgbGlua19hbm5vdW5jZSBm
YWxzZSBtdHUgOTAwMCBzcGVlZCAwIGR1cGxleCAwCj4KPiAkIHZkcGEgZGV2IGNvbmZpZyBzaG93
IC1qcAo+IHsKPiAgICAgICJjb25maWciOiB7Cj4gICAgICAgICAgImJhciI6IHsKPiAgICAgICAg
ICAgICAgIm1hYyI6ICIwMDoxMToyMjozMzo0NDo1NSIsCj4gICAgICAgICAgICAgICJsaW5rICI6
ICJ1cCIsCj4gICAgICAgICAgICAgICJsaW5rX2Fubm91bmNlICI6IGZhbHNlLAo+ICAgICAgICAg
ICAgICAibXR1IjogOTAwMCwKPiAgICAgICAgICAgICAgInNwZWVkIjogMCwKPiAgICAgICAgICAg
ICAgImR1cGxleCI6IDAKPiAgICAgICAgICB9Cj4gICAgICB9Cj4gfQo+Cj4gU2lnbmVkLW9mZi1i
eTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiBjaGFuZ2Vsb2c6Cj4gdjEtPnYyOgo+ICAgLSBm
aXhlZCBtdHUgcmFuZ2UgY2hlY2tpbmcgZm9yIG1heAo+ICAgLSB1c2luZyBOTEFfUE9MSUNZX0VU
SF9BRERSCj4gICAtIHNldCBjb25maWcgbW92ZWQgdG8gZGV2aWNlIG9wcyBpbnN0ZWFkIG9mIG1n
bXRkZXYgb3BzCj4gICAtIG1lcmdlZCBidWlsZCBhbmQgc2V0IHRvIHNpbmdsZSByb3V0aW5lCj4g
ICAtIGVuc3VyaW5nIHRoYXQgdXNlciBoYXMgTkVUX0FETUlOIGNhcGFiaWxpdHkgZm9yIGNvbmZp
Z3VyaW5nIG5ldHdvcmsKPiAgICAgYXR0cmlidXRlcwo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3Zk
cGEuYyAgICAgICB8IDkwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICB8IDE1ICsrKysrKysKPiAgIGluY2x1ZGUvdWFw
aS9saW51eC92ZHBhLmggfCAgMSArCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92
ZHBhLmMKPiBpbmRleCA5ZGE4ZGViOGMwZjIuLjZhNmVmMWEwODVlOCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IEBAIC04ODEs
MTAgKzg4MSw5NCBAQCB2ZHBhX25sX2NtZF9kZXZfY29uZmlnX2dldF9kdW1waXQoc3RydWN0IHNr
X2J1ZmYgKm1zZywgc3RydWN0IG5ldGxpbmtfY2FsbGJhY2sgKgo+ICAgCXJldHVybiBtc2ctPmxl
bjsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9jb25maWdfc2V0KHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwKPiArCQkJCSAgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVj
dCBnZW5sX2luZm8gKmluZm8pCj4gK3sKPiArCXN0cnVjdCBubGF0dHIgKipubF9hdHRycyA9IGlu
Zm8tPmF0dHJzOwo+ICsJc3RydWN0IHZkcGFfZGV2X3NldF9jb25maWcgY29uZmlnID0ge307Cj4g
Kwljb25zdCB1OCAqbWFjYWRkcjsKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKCF2ZGV2LT5jb25m
aWctPnNldF9jZV9jb25maWcpCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICsKPiArCWlmICgh
bmV0bGlua19jYXBhYmxlKHNrYiwgQ0FQX05FVF9BRE1JTikpCj4gKwkJcmV0dXJuIC1FUEVSTTsK
PiArCj4gKwlpZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFJdKSB7Cj4g
KwkJbWFjYWRkciA9IG5sYV9kYXRhKG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNB
RERSXSk7Cj4gKwkJbWVtY3B5KGNvbmZpZy5uZXQubWFjLCBtYWNhZGRyLCBzaXplb2YoY29uZmln
Lm5ldC5tYWMpKTsKPiArCQljb25maWcubmV0X21hc2subWFjX3ZhbGlkID0gdHJ1ZTsKPiArCX0K
PiArCWlmIChubF9hdHRyc1tWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVXSkgewo+ICsJCWNvbmZp
Zy5uZXQubXR1ID0KPiArCQkJbmxhX2dldF91MTYobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01UVV0pOwo+ICsJCWNvbmZpZy5uZXRfbWFzay5tdHVfdmFsaWQgPSB0cnVlOwo+ICsJfQoK
CkkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gYW92aWQgYW55IGRldmljZSBzcGVjaWZpYyBzdHVmZnMg
aW4gdmRwYS5jLiBDYW4gCndlIGp1c3QgbWFrZSB0aGUgY29uZmlnIGRhdGEgb3BhcXVlIGFuZCBz
aW1wbHkgcGFzcyB0aGVtIHRvIHRoZSBkcml2ZXI/CgoKPiArCj4gKwltdXRleF9sb2NrKCZ2ZGV2
LT5jZl9tdXRleCk7Cj4gKwllcnIgPSB2ZGV2LT5jb25maWctPnNldF9jZV9jb25maWcodmRldiwg
JmNvbmZpZyk7Cj4gKwltdXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4KTsKPiArCXJldHVybiBl
cnI7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgdmRwYV9kZXZfY29uZmlnX3NldChzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICpza2IsCj4gKwkJCSAgICAgICBzdHJ1Y3Qg
Z2VubF9pbmZvICppbmZvKQo+ICt7Cj4gKwlpbnQgZXJyID0gLUVPUE5PVFNVUFA7Cj4gKwl1MzIg
ZGV2aWNlX2lkOwo+ICsKPiArCWlmICghdmRldi0+bWRldikKPiArCQlyZXR1cm4gLUVPUE5PVFNV
UFA7Cj4gKwo+ICsJZGV2aWNlX2lkID0gdmRldi0+Y29uZmlnLT5nZXRfZGV2aWNlX2lkKHZkZXYp
Owo+ICsJc3dpdGNoIChkZXZpY2VfaWQpIHsKPiArCWNhc2UgVklSVElPX0lEX05FVDoKPiArCQll
cnIgPSB2ZHBhX2Rldl9uZXRfY29uZmlnX3NldCh2ZGV2LCBza2IsIGluZm8pOwo+ICsJCWJyZWFr
Owo+ICsJZGVmYXVsdDoKPiArCQlicmVhazsKPiArCX0KPiArCXJldHVybiBlcnI7Cj4gK30KPiAr
Cj4gK3N0YXRpYyBpbnQgdmRwYV9ubF9jbWRfZGV2X2NvbmZpZ19zZXRfZG9pdChzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKQo+ICt7Cj4gKwlzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkZXY7Cj4gKwljb25zdCBjaGFyICpkZXZuYW1lOwo+ICsJc3RydWN0IGRldmljZSAq
ZGV2Owo+ICsJaW50IGVycjsKPiArCj4gKwlpZiAoIWluZm8tPmF0dHJzW1ZEUEFfQVRUUl9ERVZf
TkFNRV0pCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwlkZXZuYW1lID0gbmxhX2RhdGEoaW5mby0+
YXR0cnNbVkRQQV9BVFRSX0RFVl9OQU1FXSk7Cj4gKwo+ICsJbXV0ZXhfbG9jaygmdmRwYV9kZXZf
bXV0ZXgpOwo+ICsJZGV2ID0gYnVzX2ZpbmRfZGV2aWNlKCZ2ZHBhX2J1cywgTlVMTCwgZGV2bmFt
ZSwgdmRwYV9uYW1lX21hdGNoKTsKPiArCWlmICghZGV2KSB7Cj4gKwkJbXV0ZXhfdW5sb2NrKCZ2
ZHBhX2Rldl9tdXRleCk7Cj4gKwkJTkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywgImRl
dmljZSBub3QgZm91bmQiKTsKPiArCQlyZXR1cm4gLUVOT0RFVjsKPiArCX0KPiArCXZkZXYgPSBj
b250YWluZXJfb2YoZGV2LCBzdHJ1Y3QgdmRwYV9kZXZpY2UsIGRldik7Cj4gKwlpZiAoIXZkZXYt
Pm1kZXYpIHsKPiArCQltdXRleF91bmxvY2soJnZkcGFfZGV2X211dGV4KTsKPiArCQlwdXRfZGV2
aWNlKGRldik7Cj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwl9Cj4gKwllcnIgPSB2ZHBhX2Rldl9j
b25maWdfc2V0KHZkZXYsIHNrYiwgaW5mbyk7Cj4gKwlwdXRfZGV2aWNlKGRldik7Cj4gKwltdXRl
eF91bmxvY2soJnZkcGFfZGV2X211dGV4KTsKPiArCXJldHVybiBlcnI7Cj4gK30KPiArCj4gICBz
dGF0aWMgY29uc3Qgc3RydWN0IG5sYV9wb2xpY3kgdmRwYV9ubF9wb2xpY3lbVkRQQV9BVFRSX01B
WCArIDFdID0gewo+ICAgCVtWRFBBX0FUVFJfTUdNVERFVl9CVVNfTkFNRV0gPSB7IC50eXBlID0g
TkxBX05VTF9TVFJJTkcgfSwKPiAgIAlbVkRQQV9BVFRSX01HTVRERVZfREVWX05BTUVdID0geyAu
dHlwZSA9IE5MQV9TVFJJTkcgfSwKPiAgIAlbVkRQQV9BVFRSX0RFVl9OQU1FXSA9IHsgLnR5cGUg
PSBOTEFfU1RSSU5HIH0sCj4gKwlbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFJdID0gTkxB
X1BPTElDWV9FVEhfQUREUiwKPiArCS8qIHZpcnRpbyBzcGVjIDEuMSBzZWN0aW9uIDUuMS40LjEg
Zm9yIHZhbGlkIE1UVSByYW5nZSAqLwo+ICsJW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFVdID0g
TkxBX1BPTElDWV9NSU4oTkxBX1UxNiwgNjgpLAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIGNvbnN0
IHN0cnVjdCBnZW5sX29wcyB2ZHBhX25sX29wc1tdID0gewo+IEBAIC05MTksNiArMTAwMywxMiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGdlbmxfb3BzIHZkcGFfbmxfb3BzW10gPSB7Cj4gICAJCS5k
dW1waXQgPSB2ZHBhX25sX2NtZF9kZXZfY29uZmlnX2dldF9kdW1waXQsCj4gICAJCS5mbGFncyA9
IEdFTkxfQURNSU5fUEVSTSwKPiAgIAl9LAo+ICsJewo+ICsJCS5jbWQgPSBWRFBBX0NNRF9ERVZf
Q09ORklHX1NFVCwKPiArCQkudmFsaWRhdGUgPSBHRU5MX0RPTlRfVkFMSURBVEVfU1RSSUNUIHwg
R0VOTF9ET05UX1ZBTElEQVRFX0RVTVAsCj4gKwkJLmRvaXQgPSB2ZHBhX25sX2NtZF9kZXZfY29u
ZmlnX3NldF9kb2l0LAo+ICsJCS5mbGFncyA9IEdFTkxfQURNSU5fUEVSTSwKPiArCX0sCj4gICB9
Owo+ICAgCj4gICBzdGF0aWMgc3RydWN0IGdlbmxfZmFtaWx5IHZkcGFfbmxfZmFtaWx5IF9fcm9f
YWZ0ZXJfaW5pdCA9IHsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNs
dWRlL2xpbnV4L3ZkcGEuaAo+IGluZGV4IGRjYmJlY2I1ZGVhOC4uYjU5ZTFhMjE0MTYxIDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBh
LmgKPiBAQCAtMTA0LDYgKzEwNCwxNCBAQCBzdHJ1Y3QgdmRwYV9kZXZfY29uZmlnIHsKPiAgIAlz
dHJ1Y3QgdmRwYV9uZXRfZGV2X2NvbmZpZyBuZXQ7Cj4gICB9Owo+ICAgCj4gK3N0cnVjdCB2ZHBh
X2Rldl9zZXRfY29uZmlnIHsKPiArCXN0cnVjdCB2ZHBhX25ldF9kZXZfY29uZmlnIG5ldDsKPiAr
CXN0cnVjdCB7Cj4gKwkJdTggbWFjX3ZhbGlkOiAxOwo+ICsJCXU4IG10dV92YWxpZDogMTsKPiAr
CX0gbmV0X21hc2s7Cj4gK307Cj4gKwo+ICAgLyoqCj4gICAgKiBzdHJ1Y3QgdmRwYV9jb25maWdf
b3BzIC0gb3BlcmF0aW9ucyBmb3IgY29uZmlndXJpbmcgYSB2RFBBIGRldmljZS4KPiAgICAqIE5v
dGU6IHZEUEEgZGV2aWNlIGRyaXZlcnMgYXJlIHJlcXVpcmVkIHRvIGltcGxlbWVudCBhbGwgb2Yg
dGhlCj4gQEAgLTIwNCw2ICsyMTIsMTEgQEAgc3RydWN0IHZkcGFfZGV2X2NvbmZpZyB7Cj4gICAg
KgkJCQljcHUgZW5kaWFubmVzcy4KPiAgICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgICoJ
CQkJQGNvbmZpZzogcG9pbnRlciB0byBjb25maWcgYnVmZmVyIHVzZWQgdG8gcmVhZCB0bwo+ICsg
KiBAc2V0X2NlX2NvbmZpZzoJCVNldCBvbmUgb3IgbW9yZSBkZXZpY2UgY29uZmlndXJhdGlvbiBp
bgo+ICsgKgkJCQljcHUgZW5kaWFubmVzcy4KPiArICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4g
KyAqCQkJCUBjb25maWc6IGNvbmZpZ3VyYXRpb24gdG8gdXBkYXRlCj4gKyAqCQkJCVJldHVybnMg
MCBvbiBzdWNjZXNzIG9yIGVycm9yIGNvZGUKCgpDYW4gd2Ugc2ltcGx5IHVzZSBzZXRfY29uZmln
IGhlcmU/CgpUaGFua3MKCgo+ICAgICogQGdldF9nZW5lcmF0aW9uOgkJR2V0IGRldmljZSBjb25m
aWcgZ2VuZXJhdGlvbiAob3B0aW9uYWwpCj4gICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiAg
ICAqCQkJCVJldHVybnMgdTMyOiBkZXZpY2UgZ2VuZXJhdGlvbgo+IEBAIC0yNzcsNiArMjkwLDgg
QEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAJCQkgICBjb25zdCB2b2lkICpidWYsIHVu
c2lnbmVkIGludCBsZW4pOwo+ICAgCXZvaWQgKCpnZXRfY2VfY29uZmlnKShzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkZXYsCj4gICAJCQkgICAgICBzdHJ1Y3QgdmRwYV9kZXZfY29uZmlnICpjb25maWcp
Owo+ICsJaW50ICgqc2V0X2NlX2NvbmZpZykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+ICsJ
CQkgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnICpjb25maWcpOwo+ICAgCXUz
MiAoKmdldF9nZW5lcmF0aW9uKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+ICAgCXN0cnVj
dCB2ZHBhX2lvdmFfcmFuZ2UgKCpnZXRfaW92YV9yYW5nZSkoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2KTsKPiAgIAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oIGIvaW5j
bHVkZS91YXBpL2xpbnV4L3ZkcGEuaAo+IGluZGV4IDVjMzFlY2MzYjk1Ni4uZWMzNDk3ODliOGQx
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmRwYS5oCj4gQEAgLTE4LDYgKzE4LDcgQEAgZW51bSB2ZHBhX2NvbW1hbmQg
ewo+ICAgCVZEUEFfQ01EX0RFVl9ERUwsCj4gICAJVkRQQV9DTURfREVWX0dFVCwJCS8qIGNhbiBk
dW1wICovCj4gICAJVkRQQV9DTURfREVWX0NPTkZJR19HRVQsCS8qIGNhbiBkdW1wICovCj4gKwlW
RFBBX0NNRF9ERVZfQ09ORklHX1NFVCwKPiAgIH07Cj4gICAKPiAgIGVudW0gdmRwYV9hdHRyIHsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
