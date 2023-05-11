Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B278FC77B7F
	for <virtualization@archiver.kernel.org>; Thu, 11 May 2023 07:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16F394089E;
	Thu, 11 May 2023 07:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16F394089E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XpmqrdnG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtCUfMl02h5G; Thu, 11 May 2023 07:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41D6040198;
	Thu, 11 May 2023 07:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41D6040198
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4049C0036;
	Thu, 11 May 2023 07:23:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80692C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B1BC600BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B1BC600BA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XpmqrdnG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w5pVzZcuoguB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F29B060ACF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F29B060ACF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 07:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683789813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhZXSJmCMPVroKyfY6svZyJqGcFT/oaAMzdzmzskFpo=;
 b=XpmqrdnGbDahFOWwfqCqk7CkpXgovTKKvKRfChlWxHDakZCst3h2bkdsoAlKUkgjrXiZfL
 OMwfTL54n2g8Z0+cR6Q6bBclLM3zVrwNQUOOl3+5RPet7YuH3YoqiTIfm2al6fQZxT5sxr
 CmjDTi+rUQPjcte68ttwDDcUrVrYf6w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-_GbRvUXbN42Ztyw-xBSSbw-1; Thu, 11 May 2023 03:23:32 -0400
X-MC-Unique: _GbRvUXbN42Ztyw-xBSSbw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edc5d704bbso4361680e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 May 2023 00:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683789810; x=1686381810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uhZXSJmCMPVroKyfY6svZyJqGcFT/oaAMzdzmzskFpo=;
 b=QqgzuetNGE+RziLdvLYQhfskOPAR8s+Tc9HVnUXz0pmpInVLcySyB/whg7o4MN3GtJ
 N2caa0vtD+xbpiND8ytvlEzZM5EgR+2evuxnX7LuhV3yzE/d6XcYhyrtF1R4Ab/2QIgJ
 HDcZxKNvdC/wuGIgTPVHUsJZ2rrIkt3fX9ihP243pwMEP86VKARzIxEvJGQ0v6cELiBL
 lg2/BAU1NPrVoDCwkcCBG+iuxtraaKCA8fQjgRbj0GiBV9eRWSq6P3J5DB0UmTikBOSY
 YzbV3vNPL+QtJel0VgWZN6GdewBhGOKB5khp4GUX4qwBJqmUldfwf2/Boo5N/Exwxrq/
 TaqQ==
X-Gm-Message-State: AC+VfDx++Z56Ko2scj9kvLghdblaHAmRc3wVGxx69ldDER75BrKZtTW2
 MiB9i0vNrdA/0ifgRPKpEyjPRwdgt8746E3ZJ0gDPTHNSkS2Ei+B6lte44ggfTSKuvWw/cq5RXA
 WZTNWErCF/rsb6/pqX13aXbWiB4PqwhDpfI50cRIkh8KX2wYB60196WWDWw==
X-Received: by 2002:ac2:4adc:0:b0:4eb:40d4:e0d2 with SMTP id
 m28-20020ac24adc000000b004eb40d4e0d2mr2212980lfp.38.1683789810635; 
 Thu, 11 May 2023 00:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HGzvBxTFw6KdzTP8z4ZeFxuPsZmjPnWDwGuMsmzaUZawt2yupl34n0WzBxIsUye8pXjDRVlQML139TuP7Nhs=
X-Received: by 2002:ac2:4adc:0:b0:4eb:40d4:e0d2 with SMTP id
 m28-20020ac24adc000000b004eb40d4e0d2mr2212973lfp.38.1683789810362; Thu, 11
 May 2023 00:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230502131048.61134-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230502131048.61134-1-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 May 2023 15:23:19 +0800
Message-ID: <CACGkMEuYr-HnKqkj_p90XbvMoa=ADgDdC3t2gwmt9_cEg8cG4A@mail.gmail.com>
Subject: Re: [PATCH] vdpa/snet: implement the resume vDPA callback
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gVHVlLCBNYXkgMiwgMjAyMyBhdCA5OjEx4oCvUE0gQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4gd3JvdGU6Cj4KPiBUaGUgY2FsbGJhY2sgc2VuZHMgYSByZXN1bWUg
Y29tbWFuZCB0byB0aGUgRFBVIHRocm91Z2gKPiB0aGUgY29udHJvbCBtZWNoYW5pc20uCj4KPiBT
aWduZWQtb2ZmLWJ5OiBBbHZhcm8gS2Fyc3ogPGFsdmFyby5rYXJzekBzb2xpZC1ydW4uY29tPgoK
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0t
Cj4gIGRyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2N0cmwuYyB8ICA2ICsrKysrKwo+ICBkcml2
ZXJzL3ZkcGEvc29saWRydW4vc25ldF9tYWluLmMgfCAxNSArKysrKysrKysrKysrKysKPiAgZHJp
dmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oIHwgIDEgKwo+ICAzIGZpbGVzIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvc29saWRydW4v
c25ldF9jdHJsLmMgYi9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9jdHJsLmMKPiBpbmRleCAz
ODU4NzM4NjQzYi4uM2NlZjI1NzFkMTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3NvbGlk
cnVuL3NuZXRfY3RybC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfY3RybC5j
Cj4gQEAgLTE2LDYgKzE2LDcgQEAgZW51bSBzbmV0X2N0cmxfb3Bjb2RlcyB7Cj4gICAgICAgICBT
TkVUX0NUUkxfT1BfREVTVFJPWSA9IDEsCj4gICAgICAgICBTTkVUX0NUUkxfT1BfUkVBRF9WUV9T
VEFURSwKPiAgICAgICAgIFNORVRfQ1RSTF9PUF9TVVNQRU5ELAo+ICsgICAgICAgU05FVF9DVFJM
X09QX1JFU1VNRSwKPiAgfTsKPgo+ICAjZGVmaW5lIFNORVRfQ1RSTF9USU1FT1VUICAgICAgICAg
ICAgICAyMDAwMDAwCj4gQEAgLTMyOCwzICszMjksOCBAQCBpbnQgc25ldF9zdXNwZW5kX2Rldihz
dHJ1Y3Qgc25ldCAqc25ldCkKPiAgewo+ICAgICAgICAgcmV0dXJuIHNuZXRfc2VuZF9jdHJsX21z
ZyhzbmV0LCBTTkVUX0NUUkxfT1BfU1VTUEVORCwgMCk7Cj4gIH0KPiArCj4gK2ludCBzbmV0X3Jl
c3VtZV9kZXYoc3RydWN0IHNuZXQgKnNuZXQpCj4gK3sKPiArICAgICAgIHJldHVybiBzbmV0X3Nl
bmRfY3RybF9tc2coc25ldCwgU05FVF9DVFJMX09QX1JFU1VNRSwgMCk7Cj4gK30KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfbWFpbi5jIGIvZHJpdmVycy92ZHBhL3Nv
bGlkcnVuL3NuZXRfbWFpbi5jCj4gaW5kZXggY2RjZDg0Y2U0ZjUuLjk5NDI4YTA0MDY4IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X21haW4uYwo+ICsrKyBiL2RyaXZl
cnMvdmRwYS9zb2xpZHJ1bi9zbmV0X21haW4uYwo+IEBAIC01MDksNiArNTA5LDIwIEBAIHN0YXRp
YyBpbnQgc25ldF9zdXNwZW5kKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiAgICAgICAgIHJl
dHVybiByZXQ7Cj4gIH0KPgo+ICtzdGF0aWMgaW50IHNuZXRfcmVzdW1lKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldikKPiArewo+ICsgICAgICAgc3RydWN0IHNuZXQgKnNuZXQgPSB2ZHBhX3RvX3Nu
ZXQodmRldik7Cj4gKyAgICAgICBpbnQgcmV0Owo+ICsKPiArICAgICAgIHJldCA9IHNuZXRfcmVz
dW1lX2RldihzbmV0KTsKPiArICAgICAgIGlmIChyZXQpCj4gKyAgICAgICAgICAgICAgIFNORVRf
RVJSKHNuZXQtPnBkZXYsICJTTkVUWyV1XSByZXN1bWUgZmFpbGVkLCBlcnI6ICVkXG4iLCBzbmV0
LT5zaWQsIHJldCk7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgIFNORVRfREJHKHNu
ZXQtPnBkZXYsICJSZXN1bWUgU05FVFsldV0gZGV2aWNlXG4iLCBzbmV0LT5zaWQpOwo+ICsKPiAr
ICAgICAgIHJldHVybiByZXQ7Cj4gK30KPiArCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzIHNuZXRfY29uZmlnX29wcyA9IHsKPiAgICAgICAgIC5zZXRfdnFfYWRkcmVzcyAg
ICAgICAgID0gc25ldF9zZXRfdnFfYWRkcmVzcywKPiAgICAgICAgIC5zZXRfdnFfbnVtICAgICAg
ICAgICAgID0gc25ldF9zZXRfdnFfbnVtLAo+IEBAIC01MzYsNiArNTUwLDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgc25ldF9jb25maWdfb3BzID0gewo+ICAgICAgICAg
LmdldF9jb25maWcgICAgICAgICAgICAgPSBzbmV0X2dldF9jb25maWcsCj4gICAgICAgICAuc2V0
X2NvbmZpZyAgICAgICAgICAgICA9IHNuZXRfc2V0X2NvbmZpZywKPiAgICAgICAgIC5zdXNwZW5k
ICAgICAgICAgICAgICAgID0gc25ldF9zdXNwZW5kLAo+ICsgICAgICAgLnJlc3VtZSAgICAgICAg
ICAgICAgICAgPSBzbmV0X3Jlc3VtZSwKPiAgfTsKPgo+ICBzdGF0aWMgaW50IHBzbmV0X29wZW5f
cGZfYmFyKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBzdHJ1Y3QgcHNuZXQgKnBzbmV0KQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF92ZHBhLmggYi9kcml2ZXJzL3ZkcGEv
c29saWRydW4vc25ldF92ZHBhLmgKPiBpbmRleCAzYzc4ZDRlN2Q0OC4uMzZhYzI4NTgzNWUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oCj4gKysrIGIvZHJp
dmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oCj4gQEAgLTIwNCw1ICsyMDQsNiBAQCB2b2lk
IHNuZXRfY3RybF9jbGVhcihzdHJ1Y3Qgc25ldCAqc25ldCk7Cj4gIGludCBzbmV0X2Rlc3Ryb3lf
ZGV2KHN0cnVjdCBzbmV0ICpzbmV0KTsKPiAgaW50IHNuZXRfcmVhZF92cV9zdGF0ZShzdHJ1Y3Qg
c25ldCAqc25ldCwgdTE2IGlkeCwgc3RydWN0IHZkcGFfdnFfc3RhdGUgKnN0YXRlKTsKPiAgaW50
IHNuZXRfc3VzcGVuZF9kZXYoc3RydWN0IHNuZXQgKnNuZXQpOwo+ICtpbnQgc25ldF9yZXN1bWVf
ZGV2KHN0cnVjdCBzbmV0ICpzbmV0KTsKPgo+ICAjZW5kaWYgLy9fU05FVF9WRFBBX0hfCj4gLS0K
PiAyLjM0LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
