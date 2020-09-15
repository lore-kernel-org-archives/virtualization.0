Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC0C433E2
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 08:19:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1BB21974
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 08:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7qnzUAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1BB21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C6A7086462;
	Tue, 15 Sep 2020 08:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0+F-l8nOuqXq; Tue, 15 Sep 2020 08:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8B4C786429;
	Tue, 15 Sep 2020 08:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69BACC0864;
	Tue, 15 Sep 2020 08:19:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E72E0C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 08:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E16EA86462
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 08:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5pfyJR-qJlU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 08:19:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 92F4A86429
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600157945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bhDFHrLKx2Ugr++K3UZXsMiyEdJCQXQW25owbTuEPc=;
 b=M7qnzUAG/TbOi3ONJ+hprfvJXwUQ0rXuUXrLXZAUQ6wroHPIIvJiqFgAhO4mCqv/IMMJxj
 rAI5lsdsEikAXeTXiXayhbP3KyiQpLQ/LkjxsLRhRpI4x1BYba75In5pM72Dvp0VCcNh4a
 eZK/b2EAVb6Re4CU0GImc5WmbjBLt0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-zNagHMNCPB-SgFEqX8TqPw-1; Tue, 15 Sep 2020 04:19:03 -0400
X-MC-Unique: zNagHMNCPB-SgFEqX8TqPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E0480F040;
 Tue, 15 Sep 2020 08:19:01 +0000 (UTC)
Received: from [10.72.13.94] (ovpn-13-94.pek2.redhat.com [10.72.13.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9D55DDB8;
 Tue, 15 Sep 2020 08:18:47 +0000 (UTC)
Subject: Re: [RFC PATCH 00/22] Enhance VHOST to enable SoC-to-SoC communication
To: Kishon Vijay Abraham I <kishon@ti.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200702082143.25259-1-kishon@ti.com>
 <20200702055026-mutt-send-email-mst@kernel.org>
 <603970f5-3289-cd53-82a9-aa62b292c552@redhat.com>
 <14c6cad7-9361-7fa4-e1c6-715ccc7e5f6b@ti.com>
 <59fd6a0b-8566-44b7-3dae-bb52b468219b@redhat.com>
 <ce9eb6a5-cd3a-a390-5684-525827b30f64@ti.com>
 <da2b671c-b05d-a57f-7bdf-8b1043a41240@redhat.com>
 <fee8a0fb-f862-03bd-5ede-8f105b6af529@ti.com>
 <b2178e1d-2f5c-e8a3-72fb-70f2f8d6aa45@redhat.com>
 <45a8a97c-2061-13ee-5da8-9877a4a3b8aa@ti.com>
 <c8739d7f-e12e-f6a2-7018-9eeaf6feb054@redhat.com>
 <20200828123409.4cd2a812.cohuck@redhat.com>
 <ac8f7e4f-9f46-919a-f5c2-89b07794f0ab@ti.com>
 <9cd58cd1-0041-3d98-baf7-6e5bc2e7e317@redhat.com>
 <edf25301-93c0-4ba6-aa85-5f04137d0906@ti.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5733dbfc-76c1-45dc-6dce-ef5449eacc73@redhat.com>
Date: Tue, 15 Sep 2020 16:18:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <edf25301-93c0-4ba6-aa85-5f04137d0906@ti.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Allen Hubbe <allenbh@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Dave Jiang <dave.jiang@intel.com>, kvm@vger.kernel.org,
 linux-ntb@googlegroups.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgS2lzaG9uOgoKT24gMjAyMC85LzE0IOS4i+WNiDM6MjMsIEtpc2hvbiBWaWpheSBBYnJhaGFt
IEkgd3JvdGU6Cj4+IFRoZW4geW91IG5lZWQgc29tZXRoaW5nIHRoYXQgaXMgZnVuY3Rpb25hbCBl
cXVpdmFsZW50IHRvIHZpcnRpbyBQQ0kKPj4gd2hpY2ggaXMgYWN0dWFsbHkgdGhlIGNvbmNlcHQg
b2YgdkRQQSAoZS5nIHZEUEEgcHJvdmlkZXMgYWx0ZXJuYXRpdmVzIGlmCj4+IHRoZSBxdWV1ZV9z
ZWwgaXMgaGFyZCBpbiB0aGUgRVAgaW1wbGVtZW50YXRpb24pLgo+IE9rYXksIEkganVzdCB0cmll
ZCB0byBjb21wYXJlIHRoZSAnc3RydWN0IHZkcGFfY29uZmlnX29wcycgYW5kICdzdHJ1Y3QKPiB2
aG9zdF9jb25maWdfb3BzJyAoIGludHJvZHVjZWQgaW4gW1JGQyBQQVRDSCAwMy8yMl0gdmhvc3Q6
IEFkZCBvcHMgZm9yCj4gdGhlIFZIT1NUIGRyaXZlciB0byBjb25maWd1cmUgVkhPU1QgZGV2aWNl
KS4KPgo+IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+IAkvKiBWaXJ0cXVldWUgb3BzICovCj4g
CWludCAoKnNldF92cV9hZGRyZXNzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gCQkJICAg
ICAgdTE2IGlkeCwgdTY0IGRlc2NfYXJlYSwgdTY0IGRyaXZlcl9hcmVhLAo+IAkJCSAgICAgIHU2
NCBkZXZpY2VfYXJlYSk7Cj4gCXZvaWQgKCpzZXRfdnFfbnVtKShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHUxNiBpZHgsIHUzMiBudW0pOwo+IAl2b2lkICgqa2lja192cSkoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKPiAJdm9pZCAoKnNldF92cV9jYikoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAo+IAkJCSAgc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKTsK
PiAJdm9pZCAoKnNldF92cV9yZWFkeSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4
LCBib29sIHJlYWR5KTsKPiAJYm9vbCAoKmdldF92cV9yZWFkeSkoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1MTYgaWR4KTsKPiAJaW50ICgqc2V0X3ZxX3N0YXRlKShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHUxNiBpZHgsCj4gCQkJICAgIGNvbnN0IHN0cnVjdCB2ZHBhX3ZxX3N0YXRlICpz
dGF0ZSk7Cj4gCWludCAoKmdldF92cV9zdGF0ZSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
MTYgaWR4LAo+IAkJCSAgICBzdHJ1Y3QgdmRwYV92cV9zdGF0ZSAqc3RhdGUpOwo+IAlzdHJ1Y3Qg
dmRwYV9ub3RpZmljYXRpb25fYXJlYQo+IAkoKmdldF92cV9ub3RpZmljYXRpb24pKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7Cj4gCS8qIHZxIGlycSBpcyBub3QgZXhwZWN0ZWQg
dG8gYmUgY2hhbmdlZCBvbmNlIERSSVZFUl9PSyBpcyBzZXQgKi8KPiAJaW50ICgqZ2V0X3ZxX2ly
cSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHYsIHUxNiBpZHgpOwo+Cj4gCS8qIERldmljZSBvcHMg
Ki8KPiAJdTMyICgqZ2V0X3ZxX2FsaWduKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+IAl1
NjQgKCpnZXRfZmVhdHVyZXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gCWludCAoKnNl
dF9mZWF0dXJlcykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpOwo+IAl2
b2lkICgqc2V0X2NvbmZpZ19jYikoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+IAkJCSAgICAg
IHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpjYik7Cj4gCXUxNiAoKmdldF92cV9udW1fbWF4KShzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+IAl1MzIgKCpnZXRfZGV2aWNlX2lkKShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYpOwo+IAl1MzIgKCpnZXRfdmVuZG9yX2lkKShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYpOwo+IAl1OCAoKmdldF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7
Cj4gCXZvaWQgKCpzZXRfc3RhdHVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1
cyk7Cj4gCXZvaWQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2ln
bmVkIGludCBvZmZzZXQsCj4gCQkJICAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuKTsKPiAJ
dm9pZCAoKnNldF9jb25maWcpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50
IG9mZnNldCwKPiAJCQkgICBjb25zdCB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pOwo+IAl1
MzIgKCpnZXRfZ2VuZXJhdGlvbikoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPgo+IAkvKiBE
TUEgb3BzICovCj4gCWludCAoKnNldF9tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3Ry
dWN0IHZob3N0X2lvdGxiICppb3RsYik7Cj4gCWludCAoKmRtYV9tYXApKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTY0IGlvdmEsIHU2NCBzaXplLAo+IAkJICAgICAgIHU2NCBwYSwgdTMyIHBl
cm0pOwo+IAlpbnQgKCpkbWFfdW5tYXApKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGlv
dmEsIHU2NCBzaXplKTsKPgo+IAkvKiBGcmVlIGRldmljZSByZXNvdXJjZXMgKi8KPiAJdm9pZCAo
KmZyZWUpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gfTsKPgo+ICtzdHJ1Y3Qgdmhvc3Rf
Y29uZmlnX29wcyB7Cj4gKwlpbnQgKCpjcmVhdGVfdnFzKShzdHJ1Y3Qgdmhvc3RfZGV2ICp2ZGV2
LCB1bnNpZ25lZCBpbnQgbnZxcywKPiArCQkJICB1bnNpZ25lZCBpbnQgbnVtX2J1ZnMsIHN0cnVj
dCB2aG9zdF92aXJ0cXVldWUgKnZxc1tdLAo+ICsJCQkgIHZob3N0X3ZxX2NhbGxiYWNrX3QgKmNh
bGxiYWNrc1tdLAo+ICsJCQkgIGNvbnN0IGNoYXIgKiBjb25zdCBuYW1lc1tdKTsKPiArCXZvaWQg
KCpkZWxfdnFzKShzdHJ1Y3Qgdmhvc3RfZGV2ICp2ZGV2KTsKPiArCWludCAoKndyaXRlKShzdHJ1
Y3Qgdmhvc3RfZGV2ICp2ZGV2LCB1NjQgdmhvc3RfZHN0LCB2b2lkICpzcmMsIGludCBsZW4pOwo+
ICsJaW50ICgqcmVhZCkoc3RydWN0IHZob3N0X2RldiAqdmRldiwgdm9pZCAqZHN0LCB1NjQgdmhv
c3Rfc3JjLCBpbnQgbGVuKTsKPiArCWludCAoKnNldF9mZWF0dXJlcykoc3RydWN0IHZob3N0X2Rl
diAqdmRldiwgdTY0IGRldmljZV9mZWF0dXJlcyk7Cj4gKwlpbnQgKCpzZXRfc3RhdHVzKShzdHJ1
Y3Qgdmhvc3RfZGV2ICp2ZGV2LCB1OCBzdGF0dXMpOwo+ICsJdTggKCpnZXRfc3RhdHVzKShzdHJ1
Y3Qgdmhvc3RfZGV2ICp2ZGV2KTsKPiArfTsKPiArCj4gc3RydWN0IHZpcnRpb19jb25maWdfb3Bz
Cj4gSSB0aGluayB0aGVyZSdzIHNvbWUgb3ZlcmxhcCBoZXJlIGFuZCBzb21lIG9mIHRoZSBvcHMg
dHJpZXMgdG8gZG8gdGhlCj4gc2FtZSB0aGluZy4KPgo+IEkgdGhpbmsgaXQgZGlmZmVycyBpbiAo
KnNldF92cV9hZGRyZXNzKSgpIGFuZCAoKmNyZWF0ZV92cXMpKCkuCj4gW2NyZWF0ZV92cXMoKSBp
bnRyb2R1Y2VkIGluIHN0cnVjdCB2aG9zdF9jb25maWdfb3BzIHByb3ZpZGVzCj4gY29tcGxpbWVu
dGFyeSBmdW5jdGlvbmFsaXR5IHRvICgqZmluZF92cXMpKCkgaW4gc3RydWN0Cj4gdmlydGlvX2Nv
bmZpZ19vcHMuIEl0IHNlZW1pbmdseSBlbmNhcHN1bGF0ZXMgdGhlIGZ1bmN0aW9uYWxpdHkgb2YK
PiAoKnNldF92cV9hZGRyZXNzKSgpLCAoKnNldF92cV9udW0pKCksICgqc2V0X3ZxX2NiKSgpLC4u
XS4KPgo+IEJhY2sgdG8gdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiAoKnNldF92cV9hZGRyZXNzKSgp
IGFuZCAoKmNyZWF0ZV92cXMpKCksCj4gc2V0X3ZxX2FkZHJlc3MoKSBkaXJlY3RseSBwcm92aWRl
cyB0aGUgdmlydHF1ZXVlIGFkZHJlc3MgdG8gdGhlIHZkcGEKPiBkZXZpY2UgYnV0IGNyZWF0ZV92
cXMoKSBvbmx5IHByb3ZpZGVzIHRoZSBwYXJhbWV0ZXJzIG9mIHRoZSB2aXJ0cXVldWUKPiAobGlr
ZSB0aGUgbnVtYmVyIG9mIHZpcnRxdWV1ZXMsIG51bWJlciBvZiBidWZmZXJzKSBidXQgZG9lcyBu
b3QgZGlyZWN0bHkKPiBwcm92aWRlIHRoZSBhZGRyZXNzLiBJTU8gdGhlIGJhY2tlbmQgY2xpZW50
IGRyaXZlcnMgKGxpa2UgbmV0IG9yIHZob3N0KQo+IHNob3VsZG4ndC9jYW5ub3QgYnkgaXRzZWxm
IGtub3cgaG93IHRvIGFjY2VzcyB0aGUgdnJpbmcgY3JlYXRlZCBvbgo+IHZpcnRpbyBmcm9udC1l
bmQuIFRoZSB2ZHBhIGRldmljZS92aG9zdCBkZXZpY2Ugc2hvdWxkIGhhdmUgbG9naWMgZm9yCj4g
dGhhdC4gVGhhdCB3aWxsIGhlbHAgdGhlIGNsaWVudCBkcml2ZXJzIHRvIHdvcmsgd2l0aCBkaWZm
ZXJlbnQgdHlwZXMgb2YKPiB2ZHBhIGRldmljZS92aG9zdCBkZXZpY2UgYW5kIGNhbiBhY2Nlc3Mg
dGhlIHZyaW5nIGNyZWF0ZWQgYnkgdmlydGlvCj4gaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgdGhl
IHZyaW5nIGNhbiBiZSBhY2Nlc3NlZCB2aWEgbW1pbyBvciBrZXJuZWwKPiBzcGFjZSBvciB1c2Vy
IHNwYWNlLgo+Cj4gSSB0aGluayB2ZHBhIGFsd2F5cyB3b3JrcyB3aXRoIGNsaWVudCBkcml2ZXJz
IGluIHVzZXJzcGFjZSBhbmQgcHJvdmlkaW5nCj4gdXNlcnNwYWNlIGFkZHJlc3MgZm9yIHZyaW5n
LgoKClNvcnJ5IGZvciBiZWluZyB1bmNsZWFyLiBXaGF0IEkgbWVhbnQgaXMgbm90IHJlcGxhY2lu
ZyB2RFBBIHdpdGggdGhlIAp2aG9zdChidXMpIHlvdSBwcm9wb3NlZCBidXQgdGhlIHBvc3NpYmls
aXR5IG9mIHJlcGxhY2luZyB2aXJ0aW8tcGNpLWVwZiAKd2l0aCB2RFBBIGluOgoKTXkgcXVlc3Rp
b24gaXMgYmFzaWNhbGx5IGZvciB0aGUgcGFydCBvZiB2aXJ0aW9fcGNpX2VwZl9zZW5kX2NvbW1h
bmQoKSwgCnNvIGl0IGxvb2tzIHRvIG1lIHlvdSBoYXZlIGEgdmVuZG9yIHNwZWNpZmljIEFQSSB0
byByZXBsYWNlIHRoZSAKdmlydGlvLXBjaSBsYXlvdXQgb2YgdGhlIEJBUjoKCgorc3RhdGljIGlu
dCB2aXJ0aW9fcGNpX2VwZl9zZW5kX2NvbW1hbmQoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2
cF9kZXYsCivCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgwqDCoMKgIHUzMiBjb21t
YW5kKQoreworwqDCoMKgIHN0cnVjdCB2aXJ0aW9fcGNpX2VwZiAqcGNpX2VwZjsKK8KgwqDCoCB2
b2lkIF9faW9tZW0gKmlvYWRkcjsKK8KgwqDCoCBrdGltZV90IHRpbWVvdXQ7CivCoMKgwqAgYm9v
bCB0aW1lZG91dDsKK8KgwqDCoCBpbnQgcmV0ID0gMDsKK8KgwqDCoCB1OCBzdGF0dXM7CisKK8Kg
wqDCoCBwY2lfZXBmID0gdG9fdmlydGlvX3BjaV9lcGYodnBfZGV2KTsKK8KgwqDCoCBpb2FkZHIg
PSB2cF9kZXYtPmlvYWRkcjsKKworwqDCoMKgIG11dGV4X2xvY2soJnBjaV9lcGYtPmxvY2spOwor
wqDCoMKgIHdyaXRlYihjb21tYW5kLCBpb2FkZHIgKyBIT1NUX0NNRCk7CivCoMKgwqAgdGltZW91
dCA9IGt0aW1lX2FkZF9tcyhrdGltZV9nZXQoKSwgQ09NTUFORF9USU1FT1VUKTsKK8KgwqDCoCB3
aGlsZSAoMSkgeworwqDCoMKgIMKgwqDCoCB0aW1lZG91dCA9IGt0aW1lX2FmdGVyKGt0aW1lX2dl
dCgpLCB0aW1lb3V0KTsKK8KgwqDCoCDCoMKgwqAgc3RhdHVzID0gcmVhZGIoaW9hZGRyICsgSE9T
VF9DTURfU1RBVFVTKTsKKwoKU2V2ZXJhbCBxdWVzdGlvbnM6CgotIEl0J3Mgbm90IGNsZWFyIHRv
IG1lIGhvdyB0aGUgc3luY2hyb25pemF0aW9uIGlzIGRvbmUgYmV0d2VlbiB0aGUgUkMgCmFuZCBF
UC4gRS5nIGhvdyBhbmQgd2hlbiB0aGUgdmFsdWUgb2YgSE9TVF9DTURfU1RBVFVTIGNhbiBiZSBj
aGFuZ2VkLsKgIApJZiB5b3Ugc3RpbGwgd2FudCB0byBpbnRyb2R1Y2UgYSBuZXcgdHJhbnNwb3J0
LCBhIHZpcnRpbyBzcGVjIHBhdGNoIAp3b3VsZCBiZSBoZWxwZnVsIGZvciB1cyB0byB1bmRlcnN0
YW5kIHRoZSBkZXZpY2UgQVBJLgotIFlvdSBoYXZlIHlvdSB2ZW5kb3Igc3BlY2lmaWMgbGF5b3V0
IChhY2NvcmRpbmcgdG8gCnZpcnRpb19wY2lfZXBiX3RhYmxlKCkpLCBzbyBJIGd1ZXNzIHlvdSBp
dCdzIGJldHRlciB0byBoYXZlIGEgdmVuZG9yIApzcGVjaWZpYyB2RFBBIGRyaXZlciBpbnN0ZWFk
Ci0gVGhlIGFkdmFudGFnZSBvZiB2ZW5kb3Igc3BlY2lmaWMgdkRQQSBkcml2ZXIgaXMgdGhhdCBp
dCBjYW4gMSkgaGF2ZSAKbGVzcyBjb2RlcyAyKSBzdXBwb3J0IHVzZXJzcGFjZSBkcml2ZXJzIHRo
cm91Z2ggdmhvc3QtdkRQQSAoaW5zdGVhZCBvZiAKaW52ZW50aW5nIG5ldyBBUElzIHNpbmNlIHdl
IGNhbid0IHVzZSB2ZmlvLXBjaSBoZXJlKS4KCgo+Pj4gIlZpcnRpbyBPdmVyIE5UQiIgc2hvdWxk
IGFueXdheXMgYmUgYSBuZXcgdHJhbnNwb3J0Lgo+Pj4+IERvZXMgdGhhdCBtYWtlIGFueSBzZW5z
ZT8KPj4+IHllYWgsIGluIHRoZSBhcHByb2FjaCBJIHVzZWQgdGhlIGluaXRpYWwgZmVhdHVyZXMg
YXJlIGhhcmQtY29kZWQgaW4KPj4+IHZob3N0LXJwbXNnIChpbmhlcmVudCB0byB0aGUgcnBtc2cp
IGJ1dCB3aGVuIHdlIGhhdmUgdG8gdXNlIGFkYXB0ZXIKPj4+IGxheWVyICh2aG9zdCBvbmx5IGZv
ciBhY2Nlc3NpbmcgdmlydGlvIHJpbmcgYW5kIHVzZSB2aXJ0aW8gZHJpdmVycyBvbgo+Pj4gYm90
aCBmcm9udCBlbmQgYW5kIGJhY2tlbmQpLCBiYXNlZCBvbiB0aGUgZnVuY3Rpb25hbGl0eSAoZS5n
LCBycG1zZyksCj4+PiB0aGUgdmhvc3Qgc2hvdWxkIGJlIGNvbmZpZ3VyZWQgd2l0aCBmZWF0dXJl
cyAodG8gYmUgcHJlc2VudGVkIHRvIHRoZQo+Pj4gdmlydGlvKSBhbmQgdGhhdCdzIHdoeSBhZGRp
dGlvbmFsIGxheWVyIG9yIEFQSXMgd2lsbCBiZSByZXF1aXJlZC4KPj4gQSBxdWVzdGlvbiBoZXJl
LCBpZiB3ZSBnbyB3aXRoIHZob3N0IGJ1cyBhcHByb2FjaCwgZG9lcyBpdCBtZWFuIHRoZQo+PiB2
aXJ0aW8gZGV2aWNlIGNhbiBvbmx5IGJlIGltcGxlbWVudGVkIGluIEVQJ3MgdXNlcnNwYWNlPwo+
IFRoZSB2aG9zdCBidXMgYXBwcm9hY2ggZG9lc24ndCBwcm92aWRlIGFueSByZXN0cmljdGlvbiBp
biB3aGVyZSB0aGUKPiB2aXJ0byBiYWNrZW5kIGRldmljZSBzaG91bGQgYmUgY3JlYXRlZC4gVGhp
cyBzZXJpZXMgY3JlYXRlcyB0d28gdHlwZXMgb2YKPiB2aXJ0aW8gYmFja2VuZCBkZXZpY2UgKG9u
ZSBmb3IgUENJZSBlbmRwb2ludCBhbmQgdGhlIG90aGVyIGZvciBOVEIpIGFuZAo+IGJvdGggdGhl
c2UgZGV2aWNlcyBhcmUgY3JlYXRlZCBpbiBrZXJuZWwuCgoKT2suCgpUaGFua3MKCgo+Cj4gVGhh
bmtzCj4gS2lzaG9uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
