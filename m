Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E971C6FA83
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 09:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D53B6417BB;
	Tue,  6 Sep 2022 09:01:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D53B6417BB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDavrF/8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0z9UbzjYFUv; Tue,  6 Sep 2022 09:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D132F417B6;
	Tue,  6 Sep 2022 09:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D132F417B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC83C0032;
	Tue,  6 Sep 2022 09:01:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1644C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81FC340B9D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81FC340B9D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VDavrF/8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i5C-5PUW7JCu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:01:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B1C9404B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B1C9404B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662454877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEYw8dkEXgcUOX7V93X65x+uXJi/wlkI4CEWgXjX+U8=;
 b=VDavrF/8htfbBC0/0euO1phdmBQ0Hfve98rKieui+TJh0fwHn6iYk5rTfvd5CwlMwWpOnM
 HcXBI0YDyxZxCD3PTX07xzHOnb4ubS1IfK1y3VZvKIA2keIKhS9HVZzDeCmBIMkWWSsbRV
 oV1RJtMi4Ze7KcYybJoEHTmXRrnbnrA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-Va1PB5n2Osumlhg0EN0tZA-1; Tue, 06 Sep 2022 05:01:06 -0400
X-MC-Unique: Va1PB5n2Osumlhg0EN0tZA-1
Received: by mail-qk1-f198.google.com with SMTP id
 bq19-20020a05620a469300b006c097741d3dso8500181qkb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 02:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=uEYw8dkEXgcUOX7V93X65x+uXJi/wlkI4CEWgXjX+U8=;
 b=w2pjWPK42Z4XHtpAy2R2j8MnEJiukXm/24omk87g41I/2HJfrjU1ksKZZTCyXJ4J1/
 fay9i4zLHpzuw7XZOvPetHgfNSfZ/bvQO8CNEw8bEYymPpxd3utNZX2BLKSuF4SXVueS
 2EFF+ss21TA8Fv+Q6uVDmwZ+efcFLoFfp0eJOtqBjaX+smGRbTn71LZ7xmSh6zZEijX0
 9ec8VJga8t1lel8r572u0165iQedP/OYpH1333iQqGm4v1Ir8CfIikuZWOPdodFRCJKF
 k2zr8FGPPEorfdZRod79EkYFxevL6QleFEKzZWjUF7uKoDxYBGbKmUDjJhMVUHTs5t5J
 4a9A==
X-Gm-Message-State: ACgBeo14XfbK0KTgeX0oPmC9SV1ceZpZtuAHHW50D/xoxRtVSmugvwgY
 1Pmn34UltvwvJSB6BKnVMAJQPX/2LDu2ublSMZMy7CT72I5X3WXLuOYgaytfbbiy7xwdYRGsQkA
 /qNd/YaOUfFcf2d08s4TPE2cvjAsvtE8ya9NXuFXr9g==
X-Received: by 2002:a05:620a:4711:b0:6bb:7e1b:5f0b with SMTP id
 bs17-20020a05620a471100b006bb7e1b5f0bmr33657198qkb.127.1662454866186; 
 Tue, 06 Sep 2022 02:01:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR54SeftazVhGuQR9Denza8esCRyPUSRNGJRsOYWXZ1aLyu1Zb25CEzZerEVP/BwXWQhYQ8KcQ==
X-Received: by 2002:a05:620a:4711:b0:6bb:7e1b:5f0b with SMTP id
 bs17-20020a05620a471100b006bb7e1b5f0bmr33657178qkb.127.1662454865958; 
 Tue, 06 Sep 2022 02:01:05 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 z20-20020ac87cb4000000b0031f36cd1958sm8888786qtv.81.2022.09.06.02.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 02:01:04 -0700 (PDT)
Date: Tue, 6 Sep 2022 11:00:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220906090048.xdwdnxy3dvuos36x@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <20220817025250-mutt-send-email-mst@kernel.org>
 <3abb1be9-b12c-e658-0391-8461e28f1b33@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3abb1be9-b12c-e658-0391-8461e28f1b33@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Liu <wei.liu@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
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

T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMTI6Mjg6NDhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+5ZyoIDIwMjIvOC8xNyAxNDo1NCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPj5P
biBNb24sIEF1ZyAxNSwgMjAyMiBhdCAxMDo1NjowM0FNIC0wNzAwLCBCb2JieSBFc2hsZW1hbiB3
cm90ZToKPj4+SGV5IGV2ZXJ5Ym9keSwKPj4+Cj4+PlRoaXMgc2VyaWVzIGludHJvZHVjZXMgZGF0
YWdyYW1zLCBwYWNrZXQgc2NoZWR1bGluZywgYW5kIHNrX2J1ZmYgdXNhZ2UKPj4+dG8gdmlydGlv
IHZzb2NrLgo+Pj4KPj4+VGhlIHVzYWdlIG9mIHN0cnVjdCBza19idWZmIGJlbmVmaXRzIHVzZXJz
IGJ5IGEpIHByZXBhcmluZyB2c29jayB0byB1c2UKPj4+b3RoZXIgcmVsYXRlZCBzeXN0ZW1zIHRo
YXQgcmVxdWlyZSBza19idWZmLCBzdWNoIGFzIHNvY2ttYXAgYW5kIHFkaXNjLAo+Pj5iKSBzdXBw
b3J0aW5nIGJhc2ljIGNvbmdlc3Rpb24gY29udHJvbCB2aWEgc29ja19hbGxvY19zZW5kX3NrYiwg
YW5kIGMpCj4+PnJlZHVjaW5nIGNvcHlpbmcgd2hlbiBkZWxpdmVyaW5nIHBhY2tldHMgdG8gVEFQ
Lgo+Pj4KPj4+VGhlIHNvY2tldCBsYXllciBubyBsb25nZXIgZm9yY2VzIGVycm9ycyB0byBiZSAt
RU5PTUVNLCBhcyB0eXBpY2FsbHkKPj4+dXNlcnNwYWNlIGV4cGVjdHMgLUVBR0FJTiB3aGVuIHRo
ZSBza19zbmRidWYgdGhyZXNob2xkIGlzIHJlYWNoZWQgYW5kCj4+Pm1lc3NhZ2VzIGFyZSBiZWlu
ZyBzZW50IHdpdGggb3B0aW9uIE1TR19ET05UV0FJVC4KPj4+Cj4+PlRoZSBkYXRhZ3JhbSB3b3Jr
IGlzIGJhc2VkIG9mZiBwcmV2aW91cyBwYXRjaGVzIGJ5IEppYW5nIFdhbmdbMV0uCj4+Pgo+Pj5U
aGUgaW50cm9kdWN0aW9uIG9mIGRhdGFncmFtcyBjcmVhdGVzIGEgdHJhbnNwb3J0IGxheWVyIGZh
aXJuZXNzIGlzc3VlCj4+PndoZXJlIGRhdGFncmFtcyBtYXkgZnJlZWx5IHN0YXJ2ZSBzdHJlYW1z
IG9mIHF1ZXVlIGFjY2Vzcy4gVGhpcyBoYXBwZW5zCj4+PmJlY2F1c2UsIHVubGlrZSBzdHJlYW1z
LCBkYXRhZ3JhbXMgbGFjayB0aGUgdHJhbnNhY3Rpb25zIG5lY2Vzc2FyeSBmb3IKPj4+Y2FsY3Vs
YXRpbmcgY3JlZGl0cyBhbmQgdGhyb3R0bGluZy4KPj4+Cj4+PlByZXZpb3VzIHByb3Bvc2FscyBp
bnRyb2R1Y2UgY2hhbmdlcyB0byB0aGUgc3BlYyB0byBhZGQgYW4gYWRkaXRpb25hbAo+Pj52aXJ0
cXVldWUgcGFpciBmb3IgZGF0YWdyYW1zWzFdLiBBbHRob3VnaCB0aGlzIHNvbHV0aW9uIHdvcmtz
LCB1c2luZwo+Pj5MaW51eCdzIHFkaXNjIGZvciBwYWNrZXQgc2NoZWR1bGluZyBsZXZlcmFnZXMg
YWxyZWFkeSBleGlzdGluZyBzeXN0ZW1zLAo+Pj5hdm9pZHMgdGhlIG5lZWQgdG8gY2hhbmdlIHRo
ZSB2aXJ0aW8gc3BlY2lmaWNhdGlvbiwgYW5kIGdpdmVzIGFkZGl0aW9uYWwKPj4+Y2FwYWJpbGl0
aWVzLiBUaGUgdXNhZ2Ugb2YgU0ZRIG9yIGZxX2NvZGVsLCBmb3IgZXhhbXBsZSwgbWF5IHNvbHZl
IHRoZQo+Pj50cmFuc3BvcnQgbGF5ZXIgc3RhcnZhdGlvbiBwcm9ibGVtLiBJdCBpcyBlYXN5IHRv
IGltYWdpbmUgb3RoZXIgdXNlCj4+PmNhc2VzIGFzIHdlbGwuIEZvciBleGFtcGxlLCBzZXJ2aWNl
cyBvZiB2YXJ5aW5nIGltcG9ydGFuY2UgbWF5IGJlCj4+PmFzc2lnbmVkIGRpZmZlcmVudCBwcmlv
cml0aWVzLCBhbmQgcWRpc2Mgd2lsbCBhcHBseSBhcHByb3ByaWF0ZQo+Pj5wcmlvcml0eS1iYXNl
ZCBzY2hlZHVsaW5nLiBCeSBkZWZhdWx0LCB0aGUgc3lzdGVtIGRlZmF1bHQgcGZpZm8gcWRpc2Mg
aXMKPj4+dXNlZC4gVGhlIHFkaXNjIG1heSBiZSBieXBhc3NlZCBhbmQgbGVnYWN5IHF1ZXVpbmcg
aXMgcmVzdW1lZCBieSBzaW1wbHkKPj4+c2V0dGluZyB0aGUgdmlydGlvLXZzb2NrJWQgbmV0d29y
ayBkZXZpY2UgdG8gc3RhdGUgRE9XTi4gVGhpcyB0ZWNobmlxdWUKPj4+c3RpbGwgYWxsb3dzIHZz
b2NrIHRvIHdvcmsgd2l0aCB6ZXJvLWNvbmZpZ3VyYXRpb24uCj4+VGhlIGJhc2ljIHF1ZXN0aW9u
IHRvIGFuc3dlciB0aGVuIGlzIHRoaXM6IHdpdGggYSBuZXQgZGV2aWNlIHFkaXNjCj4+ZXRjIGlu
IHRoZSBwaWN0dXJlLCBob3cgaXMgdGhpcyBkaWZmZXJlbnQgZnJvbSB2aXJ0aW8gbmV0IHRoZW4/
Cj4+V2h5IGRvIHlvdSBzdGlsbCB3YW50IHRvIHVzZSB2c29jaz8KPgo+Cj5PciBtYXliZSBpdCdz
IHRpbWUgdG8gcmV2aXNpdCBhbiBvbGQgaWRlYVsxXSB0byB1bmlmeSBhdCBsZWFzdCB0aGUgCj5k
cml2ZXIgcGFydCAoZS5nIHVzaW5nIHZpcnRpby1uZXQgZHJpdmVyIGZvciB2c29jayB0aGVuIHdl
IGNhbiBhbGwgCj5mZWF0dXJlcyB0aGF0IHZzb2NrIGlzIGxhY2tpbmcgbm93KT8KClNvcnJ5IGZv
ciBjb21pbmcgbGF0ZSB0byB0aGUgZGlzY3Vzc2lvbiEKClRoaXMgd291bGQgYmUgZ3JlYXQsIHRo
b3VnaCwgbGFzdCB0aW1lIEkgaGFkIGxvb2tlZCBhdCBpdCwgSSBoYWQgZm91bmQgCml0IHF1aXRl
IGNvbXBsaWNhdGVkLiBUaGUgbWFpbiBwcm9ibGVtIGlzIHRyeWluZyB0byBhdm9pZCBhbGwgdGhl
IApuZXQtc3BlY2lmaWMgc3R1ZmYgKE1UVSwgZXRoZXJuZXQgaGVhZGVyLCBIVyBvZmZsb2FkaW5n
LCBldGMuKS4KCk1heWJlIHdlIGNvdWxkIHN0YXJ0IHRoaW5raW5nIGFib3V0IHRoaXMgaWRlYSBi
eSBhZGRpbmcgYSBuZXcgdHJhbnNwb3J0IAp0byB2c29jayAoZS5nLiB2aXJ0aW8tbmV0LXZzb2Nr
KSBjb21wbGV0ZWx5IHNlcGFyYXRlIGZyb20gd2hhdCB3ZSBoYXZlIApub3cuCgpUaGFua3MsClN0
ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
