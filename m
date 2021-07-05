Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F81C07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 07:30:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5986135D
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5986135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FFCA40004;
	Mon,  5 Jul 2021 07:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQyaG4zuFarR; Mon,  5 Jul 2021 07:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 575F8400B5;
	Mon,  5 Jul 2021 07:30:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B123C001A;
	Mon,  5 Jul 2021 07:30:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D41C7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9AFF400B5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plmniz6qLwX2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:29:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 195A240004
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625470198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrSBmzvOS6/PS/ey8rda3qmHumcD6j+TIXTeJ0gyPEk=;
 b=BslUoJ2n+c5ICoq+zmAWHxkPXeHlImCeMXh0mih86rbJIjYC1wiJw2/0+ELciLOdnUvMbq
 Rv+IQagi9kflh4Z/vYdUAVuSDhi2/r17ZKaafOGedp/WVcHEyeCb6G0iNxOSgxN1BT3KIH
 ZQwluFHGZ5nXofJbJvciLOKTvouVoS4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-DU86ULoZN-WnyrH_5dNtsg-1; Mon, 05 Jul 2021 03:29:56 -0400
X-MC-Unique: DU86ULoZN-WnyrH_5dNtsg-1
Received: by mail-pg1-f197.google.com with SMTP id
 w38-20020a6347660000b029022342ce1f8bso12987376pgk.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 00:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TrSBmzvOS6/PS/ey8rda3qmHumcD6j+TIXTeJ0gyPEk=;
 b=fG+k80psKNRvz38vKz/bSB7KdoqmF4HHq/M3l+PIB3Ekt3EK7SooVw+GOCjHeLyNVu
 7ROXQOrK9VJFVpoQcgWjAbROYte9P0JZ6Atf0i8ocI0CfIZYjip9Zf8WZyVZYcDcmY3m
 CHKzqva7RRcUGP4ZNlz4+XcL37Chl09lQ2wW3bgYfwIO4XRUQOnjqOlVDoPidfmJCR80
 hn+Sdq6wTPOgE0UEVPrIf6DBf44b+agXGNaquH5TG7HaRlkbpeuNJ776uUOM6w9Ftksi
 6q1m6qHJnpt2/1CxETND/eb0uTXvkUvc5fsZPdD8Z4+h+jkRefdqMf6GxUejVrPtzyo9
 qOcA==
X-Gm-Message-State: AOAM532wu4f11ecSh66wn3kHObq/i16AfxodjvY6nJE0WzHuTnse09YE
 CuYYgGEePCLF6fDeoG3CVppEZVEVLJ+AQ6ihUT7JrBwyJJshoVre55D+fUDqR+KISR8rXz3zGEP
 REkV05fPTs6VUWF0ChtnZd2q3vz5kpe7f0mX3twZduw==
X-Received: by 2002:a62:e40c:0:b029:317:3367:c5db with SMTP id
 r12-20020a62e40c0000b02903173367c5dbmr13828154pfh.62.1625470195672; 
 Mon, 05 Jul 2021 00:29:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyPuvIjsJjbwagcjsnQti/B3SFzhjFQwJhjth684dqQCP2e9nWAUj+nOHvnbWfsYhmocWiLA==
X-Received: by 2002:a62:e40c:0:b029:317:3367:c5db with SMTP id
 r12-20020a62e40c0000b02903173367c5dbmr13828142pfh.62.1625470195452; 
 Mon, 05 Jul 2021 00:29:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z76sm11997064pfc.173.2021.07.05.00.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jul 2021 00:29:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum virtqueue
 size
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
 <20210705032602-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
Date: Mon, 5 Jul 2021 15:29:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705032602-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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

CtTaIDIwMjEvNy81IM/CzuczOjI2LCBNaWNoYWVsIFMuIFRzaXJraW4g0LS1wDoKPiBPbiBNb24s
IEp1bCAwNSwgMjAyMSBhdCAwMzoxOToxMFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBU
aGlzIHBhdGNoIHN3aXRjaCB0byByZWFkIHZpcnRxdWV1ZSBzaXplIGZyb20gdGhlIGNhcGFiaWxp
dHkgaW5zdGVhZAo+PiBvZiBkZXBlbmRpbmcgb24gdGhlIGhhcmRjb2RlZCB2YWx1ZS4gVGhpcyBh
bGxvd3MgdGhlIHBlciB2aXJ0cXVldWUKPj4gc2l6ZSBjb3VsZCBiZSBhZHZlcnRpc2VkLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNvIGxl
dCdzIGFkZCBhbiBpb2N0bCBmb3IgdGhpcz8gSXQncyByZWFsbHkgYSBidWcgd2UgZG9uJ3QuLgoK
CkFzIGV4cGxhaW5lZCBpbiBwYXRjaCAxLiBRZW11IGRvZXNuJ3QgdXNlIFZIT1NUX1ZEUEFfR0VU
X1ZSSU5HX05VTSAKYWN0dWFsbHkuIEluc3RlYWQgaXQgY2hlY2tzIHRoZSByZXN1bHQgVkhPU1Rf
VkRQQV9TRVRfVlJJTkdfTlVNLgoKU28gSSBjaGFuZ2UgVkhPU1RfVkRQQV9HRVRfVlJJTkdfTlVN
IHRvIHJldHVybiB0aGUgbWluaW1hbCBzaXplIG9mIGFsbCAKdGhlIHZpcnRxdWV1ZXMuCgpJZiB5
b3Ugd2lzaCB3ZSBjYW4gYWRkIGEgVkhPU1RfVkRQQV9HRVRfVlJJTkdfTlVNMiwgYnV0IEknbSBu
b3Qgc3VyZSBpdCAKd2lsbCBoYXZlIGEgdXNlciBvciBub3QuCgpUaGFua3MKCgo+Cj4+IC0tLQo+
PiAgIGRyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyB8IDYgKysrKy0tCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92
aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+PiBpbmRleCAyOTI2NjQxZmI1ODYuLjE5OGY3MDc2ZTRkOSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+PiBAQCAtMTgsNyArMTgsNiBAQAo+
PiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3Zp
cnRpb19wY2lfbW9kZXJuLmg+Cj4+ICAgCj4+IC0jZGVmaW5lIFZQX1ZEUEFfUVVFVUVfTUFYIDI1
Ngo+PiAgICNkZWZpbmUgVlBfVkRQQV9EUklWRVJfTkFNRSAidnBfdmRwYSIKPj4gICAjZGVmaW5l
IFZQX1ZEUEFfTkFNRV9TSVpFIDI1Ngo+PiAgIAo+PiBAQCAtMTk3LDcgKzE5NiwxMCBAQCBzdGF0
aWMgdm9pZCB2cF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1OCBz
dGF0dXMpCj4+ICAgCj4+ICAgc3RhdGljIHUxNiB2cF92ZHBhX2dldF92cV9udW1fbWF4KHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSwgdTE2IHFpZCkKPj4gICB7Cj4+IC0JcmV0dXJuIFZQX1ZEUEFf
UVVFVUVfTUFYOwo+PiArCXN0cnVjdCB2cF92ZHBhICp2cF92ZHBhID0gdmRwYV90b192cCh2ZHBh
KTsKPj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX3ZkcGEt
Pm1kZXY7Cj4+ICsKPj4gKwlyZXR1cm4gdnBfbW9kZXJuX2dldF9xdWV1ZV9zaXplKG1kZXYsIHFp
ZCk7Cj4+ICAgfQo+PiAgIAo+PiAgIHN0YXRpYyBpbnQgdnBfdmRwYV9nZXRfdnFfc3RhdGUoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgcWlkLAo+PiAtLSAKPj4gMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
