Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA11C433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 03:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D2FF833C9;
	Tue, 17 May 2022 03:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sJlP1coCu8H; Tue, 17 May 2022 03:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 127E1833B7;
	Tue, 17 May 2022 03:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8315C0032;
	Tue, 17 May 2022 03:05:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55E12C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A07940B91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXi9vMe3Ljfq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:05:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50EEC40408
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652756725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EelOwjaw4TS+XRiPvJytkNJ1z7ZsgkjXM+Dsrb/Ma8s=;
 b=TIgpt9v0rYFbrL41+NBoqO45diwWq6au5bs6beybXt74pSy6u0ouw1MYqOynsUYeF0JcN+
 MfxFDzHqiAFwgN9CtY1Ku0qQ3Zd26QhqAK/PrSc1G4zAMUu8SFqVD5AlAzsJrmSVDoR/SF
 nhfXFBUGQ5UdvLgf4uMghk6Lp01CIPE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-3cT2U27EOs-QTKzs9uBDag-1; Mon, 16 May 2022 23:05:23 -0400
X-MC-Unique: 3cT2U27EOs-QTKzs9uBDag-1
Received: by mail-pf1-f200.google.com with SMTP id
 b184-20020a62cfc1000000b0050d209cb8dcso7048556pfg.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 20:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EelOwjaw4TS+XRiPvJytkNJ1z7ZsgkjXM+Dsrb/Ma8s=;
 b=n7WoldnykGfoN46PFmAF0KEzT37EeeKIO2/AxYOmot2ahFgNhg0ebEkDOAGrd8kEPe
 sd8wSpGkYdlZWqEJm44Q0H9ok9EJcAv2CoPxZdFPVxnsZrFKi8/5D2GKzMf+UiG0EWlH
 iTH574YpH+u6fH+5ViXkLwEEXodi8wbRT5Qz+XdrRVRzlYtlAorpwj9nJYYA1R4YTO0k
 QjFILdn8VMRXNd9l+yUdB509ATFL63nStHvdDXUtg7XykhWsVUjwFFCrL2xYtNgI7e1S
 hhmWQpm9/ttK6Z6v3lzgvZrx1u9DQ/HUoZmKAKLJxKWSNRgZHaCfGdA1UdH0KeHoKV44
 +4zw==
X-Gm-Message-State: AOAM530kXxZVSvrZqy/kr1l4B+WD88e8yMOHVE/wGTDddF/PZ/4lcHdU
 0zBr003hP0dTcTaX3nkix6GmHBa7zX1KTfbvXhDUhRRNzlsyXgYWBV/fInuppcD1ptFVwRZqQit
 j//V8SPLOD/p57+dWceK+NyYcSosp6K7Em5eDy8uoPA==
X-Received: by 2002:a17:902:82c7:b0:161:4936:f068 with SMTP id
 u7-20020a17090282c700b001614936f068mr14342973plz.145.1652756722369; 
 Mon, 16 May 2022 20:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk6L81/d20e5TYIJBogw4txS5znfNbyxYwKsMeeXIqeOMLnabcGJ3/YConpbtiAp5i7wV07w==
X-Received: by 2002:a17:902:82c7:b0:161:4936:f068 with SMTP id
 u7-20020a17090282c700b001614936f068mr14342950plz.145.1652756722052; 
 Mon, 16 May 2022 20:05:22 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 gz19-20020a17090b0ed300b001d9738fdf2asm407169pjb.37.2022.05.16.20.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 20:05:21 -0700 (PDT)
Message-ID: <c235a37a-8a57-b4ae-6c2c-562d6e163450@redhat.com>
Date: Tue, 17 May 2022 11:05:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: About restoring the state in vhost-vdpa device
To: Parav Pandit <parav@nvidia.com>, Eugenio Perez Martin <eperezma@redhat.com>
References: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
 <PH0PR12MB5481AF0B02B0FB00885FF2AEDCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BY5PR02MB698052EE53B707C6C04C3C8CB1CA9@BY5PR02MB6980.namprd02.prod.outlook.com>
 <PH0PR12MB54811C88B389ACB495BD5AB2DCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWe2dQx1s7wQr8OLp-0eAQZJcCBuFwdxBA=sgeNm_u4N6A@mail.gmail.com>
 <PH0PR12MB54812F8306F5B9650BA10783DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB54812F8306F5B9650BA10783DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "virtio-networking@redhat.com" <virtio-networking@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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

CuWcqCAyMDIyLzUvMTcgMDQ6MjksIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4KPj4gRnJvbTogRXVn
ZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IE1vbmRheSwg
TWF5IDE2LCAyMDIyIDQ6NTEgQU0KPj4KPj4gT24gRnJpLCBNYXkgMTMsIDIwMjIgYXQgODoyNSBQ
TSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOgo+Pj4gSGkgR2F1dGFtLAo+
Pj4KPj4+IFBsZWFzZSBmaXggeW91ciBlbWFpbCBjbGllbnQgdG8gaGF2ZSByaWdodCByZXNwb25z
ZSBmb3JtYXQuCj4+PiBPdGhlcndpc2UsIGl0IHdpbGwgYmUgY29uZnVzaW5nIGZvciB0aGUgcmVz
dCBhbmQgdXMgdG8gZm9sbG93IHRoZQo+PiBjb252ZXJzYXRpb24uCj4+PiBNb3JlIGJlbG93Lgo+
Pj4KPj4+PiBGcm9tOiBHYXV0YW0gRGF3YXIgPGdkYXdhckB4aWxpbnguY29tPgo+Pj4+IFNlbnQ6
IEZyaWRheSwgTWF5IDEzLCAyMDIyIDE6NDggUE0KPj4+Pj4gT3VyIHByb3Bvc2FsIGRpdmVyZ2Ug
aW4gc3RlcCA3OiBJbnN0ZWFkIG9mIGVuYWJsaW5nICphbGwqIHRoZQo+Pj4+PiB2aXJ0cXVldWVz
LCBvbmx5IGVuYWJsZSB0aGUgQ1ZRLgo+Pj4+IEp1c3QgdG8gZG91YmxlIGNoZWNrLCBWUSAwIGFu
ZCAxIG9mIHRoZSBuZXQgYXJlIGFsc28gbm90IGVuYWJsZWQsIGNvcnJlY3Q/Cj4+Pj4gW0dEPj5d
IFllcywgdGhhdCdzIG15IHVuZGVyc3RhbmRpbmcgYXMgd2VsbC4KPj4+Pgo+PiBUaGF0J3MgY29y
cmVjdC4gV2UgY2FuIHNheSB0aGF0IGZvciBhIHF1ZXVlIHRvIGJlIGVuYWJsZWQgdGhyZWUgdGhp
bmdzIG11c3QKPj4gaGFwcGVuOgo+PiAqIERSSVZFUl9PSyAoU3RpbGwgbm90IHNlbmQpCj4+ICog
VkhPU1RfVkRQQV9TRVRfVlJJTkdfRU5BQkxFIHNlbnQgZm9yIHRoYXQgcXVldWUgKE9ubHkgc2Vu
dCBmb3IKPj4gQ1ZRKQo+PiAqIElmIHF1ZXVlIGlzIG5vdCBpbiBmaXJzdCBkYXRhIHF1ZXVlIHBh
aXIgYW5kIG5vdCBjdnE6IHNlbmQKPj4gVklSVElPX05FVF9DVFJMX01RX1ZRX1BBSVJTX1NFVCB3
aXRoIGEgcXVldWUgcGFpciB0aGF0IGluY2x1ZGUgaXQuCj4+Cj4gVGhlc2UgaWYgY29uZGl0aW9u
cywgc3BlY2lhbGx5IHRoZSBsYXN0IG9uZSBpcyBub3QgZ29vZCBhcyBpdCByZXF1aXJlcyBkZXZp
Y2UgdHlwZSBrbm93bGVkZ2UsIHdoaWNoIGluIG1vc3QgY2FzZXMgbm90IG5lZWRlZC4KPiBTcGVj
aWFsbHkgZm9yIHRoZSBuZXcgY29kZS4KPgo+Pj4+PiBBZnRlciB0aGF0LCBzZW5kIHRoZSBEUklW
RVJfT0sgYW5kIHF1ZXVlIGFsbCB0aGUgY29udHJvbCBjb21tYW5kcwo+Pj4+PiB0byByZXN0b3Jl
IHRoZSBkZXZpY2Ugc3RhdHVzIChNUSwgUlNTLCAuLi4pLiBPbmNlIGFsbCBvZiB0aGVtIGhhdmUK
Pj4+Pj4gYmVlbiBhY2tub3dsZWRnZWQgKCJkZXZpY2UiLCBvciBlbXVsYXRlZCBjdnEgaW4gaG9z
dCB2ZHBhIGJhY2tlbmQKPj4+Pj4gZHJpdmVyLCBoYXMgdXNlZCBhbGwgY3ZxIGJ1ZmZlcnMsIGVu
YWJsZSAoU0VUX1ZSSU5HX0VOQUJMRSwKPj4+Pj4gc2V0X3ZxX3JlYWR5KSBhbGwgb3RoZXIgcXVl
dWVzLgo+Pj4+Pgo+Pj4+IFdoYXQgaXMgc3BlY2lhbCBhYm91dCBkb2luZyBEUklWRVJfT0sgYW5k
IGVucXVldWluZyB0aGUgY29udHJvbAo+Pj4+IGNvbW1hbmRzPwo+Pj4+IFdoeSBvdGhlciBjb25m
aWd1cmF0aW9uIGNhbm5vdCBiZSBhcHBsaWVkIGJlZm9yZSBEUklWRVJfT0s/Cj4+IFRoZXJlIGlz
IG5vdGhpbmcgc3BlY2lhbCBiZXlvbmQgInRoZXkgaGF2ZSBhIG1ldGhvZCB0byBiZSBzZXQgdGhh
dCB3YXksIHNvCj4+IHJldXNpbmcgaXQgYXZvaWRzIGhhdmluZyB0byBtYWludGFpbiBtYW55IHdh
eXMgdG8gc2V0IHRoZSBzYW1lIHRoaW5ncywKPj4gc2ltcGxpZnlpbmcgaW1wbGVtZW50YXRpb25z
Ii4KPj4KPj4gSSdtIG5vdCBzYXlpbmcgIml0IGhhcyBiZWVuIGxpa2UgdGhhdCBmb3JldmVyIHNv
IHdlIGNhbm5vdCBjaGFuZ2UgaXQiOgo+PiBJJ20gdmVyeSBvcGVuIHRvIHRoZSBjaGFuZ2UgYnV0
IHByaW9yaXR5LXdpc2Ugd2Ugc2hvdWxkIGZpcnN0IGFjaGlldmUgYQo+PiB3b3JraW5nIExNIHdp
dGggcGFja2VkLCBpbl9vcmRlciwgb3IgZXZlbiBpbmRpcmVjdC4KPj4KPj4+PiBbR0Q+Pl0gRm9y
IHRoZSBkZXZpY2UgdG8gYmUgbGl2ZSAoYW5kIGFueSBxdWV1ZSB0byBiZSBhYmxlIHRvIHBhc3MK
Pj4+PiB0cmFmZmljKSwgRFJJVkVSX09LIGlzIGEgbXVzdC4KPj4+IFRoaXMgYXBwbGllcyBvbmx5
IHRvIHRoZSB2ZHBhIGRldmljZSBpbXBsZW1lbnRlZCBvdmVyIHZpcnRpbyBkZXZpY2UuCj4+PiBG
b3Igc3VjaCB1c2UgY2FzZS9pbXBsZW1lbnRhdGlvbiBhbnl3YXkgYSBwcm9wZXIgdmlydGlvIHNw
ZWMgZXh0ZW5zaW9uIGlzCj4+IG5lZWRlZCBmb3IgaXQgYmUgZWZmaWNpZW50Lgo+Pj4gQW5kIHdo
YXQgdGhhdCBoYXBwZW5zIHRoaXMgc2NoZW1lIHdpbGwgc3RpbGwgd29yay4KPj4+Cj4+IEFsdGhv
dWdoIGl0J3MgYSBsb25nZXIgcm91dGUsIEknZCB2ZXJ5IG11Y2ggcHJlZmVyIGFuIGluLWJhbmQg
dmlydGlvIHdheSB0bwo+PiBwZXJmb3JtIGl0IHJhdGhlciB0aGFuIGEgbGludXgvdmRwYSBzcGVj
aWZpYy4gSXQncyBvbmUgb2YgdGhlIHJlYXNvbnMgSSBwcmVmZXIKPj4gdGhlIENWUSBiZWhhdmlv
ciBvdmVyIGEgdmRwYSBzcGVjaWZpYyBpb2N0bC4KPj4KPiBXaGF0IGlzIHRoZSBpbi1iYW5kIG1l
dGhvZCB0byBzZXQgbGFzdF9hdmFpbF9pZHg/Cj4gSW4tYmFuZCB2aXJ0aW8gbWV0aG9kIGRvZXNu
J3QgZXhpc3QuCgoKUmlnaHQsIGJ1dCBpdCdzIHBhcnQgb2YgdGhlIHZob3N0IEFQSSB3aGljaCB3
YXMgdGhlcmUgZm9yIG1vcmUgdGhhbiAxMCAKeWVhcnMuIFRoaXMgc2hvdWxkIGJlIHN1cHBvcnRl
ZCBieSBhbGwgdGhlIHZEUEEgdmVuZG9ycy4KCgo+Cj4+PiBPdGhlciB2ZHBhIGRldmljZXMgZG9l
c27igJl0IGhhdmUgdG8gbGl2ZSB3aXRoIHRoaXMgbGltaXRhdGlvbiBhdCB0aGlzIG1vbWVudC4K
Pj4+Cj4+Pj4gU28sIGFueSBjb25maWd1cmF0aW9uIGNhbiBiZSBwYXNzZWQgb3ZlciB0aGUgQ1ZR
IG9ubHkgYWZ0ZXIgaXQgaXMKPj4+PiBzdGFydGVkICh2cmluZyBjb25maWd1cmF0aW9uICsgRFJJ
VkVSX09LKS4gRm9yIGFuIGVtdWxhdGVkIHF1ZXVlLCBpZgo+Pj4+IHRoZSBvcmRlciBpcyByZXZl
cnNlZCwgSSB0aGluayB0aGUgZW5xdWV1ZWQgY29tbWFuZHMgd2lsbCByZW1haW4KPj4+PiBidWZm
ZXJlZCBhbmQgZGV2aWNlIHNob3VsZCBiZSBhYmxlIHRvIHNlcnZpY2UgdGhlbSB3aGVuIGl0IGdv
ZXMgbGl2ZS4KPj4+IEkgbGlrZWx5IGRpZG7igJl0IHVuZGVyc3RhbmQgd2hhdCB5b3UgZGVzY3Jp
YmUgYWJvdmUuCj4+Pgo+Pj4gVnEgYXZhaWwgaW5kZXggZXRjIGlzIHByb2dyYW1tZWQgYmVmb3Jl
IGRvaW5nIERSSVZFUl9PSyBhbnl3YXkuCj4+Pgo+Pj4gU2VxdWVuY2UgaXMgdmVyeSBzdHJhaWdo
dCBmb3J3YXJkIGF0IGRlc3RpbmF0aW9uIGZyb20gdXNlciB0byBrZXJuZWwuCj4+PiAxLiBTZXQg
Y29uZmlnIHNwYWNlIGZpZWxkcyAoc3VjaCBhcyB2aXJ0aW9fbmV0X2NvbmZpZy92aXJ0aW9fYmxr
X2NvbmZpZykuCj4+PiAyLiBTZXQgb3RoZXIgZGV2aWNlIGF0dHJpYnV0ZXMgKG1heCB2cXMsIGN1
cnJlbnQgbnVtIHZxcykgMy4gU2V0IG5ldAo+Pj4gc3BlY2lmaWMgY29uZmlnIChSU1MsIHZsYW4s
IG1hYyBhbmQgbW9yZSBmaWx0ZXJzKSA0LiBTZXQgVlEgZmllbGRzCj4+PiAoZW5hYmxlLCBtc2l4
LCBhZGRyLCBhdmFpbCBpbmR4KSA1LiBTZXQgRFJJVkVSX09LLCBkZXZpY2UgcmVzdW1lcyBmcm9t
Cj4+PiB3aGVyZSBpdCBsZWZ0IG9mZgo+Pj4KPj4+IFN0ZXBzICMxIHRvICM0IGNhbiBiZSBkb25l
IG11bHRpcGxlIHRpbWVzIGluIHByZS13YXJtIGRldmljZSB1cCBjYXNlIGluCj4+IGZ1dHVyZS4K
Pj4KPj4gVGhhdCByZXF1aXJlcyBjcmVhdGluZyBhIHdheSB0byBzZXQgYWxsIHRoZSBwYXJhbWV0
ZXJzIGVudW1lcmF0ZWQgdGhlcmUgdG8KPj4gdmRwYSBkZXZpY2VzLiBFYWNoIHRpbWUgYSBuZXcg
ZmVhdHVyZSBpcyBhZGRlZCB0byB2aXJ0aW8tbmV0IHRoYXQgbW9kaWZpZXMKPj4gdGhlIGd1ZXN0
LXZpc2libGUgZnJvbnRlZCBkZXZpY2Ugd2Ugd291bGQgbmVlZCB0byB1cGRhdGUgaXQuCj4gQW55
IGd1ZXN0IHZpc2libGUgZmVhdHVyZSBleHBvc2VkIGJ5IHRoZSB2ZHBhIGRldmljZSBvbiB0aGUg
c291cmNlIHNpZGUsIGEgbWlncmF0aW9uIGFnZW50IG5lZWRzIHRvIHZlcmlmeS9hbmQgbWFrZSBk
ZXN0aW5hdGlvbiBkZXZpY2UgY2FwYWJsZSB0byBzdXBwb3J0IGl0IGFueXdheS4gV2l0aG91dCBp
dCBhIGRldmljZSBtYXkgYmUgbWlncmF0ZWQsIGJ1dCBpdCB3b24ndCBwZXJmb3JtIGF0IHNhbWUg
bGV2ZWwgYXMgc291cmNlLgo+Cj4+IEFuZCBhbGwgdGhlCj4+IGxheWVycyBvZiB0aGUgc3RhY2sg
bmVlZCB0byBtYWludGFpbiBtb3JlIHN0YXRlLgo+IE1vc3RseSBub3QuIEEgY29tcGxldGUgdmly
dGlvIGRldmljZSBzdGF0ZSBhcnJpdmVkIGZyb20gc291cmNlIHZkcGEgZGV2aWNlIGNhbiBiZSBn
aXZlbiB0byBkZXN0aW5hdGlvbiB2ZHBhIGRldmljZSB3aXRob3V0IGFueW9uZSBlbHNlIGxvb2tp
bmcgaW4gdGhlIG1pZGRsZS4gSWYgdGhpcyBmb3JtYXQgaXMga25vd24vd2VsbCBkZWZpbmVkLgoK
ClRoYXQncyBmaW5lLCBhbmQgaXQgc2VlbXMgdGhlIHZpcnRpbyBzcGVjIGlzIGEgYmV0dGVyIHBs
YWNlIGZvciB0aGlzLCAKdGhlbiB3ZSB3b24ndCBkdXBsaWNhdGUgZWZmb3J0cz8KCgo+Cj4+ICBG
cm9tIHRoZSBndWVzdCBwb2ludCBvZiB2aWV3LCB0byBlbmFibGUgYWxsIHRoZSBxdWV1ZXMgd2l0
aAo+PiBWSE9TVF9WRFBBX1NFVF9WUklOR19FTkFCTEUgYW5kIGRvbid0IHNlbmQgRFJJVkVSX09L
IGlzIHRoZSBzYW1lCj4+IGFzIHNlbmQgRFJJVkVSX09LIGFuZCBub3QgdG8gZW5hYmxlIGFueSBk
YXRhIHF1ZXVlIHdpdGgKPj4gVkhPU1RfVkRQQV9TRVRfVlJJTkdfRU5BQkxFLgo+IEVuYWJsaW5n
IFNFVF9WUklOR19FTkFCTEUgYWZ0ZXIgRFJJVkVSX09LIGhhcyB0d28gYmFzaWMgdGhpbmdzIGJy
b2tlbi4KCgpJdCBsb29rcyB0byBtZSB0aGUgc3BlYzoKCjEpIEZvciBQQ0kgaXQgZG9lc24ndCBm
b3JiaWQgdGhlIGRyaXZlciB0byBzZXQgcXVldWVfZW5hYmxlIHRvIDEgYWZ0ZXIgCkRSSVZFUl9P
Sy4KMikgRm9yIE1NSU8sIGl0IGV2ZW4gYWxsb3dzIHRoZSBkcml2ZXIgdG8gZGlzYWJsZSBhIHF1
ZXVlIGFmdGVyIERSSVZFUl9PSwoKCj4gMS4gc3VwcGxpZWQgUlNTIGNvbmZpZyBhbmQgVlEgY29u
ZmlnIGlzIG5vdCBob25vcmVkIGZvciBzZXZlcmFsIHRlbnMgb2YgaHVuZHJlZHMgb2YgbWlsbGlz
ZWNvbmRzCj4gSXQgd2lsbCBiZSBwdXJlbHkgZGVwZW5kZW50IG9uIGhvdy93aGVuIHRoaXMgaW9j
dGwgYXJlIG1hZGUuCj4gRHVlIHRvIHRoaXMgYmVoYXZpb3IgcGFja2V0IHN1cHBvc2VkIHRvIGFy
cml2ZSBpbiBYIFZRLCBhcnJpdmVzIGluIFkgVlEuCgoKSSBkb24ndCBnZXQgd2h5IHdlIGVuZCB1
cCB3aXRoIHRoaXMgc2l0dWF0aW9uLgoKMSkgZW5hYmxlIGN2cQoyKSBzZXQgZHJpdmVyX29rCjMp
IHNldCBSU1MKNCkgZW5hYmxlIFRYL1JYCgp2cwoKMSkgc2V0IFJTUwoyKSBlbmFibGUgY3ZxCjMp
IGVuYWJsZSBUWC9SWAo0KSBzZXQgZHJpdmVyX29rCgpJcyB0aGUgbGF0dGVyIGZhc3Rlcj8KCgo+
Cj4gMi4gRWFjaCBWUSBlbmFibGVtZW50IG9uZSBhdCBhIHRpbWUsIHJlcXVpcmVzIGNvbnN0YW50
IHN0ZWVyaW5nIHVwZGF0ZSBmb3IgdGhlIFZRCj4gV2hpbGUgdGhpcyBpbmZvcm1hdGlvbiBpcyBz
b21ldGhpbmcgYWxyZWFkeSBrbm93bi4gVHJ5aW5nIHRvIHJldXNlIGJyaW5ncyBhIGNhbGxiYWNr
IHJlc3VsdCBpbiB0aGlzIGluLWVmZmljaWVuY3kuCj4gU28gYmV0dGVyIHRvIHN0YXJ0IHdpdGgg
bW9yZSByZXVzYWJsZSBBUElzIHRoYXQgZml0cyB0aGUgTE0gZmxvdy4KCgpJIGFncmVlLCBidXQg
dGhlIG1ldGhvZCBwcm9wb3NlZCBpbiB0aGUgbWFpbCBzZWVtcyB0byBiZSB0aGUgb25seSB3YXkg
CnRoYXQgY2FuIHdvcmsgd2l0aCB0aGUgYWxsIHRoZSBtYWpvciB2RFBBIHZlbmRvcnMuCgpFLmcg
dGhlIG5ldyBBUEkgcmVxdWlyZXMgdGhlIGRldmljZSBoYXMgdGhlIGFiaWxpdHkgdG8gcmVjZWl2
ZSBkZXZpY2UgCnN0YXRlIG90aGVyIHRoYW4gdGhlIGNvbnRyb2wgdmlydHF1ZXVlIHdoaWNoIG1p
Z2h0IG5vdCBiZSBzdXBwb3J0ZWQgdGhlIApoYXJkd2FyZS4gKFRoZSBkZXZpY2UgbWlnaHQgZXhw
ZWN0cyBhIHRyYXAgYW5kIGVtdWxhdGUgbW9kZWwgcmF0aGVyIHRoYW4gCnNhdmUgYW5kIHJlc3Rv
cmUpLgoKIEZyb20gcWVtdSBwb2ludCBvZiB2aWV3LCBpdCBtaWdodCBuZWVkIHRvIHN1cHBvcnQg
Ym90aCBtb2RlbHMuCgpJZiB0aGUgZGV2aWNlIGNhbid0IGRvIHNhdmUgYW5kIHJlc3RvcmU6Cgox
LjEpIGVuYWJsZSBjdnEKMS4yKSBzZXQgZHJpdmVyX29rCjEuMykgc2V0IGRldmljZSBzdGF0ZSAo
TVEsIFJTUykgdmlhIGNvbnRyb2wgdnEKMS40KSBlbmFibGUgVFgvUlgKCklmIHRoZSBkZXZpY2Ug
Y2FuIGRvIHNhdmUgYW5kIHJlc3RvcmU6CgoyLjEpIHNldCBkZXZpY2Ugc3RhdGUgKG5ldyBBUEkg
Zm9yIHNldHRpbmcgTVEsUlNTKQoyLjIpIGVuYWJsZSBjdnEKMi4zKSBlbmFibGUgVFg/UlgKMi40
KSBzZXQgZHJpdmVyX29rCgpXZSBjYW4gc3RhcnQgZnJvbSAxIHNpbmNlIGl0IHdvcmtzIGZvciBh
bGwgZGV2aWNlIGFuZCB0aGVuIGFkZGluZyAKc3VwcG9ydCBmb3IgMj8KClRoYW5rcwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
