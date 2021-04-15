Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA78C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:16:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E565611F1
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E565611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9B4B60D86;
	Thu, 15 Apr 2021 08:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MwBji6yD9U7Q; Thu, 15 Apr 2021 08:16:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7797160D74;
	Thu, 15 Apr 2021 08:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA20C000C;
	Thu, 15 Apr 2021 08:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA8F3C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9BD260D81
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9M2OIhU-0nEg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:16:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F6FA60D74
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618474592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3qfacKPFWYJe6SJGGT9jnGqaiQMDFfgudP5Ye2GaUQ=;
 b=UvM2lA4UEc+hvdVPyTlY+DpqNXKkbZ4cpZgX5dfqQDKCQT4DLwiQVExI+wKsytfUqNk0GL
 0ISGthUimiUPrxjMQS3z77H5NNqDNHhrzB7uq18WvIBdXspQsksB4WwrTwtdE18kukpGVf
 rRSjezJKfi3fN2AbiiCth8q0agg6yS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-nf00DL1qOpq2a81pIwwyBQ-1; Thu, 15 Apr 2021 04:16:29 -0400
X-MC-Unique: nf00DL1qOpq2a81pIwwyBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA2310053E8;
 Thu, 15 Apr 2021 08:16:28 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-61.pek2.redhat.com
 [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1581C1F057;
 Thu, 15 Apr 2021 08:16:21 +0000 (UTC)
Subject: Re: [PATCH 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
To: Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-4-lingshan.zhu@intel.com>
 <20210415081236.anbssqtsyjnmiaby@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <178b6e14-dfb5-b5f9-477e-15801d849c2a@redhat.com>
Date: Thu, 15 Apr 2021 16:16:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415081236.anbssqtsyjnmiaby@steredhat>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, leonro@nvidia.com
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

CuWcqCAyMDIxLzQvMTUg5LiL5Y2INDoxMiwgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiBP
biBXZWQsIEFwciAxNCwgMjAyMSBhdCAwNToxODozMlBNICswODAwLCBaaHUgTGluZ3NoYW4gd3Jv
dGU6Cj4+IGdldF9jb25maWdfc2l6ZSgpIHNob3VsZCByZXR1cm4gdGhlIHNpemUgYmFzZWQgb24g
dGhlIGRlY2VjdGVkCj4+IGRldmljZSB0eXBlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGlu
Z3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jIHwgMTEgKysrKysrKysrKy0KPj4gMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
Ywo+PiBpbmRleCA5YjZhMzhiNzk4ZmEuLmI0OGI5Nzg5YjY5ZSAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4+IEBAIC0zNDcsNyArMzQ3LDE2IEBAIHN0YXRpYyB1MzIgaWZjdmZfdmRw
YV9nZXRfdnFfYWxpZ24oc3RydWN0IAo+PiB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Cj4+IHN0
YXRpYyBzaXplX3QgaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhX2RldikKPj4gewo+PiAtwqDCoMKgIHJldHVybiBzaXplb2Yoc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnKTsKPj4gK8KgwqDCoCBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2
ZHBhX2Rldik7Cj4+ICvCoMKgwqAgc2l6ZV90IHNpemU7Cj4+ICsKPj4gK8KgwqDCoCBpZiAodmYt
PmRldl90eXBlID09IFZJUlRJT19JRF9ORVQpCj4+ICvCoMKgwqDCoMKgwqDCoCBzaXplID0gc2l6
ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAodmYtPmRl
dl90eXBlID09IFZJUlRJT19JRF9CTE9DSykKPj4gK8KgwqDCoMKgwqDCoMKgIHNpemUgPSBzaXpl
b2Yoc3RydWN0IHZpcnRpb19ibGtfY29uZmlnKTsKPj4gKwo+PiArwqDCoMKgIHJldHVybiBzaXpl
Owo+Cj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBpZmN2ZiBkZXRhaWxzLCBidXQgY2FuIGl0
IGhhcHBlbiB0aGF0IHRoZSAKPiBkZXZpY2UgaXMgbm90IGJsb2NrIG9yIG5ldD8KPgo+IFNob3Vs
ZCB3ZSBzZXQgYHNpemVgIHRvIDAgYnkgZGVmYXVsdCB0byBoYW5kbGUgdGhpcyBjYXNlIG9yIGFy
ZSB3ZSAKPiBzdXJlIGl0J3Mgb25lIG9mIHRoZSB0d28/Cj4KPiBNYXliZSB3ZSBzaG91bGQgYWRk
IGEgY29tbWVudCBvciBhIHdhcm5pbmcgbWVzc2FnZSBpbiB0aGlzIGNhc2UsIHRvIAo+IHByZXZl
bnQgc29tZSBhbmFseXNpcyB0b29sIG9yIGNvbXBpbGVyIGZyb20gd29ycnlpbmcgdGhhdCBgc2l6
ZWAgbWlnaHQgCj4gYmUgdW5pbml0aWFsaXplZC4KPgo+IEkgd2FzIHRoaW5raW5nIHNvbWV0aGlu
ZyBsaWtlIHRoaXM6Cj4KPiDCoMKgwqDCoHN3aXRjaCh2Zi0+ZGV2X3R5cGUpIHsKPiDCoMKgwqDC
oGNhc2UgVklSVElPX0lEX05FVDoKPiDCoMKgwqDCoMKgwqDCoCBzaXplID0gc2l6ZW9mKHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZyk7Cj4gwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqBj
YXNlIFZJUlRJT19JRF9CTE9DSzoKPiDCoMKgwqDCoMKgwqDCoCBzaXplID0gc2l6ZW9mKHN0cnVj
dCB2aXJ0aW9fYmxrX2NvbmZpZyk7Cj4gwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gwqDCoMKgwqBk
ZWZhdWx0Ogo+IMKgwqDCoMKgwqDCoMKgIC8qIG9yIFdBUk4oMSwgIiIpIGlmIGRldl93YXJuKCkg
bm90IGFwcGx5ICovCj4gwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm4oLi4uICwgInZpcnRpbyBJRCBb
MHgleF0gbm90IHN1cHBvcnRlZFxuIikKPiDCoMKgwqDCoMKgwqDCoCBzaXplID0gMDsKPgo+IMKg
wqDCoMKgfQo+CgpZZXMsIEkgYWdyZWUuCgpUaGFua3MKCgo+IFRoYW5rcywKPiBTdGVmYW5vCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
