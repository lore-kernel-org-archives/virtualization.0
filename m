Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E68C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 05:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E424940239;
	Wed,  7 Sep 2022 05:38:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E424940239
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ky12rQYF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CKcieN6eLdcL; Wed,  7 Sep 2022 05:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B171401CC;
	Wed,  7 Sep 2022 05:38:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B171401CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B875C0033;
	Wed,  7 Sep 2022 05:38:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B786C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 05:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3305E401F1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 05:38:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3305E401F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPhp1MZ7yfXb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 05:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AF85401CC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AF85401CC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 05:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662529095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/ijoziX1JqP00j9yW5u7IZw3l7uhHHBn3IFfumff2g=;
 b=Ky12rQYFCUBhadLWUWvshBiLc814c+XDmP2PfWcSDlQ1N80ehxB+IEOQOvDDuBVKKkO8HV
 fCJP4v3nEGYi4zs6ubBafSlya1gN0bM4Xvi9Q95S41Vr/3v3WFLDf2eR1ADmtx2l06yz2d
 OY+g1p4/zXKgp5S+BAdRXWGSEv3U98s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-moZrJPedN0aJIahKu7kTkQ-1; Wed, 07 Sep 2022 01:38:13 -0400
X-MC-Unique: moZrJPedN0aJIahKu7kTkQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 p18-20020a170902e75200b00176c0e055c9so3634454plf.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 22:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=z/ijoziX1JqP00j9yW5u7IZw3l7uhHHBn3IFfumff2g=;
 b=s6W5cfz56eCnjPBsR9Z3Aa4qzweZGtyesAPfYy5IQ/i3jU4iz9cKXd+G2wU2k6Kuh4
 zRlAStFbUBWLXNYHQjJ1GE/uqbDOoXT0pObRi+xTp4CbemIL7Rz7LKlUNs1sPYe3AkFR
 CC3H/liyeK5WcRdZbgrsxoJ0NaA4503lJPEovPSQqOfzidWWtWlFwO8d/Qklb+8uiUAl
 3xPa9fdnmJK2AdFjtl9+ir3x1Eo7+8JG9kZr93O53dsaa4RyazTPnmwqcWBzx4gUi4Bo
 Igslnuh2kZKwMIFw+BbWGeg1wGQj/d9kRzyhML4/aFXv95+A2lNnK2QrSOwC9q2Ragbw
 7LfQ==
X-Gm-Message-State: ACgBeo1M2LXseUhdcEjDovnyQ1WDXzBb7+GCk/Z3tux0wNi7/CiWepYu
 Lp+XAwBuenWob46I51H8bQMN+z1DSBl0CoeQF3xosQoUq2kS8xPUcPtirM2PglmJ44uJaMwaLkG
 1ylXeNOjOXKPu0foGMwnl6+JFbyiOyer+iRoR9OaguQ==
X-Received: by 2002:a17:902:ef50:b0:171:516d:d2ce with SMTP id
 e16-20020a170902ef5000b00171516dd2cemr2150670plx.171.1662529092675; 
 Tue, 06 Sep 2022 22:38:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5xHIuO0ckPVo1IAdDm+QtW6wb3fUCt/3CAknqurpy5/WVdwoP6vH+j2dzlabcwVg6m63ayGA==
X-Received: by 2002:a17:902:ef50:b0:171:516d:d2ce with SMTP id
 e16-20020a170902ef5000b00171516dd2cemr2150649plx.171.1662529092367; 
 Tue, 06 Sep 2022 22:38:12 -0700 (PDT)
Received: from [10.72.13.171] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a170902654900b00172ba718ed4sm6142087pln.138.2022.09.06.22.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Sep 2022 22:38:11 -0700 (PDT)
Message-ID: <b1a7c454-860d-6a40-9da1-2a06f30ff1be@redhat.com>
Date: Wed, 7 Sep 2022 13:38:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v3 6/7] virtio: in order support for virtio_ring
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn>
 <20220901055434.824-7-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901055434.824-7-qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIyLzkvMSAxMzo1NCwgR3VvIFpoaSDlhpnpgZM6Cj4gSWYgaW4gb3JkZXIgZmVhdHVy
ZSBuZWdvdGlhdGVkLCB3ZSBjYW4gc2tpcCB0aGUgdXNlZCByaW5nIHRvIGdldAo+IGJ1ZmZlcidz
IGRlc2MgaWQgc2VxdWVudGlhbGx5LiAgRm9yIHNraXBwZWQgYnVmZmVycyBpbiB0aGUgYmF0Y2gs
IHRoZQo+IHVzZWQgcmluZyBkb2Vzbid0IGNvbnRhaW4gdGhlIGJ1ZmZlciBsZW5ndGgsIGFjdHVh
bGx5IHRoZXJlIGlzIG5vdCBuZWVkCj4gdG8gZ2V0IHNraXBwZWQgYnVmZmVycycgbGVuZ3RoIGFz
IHRoZXkgYXJlIHR4IGJ1ZmZlci4KPgo+IFNpZ25lZC1vZmYtYnk6IEd1byBaaGkgPHF0eHVuaW5n
MTk5OUBzanR1LmVkdS5jbj4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
fCA3NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA2NCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+IGluZGV4IDAwYWE0YjdhNDljMi4uZDUyNjI0MTc5YjQzIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gQEAgLTEwMyw2ICsxMDMsOSBAQCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsKPiAgIAkv
KiBIb3N0IHN1cHBvcnRzIGluZGlyZWN0IGJ1ZmZlcnMgKi8KPiAgIAlib29sIGluZGlyZWN0Owo+
ICAgCj4gKwkvKiBIb3N0IHN1cHBvcnRzIGluIG9yZGVyIGZlYXR1cmUgKi8KPiArCWJvb2wgaW5f
b3JkZXI7Cj4gKwo+ICAgCS8qIEhvc3QgcHVibGlzaGVzIGF2YWlsIGV2ZW50IGlkeCAqLwo+ICAg
CWJvb2wgZXZlbnQ7Cj4gICAKPiBAQCAtMTQ0LDYgKzE0NywxOSBAQCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlIHsKPiAgIAkJCS8qIERNQSBhZGRyZXNzIGFuZCBzaXplIGluZm9ybWF0aW9uICovCj4g
ICAJCQlkbWFfYWRkcl90IHF1ZXVlX2RtYV9hZGRyOwo+ICAgCQkJc2l6ZV90IHF1ZXVlX3NpemVf
aW5fYnl0ZXM7Cj4gKwo+ICsJCQkvKiBJZiBpbl9vcmRlciBmZWF0dXJlIGlzIG5lZ290aWF0ZWQs
IGhlcmUgaXMgdGhlIG5leHQgaGVhZCB0byBjb25zdW1lICovCj4gKwkJCXUxNiBuZXh0X2Rlc2Nf
YmVnaW47Cj4gKwkJCS8qCj4gKwkJCSAqIElmIGluX29yZGVyIGZlYXR1cmUgaXMgbmVnb3RpYXRl
ZCwKPiArCQkJICogaGVyZSBpcyB0aGUgbGFzdCBkZXNjcmlwdG9yJ3MgaWQgaW4gdGhlIGJhdGNo
Cj4gKwkJCSAqLwo+ICsJCQl1MTYgbGFzdF9kZXNjX2luX2JhdGNoOwo+ICsJCQkvKgo+ICsJCQkg
KiBJZiBpbl9vcmRlciBmZWF0dXJlIGlzIG5lZ290aWF0ZWQsCj4gKwkJCSAqIGJ1ZmZlcnMgZXhj
ZXB0IGxhc3QgYnVmZmVyIGluIHRoZSBiYXRjaCBhcmUgc2tpcHBlZCBidWZmZXIKPiArCQkJICov
Cj4gKwkJCWJvb2wgaXNfc2tpcHBlZF9idWZmZXI7Cj4gICAJCX0gc3BsaXQ7Cj4gICAKPiAgIAkJ
LyogQXZhaWxhYmxlIGZvciBwYWNrZWQgcmluZyAqLwo+IEBAIC01ODQsOCArNjAwLDYgQEAgc3Rh
dGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEs
Cj4gICAJCQkJCSB0b3RhbF9zZyAqIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyksCj4gICAJCQkJ
CSBWUklOR19ERVNDX0ZfSU5ESVJFQ1QsCj4gICAJCQkJCSBmYWxzZSk7Cj4gLQkJdnEtPnNwbGl0
LmRlc2NfZXh0cmFbaGVhZCAmICh2cS0+c3BsaXQudnJpbmcubnVtIC0gMSldLmZsYWdzICY9Cj4g
LQkJCX5WUklOR19ERVNDX0ZfTkVYVDsKCgpUaGlzIHNlZW1zIGlycmVsZXZhbnQuCgoKPiAgIAl9
Cj4gICAKPiAgIAkvKiBXZSdyZSB1c2luZyBzb21lIGJ1ZmZlcnMgZnJvbSB0aGUgZnJlZSBsaXN0
LiAqLwo+IEBAIC03MDEsOCArNzE1LDE2IEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfc3BsaXQo
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsIHVuc2lnbmVkIGludCBoZWFkLAo+ICAgCX0KPiAg
IAo+ICAgCXZyaW5nX3VubWFwX29uZV9zcGxpdCh2cSwgaSk7Cj4gLQl2cS0+c3BsaXQuZGVzY19l
eHRyYVtpXS5uZXh0ID0gdnEtPmZyZWVfaGVhZDsKPiAtCXZxLT5mcmVlX2hlYWQgPSBoZWFkOwo+
ICsJLyoKPiArCSAqIElmIGluX29yZGVyIGZlYXR1cmUgaXMgbmVnb3RpYXRlZCwKPiArCSAqIHRo
ZSBkZXNjcmlwdG9ycyBhcmUgbWFkZSBhdmFpbGFibGUgaW4gb3JkZXIuCj4gKwkgKiBTaW5jZSB0
aGUgZnJlZV9oZWFkIGlzIGFscmVhZHkgYSBjaXJjdWxhciBsaXN0LAo+ICsJICogaXQgbXVzdCBj
b25zdW1lIGl0IHNlcXVlbnRpYWxseS4KPiArCSAqLwo+ICsJaWYgKCF2cS0+aW5fb3JkZXIpIHsK
PiArCQl2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0ID0gdnEtPmZyZWVfaGVhZDsKPiArCQl2
cS0+ZnJlZV9oZWFkID0gaGVhZDsKPiArCX0KPiAgIAo+ICAgCS8qIFBsdXMgZmluYWwgZGVzY3Jp
cHRvciAqLwo+ICAgCXZxLT52cS5udW1fZnJlZSsrOwo+IEBAIC03NDQsNyArNzY2LDcgQEAgc3Rh
dGljIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpf
dnEsCj4gICB7Cj4gICAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
PiAgIAl2b2lkICpyZXQ7Cj4gLQl1bnNpZ25lZCBpbnQgaTsKPiArCXVuc2lnbmVkIGludCBpLCBq
Owo+ICAgCXUxNiBsYXN0X3VzZWQ7Cj4gICAKPiAgIAlTVEFSVF9VU0UodnEpOwo+IEBAIC03NjMs
MTEgKzc4NSwzOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KHN0
cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgIAkvKiBPbmx5IGdldCB1c2VkIGFycmF5IGVudHJpZXMg
YWZ0ZXIgdGhleSBoYXZlIGJlZW4gZXhwb3NlZCBieSBob3N0LiAqLwo+ICAgCXZpcnRpb19ybWIo
dnEtPndlYWtfYmFycmllcnMpOwo+ICAgCj4gLQlsYXN0X3VzZWQgPSAodnEtPmxhc3RfdXNlZF9p
ZHggJiAodnEtPnNwbGl0LnZyaW5nLm51bSAtIDEpKTsKPiAtCWkgPSB2aXJ0aW8zMl90b19jcHUo
X3ZxLT52ZGV2LAo+IC0JCQl2cS0+c3BsaXQudnJpbmcudXNlZC0+cmluZ1tsYXN0X3VzZWRdLmlk
KTsKPiAtCSpsZW4gPSB2aXJ0aW8zMl90b19jcHUoX3ZxLT52ZGV2LAo+IC0JCQl2cS0+c3BsaXQu
dnJpbmcudXNlZC0+cmluZ1tsYXN0X3VzZWRdLmxlbik7Cj4gKwlpZiAodnEtPmluX29yZGVyKSB7
Cj4gKwkJbGFzdF91c2VkID0gKHZxLT5sYXN0X3VzZWRfaWR4ICYgKHZxLT5zcGxpdC52cmluZy5u
dW0gLSAxKSk7CgoKTGV0J3MgbW92ZSB0aGlzIGJleW9uZCB0aGUgaW5fb3JkZXIgY2hlY2suCgoK
PiArCQlpZiAoIXZxLT5zcGxpdC5pc19za2lwcGVkX2J1ZmZlcikgewo+ICsJCQl2cS0+c3BsaXQu
bGFzdF9kZXNjX2luX2JhdGNoID0KPiArCQkJCXZpcnRpbzMyX3RvX2NwdShfdnEtPnZkZXYsCj4g
KwkJCQkJCXZxLT5zcGxpdC52cmluZy51c2VkLT5yaW5nW2xhc3RfdXNlZF0uaWQpOwo+ICsJCQl2
cS0+c3BsaXQuaXNfc2tpcHBlZF9idWZmZXIgPSB0cnVlOwo+ICsJCX0KPiArCQkvKiBGb3Igc2tp
cHBlZCBidWZmZXJzIGluIGJhdGNoLCB3ZSBjYW4gaWdub3JlIHRoZSBsZW4gaW5mbywgc2ltcGx5
IHNldCBsZW4gYXMgMCAqLwoKClRoaXMgc2VlbXMgdG8gYnJlYWsgdGhlIGNhbGxlciB0aGF0IGRl
cGVuZHMgb24gYSBjb3JyZWN0IGxlbi4KCgo+ICsJCWlmICh2cS0+c3BsaXQubmV4dF9kZXNjX2Jl
Z2luICE9IHZxLT5zcGxpdC5sYXN0X2Rlc2NfaW5fYmF0Y2gpIHsKPiArCQkJKmxlbiA9IDA7Cj4g
KwkJfSBlbHNlIHsKPiArCQkJKmxlbiA9IHZpcnRpbzMyX3RvX2NwdShfdnEtPnZkZXYsCj4gKwkJ
CQkJICAgICAgIHZxLT5zcGxpdC52cmluZy51c2VkLT5yaW5nW2xhc3RfdXNlZF0ubGVuKTsKPiAr
CQkJdnEtPnNwbGl0LmlzX3NraXBwZWRfYnVmZmVyID0gZmFsc2U7Cj4gKwkJfQo+ICsJCWkgPSB2
cS0+c3BsaXQubmV4dF9kZXNjX2JlZ2luOwo+ICsJCWogPSBpOwo+ICsJCS8qIEluZGlyZWN0IG9u
bHkgdGFrZXMgb25lIGRlc2NyaXB0b3IgaW4gZGVzY3JpcHRvciB0YWJsZSAqLwo+ICsJCXdoaWxl
ICghdnEtPmluZGlyZWN0ICYmICh2cS0+c3BsaXQuZGVzY19leHRyYVtqXS5mbGFncyAmIFZSSU5H
X0RFU0NfRl9ORVhUKSkKPiArCQkJaiA9IChqICsgMSkgJiAodnEtPnNwbGl0LnZyaW5nLm51bSAt
IDEpOwoKCkFueSByZWFzb24gaW5kaXJlY3QgZGVzY3JpcHRvcnMgY2FuJ3QgYmUgY2hhaW5lZD8K
Cgo+ICsJCS8qIG1vdmUgdG8gbmV4dCAqLwo+ICsJCWogPSAoaiArIDEpICUgdnEtPnNwbGl0LnZy
aW5nLm51bTsKPiArCQkvKiBOZXh0IGJ1ZmZlciB3aWxsIHVzZSB0aGlzIGRlc2NyaXB0b3IgaW4g
b3JkZXIgKi8KPiArCQl2cS0+c3BsaXQubmV4dF9kZXNjX2JlZ2luID0gajsKCgpJcyBpdCBtb3Jl
IGVmZmljaWVudCB0byBwb2tlIHRoZSBhdmFpbGFibGUgcmluZz8KClRoYW5rcwoKCj4gKwl9IGVs
c2Ugewo+ICsJCWxhc3RfdXNlZCA9ICh2cS0+bGFzdF91c2VkX2lkeCAmICh2cS0+c3BsaXQudnJp
bmcubnVtIC0gMSkpOwo+ICsJCWkgPSB2aXJ0aW8zMl90b19jcHUoX3ZxLT52ZGV2LAo+ICsJCQkJ
ICAgIHZxLT5zcGxpdC52cmluZy51c2VkLT5yaW5nW2xhc3RfdXNlZF0uaWQpOwo+ICsJCSpsZW4g
PSB2aXJ0aW8zMl90b19jcHUoX3ZxLT52ZGV2LAo+ICsJCQkJICAgICAgIHZxLT5zcGxpdC52cmlu
Zy51c2VkLT5yaW5nW2xhc3RfdXNlZF0ubGVuKTsKPiArCX0KPiAgIAo+ICAgCWlmICh1bmxpa2Vs
eShpID49IHZxLT5zcGxpdC52cmluZy5udW0pKSB7Cj4gICAJCUJBRF9SSU5HKHZxLCAiaWQgJXUg
b3V0IG9mIHJhbmdlXG4iLCBpKTsKPiBAQCAtMjIyMyw2ICsyMjcyLDcgQEAgc3RydWN0IHZpcnRx
dWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiAgIAo+ICAg
CXZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lO
RElSRUNUX0RFU0MpICYmCj4gICAJCSFjb250ZXh0Owo+ICsJdnEtPmluX29yZGVyID0gdmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX0lOX09SREVSKTsKPiAgIAl2cS0+ZXZlbnQgPSB2
aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX1JJTkdfRl9FVkVOVF9JRFgpOwo+ICAgCj4g
ICAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9PUkRFUl9QTEFURk9STSkp
Cj4gQEAgLTIyMzUsNiArMjI4NSwxMCBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192
aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ICAgCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19z
aGFkb3cgPSAwOwo+ICAgCXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93ID0gMDsKPiAgIAo+ICsJ
dnEtPnNwbGl0Lm5leHRfZGVzY19iZWdpbiA9IDA7Cj4gKwl2cS0+c3BsaXQubGFzdF9kZXNjX2lu
X2JhdGNoID0gMDsKPiArCXZxLT5zcGxpdC5pc19za2lwcGVkX2J1ZmZlciA9IGZhbHNlOwo+ICsK
PiAgIAkvKiBObyBjYWxsYmFjaz8gIFRlbGwgb3RoZXIgc2lkZSBub3QgdG8gYm90aGVyIHVzLiAq
Lwo+ICAgCWlmICghY2FsbGJhY2spIHsKPiAgIAkJdnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRv
dyB8PSBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVDsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
