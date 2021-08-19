Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67984C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:22:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A1A60EFE
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 04:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3A1A60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDD6A405C0;
	Thu, 19 Aug 2021 04:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oj2z7FT5nr8q; Thu, 19 Aug 2021 04:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F27F405D2;
	Thu, 19 Aug 2021 04:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F01EC0010;
	Thu, 19 Aug 2021 04:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D7E5C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F9C060825
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1myPBMiM_bDa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:22:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4DEC606BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 04:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629346927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKUOyiYEPIP5DEgiwwGNk2YT7F+NNRdyRlQT6tMaOLE=;
 b=TicgwEASOuZmtOxJaz9Oz3lgVgX59krilPUvhmm1xVB3CA2Om3ehxljwaQWW/iDHlCsQd+
 W48NCIST+ZudC2rd9ZTh0cu/pqGDu5sOCuZq9R3g/bkSdkA2O/ZIyGbPEcfmOCIuo0JHG9
 M94ffSi13Zs4bCdg/CWNopjLywqTjf0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-x-2SdxwROVuUB0XiaV9QZQ-1; Thu, 19 Aug 2021 00:22:06 -0400
X-MC-Unique: x-2SdxwROVuUB0XiaV9QZQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 z23-20020a17090abd97b0290176898bbb9cso2445635pjr.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 21:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uKUOyiYEPIP5DEgiwwGNk2YT7F+NNRdyRlQT6tMaOLE=;
 b=TIP13+4dFLdAk6m3a/yzX6E/xm6+eRJNjiD8RHkdiMHr4K5YLVAyAVw7rapYBC3XQk
 SubYEyliRepPYDt2VFkLqV3oRJayJhS12rn90QCFRAApLfvcUJNuIm8l28S96HT+oc6Y
 vVodQD9nONpUcN5rvSYuHAfjcxoCz5tk4xxZgy65T6Yp+Zgu4i9ScGCpuNn2vpLVMrT0
 QaaynCt2Fs23gP4eypL8BrIJKcXlQSorUkeUm7hrPck+4+d4c3q/5KLBBkq9bXyzuUAy
 DEqnLTXJWmXNTdMc90oiAusdJmau0u52I0LsWJ5N+P1UMEM+t8SFVl4i3mzuaU7RrRzn
 PQ/g==
X-Gm-Message-State: AOAM531CH+voovq1u5zC4qu31aqOOC2twe5qjRE6oCj9jC4AnYF2jCPq
 4xhny7hoJestYUHjV5IToMs5UtXG839W/uaVyQPMrBksrofJinO5pH9wBLVT4DhEdHBmtGIwEyE
 2fS7pZlvnQTmB5S3dW8BHEjK+LYrllAfzVNaZmH1s3A==
X-Received: by 2002:a17:902:d3c5:b029:12d:32f2:8495 with SMTP id
 w5-20020a170902d3c5b029012d32f28495mr10299995plb.72.1629346925119; 
 Wed, 18 Aug 2021 21:22:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfL2m5iE4PAaGh0pSE/goD/Sg9MwLXKpzB0iWrfBlrVUXFmaCc2vN3p2IzTFASGyIuHR0Zvw==
X-Received: by 2002:a17:902:d3c5:b029:12d:32f2:8495 with SMTP id
 w5-20020a170902d3c5b029012d32f28495mr10299972plb.72.1629346924718; 
 Wed, 18 Aug 2021 21:22:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k197sm1440538pfd.190.2021.08.18.21.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 21:22:04 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
 <20210818133309-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4ee539aa-a7c6-d9b9-790c-b8fedc69e5c7@redhat.com>
Date: Thu, 19 Aug 2021 12:22:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818133309-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CtTaIDIwMjEvOC8xOSDJz87nMTozMywgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gT24gV2Vk
LCBBdWcgMTgsIDIwMjEgYXQgMTI6MzE6MzlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
T24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMTE6MTUgQU0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlk
aWEuY29tPiB3cm90ZToKPj4+Cj4+Pgo+Pj4+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Cj4+Pj4gU2VudDogVHVlc2RheSwgQXVndXN0IDE3LCAyMDIxIDI6MjQgQU0K
Pj4+Pgo+Pj4+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDA5OjUxOjQ5QU0gKzAwMDAsIFBhcmF2
IFBhbmRpdCB3cm90ZToKPj4+Pj4+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhh
dC5jb20+Cj4+Pj4+PiBTZW50OiBNb25kYXksIEF1Z3VzdCA5LCAyMDIxIDM6MTAgUE0KPj4+Pj4+
Cj4+Pj4+PiBPbiBGcmksIEF1ZyAwNiwgMjAyMSBhdCAwODo1NTo1NkFNICswMDAwLCBQYXJhdiBQ
YW5kaXQgd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhlIHBvaW50IGlzIHRvIHRyeSBhbmQgbm90
IHJlaW52ZW50IGEgZGVkaWNhdGVkIHZwZGEgaW50ZXJmYWNlCj4+Pj4+Pj4+IHdoZXJlIGEgZ2Vu
ZXJpYyBvbmUgZXhpdHMuCj4+Pj4+Pj4+IEUuZy4gZm9yIHBoeSB0aGluZ3Mgc3VjaCBhcyBtYWMg
c3BlZWQgZXRjLCBJIHRoaW5rIG1vc3QgcGVvcGxlCj4+Pj4+Pj4+IGFyZSB1c2luZyBldGh0b29s
IHRoaW5ncyByaWdodD8KPj4+Pj4+PiBBcyB5b3Uga25vdyB2ZHBhIGlzIHRoZSBiYWNrZW5kIGRl
dmljZSBmb3IgdGhlIGZyb250LWVuZCBuZXRkZXZpY2UKPj4+Pj4+IGFjY2Vzc2VkIGJ5IHRoZSBl
dGh0b29sLgo+Pj4+Pj4+IHZkcGEgbWFuYWdlbWVudCB0b29sIGhlcmUgaXMgY29tcG9zaW5nIHRo
ZSB2ZHBhIGRldmljZS4KPj4+Pj4+Pgo+Pj4+Pj4+IEZvciBleGFtcGxlIGNyZWF0b3IgKGh5cGVy
dmlzb3IpIG9mIHRoZSB2ZHBhIGRldmljZXMga25vd3MgdGhhdCBhCj4+Pj4+Pj4gZ3Vlc3QgVk0g
aXMgZ2l2ZW4gNCB2Y3B1cywgU28gaHlwZXJ2aXNvciBjcmVhdGVzIGEgdmRwYSBkZXZpY2VzCj4+
Pj4+Pj4gd2l0aCBjb25maWcgc3BhY2UgbGF5b3V0IGFzLCBtYXhfdmlydHF1ZXVlX3BhaXJzID0g
NC4KPj4+Pj4+PiBBbmQgdGhlIE1BQyBhZGRyZXNzIGNob3NlbiBieSBoeXBlcnZpc29yIGluIG1h
Y1s2XS4KPj4+Pj4+Pgo+Pj4+Pj4+IEd1ZXN0IFZNIGV0aHRvb2wgY2FuIHN0aWxsIGNob3NlIHRv
IHVzZSBsZXNzIG51bWJlciBvZiBjaGFubmVscy4KPj4+Pj4+Pgo+Pj4+Pj4+IFR5cGljYWxseSwK
Pj4+Pj4+PiBldGh0b29sIGlzIGZvciBndWVzdCBWTS4KPj4+Pj4+PiB2ZHBhIGRldmljZSBpcyBp
biBoeXBldmlzb3IuCj4+Pj4+Pj4KPj4+Pj4+PiBIb3cgY2FuIGh5cGVydmlzb3IgY29tcG9zZSBh
IHZkcGEgZGV2aWNlIHdpdGhvdXQgYW55IHRvb2w/Cj4+Pj4+Pj4gSG93IGNhbiBpdCB0ZWxsIGV0
aHRvb2wsIHdoYXQgaXMgc3VwcG9ydGVkIGFuZCB3aGF0IGFyZSB0aGUgZGVmYXVsdHM/Cj4+Pj4+
Pj4KPj4+Pj4+PiBJIG11c3QgYmUgbWlzdW5kZXJzdGFuZGluZyB5b3VyIGNvbW1lbnQgYWJvdXQg
ZXRodG9vbC4KPj4+Pj4+PiBDYW4geW91IHBsZWFzZSBleHBsYWluPwo+Pj4+Pj4KPj4+Pj4+IEkg
YW0gYmFzaWNhbGx5IHNheWluZyB0aGF0IHdlIHByb2JhYmx5IHdhbnQgdG8gYmUgYWJsZSB0byBj
aGFuZ2UgTUFDCj4+Pj4+PiBvZiBhIFZEUEEgZGV2aWNlIG9uIHRoZSBob3N0IHdpdGhvdXQgZGVz
cm95aW5nIGFuZCByZWNyZWF0aW5nIHRoZQo+Pj4+Pj4gZGV2aWNlIGFzIGxvbmcgYXMgaXQncyBu
b3QgaW4gdXNlLgo+Pj4+PiBPay4gSSB1bmRlcnN0b29kIHlvdXIgY29tbWVudCBub3cuCj4+Pj4+
IFllcywgdGhpcyB3YXMgdGhlIG9iamVjdGl2ZSB3aGljaCBpcyB3aHkgdGhleSBhcmUgcHJlc2Vu
dCBhcyBpbmRlcGVuZGVudAo+Pj4+IGNvbmZpZyBrbm9iLgo+Pj4+PiBKYXNvbiB3YXMgc3VnZ2Vz
dGluZyB0byBoYXZlIHRoZW0gYXMgY3JlYXRpb24gb25seSBrbm9icywgd2hpY2ggcmVxdWlyZXMK
Pj4+PiByZWNyZWF0ZS4KPj4+Pj4gSSBkb24ndCBoYXZlIHN0cm9uZyBvcGluaW9uIGZvciBlaXRo
ZXIgbWV0aG9kLgo+Pj4+Pgo+Pj4+PiBQYXNzaW5nIHRoZW0gYXQgY3JlYXRpb24gdGltZSBpcyBz
aW1wbGVyIGZvciB1c2VyLgo+Pj4+PiBJZiB1c2VyIG5lZWRzIHRoZSBhYmlsaXR5IHRvIG1vZGlm
eSBhbmQgcmV1c2Ugc2FtZSBkZXZpY2Ugd2l0aCBkaWZmZXJlbnQKPj4+PiBjb25maWcsIGV4dGVu
ZGluZyBzdWNoIHN1cHBvcnQgaW4gZnV0dXJlIGxpa2UgdGhpcyBwYXRjaCBzaG91bGQgcG9zc2li
bGUuCj4+Pj4+IFNvIHRoZXJlIGFyZSB0d28gcXVlc3Rpb25zIHRvIGNsb3NlLgo+Pj4+PiAxLiBD
YW4gd2Ugc3RhcnQgd2l0aCBjb25maWcgcGFyYW1zIGF0IHZkcGEgZGV2aWNlIGNyZWF0aW9uIHRp
bWU/Cj4+Pj4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2UgbmVlZCBib3RoIGJ1dCBJJ2QgbGlrZSB0
byBzZWUgYSBmdWxsIEFQSSBhbmQgSSB0aGluayB3ZQo+Pj4+IGFsbCBhZ3JlZSBob3N0IHdhbnRz
IGFiaWxpdHkgdG8gdHdlYWsgbWFjIGFmdGVyIGRldmljZSBjcmVhdGlvbiBldmVuIGlmIGd1ZXN0
IGlzCj4+Pj4gbm90IGFsbG93ZWQgdG8gY2hhbmdlIG1hYywgcmlnaHQ/Cj4+Pj4KPj4+IFllcy4K
Pj4+ICQgdmRwYSBkZXYgYWRkIG5hbWUgZm9vIG1nbXRkZXYgcGNpLzAwMDA6MDM6MDAuMCBtYWMg
MDA6MTE6MjI6MzM6NDQ6NTUgbWF4dnFzIDggbXR1IDkwMDAKPj4+Cj4+PiBBYm92ZSBBUEkgaWYg
d2UgZG8gYXQgY3JlYXRpb24gdGltZS4gSXQgaXMgbGlrZWx5IHNpbXBsZXIgZm9yIHVzZXIgdG8g
cGFzcyBuZWNlc3NhcnkgcGFyYW1zIGR1cmluZyBjcmVhdGlvbiB0aW1lLgo+Pj4KPj4+Pj4gMi4g
SXMgaXQgb2sgdG8gaGF2ZSB0aGVzZSBjb25maWcgcGFyYW1zIGFzIGluZGl2aWR1YWwgZmllbGRz
IGF0IG5ldGxpbmsgVS0+Swo+Pj4+IFVBUEkgbGV2ZWw/Cj4+Pj4+IFRoaXMgaXMgdGhlIG1ldGhv
ZCBwcm9wb3NlZCBpbiB0aGlzIHBhdGNoIHNlcmllcy4KPj4+Pj4gKFNpbWlsYXIgdG8gaW5jcmVt
ZW50YWxseSBncm93aW5nIHZ4bGFuIGlwIGxpbmsgY29tbWFuZCkuCj4+Pj4+Cj4+Pj4+IE9yCj4+
Pj4+IFRoZXkgc2hvdWxkIGJlIHBhY2tlZCBpbiBhIHN0cnVjdHVyZSBiZXR3ZWVuIFUtPiBLIGFu
ZCBkZWFsIHdpdGgKPj4+PiB0eXBlY2FzdGluZyBiYXNlZCBvbiBzaXplIGFuZCBtb3JlPwo+Pj4+
PiAoSmFzb24ncyBpbnB1dCkuCj4+Pj4gSSdtIGluY2xpbmVkIHRvIHNheSB2eGxhbiBpcyBjbG9z
ZXIgdG8gYSBtb2RlbCB0byBmb2xsb3cuCj4+PiBPay4gdGhhbmtzIGZvciB0aGUgZmVlZGJhY2su
IFdlIGFyZSB1c2luZyB0aGUgbW9kZWwgY2xvc2UgdG8gdnhsYW4uCj4+PiBMZXRzIHJlc29sdmUg
c2hvdWxkIHdlIGhhdmUgaXQgYXQgY3JlYXRpb24gdGltZSwgcG9zdCBjcmVhdGlvbiBvciBib3Ro
Pwo+Pj4gKGEpIENyZWF0aW9uIHRpbWUKPj4+IFByb3M6Cj4+PiAtIHNpbXBsZXIgc2luZ2xlIGFw
aSBmb3IgdXNlcgo+Pj4gLSBlbGltaW5hdGVzIG5lZWRzIG9mIGludmVudGluZyBzdGF0cyByZXNl
dCBpbiBmdXR1cmUgc2VyaWVzCj4+PiBDb25zOgo+Pj4gLSBpbmFiaWxpdHkgdG8gcmV1c2UgdGhl
IGRldmljZSB3aXRoIGRpZmZlcmVudCBjb25maWcKPj4gVGhpcyBjYW4gYmUgc29sdmVkIGJ5IGRl
c3Ryb3lpbmcgdGhlIGluc3RhbmNlIGFuZCByZS1jcmVhdGluZyBpdCB3aXRoCj4+IGEgZGlmZmVy
ZW50IHBhcmFtcz8KPj4KPj4+IC0gVGhpcyBtYXkgbm90IGJlIG9mIGdyZWF0IGFkdmFudGFnZSwg
YW5kIGl0IGlzIHByb2JhYmx5IGZpbmUgdG8gaGF2ZSBjcmVhdGlvbiB0aW1lIHBhcmFtcwo+Pj4K
Pj4+IChiKSBwb3N0IGNyZWF0aW9uIHRpbWU6Cj4+PiBQcm9zOgo+Pj4gLSBhYmxlIHRvIHJldXNl
IHRoZSBkZXZpY2Ugd2l0aCBkaWZmZXJlbnQgY29uZmlnIGZvciBzYXkgZGlmZmVyZW50IFZNLgo+
Pj4gLSB3aWxsIHJlcXVpcmUgc3RhdHMgcmVzZXQgaW4gZnV0dXJlIG9uY2Ugc3RhdHMgYXJlIGlt
cGxlbWVudGVkCj4+IEFueSByZWFzb24gZm9yIGRvaW5nIHRoaXMgb3RoZXIgdGhhbiByZS1jcmVh
dGluZyB0aGUgZGV2aWNlPwo+IFBlcm1pc3Npb25zLgoKCkkgd291bGQgZXhwZWN0IHRoYXQgQ0FQ
X05FVF9BRE1JTiBpcyByZXF1aXJlZCBmb3IgYm90aCBjYXNlcy4KCk9yIGFueXRoaW5nIEkgbWlz
cyBoZXJlPwoKVGhhbmtzCgoKPgo+Cj4+PiBDb25zOgo+Pj4gLSBtb3JlIGNvbW1hbmRzIGZvciB1
c2VycyB0byBjb25maWcgYSBkZXZpY2UsIGJldHRlciB0byBoYXZlIHRoZSBhYmlsaXR5IGF0IGNy
ZWF0ZSB0aW1lLgo+PiBXZSBwcm9iYWJseSBuZWVkIHRvIHN1cHBvcnQgcG9zdCBjcmVhdGlvbiBi
dXQgaXQgc2hvdWxkIGJlIGRldmljZSBzcGVjaWZpYy4KPj4KPj4gRS5nIHdlIG1heSBzdXBwb3J0
IGRldmljZSByZXNpemUgZm9yIHZpcnRpby1ibGsgZGV2aWNlcy4KPj4KPj4gQnV0IGl0IGNhbiBi
ZSBkb25lIG9uIHRvcCBJIHRoaW5rLgo+Pgo+PiBUaGFua3MKPj4KPj4+PiAtLQo+Pj4+IE1TVAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
