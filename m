Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15296C48BCD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 01:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B175C61407
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 01:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175C61407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CE98401E5;
	Thu, 10 Jun 2021 01:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FiCfuGcaRCPp; Thu, 10 Jun 2021 01:51:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B71E9403B9;
	Thu, 10 Jun 2021 01:51:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88EA5C000E;
	Thu, 10 Jun 2021 01:51:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8C7EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 01:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2E4F82AF8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 01:51:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtHBnQjHzovj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 01:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E06B82951
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623289874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vz0jGs3iC3Z2zxb/bDk+em2UI3NrnLgN9D+cOWfKhFk=;
 b=S5RXg8X8YXq66Z3WPSv9xSPaTMmfkX3cosCtttdM9Jqb3JICVGeF9wR2ms3l22ca3WVGSb
 XAu2KmOQHjd+t9MStM/AL8pg8RVqhp825wrPkwJOn57lZzHTLS3XK1ocBTAFExR0DgzKWF
 zHBvNfgAcUb82EYR/S0gnwzKC8h94V4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-phlj2WQzO1inDCRuu6Zf4Q-1; Wed, 09 Jun 2021 21:51:10 -0400
X-MC-Unique: phlj2WQzO1inDCRuu6Zf4Q-1
Received: by mail-pg1-f199.google.com with SMTP id
 w185-20020a6362c20000b02902208d90c8c8so14585386pgb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 18:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Vz0jGs3iC3Z2zxb/bDk+em2UI3NrnLgN9D+cOWfKhFk=;
 b=s1TF3A0PvCKD7tGJQEHTzTp/2nAVYeUGflyL3IH8NdvgAp9R5NUTkd5PhRbV8sCJ6a
 thyGMa5Z7/lyNWi5i+RFsHxJfDpPd8rsGz3GRaX1oK/nvInguForwbs40yyYnJWETpwc
 0b2MLFlQ98fIgvRtrchq2x3LouaUt301oVtre5auW/a1d3R1n4f/wfrxTvL0rgPLdRPt
 heXSQVMa3e7gY3QfASntvKAWP6bujFtn3dBaLz67Sb0uEJYQ0FokbeApjb1o59iXsnnQ
 CuxiNL+++Xwsg4b8h/944zn5JvmVznI1vjkYKY7WOED2fA3RHxzwkztXGu9WWCwLR2AR
 XCUw==
X-Gm-Message-State: AOAM5333QZ9oXmxUjQuhOB2kUPeFHvQDkEbOgveM0gDeSEVpILGeisyF
 0ZmCd/nqZAG9UAmR/1YHhxbkM9h3pqRcjUjkzMd34UDZDtJkczUeRln1JI6ExKofRllOsruH/oD
 4WRE8LcspXmgc+Sy4Lua9vk3xXoufO7akDKaYkt/7wg==
X-Received: by 2002:a63:1f57:: with SMTP id q23mr2540935pgm.398.1623289869844; 
 Wed, 09 Jun 2021 18:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTPUVSAZdPB8Qre6f3DbTbUGZcOx/a9zlBz8i8IQXThi6iMQgKG/iGcFooiYctC9c43+Gg/Q==
X-Received: by 2002:a63:1f57:: with SMTP id q23mr2540893pgm.398.1623289869521; 
 Wed, 09 Jun 2021 18:51:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l3sm846806pgb.77.2021.06.09.18.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 18:51:09 -0700 (PDT)
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
To: Jiang Wang <jiang.wang@bytedance.com>, sgarzare@redhat.com
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da90f17a-1c24-b475-76ef-f6a7fc2bcdd5@redhat.com>
Date: Thu, 10 Jun 2021 09:50:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609232501.171257-1-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 duanxiongchun@bytedance.com, xieyongji@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>, Steven Rostedt <rostedt@goodmis.org>,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>, arseny.krasnov@kaspersky.com,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

CuWcqCAyMDIxLzYvMTAg5LiK5Y2INzoyNCwgSmlhbmcgV2FuZyDlhpnpgZM6Cj4gVGhpcyBwYXRj
aHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2YgU09DS19ER1JBTSBmb3IgdmlydGlvCj4gdHJhbnNw
b3J0Lgo+Cj4gRGF0YWdyYW0gc29ja2V0cyBhcmUgY29ubmVjdGlvbmxlc3MgYW5kIHVucmVsaWFi
bGUuIFRvIGF2b2lkIHVuZmFpciBjb250ZW50aW9uCj4gd2l0aCBzdHJlYW0gYW5kIG90aGVyIHNv
Y2tldHMsIGFkZCB0d28gbW9yZSB2aXJ0cXVldWVzIGFuZAo+IGEgbmV3IGZlYXR1cmUgYml0IHRv
IGluZGljYXRlIGlmIHRob3NlIHR3byBuZXcgcXVldWVzIGV4aXN0IG9yIG5vdC4KPgo+IERncmFt
IGRvZXMgbm90IHVzZSB0aGUgZXhpc3RpbmcgY3JlZGl0IHVwZGF0ZSBtZWNoYW5pc20gZm9yCj4g
c3RyZWFtIHNvY2tldHMuIFdoZW4gc2VuZGluZyBmcm9tIHRoZSBndWVzdC9kcml2ZXIsIHNlbmRp
bmcgcGFja2V0cwo+IHN5bmNocm9ub3VzbHksIHNvIHRoZSBzZW5kZXIgd2lsbCBnZXQgYW4gZXJy
b3Igd2hlbiB0aGUgdmlydHF1ZXVlIGlzIGZ1bGwuCj4gV2hlbiBzZW5kaW5nIGZyb20gdGhlIGhv
c3QvZGV2aWNlLCBzZW5kIHBhY2tldHMgYXN5bmNocm9ub3VzbHkKPiBiZWNhdXNlIHRoZSBkZXNj
cmlwdG9yIG1lbW9yeSBiZWxvbmdzIHRvIHRoZSBjb3JyZXNwb25kaW5nIFFFTVUKPiBwcm9jZXNz
LgoKCldoYXQncyB0aGUgdXNlIGNhc2UgZm9yIHRoZSBkYXRhZ3JhbSB2c29jaz8KCgo+Cj4gVGhl
IHZpcnRpbyBzcGVjIHBhdGNoIGlzIGhlcmU6Cj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlz
dHMvbGludXgtdmlydHVhbGl6YXRpb24vbXNnNTAwMjcuaHRtbAoKCkhhdmUgYSBxdWljayBnbGFu
Y2UsIEkgc3VnZ2VzdCB0byBzcGxpdCBtZXJnZWFibGUgcnggYnVmZmVyIGludG8gYW4gCnNlcGFy
YXRlIHBhdGNoLgoKQnV0IEkgdGhpbmsgaXQncyB0aW1lIHRvIHJldmlzaXQgdGhlIGlkZWEgb2Yg
dW5pZnlpbmcgdGhlIHZpcnRpby1uZXQgYW5kIAp2aXJ0aW8tdnNvY2suIE90aGVyd2lzZSB3ZSdy
ZSBkdXBsaWNhdGluZyBmZWF0dXJlcyBhbmQgYnVncy4KClRoYW5rcwoKCj4KPiBGb3IgdGhvc2Ug
d2hvIHByZWZlciBnaXQgcmVwbywgaGVyZSBpcyB0aGUgbGluayBmb3IgdGhlIGxpbnV4IGtlcm5l
bO+8mgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9KaWFuZzExNTUvbGludXgvdHJlZS92c29jay1kZ3Jh
bS12MQo+Cj4gcWVtdSBwYXRjaCBsaW5rOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9KaWFuZzExNTUv
cWVtdS90cmVlL3Zzb2NrLWRncmFtLXYxCj4KPgo+IFRvIGRvOgo+IDEuIHVzZSBza2Igd2hlbiBy
ZWNlaXZpbmcgcGFja2V0cwo+IDIuIHN1cHBvcnQgbXVsdGlwbGUgdHJhbnNwb3J0Cj4gMy4gc3Vw
cG9ydCBtZXJnZWFibGUgcnggYnVmZmVyCj4KPgo+IEppYW5nIFdhbmcgKDYpOgo+ICAgIHZpcnRp
by92c29jazogYWRkIFZJUlRJT19WU09DS19GX0RHUkFNIGZlYXR1cmUgYml0Cj4gICAgdmlydGlv
L3Zzb2NrOiBhZGQgc3VwcG9ydCBmb3IgdmlydGlvIGRhdGFncmFtCj4gICAgdmhvc3QvdnNvY2s6
IGFkZCBzdXBwb3J0IGZvciB2aG9zdCBkZ3JhbS4KPiAgICB2c29ja190ZXN0OiBhZGQgdGVzdHMg
Zm9yIHZzb2NrIGRncmFtCj4gICAgdmhvc3QvdnNvY2s6IGFkZCBrY29uZmlnIGZvciB2aG9zdCBk
Z3JhbSBzdXBwb3J0Cj4gICAgdmlydGlvL3Zzb2NrOiBhZGQgc3lzZnMgZm9yIHJ4IGJ1ZiBsZW4g
Zm9yIGRncmFtCj4KPiAgIGRyaXZlcnMvdmhvc3QvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA4ICsKPiAgIGRyaXZlcnMvdmhvc3QvdnNvY2suYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMjA3ICsrKysrKysrLS0KPiAgIGluY2x1ZGUvbGludXgvdmlydGlv
X3Zzb2NrLmggICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsKPiAgIGluY2x1ZGUvbmV0L2Fm
X3Zzb2NrLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKPiAgIC4uLi90cmFj
ZS9ldmVudHMvdnNvY2tfdmlydGlvX3RyYW5zcG9ydF9jb21tb24uaCAgIHwgICA1ICstCj4gICBp
bmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3Zzb2NrLmggICAgICAgICAgICAgICAgICB8ICAgNCAr
Cj4gICBuZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxMiArCj4gICBuZXQvdm13X3Zzb2NrL3ZpcnRpb190cmFuc3BvcnQuYyAgICAgICAgICAgICAg
ICAgICB8IDQzMyArKysrKysrKysrKysrKysrKystLS0KPiAgIG5ldC92bXdfdnNvY2svdmlydGlv
X3RyYW5zcG9ydF9jb21tb24uYyAgICAgICAgICAgIHwgMTg0ICsrKysrKysrLQo+ICAgdG9vbHMv
dGVzdGluZy92c29jay91dGlsLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMDUgKysrKysK
PiAgIHRvb2xzL3Rlc3RpbmcvdnNvY2svdXRpbC5oICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA0ICsKPiAgIHRvb2xzL3Rlc3RpbmcvdnNvY2svdnNvY2tfdGVzdC5jICAgICAgICAgICAgICAg
ICAgIHwgMTk1ICsrKysrKysrKysKPiAgIDEyIGZpbGVzIGNoYW5nZWQsIDEwNzAgaW5zZXJ0aW9u
cygrKSwgOTcgZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
