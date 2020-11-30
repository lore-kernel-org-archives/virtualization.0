Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9FFC63777
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:28:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B89621D7A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Th29JUBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B89621D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A82E5865DB;
	Mon, 30 Nov 2020 03:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uOGmi-fUXaNc; Mon, 30 Nov 2020 03:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D1E88652A;
	Mon, 30 Nov 2020 03:28:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECD43C163C;
	Mon, 30 Nov 2020 03:28:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD490C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5DEF86D94
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLOmIux4Qxzz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:28:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9C2986D92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606706887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+ktcSCRfDfRJj94km371nTtLoxOjOvm9VnMZIoOpy4=;
 b=Th29JUBzDav0AxCGwFtnW2rjoA8AmzWY9Qw6oZd1CWF1tQlVluXmJDzOIGkaEqhBy4J0sH
 OMBiVNZCWV/iZdklbA4vFZA1X46yd+xoasRHxTU6Lkluui8m1TF9+UJ7+jMHMBVbbtlQjx
 P6nIfITZDhITv6BZvTK/Z4gIHGaqxB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-mRD_QdrDMKy7xeEWn7PLGQ-1; Sun, 29 Nov 2020 22:28:05 -0500
X-MC-Unique: mRD_QdrDMKy7xeEWn7PLGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 983381842141;
 Mon, 30 Nov 2020 03:28:04 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BD6E60C5F;
 Mon, 30 Nov 2020 03:27:52 +0000 (UTC)
Subject: Re: [PATCH v2 13/17] vdpa_sim: set vringh notify callback
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-14-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5569e198-22be-514a-744a-1bef9a3b95ce@redhat.com>
Date: Mon, 30 Nov 2020 11:27:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-14-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBJ
bnN0ZWFkIG9mIGNhbGxpbmcgdGhlIHZxIGNhbGxiYWNrIGRpcmVjdGx5LCB3ZSBjYW4gbGV2ZXJh
Z2UgdGhlCj4gdnJpbmdoX25vdGlmeSgpIGZ1bmN0aW9uLCBhZGRpbmcgdmRwYXNpbV92cV9ub3Rp
ZnkoKSBhbmQgc2V0dGluZyBpdAo+IGluIHRoZSB2cmluZ2ggbm90aWZ5IGNhbGxiYWNrLgo+Cj4g
U3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMjEgKysrKysrKysrKysrKysrKyst
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gaW5kZXggOGI4N2NlMDQ4NWI2Li40MzI3ZWZk
NmQ0MWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiAr
KysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC0xMjAsNiArMTIwLDE3
IEBAIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqZGV2X3RvX3NpbShzdHJ1Y3QgZGV2aWNlICpkZXYp
Cj4gICAJcmV0dXJuIHZkcGFfdG9fc2ltKHZkcGEpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lk
IHZkcGFzaW1fdnFfbm90aWZ5KHN0cnVjdCB2cmluZ2ggKnZyaW5nKQo+ICt7Cj4gKwlzdHJ1Y3Qg
dmRwYXNpbV92aXJ0cXVldWUgKnZxID0KPiArCQljb250YWluZXJfb2YodnJpbmcsIHN0cnVjdCB2
ZHBhc2ltX3ZpcnRxdWV1ZSwgdnJpbmcpOwo+ICsKPiArCWlmICghdnEtPmNiKQo+ICsJCXJldHVy
bjsKPiArCj4gKwl2cS0+Y2IodnEtPnByaXZhdGUpOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQg
dmRwYXNpbV9xdWV1ZV9yZWFkeShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdW5zaWduZWQgaW50
IGlkeCkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgKnZxID0gJnZkcGFzaW0t
PnZxc1tpZHhdOwo+IEBAIC0xMzEsNiArMTQyLDggQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9xdWV1
ZV9yZWFkeShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdW5zaWduZWQgaW50IGlkeCkKPiAgIAkJ
CSAgKHVpbnRwdHJfdCl2cS0+ZHJpdmVyX2FkZHIsCj4gICAJCQkgIChzdHJ1Y3QgdnJpbmdfdXNl
ZCAqKQo+ICAgCQkJICAodWludHB0cl90KXZxLT5kZXZpY2VfYWRkcik7Cj4gKwo+ICsJdnEtPnZy
aW5nLm5vdGlmeSA9IHZkcGFzaW1fdnFfbm90aWZ5OwoKCkRvIHdlIG5lZWQgdG8gY2xlYXIgbm90
aWZ5IGR1cmluZyByZXNldD8KCk90aGVyIGxvb2tzIGdvb2QuCgoKPiAgIH0KPiAgIAo+ICAgc3Rh
dGljIHZvaWQgdmRwYXNpbV92cV9yZXNldChzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwKPiBAQCAt
MjIwLDEwICsyMzMsMTAgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCj4gICAJCXNtcF93bWIoKTsKPiAgIAo+ICAgCQlsb2NhbF9iaF9kaXNh
YmxlKCk7Cj4gLQkJaWYgKHR4cS0+Y2IpCj4gLQkJCXR4cS0+Y2IodHhxLT5wcml2YXRlKTsKPiAt
CQlpZiAocnhxLT5jYikKPiAtCQkJcnhxLT5jYihyeHEtPnByaXZhdGUpOwo+ICsJCWlmICh2cmlu
Z2hfbmVlZF9ub3RpZnlfaW90bGIoJnR4cS0+dnJpbmcpID4gMCkKPiArCQkJdnJpbmdoX25vdGlm
eSgmdHhxLT52cmluZyk7Cj4gKwkJaWYgKHZyaW5naF9uZWVkX25vdGlmeV9pb3RsYigmcnhxLT52
cmluZykgPiAwKQo+ICsJCQl2cmluZ2hfbm90aWZ5KCZyeHEtPnZyaW5nKTsKPiAgIAkJbG9jYWxf
YmhfZW5hYmxlKCk7Cj4gICAKPiAgIAkJaWYgKCsrcGt0cyA+IDQpIHsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
