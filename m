Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C01C77B61
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 13:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB53341ED4;
	Thu, 13 Apr 2023 13:39:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB53341ED4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeT7W7jE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6pPc9Falh_r; Thu, 13 Apr 2023 13:39:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECCC9418E9;
	Thu, 13 Apr 2023 13:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECCC9418E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1C2AC0036;
	Thu, 13 Apr 2023 13:39:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7426FC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EC3060BE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EC3060BE3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeT7W7jE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mKEaUKQkiSwZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:39:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A05660B55
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A05660B55
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681393147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLTEnlNnryDeu3bY+Efaxs2tlXR/HklE3XK0i2rSPDc=;
 b=HeT7W7jEKeV43tlbCzGj2EOC33R1NRcAJoqL/cgZMnr798qcgTDXjd3WJaLsAC3tXBkgfG
 n8340xvTTyH1Lh2mkmPkB/l2H9ZQevW2SJTPqduwWTshvbw7WUkg5uffzNKRh7qFwjHXTo
 23ZzmwhWa0vQ0hJJMZNe6U+HxGG+kFw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-n4OD2xDYNKGfsltfnOGvXg-1; Thu, 13 Apr 2023 09:39:05 -0400
X-MC-Unique: n4OD2xDYNKGfsltfnOGvXg-1
Received: by mail-qt1-f199.google.com with SMTP id
 y5-20020a05622a004500b003e3979be6abso10832063qtw.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 06:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681393145; x=1683985145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLTEnlNnryDeu3bY+Efaxs2tlXR/HklE3XK0i2rSPDc=;
 b=i0qpcNN/uWqUu1sBxlz7f1fAxEle0Kl8yNTHTD+lMZ2qKVYPaPQJ6HKqTNZwR2/Hqb
 598fhxmFshXlqsnvhGAnoSyrP4zYb+ZCf6qG7rXom+egdRQYjeC12F04jjwVrEfXOpgQ
 VGFQZd2MwD0wvo4aZUZc+mZu30JywKs1oX+e5fi+os4+jiiKCHZtEKIVfImv9F7gsCoH
 70oI1ivUiJVSUnsJN0PMpe/ZclBlg+05rP/pVv/kgIUvBZA4n0xWZOejI2OqiepZ3bEK
 VS16NDpX5UPPjHnhchFLTC0CPdcmHaXdu18rcYRe1Z9H1fz6uqyNSL65U3jiVtdBuP/w
 V6wg==
X-Gm-Message-State: AAQBX9d+1nmOlCA2BDrLMAv+zjLuzdCUcfUqY2VYNoGoFot+YFmmDyKq
 2o3mm92j4YRCp/uVl1qADgtKvjxBi95nfoj2k9X1pe+x8KMlK1zOenvmZjKyNQoxMomJd+ObjM+
 qVacrZA1FAqoxjEzOg4gaF83wZQs9QC+oFyRxgVAMaw==
X-Received: by 2002:a05:6214:4110:b0:5e9:8487:3978 with SMTP id
 kc16-20020a056214411000b005e984873978mr2957214qvb.41.1681393145331; 
 Thu, 13 Apr 2023 06:39:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZdVtpFtu0/c0su+y8jonHkVOioE5JF2htAL3D+ZJEQBGs2mlBkESWx6V18SUs3Dkk06xuIRA==
X-Received: by 2002:a05:6214:4110:b0:5e9:8487:3978 with SMTP id
 kc16-20020a056214411000b005e984873978mr2957192qvb.41.1681393145012; 
 Thu, 13 Apr 2023 06:39:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a0ce805000000b005eedb5cebd1sm424923qvn.130.2023.04.13.06.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 06:39:04 -0700 (PDT)
Message-ID: <9a765411-00ad-307e-9ca2-f6a7defba9cc@redhat.com>
Date: Thu, 13 Apr 2023 15:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: virtio-iommu hotplug issue
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
 <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGksCgpPbiA0LzEzLzIzIDEzOjAxLCBBa2loaWtvIE9kYWtpIHdyb3RlOgo+IE9uIDIwMjMvMDQv
MTMgMTk6NDAsIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToKPj4gSGVsbG8sCj4+Cj4+IE9u
IFRodSwgQXByIDEzLCAyMDIzIGF0IDAxOjQ5OjQzUE0gKzA5MDAsIEFraWhpa28gT2Rha2kgd3Jv
dGU6Cj4+PiBIaSwKPj4+Cj4+PiBSZWNlbnRseSBJIGVuY291bnRlcmVkIGEgcHJvYmxlbSB3aXRo
IHRoZSBjb21iaW5hdGlvbiBvZiBMaW51eCdzCj4+PiB2aXJ0aW8taW9tbXUgZHJpdmVyIGFuZCBR
RU1VIHdoZW4gYSBTUi1JT1YgdmlydHVhbCBmdW5jdGlvbiBnZXRzCj4+PiBkaXNhYmxlZC4KPj4+
IEknZCBsaWtlIHRvIGFzayB5b3Ugd2hhdCBraW5kIG9mIHNvbHV0aW9uIGlzIGFwcHJvcHJpYXRl
IGhlcmUgYW5kCj4+PiBpbXBsZW1lbnQKPj4+IHRoZSBzb2x1dGlvbiBpZiBwb3NzaWJsZS4KPj4+
Cj4+PiBBIFBDSWUgZGV2aWNlIGltcGxlbWVudGluZyB0aGUgU1ItSU9WIHNwZWNpZmljYXRpb24g
ZXhwb3J0cyBhIHZpcnR1YWwKPj4+IGZ1bmN0aW9uLCBhbmQgdGhlIGd1ZXN0IGNhbiBlbmFibGUg
b3IgZGlzYWJsZSBpdCBhdCBydW50aW1lIGJ5Cj4+PiB3cml0aW5nIHRvIGEKPj4+IGNvbmZpZ3Vy
YXRpb24gcmVnaXN0ZXIuIFRoaXMgZWZmZWN0aXZlbHkgbG9va3MgbGlrZSBhIFBDSSBkZXZpY2Ug
aXMKPj4+IGhvdHBsdWdnZWQgZm9yIHRoZSBndWVzdC4KPj4KPj4gSnVzdCBzbyBJIHVuZGVyc3Rh
bmQgdGhpcyBiZXR0ZXI6IHRoZSBndWVzdCBnZXRzIGEgd2hvbGUgUENJZSBkZXZpY2UgUEYKPj4g
dGhhdCBpbXBsZW1lbnRzIFNSLUlPViwgYW5kIHNvIHRoZSBndWVzdCBjYW4gZHluYW1pY2FsbHkg
Y3JlYXRlIFZGcz/CoAo+PiBPdXQKPj4gb2YgY3VyaW9zaXR5LCBpcyB0aGF0IGEgaGFyZHdhcmUg
ZGV2aWNlIGFzc2lnbmVkIHRvIHRoZSBndWVzdCB3aXRoIFZGSU8sCj4+IG9yIGEgZGV2aWNlIGVt
dWxhdGVkIGJ5IFFFTVU/Cj4KPiBZZXMsIHRoYXQncyByaWdodC4gVGhlIGd1ZXN0IGNhbiBkeW5h
bWljYWxseSBjcmVhdGUgYW5kIGRlbGV0ZSBWRnMuCj4gVGhlIGRldmljZSBpcyBlbXVsYXRlZCBi
eSBRRU1VOiBpZ2IsIGFuIEludGVsIE5JQyByZWNlbnRseSBhZGRlZCB0bwo+IFFFTVUgYW5kIHBy
b2plY3RlZCB0byBiZSByZWxlYXNlZCBhcyBwYXJ0IG9mIFFFTVUgOC4wLgpGcm9tIGJlbG93IGRl
c2NyaXB0aW9uIEluIHVuZGVyc3RhbmQgeW91IHRoZW4gYmluZCB0aGlzIGVtdWxhdGVkIGRldmlj
ZQp0byBWRklPIG9uIGd1ZXN0LCBjb3JyZWN0Pwo+Cj4+Cj4+PiBJbiBzdWNoIGEgY2FzZSwgdGhl
IGtlcm5lbCBhc3N1bWVzIHRoZSBlbmRwb2ludCBpcwo+Pj4gZGV0YWNoZWQgZnJvbSB0aGUgdmly
dGlvLWlvbW11IGRvbWFpbiwgYnV0IFFFTVUgYWN0dWFsbHkgZG9lcyBub3QKPj4+IGRldGFjaCBp
dC4KVGhlIFFFTVUgdmlydGlvLWlvbW11IGRldmljZSBleGVjdXRlcyBjb21tYW5kcyBmcm9tIHRo
ZSB2aXJ0aW8taW9tbXUKZHJpdmVyIGFuZCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoZSBWRklPIGlu
ZnJhIGlzIG5vdCBpbiB0cm91YmxlIGhlcmUuIEFzCnN1Z2dlc3RlZCBieSBKZWFuLCBhIGRldGFj
aCBjb21tYW5kIHByb2JhYmx5IGlzIG1pc3NlZC4KPj4+Cj4+PiBUaGlzIGluY29uc2lzdGVudCB2
aWV3IG9mIHRoZSByZW1vdmVkIGRldmljZSBzb21ldGltZXMgcHJldmVudHMgdGhlCj4+PiBWTSBm
cm9tCj4+PiBjb3JyZWN0bHkgcGVyZm9ybWluZyB0aGUgZm9sbG93aW5nIHByb2NlZHVyZSwgZm9y
IGV4YW1wbGU6Cj4+PiAxLiBFbmFibGUgYSBWRi4KPj4+IDIuIERpc2FibGUgdGhlIFZGLgo+Pj4g
My4gT3BlbiBhIHZmaW8gY29udGFpbmVyLgo+Pj4gNC4gT3BlbiB0aGUgZ3JvdXAgd2hpY2ggdGhl
IFBGIGJlbG9uZ3MgdG8uCj4+PiA1LiBBZGQgdGhlIGdyb3VwIHRvIHRoZSB2ZmlvIGNvbnRhaW5l
ci4KPj4+IDYuIE1hcCBzb21lIG1lbW9yeSByZWdpb24uCj4+PiA3LiBDbG9zZSB0aGUgZ3JvdXAu
Cj4+PiA4LiBDbG9zZSB0aGUgdmZpbyBjb250YWluZXIuCj4+PiA5LiBSZXBlYXQgMy04Cj4+Pgo+
Pj4gV2hlbiB0aGUgVkYgZ2V0cyBkaXNhYmxlZCwgdGhlIGtlcm5lbCBhc3N1bWVzIHRoZSBlbmRw
b2ludCBpcwo+Pj4gZGV0YWNoZWQgZnJvbQo+Pj4gdGhlIElPTU1VIGRvbWFpbiwgYnV0IFFFTVUg
YWN0dWFsbHkgZG9lc24ndCBkZXRhY2ggaXQuIExhdGVyLCB0aGUKPj4+IGRvbWFpbgo+Pj4gd2ls
bCBiZSByZXVzZWQgaW4gc3RlcCAzLTguCj4+Pgo+Pj4gSW4gc3RlcCA3LCB0aGUgUEYgd2lsbCBi
ZSBkZXRhY2hlZCwgYW5kIHRoZSBrZXJuZWwgdGhpbmtzIHRoZXJlIGlzIG5vCj4+PiBlbmRwb2lu
dCBhdHRhY2hlZCBhbmQgdGhlIG1hcHBpbmcgdGhlIGRvbWFpbiBob2xkcyBpcyBjbGVhcmVkLCBi
dXQKPj4+IHRoZSBWRgo+Pj4gZW5kcG9pbnQgaXMgc3RpbGwgYXR0YWNoZWQgYW5kIHRoZSBtYXBw
aW5nIGlzIGtlcHQgaW50YWN0Lgo+Pj4KPj4+IEluIHN0ZXAgOSwgdGhlIHNhbWUgZG9tYWluIHdp
bGwgYmUgcmV1c2VkIGFnYWluLCBhbmQgdGhlIGtlcm5lbAo+Pj4gcmVxdWVzdHMgdG8KPj4+IGNy
ZWF0ZSBhIG5ldyBtYXBwaW5nLCBidXQgaXQgd2lsbCBjb25mbGljdCB3aXRoIHRoZSBleGlzdGlu
ZyBtYXBwaW5nCj4+PiBhbmQKPj4+IHJlc3VsdCBpbiAtRUlOVkFMLgo+Pj4KPj4+IFRoaXMgcHJv
YmxlbSBjYW4gYmUgZml4ZWQgYnkgZWl0aGVyIG9mOgo+Pj4gLSByZXF1ZXN0aW5nIHRoZSBkZXRh
Y2htZW50IG9mIHRoZSBlbmRwb2ludCBmcm9tIHRoZSBndWVzdCB3aGVuIHRoZSBQQ0kKPj4+IGRl
dmljZSBpcyB1bnBsdWdnZWQgKHRoZSBWRiBpcyBkaXNhYmxlZCkKPj4KPj4gWWVzLCBJIHRoaW5r
IHRoaXMgaXMgYW4gaXNzdWUgaW4gdGhlIHZpcnRpby1pb21tdSBkcml2ZXIsIHdoaWNoCj4+IHNo
b3VsZCBiZQo+PiBzZW5kaW5nIGEgREVUQUNIIHJlcXVlc3Qgd2hlbiB0aGUgVkYgaXMgZGlzYWJs
ZWQsIGxpa2VseSBmcm9tCj4+IHZpb21tdV9yZWxlYXNlX2RldmljZSgpLiBJJ2xsIHdvcmsgb24g
YSBmaXggdW5sZXNzIHlvdSB3b3VsZCBsaWtlIHRvCj4+IGRvIGl0Cj4KPiBJdCB3aWxsIGJlIG5p
Y2UgaWYgeW91IHByZXBhcmUgYSBmaXguIEkgd2lsbCB0ZXN0IHlvdXIgcGF0Y2ggd2l0aCBteQo+
IHdvcmtsb2FkIGlmIHlvdSBzaGFyZSBpdCB3aXRoIG1lLgoKSSBjYW4gaGVscCB0ZXN0aW5nIHRv
bwoKVGhhbmtzCgpFcmljCj4KPiBSZWdhcmRzLAo+IEFraWhpa28gT2Rha2kKPgo+Pgo+Pj4gLSBk
ZXRlY3RpbmcgdGhhdCB0aGUgUENJIGRldmljZSBpcyBnb25lIGFuZCBhdXRvbWF0aWNhbGx5IGRl
dGFjaCBpdCBvbgo+Pj4gUUVNVS1zaWRlLgo+Pj4KPj4+IEl0IGlzIG5vdCBjb21wbGV0ZWx5IGNs
ZWFyIGZvciBtZSB3aGljaCBzb2x1dGlvbiBpcyBtb3JlIGFwcHJvcHJpYXRlCj4+PiBhcyB0aGUK
Pj4+IHZpcnRpby1pb21tdSBzcGVjaWZpY2F0aW9uIGlzIHdyaXR0ZW4gaW4gYSB3YXkgaW5kZXBl
bmRlbnQgb2YgdGhlCj4+PiBlbmRwb2ludAo+Pj4gbWVjaGFuaXNtIGFuZCBkb2VzIG5vdCBzYXkg
d2hhdCBzaG91bGQgYmUgZG9uZSB3aGVuIGEgUENJIGRldmljZSBpcwo+Pj4gdW5wbHVnZ2VkLgo+
Pgo+PiBZZXMsIEknbSBub3Qgc3VyZSBpdCdzIGluIHNjb3BlIGZvciB0aGUgc3BlY2lmaWNhdGlv
biwgaXQncyBtb3JlIGFib3V0Cj4+IHNvZnR3YXJlIGd1aWRhbmNlCj4+Cj4+IFRoYW5rcywKPj4g
SmVhbgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
