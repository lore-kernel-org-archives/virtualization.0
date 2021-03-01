Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E584C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 13:10:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8B564E40
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 13:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8B564E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61EC6606DB;
	Mon,  1 Mar 2021 13:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFsPqCANdR1C; Mon,  1 Mar 2021 13:10:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E52F6063F;
	Mon,  1 Mar 2021 13:09:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA055C000B;
	Mon,  1 Mar 2021 13:09:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76EECC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 13:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 537BA4EC1A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 13:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LMHuuGp-uaPB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 13:09:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0ABC74EC05
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614604195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpOE+HvfzvVF0uHUZZZjwWkF/JdTrtHO6fTJq2Bc4Fw=;
 b=RrVcpLsTpUZuqjfAqdpIvhjtQyN4phKI1LCfXtScra0SwVCgkl3r7vZCgXtyEZiTeKZg5B
 L9qhjfXtohgHCu0SH64la8dnCG4RLa6CLs9Q+q68aUU/g3befO9hEwhWcJdu5Mqtc8PSUL
 cdraAgSTt5k5I+DkdGPGgVeLu/crzP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-zowQL09dNo-L2eVHGiYSnQ-1; Mon, 01 Mar 2021 08:09:54 -0500
X-MC-Unique: zowQL09dNo-L2eVHGiYSnQ-1
Received: by mail-wr1-f70.google.com with SMTP id v13so8371317wrs.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 05:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FpOE+HvfzvVF0uHUZZZjwWkF/JdTrtHO6fTJq2Bc4Fw=;
 b=FeXPECaGGzLNMcRodlxlkvwdcZtTRCJzsqjkg+6R+xNUKoyk6GEWMOwLuoo1cy+mNx
 2+AbCD28SumPst1w4Z4hM6NN4DBg2PJ0lHD43PwSTy+xZUulEGRFLe7K2snz787XSrAp
 e2VXCv5OycFFDjsfo5Ijha0nx3+jI0c/wuMg639YNIiAHrQIPAznGan1Pb1/AS0XkrpI
 nhHKC1sOd+b4bP8NM5AnkO5o9oMzvFMXWS1dMtjRRAnDhRmDizA6tV93nwiUutnZ0nSn
 7TURh2Y89SFxsS1Pcr7nhTnl6YmfJkAGU9JZzt/MZ4LCeF+sRL1H02d+jlgiyyIthfh3
 ZctQ==
X-Gm-Message-State: AOAM531gBfzqErsvX13AvJtxm1D+PHcto1UbFwsdQAwTXqQ0MqFFhHio
 SHqR/Vh1PCwUQW1EhEW4ydunH4T0hoe7PDKqQuu8aXZ565fxzmAEqGKmEeLqhU2ITZwp7mN0mqu
 OnP/4P94yEvMRABeBbz8c4HmQeAFwRv+hnCuEssB7cw==
X-Received: by 2002:a17:906:e84:: with SMTP id
 p4mr15763325ejf.30.1614604192827; 
 Mon, 01 Mar 2021 05:09:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVJhXvd1r87NrEXVme020OJ9jS0KWZ6LRIEfuqwLPYtfd7cF/O1cpz/wBHfKS/9oGVDVnn8Q==
X-Received: by 2002:a17:906:e84:: with SMTP id
 p4mr15763314ejf.30.1614604192672; 
 Mon, 01 Mar 2021 05:09:52 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id y9sm12032907ejd.110.2021.03.01.05.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 05:09:51 -0800 (PST)
Date: Mon, 1 Mar 2021 08:09:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated
 random MAC address
Message-ID: <20210301080731-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDk6MDg6MjhBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDA1OjExOjIzUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiAKPiA+IE9uIDIwMjEvMi8yNCAyOjE4IOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+ID4gPiBGcm9tOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiA+ID4gCj4gPiA+
IFVzZSBhIHJhbmRvbWx5IGdlbmVyYXRlZCBNQUMgYWRkcmVzcyB0byBiZSBhcHBsaWVkIGluIGNh
c2UgaXQgaXMgbm90Cj4gPiA+IGNvbmZpZ3VyZWQgYnkgbWFuYWdlbWVudCB0b29sLgo+ID4gPiAK
PiA+ID4gVGhlIHZhbHVlIHF1ZXJpZWQgdGhyb3VnaCBtbHg1X3F1ZXJ5X25pY192cG9ydF9tYWNf
YWRkcmVzcygpIGlzIG5vdAo+ID4gPiByZWxlbGF2bnQgdG8gdmRwYSBzaW5jZSBpdCBpcyB0aGUg
bWFjIHRoYXQgc2hvdWxkIGJlIHVzZWQgYnkgdGhlIHJlZ3VsYXIKPiA+ID4gTklDIGRyaXZlci4K
PiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+
ID4gPiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+ID4gCj4g
PiAKPiA+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gCj4g
PiAKPiA+ID4gLS0tCj4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwg
NSArLS0tLQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlv
bnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gaW5kZXgg
YjY3YmJhNTgxZGZkLi5lY2UyMTgzZTdiMjAgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiA+ID4gQEAgLTIwMDUsMTAgKzIwMDUsNyBAQCBzdGF0aWMgaW50IG1seDVf
dmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5h
bWUpCj4gPiA+ICAgCWlmIChlcnIpCj4gPiA+ICAgCQlnb3RvIGVycl9tdHU7Cj4gPiA+IC0JZXJy
ID0gbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgY29uZmlnLT5t
YWMpOwo+ID4gPiAtCWlmIChlcnIpCj4gPiA+IC0JCWdvdG8gZXJyX210dTsKPiA+ID4gLQo+ID4g
PiArCWV0aF9yYW5kb21fYWRkcihjb25maWctPm1hYyk7Cj4gCj4gSSB0aGluayB0aGlzIHBhdGNo
IGlzIG1pc3Npbmcgc2V0dGluZyBWSVJUSU9fTkVUX0ZfTVRVLiBJIHdpbGwgcG9zdCB2Mgo+IHdp
dGggdGhlIG90aGVyIGZpeGVzIGluIHRoaXMgc2VyaWVzLgoKSSBkb24ndCByZWFsbHkgdW5kZXJz
dGFuZCB3aHkgdGhpcyBpcyBhIGdvb2QgaWRlYS4KCklmIHVzZXJzcGFjZSB3YW50cyBhIHJhbmRv
bSBtYWMgaXQgY2FuIHNldCBpdCwgd2l0aCB0aGlzCnBhdGNoIGl0IGlzIGltcG9zc2libGUgdG8g
a25vdyB3aGV0aGVyIHRoZSBtYWMgaXMKYSBoYXJkd2FyZSBvbmUgKHdoaWNoIHdpbGwgYmUgcGVy
c2lzdGVudCBlLmcuIGFjcm9zcyByZWJvb3RzKQpvciBhIHJhbmRvbSBvbmUuCgpFLmcuIHRoZXJl
IGlzIGEgcGF0Y2ggY29uZmlndXJpbmcgYSB1c2Vyc3BhY2Ugc3VwcGxpZWQKbWFjIGlmIHRoZSBo
YXJkd2FyZSBtYWMgaXMgemVyby4KClRoaXMgcGF0Y2ggd2lsbCBicmVhayBpdC4KCj4gPiA+ICAg
CW12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2LT5kZXZpY2U7Cj4gPiA+ICAgCWVyciA9IG1seDVf
dmRwYV9hbGxvY19yZXNvdXJjZXMoJm5kZXYtPm12ZGV2KTsKPiA+ID4gICAJaWYgKGVycikKPiA+
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
