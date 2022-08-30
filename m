Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19EBECAAA1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 08:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CB45409E7;
	Tue, 30 Aug 2022 08:21:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CB45409E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ahhfxcvl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LY_-UqN96jeJ; Tue, 30 Aug 2022 08:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3BA9409BE;
	Tue, 30 Aug 2022 08:21:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3BA9409BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 882A2C0032;
	Tue, 30 Aug 2022 08:21:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21314C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 08:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8899409E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 08:21:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8899409E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mr771Lv3N-ZI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 08:21:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF2ED409BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF2ED409BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 08:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661847678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFZmgRNIvDHnsZ4hZFWkKMoxYa2ZAAr70hkEo3k5QfM=;
 b=AhhfxcvlY8H1tQA1gv5utvig1iEDDyo9VSCw/uGTrbhIoIKUwvB9C+X2Td/yxKua1GwzO3
 sR/9AUJyGqSZVydvfZQBi7OKc0+NQU821uyTu1Qh7EQXvWB3ceulLShQWxsAqp3nJJcZvm
 Ty+vAYA1IlIX0bl+GeVBLMIO6PoH+xs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-M7E4TRPOMj-Or4ajydvu5g-1; Tue, 30 Aug 2022 04:21:16 -0400
X-MC-Unique: M7E4TRPOMj-Or4ajydvu5g-1
Received: by mail-wm1-f71.google.com with SMTP id
 v67-20020a1cac46000000b003a615c4893dso6300556wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=jFZmgRNIvDHnsZ4hZFWkKMoxYa2ZAAr70hkEo3k5QfM=;
 b=ddFop2oYJ//KPu8Yiw1HhuuatnOxPfO/CdeycbmJtj5pQ/3HhTeHembiJMjg/md8rg
 yjeHnZwRaJ7BlPXQGlPlUoHFW4qKJZZRP+fonjjsBFLpVzHethvFcK+33IicISpK2JqA
 1VX7dKPtXmi24siZzDozRy74tMS8Vyvz4SvSue7+EH+7VO2yN0e7tGbG6gsKxyOFkhk0
 Hp0NFfAVadfOlCNqvShb2logKurAq4NeEqFkwLsXo2umI2dVn2KDoU/KFzaMBadtTi3I
 WFJzf3DwZUce3TwFtqpSi/lCGMN1AInV83K+sVhYRnC282OWrot+eA1khsbZILdjb8Mg
 6K+A==
X-Gm-Message-State: ACgBeo3RCyDUCibaIVxgF6a/6Wna2NSbqROwelJTjMrmzNc45HsnvJGu
 IRJAcdxw2aRDJ7qtdnk/Y4q/QJ+7TlsATMyIUWFAEOG1W4T2E8NzBw1u8gCdsFsRoPoQQ6mUYCY
 D247dFaBzVGQdLktboYau+JsZjo9qOlvkOpoIR1JtmA==
X-Received: by 2002:a05:6000:137b:b0:226:d465:c8a7 with SMTP id
 q27-20020a056000137b00b00226d465c8a7mr6895186wrz.306.1661847675144; 
 Tue, 30 Aug 2022 01:21:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5iJ3tqF17X5OWuYSwVw2t9iiLJ6tEzlAoVKQMS3rhSUtE7o0N8HTuHkqFdW1TniJdS5/zeXQ==
X-Received: by 2002:a05:6000:137b:b0:226:d465:c8a7 with SMTP id
 q27-20020a056000137b00b00226d465c8a7mr6895171wrz.306.1661847674904; 
 Tue, 30 Aug 2022 01:21:14 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c3b9200b003a846a014c1sm7250048wms.23.2022.08.30.01.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 01:21:14 -0700 (PDT)
Date: Tue, 30 Aug 2022 04:21:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: RFC: control virtqueue size by the vdpa tool
Message-ID: <20220830041757-mutt-send-email-mst@kernel.org>
References: <DM8PR12MB5400FEB0322A9FD6B3271D45AB799@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400FEB0322A9FD6B3271D45AB799@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDY6MjI6MzFBTSArMDAwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+ICAKPiAKPiBIaSwKPiAKPiAgCj4gCj4gSSBoYXZlIGJlZW4gZXhwZXJpbWVudGluZyB3aXRo
IGRpZmZlcmVudCBxdWV1ZSBzaXplcyB3aXRoIG1seDVfdmRwYSBhbmQgbm90aWNlZAo+IHRoYXQg
cXVldWUgc2l6ZSBjYW4gYWZmZWN0IHBlcmZvcm1hbmNlLgoKQWJzb2x1dGVseS4gQ2FuIHlvdSBz
aGFyZSB0aGUgcmVzdWx0cyBidHc/IFdvdWxkIGJlIHZlcnkgaW50ZXJlc3RpbmcuCgo+IEkgd291
bGQgbGlrZSB0byBwcm9wb3NlIGFuIGV4dGVuc2lvbiB0byB2ZHBhIHRvb2wgdG8gYWxsb3cgdG8g
c3BlY2lmeSB0aGUgcXVldWUKPiBzaXplLiBWYWxpZCB2YWx1ZXMgd2lsbCBjb25mb3JtIHRvIHRo
ZSBtYXggb2YgMzI3Njggc3BlY2lmaWVkIGJ5IHRoZSBzcGVjLgo+IAo+ICAKPiAKPiDigJx2ZHBh
IG1nbXRkZXYgc2hvd+KAnSB3aWxsIGhhdmUgYW5vdGhlciBsaW5lIHNwZWNpZnlpbmcgdGhlIHZh
bGlkIHJhbmdlIGZvciBhCj4gbWFuYWdlbWVudCBkZXZpY2Ugd2hpY2ggY291bGQgYmUgbmFycm93
ZXIgdGhhbiB0aGUgc3BlYyBhbGxvd3MuIFRoaXMgcmFuZ2Ugd2lsbAo+IGJlIHZhbGlkIGZvciBk
YXRhIHF1ZXVlcyBvbmx5IChub3QgZm9yIGNvbnRyb2wgVlEpLgo+IAo+IEFub3RoZXIgbGluZSB3
aWxsIGRpc3BsYXkgdGhlIGRlZmF1bHQgcXVldWUgc2l6ZQo+IAo+ICAKPiAKPiBFeGFtcGxlOgo+
IAo+ICQgdmRwYSBtZ210ZGV2IHNob3cKPiAKPiBhdXhpbGlhcnkvbWx4NV9jb3JlLnNmLjY6Cj4g
Cj4gICBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKPiAKPiAgIG1heF9zdXBwb3J0ZWRfdnFzIDY1Cj4g
Cj4gICBkZXZfZmVhdHVyZXMgQ1NVTSBHVUVTVF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082
IFNUQVRVUyBDVFJMX1ZRIENUUkxfVkxBTgo+IE1RIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xIEFD
Q0VTU19QTEFURk9STQo+IAo+ICAgZGF0YSBxdWV1ZSByYW5nZSAyNTYtNDA5Ngo+IAo+ICAgZGVm
YXVsdCBxdWV1ZSBzaXplIDI1Ngo+IAo+ICAKPiAKPiBXaGVuIHlvdSBjcmVhdGUgdGhlIHZkcGEg
ZGV2aWNlIHlvdSBjYW4gc3BlY2lmeSB0aGUgcmVxdWVzdGVkIHZhbHVlOgo+IAo+ICQgdmRwYSBk
ZXYgYWRkIG5hbWUgdmRwYS1hIG1nbXRkZXYgYXV4aWxpYXJ5L21seDVfY29yZS5zZi42IG1heF92
cXAgMSBtdHUgOTAwMAo+IHF1ZXVlX3NpemUgMTAyNAo+IAo+ICAKCk1ha2VzIHNlbnNlIHRvIG1l
LCBob3dldmVyLCBub3RlIHRoYXQKMS4gdGhlIHZhbHVlIGNvbnRyb2xsZWQgZnJvbSB0aGUgaG9z
dCBpcyBhY3R1YWxseSB0aGUgbWF4IHF1ZXVlIHNpemUKICAgbm90IHRoZSBxdWV1ZSBzaXplLiBx
dWV1ZSBzaXplIGNhbiBiZSBjb250cm9sbGVkIGZyb20gZ3Vlc3Qgd2l0aAogICB0aGUgcmVjZW50
IHJlc2V0IGV4dGVuc2lvbgoyLiBkaWZmZXJlbnQgc2l6ZXMgZm9yIHJ4IGFuZCB0eCBwcm9iYWJs
eSBtYWtlIHNlbnNlCgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
