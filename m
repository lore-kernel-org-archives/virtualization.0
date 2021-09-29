Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:45:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A13613D0
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89A13613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BC1082479;
	Wed, 29 Sep 2021 08:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ANLu8WkyjmXN; Wed, 29 Sep 2021 08:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E83EB81D2D;
	Wed, 29 Sep 2021 08:45:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2DDCC000F;
	Wed, 29 Sep 2021 08:45:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0C07C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9132415A5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5KJuchQC1QrE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:45:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B072B41570
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632905148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gvu4L83YOBGLGvWqLGUuGEaO/DEUZyEQ1rFR5bn6b8M=;
 b=JX8sXbowIGFwf7cZnZnH3wolVvbBg/04UwcHDM4LArKbK7y5RdnLF7GKBfNlCIqxj7WeYb
 EJQIzjv+Oko8xuDDKM8M1tO52KUIC4K0DaVpqAhlyP0JmqIwixnUFtYcSt5jJSOtPXDc77
 LK4n2WibCqgob34LQwQqKU6A/2Ads4g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-4pqthK31ORCdGzB13yjhpg-1; Wed, 29 Sep 2021 04:45:47 -0400
X-MC-Unique: 4pqthK31ORCdGzB13yjhpg-1
Received: by mail-wm1-f72.google.com with SMTP id
 y23-20020a05600c365700b003015b277f98so578905wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Gvu4L83YOBGLGvWqLGUuGEaO/DEUZyEQ1rFR5bn6b8M=;
 b=U1eRfUt+gM8QzUrdX9/Hbp2e964ZSSG6EXsaNg1Oihtq0Ind5XbXOBg+Jei5Jia5J9
 oPHkbbepM+SU/v+3xHcfPPjuLQFMJWiF7n9Ux+dYfRhInNeFVAp147BqYeZJclk263w7
 Oabs9N2t53zAIi4pr9cYE0/9zE+76qjdd9kIAdHY5jfXU5oSU0BBDWN8R/7XHo1tgwj3
 z2V7tyAwMwVb4lguAuo6mNaVloVTK+7nbbZhXdamdR4d6vYa0wSeWjlQ72mWRo1ZtIPd
 Rc3ejmzk2YyBj2Sl/dzW2JZC2mOAs9InAkWcyfyY5K75B2uAN+3n/XXSVpgcP31PLAfm
 LgpQ==
X-Gm-Message-State: AOAM532X78clXnVmiTnioaiCTw3cMO5AEPOp8nnd6YIEXxHZnLI4HKhU
 BQoY1PzT45LQu3e1bhE9Em4/DpFV1OnMSHvPKmAnCouPiDfsKLqAl4MOMYrH3Hiax5NS+V/dSDF
 mVyXDCQRwE42fFDJkBzF01wqsTijxFFJbxmQ76NemYg==
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr8734504wmc.149.1632905146277; 
 Wed, 29 Sep 2021 01:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaikWIkzzrJGqHValULa/ZmnNfg4rl1LyjKqzMWVt+gz9mbskxaXhni5v3m042+vSd753h3g==
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr8734485wmc.149.1632905146123; 
 Wed, 29 Sep 2021 01:45:46 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
 by smtp.gmail.com with ESMTPSA id
 t126sm893773wma.4.2021.09.29.01.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 01:45:45 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Date: Wed, 29 Sep 2021 10:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
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

PiAKPiBIb3cgYWJvdXQKPiAKPiAgwqDCoMKgIHJldHVybiBhLm1lbV90eXBlICE9IEhWTU1FTV9t
bWlvX2RtOwo+IAoKSGEsIGhvdyBjb3VsZCBJIGhhdmUgbWlzc2VkIHRoYXQgOikKCj4gCj4gUmVz
dWx0IHNob3VsZCBiZSBwcm9tb3RlZCB0byBpbnQgYW5kIHRoaXMgaGFzIGFkZGVkIGJlbmVmaXQg
b2Ygbm90IHJlcXVpcmluZyBjaGFuZ2VzIGluIHBhdGNoIDQuCj4gCgpDYW4gd2UgZ28gb25lIHN0
ZXAgZnVydGhlciBhbmQgZG8KCgpAQCAtMjAsMjQgKzIwLDExIEBAIHN0YXRpYyBpbnQgeGVuX29s
ZG1lbV9wZm5faXNfcmFtKHVuc2lnbmVkIGxvbmcgcGZuKQogICAgICAgICBzdHJ1Y3QgeGVuX2h2
bV9nZXRfbWVtX3R5cGUgYSA9IHsKICAgICAgICAgICAgICAgICAuZG9taWQgPSBET01JRF9TRUxG
LAogICAgICAgICAgICAgICAgIC5wZm4gPSBwZm4sCisgICAgICAgICAgICAgICAubWVtX3R5cGUg
PSBIVk1NRU1fcmFtX3J3LAogICAgICAgICB9OwotICAgICAgIGludCByYW07CiAgCi0gICAgICAg
aWYgKEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwgJmEpKQotICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTlhJTzsKLQotICAgICAgIHN3aXRjaCAoYS5tZW1fdHlwZSkgewotICAg
ICAgIGNhc2UgSFZNTUVNX21taW9fZG06Ci0gICAgICAgICAgICAgICByYW0gPSAwOwotICAgICAg
ICAgICAgICAgYnJlYWs7Ci0gICAgICAgY2FzZSBIVk1NRU1fcmFtX3J3OgotICAgICAgIGNhc2Ug
SFZNTUVNX3JhbV9ybzoKLSAgICAgICBkZWZhdWx0OgotICAgICAgICAgICAgICAgcmFtID0gMTsK
LSAgICAgICAgICAgICAgIGJyZWFrOwotICAgICAgIH0KLQotICAgICAgIHJldHVybiByYW07Cisg
ICAgICAgSFlQRVJWSVNPUl9odm1fb3AoSFZNT1BfZ2V0X21lbV90eXBlLCAmYSk7CisgICAgICAg
cmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07CiAgfQogICNlbmRpZgoKCkFzc3Vt
aW5nIHRoYXQgaWYgSFlQRVJWSVNPUl9odm1fb3AoKSBmYWlscyB0aGF0Ci5tZW1fdHlwZSBpcyBu
b3Qgc2V0IHRvIEhWTU1FTV9tbWlvX2RtLgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
