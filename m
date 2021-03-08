Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE10CC433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:42:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5827E6522F
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 16:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5827E6522F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26582400DC;
	Mon,  8 Mar 2021 16:42:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JRZSfmS5Ql6b; Mon,  8 Mar 2021 16:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20B16400D6;
	Mon,  8 Mar 2021 16:42:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01E69C000B;
	Mon,  8 Mar 2021 16:42:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5EADC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C978C6F4DA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_yp-xRtq0fp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:42:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1E4B605C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:42:52 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id u20so10595428iot.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Mar 2021 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BNlx4YPfM1nidlUove0a2nwdF4iPwX2FX54lO9BqECo=;
 b=PrcHqWM7PnbSdR1uQ2JziJWlKjjLrk2YVlkPA6r/nL9C/TPD9MIerRj2HQKQ71IvB5
 JZU4S05UPtRRGfcpGqJtEnZv4A7oASYA2vliIUFOdfFaoWy2tITkB2UETbyZ9QQ6EjCJ
 KUjWfSANCUvDkJYwX9160gXx8laQ8HA5OFt9Jcjv63VLYFq7e7Q7812gxrMeSAx9Rc2y
 HCRy9naWrSGM4I0ISYuLtmW5rYiX/RKy0a7rg7uJfNC5W8IkWhZ/hbIcpLkATg8bTaaJ
 uwcj/UHKS1bqp8Qf7+5Jddb55e5G5zDtBp/9y3nZBfCZAl3WYaW4VhQ234YZY1hBZPuw
 G+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BNlx4YPfM1nidlUove0a2nwdF4iPwX2FX54lO9BqECo=;
 b=JsKrRbdevmVcbL4IPyVDUYWBVa2IQO7k2KTXa5m2QHqTjKCowjd31N2wJ6V+iiUpo0
 onof0VG0OXk21Uc+CsTwBvkf/7DdYfLuAgQiDMLZJhRBzFjovJTOKQcRlsg3IOD3qG9N
 1aAzXvs/EJ0kxZ/DoCuC+5Z3U507UhVIVREllkMRy2D1vQex8bgZYiI2qMKmsBDIVtNY
 92SScX+aIsSdVIKFCs/Rp8Sm4v1KAzPkTjS9rj1qIVEYTXidPSsA8ra1iFRP6TpZqZmy
 2cToeCvzh9FpevyG/gfy7WKt9YWa/aGyN2kyuRmU3G8oMTyQCnF/FoIbL+08lRt/TyyJ
 TpgA==
X-Gm-Message-State: AOAM530eBwvXhXIL01IZ4OLpHjYYHOrOyjiLDgAV/i1I8OVKOVsQESUp
 whelu8JQH2cIlqk+hv23TBSmlXZmyXk=
X-Google-Smtp-Source: ABdhPJzIqKfSoF0sdk0JhHyfLAp1Hk3pGQs1ueevQq3Q58YZsgerxVcRu7ZhXkyZOXOPDB84Yy0r/g==
X-Received: by 2002:a6b:7302:: with SMTP id e2mr19112165ioh.106.1615221771648; 
 Mon, 08 Mar 2021 08:42:51 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.40])
 by smtp.googlemail.com with ESMTPSA id k10sm6291465iop.42.2021.03.08.08.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Mar 2021 08:42:51 -0800 (PST)
Subject: Re: [PATCH v2 2/2] net: avoid infinite loop in mpls_gso_segment when
 mpls_hlen == 0
To: Balazs Nemeth <bnemeth@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1615199056.git.bnemeth@redhat.com>
 <85e04e1e6367f19c8f538d145b32f5bb93788d8a.1615199056.git.bnemeth@redhat.com>
 <CA+FuTSdWSCzkB7sDn+_0Oxy8JqmqL=nsQXP_3bnb4Xdd=0A=KQ@mail.gmail.com>
 <718e4f13-31a8-037c-9725-08ae3cd93ccd@gmail.com>
 <543ebc518aa31f04bb6a85b66f37d984ede4b031.camel@redhat.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <f1fc417e-946b-6e92-3650-865834c289f3@gmail.com>
Date: Mon, 8 Mar 2021 09:42:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <543ebc518aa31f04bb6a85b66f37d984ede4b031.camel@redhat.com>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
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

T24gMy84LzIxIDk6MjYgQU0sIEJhbGF6cyBOZW1ldGggd3JvdGU6Cj4gT24gTW9uLCAyMDIxLTAz
LTA4IGF0IDA5OjE3IC0wNzAwLCBEYXZpZCBBaGVybiB3cm90ZToKPj4gT24gMy84LzIxIDk6MDcg
QU0sIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4+Pj4gZGlmZiAtLWdpdCBhL25ldC9tcGxzL21w
bHNfZ3NvLmMgYi9uZXQvbXBscy9tcGxzX2dzby5jCj4+Pj4gaW5kZXggYjE2OTAxNDliNmZhLi5j
YzFiNjQ1N2ZjOTMgMTAwNjQ0Cj4+Pj4gLS0tIGEvbmV0L21wbHMvbXBsc19nc28uYwo+Pj4+ICsr
KyBiL25ldC9tcGxzL21wbHNfZ3NvLmMKPj4+PiBAQCAtMjcsNyArMjcsNyBAQCBzdGF0aWMgc3Ry
dWN0IHNrX2J1ZmYgKm1wbHNfZ3NvX3NlZ21lbnQoc3RydWN0Cj4+Pj4gc2tfYnVmZiAqc2tiLAo+
Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqAgc2tiX3Jlc2V0X25ldHdvcmtfaGVhZGVyKHNrYik7Cj4+
Pj4gwqDCoMKgwqDCoMKgwqAgbXBsc19obGVuID0gc2tiX2lubmVyX25ldHdvcmtfaGVhZGVyKHNr
YikgLQo+Pj4+IHNrYl9uZXR3b3JrX2hlYWRlcihza2IpOwo+Pj4+IC3CoMKgwqDCoMKgwqAgaWYg
KHVubGlrZWx5KCFwc2tiX21heV9wdWxsKHNrYiwgbXBsc19obGVuKSkpCj4+Pj4gK8KgwqDCoMKg
wqDCoCBpZiAodW5saWtlbHkoIW1wbHNfaGxlbiB8fCAhcHNrYl9tYXlfcHVsbChza2IsCj4+Pj4g
bXBsc19obGVuKSkpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0
Owo+Pj4KPj4+IEdvb2QgY2F0aGMuIEJlc2lkZXMgbGVuZ3RoIHplcm8sIHRoaXMgY2FuIGJlIG1v
cmUgc3RyaWN0OiBhIGxhYmVsCj4+PiBpcwo+Pj4gNEIsIHNvIG1wbHNfaGxlbiBuZWVkcyB0byBi
ZSA+PSA0Qi4KPj4+Cj4+PiBQZXJoYXBzIGV2ZW4gYWxpZ25lZCB0byA0QiwgdG9vLCBidXQgbm90
IGlmIHRoZXJlIG1heSBiZSBvdGhlcgo+Pj4gZW5jYXAgb24gdG9wLgo+Pj4KPj4+IFVuZm9ydHVu
YXRlbHkgdGhlcmUgaXMgbm8gc3RydWN0IG9yIHR5cGUgZGVmaW5pdGlvbiB0aGF0IHdlIGNhbiB1
c2UKPj4+IGEKPj4+IHNpemVvZiBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIHRoZSByYXcgY29uc3Rh
bnQuCj4+Pgo+Pgo+PiBNUExTX0hMRU4gY2FuIGJlIHVzZWQgaGVyZS4KPj4KPiAKPiBXaGF0IGFi
b3V0IHNpemVvZihzdHJ1Y3QgbXBsc19sYWJlbCksIGxpa2UgaW4gbmV0L2lwdjQvdHVubmVsNC5j
Pwo+IAoKSSB3YXMgdGhpbmtpbmcgTVBMU19ITEVOIGJlY2F1c2Ugb2YgaXRzIGNvbnNpc3RlbnQg
dXNlIHdpdGggc2tiCm1hbmlwdWxhdGlvbnMuIG5ldC9tcGxzIGNvZGUgdXNlcyBtcGxzX3NoaW1f
aGRyIG92ZXIgbXBsc19sYWJlbC4KCkxvb2tzIGxpa2UgdGhlIE1QTFMgY29kZSBjb3VsZCB1c2Ug
c29tZSBjbGVhbnVwcyB0byBtYWtlIHRoaXMgY29uc2lzdGVudC4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
