Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42578C6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 03:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 909CB41E4E;
	Fri, 24 Mar 2023 03:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 909CB41E4E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZQ4w2QY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRT832oz83bF; Fri, 24 Mar 2023 03:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6BDBD41E3A;
	Fri, 24 Mar 2023 03:41:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BDBD41E3A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA95C0071;
	Fri, 24 Mar 2023 03:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8EAFC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 03:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CD278412F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 03:41:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CD278412F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZQ4w2QY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HDKzDanrzHTM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 03:41:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56CE28412D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56CE28412D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 03:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679629286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swlWlggXJj2hbT0VucgzYRhl+ET3HPvPizdMvN3gXts=;
 b=aZQ4w2QY4rGYrlyInUZlWtlzwuroe3NZ4c8PNfJMDwmCG8qFMPipHdX/3ilmrOhdepqsdJ
 96Am1lzktdkPYme4U2fBXb+FjYTQy3JiDeJDM1ham45/si1iTb3+w2T/9ue7P7kYmAPYKv
 u44cuT89WjoGqsxLeR0uENXhxhHWU00=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-pgM5RamRMQmcV6Ai-MchFA-1; Thu, 23 Mar 2023 23:41:24 -0400
X-MC-Unique: pgM5RamRMQmcV6Ai-MchFA-1
Received: by mail-oo1-f72.google.com with SMTP id
 q18-20020a4a3312000000b0053b61757527so294742ooq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 20:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679629284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swlWlggXJj2hbT0VucgzYRhl+ET3HPvPizdMvN3gXts=;
 b=1PKwTCn70hXdr1DuNOnlHNxMB52AGnIVeFOB/77fUrFFdA25QB9k+j301bJEy+rZvs
 dYrIxSzt0FhI94ph+zgxDmcro9hXWJT8zCqCfLMsMkRlGSEB4aPgUi0TkvhbFAQ1bQfD
 58XuNvNRAiFvxPcr9ZppvnlG6lKXk/vYHz/nqmnSulk+/J8aJToyAZNQqLNcxUyDHoOo
 /an9wtb0ZVgOweMfEX/mc9OHNB5ffzy96/0SiALwtiktrTXhdsmZI5jnAbadI+Dz3GGq
 2kC3QucjryrV3bNhPGUKjJro+Z4VHI2XkymlUOm+cvs+K4OvVq0BlvEjE4PDmUgPAzyu
 K64Q==
X-Gm-Message-State: AAQBX9dF2YeY8qzzcL6PgIRkEWG5INOR07OH4rn3sdUjSWtDKuvpiLyP
 thV/vjpe+NMFHZ9yykX+lmDC3eE40ACd9gOD2gem2RIaXaynIiVXyU4e5XfPR/G2gQVdSZqMZRz
 AMeqSrRq4MI6FpqhbIgIqKnLpmcSHWXH9xNdG4z4Rh8a1kLN80/+hzadHJA==
X-Received: by 2002:a05:6870:10d4:b0:17e:255e:b1 with SMTP id
 20-20020a05687010d400b0017e255e00b1mr521143oar.9.1679629283877; 
 Thu, 23 Mar 2023 20:41:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set/QtGSvTUkrhlTrdohi2qzwnqwBehxRYbFDLU7APMXwPEOiBCg665bDT5xmcEYMDDj/Ouy/KGDODj6Tc7kqUYI=
X-Received: by 2002:a05:6870:10d4:b0:17e:255e:b1 with SMTP id
 20-20020a05687010d400b0017e255e00b1mr521139oar.9.1679629283610; Thu, 23 Mar
 2023 20:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <CACGkMEvx_-3XbnBk1PakqODhL+C0Oy-BVORm=FsMxvzVcBbrnA@mail.gmail.com>
 <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
In-Reply-To: <CABKxMyNSp1-pJW11B3YuDm39mg=eT48JspDsrEePjKFrHNK8NQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Mar 2023 11:41:12 +0800
Message-ID: <CACGkMEsG3_+GmfoO-y_dMxSeMn_Ry5L0PVgLSKSAJzRbym4j8A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] virtio_ring: Suppress tx interrupt when
 napi_tx disable
To: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgNDowMeKAr1BNIOm7hOadsCA8aHVhbmdqaWUuYWxiZXJ0
QGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+Cj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4g5LqOMjAyM+W5tDPmnIgyMuaXpeWRqOS4iSAxMDozN+WGmemBk++8mgo+ID4KPiA+IE9uIFR1
ZSwgTWFyIDIxLCAyMDIzIGF0IDU6MDDigK9QTSBBbGJlcnQgSHVhbmcKPiA+IDxodWFuZ2ppZS5h
bGJlcnRAYnl0ZWRhbmNlLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEZyb206ICJodWFuZ2ppZS5h
bGJlcnQiIDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4KPiA+ID4KPiA+ID4gZml4IGNv
bW1pdCA4ZDYyMmQyMWQyNDggKCJ2aXJ0aW86IGZpeCB1cCB2aXJ0aW9fZGlzYWJsZV9jYiIpCj4g
PiA+Cj4gPiA+IGlmIHdlIGRpc2FibGUgdGhlIG5hcGlfdHguIHdoZW4gd2UgdHJpZ2VyIGEgdHgg
aW50ZXJydXB0LCB0aGUKPiA+Cj4gPiB0eXBvIHNob3VsZCBiZSAidHJpZ2dlciIKPiA+Cj4KPiBP
SywgdGhhbmtzIGZvciB0aGlzLiBJIHdpbGwgY29ycmVjdCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9u
Cj4KPiA+ID4gdnEtPmV2ZW50X3RyaWdnZXJlZCB3aWxsIGJlIHNldCB0byB0cnVlLiBJdCB3aWxs
IG5vIGxvbmdlciBiZQo+ID4gPiBzZXQgdG8gZmFsc2UuIFVubGVzcyB3ZSBleHBsaWNpdGx5IGNh
bGwgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkCj4gPiA+IG9yIHZpcnRxdWV1ZV9lbmFibGVf
Y2JfcHJlcGFyZQo+ID4gPgo+ID4gPiBpZiB3ZSBkaXNhYmxlIHRoZSBuYXBpX3R4LCBJdCB3aWxs
IG9ubHkgYmUgY2FsbGVkIHdoZW4gdGhlIHR4IHJpbmcKPiA+ID4gYnVmZmVyIGlzIHJlbGF0aXZl
bHkgc21hbGw6Cj4gPiA+IHZpcnRpb19uZXQtPnN0YXJ0X3htaXQ6Cj4gPiA+ICAgICAgICAgaWYg
KHNxLT52cS0+bnVtX2ZyZWUgPCAyK01BWF9TS0JfRlJBR1MpIHsKPiA+ID4gICAgICAgICAgICAg
ICAgIG5ldGlmX3N0b3Bfc3VicXVldWUoZGV2LCBxbnVtKTsKPiA+ID4gICAgICAgICAgICAgICAg
IGlmICghdXNlX25hcGkgJiYKPiA+ID4gICAgICAgICAgICAgICAgICAgICB1bmxpa2VseSghdmly
dHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSkpKSB7Cj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIE1vcmUganVzdCBnb3QgdXNlZCwgZnJlZSB0aGVtIHRoZW4gcmVjaGVjay4g
Ki8KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9vbGRfeG1pdF9za2JzKHNxLCBm
YWxzZSk7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVl
ID49IDIrTUFYX1NLQl9GUkFHUykgewo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgfQo+ID4KPiA+IFRoZSBjb2RlIGV4YW1wbGUgaGVyZSBpcyBv
dXQgb2YgZGF0ZSwgbWFrZSBzdXJlIHlvdXIgdHJlZSBoYXMgdGhpczoKPgo+IGFsc28sIEkgd2ls
bCBjb3JyZWN0IGl0IGluIHRoZSBuZXh0IHZlcnNpb27vvIx0aGlzIGlzIGZyb20ga2VybmVsIDUu
MTUuCj4KPiA+Cj4gPiBjb21taXQgZDcxZWJlODExNGI0YmY2MjI4MDRiODEwZjVlMjc0MDY5MDYw
YTE3NAo+ID4gQXV0aG9yOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gRGF0
ZTogICBUdWUgSmFuIDE3IDExOjQ3OjA3IDIwMjMgKzA4MDAKPiA+Cj4gPiAgICAgdmlydGlvLW5l
dDogY29ycmVjdGx5IGVuYWJsZSBjYWxsYmFjayBkdXJpbmcgc3RhcnRfeG1pdAo+ID4KPiA+ID4g
ICAgICAgICAgICAgICAgIH0KPiA+ID4gICAgICAgICB9Cj4gPiA+IEJlY2F1c2UgZXZlbnRfdHJp
Z2dlcmVkIGlzIHRydWUuVGhlcmVmb3JlLCBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCBvcgo+
ID4gPiBWUklOR19QQUNLRURfRVZFTlRfRkxBR19ESVNBQkxFIHdpbGwgbm90IGJlIHNldC5TbyB3
ZSB1cGRhdGUKPiA+ID4gdnJpbmdfdXNlZF9ldmVudCgmdnEtPnNwbGl0LnZyaW5nKSBvciB2cS0+
cGFja2VkLnZyaW5nLmRyaXZlci0+b2ZmX3dyYXAKPiA+ID4gZXZlcnkgdGltZSB3ZSBjYWxsIHZp
cnRxdWV1ZV9nZXRfYnVmX2N0eC5UaGlzIHdpbGwgYnJpbmcgbW9yZSBpbnRlcnJ1cHRpb25zLgo+
ID4KPiA+IENhbiB5b3UgcGxlYXNlIHBvc3QgaG93IHRvIHRlc3Qgd2l0aCB0aGUgcGVyZm9ybWFu
Y2UgbnVtYmVycz8KPiA+Cj4KPiBpcGVyZjMgdGNwIHN0cmVhbToKPiB2bTEgLS0tLS0tLS0tLS0t
LS0tLS0+IHZtMgo+IHZtMiBqdXN0IHJlY2VpdmUgdGNwIGRhdGEgc3RyZWFtIGZyb20gdm0xLCBh
bmQgc2VuZCB0aGUgYWNrIHRvIHZtMSwKPiB0aGVyZSBhcmUgc28KPiBtYW55IHR4IGludGVycnVw
dGlvbnMgIGluIHZtMi4KPgo+IGJ1dCB3aXRob3V0IGV2ZW50X3RyaWdnZXJlZCB0aGVyZSBhcmUg
anVzdCBhIGZldyB0eCBpbnRlcnJ1cHRpb25zLgo+Cj4gPiA+Cj4gPiA+IGlmIGV2ZW50X3RyaWdn
ZXJlZCBpcyBzZXQgdG8gdHJ1ZSwgZG8gbm90IHVwZGF0ZSB2cmluZ191c2VkX2V2ZW50KCZ2cS0+
c3BsaXQudnJpbmcpCj4gPiA+IG9yIHZxLT5wYWNrZWQudnJpbmcuZHJpdmVyLT5vZmZfd3JhcAo+
ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBodWFuZ2ppZS5hbGJlcnQgPGh1YW5namllLmFsYmVy
dEBieXRlZGFuY2UuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgfCA2ICsrKystLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IGluZGV4IDMw
N2UxMzljYjExZC4uZjQ4NmNjY2FkYmViIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiA+ID4gQEAgLTc5NSw3ICs3OTUsOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZf
Y3R4X3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ID4gICAgICAgICAvKiBJZiB3ZSBl
eHBlY3QgYW4gaW50ZXJydXB0IGZvciB0aGUgbmV4dCBlbnRyeSwgdGVsbCBob3N0Cj4gPiA+ICAg
ICAgICAgICogYnkgd3JpdGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBi
ZWZvcmUKPiA+ID4gICAgICAgICAgKiB0aGUgcmVhZCBpbiB0aGUgbmV4dCBnZXRfYnVmIGNhbGwu
ICovCj4gPiA+IC0gICAgICAgaWYgKCEodnEtPnNwbGl0LmF2YWlsX2ZsYWdzX3NoYWRvdyAmIFZS
SU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUKSkKPiA+ID4gKyAgICAgICBpZiAoISh2cS0+c3BsaXQu
YXZhaWxfZmxhZ3Nfc2hhZG93ICYgVlJJTkdfQVZBSUxfRl9OT19JTlRFUlJVUFQpCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICYmICh2cS0+ZXZlbnRfdHJpZ2dlcmVkID09IGZhbHNlKSkK
PiA+Cj4gPiBJJ20gbm90IHN1cmUgdGhpcyBjYW4gd29yaywgd2hlbiBldmVudF90cmlnZ2VyZWQg
aXMgdHJ1ZSBpdCBtZWFucwo+ID4gd2UndmUgZ290IGFuIGludGVycnVwdCwgaW4gdGhpcyBjYXNl
IGlmIHdlIHdhbnQgYW5vdGhlciBpbnRlcnJ1cHQgZm9yCj4gPiB0aGUgbmV4dCBlbnRyeSwgd2Ug
c2hvdWxkIHVwZGF0ZSB1c2VkX2V2ZW50IG90aGVyd2lzZSB3ZSB3aWxsIGxvc2UKPiA+IHRoYXQg
aW50ZXJydXB0Pwo+ID4KPiA+IFRoYW5rcwo+Cj4gTm9ybWFsbHksIGlmIHdlIHJlY2VpdmUgYW4g
aW50ZXJydXB0LCB3ZSBzaG91bGQgZGlzYWJsZSB0aGUgaW50ZXJydXB0Cj4gaW4gdGhlIGludGVy
cnVwdCBjYWxsYmFjayBoYW5kbGVyLgoKU28gdGhlIHByb2JsZW0gaXM6CgoxKSBldmVudF90cmln
Z2VyZWQgd2FzIHNldCB0byB0cnVlIGluIHZyaW5nX2ludGVycnVwdCgpCjIpIGFmdGVyIHRoaXMg
bm90aGluZyB3aWxsIGhhcHBlbiBmb3IgdmlydHF1ZXVlX2Rpc2FibGVfY2IoKSBzbwpWUklOR19B
VkFJTF9GX05PX0lOVEVSUlVQVCBpcyBub3Qgc2V0IGluIGF2YWlsX2ZsYWdzX3NoYWRvdwozKSB2
aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfc3BsaXQoKSB3aWxsIHN0aWxsIHRoaW5rIHRoZSBjYiBpcyBl
bmFibGVkCnRoZW4gaXQgdHJpZXMgdG8gcHVibGlzaCBuZXcgZXZlbnQKClRoaXMgbWFrZXMgbWUg
dGhpbmsgYWJvdXQgd2hldGhlciBvciBub3Qgd2UgcmVhbGx5IG5lZWQKZXZlbnRfdHJpZ2dlcmVk
LiBUaGUgYXNzdW1wdGlvbiBpbiB0aGUgdmlydHF1ZXVlX2Rpc2FibGVfY2IoKSBzZWVtcwp3cm9u
ZzoKCi8qIElmIGRldmljZSB0cmlnZ2VyZWQgYW4gZXZlbnQgYWxyZWFkeSBpdCB3b24ndCB0cmln
Z2VyIG9uZSBhZ2FpbjoKICogbm8gbmVlZCB0byBkaXNhYmxlLgogKi8KaWYgKHZxLT5ldmVudF90
cmlnZ2VyZWQpCiAgICAgICAgICAgICAgICByZXR1cm47CgpUaGlzIGlzIHdyb25nIGlmIHRoZXJl
J3Mgbm8gZXZlbnQgaW5kZXggc3VwcG9ydC4gQW5kIHRoZQpldmVudF90cmlnZ2VyZWQgaXMgc29t
ZWhvdyBkdXBsaWNhdGVkIHdpdGggdGhlClZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUIGluIHRo
ZSBjYXNlIG9mIGV2ZW50IGluZGV4LiBUaGUgY29ycmVjdCBmaXgKbWlnaHQgYmU6CgoxKSByZW1v
dmUgZXZlbnRfdHJpZ2dlcmVkCjIpIHNldCBWUklOR19BVkFJTF9GX05PX0lOVEVSUlVQVCBpbiBh
dmFpbF9mbGFnc19zaGFkb3cgaW4KdnJpbmdfaW50ZXJycnVwdCBpZiBldmVudCBpbmRleCBpcyBz
dXBwb3J0ZWQKCj8KClRoYW5rcwoKCj4gQnV0IGJlY2F1c2Ugb2YgdGhlIGludHJvZHVjdGlvbiBv
ZiBldmVudF90cmlnZ2VyZWQsIGhlcmUsCj4gdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0ICBj
YW5ub3QgYmUgcmVjb2duaXplZAo+IHRoYXQgdGhlIGludGVycnVwdCBoYXMgYmVlbiB0dXJuZWQg
b2ZmLgo+Cj4gaWYgd2Ugd2FudCAgYW5vdGhlciBpbnRlcnJ1cHQgZm9yIHRoZSBuZXh0IGVudHJ5
LCBXZSBzaG91bGQgcHJvYmFibHkKPiBjYWxsIHZpcnRxdWV1ZV9lbmFibGVfY2LvvJ8KPgo+IFRo
YW5rcwo+Cj4gPgo+ID4gPiAgICAgICAgICAgICAgICAgdmlydGlvX3N0b3JlX21iKHZxLT53ZWFr
X2JhcnJpZXJzLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2cmluZ191
c2VkX2V2ZW50KCZ2cS0+c3BsaXQudnJpbmcpLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNwdV90b192aXJ0aW8xNihfdnEtPnZkZXYsIHZxLT5sYXN0X3VzZWRfaWR4KSk7
Cj4gPiA+IEBAIC0xNTI5LDcgKzE1MzAsOCBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9i
dWZfY3R4X3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ICAgICAgICAgICogYnkg
d3JpdGluZyBldmVudCBpbmRleCBhbmQgZmx1c2ggb3V0IHRoZSB3cml0ZSBiZWZvcmUKPiA+ID4g
ICAgICAgICAgKiB0aGUgcmVhZCBpbiB0aGUgbmV4dCBnZXRfYnVmIGNhbGwuCj4gPiA+ICAgICAg
ICAgICovCj4gPiA+IC0gICAgICAgaWYgKHZxLT5wYWNrZWQuZXZlbnRfZmxhZ3Nfc2hhZG93ID09
IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RFU0MpCj4gPiA+ICsgICAgICAgaWYgKHZxLT5wYWNr
ZWQuZXZlbnRfZmxhZ3Nfc2hhZG93ID09IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RFU0MKPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgJiYgKHZxLT5ldmVudF90cmlnZ2VyZWQgPT0gZmFs
c2UpKQo+ID4gPiAgICAgICAgICAgICAgICAgdmlydGlvX3N0b3JlX21iKHZxLT53ZWFrX2JhcnJp
ZXJzLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2cS0+cGFja2VkLnZy
aW5nLmRyaXZlci0+b2ZmX3dyYXAsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1X3RvX2xlMTYodnEtPmxhc3RfdXNlZF9pZHgpKTsKPiA+ID4gLS0KPiA+ID4gMi4zMS4x
Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
