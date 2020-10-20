Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F4C433E7
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 06:23:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7C321741
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 06:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI27/Si9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7C321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 295A62E19F;
	Tue, 20 Oct 2020 06:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nvMBaz4kcBj3; Tue, 20 Oct 2020 06:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5822B2E15F;
	Tue, 20 Oct 2020 06:23:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3749EC0052;
	Tue, 20 Oct 2020 06:23:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37B73C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3051B8753F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UVmzKuR3dYf9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:23:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E35598753B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 06:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603175011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYBBFaywtQ+WHSPP8mqHtlCXgzq0Xbm6CyO640a+IUg=;
 b=DI27/Si9MdVxYrG92SBv8L3ciVTouF6wCB27vdv50Isomk60ttSHBl95vz4af9EAeVBn33
 Wx2Kj+e6IX5jLqAQH5lhyzbBWTwp+9L2JpGwcVQlEc+8UZwkFlLouEBRmcfrX7/ncGs7IG
 XSLKwY6J33bi9EMNPNywS8tZY0FZDwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-v9xI-lB8Obado3FWNetisw-1; Tue, 20 Oct 2020 02:23:27 -0400
X-MC-Unique: v9xI-lB8Obado3FWNetisw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E63D85EE94;
 Tue, 20 Oct 2020 06:23:24 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A389461983;
 Tue, 20 Oct 2020 06:23:16 +0000 (UTC)
Subject: Re: [PATCH 1/2] KVM: not register a IRQ bypass producer if
 unsupported or disabled
To: Zhenzhong Duan <zhenzhong.duan@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20201019090657.131-1-zhenzhong.duan@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ef3b498-bdc5-4a3d-d23b-ad58205ae1b7@redhat.com>
Date: Tue, 20 Oct 2020 14:23:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019090657.131-1-zhenzhong.duan@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: wanpengli@tencent.com, mst@redhat.com, netdev@vger.kernel.org,
 joro@8bytes.org, sean.j.christopherson@intel.com, mingo@redhat.com,
 bp@alien8.de, pbonzini@redhat.com, tglx@linutronix.de, jmattson@google.com
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

Ck9uIDIwMjAvMTAvMTkg5LiL5Y2INTowNiwgWmhlbnpob25nIER1YW4gd3JvdGU6Cj4gSWYgUG9z
dCBpbnRlcnJ1cHQgaXMgZGlzYWJsZWQgZHVlIHRvIGhhcmR3YXJlIGxpbWl0IG9yIGZvcmNlbHkg
ZGlzYWJsZWQKPiBieSAiaW50cmVtYXA9bm9wb3N0IiBwYXJhbWV0ZXIsIHJldHVybiAtRUlOVkFM
IHNvIHRoYXQgdGhlIGxlZ2FjeSBtb2RlIElSUQo+IGlzbid0IHJlZ2lzdGVyZWQgYXMgSVJRIGJ5
cGFzcyBwcm9kdWNlci4KCgpJcyB0aGVyZSBhbnkgc2lkZSBlZmZlY3QgaWYgaXQgd2FzIHN0aWxs
IHJlZ2lzdGVyZWQ/CgoKPgo+IFdpdGggdGhpcyBjaGFuZ2UsIGJlbG93IG1lc3NhZ2UgaXMgcHJp
bnRlZDoKPiAidmZpby1wY2kgMDAwMDpkYjowMC4wOiBpcnEgYnlwYXNzIHByb2R1Y2VyICh0b2tl
biAwMDAwMDAwMDYwYzhjZGE1KSByZWdpc3RyYXRpb24gZmFpbHM6IC0yMiIKCgpJIG1heSBtaXNz
IHNvbWV0aGluZywgYnV0IHRoZSBwYXRjaCBvbmx5IHRvdWNoZXMgdmhvc3QtdkRQQSBpbnN0ZWFk
IG9mIFZGSU8/CgpUaGFua3MKCgo+Cj4gLi53aGljaCBhbHNvIGhpbnRzIHVzIGlmIGEgdmZpbyBv
ciB2ZHBhIGRldmljZSB3b3JrcyBpbiBQSSBtb2RlIG9yIGxlZ2FjeQo+IHJlbWFwcGluZyBtb2Rl
Lgo+Cj4gQWRkIGEgcHJpbnQgdG8gdmRwYSBjb2RlIGp1c3QgbGlrZSB3aGF0IHZmaW9fbXNpX3Nl
dF92ZWN0b3Jfc2lnbmFsKCkgZG9lcy4KPgo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBnbWFpbC5jb20+Cj4gLS0tCj4gICBhcmNoL3g4Ni9rdm0vc3ZtL2F2
aWMuYyB8IDMgKy0tCj4gICBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICB8IDUgKystLS0KPiAgIGRy
aXZlcnMvdmhvc3QvdmRwYS5jICAgIHwgNSArKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3Zt
L3N2bS9hdmljLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL2F2aWMuYwo+IGluZGV4IGFjODMwY2QuLjMx
NjE0MmEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9hdmljLmMKPiArKysgYi9hcmNo
L3g4Ni9rdm0vc3ZtL2F2aWMuYwo+IEBAIC04MTQsNyArODE0LDcgQEAgaW50IHN2bV91cGRhdGVf
cGlfaXJ0ZShzdHJ1Y3Qga3ZtICprdm0sIHVuc2lnbmVkIGludCBob3N0X2lycSwKPiAgIAo+ICAg
CWlmICgha3ZtX2FyY2hfaGFzX2Fzc2lnbmVkX2RldmljZShrdm0pIHx8Cj4gICAJICAgICFpcnFf
cmVtYXBwaW5nX2NhcChJUlFfUE9TVElOR19DQVApKQo+IC0JCXJldHVybiAwOwo+ICsJCXJldHVy
biByZXQ7Cj4gICAKPiAgIAlwcl9kZWJ1ZygiU1ZNOiAlczogaG9zdF9pcnE9JSN4LCBndWVzdF9p
cnE9JSN4LCBzZXQ9JSN4XG4iLAo+ICAgCQkgX19mdW5jX18sIGhvc3RfaXJxLCBndWVzdF9pcnEs
IHNldCk7Cj4gQEAgLTg5OSw3ICs4OTksNiBAQCBpbnQgc3ZtX3VwZGF0ZV9waV9pcnRlKHN0cnVj
dCBrdm0gKmt2bSwgdW5zaWduZWQgaW50IGhvc3RfaXJxLAo+ICAgCQl9Cj4gICAJfQo+ICAgCj4g
LQlyZXQgPSAwOwo+ICAgb3V0Ogo+ICAgCXNyY3VfcmVhZF91bmxvY2soJmt2bS0+aXJxX3NyY3Us
IGlkeCk7Cj4gICAJcmV0dXJuIHJldDsKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC92
bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKPiBpbmRleCBmMGE5OTU0Li4xZmVkNmQ2IDEw
MDY0NAo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMKPiArKysgYi9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jCj4gQEAgLTc3MTYsMTIgKzc3MTYsMTIgQEAgc3RhdGljIGludCB2bXhfdXBkYXRl
X3BpX2lydGUoc3RydWN0IGt2bSAqa3ZtLCB1bnNpZ25lZCBpbnQgaG9zdF9pcnEsCj4gICAJc3Ry
dWN0IGt2bV9sYXBpY19pcnEgaXJxOwo+ICAgCXN0cnVjdCBrdm1fdmNwdSAqdmNwdTsKPiAgIAlz
dHJ1Y3QgdmNwdV9kYXRhIHZjcHVfaW5mbzsKPiAtCWludCBpZHgsIHJldCA9IDA7Cj4gKwlpbnQg
aWR4LCByZXQgPSAtRUlOVkFMOwo+ICAgCj4gICAJaWYgKCFrdm1fYXJjaF9oYXNfYXNzaWduZWRf
ZGV2aWNlKGt2bSkgfHwKPiAgIAkJIWlycV9yZW1hcHBpbmdfY2FwKElSUV9QT1NUSU5HX0NBUCkg
fHwKPiAgIAkJIWt2bV92Y3B1X2FwaWN2X2FjdGl2ZShrdm0tPnZjcHVzWzBdKSkKPiAtCQlyZXR1
cm4gMDsKPiArCQlyZXR1cm4gcmV0Owo+ICAgCj4gICAJaWR4ID0gc3JjdV9yZWFkX2xvY2soJmt2
bS0+aXJxX3NyY3UpOwo+ICAgCWlycV9ydCA9IHNyY3VfZGVyZWZlcmVuY2Uoa3ZtLT5pcnFfcm91
dGluZywgJmt2bS0+aXJxX3NyY3UpOwo+IEBAIC03Nzg3LDcgKzc3ODcsNiBAQCBzdGF0aWMgaW50
IHZteF91cGRhdGVfcGlfaXJ0ZShzdHJ1Y3Qga3ZtICprdm0sIHVuc2lnbmVkIGludCBob3N0X2ly
cSwKPiAgIAkJfQo+ICAgCX0KPiAgIAo+IC0JcmV0ID0gMDsKPiAgIG91dDoKPiAgIAlzcmN1X3Jl
YWRfdW5sb2NrKCZrdm0tPmlycV9zcmN1LCBpZHgpOwo+ICAgCXJldHVybiByZXQ7Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRl
eCA2MmE5YmIwLi5iMjAwNjBhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4g
KysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtMTA3LDYgKzEwNywxMSBAQCBzdGF0aWMg
dm9pZCB2aG9zdF92ZHBhX3NldHVwX3ZxX2lycShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTE2IHFp
ZCkKPiAgIAl2cS0+Y2FsbF9jdHgucHJvZHVjZXIudG9rZW4gPSB2cS0+Y2FsbF9jdHguY3R4Owo+
ICAgCXZxLT5jYWxsX2N0eC5wcm9kdWNlci5pcnEgPSBpcnE7Cj4gICAJcmV0ID0gaXJxX2J5cGFz
c19yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKPiArCWlmICh1bmxp
a2VseShyZXQpKQo+ICsJCWRldl9pbmZvKCZ2ZHBhLT5kZXYsCj4gKwkJImlycSBieXBhc3MgcHJv
ZHVjZXIgKHRva2VuICVwKSByZWdpc3RyYXRpb24gZmFpbHM6ICVkXG4iLAo+ICsJCXZxLT5jYWxs
X2N0eC5wcm9kdWNlci50b2tlbiwgcmV0KTsKPiArCj4gICAJc3Bpbl91bmxvY2soJnZxLT5jYWxs
X2N0eC5jdHhfbG9jayk7Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
