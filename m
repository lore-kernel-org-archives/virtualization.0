Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D8DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0252D8145B;
	Tue, 22 Feb 2022 07:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LV-_LxkRzumm; Tue, 22 Feb 2022 07:26:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 726468146A;
	Tue, 22 Feb 2022 07:26:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A5F4C001A;
	Tue, 22 Feb 2022 07:26:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 365ACC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D1E040140
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YdfXxD41JFRz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE22140145
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645514805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSgLTHt2PShYy/c40Sx83Rs/A6YQkQ1rRo49MyA5y1c=;
 b=Jj0UkdBr4Jz1IkpvNHym2Hi9Nbh9dajNy86ckPgt+/1Y7P3p8msfTBH08FMcWA8UqLM42r
 y/L33PBdb1jLWjPbtA/tL3Stz9UxaD370uAbWb2C3nSEYe86yhCFuL+mf0OmIAeLo4wKKw
 d+FXMA6yHozegHTILaNKl2kXVQ++A28=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-kUro2c-oMKG_u3P3BaYa4A-1; Tue, 22 Feb 2022 02:26:44 -0500
X-MC-Unique: kUro2c-oMKG_u3P3BaYa4A-1
Received: by mail-pl1-f200.google.com with SMTP id
 v14-20020a170902e8ce00b0014b48e8e498so4896229plg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lSgLTHt2PShYy/c40Sx83Rs/A6YQkQ1rRo49MyA5y1c=;
 b=BO+gP64P6bhZMtYnB6EgT2OJvOQ+vrfeA88OIVf42FfBDHd0HmNARB/t42NoMuNDWj
 Im7h7NyYOdqyUMruOmfZ1n0hRv2eAbUtPhQl1rJWPHLYwALr+0khf8izEltgm0QklJgr
 B+edh7HF+DLL++tcyDNPlpVKVtxdtqJvZDNlOxtzPhWrDdP9CcYtvukk7Wy+w/uwWqsI
 EOcijibw1sO/mhJmMB8WLyJCPRqrykJLCesk9ocXvm0P52+kVKBtYAqpo+h1Z4Gf9m7u
 pq3gTDlirDpUv9LW5dXUeKqnRJ5fNE1FcXxK+psSJXbECAQbJ/15ZCydKSUuBAJ19nUs
 JuCQ==
X-Gm-Message-State: AOAM532Mbbd3jlPwnCIUuFVgrxFynJ0/PBgfxqPggzh2rV8m4BnoYwG+
 VzSWk5ikTTuqcL1D1pxBjw+tJ1RyOvBtq3IJbCid3hOePm9dfJa88oZh+LYC7+wvgoz2VNc+j7v
 eSSnWn0JLoslEXWQN/O8w1qXiTFzpcsFSbG/tiY8rtw==
X-Received: by 2002:a17:903:31cd:b0:14d:bb40:2a17 with SMTP id
 v13-20020a17090331cd00b0014dbb402a17mr21733816ple.1.1645514803389; 
 Mon, 21 Feb 2022 23:26:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvVYyyfok9o/m2xgJK+AvfLAkwo4kCJOT5iqgb7ZlXLCMRgUCTTprxVoojziuhwzxQBNlr3A==
X-Received: by 2002:a17:903:31cd:b0:14d:bb40:2a17 with SMTP id
 v13-20020a17090331cd00b0014dbb402a17mr21733784ple.1.1645514803117; 
 Mon, 21 Feb 2022 23:26:43 -0800 (PST)
Received: from [10.72.13.199] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b21sm1554336pji.22.2022.02.21.23.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 23:26:42 -0800 (PST)
Message-ID: <24717b73-7aca-dd75-22d4-2b8d9e6bd737@redhat.com>
Date: Tue, 22 Feb 2022 15:26:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 18/31] vhost: Shadow virtqueue buffers forwarding
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-19-eperezma@redhat.com>
 <62e877ca-51d7-da85-13c9-d469a85f33c9@redhat.com>
 <CAJaqyWfF01k3LntM7RLEmFcej=EY2d4+2MARKXPptQ2J7VnB9A@mail.gmail.com>
 <7c52e50a-4c8e-7865-1c3d-8b156986c13a@redhat.com>
 <CAJaqyWedqtzRW=ur7upchneSc-oOkvkr3FUph_BfphV3zTmnkw@mail.gmail.com>
 <7e72def5-a1e9-ad92-2c83-fda72ffd7b60@redhat.com>
 <CAJaqyWcHhMpjJ4kde1ejV5c_vP7_8PvfXpi5u9rdWuaORFt_zg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWcHhMpjJ4kde1ejV5c_vP7_8PvfXpi5u9rdWuaORFt_zg@mail.gmail.com>
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

CuWcqCAyMDIyLzIvMjEg5LiL5Y2INDoxNSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIE1vbiwgRmViIDIxLCAyMDIyIGF0IDg6NDQgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IOWcqCAyMDIyLzIvMTcg5LiL5Y2IODo0OCwgRXVnZW5pbyBQ
ZXJleiBNYXJ0aW4g5YaZ6YGTOgo+Pj4gT24gVHVlLCBGZWIgOCwgMjAyMiBhdCA5OjE2IEFNIEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIyLzIvMSDk
uIvljYg3OjI1LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4+Pj4+IE9uIFN1biwgSmFu
IDMwLCAyMDIyIGF0IDc6NDcgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Pj4+PiDlnKggMjAyMi8xLzIyIOS4iuWNiDQ6MjcsIEV1Z2VuaW8gUMOpcmV6IOWGmemB
kzoKPj4+Pj4+PiBAQCAtMjcyLDYgKzU5MCwyOCBAQCB2b2lkIHZob3N0X3N2cV9zZXRfc3ZxX2tp
Y2tfZmQoVmhvc3RTaGFkb3dWaXJ0cXVldWUgKnN2cSwgaW50IHN2cV9raWNrX2ZkKQo+Pj4+Pj4+
ICAgICAgdm9pZCB2aG9zdF9zdnFfc3RvcChWaG9zdFNoYWRvd1ZpcnRxdWV1ZSAqc3ZxKQo+Pj4+
Pj4+ICAgICAgewo+Pj4+Pj4+ICAgICAgICAgIGV2ZW50X25vdGlmaWVyX3NldF9oYW5kbGVyKCZz
dnEtPnN2cV9raWNrLCBOVUxMKTsKPj4+Pj4+PiArICAgIGdfYXV0b2ZyZWUgVmlydFF1ZXVlRWxl
bWVudCAqbmV4dF9hdmFpbF9lbGVtID0gTlVMTDsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICBpZiAo
IXN2cS0+dnEpIHsKPj4+Pj4+PiArICAgICAgICByZXR1cm47Cj4+Pj4+Pj4gKyAgICB9Cj4+Pj4+
Pj4gKwo+Pj4+Pj4+ICsgICAgLyogU2VuZCBhbGwgcGVuZGluZyB1c2VkIGRlc2NyaXB0b3JzIHRv
IGd1ZXN0ICovCj4+Pj4+Pj4gKyAgICB2aG9zdF9zdnFfZmx1c2goc3ZxLCBmYWxzZSk7Cj4+Pj4+
PiBEbyB3ZSBuZWVkIHRvIHdhaXQgZm9yIGFsbCB0aGUgcGVuZGluZyBkZXNjcmlwdG9ycyB0byBi
ZSBjb21wbGV0ZWQgaGVyZT8KPj4+Pj4+Cj4+Pj4+IE5vLCB0aGlzIGZ1bmN0aW9uIGRvZXMgbm90
IHdhaXQsIGl0IG9ubHkgY29tcGxldGVzIHRoZSBmb3J3YXJkaW5nIG9mCj4+Pj4+IHRoZSAqdXNl
ZCogZGVzY3JpcHRvcnMuCj4+Pj4+Cj4+Pj4+IFRoZSBiZXN0IGV4YW1wbGUgaXMgdGhlIG5ldCBy
eCBxdWV1ZSBpbiBteSBvcGluaW9uLiBUaGlzIGNhbGwgd2lsbAo+Pj4+PiBjaGVjayBTVlEncyB2
cmluZyB1c2VkX2lkeCBhbmQgd2lsbCBmb3J3YXJkIHRoZSBsYXN0IHVzZWQgZGVzY3JpcHRvcnMK
Pj4+Pj4gaWYgYW55LCBidXQgYWxsIGF2YWlsYWJsZSBkZXNjcmlwdG9ycyB3aWxsIHJlbWFpbiBh
cyBhdmFpbGFibGUgZm9yCj4+Pj4+IHFlbXUncyBWUSBjb2RlLgo+Pj4+Pgo+Pj4+PiBUbyBza2lw
IGl0IHdvdWxkIG1pc3MgdGhvc2UgbGFzdCByeCBkZXNjcmlwdG9ycyBpbiBtaWdyYXRpb24uCj4+
Pj4+Cj4+Pj4+IFRoYW5rcyEKPj4+PiBTbyBpdCdzIHByb2JhYmx5IHRvIG5vdCB0aGUgYmVzdCBw
bGFjZSB0byBhc2suIEl0J3MgbW9yZSBhYm91dCB0aGUKPj4+PiBpbmZsaWdodCBkZXNjcmlwdG9y
cyBzbyBpdCBzaG91bGQgYmUgVFggaW5zdGVhZCBvZiBSWC4KPj4+Pgo+Pj4+IEkgY2FuIGltYWdp
bmUgdGhlIG1pZ3JhdGlvbiBsYXN0IHBoYXNlLCB3ZSBzaG91bGQgc3RvcCB0aGUgdmhvc3QtdkRQ
QQo+Pj4+IGJlZm9yZSBjYWxsaW5nIHZob3N0X3N2cV9zdG9wKCkuIFRoZW4gd2Ugc2hvdWxkIGJl
IGZpbmUgcmVnYXJkbGVzcyBvZgo+Pj4+IGluZmxpZ2h0IGRlc2NyaXB0b3JzLgo+Pj4+Cj4+PiBJ
IHRoaW5rIEknbSBzdGlsbCBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLgo+Pj4KPj4+IFRvIGJlIG9u
IHRoZSBzYW1lIHBhZ2UuIFJlZ2FyZGluZyB0eCB0aGlzIGNvdWxkIGNhdXNlIHJlcGVhdGVkIHR4
Cj4+PiBmcmFtZXMgKG9uZSBhdCBzb3VyY2UgYW5kIG90aGVyIGF0IGRlc3RpbmF0aW9uKSwgYnV0
IG5ldmVyIGEgbWlzc2VkCj4+PiBidWZmZXIgbm90IHRyYW5zbWl0dGVkLiBUaGUgInN0b3AgYmVm
b3JlIiBjb3VsZCBiZSBpbnRlcnByZXRlZCBhcyAiU1ZRCj4+PiBpcyBub3QgZm9yd2FyZGluZyBh
dmFpbGFibGUgYnVmZmVycyBhbnltb3JlIi4gV291bGQgdGhhdCB3b3JrPwo+Pgo+PiBSaWdodCwg
YnV0IHRoaXMgb25seSB3b3JrIGlmCj4+Cj4+IDEpIGEgZmx1c2ggdG8gbWFrZSBzdXJlIFRYIERN
QSBmb3IgaW5mbGlnaHQgZGVzY3JpcHRvcnMgYXJlIGFsbCBjb21wbGV0ZWQKPj4KPj4gMikganVz
dCBtYXJrIGFsbCBpbmZsaWdodCBkZXNjcmlwdG9yIHVzZWQKPj4KPiBJdCBjdXJyZW50bHkgdHJ1
c3RzIG9uIHRoZSByZXZlcnNlOiBCdWZmZXJzIG5vdCBtYXJrZWQgYXMgdXNlZCAoYnkgdGhlCj4g
ZGV2aWNlKSB3aWxsIGJlIGF2YWlsYWJsZSBpbiB0aGUgZGVzdGluYXRpb24sIHNvIGV4cGVjdAo+
IHJldHJhbnNtaXNzaW9ucy4KCgpJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgSSB0aGluayB3ZSBk
byBtaWdyYXRlIGxhc3RfYXZhaWxfaWR4LiBTbyB0aGVyZSAKd29uJ3QgYmUgYSByZS10cmFuc21p
c3Npb24sIHNpbmNlIHdlIGRlcGVuZCBvbiBxZW11IHZpcnRxdWV1ZSBjb2RlIHRvIApkZWFsIHdp
dGggdnJpbmcgYmFzZT8KClRoYW5rcwoKCj4KPiBUaGFua3MhCj4KPj4gT3RoZXJ3aXNlIHRoZXJl
IGNvdWxkIGJlIGJ1ZmZlcnMgdGhhdCBpcyBpbmZsaWdodCBmb3JldmVyLgo+Pgo+PiBUaGFua3MK
Pj4KPj4KPj4+IFRoYW5rcyEKPj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+Pj4gVGhhbmtz
Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICBmb3IgKHVuc2lnbmVkIGkgPSAw
OyBpIDwgc3ZxLT52cmluZy5udW07ICsraSkgewo+Pj4+Pj4+ICsgICAgICAgIGdfYXV0b2ZyZWUg
VmlydFF1ZXVlRWxlbWVudCAqZWxlbSA9IE5VTEw7Cj4+Pj4+Pj4gKyAgICAgICAgZWxlbSA9IGdf
c3RlYWxfcG9pbnRlcigmc3ZxLT5yaW5nX2lkX21hcHNbaV0pOwo+Pj4+Pj4+ICsgICAgICAgIGlm
IChlbGVtKSB7Cj4+Pj4+Pj4gKyAgICAgICAgICAgIHZpcnRxdWV1ZV9kZXRhY2hfZWxlbWVudChz
dnEtPnZxLCBlbGVtLCBlbGVtLT5sZW4pOwo+Pj4+Pj4+ICsgICAgICAgIH0KPj4+Pj4+PiArICAg
IH0KPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICBuZXh0X2F2YWlsX2VsZW0gPSBnX3N0ZWFsX3BvaW50
ZXIoJnN2cS0+bmV4dF9ndWVzdF9hdmFpbF9lbGVtKTsKPj4+Pj4+PiArICAgIGlmIChuZXh0X2F2
YWlsX2VsZW0pIHsKPj4+Pj4+PiArICAgICAgICB2aXJ0cXVldWVfZGV0YWNoX2VsZW1lbnQoc3Zx
LT52cSwgbmV4dF9hdmFpbF9lbGVtLAo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBuZXh0X2F2YWlsX2VsZW0tPmxlbik7Cj4+Pj4+Pj4gKyAgICB9Cj4+Pj4+Pj4gICAg
ICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
