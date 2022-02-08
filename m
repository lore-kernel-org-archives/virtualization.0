Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58601C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E594940867;
	Tue,  8 Feb 2022 03:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uqk1OhqckZX; Tue,  8 Feb 2022 03:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 68AC240629;
	Tue,  8 Feb 2022 03:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30C73C001A;
	Tue,  8 Feb 2022 03:36:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 861E4C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67238815AD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GqYs6MsmcUDQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6271E81415
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644291398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvjYmb4fznf4B7CPoj9ot4B6+UX+ip1V7EfG8FVrs/w=;
 b=J6jpZnN172CHsC92PnckzcEffL5Z3Z7TSZZkuuwUbFsZ7cTogEyXaht+ErzD2/xZ8EaMvX
 cmACS4ilfkBveXX3g/zUzki/wvBIg4OlzTkDZjDAmbilJV9JGhHxvjFZjK3Pj3c9elnzW6
 I7Nc1orWWOKWd2rvNtGRrTd6wJs7710=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-e5BKp5SQPTaEunnYkgIzsg-1; Mon, 07 Feb 2022 22:36:35 -0500
X-MC-Unique: e5BKp5SQPTaEunnYkgIzsg-1
Received: by mail-lj1-f197.google.com with SMTP id
 k18-20020a05651c10b200b002430548189aso5374360ljn.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 19:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RvjYmb4fznf4B7CPoj9ot4B6+UX+ip1V7EfG8FVrs/w=;
 b=JpeoxGZfPuWMXWukmJjY/dZBYWmInjjZ1hT1lr+shE9DR37sGsjCxGGAbvmdjcRw04
 cjqioGu8MQ/5kEJA1ms/wqnSrgjOjFiqBPc55xA6v9l4oFu9SWxgllh2Z3G0kobgiE0L
 iGu2zTbLcz55RPlGUtYWeVgUq9CPe3/NF8/bQ6lVNe9OTGlufWMsysREDjre95ynLgks
 rcqtuH5Uq81CeOuvDvJMs101+tXDgf98lbzxI9HvRHqfOGCYcvzBJHkMsnN5EOm3aRkP
 TCSADzc3hYHkMavih/D88iFB9YPPHyKgiNqVFEiKzJfxAYhg771Q21v68J0NPt5lvffi
 VyRA==
X-Gm-Message-State: AOAM530vHez5fTaDV+TOfvKO3byLW1YLvF94KlyjsO4hVdg1bwIFfKCG
 /1ZWJh/Lf+jbB3VBs3lesYLwP3thDCcDocC5qy43iNfjhNccjvVWWmIx1nLzRmiuzNAnZsRvH3Y
 k5YvRdJfdXaimMpJSdOPgE8KB+qesIpT/49xeqd9FI5NBzqelij1jfn5gbg==
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr1568570lji.217.1644291394331; 
 Mon, 07 Feb 2022 19:36:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMI8o//xEA9K104uQ3Yysm0k68EfVhZh1ieP1yTpxYlAIN/TFaRuip8eyeyhBON0GOKIx6a2oM+t+M5gdNlNU=
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr1568554lji.217.1644291394065; 
 Mon, 07 Feb 2022 19:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-2-xuanzhuo@linux.alibaba.com>
 <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
 <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
 <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
 <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtOoSF293nDwLFpAcs9M1+sUZufO309kCO0tRy7w40vdQ@mail.gmail.com>
 <1644290712.5535257-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644290712.5535257-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Feb 2022 11:36:23 +0800
Message-ID: <CACGkMEshTp8vSP9=pKj82y8+DDQFu9tFAk1EGhMZLvXUE-OSEA@mail.gmail.com>
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

T24gVHVlLCBGZWIgOCwgMjAyMiBhdCAxMToyOSBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgOCBGZWIgMjAyMiAxMToyNDoxMyArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEZl
YiA4LCAyMDIyIGF0IDExOjIwIEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUdWUsIDggRmViIDIwMjIgMTE6MDM6MTcgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwg
RmViIDgsIDIwMjIgYXQgMTA6MTcgQU0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gTW9uLCA3IEZlYiAyMDIyIDE2OjA2
OjE1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4g
PiA+ID4gT24gTW9uLCBGZWIgNywgMjAyMiBhdCAyOjA3IFBNIFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT24g
TW9uLCA3IEZlYiAyMDIyIDExOjQxOjA2ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMi8x
LzI2IOS4i+WNiDM6MzUsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+IEFkZCBx
dWV1ZV9ub3RpZnlfZGF0YSBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnLCB3aGljaCBj
b21lcyBmcm9tCj4gPiA+ID4gPiA+ID4gPiA+IGhlcmUgaHR0cHM6Ly9naXRodWIuY29tL29hc2lz
LXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvODkKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gU2luY2UgSSB3YW50IHRvIGFkZCBxdWV1ZV9yZXNldCBhZnRlciBpdCwgSSBzdWJtaXR0
ZWQgdGhpcyBwYXRjaCBmaXJzdC4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+
ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4
L3ZpcnRpb19wY2kuaCB8IDEgKwo+ID4gPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcGNpLmgKPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXggM2E4NmYzNmQ3ZTNkLi40OTJj
ODlmNTZjNmEgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcGNpLmgKPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4
L3ZpcnRpb19wY2kuaAo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMTY0LDYgKzE2NCw3IEBAIHN0cnVj
dCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ID4gPiA+ID4gPiA+ID4gPiAgICAgX19sZTMyIHF1
ZXVlX2F2YWlsX2hpOyAgICAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+ID4gPiA+ID4gPiA+
ICAgICBfX2xlMzIgcXVldWVfdXNlZF9sbzsgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+
ID4gPiA+ID4gPiA+ID4gICAgIF9fbGUzMiBxdWV1ZV91c2VkX2hpOyAgICAgICAgICAgLyogcmVh
ZC13cml0ZSAqLwo+ID4gPiA+ID4gPiA+ID4gPiArICAgX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRh
OyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+ID4gPiA+ID4gPiA+ICAgfTsKPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU28gSSBoYWQgdGhlIHNhbWUg
Y29uY2VybiBhcyBwcmV2aW91cyB2ZXJzaW9uLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+IFRoaXMgYnJlYWtzIHVBQkkgd2hlcmUgcHJvZ3JhbSBtYXkgdHJ5IHRvIHVzZSBzaXplb2Yo
c3RydWN0Cj4gPiA+ID4gPiA+ID4gPiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcpLgo+ID4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+IFdlIHByb2JhYmx5IG5lZWQgYSBjb250YWluZXIgc3RydWN0
dXJlIGhlcmUuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIHNlZSwgSSBwbGFuIHRvIGFk
ZCBhIHN0cnVjdCBsaWtlIHRoaXMsIGRvIHlvdSB0aGluayBpdCdzIGFwcHJvcHJpYXRlPwo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZ192MSB7
Cj4gPiA+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIGNmZzsK
PiA+ID4gPiA+ID4gPiAgICAgICAgIF9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyog
cmVhZC13cml0ZSAqLwo+ID4gPiA+ID4gPiA+IH0KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU29t
ZXRoaW5nIGxpa2UgdGhpcyBidXQgd2UgcHJvYmFibHkgbmVlZCBhIGJldHRlciBuYW1lLgo+ID4g
PiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBob3cgYWJvdXQgdGhpcz8KPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgICAgICAgIC8qIEV4dCBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfQ09NTU9OX0NGRzog
Ki8KPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZ19leHQgewo+
ID4gPiA+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgY2Zn
Owo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcXVldWVfbm90aWZ5
X2RhdGE7ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgX19sZTE2IHJlc2VydmVkMDsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xl
MTYgcmVzZXJ2ZWQxOwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDI7
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMzsKPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQ0Owo+ID4gPiA+ID4gICAgICAgICAgICAgICAg
IF9fbGUxNiByZXNlcnZlZDU7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2Vy
dmVkNjsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQ3Owo+ID4gPiA+
ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDg7Cj4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgX19sZTE2IHJlc2VydmVkOTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYg
cmVzZXJ2ZWQxMDsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQxMTsK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQxMjsKPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQxMzsKPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICBfX2xlMTYgcmVzZXJ2ZWQxNDsKPiA+ID4gPiA+ICAgICAgICAgfTsKPiA+ID4gPgo+ID4gPiA+
IEkgc3RpbGwgdGhpbmsgdGhlIGNvbnRhaW5lciB3aXRob3V0IHBhZGRpbmcgaXMgYmV0dGVyLiBP
dGhlcndpc2UKPiA+ID4gPiB1c2Vyc3BhY2UgbmVlZHMgdG8gdXNlIG9mZnNldF9vZigpIHRyaWNr
IGluc3RlYWQgb2Ygc2l6ZW9mKCkuCj4gPiA+Cj4gPiA+IEluIHRoaXMgY2FzZSwgYXMgdmlydGlv
X3BjaV9jb21tb25fY2ZnX2V4dCBhZGRzIG5ldyBtZW1iZXJzIGluIHRoZSBmdXR1cmUsIHdlCj4g
PiA+IHdpbGwgYWRkIG1vcmUgY29udGFpbmVyIHN0cnVjdHVyZXMuCj4gPiA+Cj4gPiA+IEluIHRo
YXQgY2FzZSwgSSB0aGluayB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfdjEgaXMgYSBnb29kIG5hbWUg
aW5zdGVhZC4KPiA+Cj4gPiBTb21ldGhpbmcgbGlrZSAidmlydGlvX3BjaV9jb21tb25fY2ZnX25v
dGlmeSIgbWlnaHQgYmUgYSBsaXR0bGUgYml0IGJldHRlci4KPgo+IEFsdGhvdWdoIHRoZXJlIGlz
IG9ubHkgb25lIG5vdGlmeV9kYXRhIGluIHRoaXMgcGF0Y2gsIEkgcGxhbiB0byBsb29rIGxpa2Ug
dGhpcwo+IGFmdGVyIG15IHBhdGNoIHNldDoKPgo+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lf
Y29tbW9uX2NmZ192MSB7Cj4gICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1v
bl9jZmcgY2ZnOwo+Cj4gICAgICAgICAgICAgICAgIF9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsg
ICAgICAgLyogcmVhZC13cml0ZSAqLwo+ICAgICAgICAgICAgICAgICBfX2xlMTYgcXVldWVfcmVz
ZXQ7ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiAgICAgICAgIH0KPgo+IElmIHdlIHVzZSB2aXJ0
aW9fcGNpX2NvbW1vbl9jZmdfbm90aWZ5LCB0aGVuIHdlIHdpbGwgZ2V0IHR3byBzdHJ1Y3R1cmVz
IGFmdGVyCj4gdGhpcyBwYXRjaCBzZXQ6Cj4KPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2Nv
bW1vbl9jZmdfbm90aWZ5IHsKPiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29t
bW9uX2NmZyBjZmc7Cj4KPiAgICAgICAgICAgICAgICAgX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRh
OyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gICAgICAgICB9Cj4KPiAgICAgICAgIHN0cnVjdCB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmdfcmVzZXQgewo+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmly
dGlvX3BjaV9jb21tb25fY2ZnX25vdGlmeSBjZmc7Cj4KPiAgICAgICAgICAgICAgICAgX19sZTE2
IHF1ZXVlX3Jlc2V0OyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gICAgICAgICB9CgpSaWdodCwg
dGhpcyBpcyBzdWItb3B0aW1hbCwgYW5kIHdlIG5lZWQgcGFkZGluZyBpbiBjZmdfbm90aWZ5CnBy
b2JhYmx5LiBCdXQgSSBjb3VsZG4ndCB0aGluayBvZiBhIGJldHRlciBpZGVhIGN1cnJlbnRseSwg
bWF5YmUgd2UKY2FuIGxpc3RlbiBmcm9tIG90aGVycyBvcGluaW9uCgpCdXQgd2UgdXNlIHNvbWV0
aGluZyBsaWtlIHRoaXMgZm9yIHZuZXRfaGVhZGVyIGV4dGVuc2lvbgoKc3RydWN0IHZpcnRpb19u
ZXRfaGRyX3Yxewp9OwoKc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hhc2h7CnN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl92MTsKX19sZTMyIFhYWDsKLi4uCl9fbGUxNiBwYWRkaW5nOwp9OwoKQW5kIGl0
J3Mgbm90IGhhcmQgdG8gaW1hZ2luZSB0aGVyZSB3b3VsZCBiZSBhbm90aGVyIGNvbnRhaW5lciBm
b3IKc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hhc2ggaW4gdGhlIGZ1dHVyZSBpZiB3ZSB3YW50
IHRvIGV4dGVuZCB2bmV0CmhlYWRlci4KClRoYW5rcwoKPgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4g
VGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MuCj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4g
PiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiBUSGFua3MKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiAgIC8qIEZpZWxkcyBpbiBWSVJUSU9fUENJX0NBUF9Q
Q0lfQ0ZHOiAqLwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
