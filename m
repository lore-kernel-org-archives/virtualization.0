Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2492C32771
	for <virtualization@archiver.kernel.org>; Sun, 18 Sep 2022 12:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BD0383F6B;
	Sun, 18 Sep 2022 12:17:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BD0383F6B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YERIaMD3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdp7uNTMSmxF; Sun, 18 Sep 2022 12:17:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C36EC83F56;
	Sun, 18 Sep 2022 12:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C36EC83F56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8841AC0033;
	Sun, 18 Sep 2022 12:17:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CABD2C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 12:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9149A83F61
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 12:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9149A83F61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VL5GjnKLDNb3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 12:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B61B683F56
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B61B683F56
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663503464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIbilycgQyjenY282EZwIsPOR3PFZL895xpYAyq5afo=;
 b=YERIaMD3wuYcnSSHE5rUpWiQjkG8gGRR1lrtqwN26ySuPA3SXyOQXrtzXfk6ZlP/qdL2zq
 Wi8TSV4I/i5XFho/xPp5yJ51WtA/+yetS5HTmPeOqMVq2AQh4d2sAzk1UrI/UTaUTIJmFJ
 UAemRQH+Sj8Bz5IoUntKUlqtiwZCbBI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-CfbDero3PLySStNSBBxkrg-1; Sun, 18 Sep 2022 08:17:42 -0400
X-MC-Unique: CfbDero3PLySStNSBBxkrg-1
Received: by mail-wm1-f71.google.com with SMTP id
 f25-20020a7bc8d9000000b003b4768dcd9cso1901902wml.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 05:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=YIbilycgQyjenY282EZwIsPOR3PFZL895xpYAyq5afo=;
 b=kHrebKGU/y6zCmUXkq7MTQeqlQ5jBSQsgmzb5tKrZ/3ebq6ruFBKTFTZdcQrgOSzqF
 bf0tI+RnJO1up77kOAaujGjYRp4aNbxvKZbVsIU6AUVZWHPZo+vvn3MhjrO8U2CoN9ah
 w8Fncz1oWvvj3Wjj2Nrs93BfpZHD3d6j1dlnDVwIy8yEYfLjwbYVaNzwjzoFk8Lk2fxy
 Egh9kBMjdusv0iF/7pgsvt4WVKZkWiagE2uZ7B76KidUI150xfQcrSgvhuiiVSvJoQxF
 BQcqZUi5TRS2Qi0iNFFih+D9T3EIEsXmZEl9aK95zeT3HtELwtzUADfDDOF5yo4zrvkr
 e8Aw==
X-Gm-Message-State: ACrzQf2zNUzQF6MWrDE/ah4s04xsLtNPxOxX6l/t1Hhwql42s5oHp3F/
 IaaEYrKS3rtQ4fMGFRjY0d8fbyKsP/Hs1122nTiu8bXpPnWEEf2Vb8CO5ZSzkNy6nxyuyp5BOiw
 mRGHV+VUmd+yNppMCsvnNJKPCXDcC4X8evn0G2+yMqg==
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id
 o2-20020a5d4742000000b0022a3a88d9e6mr8183471wrs.438.1663503461619; 
 Sun, 18 Sep 2022 05:17:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6OgKAiHsRIMsNcvcQlSELq9pAaD49wvj8xve/5Xz8Q2YgoqvtA0Jk9oZfbBvYoMf3nUdnFOQ==
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id
 o2-20020a5d4742000000b0022a3a88d9e6mr8183456wrs.438.1663503461375; 
 Sun, 18 Sep 2022 05:17:41 -0700 (PDT)
Received: from redhat.com ([2.52.4.6]) by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c354700b003b4cba4ef71sm4421682wmq.41.2022.09.18.05.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Sep 2022 05:17:40 -0700 (PDT)
Date: Sun, 18 Sep 2022 08:17:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Junbo <junbo4242@gmail.com>
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220918081713-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
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

T24gU3VuLCBTZXAgMTgsIDIwMjIgYXQgMDU6MDA6MjBQTSArMDgwMCwgSnVuYm8gd3JvdGU6Cj4g
aGnCoE1pY2hhZWwKPiAKPiBpbiB2aXJ0aW8tbmV0LmMKPiDCoCDCoCAvKiBQYXJhbWV0ZXJzIGZv
ciBjb250cm9sIHZpcnRxdWV1ZSwgaWYgYW55ICovCj4gwqAgwqAgaWYgKHZpLT5oYXNfY3ZxKSB7
Cj4gwqAgwqAgwqAgwqAgY2FsbGJhY2tzW3RvdGFsX3ZxcyAtIDFdID0gTlVMTDsKPiDCoCDCoCDC
oCDCoCBuYW1lc1t0b3RhbF92cXMgLSAxXSA9ICJjb250cm9sIjsKPiDCoCDCoCB9Cj4gCj4gSSB0
aGluayB0aGUgQXV0aG9yIHdobyB3cml0ZSB0aGUgY29kZQoKd2FpdCwgdGhhdCB3YXMgbm90IHlv
dT8KCj4gbWF5YmUgd2FudCB0byBuYW1lIHRoZSBjb250cm9sIHF1ZXVlIHRvCj4gJ3ZpcnRpb1gt
Y29udHJvbCcsIGJ1dCBpdCBuZXZlciB3b3JrZWQsIHdlIGNhbiBzZWUgdGhlIG5hbWUgc3RpbGwg
YmUKPiAndmlydGlvWC1jb25maWcnIGluIC9wcm9jL2ludGVycnVwdHMsIGZvciBleGFtcGxlwqAK
PiDCoDQzOiDCoCDCoCDCoCDCoCDCoDAgwqAgwqAgwqAgwqAgwqAwIMKgIMKgIMKgIMKgIMKgMCDC
oCDCoCDCoCDCoCDCoDAgwqAgwqAgwqAgwqAgwqAwIMKgIMKgIMKgIMKgIMKgMCDCoCDCoCDCoCDC
oAo+IMKgMCDCoCDCoCDCoCDCoCDCoDAgwqAgUENJLU1TSS1lZGdlIMKgIMKgIMKgdmlydGlvMC1j
b25maWcKPiDCoDQ0OiDCoCDCoCDCoCDCoCA2NCDCoCDCoCDCoCDCoCDCoDAgwqAgwqAgwqAgwqAg
wqAwIMKgIMKgIMKgIMKgIMKgMCDCoCDCoCDCoCDCoCDCoDAgwqAgwqAgwqAgwqAgwqAwIMKgIMKg
IMKgCj4gMTg0NSDCoCDCoCDCoCDCoCDCoDAgwqAgUENJLU1TSS1lZGdlIMKgIMKgIMKgdmlydGlv
MC1pbnB1dC4wCj4gwqA0NTogwqAgwqAgwqAgwqAgwqAxIMKgIMKgIMKgIMKgIMKgMCDCoCDCoCDC
oCDCoCDCoDAgwqAgwqAgwqAgwqAgwqAwIMKgIMKgIMKgIMKgIMKgMCDCoCDCoCDCoCDCoCDCoDAg
wqAgwqAgwqAgwqAKPiDCoDAgwqAgwqAgwqAgwqAgwqAwIMKgIFBDSS1NU0ktZWRnZSDCoCDCoCDC
oHZpcnRpbzAtb3V0cHV0LjAKPiAKPiBCZWNhdXNlIGluIGZ1bmN0aW9uwqB2cF9yZXF1ZXN0X21z
aXhfdmVjdG9ycywgaXQganVzdCBhbGxvY2F0ZSAneHh4eC1jb25maWcnIHRvCj4gZXZlcnkgdmly
dGlvIGRldmljZXMsIGV2ZW4gdGhlIHZpcnRpbyBkZXZpY2UgZG8gbm90IG5lZWQgaXQuIGluIC9w
cm9jLwo+IGludGVycnVwdHMsIHdlIGNhbiBzZWUgdGhhdCBlYWNoIHZpcnRpbyBkZXZpY2UncyBm
aXJzdCBpbnRlcnJ1cHQgYWx3YXlzIG5hbWVkCj4gJ3ZpcnRpb1gtY29uZmlnJy4KPiAKPiBTbyBJ
IHRoaW5rIGl0J3MgYmV0dGVyIHRvIG5vdCBleHBsaWNpdGx5IGdpdmUgdGhlICJjb250cm9sIiBo
ZXJlLCBpdCdzCj4gdXNlbGVzcy4uLsKgwqAKPiAKPiAKPiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiDkuo4yMDIy5bm0OeaciDE45pel5ZGo5pelIDE0OjU25YaZ6YGT77yaCj4g
Cj4gICAgIE9uIFNhdCwgU2VwIDE3LCAyMDIyIGF0IDA5OjI4OjU3QU0gKzAwMDAsIGp1bmJvNDI0
MkBnbWFpbC5jb20gd3JvdGU6Cj4gICAgID4gRnJvbTogSnVuYm8gPGp1bmJvNDI0MkBnbWFpbC5j
b20+Cj4gICAgID4KPiAgICAgPiBJbiB2aXJ0aW8gZHJpdmVycywgdGhlIGNvbnRyb2wgcXVldWUg
YWx3YXlzIG5hbWVkIDx2aXJ0aW9YPi1jb25maWcuCj4gICAgID4KPiAgICAgPiBTaWduZWQtb2Zm
LWJ5OiBKdW5ibyA8anVuYm80MjQyQGdtYWlsLmNvbT4KPiAKPiAgICAgSSBkb24ndCB0aGluayB0
aGF0J3MgcmlnaHQuIGNvbmZpZyBpcyB0aGUgY29uZmlnIGludGVycnVwdC4KPiAKPiAKPiAKPiAg
ICAgPiAtLS0KPiAgICAgPsKgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDMgKystCj4gICAg
ID7CoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gICAg
ID4KPiAgICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gICAgID4gaW5kZXggOWNjZTdkZWM3MzY2Li4wYjNlNzRjZmUy
MDEgMTAwNjQ0Cj4gICAgID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gICAgID4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gICAgID4gQEAgLTM0NjksNyArMzQ2OSw4
IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9maW5kX3ZxcyhzdHJ1Y3QgdmlydG5ldF9pbmZvCj4gICAg
ICp2aSkKPiAgICAgPsKgIMKgIMKgIMKgLyogUGFyYW1ldGVycyBmb3IgY29udHJvbCB2aXJ0cXVl
dWUsIGlmIGFueSAqLwo+ICAgICA+wqAgwqAgwqAgwqBpZiAodmktPmhhc19jdnEpIHsKPiAgICAg
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FsbGJhY2tzW3RvdGFsX3ZxcyAtIDFdID0gTlVMTDsK
PiAgICAgPiAtwqAgwqAgwqAgwqAgwqAgwqAgwqBuYW1lc1t0b3RhbF92cXMgLSAxXSA9ICJjb250
cm9sIjsKPiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBjb250cm9sIHZpcnRxdWV1ZSBh
bHdheXMgbmFtZWQgPHZpcnRpb1g+LWNvbmZpZyAqLwo+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoG5hbWVzW3RvdGFsX3ZxcyAtIDFdID0gIiI7Cj4gICAgID7CoCDCoCDCoCDCoH0KPiAgICAg
PsKgCj4gICAgID7CoCDCoCDCoCDCoC8qIEFsbG9jYXRlL2luaXRpYWxpemUgcGFyYW1ldGVycyBm
b3Igc2VuZC9yZWNlaXZlIHZpcnRxdWV1ZXMgKi8KPiAgICAgPiAtLQo+ICAgICA+IDIuMzEuMQo+
IAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
