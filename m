Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B4FC64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1B204183E;
	Wed,  8 Mar 2023 14:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1B204183E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EWFaV14V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tw1M4WLkMkCI; Wed,  8 Mar 2023 14:16:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD09A41835;
	Wed,  8 Mar 2023 14:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD09A41835
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99C4DC0071;
	Wed,  8 Mar 2023 14:16:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE85CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 968E94183D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 968E94183D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qGAaDiDLKjRu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96B0D41835
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96B0D41835
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678284968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfZYe+kVp7t8ATPaeyVDKI3woZqxEgv/0sSkiCPknkQ=;
 b=EWFaV14VDOyglPbl+Wg0YzJtHBQ5obQo7WZGkzWIj85r5Pn32fna2DFh+43Wj/5DAPep2l
 /w52suf4weuhSs79+qwVXLjqHrvRVe0Euy2l/eTarrZLdIuVt8YEh+OKhQOTR7qdo8hF7D
 Fz5VysxkriNUuPHqsZ8SyYt74jzYvkA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-_8CKuCIKPYK30MaElGtnoQ-1; Wed, 08 Mar 2023 09:16:07 -0500
X-MC-Unique: _8CKuCIKPYK30MaElGtnoQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 z14-20020a05640235ce00b004e07ddbc2f8so15325200edc.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678284966;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfZYe+kVp7t8ATPaeyVDKI3woZqxEgv/0sSkiCPknkQ=;
 b=dPD+q/wRrXMjmKHCwnCPhMYVgtPw4fhxvBoaNZRy8N/BdHzcUOQoaEoiEQyRzGqZCQ
 VdCwjqLklli7tpnzeAi6sRMo/+vfW2cZrLxsEk1B3dLEe2Qte+3UBgBOQ5/snE9Yozwb
 MS/P8nFhLfxbEk6afUs5xYkN8PEbSU8QYxqLjRdT147TQ06ZOQrITUzT9Ar+/RcrmQgP
 9PMCyV72kuDJ09WNeVl4QmGmzhz9zF5nYxrAjuPel+OPVq3T1t3FmL2ZdY7kgtmu+VzF
 EhhgarmRYAYbhasS9PlGzfyfIGGsO+TPUD3w/PFGYxq37Vz9pSjQbg5vVkffuwbHZP+L
 kjyg==
X-Gm-Message-State: AO0yUKU6Ct8kCkYNWRule2t73RH5RcoJIy3pixSQXTL2NIXxgrJToXSh
 8VJpo43jAeWTA737TV//DbFUwq4kgvbrxQ66k5sLkISKu3NBTerAmrO8ir/B1w1MnrHVbzLSsiC
 c/AAJQM83iX44C29YBdNKE8bHMvytRqwp0F78iirGCw==
X-Received: by 2002:a17:906:af18:b0:8aa:c155:9233 with SMTP id
 lx24-20020a170906af1800b008aac1559233mr17654564ejb.26.1678284966327; 
 Wed, 08 Mar 2023 06:16:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/fweoDPXvwqMsH9l5ZXTF7xQQKM36+ghU1qVk/lWB4ZCw8uku8fpbjlFXrIMwt+Oy8xChG7A==
X-Received: by 2002:a17:906:af18:b0:8aa:c155:9233 with SMTP id
 lx24-20020a170906af1800b008aac1559233mr17654544ejb.26.1678284966048; 
 Wed, 08 Mar 2023 06:16:06 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 p23-20020a170906615700b008d5d721f8a4sm7483817ejl.197.2023.03.08.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:16:05 -0800 (PST)
Date: Wed, 8 Mar 2023 09:16:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308091442-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

T24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMDk6MDc6NDlBTSAtMDUwMCwgRmVuZyBMaXUgd3JvdGU6
Cj4gCj4gCj4gT24gMjAyMy0wMy0wOCBhLm0uMTI6NTgsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+
ID4gCj4gPiAKPiA+IE9uIFR1ZSwgTWFyIDcsIDIwMjMgYXQgMTE6NTfigK9BTSBGZW5nIExpdSA8
ZmVsaXVAbnZpZGlhLmNvbT4gd3JvdGU6Cj4gPiA+IAo+ID4gPiBBZGQgY29uc3QgdG8gbWFrZSB0
aGUgcmVhZC1vbmx5IHBvaW50ZXIgcGFyYW1ldGVycyBjbGVhciwgc2ltaWxhciB0bwo+ID4gPiBt
YW55IGV4aXN0aW5nIGZ1bmN0aW9ucy4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZlbmcg
TGl1IDxmZWxpdUBudmlkaWEuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amly
aUBudmlkaWEuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlk
aWEuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogR2F2aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+
ID4gPiBSZXZpZXdlZC1ieTogQm9kb25nIFdhbmcgPGJvZG9uZ0BudmlkaWEuY29tPgo+ID4gPiAt
LS0KPiA+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjUgKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLQo+ID4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAxMiAr
KysrKystLS0tLS0KPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+IAo+ID4gWy4uLl0KPiA+IAo+ID4gPiAKPiA+ID4gLS8q
Cj4gPiA+IC0gKiBUaGlzIHNob3VsZCBwcmV2ZW50IHRoZSBkZXZpY2UgZnJvbSBiZWluZyB1c2Vk
LCBhbGxvd2luZyBkcml2ZXJzIHRvCj4gPiA+ICsvIFRoaXMgc2hvdWxkIHByZXZlbnQgdGhlIGRl
dmljZSBmcm9tIGJlaW5nIHVzZWQsIGFsbG93aW5nIGRyaXZlcnMgdG8KPiA+ID4gICAgKiByZWNv
dmVyLiAgWW91IG1heSBuZWVkIHRvIGdyYWIgYXBwcm9wcmlhdGUgbG9ja3MgdG8gZmx1c2guCj4g
PiA+ICAgICovCj4gPiAKPiA+IEFueSByZWFzb24gZm9yIHRoaXMgY2hhbmdlPwo+ID4gCj4gSGks
IEphc29uCj4gVGhlIG9yaWdpbmFsIGNvbW1lbnQgb2YgdGhlIGNvZGUgaGFkIGEgc3ludGF4IHBy
b2JsZW0gYW5kIGNvdWxkbid0IGNvbXBpbGUsCj4gSSBmaXhlZCBpdCBoZXJlCgpUaGlzIGlzIGhv
dyBpdCBsb29rZWQgYmVmb3JlIHlvdXIgcGF0Y2g6CgovKgogKiBUaGlzIHNob3VsZCBwcmV2ZW50
IHRoZSBkZXZpY2UgZnJvbSBiZWluZyB1c2VkLCBhbGxvd2luZyBkcml2ZXJzIHRvCiAqIHJlY292
ZXIuICBZb3UgbWF5IG5lZWQgdG8gZ3JhYiBhcHByb3ByaWF0ZSBsb2NrcyB0byBmbHVzaC4KICov
CgpJIHNlZSBubyBwcm9ibGVtIGhlcmUuCgoKPiA+IFRoYW5rcwo+ID4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
