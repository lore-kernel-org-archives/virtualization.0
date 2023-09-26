Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CAAE81810
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 03:29:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D03DE41768;
	Tue, 26 Sep 2023 03:29:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D03DE41768
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fjvsoa+M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uXzserpitul0; Tue, 26 Sep 2023 03:29:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2845041761;
	Tue, 26 Sep 2023 03:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2845041761
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1929C0039;
	Tue, 26 Sep 2023 03:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72420C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3958D82237
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:29:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3958D82237
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fjvsoa+M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhlvMFIDgmu0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:29:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 582D58220B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 03:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 582D58220B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695698940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZAhx7MFdkeBmGFe31AVlV3iO2EqSJG4TtChPwC6CuI=;
 b=fjvsoa+Ml4dQ2qD5gm5vNJh4QTZwkottC8QT0OqUOWq7CjMUDkmizKLRSg0s2b3RdpdRYw
 Kgvj/ynQabRYCs87LoeqwphVAg/IkW8n68LhgYjloYlidLUnV2OYxy0diDHoJ1nWV2op26
 sK8L+FEGvfE7lnqH01DPSIGwUJnsp1A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-BQ1JqGeCPX6eEJ7ef52m1w-1; Mon, 25 Sep 2023 23:28:58 -0400
X-MC-Unique: BQ1JqGeCPX6eEJ7ef52m1w-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503c774fd61so10575873e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 20:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695698937; x=1696303737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZAhx7MFdkeBmGFe31AVlV3iO2EqSJG4TtChPwC6CuI=;
 b=Zft6fOVAFa6o9jHts96C/rqo25kThGPyDxPIEpK2xp4sDM9+19Waq9QQcMdLgb5fQu
 qj2d1oHvEZ3HOu31gtRw3pX6xxT+YDhaMZH5bk/4X8jNP3oxgTsBkhy8AyJ03NhL6YQC
 irvcVgc+5lAZIZeoRl8JGQkA41BTviaF2BJww1pJp6IseKsW/EZXyS8zijQNHQXVqAyA
 mOfidWUUotbNs0f3iqYNIq7LbFFZVgrOL4CawTE1uVOuF0QHmoWwtUNjagkUItTHwTvi
 9qSQ5liBDhRBGRw/WGehTqgvitHc+9xxO40uNWuvCqrhaW1HrCsDjwDvbfwUyf9OQX06
 aYXA==
X-Gm-Message-State: AOJu0YyRpd+inemPq77O3FCL+dAcmXAfVPGrhSd8UHGibhKuJC1l2yWG
 l1QnC/bY1hK3XxfUqRJQz60Bf7Inl7kn/XXVoSz62DMb+r/IXsYDI8KlwvltlbE31wFajvjeDXe
 tpGrwZVWGDdgJ+GgFOIj2zFekIZ/Br2N8/D1uBR+F2DaEMbUpWO93jT7RHQ==
X-Received: by 2002:a05:6512:401a:b0:503:2e6:685e with SMTP id
 br26-20020a056512401a00b0050302e6685emr9229178lfb.14.1695698937284; 
 Mon, 25 Sep 2023 20:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWGjNYL9Nj97phWZA57NV0UhAnICMO0Ky6EU5to4ByQxb437UN1JumpShCANeB1L+1wbau4bm3GnFKZtgx7X8=
X-Received: by 2002:a05:6512:401a:b0:503:2e6:685e with SMTP id
 br26-20020a056512401a00b0050302e6685emr9229170lfb.14.1695698936966; Mon, 25
 Sep 2023 20:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-6-dtatulea@nvidia.com>
In-Reply-To: <20230912130132.561193-6-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 11:28:45 +0800
Message-ID: <CACGkMEuB93-gmyCrfeubT5p-i-4M96UmkDJbuDMCAu5LXSyitA@mail.gmail.com>
Subject: Re: [PATCH 05/16] vdpa/mlx5: Decouple cvq iotlb handling from hw
 mapping code
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgOTowMuKAr1BNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPiB3cm90ZToKPgo+IFRoZSBoYW5kbGluZyBvZiB0aGUgY3ZxIGlvdGxiIGlz
IGN1cnJlbnRseSBjb3VwbGVkIHdpdGggdGhlIGNyZWF0aW9uCj4gYW5kIGRlc3RydWN0aW9uIG9m
IHRoZSBoYXJkd2FyZSBta2V5cyAobXIpLgo+Cj4gVGhpcyBwYXRjaCBtb3ZlcyBjdnEgaW90bGIg
aGFuZGxpbmcgaW50byBpdHMgb3duIGZ1bmN0aW9uIGFuZCBzaGlmdHMgaXQKPiB0byBhIHNjb3Bl
IHRoYXQgaXMgbm90IHJlbGF0ZWQgdG8gbXIgaGFuZGxpbmcuIEFzIGN2cSBoYW5kbGluZyBpcyBq
dXN0IGEKPiBwcnVuZV9pb3RsYiArIGR1cF9pb3RsYiBjeWNsZSwgcHV0IGl0IGFsbCBpbiB0aGUg
c2FtZSAidXBkYXRlIiBmdW5jdGlvbi4KPiBGaW5hbGx5LCB0aGUgZGVzdHJ1Y3Rpb24gcGF0aCBp
cyBoYW5kbGVkIGJ5IGRpcmVjdGx5IHBydW5pbmcgdGhlIGlvdGxiLgo+Cj4gQWZ0ZXIgdGhpcyBt
b3ZlIGlzIGRvbmUgdGhlIEFTSUQgbXIgY29kZSBjYW4gYmUgY29sbGFwc2VkIGludG8gYSBzaW5n
bGUKPiBmdW5jdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxl
YUBudmlkaWEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5o
IHwgIDMgKysKPiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8IDU3ICsrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgIHwgIDcgKystLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDM5
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4
NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gaW5kZXggMzc0
OGYwMjdjZmU5Li41NTQ4OTlhODAyNDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBh
LmgKPiBAQCAtMTIwLDYgKzEyMCw5IEBAIGludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPiAgICAgICAg
ICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4gIHZvaWQgbWx4NV92ZHBhX2Rl
c3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KTsKPiAgdm9pZCBtbHg1X3ZkcGFf
ZGVzdHJveV9tcl9hc2lkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50
IGFzaWQpOwo+ICtpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X2lvdGxiICppb3RsYiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGludCBhc2lkKTsKPiAgaW50IG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldik7Cj4KPiAgI2RlZmluZSBtbHg1X3ZkcGFfd2FybihfX2RldiwgZm9y
bWF0LCAuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiBpbmRleCA3YmQwODgzYjhiMjUuLmZjYjZhZTMy
ZTllZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiArKysgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPiBAQCAtNDg5LDE0ICs0ODksNiBAQCBzdGF0aWMg
dm9pZCBkZXN0cm95X3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qg
bWx4NV92ZHBhX21yICptcgo+ICAgICAgICAgfQo+ICB9Cj4KPiAtc3RhdGljIHZvaWQgX21seDVf
dmRwYV9kZXN0cm95X2N2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVk
IGludCBhc2lkKQo+IC17Cj4gLSAgICAgICBpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBB
X0NWUV9HUk9VUF0gIT0gYXNpZCkKPiAtICAgICAgICAgICAgICAgcmV0dXJuOwo+IC0KPiAtICAg
ICAgIHBydW5lX2lvdGxiKG12ZGV2KTsKPiAtfQo+IC0KPiAgc3RhdGljIHZvaWQgX21seDVfdmRw
YV9kZXN0cm95X2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGlu
dCBhc2lkKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+
bXI7Cj4gQEAgLTUyMiwyNSArNTE0LDE0IEBAIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNp
ZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+ICAgICAg
ICAgbXV0ZXhfbG9jaygmbXItPm1rZXlfbXR4KTsKPgo+ICAgICAgICAgX21seDVfdmRwYV9kZXN0
cm95X2R2cV9tcihtdmRldiwgYXNpZCk7Cj4gLSAgICAgICBfbWx4NV92ZHBhX2Rlc3Ryb3lfY3Zx
X21yKG12ZGV2LCBhc2lkKTsKPgo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtci0+bWtleV9tdHgp
Owo+ICB9Cj4KPiAgdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYpCj4gIHsKPiAtICAgICAgIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQobXZkZXYs
IG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdKTsKPiAgICAgICAgIG1seDVf
dmRwYV9kZXN0cm95X21yX2FzaWQobXZkZXYsIG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9E
QVRBVlFfR1JPVVBdKTsKPiAtfQo+IC0KPiAtc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9j
dnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFzaWQpCj4gLXsKPiAtICAgICAg
IGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBhc2lkKQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gMDsKPiAtCj4gLSAgICAgICByZXR1cm4gZHVwX2lvdGxiKG12
ZGV2LCBpb3RsYik7Cj4gKyAgICAgICBwcnVuZV9pb3RsYihtdmRldik7Cj4gIH0KPgo+ICBzdGF0
aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsCj4gQEAgLTU3MiwyMiArNTUzLDcgQEAgc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9k
dnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+ICBzdGF0aWMgaW50IF9tbHg1X3Zk
cGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsIHVuc2lnbmVkIGlu
dCBhc2lkKQo+ICB7Cj4gLSAgICAgICBpbnQgZXJyOwo+IC0KPiAtICAgICAgIGVyciA9IF9tbHg1
X3ZkcGFfY3JlYXRlX2R2cV9tcihtdmRldiwgaW90bGIsIGFzaWQpOwo+IC0gICAgICAgaWYgKGVy
cikKPiAtICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPiAtCj4gLSAgICAgICBlcnIgPSBfbWx4
NV92ZHBhX2NyZWF0ZV9jdnFfbXIobXZkZXYsIGlvdGxiLCBhc2lkKTsKPiAtICAgICAgIGlmIChl
cnIpCj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0X2VycjsKPiAtCj4gLSAgICAgICByZXR1cm4g
MDsKPiAtCj4gLW91dF9lcnI6Cj4gLSAgICAgICBfbWx4NV92ZHBhX2Rlc3Ryb3lfZHZxX21yKG12
ZGV2LCBhc2lkKTsKPiAtCj4gLSAgICAgICByZXR1cm4gZXJyOwo+ICsgICAgICAgcmV0dXJuIF9t
bHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihtdmRldiwgaW90bGIsIGFzaWQpOwo+ICB9Cj4KPiAgaW50
IG1seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qg
dmhvc3RfaW90bGIgKmlvdGxiLAo+IEBAIC02MjAsNyArNTg2LDI0IEBAIGludCBtbHg1X3ZkcGFf
aGFuZGxlX3NldF9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3Rf
aW90bGIgKmlvCj4gICAgICAgICByZXR1cm4gZXJyOwo+ICB9Cj4KPiAraW50IG1seDVfdmRwYV91
cGRhdGVfY3ZxX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCkKPiArewo+ICsgICAg
ICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdICE9IGFzaWQpCj4g
KyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsKPiArICAgICAgIHBydW5lX2lvdGxiKG12ZGV2
KTsKPiArICAgICAgIHJldHVybiBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKPiArfQo+ICsKPiAg
aW50IG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikK
PiAgewo+IC0gICAgICAgcmV0dXJuIG1seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIE5VTEwsIDAp
Owo+ICsgICAgICAgaW50IGVycjsKPiArCj4gKyAgICAgICBlcnIgPSBtbHg1X3ZkcGFfY3JlYXRl
X21yKG12ZGV2LCBOVUxMLCAwKTsKPiArICAgICAgIGlmIChlcnIpCj4gKyAgICAgICAgICAgICAg
IHJldHVybiBlcnI7Cj4gKwo+ICsgICAgICAgcmV0dXJuIG1seDVfdmRwYV91cGRhdGVfY3ZxX2lv
dGxiKG12ZGV2LCBOVUxMLCAwKTsKPiAgfQoKTml0OiBTdGlsbCBhIGxpdHRsZSBiaXQgY291cGxp
bmcgYnV0IGFueWhvdzoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKVGhhbmtzCgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCBkMzRjMTliNGUx
MzkuLjA2MWQ4ZjdhNjYxYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAt
Mjg4NCwxMCArMjg4NCwxMyBAQCBzdGF0aWMgaW50IHNldF9tYXBfZGF0YShzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4gICAgICAgICAgICAg
ICAgIHJldHVybiBlcnI7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIGlmIChjaGFuZ2VfbWFwKQo+
ICsgICAgICAgaWYgKGNoYW5nZV9tYXApIHsKPiAgICAgICAgICAgICAgICAgZXJyID0gbWx4NV92
ZHBhX2NoYW5nZV9tYXAobXZkZXYsIGlvdGxiLCBhc2lkKTsKPiArICAgICAgICAgICAgICAgaWYg
KGVycikKPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+ICsgICAgICAgfQo+
Cj4gLSAgICAgICByZXR1cm4gZXJyOwo+ICsgICAgICAgcmV0dXJuIG1seDVfdmRwYV91cGRhdGVf
Y3ZxX2lvdGxiKG12ZGV2LCBpb3RsYiwgYXNpZCk7Cj4gIH0KPgo+ICBzdGF0aWMgaW50IG1seDVf
dmRwYV9zZXRfbWFwKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFzaWQs
Cj4gLS0KPiAyLjQxLjAKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
