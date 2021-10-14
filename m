Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:30:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B12260184
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B12260184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7E9C4062B;
	Thu, 14 Oct 2021 03:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1t2ak6iHMJFl; Thu, 14 Oct 2021 03:30:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6DD1740644;
	Thu, 14 Oct 2021 03:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 448B5C0011;
	Thu, 14 Oct 2021 03:30:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC4EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 03:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C47540644
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 03:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sM04GT7S7qdl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 03:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC704062B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 03:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634182214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG0SVIux0s/g7ZeBe2DCekA66rrHyA4AmTh0wIt6pek=;
 b=Q19G7s4CYgid5g2dta5bsr0lj6DE2eHTfV5e/AQ9efcdiqOZNb6kh+wFzbDJeP9PokSVmo
 37t0WZ9FckvVIamhJuMnDXuciEeIHFeQiIVvl8Z8359FJ5kVCWGQVZjNwdMKEG4PhE96ae
 vH+rcHPcYeqQ36lwGXPbsrADT2hRPxo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-O_fzbiT_NVqh-dDmuKdrBw-1; Wed, 13 Oct 2021 23:30:13 -0400
X-MC-Unique: O_fzbiT_NVqh-dDmuKdrBw-1
Received: by mail-lf1-f69.google.com with SMTP id
 u17-20020a05651206d100b003fd714d9a38so3414501lff.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 20:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bG0SVIux0s/g7ZeBe2DCekA66rrHyA4AmTh0wIt6pek=;
 b=k48YtYMAqajFShKqvjwSYb6TWWhWC4kNFRy6MlmSOc3biZng/VtZV4EBlScDjUBo6a
 ixlSlaKwJp+aOfJKCvq74giUagKdvvJy4nrg/TdUcpU4vyuhgTuY7Wu8WzTjVobPlWcy
 JlRTn1l0EXnvz5SCdMtA+Q324pAeID1Q6BxOteE0TEz8HTkYYq0MwAlXzvaROeEZpL8W
 ldXCW9wrchustXMbT5mQ8qMddmam+GQ6z9P4RH9uxzAMohKjhyob9cilSiD27tDbXGuj
 klFZWKzsJv3jHrGIBsnZJG9NNf35hUGzSw2bWk+qzC1+xBTWSPXFdul2aqzAHwTJ5EOB
 ZFuw==
X-Gm-Message-State: AOAM531CJ9T+P2nQd0O+/83xYp+79JNJ9ymQafoz6SWGdk5wqqk8+W0h
 t1s8lkonWvz8LGFIDqp3wRw8spd0JYZdMvTFU+3dZhdTIkkMMQfJy6dbBILWOtWB0pwvGoyd7Wq
 XHFIfFM74NcfN6FoabePhXs1KkpxKJS0ClfxGdPzoNQM9JtMyMgmu8EvgmQ==
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3434334ljg.277.1634182212300; 
 Wed, 13 Oct 2021 20:30:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRhJRM9Zk2Nt3JVQQkFK+aaj2JG866bcIAt0E7pn4iFil6wIP7mmKG/ECedAIRWfinjVJMV8unKdbhcwka9Lc=
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3434296ljg.277.1634182211789; 
 Wed, 13 Oct 2021 20:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211012140710.804529-1-eperezma@redhat.com>
 <20211012140710.804529-4-eperezma@redhat.com>
In-Reply-To: <20211012140710.804529-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 11:29:56 +0800
Message-ID: <CACGkMEsGDoWuE0WEq7P-S5V5XiLPCZcVAszQFHDLsLDZEAAh5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vdpa: Check for iova range at mappings changes
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

T24gVHVlLCBPY3QgMTIsIDIwMjEgYXQgMTA6MDcgUE0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gQ2hlY2sgdmRwYSBkZXZpY2UgcmFuZ2UgYmVmb3JlIHVw
ZGF0aW5nIG1lbW9yeSByZWdpb25zIHNvIHdlIGRvbid0IGFkZAo+IGFueSBvdXRzaWRlIG9mIGl0
LCBhbmQgcmVwb3J0IHRoZSBpbnZhbGlkIGNoYW5nZSBpZiBhbnkuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9o
dy92aXJ0aW8vdmhvc3QtdmRwYS5oIHwgIDIgKysKPiAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAg
ICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+ICBody92aXJ0
aW8vdHJhY2UtZXZlbnRzICAgICAgICAgfCAgMSArCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92
aXJ0aW8vdmhvc3QtdmRwYS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdmRwYS5oCj4gaW5k
ZXggYTg5NjNkYTJkOS4uYzI4OGNmN2VjYiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRp
by92aG9zdC12ZHBhLmgKPiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmgKPiBA
QCAtMTMsNiArMTMsNyBAQAo+ICAjZGVmaW5lIEhXX1ZJUlRJT19WSE9TVF9WRFBBX0gKPgo+ICAj
aW5jbHVkZSAiaHcvdmlydGlvL3ZpcnRpby5oIgo+ICsjaW5jbHVkZSAic3RhbmRhcmQtaGVhZGVy
cy9saW51eC92aG9zdF90eXBlcy5oIgo+Cj4gIHR5cGVkZWYgc3RydWN0IFZob3N0VkRQQUhvc3RO
b3RpZmllciB7Cj4gICAgICBNZW1vcnlSZWdpb24gbXI7Cj4gQEAgLTI0LDYgKzI1LDcgQEAgdHlw
ZWRlZiBzdHJ1Y3Qgdmhvc3RfdmRwYSB7Cj4gICAgICB1aW50MzJfdCBtc2dfdHlwZTsKPiAgICAg
IGJvb2wgaW90bGJfYmF0Y2hfYmVnaW5fc2VudDsKPiAgICAgIE1lbW9yeUxpc3RlbmVyIGxpc3Rl
bmVyOwo+ICsgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlOwo+ICAg
ICAgc3RydWN0IHZob3N0X2RldiAqZGV2Owo+ICAgICAgVmhvc3RWRFBBSG9zdE5vdGlmaWVyIG5v
dGlmaWVyW1ZJUlRJT19RVUVVRV9NQVhdOwo+ICB9IFZob3N0VkRQQTsKPiBkaWZmIC0tZ2l0IGEv
aHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPiBpbmRleCBi
ZTdjNjNiNGJhLi5kYmY3NzNkMDMyIDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBh
LmMKPiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gQEAgLTM3LDIwICszNywzNCBAQCBz
dGF0aWMgSW50MTI4IHZob3N0X3ZkcGFfc2VjdGlvbl9lbmQoY29uc3QgTWVtb3J5UmVnaW9uU2Vj
dGlvbiAqc2VjdGlvbikKPiAgICAgIHJldHVybiBsbGVuZDsKPiAgfQo+Cj4gLXN0YXRpYyBib29s
IHZob3N0X3ZkcGFfbGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKE1lbW9yeVJlZ2lvblNlY3Rpb24g
KnNlY3Rpb24pCj4gLXsKPiAtICAgIHJldHVybiAoIW1lbW9yeV9yZWdpb25faXNfcmFtKHNlY3Rp
b24tPm1yKSAmJgo+IC0gICAgICAgICAgICAhbWVtb3J5X3JlZ2lvbl9pc19pb21tdShzZWN0aW9u
LT5tcikpIHx8Cj4gLSAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faXNfcHJvdGVjdGVkKHNlY3Rp
b24tPm1yKSB8fAo+IC0gICAgICAgICAgIC8qIHZob3N0LXZEUEEgZG9lc24ndCBhbGxvdyBNTUlP
IHRvIGJlIG1hcHBlZCAgKi8KPiAtICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9pc19yYW1fZGV2
aWNlKHNlY3Rpb24tPm1yKSB8fAo+IC0gICAgICAgICAgIC8qCj4gLSAgICAgICAgICAgICogU2l6
aW5nIGFuIGVuYWJsZWQgNjQtYml0IEJBUiBjYW4gY2F1c2Ugc3B1cmlvdXMgbWFwcGluZ3MgdG8K
PiAtICAgICAgICAgICAgKiBhZGRyZXNzZXMgaW4gdGhlIHVwcGVyIHBhcnQgb2YgdGhlIDY0LWJp
dCBhZGRyZXNzIHNwYWNlLiAgVGhlc2UKPiAtICAgICAgICAgICAgKiBhcmUgbmV2ZXIgYWNjZXNz
ZWQgYnkgdGhlIENQVSBhbmQgYmV5b25kIHRoZSBhZGRyZXNzIHdpZHRoIG9mCj4gLSAgICAgICAg
ICAgICogc29tZSBJT01NVSBoYXJkd2FyZS4gIFRPRE86IFZEUEEgc2hvdWxkIHRlbGwgdXMgdGhl
IElPTU1VIHdpZHRoLgo+IC0gICAgICAgICAgICAqLwo+IC0gICAgICAgICAgIHNlY3Rpb24tPm9m
ZnNldF93aXRoaW5fYWRkcmVzc19zcGFjZSAmICgxVUxMIDw8IDYzKTsKPiArc3RhdGljIGJvb2wg
dmhvc3RfdmRwYV9saXN0ZW5lcl9za2lwcGVkX3NlY3Rpb24oTWVtb3J5UmVnaW9uU2VjdGlvbiAq
c2VjdGlvbiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgaW92YV9taW4sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ2NF90IGlvdmFfbWF4KQo+ICt7Cj4gKyAgICBJbnQxMjggbGxl
bmQ7Cj4gKwo+ICsgICAgaWYgKCghbWVtb3J5X3JlZ2lvbl9pc19yYW0oc2VjdGlvbi0+bXIpICYm
Cj4gKyAgICAgICAgICFtZW1vcnlfcmVnaW9uX2lzX2lvbW11KHNlY3Rpb24tPm1yKSkgfHwKPiAr
ICAgICAgICBtZW1vcnlfcmVnaW9uX2lzX3Byb3RlY3RlZChzZWN0aW9uLT5tcikgfHwKPiArICAg
ICAgICAvKiB2aG9zdC12RFBBIGRvZXNuJ3QgYWxsb3cgTU1JTyB0byBiZSBtYXBwZWQgICovCj4g
KyAgICAgICAgbWVtb3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKHNlY3Rpb24tPm1yKSkgewo+ICsg
ICAgICAgIHJldHVybiB0cnVlOwo+ICsgICAgfQo+ICsKPiArICAgIGlmIChzZWN0aW9uLT5vZmZz
ZXRfd2l0aGluX2FkZHJlc3Nfc3BhY2UgPCBpb3ZhX21pbikgewo+ICsgICAgICAgIGVycm9yX3Jl
cG9ydCgiUkFNIHNlY3Rpb24gb3V0IG9mIGRldmljZSByYW5nZSAobWluPSVsdSwgYWRkcj0lbHUp
IiwKPiArICAgICAgICAgICAgICAgICAgICAgaW92YV9taW4sIHNlY3Rpb24tPm9mZnNldF93aXRo
aW5fYWRkcmVzc19zcGFjZSk7Cj4gKyAgICAgICAgcmV0dXJuIHRydWU7Cj4gKyAgICB9Cj4gKwo+
ICsgICAgbGxlbmQgPSB2aG9zdF92ZHBhX3NlY3Rpb25fZW5kKHNlY3Rpb24pOwo+ICsgICAgaWYg
KGludDEyOF9ndChsbGVuZCwgaW50MTI4X21ha2U2NChpb3ZhX21heCkpKSB7Cj4gKyAgICAgICAg
ZXJyb3JfcmVwb3J0KCJSQU0gc2VjdGlvbiBvdXQgb2YgZGV2aWNlIHJhbmdlIChtYXg9JWx1LCBl
bmQgYWRkcj0lbHUpIiwKPiArICAgICAgICAgICAgICAgICAgICAgaW92YV9tYXgsIGludDEyOF9n
ZXQ2NChsbGVuZCkpOwo+ICsgICAgICAgIHJldHVybiB0cnVlOwo+ICsgICAgfQo+ICsKPiArICAg
IHJldHVybiBmYWxzZTsKPiAgfQo+Cj4gIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9kbWFfbWFwKHN0
cnVjdCB2aG9zdF92ZHBhICp2LCBod2FkZHIgaW92YSwgaHdhZGRyIHNpemUsCj4gQEAgLTE2Miw3
ICsxNzYsOCBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX2xpc3RlbmVyX3JlZ2lvbl9hZGQoTWVt
b3J5TGlzdGVuZXIgKmxpc3RlbmVyLAo+ICAgICAgdm9pZCAqdmFkZHI7Cj4gICAgICBpbnQgcmV0
Owo+Cj4gLSAgICBpZiAodmhvc3RfdmRwYV9saXN0ZW5lcl9za2lwcGVkX3NlY3Rpb24oc2VjdGlv
bikpIHsKPiArICAgIGlmICh2aG9zdF92ZHBhX2xpc3RlbmVyX3NraXBwZWRfc2VjdGlvbihzZWN0
aW9uLCB2LT5pb3ZhX3JhbmdlLmZpcnN0LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHYtPmlvdmFfcmFuZ2UubGFzdCkpIHsKPiAgICAgICAgICByZXR1cm47
Cj4gICAgICB9Cj4KPiBAQCAtMjIwLDcgKzIzNSw4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFf
bGlzdGVuZXJfcmVnaW9uX2RlbChNZW1vcnlMaXN0ZW5lciAqbGlzdGVuZXIsCj4gICAgICBJbnQx
MjggbGxlbmQsIGxsc2l6ZTsKPiAgICAgIGludCByZXQ7Cj4KPiAtICAgIGlmICh2aG9zdF92ZHBh
X2xpc3RlbmVyX3NraXBwZWRfc2VjdGlvbihzZWN0aW9uKSkgewo+ICsgICAgaWYgKHZob3N0X3Zk
cGFfbGlzdGVuZXJfc2tpcHBlZF9zZWN0aW9uKHNlY3Rpb24sIHYtPmlvdmFfcmFuZ2UuZmlyc3Qs
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdi0+aW92YV9y
YW5nZS5sYXN0KSkgewo+ICAgICAgICAgIHJldHVybjsKPiAgICAgIH0KPgo+IEBAIC0yODgsNiAr
MzA0LDE5IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfYWRkX3N0YXR1cyhzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYsIHVpbnQ4X3Qgc3RhdHVzKQo+ICAgICAgdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhP
U1RfVkRQQV9TRVRfU1RBVFVTLCAmcyk7Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBh
X2dldF9pb3ZhX3JhbmdlKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+ICt7Cj4gKyAgICBpbnQgcmV0
ID0gdmhvc3RfdmRwYV9jYWxsKHYtPmRldiwgVkhPU1RfVkRQQV9HRVRfSU9WQV9SQU5HRSwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnYtPmlvdmFfcmFuZ2UpOwo+ICsgICAgaWYg
KHJldCAhPSAwKSB7Cj4gKyAgICAgICAgdi0+aW92YV9yYW5nZS5maXJzdCA9IDA7Cj4gKyAgICAg
ICAgdi0+aW92YV9yYW5nZS5sYXN0ID0gTUFLRV82NEJJVF9NQVNLKDAsIDYzKTsKCk5pdDoKClVM
TE9OR19NQVg/CgpPdGhlcnMgbG9vayBnb29kLgoKVGhhbmtzCgo+ICsgICAgfQo+ICsKPiArICAg
IHRyYWNlX3Zob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodi0+ZGV2LCB2LT5pb3ZhX3JhbmdlLmZp
cnN0LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2LT5pb3ZhX3Jhbmdl
Lmxhc3QpOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfaW5pdChzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYsIHZvaWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKQo+ICB7Cj4gICAgICBzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdjsKPiBAQCAtMzAwLDYgKzMyOSw3IEBAIHN0YXRpYyBpbnQgdmhvc3Rf
dmRwYV9pbml0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVy
cnApCj4gICAgICB2LT5saXN0ZW5lciA9IHZob3N0X3ZkcGFfbWVtb3J5X2xpc3RlbmVyOwo+ICAg
ICAgdi0+bXNnX3R5cGUgPSBWSE9TVF9JT1RMQl9NU0dfVjI7Cj4KPiArICAgIHZob3N0X3ZkcGFf
Z2V0X2lvdmFfcmFuZ2Uodik7Cj4gICAgICB2aG9zdF92ZHBhX2FkZF9zdGF0dXMoZGV2LCBWSVJU
SU9fQ09ORklHX1NfQUNLTk9XTEVER0UgfAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVklSVElPX0NPTkZJR19TX0RSSVZFUik7Cj4KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Ry
YWNlLWV2ZW50cyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPiBpbmRleCA4ZWQxOWU5ZDBjLi42
NTBlNTIxZTM1IDEwMDY0NAo+IC0tLSBhL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPiArKysgYi9o
dy92aXJ0aW8vdHJhY2UtZXZlbnRzCj4gQEAgLTUyLDYgKzUyLDcgQEAgdmhvc3RfdmRwYV9zZXRf
dnJpbmdfY2FsbCh2b2lkICpkZXYsIHVuc2lnbmVkIGludCBpbmRleCwgaW50IGZkKSAiZGV2OiAl
cCBpbmRleDoKPiAgdmhvc3RfdmRwYV9nZXRfZmVhdHVyZXModm9pZCAqZGV2LCB1aW50NjRfdCBm
ZWF0dXJlcykgImRldjogJXAgZmVhdHVyZXM6IDB4JSJQUkl4NjQKPiAgdmhvc3RfdmRwYV9zZXRf
b3duZXIodm9pZCAqZGV2KSAiZGV2OiAlcCIKPiAgdmhvc3RfdmRwYV92cV9nZXRfYWRkcih2b2lk
ICpkZXYsIHZvaWQgKnZxLCB1aW50NjRfdCBkZXNjX3VzZXJfYWRkciwgdWludDY0X3QgYXZhaWxf
dXNlcl9hZGRyLCB1aW50NjRfdCB1c2VkX3VzZXJfYWRkcikgImRldjogJXAgdnE6ICVwIGRlc2Nf
dXNlcl9hZGRyOiAweCUiUFJJeDY0IiBhdmFpbF91c2VyX2FkZHI6IDB4JSJQUkl4NjQiIHVzZWRf
dXNlcl9hZGRyOiAweCUiUFJJeDY0Cj4gK3Zob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodm9pZCAq
ZGV2LCB1aW50NjRfdCBmaXJzdCwgdWludDY0X3QgbGFzdCkgImRldjogJXAgZmlyc3Q6IDB4JSJQ
Ukl4NjQiIGxhc3Q6IDB4JSJQUkl4NjQKPgo+ICAjIHZpcnRpby5jCj4gIHZpcnRxdWV1ZV9hbGxv
Y19lbGVtZW50KHZvaWQgKmVsZW0sIHNpemVfdCBzeiwgdW5zaWduZWQgaW5fbnVtLCB1bnNpZ25l
ZCBvdXRfbnVtKSAiZWxlbSAlcCBzaXplICV6ZCBpbl9udW0gJXUgb3V0X251bSAldSIKPiAtLQo+
IDIuMjcuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
