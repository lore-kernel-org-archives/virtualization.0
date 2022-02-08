Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF2EC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2EE140228;
	Tue,  8 Feb 2022 03:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eb74rRwqelRh; Tue,  8 Feb 2022 03:24:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74A674020E;
	Tue,  8 Feb 2022 03:24:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 499E7C001A;
	Tue,  8 Feb 2022 03:24:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26F6EC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07FC560A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DQJZRZFJnWx9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AEDE60A97
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644290667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmzNPlkxWWEnYip16aRoQo9kev5KhShz7UfafEwcglg=;
 b=XHELVZFZOpAKnfqCtHpjhR7muPCp3bkjX9DWGYMNnvyGJzZgc/HYDZ8an8ehLvmX1aCIjr
 TO4NiRy8Mvl77YrWbQOdy11eDcpI7AlX1h6wqNLFYhe2nfui/Kf0/0nIxAmEIr6PIUB4UG
 7TPNFXHAtQT1LYBBS+Iw6oc86rWpYdI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-EiTPxb7qMy-9ddgFEC-T8g-1; Mon, 07 Feb 2022 22:24:25 -0500
X-MC-Unique: EiTPxb7qMy-9ddgFEC-T8g-1
Received: by mail-lj1-f197.google.com with SMTP id
 q17-20020a2e7511000000b0023c95987502so5406096ljc.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 19:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XmzNPlkxWWEnYip16aRoQo9kev5KhShz7UfafEwcglg=;
 b=rSUz7pej5B3/+C8oFfAx1D6Kt2970d3ZkJ4sSPRfEaPc4l4kKbKzROcmeXC//+lDhr
 QQcfLtFw9lAhw0ZpcBnc55eo0VifNsoYewGndhMCLGEVToS8lfbqztuHYHEuZccsKRXE
 8EyK3+u1z/w7Z9C/KVKgHQnSgQc9wF3vRQoXHdSK9FAUGuPqfcT+QbZtD7vcwfy6davm
 cXL9VsE9zApbPpE29ZeJEpnzr5Fjfu9SJD0x6vJIm+EaHAmcWkTgyhspftnaWs+chyXD
 cqwK+0LtuoC1J21b6pLRygeNqC/xQxgLJ+f2Hnr1GGQxhEnvkTPaQf0eGBJ900LnD2SS
 36pQ==
X-Gm-Message-State: AOAM5335d7lyOFMdeR7lVNPeI4ABhGRUvptDWh+V9sAYF8SKJA41wi1K
 bQJOYUY0W1OLFtiUp8zxCmDQifL05EkDH6NwKxS6UeUarpyvxril/3coyzxOR7E7zGi2pFlzBJU
 +5UNz04umgrzrIM/CaG/9Mck49QKn5QQf1zXdris83sHJeoLNglj2Q5QPDQ==
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr1720193lfp.580.1644290664426; 
 Mon, 07 Feb 2022 19:24:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW38r/MbqhEQoE0DC7dUknDgPDexQGx026XujMyoT9wTt77AHO3Jo4bfMJvjYC7HugGD8zwBA3+PWfIrkxA9U=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr1720177lfp.580.1644290664230; 
 Mon, 07 Feb 2022 19:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-2-xuanzhuo@linux.alibaba.com>
 <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
 <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
 <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
 <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Feb 2022 11:24:13 +0800
Message-ID: <CACGkMEtOoSF293nDwLFpAcs9M1+sUZufO309kCO0tRy7w40vdQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBGZWIgOCwgMjAyMiBhdCAxMToyMCBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgOCBGZWIgMjAyMiAxMTowMzoxNyArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEZl
YiA4LCAyMDIyIGF0IDEwOjE3IEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24sIDcgRmViIDIwMjIgMTY6MDY6MTUgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwg
RmViIDcsIDIwMjIgYXQgMjowNyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBNb24sIDcgRmViIDIwMjIgMTE6NDE6
MDYgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiDlnKggMjAyMi8xLzI2IOS4i+WNiDM6MzUsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiA+ID4gPiA+ID4gQWRkIHF1ZXVlX25vdGlmeV9kYXRhIGluIHN0cnVjdCB2aXJ0aW9f
cGNpX2NvbW1vbl9jZmcsIHdoaWNoIGNvbWVzIGZyb20KPiA+ID4gPiA+ID4gPiBoZXJlIGh0dHBz
Oi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzg5Cj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiBTaW5jZSBJIHdhbnQgdG8gYWRkIHF1ZXVlX3Jlc2V0IGFmdGVyIGl0
LCBJIHN1Ym1pdHRlZCB0aGlzIHBhdGNoIGZpcnN0Lgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4K
PiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0
aW9fcGNpLmggfCAxICsKPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fcGNpLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4g
PiA+ID4gPiA+ID4gaW5kZXggM2E4NmYzNmQ3ZTNkLi40OTJjODlmNTZjNmEgMTAwNjQ0Cj4gPiA+
ID4gPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4gPiA+ID4g
PiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiA+ID4gPiA+ID4gPiBA
QCAtMTY0LDYgKzE2NCw3IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ID4gPiA+
ID4gPiA+ICAgICBfX2xlMzIgcXVldWVfYXZhaWxfaGk7ICAgICAgICAgIC8qIHJlYWQtd3JpdGUg
Ki8KPiA+ID4gPiA+ID4gPiAgICAgX19sZTMyIHF1ZXVlX3VzZWRfbG87ICAgICAgICAgICAvKiBy
ZWFkLXdyaXRlICovCj4gPiA+ID4gPiA+ID4gICAgIF9fbGUzMiBxdWV1ZV91c2VkX2hpOyAgICAg
ICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiA+ID4gPiA+ICsgICBfX2xlMTYgcXVldWVfbm90
aWZ5X2RhdGE7ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiA+ID4gPiAgIH07Cj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNvIEkgaGFkIHRoZSBzYW1lIGNvbmNlcm4g
YXMgcHJldmlvdXMgdmVyc2lvbi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhpcyBicmVha3Mg
dUFCSSB3aGVyZSBwcm9ncmFtIG1heSB0cnkgdG8gdXNlIHNpemVvZihzdHJ1Y3QKPiA+ID4gPiA+
ID4gdmlydGlvX3BjaV9jb21tb25fY2ZnKS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2UgcHJv
YmFibHkgbmVlZCBhIGNvbnRhaW5lciBzdHJ1Y3R1cmUgaGVyZS4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBJIHNlZSwgSSBwbGFuIHRvIGFkZCBhIHN0cnVjdCBsaWtlIHRoaXMsIGRvIHlvdSB0aGluayBp
dCdzIGFwcHJvcHJpYXRlPwo+ID4gPiA+ID4KPiA+ID4gPiA+IHN0cnVjdCB2aXJ0aW9fcGNpX2Nv
bW1vbl9jZmdfdjEgewo+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25f
Y2ZnIGNmZzsKPiA+ID4gPiA+ICAgICAgICAgX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOyAgICAg
ICAvKiByZWFkLXdyaXRlICovCj4gPiA+ID4gPiB9Cj4gPiA+ID4KPiA+ID4gPiBTb21ldGhpbmcg
bGlrZSB0aGlzIGJ1dCB3ZSBwcm9iYWJseSBuZWVkIGEgYmV0dGVyIG5hbWUuCj4gPiA+Cj4gPiA+
Cj4gPiA+IGhvdyBhYm91dCB0aGlzPwo+ID4gPgo+ID4gPiAgICAgICAgIC8qIEV4dCBGaWVsZHMg
aW4gVklSVElPX1BDSV9DQVBfQ09NTU9OX0NGRzogKi8KPiA+ID4gICAgICAgICBzdHJ1Y3Qgdmly
dGlvX3BjaV9jb21tb25fY2ZnX2V4dCB7Cj4gPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmly
dGlvX3BjaV9jb21tb25fY2ZnIGNmZzsKPiA+ID4KPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUx
NiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPgo+ID4gPiAg
ICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMDsKPiA+ID4gICAgICAgICAgICAgICAgIF9f
bGUxNiByZXNlcnZlZDE7Cj4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQyOwo+
ID4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMzsKPiA+ID4gICAgICAgICAgICAg
ICAgIF9fbGUxNiByZXNlcnZlZDQ7Cj4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2
ZWQ1Owo+ID4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkNjsKPiA+ID4gICAgICAg
ICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDc7Cj4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYg
cmVzZXJ2ZWQ4Owo+ID4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkOTsKPiA+ID4g
ICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDEwOwo+ID4gPiAgICAgICAgICAgICAgICAg
X19sZTE2IHJlc2VydmVkMTE7Cj4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQx
MjsKPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDEzOwo+ID4gPiAgICAgICAg
ICAgICAgICAgX19sZTE2IHJlc2VydmVkMTQ7Cj4gPiA+ICAgICAgICAgfTsKPiA+Cj4gPiBJIHN0
aWxsIHRoaW5rIHRoZSBjb250YWluZXIgd2l0aG91dCBwYWRkaW5nIGlzIGJldHRlci4gT3RoZXJ3
aXNlCj4gPiB1c2Vyc3BhY2UgbmVlZHMgdG8gdXNlIG9mZnNldF9vZigpIHRyaWNrIGluc3RlYWQg
b2Ygc2l6ZW9mKCkuCj4KPiBJbiB0aGlzIGNhc2UsIGFzIHZpcnRpb19wY2lfY29tbW9uX2NmZ19l
eHQgYWRkcyBuZXcgbWVtYmVycyBpbiB0aGUgZnV0dXJlLCB3ZQo+IHdpbGwgYWRkIG1vcmUgY29u
dGFpbmVyIHN0cnVjdHVyZXMuCj4KPiBJbiB0aGF0IGNhc2UsIEkgdGhpbmsgdmlydGlvX3BjaV9j
b21tb25fY2ZnX3YxIGlzIGEgZ29vZCBuYW1lIGluc3RlYWQuCgpTb21ldGhpbmcgbGlrZSAidmly
dGlvX3BjaV9jb21tb25fY2ZnX25vdGlmeSIgbWlnaHQgYmUgYSBsaXR0bGUgYml0IGJldHRlci4K
ClRoYW5rcwoKPgo+IFRoYW5rcy4KPgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBU
aGFua3MKPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVEhhbmtzCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgIC8qIEZp
ZWxkcyBpbiBWSVJUSU9fUENJX0NBUF9QQ0lfQ0ZHOiAqLwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4K
PiA+ID4gPgo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
