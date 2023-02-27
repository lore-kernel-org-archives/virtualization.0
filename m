Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE226C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 12:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50FE1403E9;
	Mon, 27 Feb 2023 12:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50FE1403E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=QW7wHSpa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBFLXdQzQbeL; Mon, 27 Feb 2023 12:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A579040924;
	Mon, 27 Feb 2023 12:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A579040924
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75251C0033;
	Mon, 27 Feb 2023 12:40:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C649C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 12:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2717A81E39
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 12:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2717A81E39
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=QW7wHSpa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agFFely8M-FO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 12:40:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1C4A81B48
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1C4A81B48
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 12:40:38 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id y10so3417108pfi.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 04:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2jhasNjoy802hJ5uR0TgTEFUPCoR2lDLD3l4YCiU10=;
 b=QW7wHSpafPjwd7TaL6/+tHtP86DxIsIbik99Z/cop3ea1f+RrzBqosm4H3vmFA30lI
 YmsHN6qenC29DXU/HQ3jnGx8SD7JJbXF/Ky/dqmr/dTWDpLd3ZUsMmXwmxAE6W934pmz
 4Qgcuo2iVRLxIGv+g4wcE3qLmpT9gQ4coJTRdnGumpINYXl8mXn+mVrHYE/Y/r53y6wx
 5IzYxpNImD1nXBFXcBeIahdFrH3Zm/S0MmqTDTtHfho8cEGKbthiWVOG6XhMYpUY1Zhi
 Wc78RDevYI5Q7B8869hWX2HaZvvgtlubgAcuQ8i7EPNwxkqcufYKA99vskYotgIAPucW
 kVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2jhasNjoy802hJ5uR0TgTEFUPCoR2lDLD3l4YCiU10=;
 b=DvTkWR9EQDDkwO5H6DXWz08MiX7OLMpeCvIT//WYiQ7LVUOIHmKfAmCWbxVeOLXRMJ
 1x8j4ZNndcmApQBm/0ADVz3FhPqFuOkYZbtz2db9mEmE9tR+KCMJaTmq+10H527G9vIw
 qHS8xUYY6//qYxJi8fPWzlHIuw79iIEonr/O+tJlj+L6ENoWTj0ZOgI0WdFxqtBbhPee
 Ie3lErQgyQEa7Npz4A09M9mLG5YUxP1ff70dDvAFcyQXjPKSEnthKpzUwc5cC1OCV2iH
 +yYEhzii2EVUf1gj8jziQB5zHKk7rKrWqiNJQ7ZDHkS70/KT88XpOJDsWzqh2WALuOn+
 0SIA==
X-Gm-Message-State: AO0yUKVbe7c8diO9POM69Y+F4iUKX/HCaPPtnYKmSBMZauY4tlZpQNcL
 /2ErlQlCG43FZ0uRrImaeeaZ6xFb1fq/SY3loYODEA==
X-Google-Smtp-Source: AK7set/YVkPThBzFKuxa/rdrEXhC1I+scq6HJaE9jiZU7WaOxbb5GKqwj45Rl6til8gIhoy8jWB+6rkrowSffmrJEgg=
X-Received: by 2002:a63:364a:0:b0:4ff:6b33:5a3a with SMTP id
 d71-20020a63364a000000b004ff6b335a3amr5777628pga.2.1677501638125; Mon, 27 Feb
 2023 04:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20230224155438.112797-1-eperezma@redhat.com>
In-Reply-To: <20230224155438.112797-1-eperezma@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 27 Feb 2023 14:40:01 +0200
Message-ID: <CAJs=3_CirpgqNNXxPNmcHmEpmPn01ef9h-Xcinmd_DDtp3Md4Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Dynamically switch to vhost shadow virtqueues at
 vdpa net migration
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

Pgo+IEl0J3MgcG9zc2libGUgdG8gbWlncmF0ZSB2ZHBhIG5ldCBkZXZpY2VzIGlmIHRoZXkgYXJl
IHNoYWRvd2VkIGZyb20gdGhlCj4gc3RhcnQuICBCdXQgdG8gYWx3YXlzIHNoYWRvdyB0aGUgZGF0
YXBsYW5lIGlzIHRvIGVmZmVjdGl2ZWx5IGJyZWFrIGl0cyBob3N0Cj4gcGFzc3Rocm91Z2gsIHNv
IGl0cyBub3QgZWZmaWNpZW50IGluIHZEUEEgc2NlbmFyaW9zLgo+Cj4gVGhpcyBzZXJpZXMgZW5h
YmxlcyBkeW5hbWljYWxseSBzd2l0Y2hpbmcgdG8gc2hhZG93IG1vZGUgb25seSBhdAo+IG1pZ3Jh
dGlvbiB0aW1lLiAgVGhpcyBhbGxvd3MgZnVsbCBkYXRhIHZpcnRxdWV1ZXMgcGFzc3Rocm91Z2gg
YWxsIHRoZQo+IHRpbWUgcWVtdSBpcyBub3QgbWlncmF0aW5nLgo+Cj4gSW4gdGhpcyBzZXJpZXMg
b25seSBuZXQgZGV2aWNlcyB3aXRoIG5vIENWUSBhcmUgbWlncmF0YWJsZS4gIENWUSBhZGRzCj4g
YWRkaXRpb25hbCBzdGF0ZSB0aGF0IHdvdWxkIG1ha2UgdGhlIHNlcmllcyBiaWdnZXIgYW5kIHN0
aWxsIGhhZCBzb21lCj4gY29udHJvdmVyc3kgb24gcHJldmlvdXMgUkZDLCBzbyBsZXQncyBzcGxp
dCBpdC4KPgo+IFN1Y2Nlc3NmdWxseSB0ZXN0ZWQgd2l0aCB2ZHBhX3NpbV9uZXQgd2l0aCBwYXRj
aCBbMV0gYXBwbGllZCBhbmQgd2l0aCB0aGUgcWVtdQo+IGVtdWxhdGVkIGRldmljZSB3aXRoIHZw
X3ZkcGEgd2l0aCBzb21lIHJlc3RyaWN0aW9uczoKPiAqIE5vIENWUS4gTm8gZmVhdHVyZSB0aGF0
IGRpZG4ndCB3b3JrIHdpdGggU1ZRIHByZXZpb3VzbHkgKHBhY2tlZCwgLi4uKQo+ICogVklSVElP
X1JJTkdfRl9TVEFURSBwYXRjaGVzIGltcGxlbWVudGluZyBbMl0uCj4gKiBFeHBvc2UgX0ZfU1VT
UEVORCwgYnV0IGlnbm9yZSBpdCBhbmQgc3VzcGVuZCBvbiByaW5nIHN0YXRlIGZldGNoIGxpa2UK
PiAgIERQREsuCj4KPiBQcmV2aW91cyB2ZXJzaW9ucyB3ZXJlIHRlc3RlZCBieSBtYW55IHZlbmRv
cnMuIE5vdCBjYXJyeWluZyBUZXN0ZWQtYnkgYmVjYXVzZQo+IG9mIGNvZGUgY2hhbmdlcywgc28g
cmUtdGVzdGluZyB3b3VsZCBiZSBhcHByZWNpYXRlZC4KPgo+IENvbW1lbnRzIGFyZSB3ZWxjb21l
Lgo+Cj4gdjQ6Cj4gLSBSZWNvdmVyIHVzZWRfaWR4IGZyb20gZ3Vlc3QncyB2cmluZyBpZiBkZXZp
Y2UgY2Fubm90IHN1c3BlbmQuCj4gLSBGaXggc3RhcnRpbmcgZGV2aWNlIGluIHRoZSBtaWRkbGUg
b2YgYSBtaWdyYXRpb24uICBSZW1vdmVkIHNvbWUKPiAgIGR1cGxpY2F0aW9uIGluIHNldHRpbmcg
LyBjbGVhcmluZyBlbmFibGVfc2hhZG93X3ZxcyBhbmQgc2hhZG93X2RhdGEKPiAgIG1lbWJlcnMg
b2Ygdmhvc3RfdmRwYS4KPiAtIEZpeCAoYWdhaW4pICJDaGVjayBmb3IgU1VTUEVORCBpbiB2aG9z
dF9kZXYuYmFja2VuZF9jYXAsIGFzCj4gICAuYmFja2VuZF9mZWF0dXJlcyBpcyBlbXB0eSBhdCB0
aGUgY2hlY2sgbW9tZW50LiIuIEl0IHdhcyByZXZlcnRlZCBieQo+ICAgbWlzdGFrZSBpbiB2My4K
PiAtIEZpeCBtZW1vcnkgbGVhayBvZiBpb3ZhIHRyZWUuCj4gLSBQcm9wZXJseSByZXdpbmQgU1ZR
IGFzIGluIGZsaWdodCBkZXNjcmlwdG9ycyB3ZXJlIHN0aWxsIGJlaW5nIGFjY291bnRlZAo+ICAg
aW4gdnEgYmFzZS4KPiAtIEV4cGFuZCBkb2N1bWVudGF0aW9uLgo+Cj4gdjM6Cj4gLSBTdGFydCBk
YXRhcGF0Y2ggaW4gU1ZRIGluIGRldmljZSBzdGFydGVkIHdoaWxlIG1pZ3JhdGluZy4KPiAtIFBy
b3Blcmx5IHJlZ2lzdGVyIG1pZ3JhdGlvbiBibG9ja2VycyBpZiBkZXZpY2UgcHJlc2VudCB1bnN1
cHBvcnRlZCBmZWF0dXJlcy4KPiAtIEZpeCByYWNlIGNvbmRpdGlvbiBiZWNhdXNlIG9mIG5vdCBz
dG9wcGluZyB0aGUgU1ZRIHVudGlsIGRldmljZSBjbGVhbnVwLgo+IC0gRXhwbGFpbiBwdXJwb3Nl
IG9mIGlvdmEgdHJlZSBpbiB0aGUgZmlyc3QgcGF0Y2ggbWVzc2FnZS4KPiAtIHMvZHluYW15Y2Fs
bHkvZHluYW1pY2FsbHkvIGluIGNvdmVyIGxldHRlci4KPiAtIGF0IGxvcmUua2VybmVsLm9yZy9x
ZW11LWRldmVsLzIwMjMwMjE1MTczODUwLjI5ODgzMi0xNC1lcGVyZXptYUByZWRoYXQuY29tCj4K
PiB2MjoKPiAtIENoZWNrIGZvciBTVVNQRU5EIGluIHZob3N0X2Rldi5iYWNrZW5kX2NhcCwgYXMg
LmJhY2tlbmRfZmVhdHVyZXMgaXMgZW1wdHkgYXQKPiAgIHRoZSBjaGVjayBtb21lbnQuCj4gLSBh
dCBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMDgwOTQyNTMuNzAyNjcyLTEyLWVw
ZXJlem1hQHJlZGhhdC5jb20vVC8KPgo+IHYxOgo+IC0gT21pdCBhbGwgY29kZSB3b3JraW5nIHdp
dGggQ1ZRIGFuZCBibG9jayBtaWdyYXRpb24gaWYgdGhlIGRldmljZSBzdXBwb3J0cwo+ICAgQ1ZR
Lgo+IC0gUmVtb3ZlIHNwdXJpb3VzIGtpY2suCj4gLSBNb3ZlIGFsbCBwb3NzaWJsZSBjaGVja3Mg
Zm9yIG1pZ3JhdGlvbiB0byB2aG9zdC12ZHBhIGluc3RlYWQgb2YgdGhlIG5ldAo+ICAgYmFja2Vu
ZC4gTW92ZSB0aGVtIHRvIGluaXQgY29kZSBmcm9tIHN0YXJ0IGNvZGUuCj4gLSBTdXNwZW5kIG9u
IHZob3N0X3ZkcGFfZGV2X3N0YXJ0KGZhbHNlKSBpbnN0ZWFkIG9mIGluIHZob3N0LXZkcGEgbmV0
IGJhY2tlbmQuCj4gLSBQcm9wZXJseSBzcGxpdCBzdXNwZW5kIGFmdGVyIGdldGluZyBiYXNlIGFu
ZCBhZGRpbmcgb2Ygc3RhdHVzX3Jlc2V0IHBhdGNoZXMuCj4gLSBBZGQgcG9zc2libGUgVE9ET3Mg
dG8gcG9pbnRzIHdoZXJlIHRoaXMgc2VyaWVzIGNhbiBpbXByb3ZlIGluIHRoZSBmdXR1cmUuCj4g
LSBDaGVjayB0aGUgc3RhdGUgb2YgbWlncmF0aW9uIHVzaW5nIG1pZ3JhdGlvbl9pbl9zZXR1cCBh
bmQKPiAgIG1pZ3JhdGlvbl9oYXNfZmFpbGVkIGluc3RlYWQgb2YgY2hlY2tpbmcgYWxsIHRoZSBw
b3NzaWJsZSBtaWdyYXRpb24gc3RhdHVzIGluCj4gICBhIHN3aXRjaC4KPiAtIEFkZCBUT0RPIHdp
dGggcG9zc2libGUgbG93IGhhbmQgZnJ1aXQgdXNpbmcgUkVTVU1FIG9wcy4KPiAtIEFsd2F5cyBv
ZmZlciBfRl9MT0cgZnJvbSB2aXJ0aW8vdmhvc3QtdmRwYSBhbmQgbGV0IG1pZ3JhdGlvbiBibG9j
a2VycyBkbwo+ICAgdGhlaXIgdGhpbmcgaW5zdGVhZCBvZiBhZGRpbmcgYSB2YXJpYWJsZS4KPiAt
IFJGQyB2MiBhdCBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAyMy0wMS9tc2cwMjU3NC5odG1sCj4KPiBSRkMgdjI6Cj4gLSBVc2UgYSBtaWdyYXRpb24gbGlz
dGVuZXIgaW5zdGVhZCBvZiBhIG1lbW9yeSBsaXN0ZW5lciB0byBrbm93IHdoZW4KPiAgIHRoZSBt
aWdyYXRpb24gc3RhcnRzLgo+IC0gQWRkIHN0dWZmIG5vdCBwaWNrZWQgd2l0aCBBU0lEIHBhdGNo
ZXMsIGxpa2UgZW5hYmxlIHJpbmdzIGFmdGVyCj4gICBkcml2ZXJfb2sKPiAtIEFkZCByZXdpbmRp
bmcgb24gdGhlIG1pZ3JhdGlvbiBzcmMsIG5vdCBpbiBkc3QKPiAtIFJGQyB2MSBhdCBodHRwczov
L2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMi0wOC9tc2cwMTY2NC5o
dG1sCj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDIwMzE0MjUwMS4z
MDAxMjUtMS1lcGVyZXptYUByZWRoYXQuY29tL1QvCj4gWzJdIGh0dHBzOi8vbGlzdHMub2FzaXMt
b3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMTAzL21zZzAwMDM2Lmh0bWwKPgo+
IEV1Z2VuaW8gUMOpcmV6ICgxNSk6Cj4gICB2ZHBhIG5ldDogbW92ZSBpb3ZhIHRyZWUgY3JlYXRp
b24gZnJvbSBpbml0IHRvIHN0YXJ0Cj4gICB2ZHBhOiBSZW1lbWJlciBsYXN0IGNhbGwgZmQgc2V0
Cj4gICB2ZHBhOiBzdG9wIHN2cSBhdCB2aG9zdF92ZHBhX2Rldl9zdGFydChmYWxzZSkKPiAgIHZk
cGE6IE5lZ290aWF0ZSBfRl9TVVNQRU5EIGZlYXR1cmUKPiAgIHZkcGE6IG1vdmUgdmhvc3QgcmVz
ZXQgYWZ0ZXIgZ2V0IHZyaW5nIGJhc2UKPiAgIHZkcGE6IGFkZCB2aG9zdF92ZHBhLT5zdXNwZW5k
ZWQgcGFyYW1ldGVyCj4gICB2ZHBhOiBhZGQgdmhvc3RfdmRwYV9zdXNwZW5kCj4gICB2ZHBhOiBy
ZXdpbmQgYXQgZ2V0X2Jhc2UsIG5vdCBzZXRfYmFzZQo+ICAgdmRwYTogYWRkIHZkcGEgbmV0IG1p
Z3JhdGlvbiBzdGF0ZSBub3RpZmllcgo+ICAgdmRwYTogZGlzYWJsZSBSQU0gYmxvY2sgZGlzY2Fy
ZCBvbmx5IGZvciB0aGUgZmlyc3QgZGV2aWNlCj4gICB2ZHBhIG5ldDogYmxvY2sgbWlncmF0aW9u
IGlmIHRoZSBkZXZpY2UgaGFzIENWUQo+ICAgdmRwYTogYmxvY2sgbWlncmF0aW9uIGlmIGRldmlj
ZSBoYXMgdW5zdXBwb3J0ZWQgZmVhdHVyZXMKPiAgIHZkcGE6IGJsb2NrIG1pZ3JhdGlvbiBpZiBT
VlEgZG9lcyBub3QgYWRtaXQgYSBmZWF0dXJlCj4gICB2ZHBhIG5ldDogYWxsb3cgVkhPU1RfRl9M
T0dfQUxMCj4gICB2ZHBhOiByZXR1cm4gVkhPU1RfRl9MT0dfQUxMIGluIHZob3N0LXZkcGEgZGV2
aWNlcwo+Cj4gIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0LWJhY2tlbmQuaCAgfCAgIDQgKwo+ICBp
bmNsdWRlL2h3L3ZpcnRpby92aG9zdC12ZHBhLmggICAgIHwgICAzICsKPiAgaHcvdmlydGlvL3Zo
b3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8ICAgOCArLQo+ICBody92aXJ0aW8vdmhvc3QtdmRwYS5j
ICAgICAgICAgICAgIHwgMTI4ICsrKysrKysrKysrKystLS0tLS0KPiAgaHcvdmlydGlvL3Zob3N0
LmMgICAgICAgICAgICAgICAgICB8ICAgMyArCj4gIG5ldC92aG9zdC12ZHBhLmMgICAgICAgICAg
ICAgICAgICAgfCAxOTggKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiAgaHcvdmlydGlv
L3RyYWNlLWV2ZW50cyAgICAgICAgICAgICB8ICAgMSArCj4gIDcgZmlsZXMgY2hhbmdlZCwgMjcz
IGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQo+Cj4gLS0KClRoZSBtaWdyYXRpb24gd29y
a3Mgd2l0aCBTb2xpZE5FVCBEUFUuCgpUZXN0ZWQtYnk6IEFsdmFybyBLYXJzeiA8YWx2YXJvLmth
cnN6QHNvbGlkLXJ1bi5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
