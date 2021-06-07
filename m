Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC23CC4743E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:31:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47468611C2
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47468611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 098E44032B;
	Mon,  7 Jun 2021 02:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgIfTrX1jzfw; Mon,  7 Jun 2021 02:30:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2D4C4029C;
	Mon,  7 Jun 2021 02:30:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89BBFC000E;
	Mon,  7 Jun 2021 02:30:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFA1C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2034540329
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0jQe3Jmi0gE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:30:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A42A4029C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623033050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ftWrDjAuGgns7tUZfM+YwyaEY5gWcXUeAuYMi5CEq8=;
 b=f2oQYUV4I+aGAROtc7/DEaLEGF9SosZiOfexTgnf8RY6kH3q7bBFzroxL+AJKouQ7+U3rU
 3IE4mwF/DCBENSQylBqqOfp3wsF8hPni1tyVBNWcFf8dsk0IlfBg467Hs33MTO4mbeDihr
 J7/VGlA5QrHoevcgMozIOf0oWG6fUN8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-WQ9DkzWkPSmyeP-__18UYw-1; Sun, 06 Jun 2021 22:30:47 -0400
X-MC-Unique: WQ9DkzWkPSmyeP-__18UYw-1
Received: by mail-pl1-f198.google.com with SMTP id
 p7-20020a170902e747b02900ef00d14127so6276190plf.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5ftWrDjAuGgns7tUZfM+YwyaEY5gWcXUeAuYMi5CEq8=;
 b=mQonkYyuAsU2Qep4dDdU7SM8ZbgHVVmeRFOCJayxZUXD4lCFjX+OtYGqIuBPtQTT9+
 vjciwPwc3hV5wYgIjylhua67tyJNpkq4VGQodbP7LXKb6ms+mXRn7e5cSFixLLY9WV/J
 TzWWYI07y7Vvi9ErUxXzm6e8Yl+vdVNGQi7W2xPGS1T3+BpNLZfldxBAxGW3VqPVwP7X
 yL2x/bg/EK4mYzhtKv1HSGel66fEfH/Xr85958d3tRE6R8sApDghNYxt35hf6391+Ujf
 QdaPN+yyTsZf0QfCeXeqPr6Bcq3faP6Lq9xnIYEmQWEdbBGxLm4oinyzl8n7UvtBk7/J
 o4kA==
X-Gm-Message-State: AOAM5313u5wnQB3X2318+0RuRAZV4hE2CaypUjtjo3oaPREJ9rYFPN97
 J6k43diZWvpnZs0E/N9j0rmFiFwQreMNA3Q9LPwWOwuAQp1ncH68IwJnIWaFoou3+2i5udVnef8
 fdXlN3+ZcFvlsysbw2fwj8S5SSqKfSf9iAMCnU7JczQ==
X-Received: by 2002:a05:6a00:170c:b029:2dc:dd8f:e083 with SMTP id
 h12-20020a056a00170cb02902dcdd8fe083mr15154712pfc.77.1623033046613; 
 Sun, 06 Jun 2021 19:30:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3i3jp5UZ+sihlmmmhsN8MN3sAd9Mve6Tji2AE1KYNIrhOf3yqoIXUSS+q4NoskX2roAUfCw==
X-Received: by 2002:a05:6a00:170c:b029:2dc:dd8f:e083 with SMTP id
 h12-20020a056a00170cb02902dcdd8fe083mr15154699pfc.77.1623033046395; 
 Sun, 06 Jun 2021 19:30:46 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o16sm6639326pfu.75.2021.06.06.19.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:30:45 -0700 (PDT)
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
To: Leon Romanovsky <leon@kernel.org>
References: <20210603112215.69259-1-elic@nvidia.com>
 <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com> <YLpNc5WsBWQ5f4cl@unreal>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c083f4b2-aa0a-ad3c-7a16-fe1c7dbda92d@redhat.com>
Date: Mon, 7 Jun 2021 10:30:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YLpNc5WsBWQ5f4cl@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

CuWcqCAyMDIxLzYvNCDkuIvljYgxMTo1NywgTGVvbiBSb21hbm92c2t5IOWGmemBkzoKPiBPbiBG
cmksIEp1biAwNCwgMjAyMSBhdCAxMDozNTo1OUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiDlnKggMjAyMS82LzMg5LiL5Y2INzoyMiwgRWxpIENvaGVuIOWGmemBkzoKPj4+IEJlZm9yZSBT
RiBzdXBwb3J0IHdhcyBpbnRyb2R1Y2VkLCB0aGUgRE1BIGRldmljZSB3YXMgZXF1YWwgdG8KPj4+
IG1kZXYtPmRldmljZSB3aGljaCB3YXMgaW4gZXNzZW5jZSBlcXVhbCB0byBwZGV2LT5kZXY7Cj4+
PiBXaXRoIFNGIGludHJvZHVjdGlvbiB0aGlzIGlzIG5vIGxvbmdlciB0cnVlLiBJdCBoYXMgYWxy
ZWFkeSBiZWVuCj4+PiBoYW5kbGVkIGZvciB2aG9zdF92ZHBhIHNpbmNlIHRoZSByZWZlcmVuY2Ug
dG8gdGhlIGRtYSBkZXZpY2UgY2FuIGZyb20KPj4+IHdpdGhpbiBtbHg1X3ZkcGEuIFdpdGggdmly
dGlvX3ZkcGEgdGhpcyBicm9rZS4gVG8gZml4IHRoaXMgd2Ugc2V0IHRoZQo+Pj4gcmVhbCBkbWEg
ZGV2aWNlIHdoZW4gaW5pdGlhbGl6aW5nIHRoZSBkZXZpY2UuCj4+Pgo+Pj4gRml4ZXM6IDFhODZi
Mzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBk
ZXZpY2VzIikKPj4KPj4gTm90ZSBzdXJlIHRoaXMgaXMgY29ycmVjdCwgYWNjb3JkaW5nIHRvIHRo
ZSBjb21taXQgbG9nIGl0IHNob3VsZCBiZSB0aGUKPj4gcGF0Y2ggdGhhdCBpbnRyb2R1Y2VzIHRo
ZSBTRiBvciBhdXggYnVzIHN1cHBvcnQgZm9yIHZEUEEuCj4gV2hlcmUgZGlkIHlvdSBzZWUgdGhh
dD8KPgo+IGdpdCBsb2cgLXAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4KPiAu
Li4KPiArICAgICAgIG12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2LT5kZXZpY2U7Cj4gKyAgICAg
ICBlcnIgPSBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKCZuZGV2LT5tdmRldik7Cj4gLi4uCj4g
ICBjb21lcyBmcm9tIGNvbW1pdCAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRy
aXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCgoKSWYgSSByZWFkIHRoZSBjb21taXQg
bG9nIGFuZCBjb2RlIGNvcnJlY3RseToKCiIKCldpdGggU0YgaW50cm9kdWN0aW9uIHRoaXMgaXMg
bm8gbG9uZ2VyIHRydWUuCgoiCgpJdCB3b3JrcyBiZWZvcmUgU0YgaXMgaW50cm9kdWNlZC4KClRo
YW5rcwoKCj4KPiBUaGFua3MKPgo+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+Cj4+Cj4+IFBhdGNoIGxvb2tzIGNvcnJlY3QuCj4+Cj4+IFRoYW5rcwo+Pgo+
Pgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAyICst
Cj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBpbmRleCBiYzMzZjJjNTIzZDMuLmE0
ZmYxNTgxODFlMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBAQCAt
MjA0Niw3ICsyMDQ2LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRw
YV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lKQo+Pj4gICAgCWlmIChlcnIpCj4+
PiAgICAJCWdvdG8gZXJyX210dTsKPj4+IC0JbXZkZXYtPnZkZXYuZG1hX2RldiA9IG1kZXYtPmRl
dmljZTsKPj4+ICsJbXZkZXYtPnZkZXYuZG1hX2RldiA9ICZtZGV2LT5wZGV2LT5kZXY7Cj4+PiAg
ICAJZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcygmbmRldi0+bXZkZXYpOwo+Pj4gICAg
CWlmIChlcnIpCj4+PiAgICAJCWdvdG8gZXJyX210dTsKPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
Cj4+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+IGh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
