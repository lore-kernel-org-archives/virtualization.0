Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8590DC433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 06:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25D5540289;
	Mon,  7 Feb 2022 06:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFJR9QKHB2CP; Mon,  7 Feb 2022 06:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95BAE40223;
	Mon,  7 Feb 2022 06:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B185C0011;
	Mon,  7 Feb 2022 06:45:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13842C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F108740289
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K7x-3duumSVF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:45:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01F5340223
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644216322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEUURs9DbKRojqtjER3XfuZTqVH5n0Bbt2yoRWooa6A=;
 b=FgkbDuH8tkkhtHGz1M52r9GcJdjSxNuTyC9MxrRE1Or7bGqMuNsvMCh+ixE2j6jFdEPIcH
 YJ4JQDgxCLZYHk51LcrA0rS8GYV1WDkdzI+0SWD8DxRga/Z6yqEBOJT3C/Z8pq9j6a0BxZ
 jlyRuDc6CZ7J9n2uIuzpyn7Z1piOMAE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-XkjMHBoINj6TKUH8YgrdNQ-1; Mon, 07 Feb 2022 01:45:13 -0500
X-MC-Unique: XkjMHBoINj6TKUH8YgrdNQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 y3-20020a1709029b8300b0014c8bcb70a1so4866769plp.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Feb 2022 22:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JEUURs9DbKRojqtjER3XfuZTqVH5n0Bbt2yoRWooa6A=;
 b=7r5ksANeL9Rfkk+UMiStERCTgQR954apzQ2ndpo/x7AJ74BkN451ZnSCMhltTyWnrq
 INk2v/0s/K38SSTvfMfneK5nrnYprHNUE8fJ+p2e/XOJMg9c6eNgUXygI0F4UShp1bV3
 U3SsQ/bKRiqiMJYKpK/43b+PPJmGpeCMm/8OKnOAam7K5HAbHdfrR0sLE/B4QFbDZBn+
 RJ6zLw08pEplhaTVtCGJGRqHZGb8mjJ2xkop5oNCM6w1/VTs7pmvRv4hYk0Ggiew1iVa
 NUpPLeQib8Nb/vy+FAhs+8O+n04P6tefnaOKa65Q5NFx7LGB6QPcv2LUruJAWy4Web5X
 hREg==
X-Gm-Message-State: AOAM530erqKV3kI0Ymjfc9ueKLd1NNnKlGcf87J+bUo8HBxB+bmTH0by
 3HofPd0mp2mIWDf70B0FjR+DzD84UxAIqNjJsc9M+IqOlzrCzZ6NSMHFiFAkyQCozpVD0Mqoxvj
 4tPS4+0UjajjOypo11ef+504Tcxt0k32By+6Gwn0/ow==
X-Received: by 2002:a63:6b42:: with SMTP id g63mr8303757pgc.602.1644216311786; 
 Sun, 06 Feb 2022 22:45:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtYZ8GxxwFMH2BvLkRE/V/ozYLXcbkTgERq0ID8ESIJ580AADyl/hLYYCiSuS83tm2veY2YQ==
X-Received: by 2002:a63:6b42:: with SMTP id g63mr8303744pgc.602.1644216311494; 
 Sun, 06 Feb 2022 22:45:11 -0800 (PST)
Received: from [10.72.13.253] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 17sm11002163pfl.175.2022.02.06.22.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Feb 2022 22:45:10 -0800 (PST)
Message-ID: <6e3efe44-3ca8-acfa-58a6-c0fc150846e7@redhat.com>
Date: Mon, 7 Feb 2022 14:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 03/17] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220126073533.44994-4-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzEvMjYg5LiL5Y2IMzozNSwgWHVhbiBaaHVvIOWGmemBkzoKPiBQZXJmb3JtaW5n
IHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIHR3byBzdGVwczoKPgo+IDEuIHJlc2V0
X3ZxOiByZXNldCBvbmUgdnEKPiAyLiBlbmFibGVfcmVzZXRfdnE6IHJlLWVuYWJsZSB0aGUgcmVz
ZXQgcXVldWUKPgo+IEluIHRoZSBmaXJzdCBzdGVwLCB0aGVzZSB0YXNrcyB3aWxsIGJlIGNvbXBs
ZXRlZDoKPiAgICAgIDEuIG5vdGlmeSB0aGUgaGFyZHdhcmUgcXVldWUgdG8gcmVzZXQKPiAgICAg
IDIuIHJlY3ljbGUgdGhlIGJ1ZmZlciBmcm9tIHZxCj4gICAgICAzLiByZWxlYXNlIHRoZSByaW5n
IG9mIHRoZSB2cQo+Cj4gVGhlIHNlY29uZCBzdGVwIGlzIHNpbWlsYXIgdG8gZmluZCB2cXMsCgoK
Tm90IHN1cmUsIHNpbmNlIGZpbmRfdnFzIHdpbGwgdXN1YWxseSB0cnkgdG8gYWxsb2NhdGUgaW50
ZXJydXB0cy4KCgo+ICAgcGFzc2luZyBwYXJhbWV0ZXJzIGNhbGxiYWNrIGFuZAo+IG5hbWUsIGV0
Yy4gQmFzZWQgb24gdGhlIG9yaWdpbmFsIHZxLCB0aGUgcmluZyBpcyByZS1hbGxvY2F0ZWQgYW5k
Cj4gY29uZmlndXJlZCB0byB0aGUgYmFja2VuZC4KCgpJIHdvbmRlciB3aGV0aGVyIHdlIHJlYWxs
eSBoYXZlIHN1Y2ggcmVxdWlyZW1lbnQuCgpGb3IgZXhhbXBsZSwgZG8gd2UgcmVhbGx5IGhhdmUg
YSB1c2UgY2FzZSB0aGF0IG1heSBjaGFuZ2U6Cgp2cSBjYWxsYmFjaywgY3R4LCByaW5nX251bSBv
ciBldmVuIHJlLWNyZWF0ZSB0aGUgdmlydHF1ZXVlPwoKVGhhbmtzCgoKPgo+IFNvIGFkZCB0d28g
Y2FsbGJhY2tzIHJlc2V0X3ZxLCBlbmFibGVfcmVzZXRfdnEgdG8gc3RydWN0Cj4gdmlydGlvX2Nv
bmZpZ19vcHMuCj4KPiBBZGQgYSBzdHJ1Y3R1cmUgZm9yIHBhc3NpbmcgcGFyYW1ldGVycy4gVGhp
cyB3aWxsIGZhY2lsaXRhdGUgc3Vic2VxdWVudAo+IGV4cGFuc2lvbiBvZiB0aGUgcGFyYW1ldGVy
cyBvZiBlbmFibGUgcmVzZXQgdnEuCj4gVGhlcmUgaXMgY3VycmVudGx5IG9ubHkgb25lIGRlZmF1
bHQgZXh0ZW5kZWQgcGFyYW1ldGVyIHJpbmdfbnVtLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGluY2x1ZGUvbGludXgv
dmlydGlvX2NvbmZpZy5oIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggYi9pbmNsdWRlL2xpbnV4
L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IDRkMTA3YWQzMTE0OS4uNTFkZDg0NjFkMWI2IDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gKysrIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW9fY29uZmlnLmgKPiBAQCAtMTYsNiArMTYsNDQgQEAgc3RydWN0IHZpcnRpb19z
aG1fcmVnaW9uIHsKPiAgIAl1NjQgbGVuOwo+ICAgfTsKPiAgIAo+ICt0eXBlZGVmIHZvaWQgdnFf
Y2FsbGJhY2tfdChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ICsKPiArLyogdmlydGlvX3Jlc2V0X3Zx
OiBzcGVjaWZ5IHBhcmFtZXRlcnMgZm9yIHF1ZXVlX3Jlc2V0Cj4gKyAqCj4gKyAqCXZkZXY6IHRo
ZSBkZXZpY2UKPiArICoJcXVldWVfaW5kZXg6IHRoZSBxdWV1ZSBpbmRleAo+ICsgKgo+ICsgKglm
cmVlX3VudXNlZF9jYjogY2FsbGJhY2sgdG8gZnJlZSB1bnVzZWQgYnVmcwo+ICsgKglkYXRhOiB1
c2VkIGJ5IGZyZWVfdW51c2VkX2NiCj4gKyAqCj4gKyAqCWNhbGxiYWNrOiBjYWxsYmFjayBmb3Ig
dGhlIHZpcnRxdWV1ZSwgTlVMTCBmb3IgdnEgdGhhdCBkbyBub3QgbmVlZCBhCj4gKyAqCSAgICAg
ICAgICBjYWxsYmFjawo+ICsgKgluYW1lOiB2aXJ0cXVldWUgbmFtZXMgKG1haW5seSBmb3IgZGVi
dWdnaW5nKSwgTlVMTCBmb3IgdnEgdW51c2VkIGJ5Cj4gKyAqCSAgICAgIGRyaXZlcgo+ICsgKglj
dHg6IGN0eAo+ICsgKgo+ICsgKglyaW5nX251bTogc3BlY2lmeSByaW5nIG51bSBmb3IgdGhlIHZx
IHRvIGJlIHJlLWVuYWJsZWQuIDAgbWVhbnMgdXNlIHRoZQo+ICsgKgkgICAgICAgICAgZGVmYXVs
dCB2YWx1ZS4gTVVTVCBiZSBhIHBvd2VyIG9mIDIuCj4gKyAqLwo+ICtzdHJ1Y3QgdmlydGlvX3Jl
c2V0X3ZxOwo+ICt0eXBlZGVmIHZvaWQgdnFfcmVzZXRfY2FsbGJhY2tfdChzdHJ1Y3QgdmlydGlv
X3Jlc2V0X3ZxICpwYXJhbSwgdm9pZCAqYnVmKTsKPiArc3RydWN0IHZpcnRpb19yZXNldF92cSB7
Cj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldjsKPiArCXUxNiBxdWV1ZV9pbmRleDsKPiAr
Cj4gKwkvKiByZXNldCB2cSBwYXJhbSAqLwo+ICsJdnFfcmVzZXRfY2FsbGJhY2tfdCAqZnJlZV91
bnVzZWRfY2I7Cj4gKwl2b2lkICpkYXRhOwo+ICsKPiArCS8qIGVuYWJsZSByZXNldCB2cSBwYXJh
bSAqLwo+ICsJdnFfY2FsbGJhY2tfdCAqY2FsbGJhY2s7Cj4gKwljb25zdCBjaGFyICpuYW1lOwo+
ICsJY29uc3QgYm9vbCAqY3R4Owo+ICsKPiArCS8qIGV4dCBlbmFibGUgcmVzZXQgdnEgcGFyYW0g
Ki8KPiArCXUxNiByaW5nX251bTsKPiArfTsKPiArCj4gICAvKioKPiAgICAqIHZpcnRpb19jb25m
aWdfb3BzIC0gb3BlcmF0aW9ucyBmb3IgY29uZmlndXJpbmcgYSB2aXJ0aW8gZGV2aWNlCj4gICAg
KiBOb3RlOiBEbyBub3QgYXNzdW1lIHRoYXQgYSB0cmFuc3BvcnQgaW1wbGVtZW50cyBhbGwgb2Yg
dGhlIG9wZXJhdGlvbnMKPiBAQCAtNzQsOCArMTEyLDkgQEAgc3RydWN0IHZpcnRpb19zaG1fcmVn
aW9uIHsKPiAgICAqIEBzZXRfdnFfYWZmaW5pdHk6IHNldCB0aGUgYWZmaW5pdHkgZm9yIGEgdmly
dHF1ZXVlIChvcHRpb25hbCkuCj4gICAgKiBAZ2V0X3ZxX2FmZmluaXR5OiBnZXQgdGhlIGFmZmlu
aXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ICAgICogQGdldF9zaG1fcmVnaW9uOiBn
ZXQgYSBzaGFyZWQgbWVtb3J5IHJlZ2lvbiBiYXNlZCBvbiB0aGUgaW5kZXguCj4gKyAqIEByZXNl
dF92cTogcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkKPiArICogQGVuYWJsZV9yZXNldF92cTog
ZW5hYmxlIGEgcmVzZXQgcXVldWUKPiAgICAqLwo+IC10eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tf
dChzdHJ1Y3QgdmlydHF1ZXVlICopOwo+ICAgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKPiAg
IAl2b2lkICgqZW5hYmxlX2Nicykoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpOwo+ICAgCXZv
aWQgKCpnZXQpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCj4g
QEAgLTEwMCw2ICsxMzksOCBAQCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewo+ICAgCQkJaW50
IGluZGV4KTsKPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24pKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LAo+ICAgCQkJICAgICAgIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiAqcmVnaW9uLCB1
OCBpZCk7Cj4gKwlpbnQgKCpyZXNldF92cSkoc3RydWN0IHZpcnRpb19yZXNldF92cSAqcGFyYW0p
Owo+ICsJc3RydWN0IHZpcnRxdWV1ZSAqKCplbmFibGVfcmVzZXRfdnEpKHN0cnVjdCB2aXJ0aW9f
cmVzZXRfdnEgKnBhcmFtKTsKPiAgIH07Cj4gICAKPiAgIC8qIElmIGRyaXZlciBkaWRuJ3QgYWR2
ZXJ0aXNlIHRoZSBmZWF0dXJlLCBpdCB3aWxsIG5ldmVyIGFwcGVhci4gKi8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
