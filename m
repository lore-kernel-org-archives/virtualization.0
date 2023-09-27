Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF97E82CDF
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 21:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21343614B7;
	Wed, 27 Sep 2023 21:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21343614B7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YY0aW4tu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FggsOCwZaHrd; Wed, 27 Sep 2023 21:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 673CD610A2;
	Wed, 27 Sep 2023 21:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 673CD610A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA0CC0071;
	Wed, 27 Sep 2023 21:27:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A00BFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7507E83829
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7507E83829
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YY0aW4tu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZA8gIRJb5QZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:27:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76C7A8381F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76C7A8381F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695850074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NVhXHBHOJiNE7AFztQWpCxUca0e80DXZadzWQuxdrFs=;
 b=YY0aW4tukM9aIk6bYnDcp/3xhw0i6AMh3UllRxilCwizAtZczvjHp/jfoQ4tSVlRx1TKF9
 Td20JZqU0JSaAT+48oQRYr2tFNL0qHwl9QDguk9xI/fsVpoHmHlAN74UvXOrMvfI13Agsi
 BMdgWDYu6ttP+u/caRgzcnjfjm9cIYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Q34wQI4SMR-_5Ip9Jj2W7Q-1; Wed, 27 Sep 2023 17:27:52 -0400
X-MC-Unique: Q34wQI4SMR-_5Ip9Jj2W7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4052d1b19f8so108631745e9.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 14:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695850071; x=1696454871;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVhXHBHOJiNE7AFztQWpCxUca0e80DXZadzWQuxdrFs=;
 b=w0dDPZuj3sXkrzuuyLM3K/2BORxUILkWc01cnSXm6U01+IqY9v9cPTA3IGiymEEuKH
 xweR7plIyJ7k227o4nmBH6Q1pt1KwqKG+IHyPgPTHkvuC5PYc59mTGwgN9fSAC8YQxIQ
 DtMsQ/NXGgUVUJu1xiqfKnh4cNCzfmDZYXZB1W7qQ5dCXAhjFWdtudIYw87a8ozZ+wkZ
 XxudugiO89aTcPr+nvpONKw8FycdSwTjflGntq6UwHLtqOFIhk1w9V51YFGQyFRRPbOe
 i7rXRKgsHRyzYHdyme5uXQWqpIWVKZMqpJXK8wT6LA1fBUVJpSFoJr1LzxYAmoyuernZ
 Z7Yw==
X-Gm-Message-State: AOJu0Yw+uAxzwt7Fy8sp1yFEzq3Unwh01P8cifrkvdcDiEqMn/HzBVch
 VjmoSRFBTEmZVhzrojUdk7Yh2Mfyf76ApqZZTdOBk4BAT47ijUsNJb/BwdcplEnCWw+6IjGEn8u
 9s+Els2v23WlBD0SwYwjVsWeQnXE7/OvCZH1OG6fzFg==
X-Received: by 2002:a05:600c:d5:b0:404:f9c1:d5d7 with SMTP id
 u21-20020a05600c00d500b00404f9c1d5d7mr2989077wmm.25.1695850071739; 
 Wed, 27 Sep 2023 14:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIcUJn90U5HWXMApV7/w5orCfurEE6KfmvMEkl/mryjB+2TvyKWxY5JcqbSZmIYrL/4XWi2g==
X-Received: by 2002:a05:600c:d5:b0:404:f9c1:d5d7 with SMTP id
 u21-20020a05600c00d500b00404f9c1d5d7mr2989057wmm.25.1695850071378; 
 Wed, 27 Sep 2023 14:27:51 -0700 (PDT)
Received: from redhat.com ([2.52.19.249]) by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b0040586360a36sm10244285wmb.17.2023.09.27.14.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 14:27:50 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:27:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH vfio 03/11] virtio-pci: Introduce admin virtqueue
Message-ID: <20230927172553-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-4-yishaih@nvidia.com>
 <20230921095216-mutt-send-email-mst@kernel.org>
 <62df07ea-ddb6-f4ee-f7c3-1400dbe3f0a9@nvidia.com>
 <40f53b6f-f220-af35-0797-e3c60c8c1294@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <40f53b6f-f220-af35-0797-e3c60c8c1294@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, leonro@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 maorg@nvidia.com
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

T24gV2VkLCBTZXAgMjcsIDIwMjMgYXQgMDI6MTI6MjRQTSAtMDQwMCwgRmVuZyBMaXUgd3JvdGU6
Cj4gCj4gCj4gT24gMjAyMy0wOS0yNiBwLm0uMzoyMywgRmVuZyBMaXUgdmlhIFZpcnR1YWxpemF0
aW9uIHdyb3RlOgo+ID4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mg
b3IgYXR0YWNobWVudHMKPiA+IAo+ID4gCj4gPiBPbiAyMDIzLTA5LTIxIGEubS45OjU3LCBNaWNo
YWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBv
cGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gPiA+IAo+ID4gPiAKPiA+ID4gT24gVGh1LCBT
ZXAgMjEsIDIwMjMgYXQgMDM6NDA6MzJQTSArMDMwMCwgWWlzaGFpIEhhZGFzIHdyb3RlOgo+ID4g
PiA+IEZyb206IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPgo+IAo+IAo+ID4gPiA+IMKgIGRy
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2F2cS5jIHwgNjUgKysrKysrKysrKysrKysr
KysrKysrKysrKysKPiA+ID4gCj4gPiA+IGlmIHlvdSBoYXZlIGEgLmMgZmlsZSB3aXRob3V0IGEg
LmggZmlsZSB5b3Uga25vdyB0aGVyZSdzIHNvbWV0aGluZwo+ID4gPiBmaXNoeS4gSnVzdCBhZGQg
dGhpcyBpbnNpZGUgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyA/Cj4gPiA+IAo+
ID4gV2lsbCBkby4KPiA+IAo+IAo+ID4gPiA+ICtzdHJ1Y3QgdmlydGlvX2F2cSB7Cj4gPiA+IAo+
ID4gPiBhZG1pbl92cSB3b3VsZCBiZSBiZXR0ZXIuIGFuZCB0aGlzIGlzIHBjaSBzcGVjaWZpYyB5
ZXM/IHNvIHZpcnRpb19wY2lfCj4gPiA+IAo+ID4gCj4gPiBXaWxsIGRvLgo+ID4gCj4gCj4gPiA+
ID4gCj4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fYXZxICphZG1pbjsKPiA+ID4gCj4g
PiA+IGFuZCB0aGlzIGNvdWxkIGJlIHRoaW5rYWJseSBhZG1pbl92cS4KPiA+ID4gCj4gPiBXaWxs
IGRvLgo+ID4gCj4gCj4gPiA+ID4gCj4gPiA+ID4gwqAgLyogSWYgZHJpdmVyIGRpZG4ndCBhZHZl
cnRpc2UgdGhlIGZlYXR1cmUsIGl0IHdpbGwgbmV2ZXIgYXBwZWFyLiAqLwo+ID4gPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKPiA+ID4gPiBiL2luY2x1
ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+ID4gPiA+IGluZGV4IDA2N2FjMWQ3ODliYy4u
ZjZjYjEzZDg1OGZkIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX3Bj
aV9tb2Rlcm4uaAo+ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4u
aAo+ID4gPiA+IEBAIC0xMCw2ICsxMCw5IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21t
b25fY2ZnIHsKPiA+ID4gPiAKPiA+ID4gPiDCoMKgwqDCoMKgwqAgX19sZTE2IHF1ZXVlX25vdGlm
eV9kYXRhO8KgwqDCoMKgwqDCoCAvKiByZWFkLXdyaXRlICovCj4gPiA+ID4gwqDCoMKgwqDCoMKg
IF9fbGUxNiBxdWV1ZV9yZXNldDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcmVhZC13cml0
ZSAqLwo+ID4gPiA+ICsKPiA+ID4gPiArwqDCoMKgwqAgX19sZTE2IGFkbWluX3F1ZXVlX2luZGV4
O8KgwqDCoMKgwqDCoCAvKiByZWFkLW9ubHkgKi8KPiA+ID4gPiArwqDCoMKgwqAgX19sZTE2IGFk
bWluX3F1ZXVlX251bTvCoMKgwqDCoMKgwqDCoMKgIC8qIHJlYWQtb25seSAqLwo+ID4gPiA+IMKg
IH07Cj4gPiA+IAo+ID4gPiAKPiA+ID4gb3VjaC4KPiA+ID4gYWN0dWFsbHkgdGhlcmUncyBhIHBy
b2JsZW0KPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgbWRldi0+Y29tbW9uID0gdnBfbW9k
ZXJuX21hcF9jYXBhYmlsaXR5KG1kZXYsIGNvbW1vbiwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzaXplb2Yoc3RydWN0Cj4gPiA+IHZpcnRpb19wY2lfY29tbW9uX2NmZyksIDQsCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMCwgc2l6ZW9mKHN0cnVjdAo+ID4gPiB2aXJ0aW9fcGNpX2NvbW1v
bl9jZmcpLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5VTEwsIE5VTEwpOwo+ID4gPiAKPiA+
ID4gZXh0ZW5kaW5nIHRoaXMgc3RydWN0dXJlIG1lYW5zIHNvbWUgY2FsbHMgd2lsbCBzdGFydCBm
YWlsaW5nIG9uCj4gPiA+IGV4aXN0aW5nIGRldmljZXMuCj4gPiA+IAo+ID4gPiBldmVuIG1vcmUg
b2YgYW4gb3VjaCwgd2hlbiB3ZSBhZGRlZCBxdWV1ZV9ub3RpZnlfZGF0YSBhbmQgcXVldWVfcmVz
ZXQgd2UKPiA+ID4gYWxzbyBwb3NzaWJseSBicm9rZSBzb21lIGRldmljZXMuIHdlbGwgaG9wZWZ1
bGx5IG5vdCBzaW5jZSBubyBvbmUKPiA+ID4gcmVwb3J0ZWQgZmFpbHVyZXMgYnV0IHdlIHJlYWxs
eSBuZWVkIHRvIGZpeCB0aGF0Lgo+ID4gPiAKPiA+ID4gCj4gPiBIaSBNaWNoYWVsCj4gPiAKPiA+
IEkgZGlkbuKAmXQgc2VlIHRoZSBmYWlsIGluIHZwX21vZGVybl9tYXBfY2FwYWJpbGl0eSgpLCBh
bmQKPiA+IHZwX21vZGVybl9tYXBfY2FwYWJpbGl0eSgpIG9ubHkgcmVhZCBhbmQgbWFwIHBjaSBt
ZW1vcnkuIFRoZSBsZW5ndGggb2YKPiA+IHRoZSBtZW1vcnkgbWFwcGluZyB3aWxsIGluY3JlYXNl
IGFzIHRoZSBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnCj4gPiBpbmNyZWFzZXMuIE5vIGVy
cm9ycyBhcmUgc2Vlbi4KPiA+IAo+ID4gQW5kIGFjY29yZGluZyB0byB0aGUgZXhpc3RpbmcgY29k
ZSwgbmV3IHBjaSBjb25maWd1cmF0aW9uIHNwYWNlIG1lbWJlcnMKPiA+IGNhbiBvbmx5IGJlIGFk
ZGVkIGluIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnLgo+ID4gCj4gPiBFdmVy
eSBzaW5nbGUgZW50cnkgYWRkZWQgaGVyZSBpcyBwcm90ZWN0ZWQgYnkgZmVhdHVyZSBiaXQsIHRo
ZXJlIGlzIG5vCj4gPiBidWcgQUZBSUsuCj4gPiAKPiA+IENvdWxkIHlvdSBoZWxwIHRvIGV4cGxh
aW4gaXQgbW9yZSBkZXRhaWw/wqAgV2hlcmUgYW5kIHdoeSBpdCB3aWxsIGZhbGwgaWYKPiA+IHdl
IGFkZCBuZXcgbWVtYmVyIGluIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnLgo+
ID4gCj4gPiAKPiBIaSwgTWljaGFlbAo+IAlBbnkgY29tbWVudHMgYWJvdXQgdGhpcz8KPiBUaGFu
a3MKPiBGZW5nCgpJZiBhbiBleGlzdGluZyBkZXZpY2UgZXhwb3NlcyBhIHNtYWxsCmNhcGFiaWxp
dHkgbWF0Y2hpbmcgb2xkIHNpemUsIHRoZW4geW91IGNoYW5nZSBzaXplIHRoZW4KdGhlIGNoZWNr
IHdpbGwgZmFpbCBvbiB0aGUgZXhpc3RpbmcgZGV2aWNlIGFuZCBkcml2ZXIgd29uJ3QgbG9hZC4K
CkFsbCB0aGlzIGhhcHBlbnMgd2F5IGJlZm9yZSBmZWF0dXJlIGJpdCBjaGVja3MuCgoKPiA+ID4g
PiAKPiA+ID4gPiDCoCBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIHsKPiA+ID4gPiAt
LSAKPiA+ID4gPiAyLjI3LjAKPiA+ID4gCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+ID4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gPiBW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
