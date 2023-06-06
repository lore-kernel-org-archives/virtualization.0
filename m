Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B449C77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 02:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E2804151D;
	Tue,  6 Jun 2023 02:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E2804151D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AqC64Yn/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7Vs9cdIY4K5; Tue,  6 Jun 2023 02:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBA3140227;
	Tue,  6 Jun 2023 02:03:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBA3140227
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95FE6C007A;
	Tue,  6 Jun 2023 02:03:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 360E7C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FDB240463
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FDB240463
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G52PmG_NrRq4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4987140227
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4987140227
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686017013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1Ccl3e5U8u2+piXpey/hOv34+n9CVP0Hq28UZVhm38=;
 b=AqC64Yn/VqE3AHsOWRHsSY2m1lk5cSQn84lPHeLlnVy3o9WES//JMzRgabmOoiHEtv5JDh
 zyRKUgUYbBmsPc5N3Gyd0ryKDxRu/7ZwzAQgb8Bv06m0jAnhLzhxbWu0OkScFaJcvn3pSn
 U9hz9gkqAfmAhN2orS96Swx+c7ebVf0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-bTh4ESbVP02HQRBYmQWZ-w-1; Mon, 05 Jun 2023 22:03:31 -0400
X-MC-Unique: bTh4ESbVP02HQRBYmQWZ-w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f517b5309cso4480117e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 19:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686017010; x=1688609010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1Ccl3e5U8u2+piXpey/hOv34+n9CVP0Hq28UZVhm38=;
 b=DKJDLGpds+rHhxUAl7sF3ebyCKuBy6NDgzXS7XfjkUtrxcQjKI+nJI2dQz/WsC8h6b
 RSo0qEFq3CgQCMMia7nsxtMf+B+OnRtSgzwk6kkvrArh6jZ8poMEMJMHz+OxYacvrIze
 OOXvNImXmWAhC+OkQ6ij9Z3lJ61cRnZMWgZFXYBAsYEOgtk30gt/e+cFTNPbVyRgVvB/
 yow1/P9e+CSMeW5lLsrRDw+dTyYRpKOi1JzWd/jMjSGWQdjEdAsLFTvSNZnOEqF68lDp
 fEeloO24KyO/IetooaLNhzseajPBL6FO6+LdTA7G8J37GLn6raUEj9dl7YbtsezEuxcZ
 E6mg==
X-Gm-Message-State: AC+VfDwGppM1Biqjbu1XFC/wTLf04gEqjuuD1+bydyJY91mC62CfiWn8
 TlaFAyeUiK92mFMl5QdTFeyfpVhvBuBtA46Cmx8+RoRX5d5KXKVzGSMeq43hiHJMGBmK1CtQPjY
 wSNvFJibunJ2yliPh+bIvAFIGrR2y/rHn7iGt7Ho6qPgAW8Rd7x5ZT4DYYA==
X-Received: by 2002:a19:700a:0:b0:4f6:140e:c9bf with SMTP id
 h10-20020a19700a000000b004f6140ec9bfmr364857lfc.22.1686017010560; 
 Mon, 05 Jun 2023 19:03:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tUXEvqHcY5X0N1auu65CSDbYsRfvVM8LVgBQkpZ8dI8mxtplO6IPvFP1wcP1ZT7NJpRubNU9Fxph4bbAotkg=
X-Received: by 2002:a19:700a:0:b0:4f6:140e:c9bf with SMTP id
 h10-20020a19700a000000b004f6140ec9bfmr364846lfc.22.1686017010284; Mon, 05 Jun
 2023 19:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230605210237.60988-1-brett.creeley@amd.com>
 <1686016374.4953902-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1686016374.4953902-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jun 2023 10:03:19 +0800
Message-ID: <CACGkMEuCGPWJVG0knTnG-1YxbACZLXLTrFMqt=eKiV-K_B_8FA@mail.gmail.com>
Subject: Re: [RFC PATCH net] virtio_net: Prevent napi_weight changes with
 VIRTIO_NET_F_NOTF_COAL support
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Brett Creeley <brett.creeley@amd.com>, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCA5OjU34oCvQU0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIDUgSnVuIDIwMjMgMTQ6MDI6MzYgLTA3
MDAsIEJyZXR0IENyZWVsZXkgPGJyZXR0LmNyZWVsZXlAYW1kLmNvbT4gd3JvdGU6Cj4gPiBDb21t
aXQgNjk5YjA0NWE4ZTQzICgibmV0OiB2aXJ0aW9fbmV0OiBub3RpZmljYXRpb25zIGNvYWxlc2Np
bmcKPiA+IHN1cHBvcnQiKSBhZGRlZCBzdXBwb3J0IGZvciBWSVJUSU9fTkVUX0ZfTk9URl9DT0FM
LiBUaGUgZ2V0X2NvYWxlc2NlCj4gPiBjYWxsIG1hZGUgY2hhbmdlcyB0byByZXBvcnQgIjEiIGlu
IHR4X21heF9jb2FsZXNjZWRfZnJhbWVzIGlmCj4gPiBWSVJUSU9fTkVUX0ZfTk9URl9DT0FMIGlz
IG5vdCBzdXBwb3J0ZWQgYW5kIG5hcGkud2VpZ2h0IGlzIG5vbi16ZXJvLgo+ID4gSG93ZXZlciwg
dGhlIG5hcGlfd2VpZ2h0IHZhbHVlIGNvdWxkIHN0aWxsIGJlIGNoYW5nZWQgYnkgdGhlCj4gPiBz
ZXRfY29hbGVzY2UgY2FsbCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgb3Igbm90IHRoZSBkZXZpY2Ug
c3VwcG9ydHMKPiA+IFZJUlRJT19ORVRfRl9OT1RGX0NPQUwuCj4gPgo+ID4gSXQgc2VlbXMgbGlr
ZSB0aGUgdHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgdmFsdWUgc2hvdWxkIG5vdCBjb250cm9sIG1v
cmUKPiA+IHRoYW4gMSB0aGluZyAoaS5lLiBuYXBpX3dlaWdodCBhbmQgdGhlIGRldmljZSdzIHR4
X21heF9wYWNrZXRzKS4gU28sIGZpeAo+ID4gdGhpcyBieSBvbmx5IGFsbG93aW5nIHRoZSBuYXBp
X3dlaWdodCBjaGFuZ2UgaWYgVklSVElPX05FVF9GX05PVEZfQ09BTAo+ID4gaXMgbm90IHN1cHBv
cnRlZCBieSB0aGUgdmlydGlvIGRldmljZS4KPgo+Cj4gQEphc29uIEkgd29uZGVyIHNob3VsZCB3
ZSBrZWVwIHRoaXMgZnVuY3Rpb24gdG8gY2hhbmdlIHRoZSBuYXBpIHdlaWdodCBieSB0aGUKPiBj
b2FsZXNlYyBjb21tYW5kLgoKSSB0aGluayBzbywgZXhwbGFpbmVkIGluIGFub3RoZXIgdGhyZWFk
LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gSXQgd2Fzbid0IGNsZWFyIHRvIG1lIGlm
IHRoaXMgd2FzIHRoZSBpbnRlbmRlZCBiZWhhdmlvciwgc28gdGhhdCdzIHdoeQo+ID4gSSdtIHNl
bmRpbmcgdGhpcyBhcyBhbiBSRkMgcGF0Y2ggaW5pdGlhbGx5LiBCYXNlZCBvbiB0aGUgZmVlZGJh
Y2ssIEkKPiA+IHdpbGwgcmVzdWJtaXQgYXMgYW4gb2ZmaWNpYWwgcGF0Y2guCj4gPgo+ID4gRml4
ZXM6IDY5OWIwNDVhOGU0MyAoIm5ldDogdmlydGlvX25ldDogbm90aWZpY2F0aW9ucyBjb2FsZXNj
aW5nIHN1cHBvcnQiKQo+ID4gU2lnbmVkLW9mZi1ieTogQnJldHQgQ3JlZWxleSA8YnJldHQuY3Jl
ZWxleUBhbWQuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjQg
KysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDQ4NmI1ODQ5
MDMzZC4uZTI4Mzg3ODY2OTA5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC0yOTkwLDE5ICsy
OTkwLDIxIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9zZXRfY29hbGVzY2Uoc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiwKPiA+ICAgICAgIGludCByZXQsIGksIG5hcGlfd2VpZ2h0Owo+ID4gICAgICAgYm9v
bCB1cGRhdGVfbmFwaSA9IGZhbHNlOwo+ID4KPiA+IC0gICAgIC8qIENhbid0IGNoYW5nZSBOQVBJ
IHdlaWdodCBpZiB0aGUgbGluayBpcyB1cCAqLwo+ID4gLSAgICAgbmFwaV93ZWlnaHQgPSBlYy0+
dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPyBOQVBJX1BPTExfV0VJR0hUIDogMDsKPiA+IC0gICAg
IGlmIChuYXBpX3dlaWdodCBeIHZpLT5zcVswXS5uYXBpLndlaWdodCkgewo+ID4gLSAgICAgICAg
ICAgICBpZiAoZGV2LT5mbGFncyAmIElGRl9VUCkKPiA+IC0gICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVCVVNZOwo+ID4gLSAgICAgICAgICAgICBlbHNlCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgdXBkYXRlX25hcGkgPSB0cnVlOwo+ID4gLSAgICAgfQo+ID4gLQo+ID4gLSAgICAgaWYg
KHZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9GX05PVEZfQ09BTCkpCj4g
PiArICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfTk9U
Rl9DT0FMKSkgewo+ID4gICAgICAgICAgICAgICByZXQgPSB2aXJ0bmV0X3NlbmRfbm90Zl9jb2Fs
X2NtZHModmksIGVjKTsKPiA+IC0gICAgIGVsc2UKPiA+ICsgICAgIH0gZWxzZSB7Cj4gPiArICAg
ICAgICAgICAgIC8qIENhbid0IGNoYW5nZSBOQVBJIHdlaWdodCBpZiB0aGUgbGluayBpcyB1cCAq
Lwo+ID4gKyAgICAgICAgICAgICBuYXBpX3dlaWdodCA9IGVjLT50eF9tYXhfY29hbGVzY2VkX2Zy
YW1lcyA/Cj4gPiArICAgICAgICAgICAgICAgICAgICAgTkFQSV9QT0xMX1dFSUdIVCA6IDA7Cj4g
PiArICAgICAgICAgICAgIGlmIChuYXBpX3dlaWdodCBeIHZpLT5zcVswXS5uYXBpLndlaWdodCkg
ewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChkZXYtPmZsYWdzICYgSUZGX1VQKQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBlbHNlCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1cGRh
dGVfbmFwaSA9IHRydWU7Cj4gPiArICAgICAgICAgICAgIH0KPiA+ICsKPiA+ICAgICAgICAgICAg
ICAgcmV0ID0gdmlydG5ldF9jb2FsX3BhcmFtc19zdXBwb3J0ZWQoZWMpOwo+ID4gKyAgICAgfQo+
ID4KPiA+ICAgICAgIGlmIChyZXQpCj4gPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gPiAt
LQo+ID4gMi4xNy4xCj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
