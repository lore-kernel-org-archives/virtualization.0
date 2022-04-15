Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C85C433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 03:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF5D840377;
	Fri, 15 Apr 2022 03:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FDH8-srgcJpq; Fri, 15 Apr 2022 03:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F2FF40181;
	Fri, 15 Apr 2022 03:00:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A2AC0033;
	Fri, 15 Apr 2022 03:00:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98E80C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 03:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F9B340181
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 03:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDL9rlOPXZOH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 03:00:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6121240022
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649991645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tA0uDOIQJO8DmINdwnol/uT15UPPYSx+8xWvdjqUWss=;
 b=ecvNd/v8Cx5o9F5O+k+D1JIuUWSql4lK8L6HaBQgDRUvvsje5X7JpbnEAZ6m2WkztmhAe9
 yFM9sEEUWGwo3ytLxFjU8/pEVN06RGa5w/LfVXL2FyLDGjZzycV3QVOlU9eJtlWF+6S0w1
 9vi3BGfzdisZi+v4i4U0wuh4WktVvWg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580--QFESJWOPRu9fI-Zm11YaQ-1; Thu, 14 Apr 2022 23:00:42 -0400
X-MC-Unique: -QFESJWOPRu9fI-Zm11YaQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 64-20020a630843000000b0039d909676d5so3617915pgi.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 20:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=tA0uDOIQJO8DmINdwnol/uT15UPPYSx+8xWvdjqUWss=;
 b=HnK0RuG/QM6sp40x0JBcU9uED14kBFGHLmSJBFe6p0iisCc5i/6aozbXU2Jb+kESuE
 y7ZHD/suufoneczw4Kj44RxN8aa95FLLGhRqvT6RSFMN2Dty45W96mrLtBdFPozQC/cZ
 c+8OEtIETfBWAvwHEnt6T6rL1wl58BerwtBoi0N3cuzLgwqzZkLbIXGpxZbtTonAhGc+
 cHZRGuHtw+ebNxSrJgb7Oe8Vzfw6Scwc5LObBfM5tkmVpzRXduH//73ixLlwHTbOHkIS
 21tmqngxoSg45LqTqS0hobXad3bzo802NpXKh5HH4TyeA+kVWv8HT/E5XBHbm+9WOWQk
 D4RA==
X-Gm-Message-State: AOAM530Kk1kRzoNUhjWlzxBqiIDyBp0BKx57WHAvLvi+PKIyfMSJPlMX
 6z5EsmyFlb9hbcpNtr1iQ+pGzOrhi2HyYmeaBtKvpKO2PxcIQ8DXqbLXGh19eaAKHNGhGQmu3Bo
 LIh76e+HhzJEBU27hBuPszSFK+RXoXGepRDn0LDhfXw==
X-Received: by 2002:a17:903:3014:b0:158:921b:6ebe with SMTP id
 o20-20020a170903301400b00158921b6ebemr13621628pla.164.1649991641864; 
 Thu, 14 Apr 2022 20:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyBudUwUFp5mBEDDIs5/uq0/x9ilfdL7IEMpmHyK5nTFf0nJ5B53+sjXRM1FKAUPSg5wPhfg==
X-Received: by 2002:a17:903:3014:b0:158:921b:6ebe with SMTP id
 o20-20020a170903301400b00158921b6ebemr13621599pla.164.1649991641471; 
 Thu, 14 Apr 2022 20:00:41 -0700 (PDT)
Received: from [10.72.13.51] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a17090a5e0d00b001c7d4099670sm3190794pjf.28.2022.04.14.20.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Apr 2022 20:00:40 -0700 (PDT)
Message-ID: <87985be4-8cb0-2292-d799-5a91fb32acda@redhat.com>
Date: Fri, 15 Apr 2022 11:00:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] virtio_net: Add control VQ struct to carry vlan id
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com
References: <20220411122942.225717-1-elic@nvidia.com>
 <20220411122942.225717-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220411122942.225717-3-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: si-wei.liu@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzQvMTEgMjA6MjksIEVsaSBDb2hlbiDlhpnpgZM6Cj4gQWRkIHN0cnVjdHVyZSB0
byBkZWZpbmUgdGhlIHBheWxvYWQgb2YgY29udHJvbCBWUSBtZXNzYWdlcyBjYXJyeWluZyB0aGUK
PiBjb25maWd1cmVkIHZsYW4gSUQuIEl0IHdpbGwgYmUgdXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNo
ZXMgb2YgdGhpcwo+IHNlcmllcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCB8IDMg
KysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0
aW9fbmV0LmgKPiBpbmRleCAzZjU1YTQyMTVmMTEuLmI5NGE0MDVmYThkMiAxMDA2NDQKPiAtLS0g
YS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19uZXQuaAo+IEBAIC0yNzAsNiArMjcwLDkgQEAgc3RydWN0IHZpcnRpb19uZXRf
Y3RybF9tYWMgewo+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfVkxBTiAgICAgICAyCj4gICAg
I2RlZmluZSBWSVJUSU9fTkVUX0NUUkxfVkxBTl9BREQgICAgICAgICAgICAgMAo+ICAgICNkZWZp
bmUgVklSVElPX05FVF9DVFJMX1ZMQU5fREVMICAgICAgICAgICAgIDEKPiArc3RydWN0IHZpcnRp
b19uZXRfY3RybF92bGFuIHsKPiArCV9fdmlydGlvMTYgaWQ7Cj4gK307CgoKSXQgbG9va3MgdG8g
bWUgdGhlcmUncyBubyBuZWVkIHRvIGJvdGhlciB1QVBJIGFuZCB3ZSBjYW4gc2ltcGx5IHVzZSAK
X192aXJ0aW8xNiBpbiBwYXRjaCAzPwoKVGhhbmtzCgoKPiAgIAo+ICAgLyoKPiAgICAqIENvbnRy
b2wgbGluayBhbm5vdW5jZSBhY2tub3dsZWRnZW1lbnQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
