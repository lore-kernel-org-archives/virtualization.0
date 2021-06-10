Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80299C48BCD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB80613F1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB80613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E99F640225;
	Thu, 10 Jun 2021 07:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dpDhLfkrZf2; Thu, 10 Jun 2021 07:24:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75D7240025;
	Thu, 10 Jun 2021 07:24:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F3B3C000E;
	Thu, 10 Jun 2021 07:24:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E69DC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1831D607D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ATXDOKdTMNy3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:24:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BD73607A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 07:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623309850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tlPw+fNQnyyXsv0Z5PViUY/ZrTm7CI6pUHe7QloYKE=;
 b=J4mBUiOt/jssPXAdNk3+VAeOAA95bSb4vXliINdKAnulUVFXgwOGWHDLHkgG6SchhwABKN
 AVjiLOGv+O1MivD1lEbXAcfhMHMGaca1uP9tdksYiinvY3eBg+pArWtb0ZquMziy/ebhKU
 sHCvZmIbS9cOPXjfYb72DAjfg1zJec0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-ZQXvCzBDP6yLdfv-s3Fd5Q-1; Thu, 10 Jun 2021 03:24:02 -0400
X-MC-Unique: ZQXvCzBDP6yLdfv-s3Fd5Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 f12-20020a056402150cb029038fdcfb6ea2so13676546edw.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 00:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5tlPw+fNQnyyXsv0Z5PViUY/ZrTm7CI6pUHe7QloYKE=;
 b=tQOZyfh6LZJQKufpyrAYU0vF1cxnYHiKxrH84kjft/PuCRSBWOCvKLDYQbk2NVsZkh
 wjcxsQO/gqTuvnp9fRF/gXdZBwwZ6fObrZTA7mH3w6no5MPQNXvldbkRth085OJW2kkG
 +yloYTEDak/UBx2ZKdD5+dgE96b06l8lUmJYaFoNWhnP7Rx0I9wX9yiiZpUEruFtbcp5
 Ppy7F5GDbvCfZy8f62i/xoo9J67eHFNDJ/Nk303u3rXNd6d3qQM9XdluLYNnAeTfxHw3
 +keAluC6uJpnUXvuqxHnRMlp4tEQIgfSxwSGg/ci7XvVWD9fxd+Xrs8FpIt52c3JwxqN
 Ny6Q==
X-Gm-Message-State: AOAM531eRJgmmg60T53mJOcRkAFNZwQej+Q6wkRdnKJeyPETDLF5VEPP
 /oNsRH7vQ3cyoMXg0sMKqcIUJIp4YbYA4aR6RDcccvGScTeRRUuj2sRb2ZVIgytIRpzrqeGQR0A
 lyWKqnGmcc53+dT2+a1jq+kX/jmup13qjcS03wB0k8Q==
X-Received: by 2002:a05:6402:31a2:: with SMTP id
 dj2mr3327560edb.206.1623309841253; 
 Thu, 10 Jun 2021 00:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQjjBWn2tn5Hz5WlWbOxelGasgbyypBGGNi74+KR/G3TdCo5Fjc4YzbciAEeQef5nBrmemKQ==
X-Received: by 2002:a05:6402:31a2:: with SMTP id
 dj2mr3327543edb.206.1623309841108; 
 Thu, 10 Jun 2021 00:24:01 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id o21sm651992ejg.49.2021.06.10.00.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 00:24:00 -0700 (PDT)
Date: Thu, 10 Jun 2021 09:23:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
Message-ID: <20210610072358.3fuvsahxec2sht4y@steredhat>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
 <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
 <ac0c241c-1013-1304-036f-504d0edc5fd7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ac0c241c-1013-1304-036f-504d0edc5fd7@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 Yongji Xie <xieyongji@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexander Popov <alex.popov@linux.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Jiang Wang ." <jiang.wang@bytedance.com>, Networking <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

T24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMTI6MDI6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+5ZyoIDIwMjEvNi8xMCDkuIrljYgxMTo0MywgSmlhbmcgV2FuZyAuIOWGmemBkzoKPj5P
biBXZWQsIEp1biA5LCAyMDIxIGF0IDY6NTEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+Pgo+Pj7lnKggMjAyMS82LzEwIOS4iuWNiDc6MjQsIEppYW5nIFdhbmcg
5YaZ6YGTOgo+Pj4+VGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2YgU09DS19ER1JB
TSBmb3IgdmlydGlvCj4+Pj50cmFuc3BvcnQuCj4+Pj4KPj4+PkRhdGFncmFtIHNvY2tldHMgYXJl
IGNvbm5lY3Rpb25sZXNzIGFuZCB1bnJlbGlhYmxlLiBUbyBhdm9pZCB1bmZhaXIgY29udGVudGlv
bgo+Pj4+d2l0aCBzdHJlYW0gYW5kIG90aGVyIHNvY2tldHMsIGFkZCB0d28gbW9yZSB2aXJ0cXVl
dWVzIGFuZAo+Pj4+YSBuZXcgZmVhdHVyZSBiaXQgdG8gaW5kaWNhdGUgaWYgdGhvc2UgdHdvIG5l
dyBxdWV1ZXMgZXhpc3Qgb3Igbm90Lgo+Pj4+Cj4+Pj5EZ3JhbSBkb2VzIG5vdCB1c2UgdGhlIGV4
aXN0aW5nIGNyZWRpdCB1cGRhdGUgbWVjaGFuaXNtIGZvcgo+Pj4+c3RyZWFtIHNvY2tldHMuIFdo
ZW4gc2VuZGluZyBmcm9tIHRoZSBndWVzdC9kcml2ZXIsIHNlbmRpbmcgcGFja2V0cwo+Pj4+c3lu
Y2hyb25vdXNseSwgc28gdGhlIHNlbmRlciB3aWxsIGdldCBhbiBlcnJvciB3aGVuIHRoZSB2aXJ0
cXVldWUgaXMgCj4+Pj5mdWxsLgo+Pj4+V2hlbiBzZW5kaW5nIGZyb20gdGhlIGhvc3QvZGV2aWNl
LCBzZW5kIHBhY2tldHMgYXN5bmNocm9ub3VzbHkKPj4+PmJlY2F1c2UgdGhlIGRlc2NyaXB0b3Ig
bWVtb3J5IGJlbG9uZ3MgdG8gdGhlIGNvcnJlc3BvbmRpbmcgUUVNVQo+Pj4+cHJvY2Vzcy4KPj4+
Cj4+PldoYXQncyB0aGUgdXNlIGNhc2UgZm9yIHRoZSBkYXRhZ3JhbSB2c29jaz8KPj4+Cj4+T25l
IHVzZSBjYXNlIGlzIGZvciBub24gY3JpdGljYWwgaW5mbyBsb2dnaW5nIGZyb20gdGhlIGd1ZXN0
Cj4+dG8gdGhlIGhvc3QsIHN1Y2ggYXMgdGhlIHBlcmZvcm1hbmNlIGRhdGEgb2Ygc29tZSBhcHBs
aWNhdGlvbnMuCj4KPgo+QW55dGhpbmcgdGhhdCBwcmV2ZW50cyB5b3UgZnJvbSB1c2luZyB0aGUg
c3RyZWFtIHNvY2tldD8KPgo+Cj4+Cj4+SXQgY2FuIGFsc28gYmUgdXNlZCB0byByZXBsYWNlIFVE
UCBjb21tdW5pY2F0aW9ucyBiZXR3ZWVuCj4+dGhlIGd1ZXN0IGFuZCB0aGUgaG9zdC4KPgo+Cj5B
bnkgYWR2YW50YWdlIGZvciBWU09DSyBpbiB0aGlzIGNhc2U/IElzIGl0IGZvciBwZXJmb3JtYW5j
ZSAoSSBndWVzcyAKPm5vdCBzaW5jZSBJIGRvbid0IGV4ZXBjdCB2c29jayB3aWxsIGJlIGZhc3Rl
cikuCgpJIHRoaW5rIHRoZSBnZW5lcmFsIGFkdmFudGFnZSB0byB1c2luZyB2c29jayBhcmUgZm9y
IHRoZSBndWVzdCBhZ2VudHMgCnRoYXQgcG90ZW50aWFsbHkgZG9uJ3QgbmVlZCBhbnkgY29uZmln
dXJhdGlvbi4KCj4KPkFuIG9idmlvdXMgZHJhd2JhY2sgaXMgdGhhdCBpdCBicmVha3MgdGhlIG1p
Z3JhdGlvbi4gVXNpbmcgVURQIHlvdSBjYW4gCj5oYXZlIGEgdmVyeSByaWNoIGZlYXR1cmVzIHN1
cHBvcnQgZnJvbSB0aGUga2VybmVsIHdoZXJlIHZzb2NrIGNhbid0Lgo+CgpUaGFua3MgZm9yIGJy
aW5naW5nIHRoaXMgdXAhCldoYXQgZmVhdHVyZXMgZG9lcyBVRFAgc3VwcG9ydCBhbmQgZGF0YWdy
YW0gb24gdnNvY2sgY291bGQgbm90IHN1cHBvcnQ/Cgo+Cj4+Cj4+Pj5UaGUgdmlydGlvIHNwZWMg
cGF0Y2ggaXMgaGVyZToKPj4+Pmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXZp
cnR1YWxpemF0aW9uL21zZzUwMDI3Lmh0bWwKPj4+Cj4+PkhhdmUgYSBxdWljayBnbGFuY2UsIEkg
c3VnZ2VzdCB0byBzcGxpdCBtZXJnZWFibGUgcnggYnVmZmVyIGludG8gYW4KPj4+c2VwYXJhdGUg
cGF0Y2guCj4+U3VyZS4KPj4KPj4+QnV0IEkgdGhpbmsgaXQncyB0aW1lIHRvIHJldmlzaXQgdGhl
IGlkZWEgb2YgdW5pZnlpbmcgdGhlIHZpcnRpby1uZXQgCj4+PmFuZAo+Pj52aXJ0aW8tdnNvY2su
IE90aGVyd2lzZSB3ZSdyZSBkdXBsaWNhdGluZyBmZWF0dXJlcyBhbmQgYnVncy4KPj5Gb3IgbWVy
Z2VhYmxlIHJ4YnVmIHJlbGF0ZWQgY29kZSwgSSB0aGluayBhIHNldCBvZiBjb21tb24gaGVscGVy
Cj4+ZnVuY3Rpb25zIGNhbiBiZSB1c2VkIGJ5IGJvdGggdmlydGlvLW5ldCBhbmQgdmlydGlvLXZz
b2NrLiBGb3Igb3RoZXIKPj5wYXJ0cywgdGhhdCBtYXkgbm90IGJlIHZlcnkgYmVuZWZpY2lhbC4g
SSB3aWxsIHRoaW5rIGFib3V0IG1vcmUuCj4+Cj4+SWYgdGhlcmUgaXMgYSBwcmV2aW91cyBlbWFp
bCBkaXNjdXNzaW9uIGFib3V0IHRoaXMgdG9waWMsIGNvdWxkIHlvdSAKPj5zZW5kIG1lCj4+c29t
ZSBsaW5rcz8gSSBkaWQgYSBxdWljayB3ZWIgc2VhcmNoIGJ1dCBkaWQgbm90IGZpbmQgYW55IHJl
bGF0ZWQKPj5pbmZvLiBUaGFua3MuCj4KPgo+V2UgaGFkIGEgbG90Ogo+Cj5bMV0gCj5odHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qva3ZtL3BhdGNoLzVCREZGNTM3LjMwNTA4MDZA
aHVhd2VpLmNvbS8KPlsyXSAKPmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9waXBl
cm1haWwvdmlydHVhbGl6YXRpb24vMjAxOC1Ob3ZlbWJlci8wMzk3OTguaHRtbAo+WzNdIGh0dHBz
Oi8vd3d3LmxrbWwub3JnL2xrbWwvMjAyMC8xLzE2LzIwNDMKPgoKV2hlbiBJIHRyaWVkIGl0LCB0
aGUgYmlnZ2VzdCBwcm9ibGVtIHRoYXQgYmxvY2tlZCBtZSB3ZXJlIGFsbCB0aGUgCmZlYXR1cmVz
IHN0cmljdGx5IHJlbGF0ZWQgdG8gVENQL0lQIHN0YWNrIGFuZCBldGhlcm5ldCBkZXZpY2VzIHRo
YXQgCnZzb2NrIGRldmljZSBkb2Vzbid0IGtub3cgaG93IHRvIGhhbmRsZTogVFNPLCBHU08sIGNo
ZWNrc3VtcywgTUFDLCBuYXBpLCAKeGRwLCBtaW4gZXRoZXJuZXQgZnJhbWUgc2l6ZSwgTVRVLCBl
dGMuCgpTbyBpbiBteSBvcGluaW9uIHRvIHVuaWZ5IHRoZW0gaXMgbm90IHNvIHNpbXBsZSwgYmVj
YXVzZSB2c29jayBpcyBub3QgCnJlYWxseSBhbiBldGhlcm5ldCBkZXZpY2UsIGJ1dCBzaW1wbHkg
YSBzb2NrZXQuCgpCdXQgSSBmdWxseSBhZ3JlZSB0aGF0IHdlIHNob3VsZG4ndCBkdXBsaWNhdGUg
ZnVuY3Rpb25hbGl0eSBhbmQgY29kZSwgc28gCm1heWJlIHdlIGNvdWxkIGZpbmQgdGhvc2UgY29t
bW9uIHBhcnRzIGFuZCBjcmVhdGUgaGVscGVycyB0byBiZSB1c2VkIGJ5IApib3RoLgoKVGhhbmtz
LApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
