Return-Path: <SRS0=LBsv=LT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65543C49EA6
	for <virtualization@archiver.kernel.org>; Fri, 25 Jun 2021 03:28:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0911961248
	for <virtualization@archiver.kernel.org>; Fri, 25 Jun 2021 03:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0911961248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBCCF40004;
	Fri, 25 Jun 2021 03:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASWB9rF0GBPV; Fri, 25 Jun 2021 03:28:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D1EC400EC;
	Fri, 25 Jun 2021 03:28:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01277C001A;
	Fri, 25 Jun 2021 03:28:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94D5AC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F41460630
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VR6-U3QH-UW5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:28:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 627B8605E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624591729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VairKeyVjcikexoImB3iMbPXuWPoHJFTRrLwf6ZrqU=;
 b=i+D0ftK5dk6NnRTdFpv/7K4CrGQ5onwJOjQhOfcT/gktlw8buqhZVSqJcPSZMFRME6KdWc
 UBBHvdWeZLvYuv5Wv6wrFZ/UEWcL5vPwbXi6zgM8nojghLoGvzJyTzCEtJHgAO+gcflhjW
 QfUvwUi3d2tyPmUHi7a2soWW+bIaHSY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-g2DOIzr9MYKZ-6gO9-RPbw-1; Thu, 24 Jun 2021 23:28:47 -0400
X-MC-Unique: g2DOIzr9MYKZ-6gO9-RPbw-1
Received: by mail-pj1-f69.google.com with SMTP id
 e11-20020a17090a77cbb029016f97f61097so4730624pjs.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 20:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7VairKeyVjcikexoImB3iMbPXuWPoHJFTRrLwf6ZrqU=;
 b=mcqDxeX/MmcPk3JMBIBspxHCX7U8IIA+SWwSqiWnRDJoYm1ABfdsEXQleeB1WSi1tK
 rsct/DKceQjBEYn5iE+lCRy5RUf9vU7sok+UFsjWbnAhf7cMydMkfhYZF2baItUKJ6rQ
 B5uhn7DGjnlXFHx1V2xMR+lc0cOcYO34fkAGWXgnpstMZpwfhW/rE8YefpIfkPDLmJDq
 NKQLPO0rpuEpX+AuQdgd/Pxm3tYnw7JfsGXoTtW/Z94kcvgS9GQ1bNJ4cQBhZSQr5NVU
 QHPbrrNm5BJ3g2bYEvQM3sqSemgldB2OmNN0guXO4ANrwwyHAtKUE1wNnssaPpBIz/Kt
 Ia7w==
X-Gm-Message-State: AOAM531xh4gynCS9BS0g/tasaQJm+AKTDT53MM7dbA5yebbAE46ZpgXo
 Q4H/4kBUZWAAHaSwf9K2s8N7Yy6kAM83dvt4bOd++S+uW76NdDkK5Pfv6fTDyxEoa+URlz5tGpn
 4lFzXhFS4yuVELMVoLQAuOFntnc0mP6I5xmrru5QB3Q==
X-Received: by 2002:a63:594f:: with SMTP id j15mr3140811pgm.168.1624591726384; 
 Thu, 24 Jun 2021 20:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlHSUFPCNxtti/TGfDdBKqqcw4TtjT0CbwnxOhvfa9dQO23KRj318cf8FfRVE/hy1HXEmIpw==
X-Received: by 2002:a63:594f:: with SMTP id j15mr3140796pgm.168.1624591726096; 
 Thu, 24 Jun 2021 20:28:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p3sm9627272pjt.0.2021.06.24.20.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 20:28:45 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
Date: Fri, 25 Jun 2021 11:28:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvMjQg5LiL5Y2IMzo1OSwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPgo+PiBGcm9t
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBUaHVyc2RheSwgSnVu
ZSAyNCwgMjAyMSAxMjozNSBQTQo+Pgo+Pj4+IENvbnNpZGVyIHdlIGhhZCBhIG1hdHVyZSBzZXQg
b2YgdmlydGlvIHNwZWNpZmljIHVBUEkgZm9yIGNvbmZpZyBzcGFjZS4KPj4+PiBJdCB3b3VsZCBi
ZSBhIGJ1cmRlbiBpZiB3ZSBuZWVkIGFuIHVubmVjZXNzYXJ5IHRyYW5zbGF0aW9uIGxheWVyIG9m
Cj4+Pj4gbmV0bGluayBpbiB0aGUgbWlkZGxlOgo+Pj4+Cj4+Pj4gW3ZEUEEgcGFyZW50ICh2aXJ0
aW9fbmV0X2NvbmZpZyldIDwtPiBbbmV0bGluawo+Pj4+IChWRFBBX0FUVFJfREVWX05FVF9YWCld
IDwtPiBbdXNlcnNwYWNlCj4+IChWRFBBX0FUVFJfREVWX05FVF9YWCldCj4+Pj4+IDwtPiBbIHVz
ZXIgKHZpcnRpb19uZXRfY29uZmlnKV0KPj4+IFRoaXMgdHJhbnNsYXRpb24gaXMgbm90IHRoZXJl
LiBXZSBzaG93IHJlbGV2YW50IG5ldCBjb25maWcgZmllbGRzIGFzCj4+IFZEUEFfQVRUUl9ERVZf
TkVUIGluZGl2aWR1YWxseS4KPj4+IEl0IGlzIG5vdCBhIGJpbmFyeSBkdW1wIHdoaWNoIGlzIGhh
cmRlciBmb3IgdXNlcnMgdG8gcGFyc2UgYW5kIG1ha2UgYW55IHVzZQo+PiBvZiBpdC4KPj4KPj4K
Pj4gVGhlIGlzIGRvbmUgaW1wbGljaXRseSwgdXNlciBuZWVkcyB0byB1bmRlcnN0YW5kIHRoZSBz
ZW1hbnRpYyBvZgo+PiB2aXJ0aW9fbmV0X2NvbmZpZyBhbmQgbWFwIHRoZSBpbmRpdmlkdWFsIGZp
ZWxkcyB0byB0aGUgdmRwYSB0b29sIHN1Yi0KPj4gY29tbWFuZC4KPiBNb3N0bHkgbm90IHZpcnRp
b19uZXRfY29uZmlnIGlzIGZvciB0aGUgcHJvZHVjZXIgYW5kIGNvbnN1bWVyIHN3IGVudGl0aWVz
Lgo+IEhlcmUgdXNlciBkb2Vzbid0IGtub3cgYWJvdXQgc3VjaCBsYXlvdXQgYW5kIHdoZXJlIGl0
cyBsb2NhdGVkLgo+IFVzZXIgb25seSBzZXRzIGNvbmZpZyBwYXJhbXMgdGhhdCBnZXRzIHNldCBp
biB0aGUgY29uZmlnIHNwYWNlLgo+ICh3aXRob3V0IHVuZGVyc3RhbmRpbmcgd2hhdCBpcyBjb25m
aWcgbGF5b3V0IGFuZCBpdHMgbG9jYXRpb24pLgo+Cj4+Cj4+PiBJdCBpcyBvbmx5IG9uZSBsZXZl
bCBvZiB0cmFuc2xhdGlvbiBmcm9tIHZpcnRpb19uZXRfY29uZmlnIChrZXJuZWwpIC0+IG5ldGxp
bmsKPj4gdmRwYSBmaWVsZHMuCj4+PiBJdCBpcyBzaW1pbGFyIHRvICdzdHJ1Y3QgbmV0ZGV2aWNl
JyAtPiBydG5sIGluZm8gZmllbGRzLgo+Pgo+PiBJIHRoaW5rIG5vdCwgdGhlIHByb2JsZW0gaXMg
dGhhdCB0aGUgbmV0ZGV2aWNlIGlzIG5vdCBhIHBhcnQgb2YgdUFQSSBidXQKPj4gdmlydGlvX25l
dF9jb25maWcgaXMuCj4gVmlydGlvX25ldF9jb25maWcgaXMgYSBVQVBJIGZvciBzdyBjb25zdW1w
dGlvbi4KPiBUaGF0IHdheSB5ZXMsIG5ldGxpbmsgY2FuIGFsc28gZG8gaXQsIGhvd2V2ZXIgaXQg
cmVxdWlyZXMgc2lkZSBjaGFubmVsIGNvbW11bmljYXRlIHdoYXQgaXMgdmFsaWQuCj4KPj4KPj4+
PiBJZiB3ZSBtYWtlIG5ldGxpbmsgc2ltcGx5IGEgdHJhbnNwb3J0LCBpdCB3b3VsZCBiZSBtdWNo
IGVhc2llci4gQW5kIHdlCj4+IGhhZAo+Pj4+IHRoZSBjaGFuY2UgdG8gdW5pZnkgdGhlIGxvZ2lj
IG9mIGJ1aWxkX2NvbmZpZygpIGFuZCBzZXRfY29uZmlnKCkgaW4gdGhlCj4+IGRyaXZlci4KPj4+
IEhvdz8gV2UgbmVlZCBiaXQgbWFzayB0byB0ZWxsIHRoYXQgb3V0IG9mIDIxIGZpZWxkcyB3aGlj
aCBmaWVsZHMgdG8gdXBkYXRlCj4+IGFuZCB3aGljaCBub3QuCj4+PiBBbmQgdGhhdCBpcyBmdXJ0
aGVyIG1peGVkIHdpdGggb2Zmc2V0IGFuZCBsZW5ndGguCj4+Cj4+IFNvIHNldF9jb25maWcoKSBj
b3VsZCBiZSBjYWxsZWQgZnJvbSB1c2Vyc3BhY2UsIHNvIGRpZCBidWlsZF9jb25maWcoKS4KPj4g
VGhlIG9ubHkgZGlmZmVyZW5jZSBpczoKPj4KPj4gMSkgdGhleSdyZSB1c2luZyBkaWZmZXJlbnQg
dHJhbnNwb3J0LCBpb2N0bCB2cyBuZXRsaW5rCj4+IDIpIGJ1aWxkX2NvbmZpZygpIGlzIG9ubHkg
ZXhwZWN0ZWQgdG8gYmUgY2FsbGVkIGJ5IHRoZSBtYW5hZ2VtZW50IHRvb2wKPj4KPj4gSWYgcWVt
dSB3b3JrcyB3ZWxsIHZpYSBzZXRfY29uZmlnIGlvY3RsLCBuZXRsaW5rIHNob3VsZCB3b3JrIGFz
IHdlbGwuCj4+Cj4gbWx4NSBzZXRfY29uZmlnIGlzIG5vb3AuCj4gdmRwYV9zZXRfY29uZmlnKCkg
bmVlZCB0byByZXR1cm4gYW4gZXJyb3IgY29kZS4gSSBkb24ndAo+IHZwX3ZkcGEuYyBibGluZGx5
IHdyaXRlcyB0aGUgY29uZmlnIGFzIGl0cyBwYXNzdGhyb3VnaC4KPiBQYXJzaW5nIHdoaWNoIGZp
ZWxkcyB0byB3cml0ZSBhbmQgd2hpY2ggbm90LCB1c2luZyBvZmZzZXQgYW5kIGxlbmd0aCBpcyBh
IG1lc3N5IGNvZGUgd2l0aCB0eXBlY2FzdCBhbmQgY29tcGFyZSBvbGQgdmFsdWVzIGV0Yy4KCgpJ
IGRvbid0IHNlZSB3aHkgaXQgbmVlZHMgdHlwZWNhc3QsIHZpcnRpb19uZXRfY29uZmlnIGlzIGFs
c28gdUFCSSwgeW91IApjYW4gZGVmZXJlbmNlIHRoZSBmaWVsZHMgZGlyZWN0bHkuCgoKPgo+PiBC
dHcsIHdoYXQgaGFwcGVucyBpZiBtYW5hZ2VtZW50IHRvb2wgdHJpZXMgdG8gbW9kaWZ5IHRoZSBt
YWMgb2YgdkRQQQo+PiB3aGVuIHRoZSBkZXZpY2UgaXMgYWxyZWFkeSB1c2VkIGJ5IHRoZSBkcml2
ZXI/Cj4gQXQgcHJlc2VudCBpdCBhbGxvd3MgbW9kaWZ5aW5nLCBidXQgaXQgc2hvdWxkIGJlIGlt
cHJvdmVkIGluIGZ1dHVyZSB0byBmYWlsIGlmIGRldmljZSBpcyBpbiB1c2UuCgoKVGhpcyBpcyBz
b21ldGhpbmcgd2UgbmVlZCB0byBmaXggSSB0aGluay4gT3IgaWYgaXQncyByZWFsbHkgdXNlZnVs
IHRvIAphbGxvd2luZyB0aGUgYXR0cmlidXRlcyB0byBiZSBtb2RpZmllZCBhZnRlciB0aGUgZGV2
aWNlIGlzIGNyZWF0ZWQuCgpXaHkgbm90IHNpbXBseSBhbGxvdyB0aGUgY29uZmlnIHRvIGJlIGJ1
aWx0IG9ubHkgYXQgZGV2aWNlIGNyZWF0aW9uPwoKCj4KPj4+Pj4+IEFuZCBhY3R1YWxseSwgaXQn
cyBub3QgdGhlIGJpbmFyeSBibG9iIHNpbmNlIHVhcGkgY2xlYXJseSBkZWZpbmUgdGhlCj4+Pj4+
PiBmb3JtYXQgKGUuZyBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpLCBjYW4gd2UgZmluZCBhIHdh
eSB0byB1c2UgdGhhdD8KPj4+Pj4+IEUuZyBpbnRyb2R1Y2UgZGV2aWNlL25ldCBzcGVjaWZpYyBj
b21tYW5kIGFuZCBwYXNzaW5nIHRoZSBibG9iIHdpdGgKPj4+Pj4+IGxlbmd0aCBhbmQgbmVnb3Rp
YXRlZCBmZWF0dXJlcy4KPj4+Pj4gTGVuZ3RoIG1heSBjaGFuZ2UgaW4gZnV0dXJlLCBtb3N0bHkg
ZXhwYW5kLiBBbmQgcGFyc2luZyBiYXNlZCBvbgo+PiBsZW5ndGgKPj4+PiBpcyBub3Qgc3VjaCBh
IGNsZWFuIHdheS4KPj4+Pgo+Pj4+Cj4+Pj4gTGVuZ3RoIGlzIG9ubHkgZm9yIGxlZ2FsIGNoZWNr
aW5nLiBUaGUgY29uZmlnIGlzIHNlbGYgY29udGFpbmVkIHdpdGg6Cj4+Pj4KPj4+IFVubGlrZWx5
LiBXaGVuIHN0cnVjdHVyZSBzaXplIGluY3JlYXNlcyBsYXRlciwgdGhlIHBhcnNpbmcgd2lsbCBj
aGFuZ2UgYmFzZWQKPj4gb24gdGhlIGxlbmd0aC4KPj4+IEJlY2F1c2Ugb2xkZXIga2VybmVsIHdv
dWxkIHJldHVybiBzaG9ydGVyIGxlbmd0aCB3aXRoIG9sZGVyIGlwcm91dGUyIHRvb2wuCj4+Cj4+
IFRoaXMgaXMgZmluZSBzaW5jZSB0aGUgb2xkZXIga2VybmVsIG9ubHkgc3VwcG9ydCBsZXNzIGZl
YXR1cmVzLiBUaGUgb25seQo+PiBwb3NzaWJsZSBpc3N1ZSBpZiB0aGUgb2xkIGlwcm91dGUgMiBy
dW5zIG9uIG5ldyBrZXJuZWwuIFdpdGggdGhlIGN1cnJlbnQKPj4gcHJvcG9zYWwsIGl0IG1heSBj
YXVzZSBzb21lIGNvbmZpZyBmaWVsZHMgY2FuJ3Qgbm90IGJlIHNob3dlZC4KPj4KPiBOb3Qgc2hv
d2luZyBpcyBvay4KPiBCdXQgdGhlIGNvZGUgaXMgbWVzc3kgdG8gdHlwZWNhc3Qgb24gc2l6ZS4K
Pgo+PiBJIHRoaW5rIGl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBpbnRyb2R1Y2UgYSBjb21tYW5kIHRv
IHNpbXBseSBkdW1wIHRoZQo+PiBjb25maWcgc3BhY2UuCj4+Cj4+Cj4+PiBTbyB1c2VyIHNwYWNl
IGFsd2F5cyBoYXZlIHRvIGRlYWwgYW5kIGhhdmUgbmFzdHkgcGFyc2luZy90eXBlY2FzdGluZwo+
PiBiYXNlZCBvbiB0aGUgbGVuZ3RoLgo+IFN1Y2ggbmFzdHkgcGFyc2luZyBpcyBub3QgcmVxdWly
ZWQgZm9yIG5ldGxpbmsgaW50ZXJmYWNlLgo+Cj4+Cj4+IFRoYXQncyBob3cgdXNlcnNwYWNlIChR
ZW11KSBpcyBleHBlY3RlZCB0byB3b3JrIG5vdy4gVGhlIHVzZXJzcGFjZQo+PiBzaG91bGQgZGV0
ZXJtaW5lIHRoZSBzZW1hbnRpYyBvZiB0aGUgZmllbGRzIGJhc2VkIG9uIHRoZSBmZWF0dXJlcy4K
Pj4KPj4gRGlmZmVyZW50aWF0ZSBjb25maWcgZmllbGRzIGRvZXNuJ3QgaGVscCBtdWNoLCBlLmcg
dXNlcnNwYWNlIHN0aWxsIG5lZWQKPj4gdG8gZGlmZmVyIExJTktfVVAgYW5kIEFOTk9VTkNFIGZv
ciB0aGUgc3RhdHVzIGZpZWxkLgo+IFllcywgdGhpcyBwYXJzaW5nIGlzIGZyb20gY29uc3RhbnQg
c2l6ZSB1MTYgc3RhdHVzLgo+Pgo+IFsuLl0KPgo+Pj4gSXRzIG5vdCBhYm91dCBwZXJmb3JtYW5j
ZS4gQnkgdGhlIHRpbWUgMXN0IGNhbGwgaXMgbWFkZSwgZmVhdHVyZXMgZ290Cj4+IHVwZGF0ZWQg
YW5kIGl0IGlzIG91dCBvZiBzeW5jIHdpdGggY29uZmlnLgo+Pj4+IDEpIGdldCBjb25maWcKPj4+
PiAyKSBnZXQgZGV2aWNlIGlkCj4+Pj4gMykgZ2V0IGZlYXR1cmVzCj4+Pj4KPj4+IFRoaXMgcmVx
dWlyZXMgdXNpbmcgZmVhdHVyZXMgZnJvbSAzcmQgbmV0bGluayBvdXRwdXQgdG8gZGVjb2RlIG91
dHB1dCBvZgo+PiAxc3QgbmV0bGluayBvdXRwdXQuCj4+PiBXaGljaCBpcyBhIGJpdCBvZGQgb2Yg
bmV0bGluay4KPj4+IE90aGVyIG5ldGxpbmsgbmxhX3B1dCgpIHByb2JhYmx5IHNlbmRpbmcgd2hv
bGUgc3RydWN0dXJlIGRvZXNu4oCZdCBuZWVkIHRvCj4+IGRvIGl0Lgo+Pgo+Pgo+PiBXZWxsLCB3
ZSBjYW4gcGFjayB0aGVtIGFsbCBpbnRvIGEgc2luZ2xlIHNrYiBpc24ndCBpdD8gKHByb2JhYmx5
IHdpdGggYQo+PiBjb25maWcgbGVuKS4KPj4KPiBZb3Ugd2FudCB0byBwYWNrIGZlYXR1cmVzIGFu
ZCBjb25maWcgYm90aCBpbiB0aGUgc2luZ2xlIG5sYV9wdXQoKT8KPiBJZiBzbywgaXQgaXNuJ3Qg
bmVjZXNzYXJ5LiBUaGVyZSBhcmUgbW9yZSBleGFtcGxlcyBpbiBrZXJuZWwgdGhhdCBhZGRzIGlu
ZGl2aWR1YWwgZmllbGRzIGluc3RlYWQgb2YgbmxhX3B1dChibG9iKS4KPiBJIHdvdWxkbuKAmXQg
Zm9sbG93IHRob3NlIG5sYV9wdXQoKSBjYWxsZXJzLgoKCk5vLCBhIHNpbmdsZSBza2Igbm90IHNp
bmdsZSBubGFfcHV0KCkuCgpBY3R1YWxseSBnaXQgZ3JlcCB0b2xkIG1lIGEgdmVyeSBnb29kIGV4
YW1wbGUgb2YgY2FycnlpbmcgdUFCSSB2aWEgCm5ldGxpbmssIHRoYXQgaXMgdGhlIG5kdF9jb25m
aWc6CgoxKSB3ZSBoYWQgbmR0X2NvbmZpZyBkZWZpbml0aW9uIGluIHRoZSB1QVBJCjIpIG5ldGxp
bmsgc2ltcGx5IGNhcnJpZXMgdGhlIHN0cnVjdHVyZSBpbiBuZWlnaHRibF9maWxsX2luZm8oKToK
CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5sYV9wdXQoc2tiLCBORFRBX0NP
TkZJRywgc2l6ZW9mKG5kYyksICZuZGMpKQoKCkZvciB2aXJpdG9fbmV0X2NvbmZpZywgd2h5IG5v
dCBzaW1wbHk6CgpsZW4gPSBvcHMtPmdldF9jb25maWdfbGVuKCk7CmNvbmZpZyA9IGttYWxsb2Mo
bGVuLCBHRlBfS0VSTkVMKTsKb3BzLT5nZXRfY29uZmlnKHZkZXYsIDAsIGNvbmZpZywgbGVuKTsK
bmxhX3B1dChza2IsIFZJUlRJT19DT05GSUcsIGNvbmZpZywgbGVuKTsKbmxhX3B1dF9sZTY0KHNr
YiwgVklSVElPX0ZFVFVSRVMsIGZlYXR1cmVzKTsKCkZvciBidWlsZF9jb25maWcsIHdlIGNhbiBz
aW1wbHkgZG8gdGhpbmcgcmV2ZXJzZWx5LiBUaGVuIGV2ZXJ5dGhpbmcgCndvcmtzIHZpYSB0aGUg
ZXhpc3RpbmcgdmlydGlvIHVBUEkvQUJJLgoKCj4KPj4+PiBGb3IgYnVpbGQgY29uZmlnLCBpdCdz
IG9ubHkgb25lCj4+Pj4KPj4+PiAxKSBidWlsZCBjb25maWcKPj4+Pgo+Pj4+Cj4+Pj4+IEkgcHJl
ZmVyIHRvIGZvbGxvdyByZXN0IG9mIHRoZSBrZXJuZWwgc3R5bGUgdG8gcmV0dXJuIHNlbGYgY29u
dGFpbmVkCj4+Pj4gaW52aWRpdmlkdWFsIGZpZWxkcy4KPj4+Pgo+Pj4+Cj4+Pj4gQnV0IEkgc2F3
IGEgbG90IG9mIGtlcm5lbCBjb2RlcyBjaG9vc2UgdG8gdXNlIGUuZyBubGFfcHV0KCkgZGlyZWN0
bHkgd2l0aAo+Pj4+IG1vZHVsZSBzcGVjaWZpYyBzdHJ1Y3R1cmUuCj4+Pj4KPj4+IEl0IG1pZ2h0
IGJlIHNlbGYtY29udGFpbmVkIHN0cnVjdHVyZSB0aGF0IHByb2JhYmx5IGhhcyBub3QgZm91bmQg
dGhlIG5lZWQKPj4gdG8gZXhwYW5kLgo+Pgo+Pgo+PiBJIHRoaW5rIGl0J3MganVzdCBhIG1hdHRl
ciBvZiBwdXR0aW5nIHRoZSBjb25maWcgbGVuZ3RoIHdpdGggdGhlIGNvbmZpZwo+PiBkYXRhLiBO
b3RlIHRoYXQgd2UndmUgYWxyZWFkeSBoYWQgLmdldF9jb25maWdfc2l6ZSgpIG9wcyBmb3IgdmFs
aWRhdGluZwo+PiBpbnB1dHMgdGhyb3VnaCBWSE9TVF9TRVRfQ09ORklHL1ZIT1NUX0dFVF9DT05G
SUcuCj4gVGhpcyBsZW5ndGggY29tZXMgYXMgcGFydCBvZiB0aGUgbmV0bGluayBpbnRlcmZhY2Ug
YWxyZWFkeSwgbm8gbmVlZCBmb3IgZXh0cmEgbGVuZ3RoLgo+IFRoZSB3aG9sZSBwb2ludCBpcyB0
byBhdm9pZCBwYXJzaW5nIGJhc2VkIG9uIGxlbmd0aC4KCgpXZWxsLCBpdCBkb2Vzbid0IGRvIGFu
eXRoaW5nIGRpZmZlcmVuY2UgY29tcGFyZWQgdG8geHh4X2lzX3ZhbGlkIHdoaWNoIApqdXN0IGNh
bGN1bGF0aW5nIHRoZSBvZmZzZXQgaW1wbGljaXRseSAodmlhIHRoZSBjb21waWxlcikuCgoKPiBX
ZSBjYW5ub3QgY2hhbmdlIHRoZSB2aXJ0aW9fbmV0X2NvbmZpZyBVQVBJIGluIHVzZSwgYnV0IG5l
dGxpbmsgY29kZSBkb2VzbuKAmXQgbmVlZCB0byBiZSBib3VuZCB0byBzaXplIGJhc2VkIHR5cGVj
YXN0aW5nIGFuZCBjb21wYXJlIGZpZWxkcyBkdXJpbmcgYnVpbGRfY29uZmlnKCkuCgoKVGhlIHBv
aW50cyBhcmU6CgoxKSBBdm9pZCBkdXBsaWNhdGluZyB0aGUgZXhpc3RpbmcgdUFQSXMKMikgQXZv
aWQgdW5uZWNlc3NhcnkgcGFyc2luZyBpbiB0aGUgbmV0bGluaywgbmV0bGluayBpcyBqdXN0IHRo
ZSAKdHJhbnNwb3J0LCBpdCdzIHRoZSBjaGFyZ2Ugb2YgdGhlIHZEUEEgcGFyZW50IHRvIGRvIHRo
YXQKClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
