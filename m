Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331F6C19F2C
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 06:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B50A040158;
	Mon,  1 Aug 2022 06:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B50A040158
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6QYPd7G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BgDnpcRCJDx; Mon,  1 Aug 2022 06:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D24354011C;
	Mon,  1 Aug 2022 06:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D24354011C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D895C0032;
	Mon,  1 Aug 2022 06:28:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D030C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30BCE60AAA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:28:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30BCE60AAA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6QYPd7G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X2OUxb5JrQz1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:28:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED39360A9B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED39360A9B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659335303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyyYryD7QGgOS3XQPZyq6yB64pJtotrkijoRHszU24s=;
 b=i6QYPd7G0jsn2Ch+H+4m8Y4f78Re+wYDvzBuPtJcuY8xsqNhisz2MiGufUvnxQV6GlyYZC
 OgOxH+g+FHbeIo7X6qhRb7TqNdBY9NgukuKkSnYU9FPjB0343pQY0Ie+AIZ9lV2dmp3cB4
 ex20+Sn7NFkhqMvojL7ypVGFY6H9Zhw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-rYVv00OjNlSJQN6Eha8euQ-1; Mon, 01 Aug 2022 02:27:42 -0400
X-MC-Unique: rYVv00OjNlSJQN6Eha8euQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 j10-20020a056512028a00b0048af6cf0bcbso721099lfp.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Jul 2022 23:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UyyYryD7QGgOS3XQPZyq6yB64pJtotrkijoRHszU24s=;
 b=7uzp0j1mzKUNifQHoSwVovpFE+vbUWxAe627a74JA1Yrl79xs533oGFbfX6lk0IEMx
 LZD6YYp/keAn9Oog+Mux6cZkFIEawT5qJHRZj0TQxVvGlZsv/2mDdPCraijtGei5ovZ9
 CYz4OEZgat1+DJ7Tx2rj2mB9FcSIm/BxXmzPUPyMVKtdQwIkloYiJ35jdpm5YXt/AxXx
 h1MG79BSyZ2lMZzR+t7hg/aOqSajWIjiKDHRg02E7JBubcFVPc9P4t4CP1F6+ZrYctMF
 NcDXSxuPxMTIXTwQuDgx61jKsG2J99ZGjRpzk6hOKQYk5Kp8mOqqzenWEvieGbCuWL0J
 tiqQ==
X-Gm-Message-State: ACgBeo144jO1uJwTA3fujAZazCWyRCvPosaElN+8dTKfU9Iv1dI6z+8m
 T+LLEzWWWmZxcvHcOu5Y3RX5EeM3JzhcllA/dVdAgRyjchnL0Tadl6UPC//vrgP3npMN+pwFDfy
 Y+NZTBjwQ6lFJ+zZvaHeuUk1shblhXskDT6BPBolY/obaHyCEFXtFoXsnPw==
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr272802lfl.641.1659335261144; 
 Sun, 31 Jul 2022 23:27:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7kLCPxnca4MZdlMlO6mFwl8I9LgAWtroXVyXQq60uRjcCEDVvYfqEqtkyly+cwNyUmf+jb+aYHvUNOq8R+JIA=
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr272773lfl.641.1659335260842; Sun, 31
 Jul 2022 23:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-17-xuanzhuo@linux.alibaba.com>
 <15aa26f2-f8af-5dbd-f2b2-9270ad873412@redhat.com>
 <1658907413.1860468-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvxsOfiiaWWAR8P68GY1yfwgTvaAbHk1JF7pTw-o2k25w@mail.gmail.com>
 <1658992162.584327-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-KYieHKXY_Qn0nfcnLMOSF=TowF5PwLKOxESL3KQ40Q@mail.gmail.com>
 <1658995783.1026692-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv6Ptn4zj_F-ww3Nay-VPmCNrXLaf5U98PvupAvo44FpA@mail.gmail.com>
 <1659001321.5738833-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvcRxbqJ01sjC50muW3cQJiJKUJW+67QrsOP662FCgi0g@mail.gmail.com>
 <1659334300.4209104-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1659334300.4209104-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Aug 2022 14:27:29 +0800
Message-ID: <CACGkMEu=PSnZWKbG8jQW2ZfoZAjOOGXkMvwrx5X+=fCFzEQqiw@mail.gmail.com>
Subject: Re: [PATCH v13 16/42] virtio_ring: split: introduce
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

T24gTW9uLCBBdWcgMSwgMjAyMiBhdCAyOjEzIFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCAxIEF1ZyAyMDIyIDEyOjQ5OjEyICswODAw
LCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+IE9uIFRodSwgSnVs
IDI4LCAyMDIyIGF0IDc6MjcgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFRodSwgMjggSnVsIDIwMjIgMTc6MDQ6MzYgKzA4MDAs
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFRodSwg
SnVsIDI4LCAyMDIyIGF0IDQ6MTggUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gT24gVGh1LCAyOCBKdWwgMjAyMiAxNTo0
Mjo1MCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+IE9uIFRodSwgSnVsIDI4LCAyMDIyIGF0IDM6MjQgUE0gWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBP
biBUaHUsIDI4IEp1bCAyMDIyIDEwOjM4OjUxICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgSnVsIDI3LCAyMDIyIGF0
IDM6NDQgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgMjcgSnVsIDIwMjIgMTE6
MTI6MTkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4g
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjIvNy8yNiAxNToyMSwg
WHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHZpcnRpbyByaW5nIHNwbGl0
IHN1cHBvcnRzIHJlc2l6ZS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMgc3VjY2Vzc2Z1bGx5IGFsbG9jYXRlZCBi
YXNlZCBvbiB0aGUgbmV3IG51bSwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHdlIHdpbGwgcmVsZWFz
ZSB0aGUgb2xkIHZyaW5nLiBJbiBhbnkgY2FzZSwgYW4gZXJyb3IgaXMgcmV0dXJuZWQsCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBpbmRpY2F0aW5nIHRoYXQgdGhlIHZyaW5nIHN0aWxsIHBvaW50cyB0
byB0aGUgb2xkIHZyaW5nLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IEluIHRoZSBjYXNlIG9mIGFuIGVycm9yLCByZS1pbml0aWFsaXplKHZpcnRxdWV1ZV9yZWlu
aXRfc3BsaXQoKSkgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB2aXJ0cXVldWUgdG8gZW5zdXJl
IHRoYXQgdGhlIHZyaW5nIGNhbiBiZSB1c2VkLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaW5kZXgg
YjZmZGE5MWM4MDU5Li41ODM1NWUxYWM3ZDcgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBA
QCAtMjIwLDYgKzIyMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192
aXJ0cXVldWUodW5zaWduZWQgaW50IGluZGV4LAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKCpjYWxsYmFjaykoc3Ry
dWN0IHZpcnRxdWV1ZSAqKSwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKTsKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICAgc3RhdGljIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICp2cmluZ19hbGxvY19k
ZXNjX2V4dHJhKHVuc2lnbmVkIGludCBudW0pOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK3N0YXRp
YyB2b2lkIHZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgIC8qCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAg
ICAqIEhlbHBlcnMuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMTExNyw2ICsxMTE4LDM5IEBA
IHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgIHJldHVybiB2cTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICAgfQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMg
aW50IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVt
KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICBzdHJ1
Y3QgdnJpbmdfdmlydHF1ZXVlX3NwbGl0IHZyaW5nX3NwbGl0ID0ge307Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiArICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IF92cS0+
dmRldjsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICBpbnQgZXJyOwo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgIGVyciA9IHZyaW5nX2FsbG9jX3F1ZXVl
X3NwbGl0KCZ2cmluZ19zcGxpdCwgdmRldiwgbnVtLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxLT5zcGxpdC52cmluZ19hbGlnbiwKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+
c3BsaXQubWF5X3JlZHVjZV9udW0pOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgIGlmIChlcnIp
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICBnb3RvIGVycjsKPiA+ID4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0aGluayB3
ZSBkb24ndCBuZWVkIHRvIGRvIGFueXRoaW5nIGhlcmU/Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gSSBtZWFudCBpdCBsb29rcyB0byBtZSBtb3N0IG9mIHRoZSB2aXJ0cXVldWVf
cmVpbml0KCkgaXMgdW5uZWNlc3NhcnkuCj4gPiA+ID4gPiA+ID4gPiBXZSBwcm9iYWJseSBvbmx5
IG5lZWQgdG8gcmVpbml0IGF2YWlsL3VzZWQgaWR4IHRoZXJlLgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJbiB0aGlzIGZ1bmN0aW9uLCB3ZSBjYW4gaW5kZWVkIHJl
bW92ZSBzb21lIGNvZGUuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgIHN0YXRp
YyB2b2lkIHZpcnRxdWV1ZV9yZWluaXRfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEp
Cj4gPiA+ID4gPiA+ID4gPiAgICAgICB7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIGlu
dCBzaXplLCBpOwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
bWVtc2V0KHZxLT5zcGxpdC52cmluZy5kZXNjLCAwLCB2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9i
eXRlcyk7Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBzaXpl
ID0gc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSAqIHZxLT5zcGxpdC52cmlu
Zy5udW07Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIG1lbXNldCh2cS0+c3BsaXQuZGVz
Y19zdGF0ZSwgMCwgc2l6ZSk7Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gICAgICAg
ICAgICAgICBzaXplID0gc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhKSAqIHZxLT5zcGxp
dC52cmluZy5udW07Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIG1lbXNldCh2cS0+c3Bs
aXQuZGVzY19leHRyYSwgMCwgc2l6ZSk7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGVz
ZSBtZW1zZXRzIGNhbiBiZSByZW1vdmVkLCBhbmQgdGhlb3JldGljYWxseSBpdCB3aWxsIG5vdCBj
YXVzZSBhbnkKPiA+ID4gPiA+ID4gPiBleGNlcHRpb25zLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBZZXMsIG90aGVyd2lzZSB3ZSBoYXZlIGJ1Z3MgaW4gZGV0YWNoX2J1ZigpLgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2cS0+
c3BsaXQudnJpbmcubnVtIC0gMTsgaSsrKQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgIHZxLT5zcGxpdC5kZXNjX2V4dHJhW2ldLm5leHQgPSBpICsgMTsKPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IFRoaXMgY2FuIGFsc28gYmUgcmVtb3ZlZCwgYnV0IHdlIG5lZWQgdG8g
cmVjb3JkIGZyZWVfaGVhZCB0aGF0IHdpbGwgYmVlbiB1cGRhdGUKPiA+ID4gPiA+ID4gPiBpbnNp
ZGUgdmlydHF1ZXVlX2luaXQoKS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2UgY2FuIHNpbXBs
eSBrZWVwIGZyZWVfaGVhZCB1bmNoYW5nZWQ/IE90aGVyd2lzZSBpdCdzIGEgYnVnIHNvbWV3aGVy
ZSBJIGd1ZXNzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfaW5pdCh2cSwg
dnEtPnNwbGl0LnZyaW5nLm51bSk7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGVyZSBh
cmUgc29tZSBvcGVyYXRpb25zIGluIHRoaXMsIHdoaWNoIGNhbiBhbHNvIGJlIHNraXBwZWQsIHN1
Y2ggYXMgc2V0dGluZwo+ID4gPiA+ID4gPiA+IHVzZV9kbWFfYXBpLiBCdXQgSSB0aGluayBjYWxs
aW5nIHRoaXMgZnVuY3Rpb24gZGlyZWN0bHkgd2lsbCBiZSBtb3JlIGNvbnZlbmllbnQKPiA+ID4g
PiA+ID4gPiBmb3IgbWFpbnRlbmFuY2UuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgZG9uJ3Qg
c2VlIGFueXRoaW5nIHRoYXQgaXMgbmVjZXNzYXJ5IGhlcmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4g
VGhlc2UgdGhyZWUgYXJlIGN1cnJlbnRseSBpbnNpZGUgdmlydHF1ZXVlX2luaXQoKQo+ID4gPiA+
ID4KPiA+ID4gPiA+IHZxLT5sYXN0X3VzZWRfaWR4ID0gMDsKPiA+ID4gPiA+IHZxLT5ldmVudF90
cmlnZ2VyZWQgPSBmYWxzZTsKPiA+ID4gPiA+IHZxLT5udW1fYWRkZWQgPSAwOwo+ID4gPiA+Cj4g
PiA+ID4gUmlnaHQuIExldCdzIGtlZXAgaXQgdGhlcmUuCj4gPiA+ID4KPiA+ID4gPiAoVGhvdWdo
IGl0J3Mga2luZCBvZiBzdHJhbmdlIHRoYXQgdGhlIGxhc3RfdXNlZF9pZHggaXMgbm90IGluaXRp
YWxpemVkCj4gPiA+ID4gYXQgdGhlIHNhbWUgcGxhY2Ugd2l0aCBhdmFpbF9pZHgvZmxhZ3Nfc2hh
ZG93LCB3ZSBjYW4gb3B0aW1pemUgaXQgb24KPiA+ID4gPiB0b3ApLgo+ID4gPgo+ID4gPiBJIHB1
dCBmcmVlX2hlYWQgPSAwIGluIHRoZSBhdHRhY2ggZnVuY3Rpb24sIGl0IGlzIG9ubHkgbmVjZXNz
YXJ5IHRvIHNldAo+ID4gPiBmcmVlX2hlYWQgPSAwIHdoZW4gYSBuZXcgc3RhdGUvZXh0cmEgaXMg
YXR0YWNoZWQuCj4gPgo+ID4gT2ssIHNvIEkgbWVhbnQgSSB0ZW5kIHRvIGtlZXAgaXQgdG8gbWFr
ZSB0aGlzIHNlcmllcyBjb252ZXJnZSBzb29uIDopCj4KPgo+IE9rLCBvdGhlciB0aGFuIHRoaXMs
IGFuZCB3aGF0IHdlIGRpc2N1c3NlZCwgbm8gbW9yZSBmaXhlcyB3aWxsIGJlIGFkZGVkLgo+Cj4g
VGhhbmtzLgoKQWNrCgpUaGFua3MKCj4KPgo+ID4KPiA+IFdlIGNhbiBkbyBvcHRpbWl6YXRpb24g
b24gdG9wIGFueWhvdy4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+IEluIHRoaXMgd2F5
LCB3aGVuIHdlIGNhbGwgdmlydHF1ZXVlX2luaXQoKSwgd2UgZG9uJ3QgaGF2ZSB0byB3b3JyeSBh
Ym91dAo+ID4gPiBmcmVlX2hlYWQgYmVpbmcgbW9kaWZpZWQuCj4gPiA+Cj4gPiA+IFJldGhpbmtp
bmcgdGhpcyBwcm9ibGVtLCBJIHRoaW5rIHZpcnRxdWV1ZV9pbml0KCkgY2FuIGJlIHJld3JpdHRl
biBhbmQgc29tZQo+ID4gPiB2YXJpYWJsZXMgdGhhdCB3aWxsIG5vdCBjaGFuZ2UgYXJlIHJlbW92
ZWQgZnJvbSBpdC4gKHVzZV9kbWFfYXBpLCBldmVudCwKPiA+ID4gd2Vha19iYXJyaWVycykKPiA+
ID4KPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRxdWV1ZV9pbml0KHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxLCB1MzIgbnVtKQo+ID4gPiArewo+ID4gPiArICAgICAgIHZxLT52cS5udW1fZnJlZSA9
IG51bTsKPiA+ID4gKwo+ID4gPiArICAgICAgIGlmICh2cS0+cGFja2VkX3JpbmcpCj4gPiA+ICsg
ICAgICAgICAgICAgICB2cS0+bGFzdF91c2VkX2lkeCA9IDAgfCAoMSA8PCBWUklOR19QQUNLRURf
RVZFTlRfRl9XUkFQX0NUUik7Cj4gPiA+ICsgICAgICAgZWxzZQo+ID4gPiArICAgICAgICAgICAg
ICAgdnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+ID4gPiArCj4gPiA+ICsgICAgICAgdnEtPmV2ZW50
X3RyaWdnZXJlZCA9IGZhbHNlOwo+ID4gPiArICAgICAgIHZxLT5udW1fYWRkZWQgPSAwOwo+ID4g
PiArCj4gPiA+ICsjaWZkZWYgREVCVUcKPiA+ID4gKyAgICAgICB2cS0+aW5fdXNlID0gZmFsc2U7
Cj4gPiA+ICsgICAgICAgdnEtPmxhc3RfYWRkX3RpbWVfdmFsaWQgPSBmYWxzZTsKPiA+ID4gKyNl
bmRpZgo+ID4gPiArfQo+ID4gPiArCj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzLgo+
ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICB2aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxp
dCgmdnEtPnNwbGl0LCB2cSk7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiB2aXJ0cXVldWVf
dnJpbmdfaW5pdF9zcGxpdCgpIGlzIG5lY2Vzc2FyeS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
UmlnaHQuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgICAgIH0K
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEFub3RoZXIgbWV0aG9kLCB3ZSBjYW4gdGFrZSBv
dXQgYWxsIHRoZSB2YXJpYWJsZXMgdG8gYmUgcmVpbml0aWFsaXplZAo+ID4gPiA+ID4gPiA+IHNl
cGFyYXRlbHksIGFuZCByZXBhY2thZ2UgdGhlbSBpbnRvIGEgbmV3IGZ1bmN0aW9uLiBJIGRvbuKA
mXQgdGhpbmsgaXTigJlzIHdvcnRoCj4gPiA+ID4gPiA+ID4gaXQsIGJlY2F1c2UgdGhpcyBwYXRo
IHdpbGwgb25seSBiZSByZWFjaGVkIGlmIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscywgd2hp
Y2gKPiA+ID4gPiA+ID4gPiBpcyBhIHJhcmUgb2NjdXJyZW5jZS4gSW4gdGhpcyBjYXNlLCBkb2lu
ZyBzbyB3aWxsIGluY3JlYXNlIHRoZSBjb3N0IG9mCj4gPiA+ID4gPiA+ID4gbWFpbnRlbmFuY2Uu
IElmIHlvdSB0aGluayBzbyBhbHNvLCBJIHdpbGwgcmVtb3ZlIHRoZSBhYm92ZSBtZW1zZXQgaW4g
dGhlIG5leHQKPiA+ID4gPiA+ID4gPiB2ZXJzaW9uLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJ
IGFncmVlLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICBlcnIgPSB2
cmluZ19hbGxvY19zdGF0ZV9leHRyYV9zcGxpdCgmdnJpbmdfc3BsaXQpOwo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gKyAgIGlmIChlcnIpIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAg
IHZyaW5nX2ZyZWVfc3BsaXQoJnZyaW5nX3NwbGl0LCB2ZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ICsgICAgICAgICAgIGdvdG8gZXJyOwo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBJIHN1Z2dlc3QgdG8gbW92ZSB2cmluZ19mcmVl
X3NwbGl0KCkgaW50byBhIGRlZGljYXRlZCBlcnJvciBsYWJlbC4KPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gV2lsbCBjaGFuZ2UuCj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICB9Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgdnJpbmdfZnJl
ZSgmdnEtPnZxKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICsgICB2aXJ0cXVldWVfdnJpbmdfaW5pdF9zcGxpdCgmdnJpbmdfc3BsaXQsIHZxKTsKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfaW5p
dCh2cSwgdnJpbmdfc3BsaXQudnJpbmcubnVtKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICB2
aXJ0cXVldWVfdnJpbmdfYXR0YWNoX3NwbGl0KHZxLCAmdnJpbmdfc3BsaXQpOwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgIHJldHVybiAwOwo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK2VycjoKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICsgICB2aXJ0cXVldWVfcmVpbml0X3NwbGl0KHZxKTsKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICsgICByZXR1cm4gLUVOT01FTTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICt9Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gICAvKgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgKiBQYWNrZWQgcmluZyBzcGVjaWZp
YyBmdW5jdGlvbnMgLSAqX3BhY2tlZCgpLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
