Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB7C433E9
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 15:04:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017AF64E0E
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 15:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017AF64E0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E0A342E12F;
	Fri, 29 Jan 2021 15:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S9cT1bVvMNWq; Fri, 29 Jan 2021 15:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 013712E10B;
	Fri, 29 Jan 2021 15:04:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71AF5C0FA7;
	Fri, 29 Jan 2021 15:04:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C75DC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F247187132
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06cu9ZdJJ07X
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 39C6386B06
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611932645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+CPWGBzXnSVDrgOFc2AuYU5x2iKqoTh2S05wcmnJi8=;
 b=XLShY6Qk/xZNWMCts+Acdv10+AVlWN1PGTJ8SM6BMMVex58wWTfylc3qc3L/OvPdJ0bepX
 wKahPyQgpvfEOWMiYJ/3ZNyzplbyAXF2bJgxlifCBQQUaO6j/s9xLhzwHs/NB4Rl9JhBUR
 nbrzO08VdTVNcKV+h4WfcF6AdcK6RVI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-ZZhKoK9SNTiR6tSL4KH3wg-1; Fri, 29 Jan 2021 10:04:04 -0500
X-MC-Unique: ZZhKoK9SNTiR6tSL4KH3wg-1
Received: by mail-ed1-f70.google.com with SMTP id o19so5024910edq.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=a+CPWGBzXnSVDrgOFc2AuYU5x2iKqoTh2S05wcmnJi8=;
 b=S+ClxLsX4SS7E6NgOE7YHyx/EifJ3syZK7xWIEiheoyILFtxVHJ9m7o+Ka9H61OWCy
 SU1P7xLCVogFwWSGy3CdHGsohpgThElbUTbrJ5HTS9O5i5bMsdn/wnNKuVFnsdviHk1J
 zxOCQXdfsuvMoiiNa0qDU/ykR/maa+8wcWsqEijXzp1fS3TVYtxUtZe5zR9P/QSjQ37l
 Uc3/fp72iogYeWBvA2GhD9ZHPsvzNpbXhbRich2vb5VgO5UHrJB4/CotjVChSJ55uZOk
 egU8gEAzkLTaerNK2AVuo8bs9TNPTjvkyJ1vqJVZYQ2rEUDNEgWqOxwWy9XkV3529608
 LzZw==
X-Gm-Message-State: AOAM530iuf1S4h7TDNLNeJ1rEBq9npJvnM+8/DEMcQGF9ovRrT5aVZT8
 3yjxflbvenXRbcR7wBHQg0N4rKPm1sdntB17we6JqSJRTVv0ibMVgwdQEeD8eKQI9+tHjoOY2YA
 hpF8EulMBcYufP2iZWbp7OoQsswu7JLkH1+XwOzi/NQ==
X-Received: by 2002:a05:6402:26d3:: with SMTP id
 x19mr5552458edd.0.1611932642903; 
 Fri, 29 Jan 2021 07:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7WYbmHqON7uY/MEpc7YIgnhrWiVrmHO/OpD5YvwzqDFwKihmgYPIO3Nn80HtBAjLeZ0He0A==
X-Received: by 2002:a05:6402:26d3:: with SMTP id
 x19mr5552416edd.0.1611932642664; 
 Fri, 29 Jan 2021 07:04:02 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id m20sm4958538edj.43.2021.01.29.07.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 07:04:01 -0800 (PST)
Date: Fri, 29 Jan 2021 16:03:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC v3 03/11] vdpa: Remove the restriction that only supports
 virtio-net devices
Message-ID: <20210129150359.caitcskrfhqed73z@steredhat>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119045920.447-4-xieyongji@bytedance.com>
 <310d7793-e4ff-fba3-f358-418cb64c7988@redhat.com>
 <20210120110832.oijcmywq7pf7psg3@steredhat>
 <1979cffc-240e-a9f9-b0ab-84a1f82ac81e@redhat.com>
 <20210127085728.j6x5yzrldp2wp55c@steredhat>
 <3cb239f5-fdd5-8311-35a0-c0f50b552521@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3cb239f5-fdd5-8311-35a0-c0f50b552521@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 linux-aio@kvack.org, netdev@vger.kernel.org, rdunlap@infradead.org,
 willy@infradead.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, bob.liu@oracle.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

T24gVGh1LCBKYW4gMjgsIDIwMjEgYXQgMTE6MTE6NDlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8xLzI3IOS4i+WNiDQ6NTcsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj5PbiBXZWQsIEphbiAyNywgMjAyMSBhdCAxMTozMzowM0FNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4KPj4+T24gMjAyMS8xLzIwIOS4i+WNiDc6MDgsIFN0ZWZhbm8gR2FyemFyZWxsYSB3
cm90ZToKPj4+Pk9uIFdlZCwgSmFuIDIwLCAyMDIxIGF0IDExOjQ2OjM4QU0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4+Pj4+Cj4+Pj4+T24gMjAyMS8xLzE5IOS4i+WNiDEyOjU5LCBYaWUgWW9u
Z2ppIHdyb3RlOgo+Pj4+Pj5XaXRoIFZEVVNFLCB3ZSBzaG91bGQgYmUgYWJsZSB0byBzdXBwb3J0
IGFsbCBraW5kcyBvZiB2aXJ0aW8gZGV2aWNlcy4KPj4+Pj4+Cj4+Pj4+PlNpZ25lZC1vZmYtYnk6
IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+Pj4+Pj4tLS0KPj4+Pj4+wqBk
cml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDI5ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+
Pj4+PsKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4+
Pj4+Pgo+Pj4+Pj5kaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+Pj4+Pj5pbmRleCAyOWVkNDE3M2YwNGUuLjQ0OGJlNzg3NWI2ZCAxMDA2NDQK
Pj4+Pj4+LS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+KysrIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPj4+Pj4+QEAgLTIyLDYgKzIyLDcgQEAKPj4+Pj4+wqAjaW5jbHVkZSA8bGludXgv
bm9zcGVjLmg+Cj4+Pj4+PsKgI2luY2x1ZGUgPGxpbnV4L3Zob3N0Lmg+Cj4+Pj4+PsKgI2luY2x1
ZGUgPGxpbnV4L3ZpcnRpb19uZXQuaD4KPj4+Pj4+KyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYmxr
Lmg+Cj4+Pj4+PsKgI2luY2x1ZGUgInZob3N0LmgiCj4+Pj4+PkBAIC0xODUsMjYgKzE4Niw2IEBA
IHN0YXRpYyBsb25nIAo+Pj4+Pj52aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZob3N0X3Zk
cGEgKnYsIHU4IF9fdXNlciAKPj4+Pj4+KnN0YXR1c3ApCj4+Pj4+PsKgwqDCoMKgIHJldHVybiAw
Owo+Pj4+Pj7CoH0KPj4+Pj4+LXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4+Pi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnICpjKQo+Pj4+Pj4tewo+Pj4+
Pj4twqDCoMKgIGxvbmcgc2l6ZSA9IDA7Cj4+Pj4+Pi0KPj4+Pj4+LcKgwqDCoCBzd2l0Y2ggKHYt
PnZpcnRpb19pZCkgewo+Pj4+Pj4twqDCoMKgIGNhc2UgVklSVElPX0lEX05FVDoKPj4+Pj4+LcKg
wqDCoMKgwqDCoMKgIHNpemUgPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsKPj4+
Pj4+LcKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+Pj4twqDCoMKgIH0KPj4+Pj4+LQo+Pj4+Pj4t
wqDCoMKgIGlmIChjLT5sZW4gPT0gMCkKPj4+Pj4+LcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlO
VkFMOwo+Pj4+Pj4tCj4+Pj4+Pi3CoMKgwqAgaWYgKGMtPmxlbiA+IHNpemUgLSBjLT5vZmYpCj4+
Pj4+Pi3CoMKgwqDCoMKgwqDCoCByZXR1cm4gLUUyQklHOwo+Pj4+Pj4tCj4+Pj4+Pi3CoMKgwqAg
cmV0dXJuIDA7Cj4+Pj4+Pi19Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+SSB0aGluayB3ZSBzaG91bGQgdXNl
IGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMuCj4+Pj4KPj4+PkZvciB0aGUgdmRwYS1ibGsgc2lt
dWxhdG9yIEkgaGFkIHRoZSBzYW1lIGlzc3VlcyBhbmQgSSdtIGFkZGluZyAKPj4+PmEgLmdldF9j
b25maWdfc2l6ZSgpIGNhbGxiYWNrIHRvIHZkcGEgZGV2aWNlcy4KPj4+Pgo+Pj4+RG8geW91IHRo
aW5rIG1ha2Ugc2Vuc2Ugb3IgaXMgYmV0dGVyIHRvIHJlbW92ZSB0aGlzIGNoZWNrIGluIAo+Pj4+
dmhvc3QvdmRwYSwgZGVsZWdhdGluZyB0aGUgYm91bmRhcmllcyBjaGVja3MgdG8gCj4+Pj5nZXRf
Y29uZmlnL3NldF9jb25maWcgY2FsbGJhY2tzLgo+Pj4KPj4+Cj4+PkEgcXVlc3Rpb24gaGVyZS4g
SG93IG11Y2ggdmFsdWUgY291bGQgd2UgZ2FpbiBmcm9tIAo+Pj5nZXRfY29uZmlnX3NpemUoKSBj
b25zaWRlciB3ZSBjYW4gbGV0IHZEUEEgcGFyZW50IHRvIHZhbGlkYXRlIHRoZSAKPj4+bGVuZ3Ro
IGluIGl0cyBnZXRfY29uZmlnKCkuCj4+Pgo+Pgo+PkkgYWdyZWUsIG1vc3Qgb2YgdGhlIGltcGxl
bWVudGF0aW9ucyBhbHJlYWR5IHZhbGlkYXRlIHRoZSBsZW5ndGgsIAo+PnRoZSBvbmx5IGdhaW4g
aXMgYW4gZXJyb3IgcmV0dXJuZWQgc2luY2UgZ2V0X2NvbmZpZygpIGlzIHZvaWQsIGJ1dCAKPj5l
dmVudHVhbGx5IHdlIGNhbiBhZGQgYSByZXR1cm4gdmFsdWUgdG8gaXQuCj4KPgo+UmlnaHQsIG9u
ZSBwcm9ibGVtIGhlcmUgaXMgdGhhdC4gRm9yIHRoZSB2aXJpdG8gcGF0aCwgaXRzIGdldF9jb25m
aWcoKSAKPnJldHVybnMgdm9pZC4gU28gd2UgY2FuIG5vdCBwcm9wYWdhdGUgZXJyb3IgdG8gdmly
dGlvIGRyaXZlcnMuIEJ1dCBpdCAKPm1pZ2h0IG5vdCBiZSBhIGJpZyBpc3N1ZSBzaW5jZSB3ZSB0
cnVzdCBrZXJuZWwgdmlydGlvIGRyaXZlci4KPgo+U28gSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0
byBjaGFuZ2UgdGhlIHJldHVybiB2YWx1ZSBpbiB0aGUgdmRwYSBjb25maWcgb3BzLgoKVGhhbmtz
IGZvciB5b3VyIGZlZWRiYWNrIQoKQFhpZSBkbyB5b3UgcGxhbiB0byBkbyB0aGlzPwoKT3RoZXJ3
aXNlIEkgY2FuIGRvIGluIG15IHZkcGEtYmxrLXNpbSBzZXJpZXMsIHdoZXJlIGZvciBub3cgSSB1
c2VkIHRoaXMgCnBhdGNoIGFzIGlzLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
