Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57902C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 09:52:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19727613C1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 09:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19727613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E321B831AC;
	Thu, 10 Jun 2021 09:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZ13FhLSAkOl; Thu, 10 Jun 2021 09:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7371A82DD9;
	Thu, 10 Jun 2021 09:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC93C000D;
	Thu, 10 Jun 2021 09:52:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFE8C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8285782E04
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E6si6JJKYnA4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66FA682DD9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623318752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTD4X05DmvXZmZ+nk5ppfERwzEcj05YeBZi3dJeI59Y=;
 b=SUychBZxmQSiiznRwx0mrai2CIVgELSuVrMg2aDfg1ZuoTay3w2dG7J/zXn3R84hkx//3T
 RD3euzstFVUL36SHvd7I248Guxx5+f03gd0vn0lGpU2N2gfnASDU7nNzlyE2c0AMLNbJdg
 fJfRVxVLbNOVsh9RcTMYMH3rMSGgtyk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-lWqBmxkaNMWQNjv2qvyQWA-1; Thu, 10 Jun 2021 05:51:56 -0400
X-MC-Unique: lWqBmxkaNMWQNjv2qvyQWA-1
Received: by mail-ed1-f72.google.com with SMTP id
 s25-20020aa7c5590000b0290392e051b029so8887346edr.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oTD4X05DmvXZmZ+nk5ppfERwzEcj05YeBZi3dJeI59Y=;
 b=lccCkdY483rJRU4H9ubhybo+x1CRDmNKAZnsnt/8Om6YA5EM3vc8iPUV+9D5LG2EFb
 BrccqWMKAYELdvRm9PTqSlj3wY3+dnuCBXWtD0j0gr6ISF2tERqS3nrH13AAY7CDyMAI
 NrBTL6qfRzvGZ0Z/wBUb58LaVNZ7XCR4o8LsfUu0w2yMclkkPczjnn9MbJCP4hR3zQZW
 DzaGwmiSGkkGrr6WH4j7+eYEZ4o7QFDUiAL1QED9mJYiP4iqgvLSlXcQL2TU+VnNMhzN
 dQecxdagrhpUQiC8vw60TKGzCYrReQJ25/We1sBzqTGUnxSBF6TcS/pstvLw3GVJzuJf
 +MKg==
X-Gm-Message-State: AOAM533MxQylb7ST7oNxbASuzgzQpiCWX3DQQYEAs40FBu7GGJDz0zas
 4zl2+8fKx/WRFfKopkzOoIzPYGUzav7GfzA1/zNsRJ1JY/JK6tcegLx+xR9KZc2vjdnse2dF4ux
 JYuQQI7Gse7555C0Z/9y3siuS0430c8aVGal1I7Q5Fg==
X-Received: by 2002:a17:906:546:: with SMTP id k6mr3667879eja.53.1623318714865; 
 Thu, 10 Jun 2021 02:51:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAt+GEShJ3nyodJQl9prURDNMT3FZNtNtpzfzWl5Wsj4as49iUo+FaYaGvMJnyLT6U5H9b0g==
X-Received: by 2002:a17:906:546:: with SMTP id k6mr3667844eja.53.1623318714647; 
 Thu, 10 Jun 2021 02:51:54 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id h19sm804248ejy.82.2021.06.10.02.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 02:51:54 -0700 (PDT)
Date: Thu, 10 Jun 2021 11:51:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
Message-ID: <20210610095151.2cpyny56kbotzppp@steredhat>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
 <CAP_N_Z_VDd+JUJ_Y-peOEc7FgwNGB8O3uZpVumQT_DbW62Jpjw@mail.gmail.com>
 <ac0c241c-1013-1304-036f-504d0edc5fd7@redhat.com>
 <20210610072358.3fuvsahxec2sht4y@steredhat>
 <47ce307b-f95e-25c7-ed58-9cd1cbff5b57@redhat.com>
MIME-Version: 1.0
In-Reply-To: <47ce307b-f95e-25c7-ed58-9cd1cbff5b57@redhat.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>, Networking <netdev@vger.kernel.org>,
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

T24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMDM6NDY6NTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+5ZyoIDIwMjEvNi8xMCDkuIvljYgzOjIzLCBTdGVmYW5vIEdhcnphcmVsbGEg5YaZ6YGT
Ogo+Pk9uIFRodSwgSnVuIDEwLCAyMDIxIGF0IDEyOjAyOjM1UE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pgo+Pj7lnKggMjAyMS82LzEwIOS4iuWNiDExOjQzLCBKaWFuZyBXYW5nIC4g5YaZ
6YGTOgo+Pj4+T24gV2VkLCBKdW4gOSwgMjAyMSBhdCA2OjUxIFBNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pgo+Pj4+PuWcqCAyMDIxLzYvMTAg5LiK5Y2INzoy
NCwgSmlhbmcgV2FuZyDlhpnpgZM6Cj4+Pj4+PlRoaXMgcGF0Y2hzZXQgaW1wbGVtZW50cyBzdXBw
b3J0IG9mIFNPQ0tfREdSQU0gZm9yIHZpcnRpbwo+Pj4+Pj50cmFuc3BvcnQuCj4+Pj4+Pgo+Pj4+
Pj5EYXRhZ3JhbSBzb2NrZXRzIGFyZSBjb25uZWN0aW9ubGVzcyBhbmQgdW5yZWxpYWJsZS4gVG8g
YXZvaWQgCj4+Pj4+PnVuZmFpciBjb250ZW50aW9uCj4+Pj4+PndpdGggc3RyZWFtIGFuZCBvdGhl
ciBzb2NrZXRzLCBhZGQgdHdvIG1vcmUgdmlydHF1ZXVlcyBhbmQKPj4+Pj4+YSBuZXcgZmVhdHVy
ZSBiaXQgdG8gaW5kaWNhdGUgaWYgdGhvc2UgdHdvIG5ldyBxdWV1ZXMgZXhpc3Qgb3Igbm90Lgo+
Pj4+Pj4KPj4+Pj4+RGdyYW0gZG9lcyBub3QgdXNlIHRoZSBleGlzdGluZyBjcmVkaXQgdXBkYXRl
IG1lY2hhbmlzbSBmb3IKPj4+Pj4+c3RyZWFtIHNvY2tldHMuIFdoZW4gc2VuZGluZyBmcm9tIHRo
ZSBndWVzdC9kcml2ZXIsIHNlbmRpbmcgcGFja2V0cwo+Pj4+Pj5zeW5jaHJvbm91c2x5LCBzbyB0
aGUgc2VuZGVyIHdpbGwgZ2V0IGFuIGVycm9yIHdoZW4gdGhlIAo+Pj4+Pj52aXJ0cXVldWUgaXMg
ZnVsbC4KPj4+Pj4+V2hlbiBzZW5kaW5nIGZyb20gdGhlIGhvc3QvZGV2aWNlLCBzZW5kIHBhY2tl
dHMgYXN5bmNocm9ub3VzbHkKPj4+Pj4+YmVjYXVzZSB0aGUgZGVzY3JpcHRvciBtZW1vcnkgYmVs
b25ncyB0byB0aGUgY29ycmVzcG9uZGluZyBRRU1VCj4+Pj4+PnByb2Nlc3MuCj4+Pj4+Cj4+Pj4+
V2hhdCdzIHRoZSB1c2UgY2FzZSBmb3IgdGhlIGRhdGFncmFtIHZzb2NrPwo+Pj4+Pgo+Pj4+T25l
IHVzZSBjYXNlIGlzIGZvciBub24gY3JpdGljYWwgaW5mbyBsb2dnaW5nIGZyb20gdGhlIGd1ZXN0
Cj4+Pj50byB0aGUgaG9zdCwgc3VjaCBhcyB0aGUgcGVyZm9ybWFuY2UgZGF0YSBvZiBzb21lIGFw
cGxpY2F0aW9ucy4KPj4+Cj4+Pgo+Pj5Bbnl0aGluZyB0aGF0IHByZXZlbnRzIHlvdSBmcm9tIHVz
aW5nIHRoZSBzdHJlYW0gc29ja2V0Pwo+Pj4KPj4+Cj4+Pj4KPj4+Pkl0IGNhbiBhbHNvIGJlIHVz
ZWQgdG8gcmVwbGFjZSBVRFAgY29tbXVuaWNhdGlvbnMgYmV0d2Vlbgo+Pj4+dGhlIGd1ZXN0IGFu
ZCB0aGUgaG9zdC4KPj4+Cj4+Pgo+Pj5BbnkgYWR2YW50YWdlIGZvciBWU09DSyBpbiB0aGlzIGNh
c2U/IElzIGl0IGZvciBwZXJmb3JtYW5jZSAoSSAKPj4+Z3Vlc3Mgbm90IHNpbmNlIEkgZG9uJ3Qg
ZXhlcGN0IHZzb2NrIHdpbGwgYmUgZmFzdGVyKS4KPj4KPj5JIHRoaW5rIHRoZSBnZW5lcmFsIGFk
dmFudGFnZSB0byB1c2luZyB2c29jayBhcmUgZm9yIHRoZSBndWVzdCAKPj5hZ2VudHMgdGhhdCBw
b3RlbnRpYWxseSBkb24ndCBuZWVkIGFueSBjb25maWd1cmF0aW9uLgo+Cj4KPlJpZ2h0LCBJIHdv
bmRlciBpZiB3ZSByZWFsbHkgbmVlZCBkYXRhZ3JhbSBjb25zaWRlciB0aGUgaG9zdCB0byBndWVz
dCAKPmNvbW11bmljYXRpb24gaXMgcmVsaWFibGUuCj4KPihOb3RlIHRoYXQgSSBkb24ndCBvYmpl
Y3QgaXQgc2luY2UgdnNvY2sgaGFzIGFscmVhZHkgc3VwcG9ydGVkIHRoYXQsIAo+anVzdCB3b25k
ZXIgaXRzIHVzZSBjYXNlcykKClllcCwgaXQgd2FzIHRoZSBzYW1lIGNvbmNlcm4gSSBoYWQgOi0p
CkFsc28gYmVjYXVzZSB3ZSdyZSBub3cgYWRkaW5nIFNFUVBBQ0tFVCwgd2hpY2ggcHJvdmlkZXMg
cmVsaWFibGUgCmRhdGFncmFtIHN1cHBvcnQuCgpCdXQgSUlVQyB0aGUgdXNlIGNhc2UgaXMgdGhl
IGxvZ2dpbmcgd2hlcmUgeW91IGRvbid0IG5lZWQgYSByZWxpYWJsZSAKY29tbXVuaWNhdGlvbiBh
bmQgeW91IHdhbnQgdG8gYXZvaWQgdG8ga2VlcCBtb3JlIG9wZW4gY29ubmVjdGlvbnMgd2l0aCAK
ZGlmZmVyZW50IGd1ZXN0cy4KClNvIHRoZSBzZXJ2ZXIgaW4gdGhlIGhvc3QgY2FuIGJlIHByZXR0
eSBzaW1wbGUgYW5kIGRvZXNuJ3QgaGF2ZSB0byAKaGFuZGxlIGNvbm5lY3Rpb25zLiBJdCBqdXN0
IHdhaXRzIGZvciBkYXRhZ3JhbXMgb24gYSBwb3J0LgoKPgo+Cj4+Cj4+Pgo+Pj5BbiBvYnZpb3Vz
IGRyYXdiYWNrIGlzIHRoYXQgaXQgYnJlYWtzIHRoZSBtaWdyYXRpb24uIFVzaW5nIFVEUCB5b3Ug
Cj4+PmNhbiBoYXZlIGEgdmVyeSByaWNoIGZlYXR1cmVzIHN1cHBvcnQgZnJvbSB0aGUga2VybmVs
IHdoZXJlIHZzb2NrIAo+Pj5jYW4ndC4KPj4+Cj4+Cj4+VGhhbmtzIGZvciBicmluZ2luZyB0aGlz
IHVwIQo+PldoYXQgZmVhdHVyZXMgZG9lcyBVRFAgc3VwcG9ydCBhbmQgZGF0YWdyYW0gb24gdnNv
Y2sgY291bGQgbm90IHN1cHBvcnQ/Cj4KPgo+RS5nIHRoZSBzZW5kcGFnZSgpIGFuZCBidXN5IHBv
bGxpbmcuIEFuZCB1c2luZyBVRFAgbWVhbnMgcWRpc2NzIGFuZCAKPmVCUEYgY2FuIHdvcmsuCgpU
aGFua3MsIEkgc2VlIQoKPgo+Cj4+Cj4+Pgo+Pj4+Cj4+Pj4+PlRoZSB2aXJ0aW8gc3BlYyBwYXRj
aCBpcyBoZXJlOgo+Pj4+Pj5odHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC12aXJ0
dWFsaXphdGlvbi9tc2c1MDAyNy5odG1sCj4+Pj4+Cj4+Pj4+SGF2ZSBhIHF1aWNrIGdsYW5jZSwg
SSBzdWdnZXN0IHRvIHNwbGl0IG1lcmdlYWJsZSByeCBidWZmZXIgaW50byBhbgo+Pj4+PnNlcGFy
YXRlIHBhdGNoLgo+Pj4+U3VyZS4KPj4+Pgo+Pj4+PkJ1dCBJIHRoaW5rIGl0J3MgdGltZSB0byBy
ZXZpc2l0IHRoZSBpZGVhIG9mIHVuaWZ5aW5nIHRoZSAKPj4+Pj52aXJ0aW8tbmV0IGFuZAo+Pj4+
PnZpcnRpby12c29jay4gT3RoZXJ3aXNlIHdlJ3JlIGR1cGxpY2F0aW5nIGZlYXR1cmVzIGFuZCBi
dWdzLgo+Pj4+Rm9yIG1lcmdlYWJsZSByeGJ1ZiByZWxhdGVkIGNvZGUsIEkgdGhpbmsgYSBzZXQg
b2YgY29tbW9uIGhlbHBlcgo+Pj4+ZnVuY3Rpb25zIGNhbiBiZSB1c2VkIGJ5IGJvdGggdmlydGlv
LW5ldCBhbmQgdmlydGlvLXZzb2NrLiBGb3Igb3RoZXIKPj4+PnBhcnRzLCB0aGF0IG1heSBub3Qg
YmUgdmVyeSBiZW5lZmljaWFsLiBJIHdpbGwgdGhpbmsgYWJvdXQgbW9yZS4KPj4+Pgo+Pj4+SWYg
dGhlcmUgaXMgYSBwcmV2aW91cyBlbWFpbCBkaXNjdXNzaW9uIGFib3V0IHRoaXMgdG9waWMsIGNv
dWxkIAo+Pj4+eW91IHNlbmQgbWUKPj4+PnNvbWUgbGlua3M/IEkgZGlkIGEgcXVpY2sgd2ViIHNl
YXJjaCBidXQgZGlkIG5vdCBmaW5kIGFueSByZWxhdGVkCj4+Pj5pbmZvLiBUaGFua3MuCj4+Pgo+
Pj4KPj4+V2UgaGFkIGEgbG90Ogo+Pj4KPj4+WzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9rdm0vcGF0Y2gvNUJERkY1MzcuMzA1MDgwNkBodWF3ZWkuY29tLwo+Pj5bMl0g
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC92aXJ0dWFsaXphdGlv
bi8yMDE4LU5vdmVtYmVyLzAzOTc5OC5odG1sCj4+PlszXSBodHRwczovL3d3dy5sa21sLm9yZy9s
a21sLzIwMjAvMS8xNi8yMDQzCj4+Pgo+Pgo+PldoZW4gSSB0cmllZCBpdCwgdGhlIGJpZ2dlc3Qg
cHJvYmxlbSB0aGF0IGJsb2NrZWQgbWUgd2VyZSBhbGwgdGhlIAo+PmZlYXR1cmVzIHN0cmljdGx5
IHJlbGF0ZWQgdG8gVENQL0lQIHN0YWNrIGFuZCBldGhlcm5ldCBkZXZpY2VzIHRoYXQgCj4+dnNv
Y2sgZGV2aWNlIGRvZXNuJ3Qga25vdyBob3cgdG8gaGFuZGxlOiBUU08sIEdTTywgY2hlY2tzdW1z
LCBNQUMsIAo+Pm5hcGksIHhkcCwgbWluIGV0aGVybmV0IGZyYW1lIHNpemUsIE1UVSwgZXRjLgo+
Cj4KPkl0IGRlcGVuZHMgb24gd2hpY2ggbGV2ZWwgd2Ugd2FudCB0byBzaGFyZToKPgo+MSkgc2hh
cmluZyBjb2Rlcwo+Mikgc2hhcmluZyBkZXZpY2VzCj4zKSBtYWtlIHZzb2NrIGEgcHJvdG9jb2wg
dGhhdCBpcyB1bmRlcnN0b29kIGJ5IHRoZSBuZXR3b3JrIGNvcmUKPgo+V2UgY2FuIHN0YXJ0IGZy
b20gMSksIHRoZSBsb3cgbGV2ZWwgdHgvcnggbG9naWMgY2FuIGJlIHNoYXJlZCBhdCBib3RoIAo+
dmlydGlvLW5ldCBhbmQgdmhvc3QtbmV0LiBGb3IgMikgd2UgcHJvYmFibHkgbmVlZCBzb21lIHdv
cmsgb24gdGhlIAo+c3BlYywgcHJvYmFibHkgd2l0aCBhIG5ldyBmZWF0dXJlIGJpdCB0byBkZW1v
bnN0cmF0ZSB0aGF0IGl0J3MgYSB2c29jayAKPmRldmljZSBub3QgYSBldGhlcm5ldCBkZXZpY2Uu
IFRoZW4gaWYgaXQgaXMgcHJvYmVkIGFzIGEgdnNvY2sgZGV2aWNlIHdlIAo+d29uJ3QgbGV0IHBh
Y2tldCB0byBiZSBkZWxpdmVyZWQgaW4gdGhlIFRDUC9JUCBzdGFjay4gRm9yIDMpLCBpdCB3b3Vs
ZCAKPmJlIGV2ZW4gaGFyZGVyIGFuZCBJJ20gbm90IHN1cmUgaXQncyB3b3J0aCB0byBkbyB0aGF0
Lgo+Cj4KPj4KPj5TbyBpbiBteSBvcGluaW9uIHRvIHVuaWZ5IHRoZW0gaXMgbm90IHNvIHNpbXBs
ZSwgYmVjYXVzZSB2c29jayBpcyBub3QgCj4+cmVhbGx5IGFuIGV0aGVybmV0IGRldmljZSwgYnV0
IHNpbXBseSBhIHNvY2tldC4KPgo+Cj5XZSBjYW4gc3RhcnQgZnJvbSBzaGFyaW5nIGNvZGVzLgoK
WWVwLCBJIGFncmVlLCBhbmQgbWF5YmUgdGhlIG1lcmdlYWJsZSBidWZmZXIgaXMgYSBnb29kIHN0
YXJ0aW5nIHBvaW50IHRvIApzaGFyZSBjb2RlIQoKQEppYW5nLCBkbyB5b3Ugd2FudCB0byB0YWtl
IGEgbG9vayBvZiB0aGlzIHBvc3NpYmlsaXR5PwoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
