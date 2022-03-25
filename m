Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092FEC433F5
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 03:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97A1761069;
	Fri, 25 Mar 2022 03:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zP9QVWkOr8No; Fri, 25 Mar 2022 03:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A5476106D;
	Fri, 25 Mar 2022 03:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8DDC0012;
	Fri, 25 Mar 2022 03:05:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16CC7C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09C3D61069
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rEoB3FAgOBPQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5523A6106D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648177530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1/M7/bmnByTWu65Mzim6SoRU2urxCvtovIoU38RgkU=;
 b=WpadKwdErklKri4AQp5ONhAUhJDJJYJC2GAVKhQLDgpa0K23NEeaKiXYVWwCcGdKqMCLuI
 u87Af/BEp7/SU4qfGhJKl9bhNuVHgozLd1L0DrTgHLNjP45azgbI51P/9Tb2hQ0ASw5dXt
 wcgxOAEx1ERl0iqU0pKBO8Nf+/BEvP8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-p2idXrB7NYKz_1gxBZ6hkw-1; Thu, 24 Mar 2022 23:05:28 -0400
X-MC-Unique: p2idXrB7NYKz_1gxBZ6hkw-1
Received: by mail-pj1-f69.google.com with SMTP id
 n17-20020a17090ac69100b001c77ebd900fso3807557pjt.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 20:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=W1/M7/bmnByTWu65Mzim6SoRU2urxCvtovIoU38RgkU=;
 b=L9eE61hOmmB3ltI7W3eg5XjPMjArCMlXCVcKaYPny9GsYHif4BMNgs4jA6XbCXXsyq
 Ns3vvF4LPkNJcUkpM+m8ASUATTStkQ6ux1E/1xO5zWye64g1e61WXPLuoTHYsgCtr3OX
 XrdSeOmRH9AMmchVFt4sOaH47nSMwdvuMkGT8s9wEsoovURueayiVopji7xFl2e9fMkc
 iVKi7f9XKxsppMBk0y0GN2E5HVJY/qEoqGs8i5u7NryvDiREPua5muswlmGMUAyxeGAJ
 59rncXBkWIxKgQNWxh0iFimD7xeqJ/8zWErFkS0JeF7yXi81A/8y+JWBPeKr2cSZGjox
 PxMQ==
X-Gm-Message-State: AOAM532282nLUyXwjGMlSeAMlpWgOIZcO0Liw5E2QfXGQx0+tKD4VUb1
 XklT9AnOSTsxwe2w3l3o1zWRy2RwNnRLjVOXxAeiwIWJExqijWAXLJNUX+Xh23gYjFKRwla5v/I
 msIaaGqb1DUJrYW0A+OfcUdOTfN/mqfbs/KkEIqbxpg==
X-Received: by 2002:a17:902:7797:b0:154:b6d:31f2 with SMTP id
 o23-20020a170902779700b001540b6d31f2mr9069827pll.39.1648177527694; 
 Thu, 24 Mar 2022 20:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymmceXQlKogsbDkqxGa/+jhIE+qWfz707Sj9yP9hpf7xzOj6GOmmceC8wpdI7WERDceL9xUQ==
X-Received: by 2002:a17:902:7797:b0:154:b6d:31f2 with SMTP id
 o23-20020a170902779700b001540b6d31f2mr9069804pll.39.1648177527397; 
 Thu, 24 Mar 2022 20:05:27 -0700 (PDT)
Received: from [10.72.13.249] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a056a0022ce00b004fabe9fac23sm5163104pfj.151.2022.03.24.20.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 20:05:26 -0700 (PDT)
Message-ID: <81381018-9dcd-3fba-becf-183435a5bf6b@redhat.com>
Date: Fri, 25 Mar 2022 11:05:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
 <20220324070612-mutt-send-email-mst@kernel.org>
 <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de
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

CuWcqCAyMDIyLzMvMjQg5LiL5Y2INzozMSwgU3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiBP
biBUaHUsIE1hciAyNCwgMjAyMiBhdCAwNzowNzowOUFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJr
aW4gd3JvdGU6Cj4+IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDEyOjAzOjA3UE0gKzAxMDAsIFN0
ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4+IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0IDA2OjQ4
OjA1QU0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+ID4gT24gVGh1LCBNYXIg
MjQsIDIwMjIgYXQgMDQ6NDA6MDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+ID4gPiBG
cm9tOiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+PiA+ID4KPj4+
ID4gPiBUaGlzIGF2b2lkcyBzZXR0aW5nIERSSVZFUl9PSyB0d2ljZSBmb3IgdGhvc2UgZHJpdmVy
cyB0aGF0IGNhbGwKPj4+ID4gPiB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkgaW4gdGhlIC5yZXN0b3Jl
Cj4+PiA+Cj4+PiA+IElzIHRoaXMgdHJ5aW5nIHRvIHNheSBpdCdzIGZhc3Rlcj8KPj4+Cj4+PiBO
b3BlLCBJIG1lYW4sIHdoZW4gSSB3cm90ZSB0aGUgb3JpZ2luYWwgdmVyc2lvbiwgSSBtZWFudCB0
byBkbyB0aGUgc2FtZQo+Pj4gdGhpbmdzIHRoYXQgd2UgZG8gaW4gdmlydGlvX2Rldl9wcm9iZSgp
IHdoZXJlIHdlIGNhbGxlZAo+Pj4gdmlydGlvX2RldmljZV9yZWFkeSgpIHdoaWNoIG5vdCBvbmx5
IHNldCB0aGUgc3RhdGUsIGJ1dCBhbHNvIGNhbGxlZAo+Pj4gLmVuYWJsZV9jYnMgY2FsbGJhY2su
Cj4+Pgo+Pj4gV2FzIHRoaXMgYSBzaWRlIGVmZmVjdCBhbmQgbWF5YmUgbW9yZSBjb21wbGlhbnQg
d2l0aCB0aGUgc3BlYz8KPj4KPj4KPj4gU29ycnkgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBxdWVz
dGlvbi4gaXQgc2F5cyAiYXZvaWRzIHNldHRpbmcgCj4+IERSSVZFUl9PSyB0d2ljZSIgLQo+PiB3
aHkgaXMgdGhhdCBhZHZhbnRhZ2VvdXMgYW5kIHdvcnRoIGNhbGxpbmcgb3V0IGluIHRoZSBjb21t
aXQgbG9nPwo+Cj4gSSBqdXN0IHdhbnRlZCB0byBzYXkgdGhhdCBpdCBzZWVtcyBzdHJhbmdlIHRv
IHNldCBEUklWRVJfT0sgdHdpY2UgaWYgCj4gd2UgcmVhZCB0aGUgc3BlYy4gSSBkb24ndCB0aGlu
ayBpdCdzIHdyb25nLCBidXQgd2VpcmQuCj4KPiBZZXMsIG1heWJlIHdlIHNob3VsZCByZXdyaXRl
IHRoZSBjb21taXQgbWVzc2FnZSBzYXlpbmcgdGhhdCB3ZSB3YW50IHRvIAo+IHVzZSB2aXJ0aW9f
ZGV2aWNlX3JlYWR5KCkgZXZlcnl3aGVyZSB0byBjb21wbGV0ZSB0aGUgc2V0dXAgYmVmb3JlIAo+
IHNldHRpbmcgRFJJVkVSX09LIHNvIHdlIGNhbiBkbyBhbGwgdGhlIG5lY2Vzc2FyeSBvcGVyYXRp
b25zIGluc2lkZSAKPiAobGlrZSBpbiBwYXRjaCAzIG9yIGNhbGwgZW5hYmxlX2NicykuCj4KPiBK
YXNvbiByZXdyb3RlIHRoZSBjb21taXQgbG9nLCBzbyBJIGRvbid0IGtub3cgaWYgaGUgYWdyZWVz
Lgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KCgpJIGFncmVlLCBJIHdpbGwgdHdlYWsgdGhlIGxvZyBp
biBWMi4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
