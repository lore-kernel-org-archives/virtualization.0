Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114D6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 03:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACF7284CE4;
	Tue, 25 Jan 2022 03:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8mQeZs8N2KP; Tue, 25 Jan 2022 03:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BB6784CCD;
	Tue, 25 Jan 2022 03:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20DDFC0031;
	Tue, 25 Jan 2022 03:13:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3B0DC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9B6A84CE2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id whYplNvTKTSm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:13:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF16684CCD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643080387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86Lwt1ErcZuXDiwduAeDfYRE712HrjflIu9KLfn/+00=;
 b=WVw5MvJxeJdujOvSKb39hCqjh5xyaSR7pqbrh6dUpbVXAwwn7Nfr24bVJE8RNmtTiFvpHh
 fPiLbH9dF6fMIj8tzVnImVfUJI+hCl4IZZkaSCx/Q6sv8a/Qdekf+7RcJcoZ8OUFUmiY78
 5HbrQDxdD3NtkzPF7VoFjy0KMPYnKZw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-HwZE0d_uNMCXhFPvOcDVTQ-1; Mon, 24 Jan 2022 22:13:06 -0500
X-MC-Unique: HwZE0d_uNMCXhFPvOcDVTQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 q2-20020a170902f78200b0014b56300928so1800806pln.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 19:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=86Lwt1ErcZuXDiwduAeDfYRE712HrjflIu9KLfn/+00=;
 b=cd7W/4RKho9qdjIjfKKcJp+wYiIDI1bPzE3yJ96FHyNPJmgcrflwMRi/eSzfWwlfKx
 gCPPgwjBS6K4BfRC22qN8qclUAxYRmQMfpNQyrdUh56f+IIGA/y2Xup7qr3niiMXTxV3
 h+1f6shzgRsHqly79ZCKW0McjcbyVvbWj408saonCR4X8oerIcjxrgW0d1XTXWmyXD14
 HInBd0hWgYzuaicJUzZcBypxOT1lq980LsMKeBzG3HIRooIX+PLhmZw3RhfIxh4difWi
 wGKuB0BEYQ0xjBtrbeub9jxuvTXKR4AQKLgfVTNLVtoW1PTuKmKJktim8PLAs+A9M+zd
 W8cw==
X-Gm-Message-State: AOAM533e2jg9pp31taxk/jIjWbmEpDgfVo5TNs8OHvMzrt9qy8j7MNIU
 UjF/6xC/tCzguh60mwtpSjecZ22naTTd/5LGl+La8DgFjzum8b12aN4U8E2C+IYW6er5c34atCW
 t0Ksuj2t2frAk49qsExHMW3pdIUI4ojlIO+CGk5H/5A==
X-Received: by 2002:a62:3601:0:b0:4c8:c4e:5a8c with SMTP id
 d1-20020a623601000000b004c80c4e5a8cmr10543978pfa.27.1643080384788; 
 Mon, 24 Jan 2022 19:13:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh+RWh7k34SLq9+VCEcz6WXv7znNyJTfegmZlOG6x/AvybDpgmQI1bw4OR1Dq1yATJH5DOxw==
X-Received: by 2002:a62:3601:0:b0:4c8:c4e:5a8c with SMTP id
 d1-20020a623601000000b004c80c4e5a8cmr10543964pfa.27.1643080384572; 
 Mon, 24 Jan 2022 19:13:04 -0800 (PST)
Received: from [10.72.14.7] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id bf23sm664467pjb.52.2022.01.24.19.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jan 2022 19:13:04 -0800 (PST)
Message-ID: <a0e42103-25bc-5711-fc36-74557c04c901@redhat.com>
Date: Tue, 25 Jan 2022 11:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] vduse: Fix returning wrong type in
 vduse_domain_alloc_iova()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20220121083940.102-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220121083940.102-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIyLzEvMjEg5LiL5Y2INDozOSwgWGllIFlvbmdqaSDlhpnpgZM6Cj4gVGhpcyBmaXhl
cyB0aGUgZm9sbG93aW5nIHNtYXRjaCB3YXJuaW5nczoKPgo+IGRyaXZlcnMvdmRwYS92ZHBhX3Vz
ZXIvaW92YV9kb21haW4uYzozMDUgdmR1c2VfZG9tYWluX2FsbG9jX2lvdmEoKSB3YXJuOiBzaG91
bGQgJ2lvdmFfcGZuIDw8IHNoaWZ0JyBiZSBhIDY0IGJpdCB0eXBlPwo+Cj4gRml4ZXM6IDhjNzcz
ZDUzZmI3YiAoInZkdXNlOiBJbXBsZW1lbnQgYW4gTU1VLWJhc2VkIHNvZnR3YXJlIElPVExCIikK
PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gUmVwb3J0
ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci9pb3ZhX2RvbWFpbi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFp
bi5jCj4gaW5kZXggMmIxMTQzZjExZDhmLi4wYTRkOTNlZGM0YzAgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL3ZkcGFfdXNlci9pb3ZhX2RvbWFpbi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci9pb3ZhX2RvbWFpbi5jCj4gQEAgLTI5NCw3ICsyOTQsNyBAQCB2ZHVzZV9kb21haW5f
YWxsb2NfaW92YShzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLAo+ICAgCj4gICAJaW92YV9wZm4g
PSBhbGxvY19pb3ZhX2Zhc3QoaW92YWQsIGlvdmFfbGVuLCBsaW1pdCA+PiBzaGlmdCwgdHJ1ZSk7
Cj4gICAKPiAtCXJldHVybiBpb3ZhX3BmbiA8PCBzaGlmdDsKPiArCXJldHVybiAoZG1hX2FkZHJf
dClpb3ZhX3BmbiA8PCBzaGlmdDsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgdmR1c2VfZG9t
YWluX2ZyZWVfaW92YShzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
