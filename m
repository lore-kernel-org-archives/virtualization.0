Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C55C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 06:34:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3556864F7E
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 06:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3556864F7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB63F4317F;
	Fri, 12 Mar 2021 06:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y423Rqdh7RPq; Fri, 12 Mar 2021 06:34:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A9DA43240;
	Fri, 12 Mar 2021 06:34:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14984C000A;
	Fri, 12 Mar 2021 06:34:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8B2EC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6FDC4ED3A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-Y8nQ5UZI7M
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:34:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD7F64ED5E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615530865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+1V19JdRYahq0X3XulqGaxRbIWtSn54ETW3FVVrlmE=;
 b=IQ9Fpwukmo4cfjY0ErsuADXh3RvrsddSfFGlfH6UIYTaCHQWq9LA5Qy3lKcn9S0N/xQQ+Z
 8bQxHOEjGd6GackGphBpDGJdP8hzShAk5hC5tf3DelSxBKMapBuyLz0XK/ulvM4GycMSUJ
 1YYp7oL7J6QU6nuTQ63eQegsomNd0Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-m9UsF-HzPbOe7woipQPy0g-1; Fri, 12 Mar 2021 01:34:21 -0500
X-MC-Unique: m9UsF-HzPbOe7woipQPy0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C31C107ACCA;
 Fri, 12 Mar 2021 06:34:20 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-168.pek2.redhat.com
 [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C04018A77;
 Fri, 12 Mar 2021 06:34:12 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost-vdpa: set v->config_ctx to NULL if
 eventfd_ctx_fdget() fails
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210311135257.109460-1-sgarzare@redhat.com>
 <20210311135257.109460-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a5eac458-eed7-df75-66ac-0a8349ad09b0@redhat.com>
Date: Fri, 12 Mar 2021 14:34:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210311135257.109460-3-sgarzare@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjEvMy8xMSA5OjUyIOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IElu
IHZob3N0X3ZkcGFfc2V0X2NvbmZpZ19jYWxsKCkgaWYgZXZlbnRmZF9jdHhfZmRnZXQoKSBmYWls
cyB0aGUKPiAndi0+Y29uZmlnX2N0eCcgY29udGFpbnMgYW4gZXJyb3IgaW5zdGVhZCBvZiBhIHZh
bGlkIHBvaW50ZXIuCj4KPiBTaW5jZSB3ZSBjb25zaWRlciAndi0+Y29uZmlnX2N0eCcgdmFsaWQg
aWYgaXQgaXMgbm90IE5VTEwsIHdlIHNob3VsZAo+IHNldCBpdCB0byBOVUxMIGluIHRoaXMgY2Fz
ZSB0byBhdm9pZCB0byB1c2UgYW4gaW52YWxpZCBwb2ludGVyIGluCj4gb3RoZXIgZnVuY3Rpb25z
IHN1Y2ggYXMgdmhvc3RfdmRwYV9jb25maWdfcHV0KCkuCj4KPiBGaXhlczogNzc2ZjM5NTAwNGQ4
ICgidmhvc3RfdmRwYTogU3VwcG9ydCBjb25maWcgaW50ZXJydXB0IGluIHZkcGEiKQo+IENjOiBs
aW5nc2hhbi56aHVAaW50ZWwuY29tCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+CgoKQWNr
ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZl
cnMvdmhvc3QvdmRwYS5jIHwgOCArKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zk
cGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggMDA3OTZlNGVjZmRmLi5mOWVjZGNl
NTQ2OGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+IEBAIC0zMzEsOCArMzMxLDEyIEBAIHN0YXRpYyBsb25nIHZob3N0X3Zk
cGFfc2V0X2NvbmZpZ19jYWxsKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgX191c2VyICphcmdw
KQo+ICAgCWlmICghSVNfRVJSX09SX05VTEwoY3R4KSkKPiAgIAkJZXZlbnRmZF9jdHhfcHV0KGN0
eCk7Cj4gICAKPiAtCWlmIChJU19FUlIodi0+Y29uZmlnX2N0eCkpCj4gLQkJcmV0dXJuIFBUUl9F
UlIodi0+Y29uZmlnX2N0eCk7Cj4gKwlpZiAoSVNfRVJSKHYtPmNvbmZpZ19jdHgpKSB7Cj4gKwkJ
bG9uZyByZXQgPSBQVFJfRVJSKHYtPmNvbmZpZ19jdHgpOwo+ICsKPiArCQl2LT5jb25maWdfY3R4
ID0gTlVMTDsKPiArCQlyZXR1cm4gcmV0Owo+ICsJfQo+ICAgCj4gICAJdi0+dmRwYS0+Y29uZmln
LT5zZXRfY29uZmlnX2NiKHYtPnZkcGEsICZjYik7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
