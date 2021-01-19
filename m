Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC544C433E0
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 04:14:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F861206F1
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 04:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F861206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9121F27261;
	Tue, 19 Jan 2021 04:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dlzWKZfNALw; Tue, 19 Jan 2021 04:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5796A27233;
	Tue, 19 Jan 2021 04:14:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 377A4C088B;
	Tue, 19 Jan 2021 04:14:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52674C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3B91785E40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4FT2QXzFN-5m
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:14:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6185985E07
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611029676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vFu34b/oSoHaP1hnpnil6zPu8VkSwS3YHn7n2rcBvE=;
 b=fKaOr16kDV/yF2HLVMo0Az3TG/s28DnImkaynChRJH5Q7mIktPW+vwg3ySSD8FIuZTiyYV
 dwmbfKpUApqQzSAdLQFjAdkuiRXaOBtZJSwqpUTBmX4AQly5L6l7i5U6d49U2jA9k4vU46
 AYq9VMHWIGe6o4Hh1vvuN8ZTaJSaCHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Y-YV8Mh0MqmFAcbPbi2chA-1; Mon, 18 Jan 2021 23:14:32 -0500
X-MC-Unique: Y-YV8Mh0MqmFAcbPbi2chA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D1218C89C4;
 Tue, 19 Jan 2021 04:14:30 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F19657;
 Tue, 19 Jan 2021 04:14:22 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <405493e0-7917-2ee9-7242-5f02c044a0fb@redhat.com>
Date: Tue, 19 Jan 2021 12:14:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xOCDkuIrljYgxMTo1OCwgSm9zZXBoIFFpIHdyb3RlOgo+IG1vZHVsZSBwYXJh
bWV0ZXIgJ3ZpcnRibGtfcXVldWVfZGVwdGgnIHdhcyBmaXJzdGx5IGludHJvZHVjZWQgZm9yCj4g
dGVzdGluZy9iZW5jaG1hcmtpbmcgcHVycG9zZXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzQzMjRi
NDU5N2MKPiAoInZpcnRpby1ibGs6IGJhc2UgcXVldWUtZGVwdGggb24gdmlydHF1ZXVlIHJpbmdz
aXplIG9yIG1vZHVsZSBwYXJhbSIpLgo+IFNpbmNlIHdlIGhhdmUgZGlmZmVyZW50IHZpcnRpby1i
bGsgZGV2aWNlcyB3aGljaCBoYXZlIGRpZmZlcmVudAo+IGNhcGFiaWxpdGllcywgaXQgcmVxdWly
ZXMgdGhhdCB3ZSBzdXBwb3J0IHBlci1kZXZpY2UgcXVldWUgZGVwdGggaW5zdGVhZAo+IG9mIHBl
ci1tb2R1bGUuIFNvIGRlZmF1bHRseSB1c2UgdnEgZnJlZSBlbGVtZW50cyBpZiBtb2R1bGUgcGFy
YW1ldGVyCj4gJ3ZpcnRibGtfcXVldWVfZGVwdGgnIGlzIG5vdCBzZXQuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBKb3NlcGggUWkgPGpvc2VwaC5xaUBsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMgfCAxMiArKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+IGluZGV4IDE0NTYw
NmQuLmY4M2E0MTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPiAr
KysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+IEBAIC03MDUsNiArNzA1LDcgQEAgc3Rh
dGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCXUz
MiB2LCBibGtfc2l6ZSwgbWF4X3NpemUsIHNnX2VsZW1zLCBvcHRfaW9fc2l6ZTsKPiAgIAl1MTYg
bWluX2lvX3NpemU7Cj4gICAJdTggcGh5c2ljYWxfYmxvY2tfZXhwLCBhbGlnbm1lbnRfb2Zmc2V0
Owo+ICsJdW5zaWduZWQgaW50IHF1ZXVlX2RlcHRoOwo+ICAgCj4gICAJaWYgKCF2ZGV2LT5jb25m
aWctPmdldCkgewo+ICAgCQlkZXZfZXJyKCZ2ZGV2LT5kZXYsICIlcyBmYWlsdXJlOiBjb25maWcg
YWNjZXNzIGRpc2FibGVkXG4iLAo+IEBAIC03NTUsMTcgKzc1NiwxOCBAQCBzdGF0aWMgaW50IHZp
cnRibGtfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJCWdvdG8gb3V0X2Zy
ZWVfdnE7Cj4gICAJfQo+ICAgCj4gLQkvKiBEZWZhdWx0IHF1ZXVlIHNpemluZyBpcyB0byBmaWxs
IHRoZSByaW5nLiAqLwo+IC0JaWYgKCF2aXJ0YmxrX3F1ZXVlX2RlcHRoKSB7Cj4gLQkJdmlydGJs
a19xdWV1ZV9kZXB0aCA9IHZibGstPnZxc1swXS52cS0+bnVtX2ZyZWU7Cj4gKwlpZiAobGlrZWx5
KCF2aXJ0YmxrX3F1ZXVlX2RlcHRoKSkgewo+ICsJCXF1ZXVlX2RlcHRoID0gdmJsay0+dnFzWzBd
LnZxLT5udW1fZnJlZTsKPiAgIAkJLyogLi4uIGJ1dCB3aXRob3V0IGluZGlyZWN0IGRlc2NzLCB3
ZSB1c2UgMiBkZXNjcyBwZXIgcmVxICovCj4gICAJCWlmICghdmlydGlvX2hhc19mZWF0dXJlKHZk
ZXYsIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQykpCj4gLQkJCXZpcnRibGtfcXVldWVfZGVw
dGggLz0gMjsKPiArCQkJcXVldWVfZGVwdGggLz0gMjsKPiArCX0gZWxzZSB7Cj4gKwkJcXVldWVf
ZGVwdGggPSB2aXJ0YmxrX3F1ZXVlX2RlcHRoOwo+ICAgCX0KPiAgIAo+ICAgCW1lbXNldCgmdmJs
ay0+dGFnX3NldCwgMCwgc2l6ZW9mKHZibGstPnRhZ19zZXQpKTsKPiAgIAl2YmxrLT50YWdfc2V0
Lm9wcyA9ICZ2aXJ0aW9fbXFfb3BzOwo+IC0JdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHZp
cnRibGtfcXVldWVfZGVwdGg7Cj4gKwl2YmxrLT50YWdfc2V0LnF1ZXVlX2RlcHRoID0gcXVldWVf
ZGVwdGg7Cj4gICAJdmJsay0+dGFnX3NldC5udW1hX25vZGUgPSBOVU1BX05PX05PREU7Cj4gICAJ
dmJsay0+dGFnX3NldC5mbGFncyA9IEJMS19NUV9GX1NIT1VMRF9NRVJHRTsKPiAgIAl2YmxrLT50
YWdfc2V0LmNtZF9zaXplID0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
