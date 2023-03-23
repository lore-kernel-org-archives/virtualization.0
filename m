Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF0FC6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 02:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 447EB613B6;
	Thu, 23 Mar 2023 02:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 447EB613B6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MR3wS8Fk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rDYHl45dxq8p; Thu, 23 Mar 2023 02:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D460460E44;
	Thu, 23 Mar 2023 02:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D460460E44
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A611DC0071;
	Thu, 23 Mar 2023 02:58:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72627C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E7AE40338
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E7AE40338
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MR3wS8Fk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMVY7MJvt2X5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:58:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 500C940332
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 500C940332
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679540299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0VvJoT/In9zXsTG4Y/WHrDmIvI8+3uyMcN0Vni7Bkk=;
 b=MR3wS8FkkIgsoZBelJcZaUDuJkwcw4vhyLNFZvBUYWVrq2PPaqOc9+lJbPbFdHRCUXNqOi
 sQqPogTTI4b+B99Ug8TZGNnBxjDm3N7S5dbtmZm1Z1fNxvFrnEpCI4Yc2mi6SDNL2wLUh3
 4/1GWbJj+D1ivhgFdgoaU5QzUUpd/Ik=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-soZMOjMtPUajkmXYI9JNgw-1; Wed, 22 Mar 2023 22:58:17 -0400
X-MC-Unique: soZMOjMtPUajkmXYI9JNgw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-176347f3b28so10768291fac.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 19:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679540297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0VvJoT/In9zXsTG4Y/WHrDmIvI8+3uyMcN0Vni7Bkk=;
 b=QNGc0Gc1SXX/T7T/sFRSY0aNPJrO9vA166oIWpLGExVDLatsVPmb6/TkCgw0s9McEE
 jy1pszJf7KNypnRnytE+w7M81cYC3t0teK+z8kMsg+V402SpMMHwerLTcUVFctmH37Ku
 /pUaHc40OIfWp6L08sBiCfyDgNjFQEexhlWybfSkPOeg2i+fSYqxTFSqe5yzvSawsows
 4xusGhW8KRbE7qdyt90i6Q7yKc58yRIbbsuF99Nxo9+1gVdImpwVk+rOKwqxoA8tlun7
 u9NRq2iH1F9BCMOyFVMuleHgvJh09BaYH2e7mU1xJ6u8FVVjMfTyltcVQDpuX+Rey+1Q
 rY8A==
X-Gm-Message-State: AO0yUKX4s0mXTKTdm1b/yp3VIzU8+8de2nl+6sA43oNkFqYTA8eS8IWq
 cXQCLyKsGiCbyz9ivkOj8O6ODPejusDFrh7udtRfJsTs51g5JGaqlm+cTnM44o5iLDUf7YEbpM6
 obqkIHkByxAnbVkCXBHeRdnRedzV/RHb+NRFq4Yjnwn3myn7MCovxvEiB0A==
X-Received: by 2002:a9d:66d1:0:b0:69f:bac:aa8a with SMTP id
 t17-20020a9d66d1000000b0069f0bacaa8amr1815481otm.2.1679540296924; 
 Wed, 22 Mar 2023 19:58:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set/BWrafeE27f5b5IZId0P5hAaqy+ikMd7Pl7UM4zZNHvprQ9rbOtFWqSmX8VPoPdPkZ143ngQ4DrCO+EBX4+4A=
X-Received: by 2002:a9d:66d1:0:b0:69f:bac:aa8a with SMTP id
 t17-20020a9d66d1000000b0069f0bacaa8amr1815470otm.2.1679540296705; Wed, 22 Mar
 2023 19:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154228.182769-2-sgarzare@redhat.com>
In-Reply-To: <20230321154228.182769-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 10:58:05 +0800
Message-ID: <CACGkMEsZog+-CHDjc5gM-3FKZySvN_6xBK10dHD3ahoxB8S+yQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] vdpa: add bind_mm/unbind_mm callbacks
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
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhlc2UgbmV3IG9wdGlvbmFsIGNhbGxiYWNr
cyBpcyB1c2VkIHRvIGJpbmQvdW5iaW5kIHRoZSBkZXZpY2UgdG8KPiBhIHNwZWNpZmljIGFkZHJl
c3Mgc3BhY2Ugc28gdGhlIHZEUEEgZnJhbWV3b3JrIGNhbiB1c2UgVkEgd2hlbgo+IHRoZXNlIGNh
bGxiYWNrcyBhcmUgaW1wbGVtZW50ZWQuCj4KPiBTdWdnZXN0ZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+CgpUaGFua3MKCj4gLS0tCj4KPiBOb3RlczoKPiAgICAgdjI6Cj4gICAgIC0gcmVtb3Zl
ZCBgc3RydWN0IHRhc2tfc3RydWN0ICpvd25lcmAgcGFyYW0gKHVudXNlZCBmb3Igbm93LCBtYXli
ZQo+ICAgICAgIHVzZWZ1bCB0byBzdXBwb3J0IGNncm91cHMpIFtKYXNvbl0KPiAgICAgLSBhZGQg
dW5iaW5kX21tIGNhbGxiYWNrIFtKYXNvbl0KPgo+ICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDEw
ICsrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gaW5k
ZXggNDNmNTllZjEwY2M5Li4zNjljMjEzOTQyODQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51
eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IEBAIC0yOTAsNiArMjkwLDE0
IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QGlkeDogdmlydHF1ZXVlIGluZGV4Cj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
ZXR1cm5zIHBvaW50ZXIgdG8gc3RydWN0dXJlIGRldmljZSBvciBlcnJvciAoTlVMTCkKPiArICog
QGJpbmRfbW06ICAgICAgICAgICAgICAgICAgIEJpbmQgdGhlIGRldmljZSB0byBhIHNwZWNpZmlj
IGFkZHJlc3Mgc3BhY2UKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNvIHRoZSB2
RFBBIGZyYW1ld29yayBjYW4gdXNlIFZBIHdoZW4gdGhpcwo+ICsgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2FsbGJhY2sgaXMgaW1wbGVtZW50ZWQuIChvcHRpb25hbCkKPiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ICsgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQG1tOiBhZGRyZXNzIHNwYWNlIHRvIGJpbmQKPiArICogQHVu
YmluZF9tbTogICAgICAgICAgICAgICAgIFVuYmluZCB0aGUgZGV2aWNlIGZyb20gdGhlIGFkZHJl
c3Mgc3BhY2UKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvdW5kIHVzaW5nIHRo
ZSBiaW5kX21tIGNhbGxiYWNrLiAob3B0aW9uYWwpCj4gKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiAgICogQGZyZWU6ICAgICAgICAgICAgICAgICAg
ICAgIEZyZWUgcmVzb3VyY2VzIHRoYXQgYmVsb25ncyB0byB2RFBBIChvcHRpb25hbCkKPiAgICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgKi8KPiBA
QCAtMzUxLDYgKzM1OSw4IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ICAgICAgICAgaW50
ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50
IGdyb3VwLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBhc2lk
KTsKPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKigqZ2V0X3ZxX2RtYV9kZXYpKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTE2IGlkeCk7Cj4gKyAgICAgICBpbnQgKCpiaW5kX21tKShzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKPiArICAgICAgIHZvaWQg
KCp1bmJpbmRfbW0pKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4KPiAgICAgICAgIC8qIEZy
ZWUgZGV2aWNlIHJlc291cmNlcyAqLwo+ICAgICAgICAgdm9pZCAoKmZyZWUpKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldik7Cj4gLS0KPiAyLjM5LjIKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
