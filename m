Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A118AC04FF3
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 19:41:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2D861414
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 19:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2D861414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 149CF83A44;
	Mon, 24 May 2021 19:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWRRe5opKOak; Mon, 24 May 2021 19:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2B0A83848;
	Mon, 24 May 2021 19:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62C8EC000E;
	Mon, 24 May 2021 19:41:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C599CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 19:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9EAD1404A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 19:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d79BWyFrb8EN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 19:41:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 386E240499
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621885268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcfSAHV/HbBYuaNWDdQvTZ83TZMYeFvwpY5VZffsoCQ=;
 b=grIN13C7EQn4IgpAWyeyS7JixRWDGWmvo8n3IaU8LXL8MRb4zIu7RD+8NbK/Jzt5A2vO3R
 GqqaVWOkYYRe5TMO2zVTSgvw+bHHj4oin/am6ysAWCP808gBR/ec7R4wbPAqMHqWQ5I/qB
 Bk0uThhlppaB/aKf4SJvpwd2bnarxgY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-83YTQ3RmNi-AUq_L7S628Q-1; Mon, 24 May 2021 15:41:05 -0400
X-MC-Unique: 83YTQ3RmNi-AUq_L7S628Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 d4-20020aa7ce040000b029038d1d0524d0so15335168edv.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 12:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QcfSAHV/HbBYuaNWDdQvTZ83TZMYeFvwpY5VZffsoCQ=;
 b=MvhjTeIXyFqYQfW1PiUhtmmvxRKcgoRa5mfb5HEFRKfWKltuk2GcbEOlh00Nfr/t/M
 AenRikLNBSUM3wdx4MPcGcaUmzjNbkOYsJqnE5eCKVnMiy67iUPtOqEGGlR+eSkf2SfK
 l7sBp+zBfR7QU3CJ7pOLaHzXDVo+YXGHaFiFPHzXTH3WLkrBYv58CF3nlUVsm/BtpZGl
 Ongk87h1cLyV1C5/Ho4oo+8PzE5a/A2fMHsVu7V4t6jTuQX3/kskc++YCj3eBesea9cx
 vh67D8XvY2smoIkaaHaQXb04CaAFpPVPGqAIYnmK5jmUY724ytSahvfKuk3zUQM5qZdA
 2RAQ==
X-Gm-Message-State: AOAM53114kUip4CoHEe5J9Brls7MVxKb4lBEDfyle497IS7V1Pwhv7DI
 h6oODDX4vLRZhQFTZXKn+zvq0svI+AQiV2TzdrE1CcO80/53a7Qk3KiOzW1BnUFV2CkuToxuJSI
 vsKhX+7FoGGIkvjDUCZvV+EnQQWF3k/ruVsi/vFXNUw==
X-Received: by 2002:a17:906:9bd6:: with SMTP id
 de22mr24479783ejc.382.1621885264646; 
 Mon, 24 May 2021 12:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb4isv8pBsruVvEy4nUeVgEq0+hKwTOOLp/Fu8OxjdxDfKOhmSPBcjZq+SxEFJohnfubgZfQ==
X-Received: by 2002:a17:906:9bd6:: with SMTP id
 de22mr24479772ejc.382.1621885264427; 
 Mon, 24 May 2021 12:41:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t9sm10273326edf.70.2021.05.24.12.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 12:41:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To: =?UTF-8?B?0K7RgNC40Lkg0JrQsNC80LXQvdC10LI=?= <damtev@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20210520133908.98891-1-damtev@yandex-team.ru>
 <20210520133908.98891-2-damtev@yandex-team.ru>
 <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
 <90021621883891@mail.yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21b08ea7-71c6-1b4b-3833-1c51d0e1d310@redhat.com>
Date: Mon, 24 May 2021 21:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <90021621883891@mail.yandex-team.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

T24gMjQvMDUvMjEgMjE6MzQsINCu0YDQuNC5INCa0LDQvNC10L3QtdCyIHdyb3RlOgo+IEhpCj4g
Cj4gICAgIElzIHlvdXIgZ29hbCB0byBhdm9pZCBhY2NpZGVudGFsbHkgZGV0ZWN0aW5nIHBhcnRp
dGlvbnMgYmVjYXVzZSBpdCdzCj4gICAgIGNvbmZ1c2luZyB3aGVuIHRoYXQgaGFwcGVucz8KPiAK
PiBUaGUgbWFpbiBnb2FsIGlzIHJlZHVjaW5nIHRoZSBrZXJuZWwgc3RhcnQgdGltZS4gSXQgbWln
aHQgYmUgdXNlIHVzZWZ1bCAKPiBpbiB0aW55IHN5c3RlbXMgdGhhdCB1c2UsIGZvciBleGFtcGxl
LCBzcXVhc2hmcyBpbWFnZXMgd2l0aCBjZXJ0YWlubHkgbm8gCj4gcGFydGl0aW9ucy4gRGlzYWJs
aW5nIHBhcnRpdGlvbnMgc2Nhbm5pbmcgZm9yIHRoZXNlIGltYWdlcyBjYW4gc2F2ZSBhIAo+IGZl
dyB0ZW5zIG9mIG1pbGxpc2Vjb25kcyB3aGljaCBjYW4gYmUgYSBzaWduaWZpY2FudCBhY2NlbGVy
YXRpb24gZm9yIAo+IHN0YXJ0aW5nIHN1Y2ggc3lzdGVtcy4KClBlcmhhcHMgdGhhdCBjb3VsZCBi
ZSBjb25maWd1cmVkIGluIHRoZSBpbWFnZSwgZm9yIGV4YW1wbGUgaW4gdGhlIGtlcm5lbCAKY29t
bWFuZCBsaW5lPwoKUGFvbG8KCj4gMjQuMDUuMjAyMSwgMTc6MjksICJTdGVmYW4gSGFqbm9jemki
IDxzdGVmYW5oYUByZWRoYXQuY29tPjoKPiAKPiAgICAgT24gVGh1LCBNYXkgMjAsIDIwMjEgYXQg
MDQ6Mzk6MDhQTSArMDMwMCwgWXVyeSBLYW1lbmV2IHdyb3RlOgo+IAo+ICAgICBIaSwKPiAgICAg
SXMgdGhlcmUgYSBWSVJUSU8gc3BlYyBjaGFuZ2UgZm9yIHRoZSBuZXcgVklSVElPX0JMS19GX05P
X1BTIGZlYXR1cmUKPiAgICAgYml0PyBQbGVhc2Ugc2VuZCBvbmU6Cj4gICAgIGh0dHBzOi8vd3d3
Lm9hc2lzLW9wZW4ub3JnL2NvbW1pdHRlZXMvdGNfaG9tZS5waHA/d2dfYWJicmV2PXZpcnRpbyNm
ZWVkYmFjawo+ICAgICA8aHR0cHM6Ly93d3cub2FzaXMtb3Blbi5vcmcvY29tbWl0dGVlcy90Y19o
b21lLnBocD93Z19hYmJyZXY9dmlydGlvI2ZlZWRiYWNrPgo+IAo+ICAgICBHRU5IRF9GTF9OT19Q
QVJUX1NDQU4gaXMgbm90IHVzZWQgbXVjaCBpbiBvdGhlciBkcml2ZXJzLiBUaGlzIG1ha2VzIG1l
Cj4gICAgIHdvbmRlciBpZiB0aGUgc2FtZSB1c2UgY2FzZSBpcyBhZGRyZXNzZWQgdGhyb3VnaCBv
dGhlciBtZWFucyB3aXRoIFNDU0ksCj4gICAgIE5WTWUsIGV0YyBkZXZpY2VzLiBNYXliZSBDaHJp
c3RvcGggb3IgSmVucyBjYW4gd2VpZ2ggaW4gb24gd2hldGhlcgo+ICAgICBhZGRpbmcgYSBiaXQg
dG8gZGlzYWJsZSBwYXJ0aXRpb24gc2Nhbm5pbmcgZm9yIGEgdmlydGlvLWJsayBmaXRzIGludG8K
PiAgICAgdGhlIGJpZyBwaWN0dXJlPwo+IAo+ICAgICBJcyB5b3VyIGdvYWwgdG8gYXZvaWQgYWNj
aWRlbnRhbGx5IGRldGVjdGluZyBwYXJ0aXRpb25zIGJlY2F1c2UgaXQncwo+ICAgICBjb25mdXNp
bmcgd2hlbiB0aGF0IGhhcHBlbnM/Cj4gCj4gICAgIFZJUlRJTyBpcyBjdXJyZW50bHkgdW5kZXJn
b2luZyBhdWRpdGluZyBhbmQgY2hhbmdlcyB0byBzdXBwb3J0IHVudHJ1c3RlZAo+ICAgICBkZXZp
Y2VzLiBGcm9tIHRoYXQgcGVyc3BlY3RpdmUgYWRkaW5nIGEgZGV2aWNlIGZlYXR1cmUgYml0IHRv
IGRpc2FibGUKPiAgICAgcGFydGl0aW9uIHNjYW5uaW5nIGRvZXMgbm90IGhlbHAgcHJvdGVjdCB0
aGUgZ3Vlc3QgZnJvbSBhbiB1bnRydXN0ZWQKPiAgICAgZGlzay4gVGhlIGd1ZXN0IGNhbm5vdCB0
cnVzdCB0aGUgZGV2aWNlLCBpbnN0ZWFkIHRoZSBndWVzdCBpdHNlbGYgd291bGQKPiAgICAgbmVl
ZCB0byBiZSBjb25maWd1cmVkIHRvIGF2b2lkIHBhcnRpdGlvbiBzY2FubmluZyBvZiB1bnRydXN0
ZWQgZGV2aWNlcy4KPiAKPiAgICAgU3RlZmFuCj4gCj4gICAgICAgICAgwqBTaWduZWQtb2ZmLWJ5
OiBZdXJ5IEthbWVuZXYgPGRhbXRldkB5YW5kZXgtdGVhbS5ydQo+ICAgICAgICAgPG1haWx0bzpk
YW10ZXZAeWFuZGV4LXRlYW0ucnU+Pgo+ICAgICAgICAgIMKgLS0tCj4gICAgICAgICAgwqDCoGRy
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIHwgNiArKysrKysKPiAgICAgICAgICDCoMKgaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19ibGsuaCB8IDEgKwo+ICAgICAgICAgIMKgwqAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+IAo+ICAgICAgICAgIMKgZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jCj4gICAgICAgICBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Js
ay5jCj4gICAgICAgICAgwqBpbmRleCBiOWZhM2VmNWI1N2MuLjE3ZWRjZmVlMjIwOCAxMDA2NDQK
PiAgICAgICAgICDCoC0tLSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gICAgICAgICAg
wqArKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+ICAgICAgICAgIMKgQEAgLTc5OSw2
ICs3OTksMTAgQEAgc3RhdGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdAo+ICAgICAgICAgdmly
dGlvX2RldmljZSAqdmRldikKPiAgICAgICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoHZibGstPmRp
c2stPmZsYWdzIHw9IEdFTkhEX0ZMX0VYVF9ERVZUOwo+ICAgICAgICAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgdmJsay0+aW5kZXggPSBpbmRleDsKPiAKPiAgICAgICAgICDCoCsgLypEaXNhYmxlIHBh
cnRpdGlvbnMgc2Nhbm5pbmcgZm9yIG5vLXBhcnRpdGlvbnMgYmxvY2sqLwo+IAo+IAo+ICAgICBG
b3JtYXR0aW5nIGNsZWFudXAgYW5kIHJlcGhyYXNpbmc6Cj4gCj4gICAgICDCoMKgLyogRGlzYWJs
ZSBwYXJ0aXRpb24gc2Nhbm5pbmcgZm9yIGRldmljZXMgd2l0aCBubyBwYXJ0aXRpb25zICovCj4g
Cj4gICAgICAgICAgwqArIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0JMS19G
X05PX1BTKSkKPiAKPiAKPiAgICAgSSBzdWdnZXN0IHVzZXIgYSBtb3JlIG9idmlvdXMgbmFtZToK
PiAKPiAgICAgIMKgwqBWSVJUSU9fQkxLX0ZfTk9fUEFSVF9TQ0FOCj4gCj4gICAgICAgICAgwqAr
IHZibGstPmRpc2stPmZsYWdzIHw9IEdFTkhEX0ZMX05PX1BBUlRfU0NBTjsKPiAgICAgICAgICDC
oCsKPiAgICAgICAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIGNvbmZpZ3VyZSBxdWV1ZSBmbHVz
aCBzdXBwb3J0ICovCj4gICAgICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqB2aXJ0YmxrX3VwZGF0
ZV9jYWNoZV9tb2RlKHZkZXYpOwo+IAo+ICAgICAgICAgIMKgQEAgLTk3Nyw2ICs5ODEsNyBAQCBz
dGF0aWMgdW5zaWduZWQgaW50IGZlYXR1cmVzX2xlZ2FjeVtdID0gewo+ICAgICAgICAgIMKgwqDC
oMKgwqDCoMKgwqDCoMKgVklSVElPX0JMS19GX1JPLCBWSVJUSU9fQkxLX0ZfQkxLX1NJWkUsCj4g
ICAgICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqBWSVJUSU9fQkxLX0ZfRkxVU0gsIFZJUlRJT19C
TEtfRl9UT1BPTE9HWSwKPiAgICAgICAgIFZJUlRJT19CTEtfRl9DT05GSUdfV0NFLAo+ICAgICAg
ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgVklSVElPX0JMS19GX01RLCBWSVJUSU9fQkxLX0ZfRElT
Q0FSRCwKPiAgICAgICAgIFZJUlRJT19CTEtfRl9XUklURV9aRVJPRVMsCj4gICAgICAgICAgwqAr
IFZJUlRJT19CTEtfRl9OT19QUywKPiAgICAgICAgICDCoMKgfQo+ICAgICAgICAgIMKgwqA7Cj4g
ICAgICAgICAgwqDCoHN0YXRpYyB1bnNpZ25lZCBpbnQgZmVhdHVyZXNbXSA9IHsKPiAgICAgICAg
ICDCoEBAIC05ODQsNiArOTg5LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludCBmZWF0dXJlc1tdID0g
ewo+ICAgICAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgVklSVElPX0JMS19GX1JPLCBWSVJUSU9f
QkxLX0ZfQkxLX1NJWkUsCj4gICAgICAgICAgwqDCoMKgwqDCoMKgwqDCoMKgwqBWSVJUSU9fQkxL
X0ZfRkxVU0gsIFZJUlRJT19CTEtfRl9UT1BPTE9HWSwKPiAgICAgICAgIFZJUlRJT19CTEtfRl9D
T05GSUdfV0NFLAo+ICAgICAgICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgVklSVElPX0JMS19GX01R
LCBWSVJUSU9fQkxLX0ZfRElTQ0FSRCwKPiAgICAgICAgIFZJUlRJT19CTEtfRl9XUklURV9aRVJP
RVMsCj4gICAgICAgICAgwqArIFZJUlRJT19CTEtfRl9OT19QUywKPiAgICAgICAgICDCoMKgfTsK
PiAKPiAgICAgICAgICDCoMKgc3RhdGljIHN0cnVjdCB2aXJ0aW9fZHJpdmVyIHZpcnRpb19ibGsg
PSB7Cj4gICAgICAgICAgwqBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19i
bGsuaAo+ICAgICAgICAgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2Jsay5oCj4gICAgICAg
ICAgwqBpbmRleCBkODg4ZjAxM2Q5ZmYuLmYxOTdkMDdhZmIwNSAxMDA2NDQKPiAgICAgICAgICDC
oC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgKPiAgICAgICAgICDCoCsrKyBi
L2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgKPiAgICAgICAgICDCoEBAIC00MCw2ICs0
MCw3IEBACj4gICAgICAgICAgwqDCoCNkZWZpbmUgVklSVElPX0JMS19GX01RIDEyIC8qIHN1cHBv
cnQgbW9yZSB0aGFuIG9uZSB2cSAqLwo+ICAgICAgICAgIMKgwqAjZGVmaW5lIFZJUlRJT19CTEtf
Rl9ESVNDQVJEIDEzIC8qIERJU0NBUkQgaXMgc3VwcG9ydGVkICovCj4gICAgICAgICAgwqDCoCNk
ZWZpbmUgVklSVElPX0JMS19GX1dSSVRFX1pFUk9FUyAxNCAvKiBXUklURSBaRVJPRVMgaXMKPiAg
ICAgICAgIHN1cHBvcnRlZCAqLwo+ICAgICAgICAgIMKgKyNkZWZpbmUgVklSVElPX0JMS19GX05P
X1BTIDE2IC8qIE5vIHBhcnRpdGlvbnMgKi8KPiAKPiAgICAgICAgICDCoMKgLyogTGVnYWN5IGZl
YXR1cmUgYml0cyAqLwo+ICAgICAgICAgIMKgwqAjaWZuZGVmIFZJUlRJT19CTEtfTk9fTEVHQUNZ
Cj4gICAgICAgICAgwqAtLQo+ICAgICAgICAgIMKgMi4yNC4zIChBcHBsZSBHaXQtMTI4KQo+IAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
