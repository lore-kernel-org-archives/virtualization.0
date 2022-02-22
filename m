Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E510C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 04:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 387B660E84;
	Tue, 22 Feb 2022 04:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mWZ7Cb-9wHS; Tue, 22 Feb 2022 04:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A458060E7F;
	Tue, 22 Feb 2022 04:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D800C001A;
	Tue, 22 Feb 2022 04:02:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD931C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 956FC40145
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mWViC5FOgoG6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:02:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 640D6400CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645502547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywnsWPS2W2qdL3zZiZJ0p7X4OhrYRlrHAylnV1YkW5k=;
 b=Zp8Sq/Ylis+iKa6pyO+cB2qcAg3fFDUxukLpJZ9F+t86nIj++bWCtjWRAfLY4hDw58noas
 CjWuBkEK26evXiPZSrnn1BzRf4+wLYKKb/cYkZon1ndIetIjEOSJzsm4Kci7nz8uFGJh7f
 cJhu19xChn+D3xKHkl5ot1w1/DKKNPI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-Kpq-Qph-MzqmnP223Dt3eA-1; Mon, 21 Feb 2022 23:02:25 -0500
X-MC-Unique: Kpq-Qph-MzqmnP223Dt3eA-1
Received: by mail-pj1-f70.google.com with SMTP id
 gv4-20020a17090b11c400b001bbffb2c5f3so807094pjb.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 20:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ywnsWPS2W2qdL3zZiZJ0p7X4OhrYRlrHAylnV1YkW5k=;
 b=esd/FT1WXAFTBpMpb30zPV6zFyvsgGVz2nfLIve7tsEEcW486OuamvlArngOoVgxaa
 DgN1pXyvqRkbKWab8nDUhdd5egGGyj+9/fIAFsNONNZoyGswV05sa9/ttnWXqR1D0rva
 pIw1JDrSctX/qTuBb+oeg3O72zHlgHg4ZMpZRhwraREIdTvtwbFskhQwvvqmgm1mVE3/
 B4DxdRaPFRSEE0EXmvbxrd+suW1xvNf/mFLmJYozIbmN3pLuvEaCa3G4H6cFVekrUfMT
 0Nto1gQM2zfajmQuBoh7yej7doKEgMtTJCZsSyeHsHEDldJqmkDcDSkWzU7W2FpIS+Ok
 hWEw==
X-Gm-Message-State: AOAM532nBeczZrN9GGvaNeTDNx2IyfxzWj4EJ3McXnC/A8PK1jiMffZ9
 0Yd2ou8LZsqVCG8fvBNskWtA+FQndEC5okxaIH+CTBRQFajGIseejN6YOtRbrkt9Bk2y56GoNcq
 v1WNQVtubmH5213e+Sb1fqkVHT2zPV0TUWrtJbze/dA==
X-Received: by 2002:a17:902:8645:b0:14d:5a0b:965e with SMTP id
 y5-20020a170902864500b0014d5a0b965emr21741238plt.112.1645502544686; 
 Mon, 21 Feb 2022 20:02:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx94kE3QR88JPF0Q2YrQPlX3wtAS+sF8gwT7y4PQSEKUIKKBTivxl+G1UnpwrPTkbz1/fytpQ==
X-Received: by 2002:a17:902:8645:b0:14d:5a0b:965e with SMTP id
 y5-20020a170902864500b0014d5a0b965emr21741214plt.112.1645502544284; 
 Mon, 21 Feb 2022 20:02:24 -0800 (PST)
Received: from [10.72.13.199] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m23sm13831319pff.201.2022.02.21.20.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 20:02:23 -0800 (PST)
Message-ID: <c98a4fd4-af0e-f97f-55a7-a8804eb1fb40@redhat.com>
Date: Tue, 22 Feb 2022 12:02:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645442604.5901623-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1645442604.5901623-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIyLzIvMjEg5LiL5Y2INzoyMywgWHVhbiBaaHVvIOWGmemBkzoKPiBPbiBNb24sIDIx
IEZlYiAyMDIyIDExOjMyOjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4gT24gRnJpLCBGZWIgMTgsIDIwMjIgYXQgNTowMCBQTSBYdWFuIFpodW8gPHh1
YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPj4+IE9uIFRodSwgMTcgRmViIDIwMjIg
MTU6MTk6NDQgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
Pj4+IE9uIFRodSwgRmViIDEwLCAyMDIyIGF0IDQ6NTEgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4+Pj4+IHZpcnRxdWV1ZV9hZGQoKSBvbmx5IHN1cHBv
cnRzIHZpcnR1YWwgYWRkcmVzc2VzLCBkbWEgaXMgY29tcGxldGVkIGluCj4+Pj4+IHZpcnRxdWV1
ZV9hZGQoKS4KPj4+Pj4KPj4+Pj4gSW4gc29tZSBzY2VuYXJpb3MgKHN1Y2ggYXMgdGhlIEFGX1hE
UCBzY2VuYXJpbyksIERNQSBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28KPj4+Pj4gaXQgaXMg
bmVjZXNzYXJ5IGZvciB1cyB0byBzdXBwb3J0IHBhc3NpbmcgdGhlIERNQSBhZGRyZXNzIHRvIHZp
cnRxdWV1ZV9hZGQoKS4KPj4+PiBJJ2Qgc3VnZ2VzdCByZW5hbWUgdGhpcyBmZWF0dXJlIGFzICJ1
bm1hbmFnZWQgRE1BIi4KPj4+IE9LCj4+Pgo+Pj4+PiBSZWNvcmQgdGhpcyBwcmVkbWEgaW5mb3Jt
YXRpb24gaW4gZXh0cmEtPmZsYWdzLCB3aGljaCBjYW4gYmUgc2tpcHBlZCB3aGVuCj4+Pj4+IGV4
ZWN1dGluZyBkbWEgdW5tYXAuCj4+Pj4gUXVlc3Rpb24gc3RpbGwsIGNhbiB3ZSB1c2UgcGVyLXZp
cnRxdWV1ZSBmbGFnIGluc3RlYWQgb2YgcGVyCj4+Pj4gZGVzY3JpcHRvciBmbGFnPyBJZiBteSBt
ZW1vcnkgaXMgY29ycmVjdCwgdGhlIGFuc3dlciBpcyB5ZXMgaW4gdGhlCj4+Pj4gZGlzY3Vzc2lv
biBmb3IgdGhlIHByZXZpb3VzIHZlcnNpb24uCj4+Pj4KPj4+IFllcy4KPj4+Cj4+PiBwZXItdmly
dHF1ZXVlPyBJIGd1ZXNzIGl0IHNob3VsZCBiZSBwZXItc3VibWl0Lgo+Pj4KPj4+IFRoaXMgcGF0
Y2ggc2V0IG9ubHkgYWRkcyBhIGZsYWcgdG8gZGVzY19leHRyYVtoZWFkXS5mbGFncywgc28gdGhh
dCB3ZSBjYW4ga25vdwo+Pj4gaWYgd2UgbmVlZCB0byB1bm1hcCBkbWEgd2hlbiB3ZSBkZXRhY2gu
Cj4+IEkgbWVhbnQgaWYgd2UgY2FuIG1hbmFnZSB0byBtYWtlIGl0IHBlciB2aXJ0cXVldWUsIHRo
ZXJlJ3Mgbm8gbmVlZCB0bwo+PiBtYWludGFpbiBwZXIgYnVmZmVyIGZsYWcuCj4+Cj4gUmV0aGlu
a2luZyB0aGlzIHF1ZXN0aW9uLCBJIGZlZWwgdGhlcmUgaXMgbm8gZXNzZW50aWFsIGRpZmZlcmVu
Y2UgYmV0d2VlbiBwZXIKPiB2aXJ0cXVldWUgYW5kIHBlciBzZ3MuCj4KPiBwZXIgdmlydHF1ZXVl
Ogo+IAkxLiBhZGQgYnVmOgo+IAkJYS4gY2hlY2sgdnEtPnByZW1hcHBlZCBmb3IgbWFwIGV2ZXJ5
IHNnCj4gCTIuIGRldGFjaDoKPiAJICAgICAgICBhLiBjaGVjayB2cS0+cHJlbWFwZWQgZm9yIHVu
bWFwCj4KPiBwZXIgc2dzOgo+IAkxLiBhZGQgYnVmOgo+IAkgICAgICAgIGEuIGNoZWNrIGZ1bmN0
aW9uIHBhcmFtZXRlciAicHJlbWFwcGVkIiBmb3IgbWFwIGV2ZXJ5IHNnCj4gCQliLiBhZGQgZmxh
ZyB0byBleHRyYVtoZWFkXS5mbGFnCj4KPiAJMi4gZGV0YWNoOgo+IAkgICAgICAgIGE6IGNoZWNr
IGV4dHJhW2hlYWRdLmZsYWcgZm9yIHVubWFwCj4KPgo+IFRoYW5rcy4KCgpQZXItdmlydHF1ZXVl
IGlzIHN0aWxsIGEgbGl0dGxlIGJpdCBlYXNpZXIgYXQgdGhlIGZpcnN0IGdsYW5jZS4KCkFjdHVh
bGx5LCBwZXItc2cgaGF2ZSBvbmUgYWR2YW50YWdlOiBpdCBjYW4gYmUgdXNlZCB3aXRob3V0IHZp
cnRxdWV1ZSAKcmVzZXQgKHRvIGFsbG93IHN3aXRjaGluZyBiZXR3ZWVuIHRoZSB0d28gbW9kZXMp
LiBCdXQgSSdtIG5vdCBzdXJlIAp3aGV0aGVyIHdlIGhhZCBzdWNoIHJlcXVpcmVtZW50cy4KCkkg
dGhpbmsgdG8gYW5zd2VyIHRoaXMgcXVlc3Rpb24sIHdlIHByb2JhYmx5IG5lZWQgYSByZWFsIHVz
ZSBjYXNlIChpZiB3ZSAKY2FuIGNvbWUgdXAgd2l0aCBhIGNhc2UgdGhhdCBpcyBtb3JlIGxpZ2h0
d2VpZ2h0IHRoYW4gQUZfWERQLCB0aGF0IHdvdWxkIApiZSBldmVuIGJldHRlcikuCgpUaGFua3MK
Cgo+Cj4KPj4gU28gd2Uga25vdyBzb21ldGhpbmcgdGhhdCBuZWVkcyB0byBiZSBtYXBwZWQgYnkg
dmlydGlvIGNvcmUgaXRzZWxmLAo+PiBlLmcgdGhlIGluZGlyZWN0IHBhZ2UuIE90aGVyIHRoYW4g
dGhpcywgYWxsIHRoZSByZXN0IGNvdWxkIGJlCj4+IHByZS1tYXBwZWQuCj4+Cj4+IEZvciB2bmV0
IGhlYWRlciwgaXQgY291bGQgYmUgbWFwcGVkIGJ5IHZpcnRpby1uZXQgd2hpY2ggY291bGQgYmUg
c3RpbGwKPj4gdHJlYXRlZCBhcyBwcmUgbWFwcGVkIERNQSBzaW5jZSBpdCdzIG5vdCB0aGUgdmly
dGlvIHJpbmcgY29kZS4KPj4KPj4gQW55dGhpbmcgSSBtaXNzIGhlcmU/Cj4+Cj4+IFRoYW5rcwo+
Pgo+Pgo+Pj4gVGhhbmtzLgo+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+PiB2MToKPj4+Pj4gICAg
IDEuIEFsbCBzZ3MgcmVxdWVzdGVkIGF0IG9uZSB0aW1lIGFyZSByZXF1aXJlZCB0byBiZSB1bmlm
aWVkIFBSRURNQSwgYW5kIHNldmVyYWwKPj4+Pj4gICAgICAgIG9mIHRoZW0gYXJlIG5vdCBzdXBw
b3J0ZWQgdG8gYmUgUFJFRE1BCj4+Pj4+ICAgICAyLiB2aXJ0aW9fZG1hX21hcCgpIGlzIHJlbW92
ZWQgZnJvbSB0aGlzIHBhdGNoIHNldCBhbmQgd2lsbCBiZSBzdWJtaXR0ZWQKPj4+Pj4gICAgICAg
IHRvZ2V0aGVyIHdpdGggdGhlIG5leHQgdGltZSBBRl9YRFAgc3VwcG9ydHMgdmlydGlvIGRtYQo+
Pj4+PiAgICAgMy4gQWRkZWQgcGF0Y2ggIzIgIzMgdG8gcmVtb3ZlIHRoZSBjaGVjayBmb3IgZmxh
Z3Mgd2hlbiBwZXJmb3JtaW5nIHVubWFwCj4+Pj4+ICAgICAgICBpbmRpcmVjdCBkZXNjCj4+Pj4+
Cj4+Pj4+IFh1YW4gWmh1byAoNik6Cj4+Pj4+ICAgIHZpcnRpbzogcmVuYW1lIHZyaW5nX3VubWFw
X3N0YXRlX3BhY2tlZCgpIHRvCj4+Pj4+ICAgICAgdnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKCkK
Pj4+Pj4gICAgdmlydGlvOiByZW1vdmUgZmxhZ3MgY2hlY2sgZm9yIHVubWFwIHNwbGl0IGluZGly
ZWN0IGRlc2MKPj4+Pj4gICAgdmlydGlvOiByZW1vdmUgZmxhZ3MgY2hlY2sgZm9yIHVubWFwIHBh
Y2tlZCBpbmRpcmVjdCBkZXNjCj4+Pj4+ICAgIHZpcnRpbzogdmlydHF1ZXVlX2FkZCgpIHN1cHBv
cnQgcHJlZG1hCj4+Pj4+ICAgIHZpcnRpbzogc3BsaXQ6IHZpcnRxdWV1ZV9hZGRfc3BsaXQoKSBz
dXBwb3J0IGRtYSBhZGRyZXNzCj4+Pj4+ICAgIHZpcnRpbzogcGFja2VkOiB2aXJ0cXVldWVfYWRk
X3BhY2tlZCgpIHN1cHBvcnQgZG1hIGFkZHJlc3MKPj4+Pj4KPj4+Pj4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIHwgMTk5ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
Cj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEyNiBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlvbnMo
LSkKPj4+Pj4KPj4+Pj4gLS0KPj4+Pj4gMi4zMS4wCj4+Pj4+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
