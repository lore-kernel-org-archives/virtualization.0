Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C53C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 08:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48EB060E2E;
	Wed, 13 Apr 2022 08:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gr3UwnipcqDO; Wed, 13 Apr 2022 08:00:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B26C260F33;
	Wed, 13 Apr 2022 08:00:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87A73C0033;
	Wed, 13 Apr 2022 08:00:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E34E1C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC570410BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YD05NCCttTxd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:00:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C28640A05
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649836833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BK0xGHuGKSg6tS7OvJ2UZVDC8hGmPnNquXolsiCRFqU=;
 b=RqfjP+4ChLNbIpRaLldlNfQEOQ1SlwSMv4gWN6qdZCZL33/dgDvpNYDyzvT74+xATND5nL
 1WAY7itK6IQ+HgAv/tToGC7wdyptNvvH5zxpQHyT5URmZJ8hFtC8nX5O+9SMcg3Re4WKDc
 PooPRPwtJVx6D+eS8Mo3IoqRNIS5Idk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-8SAxfQ6wOxem2v7Lr2faog-1; Wed, 13 Apr 2022 04:00:32 -0400
X-MC-Unique: 8SAxfQ6wOxem2v7Lr2faog-1
Received: by mail-pl1-f200.google.com with SMTP id
 x10-20020a170902ec8a00b001585af19391so818722plg.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 01:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BK0xGHuGKSg6tS7OvJ2UZVDC8hGmPnNquXolsiCRFqU=;
 b=GPd6Wc/GVSucU5X1dh3/4hLQXfvcGtgbKzMPo5GyWk1tlYvU1HOo51Ii6Rm5qFgIGF
 29EYF1HToO/RePTm5UBpEHkRuAsJkfc+WnjVi3iMRofCbBbkPtF+TB37cXfRdy97tEfr
 Mfs7lNmLFeXTmbeEH668oTpUqB4HfiuF2vP3aCIFjH8kkcbPJ3Hawn5GGAn1u5EI4PcR
 DWT5deGMjYAZnO6Gwdv7Kj12GjZudiLZzHhaVkOr2v+EEranhgPC9BLq/lFS7GkAkGvS
 nepkiBbSgXULuZnS0ftIhOjsXimuKxOsR534cvxg8ngvYlDD3HB32CsyObszq6RL9244
 u9mA==
X-Gm-Message-State: AOAM5328Myah7J/t5Z1vhVjcZwn4z1zCCXjaU5m9EBwmZ9i5YukF4z0X
 5KOPkL8eO23s1sU2G/+wW7Q283VlyvhV4Sf+FtCco8cYN0VqeKkDSAY9+Hpfq5TgKysUwPDU/Yu
 fYCL+tAKG8X/lovoKIDw1NCWtUcXTPH4bYK/QMFaIZg==
X-Received: by 2002:a63:885:0:b0:39d:2197:2dcf with SMTP id
 127-20020a630885000000b0039d21972dcfmr16534604pgi.300.1649836831066; 
 Wed, 13 Apr 2022 01:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxYX/5hHC47/+wODyw6SuCX6q43fRwhhJkty2IwP5vjbtPmYxOh8zOxYYGS8lSmQrVc9+uNA==
X-Received: by 2002:a63:885:0:b0:39d:2197:2dcf with SMTP id
 127-20020a630885000000b0039d21972dcfmr16534566pgi.300.1649836830786; 
 Wed, 13 Apr 2022 01:00:30 -0700 (PDT)
Received: from [10.72.13.223] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a056a00150600b004fb2d266f97sm43184355pfu.115.2022.04.13.01.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 01:00:30 -0700 (PDT)
Message-ID: <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
Date: Wed, 13 Apr 2022 16:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 31/32] virtio_net: support rx/tx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzQvNiDkuIrljYgxMTo0MywgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGlzIHBhdGNo
IGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBvZiB0aGUgcngsIHR4IHF1ZXVlcy4KPiBC
YXNlZCBvbiB0aGlzIGZ1bmN0aW9uLCBpdCBpcyBwb3NzaWJsZSB0byBtb2RpZnkgdGhlIHJpbmcg
bnVtIG9mIHRoZQo+IHF1ZXVlLgo+Cj4gVGhlcmUgbWF5IGJlIGFuIGV4Y2VwdGlvbiBkdXJpbmcg
dGhlIHJlc2l6ZSBwcm9jZXNzLCB0aGUgcmVzaXplIG1heQo+IGZhaWwsIG9yIHRoZSB2cSBjYW4g
bm8gbG9uZ2VyIGJlIHVzZWQuIEVpdGhlciB3YXksIHdlIG11c3QgZXhlY3V0ZQo+IG5hcGlfZW5h
YmxlKCkuIEJlY2F1c2UgbmFwaV9kaXNhYmxlIGlzIHNpbWlsYXIgdG8gYSBsb2NrLCBuYXBpX2Vu
YWJsZQo+IG11c3QgYmUgY2FsbGVkIGFmdGVyIGNhbGxpbmcgbmFwaV9kaXNhYmxlLgo+Cj4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDgxICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gaW5kZXggYjhiZjAwNTI1MTc3Li5iYTY4NTlmMzA1ZjcgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gQEAgLTI1MSw2ICsyNTEsOSBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiAgIAlj
aGFyIHBhZGRpbmdbNF07Cj4gICB9Owo+ICAgCj4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJl
ZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ICtzdGF0aWMg
dm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9p
ZCAqYnVmKTsKPiArCj4gICBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRyKQo+ICAg
ewo+ICAgCXJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gQEAg
LTEzNjksNiArMTM3MiwxNSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X25hcGlfZW5hYmxlKHN0cnVj
dCB2aXJ0cXVldWUgKnZxLCBzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGkpCj4gICB7Cj4gICAJbmFw
aV9lbmFibGUobmFwaSk7Cj4gICAKPiArCS8qIENoZWNrIGlmIHZxIGlzIGluIHJlc2V0IHN0YXRl
LiBUaGUgbm9ybWFsIHJlc2V0L3Jlc2l6ZSBwcm9jZXNzIHdpbGwKPiArCSAqIGJlIHByb3RlY3Rl
ZCBieSBuYXBpLiBIb3dldmVyLCB0aGUgcHJvdGVjdGlvbiBvZiBuYXBpIGlzIG9ubHkgZW5hYmxl
ZAo+ICsJICogZHVyaW5nIHRoZSBvcGVyYXRpb24sIGFuZCB0aGUgcHJvdGVjdGlvbiBvZiBuYXBp
IHdpbGwgZW5kIGFmdGVyIHRoZQo+ICsJICogb3BlcmF0aW9uIGlzIGNvbXBsZXRlZC4gSWYgcmUt
ZW5hYmxlIGZhaWxzIGR1cmluZyB0aGUgcHJvY2VzcywgdnEKPiArCSAqIHdpbGwgcmVtYWluIHVu
YXZhaWxhYmxlIHdpdGggcmVzZXQgc3RhdGUuCj4gKwkgKi8KPiArCWlmICh2cS0+cmVzZXQpCj4g
KwkJcmV0dXJuOwoKCkkgZG9uJ3QgZ2V0IHdoZW4gY291bGQgd2UgaGl0IHRoaXMgY29uZGl0aW9u
LgoKCj4gKwo+ICAgCS8qIElmIGFsbCBidWZmZXJzIHdlcmUgZmlsbGVkIGJ5IG90aGVyIHNpZGUg
YmVmb3JlIHdlIG5hcGlfZW5hYmxlZCwgd2UKPiAgIAkgKiB3b24ndCBnZXQgYW5vdGhlciBpbnRl
cnJ1cHQsIHNvIHByb2Nlc3MgYW55IG91dHN0YW5kaW5nIHBhY2tldHMgbm93Lgo+ICAgCSAqIENh
bGwgbG9jYWxfYmhfZW5hYmxlIGFmdGVyIHRvIHRyaWdnZXIgc29mdElSUSBwcm9jZXNzaW5nLgo+
IEBAIC0xNDEzLDYgKzE0MjUsMTUgQEAgc3RhdGljIHZvaWQgcmVmaWxsX3dvcmsoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQo+ICAgCQlzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEgPSAmdmktPnJx
W2ldOwo+ICAgCj4gICAJCW5hcGlfZGlzYWJsZSgmcnEtPm5hcGkpOwo+ICsKPiArCQkvKiBDaGVj
ayBpZiB2cSBpcyBpbiByZXNldCBzdGF0ZS4gU2VlIG1vcmUgaW4KPiArCQkgKiB2aXJ0bmV0X25h
cGlfZW5hYmxlKCkKPiArCQkgKi8KPiArCQlpZiAocnEtPnZxLT5yZXNldCkgewo+ICsJCQl2aXJ0
bmV0X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiArCQkJY29udGludWU7Cj4gKwkJ
fQoKCkNhbiB3ZSBkbyBzb21ldGhpbmcgc2ltaWxhciBpbiB2aXJ0bmV0X2Nsb3NlKCkgYnkgY2Fu
Y2VsaW5nIHRoZSB3b3JrPwoKCj4gKwo+ICAgCQlzdGlsbF9lbXB0eSA9ICF0cnlfZmlsbF9yZWN2
KHZpLCBycSwgR0ZQX0tFUk5FTCk7Cj4gICAJCXZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAm
cnEtPm5hcGkpOwo+ICAgCj4gQEAgLTE1MjMsNiArMTU0NCwxMCBAQCBzdGF0aWMgdm9pZCB2aXJ0
bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gICAJaWYgKCFzcS0+
bmFwaS53ZWlnaHQgfHwgaXNfeGRwX3Jhd19idWZmZXJfcXVldWUodmksIGluZGV4KSkKPiAgIAkJ
cmV0dXJuOwo+ICAgCj4gKwkvKiBDaGVjayBpZiB2cSBpcyBpbiByZXNldCBzdGF0ZS4gU2VlIG1v
cmUgaW4gdmlydG5ldF9uYXBpX2VuYWJsZSgpICovCj4gKwlpZiAoc3EtPnZxLT5yZXNldCkKPiAr
CQlyZXR1cm47CgoKV2UndmUgZGlzYWJsZWQgVFggbmFwaSwgYW55IGNoYW5jZSB3ZSBjYW4gc3Rp
bGwgaGl0IHRoaXM/CgoKPiArCj4gICAJaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4g
ICAJCWRvIHsKPiAgIAkJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gQEAgLTE3Njks
NiArMTc5NCw2MiBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCXJldHVybiBORVRERVZfVFhfT0s7
Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aXJ0bmV0X3J4X3Jlc2l6ZShzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSwKPiArCQkJICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHUzMiByaW5n
X251bSkKPiArewo+ICsJaW50IGVycjsKPiArCj4gKwluYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsK
PiArCj4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHJxLT52cSwgcmluZ19udW0sIHZpcnRuZXRf
cnFfZnJlZV91bnVzZWRfYnVmKTsKPiArCWlmIChlcnIpCj4gKwkJZ290byBlcnI7Cj4gKwo+ICsJ
aWYgKCF0cnlfZmlsbF9yZWN2KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4gKwkJc2NoZWR1bGVfZGVs
YXllZF93b3JrKCZ2aS0+cmVmaWxsLCAwKTsKPiArCj4gKwl2aXJ0bmV0X25hcGlfZW5hYmxlKHJx
LT52cSwgJnJxLT5uYXBpKTsKPiArCXJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsJbmV0ZGV2X2Vy
cih2aS0+ZGV2LAo+ICsJCSAgICJyZXNldCByeCByZXNldCB2cSBmYWlsOiByeCBxdWV1ZSBpbmRl
eDogJXRkIGVycjogJWRcbiIsCj4gKwkJICAgcnEgLSB2aS0+cnEsIGVycik7Cj4gKwl2aXJ0bmV0
X25hcGlfZW5hYmxlKHJxLT52cSwgJnJxLT5uYXBpKTsKPiArCXJldHVybiBlcnI7Cj4gK30KPiAr
Cj4gK3N0YXRpYyBpbnQgdmlydG5ldF90eF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmks
Cj4gKwkJCSAgICAgc3RydWN0IHNlbmRfcXVldWUgKnNxLCB1MzIgcmluZ19udW0pCj4gK3sKPiAr
CXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPiArCWludCBlcnIsIHFpbmRleDsKPiArCj4gKwlx
aW5kZXggPSBzcSAtIHZpLT5zcTsKPiArCj4gKwl2aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmc3Et
Pm5hcGkpOwo+ICsKPiArCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcWluZGV4
KTsKPiArCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2
aS0+ZGV2LCBxaW5kZXgpOwo+ICsJX19uZXRpZl90eF91bmxvY2tfYmgodHhxKTsKPiArCj4gKwll
cnIgPSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0sIHZpcnRuZXRfc3FfZnJlZV91
bnVzZWRfYnVmKTsKPiArCWlmIChlcnIpCj4gKwkJZ290byBlcnI7Cj4gKwo+ICsJbmV0aWZfc3Rh
cnRfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKPiArCXZpcnRuZXRfbmFwaV90eF9lbmFibGUo
dmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiArCXJldHVybiAwOwo+ICsKPiArZXJyOgoKCkkgZ3Vl
c3Mgd2UgY2FuIHN0aWxsIHN0YXJ0IHRoZSBxdWV1ZSBpbiB0aGlzIGNhc2U/IChTaW5jZSB3ZSBk
b24ndCAKY2hhbmdlIHRoZSBxdWV1ZSBpZiByZXNpemUgZmFpbHMpLgoKCj4gKwluZXRkZXZfZXJy
KHZpLT5kZXYsCj4gKwkJICAgInJlc2V0IHR4IHJlc2V0IHZxIGZhaWw6IHR4IHF1ZXVlIGluZGV4
OiAldGQgZXJyOiAlZFxuIiwKPiArCQkgICBzcSAtIHZpLT5zcSwgZXJyKTsKPiArCXZpcnRuZXRf
bmFwaV90eF9lbmFibGUodmksIHNxLT52cSwgJnNxLT5uYXBpKTsKPiArCXJldHVybiBlcnI7Cj4g
K30KPiArCj4gICAvKgo+ICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0cXVl
dWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4gICAgKiBzdXBwb3J0ZWQgYnkgdGhlIGh5
cGVydmlzb3IsIGFzIGluZGljYXRlZCBieSBmZWF0dXJlIGJpdHMsIHNob3VsZAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
