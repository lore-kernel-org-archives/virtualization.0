Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2403C433F5
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 06:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5787F84E27;
	Fri, 28 Jan 2022 06:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wG01OCgHyffZ; Fri, 28 Jan 2022 06:33:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D156F84E25;
	Fri, 28 Jan 2022 06:33:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C6EC0011;
	Fri, 28 Jan 2022 06:33:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 503E2C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26E3F60B31
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uyibrQZbYCpP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57D3660B20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643351581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTBa8Rxe83S7/zRBXu+VYt7bO/6tlqvapp+sSbPm424=;
 b=QtJe1l9CR6KCbA2QHROahU+GMg1cJ9mcLaaEwZUjGHPkS/UfwIJ+66NxOuYNsLNiUJP8Fy
 3TbX3R303uR3OUr1LJ1XKgPKkgDet3LhDQftU1FQWpP44zP88vpYfwLXlzfSHX91U31Prx
 ivLynr9aT8yjCQr/VHL1sornvwzs59w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-B1SwCnuAMDSWuR5a8Z_IXQ-1; Fri, 28 Jan 2022 01:33:00 -0500
X-MC-Unique: B1SwCnuAMDSWuR5a8Z_IXQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 z12-20020a17090a1fcc00b001b63e477f9fso627362pjz.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 22:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xTBa8Rxe83S7/zRBXu+VYt7bO/6tlqvapp+sSbPm424=;
 b=QDc0q448TbgSKRXLKiXrAa8v7TGg/Nmlzs+jQFFpNgCeURXJScIrevLs8qoLGWQF78
 jRKm4R+Jxd2ApbDZuuqUll5R9bZmJJUtn1vTIYJTJcgR9MQkL7hdoJ1QWSs37zErRMr1
 ocYZRRu7MEcg0TnRAJ0wySZNC+jE0O/xtfV2dwazJ/Ua+/lBcHFWYqoyaGkUwZA32d9E
 WkGEYh2hzJPS510NzlO+zPDUYvpkOX9q6zrWMmpoQqyUeEmQu1lDqecd8/Vvsvwh975s
 OU6u3DKjL/srXF2GffZwMTad4eSDolbg51cUyZq8E9tzvxA4Rac2ycwj1bKEc8quUFl3
 z1/g==
X-Gm-Message-State: AOAM533w4apQM6VXTsnuyTBvcerIa/hXdoQgj3FGURDXWoOVIkJT6uHv
 O6PaBXFLuRTyyEKZuwk6BRILU0Zt2LyhiZwyZR3lXPq0DQIwYzsq4O2l3z+XnIOA7W6plzMiFdE
 WvyHFuOJ0GRpIJzFppnewGpRfRd3ElrtDlo0m1/049A==
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr6966103pfp.55.1643351579035; 
 Thu, 27 Jan 2022 22:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3Og3f6UrdRAE4sr1QlpWNx1A+eBVCL0XpNjIr3KrHEDQCi1uZipitBvrcKHFlQTuhPO1Mbw==
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr6966071pfp.55.1643351578753; 
 Thu, 27 Jan 2022 22:32:58 -0800 (PST)
Received: from [10.72.13.185] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l191sm18969415pga.65.2022.01.27.22.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 22:32:58 -0800 (PST)
Message-ID: <5d51d7c9-7066-e72e-e775-ad3956733779@redhat.com>
Date: Fri, 28 Jan 2022 14:32:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 05/31] vhost: Add Shadow VirtQueue kick forwarding
 capabilities
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121202733.404989-6-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IEF0IHRo
aXMgbW9kZSBubyBidWZmZXIgZm9yd2FyZGluZyB3aWxsIGJlIHBlcmZvcm1lZCBpbiBTVlEgbW9k
ZTogUWVtdQo+IHdpbGwganVzdCBmb3J3YXJkIHRoZSBndWVzdCdzIGtpY2tzIHRvIHRoZSBkZXZp
Y2UuCj4KPiBBbHNvLCBob3N0IG5vdGlmaWVycyBtdXN0IGJlIGRpc2FibGVkIGF0IFNWUSBzdGFy
dCwgYW5kIHRoZXkgd2lsbCBub3QKPiBzdGFydCBpZiBTVlEgaGFzIGJlZW4gZW5hYmxlZCB3aGVu
IHRoZSBkZXZpY2UgaXMgc3RvcHBlZC4gVGhpcyB3aWxsIGJlCj4gYWRkcmVzc2VkIGluIG5leHQg
cGF0Y2hlcy4KCgpXZSBuZWVkIHRvIGRpc2FibGUgaG9zdF9ub3RpZmllcl9tciBhcyB3ZWxsLCBv
dGhlcndpc2UgZ3Vlc3QgbWF5IHRvdWNoIAp0aGUgaGFyZHdhcmUgZG9vcmJlbGwgZGlyZWN0bHkg
d2l0aG91dCBnb2luZyB0aHJvdWdoIGV2ZW50ZmQuCgoKPgo+IFNpZ25lZC1vZmYtYnk6IEV1Z2Vu
aW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaHcvdmlydGlvL3Zob3N0
LXNoYWRvdy12aXJ0cXVldWUuaCB8ICAyICsrCj4gICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZp
cnRxdWV1ZS5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRv
dy12aXJ0cXVldWUuaAo+IGluZGV4IGE1NmVjZmMwOWQuLjRjNTgzYTkxNzEgMTAwNjQ0Cj4gLS0t
IGEvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuaAo+ICsrKyBiL2h3L3ZpcnRpby92
aG9zdC1zaGFkb3ctdmlydHF1ZXVlLmgKPiBAQCAtMTksNiArMTksOCBAQCB2b2lkIHZob3N0X3N2
cV9zZXRfc3ZxX2tpY2tfZmQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IHN2cV9raWNr
X2ZkKTsKPiAgIGNvbnN0IEV2ZW50Tm90aWZpZXIgKnZob3N0X3N2cV9nZXRfZGV2X2tpY2tfbm90
aWZpZXIoCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29uc3QgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSk7Cj4gICAKPiArdm9pZCB2aG9zdF9zdnFf
c3RvcChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKTsKPiArCj4gICBWaG9zdFNoYWRvd1ZpcnRx
dWV1ZSAqdmhvc3Rfc3ZxX25ldyh2b2lkKTsKPiAgIAo+ICAgdm9pZCB2aG9zdF9zdnFfZnJlZShW
aG9zdFNoYWRvd1ZpcnRxdWV1ZSAqdnEpOwo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3Qt
c2hhZG93LXZpcnRxdWV1ZS5jIGIvaHcvdmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+
IGluZGV4IDIxNTM0YmM5NGQuLjg5OTFmMGIzYzMgMTAwNjQ0Cj4gLS0tIGEvaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC1zaGFkb3ctdmly
dHF1ZXVlLmMKPiBAQCAtNDIsMTEgKzQyLDI2IEBAIGNvbnN0IEV2ZW50Tm90aWZpZXIgKnZob3N0
X3N2cV9nZXRfZGV2X2tpY2tfbm90aWZpZXIoCj4gICAgICAgcmV0dXJuICZzdnEtPmhkZXZfa2lj
azsKPiAgIH0KPiAgIAo+ICsvKiBGb3J3YXJkIGd1ZXN0IG5vdGlmaWNhdGlvbnMgKi8KPiArc3Rh
dGljIHZvaWQgdmhvc3RfaGFuZGxlX2d1ZXN0X2tpY2soRXZlbnROb3RpZmllciAqbikKPiArewo+
ICsgICAgVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSA9IGNvbnRhaW5lcl9vZihuLCBWaG9zdFNo
YWRvd1ZpcnRxdWV1ZSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3ZxX2tpY2spOwo+ICsKPiArICAgIGlmICh1bmxpa2VseSghZXZlbnRfbm90aWZpZXJf
dGVzdF9hbmRfY2xlYXIobikpKSB7Cj4gKyAgICAgICAgcmV0dXJuOwo+ICsgICAgfQo+ICsKPiAr
ICAgIGV2ZW50X25vdGlmaWVyX3NldCgmc3ZxLT5oZGV2X2tpY2spOwo+ICt9Cj4gKwo+ICAgLyoq
Cj4gICAgKiBTZXQgYSBuZXcgZmlsZSBkZXNjcmlwdG9yIGZvciB0aGUgZ3Vlc3QgdG8ga2ljayBT
VlEgYW5kIG5vdGlmeSBmb3IgYXZhaWwKPiAgICAqCj4gICAgKiBAc3ZxICAgICAgICAgIFRoZSBz
dnEKPiAtICogQHN2cV9raWNrX2ZkICBUaGUgbmV3IHN2cSBraWNrIGZkCj4gKyAqIEBzdnFfa2lj
a19mZCAgVGhlIHN2cSBraWNrIGZkCj4gKyAqCj4gKyAqIE5vdGUgdGhhdCBTVlEgd2lsbCBuZXZl
ciBjbG9zZSB0aGUgb2xkIGZpbGUgZGVzY3JpcHRvci4KPiAgICAqLwo+ICAgdm9pZCB2aG9zdF9z
dnFfc2V0X3N2cV9raWNrX2ZkKFZob3N0U2hhZG93VmlydHF1ZXVlICpzdnEsIGludCBzdnFfa2lj
a19mZCkKPiAgIHsKPiBAQCAtNjUsMTIgKzgwLDIyIEBAIHZvaWQgdmhvc3Rfc3ZxX3NldF9zdnFf
a2lja19mZChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxLCBpbnQgc3ZxX2tpY2tfZmQpCj4gICAg
ICAgICogbmVlZCB0byBleHBsaWNpdGVseSBjaGVjayBmb3IgdGhlbS4KPiAgICAgICAgKi8KPiAg
ICAgICBldmVudF9ub3RpZmllcl9pbml0X2ZkKCZzdnEtPnN2cV9raWNrLCBzdnFfa2lja19mZCk7
Cj4gKyAgICBldmVudF9ub3RpZmllcl9zZXRfaGFuZGxlcigmc3ZxLT5zdnFfa2ljaywgdmhvc3Rf
aGFuZGxlX2d1ZXN0X2tpY2spOwo+ICAgCj4gICAgICAgaWYgKCFjaGVja19vbGQgfHwgZXZlbnRf
bm90aWZpZXJfdGVzdF9hbmRfY2xlYXIoJnRtcCkpIHsKPiAgICAgICAgICAgZXZlbnRfbm90aWZp
ZXJfc2V0KCZzdnEtPmhkZXZfa2ljayk7Cj4gICAgICAgfQo+ICAgfQo+ICAgCj4gKy8qKgo+ICsg
KiBTdG9wIHNoYWRvdyB2aXJ0cXVldWUgb3BlcmF0aW9uLgo+ICsgKiBAc3ZxIFNoYWRvdyBWaXJ0
cXVldWUKPiArICovCj4gK3ZvaWQgdmhvc3Rfc3ZxX3N0b3AoVmhvc3RTaGFkb3dWaXJ0cXVldWUg
KnN2cSkKPiArewo+ICsgICAgZXZlbnRfbm90aWZpZXJfc2V0X2hhbmRsZXIoJnN2cS0+c3ZxX2tp
Y2ssIE5VTEwpOwo+ICt9CgoKVGhpcyBmdW5jdGlvbiBpcyBub3QgdXNlZCBpbiB0aGUgcGF0Y2gu
CgpUaGFua3MKCgo+ICsKPiAgIC8qKgo+ICAgICogQ3JlYXRlcyB2aG9zdCBzaGFkb3cgdmlydHF1
ZXVlLCBhbmQgaW5zdHJ1Y3Qgdmhvc3QgZGV2aWNlIHRvIHVzZSB0aGUgc2hhZG93Cj4gICAgKiBt
ZXRob2RzIGFuZCBmaWxlIGRlc2NyaXB0b3JzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
