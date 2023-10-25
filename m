Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91692C25B6B
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 05:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B49D4F210;
	Wed, 25 Oct 2023 05:53:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B49D4F210
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hKku4zLj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWdnlfYWcIRN; Wed, 25 Oct 2023 05:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 544884EE45;
	Wed, 25 Oct 2023 05:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 544884EE45
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B64FC0039;
	Wed, 25 Oct 2023 05:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7502BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D88384FFF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D88384FFF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hKku4zLj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRpGIR0qS3KD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:53:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CA6884FFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 05:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CA6884FFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698213232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubCPHMOlreiJtQ+N6ueZ0lVtDni4RqOGkWgFbQwJEWk=;
 b=hKku4zLjOQl4kJNL0hyiIx7izFzmdcNwf7BOrXo3fir4RNpSVh/OuuIkDbFtOnW+gZHr0P
 nkn9Iv5r5U9p5BmWXLXkKeMp9l7oyXCMq/JS2X3QSfm45vUWEsxGV2S9AEfk28XEybE5Z3
 2D0ts2FVp1IFQRtKChFFLm22tucDWVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-JxAFcAG-Pw-ceqVJ23AnoA-1; Wed, 25 Oct 2023 01:53:45 -0400
X-MC-Unique: JxAFcAG-Pw-ceqVJ23AnoA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32dc767e619so2384742f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 22:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698213224; x=1698818024;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubCPHMOlreiJtQ+N6ueZ0lVtDni4RqOGkWgFbQwJEWk=;
 b=RbbyEaE3uC0PqOALY8RZs6evmGiB8EGl0uCBtrh0Gk8a2cijX0+XyWZxhzmYrIIcZM
 pA8k7BaNYjjHi4tIOrPUK5xJh3FqfsFjUi3jvk4erRJTXjEUAEKRRr/GztTMYSDVoBGu
 MOjaRuDKAo7b/WfbdgG6+IVKYtoa2btULRc7x5pfmc0VL8dlr37Op6xMHBR0r0h0H6RC
 w30uOtUxh6z8fjAbVF0WOYS69UknOLUtyQx1CHE+p5ySdYJ9QqrXiSuJ0Oj9ALhGI8x2
 WPig9BeRrKPsVqzHZY0Q8PlPGIMId2hb3NLHBs+Oc9VG4oE9UKyjY++uIUiGV0my3zT7
 fSVA==
X-Gm-Message-State: AOJu0YzEQy08JSEBVMFuXeLXNmsslORcHN+bkIMrNFAOUZN4s2CNbrgT
 fnKUUJaUV3U9isahk/VSnV6NDB3Q1FSHxY7dw+0VspoctkAINR7yYnO+UNI84IxTkna5dEmU0dW
 22Q49aiwEqOXkzYzqhoDpxZfRX/pV1bE343juTaHNRA==
X-Received: by 2002:a5d:58d4:0:b0:32d:ba1e:5cee with SMTP id
 o20-20020a5d58d4000000b0032dba1e5ceemr9743306wrf.45.1698213224517; 
 Tue, 24 Oct 2023 22:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5c2YSpkwKFmHyjOBWo7oEpueedhzE4gMzP/K4t5T/VbmEHDv2P9mk7ciY/fkpt2iryR0m8A==
X-Received: by 2002:a5d:58d4:0:b0:32d:ba1e:5cee with SMTP id
 o20-20020a5d58d4000000b0032dba1e5ceemr9743299wrf.45.1698213224157; 
 Tue, 24 Oct 2023 22:53:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
 by smtp.gmail.com with ESMTPSA id
 n12-20020adfe78c000000b00326f0ca3566sm11364036wrm.50.2023.10.24.22.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 22:53:43 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:53:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
Message-ID: <20231025015243-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
 <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Heng Qi <hengqi@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgMDk6MTg6MjdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIE9jdCAyNCwgMjAyMyBhdCA4OjAz4oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4KPiA+IOWcqCAyMDIzLzEwLzEyIOS4
i+WNiDQ6MjksIEphc29uIFdhbmcg5YaZ6YGTOgo+ID4gPiBPbiBUaHUsIE9jdCAxMiwgMjAyMyBh
dCAzOjQ04oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+
ID4+IE5vdywgdmlydGlvLW5ldCBhbHJlYWR5IHN1cHBvcnRzIHBlci1xdWV1ZSBtb2RlcmF0aW9u
IHBhcmFtZXRlcgo+ID4gPj4gc2V0dGluZy4gQmFzZWQgb24gdGhpcywgd2UgdXNlIHRoZSBuZXRk
aW0gbGlicmFyeSBvZiBsaW51eCB0byBzdXBwb3J0Cj4gPiA+PiBkeW5hbWljIGNvYWxlc2Npbmcg
bW9kZXJhdGlvbiBmb3IgdmlydGlvLW5ldC4KPiA+ID4+Cj4gPiA+PiBEdWUgdG8gaGFyZHdhcmUg
c2NoZWR1bGluZyBpc3N1ZXMsIHdlIG9ubHkgdGVzdGVkIHJ4IGRpbS4KPiA+ID4gRG8geW91IGhh
dmUgUFBTIG51bWJlcnM/IEFuZCBUWCBudW1iZXJzIGFyZSBhbHNvIGltcG9ydGFudCBhcyB0aGUK
PiA+ID4gdGhyb3VnaHB1dCBjb3VsZCBiZSBtaXNsZWFkaW5nIGR1ZSB0byB2YXJpb3VzIHJlYXNv
bnMuCj4gPgo+ID4gSGkgSmFzb24hCj4gPgo+ID4gVGhlIGNvbXBhcmlzb24gb2YgcnggbmV0ZGlt
IHBlcmZvcm1hbmNlIGlzIGFzIGZvbGxvd3M6Cj4gPiAodGhlIGJhY2tlbmQgc3VwcG9ydGluZyB0
eCBkaW0gaXMgbm90IHlldCByZWFkeSkKPiAKPiBUaGFua3MgYSBsb3QgZm9yIHRoZSBudW1iZXJz
Lgo+IAo+IEknZCBzdGlsbCBleHBlY3QgdGhlIFRYIHJlc3VsdCBhcyBJIGRpZCBwbGF5IHR4IGlu
dGVycnVwdCBjb2FsZXNjaW5nCj4gYWJvdXQgMTAgeWVhcnMgYWdvLgo+IAo+IEkgd2lsbCBzdGFy
dCB0byByZXZpZXcgdGhlIHNlcmllcyBidXQgbGV0J3MgdHJ5IHRvIGhhdmUgc29tZSBUWCBudW1i
ZXJzIGFzIHdlbGwuCj4gCj4gQnR3LCBpdCB3b3VsZCBiZSBtb3JlIGNvbnZlbmllbnQgdG8gaGF2
ZSBhIHJhdyBQUFMgYmVuY2htYXJrLiBFLmcgeW91Cj4gY2FuIHRyeSB0byB1c2UgYSBzb2Z0d2Fy
ZSBvciBoYXJkd2FyZSBwYWNrZXQgZ2VuZXJhdG9yLgo+IAo+IFRoYW5rcwoKTGF0ZW5jeSByZXN1
bHRzIGFyZSBhbHNvIGtpbmQgb2YgaW50ZXJlc3RpbmcuCgoKPiA+Cj4gPgo+ID4gSS4gU29ja3Bl
cmYgVURQCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cj4gPiAxLiBFbnYKPiA+IHJ4cV8wIGlzIGFmZmluaXR5IHRvIGNwdV8wCj4gPgo+ID4gMi4g
Q21kCj4gPiBjbGllbnQ6ICB0YXNrc2V0IC1jIDAgc29ja3BlcmYgdHAgLXAgODk4OSAtaSAkSVAg
LXQgMTAgLW0gMTZCCj4gPiBzZXJ2ZXI6IHRhc2tzZXQgLWMgMCBzb2NrcGVyZiBzciAtcCA4OTg5
Cj4gPgo+ID4gMy4gUmVzdWx0Cj4gPiBkaW0gb2ZmOiAxMTQzMjc3LjAwIHJ4cHBzLCB0aHJvdWdo
cHV0IDE3Ljg0NCBNQnBzLCBjcHUgaXMgMTAwJS4KPiA+IGRpbSBvbjogMTEyNDE2MS4wMCByeHBw
cywgdGhyb3VnaHB1dCAxNy42MTAgTUJwcywgY3B1IGlzIDgzLjUlLgo+ID4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4KPiA+Cj4gPiBJSS4gUmVk
aXMKPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
PiA+IDEuIEVudgo+ID4gVGhlcmUgYXJlIDggcnhxcyBhbmQgcnhxX2kgaXMgYWZmaW5pdHkgdG8g
Y3B1X2kuCj4gPgo+ID4gMi4gUmVzdWx0Cj4gPiBXaGVuIGFsbCBjcHVzIGFyZSAxMDAlLCBvcHMv
c2VjIG9mIG1lbXRpZXJfYmVuY2htYXJrIGNsaWVudCBpcwo+ID4gZGltIG9mZjogICA5Nzg0Mzcu
MjMKPiA+IGRpbSBvbjogMTE0MzYzOC4yOAo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQo+ID4KPiA+Cj4gPiBJSUkuIE5naW54Cj4gPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiAxLiBFbnYKPiA+
IFRoZXJlIGFyZSA4IHJ4cXMgYW5kIHJ4cV9pIGlzIGFmZmluaXR5IHRvIGNwdV9pLgo+ID4KPiA+
IDIuIFJlc3VsdAo+ID4gV2hlbiBhbGwgY3B1cyBhcmUgMTAwJSwgcmVxdWVzdHMvc2VjIG9mIHdy
ayBjbGllbnQgaXMKPiA+IGRpbSBvZmY6ICAgODc3OTMxLjY3Cj4gPiBkaW0gb246IDEwMTkxNjAu
MzEKPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
PiA+Cj4gPiBUaGFua3MhCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4+IEBUZXN0
IGVudgo+ID4gPj4gcnhxMCBoYXMgYWZmaW5pdHkgdG8gY3B1MC4KPiA+ID4+Cj4gPiA+PiBAVGVz
dCBjbWQKPiA+ID4+IGNsaWVudDogdGFza3NldCAtYyAwIHNvY2twZXJmIHRwIC1pICR7SVB9IC10
IDMwIC0tdGNwIC1tICR7bXNnX3NpemV9Cj4gPiA+PiBzZXJ2ZXI6IHRhc2tzZXQgLWMgMCBzb2Nr
cGVyZiBzciAtLXRjcAo+ID4gPj4KPiA+ID4+IEBUZXN0IHJlcwo+ID4gPj4gVGhlIHNlY29uZCBj
b2x1bW4gaXMgdGhlIHJhdGlvIG9mIHRoZSByZXN1bHQgcmV0dXJuZWQgYnkgY2xpZW50Cj4gPiA+
PiB3aGVuIHJ4IGRpbSBpcyBlbmFibGVkIHRvIHRoZSByZXN1bHQgcmV0dXJuZWQgYnkgY2xpZW50
IHdoZW4KPiA+ID4+IHJ4IGRpbSBpcyBkaXNhYmxlZC4KPiA+ID4+ICAgICAgICAgIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+PiAgICAgICAgICB8IG1zZ19zaXpl
IHwgIHJ4X2RpbT1vbiAvIHJ4X2RpbT1vZmYgfAo+ID4gPj4gICAgICAgICAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4+ICAgICAgICAgIHwgICAxNEIgICAgfCAg
ICAgICAgICsgMyUgICAgICAgICAgICB8Cj4gPiA+PiAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPj4gICAgICAgICAgfCAgIDEwMEIgICB8ICAgICAg
ICAgKyAxNiUgICAgICAgICAgIHwKPiA+ID4+ICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+PiAgICAgICAgICB8ICAgNTAwQiAgIHwgICAgICAgICAr
IDI1JSAgICAgICAgICAgfAo+ID4gPj4gICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiA+ID4+ICAgICAgICAgIHwgICAxNDAwQiAgfCAgICAgICAgICsgMjgl
ICAgICAgICAgICB8Cj4gPiA+PiAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ID4gPj4gICAgICAgICAgfCAgIDIwNDhCICB8ICAgICAgICAgKyAyMiUgICAg
ICAgICAgIHwKPiA+ID4+ICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gPiA+PiAgICAgICAgICB8ICAgNDA5NkIgIHwgICAgICAgICArIDUlICAgICAgICAg
ICAgfAo+ID4gPj4gICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiA+ID4+Cj4gPiA+PiAtLS0KPiA+ID4+IFRoaXMgcGF0Y2ggc2V0IHdhcyBwYXJ0IG9mIHRo
ZSBwcmV2aW91cyBuZXRkaW0gcGF0Y2ggc2V0WzFdLgo+ID4gPj4gWzFdIHdhcyBzcGxpdCBpbnRv
IGEgbWVyZ2VkIGJ1Z2ZpeCBzZXRbMl0gYW5kIHRoZSBjdXJyZW50IHNldC4KPiA+ID4+IFRoZSBw
cmV2aW91cyByZWxldmFudCBjb21tZW50YXRvcnMgaGF2ZSBiZWVuIENjZWQuCj4gPiA+Pgo+ID4g
Pj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgxMTA2NTUxMi4yMjE5MC0x
LWhlbmdxaUBsaW51eC5hbGliYWJhLmNvbS8KPiA+ID4+IFsyXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvY292ZXIuMTY5Njc0NTQ1Mi5naXQuaGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tLwo+
ID4gPj4KPiA+ID4+IEhlbmcgUWkgKDUpOgo+ID4gPj4gICAgdmlydGlvLW5ldDogcmV0dXJucyB3
aGV0aGVyIG5hcGkgaXMgY29tcGxldGUKPiA+ID4+ICAgIHZpcnRpby1uZXQ6IHNlcGFyYXRlIHJ4
L3R4IGNvYWxlc2NpbmcgbW9kZXJhdGlvbiBjbWRzCj4gPiA+PiAgICB2aXJ0aW8tbmV0OiBleHRy
YWN0IHZpcnRxdWV1ZSBjb2FsZXNjaWcgY21kIGZvciByZXVzZQo+ID4gPj4gICAgdmlydGlvLW5l
dDogc3VwcG9ydCByeCBuZXRkaW0KPiA+ID4+ICAgIHZpcnRpby1uZXQ6IHN1cHBvcnQgdHggbmV0
ZGltCj4gPiA+Pgo+ID4gPj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAzOTQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCj4gPiA+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzMjIgaW5zZXJ0aW9ucygrKSwgNzIgZGVsZXRpb25zKC0pCj4gPiA+Pgo+ID4gPj4gLS0KPiA+
ID4+IDIuMTkuMS42LmdiNDg1NzEwYgo+ID4gPj4KPiA+ID4+Cj4gPgo+ID4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
