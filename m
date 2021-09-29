Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E1C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:07:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF1C61406
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EF1C61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65E0B60C1A;
	Wed, 29 Sep 2021 15:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DL-fdK8JJ_Rf; Wed, 29 Sep 2021 15:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1390E60C1F;
	Wed, 29 Sep 2021 15:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7601C000F;
	Wed, 29 Sep 2021 15:07:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E29FC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2727D832EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fae28QV5Mu_t
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77469832DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632928035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gapF6Q7MxbKj+/Jpg0HNCHa+0ngI63VYNLFNHFDInM4=;
 b=LhgWWRM1iezTsTbyUR0RtFUrGC/j9CAkX9XNLkr26OzJ0jzngXIVrJF8SNuHREeS62SorG
 grdPpCCVlxAKIK7wd6VSRyO/nJC1x12+3E+HeHD8exYmlE9MnyiAy+Nd9zpHxCnqS3NrRI
 k6aF7ceeafd+YR3eQZqEfJTwbyfUP/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-bDbWU6f5Pe6Z8k9vx4wpaw-1; Wed, 29 Sep 2021 11:07:14 -0400
X-MC-Unique: bDbWU6f5Pe6Z8k9vx4wpaw-1
Received: by mail-wr1-f70.google.com with SMTP id
 r7-20020a5d6947000000b0015e0f68a63bso704435wrw.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gapF6Q7MxbKj+/Jpg0HNCHa+0ngI63VYNLFNHFDInM4=;
 b=Sx2ycDczpciU2X4v/kRi68WLg4EmjmkxPfgLNfBdSbsVlUR+6wcgwhEMwz4GM//5is
 8j9jFpsgMDivFjsEZdD/gt7WC7Cml+m4nQz//Mbq8GZsujmG2j/Eag0LQ1h03sW85Z1Y
 6JicOqVQckWdWe2IJAwC0iq9Wah/RmHAqWI6DEyV4OxNMcLwq+rJbFzLfzBxZefyNykh
 FRPXCXDIek52eif/FCznApjld7ZbqUXqxXM62vreWIWd78FUe2pG4J4U6xpg5ENQfAye
 HISl+lneqsqyyBI//50an6auvVd9FaP/FFW561E/5nmH9WcT54fuGmdSi+X19QVME4K3
 j0HQ==
X-Gm-Message-State: AOAM532RQJdCpb/is21+yF/HBR+ZOxrPKsR16zlHiPwKytaHie9sNPHI
 mGhceBZws7Q7kwNg/tpcFisAbZAoHBqTZDxoqb/cdMXLJENmyWAR8BgRiJIhflHkBVMuw10z4TF
 TF3Cd4B4T5NAtJKV+cX5SCVmTOGXKFnxzc3XAh14tGA==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr378686wrt.147.1632928032837; 
 Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo/OiD1pi8Vj8uvbtvhFWxk5A000qCxnhsR/1CMHH5asTCVBPsn8x+8H3lxRFK4haIMhJq1A==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr378630wrt.147.1632928032598; 
 Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
 by smtp.gmail.com with ESMTPSA id
 f8sm177044wrx.15.2021.09.29.08.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
 <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e6ace8c8-8a2d-9bf7-e65b-91d0037c4d08@redhat.com>
Date: Wed, 29 Sep 2021 17:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
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

T24gMjkuMDkuMjEgMTY6MjIsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToKPiAKPiBPbiA5LzI5LzIx
IDU6MDMgQU0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+PiBPbiAyOS4wOS4yMSAxMDo0NSwg
RGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4+Pj4KPj4+IENhbiB3ZSBnbyBvbmUgc3RlcCBmdXJ0
aGVyIGFuZCBkbwo+Pj4KPj4+Cj4+PiBAQCAtMjAsMjQgKzIwLDExIEBAIHN0YXRpYyBpbnQgeGVu
X29sZG1lbV9wZm5faXNfcmFtKHVuc2lnbmVkIGxvbmcgcGZuKQo+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgeGVuX2h2bV9nZXRfbWVtX3R5cGUgYSA9IHsKPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5kb21pZCA9IERPTUlEX1NFTEYsCj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucGZuID0gcGZuLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLm1lbV90eXBlID0gSFZNTUVNX3JhbV9ydywKPj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqAgfTsKPj4+IC3CoMKgwqDCoMKgwqAgaW50IHJhbTsKPj4+ICDCoMKgIC3CoMKgwqDC
oMKgwqAgaWYgKEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwgJmEpKQo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTlhJTzsKPj4+IC0KPj4+IC3C
oMKgwqDCoMKgwqAgc3dpdGNoIChhLm1lbV90eXBlKSB7Cj4+PiAtwqDCoMKgwqDCoMKgIGNhc2Ug
SFZNTUVNX21taW9fZG06Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW0gPSAw
Owo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiAtwqDCoMKgwqDC
oMKgIGNhc2UgSFZNTUVNX3JhbV9ydzoKPj4+IC3CoMKgwqDCoMKgwqAgY2FzZSBIVk1NRU1fcmFt
X3JvOgo+Pj4gLcKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmFtID0gMTsKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+Pj4gLcKgwqDCoMKgwqDCoCB9Cj4+PiAtCj4+PiAtwqDCoMKgwqDCoMKgIHJldHVybiByYW07
Cj4+PiArwqDCoMKgwqDCoMKgIEhZUEVSVklTT1JfaHZtX29wKEhWTU9QX2dldF9tZW1fdHlwZSwg
JmEpOwo+Pj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gYS5tZW1fdHlwZSAhPSBIVk1NRU1fbW1pb19k
bTsKPiAKPiAKPiBJIHdhcyBhY3R1YWxseSB0aGlua2luZyBvZiBhc2tpbmcgeW91IHRvIGFkZCBh
bm90aGVyIHBhdGNoIHdpdGggcHJfd2Fybl9vbmNlKCkgaGVyZSAoYW5kIHByaW50IGVycm9yIGNv
ZGUgYXMgd2VsbCkuIFRoaXMgY2FsbCBmYWlsaW5nIGlzIGluZGljYXRpb24gb2Ygc29tZXRoaW5n
IGdvaW5nIHF1aXRlIHdyb25nIGFuZCBpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cgYWJvdXQgdGhp
cy4KCldpbGwgaW5jbHVkZSBhIHBhdGNoIGluIHYyLCB0aGFua3MhCgoKLS0gClRoYW5rcywKCkRh
dmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
