Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B7C4321E
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 04:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C11D60767;
	Wed,  9 Mar 2022 04:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lh5pD4XYHW8H; Wed,  9 Mar 2022 04:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB73B6061B;
	Wed,  9 Mar 2022 04:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC05AC001D;
	Wed,  9 Mar 2022 04:48:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D516BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4229415E0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yV0O9U7iBUiQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8CA040882
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646801329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yW1kWq855MoycbxENZXn/INYb5Qcrtgiwr9xtyGJCE=;
 b=SbxytL/WuxrtxWmAszAVYSUGzS83WGm6V9D2g+wuvWh+4W619dbgOYwPTi432XOZPOuVab
 onkaexQRKxBE8Fd93Tcqi4/zfnXUNZobaUljXFs9ZVWUj95bvHHf0WPpzN34ESnrAlWie+
 6J16TPoYiLyjAPbxTexc15jmpbyBTRw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-LzbWuprmMBibDDpSH5fecA-1; Tue, 08 Mar 2022 23:48:46 -0500
X-MC-Unique: LzbWuprmMBibDDpSH5fecA-1
Received: by mail-pj1-f69.google.com with SMTP id
 e14-20020a17090a684e00b001bf09ac2385so872873pjm.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 20:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7yW1kWq855MoycbxENZXn/INYb5Qcrtgiwr9xtyGJCE=;
 b=dMue2Rne/4evcjj8UMydvw4M8LMt014JwS95d0jCbv6bqsC4Lu2bToJUTARnW7nu3f
 AXL2k0dBnClDFhmkPpvaZClPKJBEfp05hPIDjy+XW5AzQxYEAwPAgi3Yh24LiRCsyHxJ
 a+xhKZ93ib0+Fogs/h0zAYgDlBGOn+oa+1vqCfl5nrzFuzEcubqwTQC+zDuptQZ97B4v
 rRpqURLd5w0ARg0gcAd61hTfb+7Pf4xhXfRrZMK63tqtHKUB9bt+7PgWJsTV/n+zdTO4
 muRPcCB2lP34bNy7Zt5tAYsZsqPgy4ep+TlIpt6s9PmnsdTbdpwc83AIBjkr1VrY4x1y
 OgUA==
X-Gm-Message-State: AOAM531TmKp/IJ+qobeUw/XOi6TXv6vwfDMr9dP8mw0cZYma4WJhKS6A
 +/aHpMBZQ+a+p1BNUw0FtZkaYOu1EgiidYBRCYQRrKd8kyp3egJeFPTnMhQlhi6uMLaDHaBUpW4
 SDQAfonSy0whwTvyZujlgAGBFXN5SVCKicdtACg2ehA==
X-Received: by 2002:a17:90b:17ca:b0:1bf:6188:cc00 with SMTP id
 me10-20020a17090b17ca00b001bf6188cc00mr8597576pjb.2.1646801325735; 
 Tue, 08 Mar 2022 20:48:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwosqJUOOIblsYGQ27dg95V2/uz330dPMJom2dl9RgGa8k3TOiXYiGNo7Wasa+ovCrQzyH4wQ==
X-Received: by 2002:a17:90b:17ca:b0:1bf:6188:cc00 with SMTP id
 me10-20020a17090b17ca00b001bf6188cc00mr8597538pjb.2.1646801325443; 
 Tue, 08 Mar 2022 20:48:45 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a056a0023cf00b004e17e11cb17sm821341pfc.111.2022.03.08.20.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 20:48:44 -0800 (PST)
Message-ID: <373494ae-825b-d573-012c-4e7d453934da@redhat.com>
Date: Wed, 9 Mar 2022 12:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 01/26] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-2-xuanzhuo@linux.alibaba.com>
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
 Mathieu Poirier <mathieu.poirier@linaro.org>,
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEFkZCBxdWV1ZV9u
b3RpZnlfZGF0YSBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnLCB3aGljaCBjb21lcyBm
cm9tCj4gaGVyZSBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vl
cy84OQo+Cj4gRm9yIG5vdCBicmVha3MgdUFCSSwgYWRkIGEgbmV3IHN0cnVjdCB2aXJ0aW9fcGNp
X2NvbW1vbl9jZmdfbm90aWZ5Lgo+Cj4gU2luY2UgSSB3YW50IHRvIGFkZCBxdWV1ZV9yZXNldCBh
ZnRlciBxdWV1ZV9ub3RpZnlfZGF0YSwgSSBzdWJtaXR0ZWQKPiB0aGlzIHBhdGNoIGZpcnN0Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4K
CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCB8IDcgKysrKysrKwo+ICAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcGNpLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gaW5kZXgg
M2E4NmYzNmQ3ZTNkLi4yMmJlYzliZDBkZmMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19wY2kuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgK
PiBAQCAtMTY2LDYgKzE2NiwxMyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIHsKPiAg
IAlfX2xlMzIgcXVldWVfdXNlZF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiAgIH07Cj4gICAKPiAr
c3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZ19ub3RpZnkgewo+ICsJc3RydWN0IHZpcnRpb19w
Y2lfY29tbW9uX2NmZyBjZmc7Cj4gKwo+ICsJX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOwkvKiBy
ZWFkLXdyaXRlICovCj4gKwlfX2xlMTYgcGFkZGluZzsKPiArfTsKPiArCj4gICAvKiBGaWVsZHMg
aW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8KPiAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NmZ19j
YXAgewo+ICAgCXN0cnVjdCB2aXJ0aW9fcGNpX2NhcCBjYXA7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
