Return-Path: <SRS0=J7vq=KX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F2C4708D
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 06:39:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEC9613B5
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 06:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEC9613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F61160DC1;
	Fri, 28 May 2021 06:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WevvG_tinKr9; Fri, 28 May 2021 06:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 077FB60DCC;
	Fri, 28 May 2021 06:39:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97072C0022;
	Fri, 28 May 2021 06:39:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC4C6C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 06:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A1D74054D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 06:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNq2ERRub0pD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 06:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C1EC404C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622183949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RpP8rpfd8a3e0y5nF0RPgT5RVi2VhGM0rPjlvoSzx4=;
 b=gDBkzqxqKfaeQ7Oxt0B4O42Rxx8iJ+KkV0cRLpR+v1/ymXcZ2RyWNdQEd9H1xErqpdsmpU
 ubdptE17Ves63meELxr8LXNnSDBJ+xtKlme4FoujSB0IqVUPSIJCYndhJ+2Whg2U5TyJGf
 W2P1AE1/z0j7H437mAmElCaTSoMZIFo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-iToEHyoBPxCc7TXwHQB8gw-1; Fri, 28 May 2021 02:39:08 -0400
X-MC-Unique: iToEHyoBPxCc7TXwHQB8gw-1
Received: by mail-pf1-f199.google.com with SMTP id
 g21-20020aa787550000b02902db9841d2a1so1875766pfo.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 23:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6RpP8rpfd8a3e0y5nF0RPgT5RVi2VhGM0rPjlvoSzx4=;
 b=MkhrdP+DZGtRJOhfNMA484e+k/Z2r19XaRqMTRa109GLpca1XPtmVRZlj1fTRBJEkv
 a7GHu4yRlDJyd7HGX4M787xyJ8pdm7vB3CrjvmWaT/EytCneAqDqZME7unuQLOzXZQeN
 rlW6LXGYNBHP+CZJRZR5qDotlfFgcn7NJv6ArE82yWZZU4oLOgprmxTI+Pqq3PXbce16
 l56h9X/ct4g3Y9zeUsP/DqGZBpSfjUi2JUsXxf5vG99J9zskcY/OQaHEn4+eO+s1W3yj
 /sbqcqQ4hCnUk8eQB0Km6AGjlYV32cp9t2b+iXYVhzQDN8g1XYUYmBVOpKsNY7OD9yRk
 cytg==
X-Gm-Message-State: AOAM531xI+BGvxTUuPhl/w/PbvxAmsTNWNz9h2fS+aEN14ZAggO8tGlv
 Xk1hkNY7GjU3h5kk/GiYT1vETHnz59K3qJS0twirPQOf55QKfXSArz63YzJEFM3LW8382Mx0XIF
 P1DeSA/7yn4VDgGs7/+lIZVVCWtRqAZdaNO4adO6uwA==
X-Received: by 2002:a17:90a:bd05:: with SMTP id
 y5mr2664319pjr.229.1622183947111; 
 Thu, 27 May 2021 23:39:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGNmAqjgmxntdDKOd5qocBDSk4ZjOlVFy0XRLBTCjKcdzj+d4zuGqzz/QNeE7UYpYTrC3W9A==
X-Received: by 2002:a17:90a:bd05:: with SMTP id
 y5mr2664285pjr.229.1622183946816; 
 Thu, 27 May 2021 23:39:06 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q24sm3476480pjp.6.2021.05.27.23.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 23:39:06 -0700 (PDT)
Subject: Re: [PATCH v7 11/12] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-12-xieyongji@bytedance.com>
 <3740c7eb-e457-07f3-5048-917c8606275d@redhat.com>
 <CACycT3uAqa6azso_8MGreh+quj-JXO1piuGnrV8k2kTfc34N2g@mail.gmail.com>
 <5a68bb7c-fd05-ce02-cd61-8a601055c604@redhat.com>
 <CACycT3ve7YvKF+F+AnTQoJZMPua+jDvGMs_ox8GQe_=SGdeCMA@mail.gmail.com>
 <ee00efca-b26d-c1be-68d2-f9e34a735515@redhat.com>
 <CACycT3ufok97cKpk47NjUBTc0QAyfauFUyuFvhWKmuqCGJ7zZw@mail.gmail.com>
 <00ded99f-91b6-ba92-5d92-2366b163f129@redhat.com>
 <3cc7407d-9637-227e-9afa-402b6894d8ac@redhat.com>
 <CACycT3s6SkER09KL_Ns9d03quYSKOuZwd3=HJ_s1SL7eH7y5gA@mail.gmail.com>
 <baf0016a-7930-2ae2-399f-c28259f415c1@redhat.com>
 <CACycT3vKZ3y0gga8PrSVtssZfNV0Y-A8=iYZSi9sbpHRNkVf-A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <503cee35-e5d7-7ccf-347b-73487872ac11@redhat.com>
Date: Fri, 28 May 2021 14:38:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACycT3vKZ3y0gga8PrSVtssZfNV0Y-A8=iYZSi9sbpHRNkVf-A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, joro@8bytes.org,
 Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzUvMjgg5LiK5Y2IMTE6NTQsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIEZyaSwg
TWF5IDI4LCAyMDIxIGF0IDk6MzMgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2INjoxNCwgWW9uZ2ppIFhpZSDlhpnpgZM6
Cj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCA0OjQzIFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2INDo0MSwgSmFzb24g
V2FuZyDlhpnpgZM6Cj4+Pj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2IMzozNCwgWW9uZ2ppIFhpZSDl
hpnpgZM6Cj4+Pj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxOjQwIFBNIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+IOWcqCAyMDIxLzUvMjcg5LiL5Y2I
MTowOCwgWW9uZ2ppIFhpZSDlhpnpgZM6Cj4+Pj4+Pj4+IE9uIFRodSwgTWF5IDI3LCAyMDIxIGF0
IDE6MDAgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+Pj4+Pj4gd3JvdGU6
Cj4+Pj4+Pj4+PiDlnKggMjAyMS81LzI3IOS4i+WNiDEyOjU3LCBZb25namkgWGllIOWGmemBkzoK
Pj4+Pj4+Pj4+PiBPbiBUaHUsIE1heSAyNywgMjAyMSBhdCAxMjoxMyBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+Pj4+IHdyb3RlOgo+Pj4+Pj4+Pj4+PiDlnKggMjAy
MS81LzE3IOS4i+WNiDU6NTUsIFhpZSBZb25namkg5YaZ6YGTOgo+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+
Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2X21zZ19zeW5jKHN0cnVjdCB2ZHVzZV9kZXYg
KmRldiwKPj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmR1
c2VfZGV2X21zZyAqbXNnKQo+Pj4+Pj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4+Pj4+ICsgICAgIGluaXRf
d2FpdHF1ZXVlX2hlYWQoJm1zZy0+d2FpdHEpOwo+Pj4+Pj4+Pj4+Pj4gKyAgICAgc3Bpbl9sb2Nr
KCZkZXYtPm1zZ19sb2NrKTsKPj4+Pj4+Pj4+Pj4+ICsgICAgIHZkdXNlX2VucXVldWVfbXNnKCZk
ZXYtPnNlbmRfbGlzdCwgbXNnKTsKPj4+Pj4+Pj4+Pj4+ICsgICAgIHdha2VfdXAoJmRldi0+d2Fp
dHEpOwo+Pj4+Pj4+Pj4+Pj4gKyAgICAgc3Bpbl91bmxvY2soJmRldi0+bXNnX2xvY2spOwo+Pj4+
Pj4+Pj4+Pj4gKyAgICAgd2FpdF9ldmVudF9raWxsYWJsZShtc2ctPndhaXRxLCBtc2ctPmNvbXBs
ZXRlZCk7Cj4+Pj4+Pj4+Pj4+IFdoYXQgaGFwcGVucyBpZiB0aGUgdXNlcnNwYWNlKG1hbGljb3Vz
KSBkb2Vzbid0IGdpdmUgYSByZXNwb25zZQo+Pj4+Pj4+Pj4+PiBmb3JldmVyPwo+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+PiBJdCBsb29rcyBsaWtlIGEgRE9TLiBJZiB5ZXMsIHdlIG5lZWQgdG8gY29u
c2lkZXIgYSB3YXkgdG8gZml4IHRoYXQuCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gSG93IGFib3V0
IHVzaW5nIHdhaXRfZXZlbnRfa2lsbGFibGVfdGltZW91dCgpIGluc3RlYWQ/Cj4+Pj4+Pj4+PiBQ
cm9iYWJseSwgYW5kIHRoZW4gd2UgbmVlZCBjaG9vc2UgYSBzdWl0YWJsZSB0aW1lb3V0IGFuZCBt
b3JlCj4+Pj4+Pj4+PiBpbXBvcnRhbnQsCj4+Pj4+Pj4+PiBuZWVkIHRvIHJlcG9ydCB0aGUgZmFp
bHVyZSB0byB2aXJ0aW8uCj4+Pj4+Pj4+Pgo+Pj4+Pj4+PiBNYWtlcyBzZW5zZSB0byBtZS4gQnV0
IGl0IGxvb2tzIGxpa2Ugc29tZQo+Pj4+Pj4+PiB2ZHBhX2NvbmZpZ19vcHMvdmlydGlvX2NvbmZp
Z19vcHMgc3VjaCBhcyBzZXRfc3RhdHVzKCkgZGlkbid0IGhhdmUgYQo+Pj4+Pj4+PiByZXR1cm4g
dmFsdWUuICBOb3cgSSBhZGQgYSBXQVJOX09OKCkgZm9yIHRoZSBmYWlsdXJlLiBEbyB5b3UgbWVh
biB3ZQo+Pj4+Pj4+PiBuZWVkIHRvIGFkZCBzb21lIGNoYW5nZSBmb3IgdmlydGlvIGNvcmUgdG8g
aGFuZGxlIHRoZSBmYWlsdXJlPwo+Pj4+Pj4+IE1heWJlLCBidXQgSSdtIG5vdCBzdXJlIGhvdyBo
YXJkIHdlIGNhbiBkbyB0aGF0Lgo+Pj4+Pj4+Cj4+Pj4+PiBXZSBuZWVkIHRvIGNoYW5nZSBhbGwg
dmlydGlvIGRldmljZSBkcml2ZXJzIGluIHRoaXMgd2F5Lgo+Pj4+PiBQcm9iYWJseS4KPj4+Pj4K
Pj4+Pj4KPj4+Pj4+PiBXZSBoYWQgTkVFRFNfUkVTRVQgYnV0IGl0IGxvb2tzIHdlIGRvbid0IGlt
cGxlbWVudCBpdC4KPj4+Pj4+Pgo+Pj4+Pj4gQ291bGQgaXQgaGFuZGxlIHRoZSBmYWlsdXJlIG9m
IGdldF9mZWF0dXJlKCkgYW5kIGdldC9zZXRfY29uZmlnKCk/Cj4+Pj4+IExvb2tzIG5vdDoKPj4+
Pj4KPj4+Pj4gIgo+Pj4+Pgo+Pj4+PiBUaGUgZGV2aWNlIFNIT1VMRCBzZXQgREVWSUNFX05FRURT
X1JFU0VUIHdoZW4gaXQgZW50ZXJzIGFuIGVycm9yIHN0YXRlCj4+Pj4+IHRoYXQgYSByZXNldCBp
cyBuZWVkZWQuIElmIERSSVZFUl9PSyBpcyBzZXQsIGFmdGVyIGl0IHNldHMKPj4+Pj4gREVWSUNF
X05FRURTX1JFU0VULCB0aGUgZGV2aWNlIE1VU1Qgc2VuZCBhIGRldmljZSBjb25maWd1cmF0aW9u
IGNoYW5nZQo+Pj4+PiBub3RpZmljYXRpb24gdG8gdGhlIGRyaXZlci4KPj4+Pj4KPj4+Pj4gIgo+
Pj4+Pgo+Pj4+PiBUaGlzIGxvb2tzIGltcGxpZXMgdGhhdCBORUVEU19SRVNFVCBtYXkgb25seSB3
b3JrIGFmdGVyIGRldmljZSBpcwo+Pj4+PiBwcm9iZWQuIEJ1dCBpbiB0aGUgY3VycmVudCBkZXNp
Z24sIGV2ZW4gdGhlIHJlc2V0KCkgaXMgbm90IHJlbGlhYmxlLgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4+
IE9yIGEgcm91Z2ggaWRlYSBpcyB0aGF0IG1heWJlIG5lZWQgc29tZSByZWxheGluZyB0byBiZSBj
b3VwbGVkIGxvb3NlbHkKPj4+Pj4+PiB3aXRoIHVzZXJzcGFjZS4gRS5nIHRoZSBkZXZpY2UgKGNv
bnRyb2wgcGF0aCkgaXMgaW1wbGVtZW50ZWQgaW4gdGhlCj4+Pj4+Pj4ga2VybmVsIGJ1dCB0aGUg
ZGF0YXBhdGggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIHVzZXJzcGFjZSBsaWtlIFRVTi9UQVAuCj4+
Pj4+Pj4KPj4+Pj4+IEkgdGhpbmsgaXQgY2FuIHdvcmsgZm9yIG1vc3QgY2FzZXMuIE9uZSBwcm9i
bGVtIGlzIHRoYXQgdGhlIHNldF9jb25maWcKPj4+Pj4+IG1pZ2h0IGNoYW5nZSB0aGUgYmVoYXZp
b3Igb2YgdGhlIGRhdGEgcGF0aCBhdCBydW50aW1lLCBlLmcuCj4+Pj4+PiB2aXJ0bmV0X3NldF9t
YWNfYWRkcmVzcygpIGluIHRoZSB2aXJ0aW8tbmV0IGRyaXZlciBhbmQKPj4+Pj4+IGNhY2hlX3R5
cGVfc3RvcmUoKSBpbiB0aGUgdmlydGlvLWJsayBkcml2ZXIuIE5vdCBzdXJlIGlmIHRoaXMgcGF0
aCBpcwo+Pj4+Pj4gYWJsZSB0byByZXR1cm4gYmVmb3JlIHRoZSBkYXRhcGF0aCBpcyBhd2FyZSBv
ZiB0aGlzIGNoYW5nZS4KPj4+Pj4gR29vZCBwb2ludC4KPj4+Pj4KPj4+Pj4gQnV0IHNldF9jb25m
aWcoKSBzaG91bGQgYmUgcmFyZToKPj4+Pj4KPj4+Pj4gRS5nIGluIHRoZSBjYXNlIG9mIHZpcnRp
by1uZXQgd2l0aCBWRVJTSU9OXzEsIGNvbmZpZyBzcGFjZSBpcyByZWFkCj4+Pj4+IG9ubHksIGFu
ZCBpdCB3YXMgc2V0IHZpYSBjb250cm9sIHZxLgo+Pj4+Pgo+Pj4+PiBGb3IgYmxvY2ssIHdlIGNh
bgo+Pj4+Pgo+Pj4+PiAxKSBzdGFydCBmcm9tIHdpdGhvdXQgV0NFIG9yCj4+Pj4+IDIpIHdlIGFk
ZCBhIGNvbmZpZyBjaGFuZ2Ugbm90aWZpY2F0aW9uIHRvIHVzZXJzcGFjZSBvcgo+Pj4+PiAzKSBl
eHRlbmQgdGhlIHNwZWMgdG8gdXNlIHZxIGluc3RlYWQgb2YgY29uZmlnIHNwYWNlCj4+Pj4+Cj4+
Pj4+IFRoYW5rcwo+Pj4+IEFub3RoZXIgdGhpbmcgaWYgd2Ugd2FudCB0byBnbyB0aGlzIHdheToK
Pj4+Pgo+Pj4+IFdlIG5lZWQgZmluZCBhIHdheSB0byB0ZXJtaW5hdGUgdGhlIGRhdGEgcGF0aCBm
cm9tIHRoZSBrZXJuZWwgc2lkZSwgdG8KPj4+PiBpbXBsZW1lbnQgdG8gcmVzZXQgc2VtYW50aWMu
Cj4+Pj4KPj4+IERvIHlvdSBtZWFuIHRlcm1pbmF0ZSB0aGUgZGF0YSBwYXRoIGluIHZkcGFfcmVz
ZXQoKS4KPj4KPj4gWWVzLgo+Pgo+Pgo+Pj4gICAgSXMgaXQgb2sgdG8ganVzdAo+Pj4gbm90aWZ5
IHVzZXJzcGFjZSB0byBzdG9wIGRhdGEgcGF0aCBhc3luY2hyb25vdXNseT8KPj4KPj4gRm9yIHdl
bGwtYmVoYXZlZCB1c2Vyc3BhY2UsIHllcyBidXQgbm8gZm9yIGJ1Z2d5IG9yIG1hbGljaW91cyBv
bmVzLgo+Pgo+IEJ1dCB0aGUgYnVnZ3kgb3IgbWFsaWNpb3VzIGRhZW1vbnMgY2FuJ3QgZG8gYW55
dGhpbmcgaWYgbXkKPiB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QuCgoKWW91J3JlIHJpZ2h0LiBJ
IG9yaWdpbmFsbHkgdGhvdWdodCB0aGVyZSBjYW4gc3RpbGwgaGF2ZSBib3VuY2luZy4gQnV0IApj
b25zaWRlciB3ZSBkb24ndCBkbyB0aGF0IGR1cmluZyBmYXVsdC4KCkl0IHNob3VsZCBiZSBzYWZl
LgoKCj4KPj4gSSBoYWQgYW4gaWRlYSwgaG93IGFib3V0IHRlcm1pbmF0ZSBJT1RMQiBpbiB0aGlz
IGNhc2U/IFRoZW4gd2UncmUgaW4KPj4gZmFjdCB0dXJuIGRhdGFwYXRoIG9mZi4KPj4KPiBTb3Jy
eSwgSSBkaWRuJ3QgZ2V0IHlvdXIgcG9pbnQgaGVyZS4gV2hhdCBkbyB5b3UgbWVhbiBieSB0ZXJt
aW5hdGluZwo+IElPVExCPwoKCkkgbWVhbnQgdGVybWluYXRlIHRoZSBib3VuY2luZyBidXQgaXQg
bG9va3Mgc2FmZSBhZnRlciBhIHNlY29uZCB0aG91Z2h0IDopCgpUaGFua3MKCgo+ICAgUmVtb3Zl
IGlvdGxiIG1hcHBpbmc/IEJ1dCB1c2Vyc3BhY2UgY2FuIHN0aWxsIGFjY2VzcyB0aGUgbWFwcGVk
Cj4gcmVnaW9uLgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
