Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D674C43334
	for <virtualization@archiver.kernel.org>; Sun, 12 Jun 2022 14:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D60C4108F;
	Sun, 12 Jun 2022 14:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O3gWd271JEEs; Sun, 12 Jun 2022 14:13:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E34714019A;
	Sun, 12 Jun 2022 14:13:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6AD3C0032;
	Sun, 12 Jun 2022 14:13:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C443C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 14:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 757C68132F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 14:13:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8-5ruYHA9S4M
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 14:13:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 214BB81327
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655043215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uY/1FXsx9O5koHqCs/XSCktrCHMDbUDFOPZy1ri1C3c=;
 b=UaFPlh0DCiLu9r/nN9LQWoc2i9YvVutsnHDo8xj1Q74HyR5j3SIkQ/cSTx4DaSy7eDSdOk
 WNH0tnl5byaQ0CxlpwvPTCTAuRlv4gNY3spxejfuAhsJIb2JiScdNG6tZmFkWJZolXVwXz
 pFmUk7qQamMBXzetdCOk7eCNhypgaGk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-bJj38UbrNQmGkZL82Q5jjg-1; Sun, 12 Jun 2022 10:13:34 -0400
X-MC-Unique: bJj38UbrNQmGkZL82Q5jjg-1
Received: by mail-wm1-f69.google.com with SMTP id
 o23-20020a05600c511700b0039743cd8093so1634979wms.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 07:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uY/1FXsx9O5koHqCs/XSCktrCHMDbUDFOPZy1ri1C3c=;
 b=kq2oOogsp8ibd391YpY9FppTspFfzVeE/qA7CJz3C1NWMR7VK5TSEaKBTwVUU8nuub
 yisimnmVmVtAYwguTy9wsYUXN7MKBL++0kfqLEpLSYXPzMLOPwxumT66VedsUxwneQcX
 GsJq811Oll1yJ+sC3A+nfK5SeNV18KxB7dRqvCvjWh1nSTLMsAVfSspRgYQm7VClwoS2
 l5YzxJRrZPwTUM3i8oOxBPOv69ipEXG8jicZ97ULzRGzJoo4nj3eH31izhL6TvLB7nWS
 gjRuuFjpjz51uPRNBhY8XuzekUEhzb3pX8cY46+vzkvEdDK36HBjlezRIUEtuHC4pAN/
 O1Cw==
X-Gm-Message-State: AOAM5322YJqVRTXFbOQwii3vM8BPhId8YtLrN9fUSUa6r1CP+EyjzrKp
 PisMqbF/sRlDiQeaJaWvVuAGzXp0btcHzKtyG26slbguaHN49XPJJOSff2o+ITgiEnkhQb2lCgk
 5VkvUS3rF8tcG29PoPm3vQywGIE9CRso3usqwHaG8NA==
X-Received: by 2002:a05:600c:4ca7:b0:39c:422a:fc6f with SMTP id
 g39-20020a05600c4ca700b0039c422afc6fmr9744689wmp.55.1655043213115; 
 Sun, 12 Jun 2022 07:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJzi2V2qnwgQB063G1Yn3kDLjmdIoCmF8eMxiSLWTAUUu3mFWcKLdDx/hgB0Qpl1DNx5gLFA==
X-Received: by 2002:a05:600c:4ca7:b0:39c:422a:fc6f with SMTP id
 g39-20020a05600c4ca700b0039c422afc6fmr9744666wmp.55.1655043212819; 
 Sun, 12 Jun 2022 07:13:32 -0700 (PDT)
Received: from redhat.com ([2.55.40.97]) by smtp.gmail.com with ESMTPSA id
 d9-20020a5d6449000000b002101ed6e70fsm5704709wrw.37.2022.06.12.07.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jun 2022 07:13:32 -0700 (PDT)
Date: Sun, 12 Jun 2022 10:13:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Subject: Re: [External] Re: [PATCH] virtio_ring : fix vring_packed_desc
 memory out of bounds bug
Message-ID: <20220612100945-mutt-send-email-mst@kernel.org>
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
 <20220610103905-mutt-send-email-mst@kernel.org>
 <CABKxMyPTLJ0bbxb23C_aeucVEP8MYNiFz1y9d8eGA4Bvdyey3g@mail.gmail.com>
 <20220610203449-mutt-send-email-mst@kernel.org>
 <CABKxMyOYrjUDvWggK=rnBZcRuaO9x=wHWq15MgAQz5_Fbtypxg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABKxMyOYrjUDvWggK=rnBZcRuaO9x=wHWq15MgAQz5_Fbtypxg@mail.gmail.com>
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

T24gU3VuLCBKdW4gMTIsIDIwMjIgYXQgMDc6MDI6MjVQTSArMDgwMCwg6buE5p2wIHdyb3RlOgo+
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTHml6Xl
kajlha0gMDg6MzXlhpnpgZPvvJoKPiA+Cj4gPiBPbiBTYXQsIEp1biAxMSwgMjAyMiBhdCAxMjoz
ODoxMEFNICswODAwLCDpu4TmnbAgd3JvdGU6Cj4gPiA+ID4gVGhpcyBwYXR0ZXJuIHdhcyBhbHdh
eXMgaWZmeSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoCj4gPiA+ID4gaW1wcm92ZXMgdGhl
IHNpdHVhdGlvbiBtdWNoLiBsYXN0X3VzZWRfaWR4IGFuZCB2cS0+cGFja2VkLnVzZWRfd3JhcF9j
b3VudGVyCj4gPiA+ID4gY2FuIHN0aWxsIGdldCBvdXQgb2Ygc3luYy4KPiA+ID4KPiA+ID4gWWVz
77yMIFlvdSBhcmUgYWJzb2x1dGVseSBjb3JyZWN0LCB0aGFua3MgZm9yIHBvaW50aW5nIG91dCB0
aGlzIGlzc3VlLCBJCj4gPiA+IGRpZG4ndCB0YWtlIHRoYXQgaW50byBjb25zaWRlcmF0aW9uLAo+
ID4gPiBob3cgYWJvdXQgZGlzYWJsaW5nIGludGVycnVwdHMgYmVmb3JlIHRoaXMgY29kZSBiZWxv
dzoKPiA+ID4KPiA+ID4gPiB2cS0+bGFzdF91c2VkX2lkeCArPSB2cS0+cGFja2VkLmRlc2Nfc3Rh
dGVbaWRdLm51bTsKPiA+ID4gPiBpZiAodW5saWtlbHkodnEtPmxhc3RfdXNlZF9pZHggPj0gdnEt
PnBhY2tlZC52cmluZy5udW0pKSB7Cj4gPiA+ID4gICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHgg
LT0gdnEtPnBhY2tlZC52cmluZy5udW07Cj4gPiA+ID4gICAgICAgICAgdnEtPnBhY2tlZC51c2Vk
X3dyYXBfY291bnRlciBePSAxOwo+ID4gPiA+IH0KPiA+ID4KPiA+ID4gaXQgc2VlbXMgdG8gYmUg
ZmluZSB0byBqdXN0IHR1cm4gb2ZmIHRoZSBpbnRlcnJ1cHRzIG9mIHRoZSBjdXJyZW50IHZyaW5n
Lgo+ID4gPgo+ID4gPiBCUgo+ID4KPiA+IFRoYXQgd291bGQgbWFrZSBkYXRhcGF0aCBzaWduaWZp
Y2FudGx5IHNsb3dlci4KPiA+Cj4gPiA+Cj4gPiA+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTDml6XlkajkupQgMjI6NTDlhpnpgZPvvJoKPiA+ID4g
Pgo+ID4gPiA+IE9uIEZyaSwgSnVuIDEwLCAyMDIyIGF0IDA2OjMzOjE0UE0gKzA4MDAsIGh1YW5n
amllLmFsYmVydCB3cm90ZToKPiA+ID4gPiA+IGtzb2Z0aXJxZCBtYXkgY29uc3VtZSB0aGUgcGFj
a2V0IGFuZCBpdCB3aWxsIGNhbGw6Cj4gPiA+ID4gPiB2aXJ0bmV0X3BvbGwKPiA+ID4gPiA+ICAg
ICAgIC0tPnZpcnRuZXRfcmVjZWl2ZQo+ID4gPiA+ID4gICAgICAgICAgICAgICAtLT52aXJ0cXVl
dWVfZ2V0X2J1Zl9jdHgKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLT52aXJ0cXVl
dWVfZ2V0X2J1Zl9jdHhfcGFja2VkCj4gPiA+ID4gPiBhbmQgaW4gdmlydHF1ZXVlX2dldF9idWZf
Y3R4X3BhY2tlZDoKPiA+ID4gPiA+Cj4gPiA+ID4gPiB2cS0+bGFzdF91c2VkX2lkeCArPSB2cS0+
cGFja2VkLmRlc2Nfc3RhdGVbaWRdLm51bTsKPiA+ID4gPiA+IGlmICh1bmxpa2VseSh2cS0+bGFz
dF91c2VkX2lkeCA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkpIHsKPiA+ID4gPiA+ICAgICAgICAg
IHZxLT5sYXN0X3VzZWRfaWR4IC09IHZxLT5wYWNrZWQudnJpbmcubnVtOwo+ID4gPiA+ID4gICAg
ICAgICAgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlciBePSAxOwo+ID4gPiA+ID4gfQo+ID4g
PiA+ID4KPiA+ID4gPiA+IGlmIGF0IHRoZSBzYW1lIHRpbWUsIHRoZXJlIGNvbWVzIGEgdnJpbmcg
aW50ZXJydXB077yMaW4gdnJpbmdfaW50ZXJydXB0Ogo+ID4gPiA+ID4gd2Ugd2lsbCBjYWxsOgo+
ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0Cj4gPiA+ID4gPiAgICAgICAtLT5tb3JlX3VzZWQKPiA+
ID4gPiA+ICAgICAgICAgICAgICAgLS0+bW9yZV91c2VkX3BhY2tlZAo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgIC0tPmlzX3VzZWRfZGVzY19wYWNrZWQKPiA+ID4gPiA+IGluIGlzX3Vz
ZWRfZGVzY19wYWNrZWQsIHRoZSBsYXN0X3VzZWRfaWR4IG1heWJlID49IHZxLT5wYWNrZWQudnJp
bmcubnVtLgo+ID4gPiA+ID4gc28gdGhpcyBjb3VsZCBjYXNlIGEgbWVtb3J5IG91dCBvZiBib3Vu
ZHMgYnVnLgo+ID4gPiA+ID4KPiA+ID4gPiA+IHRoaXMgcGF0Y2ggaXMgdG8gZml4IHRoaXMuCj4g
PiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogaHVhbmdqaWUuYWxiZXJ0IDxodWFuZ2pp
ZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBwYXR0
ZXJuIHdhcyBhbHdheXMgaWZmeSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoCj4gPiA+ID4g
aW1wcm92ZXMgdGhlIHNpdHVhdGlvbiBtdWNoLiBsYXN0X3VzZWRfaWR4IGFuZCB2cS0+cGFja2Vk
LnVzZWRfd3JhcF9jb3VudGVyCj4gPiA+ID4gY2FuIHN0aWxsIGdldCBvdXQgb2Ygc3luYy4KPiA+
ID4gPgo+ID4gPiA+IE1heWJlIHJlZmFjdG9yIGNvZGUgdG8ga2VlcCBldmVyeXRoaW5nIGluIHZx
LT5sYXN0X3VzZWRfaWR4Pwo+ID4gPiA+Cj4gPiA+ID4gSmFzb24gd2hhdCBpcyB5b3VyIHRha2U/
Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYyB8IDMgKysrCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gaW5k
ZXggMTNhNzM0OGNlZGZmLi5kMmFiYmIzYTgxODcgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiBAQCAtMTM5Nyw2ICsxMzk3LDkgQEAgc3RhdGljIGlubGlu
ZSBib29sIGlzX3VzZWRfZGVzY19wYWNrZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEsCj4gPiA+ID4gPiAgICAgICBib29sIGF2YWlsLCB1c2VkOwo+ID4gPiA+ID4gICAgICAgdTE2
IGZsYWdzOwo+ID4gPiA+ID4KPiA+ID4gPiA+ICsgICAgIGlmIChpZHggPj0gdnEtPnBhY2tlZC52
cmluZy5udW0pCj4gPiA+ID4gPiArICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICAgICAgIGZsYWdzID0gbGUxNl90b19jcHUodnEtPnBhY2tlZC52cmluZy5k
ZXNjW2lkeF0uZmxhZ3MpOwo+ID4gPiA+ID4gICAgICAgYXZhaWwgPSAhIShmbGFncyAmICgxIDw8
IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfQVZBSUwpKTsKPiA+ID4gPiA+ICAgICAgIHVzZWQgPSAhIShm
bGFncyAmICgxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfVVNFRCkpOwo+ID4gPiA+ID4gLS0KPiA+
ID4gPiA+IDIuMjcuMAo+ID4gPiA+Cj4gPgo+IAo+IE1pY2hhZWwgUyAsIHRoYW5rcyBmb3IgeW91
ciBjb3JyZWN0aW9uLCB0aGVyZSBtYXkgYmUgYW5vdGhlciBzaW1wbGUKPiBzb2x1dGlvbiBoZXJl
Ogo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDEzYTczNDhjZWRmZi4uNGRiNGRiMTlmOTRh
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTEzOTcsNiArMTM5Nyw5IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCBpc191c2VkX2Rlc2NfcGFja2VkKGNvbnN0Cj4gc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSAqdnEsCj4gICAgICAgICBib29sIGF2YWlsLCB1c2VkOwo+ICAgICAgICAgdTE2IGZsYWdz
Owo+IAo+ICsgICAgICAgaWYgKGlkeCA+PSB2cS0+cGFja2VkLnZyaW5nLm51bSkKPiArICAgICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICsKPiAgICAgICAgIGZsYWdzID0gbGUxNl90b19jcHUo
dnEtPnBhY2tlZC52cmluZy5kZXNjW2lkeF0uZmxhZ3MpOwo+ICAgICAgICAgYXZhaWwgPSAhIShm
bGFncyAmICgxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfQVZBSUwpKTsKPiAgICAgICAgIHVzZWQg
PSAhIShmbGFncyAmICgxIDw8IFZSSU5HX1BBQ0tFRF9ERVNDX0ZfVVNFRCkpOwo+IEBAIC0xNDUz
LDggKzE0NTYsOSBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3BhY2tlZChz
dHJ1Y3QKPiB2aXJ0cXVldWUgKl92cSwKPiAKPiAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4ICs9
IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubnVtOwo+ICAgICAgICAgaWYgKHVubGlrZWx5KHZx
LT5sYXN0X3VzZWRfaWR4ID49IHZxLT5wYWNrZWQudnJpbmcubnVtKSkgewo+IC0gICAgICAgICAg
ICAgICB2cS0+bGFzdF91c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsKPiAgICAgICAg
ICAgICAgICAgdnEtPnBhY2tlZC51c2VkX3dyYXBfY291bnRlciBePSAxOwo+ICsgICAgICAgICAg
ICAgICBiYXJyaWVyKCk7Cj4gKyAgICAgICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4IC09IHZx
LT5wYWNrZWQudnJpbmcubnVtOwo+ICAgICAgICAgfQo+IAo+ICAgICAgICAgLyoKPiAKPiB2cS0+
cGFja2VkLnVzZWRfd3JhcF9jb3VudGVyICBhbmQgIHZxLT5sYXN0X3VzZWRfaWR4IG9ubHkgaW5j
cmVhc2VkCj4gYnkgdGhlIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQsIGFuZAo+IHNvIHdl
IGNhbiBhZGQgYSBtZW1vcnkgYmFycmllciBhbmQgQ2hhbmdpbmcgdGhlIG9yZGVyIGluIHdoaWNo
Cj4gbGFzdF91c2VkX2lkeCAgYW5kIHVzZWRfd3JhcF9jb3VudGVyICBhcmUgYXNzaWduZWQKPiBz
aG91bGQgdGVtcG9yYXJpbHkgc29sdmUgdGhlIHByb2JsZW0uIEJ1dCBhcyB5b3Ugc2FpZCwgdGhl
IGNvZGUgbWF5Cj4gbmVlZCB0byBiZSByZWZhY3RvcmVkIHRvIGZ1bGx5IGFkZHJlc3MgdGhlc2Ug
a2luZHMgb2YgaXNzdWVzLgo+IAo+IEJSCgp0aGlzIG1pZ2h0IHNvbHZlIHRoZSBPT0IgYWNjZXNz
IGJ1dCBub3QgdGhlIHByb2JsZW0gdGhhdCBpbnRlcnJ1cHQKbWlnaHQgdXNlIGFuIGluY29ycmVj
dCB2YWx1ZSB0byBjaGVjayBmb3IgdGhlIHVzZWQgaW5kZXguCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
