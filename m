Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0F5EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1135C416DD;
	Tue, 27 Jun 2023 08:03:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1135C416DD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=COsHtKR8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SB2XDJEFqV-c; Tue, 27 Jun 2023 08:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E77C41705;
	Tue, 27 Jun 2023 08:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E77C41705
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5532BC0DD7;
	Tue, 27 Jun 2023 08:03:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAEB6C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94C1541700
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94C1541700
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XOerLfYeSIoB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9779416FD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9779416FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687853024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Sijha0YXJUjNDfHLb+Azz4YINEqeJlQ8jO8DuRzjtc=;
 b=COsHtKR8SM6M8zk168LjKZ9hemNlDG1tiEEOKs3HYkqt6tCt0uigehlDVpukHPlELdaQfi
 iYLkhQc2q+grhVL68c7N+cKZEs30ICltvnlNHlieXhd8Z5K+L/9JjVxZ5KDa/w4F57dikV
 nNLu2nd0qn56VI7nYE8hJm9k/Re+Os8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-QTcAwif6OGuB7HAb35eFYA-1; Tue, 27 Jun 2023 04:03:42 -0400
X-MC-Unique: QTcAwif6OGuB7HAb35eFYA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6a10a0a76so16429251fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 01:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687853021; x=1690445021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Sijha0YXJUjNDfHLb+Azz4YINEqeJlQ8jO8DuRzjtc=;
 b=bGvYTFGTyhJd8G9y3SlvaJOB6yf2YC5YeAR5FNhvrggpu96VA18DzkE5qQxB8kSrAr
 500roEJ5jIWB8Iub0Klg+eDf5PRpVOM+/5zOuXIcg026+Ebts46g4CSuzAu9yYDlDt3U
 2rfixrOozrHuxPKNHVk9KYFrY/xAlG5Yzy0jhmLmoDFZsvM56kq2LaEJ/hjRLJZhoFuA
 NN4nTL/RkNT3buN9eYB01A2WI9Xyy5YTKuGso7V7i9BdFFkMsyxNUA7XxOgQNbC3u0ze
 /0yKT7wFD8pdH48B/58mWOOjlUiEJHK+KnQ6EUZsTjl0Cdp3nCBnn40iQ71jZqi8iNS9
 5Ajg==
X-Gm-Message-State: AC+VfDwhggiAGbscYnObFq1xHSQsRnCAK5sZJsO8cQVprylfJRHBTPRX
 1OEnP+Og7p+aCTqzT+JqpNHhuSfhWdTplIh6qDCQbE99a7VOFG7NfKqquv0xsRQ6TGeJx/iOTWY
 fxoD61RuPLnvsFu4f+XO4ROLWHS9NCxD+4Sa1Ev172/g5L26dNvvCEH47cg==
X-Received: by 2002:a2e:9619:0:b0:2b6:a59c:5e02 with SMTP id
 v25-20020a2e9619000000b002b6a59c5e02mr3038565ljh.20.1687853020809; 
 Tue, 27 Jun 2023 01:03:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bcmfHyMmURgW7H/N4Q0xvQrGAHQn5HeoHqiK6eNWEjZw8/c0ufCAuMNVB1pTSagyYRiNhsx+f+VI3S81N0Bs=
X-Received: by 2002:a2e:9619:0:b0:2b6:a59c:5e02 with SMTP id
 v25-20020a2e9619000000b002b6a59c5e02mr3038552ljh.20.1687853020520; Tue, 27
 Jun 2023 01:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:29 +0800
Message-ID: <CACGkMEuoBtQ+=kJJk84Vs2sk7WAdh8O3d2wJLM-yBFAtkgLEUA@mail.gmail.com>
Subject: Re: [PATCH vhost v10 04/10] virtio_ring: packed: support add
 premapped buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBJZiB0aGUgdnEgaXMgdGhlIHByZW1hcHBlZCBtb2Rl
LCB1c2UgdGhlIHNnX2RtYV9hZGRyZXNzKCkgZGlyZWN0bHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDE4MjEyYzNlMDU2Yi4uZGMxMDlmYmMwNWE1IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTEyOTksOSArMTI5OSwxMyBAQCBzdGF0aWMgaW50
IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZx
LAo+Cj4gICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3NncyArIGluX3NnczsgbisrKSB7Cj4g
ICAgICAgICAgICAgICAgIGZvciAoc2cgPSBzZ3Nbbl07IHNnOyBzZyA9IHNnX25leHQoc2cpKSB7
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBu
IDwgb3V0X3NncyA/Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRE1BX1RPX0RFVklDRSA6IERNQV9GUk9NX0RFVklDRSwgJmFkZHIpKQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGlmICh2cS0+cHJlbWFwcGVkKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpOwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdf
bWFwX29uZV9zZyh2cSwgc2csIG4gPCBvdXRfc2dzID8KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJQ0UgOiBETUFfRlJPTV9E
RVZJQ0UsICZhZGRyKSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byB1bm1hcF9yZWxlYXNlOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPgo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGRlc2NbaV0uZmxhZ3MgPSBjcHVfdG9fbGUxNihuIDwgb3V0X3Nn
cyA/Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCA6
IFZSSU5HX0RFU0NfRl9XUklURSk7Cj4gQEAgLTEzNjksMTAgKzEzNzMsMTIgQEAgc3RhdGljIGlu
dCB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2
cSwKPiAgICAgICAgIHJldHVybiAwOwo+Cj4gIHVubWFwX3JlbGVhc2U6Cj4gLSAgICAgICBlcnJf
aWR4ID0gaTsKPiArICAgICAgIGlmICghdnEtPnByZW1hcHBlZCkgewo+ICsgICAgICAgICAgICAg
ICBlcnJfaWR4ID0gaTsKPgo+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IGVycl9pZHg7IGkrKykK
PiAtICAgICAgICAgICAgICAgdnJpbmdfdW5tYXBfZGVzY19wYWNrZWQodnEsICZkZXNjW2ldKTsK
PiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGVycl9pZHg7IGkrKykKPiArICAgICAg
ICAgICAgICAgICAgICAgICB2cmluZ191bm1hcF9kZXNjX3BhY2tlZCh2cSwgJmRlc2NbaV0pOwo+
ICsgICAgICAgfQo+Cj4gICAgICAgICBrZnJlZShkZXNjKTsKPgo+IEBAIC0xNDQ3LDkgKzE0NTMs
MTMgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9wYWNrZWQoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxLAo+ICAgICAgICAgICAgICAgICBmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBz
Z19uZXh0KHNnKSkgewo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRkcjsK
Pgo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywg
biA8IG91dF9zZ3MgPwo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIERNQV9UT19ERVZJQ0UgOiBETUFfRlJPTV9ERVZJQ0UsICZhZGRyKSkKPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5tYXBfcmVsZWFzZTsKPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAodnEtPnByZW1hcHBlZCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYWRkciA9IHNnX2RtYV9hZGRyZXNzKHNnKTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5n
X21hcF9vbmVfc2codnEsIHNnLCBuIDwgb3V0X3NncyA/Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFfVE9fREVWSUNFIDogRE1BX0ZST01f
REVWSUNFLCAmYWRkcikpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gdW5tYXBfcmVsZWFzZTsKPiArICAgICAgICAgICAgICAgICAgICAgICB9Cj4KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBmbGFncyA9IGNwdV90b19sZTE2KHZxLT5wYWNrZWQuYXZhaWxf
dXNlZF9mbGFncyB8Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCsrYyA9
PSB0b3RhbF9zZyA/IDAgOiBWUklOR19ERVNDX0ZfTkVYVCkgfAo+IEBAIC0xNTEyLDExICsxNTIy
LDE3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0
cXVldWUgKl92cSwKPiAgICAgICAgIHJldHVybiAwOwo+Cj4gIHVubWFwX3JlbGVhc2U6Cj4gKyAg
ICAgICB2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3MgPSBhdmFpbF91c2VkX2ZsYWdzOwo+ICsK
PiArICAgICAgIGlmICh2cS0+cHJlbWFwcGVkKSB7CgpTaW1pbGFyIHRvIHRoZSBzcGxpdCBwYXRo
LCBJIHRoaW5rIHdlIGNhbid0IGhpdCB2cS0+cHJlbWFwcGVkIGhlcmUuCgpUaGFua3MKCgo+ICsg
ICAgICAgICAgICAgICBFTkRfVVNFKHZxKTsKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87
Cj4gKyAgICAgICB9Cj4gKwo+ICAgICAgICAgZXJyX2lkeCA9IGk7Cj4gICAgICAgICBpID0gaGVh
ZDsKPiAgICAgICAgIGN1cnIgPSB2cS0+ZnJlZV9oZWFkOwo+Cj4gLSAgICAgICB2cS0+cGFja2Vk
LmF2YWlsX3VzZWRfZmxhZ3MgPSBhdmFpbF91c2VkX2ZsYWdzOwo+Cj4gICAgICAgICBmb3IgKG4g
PSAwOyBuIDwgdG90YWxfc2c7IG4rKykgewo+ICAgICAgICAgICAgICAgICBpZiAoaSA9PSBlcnJf
aWR4KQo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
