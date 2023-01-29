Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452BCC61D97
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 05:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3AC44035B;
	Sun, 29 Jan 2023 05:56:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3AC44035B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KETNazdh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lZ3vrftNGxvB; Sun, 29 Jan 2023 05:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC47341755;
	Sun, 29 Jan 2023 05:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC47341755
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 965AFC0033;
	Sun, 29 Jan 2023 05:56:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFBCC002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 556FF8139A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 556FF8139A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KETNazdh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KgWMEb0qJRso
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:56:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9328E81368
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9328E81368
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674971779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSf6XZDVYNJk3cIc7xUh3xm95VMkiJ6FAi9/1U1AbRQ=;
 b=KETNazdhDc0Qe1h/0as4DyC3jEB6AQOjPTlthSW4QURVmSbHi4c03FDyVkpOUVM+pt1iCa
 QUbrkeCX9VOKrFUBBQ1ENdaUc9x0dcVFwI8VEag6Sn/fXHDI6a1aJE7JY493fWyUfxiVtA
 zWKiihwX2mRJFcaZ3ScUl5QtMokTt6Y=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-VzshhZ-vNtyQmcNkbwzoBQ-1; Sun, 29 Jan 2023 00:56:17 -0500
X-MC-Unique: VzshhZ-vNtyQmcNkbwzoBQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 g32-20020a635660000000b00478c21b8095so3687724pgm.10
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 21:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSf6XZDVYNJk3cIc7xUh3xm95VMkiJ6FAi9/1U1AbRQ=;
 b=Si4XyPmWaarfkMFEiZG1pbFpIt+M76VI28/dOqsEthXXtKlrUc92tOy+J9WFv5EkrT
 K7cIl25rY+Rygw9Z8Pmk0O69t+za71skiF9tzRnBd2TMxi9VFsghuRfWbZirmXhGB5Q3
 /jMdZYtMqhWNDAKzQlJEQNWFylsIvdbZPQ2tZyAx3oZQhIPZFmj18wYgsOOgdx45Tsx2
 dkuhvihwdH7RSqmCJam1va2UFXejVdRxQM7rJMKM1P/v9cZUOr4r5RJBMlyqF3N1i379
 zag8uSwYQ9wIfR+e0+lSItlMjZBMl5gTGJxkM0ma5vCdcVhpYi13Cs45XClQIyqrgoFT
 JP2A==
X-Gm-Message-State: AFqh2krVaMgdtqKkWw/U1EqLFzgWUa1DVmE3A3aL8J5t3dvk6oZCxUjB
 TvxY+x8/RSAXKvPWEUq05u3AYk0Kdkfv0PVsvLw2ij2gzgcp8jqRm0xuQd8mhwk/TzqhbS+84ew
 7v35bEqDYzTnuwxrPbOeLE8pkuam1Fz+aHl7byeNfUg==
X-Received: by 2002:a17:90a:4bc2:b0:229:7b29:54ac with SMTP id
 u2-20020a17090a4bc200b002297b2954acmr46408817pjl.35.1674971776939; 
 Sat, 28 Jan 2023 21:56:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtM+R0YBDYb3wyJgfTkGKuUFE6HcXh+c6aBlpjxk2FuGJ0r+w0P+ZWuUZUFyOUvMqVDCZlTGg==
X-Received: by 2002:a17:90a:4bc2:b0:229:7b29:54ac with SMTP id
 u2-20020a17090a4bc200b002297b2954acmr46408802pjl.35.1674971776696; 
 Sat, 28 Jan 2023 21:56:16 -0800 (PST)
Received: from [10.72.13.13] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a17090a4e0200b00219463262desm5148749pjh.39.2023.01.28.21.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Jan 2023 21:56:16 -0800 (PST)
Message-ID: <1a1c8359-855d-7a05-686a-23935dcad5a9@redhat.com>
Date: Sun, 29 Jan 2023 13:56:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] vdpa_sim: not reset state in vdpasim_queue_ready
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-2-eperezma@redhat.com>
 <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
 <CAJaqyWejkbiwKK4O0qOObdf294YrzMeSRTVoWNzv75yQCvkJqQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWejkbiwKK4O0qOObdf294YrzMeSRTVoWNzv75yQCvkJqQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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

CuWcqCAyMDIzLzEvMTkgMTc6MTQsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiBPbiBU
aHUsIEphbiAxOSwgMjAyMyBhdCA0OjE2IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+PiBPbiBUaHUsIEphbiAxOSwgMjAyMyBhdCAxMjo0NCBBTSBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+PiB2ZHBhc2ltX3F1ZXVlX3JlYWR5
IGNhbGxzIHZyaW5naF9pbml0X2lvdGxiLCB3aGljaCByZXNldHMgc3BsaXQgaW5kZXhlcy4KPj4+
IEJ1dCBpdCBjYW4gYmUgY2FsbGVkIGFmdGVyIHNldHRpbmcgYSByaW5nIGJhc2Ugd2l0aAo+Pj4g
dmRwYXNpbV9zZXRfdnFfc3RhdGUuCj4+Pgo+Pj4gRml4IGl0IGJ5IHN0YXNoaW5nIHRoZW0uIFRo
ZXkncmUgc3RpbGwgcmVzZXR0ZWQgaW4gdmRwYXNpbV92cV9yZXNldC4KPj4+Cj4+PiBUaGlzIHdh
cyBkaXNjb3ZlcmVkIGFuZCB0ZXN0ZWQgbGl2ZSBtaWdyYXRpbmcgdGhlIHZkcGFfc2ltX25ldCBk
ZXZpY2UuCj4+Pgo+Pj4gRml4ZXM6IDJjNTNkMGY2NGMwNiAoInZkcGFzaW06IHZEUEEgZGV2aWNl
IHNpbXVsYXRvciIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFA
cmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
YyB8IDIgKysKPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+PiBpbmRleCBjYjg4ODkxYjQ0YTguLjg4MzkyMzJhM2Zj
YiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+Pj4gQEAgLTY2LDYgKzY2LDcg
QEAgc3RhdGljIHZvaWQgdmRwYXNpbV92cV9ub3RpZnkoc3RydWN0IHZyaW5naCAqdnJpbmcpCj4+
PiAgIHN0YXRpYyB2b2lkIHZkcGFzaW1fcXVldWVfcmVhZHkoc3RydWN0IHZkcGFzaW0gKnZkcGFz
aW0sIHVuc2lnbmVkIGludCBpZHgpCj4+PiAgIHsKPj4+ICAgICAgICAgIHN0cnVjdCB2ZHBhc2lt
X3ZpcnRxdWV1ZSAqdnEgPSAmdmRwYXNpbS0+dnFzW2lkeF07Cj4+PiArICAgICAgIHVpbnQxNl90
IGxhc3RfYXZhaWxfaWR4ID0gdnEtPnZyaW5nLmxhc3RfYXZhaWxfaWR4Owo+Pj4KPj4+ICAgICAg
ICAgIHZyaW5naF9pbml0X2lvdGxiKCZ2cS0+dnJpbmcsIHZkcGFzaW0tPmZlYXR1cmVzLCB2cS0+
bnVtLCBmYWxzZSwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdnJpbmdf
ZGVzYyAqKSh1aW50cHRyX3QpdnEtPmRlc2NfYWRkciwKPj4+IEBAIC03NCw2ICs3NSw3IEBAIHN0
YXRpYyB2b2lkIHZkcGFzaW1fcXVldWVfcmVhZHkoc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sIHVu
c2lnbmVkIGludCBpZHgpCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0IHZy
aW5nX3VzZWQgKikKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1aW50cHRyX3QpdnEt
PmRldmljZV9hZGRyKTsKPj4+Cj4+PiArICAgICAgIHZxLT52cmluZy5sYXN0X2F2YWlsX2lkeCA9
IGxhc3RfYXZhaWxfaWR4Owo+PiBEb2VzIHRoaXMgbmVlZCB0byBiZSBzZXJpYWxpemVkIHdpdGgg
dGhlIGRhdGFwYXRoPwo+Pgo+PiBFLmcgaW4gc2V0X3ZxX3N0YXRlKCkgd2UgZG86Cj4+Cj4+IHNw
aW5fbG9jaygmdmRwYXNpbS0+bG9jayk7Cj4+IHZyaC0+bGFzdF9hdmFpbF9pZHggPSBzdGF0ZS0+
c3BsaXQuYXZhaWxfaW5kZXg7Cj4+IHNwaW5fdW5sb2NrKCZ2ZHBhc2ltLT5sb2NrKTsKPj4KPiB2
ZHBhc2ltX3F1ZXVlX3JlYWR5IGlzIGNhbGxlZCBmcm9tIHZkcGFzaW1fc2V0X3ZxX3JlYWR5LCB3
aGljaCBob2xkcwo+IHRoZXNlIGxvY2tzLgo+Cj4gTWF5YmUgaXQncyB0b28gbXVjaCBpbmRpcmVj
dGlvbiBhbmQgdG8gZW1iZWQgdmRwYXNpbV9xdWV1ZV9yZWFkeSBpbgo+IHZkcGFzaW1fc2V0X3Zx
X3JlYWR5IHdvdWxkIGJlIGNsZWFyZXIgZm9yIHRoZSBmdXR1cmU/CgoKTm9wZSwgSSBtaXNzIHRo
ZSBjYWxsZXIuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKCj4KPiBUaGFua3MhCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
