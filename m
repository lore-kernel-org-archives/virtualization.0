Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DFEC6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9146060EC4;
	Fri, 24 Mar 2023 06:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9146060EC4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EERxgPU/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3F-XVtFRM7zP; Fri, 24 Mar 2023 06:42:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B697960B33;
	Fri, 24 Mar 2023 06:42:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B697960B33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99878C0035;
	Fri, 24 Mar 2023 06:42:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E810C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1379C60E28
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:42:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1379C60E28
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dXhAiTe_b66I
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:42:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A60D460B33
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A60D460B33
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679640152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmdb6j6ItYOZ/8VqzMFnrYnH4ti/eMeg7F+hPFB/9iw=;
 b=EERxgPU/2cldMUFS64vLZqaHSkyjzJBzfFOWxayP45t+xkH7zGBXgmctUWsNuCgxq6C0nX
 r4SiPE8ZrnlhBQ9qbi5HuC4u7RW5UC8O5wxVjnLe2Srft3NA+8s5ciJRyMHEvI4FoQvSMy
 AOe8iwRMAQ84dkVnlwLnSEWdtwafNe8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-V2QAwP5KNgCoZC4SarS9gA-1; Fri, 24 Mar 2023 02:42:31 -0400
X-MC-Unique: V2QAwP5KNgCoZC4SarS9gA-1
Received: by mail-wm1-f72.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so545828wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 23:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679640149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmdb6j6ItYOZ/8VqzMFnrYnH4ti/eMeg7F+hPFB/9iw=;
 b=oruD9NrwyaghoFUVgR79jvBtgn79dYNIkkKbZiqtMh6wqxGOxXbKIEBLvUFSzDVuvF
 SIxH0WzOpAPRDqQLqOQAFi3RXTKXxzZ9OI/1L4rruZ++uqFX08cR8CIT309xI4+viHUf
 hrNEEZz8a89KI1oZDIZM7dY/VBACpDE2aHu26+s1Ro4nPBzOr1Fx0P1iMMuoGIjYx2W8
 sVSRJeLSbm6gQJwR2/N+ow8H2rV94hzSNQRjaxaskdNe0GT8uTEqPCXfV8ajWdxWh5XB
 zhgEaQbljg9Bl2jx1c3tDKMK7JLmHQRhCkjYTaJ7Ah2XmPKR6IFsmdGPz56EtftPm1U0
 JPmg==
X-Gm-Message-State: AO0yUKWQZ45nOVRnV5o5yieNagzGhFZUG7o0csIv1MV/HFUl7PKAuSed
 bGMaJzlIUyETHuM8PVj2nmln98bExXpjNNyyV6AsfkdWrerZAJhlJCNi1fIlLzDnsg9zWDvYIuS
 GolupCU/tbyI6IK9wBbny6EU2wFd2WpBZZCbZi3RF6pSY70aERA==
X-Received: by 2002:a7b:c8c3:0:b0:3ed:f5b5:37fc with SMTP id
 f3-20020a7bc8c3000000b003edf5b537fcmr1561240wml.1.1679640149480; 
 Thu, 23 Mar 2023 23:42:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set8qEkJsxwBH6JavY2EvJWIrGXnnEjIkZNbHFxl/rDprhEPzTouh1Y39uZ3gHFMz6zhoHicYng==
X-Received: by 2002:a7b:c8c3:0:b0:3ed:f5b5:37fc with SMTP id
 f3-20020a7bc8c3000000b003edf5b537fcmr1561230wml.1.1679640149160; 
 Thu, 23 Mar 2023 23:42:29 -0700 (PDT)
Received: from redhat.com ([2.52.12.190]) by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c378e00b003ed2276cd0dsm3910041wmr.38.2023.03.23.23.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 23:42:28 -0700 (PDT)
Date: Fri, 24 Mar 2023 02:42:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
Message-ID: <20230324024155-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
 <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
 <20230324013805-mutt-send-email-mst@kernel.org>
 <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvAvOCCuB4QRQa1goAhWEyXfTiJahTT7NQ+HT3J0GUNyw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMDI6MzI6NDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBGcmksIE1hciAyNCwgMjAyMyBhdCAxOjU54oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQg
MTE6NDE6MTJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gT24gVGh1LCBNYXIgMjMs
IDIwMjMgYXQgNDowMeKAr1BNIOm7hOadsCA8aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+
IHdyb3RlOgo+ID4gPiA+Cj4gPiA+ID4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
5LqOMjAyM+W5tDPmnIgyMuaXpeWRqOS4iSAxMDozN+WGmemBk++8mgo+ID4gPiA+ID4KPiA+ID4g
PiA+IE9uIFR1ZSwgTWFyIDIxLCAyMDIzIGF0IDU6MDDigK9QTSBBbGJlcnQgSHVhbmcKPiA+ID4g
PiA+IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IEZyb206ICJodWFuZ2ppZS5hbGJlcnQiIDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRh
bmNlLmNvbT4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZml4IGNvbW1pdCA4ZDYyMmQyMWQyNDgg
KCJ2aXJ0aW86IGZpeCB1cCB2aXJ0aW9fZGlzYWJsZV9jYiIpCj4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+IGlmIHdlIGRpc2FibGUgdGhlIG5hcGlfdHguIHdoZW4gd2UgdHJpZ2VyIGEgdHggaW50ZXJy
dXB0LCB0aGUKPiA+ID4gPiA+Cj4gPiA+ID4gPiB0eXBvIHNob3VsZCBiZSAidHJpZ2dlciIKPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBPSywgdGhhbmtzIGZvciB0aGlzLiBJIHdpbGwgY29ycmVj
dCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uCj4gPiA+ID4KPiA+ID4gPiA+ID4gdnEtPmV2ZW50X3Ry
aWdnZXJlZCB3aWxsIGJlIHNldCB0byB0cnVlLiBJdCB3aWxsIG5vIGxvbmdlciBiZQo+ID4gPiA+
ID4gPiBzZXQgdG8gZmFsc2UuIFVubGVzcyB3ZSBleHBsaWNpdGx5IGNhbGwgdmlydHF1ZXVlX2Vu
YWJsZV9jYl9kZWxheWVkCj4gPiA+ID4gPiA+IG9yIHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFy
ZQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBpZiB3ZSBkaXNhYmxlIHRoZSBuYXBpX3R4LCBJdCB3
aWxsIG9ubHkgYmUgY2FsbGVkIHdoZW4gdGhlIHR4IHJpbmcKPiA+ID4gPiA+ID4gYnVmZmVyIGlz
IHJlbGF0aXZlbHkgc21hbGw6Cj4gPiA+ID4gPiA+IHZpcnRpb19uZXQtPnN0YXJ0X3htaXQ6Cj4g
PiA+ID4gPiA+ICAgICAgICAgaWYgKHNxLT52cS0+bnVtX2ZyZWUgPCAyK01BWF9TS0JfRlJBR1Mp
IHsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIG5ldGlmX3N0b3Bfc3VicXVldWUoZGV2LCBx
bnVtKTsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGlmICghdXNlX25hcGkgJiYKPiA+ID4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICB1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9jYl9k
ZWxheWVkKHNxLT52cSkpKSB7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8q
IE1vcmUganVzdCBnb3QgdXNlZCwgZnJlZSB0aGVtIHRoZW4gcmVjaGVjay4gKi8KPiA+ID4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9vbGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7
Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVl
ID49IDIrTUFYX1NLQl9GUkFHUykgewo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZx
KTsKPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4KPiA+ID4g
PiA+IFRoZSBjb2RlIGV4YW1wbGUgaGVyZSBpcyBvdXQgb2YgZGF0ZSwgbWFrZSBzdXJlIHlvdXIg
dHJlZSBoYXMgdGhpczoKPiA+ID4gPgo+ID4gPiA+IGFsc28sIEkgd2lsbCBjb3JyZWN0IGl0IGlu
IHRoZSBuZXh0IHZlcnNpb27vvIx0aGlzIGlzIGZyb20ga2VybmVsIDUuMTUuCj4gPiA+ID4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBjb21taXQgZDcxZWJlODExNGI0YmY2MjI4MDRiODEwZjVlMjc0MDY5
MDYwYTE3NAo+ID4gPiA+ID4gQXV0aG9yOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pgo+ID4gPiA+ID4gRGF0ZTogICBUdWUgSmFuIDE3IDExOjQ3OjA3IDIwMjMgKzA4MDAKPiA+ID4g
PiA+Cj4gPiA+ID4gPiAgICAgdmlydGlvLW5ldDogY29ycmVjdGx5IGVuYWJsZSBjYWxsYmFjayBk
dXJpbmcgc3RhcnRfeG1pdAo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIH0K
PiA+ID4gPiA+ID4gICAgICAgICB9Cj4gPiA+ID4gPiA+IEJlY2F1c2UgZXZlbnRfdHJpZ2dlcmVk
IGlzIHRydWUuVGhlcmVmb3JlLCBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCBvcgo+ID4gPiA+
ID4gPiBWUklOR19QQUNLRURfRVZFTlRfRkxBR19ESVNBQkxFIHdpbGwgbm90IGJlIHNldC5TbyB3
ZSB1cGRhdGUKPiA+ID4gPiA+ID4gdnJpbmdfdXNlZF9ldmVudCgmdnEtPnNwbGl0LnZyaW5nKSBv
ciB2cS0+cGFja2VkLnZyaW5nLmRyaXZlci0+b2ZmX3dyYXAKPiA+ID4gPiA+ID4gZXZlcnkgdGlt
ZSB3ZSBjYWxsIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eC5UaGlzIHdpbGwgYnJpbmcgbW9yZSBpbnRl
cnJ1cHRpb25zLgo+ID4gPiA+ID4KPiA+ID4gPiA+IENhbiB5b3UgcGxlYXNlIHBvc3QgaG93IHRv
IHRlc3Qgd2l0aCB0aGUgcGVyZm9ybWFuY2UgbnVtYmVycz8KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+
ID4gPiBpcGVyZjMgdGNwIHN0cmVhbToKPiA+ID4gPiB2bTEgLS0tLS0tLS0tLS0tLS0tLS0+IHZt
Mgo+ID4gPiA+IHZtMiBqdXN0IHJlY2VpdmUgdGNwIGRhdGEgc3RyZWFtIGZyb20gdm0xLCBhbmQg
c2VuZCB0aGUgYWNrIHRvIHZtMSwKPiA+ID4gPiB0aGVyZSBhcmUgc28KPiA+ID4gPiBtYW55IHR4
IGludGVycnVwdGlvbnMgIGluIHZtMi4KPiA+ID4gPgo+ID4gPiA+IGJ1dCB3aXRob3V0IGV2ZW50
X3RyaWdnZXJlZCB0aGVyZSBhcmUganVzdCBhIGZldyB0eCBpbnRlcnJ1cHRpb25zLgo+ID4gPiA+
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IGlmIGV2ZW50X3RyaWdnZXJlZCBpcyBzZXQgdG8gdHJ1
ZSwgZG8gbm90IHVwZGF0ZSB2cmluZ191c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJpbmcpCj4gPiA+
ID4gPiA+IG9yIHZxLT5wYWNrZWQudnJpbmcuZHJpdmVyLT5vZmZfd3JhcAo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBodWFuZ2ppZS5hbGJlcnQgPGh1YW5namllLmFsYmVy
dEBieXRlZGFuY2UuY29tPgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgfCA2ICsrKystLQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+IGluZGV4IDMwN2UxMzljYjExZC4uZjQ4NmNjY2Fk
YmViIDEwMDY0NAo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiA+
ID4gQEAgLTc5NSw3ICs3OTUsOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4
X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ID4gPiA+ID4gICAgICAgICAvKiBJZiB3
ZSBleHBlY3QgYW4gaW50ZXJydXB0IGZvciB0aGUgbmV4dCBlbnRyeSwgdGVsbCBob3N0Cj4gPiA+
ID4gPiA+ICAgICAgICAgICogYnkgd3JpdGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRo
ZSB3cml0ZSBiZWZvcmUKPiA+ID4gPiA+ID4gICAgICAgICAgKiB0aGUgcmVhZCBpbiB0aGUgbmV4
dCBnZXRfYnVmIGNhbGwuICovCj4gPiA+ID4gPiA+IC0gICAgICAgaWYgKCEodnEtPnNwbGl0LmF2
YWlsX2ZsYWdzX3NoYWRvdyAmIFZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUKSkKPiA+ID4gPiA+
ID4gKyAgICAgICBpZiAoISh2cS0+c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93ICYgVlJJTkdfQVZB
SUxfRl9OT19JTlRFUlJVUFQpCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICYm
ICh2cS0+ZXZlbnRfdHJpZ2dlcmVkID09IGZhbHNlKSkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBJJ20g
bm90IHN1cmUgdGhpcyBjYW4gd29yaywgd2hlbiBldmVudF90cmlnZ2VyZWQgaXMgdHJ1ZSBpdCBt
ZWFucwo+ID4gPiA+ID4gd2UndmUgZ290IGFuIGludGVycnVwdCwgaW4gdGhpcyBjYXNlIGlmIHdl
IHdhbnQgYW5vdGhlciBpbnRlcnJ1cHQgZm9yCj4gPiA+ID4gPiB0aGUgbmV4dCBlbnRyeSwgd2Ug
c2hvdWxkIHVwZGF0ZSB1c2VkX2V2ZW50IG90aGVyd2lzZSB3ZSB3aWxsIGxvc2UKPiA+ID4gPiA+
IHRoYXQgaW50ZXJydXB0Pwo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+
ID4gTm9ybWFsbHksIGlmIHdlIHJlY2VpdmUgYW4gaW50ZXJydXB0LCB3ZSBzaG91bGQgZGlzYWJs
ZSB0aGUgaW50ZXJydXB0Cj4gPiA+ID4gaW4gdGhlIGludGVycnVwdCBjYWxsYmFjayBoYW5kbGVy
Lgo+ID4gPgo+ID4gPiBTbyB0aGUgcHJvYmxlbSBpczoKPiA+ID4KPiA+ID4gMSkgZXZlbnRfdHJp
Z2dlcmVkIHdhcyBzZXQgdG8gdHJ1ZSBpbiB2cmluZ19pbnRlcnJ1cHQoKQo+ID4gPgo+ID4gPiAy
KSBhZnRlciB0aGlzIG5vdGhpbmcgd2lsbCBoYXBwZW4gZm9yIHZpcnRxdWV1ZV9kaXNhYmxlX2Ni
KCkgc28KPiA+ID4gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgaXMgbm90IHNldCBpbiBhdmFp
bF9mbGFnc19zaGFkb3cKPiA+ID4gMykgdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KCkgd2ls
bCBzdGlsbCB0aGluayB0aGUgY2IgaXMgZW5hYmxlZAo+ID4gPiB0aGVuIGl0IHRyaWVzIHRvIHB1
Ymxpc2ggbmV3IGV2ZW50Cj4gPgo+ID4gT2guIEdvb2QgcG9pbnQhIEkgdGhpbmsgd2hlbiBJIHdy
b3RlIHVwCj4gPiA4ZDYyMmQyMWQyNDggKCJ2aXJ0aW86IGZpeCB1cCB2aXJ0aW9fZGlzYWJsZV9j
YiIpCj4gPiBJIG1pc3NlZCB0aGlzIGNvcm5lciBjYXNlLgo+ID4KPiA+Cj4gPgo+ID4gPiBUaGlz
IG1ha2VzIG1lIHRoaW5rIGFib3V0IHdoZXRoZXIgb3Igbm90IHdlIHJlYWxseSBuZWVkCj4gPiA+
IGV2ZW50X3RyaWdnZXJlZC4gVGhlIGFzc3VtcHRpb24gaW4gdGhlIHZpcnRxdWV1ZV9kaXNhYmxl
X2NiKCkgc2VlbXMKPiA+ID4gd3Jvbmc6Cj4gPiA+Cj4gPiA+IC8qIElmIGRldmljZSB0cmlnZ2Vy
ZWQgYW4gZXZlbnQgYWxyZWFkeSBpdCB3b24ndCB0cmlnZ2VyIG9uZSBhZ2FpbjoKPiA+ID4gICog
bm8gbmVlZCB0byBkaXNhYmxlLgo+ID4gPiAgKi8KPiA+ID4gaWYgKHZxLT5ldmVudF90cmlnZ2Vy
ZWQpCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+Cj4gPiA+IFRoaXMgaXMgd3Jv
bmcgaWYgdGhlcmUncyBubyBldmVudCBpbmRleCBzdXBwb3J0Lgo+ID4KPiA+Cj4gPiBJIGRvbid0
IGdldCBpdC4gIGhvdyBkb2VzIHRoaXMgZ2V0IHRyaWdnZXJlZD8KPiA+Cj4gPiBZb3UgYXJlIHRh
bGtpbmcgYWJvdXQgZGV2aWNlIHdpdGhvdXQgZXZlbnQgaW5kZXg/Cj4gPiBIZXJlJ3MgY29kZSBm
cm9tIHZyaW5nX2ludGVycnVwdCgpOgo+ID4KPiA+ICAgICAgICAgLyogSnVzdCBhIGhpbnQgZm9y
IHBlcmZvcm1hbmNlOiBzbyBpdCdzIG9rIHRoYXQgdGhpcyBjYW4gYmUgcmFjeSEgKi8KPiA+ICAg
ICAgICAgaWYgKHZxLT5ldmVudCkKPiA+ICAgICAgICAgICAgICAgICB2cS0+ZXZlbnRfdHJpZ2dl
cmVkID0gdHJ1ZTsKPiAKPiBCdXQgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIGluIHZpcnRxdWV1ZV9k
aXNhYmxlX2NiKCk6Cj4gCj4gICAgICAgICAvKiBJZiBkZXZpY2UgdHJpZ2dlcmVkIGFuIGV2ZW50
IGFscmVhZHkgaXQgd29uJ3QgdHJpZ2dlciBvbmUgYWdhaW46Cj4gICAgICAgICAgKiBubyBuZWVk
IHRvIGRpc2FibGUuCj4gICAgICAgICAgKi8KPiAgICAgICAgIGlmICh2cS0+ZXZlbnRfdHJpZ2dl
cmVkKQo+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4gCj4gICAgICAgICBpZiAodnEtPnBhY2tl
ZF9yaW5nKQo+ICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYl9wYWNrZWQoX3Zx
KTsKPiAgICAgICAgIGVsc2UKPiAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Jf
c3BsaXQoX3ZxKTsKPiAKPiBUaGlzIG1lYW5zLCB3aXRob3V0IGFuIGV2ZW50IGluZGV4LCB3ZSBk
b24ndCBzZXQgYXZhaWwgZmxhZ3MuIFNvIHRoZQo+IGludGVycnVwdCBpcyBub3QgZGlzYWJsZWQg
YWN0dWFsbHkgaW4gdGhpcyBjYXNlLgo+IAo+IFRoYW5rcwoKT25seSBpZiBldmVudF90cmlnZ2Vy
ZWQgaXMgdHJ1ZSwgd2hpY2ggd2l0aG91dCBldmVudCBpbmRleCBpdCBuZXZlciBpcy4KCj4gPgo+
ID4KPiA+Cj4gPgo+ID4gPiBBbmQgdGhlCj4gPiA+IGV2ZW50X3RyaWdnZXJlZCBpcyBzb21laG93
IGR1cGxpY2F0ZWQgd2l0aCB0aGUKPiA+ID4gVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQgaW4g
dGhlIGNhc2Ugb2YgZXZlbnQgaW5kZXguIFRoZSBjb3JyZWN0IGZpeAo+ID4gPiBtaWdodCBiZToK
PiA+ID4KPiA+ID4gMSkgcmVtb3ZlIGV2ZW50X3RyaWdnZXJlZAo+ID4gPiAyKSBzZXQgVlJJTkdf
QVZBSUxfRl9OT19JTlRFUlJVUFQgaW4gYXZhaWxfZmxhZ3Nfc2hhZG93IGluCj4gPiA+IHZyaW5n
X2ludGVycnJ1cHQgaWYgZXZlbnQgaW5kZXggaXMgc3VwcG9ydGVkCj4gPiA+Cj4gPiA+ID8KPiA+
ID4KPiA+ID4gVGhhbmtzCj4gPgo+ID4gSSBhbSBub3Qgc3VyZSBhbGwgdGhpcyBpcyByaWdodCBh
bmQgSSdkIHJhdGhlciB3ZSBmb2N1c2VkCj4gPiBwZXJmb3JtYW5jZS9jb3JyZWN0bmVzcyBhbmQg
Y2xlYW51cHMgc2VwYXJhdGVseS4KPiA+Cj4gPgo+ID4KPiA+Cj4gPiA+Cj4gPiA+ID4gQnV0IGJl
Y2F1c2Ugb2YgdGhlIGludHJvZHVjdGlvbiBvZiBldmVudF90cmlnZ2VyZWQsIGhlcmUsCj4gPiA+
ID4gdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0ICBjYW5ub3QgYmUgcmVjb2duaXplZAo+ID4g
PiA+IHRoYXQgdGhlIGludGVycnVwdCBoYXMgYmVlbiB0dXJuZWQgb2ZmLgo+ID4gPiA+Cj4gPiA+
ID4gaWYgd2Ugd2FudCAgYW5vdGhlciBpbnRlcnJ1cHQgZm9yIHRoZSBuZXh0IGVudHJ5LCBXZSBz
aG91bGQgcHJvYmFibHkKPiA+ID4gPiBjYWxsIHZpcnRxdWV1ZV9lbmFibGVfY2LvvJ8KPiA+ID4g
Pgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgdmlydGlvX3N0b3JlX21iKHZxLT53ZWFrX2JhcnJpZXJzLAo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2cmluZ191c2VkX2V2ZW50KCZ2cS0+c3BsaXQu
dnJpbmcpLAo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV90
b192aXJ0aW8xNihfdnEtPnZkZXYsIHZxLT5sYXN0X3VzZWRfaWR4KSk7Cj4gPiA+ID4gPiA+IEBA
IC0xNTI5LDcgKzE1MzAsOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3Bh
Y2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ID4gPiA+ICAgICAgICAgICogYnkgd3Jp
dGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBiZWZvcmUKPiA+ID4gPiA+
ID4gICAgICAgICAgKiB0aGUgcmVhZCBpbiB0aGUgbmV4dCBnZXRfYnVmIGNhbGwuCj4gPiA+ID4g
PiA+ICAgICAgICAgICovCj4gPiA+ID4gPiA+IC0gICAgICAgaWYgKHZxLT5wYWNrZWQuZXZlbnRf
ZmxhZ3Nfc2hhZG93ID09IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RFU0MpCj4gPiA+ID4gPiA+
ICsgICAgICAgaWYgKHZxLT5wYWNrZWQuZXZlbnRfZmxhZ3Nfc2hhZG93ID09IFZSSU5HX1BBQ0tF
RF9FVkVOVF9GTEFHX0RFU0MKPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgJiYg
KHZxLT5ldmVudF90cmlnZ2VyZWQgPT0gZmFsc2UpKQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgdmlydGlvX3N0b3JlX21iKHZxLT53ZWFrX2JhcnJpZXJzLAo+ID4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZ2cS0+cGFja2VkLnZyaW5nLmRyaXZlci0+b2ZmX3dy
YXAsCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1X3RvX2xl
MTYodnEtPmxhc3RfdXNlZF9pZHgpKTsKPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gMi4zMS4x
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
