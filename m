Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A39EC64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:08:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB3220757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXVS5jGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB3220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FCD3872F0;
	Mon, 30 Nov 2020 03:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-t84vaSkdCy; Mon, 30 Nov 2020 03:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A7C408722B;
	Mon, 30 Nov 2020 03:08:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92BACC0859;
	Mon, 30 Nov 2020 03:08:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84642C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6E5B020C41
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KSu8yGUQPOa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:08:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5BB3221080
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606705695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=clkfvuFNq2hdJY744R66AkCZTfv6bN3GZv0TvqZ3EpY=;
 b=JXVS5jGnqy+3VY/Nh/fxV9W270xQezU22KtGB68kk9Bl/73weVWFBhq0NtB4KJTFRwRL6Z
 wXwljNF25LLT58mOVTQJSvSiEoR2eYJzYGChOxPbLEyU8KReEUgZr9WZkrK2e0XGZD44H7
 hqRW2ecsK3gpeoArlsfh8MkZgQCdCGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-6ZjAUzukNdCXz1y0d7gwmg-1; Sun, 29 Nov 2020 22:08:12 -0500
X-MC-Unique: 6ZjAUzukNdCXz1y0d7gwmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741EA1E7ED;
 Mon, 30 Nov 2020 03:08:11 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC5D60C4D;
 Mon, 30 Nov 2020 03:07:59 +0000 (UTC)
Subject: Re: [PATCH v2 05/17] vdpa_sim: rename vdpasim_config_ops variables
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-6-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aa1f23e3-585c-55c1-1529-f17853f13b17@redhat.com>
Date: Mon, 30 Nov 2020 11:07:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-6-sgarzare@redhat.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBU
aGVzZSB2YXJpYWJsZXMgc3RvcmVzIGdlbmVyaWMgY2FsbGJhY2tzIHVzZWQgYnkgdGhlIHZEUEEg
c2ltdWxhdG9yCj4gY29yZSwgc28gd2UgY2FuIHJlbW92ZSB0aGUgJ25ldCcgd29yZCBpbiB0aGVp
ciBuYW1lcy4KPgo+IENvLWRldmVsb3BlZC1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZp
ZGlhLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMTIgKysr
KysrLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IDQwNjY0ZDg3ZjMwMy4uNjIyMDRlMDY0ODQx
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtMzMxLDggKzMzMSw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgdmRwYXNpbV9kbWFfb3BzID0gewo+ICAgCS5m
cmVlID0gdmRwYXNpbV9mcmVlX2NvaGVyZW50LAo+ICAgfTsKPiAgIAo+IC1zdGF0aWMgY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX25ldF9jb25maWdfb3BzOwo+IC1zdGF0aWMg
Y29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX25ldF9iYXRjaF9jb25maWdfb3Bz
Owo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2NvbmZpZ19v
cHM7Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fYmF0Y2hf
Y29uZmlnX29wczsKPiAgIAo+ICAgc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0
ZSh2b2lkKQo+ICAgewo+IEBAIC0zNDIsOSArMzQyLDkgQEAgc3RhdGljIHN0cnVjdCB2ZHBhc2lt
ICp2ZHBhc2ltX2NyZWF0ZSh2b2lkKQo+ICAgCWludCBpLCByZXQgPSAtRU5PTUVNOwo+ICAgCj4g
ICAJaWYgKGJhdGNoX21hcHBpbmcpCj4gLQkJb3BzID0gJnZkcGFzaW1fbmV0X2JhdGNoX2NvbmZp
Z19vcHM7Cj4gKwkJb3BzID0gJnZkcGFzaW1fYmF0Y2hfY29uZmlnX29wczsKPiAgIAllbHNlCj4g
LQkJb3BzID0gJnZkcGFzaW1fbmV0X2NvbmZpZ19vcHM7Cj4gKwkJb3BzID0gJnZkcGFzaW1fY29u
ZmlnX29wczsKPiAgIAo+ICAgCXZkcGFzaW0gPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdmRw
YXNpbSwgdmRwYSwgTlVMTCwgb3BzLCBWRFBBU0lNX1ZRX05VTSk7Cj4gICAJaWYgKCF2ZHBhc2lt
KQo+IEBAIC02NTcsNyArNjU3LDcgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9mcmVlKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSkKPiAgIAlrZnJlZSh2ZHBhc2ltLT52cXMpOwo+ICAgfQo+ICAgCj4g
LXN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fbmV0X2NvbmZpZ19v
cHMgPSB7Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fY29u
ZmlnX29wcyA9IHsKPiAgIAkuc2V0X3ZxX2FkZHJlc3MgICAgICAgICA9IHZkcGFzaW1fc2V0X3Zx
X2FkZHJlc3MsCj4gICAJLnNldF92cV9udW0gICAgICAgICAgICAgPSB2ZHBhc2ltX3NldF92cV9u
dW0sCj4gICAJLmtpY2tfdnEgICAgICAgICAgICAgICAgPSB2ZHBhc2ltX2tpY2tfdnEsCj4gQEAg
LTY4NCw3ICs2ODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBh
c2ltX25ldF9jb25maWdfb3BzID0gewo+ICAgCS5mcmVlICAgICAgICAgICAgICAgICAgID0gdmRw
YXNpbV9mcmVlLAo+ICAgfTsKPiAgIAo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmln
X29wcyB2ZHBhc2ltX25ldF9iYXRjaF9jb25maWdfb3BzID0gewo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2JhdGNoX2NvbmZpZ19vcHMgPSB7Cj4gICAJLnNl
dF92cV9hZGRyZXNzICAgICAgICAgPSB2ZHBhc2ltX3NldF92cV9hZGRyZXNzLAo+ICAgCS5zZXRf
dnFfbnVtICAgICAgICAgICAgID0gdmRwYXNpbV9zZXRfdnFfbnVtLAo+ICAgCS5raWNrX3ZxICAg
ICAgICAgICAgICAgID0gdmRwYXNpbV9raWNrX3ZxLAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
