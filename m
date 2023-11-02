Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8365C4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 04:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70DDE4EF80;
	Thu,  2 Nov 2023 04:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70DDE4EF80
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2zhB8SZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hSXc5vYDAwr; Thu,  2 Nov 2023 04:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E46FD4EF7B;
	Thu,  2 Nov 2023 04:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E46FD4EF7B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE92EC0039;
	Thu,  2 Nov 2023 04:33:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2663FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F18E443330
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F18E443330
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2zhB8SZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2yMJMPlSf4Es
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:33:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AF7F4332C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 04:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AF7F4332C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698899595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y98Oj+fTiOqVHZf5XNKpFyZowS6KE9Dc3E1VJK061b4=;
 b=D2zhB8SZAL5k/tNZ2HguCSBrVfCCsGH7ep9AyPhgTlItKZQatyE/UZlyxV942uur0QOMB0
 D72ruZUW58Gb6M0lj135NXCs9WDtgZ+k9FO9obpVdYTH5p7R2E2kPCdlywowNduF5snegd
 WFp7PaX/iyswajiCBJB2/uwNxecB0DU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-kH3KQjs7MiKwTHiIhMJgBw-1; Thu, 02 Nov 2023 00:33:13 -0400
X-MC-Unique: kH3KQjs7MiKwTHiIhMJgBw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-670b32845a7so6972826d6.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Nov 2023 21:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698899593; x=1699504393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y98Oj+fTiOqVHZf5XNKpFyZowS6KE9Dc3E1VJK061b4=;
 b=Aej/uszyTU/DCcceZO4x1+/qENTOAzg7z2Lr9afMGSifiku0wtLrmg/T4S/D6/OKEE
 0t4zV3aYlTG8Nt+MCr223v74oWOtCff6PmulEx4k2wxhdvh6XCQsd7jWEF+tFIG6o0F1
 Zf5ZsF2lMQDTFb4SpYnynn1+mJ+N67OgAS5SK6QqSTaRceaStKHw7RTeARhEFQuoOXN/
 iU4whPGFwiJ06eWMKsJ/RJrWH04zaOx7YJG+iExpwN9aGVBxTMuMbHeovVdLXL1tq3hO
 XQd5wjZxocXhWlylyHJaw4q8V4nZuxb/dkuh61U4j2jQGIRUzDoPHc8nx2SOCFllvkhY
 LMEg==
X-Gm-Message-State: AOJu0Yy7FBOc6+gxHImUlkvciq3LHAwwZ/X/uzKOdjFJcCI170vBlsak
 auvdEKpTEcawlk2iII8u2ukVJG3dpG4FZtjosgdFdz7wNeAz1xybPZ/OiICSq7eVMTOhJeA1ONu
 /C2ytYkxVZHjflaQyFwr1AP4dgewyimJZR777iNgjq8Jknh1Jbl2Ij/olSA==
X-Received: by 2002:a05:6214:aca:b0:673:b0e7:1916 with SMTP id
 g10-20020a0562140aca00b00673b0e71916mr10917476qvi.2.1698899593194; 
 Wed, 01 Nov 2023 21:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7nlFlO39vZUy7zUX/dKshbsIenSEP1pKRrU9XA0UfkY4zAhtRq4JUZ77uWhbM/nKAkjBU1ml5Ybe7rqUC4Yw=
X-Received: by 2002:a05:6214:aca:b0:673:b0e7:1916 with SMTP id
 g10-20020a0562140aca00b00673b0e71916mr10917453qvi.2.1698899592888; Wed, 01
 Nov 2023 21:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
 <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
 <20231025015243-mutt-send-email-mst@kernel.org>
 <d3b9e9e8-1ef4-48ac-8a2f-4fa647ae4372@linux.alibaba.com>
In-Reply-To: <d3b9e9e8-1ef4-48ac-8a2f-4fa647ae4372@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 12:33:01 +0800
Message-ID: <CACGkMEsQ4oDbXPQZ2boB-Bj36qzWs9Sx_Du9ZiJLe+-99DOtwQ@mail.gmail.com>
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

T24gV2VkLCBOb3YgMSwgMjAyMyBhdCA3OjAz4oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFs
aWJhYmEuY29tPiB3cm90ZToKPgo+Cj4KPiDlnKggMjAyMy8xMC8yNSDkuIvljYgxOjUzLCBNaWNo
YWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gT24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgMDk6MTg6
MjdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+PiBPbiBUdWUsIE9jdCAyNCwgMjAyMyBh
dCA4OjAz4oCvUE0gSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+
Pj4KPiA+Pj4KPiA+Pj4g5ZyoIDIwMjMvMTAvMTIg5LiL5Y2INDoyOSwgSmFzb24gV2FuZyDlhpnp
gZM6Cj4gPj4+PiBPbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCAzOjQ04oCvUE0gSGVuZyBRaSA8aGVu
Z3FpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Pj4+PiBOb3csIHZpcnRpby1uZXQgYWxy
ZWFkeSBzdXBwb3J0cyBwZXItcXVldWUgbW9kZXJhdGlvbiBwYXJhbWV0ZXIKPiA+Pj4+PiBzZXR0
aW5nLiBCYXNlZCBvbiB0aGlzLCB3ZSB1c2UgdGhlIG5ldGRpbSBsaWJyYXJ5IG9mIGxpbnV4IHRv
IHN1cHBvcnQKPiA+Pj4+PiBkeW5hbWljIGNvYWxlc2NpbmcgbW9kZXJhdGlvbiBmb3IgdmlydGlv
LW5ldC4KPiA+Pj4+Pgo+ID4+Pj4+IER1ZSB0byBoYXJkd2FyZSBzY2hlZHVsaW5nIGlzc3Vlcywg
d2Ugb25seSB0ZXN0ZWQgcnggZGltLgo+ID4+Pj4gRG8geW91IGhhdmUgUFBTIG51bWJlcnM/IEFu
ZCBUWCBudW1iZXJzIGFyZSBhbHNvIGltcG9ydGFudCBhcyB0aGUKPiA+Pj4+IHRocm91Z2hwdXQg
Y291bGQgYmUgbWlzbGVhZGluZyBkdWUgdG8gdmFyaW91cyByZWFzb25zLgo+ID4+PiBIaSBKYXNv
biEKPiA+Pj4KPiA+Pj4gVGhlIGNvbXBhcmlzb24gb2YgcnggbmV0ZGltIHBlcmZvcm1hbmNlIGlz
IGFzIGZvbGxvd3M6Cj4gPj4+ICh0aGUgYmFja2VuZCBzdXBwb3J0aW5nIHR4IGRpbSBpcyBub3Qg
eWV0IHJlYWR5KQo+ID4+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIG51bWJlcnMuCj4gPj4KPiA+PiBJ
J2Qgc3RpbGwgZXhwZWN0IHRoZSBUWCByZXN1bHQgYXMgSSBkaWQgcGxheSB0eCBpbnRlcnJ1cHQg
Y29hbGVzY2luZwo+ID4+IGFib3V0IDEwIHllYXJzIGFnby4KPiA+Pgo+ID4+IEkgd2lsbCBzdGFy
dCB0byByZXZpZXcgdGhlIHNlcmllcyBidXQgbGV0J3MgdHJ5IHRvIGhhdmUgc29tZSBUWCBudW1i
ZXJzIGFzIHdlbGwuCj4gPj4KPiA+PiBCdHcsIGl0IHdvdWxkIGJlIG1vcmUgY29udmVuaWVudCB0
byBoYXZlIGEgcmF3IFBQUyBiZW5jaG1hcmsuIEUuZyB5b3UKPiA+PiBjYW4gdHJ5IHRvIHVzZSBh
IHNvZnR3YXJlIG9yIGhhcmR3YXJlIHBhY2tldCBnZW5lcmF0b3IuCj4gPj4KPiA+PiBUaGFua3MK
PiA+IExhdGVuY3kgcmVzdWx0cyBhcmUgYWxzbyBraW5kIG9mIGludGVyZXN0aW5nLgo+Cj4gSSB0
ZXN0IHRoZSBsYXRlbmN5IHVzaW5nIHNvY2twZXJmIHBwOgo+Cj4gQFJ4IGNtZAo+IHRhc2tzZXQg
LWMgMCBzb2NrcGVyZiBzciAtcCA4OTg5Cj4KPiBAVHggY21kCj4gdGFza3NldCAtYyAwIHNvY2tw
ZXJmIHBwIC1pICR7aXB9IC1wIDg5ODkgLXQgMTAKPgo+IEFmdGVyIHJ1bm5pbmcgdGhpcyBjbWQg
NSB0aW1lcyBhbmQgYXZlcmFnaW5nIHRoZSByZXN1bHRzLAo+IHdlIGdldCB0aGUgZm9sbG93aW5n
IGRhdGE6Cj4KPiBkaW0gb2ZmOiAxNy43NzM1IHVzZWMKPiBkaW0gb246IDE4LjAxMTAgdXNlYwoK
TGV0J3MgYWRkIHRob3NlIG51bWJlcnMgdG8gdGhlIGNoYW5nZWxvZyBvZiB0aGUgbmV4dCB2ZXJz
aW9uLgoKVGhhbmtzCgo+Cj4gVGhhbmtzIQo+Cj4gPgo+ID4KPiA+Pj4KPiA+Pj4gSS4gU29ja3Bl
cmYgVURQCj4gPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KPiA+Pj4gMS4gRW52Cj4gPj4+IHJ4cV8wIGlzIGFmZmluaXR5IHRvIGNwdV8wCj4gPj4+
Cj4gPj4+IDIuIENtZAo+ID4+PiBjbGllbnQ6ICB0YXNrc2V0IC1jIDAgc29ja3BlcmYgdHAgLXAg
ODk4OSAtaSAkSVAgLXQgMTAgLW0gMTZCCj4gPj4+IHNlcnZlcjogdGFza3NldCAtYyAwIHNvY2tw
ZXJmIHNyIC1wIDg5ODkKPiA+Pj4KPiA+Pj4gMy4gUmVzdWx0Cj4gPj4+IGRpbSBvZmY6IDExNDMy
NzcuMDAgcnhwcHMsIHRocm91Z2hwdXQgMTcuODQ0IE1CcHMsIGNwdSBpcyAxMDAlLgo+ID4+PiBk
aW0gb246IDExMjQxNjEuMDAgcnhwcHMsIHRocm91Z2hwdXQgMTcuNjEwIE1CcHMsIGNwdSBpcyA4
My41JS4KPiA+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQo+ID4+Pgo+ID4+Pgo+ID4+PiBJSS4gUmVkaXMKPiA+Pj4gPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4+PiAxLiBFbnYKPiA+Pj4gVGhlcmUg
YXJlIDggcnhxcyBhbmQgcnhxX2kgaXMgYWZmaW5pdHkgdG8gY3B1X2kuCj4gPj4+Cj4gPj4+IDIu
IFJlc3VsdAo+ID4+PiBXaGVuIGFsbCBjcHVzIGFyZSAxMDAlLCBvcHMvc2VjIG9mIG1lbXRpZXJf
YmVuY2htYXJrIGNsaWVudCBpcwo+ID4+PiBkaW0gb2ZmOiAgIDk3ODQzNy4yMwo+ID4+PiBkaW0g
b246IDExNDM2MzguMjgKPiA+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQo+ID4+Pgo+ID4+Pgo+ID4+PiBJSUkuIE5naW54Cj4gPj4+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Pj4gMS4gRW52Cj4g
Pj4+IFRoZXJlIGFyZSA4IHJ4cXMgYW5kIHJ4cV9pIGlzIGFmZmluaXR5IHRvIGNwdV9pLgo+ID4+
Pgo+ID4+PiAyLiBSZXN1bHQKPiA+Pj4gV2hlbiBhbGwgY3B1cyBhcmUgMTAwJSwgcmVxdWVzdHMv
c2VjIG9mIHdyayBjbGllbnQgaXMKPiA+Pj4gZGltIG9mZjogICA4Nzc5MzEuNjcKPiA+Pj4gZGlt
IG9uOiAxMDE5MTYwLjMxCj4gPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KPiA+Pj4KPiA+Pj4gVGhhbmtzIQo+ID4+Pgo+ID4+Pj4gVGhhbmtzCj4g
Pj4+Pgo+ID4+Pj4+IEBUZXN0IGVudgo+ID4+Pj4+IHJ4cTAgaGFzIGFmZmluaXR5IHRvIGNwdTAu
Cj4gPj4+Pj4KPiA+Pj4+PiBAVGVzdCBjbWQKPiA+Pj4+PiBjbGllbnQ6IHRhc2tzZXQgLWMgMCBz
b2NrcGVyZiB0cCAtaSAke0lQfSAtdCAzMCAtLXRjcCAtbSAke21zZ19zaXplfQo+ID4+Pj4+IHNl
cnZlcjogdGFza3NldCAtYyAwIHNvY2twZXJmIHNyIC0tdGNwCj4gPj4+Pj4KPiA+Pj4+PiBAVGVz
dCByZXMKPiA+Pj4+PiBUaGUgc2Vjb25kIGNvbHVtbiBpcyB0aGUgcmF0aW8gb2YgdGhlIHJlc3Vs
dCByZXR1cm5lZCBieSBjbGllbnQKPiA+Pj4+PiB3aGVuIHJ4IGRpbSBpcyBlbmFibGVkIHRvIHRo
ZSByZXN1bHQgcmV0dXJuZWQgYnkgY2xpZW50IHdoZW4KPiA+Pj4+PiByeCBkaW0gaXMgZGlzYWJs
ZWQuCj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgbXNnX3NpemUgfCAgcnhfZGltPW9uIC8gcnhfZGltPW9m
ZiB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgICAxNEIgICAgfCAgICAgICAgICsgMyUgICAgICAgICAg
ICB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgICAxMDBCICAgfCAgICAgICAgICsgMTYlICAgICAgICAg
ICB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgICA1MDBCICAgfCAgICAgICAgICsgMjUlICAgICAgICAg
ICB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgICAxNDAwQiAgfCAgICAgICAgICsgMjglICAgICAgICAg
ICB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgICAyMDQ4QiAgfCAgICAgICAgICsgMjIlICAgICAgICAg
ICB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4gICAgICAgICAgIHwgICA0MDk2QiAgfCAgICAgICAgICsgNSUgICAgICAgICAg
ICB8Cj4gPj4+Pj4gICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPj4+Pj4KPiA+Pj4+PiAtLS0KPiA+Pj4+PiBUaGlzIHBhdGNoIHNldCB3YXMgcGFydCBv
ZiB0aGUgcHJldmlvdXMgbmV0ZGltIHBhdGNoIHNldFsxXS4KPiA+Pj4+PiBbMV0gd2FzIHNwbGl0
IGludG8gYSBtZXJnZWQgYnVnZml4IHNldFsyXSBhbmQgdGhlIGN1cnJlbnQgc2V0Lgo+ID4+Pj4+
IFRoZSBwcmV2aW91cyByZWxldmFudCBjb21tZW50YXRvcnMgaGF2ZSBiZWVuIENjZWQuCj4gPj4+
Pj4KPiA+Pj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwODExMDY1NTEy
LjIyMTkwLTEtaGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tLwo+ID4+Pj4+IFsyXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvY292ZXIuMTY5Njc0NTQ1Mi5naXQuaGVuZ3FpQGxpbnV4LmFsaWJh
YmEuY29tLwo+ID4+Pj4+Cj4gPj4+Pj4gSGVuZyBRaSAoNSk6Cj4gPj4+Pj4gICAgIHZpcnRpby1u
ZXQ6IHJldHVybnMgd2hldGhlciBuYXBpIGlzIGNvbXBsZXRlCj4gPj4+Pj4gICAgIHZpcnRpby1u
ZXQ6IHNlcGFyYXRlIHJ4L3R4IGNvYWxlc2NpbmcgbW9kZXJhdGlvbiBjbWRzCj4gPj4+Pj4gICAg
IHZpcnRpby1uZXQ6IGV4dHJhY3QgdmlydHF1ZXVlIGNvYWxlc2NpZyBjbWQgZm9yIHJldXNlCj4g
Pj4+Pj4gICAgIHZpcnRpby1uZXQ6IHN1cHBvcnQgcnggbmV0ZGltCj4gPj4+Pj4gICAgIHZpcnRp
by1uZXQ6IHN1cHBvcnQgdHggbmV0ZGltCj4gPj4+Pj4KPiA+Pj4+PiAgICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAzOTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
Cj4gPj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMyMiBpbnNlcnRpb25zKCspLCA3MiBkZWxldGlv
bnMoLSkKPiA+Pj4+Pgo+ID4+Pj4+IC0tCj4gPj4+Pj4gMi4xOS4xLjYuZ2I0ODU3MTBiCj4gPj4+
Pj4KPiA+Pj4+Pgo+ID4+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
