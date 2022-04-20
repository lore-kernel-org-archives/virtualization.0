Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 08:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3580742567;
	Wed, 20 Apr 2022 08:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ONpu-U9D17e; Wed, 20 Apr 2022 08:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1FF0F41971;
	Wed, 20 Apr 2022 08:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7AE2C002F;
	Wed, 20 Apr 2022 08:07:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49FF8C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 374B340936
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jzGQpAUbXKue
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:07:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1882D404D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650442053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rR3PwdlS73fQgAfVhkwU0yDzAvZApVO7WnCmTeqjOIk=;
 b=B1avUxWCa0ml4NxGmjwELn9u4UEnfKjDIMuBgRxW8UnhnlzLfGOzouiusqYVVTj3AqGCL8
 8pujjcShPhe1+6c/8ugWJFuFcxfdJcKG1Grk1Jjnvk++ijZGl8gzYXhjl0oyZ/0LxToVRz
 doPJkZ3lYMTSpaOlvHejprO1PJBDfV4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-SUoPTrJZMYuhLEAPzBgAgA-1; Wed, 20 Apr 2022 04:07:32 -0400
X-MC-Unique: SUoPTrJZMYuhLEAPzBgAgA-1
Received: by mail-pg1-f198.google.com with SMTP id
 r201-20020a632bd2000000b003aa58a885d1so589176pgr.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 01:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rR3PwdlS73fQgAfVhkwU0yDzAvZApVO7WnCmTeqjOIk=;
 b=dsuPFw7uZw2WZwpKjQf6blEAznr/O2SCVy/CzBpUV/Un2wFhYFQ7FzkxVpu1Ju/D9V
 CPYNBxmmW5djFxtoNlwMhzrfYOHz0JSQuMJQpbPqQihm1LNzj52IcubndyWO0JaeMcHg
 xcA75Z9amaiNCS4G7a/3+MVQxbx4kX4D4FR2Jx1XxAj3LjfB9IUy+M3UAG1JoJIDUU5W
 3WKY/NvZrbmEG/C6POFty1aMTEsumMkm/OXCHO3idwxpjZDMztH6TfT1AEC9QaYh/Za/
 AsJOVOGMcy2mUAW6NGnUb0NZgwHApkPmCigrH5zT+AjzxYbLvlyv0NU8/4gzRgSUfzno
 DUZQ==
X-Gm-Message-State: AOAM5317n3YH5Qw05jXW7UxAnZdod6IpR95G5fVJgfvhJ1ShiTb29yWn
 6dufN8z/ZqfCa05bYPnkIprJMaa7H11UoEgxMd352APGmGpWx+9v9DXKgM3oEh0znq3sY6YqDEs
 g9e919BYmm2hSKWrUURUVz/5fnPtYfpL4P08Jtb3Z0w==
X-Received: by 2002:a17:902:a9c2:b0:156:1859:2d05 with SMTP id
 b2-20020a170902a9c200b0015618592d05mr19979680plr.86.1650442051553; 
 Wed, 20 Apr 2022 01:07:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFk59VsehZHt0zbZIPnf8EAggNgllkE5m36B1U6NvT9dCMKM3PWPk+qmffoSGn3+V68KJKCg==
X-Received: by 2002:a17:902:a9c2:b0:156:1859:2d05 with SMTP id
 b2-20020a170902a9c200b0015618592d05mr19979657plr.86.1650442051231; 
 Wed, 20 Apr 2022 01:07:31 -0700 (PDT)
Received: from [10.72.14.13] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a17090ad99000b001bcbc4247a0sm17897344pjv.57.2022.04.20.01.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 01:07:30 -0700 (PDT)
Message-ID: <b4899534-8c08-ddfc-dea0-460a94b00c32@redhat.com>
Date: Wed, 20 Apr 2022 16:07:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
To: =?UTF-8?Q?Maciej_Szyma=c5=84ski?= <maciej.szymanski@opensynergy.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
 <20220419103826-mutt-send-email-mst@kernel.org>
 <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
 <20220420023511-mutt-send-email-mst@kernel.org>
 <4080d799-b42e-018a-8b14-621295e55a8d@opensynergy.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <4080d799-b42e-018a-8b14-621295e55a8d@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIyLzQvMjAgMTU6MzIsIE1hY2llaiBTenltYcWEc2tpIOWGmemBkzoKPiBPbiAyMC4w
NC4yMDIyIDA4OjM1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IE9uIFdlZCwgQXByIDIw
LCAyMDIyIGF0IDExOjA3OjAwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiBUdWUs
IEFwciAxOSwgMjAyMiBhdCAxMTowMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPiAKPj4+IHdyb3RlOgo+Pj4+IE9uIFR1ZSwgQXByIDE5LCAyMDIyIGF0IDA0OjEyOjMxUE0g
KzAyMDAsIE1hY2llaiBTenltYcWEc2tpIHdyb3RlOgo+Pj4+PiBIZWxsbywKPj4+Pj4KPj4+Pj4g
SSd2ZSBmb3VuZCBhIHByb2JsZW0gaW4gdmlydGlvLW5ldCBkcml2ZXIuCj4+Pj4+IElmIHZpcnRp
by1uZXQgYmFja2VuZCBkZXZpY2UgYWR2ZXJ0aXNlcyBndWVzdCBvZmZsb2FkIGZlYXR1cmVzLCAK
Pj4+Pj4gdGhlcmUgaXMKPj4+Pj4gYW4gdW5wZXJtaXR0ZWQgdXNhZ2Ugb2YgY29udHJvbCB2aXJ0
cXVldWUgYmVmb3JlIGRyaXZlciBpcyAKPj4+Pj4gaW5pdGlhbGl6ZWQuCj4+Pj4+IEFjY29yZGlu
ZyB0byBWSVJUSU8gc3BlY2lmaWNhdGlvbiAyLjEuMiA6Cj4+Pj4+ICJUaGUgZGV2aWNlIE1VU1Qg
Tk9UIGNvbnN1bWUgYnVmZmVycyBvciBzZW5kIGFueSB1c2VkIGJ1ZmZlcgo+Pj4+PiBub3RpZmlj
YXRpb25zIHRvIHRoZSBkcml2ZXIgYmVmb3JlIERSSVZFUl9PSy4iCj4+Pj4gUmlnaHQuCj4+Pj4K
Pj4+Pj4gRHVyaW5nIGFuIGluaXRpYWxpemF0aW9uLCBkcml2ZXIgY2FsbHMgcmVnaXN0ZXJfbmV0
ZGV2aWNlIHdoaWNoIAo+Pj4+PiBpbnZva2VzCj4+Pj4+IGNhbGxiYWNrIGZ1bmN0aW9uIHZpcnRu
ZXRfc2V0X2ZlYXR1cmVzIGZyb20gX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzLgo+Pj4+PiBJZiBn
dWVzdCBvZmZsb2FkIGZlYXR1cmVzIGFyZSBhZHZlcnRpc2VkIGJ5IHRoZSBkZXZpY2UsCj4+Pj4+
IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzIGlzIHVzaW5nIHZpcnRuZXRfc2VuZF9jb21tYW5k
IHRvIHdyaXRlIGFuZAo+Pj4+PiByZWFkIGZyb20gVlEuCj4+Pj4+IFRoYXQgbGVhZHMgdG8gaW5p
dGlhbGl6YXRpb24gc3R1Y2sgYXMgZGV2aWNlIGlzIG5vdCBwZXJtaXR0ZWQgeWV0IAo+Pj4+PiB0
byB1c2UgVlEuCj4+Pj4KPj4+Pgo+Pj4+IEhtbSBzbyB3ZSBoYXZlIHRoaXM6Cj4+Pj4KPj4+Pgo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKChkZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVU
SUZfRl9HUk9fSFcpIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
dmktPnhkcF9lbmFibGVkKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOwo+Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZmxvYWRzID0gdmkt
Pmd1ZXN0X29mZmxvYWRzX2NhcGFibGU7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZWxzZQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBvZmZsb2FkcyA9IHZpLT5ndWVzdF9vZmZsb2Fkc19jYXBhYmxlICYKPj4+PiB+R1VF
U1RfT0ZGTE9BRF9HUk9fSFdfTUFTSzsKPj4+Pgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzKHZpLCBvZmZsb2Fkcyk7
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVycikKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aS0+Z3Vlc3Rfb2ZmbG9hZHMg
PSBvZmZsb2FkczsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pgo+Pj4+IHdoaWNoIEkgZ3Vl
c3Mgc2hvdWxkIGhhdmUgcHJldmVudGVkIHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxvYWRzIGZyb20g
Cj4+Pj4gZXZlciBydW5uaW5nLgo+Pj4+Cj4+Pj4gwqBGcm9tIHlvdXIgZGVzY3JpcHRpb24gaXQg
c291bmRzIGxpa2UgeW91IGhhdmUgb2JzZXJ2ZWQgdGhpcwo+Pj4+IGluIHByYWN0aWNlLCByaWdo
dD8KPj4+Pgo+IFllcy4gSSBoYXZlIHByb3ByaWV0YXJ5IHZpcnRpby1uZXQgZGV2aWNlIHdoaWNo
IGFkdmVydGlzZXMgZm9sbG93aW5nCj4gZ3Vlc3Qgb2ZmbG9hZCBmZWF0dXJlcyA6Cj4gLSBWSVJU
SU9fTkVUX0ZfR1VFU1RfQ1NVTQo+IC0gVklSVElPX05FVF9GX0dVRVNUX1RTTzQKPiAtIFZJUlRJ
T19ORVRfRl9HVUVTVF9UU082Cj4gLSBWSVJUSU9fTkVUX0ZfR1VFU1RfVUZPCj4KPiBUaGlzIGZl
YXR1cmUgc2V0IHBhc3NlcyB0aGUgY29uZGl0aW9uIGluIHZpcnRuZXRfc2V0X2ZlYXR1cmVzLgo+
Cj4gV2hlbiBJIGRpc2FibGUgZ3Vlc3Qgb2ZmbG9hZHMgaW4gbXkgZGV2aWNlIC0gdmlydG5ldF9z
ZXRfZ3Vlc3Rfb2ZmbG9hZHMKPiBpcyBub3QgY2FsbGVkIGFuZCBkcml2ZXIgaW5pdGlhbGl6YXRp
b24gY29tcGxldGVzIHN1Y2Nlc3NmdWxseS4KPj4+Pgo+Pj4+PiBJIGhhdmUgYXR0YWNoZWQgYSBw
YXRjaCBmb3Iga2VybmVsIDUuMTgtcmMzIHdoaWNoIGZpeGVzIHRoZSAKPj4+Pj4gcHJvYmxlbSBi
eQo+Pj4+PiBkZWZlcnJpbmcgZmVhdHVyZSBzZXQgYWZ0ZXIgdmlydGlvIGRyaXZlciBpbml0aWFs
aXphdGlvbi4KPj4+Pj4KPj4+Pj4gQmVzdCBSZWdhcmRzLAo+Pj4+Pgo+Pj4+PiAtLSAKPj4+Pj4g
TWFjaWVqIFN6eW1hxYRza2kKPj4+Pj4gU2VuaW9yIFN0YWZmIEVuZ2luZWVyCj4+Pj4+Cj4+Pj4+
IE9wZW5TeW5lcmd5IEdtYkgKPj4+Pj4gUm90aGVyc3RyLiAyMCwgMTAyNDUgQmVybGluCj4+Pj4+
Cj4+Pj4+IFBob25lOsKgwqDCoCArNDkgMzAgNjAgOTggNTQgMCAtODYKPj4+Pj4gRmF4OsKgwqDC
oMKgwqAgKzQ5IDMwIDYwIDk4IDU0IDAgLTk5Cj4+Pj4+IEUtTWFpbDrCoMKgIG1hY2llai5zenlt
YW5za2lAb3BlbnN5bmVyZ3kuY29tCj4+Pj4+Cj4+Pj4+IHd3dy5vcGVuc3luZXJneS5jb20KPj4+
Pj4KPj4+Pj4gSGFuZGVsc3JlZ2lzdGVyL0NvbW1lcmNpYWwgUmVnaXN0cnk6IEFtdHNnZXJpY2h0
IENoYXJsb3R0ZW5idXJnLCAKPj4+Pj4gSFJCIDEwODYxNkIKPj4+Pj4gR2VzY2jDpGZ0c2bDvGhy
ZXIvTWFuYWdpbmcgRGlyZWN0b3I6IFJlZ2lzIEFkamFtYWgKPj4+Pj4KPj4+Pj4gUGxlYXNlIG1p
bmQgb3VyIHByaXZhY3kgCj4+Pj4+IG5vdGljZTxodHRwczovL3d3dy5vcGVuc3luZXJneS5jb20v
ZGF0ZW5zY2h1dHplcmtsYWVydW5nL3ByaXZhY3ktbm90aWNlLWZvci1idXNpbmVzcy1wYXJ0bmVy
cy1wdXJzdWFudC10by1hcnRpY2xlLTEzLW9mLXRoZS1nZW5lcmFsLWRhdGEtcHJvdGVjdGlvbi1y
ZWd1bGF0aW9uLWdkcHIvPiAKPj4+Pj4gcHVyc3VhbnQgdG8gQXJ0LiAxMyBHRFBSLiAvLyBVbnNl
cmUgSGlud2Vpc2UgenVtIERhdGVuc2NodXR6IGdlbS4gCj4+Pj4+IEFydC4gMTMgRFNHVk8gZmlu
ZGVuIFNpZSAKPj4+Pj4gaGllci48aHR0cHM6Ly93d3cub3BlbnN5bmVyZ3kuY29tL2RlL2RhdGVu
c2NodXR6ZXJrbGFlcnVuZy9kYXRlbnNjaHV0emhpbndlaXNlLWZ1ZXItZ2VzY2hhZWZ0c3BhcnRu
ZXItZ2VtLWFydC0xMy1kc2d2by8+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4gaW5kZXggODc4MzhjYi4u
YTQ0NDYyZCAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+PiBAQCAtMjY0LDYgKzI2NCw4IEBA
IHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxv
bmcgZ3Vlc3Rfb2ZmbG9hZHM7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBn
dWVzdF9vZmZsb2Fkc19jYXBhYmxlOwo+Pj4+Pgo+Pj4+PiArwqDCoMKgwqDCoMKgIG5ldGRldl9m
ZWF0dXJlc190IGZlYXR1cmVzOwo+Pj4+PiArCj4+Pj4gSSBkb24ndCBtdWNoIGxpa2UgaG93IHdl
IGFyZSBmb3JjZWQgdG8ga2VlcCBhIGNvcHkgb2YgZmVhdHVyZXMKPj4+PiBoZXJlIDooIEF0IGxl
YXN0IHBscyBhZGQgYSBjb21tZW50IGV4cGxhaW5pbmcgd2hhdCdzIGdvaW5nIG9uLAo+Pj4+IHdo
byBvd25zIHRoaXMgZXRjLgo+IFBlcnNvbmFsbHkgSSBkb24ndCBsaWtlIHRoaXMgYXMgd2VsbCBi
dXQgSSB0aGluayBpdCBpcyBvbmx5IHdheSB0byBrZWVwCj4gdGhlIGZlYXR1cmVzIGZvciBkZWZl
cnJlZCBzZXQuCj4+Pj4KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBmYWlsb3ZlciB3aGVuIFNU
QU5EQlkgZmVhdHVyZSBlbmFibGVkICovCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGZh
aWxvdmVyICpmYWlsb3ZlcjsKPj4+Pj4gwqAgfTsKPj4+Pj4gQEAgLTI5NzYsNiArMjk3OCwxNSBA
QCBzdGF0aWMgaW50IAo+Pj4+PiB2aXJ0bmV0X2dldF9waHlzX3BvcnRfbmFtZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LCBjaGFyICpidWYsCj4+Pj4+Cj4+Pj4+IMKgIHN0YXRpYyBpbnQgdmlydG5l
dF9zZXRfZmVhdHVyZXMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRk
ZXZfZmVhdHVyZXNfdCBmZWF0dXJlcykKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoMKgwqDCoCBzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4+Pj4+ICvCoMKgwqDCoMKg
wqAgdmktPmZlYXR1cmVzID0gZmVhdHVyZXM7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsKPj4+Pj4gK30KPj4+Pgo+Pj4+IExvb2tzIGxpa2UgdGhpcyBicmVha3MgY2hhbmdp
bmcgZmVhdHVyZXMgYWZ0ZXIgaW5pdGlhbGl6YXRpb24gLQo+Pj4+IHRoZXNlIHdpbGwgbmV2ZXIg
YmUgcHJvcGFnYXRlZCB0byBoYXJkd2FyZSBub3cuCj4gSW5kZWVkLiBBbiBvcmlnaW5hbCBmdW5j
dGlvbiB3b24ndCBiZSB1c2VkLgo+Cj4+PiBZZXMsIEkgdGhpbmsgd2UgbmVlZCB0byBoYXZlIGEg
Y2hlY2sgYW5kIG9ubHkgZGVmZXIgdGhlIHNldHRpbmcgd2hlbgo+Pj4gdmlydGlvIGRldmljZSBp
cyBub3QgcmVhZHkuCj4gUmlnaHQuIEkgaGF2ZSB1cGRhdGVkIG15IHBhdGNoIHRvIGNoZWNrIHN0
YXR1cyB0byBkZWZmZXIgZmVhdHVyZSBzZXQuCj4gVGhhdCB3aWxsIGFsc28gc29sdmUgdGhlIHBy
b2JsZW0gZnJvbSBjb21tZW50IGFib3ZlLgo+Cj4+PiBUaGFua3MKPj4gSSB0aGluayB3ZSBzaG91
bGQgZmlyc3QgdW5kZXJzdGFuZCBob3cgZG9lcyB0aGUgaXNzdWUgdHJpZ2dlciwKPj4gaXMgdGhp
cyBhIHRoZW9yZXRpY2FsIG9yIGEgcHJhY3RpY2FsIGlzc3VlLgo+IEFzIG1lbnRpb25lZCBhYm92
ZSAtIHByYWN0aWNhbCBpc3N1ZS4gSXQgZG9lcyBub3Qgb2NjdXIgZm9yIGYuZS4gUUVNVQo+IGJ1
aWx0LWluIHZpcnRpby1uZXQgZGV2aWNlIGFzIGl0IGRvZXMgbm90IGFkdmVydGlzZSBndWVzdCBv
ZmZsb2FkIAo+IGZlYXR1cmVzLgoKClFlbXUgaGFzIHRoYXQgc3VwcG9ydCAoZW5hYmxlZCBieSBk
ZWZhdWx0KToKCiDCoMKgwqAgREVGSU5FX1BST1BfQklUNjQoImN0cmxfZ3Vlc3Rfb2ZmbG9hZHMi
LCBWaXJ0SU9OZXQsIGhvc3RfZmVhdHVyZXMsCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUywgdHJ1ZSksCgpCdXQg
UWVtdSBkb2Vzbid0IGNoZWNrIERSSVZFUl9PSyB3aGVuIHByb2Nlc3NpbmcgY3RybCB2cSwgdGhh
dCdzIHdoeSB3ZSAKbmV2ZXIgc2VlIGFueSByZXBvcnQgYmVmb3JlLgoKVGhhbmtzCgoKPgo+Pj4+
PiArCj4+Pj4+ICtzdGF0aWMgaW50IHZpcnRuZXRfc2V0X2ZlYXR1cmVzX2RlZmVycmVkKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXMp
Cj4+Pj4+IMKgIHsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSA9IG5ldGRldl9wcml2KGRldik7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdTY0IG9mZmxvYWRz
Owo+Pj4+PiBAQCAtMzY0NCw2ICszNjU1LDEzIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShz
dHJ1Y3QgCj4+Pj4+IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+Pj4+Cj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgdmlydGlvX2RldmljZV9yZWFkeSh2ZGV2KTsKPj4+Pj4KPj4+Pj4gK8KgwqDCoMKgwqDC
oCAvKiBEZWZlcnJlZCBmZWF0dXJlIHNldCBhZnRlciBkZXZpY2UgcmVhZHkgKi8KPj4+Pj4gK8Kg
wqDCoMKgwqDCoCBlcnIgPSB2aXJ0bmV0X3NldF9mZWF0dXJlc19kZWZlcnJlZChkZXYsIHZpLT5m
ZWF0dXJlcyk7Cj4+Pj4KPj4+PiBJdCBzZWVtcyB0aGF0IGlmIHRoaXMgaXMgY2FsbGVkIGUuZy4g
Zm9yIGEgZGV2aWNlIHdpdGhvdXQgYSBDVlEgYW5kCj4+Pj4gdGhlcmUgYXJlIHRoaW5ncyB0aGF0
IGFjdHVhbGx5IG5lZWQgdG8gY2hhbmdlIHRoZW4gaXQgd2lsbCBCVUdfT04uCj4+Pj4KPj4+Pgo+
Pj4+PiArwqDCoMKgwqDCoMKgIGlmIChlcnIpIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHJfZGVidWcoInZpcnRpb19uZXQ6IHNldCBmZWF0dXJlcyBmYWlsZWRcbiIpOwo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZyZWVfdW5yZWdpc3Rlcl9u
ZXRkZXY7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgfQo+Pj4+PiArCj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqAgZXJyID0gdmlydG5ldF9jcHVfbm90aWZfYWRkKHZpKTsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oCBpZiAoZXJyKSB7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2Rl
YnVnKCJ2aXJ0aW9fbmV0OiByZWdpc3RlcmluZyBjcHUgbm90aWZpZXIgCj4+Pj4+IGZhaWxlZFxu
Iik7Cj4+Pj4+Cj4+Pj4gLS0gCj4+Pj4gTVNUCj4+Pj4KPgo+IFBsZWFzZSBtaW5kIG91ciBwcml2
YWN5IAo+IG5vdGljZTxodHRwczovL3d3dy5vcGVuc3luZXJneS5jb20vZGF0ZW5zY2h1dHplcmts
YWVydW5nL3ByaXZhY3ktbm90aWNlLWZvci1idXNpbmVzcy1wYXJ0bmVycy1wdXJzdWFudC10by1h
cnRpY2xlLTEzLW9mLXRoZS1nZW5lcmFsLWRhdGEtcHJvdGVjdGlvbi1yZWd1bGF0aW9uLWdkcHIv
PiAKPiBwdXJzdWFudCB0byBBcnQuIDEzIEdEUFIuIC8vIFVuc2VyZSBIaW53ZWlzZSB6dW0gRGF0
ZW5zY2h1dHogZ2VtLiBBcnQuIAo+IDEzIERTR1ZPIGZpbmRlbiBTaWUgCj4gaGllci48aHR0cHM6
Ly93d3cub3BlbnN5bmVyZ3kuY29tL2RlL2RhdGVuc2NodXR6ZXJrbGFlcnVuZy9kYXRlbnNjaHV0
emhpbndlaXNlLWZ1ZXItZ2VzY2hhZWZ0c3BhcnRuZXItZ2VtLWFydC0xMy1kc2d2by8+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
