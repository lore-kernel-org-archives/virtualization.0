Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D304EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  1 Mar 2022 10:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64D9F4051A;
	Tue,  1 Mar 2022 10:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJ4FBUko0ir0; Tue,  1 Mar 2022 10:28:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACE324011D;
	Tue,  1 Mar 2022 10:28:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4E9C0033;
	Tue,  1 Mar 2022 10:28:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61070C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 10:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ECA44013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 10:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id umciLz7aW4eS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 10:28:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED8684011D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 10:28:30 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id cx5so1137631pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OnrvTGkeFdz9SdbU5YzUcBSW1gSC4dxIsoPtl5S/0ts=;
 b=lMlykeCoeBj9pbm8Ib7uSMq9dStt/53mqUfx2z5VFG6jvOn36rzyKO/bfGleQvEiXE
 FzasQdln3ka7j+JaThLPFGyV6U/ACZts500Rvo7q6u6i20CssPsw9nnuZwPNED0r70UU
 5SK3n9+/DGKFtTmR8ghteojViVhQui3Cqzdce3A358Y6XD0PPkAOFXP9zod+bwchXybO
 YBdv506L4f553PXcFwYQ7ywQg7js5X7r/PcC4E6iId7+DfqWvRvwOzc7LFxQ/zWtRVVU
 /Dp8PKzt37KMYZUWpmtsV6CiTl2Rtryy1BoegmoOY86Al9w3GbFbtgOFWwfN85Qey9Ys
 ndtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OnrvTGkeFdz9SdbU5YzUcBSW1gSC4dxIsoPtl5S/0ts=;
 b=gqYEnPM9APapAKs35Yi62/ilwDUTXxpFcm2yC7rL7ZgY/PwYAIMGLyxOe+macEYirZ
 k48vQQxPXZM3QT1xv8mP2poLqITc3pzQ9QunzO/S1jfAulL8fXJ2NAEYbdm0ESiD/vQR
 ONV8L34ZN6lvK1QO3Ri3HlrFDg6rIWlP7VXROYqSXPxDaCi9Pulcuvrraz8zSVWjLryD
 IUDE/IpAwITbm2neQvAbMivCoR8jiub/cCSFVtfe4o9Krr96L640w5oVejqPv1dr5k3d
 Bsnq9eXSgSZqKKZWCNYQIVHAHMUkezaGwgET25XrZTzEI0JYfCZCctNimuR+Rl1CU7nc
 aQkw==
X-Gm-Message-State: AOAM533g9myXSzrH+bIJPJKwNlEO+TG5sYiEtyIbbOpmeD9GW7LiVIBo
 CY/dz0NvGAqAgFyX95QDNYv8Zg==
X-Google-Smtp-Source: ABdhPJyRALXKhW8s2bFsc2BXDdKE696FpYRLC0WDq+QpkTb6aaJXFusyucj3Yl8gAZuVpQGgt+Wr/A==
X-Received: by 2002:a17:902:7204:b0:14f:b325:7658 with SMTP id
 ba4-20020a170902720400b0014fb3257658mr24704466plb.110.1646130510135; 
 Tue, 01 Mar 2022 02:28:30 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a63a54c000000b00376047bf784sm12271772pgu.23.2022.03.01.02.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 02:28:29 -0800 (PST)
Subject: PING: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
From: zhenwei pi <pizhenwei@bytedance.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
 <20220211084108.1254218-4-pizhenwei@bytedance.com>
 <c9144b0d82e34566a960f210ddc32696@huawei.com>
 <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
 <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
Message-ID: <0c148ada-9f32-3272-8a89-591299ab098d@bytedance.com>
Date: Tue, 1 Mar 2022 18:25:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
Content-Language: en-US
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, kernel test robot <lkp@intel.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
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

UElORyEKCkhpLCBMZWkKSSBhbHNvIHRha2UgYSBsb29rIGF0IG90aGVyIGNyeXB0byBkcml2ZXJz
IHFhdC9jY3AvaGlzaWxpY29uLCB0aGV5CnNlcGFyYXRlIGFrY2lwaGVyL3NrY2lwaGVyIGFsZ28u
IElmIHlvdSBjb25zaWRlciB0aGF0IHJldXNpbmcKdmlydGlvX2NyeXB0b19hbGdzX3JlZ2lzdGVy
L3VucmVnaXN0ZXIgc2VlbXMgYmV0dGVyLCBJIHdpbGwgdHJ5IHRvIG1lcmdlCnRoZW0gaW50byBh
IHNpbmdsZSBmdW5jdGlvbi4KCk9uIDIvMjMvMjIgNjoxNyBQTSwgemhlbndlaSBwaSB3cm90ZToK
PiAKPiBPbiAyLzE4LzIyIDExOjEyIEFNLCB6aGVud2VpIHBpIHdyb3RlOgo+Pj4+ICt2b2lkIHZp
cnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc191bnJlZ2lzdGVyKHN0cnVjdCB2aXJ0aW9fY3J5cHRv
Cj4+Pj4gKyp2Y3J5cHRvKSB7Cj4+Pj4gK8KgwqDCoCBpbnQgaSA9IDA7Cj4+Pj4gKwo+Pj4+ICvC
oMKgwqAgbXV0ZXhfbG9jaygmYWxnc19sb2NrKTsKPj4+PiArCj4+Pj4gK8KgwqDCoCBmb3IgKGkg
PSAwOyBpIDwgQVJSQVlfU0laRSh2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ3MpOyBpKyspIHsK
Pj4+PiArwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc2VydmljZSA9IHZpcnRpb19jcnlwdG9fYWtj
aXBoZXJfYWxnc1tpXS5zZXJ2aWNlOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBhbGdv
bnVtID0gdmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFsZ29udW07Cj4+Pj4gKwo+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAodmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFjdGl2
ZV9kZXZzID09IDAgfHwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhdmlydGNyeXB0b19h
bGdvX2lzX3N1cHBvcnRlZCh2Y3J5cHRvLCBzZXJ2aWNlLCBhbGdvbnVtKSkKPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
ICh2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ3NbaV0uYWN0aXZlX2RldnMgPT0gMSkKPj4+PiAr
Cj4+Pj4gwqDCoMKgwqBjcnlwdG9fdW5yZWdpc3Rlcl9ha2NpcGhlcigmdmlydGlvX2NyeXB0b19h
a2NpcGhlcl9hbGdzW2ldLmFsZ28pOwo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgdmlydGlv
X2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFjdGl2ZV9kZXZzLS07Cj4+Pj4gK8KgwqDCoCB9Cj4+
Pj4gKwo+Pj4+ICvCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhbGdzX2xvY2spOwo+Pj4+ICt9Cj4+Pgo+
Pj4gV2h5IGRvbid0IHlvdSByZXVzZSB0aGUgdmlydGlvX2NyeXB0b19hbGdzX3JlZ2lzdGVyL3Vu
cmVnaXN0ZXIgCj4+PiBmdW5jdGlvbnM/Cj4+PiBUaGUgY3VycmVudCBjb2RlIGlzIHRvbyByZXBl
dGl0aXZlLiBNYXliZSB3ZSBkb24ndCBuZWVkIGNyZWF0ZSB0aGUgCj4+PiBuZXcgZmlsZSB2aXJ0
aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ28uYwo+Pj4gYmVjYXVzZSB3ZSBoYWQgdmlydGlvX2NyeXB0
b19hbGdzLmMgd2hpY2ggaW5jbHVkZXMgYWxsIGFsZ29yaXRobXMuCj4+Pgo+Pgo+PiBZZXMsIHRo
aXMgbG9va3Mgc2ltaWxhciB0byB2aXJ0aW9fY3J5cHRvX2FsZ3NfcmVnaXN0ZXIvdW5yZWdpc3Rl
ci4KPj4KPj4gTGV0J3MgbG9vayBhdCB0aGUgZGlmZmVyZW5jZToKPj4gc3RydWN0IHZpcnRpb19j
cnlwdG9fYWtjaXBoZXJfYWxnbyB7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgYWxnb251
bTsKPj4gwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBzZXJ2aWNlOwo+PiDCoMKgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGludCBhY3RpdmVfZGV2czsKPj4gwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
YWtjaXBoZXJfYWxnIGFsZ287Cj4+IH07Cj4+Cj4+IHN0cnVjdCB2aXJ0aW9fY3J5cHRvX2FsZ28g
ewo+PiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IGFsZ29udW07Cj4+IMKgwqDCoMKgwqDCoMKg
wqAgdWludDMyX3Qgc2VydmljZTsKPj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgYWN0
aXZlX2RldnM7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrY2lwaGVyX2FsZyBhbGdvOyAv
KiBha2NpcGhlcl9hbGcgVlMgc2tjaXBoZXJfYWxnICovCj4+IH07Cj4+Cj4+IElmIHJldXNpbmcg
dmlydGlvX2NyeXB0b19hbGdzX3JlZ2lzdGVyL3VucmVnaXN0ZXIsIHdlIG5lZWQgdG8gbW9kaWZ5
IAo+PiB0aGUgZGF0YSBzdHJ1Y3R1cmUgbGlrZSB0aGlzOgo+PiBzdHJ1Y3QgdmlydGlvX2NyeXB0
b19ha2NpcGhlcl9hbGdvIHsKPj4gwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBhbGdvbnVtOwo+
PiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHNlcnZpY2U7wqDCoMKgIC8qIHVzZSBzZXJ2aWNl
IHRvIGRpc3Rpbmd1aXNoIAo+PiBha2NpcGhlci9za2NpcGhlciAqLwo+PiDCoMKgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGludCBhY3RpdmVfZGV2czsKPj4gwqDCoMKgwqDCoHVuaW9uIHsKPj4gwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2tjaXBoZXJfYWxnIHNrY2lwaGVyOwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGFrY2lwaGVyX2FsZyBha2NpcGhlcjsKPj4gwqDCoMKgwqDC
oH0gYWxnOwo+PiB9Owo+Pgo+PiBpbnQgdmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzX3JlZ2lz
dGVyKHN0cnVjdCB2aXJ0aW9fY3J5cHRvICp2Y3J5cHRvKQo+PiB7Cj4+IMKgwqDCoMKgwqAuLi4K
Pj4gwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh2aXJ0aW9fY3J5
cHRvX2FrY2lwaGVyX2FsZ3MpOyBpKyspIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDMyX3Qgc2VydmljZSA9IAo+PiB2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ3Nb
aV0uc2VydmljZTsKPj4gwqDCoMKgwqDCoMKgwqDCoCAuLi4KPj4gwqDCoMKgwqDCoMKgwqDCoCAv
KiB0ZXN0IHNlcnZpY2UgdHlwZSB0aGVuIGNhbGwgCj4+IGNyeXB0b19yZWdpc3Rlcl9ha2NpcGhl
ci9jcnlwdG9fcmVnaXN0ZXJfc2tjaXBoZXIgKi8KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHNlcnZpY2UgPT0gVklSVElPX0NSWVBUT19TRVJWSUNFX0FLQ0lQSEVSKQo+
PiBjcnlwdG9fcmVnaXN0ZXJfYWtjaXBoZXIoJnZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc1tp
XS5hbGdvLmFrY2lwaGVyKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4+IGNyeXB0b19yZWdp
c3Rlcl9za2NpcGhlcigmdmlydGlvX2NyeXB0b19za2NpcGhlcl9hbGdzW2ldLmFsZ28uc2tjaXBo
ZXIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgIC4uLgo+PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDC
oMKgwqDCoC4uLgo+PiB9Cj4+Cj4+IEFsc28gdGVzdCBzZXJ2aWNlIHR5cGUgYW5kIGNhbGwgCj4+
IGNyeXB0b191bnJlZ2lzdGVyX3NrY2lwaGVyL2NyeXB0b191bnJlZ2lzdGVyX2FrY2lwaGVyLgo+
Pgo+PiBUaGlzIGdldHMgdW5jbGVhciBmcm9tIGN1cnJlbnQgdjIgdmVyc2lvbi4KPj4KPj4gT24g
dGhlIG90aGVyIGhhbmQsIHRoZSBrZXJuZWwgc2lkZSBwcmVmZXJzIHRvIHNlcGFyYXRlIHNrY2lw
aGVyIGFuZCAKPj4gYWtjaXBoZXIoc2VwYXJhdGVkIGhlYWRlciBmaWxlcyBhbmQgaW1wbGVtZW50
YXRpb25zKS4KPj4KPgoKLS0gCnpoZW53ZWkgcGkKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
