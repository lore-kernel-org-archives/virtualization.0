Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE28C43334
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 08:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CCFE4025C;
	Mon, 13 Jun 2022 08:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LqnjeGKHBtLx; Mon, 13 Jun 2022 08:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33C3540210;
	Mon, 13 Jun 2022 08:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18510C0039;
	Mon, 13 Jun 2022 08:55:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ADC6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B7C160071
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jM-z_W6cQQdh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:55:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E521F60011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655110551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ue9GXuZlt6O4w3FULE2nckV/CzaJQzI0UzlNFHJkrZY=;
 b=Pbsv//blBxsjGzWS53BL+SIccWCMak+Ln0QXyni0ZEXePYw5p4HbTey0SPJcPhHpQG7YKy
 gs14AAMNFV/Ti4CTDiITJsFgbyP4y7XNyORyucyhMFNaqOrDz2W9fNfVeuurlVrOvUiksT
 UbWdYTFz8Q6fR7Q01XXoPG14UiBmHgo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-yAmDKNvzM0KS3DpcVB9qZw-1; Mon, 13 Jun 2022 04:55:50 -0400
X-MC-Unique: yAmDKNvzM0KS3DpcVB9qZw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a9-20020a17090682c900b0070b513b9dc4so1535923ejy.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ue9GXuZlt6O4w3FULE2nckV/CzaJQzI0UzlNFHJkrZY=;
 b=61bgHNamdbT/Tjd67uH1tqHd9fuhIvrJ/h07HWY6vFY3avlJT8HWpWl6BrlyaNCOdR
 SvfgPSE66IbGyEuaVZLS/3rEbejaJQT3HPpDmEOl2hHKwPWvhca6yj2PTvyJ4+hkB7Vt
 26tbu4lZx8Ejftu0ivOF3m6cJ0i8s6ewLXgfKQOXzTVcFT1tLVRViAryU/dIXgu0XiIB
 8FfaIOqWLMMQRgGi65MCinGauNHQLyA/rteqsjf/QKdw+obFW1hmDzPUHcFVLirw48Oq
 iN+1dv0sAZ5YmpWUINmYyTl60n7gCFZWf7XAuHeO5n8YgSnnaMjJY/xhpmwFsZJyrZey
 VvtQ==
X-Gm-Message-State: AOAM5303QE0aP/UtVZx/jQfH8jAMBQR2gmMab8pEmP5huD+2yMDcGqJx
 A9jlkEdOeBLMu59Tuq+nA7CTB1j/L3zYzsbfsDgk/j0vSKrGq07eCB5RHXsOPk3lordBcWU22EH
 62580PU/kRUOMwEgMB9auPkOg1OK0l9nI/BeScupV/A==
X-Received: by 2002:a05:6402:847:b0:42d:91ed:82f3 with SMTP id
 b7-20020a056402084700b0042d91ed82f3mr65194855edz.416.1655110549575; 
 Mon, 13 Jun 2022 01:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcB9+XyOU39IAxggYlgFNEtGGAUmTGp5Y4DoCkomSM03LY8ciXJZ6dR59zB3fhinaO0WhDJA==
X-Received: by 2002:a05:6402:847:b0:42d:91ed:82f3 with SMTP id
 b7-20020a056402084700b0042d91ed82f3mr65194835edz.416.1655110549248; 
 Mon, 13 Jun 2022 01:55:49 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107c:be5a:1a30:9f6d:4400:4adc])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a056402274600b0042def6cd141sm4552298edd.30.2022.06.13.01.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 01:55:48 -0700 (PDT)
Date: Mon, 13 Jun 2022 04:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Subject: Re: [PATCH] virtio_ring : fix vring_packed_desc memory out of bounds
 bug
Message-ID: <20220613045212-mutt-send-email-mst@kernel.org>
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
 <20220610103905-mutt-send-email-mst@kernel.org>
 <CABKxMyPTLJ0bbxb23C_aeucVEP8MYNiFz1y9d8eGA4Bvdyey3g@mail.gmail.com>
 <20220610203449-mutt-send-email-mst@kernel.org>
 <CABKxMyOYrjUDvWggK=rnBZcRuaO9x=wHWq15MgAQz5_Fbtypxg@mail.gmail.com>
 <20220612100945-mutt-send-email-mst@kernel.org>
 <CABKxMyMiOhRSp5_VOZ2Sh8q7Ef3+hnZmALHazwii0hR3SfRZWg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABKxMyMiOhRSp5_VOZ2Sh8q7Ef3+hnZmALHazwii0hR3SfRZWg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yuanzhu@bytedance.com, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDQ6NDQ6MDNQTSArMDgwMCwg6buE5p2wIHdyb3RlOgo+
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTLml6Xl
kajml6UgMjI6MTPlhpnpgZPvvJoKPiA+Cj4gPiBPbiBTdW4sIEp1biAxMiwgMjAyMiBhdCAwNzow
MjoyNVBNICswODAwLCDpu4TmnbAgd3JvdGU6Cj4gPiA+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTHml6Xlkajlha0gMDg6MzXlhpnpgZPvvJoKPiA+
ID4gPgo+ID4gPiA+IE9uIFNhdCwgSnVuIDExLCAyMDIyIGF0IDEyOjM4OjEwQU0gKzA4MDAsIOm7
hOadsCB3cm90ZToKPiA+ID4gPiA+ID4gVGhpcyBwYXR0ZXJuIHdhcyBhbHdheXMgaWZmeSwgYnV0
IEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoCj4gPiA+ID4gPiA+IGltcHJvdmVzIHRoZSBzaXR1YXRp
b24gbXVjaC4gbGFzdF91c2VkX2lkeCBhbmQgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlcgo+
ID4gPiA+ID4gPiBjYW4gc3RpbGwgZ2V0IG91dCBvZiBzeW5jLgo+ID4gPiA+ID4KPiA+ID4gPiA+
IFllc++8jCBZb3UgYXJlIGFic29sdXRlbHkgY29ycmVjdCwgdGhhbmtzIGZvciBwb2ludGluZyBv
dXQgdGhpcyBpc3N1ZSwgSQo+ID4gPiA+ID4gZGlkbid0IHRha2UgdGhhdCBpbnRvIGNvbnNpZGVy
YXRpb24sCj4gPiA+ID4gPiBob3cgYWJvdXQgZGlzYWJsaW5nIGludGVycnVwdHMgYmVmb3JlIHRo
aXMgY29kZSBiZWxvdzoKPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IHZxLT5sYXN0X3VzZWRfaWR4ICs9
IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubnVtOwo+ID4gPiA+ID4gPiBpZiAodW5saWtlbHko
dnEtPmxhc3RfdXNlZF9pZHggPj0gdnEtPnBhY2tlZC52cmluZy5udW0pKSB7Cj4gPiA+ID4gPiA+
ICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4IC09IHZxLT5wYWNrZWQudnJpbmcubnVtOwo+ID4g
PiA+ID4gPiAgICAgICAgICB2cS0+cGFja2VkLnVzZWRfd3JhcF9jb3VudGVyIF49IDE7Cj4gPiA+
ID4gPiA+IH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiBpdCBzZWVtcyB0byBiZSBmaW5lIHRvIGp1c3Qg
dHVybiBvZmYgdGhlIGludGVycnVwdHMgb2YgdGhlIGN1cnJlbnQgdnJpbmcuCj4gPiA+ID4gPgo+
ID4gPiA+ID4gQlIKPiA+ID4gPgo+ID4gPiA+IFRoYXQgd291bGQgbWFrZSBkYXRhcGF0aCBzaWdu
aWZpY2FudGx5IHNsb3dlci4KPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTDml6XlkajkupQgMjI6NTDl
hpnpgZPvvJoKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gRnJpLCBKdW4gMTAsIDIwMjIgYXQg
MDY6MzM6MTRQTSArMDgwMCwgaHVhbmdqaWUuYWxiZXJ0IHdyb3RlOgo+ID4gPiA+ID4gPiA+IGtz
b2Z0aXJxZCBtYXkgY29uc3VtZSB0aGUgcGFja2V0IGFuZCBpdCB3aWxsIGNhbGw6Cj4gPiA+ID4g
PiA+ID4gdmlydG5ldF9wb2xsCj4gPiA+ID4gPiA+ID4gICAgICAgLS0+dmlydG5ldF9yZWNlaXZl
Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAtLT52aXJ0cXVldWVfZ2V0X2J1Zl9jdHgKPiA+
ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgLS0+dmlydHF1ZXVlX2dldF9idWZfY3R4
X3BhY2tlZAo+ID4gPiA+ID4gPiA+IGFuZCBpbiB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfcGFja2Vk
Ogo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gdnEtPmxhc3RfdXNlZF9pZHggKz0gdnEtPnBh
Y2tlZC5kZXNjX3N0YXRlW2lkXS5udW07Cj4gPiA+ID4gPiA+ID4gaWYgKHVubGlrZWx5KHZxLT5s
YXN0X3VzZWRfaWR4ID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkgewo+ID4gPiA+ID4gPiA+ICAg
ICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4IC09IHZxLT5wYWNrZWQudnJpbmcubnVtOwo+ID4gPiA+
ID4gPiA+ICAgICAgICAgIHZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIgXj0gMTsKPiA+ID4g
PiA+ID4gPiB9Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBpZiBhdCB0aGUgc2FtZSB0aW1l
LCB0aGVyZSBjb21lcyBhIHZyaW5nIGludGVycnVwdO+8jGluIHZyaW5nX2ludGVycnVwdDoKPiA+
ID4gPiA+ID4gPiB3ZSB3aWxsIGNhbGw6Cj4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0Cj4g
PiA+ID4gPiA+ID4gICAgICAgLS0+bW9yZV91c2VkCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAtLT5tb3JlX3VzZWRfcGFja2VkCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
IC0tPmlzX3VzZWRfZGVzY19wYWNrZWQKPiA+ID4gPiA+ID4gPiBpbiBpc191c2VkX2Rlc2NfcGFj
a2VkLCB0aGUgbGFzdF91c2VkX2lkeCBtYXliZSA+PSB2cS0+cGFja2VkLnZyaW5nLm51bS4KPiA+
ID4gPiA+ID4gPiBzbyB0aGlzIGNvdWxkIGNhc2UgYSBtZW1vcnkgb3V0IG9mIGJvdW5kcyBidWcu
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiB0aGlzIHBhdGNoIGlzIHRvIGZpeCB0aGlzLgo+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogaHVhbmdqaWUuYWxiZXJ0
IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gVGhpcyBwYXR0ZXJuIHdhcyBhbHdheXMgaWZmeSwgYnV0IEkgZG9uJ3QgdGhp
bmsgdGhlIHBhdGNoCj4gPiA+ID4gPiA+IGltcHJvdmVzIHRoZSBzaXR1YXRpb24gbXVjaC4gbGFz
dF91c2VkX2lkeCBhbmQgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlcgo+ID4gPiA+ID4gPiBj
YW4gc3RpbGwgZ2V0IG91dCBvZiBzeW5jLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBNYXliZSBy
ZWZhY3RvciBjb2RlIHRvIGtlZXAgZXZlcnl0aGluZyBpbiB2cS0+bGFzdF91c2VkX2lkeD8KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gSmFzb24gd2hhdCBpcyB5b3VyIHRha2U/Cj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCAzICsrKwo+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiA+ID4gPiA+ID4gPiBpbmRleCAxM2E3MzQ4Y2VkZmYuLmQyYWJiYjNhODE4NyAxMDA2NDQK
PiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4g
PiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiA+IEBA
IC0xMzk3LDYgKzEzOTcsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfdXNlZF9kZXNjX3BhY2tl
ZChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+ID4gPiA+ID4gPiAgICAgICBi
b29sIGF2YWlsLCB1c2VkOwo+ID4gPiA+ID4gPiA+ICAgICAgIHUxNiBmbGFnczsKPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ICsgICAgIGlmIChpZHggPj0gdnEtPnBhY2tlZC52cmluZy5udW0p
Cj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+ICAgICAgIGZsYWdzID0gbGUxNl90b19jcHUodnEtPnBhY2tlZC52cmlu
Zy5kZXNjW2lkeF0uZmxhZ3MpOwo+ID4gPiA+ID4gPiA+ICAgICAgIGF2YWlsID0gISEoZmxhZ3Mg
JiAoMSA8PCBWUklOR19QQUNLRURfREVTQ19GX0FWQUlMKSk7Cj4gPiA+ID4gPiA+ID4gICAgICAg
dXNlZCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9VU0VEKSk7Cj4gPiA+
ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gPiAyLjI3LjAKPiA+ID4gPiA+ID4KPiA+ID4gPgo+ID4g
Pgo+ID4gPiBNaWNoYWVsIFMgLCB0aGFua3MgZm9yIHlvdXIgY29ycmVjdGlvbiwgdGhlcmUgbWF5
IGJlIGFub3RoZXIgc2ltcGxlCj4gPiA+IHNvbHV0aW9uIGhlcmU6Cj4gPiA+Cj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ID4gPiBpbmRleCAxM2E3MzQ4Y2VkZmYuLjRkYjRkYjE5Zjk0YSAxMDA2NDQK
PiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IEBAIC0xMzk3LDYgKzEzOTcsOSBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgaXNfdXNlZF9kZXNjX3BhY2tlZChjb25zdAo+ID4gPiBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSwKPiA+ID4gICAgICAgICBib29sIGF2YWlsLCB1c2VkOwo+ID4gPiAg
ICAgICAgIHUxNiBmbGFnczsKPiA+ID4KPiA+ID4gKyAgICAgICBpZiAoaWR4ID49IHZxLT5wYWNr
ZWQudnJpbmcubnVtKQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ID4gPiAr
Cj4gPiA+ICAgICAgICAgZmxhZ3MgPSBsZTE2X3RvX2NwdSh2cS0+cGFja2VkLnZyaW5nLmRlc2Nb
aWR4XS5mbGFncyk7Cj4gPiA+ICAgICAgICAgYXZhaWwgPSAhIShmbGFncyAmICgxIDw8IFZSSU5H
X1BBQ0tFRF9ERVNDX0ZfQVZBSUwpKTsKPiA+ID4gICAgICAgICB1c2VkID0gISEoZmxhZ3MgJiAo
MSA8PCBWUklOR19QQUNLRURfREVTQ19GX1VTRUQpKTsKPiA+ID4gQEAgLTE0NTMsOCArMTQ1Niw5
IEBAIHN0YXRpYyB2b2lkICp2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfcGFja2VkKHN0cnVjdAo+ID4g
PiB2aXJ0cXVldWUgKl92cSwKPiA+ID4KPiA+ID4gICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCAr
PSB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRdLm51bTsKPiA+ID4gICAgICAgICBpZiAodW5saWtl
bHkodnEtPmxhc3RfdXNlZF9pZHggPj0gdnEtPnBhY2tlZC52cmluZy5udW0pKSB7Cj4gPiA+IC0g
ICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsK
PiA+ID4gICAgICAgICAgICAgICAgIHZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIgXj0gMTsK
PiA+ID4gKyAgICAgICAgICAgICAgIGJhcnJpZXIoKTsKPiA+ID4gKyAgICAgICAgICAgICAgIHZx
LT5sYXN0X3VzZWRfaWR4IC09IHZxLT5wYWNrZWQudnJpbmcubnVtOwo+ID4gPiAgICAgICAgIH0K
PiA+ID4KPiA+ID4gICAgICAgICAvKgo+ID4gPgo+ID4gPiB2cS0+cGFja2VkLnVzZWRfd3JhcF9j
b3VudGVyICBhbmQgIHZxLT5sYXN0X3VzZWRfaWR4IG9ubHkgaW5jcmVhc2VkCj4gPiA+IGJ5IHRo
ZSB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfcGFja2VkLCBhbmQKPiA+ID4gc28gd2UgY2FuIGFkZCBh
IG1lbW9yeSBiYXJyaWVyIGFuZCBDaGFuZ2luZyB0aGUgb3JkZXIgaW4gd2hpY2gKPiA+ID4gbGFz
dF91c2VkX2lkeCAgYW5kIHVzZWRfd3JhcF9jb3VudGVyICBhcmUgYXNzaWduZWQKPiA+ID4gc2hv
dWxkIHRlbXBvcmFyaWx5IHNvbHZlIHRoZSBwcm9ibGVtLiBCdXQgYXMgeW91IHNhaWQsIHRoZSBj
b2RlIG1heQo+ID4gPiBuZWVkIHRvIGJlIHJlZmFjdG9yZWQgdG8gZnVsbHkgYWRkcmVzcyB0aGVz
ZSBraW5kcyBvZiBpc3N1ZXMuCj4gPiA+Cj4gPiA+IEJSCj4gPgo+ID4gdGhpcyBtaWdodCBzb2x2
ZSB0aGUgT09CIGFjY2VzcyBidXQgbm90IHRoZSBwcm9ibGVtIHRoYXQgaW50ZXJydXB0Cj4gPiBt
aWdodCB1c2UgYW4gaW5jb3JyZWN0IHZhbHVlIHRvIGNoZWNrIGZvciB0aGUgdXNlZCBpbmRleC4K
PiA+Cj4gCj4gWWVzLCB0aGFua3MgZm9yIHRoYXQsIGJ1dCBpdCBzZWVtcyB0aGF0IGl0IGNhbiBu
b3Qgc29sdmUgdGhlIHByb2JsZW0KPiB0aGF0IGludGVycnVwdAo+IG1pZ2h0IHVzZSBhbiBpbmNv
cnJlY3QgdmFsdWUgdG8gY2hlY2sgZm9yIHRoZSB1c2VkIGluZGV4IGlmIHdlIGRvIG5vdAo+IGRp
c2FibGUgaXJxIGluIHNvZnRpcnFkLgo+IHRoZSBmb2xsb3dpbmcgY29kZSBpbiB2aXJ0cXVldWVf
Z2V0X2J1Zl9jdHhfcGFja2VkOgo+IAo+ID4xNDUzICAgICAgLyogZGV0YWNoX2J1Zl9wYWNrZWQg
Y2xlYXJzIGRhdGEsIHNvIGdyYWIgaXQgbm93LiAqLwo+ID4xNDU0ICAgICAgIHJldCA9IHZxLT5w
YWNrZWQuZGVzY19zdGF0ZVtpZF0uZGF0YTsKPiA+MTQ1NSAgICAgICBkZXRhY2hfYnVmX3BhY2tl
ZCh2cSwgaWQsIGN0eCk7Cj4gPjE0NTYKPiA+MTQ1NyAgICAgIHZxLT5sYXN0X3VzZWRfaWR4ICs9
IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubnVtOwo+ID4xNDU4ICAgICAgaWYgKHVubGlrZWx5
KHZxLT5sYXN0X3VzZWRfaWR4ID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkgewo+ID4xNDU5ICAg
ICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHggLT0gdnEtPnBhY2tlZC52cmluZy5udW07Cj4gPjE0
NjAgICAgICAgICAgICB2cS0+cGFja2VkLnVzZWRfd3JhcF9jb3VudGVyIF49IDE7Cj4gPjE0NjEg
ICAgICB9Cj4gCj4gYWZ0ZXIgY2FsbCAgbGluZSAxNDU1LCB0aGUgcmVhbCBsYXN0X3VzZWRfaWR4
IHNob3VsZCBhZGQKPiB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRdLm51bSwgYnV0IGl0Cj4gYWRk
IGl0IGluIGxpbmUgMTQ1Ny4gaWYgdGhlIGludGVycnVwdCBjb21lcyBiZWZvcmUgMTQ1Nywgd2Ug
YWxzbyBnZXQKPiB0aGUgaW5jb3JyZWN0ICBsYXN0X3VzZWRfaWR4Lgo+IGRvIHlvdSBoYXZlIGFu
eSBnb29kIGNvbW1lbnRzPyBUaGlzIHByb2JsZW0gZXhpc3RzIGV2ZW4gaWYKPiBsYXN0X3VzZWRf
aWR4IGFuZCB1c2VkX3dyYXBfY291bnRlciBhcmUgbWVyZ2VkIGFuZCB0aGVpciBvcGVyYXRpb25z
Cj4gYXJlIGF0b21pYy4KPiAKPiBCUgoKVGhlIGFzc3VtcHRpb24gaXMgdGhhdCB3ZSBkbyBub3Qg
bmVlZCB0byB3b3JyeSBhYm91dAp0aGUgY2FzZSB3aGVyZSByaW5nIGFscmVhZHkgaGFkIHVzZWQg
YnVmZmVyczogdGhlc2UKYXJlIGdvaW5nIHRvIGJlIHBvbGxlZCBieSB0aGUgZHJpdmVyLgpXZSBk
byBuZWVkIHRvIHdvcnJ5IGFib3V0IGFueSBidWZmZXJzIGFkZGVkIGFmdGVyCmRyaXZlciBkcmFp
bnMgdGhlIHZxLgpJbiBvdGhlciB3b3JkcyB0aGUgam9iIG9mIHRoZSBjYWxsYmFjayBpcyB0byBz
aWduYWwKdG8gZHJpdmVyIHRoZSBubyB1c2VkIGJ1ZmZlcnMgLT4gc29tZSB1c2VkIGJ1ZmZlcnMK
Y29uZGl0aW9uLgpUaGlzIGlnbm9yZXMgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
