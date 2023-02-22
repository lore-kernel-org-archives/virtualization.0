Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786E2C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 04:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E2A7605E3;
	Wed, 22 Feb 2023 04:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E2A7605E3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QoNYNrdp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2k0FlQPagDuy; Wed, 22 Feb 2023 04:07:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A98C60591;
	Wed, 22 Feb 2023 04:07:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A98C60591
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D93EC0033;
	Wed, 22 Feb 2023 04:07:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECC09C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C811860591
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:07:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C811860591
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I_hNfFB5YsFD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:07:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16F306058F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16F306058F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 04:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677038860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23WaYJEuVEDnZZtD/Kv+hEaPZ1wtaeuDlWV+EiAlFYE=;
 b=QoNYNrdpmC2gT234TmClrKO71SAq8NbBjts/5wlOOxCMBoc4byFFa3AN5eC4VpGf+mctS/
 OFHG/xfmsJUNm6KpbIBbPVcRgMleEK5JxGLDQLNmOIU7TOmhx/rl1TB/ek24pMx9agfzEx
 ol4jqtn1VRiMHBeDp68jp5Fr35lDYjk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-OVmtsrVgNauOqZs897iSKg-1; Tue, 21 Feb 2023 23:07:36 -0500
X-MC-Unique: OVmtsrVgNauOqZs897iSKg-1
Received: by mail-pf1-f198.google.com with SMTP id
 ds2-20020a056a004ac200b0058d9b9fecb6so3019075pfb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 20:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23WaYJEuVEDnZZtD/Kv+hEaPZ1wtaeuDlWV+EiAlFYE=;
 b=v773p426eJX98rJ3JBRPTOALJvQ+lON0O31/TkHmeq/hAjrN44rDrtcncC8TjE3e55
 k+l3Cwp6J8sVgiltnLFNK0lBCv2bVTRkdjoAikRMQCxO9CB7J3VSWLhtSVXRdVwS8vQi
 SJV/x1DKlVNfPkzqIS1iU+RmzU8EvfRzOeKzuXx5zvjeZOyf5GniwJYDjo+wRAdIOSaX
 NXTUTlI0BOJemOcylm4ezwnoQh87yb8oJtDEQj6el1C/9+MU/2rd2ulKYW60lFuiBgT0
 BFpfiMniyi5tR6sEOf/Sx/1DM0VV4+yjQzKn+HP8sR1w2XmOBVkdaUFQuXPC8KCoB4L+
 NGLw==
X-Gm-Message-State: AO0yUKWhZYeKrWQ/Ncg0lpQVZHRghizi4FM6D5jm+/c+Va80H40Oryjd
 2aBMqEZOiTQnykpNlf4dwuPK778OosMypwBBWJadR2vl1J1OWYYSinhzRja9CIDE22ZSYCJCJMi
 6fpyhtZjZ2Eo99IKjn/++xxy9Za2+Hg3xOf82kS8LUg==
X-Received: by 2002:a05:6a20:a10b:b0:bd:17a4:c339 with SMTP id
 q11-20020a056a20a10b00b000bd17a4c339mr6558895pzk.13.1677038855345; 
 Tue, 21 Feb 2023 20:07:35 -0800 (PST)
X-Google-Smtp-Source: AK7set952JHhGcQmblzrCG151oLNcAaBWjsK1jgb2/cKapb1E2eT4+uCH9XBPpKVAPS6NZRV1WV3Gw==
X-Received: by 2002:a05:6a20:a10b:b0:bd:17a4:c339 with SMTP id
 q11-20020a056a20a10b00b000bd17a4c339mr6558870pzk.13.1677038855037; 
 Tue, 21 Feb 2023 20:07:35 -0800 (PST)
Received: from [10.72.13.76] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170902eec600b0017a032d7ae4sm1669577plb.104.2023.02.21.20.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Feb 2023 20:07:34 -0800 (PST)
Message-ID: <c5817a6d-097f-6cef-748f-1b1848d0192f@redhat.com>
Date: Wed, 22 Feb 2023 12:07:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 13/13] vdpa: return VHOST_F_LOG_ALL in vhost-vdpa
 devices
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-14-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230208094253.702672-14-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvOCAxNzo0MiwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IHZob3N0LXZkcGEg
ZGV2aWNlcyBjYW4gcmV0dXJuIHRoaXMgZmVhdHVyZXMgbm93IHRoYXQgYmxvY2tlcnMgaGF2ZSBi
ZWVuCj4gc2V0IGluIGNhc2Ugc29tZSBmZWF0dXJlcyBhcmUgbm90IG1ldC4KPgo+IEV4cG9zZSBW
SE9TVF9GX0xPR19BTEwgb25seSBpbiB0aGF0IGNhc2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFdWdl
bmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiAtLS0KCgpBY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gICBody92aXJ0aW8vdmhvc3Qt
dmRwYS5jIHwgMyArLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIvaHcvdmly
dGlvL3Zob3N0LXZkcGEuYwo+IGluZGV4IDEzYTg2YTJiYjEuLjVmZGRjNzdjNWMgMTAwNjQ0Cj4g
LS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+ICsrKyBiL2h3L3ZpcnRpby92aG9zdC12ZHBh
LmMKPiBAQCAtMTMxOSwxMCArMTMxOSw5IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJp
bmdfY2FsbChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFf
Z2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCAqZmVhdHVyZXMpCj4gICB7Cj4gLSAgICBzdHJ1
Y3Qgdmhvc3RfdmRwYSAqdiA9IGRldi0+b3BhcXVlOwo+ICAgICAgIGludCByZXQgPSB2aG9zdF92
ZHBhX2dldF9kZXZfZmVhdHVyZXMoZGV2LCBmZWF0dXJlcyk7Cj4gICAKPiAtICAgIGlmIChyZXQg
PT0gMCAmJiB2LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPiArICAgIGlmIChyZXQgPT0gMCkgewo+
ICAgICAgICAgICAvKiBBZGQgU1ZRIGxvZ2dpbmcgY2FwYWJpbGl0aWVzICovCj4gICAgICAgICAg
ICpmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0ZfTE9HX0FMTCk7Cj4gICAgICAgfQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
