Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451FC4708F
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 05:38:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A824161411
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 05:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A824161411
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A05060B6C;
	Fri,  4 Jun 2021 05:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWiOZj7eiS1s; Fri,  4 Jun 2021 05:38:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2DD760AF1;
	Fri,  4 Jun 2021 05:38:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0B5BC000E;
	Fri,  4 Jun 2021 05:38:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2995CC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F8394068A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CZalHm_wl-D6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:38:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 122A940686
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622785093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goPsG0ZvybVWv4Ouo01fpZW4lJeP0aNbCe0a5SKG3dU=;
 b=NV9NFg8b14VXo2Qwmqh0i6tnIWwZACRDCl00JdHJPMIsYrAxPlf0lzzOFef0oEPpVsosgE
 jpT9Pc+4meW4RBtpRFcZjOFMYwautjQgfNbUoUKBLbLbdgeO1b4E8TyUUC74L4auvqAXv9
 3aPJERwBcNPmGEWqyG8K3nYITsXDWIs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-beor9GisMyW3gxAmUOikCA-1; Fri, 04 Jun 2021 01:38:12 -0400
X-MC-Unique: beor9GisMyW3gxAmUOikCA-1
Received: by mail-pj1-f72.google.com with SMTP id
 p22-20020a17090a9316b029016a0aced749so4549602pjo.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 22:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=goPsG0ZvybVWv4Ouo01fpZW4lJeP0aNbCe0a5SKG3dU=;
 b=qO9jHFGwAvvfq+o4HjV2qYMYJG4OZpDCs5ib4liNqW6gXXOhLkJkLKzF0xOkaylK1U
 CogJ3xS3xOuA+w8G/veSi8P82m51rSr96iwYd7yEt+TwG1Sz60xzYEqLI1fcg6W8Fd46
 pvb7Dh4CpZxVXk3TUYcAlWLujVyETpqwg7XDwua8ln/P3rChoBx3Jm67pijAvH9D//Iv
 YXgO7o3nX49ZK826WWwk4mWYXpXfNsYC8BChNSLJmUai1VbxbNWmZxwy+2f+SB3Z/rcq
 P8GW7Kvlk47BXZG2QQdavag8P1aOsuQMi4zG2HTzzSrzB3tVzz42UH5u9MsJCeGNpI0l
 JE0Q==
X-Gm-Message-State: AOAM530HR8oc2aOXqvzrU1aS3pLwJK2quf44Z+ETjkdLywoGvzqzks3g
 s0bQWu7+BcwxQfLxvUv0y29CH33n9Z1/FKnEaCu1xPqkSWzv8odNWsg79F+zlnnPFnN0WpFd8/K
 js1dlSBQGBsVckDvcPDqq1ABv3yjypkz5jb3MJ84KDA==
X-Received: by 2002:a65:6209:: with SMTP id d9mr3255081pgv.39.1622785091238;
 Thu, 03 Jun 2021 22:38:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy70jTBX6p7+GIl0R40NevNwtAbPV10fcC1uZ6NrvXldomxW3Rg6jMyVb0NoR4dWeio4VttIg==
X-Received: by 2002:a65:6209:: with SMTP id d9mr3255058pgv.39.1622785090898;
 Thu, 03 Jun 2021 22:38:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e17sm694312pfi.131.2021.06.03.22.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 22:38:10 -0700 (PDT)
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
 <20210506123829.GA403858@infradead.org>
 <20210514063516-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
Date: Fri, 4 Jun 2021 13:38:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210514063516-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8xNCDPws7nNzoxMywgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gVGh1
LCBNYXkgMDYsIDIwMjEgYXQgMDE6Mzg6MjlQTSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3Jv
dGU6Cj4+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDA0OjEyOjE3QU0gLTA0MDAsIE1pY2hhZWwg
Uy4gVHNpcmtpbiB3cm90ZToKPj4+IExldCdzIHRyeSBmb3IganVzdCBhIGJpdCwgd29uJ3QgbWFr
ZSB0aGlzIHdpbmRvdyBhbnl3YXk6Cj4+Pgo+Pj4gSSBoYXZlIGFuIG9sZCBpZGVhLiBBZGQgYSB3
YXkgdG8gZmluZCBvdXQgdGhhdCB1bm1hcCBpcyBhIG5vcAo+Pj4gKG9yIG1vcmUgZXhhY3RseSBk
b2VzIG5vdCB1c2UgdGhlIGFkZHJlc3MvbGVuZ3RoKS4KPj4+IFRoZW4gaW4gdGhhdCBjYXNlIGV2
ZW4gd2l0aCBETUEgQVBJIHdlIGRvIG5vdCBuZWVkCj4+PiB0aGUgZXh0cmEgZGF0YS4gSG1tPwo+
PiBTbyB3ZSBhY3R1YWxseSBkbyBoYXZlIGEgY2hlY2sgZm9yIHRoYXQgZnJvbSB0aGUgZWFybHkg
ZGF5cyBvZiB0aGUgRE1BCj4+IEFQSSwgYnV0IGl0IG9ubHkgd29ya3MgYXQgY29tcGlsZSB0aW1l
OiBDT05GSUdfTkVFRF9ETUFfTUFQX1NUQVRFLgo+Pgo+PiBCdXQgZ2l2ZW4gaG93IHJhcmUgY29u
ZmlncyB3aXRob3V0IGFuIGlvbW11IG9yIHN3aW90bGIgYXJlIHRoZXNlIGRheXMKPj4gaXQgaGFz
IHN0b3BwZWQgdG8gYmUgdmVyeSB1c2VmdWwuICBVbmZvcnR1bmF0ZWx5IGEgcnVudGltZS12ZXJz
aW9uIGlzCj4+IG5vdCBlbnRpcmVseSB0cml2aWFsLCBidXQgbWF5YmUgaWYgd2UgYWxsb3cgZm9y
IGZhbHNlIHBvc2l0aXZlcyB3ZQo+PiBjb3VsZCBkbyBzb21ldGhpbmcgbGlrZSB0aGlzCj4+Cj4+
IGJvb2wgZG1hX2RpcmVjdF9uZWVkX3N0YXRlKHN0cnVjdCBkZXZpY2UgKmRldikKPj4gewo+PiAJ
Lyogc29tZSBhcmVhcyBjb3VsZCBub3QgYmUgY292ZXJlZCBieSBhbnkgbWFwIGF0IGFsbCAqLwo+
PiAJaWYgKGRldi0+ZG1hX3JhbmdlX21hcCkKPj4gCQlyZXR1cm4gZmFsc2U7Cj4+IAlpZiAoZm9y
Y2VfZG1hX3VuZW5jcnlwdGVkKGRldikpCj4+IAkJcmV0dXJuIGZhbHNlOwo+PiAJaWYgKGRtYV9k
aXJlY3RfbmVlZF9zeW5jKGRldikpCj4+IAkJcmV0dXJuIGZhbHNlOwo+PiAJcmV0dXJuICpkZXYt
PmRtYV9tYXNrID09IERNQV9CSVRfTUFTSyg2NCk7Cj4+IH0KPj4KPj4gYm9vbCBkbWFfbmVlZF9z
dGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+IHsKPj4gCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29w
cyAqb3BzID0gZ2V0X2RtYV9vcHMoZGV2KTsKPj4KPj4gCWlmIChkbWFfbWFwX2RpcmVjdChkZXYs
IG9wcykpCj4+IAkJcmV0dXJuIGRtYV9kaXJlY3RfbmVlZF9zdGF0ZShkZXYpOwo+PiAJcmV0dXJu
IG9wcy0+dW5tYXBfcGFnZSB8fAo+PiAJCW9wcy0+c3luY19zaW5nbGVfZm9yX2NwdSB8fCBvcHMt
PnN5bmNfc2luZ2xlX2Zvcl9kZXZpY2U7Cj4+IH0KPiBZZWEgdGhhdCBzb3VuZHMgbGlrZSBhIGdv
b2QgaWRlYS4gV2Ugd2lsbCBuZWVkIHRvIGRvY3VtZW50IHRoYXQuCj4KPgo+IFNvbWV0aGluZyBs
aWtlOgo+Cj4gLyoKPiAgICogZG1hX25lZWRfc3RhdGUgLSByZXBvcnQgd2hldGhlciB1bm1hcCBj
YWxscyB1c2UgdGhlIGFkZHJlc3MgYW5kIGxlbmd0aAo+ICAgKiBAZGV2OiBkZXZpY2UgdG8gZ3Vl
cnkKPiAgICoKPiAgICogVGhpcyBpcyBhIHJ1bnRpbWUgdmVyc2lvbiBvZiBDT05GSUdfTkVFRF9E
TUFfTUFQX1NUQVRFLgo+ICAgKgo+ICAgKiBSZXR1cm4gdGhlIHZhbHVlIGluZGljYXRpbmcgd2hl
dGhlciBkbWFfdW5tYXBfKiBhbmQgZG1hX3N5bmNfKiBjYWxscyBmb3IgdGhlIGRldmljZQo+ICAg
KiB1c2UgdGhlIERNQSBzdGF0ZSBwYXJhbWV0ZXJzIHBhc3NlZCB0byB0aGVtLgo+ICAgKiBUaGUg
RE1BIHN0YXRlIHBhcmFtZXRlcnMgYXJlOiBzY2F0dGVyL2dhdGhlciBsaXN0L3RhYmxlLCBhZGRy
ZXNzIGFuZAo+ICAgKiBsZW5ndGguCj4gICAqCj4gICAqIElmIGRtYV9uZWVkX3N0YXRlIHJldHVy
bnMgZmFsc2UgdGhlbiBETUEgc3RhdGUgcGFyYW1ldGVycyBhcmUKPiAgICogaWdub3JlZCBieSBh
bGwgZG1hX3VubWFwXyogYW5kIGRtYV9zeW5jXyogY2FsbHMsIHNvIGl0IGlzIHNhZmUgdG8gcGFz
cyAwIGZvcgo+ICAgKiBhZGRyZXNzIGFuZCBsZW5ndGgsIGFuZCBETUFfVU5NQVBfU0dfVEFCTEVf
SU5WQUxJRCBhbmQKPiAgICogRE1BX1VOTUFQX1NHX0xJU1RfSU5WQUxJRCBmb3Igcy9nIHRhYmxl
IGFuZCBsZW5ndGggcmVzcGVjdGl2ZWx5Lgo+ICAgKiBJZiBkbWFfbmVlZF9zdGF0ZSByZXR1cm5z
IHRydWUgdGhlbiBETUEgc3RhdGUgbWlnaHQKPiAgICogYmUgdXNlZCBhbmQgc28gdGhlIGFjdHVh
bCB2YWx1ZXMgYXJlIHJlcXVpcmVkLgo+ICAgKi8KPgo+IEFuZCB3ZSB3aWxsIG5lZWQgRE1BX1VO
TUFQX1NHX1RBQkxFX0lOVkFMSUQgYW5kCj4gRE1BX1VOTUFQX1NHX0xJU1RfSU5WQUxJRCBhcyBw
b2ludGVycyB0byBhbiBlbXB0eSBnbG9iYWwgdGFibGUgYW5kIGxpc3QKPiBmb3IgY2FsbHMgc3Vj
aCBhcyBkbWFfdW5tYXBfc2d0YWJsZSB0aGF0IGRlcmVmZXJlbmNlIHBvaW50ZXJzIGJlZm9yZSBj
aGVja2luZwo+IHRoZXkgYXJlIHVzZWQuCj4KPgo+IERvZXMgdGhpcyBsb29rIGdvb2Q/Cj4KPiBU
aGUgdGFibGUvbGVuZ3RoIHZhcmlhbnRzIGFyZSBmb3IgY29uc2lzdGVuY3ksIHZpcnRpbyBzcGVj
aWZpY2FsbHkgZG9lcwo+IG5vdCB1c2Ugcy9nIGF0IHRoZSBtb21lbnQsIGJ1dCBpdCBzZWVtcyBu
aWNlciB0aGFuIGxlYXZpbmcKPiB1c2VycyB3b25kZXIgd2hhdCB0byBkbyBhYm91dCB0aGVzZS4K
Pgo+IFRob3VnaHRzPyBKYXNvbiB3YW50IHRvIHRyeSBpbXBsZW1lbnRpbmc/CgoKSSBjYW4gYWRk
IGl0IGluIG15IHRvZG8gbGlzdCBvdGhlciBpZiBvdGhlciBwZW9wbGUgYXJlIGludGVyZXN0ZWQg
aW4gCnRoaXMsIHBsZWFzZSBsZXQgdXMga25vdy4KCkJ1dCB0aGlzIGlzIGp1c3QgYWJvdXQgc2F2
aW5nIHRoZSBlZmZvcnRzIG9mIHVubWFwIGFuZCBpdCBkb2Vzbid0IAplbGltaW5hdGUgdGhlIG5l
Y2Vzc2FyeSBvZiB1c2luZyBwcml2YXRlIG1lbW9yeSAoYWRkciwgbGVuZ3RoKSBmb3IgdGhlIApt
ZXRhZGF0YSBmb3IgdmFsaWRhdGluZyB0aGUgZGV2aWNlIGlucHV0cy4KCkFuZCBqdXN0IHRvIGNs
YXJpZnksIHRoZSBzbGlnaHQgcmVncmVzc2lvbiB3ZSBzZWUgaXMgdGVzdGluZyB3aXRob3V0IApW
SVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggbWVhbnMgRE1BIEFQSSBpcyBub3QgdXNlZC4K
ClNvIEkgd2lsbCBnbyB0byBwb3N0IGEgZm9ybWFsIHZlcnNpb24gb2YgdGhpcyBzZXJpZXMgYW5k
IHdlIGNhbiBzdGFydCAKZnJvbSB0aGVyZS4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
