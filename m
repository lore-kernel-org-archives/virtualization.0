Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D18FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 07:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAC18827D2;
	Wed, 12 Jan 2022 07:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O64YeYZ1AX2C; Wed, 12 Jan 2022 07:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 623288276E;
	Wed, 12 Jan 2022 07:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F454C002F;
	Wed, 12 Jan 2022 07:53:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BADEC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 830BA6FB76
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jw-YQ2JumMAE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B30DD6FB4F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641973986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ns9t0MBpHKEo9l+PjwNtwXiT/Qp5fHMZFtVVafL1/oM=;
 b=CSuBthrserbck+o/NhB58OnhxGCVjMm31LH0GFunQMTwdnKf5SS81Qs8gCAwC5NzEBGRtD
 uIAMp4E6e9Gzp3SQYPeToFOaVxzUxYHsD5z6t8F/VHC1fLRzDpIiXGQwjITZo1+ow1lLh9
 5pPvr/HX1NUpv9AN6u98d15p+91T7pE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-DFny-ibdNKilddggEe5QvA-1; Wed, 12 Jan 2022 02:53:04 -0500
X-MC-Unique: DFny-ibdNKilddggEe5QvA-1
Received: by mail-lf1-f72.google.com with SMTP id
 i16-20020a056512319000b00425efb1c65eso1099520lfe.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 23:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ns9t0MBpHKEo9l+PjwNtwXiT/Qp5fHMZFtVVafL1/oM=;
 b=PlHZAlCAeIpgIAa6FOamcixN9o6evV7Ri8QeMubnsYPOJuo+HjQZmC4eiTzzLBR5FG
 v78/4ahQ2lDRRYC4iNflCXQM3B6HsxrDNTU2GL1mYHg9i060rCZjFaMVNXVVNIKhdrBK
 jUrdaHuM6QUYzGMemsb6yXORhjUsJkjzw1kXNq5uBljEekO9Qp+j81+dLQxBAy/3c6wR
 sv8IbxrrgkVrvp2Dj0eRg3IW6RVEhav5FJUqrEKjZccWKnfDoPmzin4o4tjX3W/fTS6T
 Q9CQ7rN51bvkoswAk6g+XTIOcd7hfyMGi4wuaP+A8lvhsurf/X2La3k3TKFplD0xu9qe
 u2mA==
X-Gm-Message-State: AOAM532hG5xw9c+Y1xbeZR0EXHgF7AoHgtthadSmgLy+3Vi5X23hXR3u
 ngh1WzqebmXeBPwN+X0owMiTIyM4aC6mHH8Tr6ECEBWQMOXMGFIYRLnmR7GREe8fZNxQZp1dh64
 ajvNzRofmfJYWq2Gyw/zrgDH54/jT6M+3eoF+KYHfa5h98VaIz0GqBMdGoA==
X-Received: by 2002:a2e:b791:: with SMTP id n17mr5365913ljo.307.1641973983389; 
 Tue, 11 Jan 2022 23:53:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAS4eHnu7EzgPGuaFqm3MShiZCtBix4yIV1Kh9Y6VlrHnXbAYcHpDgkdS6SvoHCzGG98EktTkkUuZ0bogSlY4=
X-Received: by 2002:a2e:b791:: with SMTP id n17mr5365902ljo.307.1641973983187; 
 Tue, 11 Jan 2022 23:53:03 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
 <20220112013018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220112013018-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 15:52:52 +0800
Message-ID: <CACGkMEs6u7o4pX4ahvnfPByt1BrSfmaFfEKm5pQJsjjH+XHYxw@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgMjozMCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgSmFuIDEyLCAyMDIyIGF0IDEwOjIzOjA3QU0g
KzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCA3OjUy
IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4g
PiBPbiBUdWUsIEphbiAxMSwgMjAyMiBhdCAxMTozNjo0MkFNICswODAwLCDmnY7kuJzljYcgd3Jv
dGU6Cj4gPiA+ID4gV2hlbiB2aXJ0aW8gdmRwYSBkZXZpY2UgcmVtb3ZlZCwgdGhlIGFibm9ybWFs
IGRhbWFnZSBvZiB0aGUgZGV2aWNlIGNhbm5vdCBiZQo+ID4gPiA+IHBlcmNlaXZlZCBub3JtYWxs
eSwgd2hpY2ggd2lsbCBjYXVzZSBwcm9ibGVtcyBzaW1pbGFyIHRvOgo+ID4gPiA+Cj4gPiA+ID4g
NDNiYjQwYzViOTI2Cj4gPiA+Cj4gPiA+Cj4gPiA+IFNob3VsZCBpbmNsdWRlIHRoZSBzdWJqZWN0
IG9mIHRoZSBwYXRjaCB0b28uCj4gPiA+Cj4gPiA+ID4gSGVuY2UsIGFkZCB0aGUgYWJpbGl0eSB0
byBhYm9ydCB0aGUgY29tbWFuZCBvbiBzdXJwcmlzZSByZW1vdmFsCj4gPiA+ID4KPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBkb25nc2hlbmcgbGkgPGxpZG9uZ3NoZW5nQGRheXVkcHUuY29tPgo+ID4g
Pgo+ID4gPiBXaGVuIHJlbW92aW5nIGdyYWNlZnVsbHksCj4gPiA+IEkgYW0gbm90IHN1cmUgd2Ug
c2hvdWxkIGJyZWFrIGRldmljZSB1bmNvbmRpdGlvbmFsbHkgbGlrZSB0aGlzCj4gPiA+IGJlZm9y
ZSBnaXZpbmcgZHJpdmVycyBhIGNoYW5jZSB0byBjbGVhbiB1cC4KPiA+ID4gU2hvdWxkIHdlIGp1
c3QgZG8gaXQgZm9yIHN1cnByaXNlIHJlbW92YWw/Cj4gPgo+ID4gVGhhdCByZXF1aXJlcyBhIG5l
dyBtZXRob2QgdG8gcXVlcnkgd2hldGhlciBpdCdzIGEgc3VycHJpc2UgcmVtb3ZhbC4KPiA+Cj4g
PiBUaGFua3MKPgo+IFdlIGNhbiBjaGVjayBwY2lfZGV2aWNlX2lzX3ByZXNlbnQgbGlrZSB2aXJ0
aW8gZG9lcy4KClRob3VnaCB0aGUgUENJIGRldmljZSBpcyB0aGUgbWFpbiB1c2VyLCB3ZSBhcmUg
dmRwYSB0cmFuc3BvcnQgdGhhdCBpcwp1bmF3YXJlIG9mIHRoZSB0eXBlIG9mIGl0cyBwYXJlbnQu
CgpTbyBpdCBsb29rcyB0byBtZSB3ZSBuZWVkIGEgbmV3IG1ldGhvZCBhbmQgUENJIHBhcmVudCBh
bmQgZG8gY2FsbCB0aGlzCmZ1bmN0aW9uIHdoZW4gbmVlZGVkLgoKVGhhbmtzCgo+Cj4gPiA+Cj4g
PiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAxICsKPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPiA+ID4KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb192ZHBhLmMKPiA+ID4gPiBpbmRleCA0YTlkZGI0NGIyYTcuLmZkOTMwNDA5ZDE5MCAxMDA2
NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiA+ID4gKysr
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gPiA+IEBAIC0zNzQsNiArMzc0LDcg
QEAgc3RhdGljIHZvaWQgdmlydGlvX3ZkcGFfcmVtb3ZlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSkKPiA+ID4gPiAgewo+ID4gPiA+ICAgc3RydWN0IHZpcnRpb192ZHBhX2RldmljZSAqdmRfZGV2
ID0gdmRwYV9nZXRfZHJ2ZGF0YSh2ZHBhKTsKPiA+ID4gPgo+ID4gPiA+ICsgdmlydGlvX2JyZWFr
X2RldmljZSh2ZF9kZXYtPnZkZXYpOwo+ID4gPiA+ICAgdW5yZWdpc3Rlcl92aXJ0aW9fZGV2aWNl
KCZ2ZF9kZXYtPnZkZXYpOwo+ID4gPiA+ICB9Cj4gPiA+ID4KPiA+ID4gPiAtLQo+ID4gPiA+IDIu
MTcuMQo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
