Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496FC433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 18:09:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319C06120D
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 18:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 319C06120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7D9560599;
	Mon,  8 Nov 2021 18:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PC8uGNUFCv4e; Mon,  8 Nov 2021 18:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99D5560638;
	Mon,  8 Nov 2021 18:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70B35C0012;
	Mon,  8 Nov 2021 18:09:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6EBC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 18:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47EF3400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 18:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PDS7sro668Jc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 18:09:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E34B540003
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636394955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cEuhXaEuhD+GKL/lBmFj9KF6WCNj/n+YccNImJPdjg=;
 b=Qe0ArsfQZRCC0E6pJ6ixO+6pLcqxNtKHbsnYD/qAEUJ7HnZtXViJXUahRjR61wWklUI4UM
 0rXzSq4Kdvp24qmviX8PyYsySZWPax4OeG0IakHgbBNIJiGvvSa2+mnKIks2Gi99ILpAlD
 b1kMwdMu5EKO/BRF0sw8XqvHXFrhUnI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-i94yxRe1OWCd_aRYRChUCg-1; Mon, 08 Nov 2021 13:09:14 -0500
X-MC-Unique: i94yxRe1OWCd_aRYRChUCg-1
Received: by mail-ed1-f71.google.com with SMTP id
 f20-20020a0564021e9400b003e2ad3eae74so15599826edf.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 10:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1cEuhXaEuhD+GKL/lBmFj9KF6WCNj/n+YccNImJPdjg=;
 b=CJrQ8UrKx5ql5QtoR8HOOndmZijc10wMD0pGCpQTAA+9T02eoJ2VhnW7Q4Jtr3dWTr
 3kinYbqtb5M++oZ86me5mLMrTYuQhH3EF9mJRJOQO/ZPtEtTiA88ww0LPEgBy32py/J0
 Y10R6Nln9Uj2O/MQaXcFBu4CgVHWomkZiK0wT+8hAa8GKWXhNuhQPaMls54JJGiIuEXD
 WzpYiwO/fqGr+10raD0zlZgOrPFltVi43aOVj0dRnqb5euI6tUkgFE8xcahYWEeUl736
 S8Q3NOCllJ0ZJiSUmc5BeK7N04uD0uKTaZvDUztLYW0kFzfMNUE+zxYkrR1eB00y+tMS
 UrHg==
X-Gm-Message-State: AOAM532cZJA3PYovEoBSMoQOscgYoU3SgSy7Oq3xLdCCVoi686JVyqbM
 B3NBWGGKsBgWjR8FPTP1SAmR3KkD1o54cMdHzzeikLSkvNUNXaCmV0VFQPrvolvx0fz90MO23lz
 cdXesfvH5ZH20SmLhBhVzMYxR/pe6Kdrb8pdvIKnMCA==
X-Received: by 2002:a17:907:6d28:: with SMTP id
 sa40mr1366940ejc.201.1636394950898; 
 Mon, 08 Nov 2021 10:09:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFl9l6h6hht9A5aJJ1AjaKI1Gc/QCJAMZfxs6NI7DNc7GZynoZUGXDhwJB5iBWG48JDP2lsQ==
X-Received: by 2002:a17:907:6d28:: with SMTP id
 sa40mr1366748ejc.201.1636394949629; 
 Mon, 08 Nov 2021 10:09:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
 by smtp.gmail.com with ESMTPSA id z9sm6779771edb.50.2021.11.08.10.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 10:09:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
 id 1A5BA18026D; Mon,  8 Nov 2021 19:09:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH net-next 03/21] ethtool, stats: introduce standard XDP
 statistics
In-Reply-To: <20211108132113.5152-1-alexandr.lobakin@intel.com>
References: <20210803163641.3743-1-alexandr.lobakin@intel.com>
 <20210803163641.3743-4-alexandr.lobakin@intel.com>
 <20210803134900.578b4c37@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <ec0aefbc987575d1979f9102d331bd3e8f809824.camel@kernel.org>
 <20211026092323.165-1-alexandr.lobakin@intel.com>
 <20211105164453.29102-1-alexandr.lobakin@intel.com>
 <87v912ri7h.fsf@toke.dk>
 <20211108132113.5152-1-alexandr.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Nov 2021 19:09:08 +0100
Message-ID: <87cznar03f.fsf@toke.dk>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=toke@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>,
 Song Liu <songliubraving@fb.com>, Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
 Sameeh Jubran <sameehj@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Zheng Yongjun <zhengyongjun3@huawei.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Petr Vorel <petr.vorel@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>, Jian Shen <shenjian15@huawei.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Michal Kubiak <michal.kubiak@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin Habets <habetsm.xilinx@gmail.com>,
 virtualization@lists.linux-foundation.org, Guy Tzalik <gtzalik@amazon.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ido Schimmel <idosch@nvidia.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
 KP Singh <kpsingh@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Dan Murphy <dmurphy@ti.com>,
 Jakub Kicinski <kuba@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, Johannes Berg <johannes@sipsolutions.net>,
 Danielle Ratson <danieller@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Netanel Belgazal <netanel@amazon.com>, Marcin Kubiak <marcin.kubiak@intel.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Saeed Bishara <saeedb@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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

QWxleGFuZGVyIExvYmFraW4gPGFsZXhhbmRyLmxvYmFraW5AaW50ZWwuY29tPiB3cml0ZXM6Cgo+
IEZyb206IFRva2UgSMO4aWxhbmQtSsO4cmdlbnNlbiA8dG9rZUByZWRoYXQuY29tPgo+IERhdGU6
IE1vbiwgMDggTm92IDIwMjEgMTI6Mzc6NTQgKzAxMDAKPgo+PiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxleGFuZHIubG9iYWtpbkBpbnRlbC5jb20+IHdyaXRlczoKPj4gCj4+ID4gRnJvbTogQWxleGFu
ZGVyIExvYmFraW4gPGFsZXhhbmRyLmxvYmFraW5AaW50ZWwuY29tPgo+PiA+IERhdGU6IFR1ZSwg
MjYgT2N0IDIwMjEgMTE6MjM6MjMgKzAyMDAKPj4gPgo+PiA+PiBGcm9tOiBTYWVlZCBNYWhhbWVl
ZCA8c2FlZWRAa2VybmVsLm9yZz4KPj4gPj4gRGF0ZTogVHVlLCAwMyBBdWcgMjAyMSAxNjo1Nzoy
MiAtMDcwMAo+PiA+PiAKPj4gPj4gWyBzbmlwIF0KPj4gPj4gCj4+ID4+ID4gWERQIGlzIGdvaW5n
IHRvIGFsd2F5cyBiZSBlQlBGIGJhc2VkICEgd2h5IG5vdCBqdXN0IHJlcG9ydCBzdWNoIHN0YXRz
Cj4+ID4+ID4gdG8gYSBzcGVjaWFsIEJQRl9NQVAgPyBCUEYgc3RhY2sgY2FuIGNvbGxlY3QgdGhl
IHN0YXRzIGZyb20gdGhlIGRyaXZlcgo+PiA+PiA+IGFuZCByZXBvcnQgdGhlbSB0byB0aGlzIHNw
ZWNpYWwgTUFQIHVwb24gdXNlciByZXF1ZXN0Lgo+PiA+PiAKPj4gPj4gSSByZWFsbHkgZGlnIHRo
aXMgaWRlYSBub3cuIEhvdyBkbyB5b3Ugc2VlIGl0Pwo+PiA+PiA8aWZpbmRleDpjaGFubmVsOnN0
YXRfaWQ+IGFzIGEga2V5IGFuZCBpdHMgdmFsdWUgYXMgYSB2YWx1ZSBvciAuLi4/Cj4+ID4KPj4g
PiBJZGVhcywgc3VnZ2VzdGlvbnMsIGFueW9uZT8KPj4gCj4+IEkgZG9uJ3QgbGlrZSB0aGUgaWRl
YSBvZiBwdXR0aW5nIHN0YXRpc3RpY3MgaW4gYSBtYXAgaW5zdGVhZCBvZiB0aGUKPj4gcmVndWxh
ciBzdGF0aXN0aWNzIGNvdW50ZXJzLiBTdXJlLCBmb3IgYmVzcG9rZSB0aGluZ3MgcGVvcGxlIHdh
bnQgdG8gcHV0Cj4+IGludG8gdGhlaXIgWERQIHByb2dyYW1zLCB1c2UgYSBtYXAsIGJ1dCBmb3Ig
cmVndWxhciBwYWNrZXQvYnl0ZQo+PiBjb3VudGVycywgdXBkYXRlIHRoZSByZWd1bGFyIGNvdW50
ZXJzIHNvIFhEUCBpc24ndCAiaW52aXNpYmxlIi4KPgo+IEkgd2FudGVkIHRvIHByb3ZpZGUgYW4g
YGlwIGxpbmtgIGNvbW1hbmQgZm9yIGdldHRpbmcgdGhlc2Ugc3RhdHMKPiBmcm9tIG1hcHMgYW5k
IHByaW50aW5nIHRoZW0gaW4gYSB1c3VhbCBmb3JtYXQgYXMgd2VsbCwgYnV0IHNlZW1zCj4gbGlr
ZSB0aGF0J3MgYW4gdW5uZWVkZWQgb3ZlcmNvbXBsaWNhdGlvbiBvZiB0aGluZ3Mgc2luY2UgdXNp
bmcKPiBtYXBzIGZvciAicmVndWxhciIvImdlbmVyaWMiIFhEUCBzdGF0cyByZWFsbHkgaGFzIG5v
IHJlYXNvbiBleGNlcHQKPiBmb3IgIlhEUCBtZWFucyBlQlBGIG1lYW5zIG1hcHMiLgoKWWVhaCwg
ZG9uJ3QgcmVhbGx5IHNlZSB3aHkgaXQgd291bGQgaGF2ZSB0bzogdG8gbWUsIG9uZSBvZiB0aGUg
YmVuZWZpdHMKb2YgWERQIGlzIGJlaW5nIGludGVncmF0ZWQgY2xvc2VseSB3aXRoIHRoZSBrZXJu
ZWwgc28gd2UgY2FuIGhhdmUgYQoiZmFzdCBwYXRoIiAqd2l0aG91dCogcmVpbnZlbnRpbmcgZXZl
cnl0aGluZy4uLgoKPj4gQXMgSmVzcGVyIHBvaW50ZWQgb3V0LCBiYXRjaGluZyB0aGUgdXBkYXRl
cyBzbyB0aGUgZ2xvYmFsIGNvdW50ZXJzIGFyZQo+PiBvbmx5IHVwZGF0ZWQgb25jZSBwZXIgTkFQ
SSBjeWNsZSBpcyB0aGUgd2F5IHRvIGF2b2lkIGEgaHVnZSBwZXJmb3JtYW5jZQo+PiBvdmVyaGVh
ZCBvZiB0aGlzLi4uCj4KPiBUaGF0J3MgaG93IEkgZG8gdGhpbmdzIGN1cnJlbnRseSwgc2VlbXMg
dG8gd29yayBqdXN0IGZpbmUuCgpBd2Vzb21lIQoKLVRva2UKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
