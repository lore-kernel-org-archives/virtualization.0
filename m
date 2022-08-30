Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA543ECAAD5
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 19:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42FC760FBB;
	Tue, 30 Aug 2022 19:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42FC760FBB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WdEq7E/F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inomJM1YBCjU; Tue, 30 Aug 2022 19:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF11A60FE1;
	Tue, 30 Aug 2022 19:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF11A60FE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83C21C0032;
	Tue, 30 Aug 2022 19:58:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6ABC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 19:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E3F682572
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 19:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E3F682572
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WdEq7E/F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DbTdeKhWB_sO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 19:58:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82909813B3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82909813B3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661889515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xu77oEXBsciH9e9dITWGZ13GF1vtWYJSoCK7U0+U5Hk=;
 b=WdEq7E/FugdrWTU9rK6Ym3Y7J8iUb3EvOTfLyqt1OmvHuE0+BWhK6iQhlI0huvd3ivvwH1
 9CWxxj2biUSQiJ9X5GgZP/CcJMuZZel5bsUj9hvcYJcYQX63vdG8teaUWiEuPMzd8NfTWu
 a2+mROUlVVP1H+JChdpPXo2FJ+T9UVE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-DQl_F1AePxyOLN3Rb39qcw-1; Tue, 30 Aug 2022 15:58:34 -0400
X-MC-Unique: DQl_F1AePxyOLN3Rb39qcw-1
Received: by mail-wm1-f69.google.com with SMTP id
 v3-20020a1cac03000000b003a7012c430dso7826290wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 12:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=Xu77oEXBsciH9e9dITWGZ13GF1vtWYJSoCK7U0+U5Hk=;
 b=5qfIc3eMRuvPk46L5bP5y0BpeOpF4Ft05qoFlzbN8EfG9Qlr5uFZqUJOJawLFvFvAF
 qHuOc/RDxCahnsym6xw2M6rsXo1XipHaKiaKD425k9vl3Qfbp3CrS9alaZirRw1P/+1I
 HfSWgZi/3oMg+zjfXa74o2zowCVQ/LmAUPSarNXzmOvuH+VpnjLKFFuPVXmBOnhtbj5U
 l8rSMs7To3awGk30eN0y6LkaWL83CtOGoCNigD5zVwBhSPsKcWVyqeTBibWfXxnIkMFD
 AlC87pE0R1mHdaz0YB+CYG9LALZnnLND62g0ovW8UBAD5jSfIwSoNpIJrz4/Tf+tQvBQ
 wRYg==
X-Gm-Message-State: ACgBeo2PiAJdfcg4gYIJHT2RPdebKpzhA40Fehl4VbZogP01KGlbxVsJ
 X9dgA2ZV10Ek/BirLQxMTVSF5GPBGcQw5LUjNeh7CI3AbFCOf4ulaD8SCxke7lIpR9nB7OvsNZC
 f/Ymx+M7bRxa5m3dUGcvOOrr90o1tNfDaBL5yVqWXeg==
X-Received: by 2002:a05:600c:4f09:b0:3a8:3d5f:371f with SMTP id
 l9-20020a05600c4f0900b003a83d5f371fmr9549001wmq.94.1661889512923; 
 Tue, 30 Aug 2022 12:58:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6N9FmoBAPBUaKXto4fd8pyYrD2XQfmGj32921fA48xxP913RVBmTjDUy4QlAT00fTRuvPycQ==
X-Received: by 2002:a05:600c:4f09:b0:3a8:3d5f:371f with SMTP id
 l9-20020a05600c4f0900b003a83d5f371fmr9548992wmq.94.1661889512699; 
 Tue, 30 Aug 2022 12:58:32 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 bg20-20020a05600c3c9400b003a60edc3a44sm14437115wmb.5.2022.08.30.12.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 12:58:32 -0700 (PDT)
Date: Tue, 30 Aug 2022 15:58:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: RFC: control virtqueue size by the vdpa tool
Message-ID: <20220830154938-mutt-send-email-mst@kernel.org>
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
cXVldWUgc2l6ZSBjYW4gYWZmZWN0IHBlcmZvcm1hbmNlLgo+IAo+IEkgd291bGQgbGlrZSB0byBw
cm9wb3NlIGFuIGV4dGVuc2lvbiB0byB2ZHBhIHRvb2wgdG8gYWxsb3cgdG8gc3BlY2lmeSB0aGUg
cXVldWUKPiBzaXplLiBWYWxpZCB2YWx1ZXMgd2lsbCBjb25mb3JtIHRvIHRoZSBtYXggb2YgMzI3
Njggc3BlY2lmaWVkIGJ5IHRoZSBzcGVjLgo+IAo+ICAKPiAKPiDigJx2ZHBhIG1nbXRkZXYgc2hv
d+KAnSB3aWxsIGhhdmUgYW5vdGhlciBsaW5lIHNwZWNpZnlpbmcgdGhlIHZhbGlkIHJhbmdlIGZv
ciBhCj4gbWFuYWdlbWVudCBkZXZpY2Ugd2hpY2ggY291bGQgYmUgbmFycm93ZXIgdGhhbiB0aGUg
c3BlYyBhbGxvd3MuIFRoaXMgcmFuZ2Ugd2lsbAo+IGJlIHZhbGlkIGZvciBkYXRhIHF1ZXVlcyBv
bmx5IChub3QgZm9yIGNvbnRyb2wgVlEpLgo+IAo+IEFub3RoZXIgbGluZSB3aWxsIGRpc3BsYXkg
dGhlIGRlZmF1bHQgcXVldWUgc2l6ZQo+IAo+ICAKPiAKPiBFeGFtcGxlOgo+IAo+ICQgdmRwYSBt
Z210ZGV2IHNob3cKPiAKPiBhdXhpbGlhcnkvbWx4NV9jb3JlLnNmLjY6Cj4gCj4gICBzdXBwb3J0
ZWRfY2xhc3NlcyBuZXQKPiAKPiAgIG1heF9zdXBwb3J0ZWRfdnFzIDY1Cj4gCj4gICBkZXZfZmVh
dHVyZXMgQ1NVTSBHVUVTVF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyBDVFJM
X1ZRIENUUkxfVkxBTgo+IE1RIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xIEFDQ0VTU19QTEFURk9S
TQo+IAo+ICAgZGF0YSBxdWV1ZSByYW5nZSAyNTYtNDA5Ngo+IAo+ICAgZGVmYXVsdCBxdWV1ZSBz
aXplIDI1Ngo+IAo+ICAKPiAKPiBXaGVuIHlvdSBjcmVhdGUgdGhlIHZkcGEgZGV2aWNlIHlvdSBj
YW4gc3BlY2lmeSB0aGUgcmVxdWVzdGVkIHZhbHVlOgo+IAo+ICQgdmRwYSBkZXYgYWRkIG5hbWUg
dmRwYS1hIG1nbXRkZXYgYXV4aWxpYXJ5L21seDVfY29yZS5zZi42IG1heF92cXAgMSBtdHUgOTAw
MAo+IHF1ZXVlX3NpemUgMTAyNAo+IAo+ICAKCgpBIGZvbGxvdyB1cCBxdWVzdGlvbjogaXNuJ3Qg
aXQgZW5vdWdoIHRvIGNvbnRyb2wgdGhlIHNpemUKZnJvbSBxZW11PyBkbyB3ZSBuZWVkIGFiaWxp
dHkgdG8gY29udHJvbCBpdCBhdCB0aGUga2VybmVsIGxldmVsPwoKLS0gCk1TVAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
