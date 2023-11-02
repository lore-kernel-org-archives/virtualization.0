Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC5C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 04:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBC1E4EF8F;
	Thu,  2 Nov 2023 04:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBC1E4EF8F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3mO9oixjaMO; Thu,  2 Nov 2023 04:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B0B74EF88;
	Thu,  2 Nov 2023 04:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B0B74EF88
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16050C0039;
	Thu,  2 Nov 2023 04:34:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C909C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEB1370513
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:34:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEB1370513
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cqpTLrU-HndO
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:34:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE40370510
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE40370510
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-jrOygo_oO3alTnFZb39VYw-1; Thu, 02 Nov 2023 00:34:36 -0400
X-MC-Unique: jrOygo_oO3alTnFZb39VYw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5afc00161daso8361717b3.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Nov 2023 21:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698899676; x=1699504476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpFEm29NArlyMffn6cLyxmCPyrgtdaJfg31aiJan1nE=;
 b=qJHYXM/kujIEl2bWrfH5kJOL6p5Wz1Pf+pysv4FbGWr8DjmrOaBInWMD2u6210Tj9h
 ye4YrdmqHLDJyFbtjjw4CsbetaBnLEKnXG2Va2mzb/9YQoNxvuJX2tfYhsTI9wTDhh1L
 afS02sNJ9cOgyzvnuiBuxHJV496N+P8z/QDCzwxcEzBymbG/xHAHoo/Cam/DkaaHCnhl
 PvG95ZztcbF3W2+ByP+OC7jyXXxOmVqjoDvkAxphnTguYdfYo7sw5/2qFxTNQYEKNYWi
 YU2Wd7eR/1+OVEPzYbzQg/VKD+o5VYHhwbysUe8oYbTI2CgjFh5UExTuRLy9lJPaegb6
 4FPg==
X-Gm-Message-State: AOJu0YyF87jdH5wh3gguktAnV6Km4HsUEwk1Q/2eDxGMMLoPW0KFX2dk
 K6tYVnrW064bg8yYfjIiG7Mb58p2BMLQLqoXYRDe342d6cVd9x1DU4R/+ndS4y1PQnoUZ7SC7E7
 zF1Lwc5LB14b1m6I226zjkM5/ZdojHpSmlPi4jmyVA+ejx/y9jOdyVyZ4qw==
X-Received: by 2002:a25:b01:0:b0:da0:54f7:11cf with SMTP id
 1-20020a250b01000000b00da054f711cfmr14684436ybl.49.1698899675687; 
 Wed, 01 Nov 2023 21:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsr0DLVOjExS4bDDTCowgNddNfuKIoTKGW6eeX2ycBl+rpwgfp06N8w0hPu441s4dXOo9yoKU3wJY/gYL0MQ8=
X-Received: by 2002:a25:b01:0:b0:da0:54f7:11cf with SMTP id
 1-20020a250b01000000b00da054f711cfmr14684427ybl.49.1698899675399; Wed, 01 Nov
 2023 21:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
 <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
 <753ac6da-f7f1-4acb-9184-e59271809c6d@linux.alibaba.com>
In-Reply-To: <753ac6da-f7f1-4acb-9184-e59271809c6d@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 12:34:23 +0800
Message-ID: <CACGkMEsRVV9mgVe2+Qe89QZD807KV8jyBmAz5--Z3NiZBPrPVg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBOb3YgMSwgMjAyMyBhdCA1OjM44oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFs
aWJhYmEuY29tPiB3cm90ZToKPgo+Cj4KPiDlnKggMjAyMy8xMC8yNSDkuIrljYg5OjE4LCBKYXNv
biBXYW5nIOWGmemBkzoKPiA+IE9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDg6MDPigK9QTSBIZW5n
IFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4+Cj4gPj4KPiA+PiDlnKgg
MjAyMy8xMC8xMiDkuIvljYg0OjI5LCBKYXNvbiBXYW5nIOWGmemBkzoKPiA+Pj4gT24gVGh1LCBP
Y3QgMTIsIDIwMjMgYXQgMzo0NOKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPj4+PiBOb3csIHZpcnRpby1uZXQgYWxyZWFkeSBzdXBwb3J0cyBwZXItcXVl
dWUgbW9kZXJhdGlvbiBwYXJhbWV0ZXIKPiA+Pj4+IHNldHRpbmcuIEJhc2VkIG9uIHRoaXMsIHdl
IHVzZSB0aGUgbmV0ZGltIGxpYnJhcnkgb2YgbGludXggdG8gc3VwcG9ydAo+ID4+Pj4gZHluYW1p
YyBjb2FsZXNjaW5nIG1vZGVyYXRpb24gZm9yIHZpcnRpby1uZXQuCj4gPj4+Pgo+ID4+Pj4gRHVl
IHRvIGhhcmR3YXJlIHNjaGVkdWxpbmcgaXNzdWVzLCB3ZSBvbmx5IHRlc3RlZCByeCBkaW0uCj4g
Pj4+IERvIHlvdSBoYXZlIFBQUyBudW1iZXJzPyBBbmQgVFggbnVtYmVycyBhcmUgYWxzbyBpbXBv
cnRhbnQgYXMgdGhlCj4gPj4+IHRocm91Z2hwdXQgY291bGQgYmUgbWlzbGVhZGluZyBkdWUgdG8g
dmFyaW91cyByZWFzb25zLgo+ID4+IEhpIEphc29uIQo+ID4+Cj4gPj4gVGhlIGNvbXBhcmlzb24g
b2YgcnggbmV0ZGltIHBlcmZvcm1hbmNlIGlzIGFzIGZvbGxvd3M6Cj4gPj4gKHRoZSBiYWNrZW5k
IHN1cHBvcnRpbmcgdHggZGltIGlzIG5vdCB5ZXQgcmVhZHkpCj4gPiBUaGFua3MgYSBsb3QgZm9y
IHRoZSBudW1iZXJzLgo+ID4KPiA+IEknZCBzdGlsbCBleHBlY3QgdGhlIFRYIHJlc3VsdCBhcyBJ
IGRpZCBwbGF5IHR4IGludGVycnVwdCBjb2FsZXNjaW5nCj4KPiBIaSwgSmFzb24uCj4KPiBTb3Jy
eSBmb3IgdGhlIGxhdGUgcmVwbHkgdG8gdGhpcyEgT3VyIHRlYW0gaGFzIGJlZW4gYmxvY2tlZCBi
eSBvdGhlcgo+IHByaW9yaXRpZXMgdGhlIHBhc3QgZmV3IGRheXMuCj4KPiBGb3IgdHggZGltLCB3
ZSBoYXZlIGEgZml4ZWQgZW1waXJpY2FsIHZhbHVlIGludGVybmFsbHkuCj4gVGhpcyB2YWx1ZSBw
ZXJmb3JtcyBiZXR0ZXIgb3ZlcmFsbCB0aGFuIG1hbnVhbGx5IGFkanVzdGluZyB0aGUgdHggdGlt
ZXIKPiByZWdpc3RlciAtLT4KPiBJJ2xsIGRvIG5vdCBoYXZlIHR4IG51bWJlcnMuIDooIFNvIGlu
IHRoZSBzaG9ydCB0ZXJtIEkgbm8gbG9uZ2VyIHRyeSB0bwo+IHB1c2ggWzUvNV0KPiBwYXRjaCBm
b3IgdHggZGltIGFuZCB0cnkgdG8gcmV0dXJuIC1FT1BOT1RTVVBQIGZvciBpdCwgc29ycnkgZm9y
IHRoaXMuCj4KPiA+IGFib3V0IDEwIHllYXJzIGFnby4KPiA+Cj4gPiBJIHdpbGwgc3RhcnQgdG8g
cmV2aWV3IHRoZSBzZXJpZXMgYnV0IGxldCdzIHRyeSB0byBoYXZlIHNvbWUgVFggbnVtYmVycyBh
cyB3ZWxsLgo+ID4KPiA+IEJ0dywgaXQgd291bGQgYmUgbW9yZSBjb252ZW5pZW50IHRvIGhhdmUg
YSByYXcgUFBTIGJlbmNobWFyay4gRS5nIHlvdQo+Cj4gSSBnb3Qgc29tZSByYXcgcHBzIGRhdGEg
dXNpbmcgcGt0Z2VuIGZyb20gbGludXgvc2FtcGxlL3BrdGdlbjoKPgo+IDEuIHR4IGNtZAo+IC4v
cGt0Z2VuX3NhbXBsZTAyX211bHRpcXVldWUuc2ggLWkgZXRoMSAtcyA0NCAtZCAke2RzdF9pcH0g
LW0gJHtkc3RfbWFjfQo+IC10IDggLWYgMCAtbiAwCj4KPiBUaGlzIHVzZXMgOCBrcGt0Z2VuZCB0
aHJlYWRzIHRvIGluamVjdCBkYXRhIGludG8gZXRoMS4KPgo+IDIuIFJ4IHNpZGUgbG9hZHMgYSBz
aW1wbGUgeGRwIHByb2cgd2hpY2ggZHJvcHMgYWxsIHJlY2VpdmVkIHVkcCBwYWNrZXRzLgo+Cj4g
My4gRGF0YQo+IHBwczogfjEwMDB3CgpGb3IgInciIGRpZCB5b3UgbWVhbiAxMCBtaWxsaW9uPyBM
b29rcyB0b28gaHVnZSB0byBtZT8KCj4gcnggZGltIG9mZjogY3B1IGlkbGU9IH4zNSUKPiByeCBk
aW0gb246IGNwdSBpZGxlPSB+NzYlCgpUaGlzIGxvb2tzIHByb21pc2luZy4KClRoYW5rcwoKPgo+
IFRoYW5rcyEKPgo+ID4gY2FuIHRyeSB0byB1c2UgYSBzb2Z0d2FyZSBvciBoYXJkd2FyZSBwYWNr
ZXQgZ2VuZXJhdG9yLgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+Pgo+ID4+IEkuIFNvY2twZXJmIFVE
UAo+ID4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
PiA+PiAxLiBFbnYKPiA+PiByeHFfMCBpcyBhZmZpbml0eSB0byBjcHVfMAo+ID4+Cj4gPj4gMi4g
Q21kCj4gPj4gY2xpZW50OiAgdGFza3NldCAtYyAwIHNvY2twZXJmIHRwIC1wIDg5ODkgLWkgJElQ
IC10IDEwIC1tIDE2Qgo+ID4+IHNlcnZlcjogdGFza3NldCAtYyAwIHNvY2twZXJmIHNyIC1wIDg5
ODkKPiA+Pgo+ID4+IDMuIFJlc3VsdAo+ID4+IGRpbSBvZmY6IDExNDMyNzcuMDAgcnhwcHMsIHRo
cm91Z2hwdXQgMTcuODQ0IE1CcHMsIGNwdSBpcyAxMDAlLgo+ID4+IGRpbSBvbjogMTEyNDE2MS4w
MCByeHBwcywgdGhyb3VnaHB1dCAxNy42MTAgTUJwcywgY3B1IGlzIDgzLjUlLgo+ID4+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Pgo+ID4+Cj4g
Pj4gSUkuIFJlZGlzCj4gPj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQo+ID4+IDEuIEVudgo+ID4+IFRoZXJlIGFyZSA4IHJ4cXMgYW5kIHJ4cV9pIGlz
IGFmZmluaXR5IHRvIGNwdV9pLgo+ID4+Cj4gPj4gMi4gUmVzdWx0Cj4gPj4gV2hlbiBhbGwgY3B1
cyBhcmUgMTAwJSwgb3BzL3NlYyBvZiBtZW10aWVyX2JlbmNobWFyayBjbGllbnQgaXMKPiA+PiBk
aW0gb2ZmOiAgIDk3ODQzNy4yMwo+ID4+IGRpbSBvbjogMTE0MzYzOC4yOAo+ID4+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Pgo+ID4+Cj4gPj4g
SUlJLiBOZ2lueAo+ID4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPiA+PiAxLiBFbnYKPiA+PiBUaGVyZSBhcmUgOCByeHFzIGFuZCByeHFfaSBpcyBh
ZmZpbml0eSB0byBjcHVfaS4KPiA+Pgo+ID4+IDIuIFJlc3VsdAo+ID4+IFdoZW4gYWxsIGNwdXMg
YXJlIDEwMCUsIHJlcXVlc3RzL3NlYyBvZiB3cmsgY2xpZW50IGlzCj4gPj4gZGltIG9mZjogICA4
Nzc5MzEuNjcKPiA+PiBkaW0gb246IDEwMTkxNjAuMzEKPiA+PiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPj4KPiA+PiBUaGFua3MhCj4gPj4KPiA+
Pj4gVGhhbmtzCj4gPj4+Cj4gPj4+PiBAVGVzdCBlbnYKPiA+Pj4+IHJ4cTAgaGFzIGFmZmluaXR5
IHRvIGNwdTAuCj4gPj4+Pgo+ID4+Pj4gQFRlc3QgY21kCj4gPj4+PiBjbGllbnQ6IHRhc2tzZXQg
LWMgMCBzb2NrcGVyZiB0cCAtaSAke0lQfSAtdCAzMCAtLXRjcCAtbSAke21zZ19zaXplfQo+ID4+
Pj4gc2VydmVyOiB0YXNrc2V0IC1jIDAgc29ja3BlcmYgc3IgLS10Y3AKPiA+Pj4+Cj4gPj4+PiBA
VGVzdCByZXMKPiA+Pj4+IFRoZSBzZWNvbmQgY29sdW1uIGlzIHRoZSByYXRpbyBvZiB0aGUgcmVz
dWx0IHJldHVybmVkIGJ5IGNsaWVudAo+ID4+Pj4gd2hlbiByeCBkaW0gaXMgZW5hYmxlZCB0byB0
aGUgcmVzdWx0IHJldHVybmVkIGJ5IGNsaWVudCB3aGVuCj4gPj4+PiByeCBkaW0gaXMgZGlzYWJs
ZWQuCj4gPj4+PiAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiA+Pj4+ICAgICAgICAgICB8IG1zZ19zaXplIHwgIHJ4X2RpbT1vbiAvIHJ4X2RpbT1vZmYg
fAo+ID4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gPj4+PiAgICAgICAgICAgfCAgIDE0QiAgICB8ICAgICAgICAgKyAzJSAgICAgICAgICAgIHwK
PiA+Pj4+ICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
ID4+Pj4gICAgICAgICAgIHwgICAxMDBCICAgfCAgICAgICAgICsgMTYlICAgICAgICAgICB8Cj4g
Pj4+PiAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+
Pj4+ICAgICAgICAgICB8ICAgNTAwQiAgIHwgICAgICAgICArIDI1JSAgICAgICAgICAgfAo+ID4+
Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4+
PiAgICAgICAgICAgfCAgIDE0MDBCICB8ICAgICAgICAgKyAyOCUgICAgICAgICAgIHwKPiA+Pj4+
ICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+Pj4g
ICAgICAgICAgIHwgICAyMDQ4QiAgfCAgICAgICAgICsgMjIlICAgICAgICAgICB8Cj4gPj4+PiAg
ICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+Pj4+ICAg
ICAgICAgICB8ICAgNDA5NkIgIHwgICAgICAgICArIDUlICAgICAgICAgICAgfAo+ID4+Pj4gICAg
ICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4+Pgo+ID4+
Pj4gLS0tCj4gPj4+PiBUaGlzIHBhdGNoIHNldCB3YXMgcGFydCBvZiB0aGUgcHJldmlvdXMgbmV0
ZGltIHBhdGNoIHNldFsxXS4KPiA+Pj4+IFsxXSB3YXMgc3BsaXQgaW50byBhIG1lcmdlZCBidWdm
aXggc2V0WzJdIGFuZCB0aGUgY3VycmVudCBzZXQuCj4gPj4+PiBUaGUgcHJldmlvdXMgcmVsZXZh
bnQgY29tbWVudGF0b3JzIGhhdmUgYmVlbiBDY2VkLgo+ID4+Pj4KPiA+Pj4+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4MTEwNjU1MTIuMjIxOTAtMS1oZW5ncWlAbGludXgu
YWxpYmFiYS5jb20vCj4gPj4+PiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVy
LjE2OTY3NDU0NTIuZ2l0LmhlbmdxaUBsaW51eC5hbGliYWJhLmNvbS8KPiA+Pj4+Cj4gPj4+PiBI
ZW5nIFFpICg1KToKPiA+Pj4+ICAgICB2aXJ0aW8tbmV0OiByZXR1cm5zIHdoZXRoZXIgbmFwaSBp
cyBjb21wbGV0ZQo+ID4+Pj4gICAgIHZpcnRpby1uZXQ6IHNlcGFyYXRlIHJ4L3R4IGNvYWxlc2Np
bmcgbW9kZXJhdGlvbiBjbWRzCj4gPj4+PiAgICAgdmlydGlvLW5ldDogZXh0cmFjdCB2aXJ0cXVl
dWUgY29hbGVzY2lnIGNtZCBmb3IgcmV1c2UKPiA+Pj4+ICAgICB2aXJ0aW8tbmV0OiBzdXBwb3J0
IHJ4IG5ldGRpbQo+ID4+Pj4gICAgIHZpcnRpby1uZXQ6IHN1cHBvcnQgdHggbmV0ZGltCj4gPj4+
Pgo+ID4+Pj4gICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzk0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ID4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMyMiBp
bnNlcnRpb25zKCspLCA3MiBkZWxldGlvbnMoLSkKPiA+Pj4+Cj4gPj4+PiAtLQo+ID4+Pj4gMi4x
OS4xLjYuZ2I0ODU3MTBiCj4gPj4+Pgo+ID4+Pj4KPiA+Pgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
