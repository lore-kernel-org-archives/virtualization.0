Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A99C25B6B
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 06:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D27048121D;
	Thu, 26 Oct 2023 06:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D27048121D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ALCpoZ5+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZS_AmWsiDyN; Thu, 26 Oct 2023 06:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 718F180EB8;
	Thu, 26 Oct 2023 06:49:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 718F180EB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50298C0039;
	Thu, 26 Oct 2023 06:49:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50D2BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BF6380EB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BF6380EB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xxEgI5FaYmY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:49:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7B2E80E7E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 06:49:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7B2E80E7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698302990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A819CxVjTt/0YD6znIYJAdPMk1RTWMLfMeumCnGtsqE=;
 b=ALCpoZ5+IGGGJlCtavHAlPHQzYoYjFNDAmrWdudMlNz0232UTY1Y66yb3QnDQlnDuAtH5n
 nl63Cg7si5nr5jQZM4ksiH60T3wTyB1NKyITzg2j2MKe2khiQdaqeSXzG5NwN2dnPx1eBO
 gKa6/l649Wg4QGm0dvHJPqE6amyfXCY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-QJGPkth3N72X6sLtR2hYTA-1; Thu, 26 Oct 2023 02:49:49 -0400
X-MC-Unique: QJGPkth3N72X6sLtR2hYTA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da7983d20so349680f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 23:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698302988; x=1698907788;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A819CxVjTt/0YD6znIYJAdPMk1RTWMLfMeumCnGtsqE=;
 b=Q5wt4Vw5PiBuG8LtloieRBsZpmeoxRrvbRpHXboaqqGS7uzlBeHajBk5NXvJHjj6yg
 2ZW+/DvWPlhTRJBZKQhnCW6pVS8AKBxh5Syg9c8yMgVxv3asIPor6mAhAOzUmcA60BFZ
 GQKa8adbWGRzJUc+WDTIo/ldj18nLnx45wJv6+i7RiVM3BOBX98uAWNjRb97G3sUVx5Q
 FjeH6rsLi94PeGiGKf5t6wEQYEL8MDFztBcUzO4yXnwyYPSDhmAkjeuzO4+C9jchcL9d
 xS6K/jcl4G/Bs3PruIke9AJ2V2KqjNGsaqvkHBsSBiyCmMrwogQrMPgzwb7LmgWsi2Wt
 AZLg==
X-Gm-Message-State: AOJu0Ywv3WkoO7dMHlCIGZexwSJ1U+1U0JuFweM6aGOH/EAbQ/aJuQ2S
 UWnvoDYcHiEhXl3Nycw5n6FxHr0EbQUJUiGEzAgGgpOtT0xEV/9M9qMjCKtAaWk6brrqXMsrgz6
 K9yNgIiHKlHp20tDuTEd5w5V0WR4GOWADefi8FW07eA==
X-Received: by 2002:a05:6000:984:b0:32d:bf1c:ce65 with SMTP id
 by4-20020a056000098400b0032dbf1cce65mr2167127wrb.22.1698302988582; 
 Wed, 25 Oct 2023 23:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOBG562yOR6ZE/N4d6D22qdUaQb1WQ+r+ZpRNQxlAYrJb19NbalLrCC21XyEwKRApTNcdacA==
X-Received: by 2002:a05:6000:984:b0:32d:bf1c:ce65 with SMTP id
 by4-20020a056000098400b0032dbf1cce65mr2167108wrb.22.1698302988230; 
 Wed, 25 Oct 2023 23:49:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
 by smtp.gmail.com with ESMTPSA id
 r4-20020adff704000000b0032d88e370basm13582521wrp.34.2023.10.25.23.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 23:49:47 -0700 (PDT)
Date: Thu, 26 Oct 2023 02:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231026024931-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com
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

T24gVGh1LCBPY3QgMjYsIDIwMjMgYXQgMDI6NDg6MDdQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6
Cj4gT24gVGh1LCBPY3QgMjYsIDIwMjMgYXQgMjo0MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDAx
OjA1OjMzQU0gKzA4MDAsIENpbmR5IEx1IHdyb3RlOgo+ID4gPiBIaSBBbGwKPiA+ID4gUmVhbGx5
IGFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5LCB0aGlzIGlzIHRoZSBkcmFmdCBSRkMgZm9yCj4gPiA+
IGlvbW11ZmQgc3VwcG9ydCBmb3IgdmRwYSwgVGhpcyBjb2RlIHByb3ZpZGVzIHRoZSBiYXNpYyBm
dW5jdGlvbgo+ID4gPiBmb3IgaW9tbXVmZCBzdXBwb3J0Cj4gPiA+Cj4gPiA+IFRoZSBjb2RlIHdh
cyB0ZXN0ZWQgYW5kIHBhc3NlZCBpbiBkZXZpY2UgdmRwYV9zaW1fbmV0Cj4gPiA+IFRoZSBxZW11
IGNvZGUgaXMKPiA+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2x1bHU2L2dpdGxhYnFlbXV0bXAvLS90
cmVlL2lvbW11ZmRSRkMKPiA+ID4gVGhlIGtlcm5lbCBjb2RlIGlzCj4gPiA+IGh0dHBzOi8vZ2l0
bGFiLmNvbS9sdWx1Ni92aG9zdC8tL3RyZWUvaW9tbXVmZFJGQwo+ID4gPgo+ID4gPiBUb0RvCj4g
PiA+IDEuIHRoaXMgY29kZSBpcyBvdXQgb2YgZGF0ZSBhbmQgbmVlZHMgdG8gY2xlYW4gYW5kIHJl
YmFzZSBvbiB0aGUgbGF0ZXN0IGNvZGUKPiA+ID4gMi4gdGhpcyBjb2RlIGhhcyBzb21lIHdvcmth
cm91bmQsIEkgU2tpcCB0aGUgY2hlY2sgZm9yCj4gPiA+IGlvbW11X2dyb3VwIGFuZCBDQUNIRV9D
T0hFUkVOQ1ksIGFsc28gc29tZSBtaXNjIGlzc3VlcyBsaWtlIG5lZWQgdG8gYWRkCj4gPiA+IG11
dGV4IGZvciBpb21tZmQgb3BlcmF0aW9ucwo+ID4gPiAzLiBvbmx5IHRlc3QgaW4gZW11bGF0ZWQg
ZGV2aWNlLCBvdGhlciBtb2RlcyBub3QgdGVzdGVkIHlldAo+ID4gPgo+ID4gPiBBZnRlciBhZGRy
ZXNzZWQgdGhlc2UgcHJvYmxlbXMgSSB3aWxsIHNlbmQgb3V0IGEgbmV3IHZlcnNpb24gZm9yIFJG
Qy4gSSB3aWxsCj4gPiA+IHByb3ZpZGUgdGhlIGNvZGUgaW4gMyB3ZWVrcwo+ID4KPiA+IFdoYXQn
cyB0aGUgc3RhdHVzIGhlcmU/Cj4gPgo+IEhpIE1pY2hhZWwKPiBUaGUgY29kZSBpcyBmaW5pc2hl
ZCwgYnV0IEkgZm91bmQgc29tZSBidWcgYWZ0ZXIgYWRkaW5nIHRoZSBzdXBwb3J0IGZvciBBU0lE
LAo+IHdpbGwgcG9zdCB0aGUgbmV3IHZlcnNpb24gYWZ0ZXIgdGhpcyBidWcgaXMgZml4ZWQsIHNo
b3VsZCBiZSBuZXh0IHdlZWsKPiBUaGFua3MKPiBDaW5keQoKCldlJ2xsIG1pc3MgdGhpcyBtZXJn
ZSB3aW5kb3cgdGhlbi4KCj4gPiAtLQo+ID4gTVNUCj4gPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
