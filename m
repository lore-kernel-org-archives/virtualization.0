Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9EC43460
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:46:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC8B611C0
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC8B611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88438400E7;
	Thu,  8 Apr 2021 09:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1iMKjSJS-zan; Thu,  8 Apr 2021 09:46:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AAC24063A;
	Thu,  8 Apr 2021 09:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12842C000B;
	Thu,  8 Apr 2021 09:46:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23C1BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0425C41920
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwnKKffNacTj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:46:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00A114191D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617875168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ed8cXY4Fne68ovFitKR7CHeZADetAwCYIlL4r4Eb7U=;
 b=Lr35rziQnaP6LBty/yNixZj/2cLkYgLDFlnIaLen5Se0C4QuLYlmPZVL5rvAvyeR2Egb9P
 rxTjA9ANhFs/rXr8I4arqwY2i3VCxY2T4zsbeJ41o6dHU3DiJ37+82B8D9hVjlyBLBzrJA
 7B5qoI5F9pdoBS4LkX6aSo8lJRRkwko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-4ZpPA4M8OmqqMcNkDqAJog-1; Thu, 08 Apr 2021 05:46:05 -0400
X-MC-Unique: 4ZpPA4M8OmqqMcNkDqAJog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 905E98189D6;
 Thu,  8 Apr 2021 09:46:01 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-53.pek2.redhat.com
 [10.72.13.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05FE36B543;
 Thu,  8 Apr 2021 09:45:55 +0000 (UTC)
Subject: Re: [PATCH 5/5] vdpa/mlx5: Fix suspend/resume index restoration
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, parav@nvidia.com,
 si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20210408091047.4269-1-elic@nvidia.com>
 <20210408091047.4269-6-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a5356a13-6d7d-8086-bfff-ff869aec5449@redhat.com>
Date: Thu, 8 Apr 2021 17:45:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408091047.4269-6-elic@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: stable@vger.kernel.org
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

CtTaIDIwMjEvNC84IM/Czuc1OjEwLCBFbGkgQ29oZW4g0LS1wDoKPiBXaGVuIHdlIHN1c3BlbmQg
dGhlIFZNLCB0aGUgVkRQQSBpbnRlcmZhY2Ugd2lsbCBiZSByZXNldC4gV2hlbiB0aGUgVk0gaXMK
PiByZXN1bWVkIGFnYWluLCBjbGVhcl92aXJ0cXVldWVzKCkgd2lsbCBjbGVhciB0aGUgYXZhaWxh
YmxlIGFuZCB1c2VkCj4gaW5kaWNlcyByZXN1bHRpbmcgaW4gaGFyZHdhcmUgdmlycXRxdWV1ZSBv
YmplY3RzIGJlY29taW5nIG91dCBvZiBzeW5jLgo+IFdlIGNhbiBhdm9pZCB0aGlzIGZ1bmN0aW9u
IGFsbHRvZ2V0aGVyIHNpbmNlIHFlbXUgd2lsbCBjbGVhciB0aGVtIGlmCj4gcmVxdWlyZWQsIGUu
Zy4gd2hlbiB0aGUgVk0gd2VudCB0aHJvdWdoIGEgcmVib290Lgo+Cj4gTW9yZW92ZXIsIHNpbmNl
IHRoZSBodyBhdmFpbGFibGUgYW5kIHVzZWQgaW5kaWNlcyBzaG91bGQgYWx3YXlzIGJlCj4gaWRl
bnRpY2FsIG9uIHF1ZXJ5IGFuZCBzaG91bGQgYmUgcmVzdG9yZWQgdG8gdGhlIHNhbWUgdmFsdWUg
c2FtZSB2YWx1ZQo+IGZvciB2aXJ0cXVldWVzIHRoYXQgY29tcGxldGUgaW4gb3JkZXIsIHdlIHNl
dCB0aGUgc2luZ2xlIHZhbHVlIHByb3ZpZGVkCj4gYnkgc2V0X3ZxX3N0YXRlKCkuIEluIGdldF92
cV9zdGF0ZSgpIHdlIHJldHVybiB0aGUgdmFsdWUgb2YgaGFyZHdhcmUKPiB1c2VkIGluZGV4Lgo+
Cj4gRml4ZXM6IGIzNWNjZWJlM2VmNyAoInZkcGEvbWx4NTogUmVzdG9yZSB0aGUgaGFyZHdhcmUg
dXNlZCBpbmRleCBhZnRlciBjaGFuZ2UgbWFwIikKPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRw
YS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+IFNp
Z25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+IC0tLQoKCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gICBkcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMgfCAyMSArKysrKysrKy0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+IGluZGV4IDZmZTYxZmM1Nzc5MC4uNGQyODA5YzdkNGUzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0xMTY5LDYgKzExNjksNyBAQCBzdGF0aWMg
dm9pZCBzdXNwZW5kX3ZxKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92
ZHBhX3ZpcnRxdWV1ZSAqbQo+ICAgCQlyZXR1cm47Cj4gICAJfQo+ICAgCW12cS0+YXZhaWxfaWR4
ID0gYXR0ci5hdmFpbGFibGVfaW5kZXg7Cj4gKwltdnEtPnVzZWRfaWR4ID0gYXR0ci51c2VkX2lu
ZGV4Owo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBzdXNwZW5kX3ZxcyhzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldikKPiBAQCAtMTQyNiw2ICsxNDI3LDcgQEAgc3RhdGljIGludCBtbHg1X3Zk
cGFfc2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwKPiAgIAkJ
cmV0dXJuIC1FSU5WQUw7Cj4gICAJfQo+ICAgCj4gKwltdnEtPnVzZWRfaWR4ID0gc3RhdGUtPmF2
YWlsX2luZGV4Owo+ICAgCW12cS0+YXZhaWxfaWR4ID0gc3RhdGUtPmF2YWlsX2luZGV4Owo+ICAg
CXJldHVybiAwOwo+ICAgfQo+IEBAIC0xNDQzLDcgKzE0NDUsMTEgQEAgc3RhdGljIGludCBtbHg1
X3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgc3Ry
dWN0IHZkcGEKPiAgIAkgKiB0aGF0IGNhcmVzIGFib3V0IGVtdWxhdGluZyB0aGUgaW5kZXggYWZ0
ZXIgdnEgaXMgc3RvcHBlZC4KPiAgIAkgKi8KPiAgIAlpZiAoIW12cS0+aW5pdGlhbGl6ZWQpIHsK
PiAtCQlzdGF0ZS0+YXZhaWxfaW5kZXggPSBtdnEtPmF2YWlsX2lkeDsKPiArCQkvKiBGaXJtd2Fy
ZSByZXR1cm5zIGEgd3JvbmcgdmFsdWUgZm9yIHRoZSBhdmFpbGFibGUgaW5kZXguCj4gKwkJICog
U2luY2UgYm90aCB2YWx1ZXMgc2hvdWxkIGJlIGlkZW50aWNhbCwgd2UgdGFrZSB0aGUgdmFsdWUg
b2YKPiArCQkgKiB1c2VkX2lkeCB3aGljaCBpcyByZXBvcnRlZCBjb3JyZWN0bHkuCj4gKwkJICov
Cj4gKwkJc3RhdGUtPmF2YWlsX2luZGV4ID0gbXZxLT51c2VkX2lkeDsKPiAgIAkJcmV0dXJuIDA7
Cj4gICAJfQo+ICAgCj4gQEAgLTE0NTIsNyArMTQ1OCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X2dldF92cV9zdGF0ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIHN0cnVjdCB2
ZHBhCj4gICAJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAiZmFpbGVkIHRvIHF1ZXJ5IHZpcnRxdWV1
ZVxuIik7Cj4gICAJCXJldHVybiBlcnI7Cj4gICAJfQo+IC0Jc3RhdGUtPmF2YWlsX2luZGV4ID0g
YXR0ci5hdmFpbGFibGVfaW5kZXg7Cj4gKwlzdGF0ZS0+YXZhaWxfaW5kZXggPSBhdHRyLnVzZWRf
aW5kZXg7Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiBAQCAtMTU0MCwxNiArMTU0Niw2IEBA
IHN0YXRpYyB2b2lkIHRlYXJkb3duX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYpCj4gICAJfQo+ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIGNsZWFyX3ZpcnRxdWV1ZXMoc3Ry
dWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gLXsKPiAtCWludCBpOwo+IC0KPiAtCWZvciAoaSA9
IG5kZXYtPm12ZGV2Lm1heF92cXMgLSAxOyBpID49IDA7IGktLSkgewo+IC0JCW5kZXYtPnZxc1tp
XS5hdmFpbF9pZHggPSAwOwo+IC0JCW5kZXYtPnZxc1tpXS51c2VkX2lkeCA9IDA7Cj4gLQl9Cj4g
LX0KPiAtCj4gICAvKiBUT0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+ICAgc3RhdGljIGlu
bGluZSBib29sIG1seDVfdmRwYV9pc19saXR0bGVfZW5kaWFuKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldikKPiAgIHsKPiBAQCAtMTc4NSw3ICsxNzgxLDYgQEAgc3RhdGljIHZvaWQgbWx4NV92
ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gICAJ
aWYgKCFzdGF0dXMpIHsKPiAgIAkJbWx4NV92ZHBhX2luZm8obXZkZXYsICJwZXJmb3JtaW5nIGRl
dmljZSByZXNldFxuIik7Cj4gICAJCXRlYXJkb3duX2RyaXZlcihuZGV2KTsKPiAtCQljbGVhcl92
aXJ0cXVldWVzKG5kZXYpOwo+ICAgCQltbHg1X3ZkcGFfZGVzdHJveV9tcigmbmRldi0+bXZkZXYp
Owo+ICAgCQluZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+ICAgCQluZGV2LT5tdmRldi5tbHhfZmVh
dHVyZXMgPSAwOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
