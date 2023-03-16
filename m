Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604EAC6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 08:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECA244000B;
	Thu, 16 Mar 2023 08:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECA244000B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hrbhj64K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 97Dw7e_1DzLe; Thu, 16 Mar 2023 08:17:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F0DC40220;
	Thu, 16 Mar 2023 08:17:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F0DC40220
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1988DC0071;
	Thu, 16 Mar 2023 08:17:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 625D6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 292F781EC3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 292F781EC3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hrbhj64K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8MPO61_v0jN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:17:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5814281EA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5814281EA4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678954652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tgpDQ21wRopkfuNLBenzw1X+XTk1gkyJI+wV3gp8bc=;
 b=hrbhj64KQXg2rgJ0FTrLKHCbjYUH8dVkn0JMFYSJ5a3/V7fQ9fJVAnh4c/6JLD6s8YjhP8
 EfByJO00EF1r1WdzdUAAoH1lQpeDTK5WOpPBhES8/hl3ppum5KdDwEBxNZpFjxFXCdZve6
 5d0P0lc+TvJ1q1nmha44X+m59UGY8ts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-b7k-GgZxOpets80MRMcliw-1; Thu, 16 Mar 2023 04:17:31 -0400
X-MC-Unique: b7k-GgZxOpets80MRMcliw-1
Received: by mail-wm1-f70.google.com with SMTP id
 l20-20020a05600c1d1400b003e10d3e1c23so2272233wms.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 01:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678954650;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tgpDQ21wRopkfuNLBenzw1X+XTk1gkyJI+wV3gp8bc=;
 b=wzx+fJoABZtn+9OMAn1LoZEz/uekUxtTx+1TxOV4Ipoo1yjuXr8i5Ke+cjoky7Rna4
 LpE33r0g2IKlhafp05QvSQsPKKj9iaq2pRmRaU0WTmr93Np1TEZg4tR1wQrRTdgcu4bR
 OVEGjGUV2VMaMhpmouGE1S0Kj9msDBcNQVTS6192P+bYvt/Psiu2+HiuWzs5UMhjLz4I
 Hi9XJ8oZbS5qDPz5xxsWCbQxeNqwQGar2pUN3iY/crGguf6Kgd5OKFqgk8ceck5FcTuv
 z4uafQ2pBCwR3OlVcg6t1QsfuleRak8rp8sFGwXt/KpzMmofT7NXnsilAGJraAG0ArEO
 a0Ig==
X-Gm-Message-State: AO0yUKXGdQWvbH2sDqvcJW7zQJYdfLKeShti4y3Zq+u/FDHs1ZU/MACb
 +3h8solB2YoOhStFcaFPNy6HqYkAe8qEUkXqXwYcLEn4D0fqig29m3jonYj37323en0AblK4tlV
 fueV2cCqP0fq8ur/xFxrmc9IdqTkg/1f0Ac0MoR78rQ==
X-Received: by 2002:a05:600c:3c8f:b0:3ea:bc08:b63e with SMTP id
 bg15-20020a05600c3c8f00b003eabc08b63emr21673835wmb.2.1678954650291; 
 Thu, 16 Mar 2023 01:17:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set8yAXCmTlyMF4pVppmWMDqyhk0GT12h+rEm72RHUQ1OCYbXiPEGJgmkVgwCqUMwdNOtrDJ3tw==
X-Received: by 2002:a05:600c:3c8f:b0:3ea:bc08:b63e with SMTP id
 bg15-20020a05600c3c8f00b003eabc08b63emr21673814wmb.2.1678954650016; 
 Thu, 16 Mar 2023 01:17:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 l26-20020a05600c2cda00b003dd1bd0b915sm4353875wmc.22.2023.03.16.01.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Mar 2023 01:17:29 -0700 (PDT)
Date: Thu, 16 Mar 2023 09:17:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/8] vdpa: add bind_mm/unbind_mm callbacks
Message-ID: <20230316081725.2gwfgptm3lkoptwt@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-2-sgarzare@redhat.com>
 <CACGkMEv24Zw-OUbBBSne21pF7=4XCZ6JGj7Y_cC7cMFYTjbF1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv24Zw-OUbBBSne21pF7=4XCZ6JGj7Y_cC7cMFYTjbF1Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMTE6Mzk6NDJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFRodSwgTWFyIDIsIDIwMjMgYXQgNzozNOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IFRoZXNlIG5ldyBvcHRpb25hbCBjYWxs
YmFja3MgaXMgdXNlZCB0byBiaW5kL3VuYmluZCB0aGUgZGV2aWNlIHRvCj4+IGEgc3BlY2lmaWMg
YWRkcmVzcyBzcGFjZSBzbyB0aGUgdkRQQSBmcmFtZXdvcmsgY2FuIHVzZSBWQSB3aGVuCj4+IHRo
ZXNlIGNhbGxiYWNrcyBhcmUgaW1wbGVtZW50ZWQuCj4+Cj4+IFN1Z2dlc3RlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+PiAtLS0KPgo+T25lIHRoaW5nIHRoYXQgY2Ft
ZSBpbnRvIG15IG1pbmQgaXMgdGhhdCBhZnRlciB0aGlzIGNvbW1pdDoKPgo+Y29tbWl0IDVjZTk5
NWYzMTNjZTU2YzBjNjI0MjVjM2RkYzM3YzVjNTBmYzMzZGIKPkF1dGhvcjogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPkRhdGU6ICAgRnJpIE1heSAyOSAxNjowMjo1OSAyMDIwICsw
ODAwCj4KPiAgICB2aG9zdDogdXNlIG1tZ3JhYigpIGluc3RlYWQgb2YgbW1nZXQoKSBmb3Igbm9u
IHdvcmtlciBkZXZpY2UKPgo+ICAgIEZvciB0aGUgZGV2aWNlIHRoYXQgZG9lc24ndCB1c2Ugdmhv
c3Qgd29ya2VyIGFuZCB1c2VfbW0oKSwgbW1nZXQoKSBpcwo+ICAgIHRvbyBoZWF2eSB3ZWlnaHQg
YW5kIGl0IG1heSBicmluZ3MgdHJvdWJsZXMgZm9yIGltcGxlbWVudGluZyBtbWFwKCkKPiAgICBz
dXBwb3J0IGZvciB2RFBBIGRldmljZS4KPgo+V2UgZG9uJ3QgaG9sZCB0aGUgYWRkcmVzcyBzcGFj
ZSBhZnRlciB0aGlzIGNvbW1pdCwgc28gdGhlIHVzZXJzcGFjZQo+bWFwcGluZyBjb3VsZCBiZSBp
bnZhbGlkIGlmIHRoZSBvd25lciBleGl0cz8KClRoYW5rcyBmb3IgbWVudGlvbmluZyBpdCwgSSds
bCB0YWtlIGEgbG9vayBhdCBpdCEKCkluIGNhc2UgbWF5YmUgSSBzaG91bGQgZG8gYSBtbWdldCAo
b3IgZ2V0X3Rhc2tfbW0pIGluIHZob3N0LXZkcGEgYmVmb3JlCmNhbGxpbmcgdGhlIGNhbGxiYWNr
LCBvciBpbiB0aGUgcGFyZW50IGRyaXZlciBpbnNpZGUgdGhlIGNhbGxiYWNrLCBidXQKaXQgc2Vl
bXMgZHVwbGljYXRpbmcgY29kZS4KClRoYW5rcywKU3RlZmFubwoKPgo+VGhhbmtzCj4KPj4KPj4g
Tm90ZXM6Cj4+ICAgICB2MjoKPj4gICAgIC0gcmVtb3ZlZCBgc3RydWN0IHRhc2tfc3RydWN0ICpv
d25lcmAgcGFyYW0gKHVudXNlZCBmb3Igbm93LCBtYXliZQo+PiAgICAgICB1c2VmdWwgdG8gc3Vw
cG9ydCBjZ3JvdXBzKSBbSmFzb25dCj4+ICAgICAtIGFkZCB1bmJpbmRfbW0gY2FsbGJhY2sgW0ph
c29uXQo+Pgo+PiAgaW5jbHVkZS9saW51eC92ZHBhLmggfCAxMCArKysrKysrKysrCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+PiBpbmRleCA0M2Y1OWVmMTBjYzku
LjM2OWMyMTM5NDI4NCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gKysr
IGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gQEAgLTI5MCw2ICsyOTAsMTQgQEAgc3RydWN0IHZk
cGFfbWFwX2ZpbGUgewo+PiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2
ZHBhIGRldmljZQo+PiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBpZHg6IHZpcnRx
dWV1ZSBpbmRleAo+PiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgcG9p
bnRlciB0byBzdHJ1Y3R1cmUgZGV2aWNlIG9yIGVycm9yIChOVUxMKQo+PiArICogQGJpbmRfbW06
ICAgICAgICAgICAgICAgICAgIEJpbmQgdGhlIGRldmljZSB0byBhIHNwZWNpZmljIGFkZHJlc3Mg
c3BhY2UKPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbyB0aGUgdkRQQSBmcmFt
ZXdvcmsgY2FuIHVzZSBWQSB3aGVuIHRoaXMKPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjYWxsYmFjayBpcyBpbXBsZW1lbnRlZC4gKG9wdGlvbmFsKQo+PiArICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+PiArICogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEBtbTogYWRkcmVzcyBzcGFjZSB0byBiaW5kCj4+ICsgKiBAdW5iaW5k
X21tOiAgICAgICAgICAgICAgICAgVW5iaW5kIHRoZSBkZXZpY2UgZnJvbSB0aGUgYWRkcmVzcyBz
cGFjZQo+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvdW5kIHVzaW5nIHRoZSBi
aW5kX21tIGNhbGxiYWNrLiAob3B0aW9uYWwpCj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+ICAgKiBAZnJlZTogICAgICAgICAgICAgICAgICAg
ICAgRnJlZSByZXNvdXJjZXMgdGhhdCBiZWxvbmdzIHRvIHZEUEEgKG9wdGlvbmFsKQo+PiAgICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+PiAgICovCj4+
IEBAIC0zNTEsNiArMzU5LDggQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4+ICAgICAgICAg
aW50ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQg
aW50IGdyb3VwLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
YXNpZCk7Cj4+ICAgICAgICAgc3RydWN0IGRldmljZSAqKCpnZXRfdnFfZG1hX2Rldikoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKPj4gKyAgICAgICBpbnQgKCpiaW5kX21tKShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKTsKPj4gKyAgICAg
ICB2b2lkICgqdW5iaW5kX21tKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pgo+PiAgICAg
ICAgIC8qIEZyZWUgZGV2aWNlIHJlc291cmNlcyAqLwo+PiAgICAgICAgIHZvaWQgKCpmcmVlKShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+PiAtLQo+PiAyLjM5LjIKPj4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
