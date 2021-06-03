Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E49C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B84613B4
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B84613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D673F40580;
	Thu,  3 Jun 2021 07:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2RKcshj6HzOM; Thu,  3 Jun 2021 07:49:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27EB0401D7;
	Thu,  3 Jun 2021 07:49:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB390C000E;
	Thu,  3 Jun 2021 07:49:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F316EC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8168402A3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m3el6loybtKT
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB88A401D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622706553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t2A9CGiOMZhMhfDQcj3P5Ci9kIgs20PIu0iiJiXQ0zk=;
 b=Nb0nZnN84jVXZx8u11OBIzsrG8LPoVK5kojE4hYE+BixbfxQhTLSIyJJ2rWC5MyngGOpEk
 I6w7jRqEfr181W2bXcCP1BkFRoUeuogiUOhwY8KrpNfo5blFDiE7pbwg1y+HjHOhrj67lU
 BiswLtc+Zr6KU0M8wSlN4ERM4Btb0zw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-u7delGAeOXqqJTxWwYsRLg-1; Thu, 03 Jun 2021 03:49:10 -0400
X-MC-Unique: u7delGAeOXqqJTxWwYsRLg-1
Received: by mail-pj1-f70.google.com with SMTP id
 t8-20020a17090aba88b029016baed73c00so1349658pjr.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 00:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=t2A9CGiOMZhMhfDQcj3P5Ci9kIgs20PIu0iiJiXQ0zk=;
 b=RP0yrzpcK5CQfG2iQpLuxqT4GQQZ1BKV/wl/KgJ5H4D/HwCnpPVdsNu3pvqGYJMbJ0
 lpVmcRta5oOCvwqfSGOZWw7oeqYHdP9azJCqoembhJWSy9o6tJX83i+CD4Kto90zdzwV
 knfEqQdSVShsKXZmlI0sVJwD0f/k+L75LHFAEgdTqIE/ZMaBImEf4ovdlzhznMCxaTAx
 OPZcJ3g1fjIFv+jLBGoLE9tZrGbhc2Ry4Hxt1vZKdfeLudI9Bazjo0//XTzpQm4OhGm1
 VGiXbkbjZQ56sIXQQ3dtPG0IuENDhaMEVWb1L7k3y/4jQCU2EUHb0+yiE5OYIFS8NLNK
 PutA==
X-Gm-Message-State: AOAM531tMc3TmIfqcbwHtrKu8kO2d9tVeiLEHrva9eQ4Jy15kXGZ5PQM
 0/qe331auKv/yFWDZSTACH3t972zYpQWPSTNcb0tJkV7W8tmKTlYheLrvNdW5fzdbhJBBXMgEyA
 +Rim0/P5/dqldp/jGxtGzPvRRlFnXjyxAhCliZpdGkg==
X-Received: by 2002:a17:902:e5d1:b029:107:810b:9f09 with SMTP id
 u17-20020a170902e5d1b0290107810b9f09mr13402433plf.83.1622706548889; 
 Thu, 03 Jun 2021 00:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG1kHzMlk/6bgLGiT7M+fez88v/bqO0OSrRP1I21Nb0TVRNHi1+b2//xRb2XxgVhHvx/ciHw==
X-Received: by 2002:a17:902:e5d1:b029:107:810b:9f09 with SMTP id
 u17-20020a170902e5d1b0290107810b9f09mr13402417plf.83.1622706548531; 
 Thu, 03 Jun 2021 00:49:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a188sm1553571pfa.59.2021.06.03.00.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 00:49:08 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
To: Eli Cohen <elic@nvidia.com>
References: <20210602095358.83318-1-elic@nvidia.com>
 <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
 <20210603073840.GB58414@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3ec31690-4cd8-1ea8-31dd-dfd3a8a25180@redhat.com>
Date: Thu, 3 Jun 2021 15:49:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603073840.GB58414@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzYvMyDkuIvljYgzOjM4LCBFbGkgQ29oZW4g5YaZ6YGTOgo+IE9uIFRodSwgSnVu
IDAzLCAyMDIxIGF0IDAzOjExOjUxUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IOWcqCAy
MDIxLzYvMiDkuIvljYg1OjUzLCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4gSW1wbGVtZW50IG1seDVf
Z2V0X3ZxX25vdGlmaWNhdGlvbigpIHRvIHJldHVybiB0aGUgZG9vcmJlbGwgYWRkcmVzcy4KPj4+
IFNpbmNlIHRoZSBub3RpZmljYXRpb24gYXJlYSBpcyBtYXBwZWQgdG8gdXNlcnNwYWNlLCBtYWtl
IHN1cmUgdGhhdCB0aGUKPj4+IEJBUiBzaXplIGlzIGF0IGxlYXN0IFBBR0VfU0laRSBsYXJnZS4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+IC0t
LQo+Pj4gdjAgLS0+IHYxOgo+Pj4gICAgIE1ha2Ugc3VyZSBTRiBiYXIgc2l6ZSBpcyBub3Qgc21h
bGxlciB0aGFuIFBBR0VfU0laRQo+Pj4KPj4+ICAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4
NV92ZHBhLmggfCAgMSArCj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5j
IHwgIDEgKwo+Pj4gICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8IDE3ICsr
KysrKysrKysrKysrKysrCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBi
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+IGluZGV4IDA5YTE2YTNkMWIy
YS4uMDAwMmIyMTM2YjQ4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9t
bHg1X3ZkcGEuaAo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+
Pj4gQEAgLTQyLDYgKzQyLDcgQEAgc3RydWN0IG1seDVfdmRwYV9yZXNvdXJjZXMgewo+Pj4gICAg
CXUzMiBwZG47Cj4+PiAgICAJc3RydWN0IG1seDVfdWFyc19wYWdlICp1YXI7Cj4+PiAgICAJdm9p
ZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4+PiArCXU2NCBwaHlzX2tpY2tfYWRkcjsKPj4+ICAgIAl1
MTYgdWlkOwo+Pj4gICAgCXUzMiBudWxsX21rZXk7Cj4+PiAgICAJYm9vbCB2YWxpZDsKPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIGIvZHJpdmVycy92
ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwo+Pj4gaW5kZXggODM2YWI5ZWYwZmE2Li5kNDYwNjIx
M2Y4OGEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5j
Cj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4+PiBAQCAtMjUz
LDYgKzI1Myw3IEBAIGludCBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldikKPj4+ICAgIAkJZ290byBlcnJfa2V5Owo+Pj4gICAgCWtpY2tfYWRkciA9
IG1kZXYtPmJhcl9hZGRyICsgb2Zmc2V0Owo+Pj4gKwlyZXMtPnBoeXNfa2lja19hZGRyID0ga2lj
a19hZGRyOwo+Pj4gICAgCXJlcy0+a2lja19hZGRyID0gaW9yZW1hcChraWNrX2FkZHIsIFBBR0Vf
U0laRSk7Cj4+PiAgICAJaWYgKCFyZXMtPmtpY2tfYWRkcikgewo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+Pj4gaW5kZXggNTUwMGJjZmU4NGI0Li4xOTM2MDM5ZTA1YmQgMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gQEAgLTE4NzEsOCArMTg3MSwyNSBAQCBz
dGF0aWMgdm9pZCBtbHg1X3ZkcGFfZnJlZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+PiAg
ICBzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgbWx4NV9nZXRfdnFfbm90aWZp
Y2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkKPj4+ICAgIHsKPj4+ICsJ
c3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+PiAgICAJc3Ry
dWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgcmV0ID0ge307Cj4+PiArCXN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2Owo+Pj4gKwlwaHlzX2FkZHJfdCBhZGRyOwo+Pj4gKwo+Pj4gKwkvKiBJZiBT
RiBCQVIgc2l6ZSBpcyBzbWFsbGVyIHRoYW4gUEFHRV9TSVpFLCBkbyBub3QgdXNlIGRpcmVjdAo+
Pj4gKwkgKiBub3RpZmljYXRpb24gdG8gYXZvaWQgdGhlIHJpc2sgb2YgbWFwcGluZyBwYWdlcyB0
aGF0IGNvbnRhaW4gQkFSIG9mIG1vcmUKPj4+ICsJICogdGhhbiBvbmUgU0YKPj4+ICsJICovCj4+
PiArCWlmIChNTFg1X0NBUF9HRU4obXZkZXYtPm1kZXYsIGxvZ19taW5fc2Zfc2l6ZSkgKyAxMiA8
IFBBR0VfU0hJRlQpCj4+PiArCQlyZXR1cm4gcmV0Owo+Pj4gKwo+Pj4gKwluZGV2ID0gdG9fbWx4
NV92ZHBhX25kZXYobXZkZXYpOwo+Pj4gKwlhZGRyID0gKHBoeXNfYWRkcl90KW5kZXYtPm12ZGV2
LnJlcy5waHlzX2tpY2tfYWRkcjsKPj4+ICsJaWYgKGFkZHIgJiB+UEFHRV9NQVNLKQo+Pj4gKwkJ
cmV0dXJuIHJldDsKPj4KPj4gVGhpcyBoYXMgYmVlbiBjaGVja2VkIGJ5IHZob3N0LXZEUEEsIGFu
ZCBpdCdzIGJldHRlciB0byBsZWF2ZSB0aG9zZSBwb2xpY3kKPj4gY2hlY2tpbmcgdG8gdGhlbSBk
cml2ZXIgaW5zdGVhZCBvZiBjaGVja2luZyBpdCBpbiB0aGUgcGFyZW50Lgo+Pgo+IE5vdCBpbiBh
bGwgaW52b2NhdGlvbnMgb2YgZ2V0X3ZxX25vdGlmaWNhdGlvbigpLiBGb3IgZXhhbXBsZSwgaW4K
PiB2aG9zdF92ZHBhX2ZhdWx0KCkgeW91IGNhbGwgcmVtYXBfcGZuX3JhbmdlKCkgd2l0aCBub3Rp
ZnkuYWRkciA+Pgo+IFBBR0VfU0hJRlQgc28gaXQgaXQgd2FzIG5vdCBhbGlnbmVkIHlvdSBtYXNr
IHRoaXMgbWlzYWxpZ25tZW50LgoKCkluIG9yZGVyIHRvIGhhdmUgdmhvc3RfdmRwYV9mYXVsdCgp
IHdvcmtzLCBpdCBzaG91bGQgZmlyc3QgcGFzcyB0aGUgCmNoZWNrIG9mIHZob3N0X3ZkcGFfbW1h
cCgpLgoKT3RoZXdpc2Ugd2Ugd29uJ3QgaW5zdGFsbCB2bWEtPnZtX29wcyBzbyB0aGVyZSB3b24n
dCBiZSBhIHBhZ2UgZmF1bHQgZm9yIAp0aGUgZG9vcmJlbGwuCgpUaGFua3MKCgo+Cj4+IFRoYW5r
cwo+Pgo+Pgo+Pj4gKwlyZXQuYWRkciA9IChwaHlzX2FkZHJfdCluZGV2LT5tdmRldi5yZXMucGh5
c19raWNrX2FkZHI7Cj4+PiArCXJldC5zaXplID0gUEFHRV9TSVpFOwo+Pj4gICAgCXJldHVybiBy
ZXQ7Cj4+PiAgICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
