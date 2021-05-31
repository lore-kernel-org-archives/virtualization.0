Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE78C47094
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:07:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E7060FF1
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 03:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E7060FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23F2D4034D;
	Mon, 31 May 2021 03:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QeH4zpgIzSwB; Mon, 31 May 2021 03:07:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD45402A5;
	Mon, 31 May 2021 03:07:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FEFCC000D;
	Mon, 31 May 2021 03:07:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B444CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DCF840346
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i9eoOWZANXaQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:07:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97B56402A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622430425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTL2/UjTdSDOPQHR1aCCCG4K/bbvo6rC4h36u+FwzVY=;
 b=AQRTeFZhQI7Bb72hiQCbvT15RZZZzbuIqohvVagJlk5c7gyd2TIyw+cyytZ4pvi6TU6hed
 s/cOR11qOYVH80a8S4AtqhNVevZYr+RdKa8oLi70dD4cXm8O/QYeVWtWNaWCzitTx4PXGO
 htelZw4/H1+3qj+nQLTUc7hGs8kedMM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-1lK7XBSqMKqVi5nmNqG2pg-1; Sun, 30 May 2021 23:07:04 -0400
X-MC-Unique: 1lK7XBSqMKqVi5nmNqG2pg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d17-20020aa781510000b02902e921bdea05so5183341pfn.21
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 20:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hTL2/UjTdSDOPQHR1aCCCG4K/bbvo6rC4h36u+FwzVY=;
 b=XZH8QMumsrn4Gbm2/XLaKiU4NJINNuWDUe6fCWrlHzaeS84AuwsBHBhoFlEl7kI/Fc
 1k0NDABxvEOQyzV5P3txNYa8ILRSTX2iW8nGbuGfbW/qNgwD4jim2i5sqWqwa3vAgaSR
 ferdsDW0prDx7h5T+AnZWtPYOZ+vnai9T5e3jgdMvxi/YTKMkBMMkYkjTGvCShCyWX7K
 s7lpNNKZTFl65VMRzbyesprJlgQikcyxtPEb3IiDmcID7CdxT5luuUVf24cd1nmUqK1M
 7SpeurUHoypnlGpuA3SHzlZIYKdIDPs2Z+IoDeSKlWFdPAqd0rwvlwIZ6c3bEzqvRo48
 r4WQ==
X-Gm-Message-State: AOAM533SjTuVkEiGxlKJmJ5zHhb2l3V5iQhGAd+W508djnVoyT0NnURI
 9QH6C9j84Y/bEhR7LjTgb39E4OR/GW9egKhj1MR3N17uenll5esq2aK0qC+H73FCCpOW8sBUQAe
 zUMpG1TXjFWw1CfuZBzT/ZKizTrfPQ+epF5NUlKbi7Q==
X-Received: by 2002:a62:784d:0:b029:2e9:a58e:8006 with SMTP id
 t74-20020a62784d0000b02902e9a58e8006mr9607573pfc.22.1622430422917; 
 Sun, 30 May 2021 20:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSXSRoiyGyb8UjJ1wU1rpb9kNRkk78MgyQIEwemII8V7lJwu5BlyWD/0iUDxZIE8BXUTNp5w==
X-Received: by 2002:a62:784d:0:b029:2e9:a58e:8006 with SMTP id
 t74-20020a62784d0000b02902e9a58e8006mr9607551pfc.22.1622430422615; 
 Sun, 30 May 2021 20:07:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t24sm9532418pji.56.2021.05.30.20.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 20:07:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
From: Jason Wang <jasowang@redhat.com>
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
 <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
Message-ID: <c9c2a453-7ceb-a0ad-7731-d150b3bc1e53@redhat.com>
Date: Mon, 31 May 2021 11:06:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIxLzUvMzEg5LiK5Y2IMTE6MDIsIEphc29uIFdhbmcg5YaZ6YGTOgo+Cj4g5ZyoIDIw
MjEvNS8zMCDkuIvljYgzOjU0LCBFbGkgQ29oZW4g5YaZ6YGTOgo+PiBDdXJyZW50bHkgYWxsIHJl
c291cmNlcyBtdXN0IGJlIGNyZWF0ZWQgd2l0aCB1aWQgIT0gMCB3aGljaCBpcyBlc3NlbnRpYWwK
Pj4gdXNlcnNwYWNlIHByb2Nlc3NlcyBhbGxvY2F0aW5nIHZpcnRxdXVldWUgcmVzb3VyY2VzLiBT
aW5jZSB0aGlzIGlzIGEKPj4ga2VybmVsIGltcGxlbWVudGF0aW9uLCBpdCBpcyBwZXJmZWN0bHkg
bGVnYWwgdG8gb3BlbiByZXNvdXJjZXMgd2l0aAo+PiB1aWQgPT0gMC4KPj4KPj4gSW4gY2FzZSBm
cmltd2FyZSBzdXBwb3J0cywgYXZvaWQgYWxsb2NhdGluZyB1c2VyIGNvbnRleHQuCj4KPgo+IFR5
cG8gImZyaW13YXJlIi4KPgo+IE90aGVyd2lzZS4KPgo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+Cj4gKEkgZG9uJ3Qgc2VlIGFueSBjb2RlIHRvIGNoZWNrIHRo
ZSBmaXJtd2FyZSBjYXBhYmlsaXR5LCBpcyB0aGlzIAo+IGludGVuZGVkPykKCgpTcGVhayB0b28g
ZmFzdC4gSSBzZWUgdGhlIE1MWDVfQ0FQX0dFTigpLCBzbyBpdCdzIGZpbmUuCgpUaGFua3MKCgo+
Cj4gVGhhbmtzCj4KPgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlh
LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMgfCA2
ICsrKysrKwo+PiDCoCBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmMuaMKgwqDCoMKgwqAgfCA0
ICsrKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMg
Cj4+IGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwo+PiBpbmRleCA2NTIxY2Jk
MGY1YzIuLjgzNmFiOWVmMGZhNiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9yZXNvdXJjZXMuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5j
Cj4+IEBAIC01NCw2ICs1NCw5IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3VjdHgoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCAKPj4gdTE2ICp1aWQpCj4+IMKgwqDCoMKgwqAgdm9pZCAqaW47Cj4+
IMKgwqDCoMKgwqAgaW50IGVycjsKPj4gwqAgK8KgwqDCoCBpZiAoTUxYNV9DQVBfR0VOKG12ZGV2
LT5tZGV2LCB1bWVtX3VpZF8wKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiArCj4+
IMKgwqDCoMKgwqAgLyogMCBtZWFucyBub3Qgc3VwcG9ydGVkICovCj4+IMKgwqDCoMKgwqAgaWYg
KCFNTFg1X0NBUF9HRU4obXZkZXYtPm1kZXYsIGxvZ19tYXhfdWN0eCkpCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+IEBAIC03OSw2ICs4Miw5IEBAIHN0YXRpYyB2
b2lkIGRlc3Ryb3lfdWN0eChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAKPj4gKm12ZGV2LCB1MzIgdWlk
KQo+PiDCoMKgwqDCoMKgIHUzMiBvdXRbTUxYNV9TVF9TWl9EVyhkZXN0cm95X3VjdHhfb3V0KV0g
PSB7fTsKPj4gwqDCoMKgwqDCoCB1MzIgaW5bTUxYNV9TVF9TWl9EVyhkZXN0cm95X3VjdHhfaW4p
XSA9IHt9Owo+PiDCoCArwqDCoMKgIGlmICghdWlkKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
Owo+PiArCj4+IMKgwqDCoMKgwqAgTUxYNV9TRVQoZGVzdHJveV91Y3R4X2luLCBpbiwgb3Bjb2Rl
LCBNTFg1X0NNRF9PUF9ERVNUUk9ZX1VDVFgpOwo+PiDCoMKgwqDCoMKgIE1MWDVfU0VUKGRlc3Ry
b3lfdWN0eF9pbiwgaW4sIHVpZCwgdWlkKTsKPj4gwqAgZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbWx4NS9tbHg1X2lmYy5oIAo+PiBiL2luY2x1ZGUvbGludXgvbWx4NS9tbHg1X2lmYy5oCj4+
IGluZGV4IDljNjhiMmRhMTRjNi4uNjA2ZDJhZWFjYWQ0IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRl
L2xpbnV4L21seDUvbWx4NV9pZmMuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L21seDUvbWx4NV9p
ZmMuaAo+PiBAQCAtMTQ4Nyw3ICsxNDg3LDkgQEAgc3RydWN0IG1seDVfaWZjX2NtZF9oY2FfY2Fw
X2JpdHMgewo+PiDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoCB1YXJfNGtbMHgxXTsKPj4g
wqDCoMKgwqDCoCB1OMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2ZWRfYXRfMjQxWzB4OV07Cj4+IMKg
wqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIHVhcl9zelsweDZdOwo+PiAtwqDCoMKgIHU4wqDC
oMKgwqDCoMKgwqDCoCByZXNlcnZlZF9hdF8yNTBbMHg4XTsKPj4gK8KgwqDCoCB1OMKgwqDCoMKg
wqDCoMKgwqAgcmVzZXJ2ZWRfYXRfMjQ4WzB4Ml07Cj4+ICvCoMKgwqAgdTjCoMKgwqDCoMKgwqDC
oMKgIHVtZW1fdWlkXzBbMHgxXTsKPj4gK8KgwqDCoCB1OMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2
ZWRfYXRfMjUwWzB4NV07Cj4+IMKgwqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgIGxvZ19wZ19z
elsweDhdOwo+PiDCoCDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoCBiZlsweDFdOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
