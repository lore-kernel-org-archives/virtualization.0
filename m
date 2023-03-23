Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C1BC6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 05:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E15041DC2;
	Thu, 23 Mar 2023 05:11:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E15041DC2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R86PcA3n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7VFx3jR13Faz; Thu, 23 Mar 2023 05:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6BF0D41C0B;
	Thu, 23 Mar 2023 05:11:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BF0D41C0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13FA8C0071;
	Thu, 23 Mar 2023 05:11:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 130CAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3FB9613E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:11:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3FB9613E1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R86PcA3n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mrDx9eoWfEyz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:11:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F63D60FAE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F63D60FAE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679548313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3obIApiz6XSZWW1/5Bw9gaJPbynr/ma2GlgXsdWN+4I=;
 b=R86PcA3n3P/QvieKrrxkzELax8+KVpij4WZivMGlmoNQblbDeY4h10v/EqYXRNaVeR05TS
 DKZ5+m2/G2m04BvFQk3QegPSiWodpZZX9E81RO2rbMaRqMLiYBrII2k+3fI9zz7rvD3QQj
 2ofzodkDA1SL+5yimIgLKbmbSVM/1rk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-lYVcqi2bMa67ZlE5Peyb6g-1; Thu, 23 Mar 2023 01:11:51 -0400
X-MC-Unique: lYVcqi2bMa67ZlE5Peyb6g-1
Received: by mail-ot1-f71.google.com with SMTP id
 e2-20020a9d5602000000b00694299f6ea9so9555032oti.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 22:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679548310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3obIApiz6XSZWW1/5Bw9gaJPbynr/ma2GlgXsdWN+4I=;
 b=zfTeVwuWJ82bta/UW5BfbzZVzPj+Z6cdh/1BTf87peP6VkH/7wnC8CnGkTgHbZ3lSh
 /KZmRRL2+2Kl6tWrRex7adAqWs6v9dnmp+jxdcG3mE+Vobg6FU7bLKrHkSgZpQg3eYHK
 o/YIraTTNvjTm48F58Rxnv52ko6Oo0ZDuhJ45ogXUkuK5cbxsLW6ANIC5euQX+StG8RA
 jPKbp56L5GQAdSeWC9PaC2LVAYkQj5M2xz/lECF5xrxo+whyeOepbI19sfZeGmdtWF53
 /Do5QFSVc++VQ4gMa2NsihWLu/xzazBs7Ee6xWbLuUQwnuiWWGOjBQqNvu1PgHRVgQTA
 EEYw==
X-Gm-Message-State: AAQBX9dB/uEYWk/yDazSNFvSvQia+cpLKsDScVZGT5oHL9KWEnfYyDhp
 D+XZDP4rdQsRDl1kL/GS9Ja96vhJCUZwVO4lGUaBUqrtWP2Bn3DgBcO1jwil+gHOYy5j3z1E9uA
 f9Lb5K0/d1BTNPTBCiDqmOnOQYVwrQf6EAIePAq7m4+1qEk7Av/VU6ddYHA==
X-Received: by 2002:a05:6871:6c97:b0:17e:7674:8df0 with SMTP id
 zj23-20020a0568716c9700b0017e76748df0mr708950oab.9.1679548310152; 
 Wed, 22 Mar 2023 22:11:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set/ZEZkMXDEYWmucA01pOHV0jYtKIc/O0X4B69Ds15sDFH0SmHz0B8yc7U/s8mZMK9Yi0aM3l+qrQwnkM/yazzk=
X-Received: by 2002:a05:6871:6c97:b0:17e:7674:8df0 with SMTP id
 zj23-20020a0568716c9700b0017e76748df0mr708948oab.9.1679548309923; Wed, 22 Mar
 2023 22:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230322191038.44037-1-shannon.nelson@amd.com>
 <20230322191038.44037-5-shannon.nelson@amd.com>
In-Reply-To: <20230322191038.44037-5-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 13:11:38 +0800
Message-ID: <CACGkMEtBGZ-ViLk=tRJiAMm_YJJ2XomRQAKdCpa1tWE4KmuRJA@mail.gmail.com>
Subject: Re: [PATCH v3 virtio 4/8] pds_vdpa: virtio bar setup for vdpa
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMzoxMeKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFByZXAgYW5kIHVzZSB0aGUgIm1vZGVybiIgdmly
dGlvIGJhciB1dGlsaXRpZXMgdG8gZ2V0IG91cgo+IHZpcnRpbyBjb25maWcgc3BhY2UgcmVhZHku
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNv
bT4KPiAtLS0KPiAgZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMgfCAyNSArKysrKysrKysrKysr
KysrKysrKysrKysrCj4gIGRyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5oIHwgIDMgKysrCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9wZHMvYXV4X2Rydi5jIGIvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMKPiBpbmRleCA4
ODFhY2Q4NjlhOWQuLjhmM2FlMzMyNjg4NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRz
L2F1eF9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5jCj4gQEAgLTQsNiAr
NCw3IEBACj4gICNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+Cj4gICNpbmNsdWRlIDxs
aW51eC9wY2kuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4KPiArI2luY2x1ZGUgPGxpbnV4
L3ZpcnRpb19wY2lfbW9kZXJuLmg+Cj4KPiAgI2luY2x1ZGUgPGxpbnV4L3Bkcy9wZHNfY29tbW9u
Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9wZHMvcGRzX2NvcmVfaWYuaD4KPiBAQCAtMjAsMTIgKzIx
LDIyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZV9pZCBwZHNfdmRwYV9p
ZF90YWJsZVtdID0gewo+ICAgICAgICAge30sCj4gIH07Cj4KPiArc3RhdGljIGludCBwZHNfdmRw
YV9kZXZpY2VfaWRfY2hlY2soc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4gK3sKPiArICAgICAgIGlm
IChwZGV2LT5kZXZpY2UgIT0gUENJX0RFVklDRV9JRF9QRU5TQU5ET19WRFBBX1ZGIHx8Cj4gKyAg
ICAgICAgICAgcGRldi0+dmVuZG9yICE9IFBDSV9WRU5ET1JfSURfUEVOU0FORE8pCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PREVWOwoKU2ltaWxhciB0byBwYXRjaCAxLCBpZiB3ZSBkb24n
dCBuZWVkIHRvIG92ZXJyaWRlIHdlIHByb2JhYmx5IGNhbgpyZW5hbWUgdGhlIGRldmljZV9pZF9j
aGVja19vdmVycmlkZSB0byBkZXZpY2VfaWRfY2hlY2soKS4gT3RoZXJ3aXNlCml0J3MgYmV0dGVy
IHRvIGxldCB0aGlzIGZ1bmN0aW9uIHRvIHJldHVybiBkZXZpY2UgaWQuCgpUaGFua3MKCj4gKwo+
ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gIHN0YXRpYyBpbnQgcGRzX3ZkcGFfcHJvYmUo
c3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmF1eF9kZXYsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZV9pZCAqaWQpCj4KPiAgewo+ICAgICAg
ICAgc3RydWN0IHBkc19hdXhpbGlhcnlfZGV2ICpwYWRldiA9Cj4gICAgICAgICAgICAgICAgIGNv
bnRhaW5lcl9vZihhdXhfZGV2LCBzdHJ1Y3QgcGRzX2F1eGlsaWFyeV9kZXYsIGF1eF9kZXYpOwo+
ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJmF1eF9kZXYtPmRldjsKPiAgICAgICAgIHN0
cnVjdCBwZHNfdmRwYV9hdXggKnZkcGFfYXV4Owo+ICAgICAgICAgaW50IGVycjsKPgo+IEBAIC00
Miw4ICs1MywyMSBAQCBzdGF0aWMgaW50IHBkc192ZHBhX3Byb2JlKHN0cnVjdCBhdXhpbGlhcnlf
ZGV2aWNlICphdXhfZGV2LAo+ICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAgZ290
byBlcnJfZnJlZV9tZW07Cj4KPiArICAgICAgIC8qIEZpbmQgdGhlIHZpcnRpbyBjb25maWd1cmF0
aW9uICovCj4gKyAgICAgICB2ZHBhX2F1eC0+dmRfbWRldi5wY2lfZGV2ID0gcGFkZXYtPnZmX3Bk
ZXY7Cj4gKyAgICAgICB2ZHBhX2F1eC0+dmRfbWRldi5kZXZpY2VfaWRfY2hlY2tfb3ZlcnJpZGUg
PSBwZHNfdmRwYV9kZXZpY2VfaWRfY2hlY2s7Cj4gKyAgICAgICB2ZHBhX2F1eC0+dmRfbWRldi5k
bWFfbWFza19vdmVycmlkZSA9IERNQV9CSVRfTUFTSyhQRFNfQ09SRV9BRERSX0xFTik7Cj4gKyAg
ICAgICBlcnIgPSB2cF9tb2Rlcm5fcHJvYmUoJnZkcGFfYXV4LT52ZF9tZGV2KTsKPiArICAgICAg
IGlmIChlcnIpIHsKPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJVbmFibGUgdG8gcHJv
YmUgZm9yIHZpcnRpbyBjb25maWd1cmF0aW9uOiAlcGVcbiIsCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgRVJSX1BUUihlcnIpKTsKPiArICAgICAgICAgICAgICAgZ290byBlcnJfZnJlZV9tZ210
X2luZm87Cj4gKyAgICAgICB9Cj4gKwo+ICAgICAgICAgcmV0dXJuIDA7Cj4KPiArZXJyX2ZyZWVf
bWdtdF9pbmZvOgo+ICsgICAgICAgcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGFkZXYtPnZmX3BkZXYp
Owo+ICBlcnJfZnJlZV9tZW06Cj4gICAgICAgICBrZnJlZSh2ZHBhX2F1eCk7Cj4gICAgICAgICBh
dXhpbGlhcnlfc2V0X2RydmRhdGEoYXV4X2RldiwgTlVMTCk7Cj4gQEAgLTU2LDYgKzgwLDcgQEAg
c3RhdGljIHZvaWQgcGRzX3ZkcGFfcmVtb3ZlKHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphdXhf
ZGV2KQo+ICAgICAgICAgc3RydWN0IHBkc192ZHBhX2F1eCAqdmRwYV9hdXggPSBhdXhpbGlhcnlf
Z2V0X2RydmRhdGEoYXV4X2Rldik7Cj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmYXV4
X2Rldi0+ZGV2Owo+Cj4gKyAgICAgICB2cF9tb2Rlcm5fcmVtb3ZlKCZ2ZHBhX2F1eC0+dmRfbWRl
dik7Cj4gICAgICAgICBwY2lfZnJlZV9pcnFfdmVjdG9ycyh2ZHBhX2F1eC0+cGFkZXYtPnZmX3Bk
ZXYpOwo+Cj4gICAgICAgICBrZnJlZSh2ZHBhX2F1eCk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9wZHMvYXV4X2Rydi5oIGIvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmgKPiBpbmRleCA5
NGJhN2FiY2FhNDMuLjhmNTE0MDQwMTU3MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRz
L2F1eF9kcnYuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5oCj4gQEAgLTQsNiAr
NCw4IEBACj4gICNpZm5kZWYgX0FVWF9EUlZfSF8KPiAgI2RlZmluZSBfQVVYX0RSVl9IXwo+Cj4g
KyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVybi5oPgo+ICsKPiAgI2RlZmluZSBQRFNf
VkRQQV9EUlZfREVTQ1JJUFRJT04gICAgIkFNRC9QZW5zYW5kbyB2RFBBIFZGIERldmljZSBEcml2
ZXIiCj4gICNkZWZpbmUgUERTX1ZEUEFfRFJWX05BTUUgICAgICAgICAgICJwZHNfdmRwYSIKPgo+
IEBAIC0xNiw2ICsxOCw3IEBAIHN0cnVjdCBwZHNfdmRwYV9hdXggewo+Cj4gICAgICAgICBpbnQg
dmZfaWQ7Cj4gICAgICAgICBzdHJ1Y3QgZGVudHJ5ICpkZW50cnk7Cj4gKyAgICAgICBzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIHZkX21kZXY7Cj4KPiAgICAgICAgIGludCBuaW50cnM7
Cj4gIH07Cj4gLS0KPiAyLjE3LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
