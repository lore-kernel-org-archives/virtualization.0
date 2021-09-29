Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D47C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 09:03:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF8A613D0
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 09:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFF8A613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D75E6077A;
	Wed, 29 Sep 2021 09:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3IkItknrrI8; Wed, 29 Sep 2021 09:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1811D606B9;
	Wed, 29 Sep 2021 09:03:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6ACCC000F;
	Wed, 29 Sep 2021 09:03:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8154DC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51A9F4039E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTBR2jDiC8nJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81024401CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632906195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7W9Fc0fF86WyXYecPV/lI8dmSptGKk8vSEWO1VbX84s=;
 b=YVh8zL0yZKyeVgeJdtYZU11nczQyEqrxLoLnaqi6fcvtnxoSoMloNsAXNmmVxFOalnBMmT
 E4AMj5YoIZgZ1Xm2mKJgWFqQ9touTFfMB2zu7HHlGRQnJd7MEj1zMqSVdY6cGyt4olVCIo
 l8Wha3ZEW9krog2EGf0N7Iifgg6DEhE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-umaqx9D2M3mSJyIYFZFqxQ-1; Wed, 29 Sep 2021 05:03:12 -0400
X-MC-Unique: umaqx9D2M3mSJyIYFZFqxQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 f7-20020a5d50c7000000b0015e288741a4so393411wrt.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 02:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7W9Fc0fF86WyXYecPV/lI8dmSptGKk8vSEWO1VbX84s=;
 b=zVHI4xzhXUydFqcsEJPCieyY5Dq/zXohDuEd19hM8tgz5yfe9604V+HSVqixOF3Pp0
 PXd4wtrsUYDnJm1QrbCOFaUWWMWIVweGRk8JWJEsUsPc8MwElz2Wp3iMsqamKeD1F8Tx
 JUWaWyXi7ZiB0+FqYfl02HW0Uo4odWf1Qlo6VWxEre6XJy3v3Bwtdac3s9PWDsHsQmqg
 zzbS8HsjXbpu6AZqrGomVHPFfRGfhWMWyd2/KRYmsZM4Ld6WtkJWLV1/jD3EolXAf9zz
 CVK1L5DpmrhOlyh2wXFoQjVvVQz7m9npIvDNh6b8uJF0Rn2OVKTFlakDY1kJ0fMJIFLO
 +MaQ==
X-Gm-Message-State: AOAM532L7POXtr3J9jm5UZswq3q6bbdinfi/kApomPiIUqie4qRxMojx
 v9a+K+fQuMI2DQSfjMFN/bjoDRIlDwy0ZLIFwYwTkmCoCV180522UCuHIv/qTjT0dMvDig8Vi0p
 IDMtTEUCABl+C+z0EuTmYw1O1djWtz+Gk42PpC6IPJA==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr9238886wmi.125.1632906190950; 
 Wed, 29 Sep 2021 02:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAVvczz8jUTCdMNZ0BC5qvezoqKUBOcf5OajF0CWmKLmPAPf0K3OR8WEfpMUG5vsV5dclhgg==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr9238872wmi.125.1632906190770; 
 Wed, 29 Sep 2021 02:03:10 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
 by smtp.gmail.com with ESMTPSA id
 t11sm1548498wrz.65.2021.09.29.02.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 02:03:10 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
From: David Hildenbrand <david@redhat.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Organization: Red Hat
Message-ID: <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
Date: Wed, 29 Sep 2021 11:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 x86@kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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

T24gMjkuMDkuMjEgMTA6NDUsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pgo+PiBIb3cgYWJv
dXQKPj4KPj4gICDCoMKgwqAgcmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07Cj4+
Cj4gCj4gSGEsIGhvdyBjb3VsZCBJIGhhdmUgbWlzc2VkIHRoYXQgOikKPiAKPj4KPj4gUmVzdWx0
IHNob3VsZCBiZSBwcm9tb3RlZCB0byBpbnQgYW5kIHRoaXMgaGFzIGFkZGVkIGJlbmVmaXQgb2Yg
bm90IHJlcXVpcmluZyBjaGFuZ2VzIGluIHBhdGNoIDQuCj4+Cj4gCj4gQ2FuIHdlIGdvIG9uZSBz
dGVwIGZ1cnRoZXIgYW5kIGRvCj4gCj4gCj4gQEAgLTIwLDI0ICsyMCwxMSBAQCBzdGF0aWMgaW50
IHhlbl9vbGRtZW1fcGZuX2lzX3JhbSh1bnNpZ25lZCBsb25nIHBmbikKPiAgICAgICAgICAgc3Ry
dWN0IHhlbl9odm1fZ2V0X21lbV90eXBlIGEgPSB7Cj4gICAgICAgICAgICAgICAgICAgLmRvbWlk
ID0gRE9NSURfU0VMRiwKPiAgICAgICAgICAgICAgICAgICAucGZuID0gcGZuLAo+ICsgICAgICAg
ICAgICAgICAubWVtX3R5cGUgPSBIVk1NRU1fcmFtX3J3LAo+ICAgICAgICAgICB9Owo+IC0gICAg
ICAgaW50IHJhbTsKPiAgICAKPiAtICAgICAgIGlmIChIWVBFUlZJU09SX2h2bV9vcChIVk1PUF9n
ZXRfbWVtX3R5cGUsICZhKSkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsKPiAtCj4g
LSAgICAgICBzd2l0Y2ggKGEubWVtX3R5cGUpIHsKPiAtICAgICAgIGNhc2UgSFZNTUVNX21taW9f
ZG06Cj4gLSAgICAgICAgICAgICAgIHJhbSA9IDA7Cj4gLSAgICAgICAgICAgICAgIGJyZWFrOwo+
IC0gICAgICAgY2FzZSBIVk1NRU1fcmFtX3J3Ogo+IC0gICAgICAgY2FzZSBIVk1NRU1fcmFtX3Jv
Ogo+IC0gICAgICAgZGVmYXVsdDoKPiAtICAgICAgICAgICAgICAgcmFtID0gMTsKPiAtICAgICAg
ICAgICAgICAgYnJlYWs7Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgcmV0dXJuIHJhbTsKPiAr
ICAgICAgIEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwgJmEpOwo+ICsgICAg
ICAgcmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07Cj4gICAgfQo+ICAgICNlbmRp
Zgo+IAo+IAo+IEFzc3VtaW5nIHRoYXQgaWYgSFlQRVJWSVNPUl9odm1fb3AoKSBmYWlscyB0aGF0
Cj4gLm1lbV90eXBlIGlzIG5vdCBzZXQgdG8gSFZNTUVNX21taW9fZG0uCj4gCgpPa2F5IHdlIGNh
bid0LCBkdWUgdG8gIl9fbXVzdF9jaGVjayIgLi4uCgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGls
ZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
