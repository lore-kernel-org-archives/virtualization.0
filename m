Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724D3C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 201C080B6F;
	Tue,  8 Feb 2022 03:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAYPQYix2hRH; Tue,  8 Feb 2022 03:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80C2880B6A;
	Tue,  8 Feb 2022 03:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF9CC0011;
	Tue,  8 Feb 2022 03:03:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A419CC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 822FC400CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ikoGmBQjE7ia
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:03:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4215640012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644289413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1stUz3RjxkgpjesKm8AllvYm9uCvOROobIu3B8b6FdQ=;
 b=UzPE0803hlZtrKj1TdhDhMlBKqpfYVf0g2NipBGcHTEx4aypp8KkpU6cY26TLI/2YqlC6g
 goX4frF1LYjgsJI1D5wV83B9EnP94vfcPQ68aSe7DX7Zr8U5t52YOPi6WPVR844tfVR3C8
 OrMEnRvIhOuNM/JXXJS9XxUzTQTkol8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-8a-Aw0rDMjq4hfdBRs8ngw-1; Mon, 07 Feb 2022 22:03:30 -0500
X-MC-Unique: 8a-Aw0rDMjq4hfdBRs8ngw-1
Received: by mail-lf1-f69.google.com with SMTP id
 27-20020ac25f1b000000b0043edb7bf7e7so3082971lfq.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 19:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1stUz3RjxkgpjesKm8AllvYm9uCvOROobIu3B8b6FdQ=;
 b=0GmMWnvPHfoRv1f/OFNO96CZs2aiNtmkKu1bDOtWspNMKcJaDG+iNcDYYQmNvBEGBP
 06NKFnR+MOcz+PpJdvgnN2JCaHTrV3T4QecNqepRjZQaGu2CKc+WTsy7wUTQSJt76nv7
 gHbjzHIyFiFOHVPJ2CnkNmpfIpxCXFI8HXc9RpqxCItERNmK5iLK5gl48iRM6l0F/KC6
 ayG3BQSyR0P2ec/y0j6OGmIdWMRD7ZJ30KlCjy8MhrqAtyOJqWPlrEeg/ktIvVdOHEBY
 VZYnK3FLI6ja/z4IbpGlgiRuZOMB2hajvPflWefk5GIyK7hpQi6uVoPWUpqX6YRf2b0b
 XERw==
X-Gm-Message-State: AOAM532tOXySK7hGABnfD6mJHlX/u2bZsII2X6Y1ygHGXY2J/8uOMS23
 hVx2d0Syc7MXsqIoD1Plf0+wUM8+oC85vTQ9r9TKPS7NtLQ+CZuWlbwF71pytK9OpN2UWlyzCpH
 E4Hnu8DhsDRFQxwBOc6q2CJg1i2WkVTTIvtE5sDlJKedQ6dHMPMj6bfNWTg==
X-Received: by 2002:a05:6512:e9c:: with SMTP id
 bi28mr1655480lfb.498.1644289409256; 
 Mon, 07 Feb 2022 19:03:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmeEqb7xD2hGfktnYzPM5khykAVWnfXuFl/OpdtF49m/bu9JXiTZeeM/TggfJswdv3D87HxYGThmUGSyAcckM=
X-Received: by 2002:a05:6512:e9c:: with SMTP id
 bi28mr1655467lfb.498.1644289409038; 
 Mon, 07 Feb 2022 19:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
 <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Feb 2022 11:03:17 +0800
Message-ID: <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
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

T24gVHVlLCBGZWIgOCwgMjAyMiBhdCAxMDoxNyBBTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgNyBGZWIgMjAyMiAxNjowNjoxNSArMDgw
MCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBNb24sIEZl
YiA3LCAyMDIyIGF0IDI6MDcgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIE1vbiwgNyBGZWIgMjAyMiAxMTo0MTowNiArMDgwMCwg
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiDl
nKggMjAyMi8xLzI2IOS4i+WNiDM6MzUsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gPiBBZGQg
cXVldWVfbm90aWZ5X2RhdGEgaW4gc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZywgd2hpY2gg
Y29tZXMgZnJvbQo+ID4gPiA+ID4gaGVyZSBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3Zp
cnRpby1zcGVjL2lzc3Vlcy84OQo+ID4gPiA+ID4KPiA+ID4gPiA+IFNpbmNlIEkgd2FudCB0byBh
ZGQgcXVldWVfcmVzZXQgYWZ0ZXIgaXQsIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2ggZmlyc3QuCj4g
PiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gICBpbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3BjaS5oIHwgMSArCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQo+ID4gPiA+ID4KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3BjaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4gPiA+
ID4gaW5kZXggM2E4NmYzNmQ3ZTNkLi40OTJjODlmNTZjNmEgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiA+ID4gPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiA+ID4gPiBAQCAtMTY0LDYgKzE2NCw3IEBAIHN0
cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ID4gPiA+ID4gICAgIF9fbGUzMiBxdWV1ZV9h
dmFpbF9oaTsgICAgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiA+ID4gICAgIF9fbGUzMiBx
dWV1ZV91c2VkX2xvOyAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiA+ID4gICAgIF9f
bGUzMiBxdWV1ZV91c2VkX2hpOyAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiA+ID4g
KyAgIF9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4g
PiA+ID4gICB9Owo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBTbyBJIGhhZCB0aGUgc2FtZSBjb25j
ZXJuIGFzIHByZXZpb3VzIHZlcnNpb24uCj4gPiA+ID4KPiA+ID4gPiBUaGlzIGJyZWFrcyB1QUJJ
IHdoZXJlIHByb2dyYW0gbWF5IHRyeSB0byB1c2Ugc2l6ZW9mKHN0cnVjdAo+ID4gPiA+IHZpcnRp
b19wY2lfY29tbW9uX2NmZykuCj4gPiA+ID4KPiA+ID4gPiBXZSBwcm9iYWJseSBuZWVkIGEgY29u
dGFpbmVyIHN0cnVjdHVyZSBoZXJlLgo+ID4gPgo+ID4gPiBJIHNlZSwgSSBwbGFuIHRvIGFkZCBh
IHN0cnVjdCBsaWtlIHRoaXMsIGRvIHlvdSB0aGluayBpdCdzIGFwcHJvcHJpYXRlPwo+ID4gPgo+
ID4gPiBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX3YxIHsKPiA+ID4gICAgICAgICBzdHJ1
Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIGNmZzsKPiA+ID4gICAgICAgICBfX2xlMTYgcXVldWVf
bm90aWZ5X2RhdGE7ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gfQo+ID4KPiA+IFNvbWV0
aGluZyBsaWtlIHRoaXMgYnV0IHdlIHByb2JhYmx5IG5lZWQgYSBiZXR0ZXIgbmFtZS4KPgo+Cj4g
aG93IGFib3V0IHRoaXM/Cj4KPiAgICAgICAgIC8qIEV4dCBGaWVsZHMgaW4gVklSVElPX1BDSV9D
QVBfQ09NTU9OX0NGRzogKi8KPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdf
ZXh0IHsKPiAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBjZmc7
Cj4KPiAgICAgICAgICAgICAgICAgX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOyAgICAgICAvKiBy
ZWFkLXdyaXRlICovCj4KPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMDsKPiAgICAg
ICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTsKPiAgICAgICAgICAgICAgICAgX19sZTE2IHJl
c2VydmVkMjsKPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMzsKPiAgICAgICAgICAg
ICAgICAgX19sZTE2IHJlc2VydmVkNDsKPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVk
NTsKPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkNjsKPiAgICAgICAgICAgICAgICAg
X19sZTE2IHJlc2VydmVkNzsKPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkODsKPiAg
ICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkOTsKPiAgICAgICAgICAgICAgICAgX19sZTE2
IHJlc2VydmVkMTA7Cj4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDExOwo+ICAgICAg
ICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQxMjsKPiAgICAgICAgICAgICAgICAgX19sZTE2IHJl
c2VydmVkMTM7Cj4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDE0Owo+ICAgICAgICAg
fTsKCkkgc3RpbGwgdGhpbmsgdGhlIGNvbnRhaW5lciB3aXRob3V0IHBhZGRpbmcgaXMgYmV0dGVy
LiBPdGhlcndpc2UKdXNlcnNwYWNlIG5lZWRzIHRvIHVzZSBvZmZzZXRfb2YoKSB0cmljayBpbnN0
ZWFkIG9mIHNpemVvZigpLgoKVGhhbmtzCgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiBUaGFua3MKPiA+
Cj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRIYW5rcwo+ID4gPiA+
Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAgIC8qIEZpZWxkcyBpbiBWSVJUSU9fUENJX0NB
UF9QQ0lfQ0ZHOiAqLwo+ID4gPiA+Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
