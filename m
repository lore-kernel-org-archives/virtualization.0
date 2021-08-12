Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D184C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 03:19:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E98A60EB5
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 03:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E98A60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B43AD40264;
	Thu, 12 Aug 2021 03:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NcN9JtkSbPH7; Thu, 12 Aug 2021 03:19:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5720540185;
	Thu, 12 Aug 2021 03:19:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38A3FC0010;
	Thu, 12 Aug 2021 03:19:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6629C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 921CC401B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lfBO-ACaIO9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:19:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61C7E400C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 03:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628738366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MIc6sPALXe+WUW9Q61hbNKyGH902cuAjmlt6gJhcAY=;
 b=UoYcJP2o8GeVf5U2Hl0jT/aHmF078pe7jtv0hxBRyM67tW1o7yDSCvKI77Fg/56TApTorp
 BMg6ssuG+fBhZ0CYQ4262EYLvgy+jS1MYe5kTqzofL+E5Lj8gcciEZCswNN5JL85HjjyMW
 efzohDGPX8sEpj9r9WllcLgcHOqXNTQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-d9Xsxu2wN1u8OwbGw3RFgQ-1; Wed, 11 Aug 2021 23:19:24 -0400
X-MC-Unique: d9Xsxu2wN1u8OwbGw3RFgQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 j6-20020a17090ac486b0290178ffdbd20dso3381326pjt.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2MIc6sPALXe+WUW9Q61hbNKyGH902cuAjmlt6gJhcAY=;
 b=uLwtY0ipwviS3j+HRHg37BGe1YUCOloLCsLgCmmzFhqCWTtBE8rp33R1YshUwtG3Sl
 y6hSxkZbGRu3vC+GEssUTAuCGzAsJUc2z8eMrmA0GAP28adM2+ZbU6Wm/ipcmW8VZRti
 pnVI3xWqecRuk3LeI6bO944XT6pyOTM3/EZxhKGT/PAKdzUir/ColGuB2j79w3E+fN/1
 eXKyKrkChWFAhbQdS0FEzay0NORsss/A5IiDcNuodGKeezQzNIkuRlajOsDW4fY5bvOC
 LjC/5Dt9GO5CeZEZvdTRN0OHiWYvqC3Fzr4dQnkrNMO6wyxX4W53Q1EUziQXsV7XhV6k
 Kt1Q==
X-Gm-Message-State: AOAM530zYk9B/r12a/zpcN6VLXaNJOD09xh3cGQ338MtWIXY7MzNqMMf
 DJ16ccQc8tgWo6jnvrLD/hHJ8xgCa2PlyE4JoiSeFdOO4ibuo+uoMwHDgFGghkc7Fdwmjtb0Q6p
 VMvwFMGoT2SN59lcNfKkEzwGlIFt71kqgAwgTw2IcRw==
X-Received: by 2002:a65:62d5:: with SMTP id m21mr1848682pgv.124.1628738363736; 
 Wed, 11 Aug 2021 20:19:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw8dTKvVctxqmxWvq0UZSp9ZQYWRXpsim94rqi7e+wmpbgaoLe0gkOGv41eTnYQ7u6T6S+og==
X-Received: by 2002:a65:62d5:: with SMTP id m21mr1848668pgv.124.1628738363545; 
 Wed, 11 Aug 2021 20:19:23 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c23sm1111974pfn.140.2021.08.11.20.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 20:19:23 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
References: <20210809140800.97835-1-elic@nvidia.com>
 <20210809140800.97835-4-elic@nvidia.com>
 <07002568-e792-aa35-ec42-5e0f12883a03@redhat.com>
 <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
 <fccc39c8-f9af-e489-8804-511cb07f1ed2@redhat.com>
 <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
Date: Thu, 12 Aug 2021 11:19:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzgvMTEg5LiL5Y2INzowNCwgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBXZWQsIEF1
ZyAxMSwgMjAyMSBhdCAwNDozNzo0NFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDlnKgg
MjAyMS84LzExIOS4i+WNiDM6NTMsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4gT25lIHRoaW5nIG5l
ZWQgdG8gc29sdmUgZm9yIG1xIGlzIHRoYXQgdGhlOgo+Pj4+Cj4+Pj4KPj4+Pj4gK3N0YXRpYyB1
MTYgY3RybF92cV9pZHgoc3RydWN0ICBtbHg1X3ZkcGFfZGV2ICptdmRldikKPj4+Pj4gK3sKPj4+
Pj4gK8KgIMKgIMKgcmV0dXJuIDIgKiAgbWx4NV92ZHBhX21heF9xcHMobXZkZXYtPm1heF92cXMp
Owo+Pj4+PiArfQo+Pj4+IFdlIHNob3VsZCBoYW5kbGUgdGhlIGNhc2Ugd2hlbiBNUSBpcyBzdXBw
b3J0ZWQgYnkgdGhlIGRldmljZSBidXQgbm90IHRoZQo+Pj4+IGRyaXZlci4KPj4+Pgo+Pj4+IEUu
ZyBpbiB0aGUgY2FzZSB3aGVuIHdlIGhhdmUgMiBxdWV1ZSBwYWlyczoKPj4+Pgo+Pj4+IFdoZW4g
TVEgaXMgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDQKPj4+Pgo+Pj4+IFdoZW4gTVEgaXMgbm90IGVu
YWJsZWQsIGN2cSBpcyBxdWV1ZSAyCj4+Pj4KPj4+IFRoZXJlJ3Mgc29tZSBpc3N1ZSB3aXRoIHRo
aXMuIEkgZ2V0IGNhbGxiYWNrcyB0YXJnZXRpbmcgc3BlY2lmaWMKPj4+IHZpcnRxdWV1ZXMgYmVm
b3JlIGZlYXR1cmVzIG5lZ290aWF0aW9uIGhhcyBiZWVuIGNvbXBsZXRlZC4KPj4+Cj4+PiBTcGVj
aWZpY2FsbHksIEkgZ2V0IHNldF92cV9jYigpIGNhbGxzLiBBdCB0aGlzIHBvaW50IEkgbXVzdCBr
bm93IHRoZQo+Pj4gY29udHJvbCB2cSBpbmRleC4KPj4KPj4gU28gSSB0aGluayB3ZSBuZWVkIGRv
IGJvdGg6Cj4+Cj4+IDEpIEF0IG9uZSBoYW5kLCBpdCdzIGEgYnVnIGZvciB0aGUgdXNlcnNwYWNl
IHRvIHVzZSB2cV9pbmRleCBiZWZvcmUgZmVhdHVyZQo+PiBpcyBuZWdvdGlhdGVkCj4+Cj4+IChs
b29rcyBsaWtlIGEgYnVnIGluIG15IGN2cSBzZXJpZXMgdGhhdCB3aWxsIGNhbGwgU0VUX1ZSSU5H
X0NBTEwgYmVmb3JlCj4+IGZlYXR1cmUgaXMgbmVnb3RpYXRlLCB3aGljaCBJIHdpbGwgbG9vayku
Cj4+Cj4+IDIpIEF0IHRoZSBvdGhlciBoYW5kLCB0aGUgZHJpdmVyIHNob3VsZCBiZSBhYmxlIHRv
IGRlYWwgd2l0aCB0aGF0Cj4+Cj4gQWxsIEkgY2FuIGRvIGlzIGRyb3AgY2FsbGJhY2tzIGZvciBW
UXMgYmVmb3JlIGZlYXR1cmVzIG5lZ290YXRpb24gaGFzCj4gYmVlbiBjb21wbGV0ZWQuCgoKT3Ig
anVzdCBsZWF2ZSBxdWV1ZSBpbmRleCAwLCAxIHdvcmsuCgpTaW5jZSBpdCBpcyBub3QgZXhwZWN0
ZWQgdG8gYmUgY2hhbmdlZC4KCgo+Cj4+PiBJIHRoaW5rIHRoZSBDVlEgaW5kZXggbXVzdCBub3Qg
ZGVwZW5kIG9uIHRoZSBuZWdvdGlhdGVkIGZlYXR1cmVzIGJ1dAo+Pj4gcmF0aGVyIGRlcGVuZCBv
ZiB0aGUgdmFsdWUgdGhlIGRldmljZSBkcml2ZXIgcHJvdmlkZXMgaW4gdGhlIGNhbGwgdG8KPj4+
IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpLgo+Pgo+PiBBdCB0aGUgdmlydGlvIGxldmVsLCBpdCdz
IHRvbyBsYXRlIHRvIGNoYW5nZSB0aGF0IGFuZCBpdCBicmVha3MgdGhlIGJhY2t3YXJkCj4+IGNv
bXBhdGliaWxpdHkuCj4+Cj4+IEJ1dCBhdCB0aGUgdkRQQSBsZXZlbCwgdGhlIHVuZGVyIGxheWVy
IGRldmljZSBjYW4gbWFwIHZpcnRpbyBjdnEgdG8gYW55IG9mCj4+IGl0J3MgdmlydHF1ZXVlLgo+
Pgo+PiBFLmcgbWFwIGN2cSAoaW5kZXggMikgdG8gbWx4NSBjdnEgKHRoZSBsYXN0KS4KPj4KPiBJ
IGFtIG5vdCBmb2xsb3dpbmcgeW91IGhlcmUuIEkgc3RpbGwgZG9uJ3Qga25vdyB3aGF0IGluZGV4
IGlzIGN2cS4KCgpSaWdodCwgd2Ugc3RpbGwgbmVlZCB0byB3YWl0IGZvciB0aGUgZmVhdHVyZSBi
ZWluZyBuZWdvdGlhdGVkIGluIG9yZGVyIAp0byBwcm9jZWVkLgoKVGhhbmtzCgoKPgo+PiBUaGFu
a3MKPj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
