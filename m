Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0B7C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:07:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15F564E16
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 18:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15F564E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 562D32305A;
	Fri,  5 Feb 2021 18:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DVWiQDpSWFU; Fri,  5 Feb 2021 18:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2478820367;
	Fri,  5 Feb 2021 18:07:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DFCFC08A1;
	Fri,  5 Feb 2021 18:07:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04F97C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E800387370
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkKqr6-yWEnQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:07:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 91BBC87362
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612548424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxMeTZ/n+Vn7dQU1j1tpbmFULO4aEKZmIFDiE1FTlAw=;
 b=LZTRCn3BrwCOeh/rEhQtMLT+vn4n3JEUv2EFpi6AMz1XJV+/MudMTb29IQU4syJr2+oxyJ
 ltNowIGijHxfn0SY+oB8ALE09iyz0QHrm8N54qxJgbvA4HE0wtKYtY1k/OYAwwGYQQ2zbO
 TgfwyeBq27gRSzFiZBDkPg3E6yhHj4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-qv9tseWRPwKhlDFB9khcBg-1; Fri, 05 Feb 2021 13:07:02 -0500
X-MC-Unique: qv9tseWRPwKhlDFB9khcBg-1
Received: by mail-wm1-f69.google.com with SMTP id h25so3144252wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 10:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IxMeTZ/n+Vn7dQU1j1tpbmFULO4aEKZmIFDiE1FTlAw=;
 b=CRVPHpaZdzW+6nolQbU8+DE+Rrbxaf+nfyllG113ieApfujFMkT+2RDCE9RFjX9yCV
 Wf/XnPN41Csc/5GV5f1lCU6lm00w0Wj8vFU9M5qFyeQ15iLqohsq3Ug6fvnETAWVk0xL
 FdbZJu1XEr4DXQdjA8udaiqSVTElfZsV/zgkF5qM2J7CWG4ry1APP+jAVgYuOfvu6WQW
 Vn41l9g0szqht7rnKQu4giHJEf2e2sNGaRSNhlxi3uyRfcGwj2ZDotrgfUDxcGxbmIEb
 SciOhPuhPWFcVP2+WCbCzrxl9fxN/T07TnEwLTz+y6T1PWAjm0LFY4SIaYIVskuM6tsu
 LRbQ==
X-Gm-Message-State: AOAM530aY4EANrs8tTZ/DsPO4m8ZND6PESyGmm1w2LFplPXaWA7lcxfD
 mEyPI5xq+w1Wq+PNdCHbNqu9nEPqUx1N9YmokCvLuXtvb8N+dnQGX6SCIfMk0LCNPO2OFOj8gnb
 exQPWs8VF27IpnjsD0/CO4U2Ggz1D0RxUfinMTxZkcQ==
X-Received: by 2002:adf:f647:: with SMTP id x7mr6176354wrp.160.1612548421619; 
 Fri, 05 Feb 2021 10:07:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9mO7p2mb6binBIQPLBJQ4QFCHvu/+u1ljqwZ7soxl9KQgsExNxcqKPsHS6dmprbR05F+aXA==
X-Received: by 2002:adf:f647:: with SMTP id x7mr6176341wrp.160.1612548421486; 
 Fri, 05 Feb 2021 10:07:01 -0800 (PST)
Received: from amorenoz.users.ipa.redhat.com ([94.73.56.18])
 by smtp.gmail.com with ESMTPSA id r12sm13451334wrp.13.2021.02.05.10.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Feb 2021 10:07:00 -0800 (PST)
Subject: Re: [PATCH iproute2-next v3 0/5] Add vdpa device management tool
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 dsahern@gmail.com, stephen@networkplumber.org, mst@redhat.com
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
 <99106d07-1730-6ed8-c847-0400be0dcd57@redhat.com>
 <1d1ff638-d498-6675-ead5-6e09213af3a8@redhat.com>
 <0017c3d7-9b04-d26c-94e2-485e4da6a778@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
Message-ID: <765b73c5-b3a1-99b0-0e3c-a23a38aedf60@redhat.com>
Date: Fri, 5 Feb 2021 19:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <0017c3d7-9b04-d26c-94e2-485e4da6a778@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=amorenoz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CgpPbiAyLzUvMjEgNDo0MCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiAKPiBPbiAyMDIxLzIvNCDk
uIvljYg3OjE1LCBBZHJpYW4gTW9yZW5vIHdyb3RlOgo+PiBTb3JyeSBJIGhhdmUgbm90IGZvbGxv
d2VkIHRoaXMgd29yayBhcyBjbG9zZSBhcyBJIHdvdWxkIGhhdmUgd2FudGVkLgo+PiBTb21lIHF1
ZXN0aW9ucyBiZWxvdy4KPj4KPj4gT24gMi80LzIxIDQ6MTYgQU0sIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBPbiAyMDIxLzIvMiDkuIvljYg2OjM1LCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4gTGlu
dXggdmRwYSBpbnRlcmZhY2UgYWxsb3dzIHZkcGEgZGV2aWNlIG1hbmFnZW1lbnQgZnVuY3Rpb25h
bGl0eS4KPj4+PiBUaGlzIGluY2x1ZGVzIGFkZGluZywgcmVtb3ZpbmcsIHF1ZXJ5aW5nIHZkcGEg
ZGV2aWNlcy4KPj4+Pgo+Pj4+IHZkcGEgaW50ZXJmYWNlIGFsc28gaW5jbHVkZXMgc2hvd2luZyBz
dXBwb3J0ZWQgbWFuYWdlbWVudCBkZXZpY2VzCj4+Pj4gd2hpY2ggc3VwcG9ydCBzdWNoIG9wZXJh
dGlvbnMuCj4+Pj4KPj4+PiBUaGlzIHBhdGNoc2V0IGluY2x1ZGVzIGtlcm5lbCB1YXBpIGhlYWRl
cnMgYW5kIGEgdmRwYSB0b29sLgo+Pj4+Cj4+Pj4gZXhhbXBsZXM6Cj4+Pj4KPj4+PiAkIHZkcGEg
bWdtdGRldiBzaG93Cj4+Pj4gdmRwYXNpbToKPj4+PiDCoMKgwqAgc3VwcG9ydGVkX2NsYXNzZXMg
bmV0Cj4+Pj4KPj4+PiAkIHZkcGEgbWdtdGRldiBzaG93IC1qcAo+Pj4+IHsKPj4+PiDCoMKgwqDC
oMKgICJzaG93Ijogewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAidmRwYXNpbSI6IHsKPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic3VwcG9ydGVkX2NsYXNzZXMiOiBbICJuZXQiIF0K
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+IH0KPj4+Pgo+
PiBIb3cgY2FuIGEgdXNlciBlc3RhYmxpc2ggdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGEgbWdt
dGRldiBhbmQgaXQncyBwYXJlbnQKPj4gZGV2aWNlIChwY2kgdmYsIHNmLCBldGMpPwo+IAo+IAo+
IFBhcmF2IHNob3VsZCBrbm93IG1vcmUgYnV0IEkgdHJ5IHRvIGFuc3dlci4KPiAKPiBJIHRoaW5r
IHRoZXJlIHNob3VsZCBiZSBCREYgaW5mb3JtYXRpb24gaW4gdGhlIG1nbXRkZXYgc2hvdyBjb21t
YW5kIGlmIHRoZQo+IHBhcmVudCBpcyBhIFBDSSBkZXZpY2UsIG9yIHdlIGNhbiBzaW1wbHkgc2hv
dyB0aGUgcGFyZW50IGhlcmU/Cj4gCj4gCj4+Cj4+Pj4gQ3JlYXRlIGEgdmRwYSBkZXZpY2Ugb2Yg
dHlwZSBuZXR3b3JraW5nIG5hbWVkIGFzICJmb28yIiBmcm9tCj4+Pj4gdGhlIG1hbmFnZW1lbnQg
ZGV2aWNlIHZkcGFzaW1fbmV0Ogo+Pj4+Cj4+Pj4gJCB2ZHBhIGRldiBhZGQgbWdtdGRldiB2ZHBh
c2ltX25ldCBuYW1lIGZvbzIKPj4+Pgo+PiBJIGd1ZXNzIHRoaXMgY29tbWFuZCB3aWxsIGFjY2Vw
dCBhICd0eXBlJyBwYXJhbWV0ZXIgb25jZSBtb3JlIHN1cHBvcnRlZF9jbGFzc2VzCj4+IGFyZSBh
ZGRlZD8KPiAKPiAKPiBUaGlzIGNvdWxkIGJlIGV4dGVuZGVkIGluIHRoZSBmdXR1cmUuCj4gCj4g
Cj4+Cj4+IEFsc28sIHdpbGwgdGhpcyB0b29sIGFsc28gaGFuZGxlIHRoZSB2ZHBhIGRyaXZlciBi
aW5kaW5nIG9yIHdpbGwgdGhlIHVzZXIgaGFuZGxlCj4+IHRoYXQgdGhyb3VnaCB0aGUgdmRwYSBi
dXMnIHN5c2ZzIGludGVyZmFjZT8KPiAKPiAKPiBJIHRoaW5rIG5vdCwgaXQncyB0aGUgY29uZmln
dXJhdGlvbiBiZWxvdyB0aGUgdmRwYSBidXMuIFRoZSBzeXNmcyBzaG91bGQgYmUgdGhlCj4gb25s
eSBpbnRlcmZhY2UgZm9yIG1hbmFnaW5nIGRyaXZlciBiaW5kaW5nLgo+IApVbmRlcnN0b29kLCB0
aGFua3MuCgotLSAKQWRyacOhbiBNb3Jlbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
