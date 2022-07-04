Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69458C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 04:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAC758261C;
	Mon,  4 Jul 2022 04:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAC758261C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DpUlngRq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hL22-hGU_yj8; Mon,  4 Jul 2022 04:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 197A1825E8;
	Mon,  4 Jul 2022 04:02:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 197A1825E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E92F0C0032;
	Mon,  4 Jul 2022 04:02:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EEB3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 792EB60BD0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 792EB60BD0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DpUlngRq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kpb-G4D-J1hC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:02:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9713E60BD1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9713E60BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656907370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDvcxMkTKOE3YDsEGpILSgl3XDOYTursfKJU9/dGAhI=;
 b=DpUlngRqASM9pQUdnX2Zf8w4cVClqvzSCDdRpFmsEJhuD04Uo1NujMtf31x35kktljAqfC
 UZ9n78Rll6+4uqrS4u4h3O7F5YdISRKVLDfsVrfjJHTj6nfhqvkgQSHMsxdIJEHOUSb7hU
 mv2PcItBy+2D8zpi40XfSKBEf4i1uII=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-jODqUYMuPruxRPwQ4SouIQ-1; Mon, 04 Jul 2022 00:02:49 -0400
X-MC-Unique: jODqUYMuPruxRPwQ4SouIQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 i15-20020a17090a2a0f00b001ef826b921dso1716803pjd.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 21:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HDvcxMkTKOE3YDsEGpILSgl3XDOYTursfKJU9/dGAhI=;
 b=pVcI5z6sORt9ECINejqtKbOYsK1U8N3QnvjCw+MAAom+NereXClkrvTm/ck3sn/ojb
 WFOIbcR5SUrDetg9Kx+ROPr7ZNolyPpQ2riXRr9lQw6PKnvfcRmOiJQ9rzQ8x83upe5M
 3BPAiy0rS6/MbkA9t38HfTvZv5ynl3stF6h4+4BeVUd40UYcUaBtMPVKAD6ZZz/5CdgK
 IfsQd7apLbTMJd65x9JuwCKLsacbmdyDg0Qg2u2wTxWgxt9v5q2EHLA3j7pdJ9wpQHKW
 yK0PqqKQ+KI0TZWTQJvLeLJvzTwM+D+3S3286bmNzFtWq9+wKJ+Yac6VuB4kAAd4TFWl
 O61Q==
X-Gm-Message-State: AJIora8oeSKOiuIgblNRNmoTIanrWUSgnM+Z9q9NlM8uP6mCct6qKvxT
 35OYnALUE8HEZK4uveXMPT7oXvmSFNkooJVtV0zeYw9jRlveLynIZ3fs/Hvb9P9amRXPjgDdfVW
 ye9LAdtdAL4RNLI13c0aHNfMeSLTaNCZQGM16nSJLgg==
X-Received: by 2002:a17:902:7604:b0:16a:f36d:73f3 with SMTP id
 k4-20020a170902760400b0016af36d73f3mr33910487pll.170.1656907367250; 
 Sun, 03 Jul 2022 21:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uxDno/Wbd/PRnmg2ukyIktZ4uuSCmlyYFX7x8EioNmBJfd4eulRHgxbl4Lai6a6wYdtHVs8g==
X-Received: by 2002:a17:902:7604:b0:16a:f36d:73f3 with SMTP id
 k4-20020a170902760400b0016af36d73f3mr33910464pll.170.1656907366984; 
 Sun, 03 Jul 2022 21:02:46 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w16-20020aa79a10000000b0051ba90d55acsm20008816pfj.207.2022.07.03.21.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 21:02:46 -0700 (PDT)
Message-ID: <fd85439f-8c94-e4f9-8500-811b3cf4c9ed@redhat.com>
Date: Mon, 4 Jul 2022 12:02:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 21/40] virtio_ring: packed: introduce
 virtqueue_resize_packed()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-22-xuanzhuo@linux.alibaba.com>
 <de7cf56d-acbd-1a2b-2226-a9fdd89afb78@redhat.com>
 <1656900812.860175-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1656900812.860175-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzcvNCAxMDoxMywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBGcmksIDEgSnVsIDIw
MjIgMTc6Mjc6NDggKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+PiDlnKggMjAyMi82LzI5IDE0OjU2LCBYdWFuIFpodW8g5YaZ6YGTOgo+Pj4gdmlydGlvIHJp
bmcgcGFja2VkIHN1cHBvcnRzIHJlc2l6ZS4KPj4+Cj4+PiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJp
bmcgaXMgc3VjY2Vzc2Z1bGx5IGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUgbmV3IG51bSwKPj4+IHdl
IHdpbGwgcmVsZWFzZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0
dXJuZWQsCj4+PiBpbmRpY2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0byB0aGUg
b2xkIHZyaW5nLgo+Pj4KPj4+IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXpl
KGJ5IHZpcnRxdWV1ZV9yZWluaXRfcGFja2VkKCkpIHRoZQo+Pj4gdmlydHF1ZXVlIHRvIGVuc3Vy
ZSB0aGF0IHRoZSB2cmluZyBjYW4gYmUgdXNlZC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4+PiBpbmRleCA2NTBmNzAxYTU0ODAuLjQ4NjA3ODcyODZkYiAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPj4+IEBAIC0yMDQyLDYgKzIwNDIsMzUgQEAgc3RhdGljIHN0cnVjdCB2
aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+Pj4gICAgCXJldHVybiBO
VUxMOwo+Pj4gICAgfQo+Pj4KPj4+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVfcGFja2Vk
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMyIG51bSkKPj4+ICt7Cj4+PiArCXN0cnVjdCB2cmlu
Z192aXJ0cXVldWVfcGFja2VkIHZyaW5nID0ge307Cj4+PiArCXN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0g
X3ZxLT52ZGV2Owo+Pj4gKwlpbnQgZXJyOwo+Pj4gKwo+Pj4gKwlpZiAodnJpbmdfYWxsb2NfcXVl
dWVfcGFja2VkKCZ2cmluZywgdmRldiwgbnVtKSkKPj4+ICsJCWdvdG8gZXJyX3Jpbmc7Cj4+PiAr
Cj4+PiArCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3BhY2tlZCgmdnJpbmcpOwo+Pj4g
KwlpZiAoZXJyKQo+Pj4gKwkJZ290byBlcnJfc3RhdGVfZXh0cmE7Cj4+PiArCj4+PiArCXZyaW5n
X2ZyZWUoJnZxLT52cSk7Cj4+PiArCj4+PiArCXZpcnRxdWV1ZV9pbml0KHZxLCB2cmluZy52cmlu
Zy5udW0pOwo+Pj4gKwl2aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3BhY2tlZCh2cSwgJnZyaW5nKTsK
Pj4+ICsJdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFja2VkKHZxKTsKPj4+ICsKPj4+ICsJcmV0dXJu
IDA7Cj4+PiArCj4+PiArZXJyX3N0YXRlX2V4dHJhOgo+Pj4gKwl2cmluZ19mcmVlX3BhY2tlZCgm
dnJpbmcsIHZkZXYpOwo+Pj4gK2Vycl9yaW5nOgo+Pj4gKwl2aXJ0cXVldWVfcmVpbml0X3BhY2tl
ZCh2cSk7Cj4+Cj4+IFNvIGRlc2Nfc3RhdGUgYW5kIGRlc2NfZXh0cmEgaGFzIGJlZW4gZnJlZWQg
dnJpbmdfZnJlZV9wYWNrZWQoKSB3aGVuCj4+IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJhX3BhY2tl
ZCgpIGZhaWxzLiBXZSBtaWdodCBnZXQgdXNlLWFmdGVyLWZyZWUgaGVyZT8KPiB2cmluZ19mcmVl
X3BhY2tlZCgpIGZyZWVzIHRoZSB0ZW1wb3Jhcnkgc3RydWN0dXJlIHZyaW5nLiBJdCBkb2VzIG5v
dCBhZmZlY3QKPiBkZXNjX3N0YXRlIGFuZCBkZXNjX2V4dHJhIG9mIHZxLiBTbyBpdCBpcyBzYWZl
LgoKCllvdSBhcmUgcmlnaHQuCgoKPgo+PiBBY3R1YWxseSwgSSB0aGluayBmb3IgcmVzaXplIHdl
IG5lZWQKPj4KPj4gMSkgZGV0YWNoIG9sZAo+PiAyKSBhbGxvY2F0ZSBuZXcKPj4gMykgaWYgMikg
c3VjY2VlZCwgYXR0YWNoIG5ldyBvdGhlcndpc2UgYXR0YWNoIG9sZAo+Cj4gVGhlIGltcGxlbWVu
dGF0aW9uIGlzIG5vdzoKPgo+IDEuIGFsbG9jYXRlIG5ldwo+IDIuIGZyZWUgb2xkIChkZXRhY2gg
b2xkKQo+IDMuIGF0dGFjaCBuZXcKPgo+IGVycm9yOgo+IDEuIGZyZWUgdGVtcG9yYXJ5Cj4gMi4g
cmVpbml0IG9sZAo+Cj4gRG8geW91IHRoaW5rIHRoaXMgaXMgb2s/IFdlIG5lZWQgdG8gYWRkIGEg
bmV3IHZhcmlhYmxlIHRvIHNhdmUgdGhlIG9sZCB2cmluZyBpbgo+IHRoZSBwcm9jZXNzIHlvdSBt
ZW50aW9uZWQsIHRoZXJlIGlzIG5vdCBtdWNoIGRpZmZlcmVuY2UgaW4gb3RoZXIuCgoKWWVzLCBJ
IHRoaW5rIHRoZSBjb2RlIGlzIGZpbmUuIEJ1dCBJJ2Qgc3VnZ2VzdCB0byByZW5hbWUgInZyaW5n
IiB0byAKInZyaW5nX3BhY2tlZCIsIHRoaXMgc2ltcGxpZnkgdGhlIHJldmlld2Vycy4KCk90aGVy
IHRoYW4gdGhpcywgeW91IGNhbiBhZGQ6CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgo+Cj4gVGhhbmtzLgo+Cj4KPj4gVGhpcyBzZWVtcyBtb3JlIGNsZWFyZXIg
dGhhbiB0aGUgY3VycmVudCBsb2dpYz8KPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+PiArCXJldHVybiAt
RU5PTUVNOwo+Pj4gK30KPj4+ICsKPj4+Cj4+PiAgICAvKgo+Pj4gICAgICogR2VuZXJpYyBmdW5j
dGlvbnMgYW5kIGV4cG9ydGVkIHN5bWJvbHMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
