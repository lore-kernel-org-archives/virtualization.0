Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCCC07E95
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 04:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100CC61CB3
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 04:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CC61CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0FFA83408;
	Wed,  7 Jul 2021 04:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9D3ADLjj7fI; Wed,  7 Jul 2021 04:04:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B2A383264;
	Wed,  7 Jul 2021 04:04:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17762C001A;
	Wed,  7 Jul 2021 04:04:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F121C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 04:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B5FC41D2C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 04:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TLHH_TZjr9ns
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 04:04:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25D1A41D2A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 04:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625630643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kM81Ns444aU40X9VzRic9kVwBUmB+o5BPH9V3KhvnJw=;
 b=YfQNVucN/HI2zfQa1aOnUxUgcallXT4FemzTEILpCujoP/jOKVweVxQGsqfTs1SKTKR/An
 U/fmkUC19UPjc6dWRu1XJBMRbJq9nuuFAlIVqIFn+BfWW2ceZ8KzNXvwD5soYwjU0KHUY9
 bJ1IMnpRNfvC5UMnwammkw8np0wd55o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-1iuPpdgzMemVuE_E4QFNYA-1; Wed, 07 Jul 2021 00:04:02 -0400
X-MC-Unique: 1iuPpdgzMemVuE_E4QFNYA-1
Received: by mail-pg1-f198.google.com with SMTP id
 p2-20020a63e6420000b02902271082c631so771755pgj.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jul 2021 21:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kM81Ns444aU40X9VzRic9kVwBUmB+o5BPH9V3KhvnJw=;
 b=A3g1zwS9MvKcd25g9lFenYC0VhQ+b/mFBJS3yloR8UfzlyVEKOtbDUQTNFHk/tAuMn
 Y5Bm1Pc2+LJ+d9aeCcQQHTfSzHv3g5VvhYodDKIpnIz/5CeukI5GMWzbgsXkq2F4N/pd
 JyIC2SnL5SI1BPsYdC6SD/l3myfESMVnxw9G0uDXMhLRfV1CN3lKQp0vyPf6M+mRrqhR
 AMgkItVul5ucg7k6qB/g+YiCMP1tShp/IqZSUHSAhRhFBvzPvsamycEJeB1RE4Nv+IKu
 leHhWtcxrNGLIMoUuYVV22XY/gs/x/i+gDux0l+JITnW35bnSLqvEMMhA0u6vdLUuU8b
 o0kg==
X-Gm-Message-State: AOAM530VWHnMx3oneqdYZ0AlunygS+Cg2ETVmO1ce9DN/ECQxSUE1p0r
 FcxKfeDG1QIuon9dECplPgDo2zvwyxBK5mD9QK9GtuxVl84fXI3th4BfyVh8jO7JUiVhwgpJP62
 lj9jrj2G9cUSTqkWIMdmks1/uOQhlArfWa0hQ/BuByw==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr3761982pjb.133.1625630641390; 
 Tue, 06 Jul 2021 21:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzipFEXuVqYiGPcn1kt1rnoQEw3aoSEM4FvPWCKr0gz3QKgPTbgtwuGKAY66Ev+exS/YsKY6Q==
X-Received: by 2002:a17:90a:390d:: with SMTP id
 y13mr3761960pjb.133.1625630641139; 
 Tue, 06 Jul 2021 21:04:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f193sm9838899pfa.185.2021.07.06.21.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jul 2021 21:04:00 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com"
 <mst@redhat.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
 <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
 <da0c4e7f-8b59-51ed-f694-04fe5a9ed0b9@redhat.com>
 <PH0PR12MB548102128B368BBE47F5F000DC1F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <386cf5c8-2f1f-8891-2448-5b6e98f51ea2@redhat.com>
 <PH0PR12MB548128DD7A4DC7441981809ADC1B9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dd5373af-3bfb-7222-dffc-dbb394284a00@redhat.com>
Date: Wed, 7 Jul 2021 12:03:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548128DD7A4DC7441981809ADC1B9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>
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

CuWcqCAyMDIxLzcvNyDkuIrljYgxOjA3LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+Cj4+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IE1vbmRheSwgSnVseSA1
LCAyMDIxIDEwOjA1IEFNCj4+Cj4+IOWcqCAyMDIxLzcvMiDkuIvljYgyOjA0LCBQYXJhdiBQYW5k
aXQg5YaZ6YGTOgo+Pj4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+
Pj4gU2VudDogVGh1cnNkYXksIEp1bHkgMSwgMjAyMSAxOjEzIFBNCj4+Pj4KPj4+Pgo+Pj4+IEFj
dHVhbGx5IGl0IGRlcGVuZHMgb24gd2hhdCBhdHRyaWJ1dGVzIGlzIHJlcXVpcmVkIGZvciBidWls
ZGluZyB0aGUgY29uZmlnLgo+Pj4+Cj4+Pj4gV2UgY2FuIHNpbXBseSByZXVzZSB0aGUgZXhpc3Rp
bmcgdmlydGlvX25ldF9jb25maWcsIGlmIG1vc3Qgb2YgdGhlCj4+Pj4gZmllbGRzIGFyZSByZXF1
aXJlZC4KPj4+Pgo+Pj4+IHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZ19zZXQgewo+Pj4+ICAgIMKg
wqDCoCDCoMKgwqAgX192aXJ0aW82NCBmZWF0dXJlczsKPj4+PiAgICDCoMKgwqAgwqDCoMKgIHVu
aW9uIHsKPj4+PiAgICDCoMKgwqAgwqDCoMKgIMKgwqDCoCBzdHJ1Y3QgdmlydGlvX25ldF9jb25m
aWc7Cj4+Pj4gICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgX192aXJ0aW82NCByZXNlcnZlZFs2NF07
Cj4+Pj4gICAgwqDCoMKgIMKgwqDCoCB9Cj4+Pj4gfTsKPj4+Pgo+Pj4+IElmIG9ubHkgZmV3IG9m
IHRoZSBpcyByZXF1aXJlZCwgd2UgY2FuIGp1c3QgcGljayB0aGVtIGFuZCB1c2UgYW5vdGhlcgo+
Pj4+IHN0cnVjdHVyZS4KPj4+IFRoZSBwb2ludCBpcyB3ZSBkZWZpbmUgc3RydWN0dXJlIGJhc2Vk
IG9uIGN1cnJlbnQgZmllbGRzLiBUb21vcnJvdyBhIG5ldwo+PiBSU1Mgb3Igcnggc2NhbGluZyBz
Y2hlbWUgYXBwZWFycywgYW5kIHN0cnVjdHVyZSBzaXplIG1pZ2h0IG5lZWQgY2hhbmdlLgo+Pj4g
QW5kIGl0IGRlbWFuZHMgdXMgdG8gZ28gYmFjayB0byBsZW5ndGggYmFzZWQgdHlwZWNhc3Rpbmcg
Y29kZS4KPj4+IGFuZCB0byBhdm9pZCBzb21lIGxlbmd0aCBjaGVjayB3ZSBwaWNrIHNvbWUgYXJi
aXRyYXJ5IHNpemUgcmVzZXJ2ZWQKPj4gd29yZHMuCj4+PiBBbmQgSSBkbyBub3Qga25vdyB3aGF0
IG5ldHdvcmsgcmVzZWFyY2ggZ3JvdXAgd2lsbCBjb21lIHVwIGZvciBuZXcgcnNzCj4+IGFsZ29y
aXRobSBhbmQgbmVlZGVkIHBsdW1iaW5nLgo+Pgo+Pgo+PiBZZXMsIGJ1dCBhcyBkaXNjdXNzZWQs
IHdlIG1heSBzdWZmZXIgdGhlIHNpbWlsYXIgaXNzdWUgYXQgdGhlIGRldmljZSBsZXZlbC4gRS5n
Cj4+IHdlIG5lZWQgYSBjb21tYW5kIHRvIGxldCBQRiB0byAiYnVpbGQiIHRoZSBjb25maWcgZm9y
IGEgVkYgb3IgU0YuCj4gSSBhbSBub3Qgc3VyZS4KPiBDdXJyZW50IHNjb3BlIG9mIGEgVkRQQSBp
cywgb25jZSB0aGVyZSBpcyBhIGhhcyBQRixWRixTRiBhbmQgeW91IGNvbmZpZ3VyZSBvciBjcmVh
dGUgYSB2ZHBhIGRldmljZSBvdXQgb2YgaXQuCj4KPj4+IEdpdmVuIHRoZSBkZXZpY2UgY29uZmln
IGlzIG5vdCBzcGVsbGVkIG91dCBpbiB0aGUgdmlydGlvIHNwZWMsIG1heSBiZSB3ZSBjYW4KPj4g
d2FpdCBmb3IgaXQgdG8gZGVmaW5lIHZpcnRpbyBtYW5hZ2VtZW50IGludGVyZmFjZS4KPj4KPj4g
WWVzLgo+IFdhaXQgaXMgbmVlZGVkIG9ubHkgaWYgd2Ugd2FudCB0byBjYXN0IFUtPksgVUFQSSBp
biBhIHN0cnVjdHVyZSB3aGljaCBpcyBib3VuZCB0byBldm9sdmUuCj4gQW5kIGhlbmNlIEkganVz
dCB3YW50IHRvIGV4Y2hhbmdlIGFzIGluZGl2aWR1YWwgZmllbGRzLgo+Cj4+Pj4gSXQncyBub3Qg
YXJiaXRyYXJ5IGJ1dCB3aXRoIGZpeGVkIGxlbmd0aC4KPj4+IEl0cyBmaXhlZCwgYnV0IGRlY2lk
ZWQgYXJiaXRyYXJpbHkgbGFyZ2UgaW4gYW50aWNpcGF0aW9uIHRoYXQgd2UgbGlrZWx5IG5lZWQg
dG8KPj4gZ3Jvdy4KPj4+IEFuZCBzb21ldGltZXMgdGhhdCBmYWxsIHNob3J0IHdoZW4gbmV4dCBy
ZXNlYXJjaCBjb21lcyB1cCB3aXRoIG1vcmUKPj4gY3JlYXRpdmUgdGhvdWdodHMuCj4+Cj4+Cj4+
IEhvdyBhYm91dCBzb21ldGhpbmcgbGlrZSBUTFZzIGluIHRoZSB2aXJ0aW8gc3BlYyB0aGVuPwo+
IFBvc3NpYmx5IHllcy4KPj4KPj4+PiBJdCBtYXkgb25seSB3b3JrIGZvciBuZXRsaW5rICh3aXRo
IHNvbWUgZHVwbGljYXRpb24gd2l0aCB0aGUgZXhpc3RpbmcKPj4+PiB2aXJ0aW8gdUFQSSkuIElm
IHdlIGNhbiBzb2x2ZSBpdCBhdCBnZW5lcmFsIHZpcnRpbyBsYXllciwgaXQgd291bGQgYmUKPj4+
PiBiZXR0ZXIuIE90aGVyd2lzZSB3ZSBuZWVkIHRvIGludmVudCB0aGVtIGFnYWluIGluIHRoZSB2
aXJ0aW8gc3BlYy4KPj4+Pgo+Pj4gVmlydGlvIHNwZWMgd2lsbCBsaWtlbHkgZGVmaW5lIHdoYXQg
c2hvdWxkIGJlIGNvbmZpZyBmaWVsZHMgdG8gcHJvZ3JhbSBhbmQgaXRzCj4+IGxheW91dC4KPj4+
IEtlcm5lbCBjYW4gYWx3YXlzIGZpbGwgdXAgdGhlIGZvcm1hdCB0aGF0IHZpcnRpbyBzcGVjIGRl
bWFuZHMuCj4+Cj4+IFllcywgSSB3b25kZXIgaWYgeW91IGhhdmUgdGhlIGludGVyZXN0IHRvIHdv
cmsgb24gdGhlIHNwZWMgdG8gc3VwcG9ydCB0aGlzLgo+Pgo+IEkgYW0gaGFwcHkgdG8gY29udHJp
YnV0ZSwgSSBuZWVkIHRvIGFzayBteSBzdXBlcnZpc29yIHRvIHNwZW5kIHNvbWUgdGltZSBpbiB0
aGlzIGFyZWEuCj4gTGV0IG1lIGZpZ3VyZSBvdXQgdGhlIGxvZ2lzdGljcy4KCgpHb29kIHRvIGtu
b3cgdGhhdC4KCgo+Cj4+Pj4gSSB0aGluayBldmVuIGZvciB0aGUgY3VycmVudCBtbHg1ZSB2RFBB
IGl0IHdvdWxkIGJlIGJldHRlciwgb3RoZXJ3aXNlIHdlCj4+Pj4gbWF5IGhhdmU6Cj4+Pj4KPj4+
PiB2RFBBIHRvb2wgLT4gW25ldGxpbmsgc3BlY2lmaWMgdkRQQSBhdHRyaWJ1dGVzKDEpXSAtPiB2
RFBBIGNvcmUgLT4gW3ZEUEEKPj4+PiBjb3JlIHNwZWNpZmljIFZEUEEgYXR0cmlidXRlcygyKV0g
LT4gbWx4NWVfdkRQQSAtPiBbbWx4NWUgc3BlY2lmaWMgdkRQQQo+Pj4+IGF0dHJpYnV0ZXMoMyld
IC0+IG1seDVlX2NvcmUKPj4+Pgo+Pj4+IFdlIG5lZWQgdG8gdXNlIGEgc2luZ2xlIGFuZCB1bmlm
aWVkIHZpcnRpbyBzdHJ1Y3R1cmUgaW4gYWxsIHRoZSAoMSksICgyKQo+Pj4+IGFuZCAoMykuCj4+
PiBUaGlzIGlzIHdoZXJlIEkgZGlmZmVyLgo+Pj4gSXRzIG9ubHkgdmRwYSB0b29sIC0+IHZkcGEg
Y29yZSAtPiB2ZW5kb3JfZHJpdmVyCj4+Pgo+Pj4gVmRwYSB0b29sIC0+IHZkcGEgY29yZSA9IG5l
dGxpbmsgYXR0cmlidXRlCj4+PiBWZHBhIGNvcmUgLT4gdmVuZG9yIGRyaXZlciA9IHN0cnVjdF9m
b28uIChpbnRlcm5hbCBpbnNpZGUgdGhlIGxpbnV4IGtlcm5lbCkKPj4+Cj4+PiBJZiB0b21vcnJv
dyB2aXJ0aW8gc3BlYyBkZWZpbmVzIHN0cnVjdF9mb28gdG8gYmUgc29tZXRoaW5nIGVsc2UsIGtl
cm5lbCBjYW4KPj4gYWx3YXlzIHVwZ3JhZGUgdG8gc3RydWN0X2JhciB3aXRob3V0IHVwZ3JhZGlu
ZyBVQVBJIG5ldGxpbmsgYXR0cmlidXRlcy4KPj4KPj4KPj4gVGhhdCdzIGZpbmUuIE5vdGUgdGhh
dCBhY3R1YWxseSBoYXZlIGFuIGV4dHJhIGxldmVsIGlmIHZlbmRvcl9kcml2ZXIgaXMKPj4gdmly
dGlvLXBjaSB2RFBBIGRyaXZlciAodnBfdmRwYSkuCj4+Cj4+IFRoZW4gd2UgaGF2ZQo+Pgo+PiB2
ZHBhIHRvb2wgLT4gdmRwYSBjb3JlIC0+IHZwX3ZkcGEgLT4gdmlydGlvLXBjaSBkZXZpY2UKPj4K
Pj4gU28gd2Ugc3RpbGwgbmVlZCBpbnZlbnQgY29tbWFuZHMgdG8gY29uZmlndXJlL2J1aWxkIFZG
L1NGIGNvbmZpZyBzcGFjZQo+PiBiZXR3ZWVuIHZwX3ZkcGEgYW5kIHZpcnRpby1wY2kgZGV2aWNl
Lgo+IFllcy4gVGhpcyBpcyBuZWVkZWQsIGJ1dCBhZ2FpbiBsZXRzIGtlZXAgdGhlIHR3byBsYXll
cnMgc2VwYXJhdGUuCj4gSW4gdGhlIGV4YW1wbGUgSSBwcm92aWRlZCwgd2Ugd2lsbCBiZSBhYmxl
IHRvIGZpbGwgdGhlIHN0cnVjdHVyZSBhbmQgcGFzcyB0aGlzIGludGVybmFsbHkgYmV0d2VlbiB2
cF92ZHBhLT52aXJ0aW8gcGNpIGRyaXZlci4KPgo+Cj4+IEFuZCBJIHRoaW5rIHdlIG1heSBzdWZm
ZXIgdGhlCj4+IHNpbWlsYXIgaXNzdWUgYXMgd2UgbWV0IGhlcmUgKHZkcGEgdG9vbCAtPiB2ZHBh
IGNvcmUpLgo+Pgo+Pgo+Pj4gTmV0bGluayBhdHRyaWJ1dGVzIGFkZGl0aW9uIHdpbGwgYmUgbmVl
ZGVkIG9ubHkgd2hlbiBzdHJ1Y3RfZm9vIGhhcyBuZXdlcgo+PiBmaWVsZHMuCj4+PiBUaGlzIHdp
bGwgYmUgc3RpbGwgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmxlLgo+Pj4KPj4+IEFuIGV4YWN0
IGV4YW1wbGUgb2YgdGhpcyBpcyBkcml2ZXJzL25ldC92eGxhbi5jCj4+PiB2eGxhbl9ubDJjb25m
KCkuCj4+PiBBIHZ4bGFuIGRldmljZSBuZWVkcyBWTkksIHNyYyBpcCwgZHN0IGlwLCB0b3MsIGFu
ZCBtb3JlLgo+Pj4gSW5zdGVhZCBvZiBwdXR0aW5nIGFsbCBpbiBzaW5nbGUgc3RydWN0dXJlIHZ4
bGFuX2NvbmZpZyBhcyBVQVBJLCB0aG9zZQo+PiBvcHRpb25hbCBmaWVsZHMgYXJlIG5ldGxpbmsg
YXR0cmlidXRlcy4KPj4+IEFuZCB2eGxhbiBkcml2ZXIgaW50ZXJuYWxseSBmaWxscyB1cCB0aGUg
Y29uZmlnIHN0cnVjdHVyZS4KPj4+Cj4+PiBJIGFtIHZlcnkgbXVjaCBjb252aW5jZWQgd2l0aCB0
aGUgYWJvdmUgdnhsYW4gYXBwcm9hY2ggdGhhdCBlbmFibGVzIGFsbAo+PiBmdW5jdGlvbmFsaXR5
IG5lZWRlZCB3aXRob3V0IHR5cGVjYXN0aW5nIGNvZGUgYW5kIHdpdGhvdXQgZGVmaW5pbmcgYXJi
aXRyYXJ5Cj4+IGxlbmd0aCBzdHJ1Y3RzLgo+Pgo+Pgo+PiBSaWdodCwgYnV0IHdlIGhhZCBzb21l
IHNtYWxsIGRpZmZlcmVuY2VzIGhlcmU6Cj4+Cj4+IDEpIHZ4bGFuIGRvZXNuJ3QgaGF2ZSBhIGV4
aXN0aW5nIHVBUEkKPj4gMikgdnhsYW4gY29uZmlndXJhdGlvbiBpcyBub3QgdXNlZCBmb3IgaGFy
ZHdhcmUKPj4KPiBUcnVlIGJ1dCB2eGxhbiBleGFtcGxlIGRvZXNu4oCZdCBwcmV2ZW50IHRvIGRv
ICMyLgo+Cj4+IEJhc2ljYWxseSwgSSdtIG5vdCBhZ2FpbnN0IHRoaXMgYXBwcm9hY2gsIEkganVz
dCB3b25kZXIgaWYgaXQncwo+PiBiZXR0ZXIvc2ltcGxlciB0byBzb2x2ZSBpdCBhdCB2aXJ0aW8g
bGF5ZXIgYmVjYXVzZSB0aGUgc2VtYW50aWMgaXMKPj4gZGVmaW5lZCBieSB0aGUgc3BlYyBub3Qg
bmV0bGluay4KPiB2ZHBhIGNvcmUgd2lsbCBiZSBhYmxlIHRvIHVzZSB0aGUgdmlydGlvIHNwZWMg
ZGVmaW5lZCBjb25maWcgd2hlbmV2ZXIgaXQgb2NjdXJzLgoKClNvIEkgdGhpbmsgYm90aCBvZiB1
cyBoYXZlIHN0cm9uZyBwb2ludHMuIE1heWJlIGl0J3MgdGhlIHRpbWUgZm9yIApNaWNoYWVsIHRv
IGRlY2lkZSBob3cgaXQgd2lsbCBnby4KCk1pY2hhZWwsIHBsZWFzZSBzaGFyZSB5b3VyIHRob3Vn
aHRzIGhlcmUuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
