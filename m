Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF8CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 456F6418F4;
	Tue, 17 May 2022 03:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z5Qcv5J-cDsv; Tue, 17 May 2022 03:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B11E3418D0;
	Tue, 17 May 2022 03:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74A3DC0039;
	Tue, 17 May 2022 03:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 955FEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7572A60F99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YeO6OFeNQeZY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3AB760EB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652757808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V52KTK9sfCZlBnEwaFt7ULBSI8/qXE3PmijvXNZClMA=;
 b=aXS2/TbuRhZ+Ck1RZTL1So2NY0LwnetnyA5Vtpust4MSfbBu9Vp/zgcP3oA/ozr6PWPP40
 IefyiyMGFytkp57dRUt+grL7DYZeEI0f4Q3aCiZpalZt+FSohk69dLyztmoWpgYySMSD/Y
 S4LZ++KJnV/tttUjxjDzcUKO5V7FEX0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-sOazk6ZtMHST3mpfLNZ8oQ-1; Mon, 16 May 2022 23:23:27 -0400
X-MC-Unique: sOazk6ZtMHST3mpfLNZ8oQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 y17-20020a637d11000000b003ab06870074so8260361pgc.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=V52KTK9sfCZlBnEwaFt7ULBSI8/qXE3PmijvXNZClMA=;
 b=lWmOV0DUJZEe1VptdPKkZQFt6A9f3sYDcN9XDWJOioVDR3OZr+1I5JW9JNJcKo8BL0
 G/W9InmQZN4XLvcIaSs7gp1mG/R1cs+ckPaSWHyNE6A5YeiID5bT7z/ENyATv4SAnTnn
 nCUJyLxFfu5XxLlm5nJ8sfKOBGEkKnC+xNKqO0cD/+Qh9yJyKV9rkBsYtoe1DnMKWPXs
 Y3jJuKO4VVgxiaaXtf6bwBqwDKKYZ9X3ly8NwBzxxvNrPyF7RuFjcMYCBwFNqgHOAAm/
 wwOzPBVAODV9drEeCSCDvrWT8AvhdjqsohGWuxxxLueVoBHmDT6y2EDO4Dc4f5nBI5Ro
 cL0Q==
X-Gm-Message-State: AOAM530Nmekujh+tjnM6R0FQNxfENFwHZ4UN9BxfgY4hMRHJPCLVsf5D
 k4yRvzw0s8PzATr0k9JPO2jWM2hsTGocHfmzXEt7B0UUVYzEg/lKLDxG7bbuFH0v/xfhjzxQ2BW
 fVH+W1tXczNwYKeTH7YVFsLWlgZtlgCgIS0HC7C2qfA==
X-Received: by 2002:a17:90a:a018:b0:1df:7c2e:5f2 with SMTP id
 q24-20020a17090aa01800b001df7c2e05f2mr2958457pjp.192.1652757806256; 
 Mon, 16 May 2022 20:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV1qWZ8G4tNp+98CF/+6kqQzaCN5H9Ak2O1hpeMJYOogxxk3cKfYvnZrCY+pXJVJJbdjUtIg==
X-Received: by 2002:a17:90a:a018:b0:1df:7c2e:5f2 with SMTP id
 q24-20020a17090aa01800b001df7c2e05f2mr2958442pjp.192.1652757806015; 
 Mon, 16 May 2022 20:23:26 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a62f80b000000b0050dc7628149sm7614228pfh.35.2022.05.16.20.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:23:25 -0700 (PDT)
Message-ID: <5db0fe9b-2bfc-31dc-e2b1-007f20f6acf2@redhat.com>
Date: Tue, 17 May 2022 11:23:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH V2 4/8] vhost_test: remove vhost_test_flush_vq()
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, arbn@yandex-team.com
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-5-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220515202922.174066-5-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzUvMTYgMDQ6MjksIE1pa2UgQ2hyaXN0aWUg5YaZ6YGTOgo+IEZyb206IEFuZHJl
eSBSeWFiaW5pbiA8YXJibkB5YW5kZXgtdGVhbS5jb20+Cj4KPiB2aG9zdF90ZXN0X2ZsdXNoX3Zx
KCkganVzdCBhIHNpbXBsZSB3cmFwcGVyIGFyb3VuZCB2aG9zdF93b3JrX2Rldl9mbHVzaCgpCj4g
d2hpY2ggc2VlbXMgaGF2ZSBubyB2YWx1ZS4gSXQncyBqdXN0IGVhc2llciB0byBjYWxsIHZob3N0
X3dvcmtfZGV2X2ZsdXNoKCkKPiBkaXJlY3RseS4gQmVzaWRlcyB0aGVyZSBpcyBubyBwb2ludCBp
biBvYnRhaW5pbmcgdmhvc3RfZGV2IHBvaW50ZXIKPiB2aWEgJ24tPnZxc1tpbmRleF0ucG9sbC5k
ZXYnIHdoaWxlIHdlIGNhbiBqdXN0IHVzZSAmbi0+ZGV2Lgo+IEl0J3MgdGhlIHNhbWUgcG9pbnRl
cnMsIHNlZSB2aG9zdF90ZXN0X29wZW4oKS92aG9zdF9kZXZfaW5pdCgpLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV5IFJ5YWJpbmluIDxhcmJuQHlhbmRleC10ZWFtLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmhvc3QvdGVzdC5jIHwgMTEgKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC90
ZXN0LmMgYi9kcml2ZXJzL3Zob3N0L3Rlc3QuYwo+IGluZGV4IGYwYWM5ZTM1ZjVkNi4uODM3MTQ4
ZDBhNmE4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdGVzdC5jCj4gKysrIGIvZHJpdmVy
cy92aG9zdC90ZXN0LmMKPiBAQCAtMTQ0LDE0ICsxNDQsOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF90
ZXN0X3N0b3Aoc3RydWN0IHZob3N0X3Rlc3QgKm4sIHZvaWQgKipwcml2YXRlcCkKPiAgIAkqcHJp
dmF0ZXAgPSB2aG9zdF90ZXN0X3N0b3BfdnEobiwgbi0+dnFzICsgVkhPU1RfVEVTVF9WUSk7Cj4g
ICB9Cj4gICAKPiAtc3RhdGljIHZvaWQgdmhvc3RfdGVzdF9mbHVzaF92cShzdHJ1Y3Qgdmhvc3Rf
dGVzdCAqbiwgaW50IGluZGV4KQo+IC17Cj4gLQl2aG9zdF93b3JrX2Rldl9mbHVzaChuLT52cXNb
aW5kZXhdLnBvbGwuZGV2KTsKPiAtfQo+IC0KPiAgIHN0YXRpYyB2b2lkIHZob3N0X3Rlc3RfZmx1
c2goc3RydWN0IHZob3N0X3Rlc3QgKm4pCj4gICB7Cj4gLQl2aG9zdF90ZXN0X2ZsdXNoX3ZxKG4s
IFZIT1NUX1RFU1RfVlEpOwo+ICsJdmhvc3Rfd29ya19kZXZfZmx1c2goJm4tPmRldik7Cj4gICB9
Cj4gICAKPiAgIHN0YXRpYyBpbnQgdmhvc3RfdGVzdF9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBmaWxlICpmKQo+IEBAIC0yMTAsNyArMjA1LDcgQEAgc3RhdGljIGxvbmcgdmhv
c3RfdGVzdF9ydW4oc3RydWN0IHZob3N0X3Rlc3QgKm4sIGludCB0ZXN0KQo+ICAgCQkJZ290byBl
cnI7Cj4gICAKPiAgIAkJaWYgKG9sZHByaXYpIHsKPiAtCQkJdmhvc3RfdGVzdF9mbHVzaF92cShu
LCBpbmRleCk7Cj4gKwkJCXZob3N0X3Rlc3RfZmx1c2gobiwgaW5kZXgpOwo+ICAgCQl9Cj4gICAJ
fQo+ICAgCj4gQEAgLTMwMyw3ICsyOTgsNyBAQCBzdGF0aWMgbG9uZyB2aG9zdF90ZXN0X3NldF9i
YWNrZW5kKHN0cnVjdCB2aG9zdF90ZXN0ICpuLCB1bnNpZ25lZCBpbmRleCwgaW50IGZkKQo+ICAg
CW11dGV4X3VubG9jaygmdnEtPm11dGV4KTsKPiAgIAo+ICAgCWlmIChlbmFibGUpIHsKPiAtCQl2
aG9zdF90ZXN0X2ZsdXNoX3ZxKG4sIGluZGV4KTsKPiArCQl2aG9zdF90ZXN0X2ZsdXNoKG4pOwo+
ICAgCX0KPiAgIAo+ICAgCW11dGV4X3VubG9jaygmbi0+ZGV2Lm11dGV4KTsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
