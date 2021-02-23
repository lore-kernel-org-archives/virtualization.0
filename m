Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BBBC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:01:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F02B64E22
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02B64E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC7E886578;
	Tue, 23 Feb 2021 10:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-C33SjdBSOa; Tue, 23 Feb 2021 10:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DCE8B86408;
	Tue, 23 Feb 2021 10:01:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE963C000B;
	Tue, 23 Feb 2021 10:01:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C5A0C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13368605BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g00uiyCCV6tp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:01:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD462605AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614074498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fq9fMMA50uXmWN63AH4eeQqewule2njQVz39u52s5qo=;
 b=XKBHD5wfdkUYl7ZxGFoYTGX9FaBwYju/UX77Xcxxzo+jwkzkNGos/lCP7zCu+mC0iPwCMg
 3v7gCvwrdANF42TT6RMh13d/88qf0cR5f+e+hM4JnXHmdmFc4LCEUbyGdbtJjjbsA2a4cl
 7iS/EQKXw7fo/4BQfzVRRg93iRheU1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-KGrES82VNxKMtRJI-uLuTg-1; Tue, 23 Feb 2021 05:01:36 -0500
X-MC-Unique: KGrES82VNxKMtRJI-uLuTg-1
Received: by mail-wr1-f72.google.com with SMTP id u15so7095549wrn.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fq9fMMA50uXmWN63AH4eeQqewule2njQVz39u52s5qo=;
 b=oU78ScbBfywt3SudFQ4GhUY29iIdzHAQHquBFxj/l+s/XgAwHeUbVQQ1QleKzOdk2y
 h4F3qCEiRdjvkkkwSRXQ99ymNmwmYSCkPGXXqncBzLLlCXmxIx4H84mToQ0wvm86wFGy
 nQo1KIBn2jfO0EwHzr+QV6v65AzLWSJkX98Dy20pxNOF68w3UxnqG1+Bno8DnOB3diMk
 BJZ3feyEi6OUgeEz2dNmhYu6un6sTDF92aaF5VEtR+gejavsnAYXiAjZK5pQfwtHIUha
 1v6RAJzfnMCEYfe/FkNJTNbH1YVujZWrkuFD3gNPcI0ZDEAvyXPud+UJ0PaAUc2z3Nww
 e08Q==
X-Gm-Message-State: AOAM532w8+NoEZqcx6FgD9IGNv9+GiG8sbzn/IvSeKM9eYwXLeJgU91F
 vs4dzoHgHqtLQugR9lPCaXKVRx0M8sRrmORBCI4nECmQJZtRRwDN3RmDDt8ISO50Vv3yBHxsxA5
 Ud/5Y1ScSQZmm71mOwYVZQiFz0j7576rWp0ZZ7AU9jA==
X-Received: by 2002:adf:97d5:: with SMTP id t21mr1510154wrb.139.1614074495014; 
 Tue, 23 Feb 2021 02:01:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqzcytawXMdenSafG3a3yvlWPCUdXAY4CQjPGVhSoQqq+a9ZdeDw2NxLx25iW4TucswKLb7Q==
X-Received: by 2002:adf:97d5:: with SMTP id t21mr1510136wrb.139.1614074494799; 
 Tue, 23 Feb 2021 02:01:34 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z11sm2046114wmi.35.2021.02.23.02.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 02:01:33 -0800 (PST)
Date: Tue, 23 Feb 2021 05:01:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223045600-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com
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

T24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMDU6NDY6MjBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjMg5LiL5Y2INToyNSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gTW9uLCBGZWIgMjIsIDIwMjEgYXQgMDk6MDk6MjhBTSAtMDgwMCwgU2ktV2VpIExp
dSB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIDIvMjEvMjAyMSA4OjE0IFBNLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToK
PiA+ID4gPiA+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1
cmVzIGlzIGludm9rZWQKPiA+ID4gPiA+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBm
b3IgbGVnYWN5IGd1ZXN0cyB0byByZXNldAo+ID4gPiA+ID4gZmVhdHVyZXMgdG8gMCwgd2hlbiBj
b25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4gPiA+ID4gPiBhcmUgc2V0
LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4gPiA+
ID4gPiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBjYXNlLgo+ID4gPiA+
ID4gCj4gPiA+ID4gPiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVz
dHMgY291bGQgYWNjZXNzCj4gPiA+ID4gPiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFy
ZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+ID4gPiA+ID4gZmVhdHVyZSBWSVJUSU9fTkVUX0Zf
TVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4gPiA+ID4gPiB3aWxsIHRyeSB0
byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0aGUgY29uZmlnCj4gPiA+
ID4gPiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4gPiA+ID4gCj4gPiA+
ID4gVGhpcyBsb29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4gPiA+ID4gCj4gPiA+ID4gIgo+
ID4gPiA+IAo+ID4gPiA+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1
IG9ubHkgZXhpc3RzIGlmCj4gPiA+ID4gVklSVElPX05FVF9GX01UVSBpcyBzZXQuIFRoaXMgZmll
bGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhlCj4gPiA+ID4gZHJpdmVyIHRvIHVz
ZS4KPiA+ID4gPiAiCj4gPiA+ID4gCj4gPiA+ID4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29ya2Fy
b3VuZCB0aGlzPwo+ID4gPiBJc24ndCB0aGUgY29tbWl0IDQ1MjYzOWE2NGFkOCBpdHNlbGYgaXMg
YSB3b3JrYXJvdW5kIGZvciBsZWdhY3kgZ3Vlc3Q/Cj4gPiA+IAo+ID4gPiBJIHRoaW5rIHRoZSBw
b2ludCBpcywgc2luY2UgdGhlcmUncyBsZWdhY3kgZ3Vlc3Qgd2UnZCBoYXZlIHRvIHN1cHBvcnQs
IHRoaXMKPiA+ID4gaG9zdCBzaWRlIHdvcmthcm91bmQgaXMgdW5hdm9pZGFibGUuIEFsdGhvdWdo
IEkgYWdyZWUgdGhlIHZpb2xhdGluZyBkcml2ZXIKPiA+ID4gc2hvdWxkIGJlIGZpeGVkICh5ZXMs
IGl0J3MgaW4gdG9kYXkncyB1cHN0cmVhbSBrZXJuZWwgd2hpY2ggZXhpc3RzIGZvciBhCj4gPiA+
IHdoaWxlIG5vdykuCj4gPiBPaCAgeW91IGFyZSByaWdodDoKPiA+IAo+ID4gCj4gPiBzdGF0aWMg
aW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiB7Cj4g
PiAgICAgICAgICBpZiAoIXZkZXYtPmNvbmZpZy0+Z2V0KSB7Cj4gPiAgICAgICAgICAgICAgICAg
IGRldl9lcnIoJnZkZXYtPmRldiwgIiVzIGZhaWx1cmU6IGNvbmZpZyBhY2Nlc3MgZGlzYWJsZWRc
biIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOwo+ID4gICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ICAgICAgICAgIH0KPiA+IAo+ID4gICAgICAgICAg
aWYgKCF2aXJ0bmV0X3ZhbGlkYXRlX2ZlYXR1cmVzKHZkZXYpKQo+ID4gICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsKPiA+IAo+ID4gICAgICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewo+ID4gICAgICAgICAgICAgICAgICBpbnQgbXR1
ID0gdmlydGlvX2NyZWFkMTYodmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywKPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10dSkpOwo+ID4g
ICAgICAgICAgICAgICAgICBpZiAobXR1IDwgTUlOX01UVSkKPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9GX01UVSk7Cj4gCj4g
Cj4gSSB3b25kZXIgd2h5IG5vdCBzaW1wbHkgZmFpbCBoZXJlPwoKQmFjayBpbiAyMDE2IGl0IHdl
bnQgbGlrZSB0aGlzOgoKCU9uIFRodSwgSnVuIDAyLCAyMDE2IGF0IDA1OjEwOjU5UE0gLTA0MDAs
IEFhcm9uIENvbm9sZSB3cm90ZToKCT4gKyAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewoJPiArICAgICAgICAgICAgIGRldi0+bXR1ID0gdmlydGlv
X2NyZWFkMTYodmRldiwKCT4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywKCT4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10dSkpOwoJPiArICAgICB9Cgk+ICsKCT4g
ICAgICAgaWYgKHZpLT5hbnlfaGVhZGVyX3NnKQoJPiAgICAgICAgICAgICAgIGRldi0+bmVlZGVk
X2hlYWRyb29tID0gdmktPmhkcl9sZW47Cgk+IAoKCU9uZSBjb21tZW50IHRob3VnaDogSSB0aGlu
ayB3ZSBzaG91bGQgdmFsaWRhdGUgdGhlIG10dS4KCUlmIGl0J3MgaW52YWxpZCwgY2xlYXIgVklS
VElPX05FVF9GX01UVSBhbmQgaWdub3JlLgoKClRvbyBsYXRlIGF0IHRoaXMgcG9pbnQgOikKCkkg
Z3Vlc3MgaXQncyBhIHdheSB0byB0ZWxsIGRldmljZSAiSSBjYW4gbm90IGxpdmUgd2l0aCB0aGlz
IE1UVSIsCmRldmljZSBjYW4gZmFpbCBGRUFUVVJFU19PSyBpZiBpdCB3YW50cyB0by4gTUlOX01U
VQppcyBhbiBpbnRlcm5hbCBsaW51eCB0aGluZyBhbmQgYXQgdGhlIHRpbWUgSSBmZWx0IGl0J3Mg
YmV0dGVyIHRvCnRyeSB0byBtYWtlIHByb2dyZXNzLgoKCj4gCj4gPiAgICAgICAgICB9Cj4gPiAK
PiA+ICAgICAgICAgIHJldHVybiAwOwo+ID4gfQo+ID4gCj4gPiBBbmQgdGhlIHNwZWMgc2F5czoK
PiA+IAo+ID4gCj4gPiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVuY2UgdG8gaW5p
dGlhbGl6ZSBhIGRldmljZToKPiA+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4gPiAyLiBTZXQgdGhl
IEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgZGV2
aWNlLgo+ID4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dz
IGhvdyB0byBkcml2ZSB0aGUgZGV2aWNlLgo+ID4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRz
LCBhbmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMgdW5kZXJzdG9vZCBieSB0aGUg
T1MgYW5kIGRyaXZlciB0byB0aGUKPiA+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJp
dmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lmaWMgY29u
ZmlndXJhdGlvbgo+ID4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRl
dmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+ID4gNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0
dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcgZmVhdHVyZSBiaXRzIGFmdGVy
IHRoaXMgc3RlcC4KPiA+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZF
QVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5v
dAo+ID4gc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVu
dXNhYmxlLgo+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBk
aXNjb3Zlcnkgb2YgdmlydHF1ZXVlcyBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVyLWJ1cyBz
ZXR1cCwKPiA+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmly
dGlvIGNvbmZpZ3VyYXRpb24gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4g
PiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZp
Y2UgaXMg4oCcbGl2ZeKAnS4KPiA+IAo+ID4gCj4gPiBJdGVtIDQgb24gdGhlIGxpc3QgZXhwbGlj
aXRseSBhbGxvd3MgcmVhZGluZyBjb25maWcgc3BhY2UgYmVmb3JlCj4gPiBGRUFUVVJFU19PSy4K
PiA+IAo+ID4gSSBjb25jbHVkZSB0aGF0IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0IG1lYW5zICJz
ZXQgaW4gZGV2aWNlIGZlYXR1cmVzIi4KPiAKPiAKPiBTbyB0aGlzIHByb2JhYmx5IG5lZWQgc29t
ZSBjbGFyaWZpY2F0aW9uLiAiaXMgc2V0IiBpcyB1c2VkIG1hbnkgdGltZXMgaW4gdGhlCj4gc3Bl
YyB0aGF0IGhhcyBkaWZmZXJlbnQgaW1wbGljYXRpb25zLgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4g
Cj4gPiBHZW5lcmFsbHkgaXQgaXMgd29ydGggZ29pbmcgb3ZlciBmZWF0dXJlIGRlcGVuZGVudCBj
b25maWcgZmllbGRzCj4gPiBhbmQgY2hlY2tpbmcgd2hldGhlciB0aGV5IHNob3VsZCBiZSBwcmVz
ZW50IHdoZW4gZGV2aWNlIGZlYXR1cmUgaXMgc2V0Cj4gPiBvciB3aGVuIGZlYXR1cmUgYml0IGhh
cyBiZWVuIG5lZ290aWF0ZWQsIGFuZCBtYWtpbmcgdGhpcyBjbGVhci4KPiA+IAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
