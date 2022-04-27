Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDCAC433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 04:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05DD182F11;
	Wed, 27 Apr 2022 04:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ngx4slmwJD7c; Wed, 27 Apr 2022 04:05:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4EA0782ACA;
	Wed, 27 Apr 2022 04:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34545C0039;
	Wed, 27 Apr 2022 04:05:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64984C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52864400D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9pYPE2XWHIP0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:05:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7434640017
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651032335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI2D7xQGQPORWCdvPh4NHGqLdP0i5IRZXFjtfHEyKNI=;
 b=KX+ZS9QnJj1STCz6JT5g5I9C7zemLTr+KIZURFFSIeGqI0sciXRhljVkfQD2X6qNyUcyH9
 en3qQpL1Hurd6d4IG8TiOfNvW0Oa97USY2Q8/IX9UBlsJUxql9HxB0lIdd/gq6nYUDGpsY
 b/vxRh19T8OFpbCKGmG/DzRZjIwNj20=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-Noh90a1KPV6-Wy_bQv2XXA-1; Wed, 27 Apr 2022 00:05:33 -0400
X-MC-Unique: Noh90a1KPV6-Wy_bQv2XXA-1
Received: by mail-pj1-f70.google.com with SMTP id
 o16-20020a17090ab89000b001d84104fc2cso1946930pjr.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 21:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OI2D7xQGQPORWCdvPh4NHGqLdP0i5IRZXFjtfHEyKNI=;
 b=ypgknt5hYgWhx5VmqzwXEidLTXNTHIpqbOid548bJCTKHTOTYpsjG3OeWWKQD5bm9P
 xypxNcrcsUDG0Ra69vJfxrgu+9cG+eR03MNCrE9ldBaLk3YvzozjtMES4WBXmZrn3JFf
 LSpTc0o9vEfFmtA11kLusZs0J+7bfLHkzx1h3M1vIKTTRTnRLdU7n3YW+OE9bohNj6Yk
 XJaxJ9/ctoVlFZku40YTrHMahGRzQq+TAenSQ5je+8t24+kJ0BYYmGLbEb1QjyuB6XmC
 Hcv/9fTODqYTYs15XXnzmnwhe0l30/2CChQCw4dj+ZEOBCNBu2v5pptHKlnTZDkQRv7I
 REpQ==
X-Gm-Message-State: AOAM533RH/ldVIHtDwdeBunlWK3v0VVieTTinf528PMZcjv5gK15VZB2
 TNo70MksOevW54HLpABamN/EQqZ+xV8P9ScoYZp4g8G+VJz+MQQ9K2to/h3ERgsNR19UHDmHxhQ
 8Ocg5d+nDfQgoPhB2eDQqC5bMjE0Pv0EXRDe7WU4Kxw==
X-Received: by 2002:a63:d449:0:b0:399:365e:d13e with SMTP id
 i9-20020a63d449000000b00399365ed13emr22146212pgj.96.1651032332548; 
 Tue, 26 Apr 2022 21:05:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi/YAPoTV3Di7OG/IjOmSo+U2UvRJCAn0OBXSlF/ljnz/il+13VVFaxFxNujygNbmvYKEaBg==
X-Received: by 2002:a63:d449:0:b0:399:365e:d13e with SMTP id
 i9-20020a63d449000000b00399365ed13emr22146195pgj.96.1651032332231; 
 Tue, 26 Apr 2022 21:05:32 -0700 (PDT)
Received: from [10.72.12.60] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a17090a1f4900b001cd498dc153sm5089742pjy.3.2022.04.26.21.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 21:05:31 -0700 (PDT)
Message-ID: <b10af1ae-d396-6694-8f1d-4a3769a84494@redhat.com>
Date: Wed, 27 Apr 2022 12:05:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/2] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To: Cindy Lu <lulu@redhat.com>
References: <20220425062735.172576-2-lulu@redhat.com>
 <CACGkMEtGZqoei6i=LmVrTgNfWM4SpxjQH-8j7BP=EoFO=iqeYw@mail.gmail.com>
 <CACLfguUmEEdJzPTsR9h-N=rVa4ktT8s6=aBsJ_MdRRy24LRyMg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACLfguUmEEdJzPTsR9h-N=rVa4ktT8s6=aBsJ_MdRRy24LRyMg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

CuWcqCAyMDIyLzQvMjcgMDk6NTgsIENpbmR5IEx1IOWGmemBkzoKPiBPbiBUdWUsIEFwciAyNiwg
MjAyMiBhdCAyOjA1IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
PiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAyOjI3IFBNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Pj4gdGhpcyBwYXRjaCBpcyB0byBhZGQgdGhlIHN1cHBvcnQgZm9yIHZkcGEg
dG9vbCBpbiB2cF92ZHBhCj4+PiBoZXJlIGlzIHRoZSBleGFtcGxlIHN0ZXBzCj4+Pgo+Pj4gbW9k
cHJvYmUgdnBfdmRwYQo+Pj4gbW9kcHJvYmUgdmhvc3RfdmRwYQo+Pj4gZWNobyAwMDAwOjAwOjA2
LjA+L3N5cy9idXMvcGNpL2RyaXZlcnMvdmlydGlvLXBjaS91bmJpbmQKPj4+IGVjaG8gMWFmNCAx
MDQxID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvdnAtdmRwYS9uZXdfaWQKPj4+Cj4+PiB2ZHBhIGRl
diBhZGQgbmFtZSB2ZHBhMSBtZ210ZGV2IHBjaS8wMDAwOjAwOjA2LjAKPj4+Cj4+PiBTaWduZWQt
b2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMv
dmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyB8IDEzOCArKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlv
bnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRw
YS5jIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4+PiBpbmRleCBjY2UxMDFl
NmE5NDAuLjg3MzQwMjk3NzU0MyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9f
cGNpL3ZwX3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5j
Cj4+PiBAQCAtMzIsNyArMzIsOCBAQCBzdHJ1Y3QgdnBfdnJpbmcgewo+Pj4KPj4+ICAgc3RydWN0
IHZwX3ZkcGEgewo+Pj4gICAgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlIHZkcGE7Cj4+PiAtICAg
ICAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgbWRldjsKPj4+ICsgICAgICAgLyog
dGhpcyBpcyBhbiBwb2ludGVyIHBvaW50IHRvIHRoZSBtZGV2IGluIHZwX3ZkcGFfbWdtdGRldiov
Cj4+PiArICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXY7Cj4+IFRo
ZSBjb2RlIGNhbiBleHBsYWluIGl0c2VsZiwgc28gdGhlIGNvbW1lbnQgaXMgcmVkdW5kYW50Lgo+
Pgo+IHN1cmUgd2xsIHJlbW92ZSB0aGlzLgo+Pj4gICAgICAgICAgc3RydWN0IHZwX3ZyaW5nICp2
cmluZzsKPj4+ICAgICAgICAgIHN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNvbmZpZ19jYjsKPj4+ICAg
ICAgICAgIGNoYXIgbXNpeF9uYW1lW1ZQX1ZEUEFfTkFNRV9TSVpFXTsKPj4+IEBAIC00MSw2ICs0
MiwxMiBAQCBzdHJ1Y3QgdnBfdmRwYSB7Cj4+PiAgICAgICAgICBpbnQgdmVjdG9yczsKPj4+ICAg
fTsKPj4+Cj4+PiArc3RydWN0IHZwX3ZkcGFfbWdtdGRldiB7Cj4+PiArICAgICAgIHN0cnVjdCB2
ZHBhX21nbXRfZGV2IG1ndGRldjsKPj4+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJu
X2RldmljZSBtZGV2Owo+PiBJIHRoaW5rIGNvdXBsaW5nIGl0IHdpdGggbWdtdCBkZXZpY2UgaXMg
cHJvYmFibHkgbm90IGdvb2QsIGFueSByZWFzb24KPj4gd2UgY2FuJ3QgYWxsb2NhdGUgaXQgaW5k
ZXBlbmRlbnRseT8KPj4KPiB5ZXMgSSBhbHNvIHRoaW5rIGl0IG1ha2UgY29kZSBjb25mdXNlZCwg
IGJ1dCB3ZSBuZWVkIHRvIGluaXQgIGl0IGluCj4gc3RhdGljIGludCB2cF92ZHBhX3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4gYW5k
IHRoZW4gIHBhc3MgaXQgdG8KPiBzdGF0aWMgaW50IHZwX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRw
YV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICBjb25zdCBzdHJ1Y3Qg
dmRwYV9kZXZfc2V0X2NvbmZpZyAqYWRkX2NvbmZpZykKPiB0aGUgb25seSBzdHJ1Y3Qgd2UgY2Fu
IHVzZSBpcyBzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCAgbm90IHN1cmUKPiBpZiB3ZSBo
YXZlCj4gc29tZSBiZXR0ZXIgY2hvaWNlID8KCgpJIHRoaW5rIHdlIGNhbiBqdXN0IGFsbG9jYXRl
IGl0IGFuZCBhc3NpZ24gaXQgdG8gdmRwYV9tZ210X2RldiBzdHJ1Y3R1cmU/CgpzdHJ1Y3QgdnBf
dmRwYV9tZ210ZGV2IHsKIMKgwqDCoCBzdHVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1k
ZXY7Cn07CgpUaGFua3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pj4gKyAgICAgICBzdHJ1Y3QgdnBfdmRw
YSAqdnBfdmRwYTsKPj4+ICt9OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
