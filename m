Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA4C4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 06:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C753408F8;
	Wed,  4 Jan 2023 06:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C753408F8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOOS8aI8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6yKlaRGQbn6j; Wed,  4 Jan 2023 06:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12F904010E;
	Wed,  4 Jan 2023 06:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12F904010E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D71D7C0032;
	Wed,  4 Jan 2023 06:46:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7849C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E3EF60FF3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E3EF60FF3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOOS8aI8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kdx77e0iRQDt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C95960B23
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C95960B23
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 06:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672814776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZlFWtxiRkDtk+thRF9nVuLB+b4oL2TYgzK5e9wk6bs=;
 b=SOOS8aI83cGhGdG2ckdETkO+AvAKw6/I1mzXh0cWm2ObnR3Oc0hTOR6dvkiwyxLtu+/KY0
 McwH5kTcpX/O1e8umacApWemFGXdRoSTCzhogLjB9kgQ6N07DCtDesJ4tqaFQNCcxYXS91
 RQCE/C7oLa5zLszqrNRdjFIItVgsKoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-aAvJHleRM9-FgpKUWU70tg-1; Wed, 04 Jan 2023 01:46:14 -0500
X-MC-Unique: aAvJHleRM9-FgpKUWU70tg-1
Received: by mail-wm1-f69.google.com with SMTP id
 m8-20020a05600c3b0800b003d96bdce12fso15971611wms.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Jan 2023 22:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dZlFWtxiRkDtk+thRF9nVuLB+b4oL2TYgzK5e9wk6bs=;
 b=J8ELvBTjf7V6j0eqt+pQNwE5AoDGvjxYRw9s7R3noCJacUHd/PG7jLN7O5PIw1XWFb
 kubvPyo16YFLTYBayBxkrmAxe9zZYwteIh6/8THyV9c/VkiSQGm2Sv8f2gq0CX/hz7Pl
 6mqFc8Naln58pSiN07Pq2d+vwDzEkXxonWAlnPnT+zhuSeNO5qvou7rtHD24osEzsgj5
 r5E1YOo2jnootfFCndyJCOPZGMeunYq18io+DdYegj9KFYEEryhHLEvL93bLNIGrzL1/
 zLHhsmU7sy0irBLRS6wmrGO005tvXe61ouzLBCxZiDVJUr2wL8/rlU6Ft6U5FH/SL6sj
 sVPg==
X-Gm-Message-State: AFqh2kojzEX1m8BgRW/giO9gea+eDCs3poRWacSgNHdnkZB0pOzVXSOU
 u9ZiO5krlcsN+Dqwi/XiKq5pDCCbPkrComEqMCV0fM2eWQfxdICj+JvigCyVGwB1wz4SFRMzq61
 IvinctZxUxx4U5hT/utRZC4Xc+wgrV3ZMSpyZ/0vmvw==
X-Received: by 2002:a05:600c:3ba7:b0:3d3:4dac:aa69 with SMTP id
 n39-20020a05600c3ba700b003d34dacaa69mr32523082wms.36.1672814773595; 
 Tue, 03 Jan 2023 22:46:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsmKlEtrhGwFJV/isqLZ83QMfqezcC6GQt8r/1BBQD+my1HQhflP0L+uExmpASFxDlO1tKIg==
X-Received: by 2002:a05:600c:3ba7:b0:3d3:4dac:aa69 with SMTP id
 n39-20020a05600c3ba700b003d34dacaa69mr32523066wms.36.1672814773307; 
 Tue, 03 Jan 2023 22:46:13 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a05600c188700b003d9aa76dc6asm17424241wmp.0.2023.01.03.22.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jan 2023 22:46:12 -0800 (PST)
Date: Wed, 4 Jan 2023 01:46:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during
 start_xmit
Message-ID: <20230104014256-mutt-send-email-mst@kernel.org>
References: <20221215032719.72294-1-jasowang@redhat.com>
 <20221215034740-mutt-send-email-mst@kernel.org>
 <CACGkMEsLeCRDqyuyGzWw+kjYrTVDjUjOw6+xHESPT2D1p03=sQ@mail.gmail.com>
 <20221215042918-mutt-send-email-mst@kernel.org>
 <CACGkMEsbvTQrEp5dmQRHp58Mu=E7f433Xrvsbs4nZMA5R3B6mQ@mail.gmail.com>
 <CACGkMEsu_OFFs15d2dzNbfSjzAZfYXLn9CNcO3ELPbDqZsndzg@mail.gmail.com>
 <50eb0df0-89fe-a5df-f89f-07bf69bd00ae@redhat.com>
MIME-Version: 1.0
In-Reply-To: <50eb0df0-89fe-a5df-f89f-07bf69bd00ae@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gV2VkLCBKYW4gMDQsIDIwMjMgYXQgMTI6MjM6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8xMi8yMyAxNDoyOSwgSmFzb24gV2FuZyDlhpnpgZM6Cj4gPiBPbiBG
cmksIERlYyAxNiwgMjAyMiBhdCAxMTo0MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgNTozNSBQTSBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIERlYyAx
NSwgMjAyMiBhdCAwNToxNTo0M1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4g
T24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgNTowMiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgMTE6
Mjc6MTlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBDb21taXQgYTc3
NjZlZjE4YjMzKCJ2aXJ0aW9fbmV0OiBkaXNhYmxlIGNiIGFnZ3Jlc3NpdmVseSIpIGVuYWJsZXMK
PiA+ID4gPiA+ID4gPiB2aXJ0cXVldWUgY2FsbGJhY2sgdmlhIHRoZSBmb2xsb3dpbmcgc3RhdGVt
ZW50Ogo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ICAgICAgICAgIGRvIHsKPiA+ID4gPiA+
ID4gPiAgICAgICAgICAgICAuLi4uLi4KPiA+ID4gPiA+ID4gPiAgICAgICAgfSB3aGlsZSAodXNl
X25hcGkgJiYga2ljayAmJgo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB1bmxpa2VseSgh
dmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSkpKTsKPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiBXaGVuIE5BUEkgaXMgdXNlZCBhbmQga2ljayBpcyBmYWxzZSwgdGhlIGNhbGxi
YWNrIHdvbid0IGJlIGVuYWJsZWQKPiA+ID4gPiA+ID4gPiBoZXJlLiBBbmQgd2hlbiB0aGUgdmly
dHF1ZXVlIGlzIGFib3V0IHRvIGJlIGZ1bGwsIHRoZSB0eCB3aWxsIGJlCj4gPiA+ID4gPiA+ID4g
ZGlzYWJsZWQsIGJ1dCB3ZSBzdGlsbCBkb24ndCBlbmFibGUgdHggaW50ZXJydXB0IHdoaWNoIHdp
bGwgY2F1c2UgYSBUWAo+ID4gPiA+ID4gPiA+IGhhbmcuIFRoaXMgY291bGQgYmUgb2JzZXJ2ZWQg
d2hlbiB1c2luZyBwa3RnZW4gd2l0aCBidXJzdCBlbmFibGVkLgo+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+IEZpeGluZyB0aGlzIGJ5IHRyeWluZyB0byBlbmFibGUgdHggaW50ZXJydXB0IGFm
dGVyIHdlIGRpc2FibGUgVFggd2hlbgo+ID4gPiA+ID4gPiA+IHdlJ3JlIG5vdCB1c2luZyBuYXBp
IG9yIGtpY2sgaXMgZmFsc2UuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gRml4ZXM6IGE3
NzY2ZWYxOGIzMyAoInZpcnRpb19uZXQ6IGRpc2FibGUgY2IgYWdncmVzc2l2ZWx5IikKPiA+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+
ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+IFRoZSBwYXRjaCBpcyBuZWVkZWQgZm9yIC1z
dGFibGUuCj4gPiA+ID4gPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToKPiA+ID4gPiA+ID4gPiAtIGVu
YWJsZSB0eCBpbnRlcnJ1cHQgYWZ0ZXIgd2UgZGlzYWJsZSB0eAo+ID4gPiA+ID4gPiA+IC0tLQo+
ID4gPiA+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ID4gPiA+ID4g
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiA+IGluZGV4IDg2ZTUy
NDU0YjViNS4uZGNmM2E1MzZkNzhhIDEwMDY0NAo+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4gPiA+ID4gPiA+IEBAIC0xODczLDcgKzE4NzMsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4
X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
KQo+ID4gPiA+ID4gPiA+ICAgICAgICAgKi8KPiA+ID4gPiA+ID4gPiAgICAgICAgaWYgKHNxLT52
cS0+bnVtX2ZyZWUgPCAyK01BWF9TS0JfRlJBR1MpIHsKPiA+ID4gPiA+ID4gPiAgICAgICAgICAg
ICAgICBuZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwgcW51bSk7Cj4gPiA+ID4gPiA+ID4gLSAgICAg
ICAgICAgICBpZiAoIXVzZV9uYXBpICYmCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAo
KCF1c2VfbmFwaSB8fCAha2ljaykgJiYKPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
dW5saWtlbHkoIXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpKSkgewo+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgLyogTW9yZSBqdXN0IGdvdCB1c2VkLCBmcmVl
IHRoZW0gdGhlbiByZWNoZWNrLiAqLwo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgZnJlZV9vbGRfeG1pdF9za2JzKHNxLCBmYWxzZSk7Cj4gPiA+ID4gPiA+IFRoaXMgd2lsbCB3
b3JrIGJ1dCB0aGUgZm9sbG93aW5nIGxpbmVzIGFyZToKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVlID49IDIrTUFYX1NL
Ql9GUkFHUykgewo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBu
ZXRpZl9zdGFydF9zdWJxdWV1ZShkZXYsIHFudW0pOwo+ID4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+IGFuZCBJIHRob3VnaHQgd2UgYXJlIHN1cHBvc2VkIHRvIGtlZXAgY2FsbGJh
Y2tzIGVuYWJsZWQgd2l0aCBuYXBpPwo+ID4gPiA+ID4gVGhpcyBzZWVtcyB0byBiZSB0aGUgb3Bw
b3NpdGUgbG9naWMgb2YgY29tbWl0IGE3NzY2ZWYxOGIzMyB0aGF0Cj4gPiA+ID4gPiBkaXNhYmxl
cyBjYWxsYmFja3MgZm9yIE5BUEkuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEl0IHNhaWQ6Cj4gPiA+
ID4gPiAKPiA+ID4gPiA+ICAgICAgVGhlcmUgYXJlIGN1cnJlbnRseSB0d28gY2FzZXMgd2hlcmUg
d2UgcG9sbCBUWCB2cSBub3QgaW4gcmVzcG9uc2UgdG8gYQo+ID4gPiA+ID4gICAgICBjYWxsYmFj
azogc3RhcnQgeG1pdCBhbmQgcnggbmFwaS4gIFdlIGN1cnJlbnRseSBkbyB0aGlzIHdpdGggY2Fs
bGJhY2tzCj4gPiA+ID4gPiAgICAgIGVuYWJsZWQgd2hpY2ggY2FuIGNhdXNlIGV4dHJhIGludGVy
cnVwdHMgZnJvbSB0aGUgY2FyZC4gIFVzZWQgbm90IHRvIGJlCj4gPiA+ID4gPiAgICAgIGEgYmln
IGlzc3VlIGFzIHdlIHJ1biB3aXRoIGludGVycnVwdHMgZGlzYWJsZWQgYnV0IHRoYXQgaXMgbm8g
bG9uZ2VyIHRoZQo+ID4gPiA+ID4gICAgICBjYXNlLCBhbmQgaW4gc29tZSBjYXNlcyB0aGUgcmF0
ZSBvZiBzcHVyaW91cyBpbnRlcnJ1cHRzIGlzIHNvIGhpZ2gKPiA+ID4gPiA+ICAgICAgbGludXgg
ZGV0ZWN0cyB0aGlzIGFuZCBhY3R1YWxseSBraWxscyB0aGUgaW50ZXJydXB0Lgo+ID4gPiA+ID4g
Cj4gPiA+ID4gPiBNeSB1bmRlcnNhdG5kaW5nIGlzIHRoYXQgaXQgdHJpZXMgdG8gZGlzYWJsZSBj
YWxsYmFja3Mgb24gVFguCj4gPiA+ID4gSSB0aGluayB3ZSB3YW50IHRvIGRpc2FibGUgY2FsbGJh
Y2tzIHdoaWxlIHBvbGxpbmcsIHllcy4gaGVyZSB3ZSBhcmUgbm90Cj4gPiA+ID4gcG9sbGluZywg
YW5kIEkgdGhpbmsgd2Ugd2FudCBhIGNhbGxiYWNrIGJlY2F1c2Ugb3RoZXJ3aXNlIG5vdGhpbmcg
d2lsbAo+ID4gPiA+IG9ycGhhbiBza2JzIGFuZCBhIHNvY2tldCBjYW4gYmUgYmxvY2tlZCwgbm90
IHRyYW5zbWl0dGluZyBhbnl0aGluZyAtIGEKPiA+ID4gPiBkZWFkbG9jay4KPiA+ID4gSSdtIG5v
dCBzdXJlIGhvdyBJIGdvdCBoZXJlLCBkaWQgeW91IG1lYW4gYSBwYXJ0aWFsIHJldmVydCBvZgo+
ID4gPiBhNzc2NmVmMThiMzMgKHRoZSBwYXJ0IHRoYXQgZGlzYWJsZXMgVFggY2FsbGJhY2tzIG9u
IHN0YXJ0X3htaXQpPwo+ID4gTWljaGFlbCwgYW55IGlkZWEgb24gdGhpcz8KPiA+IAo+ID4gVGhh
bmtzCj4gCj4gCj4gTWljaGFlbCwgYW55IGNvbW1lbnQ/Cj4gCj4gVGhhbmtzCgpTb3JyeSBJIGRv
bid0IHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLiBXaGF0IGRvZXMgImhvdyBJIGdvdCBoZXJlIiBt
ZWFuPwpUbyByZXBlYXQgbXkgc3VnZ2VzdGlvbjoKCglJIHRoaW5rIGl0IGlzIGVhc2llciB0byBq
dXN0IGRvIGEgc2VwYXJhdGUgYnJhbmNoIGhlcmUuIEFsb25nIHRoZQoJbGluZXMgb2Y6CgoJCQlp
ZiAodXNlX25hcGkpIHsKCQkJCWlmICh1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxh
eWVkKHNxLT52cSkpKQoJCQkJCXZpcnRxdWV1ZV9uYXBpX3NjaGVkdWxlKG5hcGksIHZxKTsKCQkJ
fSBlbHNlIHsKCQkJCS4uLiBvbGQgY29kZSAuLi4KCQkJfQoKd2UgY2FuIGFsc28gYmFja3BvcnQg
dGhpcyBtaW5pbWFsIHNhZmUgZml4LCBhbnkgcmVmYWN0b3JpbmdzIGNhbiBiZSBkb25lIG9uCnRv
cC4KCgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
