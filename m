Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263AEC49361
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:08:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84F4613D5
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84F4613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D7C84024A;
	Thu, 17 Jun 2021 03:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x9rihi5vGK2K; Thu, 17 Jun 2021 03:08:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 08E8040255;
	Thu, 17 Jun 2021 03:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE709C000D;
	Thu, 17 Jun 2021 03:08:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DCB1C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFF47607C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id emQ2DHYf98H4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:08:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41D52606CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623899324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJESmDxrRmYGcRizjKpgmpvFUh6G3YJgeVVQgOoxENU=;
 b=Rsw5/FR4xG/eiCQGqLdBJnlyKyaSf+wIxKhjZZhw3KhxOTdT/Ya6q6XryvnvAT6L1yPYys
 rDGDvRHRaDJ9tY8J1EbtK80HgK/Atb395NkuR0mRO+dxzB4uKIiPViBr/IdeGWWdrZ1eec
 CAa2AZ3aKJDFzvkoH8G7zCLNyAvX1LY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-5nCaIH8YMmiNrulzKZYIjA-1; Wed, 16 Jun 2021 23:08:43 -0400
X-MC-Unique: 5nCaIH8YMmiNrulzKZYIjA-1
Received: by mail-pj1-f70.google.com with SMTP id
 on11-20020a17090b1d0bb029016bba777f5fso3098327pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 20:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VJESmDxrRmYGcRizjKpgmpvFUh6G3YJgeVVQgOoxENU=;
 b=bsfzsguEp0soGXXVL51gceGJBxb/V2pw2bWNOPuZkOgcM3eDtUfxm2z8mvO4I9bCCL
 fL6NQ7Hc0GO+uCcmw5MEJcCs8BUIMXLBpdZML/huS46W2FLujXavgJpkbdqXB6LmAEdP
 pA1w5hfzV6RYjR5aJ57a6n6+DimQDNF4LCwBgSWiOnddHvep79WMydkfevhsUm1riynw
 SQyIJA+mYOcETzNPtdpn6ZsYWs4tDiPEz8/KuEyU5O4WF74oo7OkauzXtGx2bzzgH/ML
 CljlTcPsYpmHgb9c8ktHmDFN0AZC5XsTvlGms45ZCuRDBM23UmuLDH+8Z0HgmeqcX1NZ
 59rg==
X-Gm-Message-State: AOAM533Z4HKU7OXcHDeqSaEQDjosEeD9r/GvzUuax+LIVuMqPRQYS63A
 rfaZy9GiA0sLcKVBDJNiPcwE0uX0vKwCfdvDwK0Zisc3D+cun2jfoQdt3R8apjLL29vBpofmVJe
 kRpw31XT7ThjV2FXPcJ8ViPjG80Vv8dT9sInXJq356A==
X-Received: by 2002:a17:90a:5b0a:: with SMTP id
 o10mr14302863pji.143.1623899322093; 
 Wed, 16 Jun 2021 20:08:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpr+9g9pKcJlYbxlBvU6PgfqtM+wo9N90186PBpdb1zN0LxLJ/yCWe9p5eHsoSE5dmxkclqQ==
X-Received: by 2002:a17:90a:5b0a:: with SMTP id
 o10mr14302828pji.143.1623899321837; 
 Wed, 16 Jun 2021 20:08:41 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ls17sm6381794pjb.56.2021.06.16.20.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 20:08:41 -0700 (PDT)
Subject: Re: [PATCH net-next v5 15/15] virtio-net: xsk zero copy xmit kick by
 threshold
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-16-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7dbdb429-edda-9f33-fbfa-bb128c5e3eca@redhat.com>
Date: Thu, 17 Jun 2021 11:08:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-16-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gQWZ0ZXIgdGVzdGluZywg
dGhlIHBlcmZvcm1hbmNlIG9mIGNhbGxpbmcga2ljayBldmVyeSB0aW1lIGlzIG5vdCBzdGFibGUu
Cj4gQW5kIGlmIGFsbCB0aGUgcGFja2V0cyBhcmUgc2VudCBhbmQga2lja2VkIGFnYWluLCB0aGUg
cGVyZm9ybWFuY2UgaXMgbm90Cj4gZ29vZC4gU28gYWRkIGEgbW9kdWxlIHBhcmFtZXRlciB0byBz
cGVjaWZ5IGhvdyBtYW55IHBhY2tldHMgYXJlIHNlbnQgdG8KPiBjYWxsIGEga2ljay4KPgo+IDgg
aXMgYSByZWxhdGl2ZWx5IHN0YWJsZSB2YWx1ZSB3aXRoIHRoZSBiZXN0IHBlcmZvcm1hbmNlLgo+
Cj4gSGVyZSBpcyB0aGUgcHBzIG9mIHRoZSB0ZXN0IG9mIHhza19raWNrX3RociB1bmRlciBkaWZm
ZXJlbnQgdmFsdWVzIChmcm9tCj4gMSB0byA2NCkuCj4KPiB0aHIgIFBQUyAgICAgICAgICAgICB0
aHIgUFBTICAgICAgICAgICAgIHRociBQUFMKPiAxICAgIDI5MjQxMTYuNzQyNDcgfCAyMyAgMzY4
MzI2My4wNDM0OCB8IDQ1ICAyNzc3OTA3LjIyOTYzCj4gMiAgICAzNDQxMDEwLjU3MTkxIHwgMjQg
IDMwNzg4ODAuMTMwNDMgfCA0NiAgMjc4MTM3Ni4yMTczOQo+IDMgICAgMzYzNjcyOC43MjM3OCB8
IDI1ICAyODU5MjE5LjU3NjU2IHwgNDcgIDI3NzcyNzEuOTEzMDQKPiA0ICAgIDM2Mzc1MTguNjE0
NjggfCAyNiAgMjg1MTU1Ny45NTkzICB8IDQ4ICAyODAwMzIwLjU2NTc1Cj4gNSAgICAzNjUxNzM4
LjE2MjUxIHwgMjcgIDI4MzQ3ODMuNTQ0MDggfCA0OSAgMjgxMzAzOS44NzU5OQo+IDYgICAgMzY1
MjE3Ni42OTIzMSB8IDI4ICAyODQ3MDEyLjQxNDcyIHwgNTAgIDM0NDUxNDMuMDE4MzkKPiA3ICAg
IDM2NjU0MTUuODA2MDIgfCAyOSAgMjg2MDYzMy45MTMwNCB8IDUxICAzNjY2OTE4LjAxMjgxCj4g
OCAgICAzNjY1MDQ1LjE2NTU1IHwgMzAgIDI4NTc5MDMuNTc4NiAgfCA1MiAgMzA1OTkyOS4yNzA5
CgoKSSB3b25kZXIgd2hhdCdzIHRoZSBudW1iZXIgZm9yIHRoZSBjYXNlIG9mIG5vbiB6YyB4c2s/
CgpUaGFua3MKCgo+IDkgICAgMzY3MTAyMy4yNDAxICB8IDMxICAyODM1NTg5Ljk4OTYzIHwgNTMg
IDI4MzE1MTUuMjE3MzkKPiAxMCAgIDM2Njk1MzIuMjMyNzQgfCAzMiAgMjg2MjgyNy44ODcwNiB8
IDU0ICAzNDUxODA0LjA3MjA0Cj4gMTEgICAzNjY2MTYwLjM3NzQ5IHwgMzMgIDI4NzE4NTUuOTY2
OTYgfCA1NSAgMzY1NDk3NS45MjM4NQo+IDEyICAgMzY3NDk1MS40NDgxMyB8IDM0ICAzNDM0NDU2
LjQ0ODE2IHwgNTYgIDM2NzYxOTguMzE4OAo+IDEzICAgMzY2NzQ0Ny41NzMzMSB8IDM1ICAzNjU2
OTE4LjU0MTc3IHwgNTcgIDM2ODQ3NDAuODU2MTkKPiAxNCAgIDMwMTg4NDYuMDUwMyAgfCAzNiAg
MzU5NjkyMS4xNjcyMiB8IDU4ICAzMDYwOTU4Ljg1OTQKPiAxNSAgIDI3OTI3NzMuODQ1MDUgfCAz
NyAgMzYwMzQ2MC42MzkwMyB8IDU5ICAyODI4ODc0LjU3MTkxCj4gMTYgICAzNDMwNTk2LjM2MDIg
IHwgMzggIDM1OTU0MTAuODc2NjYgfCA2MCAgMzQ1OTkyNi4xMTAyNwo+IDE3ICAgMzY2MDUyNS44
NTgwNiB8IDM5ICAzNjA0MjUwLjE3ODE5IHwgNjEgIDM2ODU0NDQuNDc1OTkKPiAxOCAgIDMwNDU2
MjcuNjkwNTQgfCA0MCAgMzU5NjU0Mi4yODQyOCB8IDYyICAzMDQ5OTU5LjA4MDkKPiAxOSAgIDI4
NDE1NDIuOTQxNzcgfCA0MSAgMzYwMDcwNS4xNjA1NCB8IDYzICAyODA2MjgwLjA0MDEzCj4gMjAg
ICAyODMwNDc1Ljk3MzQ4IHwgNDIgIDMwMTk4MzMuNzExOTEgfCA2NCAgMzQ0ODQ5NC4zOTEzCj4g
MjEgICAyODQ1NjU1LjU1Nzg5IHwgNDMgIDI3NTI5NTEuOTMyNjQgfAo+IDIyICAgMzQ1MDM4OS44
NDM2NSB8IDQ0ICAyNzUzMTA3LjI3MTY0IHwKPgo+IEl0IGNhbiBiZSBmb3VuZCB0aGF0IHdoZW4g
dGhlIHZhbHVlIG9mIHhza19raWNrX3RociBpcyByZWxhdGl2ZWx5IHNtYWxsLAo+IHRoZSBwZXJm
b3JtYW5jZSBpcyBub3QgZ29vZCwgYW5kIHdoZW4gaXRzIHZhbHVlIGlzIGdyZWF0ZXIgdGhhbiAx
MywgdGhlCj4gcGVyZm9ybWFuY2Ugd2lsbCBiZSBtb3JlIGlycmVndWxhciBhbmQgdW5zdGFibGUu
IEl0IGxvb2tzIHNpbWlsYXIgZnJvbSAzCj4gdG8gMTMsIEkgY2hvc2UgOCBhcyB0aGUgZGVmYXVs
dCB2YWx1ZS4KPgo+IFRoZSB0ZXN0IGVudmlyb25tZW50IGlzIHFlbXUgKyB2aG9zdC1uZXQuIEkg
bW9kaWZpZWQgdmhvc3QtbmV0IHRvIGRyb3AKPiB0aGUgcGFja2V0cyBzZW50IGJ5IHZtIGRpcmVj
dGx5LCBzbyB0aGF0IHRoZSBjcHUgb2Ygdm0gY2FuIHJ1biBoaWdoZXIuCj4gQnkgZGVmYXVsdCwg
dGhlIHByb2Nlc3NlcyBpbiB0aGUgdm0gYW5kIHRoZSBjcHUgb2Ygc29mdGlycWQgYXJlIHRvbyBs
b3csCj4gYW5kIHRoZXJlIGlzIG5vIG9idmlvdXMgZGlmZmVyZW5jZSBpbiB0aGUgdGVzdCBkYXRh
Lgo+Cj4gRHVyaW5nIHRoZSB0ZXN0LCB0aGUgY3B1IG9mIHNvZnRpcnEgcmVhY2hlZCAxMDAlLiBF
YWNoIHhza19raWNrX3RociB3YXMKPiBydW4gZm9yIDMwMHMsIHRoZSBwcHMgb2YgZXZlcnkgc2Vj
b25kIHdhcyByZWNvcmRlZCwgYW5kIHRoZSBhdmVyYWdlIG9mCj4gdGhlIHBwcyB3YXMgZmluYWxs
eSB0YWtlbi4gVGhlIHZob3N0IHByb2Nlc3MgY3B1IG9uIHRoZSBob3N0IGhhcyBhbHNvCj4gcmVh
Y2hlZCAxMDAlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiBSZXZpZXdlZC1ieTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJh
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmMgfCAgMSArCj4g
ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKy0t
Cj4gICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAgIHwgIDIgKysKPiAgIDMgZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvL3Zp
cnRpb19uZXQuYwo+IGluZGV4IDk1MDMxMzNlNzFmMC4uZGZlNTA5OTM5YjQ1IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW8vdmlydGlvX25ldC5jCj4gQEAgLTE0LDYgKzE0LDcgQEAgc3RhdGljIGJvb2wgY3N1bSA9
IHRydWUsIGdzbyA9IHRydWUsIG5hcGlfdHggPSB0cnVlOwo+ICAgbW9kdWxlX3BhcmFtKGNzdW0s
IGJvb2wsIDA0NDQpOwo+ICAgbW9kdWxlX3BhcmFtKGdzbywgYm9vbCwgMDQ0NCk7Cj4gICBtb2R1
bGVfcGFyYW0obmFwaV90eCwgYm9vbCwgMDY0NCk7Cj4gK21vZHVsZV9wYXJhbSh4c2tfa2lja190
aHIsIGludCwgMDY0NCk7Cj4gICAKPiAgIC8qIEZJWE1FOiBNVFUgaW4gY29uZmlnLiAqLwo+ICAg
I2RlZmluZSBHT09EX1BBQ0tFVF9MRU4gKEVUSF9ITEVOICsgVkxBTl9ITEVOICsgRVRIX0RBVEFf
TEVOKQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgYi9kcml2ZXJzL25l
dC92aXJ0aW8veHNrLmMKPiBpbmRleCAzOTczYzgyZDFhZDIuLjJmM2JhNmFiNDc5OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW8veHNrLmMKPiBAQCAtNSw2ICs1LDggQEAKPiAgIAo+ICAgI2luY2x1ZGUgInZpcnRpb19uZXQu
aCIKPiAgIAo+ICtpbnQgeHNrX2tpY2tfdGhyID0gODsKPiArCj4gICBzdGF0aWMgc3RydWN0IHZp
cnRpb19uZXRfaGRyX21yZ19yeGJ1ZiB4c2tfaGRyOwo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZp
cnRuZXRfeHNrX2N0eCAqdmlydG5ldF94c2tfY3R4X2dldChzdHJ1Y3QgdmlydG5ldF94c2tfY3R4
X2hlYWQgKmhlYWQpCj4gQEAgLTQ1NSw2ICs0NTcsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeHNr
X3htaXRfYmF0Y2goc3RydWN0IHNlbmRfcXVldWUgKnNxLAo+ICAgCXN0cnVjdCB4ZHBfZGVzYyBk
ZXNjOwo+ICAgCWludCBlcnIsIHBhY2tldCA9IDA7Cj4gICAJaW50IHJldCA9IC1FQUdBSU47Cj4g
KwlpbnQgbmVlZF9raWNrID0gMDsKPiAgIAo+ICAgCXdoaWxlIChidWRnZXQtLSA+IDApIHsKPiAg
IAkJaWYgKHNxLT52cS0+bnVtX2ZyZWUgPCAyICsgTUFYX1NLQl9GUkFHUykgewo+IEBAIC00NzUs
MTEgKzQ3OCwyMiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeHNrX3htaXRfYmF0Y2goc3RydWN0IHNl
bmRfcXVldWUgKnNxLAo+ICAgCQl9Cj4gICAKPiAgIAkJKytwYWNrZXQ7Cj4gKwkJKytuZWVkX2tp
Y2s7Cj4gKwkJaWYgKG5lZWRfa2ljayA+IHhza19raWNrX3Rocikgewo+ICsJCQlpZiAodmlydHF1
ZXVlX2tpY2tfcHJlcGFyZShzcS0+dnEpICYmCj4gKwkJCSAgICB2aXJ0cXVldWVfbm90aWZ5KHNx
LT52cSkpCj4gKwkJCQkrK3N0YXRzLT5raWNrczsKPiArCj4gKwkJCW5lZWRfa2ljayA9IDA7Cj4g
KwkJfQo+ICAgCX0KPiAgIAo+ICAgCWlmIChwYWNrZXQpIHsKPiAtCQlpZiAodmlydHF1ZXVlX2tp
Y2tfcHJlcGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPiAtCQkJKytz
dGF0cy0+a2lja3M7Cj4gKwkJaWYgKG5lZWRfa2ljaykgewo+ICsJCQlpZiAodmlydHF1ZXVlX2tp
Y2tfcHJlcGFyZShzcS0+dnEpICYmCj4gKwkJCSAgICB2aXJ0cXVldWVfbm90aWZ5KHNxLT52cSkp
Cj4gKwkJCQkrK3N0YXRzLT5raWNrczsKPiArCQl9Cj4gICAKPiAgIAkJKmRvbmUgKz0gcGFja2V0
Owo+ICAgCQlzdGF0cy0+eGRwX3R4ICs9IHBhY2tldDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvL3hzay5oIGIvZHJpdmVycy9uZXQvdmlydGlvL3hzay5oCj4gaW5kZXggZmUyMmNm
NzhkNTA1Li40ZjBmNGY5Y2YyM2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvL3hz
ay5oCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvL3hzay5oCj4gQEAgLTcsNiArNyw4IEBACj4g
ICAKPiAgICNkZWZpbmUgVklSVE5FVF9YU0tfQlVGRl9DVFggICgodm9pZCAqKSh1bnNpZ25lZCBs
b25nKX4wTCkKPiAgIAo+ICtleHRlcm4gaW50IHhza19raWNrX3RocjsKPiArCj4gICAvKiBXaGVu
IHhzayBkaXNhYmxlLCB1bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlcywgdGhlIG5ldHdvcmsgY2Fy
ZCBtdXN0IHJlY2xhaW0KPiAgICAqIGFsbCB0aGUgbWVtb3J5IHRoYXQgaGFzIGJlZW4gc2VudCBh
bmQgdGhlIG1lbW9yeSBhZGRlZCB0byB0aGUgcnEgcXVldWUgYnkKPiAgICAqIGRlc3Ryb3lpbmcg
dGhlIHF1ZXVlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
