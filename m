Return-Path: <SRS0=5hAK=ME=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41552C07E9C
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 03:08:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CD660FE9
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 03:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CD660FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BF586071A;
	Mon, 12 Jul 2021 03:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppd0vh-PLvIG; Mon, 12 Jul 2021 03:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D57B66059C;
	Mon, 12 Jul 2021 03:07:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5442C001A;
	Mon, 12 Jul 2021 03:07:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 757DFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 03:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CB95401B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 03:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAfTpAfcwmhi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 03:07:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12428400C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 03:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626059275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DigXiH/LTULD0RvNd551qqlSUUAL5xHAN7DKU/yDOVs=;
 b=QPXxG3OyZXCbZI8aUNQ0sU+1eQG2yB8FZ4MnKwvOpkJLmCfQcjiE4lTiiN4cqYlF3AoA85
 m8D8HIo0PU2TYYQ9S/5WERlc20BQrjE4aEQ2VdS3pMv/Cl8KX0Xq5aiHl9HO6889psQkdP
 sETKkWZkh9kpEfjH9tvk15k28msHAJM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-1KCNluOoOxm8hNHGdPO8Ag-1; Sun, 11 Jul 2021 23:07:54 -0400
X-MC-Unique: 1KCNluOoOxm8hNHGdPO8Ag-1
Received: by mail-pf1-f198.google.com with SMTP id
 j10-20020a056a00174ab029031e1e93e88dso11754431pfc.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Jul 2021 20:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DigXiH/LTULD0RvNd551qqlSUUAL5xHAN7DKU/yDOVs=;
 b=Y+lo2SfMovkkzPDfCGbB2Nc9sA5JPWqebL9CxXRHf21NzeMLCfSRl1hzZ8O4OxVAM7
 u07mpFhLbSeUN79oD+FOFddcgzqjEXP9TFH0G1apLxuBfDXHftSUoFyKdWXBvTubQ4cV
 pIVgbb1iCcuWfOVIw/LR7kSmz71MbM7k/H0E6ESfCaWZ5KL6CVgLxfieYGMTQs2BtM2S
 GPGMt5qINUgYa3/ALXJMZisP0mpN05j8LQeJDpSgUMD3QsliokHP/3nEpRbbSNztwoOq
 IGHUn7Jhp/OA/MUW9W16YNh0ldQxzayOfgB1IoCkANUkI1OhywX8MlG8s2zKIBVmmQnN
 lCmQ==
X-Gm-Message-State: AOAM531Px537dTTJgbD6Ch3qLtctU0V4r1lsxOfNaSVkCfVUF3VTVshY
 HblOjYI3WNitKVnT30pd0tRjqJhfP3p+wZGNj41RMd8YI1LBLLP4mh/FeXas2isnwCFC5dGIsDD
 PqiEFVKgudXRXZnCCMCAtAlVz2P3Cc9T8JXRkQEcEFA==
X-Received: by 2002:a17:902:7489:b029:129:c0d3:96ca with SMTP id
 h9-20020a1709027489b0290129c0d396camr23766929pll.46.1626059273334; 
 Sun, 11 Jul 2021 20:07:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxESf9PbVdwF/2IJoYJMIgdbQYf4I6nxhfXcDxjtsXifXfkOeknetHp4Hd3RPbbf5QVI0UF5A==
X-Received: by 2002:a17:902:7489:b029:129:c0d3:96ca with SMTP id
 h9-20020a1709027489b0290129c0d396camr23766914pll.46.1626059273074; 
 Sun, 11 Jul 2021 20:07:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j15sm11693382pjl.15.2021.07.11.20.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jul 2021 20:07:52 -0700 (PDT)
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
 <20210506123829.GA403858@infradead.org>
 <20210514063516-mutt-send-email-mst@kernel.org>
 <8bf22db2-97d4-9f88-8b6b-d685fd63ac8b@redhat.com>
 <20210711120627-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e2b4c614-746f-e81b-bb0b-d84f0efd381f@redhat.com>
Date: Mon, 12 Jul 2021 11:07:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711120627-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, xieyongji@bytedance.com,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzcvMTIg5LiK5Y2IMTI6MDgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
T24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDE6Mzg6MDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4g5ZyoIDIwMjEvNS8xNCDkuIvljYg3OjEzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGT
Ogo+Pj4gT24gVGh1LCBNYXkgMDYsIDIwMjEgYXQgMDE6Mzg6MjlQTSArMDEwMCwgQ2hyaXN0b3Bo
IEhlbGx3aWcgd3JvdGU6Cj4+Pj4gT24gVGh1LCBNYXkgMDYsIDIwMjEgYXQgMDQ6MTI6MTdBTSAt
MDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+PiBMZXQncyB0cnkgZm9yIGp1c3Qg
YSBiaXQsIHdvbid0IG1ha2UgdGhpcyB3aW5kb3cgYW55d2F5Ogo+Pj4+Pgo+Pj4+PiBJIGhhdmUg
YW4gb2xkIGlkZWEuIEFkZCBhIHdheSB0byBmaW5kIG91dCB0aGF0IHVubWFwIGlzIGEgbm9wCj4+
Pj4+IChvciBtb3JlIGV4YWN0bHkgZG9lcyBub3QgdXNlIHRoZSBhZGRyZXNzL2xlbmd0aCkuCj4+
Pj4+IFRoZW4gaW4gdGhhdCBjYXNlIGV2ZW4gd2l0aCBETUEgQVBJIHdlIGRvIG5vdCBuZWVkCj4+
Pj4+IHRoZSBleHRyYSBkYXRhLiBIbW0/Cj4+Pj4gU28gd2UgYWN0dWFsbHkgZG8gaGF2ZSBhIGNo
ZWNrIGZvciB0aGF0IGZyb20gdGhlIGVhcmx5IGRheXMgb2YgdGhlIERNQQo+Pj4+IEFQSSwgYnV0
IGl0IG9ubHkgd29ya3MgYXQgY29tcGlsZSB0aW1lOiBDT05GSUdfTkVFRF9ETUFfTUFQX1NUQVRF
Lgo+Pj4+Cj4+Pj4gQnV0IGdpdmVuIGhvdyByYXJlIGNvbmZpZ3Mgd2l0aG91dCBhbiBpb21tdSBv
ciBzd2lvdGxiIGFyZSB0aGVzZSBkYXlzCj4+Pj4gaXQgaGFzIHN0b3BwZWQgdG8gYmUgdmVyeSB1
c2VmdWwuICBVbmZvcnR1bmF0ZWx5IGEgcnVudGltZS12ZXJzaW9uIGlzCj4+Pj4gbm90IGVudGly
ZWx5IHRyaXZpYWwsIGJ1dCBtYXliZSBpZiB3ZSBhbGxvdyBmb3IgZmFsc2UgcG9zaXRpdmVzIHdl
Cj4+Pj4gY291bGQgZG8gc29tZXRoaW5nIGxpa2UgdGhpcwo+Pj4+Cj4+Pj4gYm9vbCBkbWFfZGly
ZWN0X25lZWRfc3RhdGUoc3RydWN0IGRldmljZSAqZGV2KQo+Pj4+IHsKPj4+PiAJLyogc29tZSBh
cmVhcyBjb3VsZCBub3QgYmUgY292ZXJlZCBieSBhbnkgbWFwIGF0IGFsbCAqLwo+Pj4+IAlpZiAo
ZGV2LT5kbWFfcmFuZ2VfbWFwKQo+Pj4+IAkJcmV0dXJuIGZhbHNlOwo+Pj4+IAlpZiAoZm9yY2Vf
ZG1hX3VuZW5jcnlwdGVkKGRldikpCj4+Pj4gCQlyZXR1cm4gZmFsc2U7Cj4+Pj4gCWlmIChkbWFf
ZGlyZWN0X25lZWRfc3luYyhkZXYpKQo+Pj4+IAkJcmV0dXJuIGZhbHNlOwo+Pj4+IAlyZXR1cm4g
KmRldi0+ZG1hX21hc2sgPT0gRE1BX0JJVF9NQVNLKDY0KTsKPj4+PiB9Cj4+Pj4KPj4+PiBib29s
IGRtYV9uZWVkX3N0YXRlKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+PiB7Cj4+Pj4gCWNvbnN0IHN0
cnVjdCBkbWFfbWFwX29wcyAqb3BzID0gZ2V0X2RtYV9vcHMoZGV2KTsKPj4+Pgo+Pj4+IAlpZiAo
ZG1hX21hcF9kaXJlY3QoZGV2LCBvcHMpKQo+Pj4+IAkJcmV0dXJuIGRtYV9kaXJlY3RfbmVlZF9z
dGF0ZShkZXYpOwo+Pj4+IAlyZXR1cm4gb3BzLT51bm1hcF9wYWdlIHx8Cj4+Pj4gCQlvcHMtPnN5
bmNfc2luZ2xlX2Zvcl9jcHUgfHwgb3BzLT5zeW5jX3NpbmdsZV9mb3JfZGV2aWNlOwo+Pj4+IH0K
Pj4+IFllYSB0aGF0IHNvdW5kcyBsaWtlIGEgZ29vZCBpZGVhLiBXZSB3aWxsIG5lZWQgdG8gZG9j
dW1lbnQgdGhhdC4KPj4+Cj4+Pgo+Pj4gU29tZXRoaW5nIGxpa2U6Cj4+Pgo+Pj4gLyoKPj4+ICAg
ICogZG1hX25lZWRfc3RhdGUgLSByZXBvcnQgd2hldGhlciB1bm1hcCBjYWxscyB1c2UgdGhlIGFk
ZHJlc3MgYW5kIGxlbmd0aAo+Pj4gICAgKiBAZGV2OiBkZXZpY2UgdG8gZ3VlcnkKPj4+ICAgICoK
Pj4+ICAgICogVGhpcyBpcyBhIHJ1bnRpbWUgdmVyc2lvbiBvZiBDT05GSUdfTkVFRF9ETUFfTUFQ
X1NUQVRFLgo+Pj4gICAgKgo+Pj4gICAgKiBSZXR1cm4gdGhlIHZhbHVlIGluZGljYXRpbmcgd2hl
dGhlciBkbWFfdW5tYXBfKiBhbmQgZG1hX3N5bmNfKiBjYWxscyBmb3IgdGhlIGRldmljZQo+Pj4g
ICAgKiB1c2UgdGhlIERNQSBzdGF0ZSBwYXJhbWV0ZXJzIHBhc3NlZCB0byB0aGVtLgo+Pj4gICAg
KiBUaGUgRE1BIHN0YXRlIHBhcmFtZXRlcnMgYXJlOiBzY2F0dGVyL2dhdGhlciBsaXN0L3RhYmxl
LCBhZGRyZXNzIGFuZAo+Pj4gICAgKiBsZW5ndGguCj4+PiAgICAqCj4+PiAgICAqIElmIGRtYV9u
ZWVkX3N0YXRlIHJldHVybnMgZmFsc2UgdGhlbiBETUEgc3RhdGUgcGFyYW1ldGVycyBhcmUKPj4+
ICAgICogaWdub3JlZCBieSBhbGwgZG1hX3VubWFwXyogYW5kIGRtYV9zeW5jXyogY2FsbHMsIHNv
IGl0IGlzIHNhZmUgdG8gcGFzcyAwIGZvcgo+Pj4gICAgKiBhZGRyZXNzIGFuZCBsZW5ndGgsIGFu
ZCBETUFfVU5NQVBfU0dfVEFCTEVfSU5WQUxJRCBhbmQKPj4+ICAgICogRE1BX1VOTUFQX1NHX0xJ
U1RfSU5WQUxJRCBmb3Igcy9nIHRhYmxlIGFuZCBsZW5ndGggcmVzcGVjdGl2ZWx5Lgo+Pj4gICAg
KiBJZiBkbWFfbmVlZF9zdGF0ZSByZXR1cm5zIHRydWUgdGhlbiBETUEgc3RhdGUgbWlnaHQKPj4+
ICAgICogYmUgdXNlZCBhbmQgc28gdGhlIGFjdHVhbCB2YWx1ZXMgYXJlIHJlcXVpcmVkLgo+Pj4g
ICAgKi8KPj4+Cj4+PiBBbmQgd2Ugd2lsbCBuZWVkIERNQV9VTk1BUF9TR19UQUJMRV9JTlZBTElE
IGFuZAo+Pj4gRE1BX1VOTUFQX1NHX0xJU1RfSU5WQUxJRCBhcyBwb2ludGVycyB0byBhbiBlbXB0
eSBnbG9iYWwgdGFibGUgYW5kIGxpc3QKPj4+IGZvciBjYWxscyBzdWNoIGFzIGRtYV91bm1hcF9z
Z3RhYmxlIHRoYXQgZGVyZWZlcmVuY2UgcG9pbnRlcnMgYmVmb3JlIGNoZWNraW5nCj4+PiB0aGV5
IGFyZSB1c2VkLgo+Pj4KPj4+Cj4+PiBEb2VzIHRoaXMgbG9vayBnb29kPwo+Pj4KPj4+IFRoZSB0
YWJsZS9sZW5ndGggdmFyaWFudHMgYXJlIGZvciBjb25zaXN0ZW5jeSwgdmlydGlvIHNwZWNpZmlj
YWxseSBkb2VzCj4+PiBub3QgdXNlIHMvZyBhdCB0aGUgbW9tZW50LCBidXQgaXQgc2VlbXMgbmlj
ZXIgdGhhbiBsZWF2aW5nCj4+PiB1c2VycyB3b25kZXIgd2hhdCB0byBkbyBhYm91dCB0aGVzZS4K
Pj4+Cj4+PiBUaG91Z2h0cz8gSmFzb24gd2FudCB0byB0cnkgaW1wbGVtZW50aW5nPwo+Pgo+PiBJ
IGNhbiBhZGQgaXQgaW4gbXkgdG9kbyBsaXN0IG90aGVyIGlmIG90aGVyIHBlb3BsZSBhcmUgaW50
ZXJlc3RlZCBpbiB0aGlzLAo+PiBwbGVhc2UgbGV0IHVzIGtub3cuCj4+Cj4+IEJ1dCB0aGlzIGlz
IGp1c3QgYWJvdXQgc2F2aW5nIHRoZSBlZmZvcnRzIG9mIHVubWFwIGFuZCBpdCBkb2Vzbid0IGVs
aW1pbmF0ZQo+PiB0aGUgbmVjZXNzYXJ5IG9mIHVzaW5nIHByaXZhdGUgbWVtb3J5IChhZGRyLCBs
ZW5ndGgpIGZvciB0aGUgbWV0YWRhdGEgZm9yCj4+IHZhbGlkYXRpbmcgdGhlIGRldmljZSBpbnB1
dHMuCj4KPiBCZXNpZGVzIHVubWFwLCB3aHkgZG8gd2UgbmVlZCB0byB2YWxpZGF0ZSBhZGRyZXNz
PwoKClNvcnJ5LCBpdCdzIG5vdCB2YWxpZGF0aW5nIGFjdHVhbGx5LCB0aGUgZHJpdmVyIGRvZXNu
J3QgZG8gYW55IAp2YWxpZGF0aW9uLiBBcyB0aGUgc3ViamVjdCwgdGhlIGRyaXZlciB3aWxsIGp1
c3QgdXNlIHRoZSBtZXRhZGF0YSBzdG9yZWQgCmluIHRoZSBkZXNjX3N0YXRlIGluc3RlYWQgb2Yg
dGhlIG9uZSBzdG9yZWQgaW4gdGhlIGRlc2NyaXB0b3IgcmluZy4KCgo+ICAgbGVuZ3RoIGNhbiBi
ZQo+IHR5cGljYWxseSB2YWxpZGF0ZWQgYnkgc3BlY2lmaWMgZHJpdmVycyAtIG5vdCBhbGwgb2Yg
dGhlbSBldmVuIHVzZSBpdCAuLgo+Cj4+IEFuZCBqdXN0IHRvIGNsYXJpZnksIHRoZSBzbGlnaHQg
cmVncmVzc2lvbiB3ZSBzZWUgaXMgdGVzdGluZyB3aXRob3V0Cj4+IFZJUlRJT19GX0FDQ0VTU19Q
TEFURk9STSB3aGljaCBtZWFucyBETUEgQVBJIGlzIG5vdCB1c2VkLgo+IEkgZ3Vlc3MgdGhpcyBp
cyBkdWUgdG8gZXh0cmEgY2FjaGUgcHJlc3N1cmU/CgoKWWVzLgoKCj4gTWF5YmUgY3JlYXRlIHll
dCBhbm90aGVyCj4gYXJyYXkganVzdCBmb3IgRE1BIHN0YXRlIC4uLgoKCkknbSBub3Qgc3VyZSBJ
IGdldCB0aGlzLCB3ZSB1c2UgdGhpcyBiYXNpY2FsbHk6CgpzdHJ1Y3QgdnJpbmdfZGVzY19leHRy
YSB7CiDCoMKgwqDCoMKgwqDCoCBkbWFfYWRkcl90IGFkZHI7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC8qIEJ1ZmZlciBETUEgYWRkci4gKi8KIMKgwqDCoMKgwqDCoMKgIHUzMiBsZW47
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBCdWZmZXIg
bGVuZ3RoLiAqLwogwqDCoMKgwqDCoMKgwqAgdTE2IGZsYWdzO8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBEZXNjcmlwdG9yIGZsYWdzLiAqLwogwqDCoMKgwqDC
oMKgwqAgdTE2IG5leHQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogVGhlIG5leHQgZGVzYyBzdGF0ZSBpbiBhIApsaXN0LiAqLwp9OwoKRXhjZXB0IGZvciB0
aGUgIm5leHQiIHRoZSByZXN0IGFyZSBhbGwgRE1BIHN0YXRlLgoKVGhhbmtzCgoKPgo+PiBTbyBJ
IHdpbGwgZ28gdG8gcG9zdCBhIGZvcm1hbCB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIGFuZCB3ZSBj
YW4gc3RhcnQgZnJvbQo+PiB0aGVyZS4KPj4KPj4gVGhhbmtzCj4+Cj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
