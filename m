Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3BBC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 10:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1DD841C2F;
	Wed, 30 Mar 2022 10:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDu4gs-ORLuS; Wed, 30 Mar 2022 10:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18C0441A18;
	Wed, 30 Mar 2022 10:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7C2BC002C;
	Wed, 30 Mar 2022 10:43:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 481F0C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 265EB40CBB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b4nWfXoc8Cya
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:43:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BE6140CB7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648637011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BF3xhFCyLrxCQP5ABQE0ta5feJB/SrzL4G5wThcA57E=;
 b=LdIl4BW2ZYWtSh7iVvGvUTwokcrspFVLgcfEEK21iI67SQcsw4di/IS22EX4sd2fr2gUNd
 J+NVnv0zUmGOll3xsd2+dv34vdOy7bWdqhnCanE98vHyvJSvNkZgPr42l1ahnZ6q1Kd9uW
 YHuj6y823iSPtQjGKznIciotTOUglL8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-GnAsJB8kPPWVDgUi3gC7xg-1; Wed, 30 Mar 2022 06:43:30 -0400
X-MC-Unique: GnAsJB8kPPWVDgUi3gC7xg-1
Received: by mail-oo1-f69.google.com with SMTP id
 g16-20020a4a2510000000b00324173d3201so12796174ooa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BF3xhFCyLrxCQP5ABQE0ta5feJB/SrzL4G5wThcA57E=;
 b=wzbwsSEG/QKySXqFSD+73pVlI8G9XTFHglpSs9ulBtvNfV6QgUkyCG4DZuGzO2tiQv
 1FN0n4Kd8rIiUW2N3JXjc4St9WdRSaGFzw4N0c00USFvnE9N5ATVQdulD9B6ciBhqosj
 dZuCADaTumPz9MYoLac2UvI3pwMqWyuACacK/BFfUKH5r23hrYq5nOvrcxoFczckoX+z
 ifP8JMEA6ahiFaNTAlj6e+307aSWqIOpDjPQF4AHEe6FwyA4Kh6darmbP5QaMjUDiMM5
 igO1gLW2XJdpcb8gamadhAK15GlkWf3wNr4J6WCwASbGFwsTrIrVT91TXGD4AFrnsxjW
 x64Q==
X-Gm-Message-State: AOAM532XFpa85xQaXTtYLVQdtyv/qXnJmFWmRRg0yhZ5kmgw6v7cA7t2
 JTxVfnpMkEMadHSUuur+RaD+n16rWA8w6PMUhv0daM4XiRda0DcFXIaKAx858IQQGoBHYFACh6P
 9PFIGMP1142l5X4YneFrX0gH0J9kM5yrNDLAnNTwHf8g2q72B73IG/dn9oQ==
X-Received: by 2002:a05:6870:1714:b0:dd:a30e:d23e with SMTP id
 h20-20020a056870171400b000dda30ed23emr1742730oae.85.1648637009386; 
 Wed, 30 Mar 2022 03:43:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaEBKXl6GGXGtVuocZYplGp6rtO1QKwBVCHAaEWlTJ5cnjGCD6V7uPD2eiQ9au5HJ6l3QhAGAyP9E6jI3nR6A=
X-Received: by 2002:a05:6870:1714:b0:dd:a30e:d23e with SMTP id
 h20-20020a056870171400b000dda30ed23emr1742723oae.85.1648637009168; Wed, 30
 Mar 2022 03:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <12eba824-ee80-0aac-56ed-e13084c9cae7@amd.com>
 <20220324104928.2959545-1-liucong2@kylinos.cn>
 <982d233d-7e30-f44e-f49d-473c3c41721e@amd.com>
 <a1ceefb7-32d8-9ce3-e56f-7684e6d3ee58@kylinos.cn>
In-Reply-To: <a1ceefb7-32d8-9ce3-e56f-7684e6d3ee58@kylinos.cn>
From: David Airlie <airlied@redhat.com>
Date: Wed, 30 Mar 2022 20:43:18 +1000
Message-ID: <CAMwc25r3ER2Mi4jo2W=VtZcusNhpsyhQ0Mjx+qHhmZAK-fSjZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/qxl: fix qxl can't use in arm64
To: Cong Liu <liucong2@kylinos.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=airlied@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: airlied <airlied@linux.ie>, linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, ray.huang@amd.com, "Vetter,
 Daniel" <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 robin.murphy@arm.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

SSdkIGxpa2UgdG8gbWFrZSBzdXJlIHRoaXMgaGFzIG5vIHNpZGUgZWZmZWN0cyBvbiB4ODYgZ3Vl
c3RzLCBpdApwcm9iYWJseSBpcyBzYWZlLCBidXQga2VlcCBhbiBleWUgZm9yIHJlZ3Jlc3Npb24g
cmVwb3J0cy4KClJldmlld2VkLWJ5OiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpE
YXZlLgoKT24gV2VkLCBNYXIgMzAsIDIwMjIgYXQgODoyMCBQTSBDb25nIExpdSA8bGl1Y29uZzJA
a3lsaW5vcy5jbj4gd3JvdGU6Cj4KPiBhbnkgc3VnZ2VzdGlvbnMgb3IgZXh0cmEgdGVzdCBJIGNh
biBkbyBub3c/Cj4KPiBSZWdhcmRzLAo+IENvbmcKPgo+IE9uIDIwMjIvMy8yNSAxNTo0NSwgQ2hy
aXN0aWFuIEvDtm5pZyB3cm90ZToKPiA+IEFtIDI0LjAzLjIyIHVtIDExOjQ5IHNjaHJpZWIgQ29u
ZyBMaXU6Cj4gPj4gcXhsIHVzZSBpb3JlbWFwIHRvIG1hcCByYW1faGVhZGVyIGFuZCByb20sIGlu
IHRoZSBhcm02NCBpbXBsZW1lbnRhdGlvbiwKPiA+PiB0aGUgZGV2aWNlIGlzIG1hcHBlZCBhcyBE
RVZJQ0VfbkduUkUsIGl0IGNhbiBub3Qgc3VwcG9ydCB1bmFsaWduZWQKPiA+PiBhY2Nlc3MuIGFu
ZCBxeGwgaXMgYSB2aXJ0dWFsIGRldmljZSwgaXQgY2FuIGJlIHRyZWF0ZWQgbW9yZSBsaWtlIFJB
TQo+ID4+IHRoYW4gYWN0dWFsIE1NSU8gcmVnaXN0ZXJzLiB1c2UgaW9yZW1hcF93YygpIHJlcGxh
Y2UgaXQuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDb25nIExpdSA8bGl1Y29uZzJAa3lsaW5v
cy5jbj4KPiA+Cj4gPiBMb29rcyBzYW5lIHRvIG1lLCBidXQgSSdtIHJlYWxseSBub3QgaW52b2x2
ZWQgZW5vdWdoIHRvIGZ1bGx5IGp1ZGdlLgo+ID4KPiA+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPgo+ID4+IC0tLQo+ID4+ICAgZHJpdmVy
cy9ncHUvZHJtL3F4bC9xeGxfa21zLmMgfCA0ICsrLS0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9x
eGwvcXhsX3R0bS5jIHwgNCArKy0tCj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcXhsL3F4bF9rbXMuYwo+ID4+IGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfa21zLmMKPiA+
PiBpbmRleCA0ZGM1YWQxM2YxMmMuLmEwNTRlNGEwMGZlOCAxMDA2NDQKPiA+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYwo+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwv
cXhsX2ttcy5jCj4gPj4gQEAgLTE2NSw3ICsxNjUsNyBAQCBpbnQgcXhsX2RldmljZV9pbml0KHN0
cnVjdCBxeGxfZGV2aWNlICpxZGV2LAo+ID4+ICAgICAgICAgICAgKGludClxZGV2LT5zdXJmYWNl
cmFtX3NpemUgLyAxMDI0LAo+ID4+ICAgICAgICAgICAgKHNiID09IDQpID8gIjY0Yml0IiA6ICIz
MmJpdCIpOwo+ID4+IC0gICAgcWRldi0+cm9tID0gaW9yZW1hcChxZGV2LT5yb21fYmFzZSwgcWRl
di0+cm9tX3NpemUpOwo+ID4+ICsgICAgcWRldi0+cm9tID0gaW9yZW1hcF93YyhxZGV2LT5yb21f
YmFzZSwgcWRldi0+cm9tX3NpemUpOwo+ID4+ICAgICAgIGlmICghcWRldi0+cm9tKSB7Cj4gPj4g
ICAgICAgICAgIHByX2VycigiVW5hYmxlIHRvIGlvcmVtYXAgUk9NXG4iKTsKPiA+PiAgICAgICAg
ICAgciA9IC1FTk9NRU07Cj4gPj4gQEAgLTE4Myw3ICsxODMsNyBAQCBpbnQgcXhsX2RldmljZV9p
bml0KHN0cnVjdCBxeGxfZGV2aWNlICpxZGV2LAo+ID4+ICAgICAgICAgICBnb3RvIHJvbV91bm1h
cDsKPiA+PiAgICAgICB9Cj4gPj4gLSAgICBxZGV2LT5yYW1faGVhZGVyID0gaW9yZW1hcChxZGV2
LT52cmFtX2Jhc2UgKwo+ID4+ICsgICAgcWRldi0+cmFtX2hlYWRlciA9IGlvcmVtYXBfd2MocWRl
di0+dnJhbV9iYXNlICsKPiA+PiAgICAgICAgICAgICAgICAgICAgICBxZGV2LT5yb20tPnJhbV9o
ZWFkZXJfb2Zmc2V0LAo+ID4+ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigqcWRldi0+cmFt
X2hlYWRlcikpOwo+ID4+ICAgICAgIGlmICghcWRldi0+cmFtX2hlYWRlcikgewo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF90dG0uYwo+ID4+IGIvZHJpdmVycy9ncHUv
ZHJtL3F4bC9xeGxfdHRtLmMKPiA+PiBpbmRleCBiMmUzM2Q1YmE1ZDAuLjk1ZGY1NzUwZjQ3ZiAx
MDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF90dG0uYwo+ID4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX3R0bS5jCj4gPj4gQEAgLTgyLDEzICs4MiwxMyBAQCBp
bnQgcXhsX3R0bV9pb19tZW1fcmVzZXJ2ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwKPiA+PiAg
ICAgICBjYXNlIFRUTV9QTF9WUkFNOgo+ID4+ICAgICAgICAgICBtZW0tPmJ1cy5pc19pb21lbSA9
IHRydWU7Cj4gPj4gICAgICAgICAgIG1lbS0+YnVzLm9mZnNldCA9IChtZW0tPnN0YXJ0IDw8IFBB
R0VfU0hJRlQpICsgcWRldi0+dnJhbV9iYXNlOwo+ID4+IC0gICAgICAgIG1lbS0+YnVzLmNhY2hp
bmcgPSB0dG1fY2FjaGVkOwo+ID4+ICsgICAgICAgIG1lbS0+YnVzLmNhY2hpbmcgPSB0dG1fd3Jp
dGVfY29tYmluZWQ7Cj4gPj4gICAgICAgICAgIGJyZWFrOwo+ID4+ICAgICAgIGNhc2UgVFRNX1BM
X1BSSVY6Cj4gPj4gICAgICAgICAgIG1lbS0+YnVzLmlzX2lvbWVtID0gdHJ1ZTsKPiA+PiAgICAg
ICAgICAgbWVtLT5idXMub2Zmc2V0ID0gKG1lbS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKwo+ID4+
ICAgICAgICAgICAgICAgcWRldi0+c3VyZmFjZXJhbV9iYXNlOwo+ID4+IC0gICAgICAgIG1lbS0+
YnVzLmNhY2hpbmcgPSB0dG1fY2FjaGVkOwo+ID4+ICsgICAgICAgIG1lbS0+YnVzLmNhY2hpbmcg
PSB0dG1fd3JpdGVfY29tYmluZWQ7Cj4gPj4gICAgICAgICAgIGJyZWFrOwo+ID4+ICAgICAgIGRl
ZmF1bHQ6Cj4gPj4gICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4KPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
