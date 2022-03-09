Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D63C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 06:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A717541680;
	Wed,  9 Mar 2022 06:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Z30ia4FKI4F; Wed,  9 Mar 2022 06:14:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 330E14158B;
	Wed,  9 Mar 2022 06:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E719BC001D;
	Wed,  9 Mar 2022 06:14:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A39B7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 886A1400A6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bR7HmiK1u6lU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA6B24002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646806491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap6RrdGHmNkYVL8OAqPmtOOXTX9dVLo0fsotyLbFTFg=;
 b=i5S46VKKjBieuOpbUfHTMb3C42TUMtZRL/oSfP9l/ZaSo5OtBDu9N4Kdr2WJ7ZcfoNs/1t
 fnhepHkjB/pd4unSPCtg9JEZ2lQIQOcjmQ1SpYTKMjY1UbRy4mb2hcgtwoPt/5a3kEApzv
 oSLfSID1kiQyoXJfYmQEnUkJ8FGT1kQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-EJnkiQjHO-OxR92YHFsnkw-1; Wed, 09 Mar 2022 01:14:48 -0500
X-MC-Unique: EJnkiQjHO-OxR92YHFsnkw-1
Received: by mail-pj1-f70.google.com with SMTP id
 e1-20020a17090a280100b001bf44b6d74bso3204069pjd.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 22:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ap6RrdGHmNkYVL8OAqPmtOOXTX9dVLo0fsotyLbFTFg=;
 b=WyyLij4gWYSF5SphqIWvC4qAACjW/QInMVuUzzpgRNCkJkoJUvxLIkNRl83Fg4K2kD
 TBwQ45bgtlPEUNbdwBWtqJ2DMWUmXfoGT1IyEHAlqyvTsXSR0r0z3FnYjJ4Y7S8JbQ11
 MLBHRFrFefk7RCexZKJl3Wv3BAQosXa1mFJ7WRzs7fO8/zGAq6BNu0ryWJFoJqHTFUKU
 OupwiHWhjKnDpbHnEffa0Sb9AHjju34ymslmlVrLJh35s19IiycMO3FMqrrQle4oAxCt
 otGYZeG+KvQb37A+o5KUB7LkSHt1QNrle7OSxdHCU+fch4NtTqcdi4Vd5jZy17aBmjZp
 /qiQ==
X-Gm-Message-State: AOAM532quYX6Of5cwSPNmZbqLVG9jl5np6vpfAM7w+2DpxyeaEgoXe0R
 oP1EHFBn4qIkJgUlW6qiHLONT9nOGsrgadvgHvVkwzvfACEuQeTYgHDHqLte+I5wwt/hmANx/EW
 pabZI2JRDA+uVIfsfJ6P3AY8KKcX+ZBA1Ld0K0xnk4g==
X-Received: by 2002:a17:903:22cb:b0:151:9f41:8738 with SMTP id
 y11-20020a17090322cb00b001519f418738mr21847658plg.46.1646806487035; 
 Tue, 08 Mar 2022 22:14:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBCiRie4tAloFgqDg9JGwKT4KtqZzw2Fk+Xq44JLOLrxTAEP8NZVRRnFNWgW3q7UR+lbtsrg==
X-Received: by 2002:a17:903:22cb:b0:151:9f41:8738 with SMTP id
 y11-20020a17090322cb00b001519f418738mr21847626plg.46.1646806486782; 
 Tue, 08 Mar 2022 22:14:46 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a056a00148e00b004e1cee6f6b4sm1233248pfu.47.2022.03.08.22.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 22:14:46 -0800 (PST)
Message-ID: <4bc140fa-9e72-4bb5-47d9-84d9db384898@redhat.com>
Date: Wed, 9 Mar 2022 14:14:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 02/26] virtio: queue_reset: add VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-3-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEFkZGVkIFZJUlRJ
T19GX1JJTkdfUkVTRVQsIGl0IGNhbWUgZnJvbSBoZXJlCj4gaHR0cHM6Ly9naXRodWIuY29tL29h
c2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTI0CgoKTml0OiBpdCdzIGJldHRlciB0byBleHBs
YWluIFZJUlRJT19GX1JJTkdfUkVTRVQgYSBsaXR0bGUgYml0IGhlcmUuCgpPdGhlciB0aGFuIHRo
aXMuCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+Cj4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0K
PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmggfCA3ICsrKysrKy0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19jb25maWcuaAo+IGluZGV4IGI1ZWRhMDZmMGQ1Ny4uMDg2MmJlODAyZmY4IDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiArKysgYi9p
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gQEAgLTUyLDcgKzUyLDcgQEAKPiAg
ICAqIHJlc3QgYXJlIHBlci1kZXZpY2UgZmVhdHVyZSBiaXRzLgo+ICAgICovCj4gICAjZGVmaW5l
IFZJUlRJT19UUkFOU1BPUlRfRl9TVEFSVAkyOAo+IC0jZGVmaW5lIFZJUlRJT19UUkFOU1BPUlRf
Rl9FTkQJCTM4Cj4gKyNkZWZpbmUgVklSVElPX1RSQU5TUE9SVF9GX0VORAkJNDEKPiAgIAo+ICAg
I2lmbmRlZiBWSVJUSU9fQ09ORklHX05PX0xFR0FDWQo+ICAgLyogRG8gd2UgZ2V0IGNhbGxiYWNr
cyB3aGVuIHRoZSByaW5nIGlzIGNvbXBsZXRlbHkgdXNlZCwgZXZlbiBpZiB3ZSd2ZQo+IEBAIC05
Miw0ICs5Miw5IEBACj4gICAgKiBEb2VzIHRoZSBkZXZpY2Ugc3VwcG9ydCBTaW5nbGUgUm9vdCBJ
L08gVmlydHVhbGl6YXRpb24/Cj4gICAgKi8KPiAgICNkZWZpbmUgVklSVElPX0ZfU1JfSU9WCQkJ
MzcKPiArCj4gKy8qCj4gKyAqIFRoaXMgZmVhdHVyZSBpbmRpY2F0ZXMgdGhhdCB0aGUgZHJpdmVy
IGNhbiByZXNldCBhIHF1ZXVlIGluZGl2aWR1YWxseS4KPiArICovCj4gKyNkZWZpbmUgVklSVElP
X0ZfUklOR19SRVNFVAkJNDAKPiAgICNlbmRpZiAvKiBfVUFQSV9MSU5VWF9WSVJUSU9fQ09ORklH
X0ggKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
