Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5658C00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 20:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D71281774;
	Mon,  1 Aug 2022 20:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D71281774
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ajm/xkeC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id naCj57bYNVK1; Mon,  1 Aug 2022 20:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A38E813CA;
	Mon,  1 Aug 2022 20:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A38E813CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC133C0032;
	Mon,  1 Aug 2022 20:12:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 578A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 20:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D223405AA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 20:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D223405AA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ajm/xkeC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zt0mMhs-dhsd
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 20:12:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9332640598
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9332640598
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659384762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kc1sFpw2lNuatI//mMoMRuF0sPT7FdNZQixKasxwawE=;
 b=ajm/xkeCgGNcoaSi2i6rRDyfBKHITj2+GrkX/2lJHLxMbkCe+WOayQPysAuvL9/D00TEI2
 4DHRbpQcHH+1tT5rVwGfbTXKyEiv78bmVd/BYbcpygCtspds5VGkDl2WQ0sJbnnxH5g4x5
 uUBa/pzC+OQtuqwmPYnyLuJuCxQBuqI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-h2COSqjzOVqPA1PGE20uQQ-1; Mon, 01 Aug 2022 16:12:41 -0400
X-MC-Unique: h2COSqjzOVqPA1PGE20uQQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 i64-20020a1c3b43000000b003a2fe4c345cso6927133wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Aug 2022 13:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=Kc1sFpw2lNuatI//mMoMRuF0sPT7FdNZQixKasxwawE=;
 b=SJLQx4/skWPIW2++reFRYGZ6oE6soFFpLvwUOg7bBJ1Svm+yEHzlqHb/QgK43OPgDC
 kTqjlNyG5mojo1UJ94vErc+MzTOb8TTZz5cXuJdzfrZkElzW651Vb5bP2oH1RoS9iRl1
 F2xImOuF1IJbya1w1HnaAV0/FOPHJpoFMc0DdXgU9vtJM4U7Gy7JNFheSgBfgizhELm0
 QcxxzJX3QY5rur0swQHGO0MlefCeYqdd7ehCb+3axDSrwU/7PPj4GNsi75IFkpMdVHRB
 BOwQJ/1lu3OFaFwv8HsvSUMuQ/1CnfjGBB2VUwH/Na0z7oKkBxHaAUNbpDReAd09CQdC
 ITzg==
X-Gm-Message-State: ACgBeo0CKRyFfRrv4YQXSq45Xb5+Jk16Hpkd8ipyLwMj4ZDjm5p9ELWi
 CGcCdlh9bxmVS6N8YrqZ2mobJuvDuMhqAY3LjavLeNiE+Fd9dEQ/8aP2ITZsPPzyFo7814hXWY9
 zGQzKG0Lp7gu23ZsA5maZP4JsiFGoWz6y4XUxCOXTMQ==
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id
 a3-20020adffb83000000b0021d649a72d9mr10733718wrr.688.1659384760034; 
 Mon, 01 Aug 2022 13:12:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Tz4ZejXUtQgcoG19U1btxFHT7BplC99FNY+fPvkO8DAysitSkTo1SmQQ/0z17+5x7LjALYA==
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id
 a3-20020adffb83000000b0021d649a72d9mr10733705wrr.688.1659384759731; 
 Mon, 01 Aug 2022 13:12:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00?
 (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de.
 [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
 by smtp.gmail.com with ESMTPSA id
 y14-20020adffa4e000000b0021eb309c97dsm12711970wrr.25.2022.08.01.13.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Aug 2022 13:12:39 -0700 (PDT)
Message-ID: <71e73194-1683-b65f-7b84-c0c719010aef@redhat.com>
Date: Mon, 1 Aug 2022 22:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
 <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
In-Reply-To: <3a5e60e8-a0d2-a1f1-28e9-e0b45069029a@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel@openvz.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Pj4+ICsKPj4+ICsJaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodmItPnZkZXYsIFZJUlRJT19CQUxM
T09OX0ZfREVGTEFURV9PTl9PT00pKQo+Pj4gKwkJbnVtX3BhZ2VzID0gLW51bV9wYWdlczsKPj4g
V2l0aCBWSVJUSU9fQkFMTE9PTl9GX0RFRkxBVEVfT05fT09NIHRoaXMgd2lsbCBub3cgYWx3YXlz
IHJlcG9ydCAiMCIuCj4+Cj4+IHdoaWNoIHdvdWxkIGJlIHRoZSBzYW1lIGFzICJudW1fcGFnZXMg
PSAwOyIgYW5kIHdvdWxkIGRlc2VydmUgYSBjb21tZW50Cj4+IGV4cGxhaW5pbmcgd2h5IHdlIGRv
bid0IGluZGljYXRlIHRoYXQgYXMgImluZmxhdGVkOiAiLgo+Pgo+PiBUaGFua3MuCj4gCj4gRXhj
ZXB0IGlmICJub3ciICByZWZlcnMgdG8gc29tZSBjb21taXQgdGhhdCBpIGFtIG1pc3NpbmcgaXQg
ZG9lcyBub3QgcmVwb3J0IDAuCgovbWUgZmFjZXBhbG0KCkkgcmVhZCAiLT0gbnVtX3BhZ2VzIgoK
PiAKPiAKPiB3aXRoIHFlbXUtc3lzdGVtLXg4Nl82NCAgLWVuYWJsZS1rdm0gLWRldmljZSB2aXJ0
aW8tYmFsbG9vbixpZD1iYWxsb29uMCxkZWZsYXRlLW9uLW9vbT1vbixub3RpZnlfb25fZW1wdHk9
b24scGFnZS1wZXItdnE9b24gLW0gM0cgLi4uLgo+IAo+IC8gIyBjYXQgL3N5cy9rZXJuZWwvZGVi
dWcvdmlydGlvLWJhbGxvb24KPiBpbmZsYXRlZDogMCBrQgo+IC8gIyBRRU1VIDQuMi4xIG1vbml0
b3IgLSB0eXBlICdoZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbgo+IChxZW11KSBiYWxsb29uIDEw
MjQKPiAocWVtdSkKPiAKPiAvICMgY2F0IC9zeXMva2VybmVsL2RlYnVnL3ZpcnRpby1iYWxsb29u
Cj4gaW5mbGF0ZWQ6IDIwOTcxNTIga0IKPiAvICMKPiAKPiB3aXRoIHFlbXUtc3lzdGVtLXg4Nl82
NMKgIC1lbmFibGUta3ZtIC1kZXZpY2UgCj4gdmlydGlvLWJhbGxvb24saWQ9YmFsbG9vbjAsZGVm
bGF0ZS1vbi1vb209b2ZmLG5vdGlmeV9vbl9lbXB0eT1vbixwYWdlLXBlci12cT1vbiAKPiAtbSAz
RyAuLi4KPiAKPiAvICMgY2F0IC9zeXMva2VybmVsL2RlYnVnL3ZpcnRpby1iYWxsb29uCj4gaW5m
bGF0ZWQ6IDAga0IKPiAvICMgUUVNVSA0LjIuMSBtb25pdG9yIC0gdHlwZSAnaGVscCcgZm9yIG1v
cmUgaW5mb3JtYXRpb24KPiAocWVtdSkgYmFsbG9vbiAxMDI0Cj4gKHFlbXUpCj4gLyAjIGNhdCAv
c3lzL2tlcm5lbC9kZWJ1Zy92aXJ0aW8tYmFsbG9vbgo+IGluZmxhdGVkOiAtMjA5NzE1MiBrQgoK
V2hhdCdzIHRoZSByYXRpb25hbGUgb2YgbWFraW5nIGl0IG5lZ2F0aXZlPwoKPiAKPiBUbyBqb2lu
IHRoZSB0aHJlYWRzOgo+IAo+Pj4gQWx3YXlzIGFjY291bnQgaW5mbGF0ZWQgbWVtb3J5IGFzIHVz
ZWQgZm9yIGJvdGggY2FzZXMgLSB3aXRoIGFuZAo+Pj4gd2l0aG91dCBkZWZsYXRlIG9uIG9vbS4g
RG8gbm90IGNoYW5nZSB0b3RhbCByYW0gd2hpY2ggY2FuIGNvbmZ1c2UKPj4+IHVzZXJzcGFjZSBh
bmQgdXNlcnMuCj4gCj4+IFNvcnJ5LCBidXQgTkFLLgo+IAo+IE9rLgo+IAo+PiBUaGlzIHdvdWxk
IGFmZmVjdCBleGlzdGluZyB1c2VycyAvIHVzZXIgc3BhY2UgLyBiYWxsb29uIHN0YXRzLiBGb3Ig
ZXhhbXBsZQo+PiBIViBqdXN0IHJlY2VudGx5IHN3aXRjaCB0byBwcm9wZXJseSB1c2luZyBhZGp1
c3RfbWFuYWdlZF9wYWdlX2NvdW50KCkKPiAKPiAKPiBJIGFtIHdvbmRlcmluZyB3aGF0J3MgdGhl
IHJhdGlvbmFsZSBiZWhpbmQgdGhpcyBpIGhhdmUgbmV2ZXIgc2VlbiBzdWNoIHVzZXJzCj4gdGhh
dCBleHBlY3QgaXQgdG8gd29yayBsaWtlIHRoaXMuIERvIHlvdSBoYXZlIGFueSBwb2ludGVycyB0
byBzdWNoIHVzZXJzLCBzbwo+IGkgY2FuIHVuZGVyc3Rvb2Qgd2h5IHRoZXkgZG8gc28gPwoKV2Ug
YWRqdXN0IHRvdGFsIHBhZ2VzIGFuZCBtYW5hZ2VkIHBhZ2VzIHRvIHNpbXVsYXRlIHdoYXQgbWVt
b3J5IGlzCmFjdHVhbGx5IGF2YWlsYWJsZSB0byB0aGUgc3lzdGVtIChqdXN0IGxpa2UgZHVyaW5n
IG1lbW9yeSBob3QodW4pcGx1ZykuCkV2ZW4gdGhvdWdoIHRoZSBwYWdlcyBhcmUgImFsbG9jYXRl
ZCIgYnkgdGhlIGRyaXZlciwgdGhleSBhcmUgYWN0dWFsbHkKdW51c2FibGUgZm9yIHRoZSBzeXN0
ZW0sIGp1c3QgYXMgaWYgdGhleSB3b3VsZCBoYXZlIGJlZW4gb2ZmbGluZWQuClN0cmljdGx5IHNw
ZWFraW5nLCB0aGUgZ3Vlc3QgT1MgY2FuIGtpbGwgYXMgbWFueSBwcm9jZXNzZXMgYXMgaXQgd2Fu
dHMsCml0IGNhbm5vdCByZWNsYWltIHRoYXQgbWVtb3J5LCBhcyBpdCdzIGxvZ2ljYWxseSBubyBs
b25nZXIgYXZhaWxhYmxlLgoKVGhlcmUgaXMgbm90aGluZyAodmFsaWQsIHdlbGwsIGV4Y2VwdCBk
cml2ZXIgdW5sb2FkaW5nKSB0aGUgZ3Vlc3QgY2FuIGRvCnRvIHJldXNlIHRoZXNlIHBhZ2VzLiBU
aGUgaHlwZXJ2aXNvciBoYXMgdG8gZ2V0IGludm9sdmVkIGZpcnN0IHRvIGdyYW50CmFjY2VzcyB0
byBzb21lIG9mIHRoZXNlIHBhZ2VzIGFnYWluIChkZWZsYXRlIHRoZSBiYWxsb29uKS4KCkl0J3Mg
ZGlmZmVyZW50IHdpdGggZGVmbGF0ZS1vbi1vb206IHRoZSBndWVzdCB3aWxsICppdHNlbGYqIGRl
Y2lkZSB0bwpyZXVzZSBpbmZsYXRlZCBwYWdlcyB0byBkZWZsYXRlIHRoZW0uIFNvIHRoZSBhbGxv
Y2F0ZWQgcGFnZXMgY2FuIGJlY29tZQpiYWNrIHVzYWJsZSBlYXNpbHkuIFRoZXJlIHdhcyBhIHJl
Y2VudCBkaXNjdXNzaW9uIGZvciB2aXJ0aW8tYmFsbG9vbiB0bwpjaGFuZ2UgdGhhdCBiZWhhdmlv
ciB3aGVuIGl0J3Mga25vd24gdGhhdCB0aGUgaHlwZXJ2aXNvciBlc3NlbnRpYWxseQppbXBsZW1l
bnRzICJkZWZsYXRlLW9uLW9vbSIgYnkgbG9va2luZyBhdCBndWVzdCBtZW1vcnkgc3RhdHMgYW5k
CmFkanVzdGluZyB0aGUgYmFsbG9vbiBzaXplIGFjY29yZGluZ2x5OyBob3dldmVyLCBhcyBsb25n
IGFzIHdlIGRvbid0Cmtub3cgd2hhdCB0aGUgaHlwZXJ2aXNvciBkb2VzIG9yIGRvZXNuJ3QgZG8s
IHdlIGhhdmUgdG8ga2VlcCB0aGUKZXhpc3RpbmcgYmVoYXZpb3IuCgpOb3RlIHRoYXQgbW9zdCBi
YWxsb29uIGRyaXZlcnMgdW5kZXIgTGludXggc2hhcmUgdGhhdCBiZWhhdmlvci4KCkluIGNhc2Ug
b2YgSHlwZXItViBJIHJlbWVtYmVyIGEgY3VzdG9tZXIgQlVHIHJlcG9ydCB0aGF0IHJlcXVlc3Rl
ZCB0aGF0CmV4YWN0IGJlaGF2aW9yLCBob3dldmVyLCBJJ20gbm90IGFibGUgdG8gbG9jYXRlIHRo
ZSBCWiBxdWlja2x5LgoKClsxXQpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvcGlw
ZXJtYWlsL3ZpcnR1YWxpemF0aW9uLzIwMjEtTm92ZW1iZXIvMDU3NzY3Lmh0bWwKKG5vdGUgdGhh
dCBJIGNhbid0IGVhc2lseSBmaW5kIHRoZSBvcmlnaW5hbCBtYWlsIGluIHRoZSBhcmNoaXZlcykK
Ck5vdGU6IEkgc3VnZ2VzdGVkIHVuZGVyIFsxXSB0byBleHBvc2UgaW5mbGF0ZWQgcGFnZXMgdmlh
IC9wcm9jL21lbWluZm8KZGlyZWN0bHkuIFdlIGNvdWxkIGRvIHRoYXQgY29uc2lzdGVudGx5IG92
ZXIgYWxsIGJhbGxvb24gZHJpdmVycyAuLi4KZG9lc24ndCBzb3VuZCB0b28gY3JhenkuCgotLSAK
VGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
