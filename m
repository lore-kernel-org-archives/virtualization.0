Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5706C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 01:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 492DF60BE5;
	Fri,  4 Mar 2022 01:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id URR5qwVai0L6; Fri,  4 Mar 2022 01:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC4FE605D5;
	Fri,  4 Mar 2022 01:40:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE7EC0012;
	Fri,  4 Mar 2022 01:40:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E22FFC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 01:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE14D83E28
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 01:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7WckuLzVZrH
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 01:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAA9381AAD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 01:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646358004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86IVBTs1zO3soES1BSFbPEwpKK67/iP/hzPqZVJT4Mk=;
 b=fFrl0nq1xMk7gzjZLfjPQ5HJKBDkmZDIdo7ol6pCHsAhUOHQ7Sb0TSgib1U0p1fpNUEErk
 F2JxcI/Zbf74Ejv3I7C7LZ8VSe1djbuuGWvcmOSm6gZp2Aq1/KEccLeOnhp+qQzvY/CK4g
 KK0AoGfaj7x5leyLIUps5UW5/C/j+LY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-Pw9sWTlKORicJQCdWX0M5g-1; Thu, 03 Mar 2022 20:40:01 -0500
X-MC-Unique: Pw9sWTlKORicJQCdWX0M5g-1
Received: by mail-lf1-f72.google.com with SMTP id
 e8-20020ac25468000000b00443973fc878so2108406lfn.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 17:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=86IVBTs1zO3soES1BSFbPEwpKK67/iP/hzPqZVJT4Mk=;
 b=MI78iuY3mfe/LdTrOh7/CRk99uniZ3FZG8JRsg0GnwIK1HJXkdp+OIL1KtjZcCABAd
 UQ6s9kwWj2y68aV/exymvmCaF21lK2MBS/i3YXBl+UteHAm1vYQTcAJZTXNEXJ48mFJH
 PNuFAjV3mr8kPvfLlkmUvoK3Ga0iy0h41M2x0kcBelfwBFMoNHdL/7rjF9wEMc5VL+0W
 BqvUh46DehQl6WtXuQhGalj6Qzc+55L2fj++fifTDyqm4dtG6Goyw3m2YLWz4YGB15Lx
 z2Phc+S/lUcvG1DzI+eN//qwdByPhjGESmC1nVkQKTVac0P/i2J28b/EcDtTsm+fBjTO
 ZBlQ==
X-Gm-Message-State: AOAM5330nN6lqM4sPhGrG+5HA0e+rz/zwTliPQAAwiG8QaX37ThCOSD9
 AtAyhx9kbKeeTPi3hv/8sfLMjxcFPPBkw8HroUNs1jTNgFQfHZ+ti86NYT1TLKJhG6kW6vpT6X3
 KcK3oH71DZTlibMC/bATrlyQMEYaNpiRLtRsS9rkW7OHHgH2ef0iFulDaNQ==
X-Received: by 2002:a05:6512:3d08:b0:43f:8f45:d670 with SMTP id
 d8-20020a0565123d0800b0043f8f45d670mr23724323lfv.587.1646357999747; 
 Thu, 03 Mar 2022 17:39:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/N5OkKEFPP69HFp2xd3HmlaSo7u6QlzusAq5p05BGKC4gaDVYtb5D7JVLeLqaoKCNZA2BDOr/nxGahzkjTHE=
X-Received: by 2002:a05:6512:3d08:b0:43f:8f45:d670 with SMTP id
 d8-20020a0565123d0800b0043f8f45d670mr23724315lfv.587.1646357999501; Thu, 03
 Mar 2022 17:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-3-eperezma@redhat.com>
 <40c5bb81-b33a-9a4a-8ce0-20289b13b907@redhat.com>
 <CAJaqyWezcrc=iPLe=Y7+g9oBYfUY9pK8OM4=ZUeRgXqr9ZUWkg@mail.gmail.com>
 <1da7c2b8-ba6e-e9aa-4d55-b1345bd65ba4@redhat.com>
 <CAJaqyWfbkzi19yMAXY7gwCAoj7sakwU_R2hDc1u8+jHPfHLadA@mail.gmail.com>
In-Reply-To: <CAJaqyWfbkzi19yMAXY7gwCAoj7sakwU_R2hDc1u8+jHPfHLadA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 4 Mar 2022 09:39:48 +0800
Message-ID: <CACGkMEvnEhpLT7zc0-w6Cfc7w6zjGi6QgMnWK=BmEcN55N3KnQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] vhost: Add Shadow VirtQueue kick forwarding
 capabilities
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Lingshan <lingshan.zhu@intel.com>
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

T24gVGh1LCBNYXIgMywgMjAyMiBhdCA1OjI1IFBNIEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVy
ZXptYUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgTWFyIDMsIDIwMjIgYXQgODoxMiBB
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4g5Zyo
IDIwMjIvMy8yIOS4iuWNiDI6NDksIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiA+ID4g
T24gTW9uLCBGZWIgMjgsIDIwMjIgYXQgMzo1NyBBTSBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhh
dC5jb20+ICB3cm90ZToKPiA+ID4+IOWcqCAyMDIyLzIvMjcg5LiL5Y2IOTo0MCwgRXVnZW5pbyBQ
w6lyZXog5YaZ6YGTOgo+ID4gPj4+IEF0IHRoaXMgbW9kZSBubyBidWZmZXIgZm9yd2FyZGluZyB3
aWxsIGJlIHBlcmZvcm1lZCBpbiBTVlEgbW9kZTogUWVtdQo+ID4gPj4+IHdpbGwganVzdCBmb3J3
YXJkIHRoZSBndWVzdCdzIGtpY2tzIHRvIHRoZSBkZXZpY2UuCj4gPiA+Pj4KPiA+ID4+PiBIb3N0
IG1lbW9yeSBub3RpZmllcnMgcmVnaW9ucyBhcmUgbGVmdCBvdXQgZm9yIHNpbXBsaWNpdHksIGFu
ZCB0aGV5IHdpbGwKPiA+ID4+PiBub3QgYmUgYWRkcmVzc2VkIGluIHRoaXMgc2VyaWVzLgo+ID4g
Pj4+Cj4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXo8ZXBlcmV6bWFAcmVkaGF0
LmNvbT4KPiA+ID4+PiAtLS0KPiA+ID4+PiAgICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRx
dWV1ZS5oIHwgIDE0ICsrKwo+ID4gPj4+ICAgIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEu
aCAgICAgfCAgIDQgKwo+ID4gPj4+ICAgIGh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVl
LmMgfCAgNTIgKysrKysrKysrKysKPiA+ID4+PiAgICBody92aXJ0aW8vdmhvc3QtdmRwYS5jICAg
ICAgICAgICAgIHwgMTQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gPiA+Pj4gICAg
NCBmaWxlcyBjaGFuZ2VkLCAyMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4+
Pgo+ID4gPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5o
IGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ID4gPj4+IGluZGV4IGYxNTE5
ZTNjN2IuLjFjYmM4N2Q1ZDggMTAwNjQ0Cj4gPiA+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXNo
YWRvdy12aXJ0cXVldWUuaAo+ID4gPj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmgKPiA+ID4+PiBAQCAtMTgsOCArMTgsMjIgQEAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RT
aGFkb3dWaXJ0cXVldWUgewo+ID4gPj4+ICAgICAgICBFdmVudE5vdGlmaWVyIGhkZXZfa2ljazsK
PiA+ID4+PiAgICAgICAgLyogU2hhZG93IGNhbGwgbm90aWZpZXIsIHNlbnQgdG8gdmhvc3QgKi8K
PiA+ID4+PiAgICAgICAgRXZlbnROb3RpZmllciBoZGV2X2NhbGw7Cj4gPiA+Pj4gKwo+ID4gPj4+
ICsgICAgLyoKPiA+ID4+PiArICAgICAqIEJvcnJvd2VkIHZpcnRxdWV1ZSdzIGd1ZXN0IHRvIGhv
c3Qgbm90aWZpZXIuIFRvIGJvcnJvdyBpdCBpbiB0aGlzIGV2ZW50Cj4gPiA+Pj4gKyAgICAgKiBu
b3RpZmllciBhbGxvd3MgdG8gcmVjb3ZlciB0aGUgVmhvc3RTaGFkb3dWaXJ0cXVldWUgZnJvbSB0
aGUgZXZlbnQgbG9vcAo+ID4gPj4+ICsgICAgICogZWFzaWx5LiBJZiB3ZSB1c2UgdGhlIFZpcnRR
dWV1ZSdzIG9uZSwgd2UgZG9uJ3QgaGF2ZSBhbiBlYXN5IHdheSB0bwo+ID4gPj4+ICsgICAgICog
cmV0cmlldmUgVmhvc3RTaGFkb3dWaXJ0cXVldWUuCj4gPiA+Pj4gKyAgICAgKgo+ID4gPj4+ICsg
ICAgICogU28gc2hhZG93IHZpcnRxdWV1ZSBtdXN0IG5vdCBjbGVhbiBpdCwgb3Igd2Ugd291bGQg
bG9zZSBWaXJ0UXVldWUgb25lLgo+ID4gPj4+ICsgICAgICovCj4gPiA+Pj4gKyAgICBFdmVudE5v
dGlmaWVyIHN2cV9raWNrOwo+ID4gPj4+ICAgIH0gVmhvc3RTaGFkb3dWaXJ0cXVldWU7Cj4gPiA+
Pj4KPiA+ID4+PiArdm9pZCB2aG9zdF9zdnFfc2V0X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93Vmly
dHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCk7Cj4gPiA+Pj4gKwo+ID4gPj4+ICt2b2lkIHZo
b3N0X3N2cV9zdG9wKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEpOwo+ID4gPj4+ICsKPiA+ID4+
PiAgICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdmhvc3Rfc3ZxX25ldyh2b2lkKTsKPiA+ID4+Pgo+
ID4gPj4+ICAgIHZvaWQgdmhvc3Rfc3ZxX2ZyZWUoZ3BvaW50ZXIgdnEpOwo+ID4gPj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmggYi9pbmNsdWRlL2h3L3ZpcnRp
by92aG9zdC12ZHBhLmgKPiA+ID4+PiBpbmRleCAzY2U3OWE2NDZkLi4wMDlhOWYzYjZiIDEwMDY0
NAo+ID4gPj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+ID4gPj4+ICsr
KyBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LXZkcGEuaAo+ID4gPj4+IEBAIC0xMiw2ICsxMiw4
IEBACj4gPiA+Pj4gICAgI2lmbmRlZiBIV19WSVJUSU9fVkhPU1RfVkRQQV9ICj4gPiA+Pj4gICAg
I2RlZmluZSBIV19WSVJUSU9fVkhPU1RfVkRQQV9ICj4gPiA+Pj4KPiA+ID4+PiArI2luY2x1ZGUg
PGdtb2R1bGUuaD4KPiA+ID4+PiArCj4gPiA+Pj4gICAgI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0
aW8uaCIKPiA+ID4+PiAgICAjaW5jbHVkZSAic3RhbmRhcmQtaGVhZGVycy9saW51eC92aG9zdF90
eXBlcy5oIgo+ID4gPj4+Cj4gPiA+Pj4gQEAgLTI3LDYgKzI5LDggQEAgdHlwZWRlZiBzdHJ1Y3Qg
dmhvc3RfdmRwYSB7Cj4gPiA+Pj4gICAgICAgIGJvb2wgaW90bGJfYmF0Y2hfYmVnaW5fc2VudDsK
PiA+ID4+PiAgICAgICAgTWVtb3J5TGlzdGVuZXIgbGlzdGVuZXI7Cj4gPiA+Pj4gICAgICAgIHN0
cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgaW92YV9yYW5nZTsKPiA+ID4+PiArICAgIGJvb2wg
c2hhZG93X3Zxc19lbmFibGVkOwo+ID4gPj4+ICsgICAgR1B0ckFycmF5ICpzaGFkb3dfdnFzOwo+
ID4gPj4+ICAgICAgICBzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXY7Cj4gPiA+Pj4gICAgICAgIFZob3N0
VkRQQUhvc3ROb3RpZmllciBub3RpZmllcltWSVJUSU9fUVVFVUVfTUFYXTsKPiA+ID4+PiAgICB9
IFZob3N0VkRQQTsKPiA+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12
aXJ0cXVldWUuYyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiA+ID4+PiBp
bmRleCAwMTljZjE5NTBmLi5hNWQwNjU5Zjg2IDEwMDY0NAo+ID4gPj4+IC0tLSBhL2h3L3ZpcnRp
by92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmMKPiA+ID4+PiArKysgYi9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5jCj4gPiA+Pj4gQEAgLTExLDYgKzExLDU2IEBACj4gPiA+Pj4gICAg
I2luY2x1ZGUgImh3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgiCj4gPiA+Pj4KPiA+
ID4+PiAgICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCIKPiA+ID4+PiArI2luY2x1ZGUg
InFlbXUvbWFpbi1sb29wLmgiCj4gPiA+Pj4gKyNpbmNsdWRlICJsaW51eC1oZWFkZXJzL2xpbnV4
L3Zob3N0LmgiCj4gPiA+Pj4gKwo+ID4gPj4+ICsvKiogRm9yd2FyZCBndWVzdCBub3RpZmljYXRp
b25zICovCj4gPiA+Pj4gK3N0YXRpYyB2b2lkIHZob3N0X2hhbmRsZV9ndWVzdF9raWNrKEV2ZW50
Tm90aWZpZXIgKm4pCj4gPiA+Pj4gK3sKPiA+ID4+PiArICAgIFZob3N0U2hhZG93VmlydHF1ZXVl
ICpzdnEgPSBjb250YWluZXJfb2YobiwgVmhvc3RTaGFkb3dWaXJ0cXVldWUsCj4gPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2cV9raWNrKTsKPiA+
ID4+PiArICAgIGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFyKG4pOwo+ID4gPj4+ICsgICAg
ZXZlbnRfbm90aWZpZXJfc2V0KCZzdnEtPmhkZXZfa2ljayk7Cj4gPiA+Pj4gK30KPiA+ID4+PiAr
Cj4gPiA+Pj4gKy8qKgo+ID4gPj4+ICsgKiBTZXQgYSBuZXcgZmlsZSBkZXNjcmlwdG9yIGZvciB0
aGUgZ3Vlc3QgdG8ga2ljayB0aGUgU1ZRIGFuZCBub3RpZnkgZm9yIGF2YWlsCj4gPiA+Pj4gKyAq
Cj4gPiA+Pj4gKyAqIEBzdnEgICAgICAgICAgVGhlIHN2cQo+ID4gPj4+ICsgKiBAc3ZxX2tpY2tf
ZmQgIFRoZSBzdnEga2ljayBmZAo+ID4gPj4+ICsgKgo+ID4gPj4+ICsgKiBOb3RlIHRoYXQgdGhl
IFNWUSB3aWxsIG5ldmVyIGNsb3NlIHRoZSBvbGQgZmlsZSBkZXNjcmlwdG9yLgo+ID4gPj4+ICsg
Ki8KPiA+ID4+PiArdm9pZCB2aG9zdF9zdnFfc2V0X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93Vmly
dHF1ZXVlICpzdnEsIGludCBzdnFfa2lja19mZCkKPiA+ID4+PiArewo+ID4gPj4+ICsgICAgRXZl
bnROb3RpZmllciAqc3ZxX2tpY2sgPSAmc3ZxLT5zdnFfa2ljazsKPiA+ID4+PiArICAgIGJvb2wg
cG9sbF9zdG9wID0gVkhPU1RfRklMRV9VTkJJTkQgIT0gZXZlbnRfbm90aWZpZXJfZ2V0X2ZkKHN2
cV9raWNrKTsKPiA+ID4+IEkgd29uZGVyIGlmIHRoaXMgaXMgcm9idXN0LiBFLmcgaXMgdGhlcmUg
YW55IGNoYW5jZSB0aGF0IG1heSBlbmQgdXAgd2l0aAo+ID4gPj4gYm90aCBwb2xsX3N0b3AgYW5k
IHBvbGxfc3RhcnQgYXJlIGZhbHNlPwo+ID4gPj4KPiA+ID4gSSBjYW5ub3QgbWFrZSB0aGF0IGhh
cHBlbiBpbiBxZW11LCBidXQgdGhlIGZ1bmN0aW9uIHN1cHBvcnRzIHRoYXQgY2FzZQo+ID4gPiB3
ZWxsOiBJdCB3aWxsIGRvIG5vdGhpbmcuIEl0J3MgbW9yZSBvciBsZXNzIHRoZSBzYW1lIGNvZGUg
YXMgdXNlZCBpbgo+ID4gPiB0aGUgdmhvc3Qga2VybmVsLCBhbmQgaXMgdGhlIGV4cGVjdGVkIGJl
aGF2aW91ciBpZiB5b3Ugc2VuZCB0d28KPiA+ID4gVkhPU1RfRklMRV9VTkJJTkQgb25lIHJpZ2h0
IGFmdGVyIGFub3RoZXIgdG8gbWUuCj4gPgo+ID4KPiA+IEkgd291bGQgdGhpbmsgaXQncyBqdXN0
IHN0b3AgdHdpY2UuCj4gPgo+ID4KPiA+ID4KPiA+ID4+IElmIG5vdCwgY2FuIHdlIHNpbXBsZSBk
ZXRlY3QgcG9sbF9zdG9wIGFzIGJlbG93IGFuZCB0cmVhdCAhcG9sbF9zdGFydAo+ID4gPj4gYW5k
IHBvbGxfc3RvcD8KPiA+ID4+Cj4gPiA+IEknbSBub3Qgc3VyZSB3aGF0IGRvZXMgaXQgYWRkLiBJ
cyB0aGVyZSBhbiB1bmV4cGVjdGVkIGNvbnNlcXVlbmNlIHdpdGgKPiA+ID4gdGhlIGN1cnJlbnQg
ZG8tbm90aGluZyBiZWhhdmlvciBJJ3ZlIG1pc3NlZD8KPiA+Cj4gPgo+ID4gSSdtIG5vdCBzdXJl
LCBidXQgaXQgZmVlbHMgb2RkIGlmIHBvbGxfc3RhcnQgaXMgbm90IHRoZSByZXZlcnNlIHZhbHVl
IG9mCj4gPiBwb2xsX3N0b3AuCj4gPgo+Cj4gSWYgd2Ugd2FudCB0byBub3QgdG8gcmVzdHJpY3Qg
dGhlIGlucHV0cywgd2UgbmVlZCB0byBoYW5kbGUgZm9yIHNpdHVhdGlvbnM6Cj4KPiBhKSBvbGRf
ZmQgPSAtMSwgbmV3X2ZkID0gLTEsCj4KPiBUaGlzIGlzIHRoZSBzaXR1YXRpb24geW91IGRlc2Ny
aWJlZCwgYW5kIGl0J3MgYmFzaWNhbGx5IGEgbm8tb3AuCj4gcG9sbF9zdG9wID09IHBvbGxfc3Rh
cnQgPT0gZmFsc2UuCj4KPiBJZiB3ZSBtYWtlIHBvbGxfc3RvcCA9IHRydWUgYW5kIHBvbGxfc3Rv
cCA9IGZhbHNlLCB3ZSBjYWxsCj4gZXZlbnRfbm90aWZpZXJfc2V0X2hhbmRsZXIoLTEsIC4uLiku
IEhvcGVmdWxseSBpdCB3aWxsIHJldHVybiBqdXN0IGFuCj4gZXJyb3IuCj4KPiBJZiB3ZSBtYWtl
IHBvbGxfc3RvcCA9IGZhbHNlIGFuZCBwb2xsX3N0b3AgPSB0cnVlLCB3ZSBhcmUgY2FsbGluZwo+
IGV2ZW50X25vdGlmaWVyX3NldCgtMSkgYW5kIGV2ZW50X25vdGlmaWVyX3NldF9oYW5kbGVyKC0x
LAo+IHBvbGxfY2FsbGJhY2spLiBTYW1lIHNpdHVhdGlvbiwgaG9wZWZ1bGx5IGFuIGVycm9yLCBi
dXQgdW5leHBlY3RlZC4KPgo+IGIpIG9sZF9mZCA9IC0xLCBuZXdfZmQgPSA+LTEsCj4KPiBXZSBu
ZWVkIHRvIHN0YXJ0IHBvbGxpbmcgdGhlIG5ld19mZC4gTm8gbmVlZCBmb3Igc3RvcCBwb2xsaW5n
IHRoZQo+IG9sZF9mZCwgc2luY2Ugd2UgYXJlIG5vdCBwb2xsaW5nIGl0IGFjdHVhbGx5Lgo+Cj4g
Yykgb2xkX2ZkID0gPi0xLCBuZXdfZmQgPSA+LTEsCj4KPiBXZSBuZWVkIHRvIHN0b3AgcG9sbGlu
ZyB0aGUgb2xkX2ZkIGFuZCBzdGFydCBwb2xsaW5nIHRoZSBuZXcgb25lLgo+Cj4gSWYgd2UgbWFr
ZSBwb2xsX3N0b3AgPSB0cnVlIGFuZCBwb2xsX3N0b3AgPSBmYWxzZSwgd2UgZG9uJ3QgcmVnaXN0
ZXIgYQo+IG5ldyBwb2xsaW5nIGZ1bmN0aW9uIGZvciB0aGUgbmV3IGtpY2tfZmQgc28gd2Ugd2ls
bCBtaXNzIGd1ZXN0J3MKPiBraWNrcy4KPgo+IElmIHdlIG1ha2UgcG9sbF9zdG9wID0gZmFsc2Ug
YW5kIHBvbGxfc3RvcCA9IHRydWUsIHdlIGtlZXAgcG9sbGluZyB0aGUKPiBvbGQgZmlsZSBkZXNj
cmlwdG9yIHRvbywgc28gd2hhdGV2ZXIgaXQgZ2V0cyBhc3NpZ25lZCB0byBjb3VsZCBjYWxsCj4g
dmhvc3RfaGFuZGxlX2d1ZXN0X2tpY2sgaWYgaXQgZG9lcyBub3Qgb3ZlcnJpZGUgcG9sbCBjYWxs
YmFjay4KPgo+IFdlICpjb3VsZCogZGV0ZWN0IGlmIG9sZF9mZCA9PSBuZXdfZmQgc28gd2Ugc2tp
cCBhbGwgdGhlIHdvcmssIGJ1dCBJCj4gdGhpbmsgaXQgaXMgbm90IHdvcnRoIGl0IHRvIGNvbXBs
aWNhdGUgdGhlIGNvZGUsIHNpbmNlIHdlJ3JlIG9ubHkKPiBiZWluZyBjYWxsZWQgd2l0aCB0aGUg
a2lja19mZCBhdCBkZXYgc3RhcnQuCj4KPiBkKSBjKSBvbGRfZmQgPSA+LTEsIG5ld19mZCA9IC0x
LAo+Cj4gV2UgbmVlZCB0byBzdG9wIHBvbGxpbmcsIG9yIHdlIGNvdWxkIGdldCBpbnZhbGlkIGtp
Y2tzIGNhbGxiYWNrcyBpZiBpdAo+IGdldHMgd3JpdGVkIGFmdGVyIHRoaXMuIE5vIG5lZWQgdG8g
cG9sbCBhbnl0aGluZyBiZXlvbmQgdGhpcy4KCkkgc2VlLCB0aGFua3MgZm9yIHRoZSBjbGFyaWZp
Y2F0aW9uLgoKPgo+ID4gVGhhbmtzCj4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
