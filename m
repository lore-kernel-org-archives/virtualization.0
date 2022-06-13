Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2637ACCA47C
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 14:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBB8D82CC7;
	Mon, 13 Jun 2022 14:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t3nv6q7sWP4a; Mon, 13 Jun 2022 14:08:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C93282CCB;
	Mon, 13 Jun 2022 14:08:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD990C0039;
	Mon, 13 Jun 2022 14:08:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21D7DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03BDC82CCB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFyivIHmGggO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:07:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 038F182CC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655129276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LhJVPrejXBlovpf6d8AN7SB8+qfxPmW1ztoAQMgx4U=;
 b=iX30qDBl4AIYpO6o3cWYNpDdR9Ef0OiW+2928EQR8JW855cmZR8GlfMYwh/9Jwe/lvxd6u
 IHXI+iTBYig06ie/wPEsc6CHiBSauBZBT+SVzpQaWyK5xhHvQyxiWA+2bfR+5G7gbmp+mT
 zMiygg+YEXq84uEqduXI0JNJirlTd+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-jgumSoSWPEyDtYirZ6wKKg-1; Mon, 13 Jun 2022 10:07:55 -0400
X-MC-Unique: jgumSoSWPEyDtYirZ6wKKg-1
Received: by mail-wr1-f70.google.com with SMTP id
 w8-20020adfde88000000b00213b7fa3a37so777037wrl.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 07:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8LhJVPrejXBlovpf6d8AN7SB8+qfxPmW1ztoAQMgx4U=;
 b=nMowVD9davT3CdMWMBZ148Ow8zAF2cK2r0uLfX/zoS4oPverY44+bW32KVJ1TeDtGv
 NKdjfleZWZ9IpuoNKqtKDhpX8y+a/bMasQ27I2c9XD0MruE69njgXc2s+08xQK/Vkcpb
 SpBUCjsp6UgpNl8oreuoFr7rhNiQP+J1k9n9qud+Mw+JNWQf8ttSHkAC2sV9/BhsOf4R
 UMURwWz6lXTKILstJywu8yJi9+064eukqOLH4WOPeyT5Ueniej3dbTCZhDrvX0V+r82N
 qgwMk4AtGFcvg81Iq1tV1F4VegdsdJLz7XHcB7+CKPMp9WNqiZEmx50NYM3kEqqVYs9f
 L+Iw==
X-Gm-Message-State: AOAM530TovJJNaQAaKiWCzyPzc2P+Gm2UwRRScLs2PCySgzPL1LwLb7l
 pX1pEcQehhvWg6HNz9omGQQRAblOwtAlEDmNdP6bWuZUwE//uUoCx8TNptRtLRhU7v4MqDq8OYV
 9Rqo4RkwFpZZ1BRLDQuOxfX7HETMIY1h5jceINwGUUA==
X-Received: by 2002:a05:600c:511e:b0:397:60e4:8ceb with SMTP id
 o30-20020a05600c511e00b0039760e48cebmr15183750wms.204.1655129274433; 
 Mon, 13 Jun 2022 07:07:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrypMUZMzcL7t4lAodWivx2/+hBE4Yd71OrQ/9PKgzB+K0ou5klX+hC6OkjMXbi4Uv+r5HEA==
X-Received: by 2002:a05:600c:511e:b0:397:60e4:8ceb with SMTP id
 o30-20020a05600c511e00b0039760e48cebmr15183732wms.204.1655129274139; 
 Mon, 13 Jun 2022 07:07:54 -0700 (PDT)
Received: from redhat.com ([2.53.9.208]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b0021033caa332sm8910119wrq.42.2022.06.13.07.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:07:53 -0700 (PDT)
Date: Mon, 13 Jun 2022 10:07:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Subject: Re: [PATCH] virtio_ring : fix vring_packed_desc memory out of bounds
 bug
Message-ID: <20220613100606-mutt-send-email-mst@kernel.org>
References: <20220610103314.61577-1-huangjie.albert@bytedance.com>
 <20220610103905-mutt-send-email-mst@kernel.org>
 <CABKxMyPTLJ0bbxb23C_aeucVEP8MYNiFz1y9d8eGA4Bvdyey3g@mail.gmail.com>
 <20220610203449-mutt-send-email-mst@kernel.org>
 <CABKxMyOYrjUDvWggK=rnBZcRuaO9x=wHWq15MgAQz5_Fbtypxg@mail.gmail.com>
 <20220612100945-mutt-send-email-mst@kernel.org>
 <CABKxMyMiOhRSp5_VOZ2Sh8q7Ef3+hnZmALHazwii0hR3SfRZWg@mail.gmail.com>
 <20220613045212-mutt-send-email-mst@kernel.org>
 <CABKxMyM5fvH6pGzPxqz1aRHbv8BX+xFfwyJi4zqqTA89RULs5w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABKxMyM5fvH6pGzPxqz1aRHbv8BX+xFfwyJi4zqqTA89RULs5w@mail.gmail.com>
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

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDk6NDc6NTVQTSArMDgwMCwg6buE5p2wIHdyb3RlOgo+
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTPml6Xl
kajkuIAgMTY6NTXlhpnpgZPvvJoKPiA+Cj4gPiBPbiBNb24sIEp1biAxMywgMjAyMiBhdCAwNDo0
NDowM1BNICswODAwLCDpu4TmnbAgd3JvdGU6Cj4gPiA+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IOS6jjIwMjLlubQ25pyIMTLml6Xlkajml6UgMjI6MTPlhpnpgZPvvJoKPiA+
ID4gPgo+ID4gPiA+IE9uIFN1biwgSnVuIDEyLCAyMDIyIGF0IDA3OjAyOjI1UE0gKzA4MDAsIOm7
hOadsCB3cm90ZToKPiA+ID4gPiA+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
IOS6jjIwMjLlubQ25pyIMTHml6Xlkajlha0gMDg6MzXlhpnpgZPvvJoKPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gT24gU2F0LCBKdW4gMTEsIDIwMjIgYXQgMTI6Mzg6MTBBTSArMDgwMCwg6buE5p2w
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXR0ZXJuIHdhcyBhbHdheXMgaWZmeSwgYnV0
IEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoCj4gPiA+ID4gPiA+ID4gPiBpbXByb3ZlcyB0aGUgc2l0
dWF0aW9uIG11Y2guIGxhc3RfdXNlZF9pZHggYW5kIHZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50
ZXIKPiA+ID4gPiA+ID4gPiA+IGNhbiBzdGlsbCBnZXQgb3V0IG9mIHN5bmMuCj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiBZZXPvvIwgWW91IGFyZSBhYnNvbHV0ZWx5IGNvcnJlY3QsIHRoYW5r
cyBmb3IgcG9pbnRpbmcgb3V0IHRoaXMgaXNzdWUsIEkKPiA+ID4gPiA+ID4gPiBkaWRuJ3QgdGFr
ZSB0aGF0IGludG8gY29uc2lkZXJhdGlvbiwKPiA+ID4gPiA+ID4gPiBob3cgYWJvdXQgZGlzYWJs
aW5nIGludGVycnVwdHMgYmVmb3JlIHRoaXMgY29kZSBiZWxvdzoKPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gdnEtPmxhc3RfdXNlZF9pZHggKz0gdnEtPnBhY2tlZC5kZXNjX3N0YXRlW2lk
XS5udW07Cj4gPiA+ID4gPiA+ID4gPiBpZiAodW5saWtlbHkodnEtPmxhc3RfdXNlZF9pZHggPj0g
dnEtPnBhY2tlZC52cmluZy5udW0pKSB7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICB2cS0+bGFz
dF91c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsKPiA+ID4gPiA+ID4gPiA+ICAgICAg
ICAgIHZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIgXj0gMTsKPiA+ID4gPiA+ID4gPiA+IH0K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IGl0IHNlZW1zIHRvIGJlIGZpbmUgdG8ganVzdCB0
dXJuIG9mZiB0aGUgaW50ZXJydXB0cyBvZiB0aGUgY3VycmVudCB2cmluZy4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IEJSCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYXQgd291bGQgbWFr
ZSBkYXRhcGF0aCBzaWduaWZpY2FudGx5IHNsb3dlci4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IOS6jjIw
MjLlubQ25pyIMTDml6XlkajkupQgMjI6NTDlhpnpgZPvvJoKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiBPbiBGcmksIEp1biAxMCwgMjAyMiBhdCAwNjozMzoxNFBNICswODAwLCBodWFu
Z2ppZS5hbGJlcnQgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IGtzb2Z0aXJxZCBtYXkgY29uc3Vt
ZSB0aGUgcGFja2V0IGFuZCBpdCB3aWxsIGNhbGw6Cj4gPiA+ID4gPiA+ID4gPiA+IHZpcnRuZXRf
cG9sbAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAtLT52aXJ0bmV0X3JlY2VpdmUKPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAtLT52aXJ0cXVldWVfZ2V0X2J1Zl9jdHgKPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIC0tPnZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9w
YWNrZWQKPiA+ID4gPiA+ID4gPiA+ID4gYW5kIGluIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNr
ZWQ6Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IHZxLT5sYXN0X3VzZWRfaWR4
ICs9IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubnVtOwo+ID4gPiA+ID4gPiA+ID4gPiBpZiAo
dW5saWtlbHkodnEtPmxhc3RfdXNlZF9pZHggPj0gdnEtPnBhY2tlZC52cmluZy5udW0pKSB7Cj4g
PiA+ID4gPiA+ID4gPiA+ICAgICAgICAgIHZxLT5sYXN0X3VzZWRfaWR4IC09IHZxLT5wYWNrZWQu
dnJpbmcubnVtOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICB2cS0+cGFja2VkLnVzZWRfd3Jh
cF9jb3VudGVyIF49IDE7Cj4gPiA+ID4gPiA+ID4gPiA+IH0KPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gaWYgYXQgdGhlIHNhbWUgdGltZSwgdGhlcmUgY29tZXMgYSB2cmluZyBp
bnRlcnJ1cHTvvIxpbiB2cmluZ19pbnRlcnJ1cHQ6Cj4gPiA+ID4gPiA+ID4gPiA+IHdlIHdpbGwg
Y2FsbDoKPiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0Cj4gPiA+ID4gPiA+ID4gPiA+
ICAgICAgIC0tPm1vcmVfdXNlZAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIC0tPm1v
cmVfdXNlZF9wYWNrZWQKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIC0t
PmlzX3VzZWRfZGVzY19wYWNrZWQKPiA+ID4gPiA+ID4gPiA+ID4gaW4gaXNfdXNlZF9kZXNjX3Bh
Y2tlZCwgdGhlIGxhc3RfdXNlZF9pZHggbWF5YmUgPj0gdnEtPnBhY2tlZC52cmluZy5udW0uCj4g
PiA+ID4gPiA+ID4gPiA+IHNvIHRoaXMgY291bGQgY2FzZSBhIG1lbW9yeSBvdXQgb2YgYm91bmRz
IGJ1Zy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gdGhpcyBwYXRjaCBpcyB0
byBmaXggdGhpcy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogaHVhbmdqaWUuYWxiZXJ0IDxodWFuZ2ppZS5hbGJlcnRAYnl0ZWRhbmNlLmNvbT4KPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXR0ZXJu
IHdhcyBhbHdheXMgaWZmeSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlIHBhdGNoCj4gPiA+ID4gPiA+
ID4gPiBpbXByb3ZlcyB0aGUgc2l0dWF0aW9uIG11Y2guIGxhc3RfdXNlZF9pZHggYW5kIHZxLT5w
YWNrZWQudXNlZF93cmFwX2NvdW50ZXIKPiA+ID4gPiA+ID4gPiA+IGNhbiBzdGlsbCBnZXQgb3V0
IG9mIHN5bmMuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gTWF5YmUgcmVmYWN0b3Ig
Y29kZSB0byBrZWVwIGV2ZXJ5dGhpbmcgaW4gdnEtPmxhc3RfdXNlZF9pZHg/Cj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gSmFzb24gd2hhdCBpcyB5b3VyIHRha2U/Cj4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4g
PiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMyArKysKPiA+ID4gPiA+ID4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiA+IGluZGV4IDEz
YTczNDhjZWRmZi4uZDJhYmJiM2E4MTg3IDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTEzOTcsNiArMTM5
Nyw5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc191c2VkX2Rlc2NfcGFja2VkKGNvbnN0IHN0cnVj
dCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBib29sIGF2YWls
LCB1c2VkOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgICB1MTYgZmxhZ3M7Cj4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIGlmIChpZHggPj0gdnEtPnBhY2tlZC52cmluZy5u
dW0pCj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ID4gPiA+
ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIGZsYWdzID0gbGUxNl90b19jcHUo
dnEtPnBhY2tlZC52cmluZy5kZXNjW2lkeF0uZmxhZ3MpOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICBhdmFpbCA9ICEhKGZsYWdzICYgKDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9BVkFJTCkpOwo+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICB1c2VkID0gISEoZmxhZ3MgJiAoMSA8PCBWUklOR19QQUNL
RURfREVTQ19GX1VTRUQpKTsKPiA+ID4gPiA+ID4gPiA+ID4gLS0KPiA+ID4gPiA+ID4gPiA+ID4g
Mi4yNy4wCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IE1p
Y2hhZWwgUyAsIHRoYW5rcyBmb3IgeW91ciBjb3JyZWN0aW9uLCB0aGVyZSBtYXkgYmUgYW5vdGhl
ciBzaW1wbGUKPiA+ID4gPiA+IHNvbHV0aW9uIGhlcmU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiBpbmRleCAxM2E3MzQ4Y2VkZmYuLjRkYjRkYjE5Zjk0YSAx
MDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiA+IEBAIC0xMzk3
LDYgKzEzOTcsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfdXNlZF9kZXNjX3BhY2tlZChjb25z
dAo+ID4gPiA+ID4gc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gPiA+ID4gPiAgICAgICAg
IGJvb2wgYXZhaWwsIHVzZWQ7Cj4gPiA+ID4gPiAgICAgICAgIHUxNiBmbGFnczsKPiA+ID4gPiA+
Cj4gPiA+ID4gPiArICAgICAgIGlmIChpZHggPj0gdnEtPnBhY2tlZC52cmluZy5udW0pCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
ICAgICAgICBmbGFncyA9IGxlMTZfdG9fY3B1KHZxLT5wYWNrZWQudnJpbmcuZGVzY1tpZHhdLmZs
YWdzKTsKPiA+ID4gPiA+ICAgICAgICAgYXZhaWwgPSAhIShmbGFncyAmICgxIDw8IFZSSU5HX1BB
Q0tFRF9ERVNDX0ZfQVZBSUwpKTsKPiA+ID4gPiA+ICAgICAgICAgdXNlZCA9ICEhKGZsYWdzICYg
KDEgPDwgVlJJTkdfUEFDS0VEX0RFU0NfRl9VU0VEKSk7Cj4gPiA+ID4gPiBAQCAtMTQ1Myw4ICsx
NDU2LDkgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9wYWNrZWQoc3RydWN0
Cj4gPiA+ID4gPiB2aXJ0cXVldWUgKl92cSwKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAgIHZx
LT5sYXN0X3VzZWRfaWR4ICs9IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubnVtOwo+ID4gPiA+
ID4gICAgICAgICBpZiAodW5saWtlbHkodnEtPmxhc3RfdXNlZF9pZHggPj0gdnEtPnBhY2tlZC52
cmluZy5udW0pKSB7Cj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHgg
LT0gdnEtPnBhY2tlZC52cmluZy5udW07Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgdnEtPnBh
Y2tlZC51c2VkX3dyYXBfY291bnRlciBePSAxOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGJh
cnJpZXIoKTsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCAtPSB2
cS0+cGFja2VkLnZyaW5nLm51bTsKPiA+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4KPiA+ID4g
PiA+ICAgICAgICAgLyoKPiA+ID4gPiA+Cj4gPiA+ID4gPiB2cS0+cGFja2VkLnVzZWRfd3JhcF9j
b3VudGVyICBhbmQgIHZxLT5sYXN0X3VzZWRfaWR4IG9ubHkgaW5jcmVhc2VkCj4gPiA+ID4gPiBi
eSB0aGUgdmlydHF1ZXVlX2dldF9idWZfY3R4X3BhY2tlZCwgYW5kCj4gPiA+ID4gPiBzbyB3ZSBj
YW4gYWRkIGEgbWVtb3J5IGJhcnJpZXIgYW5kIENoYW5naW5nIHRoZSBvcmRlciBpbiB3aGljaAo+
ID4gPiA+ID4gbGFzdF91c2VkX2lkeCAgYW5kIHVzZWRfd3JhcF9jb3VudGVyICBhcmUgYXNzaWdu
ZWQKPiA+ID4gPiA+IHNob3VsZCB0ZW1wb3JhcmlseSBzb2x2ZSB0aGUgcHJvYmxlbS4gQnV0IGFz
IHlvdSBzYWlkLCB0aGUgY29kZSBtYXkKPiA+ID4gPiA+IG5lZWQgdG8gYmUgcmVmYWN0b3JlZCB0
byBmdWxseSBhZGRyZXNzIHRoZXNlIGtpbmRzIG9mIGlzc3Vlcy4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBCUgo+ID4gPiA+Cj4gPiA+ID4gdGhpcyBtaWdodCBzb2x2ZSB0aGUgT09CIGFjY2VzcyBidXQg
bm90IHRoZSBwcm9ibGVtIHRoYXQgaW50ZXJydXB0Cj4gPiA+ID4gbWlnaHQgdXNlIGFuIGluY29y
cmVjdCB2YWx1ZSB0byBjaGVjayBmb3IgdGhlIHVzZWQgaW5kZXguCj4gPiA+ID4KPiA+ID4KPiA+
ID4gWWVzLCB0aGFua3MgZm9yIHRoYXQsIGJ1dCBpdCBzZWVtcyB0aGF0IGl0IGNhbiBub3Qgc29s
dmUgdGhlIHByb2JsZW0KPiA+ID4gdGhhdCBpbnRlcnJ1cHQKPiA+ID4gbWlnaHQgdXNlIGFuIGlu
Y29ycmVjdCB2YWx1ZSB0byBjaGVjayBmb3IgdGhlIHVzZWQgaW5kZXggaWYgd2UgZG8gbm90Cj4g
PiA+IGRpc2FibGUgaXJxIGluIHNvZnRpcnFkLgo+ID4gPiB0aGUgZm9sbG93aW5nIGNvZGUgaW4g
dmlydHF1ZXVlX2dldF9idWZfY3R4X3BhY2tlZDoKPiA+ID4KPiA+ID4gPjE0NTMgICAgICAvKiBk
ZXRhY2hfYnVmX3BhY2tlZCBjbGVhcnMgZGF0YSwgc28gZ3JhYiBpdCBub3cuICovCj4gPiA+ID4x
NDU0ICAgICAgIHJldCA9IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0uZGF0YTsKPiA+ID4gPjE0
NTUgICAgICAgZGV0YWNoX2J1Zl9wYWNrZWQodnEsIGlkLCBjdHgpOwo+ID4gPiA+MTQ1Ngo+ID4g
PiA+MTQ1NyAgICAgIHZxLT5sYXN0X3VzZWRfaWR4ICs9IHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtp
ZF0ubnVtOwo+ID4gPiA+MTQ1OCAgICAgIGlmICh1bmxpa2VseSh2cS0+bGFzdF91c2VkX2lkeCA+
PSB2cS0+cGFja2VkLnZyaW5nLm51bSkpIHsKPiA+ID4gPjE0NTkgICAgICAgICAgICB2cS0+bGFz
dF91c2VkX2lkeCAtPSB2cS0+cGFja2VkLnZyaW5nLm51bTsKPiA+ID4gPjE0NjAgICAgICAgICAg
ICB2cS0+cGFja2VkLnVzZWRfd3JhcF9jb3VudGVyIF49IDE7Cj4gPiA+ID4xNDYxICAgICAgfQo+
ID4gPgo+ID4gPiBhZnRlciBjYWxsICBsaW5lIDE0NTUsIHRoZSByZWFsIGxhc3RfdXNlZF9pZHgg
c2hvdWxkIGFkZAo+ID4gPiB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRdLm51bSwgYnV0IGl0Cj4g
PiA+IGFkZCBpdCBpbiBsaW5lIDE0NTcuIGlmIHRoZSBpbnRlcnJ1cHQgY29tZXMgYmVmb3JlIDE0
NTcsIHdlIGFsc28gZ2V0Cj4gPiA+IHRoZSBpbmNvcnJlY3QgIGxhc3RfdXNlZF9pZHguCj4gPiA+
IGRvIHlvdSBoYXZlIGFueSBnb29kIGNvbW1lbnRzPyBUaGlzIHByb2JsZW0gZXhpc3RzIGV2ZW4g
aWYKPiA+ID4gbGFzdF91c2VkX2lkeCBhbmQgdXNlZF93cmFwX2NvdW50ZXIgYXJlIG1lcmdlZCBh
bmQgdGhlaXIgb3BlcmF0aW9ucwo+ID4gPiBhcmUgYXRvbWljLgo+ID4gPgo+ID4gPiBCUgo+ID4K
PiA+IFRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgd2UgZG8gbm90IG5lZWQgdG8gd29ycnkgYWJvdXQK
PiA+IHRoZSBjYXNlIHdoZXJlIHJpbmcgYWxyZWFkeSBoYWQgdXNlZCBidWZmZXJzOiB0aGVzZQo+
ID4gYXJlIGdvaW5nIHRvIGJlIHBvbGxlZCBieSB0aGUgZHJpdmVyLgo+ID4gV2UgZG8gbmVlZCB0
byB3b3JyeSBhYm91dCBhbnkgYnVmZmVycyBhZGRlZCBhZnRlcgo+ID4gZHJpdmVyIGRyYWlucyB0
aGUgdnEuCj4gPiBJbiBvdGhlciB3b3JkcyB0aGUgam9iIG9mIHRoZSBjYWxsYmFjayBpcyB0byBz
aWduYWwKPiA+IHRvIGRyaXZlciB0aGUgbm8gdXNlZCBidWZmZXJzIC0+IHNvbWUgdXNlZCBidWZm
ZXJzCj4gPiBjb25kaXRpb24uCj4gPiBUaGlzIGlnbm9yZXMgdmlydHF1ZXVlX2VuYWJsZV9jYl9k
ZWxheWVkLgo+ID4KPiAKPiBNYW55IHRoYW5rcyBmb3IgeW91IC4gYnV0IEknbSBzb3JyeSBJIGRp
ZG4ndCB1bmRlcnN0YW5kIHRoZSBtZWFuaW5nIG9mCj4gdGhlIGxhc3Qgc2VudGVuY2XvvJoKPiA+
IFRoaXMgaWdub3JlcyB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQuCj4gCj4gdmlydHF1ZXVl
X2VuYWJsZV9jYl9kZWxheWVkIGlzIHRvIGVuYWJsZSB0aGUgZGV2aWNlCj4gbm90aWZpY2F0aW9u
77yIaW50ZXJydXB077yJZGVsYXllZChpZiBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCBlbmFibGVk
KS4KPiBIb3cgZG9lcyB0aGlzIHJlbGF0ZSB0byBvdXIgcHJldmlvdXMgZGlzY3Vzc2lvbj8KCkkg
c2FpZDoKdGhlIGpvYiBvZiB0aGUgY2FsbGJhY2sgaXMgdG8gc2lnbmFsIHRvIGRyaXZlciB0aGUg
bm8gdXNlZCBidWZmZXJzIC0+IHNvbWUgdXNlZCBidWZmZXJzCgoKVGhpcyBkb2VzIG5vdCBhcHBs
eSB0byB2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQgLSBmb3IgdGhhdCBvbmUKdGhlIGpvYiBv
ZiB0aGUgY2FsbGJhY2sgaXMgdG8gc2lnbmFsIHRoZSBubyB1c2VkIGJ1ZmZlcnMgLT4gbG90cyBv
Zgp1c2VkIGJ1ZmZlcnMgY29uZGl0aW9uLgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
