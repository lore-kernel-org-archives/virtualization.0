Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC9BC63797
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 15:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E03E3813DA;
	Tue, 17 Jan 2023 15:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E03E3813DA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DMgDAcPX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3gjxK-8yc8y; Tue, 17 Jan 2023 15:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3111A8186A;
	Tue, 17 Jan 2023 15:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3111A8186A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12839C0032;
	Tue, 17 Jan 2023 15:33:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A281C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E411C405EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E411C405EB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DMgDAcPX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bbRzRCJwLfcF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C65B405D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C65B405D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673969606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpLspA5PSonBw/vmV1OrZLpzelfm/8/OIBNoQk0pktg=;
 b=DMgDAcPXbYsqPCJOhqxr+UiWTiYqu//CsJEwr6IBmgkMlD6yCDCzLQ5p/2YENiR3OHNm9q
 sjuPwMwailnfo95Ed+studzAODqjZ1HMmYNXtRYmxmFFqXl0xq8NxH0FOoyItQeBo24K8H
 iy3s8pLhv/YYAXQbl3TsglK0h1OQqac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-AQ2M7qPnMKakBRc3qq5O_A-1; Tue, 17 Jan 2023 10:33:25 -0500
X-MC-Unique: AQ2M7qPnMKakBRc3qq5O_A-1
Received: by mail-wm1-f69.google.com with SMTP id
 n18-20020a05600c4f9200b003d993e08485so16618571wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 07:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpLspA5PSonBw/vmV1OrZLpzelfm/8/OIBNoQk0pktg=;
 b=sD6uXYmebFdzeTxBDBBsUe8XRYfgyh5f9W0ANXKEPQ0y3fYBWfJnlR6tBWcCoLFbxi
 nHbctsA+nj91iYBU2/BEcN7/nK8jZbVPWv9Bg7IWC8V+SppytPrjifr0qMF5kw/5uZGl
 oy5LNb7KtLViZpRi871rOl06QUP0GTdNdLYRd+vGF4+xY7C0k9pbdTWjyg1LK+r1xH5g
 ITuF6EMtQZ9tR9w9YpPY6z+/xmjgA/j6W1i9bieBs/4u0/rcV0M3P2f3MZyPOENcMUuv
 nudX1dk65WeedPndYBluL77FfKVY41CsQrij1jsvaSLcjFo/3uz1lm253YeLccK23roy
 D9EA==
X-Gm-Message-State: AFqh2kpH5bZwedzgErYh8MI7JXrdfVRLI+b5mRwwqED80UcXXoF1dbxZ
 wnVOCAcMvuT3ds8T9IEdDw/w3JzOB+PtIo0RnhUPXvvURF8K9RK3OeY4DA+8ihiYZH3lxWWxxrt
 AAE+UdCxVk6QON2H20B7cFcbiRPmgw9cmR/UfYmtxJA==
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id
 g3-20020a05600c308300b003da0e4de6bamr3462886wmn.14.1673969584684; 
 Tue, 17 Jan 2023 07:33:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCh6pUXHdET5pfuUv9PvBeMbDsI9H3dt7KkiP1Worcaf06CcwLqp9GwiSRlxDjBnrsjANXng==
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id
 g3-20020a05600c308300b003da0e4de6bamr3462862wmn.14.1673969584377; 
 Tue, 17 Jan 2023 07:33:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:f00:323e:5956:8da1:9237?
 (p200300cbc7080f00323e59568da19237.dip0.t-ipconnect.de.
 [2003:cb:c708:f00:323e:5956:8da1:9237])
 by smtp.gmail.com with ESMTPSA id
 bi6-20020a05600c3d8600b003d9df9e59c4sm34116110wmb.37.2023.01.17.07.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jan 2023 07:33:03 -0800 (PST)
Message-ID: <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
Date: Tue, 17 Jan 2023 16:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>, mark.rutland@arm.com,
 will@kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
In-Reply-To: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Sukadev Bhattiprolu \(QUIC\)" <quic_sukadev@quicinc.com>,
 "Srivatsa Vaddagiri \(QUIC\)" <quic_svaddagi@quicinc.com>,
 "Patrick Daly \(QUIC\)" <quic_pdaly@quicinc.com>,
 "Trilok Soni \(QUIC\)" <quic_tsoni@quicinc.com>
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

T24gMTUuMDEuMjMgMDQ6NTcsIFN1ZGFyc2hhbiBSYWphZ29wYWxhbiB3cm90ZToKPiBIZWxsbyBh
bGwsCj4gCgpIaSwKCkknbGwgZm9jdXMgb24gdGhlIHZpcnRpby1tZW0gc2lkZSBvZiB0aGluZ3Mg
OikKCj4gV2XigJlyZSBmcm9tIHRoZSBMaW51eCBtZW1vcnkgdGVhbSBoZXJlIGF0IFF1YWxjb21t
LiBXZSBhcmUgY3VycmVudGx5Cj4gZGV2aXNpbmcgYSBWTSBtZW1vcnkgcmVzaXppbmcgZmVhdHVy
ZSB3aGVyZSB3ZSBkeW5hbWljYWxseSBpbmZsYXRlIG9yCj4gZGVmbGF0ZSB0aGUgTGludXggVk0g
YmFzZWQgb24gb25nb2luZyBtZW1vcnkgZGVtYW5kcyBpbiB0aGUgVk0uIFdlCj4gd2FudGVkIHRv
IHByb3Bvc2UgZmV3IGRldGFpbHMgYWJvdXQgdGhpcyB1c2Vyc3BhY2UgZGFlbW9uIGluIGZvcm0g
b2YgUkZDCj4gYW5kIHdhbnRlZCB0byBrbm93IHRoZSB1cHN0cmVhbeKAmXMgb3Bpbmlvbi4gSGVy
ZSBhcmUgZmV3IGRldGFpbHMg4oCTCgpJJ2QgYXZvaWQgdXNpbmcgdGhlIHRlcm1pbm9sb2d5IG9m
IGluZmxhdGluZy9kZWZsYXRpbmcgVk0gbWVtb3J5IHdoZW4gCnRhbGtpbmcgYWJvdXQgdmlydGlv
LW1lbS4gSnVzdCBjYWxsIGl0ICJkeW5hbWljYWxseSByZXNpemluZyBWTSBtZW1vcnkiLiAKdmly
dGlvLW1lbSBpcyBvbmUgd2F5IG9mIGRvaW5nIGl0IHVzaW5nIG1lbW9yeSBkZXZpY2VzLgoKSW5m
bGF0aW9uL2RlZmxhdGlvbiwgaW4gY29udHJhc3QsIHJlbWluZHMgb25lIG9mIGEgdHJhZGl0aW9u
YWwgYmFsbG9vbiAKZHJpdmVyLCBhbG9uZyB0aGUgbGluZXMgb2YgdmlydGlvLWJhbGxvb24uCgo+
IAo+IDEuIFRoaXMgd2lsbCBiZSBhIG5hdGl2ZSB1c2Vyc3BhY2UgZGFlbW9uIHRoYXQgd2lsbCBi
ZSBydW5uaW5nIG9ubHkgaW4KPiB0aGUgTGludXggVk0gd2hpY2ggd2lsbCB1c2UgdmlydGlvLW1l
bSBkcml2ZXIgdGhhdCB1c2VzIG1lbW9yeSBob3RwbHVnCj4gdG8gYWRkL3JlbW92ZSBtZW1vcnku
IFRoZSBWTSAoYWthIFNlY29uZGFyeSBWTSwgU1ZNKSB3aWxsIHJlcXVlc3QgZm9yCj4gbWVtb3J5
IGZyb20gdGhlIGhvc3Qgd2hpY2ggaXMgUHJpbWFyeSBWTSwgUFZNIHZpYSB0aGUgYmFja2VuZCBo
eXBlcnZpc29yCj4gd2hpY2ggdGFrZXMgY2FyZSBvZiBjcm9zcy1WTSBjb21tdW5pY2F0aW9uLgo+
IAo+IDIuIFRoaXMgd2lsbCBiZSBndWVzdCBkcml2ZXIuIFRoaXMgZGFlbW9uIHdpbGwgdXNlIFBT
SSBtZWNoYW5pc20gdG8KPiBtb25pdG9yIG1lbW9yeSBwcmVzc3VyZSB0byBrZWVwIHRyYWNrIG9m
IG1lbW9yeSBkZW1hbmRzIGluIHRoZSBzeXN0ZW0uCj4gSXQgd2lsbCByZWdpc3RlciB0byBmZXcg
bWVtb3J5IHByZXNzdXJlIGV2ZW50cyBhbmQgbWFrZSBhbiBlZHVjYXRlZAo+IGd1ZXNzIG9uIHdo
ZW4gZGVtYW5kIGZvciBtZW1vcnkgaW4gc3lzdGVtIGlzIGluY3JlYXNpbmcuCgpJcyB0aGF0IHJ1
bm5pbmcgaW4gdGhlIHByaW1hcnkgb3IgdGhlIHNlY29uZGFyeSBWTT8KCj4gCj4gMy4gQ3VycmVu
dGx5LCBtaW4gUFNJIHdpbmRvdyBzaXplIGlzIDUwMG1zLCBzbyBQU0kgbW9uaXRvciBzYW1wbGlu
Zwo+IHBlcmlvZCB3aWxsIGJlIDUwbXMuIEluIG9yZGVyIHRvIGdldCBxdWljayByZXNwb25zZSB0
aW1lIGZyb20gUFNJLCB3ZeKAmXZlCj4gcmVkdWNlZCB0aGUgbWluIHdpbmRvdyBzaXplIHRvIDUw
bXMgc28gdGhhdCBhcyBzbWFsbCBhcyA1bXMgaW5jcmVhc2UgaW4KPiBtZW1vcnkgcHJlc3N1cmUg
Y2FuIGJlIHJlcG9ydGVkIHRvIHVzZXJzcGFjZSBieSBQU0kuCj4gCj4gLyogUFNJIHRyaWdnZXIg
ZGVmaW5pdGlvbnMgKi8KPiAtI2RlZmluZSBXSU5ET1dfTUlOX1VTIDUwMDAwMMKgwqAgLyogTWlu
IHdpbmRvdyBzaXplIGlzIDUwMG1zICovCj4gKyNkZWZpbmUgV0lORE9XX01JTl9VUyA1MDAwMMKg
wqDCoCAvKiBNaW4gd2luZG93IHNpemUgaXMgNTBtcyAqLwo+IAo+IDQuIERldGVjdGluZyBpbmNy
ZWFzZSBpbiBtZW1vcnkgZGVtYW5kIOKAkyB3aGVuIGEgY2VydGFpbiB1c2VjYXNlIHN0YXJ0cwo+
IGluIFZNIHRoYXQgZG9lcyBtZW1vcnkgYWxsb2NhdGlvbnMsIGl0IHdpbGwgc3RhbGwgY2F1c2lu
ZyBQU0kgbWVjaGFuaXNtCj4gdG8gZ2VuZXJhdGUgYSBtZW1vcnkgcHJlc3N1cmUgZXZlbnQgdG8g
dXNlcnNwYWNlLiBUbyBzaW1wbHkgcHV0LCB3aGVuCj4gcHJlc3N1cmUgaW5jcmVhc2VzIGNlcnRh
aW4gc2V0IHRocmVzaG9sZCwgaXQgY2FuIG1ha2UgZWR1Y2F0ZWQgZ3Vlc3MKPiB0aGF0IGEgbWVt
b3J5IHJlcXVpcmluZyB1c2VjYXNlIGhhcyByYW4gYW5kIFZNIHN5c3RlbSBuZWVkcyBtZW1vcnkg
dG8gYmUKPiBhZGRlZC4KPiAKPiA1LiBEZXRlY3RpbmcgZGVjcmVhc2UgaW4gbWVtb3J5IHByZXNz
dXJlIOKAkyB0aGUgcmV2ZXJzZSBwYXJ0IHdoZXJlIHdlCj4gZ2l2ZSBiYWNrIG1lbW9yeSB0byBQ
Vk0gd2hlbiBtZW1vcnkgaXMgbm8gbG9uZ2VyIG5lZWRlZCBpcyBiaXQgdHJpY2t5Lgo+IFdlIGxv
b2sgZm9yIHByZXNzdXJlIGRlY2F5IGFuZCBzZWUgaWYgUFNJIGF2ZXJhZ2VzIChhdmcxMCwgYXZn
NjAsCj4gYXZnMzAwKSBnbyBkb3duLCBhbmQgYWxvbmcgd2l0aCBvdGhlciBtZW1vcnkgc3RhdHMg
KHN1Y2ggYXMgZnJlZSBtZW1vcnkKPiBldGMpIHdlIG1ha2UgYW4gZWR1Y2F0ZWQgZ3Vlc3MgdGhh
dCB1c2VjYXNlIGhhcyBlbmRlZCBhbmQgbWVtb3J5IGhhcwo+IGJlZW4gZnJlZeKAmWVkIGJ5IHRo
ZSB1c2VjYXNlLCBhbmQgdGhpcyBtZW1vcnkgY2FuIGJlIGdpdmVuIGJhY2sgdG8gUFZNCj4gd2hl
biBpdHMgbm8gbG9uZ2VyIG5lZWRlZC4KPiAKPiA2LiBJ4oCZbSBza2ltbWluZyBtdWNoIG9uIHRo
ZSBsb2dpYyBhbmQgaW50ZWxsaWdlbmNlIGJ1dCB0aGUgZGFlbW9uIHJlbGllcwo+IG9uIFBTSSBt
ZWNoYW5pc20gdG8ga25vdyB3aGVuIG1lbW9yeSBkZW1hbmQgaXMgZ29pbmcgdXAgYW5kIGRvd24s
IGFuZAo+IGNvbW11bmljYXRlcyB3aXRoIHZpcnRpby1tZW0gZHJpdmVyIGZvciBob3QtcGx1Z2dp
bmcvdW5wbHVnZ2luZyBtZW1vcnkuCgpGb3Igbm93LCB0aGUgaHlwZXJ2aXNvciBpcyBpbiBjaGFy
Z2Ugb2YgdHJpZ2dlcmluZyBhIHZpcnRpby1tZW0gZGV2aWNlIApyZXNpemUgcmVxdWVzdC4gV2ls
bCB0aGUgTGludXggVk0gZXhwb3NlIGEgdmlydGlvLW1lbSBkZXZpY2UgdG8gdGhlIFNWTSAKYW5k
IHJlcXVlc3QgdG8gcmVzaXplIHRoZSBTVk0gbWVtb3J5IHZpYSB0aGF0IHZpcnRpby1tZW0gZGV2
aWNlPwoKPiBXZSBhbHNvIGZhY3RvciBpbiB0aGUgbGF0ZW5jeSBpbnZvbHZlZCB3aXRoIHJvdW5k
dHJpcHMgYmV0d2VlbiBTVk08LT5QVk0KPiBzbyB3ZSBzaXplIHRoZSBtZW1vcnkgY2h1Y2sgdGhh
dCBuZWVkcyB0byBiZSBwbHVnZ2VkLWluIGFjY29yZGluZ2x5Lgo+IAo+IDcuIFRoZSB3aG9sZSBw
dXJwb3NlIG9mIGRhZW1vbiB1c2luZyBQU0kgbWVjaGFuaXNtIGlzIHRvIG1ha2UgdGhpcyBzaQo+
IGd1ZXN0IGRyaXZlbiByYXRoZXIgdGhhbiBob3N0IGRyaXZlbiwgd2hpY2ggY3VycmVudGx5IGlz
IHRoZSBjYXNlIG1vc3RseQo+IHdpdGggdmlydGlvLW1lbSB1c2Vycy4gVGhlIG1lbW9yeSBwcmVz
c3VyZSBhbmQgdXNhZ2UgbW9uaXRvcmluZyBoYXBwZW5zCj4gaW5zaWRlIHRoZSBTVk0gYW5kIHRo
ZSBTVk0gbWFrZXMgdGhlIGRlY2lzaW9ucyB0byByZXF1ZXN0IGZvciBtZW1vcnkKPiBmcm9tIFBW
TS4gVGhpcyBhdm9pZHMgYW55IGludGVydmVudGlvbiBzdWNoIGFzIGFkbWluIGluIFBWTSB0byBt
b25pdG9yCj4gYW5kIGNvbnRyb2wgdGhlIGtub2JzLiBXZSBoYXZlIGFsc28gc2V0IG1heCBsaW1p
dCBvZiBob3cgbXVjaCBTVk1zIGNhbgo+IGdyb3cgaW50ZXJtcyBvZiBtZW1vcnksIHNvIHRoYXQg
YSByb3VnZSBWTSB3b3VsZCBub3QgYWJ1c2UgdGhpcyBzY2hlbWUuCgpTb21ldGhpbmcgSSBlbnZp
c2lvbmVkIGF0IHNvbWUgcG9pbnQgaXMgdG8KMSkgSGF2ZSBhIHZpcnRpby1tZW0gZ3Vlc3QgZHJp
dmVyIHRvIHJlcXVlc3QgYSBzaXplIGNoYW5nZS4gVGhlCiAgICBoeXBlcnZpc29yIHdpbGwgcmVh
Y3QgYWNjb3JkaW5nbHkgYnkgYWRqdXN0aW5nIHRoZSByZXF1ZXN0ZWQgc2l6ZS4KCiAgICBTdWNo
IGEgZHJpdmVyPC0+ZGV2aWNlIHJlcXVlc3QgY291bGQgYmUgY29tbXVuaWNhdGVkIHZpYSBhbnkg
b3RoZXIKICAgIGNvbW11bmljYXRpb24gbWVjaGFuaXNtIHRvIHRoZSBoeXBlcnZpc29yLCBidXQg
aXQgYWxyZWFkeSBjYW1lIHVwIGEKICAgIGNvdXBsZSBvZiB0aW1lcyB0byBkbyBpdCB2aWEgdGhl
IHZpcnRpby1tZW0gcHJvdG9jb2wgZGlyZWN0bHkuCgoyKSBDb25maWd1cmUgdGhlIGh5cGVydmlz
b3IgdG8gaGF2ZSBhIGxvd2VyL3VwcGVyIHJhbmdlLiBXaXRoaW4gdGhhdAogICAgcmFuZ2UsIHJl
c2l6ZSByZXF1ZXN0cyBieSB0aGUgZHJpdmVyIGNhbiBiZSBncmFudGVkLiBUaGUgY3VycmVudAog
ICAgdmFsdWVzIG9mIHRoZXNlIHByb3BlcnRpZXMgY2FuIGJlIGV4cG9zZWQgdmlhIHRoZSBkZXZp
Y2UgdG8gdGhlCiAgICBkcml2ZXIgYXMgd2VsbC4KCklzIHRoYXQgd2hhdCB5b3UgYWxzbyBwcm9w
b3NpbmcgaGVyZT8gSWYgc28sIGdyZWF0LgoKPiAKPiBUaGlzIGRhZW1vbiBpcyBjdXJyZW50bHkg
aW4ganVzdCBCZXRhIHN0YWdlIG5vdyBhbmQgd2UgaGF2ZSBiYXNpYwo+IGZ1bmN0aW9uYWxpdHkg
cnVubmluZy4gV2UgYXJlIHlldCB0byBhZGQgbW9yZSBmbGVzaCB0byB0aGlzIHNjaGVtZSB0bwoK
R29vZCB0byBoZWFyIHRoYXQgdGhlIGJhc2ljcyBhcmUgcnVubmluZyB3aXRoIHZpcnRpby1tZW0g
KEkgYXNzdW1lIDopICkuCgo+IG1ha2Ugc3VyZSBhbnkgcG90ZW50aWFsIHJpc2tzIG9yIHNlY3Vy
aXR5IGNvbmNlcm5zIGFyZSB0YWtlbiBjYXJlIGFzIHdlbGwuCgpJdCB3b3VsZCBiZSBncmVhdCB0
byBkcmF3L2V4cGxhaW4gdGhlIGFyY2hpdGVjdHVyZSBpbiBtb3JlIGRldGFpbC4KCi0tIApUaGFu
a3MsCgpEYXZpZCAvIGRoaWxkZW5iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
