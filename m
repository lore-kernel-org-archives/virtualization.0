Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0CCC6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 03:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEC68813F6;
	Thu, 23 Mar 2023 03:02:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEC68813F6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IP0DdeDt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R19Lhy9xfkvR; Thu, 23 Mar 2023 03:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5FE2A813DB;
	Thu, 23 Mar 2023 03:01:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FE2A813DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 426A3C0035;
	Thu, 23 Mar 2023 03:01:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33CF3610DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:01:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33CF3610DE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IP0DdeDt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xChX-bmMVP_O
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:01:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60EB860FAE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60EB860FAE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679540515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V020neUbbZWaZoIFJtWjwKXZ29/hnOcn6337E3R+7Xs=;
 b=IP0DdeDtqueZHsFOdqy9mbKToC5BNWz2B9u2ggmk9PhLzYyxaS2YeqkioKSn9n7aEDfCk0
 XNk5c9yoLmd4w6NqcbW/eKFAM881BvHxCUtMLXfBjms2PzQpSLdARke650FUqMOqyBRa+8
 w+3HJmADf1KSWnYk71oAg6Vlfrobxew=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-ujh-2b2MP4m6KK8IRQ8iJQ-1; Wed, 22 Mar 2023 23:01:51 -0400
X-MC-Unique: ujh-2b2MP4m6KK8IRQ8iJQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 w5-20020a4a9785000000b0052521223553so6681057ooi.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 20:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679540511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V020neUbbZWaZoIFJtWjwKXZ29/hnOcn6337E3R+7Xs=;
 b=XAkrgo4laD3MEKj8QpyCXN72P5UXvTwpNnVSrW0s41Bks9aS4PqBu99pEsp1ke+p7n
 /mNYVllk2dkM3RJfIZoZbDqdKLzZGF341+TsqEzPFxwLBIOrU+CoSHqOaMRZj8poRebM
 fEvM7qOhZKh+a0jYvQPBh5EA2fW+reQRPmcTYUn9+P2JDtJijnubvl3oVrmwkFL1NyjE
 1k/WH6yCr4ZXriCJClXbAFysnETS7iblqc21u3RuwdmNHF9Onxla3jZqmPRIpVKscSV9
 3OOWBWcnwSIzaGv43NlVb0ovhnT358B9f/a6XT3RfhzvqY2PR9YiHfisE9UcaOhlQ7m2
 9t7g==
X-Gm-Message-State: AO0yUKUJUNSsk4G8mOFMpE8vEcqPrt8qJETmoStihEZMILMoigFk6Z3m
 Lw8QFYXQDnEpQaVKHUj3lU7G8CZzPcW2RACtbrUca7f2P7v1B7OLEP4pjiLvwEIvcvVGgmZocLS
 O3a9z+mo/pYbJsahuUTdbtKvHijemCQDm5i0xNlbI3npxC5USXPvu3Ply1g==
X-Received: by 2002:a4a:da03:0:b0:536:c774:d6cc with SMTP id
 e3-20020a4ada03000000b00536c774d6ccmr1503650oou.0.1679540511117; 
 Wed, 22 Mar 2023 20:01:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set/tckm88ucwnaPIT76mp9XcG9XGO5SMDYk5qPRCnqR4YfUWsnGbFN7uYCec8c4MsR1rUwyhA1vi/LxnZGNE7ZQ=
X-Received: by 2002:a4a:da03:0:b0:536:c774:d6cc with SMTP id
 e3-20020a4ada03000000b00536c774d6ccmr1503644oou.0.1679540510894; Wed, 22 Mar
 2023 20:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154228.182769-3-sgarzare@redhat.com>
In-Reply-To: <20230321154228.182769-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 11:01:39 +0800
Message-ID: <CACGkMEtq8PWL01WBL2Ve-Yr=ZO+su73tKuOh1EBLagkrLdiCaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMTE6NDLigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gV2hlbiB0aGUgdXNlciBjYWxsIFZIT1NUX1NF
VF9PV05FUiBpb2N0bCBhbmQgdGhlIHZEUEEgZGV2aWNlCj4gaGFzIGB1c2VfdmFgIHNldCB0byB0
cnVlLCBsZXQncyBjYWxsIHRoZSBiaW5kX21tIGNhbGxiYWNrLgo+IEluIHRoaXMgd2F5IHdlIGNh
biBiaW5kIHRoZSBkZXZpY2UgdG8gdGhlIHVzZXIgYWRkcmVzcyBzcGFjZQo+IGFuZCBkaXJlY3Rs
eSB1c2UgdGhlIHVzZXIgVkEuCj4KPiBUaGUgdW5iaW5kX21tIGNhbGxiYWNrIGlzIGNhbGxlZCBk
dXJpbmcgdGhlIHJlbGVhc2UgYWZ0ZXIKPiBzdG9wcGluZyB0aGUgZGV2aWNlLgo+Cj4gU2lnbmVk
LW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+
Cj4gTm90ZXM6Cj4gICAgIHYzOgo+ICAgICAtIGFkZGVkIGBjYXNlIFZIT1NUX1NFVF9PV05FUmAg
aW4gdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bCgpIFtKYXNvbl0KPiAgICAgdjI6Cj4gICAgIC0g
Y2FsbCB0aGUgbmV3IHVuYmluZF9tbSBjYWxsYmFjayBkdXJpbmcgdGhlIHJlbGVhc2UgW0phc29u
XQo+ICAgICAtIGF2b2lkIHRvIGNhbGwgYmluZF9tbSBjYWxsYmFjayBhZnRlciB0aGUgcmVzZXQs
IHNpbmNlIHRoZSBkZXZpY2UKPiAgICAgICBpcyBub3QgZGV0YWNoaW5nIGl0IG5vdyBkdXJpbmcg
dGhlIHJlc2V0Cj4KPiAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAzMSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
IGluZGV4IDdiZTlkOWQ4ZjAxYy4uMjAyNTBjMzQxOGIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtMjE5LDYgKzIx
OSwyOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVzZXQoc3RydWN0IHZob3N0X3ZkcGEgKnYp
Cj4gICAgICAgICByZXR1cm4gdmRwYV9yZXNldCh2ZHBhKTsKPiAgfQo+Cj4gK3N0YXRpYyBsb25n
IHZob3N0X3ZkcGFfYmluZF9tbShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiArewo+ICsgICAgICAg
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPiArICAgICAgIGNvbnN0IHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiArCj4gKyAgICAgICBpZiAo
IXZkcGEtPnVzZV92YSB8fCAhb3BzLT5iaW5kX21tKQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
MDsKPiArCj4gKyAgICAgICByZXR1cm4gb3BzLT5iaW5kX21tKHZkcGEsIHYtPnZkZXYubW0pOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3VuYmluZF9tbShzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdikKPiArewo+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRw
YTsKPiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNv
bmZpZzsKPiArCj4gKyAgICAgICBpZiAoIXZkcGEtPnVzZV92YSB8fCAhb3BzLT51bmJpbmRfbW0p
Cj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiArCj4gKyAgICAgICBvcHMtPnVuYmluZF9tbSh2
ZHBhKTsKPiArfQo+ICsKPiAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfZGV2aWNlX2lkKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKmFyZ3ApCj4gIHsKPiAgICAgICAgIHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gQEAgLTcwOSw2ICs3MzEsMTQgQEAgc3Rh
dGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4g
ICAgICAgICBjYXNlIFZIT1NUX1ZEUEFfUkVTVU1FOgo+ICAgICAgICAgICAgICAgICByID0gdmhv
c3RfdmRwYV9yZXN1bWUodik7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgY2Fz
ZSBWSE9TVF9TRVRfT1dORVI6Cj4gKyAgICAgICAgICAgICAgIHIgPSB2aG9zdF9kZXZfc2V0X293
bmVyKGQpOwoKTml0OgoKSSdkIHN0aWNrIHRvIHRoZSBjdXJyZW50IHdheSBvZiBwYXNzaW5nIHRo
ZSBjbWQsIGFyZ3AgdG8Kdmhvc3RfZGV2X2lvY3RsKCkgYW5kIGludHJvZHVjZSBhIG5ldyBzd2l0
Y2ggYWZ0ZXIgdGhlCnZob3N0X2Rldl9pb2N0bCgpLgoKSW4gdGhpcyB3YXksIHdlIGFyZSBpbW11
bmUgdG8gYW55IHBvc3NpYmxlIGNoYW5nZXMgb2YgZGVhbGluZyB3aXRoClZIT1NUX1NFVF9PV05F
UiBpbiB2aG9zdCBjb3JlLgoKT3RoZXJzIGxvb2sgZ29vZC4KClRoYW5rcwoKPiArICAgICAgICAg
ICAgICAgaWYgKHIpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICAg
ICAgICAgIHIgPSB2aG9zdF92ZHBhX2JpbmRfbW0odik7Cj4gKyAgICAgICAgICAgICAgIGlmIChy
KQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHZob3N0X2Rldl9yZXNldF9vd25lcihkLCBOVUxM
KTsKPiArICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBkZWZhdWx0Ogo+ICAgICAgICAg
ICAgICAgICByID0gdmhvc3RfZGV2X2lvY3RsKCZ2LT52ZGV2LCBjbWQsIGFyZ3ApOwo+ICAgICAg
ICAgICAgICAgICBpZiAociA9PSAtRU5PSU9DVExDTUQpCj4gQEAgLTEyODcsNiArMTMxNyw3IEBA
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVj
dCBmaWxlICpmaWxlcCkKPiAgICAgICAgIHZob3N0X3ZkcGFfY2xlYW5faXJxKHYpOwo+ICAgICAg
ICAgdmhvc3RfdmRwYV9yZXNldCh2KTsKPiAgICAgICAgIHZob3N0X2Rldl9zdG9wKCZ2LT52ZGV2
KTsKPiArICAgICAgIHZob3N0X3ZkcGFfdW5iaW5kX21tKHYpOwo+ICAgICAgICAgdmhvc3RfdmRw
YV9jb25maWdfcHV0KHYpOwo+ICAgICAgICAgdmhvc3RfdmRwYV9jbGVhbnVwKHYpOwo+ICAgICAg
ICAgbXV0ZXhfdW5sb2NrKCZkLT5tdXRleCk7Cj4gLS0KPiAyLjM5LjIKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
