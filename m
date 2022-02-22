Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBC1C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 07:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94E8D40140;
	Tue, 22 Feb 2022 07:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xdv4jG5IDMcA; Tue, 22 Feb 2022 07:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80A9840145;
	Tue, 22 Feb 2022 07:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43EBEC001A;
	Tue, 22 Feb 2022 07:41:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CCF9C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAE4B60B6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ADhcUWxK6kdc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:41:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E62160803
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645515708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGrx4EtwRfyNbdr1Hsz29eiLereNmvESiiY5K98iiTU=;
 b=cuSKtWmPYxM5Za250Zhtiljr0LFoha86r8AL9sLwHV2ICG2mDLGgg2xvXAkfiBgvR8J7mo
 XA0Wh4Q5hGmprzpqqB6OdIB+t6bHs5lMyRlX+cVUhTFODZRojeLTfJ1blDoVqpdyP6x2kV
 FZuDZGEsGiHAnw5ZFAo9HK/cUxaalhs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-QZaSxEpKM6C5qND2Q4zZ0w-1; Tue, 22 Feb 2022 02:41:47 -0500
X-MC-Unique: QZaSxEpKM6C5qND2Q4zZ0w-1
Received: by mail-pg1-f200.google.com with SMTP id
 t68-20020a635f47000000b003732348b971so10906274pgb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 23:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=IGrx4EtwRfyNbdr1Hsz29eiLereNmvESiiY5K98iiTU=;
 b=pu0UBG0XHIc0/CQkltpU7s8r6naxRpL+X97qJ67SdH4Z2eCZJTZfCI9lOsXiz/kFHM
 cN2wR7GnNDnoFF+SE4035vpbVaY5sXFIbkosVL3KI05Ko6Gjh+FudDcsyc32mgSqR7jP
 Z25dtyiYFDeqdid4JnyWP04vCN+ajf0FGlRm6OhuJNC/IZFs8veDWGvN9ivKq6PvPdR6
 Jkgp2aFrtOAO8VrgRQLKCcRbnH5fIPcw6+7djg4UF2ZwX+KP75WXTwOP6HVdJQtWbYJu
 CpEvxudzeR1Fb7PHPmsR7+t7gHryQlOkCX3Mre0oYZV2WZzOgub1EM9AY3yCLJgTHYr0
 dW2Q==
X-Gm-Message-State: AOAM532LW4TTTWQfDNVLslRjvWx9OkbSlte0x+prADuUIC3Wb4fxQ8sW
 o7xNPxfmDGq5aJIeHWnWM0HAl+mno+2ECjx7fgN8J2X23kXscZcq8Ih4ifxc/8VVADYtnn9ZqG1
 aRawMUh40Atsb2MDxoXwc8vQQNjbYvgWy0lWGySGXTw==
X-Received: by 2002:a17:902:d508:b0:14f:dd5f:c8b2 with SMTP id
 b8-20020a170902d50800b0014fdd5fc8b2mr1911211plg.17.1645515705968; 
 Mon, 21 Feb 2022 23:41:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2WX9ULvGmnVvPW8y6Y/A9jFQVM47Ch2DLAEyaR5PdCPEif0F457n1g98Ql7HwNUofmpiqBw==
X-Received: by 2002:a17:902:d508:b0:14f:dd5f:c8b2 with SMTP id
 b8-20020a170902d50800b0014fdd5fc8b2mr1911197plg.17.1645515705673; 
 Mon, 21 Feb 2022 23:41:45 -0800 (PST)
Received: from [10.72.13.199] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q8sm14860810pfk.168.2022.02.21.23.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 23:41:45 -0800 (PST)
Message-ID: <0f0204f1-8b7f-a21e-495e-24443a63f026@redhat.com>
Date: Tue, 22 Feb 2022 15:41:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH 28/31] vdpa: Expose VHOST_F_LOG_ALL on SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-29-eperezma@redhat.com>
 <42664143-6d0c-b107-ec90-8e6336bae29b@redhat.com>
 <CAJaqyWdBLU+maEhByepzeH7iwLmqUba0rRb8PM4VwBy2P8Vtow@mail.gmail.com>
 <9b32f664-56a9-3718-cf48-49003f87d430@redhat.com>
 <CAJaqyWcvWjPas0=xp+U-c-kG+e6k73jg=C4phFD7S-tZY=niSQ@mail.gmail.com>
 <CACGkMEtbd9RsE9f-HLnwmhJEFsK++uBHnqG4N0c6qJG0PxDdzw@mail.gmail.com>
 <CAJaqyWdhHmD+tB_bY_YEMnBU1p7-LW=LP8f+3e_ZXDcOfSRiNA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWdhHmD+tB_bY_YEMnBU1p7-LW=LP8f+3e_ZXDcOfSRiNA@mail.gmail.com>
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

CuWcqCAyMDIyLzIvMTcg5LiL5Y2INDoyMiwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIFRodSwgRmViIDE3LCAyMDIyIGF0IDc6MDIgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+IE9uIFdlZCwgRmViIDE2LCAyMDIyIGF0IDExOjU0IFBNIEV1Z2Vu
aW8gUGVyZXogTWFydGluCj4+IDxlcGVyZXptYUByZWRoYXQuY29tPiB3cm90ZToKPj4+IE9uIFR1
ZSwgRmViIDgsIDIwMjIgYXQgOToyNSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4+Pgo+Pj4+IOWcqCAyMDIyLzIvMSDkuIvljYg3OjQ1LCBFdWdlbmlvIFBlcmV6
IE1hcnRpbiDlhpnpgZM6Cj4+Pj4+IE9uIFN1biwgSmFuIDMwLCAyMDIyIGF0IDc6NTAgQU0gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiDlnKggMjAyMi8xLzIy
IOS4iuWNiDQ6MjcsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPj4+Pj4+PiBTVlEgaXMgYWJsZSB0
byBsb2cgdGhlIGRpcnR5IGJpdHMgYnkgaXRzZWxmLCBzbyBsZXQncyB1c2UgaXQgdG8gbm90Cj4+
Pj4+Pj4gYmxvY2sgbWlncmF0aW9uLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQWxzbywgaWdub3JlIHNldCBh
bmQgY2xlYXIgb2YgVkhPU1RfRl9MT0dfQUxMIG9uIHNldF9mZWF0dXJlcyBpZiBTVlEgaXMKPj4+
Pj4+PiBlbmFibGVkLiBFdmVuIGlmIHRoZSBkZXZpY2Ugc3VwcG9ydHMgaXQsIHRoZSByZXBvcnRz
IHdvdWxkIGJlIG5vbnNlbnNlCj4+Pj4+Pj4gYmVjYXVzZSBTVlEgbWVtb3J5IGlzIGluIHRoZSBx
ZW11IHJlZ2lvbi4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoZSBsb2cgcmVnaW9uIGlzIHN0aWxsIGFsbG9j
YXRlZC4gRnV0dXJlIGNoYW5nZXMgbWlnaHQgc2tpcCB0aGF0LCBidXQKPj4+Pj4+PiB0aGlzIHNl
cmllcyBpcyBhbHJlYWR5IGxvbmcgZW5vdWdoLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+
Pj4gICAgIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKwo+
Pj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4+Cj4+Pj4+
Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3Qt
dmRwYS5jCj4+Pj4+Pj4gaW5kZXggZmIwYTMzOGJhYS4uNzUwOTBkNjVlOCAxMDA2NDQKPj4+Pj4+
PiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+Pj4+Pj4gKysrIGIvaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYwo+Pj4+Pj4+IEBAIC0xMDIyLDYgKzEwMjIsOSBAQCBzdGF0aWMgaW50IHZob3N0
X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdWludDY0X3QgKmZlYXR1
cmVzKQo+Pj4+Pj4+ICAgICAgICAgaWYgKHJldCA9PSAwICYmIHYtPnNoYWRvd192cXNfZW5hYmxl
ZCkgewo+Pj4+Pj4+ICAgICAgICAgICAgIC8qIEZpbHRlciBvbmx5IGZlYXR1cmVzIHRoYXQgU1ZR
IGNhbiBvZmZlciB0byBndWVzdCAqLwo+Pj4+Pj4+ICAgICAgICAgICAgIHZob3N0X3N2cV92YWxp
ZF9ndWVzdF9mZWF0dXJlcyhmZWF0dXJlcyk7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsgICAgICAgIC8q
IEFkZCBTVlEgbG9nZ2luZyBjYXBhYmlsaXRpZXMgKi8KPj4+Pj4+PiArICAgICAgICAqZmVhdHVy
ZXMgfD0gQklUX1VMTChWSE9TVF9GX0xPR19BTEwpOwo+Pj4+Pj4+ICAgICAgICAgfQo+Pj4+Pj4+
Cj4+Pj4+Pj4gICAgICAgICByZXR1cm4gcmV0Owo+Pj4+Pj4+IEBAIC0xMDM5LDggKzEwNDIsMjUg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpk
ZXYsCj4+Pj4+Pj4KPj4+Pj4+PiAgICAgICAgIGlmICh2LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsK
Pj4+Pj4+PiAgICAgICAgICAgICB1aW50NjRfdCBkZXZfZmVhdHVyZXMsIHN2cV9mZWF0dXJlcywg
YWNrZWRfZmVhdHVyZXM7Cj4+Pj4+Pj4gKyAgICAgICAgdWludDhfdCBzdGF0dXMgPSAwOwo+Pj4+
Pj4+ICAgICAgICAgICAgIGJvb2wgb2s7Cj4+Pj4+Pj4KPj4+Pj4+PiArICAgICAgICByZXQgPSB2
aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9WRFBBX0dFVF9TVEFUVVMsICZzdGF0dXMpOwo+Pj4+
Pj4+ICsgICAgICAgIGlmICh1bmxpa2VseShyZXQpKSB7Cj4+Pj4+Pj4gKyAgICAgICAgICAgIHJl
dHVybiByZXQ7Cj4+Pj4+Pj4gKyAgICAgICAgfQo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgICAgICBp
ZiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+Pj4+Pj4+ICsgICAgICAg
ICAgICAvKgo+Pj4+Pj4+ICsgICAgICAgICAgICAgKiB2aG9zdCBpcyB0cnlpbmcgdG8gZW5hYmxl
IG9yIGRpc2FibGUgX0ZfTE9HLCBhbmQgdGhlIGRldmljZQo+Pj4+Pj4+ICsgICAgICAgICAgICAg
KiB3b3VsZCByZXBvcnQgd3JvbmcgZGlydHkgcGFnZXMuIFNWUSBoYW5kbGVzIGl0Lgo+Pj4+Pj4+
ICsgICAgICAgICAgICAgKi8KPj4+Pj4+IEkgZmFpbCB0byB1bmRlcnN0YW5kIHRoaXMgY29tbWVu
dCwgSSdkIHRoaW5rIHRoZXJlJ3Mgbm8gd2F5IHRvIGRpc2FibGUKPj4+Pj4+IGRpcnR5IHBhZ2Ug
dHJhY2tpbmcgZm9yIFNWUS4KPj4+Pj4+Cj4+Pj4+IHZob3N0X2xvZ19nbG9iYWxfe3N0YXJ0LHN0
b3B9IGFyZSBjYWxsZWQgYXQgdGhlIGJlZ2lubmluZyBhbmQgZW5kIG9mCj4+Pj4+IG1pZ3JhdGlv
bi4gVG8gaW5mb3JtIHRoZSBkZXZpY2UgdGhhdCBpdCBzaG91bGQgc3RhcnQgbG9nZ2luZywgdGhl
eSBzZXQKPj4+Pj4gb3IgY2xlYW4gVkhPU1RfRl9MT0dfQUxMIGF0IHZob3N0X2Rldl9zZXRfbG9n
Lgo+Pj4+Cj4+Pj4gWWVzLCBidXQgZm9yIFNWUSwgd2UgY2FuJ3QgZGlzYWJsZSBkaXJ0eSBwYWdl
IHRyYWNraW5nLCBpc24ndCBpdD8gVGhlCj4+Pj4gb25seSB0aGluZyBpcyB0byBpZ25vcmUgb3Ig
ZmlsdGVyIG91dCB0aGUgRl9MT0dfQUxMIGFuZCBwcmV0ZW5kIHRvIGJlCj4+Pj4gZW5hYmxlZCBh
bmQgZGlzYWJsZWQuCj4+Pj4KPj4+IFllcywgdGhhdCdzIHdoYXQgdGhpcyBwYXRjaCBkb2VzLgo+
Pj4KPj4+Pj4gV2hpbGUgU1ZRIGRvZXMgbm90IHVzZSBWSE9TVF9GX0xPR19BTEwsIGl0IGV4cG9y
dHMgdGhlIGZlYXR1cmUgYml0IHNvCj4+Pj4+IHZob3N0IGRvZXMgbm90IGJsb2NrIG1pZ3JhdGlv
bi4gTWF5YmUgd2UgbmVlZCB0byBsb29rIGZvciBhbm90aGVyIHdheQo+Pj4+PiB0byBkbyB0aGlz
Pwo+Pj4+Cj4+Pj4gSSdtIGZpbmUgd2l0aCBmaWx0ZXJpbmcgc2luY2UgaXQncyBtdWNoIG1vcmUg
c2ltcGxlciwgYnV0IEkgZmFpbCB0bwo+Pj4+IHVuZGVyc3RhbmQgd2h5IHdlIG5lZWQgdG8gY2hl
Y2sgRFJJVkVSX09LLgo+Pj4+Cj4+PiBPayBtYXliZSBJIGNhbiBtYWtlIHRoYXQgcGFydCBtb3Jl
IGNsZWFyLAo+Pj4KPj4+IFNpbmNlIGJvdGggb3BlcmF0aW9ucyB1c2Ugdmhvc3RfdmRwYV9zZXRf
ZmVhdHVyZXMgd2UgbXVzdCBqdXN0IGZpbHRlcgo+Pj4gdGhlIG9uZSB0aGF0IGFjdHVhbGx5IHNl
dHMgb3IgcmVtb3ZlcyBWSE9TVF9GX0xPR19BTEwsIHdpdGhvdXQKPj4+IGFmZmVjdGluZyBvdGhl
ciBmZWF0dXJlcy4KPj4+Cj4+PiBJbiBwcmFjdGljZSwgdGhhdCBtZWFucyB0byBub3QgZm9yd2Fy
ZCB0aGUgc2V0IGZlYXR1cmVzIGFmdGVyCj4+PiBEUklWRVJfT0suIFRoZSBkZXZpY2UgaXMgbm90
IGV4cGVjdGluZyB0aGVtIGFueW1vcmUuCj4+IEkgd29uZGVyIHdoYXQgaGFwcGVucyBpZiB3ZSBk
b24ndCBkbyB0aGlzLgo+Pgo+IElmIHdlIHNpbXBseSBkZWxldGUgdGhlIGNoZWNrIHZob3N0X2Rl
dl9zZXRfZmVhdHVyZXMgd2lsbCByZXR1cm4gYW4KPiBlcnJvciwgZmFpbGluZyB0aGUgc3RhcnQg
b2YgdGhlIG1pZ3JhdGlvbi4gTW9yZSBvbiB0aGlzIGJlbG93LgoKCk9rLgoKCj4KPj4gU28ga2Vy
bmVsIGhhZCB0aGlzIGNoZWNrOgo+Pgo+PiAgICAgICAgICAvKgo+PiAgICAgICAgICAgKiBJdCdz
IG5vdCBhbGxvd2VkIHRvIGNoYW5nZSB0aGUgZmVhdHVyZXMgYWZ0ZXIgdGhleSBoYXZlCj4+ICAg
ICAgICAgICAqIGJlZW4gbmVnb3RpYXRlZC4KPj4gICAgICAgICAgICovCj4+IGlmIChvcHMtPmdl
dF9zdGF0dXModmRwYSkgJiBWSVJUSU9fQ09ORklHX1NfRkVBVFVSRVNfT0spCj4+ICAgICAgICAg
IHJldHVybiAtRUJVU1k7Cj4+Cj4+IFNvIGlzIGl0IEZFQVRVUkVTX09LIGFjdHVhbGx5Pwo+Pgo+
IFllcywgRkVBVFVSRVNfT0sgc2VlbXMgbW9yZSBhcHByb3ByaWF0ZSBhY3R1YWxseSBzbyBJIHdp
bGwgc3dpdGNoIHRvCj4gaXQgZm9yIHRoZSBuZXh0IHZlcnNpb24uCj4KPiBCdXQgaXQgc2hvdWxk
IGJlIGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50LCBzaW5jZQo+IHZob3N0LmM6dmhvc3RfZGV2X3N0
YXJ0IHNldHMgYm90aCBhbmQgdGhlIHNldHRpbmcgb2YgX0ZfTE9HX0FMTCBjYW5ub3QKPiBiZSBj
b25jdXJyZW50IHdpdGggaXQuCgoKUmlnaHQuCgoKPgo+PiBGb3IgdGhpcyBwYXRjaCwgSSB3b25k
ZXIgaWYgdGhlIHRoaW5nIHdlIG5lZWQgdG8gZG8gaXMgdG8gc2VlIHdoZXRoZXIKPj4gaXQgaXMg
YSBlbmFibGUvZGlzYWJsZSBGX0xPR19BTEwgYW5kIHNpbXBseSByZXR1cm4uCj4+Cj4gWWVzLCB0
aGF0J3MgdGhlIGludGVudGlvbiBvZiB0aGUgcGF0Y2guCj4KPiBXZSBoYXZlIDQgY2FzZXMgaGVy
ZToKPiBhKSBXZSdyZSBiZWluZyBjYWxsZWQgZnJvbSB2aG9zdF9kZXZfc3RhcnQsIHdpdGggZW5h
YmxlX2xvZyA9IGZhbHNlCj4gYikgV2UncmUgYmVpbmcgY2FsbGVkIGZyb20gdmhvc3RfZGV2X3N0
YXJ0LCB3aXRoIGVuYWJsZV9sb2cgPSB0cnVlCgoKQW5kIHRoaXMgY2FzZSBtYWtlcyB1cyBjYW4n
dCBzaW1wbHkgcmV0dXJuIHdpdGhvdXQgY2FsbGluZyB2aG9zdC12ZHBhLgoKCj4gYykgV2UncmUg
YmVpbmcgY2FsbGVkIGZyb20gdmhvc3RfZGV2X3NldF9sb2csIHdpdGggZW5hYmxlX2xvZyA9IGZh
bHNlCj4gZCkgV2UncmUgYmVpbmcgY2FsbGVkIGZyb20gdmhvc3RfZGV2X3NldF9sb2csIHdpdGgg
ZW5hYmxlX2xvZyA9IHRydWUKPgo+IFRoZSB3YXkgdG8gdGVsbCB0aGUgZGlmZmVyZW5jZSBiZXR3
ZWVuIGEvYiBhbmQgYy9kIGlzIHRvIGNoZWNrIGlmCj4ge0ZFQVRVUkVTLERSSVZFUn1fT0sgaXMg
c2V0LiBBbmQsIGFzIHlvdSBwb2ludCBvdXQgaW4gcHJldmlvdXMgbWFpbHMsCj4gRl9MT0dfQUxM
IG11c3QgYmUgZmlsdGVyZWQgdW5jb25kaXRpb25hbGx5IHNpbmNlIFNWUSB0cmFja3MgZGlydHkK
PiBtZW1vcnkgdGhyb3VnaCB0aGUgbWVtb3J5IHVubWFwcGluZywgc28gd2UgY2xlYXIgdGhlIGJp
dAo+IHVuY29uZGl0aW9uYWxseSBpZiB3ZSBkZXRlY3QgdGhhdCBWSE9TVF9TRVRfRkVBVFVSRVMg
d2lsbCBiZSBjYWxsZWQKPiAoY2FzZXMgYSBhbmQgYikuCj4KPiBBbm90aGVyIHBvc3NpYmlsaXR5
IGlzIHRvIHRyYWNrIGlmIGZlYXR1cmVzIGhhdmUgYmVlbiBzZXQgd2l0aCBhIGJvb2wKPiBpbiB2
aG9zdF92ZHBhIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuIEJ1dCBpdCBzZWVtcyBjbGVhbmVyIHRv
IG1lIHRvCj4gb25seSBzdG9yZSB0aGF0IGluIHRoZSBhY3R1YWwgZGV2aWNlLgoKClNvIEkgc3Vn
Z2VzdCB0byBtYWtlIHN1cmUgY29kZXMgbWF0Y2ggdGhlIGNvbW1lbnQ6CgogwqDCoMKgwqDCoMKg
wqAgaWYgKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spIHsKIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyoKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHZob3N0IGlzIHRyeWlu
ZyB0byBlbmFibGUgb3IgZGlzYWJsZSBfRl9MT0csIGFuZCB0aGUgZGV2aWNlCiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiB3b3VsZCByZXBvcnQgd3JvbmcgZGlydHkgcGFnZXMuIFNWUSBoYW5k
bGVzIGl0LgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAwOwogwqDCoMKgwqDCoMKgwqAgfQoKSXQgd291bGQgYmUgYmV0dGVyIHRvIGNo
ZWNrIHdoZXRoZXIgdGhlIGNhbGxlciBpcyB0b2dnbGluZyBfRl9MT0dfQUxMIGluIAp0aGlzIGNh
c2UuCgpUaGFua3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pj4gRG9lcyB0aGF0IG1ha2UgbW9yZSBzZW5z
ZT8KPj4+Cj4+PiBUaGFua3MhCj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gVGhhbmtz
IQo+Pj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiArICAgICAgICAgICAg
cmV0dXJuIDA7Cj4+Pj4+Pj4gKyAgICAgICAgfQo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgICAgICAv
KiBXZSBtdXN0IG5vdCBhY2sgX0ZfTE9HIGlmIFNWUSBpcyBlbmFibGVkICovCj4+Pj4+Pj4gKyAg
ICAgICAgZmVhdHVyZXMgJj0gfkJJVF9VTEwoVkhPU1RfRl9MT0dfQUxMKTsKPj4+Pj4+PiArCj4+
Pj4+Pj4gICAgICAgICAgICAgcmV0ID0gdmhvc3RfdmRwYV9nZXRfZGV2X2ZlYXR1cmVzKGRldiwg
JmRldl9mZWF0dXJlcyk7Cj4+Pj4+Pj4gICAgICAgICAgICAgaWYgKHJldCAhPSAwKSB7Cj4+Pj4+
Pj4gICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiQ2FuJ3QgZ2V0IHZkcGEgZGV2aWNlIGZl
YXR1cmVzLCBnb3QgKCVkKSIsIHJldCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
