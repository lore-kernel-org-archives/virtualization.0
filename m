Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A00C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4C9E812F9;
	Tue, 22 Feb 2022 07:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EyJLRiJ2rs02; Tue, 22 Feb 2022 07:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EC2181317;
	Tue, 22 Feb 2022 07:18:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D88AAC001A;
	Tue, 22 Feb 2022 07:18:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E775C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECF2A60A84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8epWs0wTr_D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:18:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1411F608D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645514302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N605itsJ1wT+s8NNBskCBTCGqv0vzaQjw0MTSTM68tQ=;
 b=bSwv0ifTIIi8HiX+HI96kMKBrSGK29lScpyiSJoow/qkXBKzzjejYvnOILUMab95ovk92y
 s6GPT7wdgh5CiaO6HnC3nE16Anhj+GGIvZ8qkTAA/ucB+TTZc09qw3DBf9EhdBA8Ilg5iG
 GkC14MttoRzcLGSaK6bCeZGORN4Bx/E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-kM-5jz3bPySwHM2HHnP6OA-1; Tue, 22 Feb 2022 02:18:18 -0500
X-MC-Unique: kM-5jz3bPySwHM2HHnP6OA-1
Received: by mail-pl1-f200.google.com with SMTP id
 y3-20020a1709029b8300b0014c8bcb70a1so4893854plp.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=N605itsJ1wT+s8NNBskCBTCGqv0vzaQjw0MTSTM68tQ=;
 b=xndpZ5L8O7rRhAzsFQ2S5ts3VFnMZUDI1OqUnRWfA/g0MXJavIBwgd05lgsBGp6hS5
 MsxDZ90Rk6uqFS/P6wBJKPNfVUDZ7E8PXGDrInToQEJH0onco8TqvlvRWmYTsWeLR7/y
 BHXQI3nbl+h1dQbLLh8Wb3HEB/dmQ3OqoB+wM0/rhrhBde/sXZxVKKPNTUeAcqcGfCJq
 qkPC+3T2qNeHn2kNqUkWfZ+atKuPNGZOX+bUqwzAvxCmX4RluW7MnGKUXQDNTAE431em
 OylFF4csbc/kIHQcXRCMZvIIQOldsC6Ri76CNnIH51FIGqhCLGghjplMqDb5gkk6ZWLu
 lu1A==
X-Gm-Message-State: AOAM532d9Gq2dd2RqvNEXLBtygljXkhzMgQUOf+hqF0wJ2sUYA1Fkt7z
 Ymyz2Io2HCO6gxcqLt9wUdVuOtoh/35VmGU4gJw0/wO80mTw5icQom8Y3tdVjP0IBifdUcFr2iw
 H9f40Gt4T4mhjrW9n8SLwQvuMcYx/cjg/orWLTKdAgA==
X-Received: by 2002:a17:90a:8689:b0:1b9:b23f:6c29 with SMTP id
 p9-20020a17090a868900b001b9b23f6c29mr2778130pjn.25.1645514297493; 
 Mon, 21 Feb 2022 23:18:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNWgMpGPWjCBoe++gVxooM30AEYuxsjbuPzJTeJ0uGVBhMK2g5R2yLPpYDB4Ah149taC6srQ==
X-Received: by 2002:a17:90a:8689:b0:1b9:b23f:6c29 with SMTP id
 p9-20020a17090a868900b001b9b23f6c29mr2778082pjn.25.1645514297129; 
 Mon, 21 Feb 2022 23:18:17 -0800 (PST)
Received: from [10.72.13.199] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t137sm1186076pgc.49.2022.02.21.23.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 23:18:16 -0800 (PST)
Message-ID: <ca9fdd45-4650-883a-707b-0c96818ad8d1@redhat.com>
Date: Tue, 22 Feb 2022 15:18:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 09/31] vhost-vdpa: Take into account SVQ in
 vhost_vdpa_set_vring_call
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-10-eperezma@redhat.com>
 <cbfbd909-4ee8-8ad2-effd-4b9f60270581@redhat.com>
 <CAJaqyWda5sBw9VGBrz8g60OJ07Eeq45RRYu9vwgOPZFwten9rw@mail.gmail.com>
 <cbdf79c3-48ed-bac2-a9cc-e5c29729e4af@redhat.com>
 <CAJaqyWeisXmZ9+xw2Rj50K7aKx4khNZZjLZEz4MY97B9pQQm3w@mail.gmail.com>
 <bccdecdd-fa2d-48c0-43b8-7afe7b230b7b@redhat.com>
 <CAJaqyWc5uR70a=hTpVpomuahF9iZouLmRpXPnWidga5CFxJOpA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWc5uR70a=hTpVpomuahF9iZouLmRpXPnWidga5CFxJOpA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzIvMjEg5LiL5Y2INDowMSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIE1vbiwgRmViIDIxLCAyMDIyIGF0IDg6MzkgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IOWcqCAyMDIyLzIvMTgg5LiL5Y2IODozNSwgRXVnZW5pbyBQ
ZXJleiBNYXJ0aW4g5YaZ6YGTOgo+Pj4gT24gVHVlLCBGZWIgOCwgMjAyMiBhdCA0OjIzIEFNIEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIyLzEvMzEg
5LiL5Y2IMTE6MzQsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPj4+Pj4gT24gU2F0LCBK
YW4gMjksIDIwMjIgYXQgOTowNiBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4+Pj4+IOWcqCAyMDIyLzEvMjIg5LiK5Y2INDoyNywgRXVnZW5pbyBQw6lyZXog5YaZ
6YGTOgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRo
YXQuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+ICAgICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyB8
IDIwICsrKysrKysrKysrKysrKysrKy0tCj4+Pj4+Pj4gICAgICAxIGZpbGUgY2hhbmdlZCwgMTgg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQg
YS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4+Pj4+
IGluZGV4IDE4ZGUxNGYwZmIuLjAyOWY5OGZlZWUgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvaHcvdmly
dGlvL3Zob3N0LXZkcGEuYwo+Pj4+Pj4+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+
Pj4+PiBAQCAtNjg3LDEzICs2ODcsMjkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmlu
Z19raWNrKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+Pj4+PiAgICAgICAgICB9Cj4+Pj4+Pj4g
ICAgICB9Cj4+Pj4+Pj4KPj4+Pj4+PiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19j
YWxsKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUpCj4+Pj4+Pj4g
K3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwoc3RydWN0IHZob3N0X2Rl
diAqZGV2LAo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB2aG9zdF92cmluZ19maWxlICpmaWxlKQo+Pj4+Pj4+ICAgICAgewo+Pj4+Pj4+ICAg
ICAgICAgIHRyYWNlX3Zob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwoZGV2LCBmaWxlLT5pbmRleCwg
ZmlsZS0+ZmQpOwo+Pj4+Pj4+ICAgICAgICAgIHJldHVybiB2aG9zdF92ZHBhX2NhbGwoZGV2LCBW
SE9TVF9TRVRfVlJJTkdfQ0FMTCwgZmlsZSk7Cj4+Pj4+Pj4gICAgICB9Cj4+Pj4+Pj4KPj4+Pj4+
PiArc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsKHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwKPj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aG9zdF92cmluZ19maWxlICpmaWxlKQo+Pj4+Pj4+ICt7Cj4+Pj4+Pj4gKyAgICBzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiA9IGRldi0+b3BhcXVlOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgIGlmICh2
LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPj4+Pj4+PiArICAgICAgICBpbnQgdmRwYV9pZHggPSB2
aG9zdF92ZHBhX2dldF92cV9pbmRleChkZXYsIGZpbGUtPmluZGV4KTsKPj4+Pj4+PiArICAgICAg
ICBWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxID0gZ19wdHJfYXJyYXlfaW5kZXgodi0+c2hhZG93
X3ZxcywgdmRwYV9pZHgpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgICAgICB2aG9zdF9zdnFfc2V0
X2d1ZXN0X2NhbGxfbm90aWZpZXIoc3ZxLCBmaWxlLT5mZCk7Cj4+Pj4+PiBUd28gcXVlc3Rpb25z
IGhlcmUgKGhhZCBzaW1pbGFyIHF1ZXN0aW9ucyBmb3IgdnJpbmcga2ljayk6Cj4+Pj4+Pgo+Pj4+
Pj4gMSkgQW55IHJlYXNvbiB0aGF0IHdlIHNldHVwIHRoZSBldmVudGZkIGZvciB2aG9zdC12ZHBh
IGluCj4+Pj4+PiB2aG9zdF92ZHBhX3N2cV9zZXR1cCgpIG5vdCBoZXJlPwo+Pj4+Pj4KPj4+Pj4g
SSdtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4uCj4+Pj4+Cj4+Pj4+IFRoZSBndWVzdC0+U1ZRIGNh
bGwgYW5kIGtpY2sgZmRzIGFyZSBzZXQgaGVyZSBhbmQgYXQKPj4+Pj4gdmhvc3RfdmRwYV9zZXRf
dnJpbmdfa2ljay4gVGhlIGV2ZW50IG5vdGlmaWVyIGhhbmRsZXIgb2YgdGhlIGd1ZXN0IC0+Cj4+
Pj4+IFNWUSBraWNrX2ZkIGlzIHNldCBhdCB2aG9zdF92ZHBhX3NldF92cmluZ19raWNrIC8KPj4+
Pj4gdmhvc3Rfc3ZxX3NldF9zdnFfa2lja19mZC4gVGhlIGd1ZXN0IC0+IFNWUSBjYWxsIGZkIGhh
cyBubyBldmVudAo+Pj4+PiBub3RpZmllciBoYW5kbGVyIHNpbmNlIHdlIGRvbid0IHBvbGwgaXQu
Cj4+Pj4+Cj4+Pj4+IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgY29ubmVjdGlvbiBTVlEgPC0+IGRl
dmljZSB1c2VzIHRoZSBzYW1lIGZkcwo+Pj4+PiBmcm9tIHRoZSBiZWdpbm5pbmcgdG8gdGhlIGVu
ZCwgYW5kIHRoZXkgd2lsbCBub3QgY2hhbmdlIHdpdGgsIGZvcgo+Pj4+PiBleGFtcGxlLCBjYWxs
IGZkIG1hc2tpbmcuIFRoYXQncyB3aHkgaXQncyBzZXR1cCBmcm9tCj4+Pj4+IHZob3N0X3ZkcGFf
c3ZxX3NldHVwLiBEZWxheWluZyB0byB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsIHdvdWxkIG1h
a2UKPj4+Pj4gdXMgYWRkIHdheSBtb3JlIGxvZ2ljIHRoZXJlLgo+Pj4+IE1vcmUgbG9naWMgaW4g
Z2VuZXJhbCBzaGFkb3cgdnEgY29kZSBidXQgbGVzcyBjb2RlcyBmb3Igdmhvc3QtdmRwYQo+Pj4+
IHNwZWNpZmljIGNvZGUgSSB0aGluay4KPj4+Pgo+Pj4+IEUuZyBmb3Igd2UgY2FuIG1vdmUgdGhl
IGtpY2sgc2V0IGxvZ2ljIGZyb20gdmhvc3RfdmRwYV9zdnFfc2V0X2ZkcygpIHRvCj4+Pj4gaGVy
ZS4KPj4+Pgo+Pj4gQnV0IHRoZXkgYXJlIGRpZmZlcmVudCBmZHMuIHZob3N0X3ZkcGFfc3ZxX3Nl
dF9mZHMgc2V0cyB0aGUKPj4+IFNWUTwtPmRldmljZS4gVGhpcyBmdW5jdGlvbiBzZXRzIHRoZSBT
VlEtPmd1ZXN0IGNhbGwgZmlsZSBkZXNjcmlwdG9yLgo+Pj4KPj4+IFRvIG1vdmUgdGhlIGxvZ2lj
IG9mIHZob3N0X3ZkcGFfc3ZxX3NldF9mZHMgaGVyZSB3b3VsZCBpbXBseSBlaXRoZXI6Cj4+PiBh
KSBMb2dpYyB0byBrbm93IGlmIHdlIGFyZSByZWNlaXZpbmcgdGhlIGZpcnN0IGNhbGwgZmQgb3Ig
bm90Lgo+Pgo+PiBBbnkgcmVhc29uIGZvciB0aGlzPyBJIGd1ZXNzIHlvdSBtZWFudCBtdWx0aXF1
ZXVlLiBJZiB5ZXMsIGl0IHNob3VsZCBub3QKPj4gYmUgbXVjaCBkaWZmZXJlbmNlIHNpbmNlIHdl
IGhhdmUgaWR4IGFzIHRoZSBwYXJhbWV0ZXIuCj4+Cj4gV2l0aCAiZmlyc3QgY2FsbCBmZCIgSSBt
ZWFudCAiZmlyc3QgdGltZSB3ZSByZWNlaXZlIHRoZSBjYWxsIGZkIiwgc28KPiB3ZSBvbmx5IHNl
dCB0aGVtIG9uY2UuCj4KPiBJIHRoaW5rIHRoaXMgaXMgZ29pbmcgdG8gYmUgZWFzaWVyIGlmIEkg
cHJlcGFyZSBhIHBhdGNoIGRvaW5nIHlvdXIgd2F5Cj4gYW5kIHdlIGNvbW1lbnQgb24gaXQuCgoK
VGhhdCB3b3VsZCBiZSBoZWxwZnVsIGJ1dCBpZiB0aGVyZSdzIG5vIGlzc3VlIHdpdGggY3VycmVu
dCBjb2RlIChzZWUgCmJlbG93KSwgd2UgY2FuIGxlYXZlIGl0IGFzIGlzIGFuZCBkbyBvcHRpbWl6
YXRpb24gb24gdG9wLgoKCj4KPj4+ICAgIFRoYXQKPj4+IGNvZGUgaXMgbm90IGluIHRoZSBzZXJp
ZXMgYXQgdGhlIG1vbWVudCwgYmVjYXVzZSBzZXR0aW5nIGF0Cj4+PiB2aG9zdF92ZHBhX2Rldl9z
dGFydCB0ZWxscyB0aGUgZGlmZmVyZW5jZSBmb3IgZnJlZS4gSXMganVzdCBhZGRpbmcKPj4+IGNv
ZGUsIG5vdCBtb3ZpbmcuCj4+PiBiKSBMb2dpYyB0byBzZXQgYWdhaW4gKnRoZSBzYW1lKiBmaWxl
IGRlc2NyaXB0b3IgdG8gZGV2aWNlLCB3aXRoIGxvZ2ljCj4+PiB0byB0ZWxsIGlmIHdlIGhhdmUg
bWlzc2VkIGNhbGxzLiBUaGF0IGxvZ2ljIGlzIG5vdCBpbXBsZW1lbnRlZCBmb3IKPj4+IGRldmlj
ZS0+U1ZRIGNhbGwgZmlsZSBkZXNjcmlwdG9yLCBiZWNhdXNlIHdlIGFyZSBhc3N1bWluZyBpdCBu
ZXZlcgo+Pj4gY2hhbmdlcyBmcm9tIHZob3N0X3ZkcGFfc3ZxX3NldF9mZHMuIFNvIHRoaXMgaXMg
YWdhaW4gYWRkaW5nIGNvZGUuCj4+Pgo+Pj4gQXQgdGhpcyBtb21lbnQsIHdlIGhhdmU6Cj4+PiB2
aG9zdF92ZHBhX3N2cV9zZXRfZmRzOgo+Pj4gICAgIHNldCBTVlE8LT5kZXZpY2UgZmRzCj4+Pgo+
Pj4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfY2FsbDoKPj4+ICAgICBzZXQgZ3Vlc3Q8LVNWUSBjYWxs
Cj4+Pgo+Pj4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfa2ljazoKPj4+ICAgICBzZXQgZ3Vlc3QtPlNW
USBraWNrLgo+Pj4KPj4+IElmIEkgdW5kZXJzdG9vZCBjb3JyZWN0bHksIHRoZSBhbHRlcm5hdGl2
ZSB3b3VsZCBiZSBzb21ldGhpbmcgbGlrZToKPj4+IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGw6
Cj4+PiAgICAgc2V0IGd1ZXN0PC1TVlEgY2FsbAo+Pj4gICAgIGlmKCF2cS0+Y2FsbF9zZXQpIHsK
Pj4+ICAgICAgIC0gc2V0IFNWUTwtZGV2aWNlIGNhbGwuCj4+PiAgICAgICAtIHZxLT5jYWxsX3Nl
dCA9IHRydWUKPj4+ICAgICB9Cj4+Pgo+Pj4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfa2ljazoKPj4+
ICAgICBzZXQgZ3Vlc3Q8LVNWUSBjYWxsCj4+PiAgICAgaWYoIXZxLT5kZXZfa2lja19zZXQpIHsK
Pj4+ICAgICAgIC0gc2V0IGd1ZXN0LT5kZXZpY2Uga2ljay4KPj4+ICAgICAgIC0gdnEtPmRldl9r
aWNrX3NldCA9IHRydWUKPj4+ICAgICB9Cj4+Pgo+Pj4gZGV2X3Jlc2V0IC8gZGV2X3N0b3A6Cj4+
PiBmb3IgdnEgaW4gdnFzOgo+Pj4gICAgIHZxLT5kZXZfa2lja19zZXQgPSB2cS0+ZGV2X2NhbGxf
c2V0ID0gZmFsc2UKPj4+IC4uLgo+Pj4KPj4+IE9yIGhhdmUgSSBtaXN1bmRlcnN0b29kIHNvbWV0
aGluZz8KPj4KPj4gSSB3b25kZXIgd2hhdCBoYXBwZW5zIGlmIE1TSS1YIGlzIG1hc2tpbmcgaW4g
Z3Vlc3QuIFNvIGlmIEkgdW5kZXJzdGFuZAo+PiBjb3JyZWN0bHksIHdlIGRvbid0IGRpc2FibGUg
dGhlIGV2ZW50ZmQgZnJvbSBkZXZpY2U/IElmIHllcywgdGhpcyBzZWVtcwo+PiBzdWJvcHRpbmFs
Lgo+Pgo+IFdlIGNhbm5vdCBkaXNhYmxlIHRoZSBkZXZpY2UncyBjYWxsIGZkIHVubGVzcyBTVlEg
YWN0aXZlbHkgcG9sbCBpdC4gQXMKPiBJIHNlZSBpdCwgaWYgdGhlIGd1ZXN0IG1hc2tzIHRoZSBj
YWxsIGZkLCBpdCBjb3VsZCBiZSBiZWNhdXNlOgo+IGEpIGl0IGRvZXNuJ3Qgd2FudCB0byByZWNl
aXZlIG1vcmUgY2FsbHMgYmVjYXVzZSBpcyBwcm9jZXNzaW5nIGJ1ZmZlcnMKPiBiKSBJcyBnb2lu
ZyB0byBidXJuIGEgY3B1IHRvIHBvbGwgaXQuCj4KPiBUaGUgbWFza2luZyBvbmx5IGFmZmVjdHMg
U1ZRLT5ndWVzdCBjYWxsLiBJZiB3ZSBhbHNvIG1hc2sgZGV2aWNlLT5TVlEsCj4gd2UncmUgYWRk
aW5nIGxhdGVuY3kgaW4gdGhlIGNhc2UgYSksIGFuZCB3ZSdyZSBlZmZlY3RpdmVseSBkaXNhYmxp
bmcKPiBmb3J3YXJkaW5nIGluIGNhc2UgYikuCgoKUmlnaHQsIHNvIHdlIG5lZWQgbGVhdmUgYSBj
b21tZW50IHRvIGV4cGxhaW4gdGhpcywgdGhlbiBJJ20gdG90YWxseSBmaW5lIAp3aXRoIHRoaXMg
YXBwcm9hY2guCgoKPgo+IEl0IG9ubHkgd29ya3MgaWYgZ3Vlc3QgaXMgZWZmZWN0aXZlbHkgbm90
IGludGVyZXN0ZWQgaW4gY2FsbHMgYmVjYXVzZQo+IGlzIG5vdCBnb2luZyB0byByZXRpcmUgdXNl
ZCBidWZmZXJzLCBidXQgaW4gdGhhdCBjYXNlIGl0IGRvZXNuJ3QgaHVydAo+IHRvIHNpbXBseSBt
YWludGFpbiB0aGUgZGV2aWNlLT5jYWxsIGZkLCB0aGUgZXZlbnRmZHMgYXJlIGdvaW5nIHRvIGJl
Cj4gc2lsZW50IGFueXdheS4KPgo+IFRoYW5rcyEKCgpZZXMuCgpUaGFua3MKCgo+Cj4+IFRoYW5r
cwo+Pgo+Pgo+Pj4gVGhhbmtzIQo+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+PiAyKSBU
aGUgY2FsbCBjb3VsZCBiZSBkaXNhYmxlZCBieSB1c2luZyAtMSBhcyB0aGUgZmQsIEkgZG9uJ3Qg
c2VlIGFueQo+Pj4+Pj4gY29kZSB0byBkZWFsIHdpdGggdGhhdC4KPj4+Pj4+Cj4+Pj4+IFJpZ2h0
LCBJIGRpZG4ndCB0YWtlIHRoYXQgaW50byBhY2NvdW50LiB2aG9zdC1rZXJuZWwgdGFrZXMgYWxz
byAtMSBhcwo+Pj4+PiBraWNrX2ZkIHRvIHVuYmluZCwgc28gU1ZRIGNhbiBiZSByZXdvcmtlZCB0
byB0YWtlIHRoYXQgaW50byBhY2NvdW50Cj4+Pj4+IGZvciBzdXJlLgo+Pj4+Pgo+Pj4+PiBUaGFu
a3MhCj4+Pj4+Cj4+Pj4+PiBUaGFua3MKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+ICsgICAgICAgIHJl
dHVybiAwOwo+Pj4+Pj4+ICsgICAgfSBlbHNlIHsKPj4+Pj4+PiArICAgICAgICByZXR1cm4gdmhv
c3RfdmRwYV9zZXRfdnJpbmdfZGV2X2NhbGwoZGV2LCBmaWxlKTsKPj4+Pj4+PiArICAgIH0KPj4+
Pj4+PiArfQo+Pj4+Pj4+ICsKPj4+Pj4+PiAgICAgIC8qKgo+Pj4+Pj4+ICAgICAgICogU2V0IHNo
YWRvdyB2aXJ0cXVldWUgZGVzY3JpcHRvcnMgdG8gdGhlIGRldmljZQo+Pj4+Pj4+ICAgICAgICoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
