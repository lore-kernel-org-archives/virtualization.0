Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D23C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 09:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CB9460BE7;
	Tue, 27 Dec 2022 09:13:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CB9460BE7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwwYu5C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cxyxVEnasodP; Tue, 27 Dec 2022 09:13:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07B3460BD6;
	Tue, 27 Dec 2022 09:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07B3460BD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD625C0032;
	Tue, 27 Dec 2022 09:13:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA84CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EBB081334
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EBB081334
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwwYu5C7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsIAjWyPd9Pu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:13:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B077381331
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B077381331
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672132393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Jx6o34uyqpu/PSUYQD9I3JF4UvYdpXWHh4RWvb/DkI=;
 b=bwwYu5C7t/6cYE7x7iYl75j1Z5e12FoGCfXm7a1tvAxI2jL6p9rPqDkUA4lxXJWOGzmxl9
 03zuCPlhiP/2xphedFVn2xluXB3KrO4S83ntsDEVEILFL+5q1zBe58wsdxloDjRSFcHiiW
 t1smLzztnMawwPQTUSSQ9nn00eLQuyc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-gmCMmbepM8uh3_RsI7hGVQ-1; Tue, 27 Dec 2022 04:13:04 -0500
X-MC-Unique: gmCMmbepM8uh3_RsI7hGVQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 ot18-20020a17090b3b5200b00219c3543529so9508109pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 01:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Jx6o34uyqpu/PSUYQD9I3JF4UvYdpXWHh4RWvb/DkI=;
 b=ZVaWjWR8TW4P4qm/a5ct4KYKHhRZRIJp29y4wMG4ak2wG75Wqp87goVP+CJREX6o4k
 x3OQoypPQBqbEFcgJpn/BsRoQXI+AuBkO2AQ1pD2rz6Q2fSBFHC3/qEV5Q0Wv+vW1viK
 rBQpzohVm9bin8qECC0eVApqK/r4AV9rsxHI/bWJF5/vDlKTKjecNvmD3pH4IfNifdQc
 YkXbhkHaHpaHHYhseC41KcSoTu+l6lYWE05S14XPA4FxdjmGQqhkQ24ey9pEFf7ckRp3
 Hd3cHmqpXBa/1vyRxfFpOGCHYnV9nX7UrZD9AvnJFHBQQ17OstiINEIZkdSZ2+AUBfM3
 A8yQ==
X-Gm-Message-State: AFqh2kpeUZmAwwgTYqhI50xMBQjRJMWGe0p54jLeMm5waFUVX5M53QY/
 Q3FbfPvVMBhQHutiYQWMOz4PcnZnMR+3M+w5n4igosgnR8SdItfVnaQ9Hj98Z4eX2pZVFx/RZ2P
 AYMz9ZwG9CqzxaQBh1//YMUkBYZzQerPhBEZcd+oxBg==
X-Received: by 2002:aa7:960d:0:b0:56c:3fba:c5ca with SMTP id
 q13-20020aa7960d000000b0056c3fbac5camr38459833pfg.16.1672132383949; 
 Tue, 27 Dec 2022 01:13:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs0uW6pvl7WTQFTWTYhpvNudCBZ3Vz1d8332wzs1ANd1EMyd8E6UvZETJjAdYG2CpgZ74SUjQ==
X-Received: by 2002:aa7:960d:0:b0:56c:3fba:c5ca with SMTP id
 q13-20020aa7960d000000b0056c3fbac5camr38459804pfg.16.1672132383657; 
 Tue, 27 Dec 2022 01:13:03 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 q13-20020aa7960d000000b005752b9fec48sm8142551pfg.204.2022.12.27.01.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 01:13:03 -0800 (PST)
Message-ID: <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
Date: Tue, 27 Dec 2022 17:12:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227022255-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIyLzEyLzI3IDE1OjMzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9uIFR1
ZSwgRGVjIDI3LCAyMDIyIGF0IDEyOjMwOjM1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
PiBCdXQgZGV2aWNlIGlzIHN0aWxsIGdvaW5nIGFuZCB3aWxsIGxhdGVyIHVzZSB0aGUgYnVmZmVy
cy4KPj4+Cj4+PiBTYW1lIGZvciB0aW1lb3V0IHJlYWxseS4KPj4gQXZvaWRpbmcgaW5maW5pdGUg
d2FpdC9wb2xsIGlzIG9uZSBvZiB0aGUgZ29hbHMsIGFub3RoZXIgaXMgdG8gc2xlZXAuCj4+IElm
IHdlIHRoaW5rIHRoZSB0aW1lb3V0IGlzIGhhcmQsIHdlIGNhbiBzdGFydCBmcm9tIHRoZSB3YWl0
Lgo+Pgo+PiBUaGFua3MKPiBJZiB0aGUgZ29hbCBpcyB0byBhdm9pZCBkaXNydXB0aW5nIHRyYWZm
aWMgd2hpbGUgQ1ZRIGlzIGluIHVzZSwKPiB0aGF0IHNvdW5kcyBtb3JlIHJlYXNvbmFibGUuIEUu
Zy4gc29tZW9uZSBpcyB0dXJuaW5nIG9uIHByb21pc2MsCj4gYSBzcGlrZSBpbiBDUFUgdXNhZ2Ug
bWlnaHQgYmUgdW53ZWxjb21lLgoKClllcywgdGhpcyB3b3VsZCBiZSBtb3JlIG9idmlvdXMgaXMg
VVAgaXMgdXNlZC4KCgo+Cj4gdGhpbmdzIHdlIHNob3VsZCBiZSBjYXJlZnVsIHRvIGFkZHJlc3Mg
dGhlbjoKPiAxLSBkZWJ1Z2dpbmcuIEN1cnJlbnRseSBpdCdzIGVhc3kgdG8gc2VlIGEgd2Fybmlu
ZyBpZiBDUFUgaXMgc3R1Y2sKPiAgICAgaW4gYSBsb29wIGZvciBhIHdoaWxlLCBhbmQgd2UgYWxz
byBnZXQgYSBiYWNrdHJhY2UuCj4gICAgIEUuZy4gd2l0aCB0aGlzIC0gaG93IGRvIHdlIGtub3cg
d2hvIGhhcyB0aGUgUlROTD8KPiAgICAgV2UgbmVlZCB0byBpbnRlZ3JhdGUgd2l0aCBrZXJuZWwv
d2F0Y2hkb2cuYyBmb3IgZ29vZCByZXN1bHRzCj4gICAgIGFuZCB0byBtYWtlIHN1cmUgcG9saWN5
IGlzIGNvbnNpc3RlbnQuCgoKVGhhdCdzIGZpbmUsIHdpbGwgY29uc2lkZXIgdGhpcy4KCgo+IDIt
IG92ZXJoZWFkLiBJbiBhIHZlcnkgY29tbW9uIHNjZW5hcmlvIHdoZW4gZGV2aWNlIGlzIGluIGh5
cGVydmlzb3IsCj4gICAgIHByb2dyYW1taW5nIHRpbWVycyBldGMgaGFzIGEgdmVyeSBoaWdoIG92
ZXJoZWFkLCBhdCBib290dXAKPiAgICAgbG90cyBvZiBDVlEgY29tbWFuZHMgYXJlIHJ1biBhbmQg
c2xvd2luZyBib290IGRvd24gaXMgbm90IG5pY2UuCj4gICAgIGxldCdzIHBvbGwgZm9yIGEgYml0
IGJlZm9yZSB3YWl0aW5nPwoKClRoZW4gd2UgZ28gYmFjayB0byB0aGUgcXVlc3Rpb24gb2YgY2hv
b3NpbmcgYSBnb29kIHRpbWVvdXQgZm9yIHBvbGwuIEFuZCAKcG9sbCBzZWVtcyBwcm9ibGVtYXRp
YyBpbiB0aGUgY2FzZSBvZiBVUCwgc2NoZWR1bGVyIG1pZ2h0IG5vdCBoYXZlIHRoZSAKY2hhbmNl
IHRvIHJ1bi4KCgo+IDMtIHN1cHJpc2UgcmVtb3ZhbC4gbmVlZCB0byB3YWtlIHVwIHRocmVhZCBp
biBzb21lIHdheS4gd2hhdCBhYm91dAo+ICAgICBvdGhlciBjYXNlcyBvZiBkZXZpY2UgYnJlYWth
Z2UgLSBpcyB0aGVyZSBhIGNoYW5jZSB0aGlzCj4gICAgIGludHJvZHVjZXMgbmV3IGJ1Z3MgYXJv
dW5kIHRoYXQ/IGF0IGxlYXN0IGVudW1lcmF0ZSB0aGVtIHBsZWFzZS4KCgpUaGUgY3VycmVudCBj
b2RlIGRpZDoKCjEpIGNoZWNrIGZvciB2cS0+YnJva2VuCjIpIHdha2V1cCBkdXJpbmcgQkFEX1JJ
TkcoKQoKU28gd2Ugd29uJ3QgZW5kIHVwIHdpdGggYSBuZXZlciB3b2tlIHVwIHByb2Nlc3Mgd2hp
Y2ggc2hvdWxkIGJlIGZpbmUuCgpUaGFua3MKCgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
