Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6716BC4361B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 11:07:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09802336F
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 11:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09802336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 17D4E207A8;
	Wed,  9 Dec 2020 11:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qwd5Y27Ml7Cb; Wed,  9 Dec 2020 11:07:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8EB7B2051A;
	Wed,  9 Dec 2020 11:07:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FC85C0FA7;
	Wed,  9 Dec 2020 11:07:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1032C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 11:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BB42087216
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 11:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHVc8eAtmM06
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 11:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D1D9987212
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607512071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNP/s73hcs7iADiI2LbiH+U19DRgaYLN1YsBGHYmWOw=;
 b=cfjtGhq7NboOeM+7fNUdj/Q+MavCgVk3YSqENbCOBCppacCoEzpUe2S7aiTC4HFDnq14c2
 8acio4NWL8ywJ5Gz5dNUnBOf7sNkwfri63tfG/Zig3xkt0lfAeaq+tGkTh+3tsooFfDC0t
 5AalIM8U635J5clu790U27Rc+nIz7kA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-uzmDL-zvOM-CB54xEXLz-g-1; Wed, 09 Dec 2020 06:07:49 -0500
X-MC-Unique: uzmDL-zvOM-CB54xEXLz-g-1
Received: by mail-wm1-f70.google.com with SMTP id b184so245304wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 03:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NNP/s73hcs7iADiI2LbiH+U19DRgaYLN1YsBGHYmWOw=;
 b=N5kC0veW9nruu2kelxMTVOhf3wyl1ZyCP/AXWRcnlLKiTz9n9uGSVFTp/F25jFeHCZ
 iPDt+M61CJ5TjM+fpUhvtnd1n4AYljloJN/N6hx2iH42Ybee9eywncgKEmd0rah4QDqC
 n/NljzQvDXFhE8q5ZoRc9gVMGv8jkhN6e3Y1nJVpDjVFWozdY5HgnMl8XeQ51IUa6g81
 0qMDthhyp82FzptmRIJp8tSjyjUyOdrgoJDZMDsTiaTmPKvDzDvhIabdZBNbXLyY7vT4
 jH4Wv62xtYg4urclYDjoRsKNXSVQnCKM9R08zbsCJ69Yrm0iSiGGomun2MZ3atxxPhk4
 L80A==
X-Gm-Message-State: AOAM533hvN2NsSa2VoERCP+vcX0+9y+GO6pTP0F32NSqzMwmlPxLbdfu
 40hd/JFB3ierwgNzhZUpWQ4YbFRib71PcqkO03IROE62p0P57jhN7BTWhVoi/l63U1t6mu7flUl
 MJAH7ygJ8JsHljwHQZDmta789u5Ja6Uf14dUuhziq5A==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr2162507wrs.248.1607512068691; 
 Wed, 09 Dec 2020 03:07:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLJjrGYKJa9GuB+sZae7CCE+GVRzbLSWplYg80HvLuf0DS5zxtBPkAXu0cvRnclJxHYP+ZcA==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr2162481wrs.248.1607512068518; 
 Wed, 09 Dec 2020 03:07:48 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it.
 [79.24.227.66])
 by smtp.gmail.com with ESMTPSA id z140sm2839639wmc.30.2020.12.09.03.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 03:07:47 -0800 (PST)
Date: Wed, 9 Dec 2020 12:07:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 13/19] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Message-ID: <20201209110745.p4ybybanzip2lav3@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-14-sgarzare@redhat.com>
 <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
MIME-Version: 1.0
In-Reply-To: <829a5026-a68c-6d02-49ef-f237dcae2460@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

T24gTW9uLCBEZWMgMDcsIDIwMjAgYXQgMDE6Mjk6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMi80IOS4iuWNiDE6MDUsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj5UaGUgZ2V0X2NvbmZpZyBjYWxsYmFjayBjYW4gYmUgdXNlZCBieSB0aGUgZGV2aWNlIHRvIGZp
bGwgdGhlCj4+Y29uZmlnIHN0cnVjdHVyZS4KPj5UaGUgY2FsbGJhY2sgd2lsbCBiZSBpbnZva2Vk
IGluIHZkcGFzaW1fZ2V0X2NvbmZpZygpIGJlZm9yZSBjb3B5aW5nCj4+Ynl0ZXMgaW50byBjYWxs
ZXIgYnVmZmVyLgo+Pgo+Pk1vdmUgdkRQQS1uZXQgY29uZmlnIHVwZGF0ZXMgZnJvbSB2ZHBhc2lt
X3NldF9mZWF0dXJlcygpIGluIHRoZQo+Pm5ldyB2ZHBhc2ltX25ldF9nZXRfY29uZmlnKCkgY2Fs
bGJhY2suCj4+Cj4+U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUBy
ZWRoYXQuY29tPgo+Pi0tLQo+PnYzOgo+Pi0gY2hlY2tlZCBpZiBnZXRfY29uZmlnIGNhbGxiYWNr
IGlzIHNldCBiZWZvcmUgY2FsbCBpdAo+Pi0tLQo+PiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmMgfCAzNSArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbS5jCj4+aW5kZXggZmU3MWVkNzg5MGUxLi5mOTM1YWRlMDgwNmIgMTAwNjQ0
Cj4+LS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj4rKysgYi9kcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PkBAIC02MCw2ICs2MCw4IEBAIHN0cnVjdCB2ZHBh
c2ltX3ZpcnRxdWV1ZSB7Cj4+ICAjZGVmaW5lIFZEUEFTSU1fTkVUX0ZFQVRVUkVTCShWRFBBU0lN
X0ZFQVRVUkVTIHwgXAo+PiAgCQkJCSAoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTUFDKSkKPj4rc3Ry
dWN0IHZkcGFzaW07Cj4+Kwo+PiAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewo+PiAgCXU2NCBz
dXBwb3J0ZWRfZmVhdHVyZXM7Cj4+ICAJc2l6ZV90IGNvbmZpZ19zaXplOwo+PkBAIC02Nyw2ICs2
OSw3IEBAIHN0cnVjdCB2ZHBhc2ltX2Rldl9hdHRyIHsKPj4gIAl1MzIgaWQ7Cj4+ICAJd29ya19m
dW5jX3Qgd29ya19mbjsKPj4rCXZvaWQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRwYXNpbSAqdmRw
YXNpbSwgdm9pZCAqY29uZmlnKTsKPj4gIH07Cj4+ICAvKiBTdGF0ZSBvZiBlYWNoIHZkcGFzaW0g
ZGV2aWNlICovCj4+QEAgLTUyMiw4ICs1MjUsNiBAQCBzdGF0aWMgdTY0IHZkcGFzaW1fZ2V0X2Zl
YXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPj4gIHN0YXRpYyBpbnQgdmRwYXNpbV9z
ZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4+ICB7
Cj4+ICAJc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPj4tCXN0
cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyAqY29uZmlnID0KPj4tCQkoc3RydWN0IHZpcnRpb19uZXRf
Y29uZmlnICopdmRwYXNpbS0+Y29uZmlnOwo+PiAgCS8qIERNQSBtYXBwaW5nIG11c3QgYmUgZG9u
ZSBieSBkcml2ZXIgKi8KPj4gIAlpZiAoIShmZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX0FD
Q0VTU19QTEFURk9STSkpKQo+PkBAIC01MzEsMTYgKzUzMiw2IEBAIHN0YXRpYyBpbnQgdmRwYXNp
bV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4+
ICAJdmRwYXNpbS0+ZmVhdHVyZXMgPSBmZWF0dXJlcyAmIHZkcGFzaW0tPmRldl9hdHRyLnN1cHBv
cnRlZF9mZWF0dXJlczsKPj4tCS8qIFdlIGdlbmVyYWxseSBvbmx5IGtub3cgd2hldGhlciBndWVz
dCBpcyB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFjZQo+Pi0JICogaGVyZSwgc28gZ2VuZXJhbGx5
IHRoYXQncyB0aGUgZWFybGllc3Qgd2UgY2FuIHNldCBjb25maWcgZmllbGRzLgo+Pi0JICogTm90
ZTogV2UgYWN0dWFsbHkgcmVxdWlyZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gYWJvdmUgd2hp
Y2gKPj4tCSAqIGltcGxpZXMgVklSVElPX0ZfVkVSU0lPTl8xLCBidXQgbGV0J3Mgbm90IHRyeSB0
byBiZSBjbGV2ZXIgaGVyZS4KPj4tCSAqLwo+Pi0KPj4tCWNvbmZpZy0+bXR1ID0gY3B1X3RvX3Zk
cGFzaW0xNih2ZHBhc2ltLCAxNTAwKTsKPj4tCWNvbmZpZy0+c3RhdHVzID0gY3B1X3RvX3ZkcGFz
aW0xNih2ZHBhc2ltLCBWSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4+LQltZW1jcHkoY29uZmlnLT5t
YWMsIG1hY2FkZHJfYnVmLCBFVEhfQUxFTik7Cj4KPgo+UGF0Y2ggbG9va3MgZ29vZCB0byBtZS4K
Pgo+QnV0IHdlIG5lZWQgTWljaGFlbCB0byBjb25maXJtIHdoZXRoZXIgZG9pbmcgbW92aW5nIGxp
a2UgdGhpcyBpcyBzYWZlLiAKPkkgZ3Vlc3Mgd2hhdCBoYXMgYmVlbiBkb25lIHdlcmUgdHJ5aW5n
IHRvIG1ha2Ugc3VyZSBnZXRfY29uZmlnKCkgZmFpbCAKPmJlZm9yZSBzZXRfZmVhdHVyZXMoKSwg
YnV0IGl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoZXRoZXIgaXQncyB1c2VmdWwuCgpJSVVDLCBhbHNv
IGxvb2tpbmcgdGhlIFFFTVUgY29kZSwgdGhlIHNldF9mZWF0dXJlcygpIHNob3VsZCBiZSBjYWxs
ZWQgCmV2ZXJ5IHRpbWUgYmVmb3JlIGdldF9jb25maWcoKSwgYnV0IHRvIGJlIHN1cmUsIGluIGdl
dF9jb25maWcoKSwgSSBjYW4gCmNoZWNrIGZvciBleGFtcGxlIGlmICd2ZHBhc2ltLT5mZWF0dXJl
cycgaXMgbm90IHplcm8gKHdlIHJlcXVpcmUgClZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBzZXQp
LgoKQE1pY2hhZWwgYW55IHN1Z2dlc3Rpb24/CgpUaGFua3MsClN0ZWZhbm8KCj4KPlRoYW5rcwo+
Cj4KPj4tCj4+ICAJcmV0dXJuIDA7Cj4+ICB9Cj4+QEAgLTU5NSw4ICs1ODYsMTMgQEAgc3RhdGlj
IHZvaWQgdmRwYXNpbV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdW5zaWdu
ZWQgaW50IG9mZnNldCwKPj4gIHsKPj4gIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFf
dG9fc2ltKHZkcGEpOwo+Pi0JaWYgKG9mZnNldCArIGxlbiA8IHZkcGFzaW0tPmRldl9hdHRyLmNv
bmZpZ19zaXplKQo+Pi0JCW1lbWNweShidWYsIHZkcGFzaW0tPmNvbmZpZyArIG9mZnNldCwgbGVu
KTsKPj4rCWlmIChvZmZzZXQgKyBsZW4gPiB2ZHBhc2ltLT5kZXZfYXR0ci5jb25maWdfc2l6ZSkK
Pj4rCQlyZXR1cm47Cj4+Kwo+PisJaWYgKHZkcGFzaW0tPmRldl9hdHRyLmdldF9jb25maWcpCj4+
KwkJdmRwYXNpbS0+ZGV2X2F0dHIuZ2V0X2NvbmZpZyh2ZHBhc2ltLCB2ZHBhc2ltLT5jb25maWcp
Owo+PisKPj4rCW1lbWNweShidWYsIHZkcGFzaW0tPmNvbmZpZyArIG9mZnNldCwgbGVuKTsKPj4g
IH0KPj4gIHN0YXRpYyB2b2lkIHZkcGFzaW1fc2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4+QEAgLTczOSw2ICs3MzUsMTYgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9iYXRjaF9jb25maWdfb3BzID0g
ewo+PiAgCS5mcmVlICAgICAgICAgICAgICAgICAgID0gdmRwYXNpbV9mcmVlLAo+PiAgfTsKPj4r
c3RhdGljIHZvaWQgdmRwYXNpbV9uZXRfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bSwgdm9pZCAqY29uZmlnKQo+Pit7Cj4+KwlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKm5ldF9j
b25maWcgPQo+PisJCShzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKiljb25maWc7Cj4+Kwo+PisJ
bmV0X2NvbmZpZy0+bXR1ID0gY3B1X3RvX3ZkcGFzaW0xNih2ZHBhc2ltLCAxNTAwKTsKPj4rCW5l
dF9jb25maWctPnN0YXR1cyA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9T
X0xJTktfVVApOwo+PisJbWVtY3B5KG5ldF9jb25maWctPm1hYywgbWFjYWRkcl9idWYsIEVUSF9B
TEVOKTsKPj4rfQo+PisKPj4gIHN0YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fZGV2X2luaXQodm9p
ZCkKPj4gIHsKPj4gIAlzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciBkZXZfYXR0ciA9IHt9Owo+PkBA
IC03NDcsNiArNzUzLDcgQEAgc3RhdGljIGludCBfX2luaXQgdmRwYXNpbV9kZXZfaW5pdCh2b2lk
KQo+PiAgCWRldl9hdHRyLnN1cHBvcnRlZF9mZWF0dXJlcyA9IFZEUEFTSU1fTkVUX0ZFQVRVUkVT
Owo+PiAgCWRldl9hdHRyLm52cXMgPSBWRFBBU0lNX1ZRX05VTTsKPj4gIAlkZXZfYXR0ci5jb25m
aWdfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpOwo+PisJZGV2X2F0dHIu
Z2V0X2NvbmZpZyA9IHZkcGFzaW1fbmV0X2dldF9jb25maWc7Cj4+ICAJZGV2X2F0dHIud29ya19m
biA9IHZkcGFzaW1fbmV0X3dvcms7Cj4+ICAJdmRwYXNpbV9kZXYgPSB2ZHBhc2ltX2NyZWF0ZSgm
ZGV2X2F0dHIpOwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
