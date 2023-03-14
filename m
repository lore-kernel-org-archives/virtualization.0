Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F4BC6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 03:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B0D1402A8;
	Tue, 14 Mar 2023 03:48:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B0D1402A8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fiPObVDv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgrxrU8fzPa2; Tue, 14 Mar 2023 03:48:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E6774012E;
	Tue, 14 Mar 2023 03:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E6774012E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82D9DC0071;
	Tue, 14 Mar 2023 03:48:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB63C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08AB081CFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08AB081CFE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fiPObVDv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c2HYtb6O121I
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:48:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4721681CE7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4721681CE7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678765726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ptwZll8h87dgHJIgfhW5kVetp/8YFoTfo6N7J2gOEM=;
 b=fiPObVDvB1HVf/MpxmO3VIxVH6x99CgprdksVMm5QHXthGriIQY+7HUWsUcqhQpl4yv03a
 9F4rDIg2J8ERaD/0BSD8+MgujtgPEEhlbLgOH7+I0ce20CkQYCN862FHNU0X8ON2lQ2pSZ
 HoNNlsXuyVXXbOV1cZNULIyUBQW5rTU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-kAUZDZlDM86Beu34-PtdQw-1; Mon, 13 Mar 2023 23:48:44 -0400
X-MC-Unique: kAUZDZlDM86Beu34-PtdQw-1
Received: by mail-oo1-f71.google.com with SMTP id
 l11-20020a4aa78b000000b005254a9621e1so3927113oom.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 20:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678765724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ptwZll8h87dgHJIgfhW5kVetp/8YFoTfo6N7J2gOEM=;
 b=UtWYegKUNsWxeY71P1k4+UjYETPA2rNlb7m3tfE49/G7wN+Vhe8CKFXb0vOo8f8291
 HMb8/HUBNGtpXJSwgIgHZD/MoDlc60eDWVgcuGO5Cq6iZTgtJFhGwCl32ZZ5nwm/UYpu
 BiRCVzYdO9j7BqfDNay3ClkVQgEVm80ieNdQSgHCeTIPNayJamdwHP6O9jfQOXJB4OgI
 knErKsOjSussczPExkMXX33lJUBCqBqXOeYdEN8NA+rygg6hmg8oOlJWlIHQTddhrnGf
 960tNCI2vdh0fX+zQMU7dcseX687UmdcXLmVa5+tyeyknrJQgpbHc6Gqfh5YFBX5NPv1
 2etQ==
X-Gm-Message-State: AO0yUKXeZ0VoV+poYWYXczocZrcZnRbvZTyNqed77xKvz8AzKe6Z5VSQ
 D5Aq1KoekyP0097VQZVOOdvkWELF5AI67BVELWhjDQ2QQmrLGLicG4kS01cWUbbDdAD6TtbhlXR
 jciXvUgADILnr1GM/9Ca886c7MwmjU/dQcQ39rWSwmVpxvCXF6kCkgiW9Zw==
X-Received: by 2002:a05:6870:1110:b0:17a:adbe:2ba4 with SMTP id
 16-20020a056870111000b0017aadbe2ba4mr117857oaf.9.1678765724089; 
 Mon, 13 Mar 2023 20:48:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set8/3QKP0un3qOoea6zpjo8vUIQsfQbqXMn5cSBIhnA44wMHNQck4apXmRGrPe4GAOAB9DE3FgX6b6IEjtSp9QQ=
X-Received: by 2002:a05:6870:1110:b0:17a:adbe:2ba4 with SMTP id
 16-20020a056870111000b0017aadbe2ba4mr117853oaf.9.1678765723868; Mon, 13 Mar
 2023 20:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-3-sgarzare@redhat.com>
In-Reply-To: <20230302113421.174582-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 11:48:33 +0800
Message-ID: <CACGkMEttgd82xOxV8WLdSFdfhRLZn68tSaV4APSDh8qXxf4OEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjM04oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IFdoZW4gdGhlIHVzZXIgY2FsbCBWSE9TVF9TRVRf
T1dORVIgaW9jdGwgYW5kIHRoZSB2RFBBIGRldmljZQo+IGhhcyBgdXNlX3ZhYCBzZXQgdG8gdHJ1
ZSwgbGV0J3MgY2FsbCB0aGUgYmluZF9tbSBjYWxsYmFjay4KPiBJbiB0aGlzIHdheSB3ZSBjYW4g
YmluZCB0aGUgZGV2aWNlIHRvIHRoZSB1c2VyIGFkZHJlc3Mgc3BhY2UKPiBhbmQgZGlyZWN0bHkg
dXNlIHRoZSB1c2VyIFZBLgo+Cj4gVGhlIHVuYmluZF9tbSBjYWxsYmFjayBpcyBjYWxsZWQgZHVy
aW5nIHRoZSByZWxlYXNlIGFmdGVyCj4gc3RvcHBpbmcgdGhlIGRldmljZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KPgo+
IE5vdGVzOgo+ICAgICB2MjoKPiAgICAgLSBjYWxsIHRoZSBuZXcgdW5iaW5kX21tIGNhbGxiYWNr
IGR1cmluZyB0aGUgcmVsZWFzZSBbSmFzb25dCj4gICAgIC0gYXZvaWQgdG8gY2FsbCBiaW5kX21t
IGNhbGxiYWNrIGFmdGVyIHRoZSByZXNldCwgc2luY2UgdGhlIGRldmljZQo+ICAgICAgIGlzIG5v
dCBkZXRhY2hpbmcgaXQgbm93IGR1cmluZyB0aGUgcmVzZXQKPgo+ICBkcml2ZXJzL3Zob3N0L3Zk
cGEuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdl
ZCwgMzAgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
IGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBkYzEyZGJkNWI0M2IuLjFhYjg5ZmNjZDgy
NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4gQEAgLTIxOSw2ICsyMTksMjggQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Jl
c2V0KHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+ICAgICAgICAgcmV0dXJuIHZkcGFfcmVzZXQodmRw
YSk7Cj4gIH0KPgo+ICtzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2JpbmRfbW0oc3RydWN0IHZob3N0
X3ZkcGEgKnYpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZk
cGE7Cj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5j
b25maWc7Cj4gKwo+ICsgICAgICAgaWYgKCF2ZHBhLT51c2VfdmEgfHwgIW9wcy0+YmluZF9tbSkK
PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKwo+ICsgICAgICAgcmV0dXJuIG9wcy0+Ymlu
ZF9tbSh2ZHBhLCB2LT52ZGV2Lm1tKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgdmhvc3RfdmRw
YV91bmJpbmRfbW0oc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gKwo+ICsgICAgICAgaWYgKCF2ZHBhLT51
c2VfdmEgfHwgIW9wcy0+dW5iaW5kX21tKQo+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gKwo+
ICsgICAgICAgb3BzLT51bmJpbmRfbW0odmRwYSk7Cj4gK30KPiArCj4gIHN0YXRpYyBsb25nIHZo
b3N0X3ZkcGFfZ2V0X2RldmljZV9pZChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICph
cmdwKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+
IEBAIC03MTEsNiArNzMzLDEzIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9j
dGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAg
IGRlZmF1bHQ6Cj4gICAgICAgICAgICAgICAgIHIgPSB2aG9zdF9kZXZfaW9jdGwoJnYtPnZkZXYs
IGNtZCwgYXJncCk7Cj4gKyAgICAgICAgICAgICAgIGlmICghciAmJiBjbWQgPT0gVkhPU1RfU0VU
X09XTkVSKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgciA9IHZob3N0X3ZkcGFfYmluZF9t
bSh2KTsKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocikgewo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdmhvc3RfZGV2X3Jlc2V0X293bmVyKCZ2LT52ZGV2LCBOVUxMKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgfQoKTml0OiBpcyBpdCBiZXR0ZXIgdG8gaGF2
ZSBhIG5ldyBjb25kaXRpb24vc3dpdGNoIGJyYW5jaCBpbnN0ZWFkIG9mCnB1dHRpbmcgdGhlbSB1
bmRlciBkZWZhdWx0PyAoYXMgd2hhdCB2cmluZ19pb2N0bCBkaWQpLgoKVGhhbmtzCgo+ICAgICAg
ICAgICAgICAgICBpZiAociA9PSAtRU5PSU9DVExDTUQpCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgciA9IHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwodiwgY21kLCBhcmdwKTsKPiAgICAgICAgICAg
ICAgICAgYnJlYWs7Cj4gQEAgLTEyODUsNiArMTMxNCw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRw
YV9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPiAgICAg
ICAgIHZob3N0X3ZkcGFfY2xlYW5faXJxKHYpOwo+ICAgICAgICAgdmhvc3RfdmRwYV9yZXNldCh2
KTsKPiAgICAgICAgIHZob3N0X2Rldl9zdG9wKCZ2LT52ZGV2KTsKPiArICAgICAgIHZob3N0X3Zk
cGFfdW5iaW5kX21tKHYpOwo+ICAgICAgICAgdmhvc3RfdmRwYV9mcmVlX2RvbWFpbih2KTsKPiAg
ICAgICAgIHZob3N0X3ZkcGFfY29uZmlnX3B1dCh2KTsKPiAgICAgICAgIHZob3N0X3ZkcGFfY2xl
YW51cCh2KTsKPiAtLQo+IDIuMzkuMgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
