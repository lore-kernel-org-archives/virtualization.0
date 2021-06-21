Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B4C48BE5
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 09:15:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E4F61002
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 09:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E4F61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2BD940022;
	Mon, 21 Jun 2021 09:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j23VHJLiLdAe; Mon, 21 Jun 2021 09:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6271A4014E;
	Mon, 21 Jun 2021 09:15:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A443C0010;
	Mon, 21 Jun 2021 09:15:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABC7C000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 09:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07EF740338
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 09:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UlOeHN3Mjdj6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 09:15:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94B8E40337
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624266938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzhILjZO1GQ5dj0O4IsZ9HQ9YHjirDYF2wLCGec3m2Q=;
 b=dVqBmLN7odgi3smgrM4SEphLD3+o9TOP8cadGgPo0wPxs1JXxE17L1YPfqVueKo/d5jyKp
 HEkPgOM6dn6dFhmOLVwYy+jE5tKBtXlqPAJLFXQ+N94F5F0lszH98BR9xxcUX9+zmedj6i
 r6wv2gamez31mZjg3kndhdPb6ZcyOj4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-q_-cCrpNNsuaYaDzygaV7A-1; Mon, 21 Jun 2021 05:15:37 -0400
X-MC-Unique: q_-cCrpNNsuaYaDzygaV7A-1
Received: by mail-pf1-f200.google.com with SMTP id
 s207-20020a6277d80000b0290300944a8bd2so3760316pfc.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 02:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wzhILjZO1GQ5dj0O4IsZ9HQ9YHjirDYF2wLCGec3m2Q=;
 b=aijnlUSf5yuZhV/Uhkoiti9ZBdslFVF8sE4YAsBBbv+S/5LtCT1w+7KJhn+vFL7vHp
 Jo4M1+NHi1V3xrTNAxgxkJHCEI8e3pB8BI3Yivj+bYYAytU9AOyEowv6uiLpuH6QQvTN
 V2oDehbMYSzbXt7HOsc2wxZ8pjDabkOooE/IFS4EqVG+4zdnvW4QfFaRBYGzcTzctbaS
 7eI4fryHqa3cgo/aosm4ysbi/c9NF4QNLUH3r4o31c/ZfVPRcrPDJzM9Mty4LARiQbZz
 O4Ts99KuDwsZYvywp4ijPt2WMlv3ei37Amlq6lyr5C0Mx8gWxzutW8P0swGt6zVoJhNg
 Fc9Q==
X-Gm-Message-State: AOAM531w4iaQXQaamec3LkgclIYKETQVj6VLg/9/0UZ+sIp67KsJk9l/
 UhjBkdGa+U3rthJxyhAcD4sDfJwCKyRnJ03mDx0zLZSCNkZ8RPZDiMHub4QAGb1XN5nYhpvXHWA
 xupSevZlLMo5/dPMOjvvGv/NP+OVlzaiDXLnkZXVYo1jOvkR2zkKerOG5vn2e/4x7Li5LUjfxKW
 u0TuPOwKZE9vtYs2r5+w==
X-Received: by 2002:a17:90b:2405:: with SMTP id
 nr5mr25169333pjb.184.1624266935925; 
 Mon, 21 Jun 2021 02:15:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzExoWE9JQgYQID1pXTKoKr8tFp6s0N+ps3+Y8yP5ZKwltSIcks06G3eLMFvF60ke7ya3mGbw==
X-Received: by 2002:a17:90b:2405:: with SMTP id
 nr5mr25169311pjb.184.1624266935693; 
 Mon, 21 Jun 2021 02:15:35 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s24sm18185495pju.9.2021.06.21.02.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jun 2021 02:15:35 -0700 (PDT)
Subject: Re: [PATCH] remove "#include<linux/virtio.h>"
To: Cai Huoqing <caihuoqing@baidu.com>, mst@redhat.com
References: <20210621074914.193-1-caihuoqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a32855c0-d23e-b385-8315-1714d5d89dbb@redhat.com>
Date: Mon, 21 Jun 2021 17:15:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621074914.193-1-caihuoqing@baidu.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8yMSDPws7nMzo0OSwgQ2FpIEh1b3Fpbmcg0LS1wDoKPiB2aXJ0aW9fY29uZmln
LmggYWxyZWFkeSBpbmNsdWRlcyB2aXJ0aW8uaC4gc28gcmVtb3ZlIGl0Cj4KPiBTaWduZWQtb2Zm
LWJ5OiBDYWkgSHVvcWluZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+CgoKSSB0aGluayB3ZSBzaG91
bGQgbm90IGRlcGVuZCBvbiBzdWNoIGRlcGVuZGVuY3kuCgpUaGFua3MKCgo+IC0tLQo+ICAgZHJp
dmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jICB8IDEgLQo+ICAgZHJpdmVycy92aXJ0aW8v
dmlydGlvLmMgICAgICAgICAgICB8IDEgLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX2lucHV0
LmMgICAgICB8IDEgLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyAgICAgICB8IDEg
LQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCB8IDEgLQo+ICAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAgICB8IDEgLQo+ICAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3ZkcGEuYyAgICAgICB8IDEgLQo+ICAgNyBmaWxlcyBjaGFuZ2VkLCA3IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyBiL2Ry
aXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+IGluZGV4IGM3NmViYjUzMTIxMi4uOGNi
NmZhODZmMDU1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEu
Ywo+ICsrKyBiL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYwo+IEBAIC0xMiw3ICsx
Miw2IEBACj4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gICAjaW5jbHVkZSA8bGludXgv
cGNpLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+IC0jaW5jbHVkZSA8bGludXgvdmly
dGlvLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ICAgI2luY2x1ZGUg
PGxpbnV4L3ZpcnRpb19yaW5nLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmlydGlvX3BjaS5oPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyBiL2RyaXZlcnMvdmlydGlvL3Zp
cnRpby5jCj4gaW5kZXggNGIxNWMwMGMwYTBhLi4wNmI2YzhjODZhZTUgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+
IEBAIC0xLDUgKzEsNCBAQAo+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQo+IC0jaW5jbHVkZSA8bGludXgvdmlydGlvLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvc3Bp
bmxvY2suaD4KPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gICAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19p
bnB1dC5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX2lucHV0LmMKPiBpbmRleCBjZTUxYWUxNjU5
NDMuLmFiODQzOWE5NGY3MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9faW5w
dXQuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19pbnB1dC5jCj4gQEAgLTEsNiArMSw1
IEBACj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cj4gICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gLSNpbmNsdWRlIDxsaW51eC92aXJ0aW8uaD4KPiAgICNp
bmNsdWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvaW5wdXQu
aD4KPiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19tbWlvLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gaW5kZXgg
NTYxMjhiOWM0NmViLi41MDYxZmYwODhkZDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX21taW8uYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPiBAQCAt
NjQsNyArNjQsNiBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgo+ICAg
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgo+
IC0jaW5jbHVkZSA8bGludXgvdmlydGlvLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmlydGlvX2Nv
bmZpZy5oPgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX21taW8uaD4KPiAgICNpbmNs
dWRlIDxsaW51eC92aXJ0aW9fcmluZy5oPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2NvbW1vbi5oIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaAo+
IGluZGV4IGJlZWMwNDdhOGY4ZC4uYWNhZTkxMmZkYjEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmgKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2NvbW1vbi5oCj4gQEAgLTIxLDcgKzIxLDYgQEAKPiAgICNpbmNsdWRlIDxsaW51eC9wY2ku
aD4KPiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvaW50ZXJy
dXB0Lmg+Cj4gLSNpbmNsdWRlIDxsaW51eC92aXJ0aW8uaD4KPiAgICNpbmNsdWRlIDxsaW51eC92
aXJ0aW9fY29uZmlnLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmlydGlvX3JpbmcuaD4KPiAgICNp
bmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggODhm
MGIxNmIxMWI4Li4wNzY2YmIyMjcyMTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMyw3
ICszLDYgQEAKPiAgICAqCj4gICAgKiAgQ29weXJpZ2h0IDIwMDcgUnVzdHkgUnVzc2VsbCBJQk0g
Q29ycG9yYXRpb24KPiAgICAqLwo+IC0jaW5jbHVkZSA8bGludXgvdmlydGlvLmg+Cj4gICAjaW5j
bHVkZSA8bGludXgvdmlydGlvX3JpbmcuaD4KPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fY29u
ZmlnLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4g
aW5kZXggZTI4YWNmNDgyZTBjLi44MGY3NTQwMTI5NmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMK
PiBAQCAtMTMsNyArMTMsNiBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+ICAgI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiAgICNpbmNsdWRlIDxsaW51eC91dWlkLmg+Cj4gLSNpbmNs
dWRlIDxsaW51eC92aXJ0aW8uaD4KPiAgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4gICAjaW5j
bHVkZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19y
aW5nLmg+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
