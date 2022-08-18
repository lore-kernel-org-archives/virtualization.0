Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD3C25B0E
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 04:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D036A40639;
	Thu, 18 Aug 2022 04:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D036A40639
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=foaSqwIt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRfaARRtllQM; Thu, 18 Aug 2022 04:29:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48F4A400E4;
	Thu, 18 Aug 2022 04:29:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48F4A400E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12597C0032;
	Thu, 18 Aug 2022 04:29:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81728C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5558240190
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:29:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5558240190
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_4cXriIQK0s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:29:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37A4A400E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37A4A400E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660796944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCPrqwMbhashZs9ajDG3ZLy61/uPNuf+3BvVHV/Odhk=;
 b=foaSqwItVnI8ICNq1K7ko3JxdBUXZvRJJaOg/Fl3pjIX99+9XB5WO8h5kgYyza3pChWPfs
 JIz/gepQ8FUQoTM49Vf5FO0S5UNqUi9pB6lecqEVoEP41QIYfTFK6K/JeCi0FpcO0616CH
 jA7agAuOlveUci3RUa07Leqt2OBXzrE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-0_XjibjYNF-XM4zcTayanA-1; Thu, 18 Aug 2022 00:29:02 -0400
X-MC-Unique: 0_XjibjYNF-XM4zcTayanA-1
Received: by mail-pl1-f200.google.com with SMTP id
 s18-20020a170902ea1200b0016f11bfefe4so422204plg.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 21:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=KCPrqwMbhashZs9ajDG3ZLy61/uPNuf+3BvVHV/Odhk=;
 b=gnhVmcmSLNgQGaRqJkoM5QH2tCoEq18hSY/EX1rTMOvsy2Z7ComgE5r4F+rx/I/BFJ
 22Z/FaoMqBxPq60Gq1E2XWvxv/2RD7q0XEc8bEAh50Zp4JIHskw6UPWSuhyIkLZVDbkH
 q+jMOF538EQGRn2xuXeX/ueZAQ40AeLfLNfLAH9K/eYS40ng8UrAAxzTU7AzTKkv9gVT
 fqfoExUUGfKwbhg0t0i1O51QXgo58N42jaxCz6DfAOufjz4qZ42rtNDIjw64u+GP70jR
 BFoHUJsvsXZddwxvrQo4TBKHJro8/cmwNleBRJahCY+GJzVp5dBUIEld8MidmhqJC/FC
 nXgQ==
X-Gm-Message-State: ACgBeo1pz0kB4dVvv/nJJhs8rP5DwTXs1KDDrDIsGW9kWsu7aLH0f35C
 2DmYayMkiGZhyLnHdkK+6i39mzlZnGnu2lqWRSBUdsROz7ST8TTYEig76sdwP4nD2+1HXqw/USI
 wXWGXjCbw+xOwUqazoM9JpmDOQnqd66xX9rTn2hjeCg==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id
 d6-20020a056a00244600b005285da90cc7mr1293869pfj.51.1660796941436; 
 Wed, 17 Aug 2022 21:29:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7NMD4EVf5aRXovcw/8GOgAQdQuu/1flQGm1/lUUdQvP3AM0nmVQZrsmhqQ7p+cfFoK7Zf2dQ==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id
 d6-20020a056a00244600b005285da90cc7mr1293831pfj.51.1660796941080; 
 Wed, 17 Aug 2022 21:29:01 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a170903211500b00170a757a191sm296595ple.9.2022.08.17.21.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Aug 2022 21:29:00 -0700 (PDT)
Message-ID: <3abb1be9-b12c-e658-0391-8461e28f1b33@redhat.com>
Date: Thu, 18 Aug 2022 12:28:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <20220817025250-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817025250-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, linux-hyperv@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzgvMTcgMTQ6NTQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gTW9u
LCBBdWcgMTUsIDIwMjIgYXQgMTA6NTY6MDNBTSAtMDcwMCwgQm9iYnkgRXNobGVtYW4gd3JvdGU6
Cj4+IEhleSBldmVyeWJvZHksCj4+Cj4+IFRoaXMgc2VyaWVzIGludHJvZHVjZXMgZGF0YWdyYW1z
LCBwYWNrZXQgc2NoZWR1bGluZywgYW5kIHNrX2J1ZmYgdXNhZ2UKPj4gdG8gdmlydGlvIHZzb2Nr
Lgo+Pgo+PiBUaGUgdXNhZ2Ugb2Ygc3RydWN0IHNrX2J1ZmYgYmVuZWZpdHMgdXNlcnMgYnkgYSkg
cHJlcGFyaW5nIHZzb2NrIHRvIHVzZQo+PiBvdGhlciByZWxhdGVkIHN5c3RlbXMgdGhhdCByZXF1
aXJlIHNrX2J1ZmYsIHN1Y2ggYXMgc29ja21hcCBhbmQgcWRpc2MsCj4+IGIpIHN1cHBvcnRpbmcg
YmFzaWMgY29uZ2VzdGlvbiBjb250cm9sIHZpYSBzb2NrX2FsbG9jX3NlbmRfc2tiLCBhbmQgYykK
Pj4gcmVkdWNpbmcgY29weWluZyB3aGVuIGRlbGl2ZXJpbmcgcGFja2V0cyB0byBUQVAuCj4+Cj4+
IFRoZSBzb2NrZXQgbGF5ZXIgbm8gbG9uZ2VyIGZvcmNlcyBlcnJvcnMgdG8gYmUgLUVOT01FTSwg
YXMgdHlwaWNhbGx5Cj4+IHVzZXJzcGFjZSBleHBlY3RzIC1FQUdBSU4gd2hlbiB0aGUgc2tfc25k
YnVmIHRocmVzaG9sZCBpcyByZWFjaGVkIGFuZAo+PiBtZXNzYWdlcyBhcmUgYmVpbmcgc2VudCB3
aXRoIG9wdGlvbiBNU0dfRE9OVFdBSVQuCj4+Cj4+IFRoZSBkYXRhZ3JhbSB3b3JrIGlzIGJhc2Vk
IG9mZiBwcmV2aW91cyBwYXRjaGVzIGJ5IEppYW5nIFdhbmdbMV0uCj4+Cj4+IFRoZSBpbnRyb2R1
Y3Rpb24gb2YgZGF0YWdyYW1zIGNyZWF0ZXMgYSB0cmFuc3BvcnQgbGF5ZXIgZmFpcm5lc3MgaXNz
dWUKPj4gd2hlcmUgZGF0YWdyYW1zIG1heSBmcmVlbHkgc3RhcnZlIHN0cmVhbXMgb2YgcXVldWUg
YWNjZXNzLiBUaGlzIGhhcHBlbnMKPj4gYmVjYXVzZSwgdW5saWtlIHN0cmVhbXMsIGRhdGFncmFt
cyBsYWNrIHRoZSB0cmFuc2FjdGlvbnMgbmVjZXNzYXJ5IGZvcgo+PiBjYWxjdWxhdGluZyBjcmVk
aXRzIGFuZCB0aHJvdHRsaW5nLgo+Pgo+PiBQcmV2aW91cyBwcm9wb3NhbHMgaW50cm9kdWNlIGNo
YW5nZXMgdG8gdGhlIHNwZWMgdG8gYWRkIGFuIGFkZGl0aW9uYWwKPj4gdmlydHF1ZXVlIHBhaXIg
Zm9yIGRhdGFncmFtc1sxXS4gQWx0aG91Z2ggdGhpcyBzb2x1dGlvbiB3b3JrcywgdXNpbmcKPj4g
TGludXgncyBxZGlzYyBmb3IgcGFja2V0IHNjaGVkdWxpbmcgbGV2ZXJhZ2VzIGFscmVhZHkgZXhp
c3Rpbmcgc3lzdGVtcywKPj4gYXZvaWRzIHRoZSBuZWVkIHRvIGNoYW5nZSB0aGUgdmlydGlvIHNw
ZWNpZmljYXRpb24sIGFuZCBnaXZlcyBhZGRpdGlvbmFsCj4+IGNhcGFiaWxpdGllcy4gVGhlIHVz
YWdlIG9mIFNGUSBvciBmcV9jb2RlbCwgZm9yIGV4YW1wbGUsIG1heSBzb2x2ZSB0aGUKPj4gdHJh
bnNwb3J0IGxheWVyIHN0YXJ2YXRpb24gcHJvYmxlbS4gSXQgaXMgZWFzeSB0byBpbWFnaW5lIG90
aGVyIHVzZQo+PiBjYXNlcyBhcyB3ZWxsLiBGb3IgZXhhbXBsZSwgc2VydmljZXMgb2YgdmFyeWlu
ZyBpbXBvcnRhbmNlIG1heSBiZQo+PiBhc3NpZ25lZCBkaWZmZXJlbnQgcHJpb3JpdGllcywgYW5k
IHFkaXNjIHdpbGwgYXBwbHkgYXBwcm9wcmlhdGUKPj4gcHJpb3JpdHktYmFzZWQgc2NoZWR1bGlu
Zy4gQnkgZGVmYXVsdCwgdGhlIHN5c3RlbSBkZWZhdWx0IHBmaWZvIHFkaXNjIGlzCj4+IHVzZWQu
IFRoZSBxZGlzYyBtYXkgYmUgYnlwYXNzZWQgYW5kIGxlZ2FjeSBxdWV1aW5nIGlzIHJlc3VtZWQg
Ynkgc2ltcGx5Cj4+IHNldHRpbmcgdGhlIHZpcnRpby12c29jayVkIG5ldHdvcmsgZGV2aWNlIHRv
IHN0YXRlIERPV04uIFRoaXMgdGVjaG5pcXVlCj4+IHN0aWxsIGFsbG93cyB2c29jayB0byB3b3Jr
IHdpdGggemVyby1jb25maWd1cmF0aW9uLgo+IFRoZSBiYXNpYyBxdWVzdGlvbiB0byBhbnN3ZXIg
dGhlbiBpcyB0aGlzOiB3aXRoIGEgbmV0IGRldmljZSBxZGlzYwo+IGV0YyBpbiB0aGUgcGljdHVy
ZSwgaG93IGlzIHRoaXMgZGlmZmVyZW50IGZyb20gdmlydGlvIG5ldCB0aGVuPwo+IFdoeSBkbyB5
b3Ugc3RpbGwgd2FudCB0byB1c2UgdnNvY2s/CgoKT3IgbWF5YmUgaXQncyB0aW1lIHRvIHJldmlz
aXQgYW4gb2xkIGlkZWFbMV0gdG8gdW5pZnkgYXQgbGVhc3QgdGhlIApkcml2ZXIgcGFydCAoZS5n
IHVzaW5nIHZpcnRpby1uZXQgZHJpdmVyIGZvciB2c29jayB0aGVuIHdlIGNhbiBhbGwgCmZlYXR1
cmVzIHRoYXQgdnNvY2sgaXMgbGFja2luZyBub3cpPwoKVGhhbmtzCgpbMV0gCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9waXBlcm1haWwvdmlydHVhbGl6YXRpb24vMjAxOC1Ob3Zl
bWJlci8wMzk3ODMuaHRtbAoKCj4KPj4gSW4gc3VtbWFyeSwgdGhpcyBzZXJpZXMgaW50cm9kdWNl
cyB0aGVzZSBtYWpvciBjaGFuZ2VzIHRvIHZzb2NrOgo+Pgo+PiAtIHZpcnRpbyB2c29jayBzdXBw
b3J0cyBkYXRhZ3JhbXMKPj4gLSB2aXJ0aW8gdnNvY2sgdXNlcyBzdHJ1Y3Qgc2tfYnVmZiBpbnN0
ZWFkIG9mIHZpcnRpb192c29ja19wa3QKPj4gICAgLSBCZWNhdXNlIHZpcnRpbyB2c29jayB1c2Vz
IHNrX2J1ZmYsIGl0IGFsc28gdXNlcyBzb2NrX2FsbG9jX3NlbmRfc2tiLAo+PiAgICAgIHdoaWNo
IGFwcGxpZXMgdGhlIHRocm90dGxpbmcgdGhyZXNob2xkIHNrX3NuZGJ1Zi4KPj4gLSBUaGUgdnNv
Y2sgc29ja2V0IGxheWVyIHN1cHBvcnRzIHJldHVybmluZyBlcnJvcnMgb3RoZXIgdGhhbiAtRU5P
TUVNLgo+PiAgICAtIFRoaXMgaXMgdXNlZCB0byByZXR1cm4gLUVBR0FJTiB3aGVuIHRoZSBza19z
bmRidWYgdGhyZXNob2xkIGlzCj4+ICAgICAgcmVhY2hlZC4KPj4gLSB2aXJ0aW8gdnNvY2sgdXNl
cyBhIG5ldF9kZXZpY2UsIHRocm91Z2ggd2hpY2ggcWRpc2MgbWF5IGJlIHVzZWQuCj4+ICAgLSBx
ZGlzYyBhbGxvd3Mgc2NoZWR1bGluZyBwb2xpY2llcyB0byBiZSBhcHBsaWVkIHRvIHZzb2NrIGZs
b3dzLgo+PiAgICAtIFNvbWUgcWRpc2NzLCBsaWtlIFNGUSwgbWF5IGFsbG93IHZzb2NrIHRvIGF2
b2lkIHRyYW5zcG9ydCBsYXllciBjb25nZXN0aW9uLiBUaGF0IGlzLAo+PiAgICAgIGl0IG1heSBh
dm9pZCBkYXRhZ3JhbXMgZnJvbSBmbG9vZGluZyBvdXQgc3RyZWFtIGZsb3dzLiBUaGUgYmVuZWZp
dAo+PiAgICAgIHRvIHRoaXMgaXMgdGhhdCBhZGRpdGlvbmFsIHZpcnRxdWV1ZXMgYXJlIG5vdCBu
ZWVkZWQgZm9yIGRhdGFncmFtcy4KPj4gICAgLSBUaGUgbmV0X2RldmljZSBhbmQgcWRpc2MgaXMg
YnlwYXNzZWQgYnkgc2ltcGx5IHNldHRpbmcgdGhlCj4+ICAgICAgbmV0X2RldmljZSBzdGF0ZSB0
byBET1dOLgo+Pgo+PiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIxMDkxNDA1
NTQ0MC4zMTIxMDA0LTEtamlhbmcud2FuZ0BieXRlZGFuY2UuY29tLwo+Pgo+PiBCb2JieSBFc2hs
ZW1hbiAoNSk6Cj4+ICAgIHZzb2NrOiByZXBsYWNlIHZpcnRpb192c29ja19wa3Qgd2l0aCBza19i
dWZmCj4+ICAgIHZzb2NrOiByZXR1cm4gZXJyb3JzIG90aGVyIHRoYW4gLUVOT01FTSB0byBzb2Nr
ZXQKPj4gICAgdnNvY2s6IGFkZCBuZXRkZXYgdG8gdmhvc3QvdmlydGlvIHZzb2NrCj4+ICAgIHZp
cnRpby92c29jazogYWRkIFZJUlRJT19WU09DS19GX0RHUkFNIGZlYXR1cmUgYml0Cj4+ICAgIHZp
cnRpby92c29jazogYWRkIHN1cHBvcnQgZm9yIGRncmFtCj4+Cj4+IEppYW5nIFdhbmcgKDEpOgo+
PiAgICB2c29ja190ZXN0OiBhZGQgdGVzdHMgZm9yIHZzb2NrIGRncmFtCj4+Cj4+ICAgZHJpdmVy
cy92aG9zdC92c29jay5jICAgICAgICAgICAgICAgICAgIHwgMjM4ICsrKystLS0tCj4+ICAgaW5j
bHVkZS9saW51eC92aXJ0aW9fdnNvY2suaCAgICAgICAgICAgIHwgIDczICsrLQo+PiAgIGluY2x1
ZGUvbmV0L2FmX3Zzb2NrLmggICAgICAgICAgICAgICAgICB8ICAgMiArCj4+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L3ZpcnRpb192c29jay5oICAgICAgIHwgICAyICsKPj4gICBuZXQvdm13X3Zzb2Nr
L2FmX3Zzb2NrLmMgICAgICAgICAgICAgICAgfCAgMzAgKy0KPj4gICBuZXQvdm13X3Zzb2NrL2h5
cGVydl90cmFuc3BvcnQuYyAgICAgICAgfCAgIDIgKy0KPj4gICBuZXQvdm13X3Zzb2NrL3ZpcnRp
b190cmFuc3BvcnQuYyAgICAgICAgfCAyMzcgKysrKystLS0KPj4gICBuZXQvdm13X3Zzb2NrL3Zp
cnRpb190cmFuc3BvcnRfY29tbW9uLmMgfCA3NzEgKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4+
ICAgbmV0L3Ztd192c29jay92bWNpX3RyYW5zcG9ydC5jICAgICAgICAgIHwgICA5ICstCj4+ICAg
bmV0L3Ztd192c29jay92c29ja19sb29wYmFjay5jICAgICAgICAgIHwgIDUxICstCj4+ICAgdG9v
bHMvdGVzdGluZy92c29jay91dGlsLmMgICAgICAgICAgICAgIHwgMTA1ICsrKysKPj4gICB0b29s
cy90ZXN0aW5nL3Zzb2NrL3V0aWwuaCAgICAgICAgICAgICAgfCAgIDQgKwo+PiAgIHRvb2xzL3Rl
c3RpbmcvdnNvY2svdnNvY2tfdGVzdC5jICAgICAgICB8IDE5NSArKysrKysKPj4gICAxMyBmaWxl
cyBjaGFuZ2VkLCAxMTc2IGluc2VydGlvbnMoKyksIDU0MyBkZWxldGlvbnMoLSkKPj4KPj4gLS0g
Cj4+IDIuMzUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
