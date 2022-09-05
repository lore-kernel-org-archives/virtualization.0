Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0D8C6FA89
	for <virtualization@archiver.kernel.org>; Mon,  5 Sep 2022 08:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 63E05401A4;
	Mon,  5 Sep 2022 08:32:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63E05401A4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YeNjLLR3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DY2teeKJ9G1; Mon,  5 Sep 2022 08:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 192794017C;
	Mon,  5 Sep 2022 08:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 192794017C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98A9DC0033;
	Mon,  5 Sep 2022 08:32:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F15CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D82B605A9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D82B605A9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YeNjLLR3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 77gzFx6XrUAb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:32:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76CFC6059C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76CFC6059C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 08:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662366748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4JK4m0m3+hN9/NjyD45TlkaSX2pzOEl0JORrLG6mzs=;
 b=YeNjLLR3zUg8fQLeuW3wzkjIYVPWu4bcvr3wuT8gAb6KWLq8FMTavfAwWO+9EVWdTxc8ZS
 LVtuXXy7WsmeGy6TZVScwC/HW7zxM1/P/B91oyIOENBFWctT+EtMdfEu8OEiuMIWq0x2Ix
 MdhMofBotyuQ/Sx8gBuLoW02BgZ8QOU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-f4avazW-O32A_Y1KrUTM7w-1; Mon, 05 Sep 2022 04:32:27 -0400
X-MC-Unique: f4avazW-O32A_Y1KrUTM7w-1
Received: by mail-pl1-f197.google.com with SMTP id
 a8-20020a170902ecc800b00176ad01ab44so1424372plh.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Sep 2022 01:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=S4JK4m0m3+hN9/NjyD45TlkaSX2pzOEl0JORrLG6mzs=;
 b=XWxzqyxv+AZDNhDs4O55Ds+Uo9d6QYpqNp0wRx5k8iK5Iw9mn1x9ltHcYrGkPOByzm
 OIIepKBmoPkyPHEiQdXu/ZGrWbmewAvsw/wIIB9b75bRJO6oplGEp8By7ZbVWkH5nvAR
 uIH0bHtzy7+/mZ+MFkpBjg/PK6s2eKP0UZ5CkRcDVZtiugtNayr+OfrWcQZDwr8UY3tx
 SgCBE3M+5zJ8RnL9HJ6pXrJOWO78dNoOSzvpEh8E07K3hjugocDeNqp+nYmk10B5DK2T
 RcpNPc1QlSMMEFFfg2efjK7gxygfr7aWToaWId+FPgKInJqkVGPg9DJzjJTjY9xkIAUQ
 8bZA==
X-Gm-Message-State: ACgBeo3AgnN83N3njxUcIWvMhhY/p9vul8BekVnhqxoMic3zF0NhIHAX
 nlB7Mvv/avKo0K+SQRAXnL5dPO0qixT2kCYviC6EFGuqYiwfNcSTGGBVb9ZT1rbzL7B+KY5Un61
 4oBEPfYgIKt494sbL5Bv6OZmZMcOqfqqdaFVr5B5PlA==
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id
 pf11-20020a17090b1d8b00b0020053675ecdmr5847727pjb.165.1662366745417; 
 Mon, 05 Sep 2022 01:32:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR55K+TMI7e0v4Qj3djAA88LyYePDornUMNHcPRaFDkQVGBJ3mgtkBq2b8FE5Hf5q95howCsPg==
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id
 pf11-20020a17090b1d8b00b0020053675ecdmr5847703pjb.165.1662366745129; 
 Mon, 05 Sep 2022 01:32:25 -0700 (PDT)
Received: from [10.72.13.239] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 o20-20020aa79794000000b0052c7ff2ac74sm7345483pfp.17.2022.09.05.01.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Sep 2022 01:32:24 -0700 (PDT)
Message-ID: <10630d99-e0bd-c067-8766-19266b38d2fe@redhat.com>
Date: Mon, 5 Sep 2022 16:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] vhost-net: support VIRTIO_F_RING_RESET
To: Kangjie Xu <kangjie.xu@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hengqi@linux.alibaba.com, bpf@vger.kernel.org
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

CuWcqCAyMDIyLzgvMjUgMTY6NTYsIEthbmdqaWUgWHUg5YaZ6YGTOgo+IEFkZCBWSVJUSU9fRl9S
SU5HX1JFU0VULCB3aGljaCBpbmRpY2F0ZXMgdGhhdCB0aGUgZHJpdmVyIGNhbiByZXNldCBhCj4g
cXVldWUgaW5kaXZpZHVhbGx5Lgo+Cj4gVklSVElPX0ZfUklOR19SRVNFVCBmZWF0dXJlIGlzIGFk
ZGVkIHRvIHZpcnRpby1zcGVjIDEuMi4gVGhlIHJlbGV2YW50Cj4gaW5mb3JtYXRpb24gaXMgaW4K
PiAgICAgIG9hc2lzLXRjcy92aXJ0aW8tc3BlYyMxMjQKPiAgICAgIG9hc2lzLXRjcy92aXJ0aW8t
c3BlYyMxMzkKPgo+IFRoZSBpbXBsZW1lbnRhdGlvbiBvbmx5IGFkZHMgdGhlIGZlYXR1cmUgYml0
IGluIHN1cHBvcnRlZCBmZWF0dXJlcy4gSXQKPiBkb2VzIG5vdCByZXF1aXJlIGFueSBvdGhlciBj
aGFuZ2VzIGJlY2F1c2Ugd2UgcmV1c2UgdGhlIGV4aXN0aW5nIHZob3N0Cj4gcHJvdG9jb2wuCj4K
PiBUaGUgdmlydHF1ZXVlIHJlc2V0IHByb2Nlc3MgY2FuIGJlIGNvbmNsdWRlZCBhcyB0d28gcGFy
dHM6Cj4gMS4gVGhlIGRyaXZlciBjYW4gcmVzZXQgYSB2aXJ0cXVldWUuIFdoZW4gaXQgaXMgdHJp
Z2dlcmVkLCB3ZSB1c2UgdGhlCj4gc2V0X2JhY2tlbmQgdG8gZGlzYWJsZSB0aGUgdmlydHF1ZXVl
Lgo+IDIuIEFmdGVyIHRoZSB2aXJ0cXVldWUgaXMgZGlzYWJsZWQsIHRoZSBkcml2ZXIgbWF5IG9w
dGlvbmFsbHkgcmUtZW5hYmxlCj4gaXQuIFRoZSBwcm9jZXNzIGlzIGJhc2ljYWxseSBzaW1pbGFy
IHRvIHdoZW4gdGhlIGRldmljZSBpcyBzdGFydGVkLAo+IGV4Y2VwdCB0aGF0IHRoZSByZXN0YXJ0
IHByb2Nlc3MgZG9lcyBub3QgbmVlZCB0byBzZXQgZmVhdHVyZXMgYW5kIHNldAo+IG1lbSB0YWJs
ZSBzaW5jZSB0aGV5IGRvIG5vdCBjaGFuZ2UuIFFFTVUgd2lsbCBzZW5kIG1lc3NhZ2VzIGNvbnRh
aW5pbmcKPiBzaXplLCBiYXNlLCBhZGRyLCBraWNrZmQgYW5kIGNhbGxmZCBvZiB0aGUgdmlydHF1
ZXVlIGluIG9yZGVyLgo+IFNwZWNpZmljYWxseSwgdGhlIGhvc3Qga2VybmVsIHdpbGwgcmVjZWl2
ZSB0aGVzZSBtZXNzYWdlcyBpbiBvcmRlcjoKPiAgICAgIGEuIFZIT1NUX1NFVF9WUklOR19OVU0K
PiAgICAgIGIuIFZIT1NUX1NFVF9WUklOR19CQVNFCj4gICAgICBjLiBWSE9TVF9TRVRfVlJJTkdf
QUREUgo+ICAgICAgZC4gVkhPU1RfU0VUX1ZSSU5HX0tJQ0sKPiAgICAgIGUuIFZIT1NUX1NFVF9W
UklOR19DQUxMCj4gICAgICBmLiBWSE9TVF9ORVRfU0VUX0JBQ0tFTkQKPiBGaW5hbGx5LCBhZnRl
ciB3ZSB1c2Ugc2V0X2JhY2tlbmQgdG8gYXR0YWNoIHRoZSB2aXJ0cXVldWUsIHRoZSB2aXJ0cXVl
dWUKPiB3aWxsIGJlIGVuYWJsZWQgYW5kIHN0YXJ0IHRvIHdvcmsuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBLYW5namllIFh1IDxrYW5namllLnh1QGxpbnV4LmFsaWJhYmEuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPgo+IFRlc3QgZW52aXJvbm1l
bnQgYW5kIG1ldGhvZDoKPiAgICAgIEhvc3Q6IDUuMTkuMC1yYzMKPiAgICAgIFFlbXU6IFFFTVUg
ZW11bGF0b3IgdmVyc2lvbiA3LjAuNTAgKFdpdGggdnEgcnNldCBzdXBwb3J0KQo+ICAgICAgR3Vl
c3Q6IDUuMTkuMC1yYzMgKFdpdGggdnEgcmVzZXQgc3VwcG9ydCkKPiAgICAgIFRlc3QgQ21kOiBl
dGh0b29sIC1nIGV0aDE7IGV0aHRvb2wgLUcgZXRoMSByeCAkMSB0eCAkMjsgZXRodG9vbCAtZyBl
dGgxOwo+Cj4gICAgICBUaGUgZHJ2aWVyIGNhbiByZXNpemUgdGhlIHZpcnRpbyBxdWV1ZSwgdGhl
biB2aXJ0aW8gcXVldWUgcmVzZXQgZnVuY3Rpb24gc2hvdWxkCj4gICAgICBiZSB0cmlnZ2VyZWQu
Cj4KPiAgICAgIFRoZSBkZWZhdWx0IGlzIHNwbGl0IG1vZGUsIG1vZGlmeSBRZW11IHZpcnRpby1u
ZXQgdG8gYWRkIFBBQ0tFRCBmZWF0dXJlIHRvCj4gICAgICB0ZXN0IHBhY2tlZCBtb2RlLgo+Cj4g
R3Vlc3QgS2VybmVsIFBhdGNoOgo+ICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzIw
MjIwODAxMDYzOTAyLjEyOTMyOS0xLXh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tLwo+Cj4gUUVN
VSBQYXRjaDoKPiAgICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvY292ZXIu
MTY2MTQxNDM0NS5naXQua2FuZ2ppZS54dUBsaW51eC5hbGliYWJhLmNvbS8KPgo+IExvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIHJldmlldyBhbmQgY29tbWVudHMuIFRoYW5rcy4KPgo+ICAgZHJpdmVy
cy92aG9zdC9uZXQuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9uZXQuYyBiL2Ry
aXZlcnMvdmhvc3QvbmV0LmMKPiBpbmRleCA2OGU0ZWNkMWNjMGUuLjhhMzQ5MjhkNGZlZiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L25ldC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC9uZXQu
Ywo+IEBAIC03Myw3ICs3Myw4IEBAIGVudW0gewo+ICAgCVZIT1NUX05FVF9GRUFUVVJFUyA9IFZI
T1NUX0ZFQVRVUkVTIHwKPiAgIAkJCSAoMVVMTCA8PCBWSE9TVF9ORVRfRl9WSVJUSU9fTkVUX0hE
UikgfAo+ICAgCQkJICgxVUxMIDw8IFZJUlRJT19ORVRfRl9NUkdfUlhCVUYpIHwKPiAtCQkJICgx
VUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkKPiArCQkJICgxVUxMIDw8IFZJUlRJT19G
X0FDQ0VTU19QTEFURk9STSkgfAo+ICsJCQkgKDFVTEwgPDwgVklSVElPX0ZfUklOR19SRVNFVCkK
PiAgIH07Cj4gICAKPiAgIGVudW0gewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
