Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B4CCE7A91
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 03:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 967AB4177C;
	Tue, 26 Sep 2023 03:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 967AB4177C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJj32r9w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQKHYWMZ1Q_P; Tue, 26 Sep 2023 03:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1EF9541779;
	Tue, 26 Sep 2023 03:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EF9541779
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07DF7C0039;
	Tue, 26 Sep 2023 03:34:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46C8BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FC1A41740
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FC1A41740
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJj32r9w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pb059eAtlYzl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 315EB41701
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 315EB41701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695699240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VemcH0Pxc7gzhy8cLvwCxUH2+uz/mp+txw8hIJIiBPM=;
 b=IJj32r9wU3CCU8E+GIZ9uT6BBbnh1rkqi6MpvSEbhGrqCMpt7Toee/PaxsuNI+9R81tSpB
 bWPsjqJkDbGzWs1F78QIhkO9Tq1LdR+4I7EdeG+ImNZVvaVRU1im1VVOGpvGmyapoobR8U
 SyKjhljrfVL2dSL5nZad1bnj3HcAFoU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-bzOqA4cyPFid2uiuRzEU_w-1; Mon, 25 Sep 2023 23:33:58 -0400
X-MC-Unique: bzOqA4cyPFid2uiuRzEU_w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so9678561e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 20:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695699237; x=1696304037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VemcH0Pxc7gzhy8cLvwCxUH2+uz/mp+txw8hIJIiBPM=;
 b=ohb8oElFJ5axMYGYPnK5ZXUKD5FsUEhHfP1aaoYzrMsQb9BvBpivZp0mM89goyvxl5
 /HFvoCuS7qfs1VFvgLse3wCWv4KxS18y6ATn0tZwwVjB2E2/hHT8VOqHzgS6xfkd/UYS
 Kaux6LAYGqhbayBKy6UQgk2pmySzEkNQ/1WwY+pQzHNood1vSfCvjZevixFB1H6/KSqT
 S9U5/dulAqB7QSMV0tnFEV1XLqDTC2CqoIVMD8GrVpqFBegMBGANOJPNUqfch+DLdXaJ
 Oe+dvafDEQTcj+eUDkzzNQg9HbMjulAVdBhdG+4lIJvqAq71I+oMBy2UdMUbAhhmX8z8
 HMJQ==
X-Gm-Message-State: AOJu0Yx0ezMDcvgBu0xIJsBdNTg0oJT0FmQFuRxun5q3BHPVtrxrhBEr
 +B65OTBUIfVz5LJREqpkfwrD1OQf8QxDnvg+YEjdi5r/jJPBdYJ/jjlVrL7CP1vdNgd3rUQ2xad
 2BKbxzgd4vKKOOmf6Jd1N4aqtQZLs7wqXlrtW/WPqKhBG6kIljaksbKH30Q==
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8636663lfv.52.1695699236797; 
 Mon, 25 Sep 2023 20:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKxKhnIjCY2u75vQcX2wF3cjPA5sZgxKb74ILugVtiuipD5V5dNcKckwfV7TbxCYM65s77akemf8UqWtEbv3E=
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8636648lfv.52.1695699236445; Mon, 25
 Sep 2023 20:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-8-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-8-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 11:33:45 +0800
Message-ID: <CACGkMEuC+TrrZ-=63XpFySzcvHYD+0YyJxF9ckx7ZSJqSS0JOw@mail.gmail.com>
Subject: Re: [PATCH 07/16] vdpa/mlx5: Collapse "dvq" mr add/delete functions
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgOTowMuKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IE5vdyB0aGF0IHRoZSBjdnEgY29kZSBpcyBvdXQgb2Yg
bWx4NV92ZHBhX2NyZWF0ZS9kZXN0cm95X21yLCB0aGUgImR2cSIKPiBmdW5jdGlvbnMgY2FuIGJl
IGZvbGRlZCBpbnRvIHRoZWlyIGNhbGxlcnMuCj4KPiBIYXZpbmcgImR2cSIgaW4gdGhlIG5hbWlu
ZyB3aWxsIG5vIGxvbmdlciBiZSBhY2N1cmF0ZSBpbiB0aGUgZG93bnN0cmVhbQo+IHBhdGNoZXMu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4K
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0t
LQo+ICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgfCAxNiArKysrKy0tLS0tLS0tLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuYwo+IGluZGV4IDU4NzMwMGU3YzE4ZS4uZmRlMDA0OTdmNGFkIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuYwo+IEBAIC00ODksNyArNDg5LDcgQEAgc3RhdGljIHZvaWQgZGVzdHJveV91c2Vy
X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9tciAqbXIK
PiAgICAgICAgIH0KPiAgfQo+Cj4gLXN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFf
bXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPiArc3Rh
dGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwgdW5zaWduZWQgaW50IGFzaWQpCj4gIHsKPiAgICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfbXIg
Km1yID0gJm12ZGV2LT5tcjsKPgo+IEBAIC01MTMsNyArNTEzLDcgQEAgdm9pZCBtbHg1X3ZkcGFf
ZGVzdHJveV9tcl9hc2lkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50
IGFzaWQpCj4KPiAgICAgICAgIG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4KPiAtICAgICAg
IF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+ICsgICAgICAgX21seDVf
dmRwYV9kZXN0cm95X21yKG12ZGV2LCBhc2lkKTsKPgo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZt
ci0+bWtleV9tdHgpOwo+ICB9Cj4gQEAgLTUyNCw5ICs1MjQsOSBAQCB2b2lkIG1seDVfdmRwYV9k
ZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiAgICAgICAgIHBydW5lX2lv
dGxiKG12ZGV2KTsKPiAgfQo+Cj4gLXN0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfZHZxX21y
KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBhc2lkKQo+ICtzdGF0aWMgaW50IF9tbHg1
X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCkKPiAgewo+ICAgICAg
ICAgc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwo+ICAgICAgICAgaW50IGVy
cjsKPiBAQCAtNTUwLDEyICs1NTAsNiBAQCBzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2R2
cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4gICAgICAgICByZXR1cm4gMDsKPiAg
fQo+Cj4gLXN0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0
X2lvdGxiICppb3RsYiwgdW5zaWduZWQgaW50IGFzaWQpCj4gLXsKPiAtICAgICAgIHJldHVybiBf
bWx4NV92ZHBhX2NyZWF0ZV9kdnFfbXIobXZkZXYsIGlvdGxiLCBhc2lkKTsKPiAtfQo+IC0KPiAg
aW50IG1seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1
Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IGludCBhc2lkKQo+ICB7Cj4gLS0KPiAyLjQxLjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
