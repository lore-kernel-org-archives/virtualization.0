Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E2C433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 04:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B3360F36
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 04:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63B3360F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19C7560665;
	Tue,  2 Nov 2021 04:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0891LQ56ExXz; Tue,  2 Nov 2021 04:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B09560655;
	Tue,  2 Nov 2021 04:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06EC7C0019;
	Tue,  2 Nov 2021 04:57:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8AA1C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD9D280CA7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3UyMNMGoaG-7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:57:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1324B80C9E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 04:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635829064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPxOPCRc3Z2/1ON035liOxmgokBJHX5NnrY+1zM54tQ=;
 b=jCaMfU1V/kPIiT/Vc1dTiS/0QSbPo83sik9Rqa2T/FjeG1/Jk72kuQw8ILaCqHK7EV1m1e
 hZRj1cJth2z73f0t98hJuyvOgELCO+DHDNoX3YT3JcZokO4mnJwRkJBJe75bf0f5wjLcpy
 DjWMDaqqsJoWu6uHolEQFZnOycL8fKs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-2AT6xD9kOna9giWMQEjhLQ-1; Tue, 02 Nov 2021 00:57:41 -0400
X-MC-Unique: 2AT6xD9kOna9giWMQEjhLQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 bn14-20020a05651c178e00b002164a557684so1314567ljb.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 21:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fPxOPCRc3Z2/1ON035liOxmgokBJHX5NnrY+1zM54tQ=;
 b=sTC99L1mNIZrzAdm7gh+Je++KvcvhyD13qYY+oLVnlcf8jMKyz53STKk+tADrl9Bb0
 lwmJUdUpHgW3NVASS15PwsYS2cJAogyHL0tg4ThgR1N5KJ6d2kmijkzTSFg6zRoNT22p
 6GoclH4ctKKt1fcLJ0k6PFsFBgEmOSI+mCVI5C0lVZrhzaSWLRgXNqyc1vAlQ4QUYjSE
 idhBNW8DKNFO856VQLKv/iLgafRB6bCwejikEUm7PDYv3nXxjgrutB7SiZdMoB9v5nYw
 5R1nlIRaCvM89Aviakm7uVfKqDBgMwnSi/XKVDSf+h3KRHehtEHF+1U3qssV7xheZBu1
 VlfA==
X-Gm-Message-State: AOAM533LDihkSQRw2ZIiztQjwnFh1ZNgpyDl4pKh8Kea8Y+pV7LMmCXe
 KXxzIgN+CcNQWTXSfeOINjbej8Fi2lVOIti9ElNrIuJsEqsnrPeP5CRLzGYFsatWEfD80yCEAIH
 6Czyx4FY4CQHlbdCFEsDJRfOj6EwGuZc363CkNVZwxZN03HvPD25NzLBH0A==
X-Received: by 2002:a05:6512:110d:: with SMTP id
 l13mr30883198lfg.199.1635829059851; 
 Mon, 01 Nov 2021 21:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2FLI/DDC4r0Zz7kO0JbzR7nV0V5lH9M3uGR5Y5AeohLGlQG14sh4TdH3r24iVDPQtW68o98ohqXgPTRrHm+k=
X-Received: by 2002:a05:6512:110d:: with SMTP id
 l13mr30883164lfg.199.1635829059598; 
 Mon, 01 Nov 2021 21:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-4-eperezma@redhat.com>
In-Reply-To: <20211029183525.1776416-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Nov 2021 12:57:28 +0800
Message-ID: <CACGkMEsa=iWwN3CkO5JmiB-2BU5T2HvBi=h48qApdktoFCe4Vw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 03/26] virtio: Add VIRTIO_F_QUEUE_STATE
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Parav Pandit <parav@mellanox.com>
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

T24gU2F0LCBPY3QgMzAsIDIwMjEgYXQgMjozNiBBTSBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBJbXBsZW1lbnRhdGlvbiBvZiBSRkMgb2YgZGV2aWNlIHN0
YXRlIGNhcGFiaWxpdHk6Cj4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92
aXJ0aW8tY29tbWVudC8yMDIwMTIvbXNnMDAwMDUuaHRtbAoKQ29uc2lkZXJpbmcgdGhpcyBzdGls
bCByZXF1aXJlcyB0aW1lIHRvIGJlIGRvbmUsIHdlIG5lZWQgdG8gdGhpbmsgb2YgYQp3YXkgdG8g
Z28gd2l0aG91dCB0aGlzLgoKVGhhbmtzCgoKCj4KPiBXaXRoIHRoaXMgY2FwYWJpbGl0eSwgdmRw
YSBkZXZpY2UgY2FuIHJlc2V0IGl0J3MgaW5kZXggc28gaXQgY2FuIHN0YXJ0Cj4gY29uc3VtaW5n
IGZyb20gZ3Vlc3QgYWZ0ZXIgZGlzYWJsaW5nIHNoYWRvdyB2aXJ0cXVldWUgKFNWUSksIHdpdGgg
c3RhdGUKPiBub3QgMC4KPgo+IFRoZSB1c2UgY2FzZSBpcyB0byB0ZXN0IFNWUSB3aXRoIHZpcnRp
by1wY2kgdmRwYSAodnBfdmRwYSkgd2l0aCBuZXN0ZWQKPiB2aXJ0dWFsaXphdGlvbi4gU3Bhd25p
bmcgYSBMMCBxZW11IHdpdGggYSB2aXJ0aW8tbmV0IGRldmljZSwgdXNlCj4gdnBfdmRwYSBkcml2
ZXIgdG8gaGFuZGxlIGl0IGluIHRoZSBndWVzdCwgYW5kIHRoZW4gc3Bhd24gYSBMMSBxZW11IHVz
aW5nCj4gdGhhdCB2ZHBhIGRldmljZS4gV2hlbiBMMSBxZW11IGNhbGxzIGRldmljZSB0byBzZXQg
YSBuZXcgc3RhdGUgdGhvdWdoCj4gdmRwYSBpb2N0bCwgdnBfdmRwYSBzaG91bGQgc2V0IGVhY2gg
cXVldWUgc3RhdGUgdGhvdWdoIHZpcnRpbwo+IFZJUlRJT19QQ0lfQ09NTU9OX1FfQVZBSUxfU1RB
VEUuCj4KPiBTaW5jZSB0aGlzIGlzIG9ubHkgZm9yIHRlc3Rpbmcgdmhvc3QtdmRwYSwgaXQncyBh
ZGRlZCBoZXJlIGJlZm9yZSBvZgo+IHByb3Bvc2luZyB0byBrZXJuZWwgY29kZS4gTm8gZWZmb3J0
IGlzIGRvbmUgZm9yIGNoZWNraW5nIHRoYXQgZGV2aWNlCj4gY2FuIGFjdHVhbGx5IGNoYW5nZSBp
dHMgc3RhdGUsIGl0cyBsYXlvdXQsIG9yIGlmIHRoZSBkZXZpY2UgZXZlbgo+IHN1cHBvcnRzIHRv
IGNoYW5nZSBzdGF0ZSBhdCBhbGwuIFRoZXNlIHdpbGwgYmUgYWRkZWQgaW4gdGhlIGZ1dHVyZS4K
Pgo+IEFsc28sIGEgbW9kaWZpZWQgdmVyc2lvbiBvZiB2cF92ZHBhIHRoYXQgYWxsb3dzIHRvIHNl
dCB0aGVzZSBpbiBQQ0kKPiBjb25maWcgaXMgbmVlZGVkLgo+Cj4gVE9ETzogQ2hlY2sgZm9yIGZl
YXR1cmUgZW5hYmxlZCBhbmQgc3BsaXQgaW4gdmlydGlvIHBjaSBjb25maWcKPgo+IFNpZ25lZC1v
ZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICBody92
aXJ0aW8vdmlydGlvLXBjaS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgMSArCj4gIGluY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby5oICAgICAgICAgICAgICAgICAgICAgfCA0ICsrKy0KPiAgaW5j
bHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDMgKysrCj4gIGlu
Y2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fcGNpLmggICAgfCAyICsrCj4gIGh3
L3ZpcnRpby92aXJ0aW8tcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCA5ICsrKysrKysr
Kwo+ICA1IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5oIGIvaHcvdmlydGlvL3ZpcnRpby1w
Y2kuaAo+IGluZGV4IDI0NDZkY2Q5YWUuLjAxOWJhZGJkN2MgMTAwNjQ0Cj4gLS0tIGEvaHcvdmly
dGlvL3ZpcnRpby1wY2kuaAo+ICsrKyBiL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmgKPiBAQCAtMTIw
LDYgKzEyMCw3IEBAIHR5cGVkZWYgc3RydWN0IFZpcnRJT1BDSVF1ZXVlIHsKPiAgICB1aW50MzJf
dCBkZXNjWzJdOwo+ICAgIHVpbnQzMl90IGF2YWlsWzJdOwo+ICAgIHVpbnQzMl90IHVzZWRbMl07
Cj4gKyAgdWludDE2X3Qgc3RhdGU7Cj4gIH0gVmlydElPUENJUXVldWU7Cj4KPiAgc3RydWN0IFZp
cnRJT1BDSVByb3h5IHsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmgg
Yi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaAo+IGluZGV4IDhiYWI5Y2ZiNzUuLjVmZTU3NWI4
ZjAgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmgKPiArKysgYi9pbmNs
dWRlL2h3L3ZpcnRpby92aXJ0aW8uaAo+IEBAIC0yODksNyArMjg5LDkgQEAgdHlwZWRlZiBzdHJ1
Y3QgVmlydElPUk5HQ29uZiBWaXJ0SU9STkdDb25mOwo+ICAgICAgREVGSU5FX1BST1BfQklUNjQo
ImlvbW11X3BsYXRmb3JtIiwgX3N0YXRlLCBfZmllbGQsIFwKPiAgICAgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19GX0lPTU1VX1BMQVRGT1JNLCBmYWxzZSksIFwKPiAgICAgIERFRklORV9QUk9Q
X0JJVDY0KCJwYWNrZWQiLCBfc3RhdGUsIF9maWVsZCwgXAo+IC0gICAgICAgICAgICAgICAgICAg
ICAgVklSVElPX0ZfUklOR19QQUNLRUQsIGZhbHNlKQo+ICsgICAgICAgICAgICAgICAgICAgICAg
VklSVElPX0ZfUklOR19QQUNLRUQsIGZhbHNlKSwgXAo+ICsgICAgREVGSU5FX1BST1BfQklUNjQo
InNhdmVfcmVzdG9yZV9xX3N0YXRlIiwgX3N0YXRlLCBfZmllbGQsIFwKPiArICAgICAgICAgICAg
ICAgICAgICAgIFZJUlRJT19GX1FVRVVFX1NUQVRFLCB0cnVlKQo+Cj4gIGh3YWRkciB2aXJ0aW9f
cXVldWVfZ2V0X2Rlc2NfYWRkcihWaXJ0SU9EZXZpY2UgKnZkZXYsIGludCBuKTsKPiAgYm9vbCB2
aXJ0aW9fcXVldWVfZW5hYmxlZF9sZWdhY3koVmlydElPRGV2aWNlICp2ZGV2LCBpbnQgbik7Cj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY29uZmln
LmggYi9pbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gaW5k
ZXggMjJlM2E4NWY2Ny4uNTlmYWQzZWI0NSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3N0YW5kYXJk
LWhlYWRlcnMvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gKysrIGIvaW5jbHVkZS9zdGFuZGFyZC1o
ZWFkZXJzL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+IEBAIC05MCw0ICs5MCw3IEBACj4gICAqIERv
ZXMgdGhlIGRldmljZSBzdXBwb3J0IFNpbmdsZSBSb290IEkvTyBWaXJ0dWFsaXphdGlvbj8KPiAg
ICovCj4gICNkZWZpbmUgVklSVElPX0ZfU1JfSU9WICAgICAgICAgICAgICAgICAgICAgICAgMzcK
PiArCj4gKy8qIERldmljZSBzdXBwb3J0IHNhdmUgYW5kIHJlc3RvcmUgdmlydHF1ZXVlIHN0YXRl
ICovCj4gKyNkZWZpbmUgVklSVElPX0ZfUVVFVUVfU1RBVEUgICAgICAgICAgICA0MAo+ICAjZW5k
aWYgLyogX0xJTlVYX1ZJUlRJT19DT05GSUdfSCAqLwo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N0
YW5kYXJkLWhlYWRlcnMvbGludXgvdmlydGlvX3BjaS5oIGIvaW5jbHVkZS9zdGFuZGFyZC1oZWFk
ZXJzL2xpbnV4L3ZpcnRpb19wY2kuaAo+IGluZGV4IGRiN2E4ZTJmY2IuLmM4ZDk4MDJhODcgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19wY2kuaAo+
ICsrKyBiL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fcGNpLmgKPiBAQCAt
MTY0LDYgKzE2NCw3IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ICAgICAgICAg
dWludDMyX3QgcXVldWVfYXZhaWxfaGk7ICAgICAgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8K
PiAgICAgICAgIHVpbnQzMl90IHF1ZXVlX3VzZWRfbG87ICAgICAgICAgLyogcmVhZC13cml0ZSAq
Lwo+ICAgICAgICAgdWludDMyX3QgcXVldWVfdXNlZF9oaTsgICAgICAgICAvKiByZWFkLXdyaXRl
ICovCj4gKyAgICAgICB1aW50MTZfdCBxdWV1ZV9hdmFpbF9zdGF0ZTsgICAgIC8qIHJlYWQtd3Jp
dGUgKi8KPiAgfTsKPgo+ICAvKiBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8K
PiBAQCAtMjAyLDYgKzIwMyw3IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX2NmZ19jYXAgewo+ICAjZGVm
aW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfQVZBSUxISSAgICA0NAo+ICAjZGVmaW5lIFZJUlRJT19Q
Q0lfQ09NTU9OX1FfVVNFRExPICAgICA0OAo+ICAjZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1Ff
VVNFREhJICAgICA1Mgo+ICsjZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfQVZBSUxfU1RBVEUg
ICAgICAgIDU2Cj4KPiAgI2VuZGlmIC8qIFZJUlRJT19QQ0lfTk9fTU9ERVJOICovCj4KPiBkaWZm
IC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMK
PiBpbmRleCA3NTBhYTQ3ZWMxLi5kN2JiNTQ5MDMzIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92
aXJ0aW8tcGNpLmMKPiArKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jCj4gQEAgLTEyNDQsNiAr
MTI0NCw5IEBAIHN0YXRpYyB1aW50NjRfdCB2aXJ0aW9fcGNpX2NvbW1vbl9yZWFkKHZvaWQgKm9w
YXF1ZSwgaHdhZGRyIGFkZHIsCj4gICAgICBjYXNlIFZJUlRJT19QQ0lfQ09NTU9OX1FfVVNFREhJ
Ogo+ICAgICAgICAgIHZhbCA9IHByb3h5LT52cXNbdmRldi0+cXVldWVfc2VsXS51c2VkWzFdOwo+
ICAgICAgICAgIGJyZWFrOwo+ICsgICAgY2FzZSBWSVJUSU9fUENJX0NPTU1PTl9RX0FWQUlMX1NU
QVRFOgo+ICsgICAgICAgIHZhbCA9IHZpcnRpb19xdWV1ZV9nZXRfbGFzdF9hdmFpbF9pZHgodmRl
diwgdmRldi0+cXVldWVfc2VsKTsKPiArICAgICAgICBicmVhazsKPiAgICAgIGRlZmF1bHQ6Cj4g
ICAgICAgICAgdmFsID0gMDsKPiAgICAgIH0KPiBAQCAtMTMzMCw2ICsxMzMzLDggQEAgc3RhdGlj
IHZvaWQgdmlydGlvX3BjaV9jb21tb25fd3JpdGUodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwK
PiAgICAgICAgICAgICAgICAgICAgICAgICBwcm94eS0+dnFzW3ZkZXYtPnF1ZXVlX3NlbF0uYXZh
aWxbMF0sCj4gICAgICAgICAgICAgICAgICAgICAgICAgKCh1aW50NjRfdClwcm94eS0+dnFzW3Zk
ZXYtPnF1ZXVlX3NlbF0udXNlZFsxXSkgPDwgMzIgfAo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHByb3h5LT52cXNbdmRldi0+cXVldWVfc2VsXS51c2VkWzBdKTsKPiArICAgICAgICAgICAgdmly
dGlvX3F1ZXVlX3NldF9sYXN0X2F2YWlsX2lkeCh2ZGV2LCB2ZGV2LT5xdWV1ZV9zZWwsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgIHByb3h5LT52cXNbdmRldi0+cXVldWVfc2VsXS5zdGF0ZSk7
Cj4gICAgICAgICAgICAgIHByb3h5LT52cXNbdmRldi0+cXVldWVfc2VsXS5lbmFibGVkID0gMTsK
PiAgICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICB2aXJ0aW9fZXJyb3IodmRldiwgIndy
b25nIHZhbHVlIGZvciBxdWV1ZV9lbmFibGUgJSJQUkl4NjQsIHZhbCk7Cj4gQEAgLTEzNTMsNiAr
MTM1OCw5IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfY29tbW9uX3dyaXRlKHZvaWQgKm9wYXF1
ZSwgaHdhZGRyIGFkZHIsCj4gICAgICBjYXNlIFZJUlRJT19QQ0lfQ09NTU9OX1FfVVNFREhJOgo+
ICAgICAgICAgIHByb3h5LT52cXNbdmRldi0+cXVldWVfc2VsXS51c2VkWzFdID0gdmFsOwo+ICAg
ICAgICAgIGJyZWFrOwo+ICsgICAgY2FzZSBWSVJUSU9fUENJX0NPTU1PTl9RX0FWQUlMX1NUQVRF
Ogo+ICsgICAgICAgIHByb3h5LT52cXNbdmRldi0+cXVldWVfc2VsXS5zdGF0ZSA9IHZhbDsKPiAr
ICAgICAgICBicmVhazsKPiAgICAgIGRlZmF1bHQ6Cj4gICAgICAgICAgYnJlYWs7Cj4gICAgICB9
Cj4gQEAgLTE5NTEsNiArMTk1OSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVzZXQoRGV2
aWNlU3RhdGUgKnFkZXYpCj4gICAgICAgICAgcHJveHktPnZxc1tpXS5kZXNjWzBdID0gcHJveHkt
PnZxc1tpXS5kZXNjWzFdID0gMDsKPiAgICAgICAgICBwcm94eS0+dnFzW2ldLmF2YWlsWzBdID0g
cHJveHktPnZxc1tpXS5hdmFpbFsxXSA9IDA7Cj4gICAgICAgICAgcHJveHktPnZxc1tpXS51c2Vk
WzBdID0gcHJveHktPnZxc1tpXS51c2VkWzFdID0gMDsKPiArICAgICAgICBwcm94eS0+dnFzW2ld
LnN0YXRlID0gMDsKPiAgICAgIH0KPgo+ICAgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikpIHsK
PiAtLQo+IDIuMjcuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
