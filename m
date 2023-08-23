Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4479CEE49A3
	for <virtualization@archiver.kernel.org>; Wed, 23 Aug 2023 00:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA1F2611C9;
	Wed, 23 Aug 2023 00:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA1F2611C9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHKEJWRr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 308-2pWWKpDV; Wed, 23 Aug 2023 00:36:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA6A2611E5;
	Wed, 23 Aug 2023 00:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA6A2611E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5285C0039;
	Wed, 23 Aug 2023 00:36:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8160AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 00:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55C0D81F6E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 00:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55C0D81F6E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHKEJWRr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUxzqGOZGN1z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 00:36:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47E2381819
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 00:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47E2381819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692750991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2IL+cZp/0HHCpa5Ko71FJgAGVSdljaI2sGgMww+L4A=;
 b=NHKEJWRrfmay4qUTCAdB5NPIMzLDYT58QF5J6qyskT1dusJlvRsp3gq4PvbpPBBaIJQYCX
 9L4lXub3tzV5pjuA58Iy6WRREqxZ5300TN57Mrcli8YZCah9ZxdpYcDj0FpP8fxZJLIC+R
 iBjJm1etvt1pN6sKP0pfDLNLueC2pWg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-MPU6VbRDPGWkqUy0mrxGkg-1; Tue, 22 Aug 2023 20:36:27 -0400
X-MC-Unique: MPU6VbRDPGWkqUy0mrxGkg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcc4347d48so25941291fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 17:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692750985; x=1693355785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2IL+cZp/0HHCpa5Ko71FJgAGVSdljaI2sGgMww+L4A=;
 b=R+BiakGQIe/Rt4HPd1l1FsE6xUWdl5rz4U9hne/Y+fm3w+e0unZ+fZi9MEdrXV/7SO
 H5I4Z6ApAq29mpYjgcP1kq3e7tLloJDGQ5SwJKyxVV7kyAXz+q9aMa7nDBNwNtnG1zDm
 luyW2e8c2ssyCA4zjDy+WNdzSZmL7NsLax+MR66OUmfiHmhCj8BPXD7DdXk10n8whkCV
 fhNE8d5LjI6wF+eT91KZDz0Oedltz8aApixVOQbTV/9l8EvXDeoAwNVA3fXYW+S7ViaG
 RHwZHL24TEkm3fR/7eCdkY8XxX7jh+8W86Nng9hqgS0oOIMchxPrCx7jID7q+aTJ3MwA
 SZ1A==
X-Gm-Message-State: AOJu0Yw+6oHXL32BQoHcfPTY56teK6YZjEGHEC0pah3kN0x8kzJAcskr
 dxAWdzW7KBKIAwjLeqndK8tRucCua86TCVkU6xbAphmoH5jXfXuvWHJ414hVs9++5qoJZSxtgBi
 6rl5XxdGY0ywwzgAjo8krAQ+zTXaj3O0kMccQ++Qav3tZbtHZZMiKMCeT/w==
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id
 d7-20020a2e3607000000b002b6de520357mr8028176lja.40.1692750985671; 
 Tue, 22 Aug 2023 17:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEFPDsk5hA0Fn4R6rUDIO6eqwFcn1qxMxURYoc60s0yH3huA1vp9eXuhPoq72Mx9oKSgrLLDu1lRa2xVe/Epk=
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id
 d7-20020a2e3607000000b002b6de520357mr8028163lja.40.1692750985367; Tue, 22 Aug
 2023 17:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230821142713.5062-1-feliu@nvidia.com>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Aug 2023 08:36:14 +0800
Message-ID: <CACGkMEvbYCf-TsV+VtNT6iUiHM7s+MOnJ5UZz8yyw2MSifVT5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
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

T24gTW9uLCBBdWcgMjEsIDIwMjMgYXQgMTA6MjfigK9QTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPiBUaGUgdmlydGlvX25ldCBkcml2ZXIgY3VycmVudGx5IGRlYWxzIHdp
dGggZGlmZmVyZW50IHZlcnNpb25zIGFuZCB0eXBlcwo+IG9mIHZpcnRpbyBuZXQgaGVhZGVycywg
c3VjaCBhcyB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYsCj4gdmlydGlvX25ldF9oZHJfdjFfaGFz
aCwgZXRjLiBEdWUgdG8gdGhlc2UgdmFyaWF0aW9ucywgdGhlIGNvZGUgcmVsaWVzCj4gb24gbXVs
dGlwbGUgdHlwZSBjYXN0cyB0byBjb252ZXJ0IG1lbW9yeSBiZXR3ZWVuIGRpZmZlcmVudCBzdHJ1
Y3R1cmVzLAo+IHBvdGVudGlhbGx5IGxlYWRpbmcgdG8gYnVncyB3aGVuIHRoZXJlIGFyZSBjaGFu
Z2VzIGluIHRoZXNlIHN0cnVjdHVyZXMuCj4KPiBJbnRyb2R1Y2VzIHRoZSAic3RydWN0IHNrYl92
bmV0X2NvbW1vbl9oZHIiIGFzIGEgdW5pZnlpbmcgaGVhZGVyCj4gc3RydWN0dXJlIHVzaW5nIGEg
dW5pb24uIFdpdGggdGhpcyBhcHByb2FjaCwgdmFyaW91cyB2aXJ0aW8gbmV0IGhlYWRlcgo+IHN0
cnVjdHVyZXMgY2FuIGJlIGNvbnZlcnRlZCBieSBhY2Nlc3NpbmcgZGlmZmVyZW50IG1lbWJlcnMg
b2YgdGhpcwo+IHN0cnVjdHVyZSwgdGh1cyBlbGltaW5hdGluZyB0aGUgbmVlZCBmb3IgdHlwZSBj
YXN0aW5nIGFuZCByZWR1Y2luZyB0aGUKPiByaXNrIG9mIHBvdGVudGlhbCBidWdzLgo+Cj4gRm9y
IGV4YW1wbGUgZm9sbG93aW5nIGNvZGU6Cj4gc3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3Rv
X3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgICAgICAgICAgICAgICAgc3RydWN0IHJl
Y2VpdmVfcXVldWUgKnJxLAo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSwgdW5z
aWduZWQgaW50IG9mZnNldCwKPiAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGxlbiwgdW5z
aWduZWQgaW50IHRydWVzaXplLAo+ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaGVhZHJv
b20pCj4gewo+IFsuLi5dCj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVm
ICpoZHI7Cj4gWy4uLl0KPiAgICAgICAgIGhkcl9sZW4gPSB2aS0+aGRyX2xlbjsKPiBbLi4uXQo+
IG9rOgo+ICAgICAgICAgaGRyID0gc2tiX3ZuZXRfaGRyKHNrYik7Cj4gICAgICAgICBtZW1jcHko
aGRyLCBoZHJfcCwgaGRyX2xlbik7Cj4gWy4uLl0KPiB9Cj4KPiBXaGVuIFZJUlRJT19ORVRfRl9I
QVNIX1JFUE9SVCBmZWF0dXJlIGlzIGVuYWJsZWQsIGhkcl9sZW4gPSAyMAo+IEJ1dCB0aGUgc2l6
ZW9mKCpoZHIpIGlzIDEyLAo+IG1lbWNweShoZHIsIGhkcl9wLCBoZHJfbGVuKTsgd2lsbCBjb3B5
IDIwIGJ5dGVzIHRvIHRoZSBoZHIsCj4gd2hpY2ggbWFrZSBhIHBvdGVudGlhbCByaXNrIG9mIGJ1
Zy4gQW5kIHRoaXMgcmlzayBjYW4gYmUgYXZvaWRlZCBieQo+IGludHJvZHVjaW5nIHN0cnVjdCBz
a2Jfdm5ldF9jb21tb25faGRyLgo+Cj4gQ2hhbmdlIGxvZwo+IHYxLT52Mgo+IGZlZWRiYWNrIGZy
b20gV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4KPiBm
ZWVkYmFjayBmcm9tIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4KPiAxLiBjaGFuZ2Ug
dG8gdXNlIG5ldC1uZXh0IHRyZWUuCj4gMi4gbW92ZSBza2Jfdm5ldF9jb21tb25faGRyIGluc2lk
ZSBrZXJuZWwgZmlsZSBpbnN0ZWFkIG9mIHRoZSBVQVBJIGhlYWRlci4KPgo+IHYyLT52Mwo+IGZl
ZWRiYWNrIGZyb20gV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWls
LmNvbT4KPiAxLiBmaXggdHlwbyBpbiBjb21taXQgbWVzc2FnZS4KPiAyLiBhZGQgb3JpZ2luYWwg
c3RydWN0IHZpcnRpb19uZXRfaGRyIGludG8gdW5pb24KPiAzLiByZW1vdmUgdmlydGlvX25ldF9o
ZHJfbXJnX3J4YnVmIHZhcmlhYmxlIGluIHJlY2VpdmVfYnVmOwo+Cj4gU2lnbmVkLW9mZi1ieTog
RmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGpp
cmlAbnZpZGlhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyNyArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggOGU5ZjRjZmU5NDFmLi44Yzc0YmM4
Y2ZlNjggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTMwMyw2ICszMDMsMTQgQEAgc3RydWN0IHBhZGRl
ZF92bmV0X2hkciB7Cj4gICAgICAgICBjaGFyIHBhZGRpbmdbMTJdOwo+ICB9Owo+Cj4gK3N0cnVj
dCB2aXJ0aW9fbmV0X2NvbW1vbl9oZHIgewo+ICsgICAgICAgdW5pb24gewo+ICsgICAgICAgICAg
ICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHIgaGRyOwo+ICsgICAgICAgICAgICAgICBzdHJ1Y3Qg
dmlydGlvX25ldF9oZHJfbXJnX3J4YnVmIG1yZ19oZHI7Cj4gKyAgICAgICAgICAgICAgIHN0cnVj
dCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoIGhhc2hfdjFfaGRyOwo+ICsgICAgICAgfTsKPiArfTsK
PiArCj4gIHN0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0
cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NxX2ZyZWVfdW51
c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPgo+IEBAIC0zNDQsOSAr
MzUyLDEwIEBAIHN0YXRpYyBpbnQgcnhxMnZxKGludCByeHEpCj4gICAgICAgICByZXR1cm4gcnhx
ICogMjsKPiAgfQo+Cj4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19y
eGJ1ZiAqc2tiX3ZuZXRfaGRyKHN0cnVjdCBza19idWZmICpza2IpCj4gK3N0YXRpYyBpbmxpbmUg
c3RydWN0IHZpcnRpb19uZXRfY29tbW9uX2hkciAqCj4gK3NrYl92bmV0X2NvbW1vbl9oZHIoc3Ry
dWN0IHNrX2J1ZmYgKnNrYikKPiAgewo+IC0gICAgICAgcmV0dXJuIChzdHJ1Y3QgdmlydGlvX25l
dF9oZHJfbXJnX3J4YnVmICopc2tiLT5jYjsKPiArICAgICAgIHJldHVybiAoc3RydWN0IHZpcnRp
b19uZXRfY29tbW9uX2hkciAqKXNrYi0+Y2I7Cj4gIH0KPgo+ICAvKgo+IEBAIC00NjksNyArNDc4
LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCBoZWFkcm9vbSkKPiAgewo+ICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYjsKPiAtICAgICAg
IHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPiArICAgICAgIHN0cnVjdCB2
aXJ0aW9fbmV0X2NvbW1vbl9oZHIgKmhkcjsKPiAgICAgICAgIHVuc2lnbmVkIGludCBjb3B5LCBo
ZHJfbGVuLCBoZHJfcGFkZGVkX2xlbjsKPiAgICAgICAgIHN0cnVjdCBwYWdlICpwYWdlX3RvX2Zy
ZWUgPSBOVUxMOwo+ICAgICAgICAgaW50IHRhaWxyb29tLCBzaGluZm9fc2l6ZTsKPiBAQCAtNTU0
LDcgKzU2Myw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksCj4gICAgICAgICAgICAgICAgIGdpdmVfcGFnZXMocnEsIHBhZ2UpOwo+
Cj4gIG9rOgo+IC0gICAgICAgaGRyID0gc2tiX3ZuZXRfaGRyKHNrYik7Cj4gKyAgICAgICBoZHIg
PSBza2Jfdm5ldF9jb21tb25faGRyKHNrYik7Cj4gICAgICAgICBtZW1jcHkoaGRyLCBoZHJfcCwg
aGRyX2xlbik7Cj4gICAgICAgICBpZiAocGFnZV90b19mcmVlKQo+ICAgICAgICAgICAgICAgICBw
dXRfcGFnZShwYWdlX3RvX2ZyZWUpOwo+IEBAIC05NjYsNyArOTc1LDcgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpyZWNlaXZlX3NtYWxsX2J1aWxkX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSwKPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4KPiAgICAgICAgIGJ1ZiArPSBoZWFk
ZXJfb2Zmc2V0Owo+IC0gICAgICAgbWVtY3B5KHNrYl92bmV0X2hkcihza2IpLCBidWYsIHZpLT5o
ZHJfbGVuKTsKPiArICAgICAgIG1lbWNweShza2Jfdm5ldF9jb21tb25faGRyKHNrYiksIGJ1Ziwg
dmktPmhkcl9sZW4pOwo+Cj4gICAgICAgICByZXR1cm4gc2tiOwo+ICB9Cj4gQEAgLTE1NzcsNyAr
MTU4Niw3IEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYnVmKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gIHsKPiAgICAgICAgIHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYgPSB2aS0+ZGV2Owo+ICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYjsKPiAtICAg
ICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPiArICAgICAgIHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbW1vbl9oZHIgKmhkcjsKPgo+ICAgICAgICAgaWYgKHVubGlrZWx5KGxl
biA8IHZpLT5oZHJfbGVuICsgRVRIX0hMRU4pKSB7Cj4gICAgICAgICAgICAgICAgIHByX2RlYnVn
KCIlczogc2hvcnQgcGFja2V0ICVpXG4iLCBkZXYtPm5hbWUsIGxlbik7Cj4gQEAgLTE1OTcsOSAr
MTYwNiw5IEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYnVmKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gICAgICAgICBpZiAodW5saWtlbHkoIXNrYikp
Cj4gICAgICAgICAgICAgICAgIHJldHVybjsKPgo+IC0gICAgICAgaGRyID0gc2tiX3ZuZXRfaGRy
KHNrYik7Cj4gKyAgICAgICBoZHIgPSBza2Jfdm5ldF9jb21tb25faGRyKHNrYik7Cj4gICAgICAg
ICBpZiAoZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfUlhIQVNIICYmIHZpLT5oYXNfcnNzX2hhc2hf
cmVwb3J0KQo+IC0gICAgICAgICAgICAgICB2aXJ0aW9fc2tiX3NldF9oYXNoKChjb25zdCBzdHJ1
Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCAqKWhkciwgc2tiKTsKPiArICAgICAgICAgICAgICAg
dmlydGlvX3NrYl9zZXRfaGFzaCgmaGRyLT5oYXNoX3YxX2hkciwgc2tiKTsKPgo+ICAgICAgICAg
aWYgKGhkci0+aGRyLmZsYWdzICYgVklSVElPX05FVF9IRFJfRl9EQVRBX1ZBTElEKQo+ICAgICAg
ICAgICAgICAgICBza2ItPmlwX3N1bW1lZCA9IENIRUNLU1VNX1VOTkVDRVNTQVJZOwo+IEBAIC0y
MTA1LDcgKzIxMTQsNyBAQCBzdGF0aWMgaW50IHhtaXRfc2tiKHN0cnVjdCBzZW5kX3F1ZXVlICpz
cSwgc3RydWN0IHNrX2J1ZmYgKnNrYikKPiAgICAgICAgIGlmIChjYW5fcHVzaCkKPiAgICAgICAg
ICAgICAgICAgaGRyID0gKHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKikoc2tiLT5k
YXRhIC0gaGRyX2xlbik7Cj4gICAgICAgICBlbHNlCj4gLSAgICAgICAgICAgICAgIGhkciA9IHNr
Yl92bmV0X2hkcihza2IpOwo+ICsgICAgICAgICAgICAgICBoZHIgPSAmc2tiX3ZuZXRfY29tbW9u
X2hkcihza2IpLT5tcmdfaGRyOwo+Cj4gICAgICAgICBpZiAodmlydGlvX25ldF9oZHJfZnJvbV9z
a2Ioc2tiLCAmaGRyLT5oZHIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dmlydGlvX2lzX2xpdHRsZV9lbmRpYW4odmktPnZkZXYpLCBmYWxzZSwKPiAtLQo+IDIuMzcuMSAo
QXBwbGUgR2l0LTEzNy4xKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
