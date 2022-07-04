Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4672ECCA483
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 03:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA0E760B8A;
	Mon,  4 Jul 2022 03:44:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA0E760B8A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwRVPYS+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OB_yGBU7ocT; Mon,  4 Jul 2022 03:44:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2676260BA4;
	Mon,  4 Jul 2022 03:44:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2676260BA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA366C0032;
	Mon,  4 Jul 2022 03:44:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8323C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D5E760BA4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D5E760BA4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EdXc0uZwUtz4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45CAA60B8A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45CAA60B8A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656906280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cv3HUpNj3eAl/vJtQ+pT32ck850vCrBA1S2j2S7C3Ys=;
 b=IwRVPYS+e2uohe1d4HFA3seCyUfjKtK0GsYF7kROiKi6xzpajJVVkiD/i2c8HSofXu04Uz
 PzvpTzwizBIycLeNWUTGIiTEKvup5wTgDPLQf0/w56wPEbpdNppQi0L2R64Wd2GCGLsdt0
 JWvm2HLSqVM4IrGG/uxUpxNoEKOFwd4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-i1OQV9xMMWm7YKBff_Hovg-1; Sun, 03 Jul 2022 23:44:38 -0400
X-MC-Unique: i1OQV9xMMWm7YKBff_Hovg-1
Received: by mail-pj1-f69.google.com with SMTP id
 u13-20020a17090a4bcd00b001eefd8fa171so4878716pjl.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 20:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cv3HUpNj3eAl/vJtQ+pT32ck850vCrBA1S2j2S7C3Ys=;
 b=gfA5Iks+oxOI/ZT1a/pl+7uCDP0G3PTJ+JFfAaqgxaNTcPPLyjp3crBZmWrWS7Lf45
 OThZvXhbNqCUwwsd/JQYm+XQztMAicF6p9DVK/VNzi4DwOfm2+ciuHwnF8zFtzzc12Sy
 /0SkcON48c3Q3POsSvcDqCwDH7y95alJNnvVz4IQGV5zHTDoNpccI5xdxeUxfbK39TQT
 KOwDRNYzyoAV5fJNloaMmbHME/3X12FF7/rPnqwZkNY+ERYKLkdkI7UQE/fb77PZqOce
 RPEmYE7zHsb+G0O2sbPtA4Vc3W0fqlkaCg8yFCqCeca/H5H3OQi3On7efoYpbrnMR9Ys
 /aYg==
X-Gm-Message-State: AJIora9ljn5PBq1infr3eIsgD5457N+RPKvacJYv5lSyFT6M9SCKfSPR
 pJP2ZLTY2EzNrcQEZ/c1LCx64sNcujZnQWP0b0pwQSg78uOl4qbG07kT+pEeyp+maEy1nomqxCB
 6t04eZLV1Mxtg7ta8BYWNe7CCtx49T7i2kxZZCQvVyw==
X-Received: by 2002:a17:903:2305:b0:16a:6b9c:2b4c with SMTP id
 d5-20020a170903230500b0016a6b9c2b4cmr33952584plh.100.1656906277846; 
 Sun, 03 Jul 2022 20:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vk/Hd8og5+nDjg8VAC8WRwsbIgZregwPlY1R8NDNjwqjgs0y/y3d5XWztK3kil+f/m4lKdeg==
X-Received: by 2002:a17:903:2305:b0:16a:6b9c:2b4c with SMTP id
 d5-20020a170903230500b0016a6b9c2b4cmr33952558plh.100.1656906277594; 
 Sun, 03 Jul 2022 20:44:37 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a056a00009000b0051c1b445094sm20026222pfj.7.2022.07.03.20.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 20:44:37 -0700 (PDT)
Message-ID: <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
Date: Mon, 4 Jul 2022 11:44:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-39-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4IHF1ZXVlcy4KPiBCYXNlZCBvbiB0
aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcgbnVtIG9mIHRo
ZQo+IHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gaW5kZXggOWZlMjIyYTM2NjNhLi42YWIxNmZkMTkzZTUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgIAlj
aGFyIHBhZGRpbmdbMTJdOwo+ICAgfTsKPiAgIAo+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2Zy
ZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPiArCj4gICBz
dGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ICAgewo+ICAgCXJldHVybiAodW5z
aWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gQEAgLTE4NDYsNiArMTg0OCwyNiBA
QCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCXJldHVybiBORVRERVZfVFhfT0s7Cj4gICB9Cj4gICAK
PiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwK
PiArCQkJICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5nX251bSkKPiArewo+
ICsJaW50IGVyciwgcWluZGV4Owo+ICsKPiArCXFpbmRleCA9IHJxIC0gdmktPnJxOwo+ICsKPiAr
CW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwoKCkRvIHdlIG5lZWQgdG8gY2FuY2VsIHRoZSByZWZp
bGwgd29yayBoZXJlPwoKVGhhbmtzCgoKPiArCj4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJx
LT52cSwgcmluZ19udW0sIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKTsKPiArCWlmIChlcnIp
Cj4gKwkJbmV0ZGV2X2Vycih2aS0+ZGV2LCAicmVzaXplIHJ4IGZhaWw6IHJ4IHF1ZXVlIGluZGV4
OiAlZCBlcnI6ICVkXG4iLCBxaW5kZXgsIGVycik7Cj4gKwo+ICsJaWYgKCF0cnlfZmlsbF9yZWN2
KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+cmVm
aWxsLCAwKTsKPiArCj4gKwl2aXJ0bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsK
PiArCXJldHVybiBlcnI7Cj4gK30KPiArCj4gICAvKgo+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0
aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gICAgKiBz
dXBwb3J0ZWQgYnkgdGhlIGh5cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMs
IHNob3VsZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
