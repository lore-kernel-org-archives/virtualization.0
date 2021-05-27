Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7552C47089
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 05:48:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834EF613DA
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 05:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834EF613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 322EC40365;
	Thu, 27 May 2021 05:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4AYC_uLXAvv; Thu, 27 May 2021 05:48:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A0B0401D9;
	Thu, 27 May 2021 05:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32603C000D;
	Thu, 27 May 2021 05:48:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 095DAC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6663600CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lG3XwYJwr_V9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:48:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 700EC60733
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 05:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622094529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hrDilVfh/qqPx2XPO3E6zbGSUURQs7c8ZBAfRTr1MU=;
 b=cYfJ+fwKqWjb5ctKpfS33VmGuEQ+CG6J9ojbpJdGNHlYp+6llAEgjdRcsUR7fJA9WTHjoR
 xmg5QPVBCnFqMeMqyG7o8JQsm5o4dWDKDIEmCbu44ams+sXfDIPOVjbLOVZpQBiWf4ig9M
 7kBjL6caxyN+DDh8OVHnL0MspLA632I=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-N-XIlHG9MuuEyRu_M-R-qg-1; Thu, 27 May 2021 01:48:47 -0400
X-MC-Unique: N-XIlHG9MuuEyRu_M-R-qg-1
Received: by mail-pg1-f200.google.com with SMTP id
 b17-20020a63eb510000b029021a1da627beso2294294pgk.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 22:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0hrDilVfh/qqPx2XPO3E6zbGSUURQs7c8ZBAfRTr1MU=;
 b=fcVb8taOe/nid7J5a92jfJZDCBFqmCnzIdiktlRKewYMbeyfHiFfQCWXrU2qncGPQ7
 GsoFmJs3HZid7eRfBO5vAnE0DUHs6LvwzFjulqCb6RMBcB0SVKQ/j77xmIP+oTwbvnvn
 iUMksLhlkO6PxLpJ77uE3ARuk2mZiYupVPI9dsJ6sPDQfKACMDFJOW9+N8213Xkzib3s
 zuCgvjFP0Ata5cU+irfNmHaus7jLmEVFVdqnlIZ68ZgEbFzR33U3o79TUETldgghQ1EX
 YhKUFlpEiQWyKwzA3UxqO3geUI0kkHukksmcDFVZyIDDQo8e0ydHlaS2d0UNjnPOIu56
 uCgw==
X-Gm-Message-State: AOAM531/dNL8feZd7hs7aYh6XJ9gbmjSF9HaeOX1foqNs8DCDpLcTBIl
 zyP7/A5QSxMMXCKXv+zEuO8c/S1lg+roxbwR2aVxlyx1hllzVQt4Qc+XnudkfrQtfDVDpMP89Mo
 bQLgE+Qz29P1DBTNpYL46fRXebKTX4OPSoP2ZbHwGvA==
X-Received: by 2002:a63:6cc1:: with SMTP id h184mr2135512pgc.367.1622094525882; 
 Wed, 26 May 2021 22:48:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhiC4pUyikKRVg/fGg/BEWY/NKv/DsEJoI/3n+vZ8sn2JoDl+AANg2WvJ/mb0S+nQ+EAS4Ag==
X-Received: by 2002:a63:6cc1:: with SMTP id h184mr2135485pgc.367.1622094525472; 
 Wed, 26 May 2021 22:48:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o186sm873098pfg.170.2021.05.26.22.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 22:48:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <eefac014-0361-b554-ffdc-2ce920810fa5@redhat.com>
 <YKy8Znh/MqHWSmON@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c51191b8-d741-2abc-0446-8a139e2ea401@redhat.com>
Date: Thu, 27 May 2021 13:48:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKy8Znh/MqHWSmON@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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

CuWcqCAyMDIxLzUvMjUg5LiL5Y2INDo1OSwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPiBPbiBU
dWUsIE1heSAyNSwgMjAyMSBhdCAxMToyMTo0MUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiDlnKggMjAyMS81LzIwIOS4i+WNiDEwOjEzLCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+Pj4g
UmVxdWVzdCBjb21wbGV0aW9uIGxhdGVuY3kgY2FuIGJlIHJlZHVjZWQgYnkgdXNpbmcgcG9sbGlu
ZyBpbnN0ZWFkIG9mCj4+PiBpcnFzLiBFdmVuIFBvc3RlZCBJbnRlcnJ1cHRzIG9yIHNpbWlsYXIg
aGFyZHdhcmUgc3VwcG9ydCBkb2Vzbid0IGJlYXQKPj4+IHBvbGxpbmcuIFRoZSByZWFzb24gaXMg
dGhhdCBkaXNhYmxpbmcgdmlydHF1ZXVlIG5vdGlmaWNhdGlvbnMgc2F2ZXMKPj4+IGNyaXRpY2Fs
LXBhdGggQ1BVIGN5Y2xlcyBvbiB0aGUgaG9zdCBieSBza2lwcGluZyBpcnEgaW5qZWN0aW9uIGFu
ZCBpbgo+Pj4gdGhlIGd1ZXN0IGJ5IHNraXBwaW5nIHRoZSBpcnEgaGFuZGxlci4gU28gbGV0J3Mg
YWRkIGJsa19tcV9vcHMtPnBvbGwoKQo+Pj4gc3VwcG9ydCB0byB2aXJ0aW9fYmxrLgo+Pj4KPj4+
IFRoZSBhcHByb2FjaCB0YWtlbiBieSB0aGlzIHBhdGNoIGRpZmZlcnMgZnJvbSB0aGUgTlZNZSBk
cml2ZXIncwo+Pj4gYXBwcm9hY2guIE5WTWUgZGVkaWNhdGVzIGhhcmR3YXJlIHF1ZXVlcyB0byBw
b2xsaW5nIGFuZCBzdWJtaXRzCj4+PiBSRVFfSElQUkkgcmVxdWVzdHMgb25seSBvbiB0aG9zZSBx
dWV1ZXMuIFRoaXMgcGF0Y2ggZG9lcyBub3QgcmVxdWlyZQo+Pj4gZXhjbHVzaXZlIHBvbGxpbmcg
cXVldWVzIGZvciB2aXJ0aW9fYmxrLiBJbnN0ZWFkLCBpdCBzd2l0Y2hlcyBiZXR3ZWVuCj4+PiBp
cnFzIGFuZCBwb2xsaW5nIHdoZW4gb25lIG9yIG1vcmUgUkVRX0hJUFJJIHJlcXVlc3RzIGFyZSBp
biBmbGlnaHQgb24gYQo+Pj4gdmlydHF1ZXVlLgo+Pj4KPj4+IFRoaXMgaXMgcG9zc2libGUgYmVj
YXVzZSB0b2dnbGluZyB2aXJ0cXVldWUgbm90aWZpY2F0aW9ucyBpcyBjaGVhcCBldmVuCj4+PiB3
aGlsZSB0aGUgdmlydHF1ZXVlIGlzIHJ1bm5pbmcuIE5WTWUgY3FzIGNhbid0IGRvIHRoaXMgYmVj
YXVzZSBpcnFzIGFyZQo+Pj4gb25seSBlbmFibGVkL2Rpc2FibGVkIGF0IHF1ZXVlIGNyZWF0aW9u
IHRpbWUuCj4+Pgo+Pj4gVGhpcyB0b2dnbGluZyBhcHByb2FjaCByZXF1aXJlcyBubyBjb25maWd1
cmF0aW9uLiBUaGVyZSBpcyBubyBuZWVkIHRvCj4+PiBkZWRpY2F0ZSBxdWV1ZXMgYWhlYWQgb2Yg
dGltZSBvciB0byB0ZWFjaCB1c2VycyBhbmQgb3JjaGVzdHJhdGlvbiB0b29scwo+Pj4gaG93IHRv
IHNldCB1cCBwb2xsaW5nIHF1ZXVlcy4KPj4+Cj4+PiBQb3NzaWJsZSBkcmF3YmFja3Mgb2YgdGhp
cyBhcHByb2FjaDoKPj4+Cj4+PiAtIEhhcmR3YXJlIHZpcnRpb19ibGsgaW1wbGVtZW50YXRpb25z
IG1heSBmaW5kIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKCkKPj4+ICAgICBleHBlbnNpdmUgc2luY2Ug
aXQgcmVxdWlyZXMgRE1BLgo+Pgo+PiBOb3RlIHRoYXQgaXQncyBwcm9iYWJseSBub3QgcmVsYXRl
ZCB0byB0aGUgYmVoYXZpb3Igb2YgdGhlIGRyaXZlciBidXQgdGhlCj4+IGRlc2lnbiBvZiB0aGUg
ZXZlbnQgc3VwcHJlc3Npb24gbWVjaGFuaXNtLgo+Pgo+PiBEZXZpY2UgY2FuIGNob29zZSB0byBp
Z25vcmUgdGhlIHN1cHByZXNzaW9uIGZsYWcgYW5kIGtlZXAgc2VuZGluZwo+PiBpbnRlcnJ1cHRz
Lgo+IFllcywgaXQncyB0aGUgZGVzaWduIG9mIHRoZSBldmVudCBzdXBwcmVzc2lvbiBtZWNoYW5p
c20uCj4KPiBJZiB3ZSB1c2UgZGVkaWNhdGVkIHBvbGxpbmcgdmlydHF1ZXVlcyB0aGVuIHRoZSBo
YXJkd2FyZSBkb2Vzbid0IG5lZWQgdG8KPiBjaGVjayB3aGV0aGVyIGludGVycnVwdHMgYXJlIGVu
YWJsZWQgZm9yIGVhY2ggbm90aWZpY2F0aW9uLiBIb3dldmVyLAo+IHRoZXJlJ3Mgbm8gbWVjaGFu
aXNtIHRvIHRlbGwgdGhlIGRldmljZSB0aGF0IHZpcnRxdWV1ZSBpbnRlcnJ1cHRzIGFyZQo+IHBl
cm1hbmVudGx5IGRpc2FibGVkLiBUaGlzIG1lYW5zIHRoYXQgYXMgb2YgdG9kYXksIGV2ZW4gZGVk
aWNhdGVkCj4gdmlydHF1ZXVlcyBjYW5ub3Qgc3VwcHJlc3MgaW50ZXJydXB0cyB3aXRob3V0IHRo
ZSBkZXZpY2UgY2hlY2tpbmcgZm9yCj4gZWFjaCBub3RpZmljYXRpb24uCgoKVGhpcyBjYW4gYmUg
ZGV0ZWN0ZWQgdmlhIGEgdHJhbnNwb3J0IHNwZWNpZmljIHdheS4KCkUuZyBpbiB0aGUgY2FzZSBv
ZiBNU0ksIFZJUlRJT19NU0lfTk9fVkVDVE9SIGNvdWxkIGJlIGEgaGludC4KCgo+Cj4+PiAgICBJ
ZiBzdWNoIGRldmljZXMgYmVjb21lIHBvcHVsYXIgdGhlbgo+Pj4gICAgIHRoZSB2aXJ0aW9fYmxr
IGRyaXZlciBjb3VsZCB1c2UgYSBzaW1pbGFyIGFwcHJvYWNoIHRvIE5WTWUgd2hlbgo+Pj4gICAg
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBpcyBkZXRlY3RlZCBpbiB0aGUgZnV0dXJlLgo+Pj4K
Pj4+IC0gSWYgYSBibGtfcG9sbCgpIHRocmVhZCBpcyBkZXNjaGVkdWxlZCBpdCBub3Qgb25seSBo
dXJ0cyBwb2xsaW5nCj4+PiAgICAgcGVyZm9ybWFuY2UgYnV0IGFsc28gZGVsYXlzIGNvbXBsZXRp
b24gb2Ygbm9uLVJFUV9ISVBSSSByZXF1ZXN0cyBvbgo+Pj4gICAgIHRoYXQgdmlydHF1ZXVlIHNp
bmNlIHZxIG5vdGlmaWNhdGlvbnMgYXJlIGRpc2FibGVkLgo+Pgo+PiBDYW4gd2UgcG9sbCBvbmx5
IHdoZW4gb25seSBoaWdoIHByaSByZXF1ZXN0cyBhcmUgcGVuZGluZz8KPiBZZXMsIHRoYXQncyB3
aGF0IHRoaXMgcGF0Y2ggZG9lcy4KPgo+PiBJZiB0aGUgYmFja2VuZCBpcyBhIHJlbW90ZSBvbmUs
IEkgdGhpbmsgdGhlIHBvbGxpbmcgbWF5IGNhdXNlIG1vcmUgY3B1Cj4+IGN5Y2xlcy4KPiBSaWdo
dCwgYnV0IHBvbGxpbmcgaXMgb25seSBkb25lIHdoZW4gdXNlcnNwYWNlIHNldHMgdGhlIFJXRl9I
SVBSSQo+IHJlcXVlc3QgZmxhZy4gTW9zdCBhcHBsaWNhdGlvbnMgZG9uJ3Qgc3VwcG9ydCBpdCBh
bmQgZm9yIHRob3NlIHRoYXQgZG8KPiBpdCdzIHByb2JhYmx5IGFuIG9wdGlvbiB0aGF0IHRoZSB1
c2VyIG5lZWRzIHRvIGVuYWJsZSBleHBsaWNpdGx5LgoKCkkgc2VlLgoKCj4KPiBTdGVmYW4KPgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMKPj4+IGluZGV4IGZjMGZiMWRjZDM5OS4uZjAyNDNkY2Q3NDVhIDEwMDY0
NAo+Pj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPj4+ICsrKyBiL2RyaXZlcnMv
YmxvY2svdmlydGlvX2Jsay5jCj4+PiBAQCAtMjksNiArMjksMTYgQEAgc3RhdGljIHN0cnVjdCB3
b3JrcXVldWVfc3RydWN0ICp2aXJ0YmxrX3dxOwo+Pj4gICAgc3RydWN0IHZpcnRpb19ibGtfdnEg
ewo+Pj4gICAgCXN0cnVjdCB2aXJ0cXVldWUgKnZxOwo+Pj4gICAgCXNwaW5sb2NrX3QgbG9jazsK
Pj4+ICsKPj4+ICsJLyogTnVtYmVyIG9mIG5vbi1SRVFfSElQUkkgcmVxdWVzdHMgaW4gZmxpZ2h0
LiBQcm90ZWN0ZWQgYnkgbG9jay4gKi8KPj4+ICsJdW5zaWduZWQgaW50IG51bV9sb3ByaTsKPj4+
ICsKPj4+ICsJLyogTnVtYmVyIG9mIFJFUV9ISVBSSSByZXF1ZXN0cyBpbiBmbGlnaHQuIFByb3Rl
Y3RlZCBieSBsb2NrLiAqLwo+Pj4gKwl1bnNpZ25lZCBpbnQgbnVtX2hpcHJpOwo+Pj4gKwo+Pj4g
KwkvKiBBcmUgdnEgbm90aWZpY2F0aW9ucyBlbmFibGVkPyBQcm90ZWN0ZWQgYnkgbG9jay4gKi8K
Pj4+ICsJYm9vbCBjYl9lbmFibGVkOwo+Pgo+PiBXZSBoYWQgZXZlbnRfZmxhZ19zaGFkb3csIGlz
IGl0IHN1ZmZpY2llbnQgdG8gaW50cm9kdWNlIGEgbmV3IGhlbHBlcgo+PiB2aXJ0cXVldWVfY2Jf
aXNfZW5hYmxlZCgpPwo+IFllcywgSSdsbCB0cnkgdGhhdCBpbiB0aGUgbmV4dCByZXZpc2lvbi4K
Pgo+Pj4gKwo+Pj4gICAgCWNoYXIgbmFtZVtWUV9OQU1FX0xFTl07Cj4+PiAgICB9IF9fX19jYWNo
ZWxpbmVfYWxpZ25lZF9pbl9zbXA7Cj4+PiBAQCAtMTcxLDMzICsxODEsNjcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIHZpcnRibGtfcmVxdWVzdF9kb25lKHN0cnVjdCByZXF1ZXN0ICpyZXEpCj4+PiAg
ICAJYmxrX21xX2VuZF9yZXF1ZXN0KHJlcSwgdmlydGJsa19yZXN1bHQodmJyKSk7Cj4+PiAgICB9
Cj4+PiAtc3RhdGljIHZvaWQgdmlydGJsa19kb25lKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+Pj4g
Ky8qIFJldHVybnMgdHJ1ZSBpZiBvbmUgb3IgbW9yZSByZXF1ZXN0cyBjb21wbGV0ZWQgKi8KPj4+
ICtzdGF0aWMgYm9vbCB2aXJ0YmxrX2NvbXBsZXRlX3JlcXVlc3RzKHN0cnVjdCB2aXJ0cXVldWUg
KnZxKQo+Pj4gICAgewo+Pj4gICAgCXN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gdnEtPnZkZXYt
PnByaXY7Cj4+PiAgICAJc3RydWN0IHZpcnRpb19ibGtfdnEgKnZicSA9ICZ2YmxrLT52cXNbdnEt
PmluZGV4XTsKPj4+ICAgIAlib29sIHJlcV9kb25lID0gZmFsc2U7Cj4+PiArCWJvb2wgbGFzdF9o
aXByaV9kb25lID0gZmFsc2U7Cj4+PiAgICAJc3RydWN0IHZpcnRibGtfcmVxICp2YnI7Cj4+PiAg
ICAJdW5zaWduZWQgbG9uZyBmbGFnczsKPj4+ICAgIAl1bnNpZ25lZCBpbnQgbGVuOwo+Pj4gICAg
CXNwaW5fbG9ja19pcnFzYXZlKCZ2YnEtPmxvY2ssIGZsYWdzKTsKPj4+ICsKPj4+ICAgIAlkbyB7
Cj4+PiAtCQl2aXJ0cXVldWVfZGlzYWJsZV9jYih2cSk7Cj4+PiArCQlpZiAodmJxLT5jYl9lbmFi
bGVkKQo+Pj4gKwkJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHZxKTsKPj4+ICAgIAkJd2hpbGUgKCh2
YnIgPSB2aXJ0cXVldWVfZ2V0X2J1Zih2cSwgJmxlbikpICE9IE5VTEwpIHsKPj4+ICAgIAkJCXN0
cnVjdCByZXF1ZXN0ICpyZXEgPSBibGtfbXFfcnFfZnJvbV9wZHUodmJyKTsKPj4+ICsJCQlpZiAo
cmVxLT5jbWRfZmxhZ3MgJiBSRVFfSElQUkkpIHsKPj4+ICsJCQkJaWYgKC0tdmJxLT5udW1faGlw
cmkgPT0gMCkKPj4+ICsJCQkJCWxhc3RfaGlwcmlfZG9uZSA9IHRydWU7Cj4+PiArCQkJfSBlbHNl
Cj4+PiArCQkJCXZicS0+bnVtX2xvcHJpLS07Cj4+PiArCj4+PiAgICAJCQlpZiAobGlrZWx5KCFi
bGtfc2hvdWxkX2Zha2VfdGltZW91dChyZXEtPnEpKSkKPj4+ICAgIAkJCQlibGtfbXFfY29tcGxl
dGVfcmVxdWVzdChyZXEpOwo+Pj4gICAgCQkJcmVxX2RvbmUgPSB0cnVlOwo+Pj4gICAgCQl9Cj4+
PiAgICAJCWlmICh1bmxpa2VseSh2aXJ0cXVldWVfaXNfYnJva2VuKHZxKSkpCj4+PiAgICAJCQli
cmVhazsKPj4+IC0JfSB3aGlsZSAoIXZpcnRxdWV1ZV9lbmFibGVfY2IodnEpKTsKPj4+ICsKPj4+
ICsJCS8qIEVuYWJsZSB2cSBub3RpZmljYXRpb25zIGlmIG5vbi1wb2xsZWQgcmVxdWVzdHMgcmVt
YWluICovCj4+PiArCQlpZiAobGFzdF9oaXByaV9kb25lICYmIHZicS0+bnVtX2xvcHJpID4gMCkg
ewo+Pj4gKwkJCWxhc3RfaGlwcmlfZG9uZSA9IGZhbHNlOwo+Pj4gKwkJCXZicS0+Y2JfZW5hYmxl
ZCA9IHRydWU7Cj4+PiArCQl9Cj4+PiArCX0gd2hpbGUgKHZicS0+Y2JfZW5hYmxlZCAmJiAhdmly
dHF1ZXVlX2VuYWJsZV9jYih2cSkpOwo+Pj4gICAgCS8qIEluIGNhc2UgcXVldWUgaXMgc3RvcHBl
ZCB3YWl0aW5nIGZvciBtb3JlIGJ1ZmZlcnMuICovCj4+PiAgICAJaWYgKHJlcV9kb25lKQo+Pj4g
ICAgCQlibGtfbXFfc3RhcnRfc3RvcHBlZF9od19xdWV1ZXModmJsay0+ZGlzay0+cXVldWUsIHRy
dWUpOwo+Pj4gICAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZicS0+bG9jaywgZmxhZ3MpOwo+
Pj4gKwo+Pj4gKwlyZXR1cm4gcmVxX2RvbmU7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbnQg
dmlydGJsa19wb2xsKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQo+Pj4gK3sKPj4+ICsJc3Ry
dWN0IHZpcnRpb19ibGsgKnZibGsgPSBoY3R4LT5xdWV1ZS0+cXVldWVkYXRhOwo+Pj4gKwlzdHJ1
Y3QgdmlydHF1ZXVlICp2cSA9IHZibGstPnZxc1toY3R4LT5xdWV1ZV9udW1dLnZxOwo+Pj4gKwo+
Pj4gKwlpZiAoIXZpcnRxdWV1ZV9tb3JlX3VzZWQodnEpKQo+Pgo+PiBJJ20gbm90IGZhbWlsaWFy
IHdpdGggYmxvY2sgcG9sbGluZyBidXQgd2hhdCBoYXBwZW5zIGlmIGEgYnVmZmVyIGlzIG1hZGUK
Pj4gYXZhaWxhYmxlIGFmdGVyIHZpcnRxdWV1ZV9tb3JlX3VzZWQoKSByZXR1cm5zIGZhbHNlIGhl
cmU/Cj4gQ2FuIHlvdSBleHBsYWluIHRoZSBzY2VuYXJpbywgSSdtIG5vdCBzdXJlIEkgdW5kZXJz
dGFuZD8gImJ1ZmZlciBpcyBtYWRlCj4gYXZhaWxhYmxlIiAtPiBhcmUgeW91IHRoaW5raW5nIGFi
b3V0IGFkZGl0aW9uYWwgcmVxdWVzdHMgYmVpbmcgc3VibWl0dGVkCj4gYnkgdGhlIGRyaXZlciBv
ciBhbiBpbi1mbGlnaHQgcmVxdWVzdCBiZWluZyBtYXJrZWQgdXNlZCBieSB0aGUgZGV2aWNlPwoK
ClNvbWV0aGluZyBsaWtlIHRoYXQ6CgoxKSByZXF1ZXN0cyBhcmUgc3VibWl0dGVkCjIpIHBvbGwg
YnV0IHZpcnRxdWV1ZV9tb3JlX3VzZWQoKSByZXR1cm4gZmFsc2UKMykgZGV2aWNlIG1ha2UgYnVm
ZmVyIHVzZWQKCkluIHRoaXMgY2FzZSwgd2lsbCBwb2xsKCkgYmUgdHJpZ2dlcmVkIGFnYWluIGJ5
IHNvbWVib2R5IGVsc2U/IChJIHRoaW5rIAppbnRlcnJ1cHQgaXMgZGlzYWJsZWQgaGVyZSkuCgpU
aGFua3MKCgoKPgo+IFN0ZWZhbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
