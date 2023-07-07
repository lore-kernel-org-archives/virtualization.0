Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F859EB64D9
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 07:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B7722405F6;
	Fri,  7 Jul 2023 07:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7722405F6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LW5BV6vy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0VbNHlx0nGK; Fri,  7 Jul 2023 07:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1919040167;
	Fri,  7 Jul 2023 07:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1919040167
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5176C0072;
	Fri,  7 Jul 2023 07:33:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF9AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DE64605A6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DE64605A6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LW5BV6vy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJdl7TKLthWd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76EC360594
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76EC360594
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688715201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBBSIXu/59mCKHbbL4NSJH2aQXfaKqVLtFEbdlv5kp4=;
 b=LW5BV6vyqsd62xu1x44wcpc1dR6ZYAu7vDu+wcKpr9+xC/cV5f9oSb8cSXE200Gp8L7qd5
 WZ47AZb6bJ7cB1yPP2/De/CpE4YSoCP6afiACsFwO/FY0nbDY0SbZpo8ZAmnxJFLqqHdoe
 oumZLUoxSOU3hToJBDuVSa3lug+6kQI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-hqneMcEKOSigbmFe4AA62A-1; Fri, 07 Jul 2023 03:33:19 -0400
X-MC-Unique: hqneMcEKOSigbmFe4AA62A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6f0527454so15958251fa.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jul 2023 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688715198; x=1691307198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBBSIXu/59mCKHbbL4NSJH2aQXfaKqVLtFEbdlv5kp4=;
 b=U0H/VCjuoLsckDx+Xvd9HfkaP9dDN05Gy87+2BZy03CFDnHzSJXzuPjn+EwaWkXksN
 EEPxKDbYGllOxMFTv6ihLFSACMVGzRCYO4SEsZoEGSTG/pprN5vsQmLKLSn9mFEFor26
 OXpc5BdpmQN5pvU5/2PH/yUQrliYH29PzaEI5kMCNd6SmQE1I9q3AXdjouxHwfaKGhz3
 NE9KQj3pDCUG1qQaPOflK6EItH40+xOA06FtR2SA7NWE/nvLY1UXgzD7I68tquymUaRO
 +1GSTCC9oyo0Tp6wXYd0b3xOs7OvUG5LN+05uWYt8UwSX6UmeGGsWDejkEMvb7UiR4mO
 3NZg==
X-Gm-Message-State: ABy/qLY2IUVRziz3VWbs7bkqxxdUSnvYzAZj69v3oOW8pLWxag/LmKxM
 aJG0mlnMsbR8E0mtyFlE7agKhE/tsRbn3Cp14AMmAvXeWhFSUvCcKw1LRMpaT098ALoJJ8/6GKO
 MiVEKaR2Z19meQ4J+NGmlhtMQR55QgRH9/LLtdlIBxApU18K3KcXPmSAGKw==
X-Received: by 2002:a2e:9dd5:0:b0:2b6:f8d0:7d3d with SMTP id
 x21-20020a2e9dd5000000b002b6f8d07d3dmr2923030ljj.49.1688715198288; 
 Fri, 07 Jul 2023 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFc7+bDcK9CkHA3vwuGskq3KTXhAS0ZYBULb6dWTJWaOzgypugPYLY4/k0fkoqOomqoBd5x0bMGXnSIa4BDfiY=
X-Received: by 2002:a2e:9dd5:0:b0:2b6:f8d0:7d3d with SMTP id
 x21-20020a2e9dd5000000b002b6f8d07d3dmr2923012ljj.49.1688715197962; Fri, 07
 Jul 2023 00:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-2-shannon.nelson@amd.com>
In-Reply-To: <20230630003609.28527-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:33:07 +0800
Message-ID: <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, Allen Hubbe <allen.hubbe@amd.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gRnJpLCBKdW4gMzAsIDIwMjMgYXQgODozNuKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IEZyb206IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJi
ZUBhbWQuY29tPgo+Cj4gV2hlbiB0aGUgdmRwYSBkZXZpY2UgaXMgcmVzZXQsIGFsc28gcmVpbml0
aWFsaXplIGl0IHdpdGggdGhlIG1hYyBhZGRyZXNzCj4gdGhhdCB3YXMgYXNzaWduZWQgd2hlbiB0
aGUgZGV2aWNlIHdhcyBhZGRlZC4KPgo+IEZpeGVzOiAxNTFjYzgzNGYzZGQgKCJwZHNfdmRwYTog
YWRkIHN1cHBvcnQgZm9yIHZkcGEgYW5kIHZkcGFtZ210IGludGVyZmFjZXMiKQo+IFNpZ25lZC1v
ZmYtYnk6IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJiZUBhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBC
cmV0dCBDcmVlbGV5IDxicmV0dC5jcmVlbGV5QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRw
YS9wZHMvdmRwYV9kZXYuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0KPiAgZHJpdmVycy92ZHBhL3Bk
cy92ZHBhX2Rldi5oIHwgIDEgKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2
LmMgYi9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiBpbmRleCA1MDcxYTRkNThmOGQuLmUy
ZTk5YmIwYmUyYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiAr
KysgYi9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiBAQCAtNDA5LDYgKzQwOSw4IEBAIHN0
YXRpYyB2b2lkIHBkc192ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2Rl
diwgdTggc3RhdHVzKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHBkc3YtPnZxc1tpXS5hdmFp
bF9pZHggPSAwOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIHBkc3YtPnZxc1tpXS51c2VkX2lk
eCA9IDA7Cj4gICAgICAgICAgICAgICAgIH0KPiArCj4gKyAgICAgICAgICAgICAgIHBkc192ZHBh
X2NtZF9zZXRfbWFjKHBkc3YsIHBkc3YtPm1hYyk7CgpTbyB0aGlzIGlzIG5vdCBuZWNlc3Nhcmls
eSBjYWxsZWQgZHVyaW5nIHJlc2V0LiBTbyBJIHRoaW5rIHdlIG5lZWQgdG8KbW92ZSBpdCB0byBw
ZHNfdmRwYV9yZXNldCgpPwoKVGhlIHJlc3QgbG9va3MgZ29vZC4KClRoYW5rcwoKPiAgICAgICAg
IH0KPgo+ICAgICAgICAgaWYgKHN0YXR1cyAmIH5vbGRfc3RhdHVzICYgVklSVElPX0NPTkZJR19T
X0ZFQVRVUkVTX09LKSB7Cj4gQEAgLTUzMiw3ICs1MzQsNiBAQCBzdGF0aWMgaW50IHBkc192ZHBh
X2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4g
ICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkbWFfZGV2Owo+ICAgICAgICAgc3RydWN0IHBjaV9kZXYg
KnBkZXY7Cj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7Cj4gLSAgICAgICB1OCBtYWNbRVRI
X0FMRU5dOwo+ICAgICAgICAgaW50IGVycjsKPiAgICAgICAgIGludCBpOwo+Cj4gQEAgLTYxNywx
OSArNjE4LDE4IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210
X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAgICAgICAqIG9yIHNldCBhIHJhbmRv
bSBtYWMgaWYgZGVmYXVsdCBpcyAwMDouLjowMAo+ICAgICAgICAgICovCj4gICAgICAgICBpZiAo
YWRkX2NvbmZpZy0+bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIp
KSB7Cj4gLSAgICAgICAgICAgICAgIGV0aGVyX2FkZHJfY29weShtYWMsIGFkZF9jb25maWctPm5l
dC5tYWMpOwo+IC0gICAgICAgICAgICAgICBwZHNfdmRwYV9jbWRfc2V0X21hYyhwZHN2LCBtYWMp
Owo+ICsgICAgICAgICAgICAgICBldGhlcl9hZGRyX2NvcHkocGRzdi0+bWFjLCBhZGRfY29uZmln
LT5uZXQubWFjKTsKPiAgICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAgICAgICAgIHN0cnVjdCB2
aXJ0aW9fbmV0X2NvbmZpZyBfX2lvbWVtICp2YzsKPgo+ICAgICAgICAgICAgICAgICB2YyA9IHBk
c3YtPnZkcGFfYXV4LT52ZF9tZGV2LmRldmljZTsKPiAtICAgICAgICAgICAgICAgbWVtY3B5X2Zy
b21pbyhtYWMsIHZjLT5tYWMsIHNpemVvZihtYWMpKTsKPiAtICAgICAgICAgICAgICAgaWYgKGlz
X3plcm9fZXRoZXJfYWRkcihtYWMpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZXRoX3Jh
bmRvbV9hZGRyKG1hYyk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAi
c2V0dGluZyByYW5kb20gbWFjICVwTVxuIiwgbWFjKTsKPiAtICAgICAgICAgICAgICAgICAgICAg
ICBwZHNfdmRwYV9jbWRfc2V0X21hYyhwZHN2LCBtYWMpOwo+ICsgICAgICAgICAgICAgICBtZW1j
cHlfZnJvbWlvKHBkc3YtPm1hYywgdmMtPm1hYywgc2l6ZW9mKHBkc3YtPm1hYykpOwo+ICsgICAg
ICAgICAgICAgICBpZiAoaXNfemVyb19ldGhlcl9hZGRyKHBkc3YtPm1hYykpIHsKPiArICAgICAg
ICAgICAgICAgICAgICAgICBldGhfcmFuZG9tX2FkZHIocGRzdi0+bWFjKTsKPiArICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJzZXR0aW5nIHJhbmRvbSBtYWMgJXBNXG4iLCBw
ZHN2LT5tYWMpOwo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4gKyAgICAgICBwZHNf
dmRwYV9jbWRfc2V0X21hYyhwZHN2LCBwZHN2LT5tYWMpOwo+Cj4gICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgcGRzdi0+bnVtX3ZxczsgaSsrKSB7Cj4gICAgICAgICAgICAgICAgIHBkc3YtPnZxc1tp
XS5xaWQgPSBpOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggYi9k
cml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPiBpbmRleCBhMWJjMzdkZTk1MzcuLmNmMDJkZjI4
N2ZjNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPiArKysgYi9k
cml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPiBAQCAtMzksNiArMzksNyBAQCBzdHJ1Y3QgcGRz
X3ZkcGFfZGV2aWNlIHsKPiAgICAgICAgIHU2NCByZXFfZmVhdHVyZXM7ICAgICAgICAgICAgICAg
LyogZmVhdHVyZXMgcmVxdWVzdGVkIGJ5IHZkcGEgKi8KPiAgICAgICAgIHU4IHZkcGFfaW5kZXg7
ICAgICAgICAgICAgICAgICAgLyogcnN2ZCBmb3IgZnV0dXJlIHN1YmRldmljZSB1c2UgKi8KPiAg
ICAgICAgIHU4IG51bV92cXM7ICAgICAgICAgICAgICAgICAgICAgLyogbnVtIHZxcyBpbiB1c2Ug
Ki8KPiArICAgICAgIHU4IG1hY1tFVEhfQUxFTl07ICAgICAgICAgICAgICAgLyogbWFjIHNlbGVj
dGVkIHdoZW4gdGhlIGRldmljZSB3YXMgYWRkZWQgKi8KPiAgICAgICAgIHN0cnVjdCB2ZHBhX2Nh
bGxiYWNrIGNvbmZpZ19jYjsKPiAgICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsKPiAg
fTsKPiAtLQo+IDIuMTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
