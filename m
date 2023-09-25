Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D9FCE7A8B
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 02:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4396415F4;
	Mon, 25 Sep 2023 02:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4396415F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMn0cEVW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vf09bFjt3utE; Mon, 25 Sep 2023 02:30:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 099F540629;
	Mon, 25 Sep 2023 02:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 099F540629
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2694C0039;
	Mon, 25 Sep 2023 02:30:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F34A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC9F9403F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC9F9403F9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMn0cEVW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2LkXvUZTywZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 280A9400B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 02:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 280A9400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695609033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=My4fcruqhbNbk3ZnNE5dRaCSndf75smmnZbl/BLKBNQ=;
 b=XMn0cEVWdi0LekSwZ9XuY5OG38iK+TFc32A6uc6MKPIjEnMMhJdS1jOwkoSCc9VyAhLMmH
 hLat9DY5hY+SUEKbpIhorDfVFERCqCfvQ1k7v/34a6eECAYvjVGEgfMALqY18iAIFHB/p+
 ANCyMf5bokQzTGEnoSX2lF0nKz90Bqo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-dLTB8sB-POuzTp_EtTvMCg-1; Sun, 24 Sep 2023 22:30:32 -0400
X-MC-Unique: dLTB8sB-POuzTp_EtTvMCg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5039413f4f9so7512931e87.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 19:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609031; x=1696213831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=My4fcruqhbNbk3ZnNE5dRaCSndf75smmnZbl/BLKBNQ=;
 b=KfEZsmYpeeeaYVTMvtEmNDCtXjwslRap65/DRYgBJMub+6Vv0y4RALbntq5iwxQsVU
 egvoug7v0bA1TOId4vxKkoHb+GyPL9156yXyzo0XFe9xoYoS0JFZsfIE/9rgBPoBWDyY
 aMyW6LNhUq7gi78hQUt+u2FU2ncUlGeOOQ95LUS/a/hTn3TzqswVoEOLKjrtTxYj7LPD
 Xwj4Awe2rs2ib0AOSq2TxdWO8zXm4DHPBA049GmYRRn4ejyIokbAo+BnnqHj0eceVOfL
 asz+PiZ5GKmtohcRw7g5Gvga8fCNhyE16V2GiS0eooIlMSqy2MuPCe87nBuaaI0kVe+J
 Y0wQ==
X-Gm-Message-State: AOJu0YxH0ZT7IcQHC1R21upinqyySh2ilGW7NzHNt1PRnWFzYtHcFfgF
 bpYViSsZcFEiaY/gb8EXrw2z0hEdcHo2nIgUFCQr1T7tds4qbTyHiJzWSjBuHnKsz/d8Le7qt/S
 H+WXzEDLdi16piRZ63IkRZ2zPBzStoQwUtM4PRp9WWQi5eAznys9lcafivw==
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id
 j26-20020a056512029a00b0050303039e2dmr4172036lfp.5.1695609031038; 
 Sun, 24 Sep 2023 19:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCXmp/aDdUak815OsqpgvdcBHOa0dtFaMwCsIbT9r2DT0517VZ0CRgMv9lcx79VNCWB0J1wHJjd25DWw8PP7A=
X-Received: by 2002:a05:6512:29a:b0:503:303:9e2d with SMTP id
 j26-20020a056512029a00b0050303039e2dmr4172025lfp.5.1695609030705; Sun, 24 Sep
 2023 19:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:30:19 +0800
Message-ID: <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgODoyNeKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4KPgo+ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlh
LmNvbT4KPiA+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIyLCAyMDIzIDU6NTMgUE0KPgo+Cj4g
PiA+IEFuZCB3aGF0J3MgbW9yZSwgdXNpbmcgTU1JTyBCQVIwIHRoZW4gaXQgY2FuIHdvcmsgZm9y
IGxlZ2FjeS4KPiA+Cj4gPiBPaD8gSG93PyBPdXIgdGVhbSBkaWRuJ3QgdGhpbmsgc28uCj4KPiBJ
dCBkb2VzIG5vdC4gSXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkLgo+IFRoZSBkZXZpY2UgcmVzZXQg
aW4gbGVnYWN5IGlzIG5vdCBzeW5jaHJvbm91cy4KCkhvdyBkbyB5b3Uga25vdyB0aGlzPwoKPiBU
aGUgZHJpdmVycyBkbyBub3Qgd2FpdCBmb3IgcmVzZXQgdG8gY29tcGxldGU7IGl0IHdhcyB3cml0
dGVuIGZvciB0aGUgc3cgYmFja2VuZC4KCkRvIHlvdSBzZWUgdGhlcmUncyBhIGZsdXNoIGFmdGVy
IHJlc2V0IGluIHRoZSBsZWdhY3kgZHJpdmVyPwoKc3RhdGljIHZvaWQgdnBfcmVzZXQoc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCnsKICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2Ug
KnZwX2RldiA9IHRvX3ZwX2RldmljZSh2ZGV2KTsKICAgICAgICAvKiAwIHN0YXR1cyBtZWFucyBh
IHJlc2V0LiAqLwogICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDAp
OwogICAgICAgIC8qIEZsdXNoIG91dCB0aGUgc3RhdHVzIHdyaXRlLCBhbmQgZmx1c2ggaW4gZGV2
aWNlIHdyaXRlcywKICAgICAgICAgKiBpbmNsdWRpbmcgTVNpLVggaW50ZXJydXB0cywgaWYgYW55
LiAqLwogICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpOwogICAgICAg
IC8qIEZsdXNoIHBlbmRpbmcgVlEvY29uZmlndXJhdGlvbiBjYWxsYmFja3MuICovCiAgICAgICAg
dnBfc3luY2hyb25pemVfdmVjdG9ycyh2ZGV2KTsKfQoKVGhhbmtzCgoKCj4gSGVuY2UgTU1JTyBC
QVIwIGlzIG5vdCB0aGUgYmVzdCBvcHRpb24gaW4gcmVhbCBpbXBsZW1lbnRhdGlvbnMuCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
