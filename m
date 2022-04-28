Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F527C4332F
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 09:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A560A60E87;
	Thu, 28 Apr 2022 09:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avwz3rWa0gFd; Thu, 28 Apr 2022 09:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30E3C60D6D;
	Thu, 28 Apr 2022 09:46:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13E5CC0039;
	Thu, 28 Apr 2022 09:46:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B53CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A276C60D89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I6og_A_MSdw4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB74A60D6D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651139204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jV2uqusDbLlqRW24zlzkQQ/fT/GXr7j2Z03UPTZMUo=;
 b=J5x8ic/JoG3f9DzY02REOuyp8GnRaAeBRXikGbcwETtBjZLJ7TCufcDK6qL/Ek25ZtZ2+W
 cYUVQTdPU3nlTFwZbxqb7lBHMbPwgaUC9Zws1WTcHFo/FzF8Yv9wH+U1fuf3EDQKBRDib3
 FRyesxY5u8u02rQC8QsSR5nyw+r3bec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-Af0gjD5sNs6JjQAFl5agSQ-1; Thu, 28 Apr 2022 05:46:43 -0400
X-MC-Unique: Af0gjD5sNs6JjQAFl5agSQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 n37-20020a05600c502500b0038fdc1394c6so1722916wmr.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=hwSKQr8OcZBwXxZOkibHDwzuYYi6mLdIMZd+BmKKQvs=;
 b=d+a/yh5bB6RXOUrNiLOdm7WqIEMpknqqmT3ZYkmQf+Stx31oLb1c427qAS2w1i/swR
 3qr7wIBJLU8IfHJPeSj3lWyJKrGM/zFsuki28eiQHaH9f+yRO3El1J+NBMAQZ4rnsQO4
 XqbIe9KlsKR2j+cC47vrk0ODrOChZeIklAjRZm/viXuJYUq3fnvGLI7mEKkfURkkvNpg
 qg8/NdIWQDvaXDZ3DUqy7jPv3lMPVK4XsauD/ZikHLSOCNPiTyJq5g6wENmZS3weJT72
 j3YpR7J6egoOEHqVf6Hf90kobjC0RtBCJvHAYTXt10NZRqmCUPEOh7+3YORNxlPJ7q6i
 x0nw==
X-Gm-Message-State: AOAM533LX6tjFVP8yOZnDItMdESm6e9h18koCrV581sbNlE7AzqqMYN+
 MaPHB/Vn7y5I6d7bP9sU5XPz/o9z2VVbzcM+Ne5cG0EDh+0V5eKFsOfpJ5SGmjTxT1Wkg/mQR5P
 f0V9zABwURsbd9W9iymyUbtcOq5TBxMgD3Kn8r9evPA==
X-Received: by 2002:a7b:c24d:0:b0:393:f9a3:e712 with SMTP id
 b13-20020a7bc24d000000b00393f9a3e712mr11561182wmj.198.1651139202121; 
 Thu, 28 Apr 2022 02:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1S+oAqN9cl2UnoBlUqKMtV+8tL4oX9YO2Iq6WKppDimrB6iJojyXKMTv40cePERaMJVIzcA==
X-Received: by 2002:a7b:c24d:0:b0:393:f9a3:e712 with SMTP id
 b13-20020a7bc24d000000b00393f9a3e712mr11561167wmj.198.1651139201843; 
 Thu, 28 Apr 2022 02:46:41 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
 by smtp.gmail.com with ESMTPSA id
 b2-20020adfc742000000b0020ac89e4241sm17413163wrh.31.2022.04.28.02.46.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Apr 2022 02:46:41 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
Date: Thu, 28 Apr 2022 11:46:40 +0200
Message-Id: <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
To: muriloo@linux.ibm.com
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mopsfelder@gmail.com,
 Christophe de Dinechin <dinechin@redhat.com>
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

Cgo+IE9uIDE1IEFwciAyMDIyLCBhdCAwNTo1MSwgTXVyaWxvIE9wc2ZlbGRlciBBcmHDumpvIDxt
dXJpbG9vQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+IAo+IE9uIDQvMTQvMjIgMjM6MzAsIE11cmls
byBPcHNmZWxkZXIgQXJhdWpvIHdyb3RlOgo+PiBHQ0MgMTIgZW5oYW5jZWQgLVdhZGRyZXNzIHdo
ZW4gY29tcGFyaW5nIGFycmF5IGFkZHJlc3MgdG8gbnVsbCBbMF0sCj4+IHdoaWNoIHdhcm5zOgo+
PiAgICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYzogSW4gZnVuY3Rpb24g4oCY
dnBfZGVsX3Zxc+KAmToKPj4gICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmM6
MjU3OjI5OiB3YXJuaW5nOiB0aGUgY29tcGFyaXNvbiB3aWxsIGFsd2F5cyBldmFsdWF0ZSBhcyDi
gJh0cnVl4oCZIGZvciB0aGUgcG9pbnRlciBvcGVyYW5kIGluIOKAmHZwX2Rldi0+bXNpeF9hZmZp
bml0eV9tYXNrcyArIChzaXpldHlwZSkoKGxvbmcgdW5zaWduZWQgaW50KWkgKiAyNTYp4oCZIG11
c3Qgbm90IGJlIE5VTEwgWy1XYWRkcmVzc10KPj4gICAgICAgMjU3IHwgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSkKPj4gICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgo+PiBJbiBmYWN0LCB0aGUgdmVy
aWZpY2F0aW9uIGlzIGNvbXBhcmluZyB0aGUgcmVzdWx0IG9mIGEgcG9pbnRlcgo+PiBhcml0aG1l
dGljLCB0aGUgYWRkcmVzcyAibXNpeF9hZmZpbml0eV9tYXNrcyArIGkiLCB3aGljaCB3aWxsIGFs
d2F5cwo+PiBldmFsdWF0ZSB0byB0cnVlLgo+PiBVbmRlciB0aGUgaG9vZCwgZnJlZV9jcHVtYXNr
X3ZhcigpIGNhbGxzIGtmcmVlKCksIHdoaWNoIGlzIHNhZmUgdG8gcGFzcwo+PiBOVUxMLCBub3Qg
cmVxdWlyaW5nIG5vbi1udWxsIHZlcmlmaWNhdGlvbi4gIFNvIHJlbW92ZSB0aGUgdmVyaWZpY2F0
aW9uCj4+IHRvIG1ha2UgY29tcGlsZXIgaGFwcHkgKGhhcHB5IGNvbXBpbGVyLCBoYXBweSBsaWZl
KS4KPj4gWzBdIGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTEw
MjEwMwo+PiBTaWduZWQtb2ZmLWJ5OiBNdXJpbG8gT3BzZmVsZGVyIEFyYXVqbyA8bXVyaWxvb0Bs
aW51eC5pYm0uY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9u
LmMgfCAzICstLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4gaW5kZXggZDcyNGY2NzY2MDhi
Li41MDQ2ZWZjZmZiNGMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
Y29tbW9uLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+PiBA
QCAtMjU0LDggKzI1NCw3IEBAIHZvaWQgdnBfZGVsX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldikKPj4gICAgCWlmICh2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3MpIHsKPj4gIAkJZm9y
IChpID0gMDsgaSA8IHZwX2Rldi0+bXNpeF92ZWN0b3JzOyBpKyspCj4+IC0JCQlpZiAodnBfZGV2
LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKQo+PiAtCQkJCWZyZWVfY3B1bWFza192YXIodnBfZGV2
LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKTsKPj4gKwkJCWZyZWVfY3B1bWFza192YXIodnBfZGV2
LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKTsKPj4gIAl9Cj4+ICAgIAlpZiAodnBfZGV2LT5tc2l4
X2VuYWJsZWQpIHsKPiAKPiBBZnRlciBJIHNlbnQgdGhpcyBtZXNzYWdlLCBJIHJlYWxpemVkIHRo
YXQgQ2hyaXN0b3BoZSAoY29waWVkIGhlcmUpCj4gaGFkIGFscmVhZHkgcHJvcG9zZWQgYSBmaXg6
Cj4gCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDQxNDE1MDg1NS4yNDA3
MTM3LTQtZGluZWNoaW5AcmVkaGF0LmNvbS8KPiAKPiBDaHJpc3RvcGhlLAo+IAo+IFNpbmNlIGZy
ZWVfY3B1bWFza192YXIoKSBjYWxscyBrZnJlZSgpIGFuZCBrZnJlZSgpIGlzIG51bGwtc2FmZSwK
PiBjYW4gd2UganVzdCBkcm9wIHRoaXMgbnVsbCB2ZXJpZmljYXRpb24gYW5kIGNhbGwgZnJlZV9j
cHVtYXNrX3ZhcigpIHJpZ2h0IGF3YXk/CgpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiByZXNw
b25kaW5nLCBicm9rZW4gbGFwdG9w4oCmCgpJbiB0aGUgY2FzZSB3aGVyZSBDT05GSUdfQ1BVTUFT
S19PRkZTVEFDSyBpcyBub3QgZGVmaW5lZCwgd2UgaGF2ZToKCgl0eXBlZGVmIHN0cnVjdCBjcHVt
YXNrIGNwdW1hc2tfdmFyX3RbMV07CgpTbyB0aGF0IHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNr
c1tpXSBpcyBzdGF0aWNhbGx5IG5vdCBudWxsICh0aGF04oCZcyB0aGUgd2FybmluZykKYnV0IGFs
c28gYSBzdGF0aWMgcG9pbnRlciwgc28gbm90IGtmcmVlLXNhZmUgSU1PLgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
