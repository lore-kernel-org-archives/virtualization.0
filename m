Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06C1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 17:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50D0D82907;
	Wed, 20 Apr 2022 17:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSYfgpXhfKXZ; Wed, 20 Apr 2022 17:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB1778144C;
	Wed, 20 Apr 2022 17:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91F56C002F;
	Wed, 20 Apr 2022 17:55:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78896C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64DFE40CAE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AC-nsRBaGFE2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:55:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E51C404F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650477300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf/b7tr89YAslHSAj9ZgCyF+UU4n8y//tG4TTcCLlvM=;
 b=GiAWYhajDZC2MIKWoO5/TsaQg4umidqEX8Zn+pcZ/y7EOXMndIza8zji/9K1FKBJs8wk68
 TU5A1ZmHekO2hkvNQNReTrdoBtjUwmyW4yIHLYO00cB3AjkrTGnvRyFSkBgquF/rnZkZ0m
 nrtYgMUW+hpVSmLueLeCwvySoQXt6vw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-fE5Go1w2MYqPnJf3niWyoQ-1; Wed, 20 Apr 2022 13:54:59 -0400
X-MC-Unique: fE5Go1w2MYqPnJf3niWyoQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 h61-20020adf9043000000b002079bbaa5d3so601992wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 10:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zf/b7tr89YAslHSAj9ZgCyF+UU4n8y//tG4TTcCLlvM=;
 b=HiS16BYvIQmwWkDepSPerb3HjziLLOpTF3sz9A1KOl8oIrYRG81QSV85oNw0WmEL0V
 9RXiKMm/8srf1r9sepp3icSyFmHAnINldFba1Ov5sTWbzfzWPjH2x6q43A+WW7cB0HuW
 fTFcgb08QXD/Qk/2X8Lbqomln1EEWmPbDZlH/4GEqYd/tHDZo0zmp6zCkXFajqNs7+MO
 3DVxeT8nRROlhvinaBfEQSvDlp7QjOHz6TsESjPHIdQwmiDOxKDLjZzUljqNmxemfp/A
 7F2BnUX8mOEXLllD/u5oXVS7SPsgtyZYJlqpywQedopnKpX28DXI0x+7VUkecvvYVEFg
 1PhQ==
X-Gm-Message-State: AOAM530vz9h3+OVRzaRge1WK2jiUu2UydiZYhlzVt2yzDmDpFtqWwHyq
 wHV8MAab7G9UCyIBvkv/oBU/kizgj+pV/m/YeoV3ElAT3UiowWJZ4hWEmaNrpqBSUi4yddxam1s
 4oxgTpYXtOvihq3CTxUYfwq6se8VBkkXgb4Orgj5gDw==
X-Received: by 2002:a1c:e911:0:b0:38e:6c5d:40e5 with SMTP id
 q17-20020a1ce911000000b0038e6c5d40e5mr4791591wmc.116.1650477298685; 
 Wed, 20 Apr 2022 10:54:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP5t8YfgHCPhLeUUewG3hfHenPnEMsmI1Ydu1bS8SJ0h6EHW2THyQD94WR8/6bKTJ03mzhZw==
X-Received: by 2002:a1c:e911:0:b0:38e:6c5d:40e5 with SMTP id
 q17-20020a1ce911000000b0038e6c5d40e5mr4791576wmc.116.1650477298433; 
 Wed, 20 Apr 2022 10:54:58 -0700 (PDT)
Received: from redhat.com ([2.53.17.80]) by smtp.gmail.com with ESMTPSA id
 z17-20020adfec91000000b0020a98f5f8a7sm391183wrn.6.2022.04.20.10.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 10:54:57 -0700 (PDT)
Date: Wed, 20 Apr 2022 13:54:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maciej =?utf-8?Q?Szyma=C5=84ski?= <maciej.szymanski@opensynergy.com>
Subject: Re: virtio-net: Unpermitted usage of virtqueue before virtio driver
 initialization
Message-ID: <20220420134755-mutt-send-email-mst@kernel.org>
References: <c0c17b91-747e-ab58-83e5-b6f7dfa55e75@opensynergy.com>
 <20220419103826-mutt-send-email-mst@kernel.org>
 <CACGkMEvJu8ADk=+QJryDfuh9y8pXzfYQ3KRg0Lq0POH3Z-SHuQ@mail.gmail.com>
 <20220420023511-mutt-send-email-mst@kernel.org>
 <4080d799-b42e-018a-8b14-621295e55a8d@opensynergy.com>
 <b4899534-8c08-ddfc-dea0-460a94b00c32@redhat.com>
 <0a118236-bb98-9183-8be2-84f6b83e2581@opensynergy.com>
 <20220420070944-mutt-send-email-mst@kernel.org>
 <4050a523-85a8-0f3c-b7de-c371a42c8f6c@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <4050a523-85a8-0f3c-b7de-c371a42c8f6c@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMDQ6NTg6NTFQTSArMDIwMCwgTWFjaWVqIFN6eW1hxYRz
a2kgd3JvdGU6Cj4gT24gMjAuMDQuMjAyMiAxMzoxMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBBcHIgMjAsIDIwMjIgYXQgMTA6MTc6MjdBTSArMDIwMCwgTWFjaWVqIFN6
eW1hxYRza2kgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBIbW0gc28gd2UgaGF2ZSB0aGlzOgo+ID4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICBp
ZiAoKGRldi0+ZmVhdHVyZXMgXiBmZWF0dXJlcykgJiBORVRJRl9GX0dST19IVykgewo+ID4gPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgaWYgKHZpLT54ZHBfZW5hYmxlZCkKPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsKPiA+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYg
TkVUSUZfRl9HUk9fSFcpCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
IG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGU7Cj4gPiA+ID4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICBlbHNlCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG9mZmxvYWRzID0gdmktPmd1ZXN0X29mZmxvYWRzX2NhcGFibGUgJgo+ID4gPiA+ID4g
PiA+ID4gfkdVRVNUX09GRkxPQURfR1JPX0hXX01BU0s7Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgIGVyciA9IHZpcnRuZXRfc2V0X2d1ZXN0X29mZmxv
YWRzKHZpLCBvZmZsb2Fkcyk7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICBpZiAo
ZXJyKQo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Owo+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgdmktPmd1ZXN0X29mZmxvYWRzID0g
b2ZmbG9hZHM7Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgfQo+ID4gPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+ID4gPiB3aGljaCBJIGd1ZXNzIHNob3VsZCBoYXZlIHByZXZlbnRlZCB2aXJ0bmV0
X3NldF9ndWVzdF9vZmZsb2Fkcwo+ID4gPiA+ID4gPiA+ID4gZnJvbSBldmVyIHJ1bm5pbmcuCj4g
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ICAgRnJvbSB5b3VyIGRlc2NyaXB0aW9uIGl0
IHNvdW5kcyBsaWtlIHlvdSBoYXZlIG9ic2VydmVkIHRoaXMKPiA+ID4gPiA+ID4gPiA+IGluIHBy
YWN0aWNlLCByaWdodD8KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gWWVzLiBJIGhhdmUgcHJv
cHJpZXRhcnkgdmlydGlvLW5ldCBkZXZpY2Ugd2hpY2ggYWR2ZXJ0aXNlcyBmb2xsb3dpbmcKPiA+
ID4gPiA+IGd1ZXN0IG9mZmxvYWQgZmVhdHVyZXMgOgo+ID4gPiA+ID4gLSBWSVJUSU9fTkVUX0Zf
R1VFU1RfQ1NVTQo+ID4gPiA+ID4gLSBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNAo+ID4gPiA+ID4g
LSBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNgo+ID4gPiA+ID4gLSBWSVJUSU9fTkVUX0ZfR1VFU1Rf
VUZPCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoaXMgZmVhdHVyZSBzZXQgcGFzc2VzIHRoZSBjb25k
aXRpb24gaW4gdmlydG5ldF9zZXRfZmVhdHVyZXMuCj4gPiBTbyB3aHkgaXNuJ3QgZGV2LT5mZWF0
dXJlcyBlcXVhbCB0byBmZWF0dXJlcz8KPiA+IAo+IEkganVzdCBkb3VibGUgdmVyaWZpZWQgYW5k
IGZvdW5kIHRoYXQgbXkgZGV2aWNlIGFkdmVydGlzZXMKPiBWSVJUSU9fTkVUX0dVRVNUX1RTTzQg
YW5kIFZJUlRJT19ORVRfRl9HVUVTVF9UU082IGJ1dCBub3QKPiBWSVJUSU9fTkVUX0ZfR1VFU1Rf
Q1NVTSBhcyBtZW50aW9uZWQgYmVmb3JlLgoKU28sIHlvdXIgZGV2aWNlIGlzIG91dCBvZiBzcGVj
OgoKVklSVElPX05FVF9GX0dVRVNUX1RTTzQgUmVxdWlyZXMgVklSVElPX05FVF9GX0dVRVNUX0NT
VU0uCgpBbmQKClRoZSBkZXZpY2UgTVVTVCBOT1Qgb2ZmZXIgYSBmZWF0dXJlIHdoaWNoIHJlcXVp
cmVzIGFub3RoZXIgZmVhdHVyZSB3aGljaCB3YXMgbm90IG9mZmVyZWQuCgoKSXMgdGhpcyBhIHBy
b2R1Y3Rpb24gZGV2aWNlPyBDYW4gaXQgYmUgZml4ZWQ/CgoKPiBUaGF0IGxlYWRzIHRvIHRoZSBm
b2xsb3dpbmcgc2l0dWF0aW9uIDoKPiAKPiBpbiB2aXJ0aW9fcHJvYmUgOgo+IAo+ICAgaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkpCj4gICAgIGRl
di0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9SWENTVU07Cj4gICBpZiAodmlydGlvX2hhc19mZWF0dXJl
KHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU080KSB8fAo+ICAgICAgIHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNikpCj4gICAgIGRldi0+ZmVhdHVyZXMg
fD0gTkVUSUZfRl9HUk9fSFc7Cj4gICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJ
T19ORVRfRl9DVFJMX0dVRVNUX09GRkxPQURTKSkKPiAgICAgZGV2LT5od19mZWF0dXJlcyB8PSBO
RVRJRl9GX0dST19IVzsKPgo+Cj4gd2hpbGUgaW4gbmV0ZGV2X2ZpeF9mZWF0dXJlcyA6Cj4gCj4g
ICBpZiAoIShmZWF0dXJlcyAmIE5FVElGX0ZfUlhDU1VNKSkgewo+ICAgICAvKiBORVRJRl9GX0dS
T19IVyBpbXBsaWVzIGRvaW5nIFJYQ1NVTSBzaW5jZSBldmVyeSBwYWNrZXQKPiAgICAgICogc3Vj
Y2Vzc2Z1bGx5IG1lcmdlZCBieSBoYXJkd2FyZSBtdXN0IGFsc28gaGF2ZSB0aGUKPiAgICAgICog
Y2hlY2tzdW0gdmVyaWZpZWQgYnkgaGFyZHdhcmUuICBJZiB0aGUgdXNlciBkb2VzIG5vdAo+ICAg
ICAgKiB3YW50IHRvIGVuYWJsZSBSWENTVU0sIGxvZ2ljYWxseSwgd2Ugc2hvdWxkIGRpc2FibGUg
R1JPX0hXLgo+ICAgICAgKi8KPiAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpIHsK
PiAgICAgICBuZXRkZXZfZGJnKGRldiwgIkRyb3BwaW5nIE5FVElGX0ZfR1JPX0hXIHNpbmNlIG5v
IFJYQ1NVTQo+IGZlYXR1cmUuXG4iKTsKPiAgICAgICBmZWF0dXJlcyAmPSB+TkVUSUZfRl9HUk9f
SFc7Cj4gICAgIH0KPiAgIH0KPiAKPiBBcyByZXN1bHQgZGV2LT5mZWF0dXJlcyBhbmQgZmVhdHVy
ZXMgcGFzc2VkIGZyb20KPiBfX25ldGRldl91cGRhdGVfZmVhdHVyZXMgZGlmZmVycyBleGFjdGx5
IGluIE5FVElGX0ZfR1JPX0hXIGJpdC4KPiAKPiAKPiBQbGVhc2UgbWluZCBvdXIgcHJpdmFjeSBu
b3RpY2U8aHR0cHM6Ly93d3cub3BlbnN5bmVyZ3kuY29tL2RhdGVuc2NodXR6ZXJrbGFlcnVuZy9w
cml2YWN5LW5vdGljZS1mb3ItYnVzaW5lc3MtcGFydG5lcnMtcHVyc3VhbnQtdG8tYXJ0aWNsZS0x
My1vZi10aGUtZ2VuZXJhbC1kYXRhLXByb3RlY3Rpb24tcmVndWxhdGlvbi1nZHByLz4gcHVyc3Vh
bnQgdG8gQXJ0LiAxMyBHRFBSLiAvLyBVbnNlcmUgSGlud2Vpc2UgenVtIERhdGVuc2NodXR6IGdl
bS4gQXJ0LiAxMyBEU0dWTyBmaW5kZW4gU2llIGhpZXIuPGh0dHBzOi8vd3d3Lm9wZW5zeW5lcmd5
LmNvbS9kZS9kYXRlbnNjaHV0emVya2xhZXJ1bmcvZGF0ZW5zY2h1dHpoaW53ZWlzZS1mdWVyLWdl
c2NoYWVmdHNwYXJ0bmVyLWdlbS1hcnQtMTMtZHNndm8vPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
