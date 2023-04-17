Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0F3C77B73
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 02:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10CD9418BF;
	Mon, 17 Apr 2023 02:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10CD9418BF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=oC4D72dU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkRkSrsE9LgV; Mon, 17 Apr 2023 02:11:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57984418B6;
	Mon, 17 Apr 2023 02:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57984418B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C7C5C0037;
	Mon, 17 Apr 2023 02:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86CCFC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A956418BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:11:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A956418BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LSFuAzcDSk51
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:11:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 125AC418B6
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 125AC418B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:11:51 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id g6so7132978pjx.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 19:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681697511; x=1684289511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnlRciSQ8X7WWGZSx9hlRKrfeUfAjen+Pljb/Shq8Sc=;
 b=oC4D72dU+xIQQLgJ0rL5uWC1ObsbwOLg7HQAJGC0ZN4mEn16fRnH07IOMu/JQcZHVH
 y7kig+eTtWN4th/cMy+FDkPO/R/DHxM4bC1pRyAsqsot5USVytJI0+sPz4oV7xL+HHnS
 jlqzgzZY35vEtUr3zN8mFUlbzooT83WYdR7EJuHOiirqehiRdGAN9P/bjPdgJk1bEy6e
 sJTh1G5QRUFz+psa1A5teBbZ+u5SjW33X7OWvCOZmj4+UCkqQV2je8TpCtfslDySBjNF
 nAp8+hlqj+NDAmH1pggj2FlIpZybJP/h98QTSZafdhwRrPRTzq+JGuamUvh6DfI6IYaS
 E5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681697511; x=1684289511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rnlRciSQ8X7WWGZSx9hlRKrfeUfAjen+Pljb/Shq8Sc=;
 b=Bcuzho8pd4MCynlnnClhDbeX2aoXStKbgDZ8oHme08sVue2acrE4wMrwkTPL5IGyzP
 i3jFhN/Kqz9BZlV7eq+d7u1RjwYSH4TY73JggqoY6s+Bmc00goH/s6PYuwk4Atk9nJWP
 Sj1iBqV9qTLAdBLmS5O9CUpvdS6qDR5x1KaXeQ/AVO4MfBLXiND22F94SaxNOrwKgxMa
 286leyxXu8uI1vtX3HSzVgbcyE6FiMxoW/PhLhqa3ZZBw8FNkhYmNxf/WbooBplNJbAt
 ILWTdr+gPiGJq7CmXJYeT8fk8AcC30kcle44VUFILEy/4VpfoQn4I3y411XfEIzLfCcX
 OEQw==
X-Gm-Message-State: AAQBX9eA8SbP+WnmZ7zxdJBCXfsRt2TEnztZNMhFj6qjAswbvtneCFUb
 9LPPgQm3/wOf1dySp8p/JkJtDw==
X-Google-Smtp-Source: AKy350bdaEVaA1sWVsC9V0FCl4r1X6pxb+q8V0/MS/TJCKBus8mKe7bvfysrPGRxWoo4C11vImaaZg==
X-Received: by 2002:a05:6a20:b284:b0:eb:df85:5d7c with SMTP id
 ei4-20020a056a20b28400b000ebdf855d7cmr12602133pzb.11.1681697511245; 
 Sun, 16 Apr 2023 19:11:51 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d14-20020aa78e4e000000b00639eae8816asm6475158pfr.130.2023.04.16.19.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Apr 2023 19:11:50 -0700 (PDT)
Message-ID: <9e9acbf6-3486-56d3-c15a-c3d67557c2a9@igel.co.jp>
Date: Mon, 17 Apr 2023 11:11:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [EXT] [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
Content-Language: en-US
To: Frank Li <frank.li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20230414123903.896914-1-mie@igel.co.jp>
 <AM6PR04MB483871ADC2BA657BBF3A5A4588999@AM6PR04MB4838.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <AM6PR04MB483871ADC2BA657BBF3A5A4588999@AM6PR04MB4838.eurprd04.prod.outlook.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Ren Zhijie <renzhijie2@huawei.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

Ck9uIDIwMjMvMDQvMTQgMjM6MzksIEZyYW5rIExpIHdyb3RlOgo+Cj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tCj4+IEZyb206IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28uanA+Cj4+IFNl
bnQ6IEZyaWRheSwgQXByaWwgMTQsIDIwMjMgNzozOSBBTQo+PiBUbzogTG9yZW56byBQaWVyYWxp
c2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz4KPj4gQ2M6IEtyenlzenRvZiBXaWxjennFhHNraSA8
a3dAbGludXguY29tPjsgTWFuaXZhbm5hbiBTYWRoYXNpdmFtCj4+IDxtYW5pQGtlcm5lbC5vcmc+
OyBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25Aa2VybmVsLm9yZz47IEJqb3JuCj4+IEhl
bGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRo
YXQuY29tPjsKPj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IFNodW5zdWtlIE1p
ZSA8bWllQGlnZWwuY28uanA+Owo+PiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IEpvbiBN
YXNvbiA8amRtYXNvbkBrdWR6dS51cz47IFJhbmR5Cj4+IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRl
YWQub3JnPjsgUmVuIFpoaWppZSA8cmVuemhpamllMkBodWF3ZWkuY29tPjsKPj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsKPj4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4gU3ViamVjdDogW0VYVF0gW1JG
QyBQQVRDSCAwLzNdIEludHJvZHVjZSBhIFBDSWUgZW5kcG9pbnQgdmlydGlvIGNvbnNvbGUKPj4K
Pj4gQ2F1dGlvbjogRVhUIEVtYWlsCj4+Cj4+IFBDSWUgZW5kcG9pbnQgZnJhbWV3b3JrIHByb3Zp
ZGVzIEFQSXMgdG8gaW1wbGVtZW50IFBDSWUgZW5kcG9pbnQKPj4gZnVuY3Rpb24uCj4+IFRoaXMg
ZnJhbWV3b3JrIGFsbG93cyBkZWZpbmluZyB2YXJpb3VzIFBDSWUgZW5kcG9pbnQgZnVuY3Rpb24g
YmVoYXZpb3JzIGluCj4+IHNvZnR3YXJlLiBUaGlzIHBhdGNoIGV4dGVuZCB0aGUgZnJhbWV3b3Jr
IGZvciB2aXJ0aW8gcGNpIGRldmljZS4gVGhlCj4+IHZpcnRpbyBpcyBkZWZpbmVkIHRvIGNvbW11
bmljYXRlIGd1ZXN0IG9uIHZpcnR1YWwgbWFjaGluZSBhbmQgaG9zdCBzaWRlLgo+PiBBZHZhbnRh
Z2Ugb2YgdGhlIHZpcnRpbyBpcyB0aGUgZWZmaWNpZW5jeSBvZiBkYXRhIHRyYW5zZmVyIGFuZCB0
aGUgY29uY2lzZW5lc3MKPj4gb2YgaW1wbGVtZW50YXRpb24gZGV2aWNlIHVzaW5nIHNvZnR3YXJl
LiBJdCBhbHNvIGJlIGFwcGxpZWQgdG8gUENJZQo+PiBlbmRwb2ludCBmdW5jdGlvbi4KPj4KPj4g
V2UgZGVzaWduZWQgYW5kIGltcGxlbWVudGVkIGEgUENJZSBFUCB2aXJ0aW8gY29uc29sZSBmdW5j
dGlvbiBkcml2ZXIgdXNpbmcKPj4gdGhlIGV4dGVuZGVkIFBDSWUgZW5kcG9pbnQgZnJhbWV3b3Jr
IGZvciB2aXJ0aW8uIEl0IGNhbiBiZSBjb21tdW5pY2F0ZQo+PiBob3N0IGFuZCBlbmRwb2ludCBv
dmVyIHZpcnRpbyBhcyBjb25zb2xlLgo+Pgo+PiBBbiBhcmNoaXRlY3R1cmUgb2YgdGhlIGZ1bmN0
aW9uIGRyaXZlciBpcyBmb2xsb3dpbmc6Cj4+Cj4+ICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSQICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSACj4+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkAo+PiAgIOKUgnZpcnRpbyAgICAgIOKUgiAgICAg
ICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIJ2aXJ0aW8gICAgICDilIIKPj4gICDilIJj
b25zb2xlIGRydiDilIIgICAgICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilJAgICAgICDilIJjb25zb2xlCj4+IGRydiDilIIKPj4gICDilJzilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAgICDilIIodmlydGlvIGNv
bnNvbGXilIIgICAgICDilJzilIDilIDilIDilIDilIAKPj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkCj4+ICAg4pSCIHZpcnRpbyBidXMg4pSCICAgICAgICAg4pSCIGRldmljZSkgICAgICAg4pSC
4peE4pSA4pSA4pSA4pSA4pa64pSCIHZpcnRpbyBidXMg4pSCCj4+ICAg4pSc4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgICAgICAg4pScLS0tLS0tLS0tLS0tLS0t4pSk
ICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSACj4+IOKUgOKUgOKUgOKUgOKUgOKUgOKUpAo+PiAg
IOKUgiAgICAgICAgICAgIOKUgiAgICAgICAgIOKUgiBwY2kgZXAgdmlydGlvIOKUgiAgICAgICAg
ICAgICAgICAgICDilIIKPj4gICDilIIgIHBjaSBidXMgICDilIIgICAgICAgICDilIIgIGNvbnNv
bGUgZHJ2ICDilIIgICAgICAgICAgICAgICAgICAg4pSCCj4+ICAg4pSCICAgICAgICAgICAg4pSC
ICBwY2llICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkICAgICAgICAgICAgICAgICAgIOKUggo+PiAgIOKUgiAgICAgICAgICAgIOKUgiDil4TilIDi
lIDilIDilIDilIDilrog4pSCICBwY2kgZXAgQnVzICAg4pSCICAgICAgICAgICAgICAgICAgIOKU
ggo+PiAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAgICAgICAg
IOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+PiDilIDilLTi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lJgKPj4gICAgIFBDSWUgUm9vdCAgICAgICAgICAgICAgUENJZSBFbmRwb2ludAo+Pgo+IFtGcmFu
ayBMaV0gU29tZSBiYXNpYyBxdWVzdGlvbiwKPiBJIHNlZSB5b3UgY2FsbCByZWdpc3Rlcl92aXJ0
aW9fZGV2aWNlIGF0IGVwZl92Y29uX3NldHVwX3ZkZXYsCj4gV2h5IGNhbGwgaXQgYXMgdmlydGlv
IGNvbnNvbGU/ICBJIHN1cHBvc2UgaXQgc2hvdWxkIGJlIHZpcnRpb2J1cyBkaXJlY3RseT8KCkkn
bSBzb3JyeSBJIGRpZG4ndCB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24uIFdoYXQgZG8geW91IG1l
YW4gdGhlIAp2aXJ0aW9idXMgZGlyZWN0bHk/Cgo+Cj4gUHJldmlvdXMgeW91IHVzZSB2aXJ0aW8t
bmV0LCB3aHkgY2hhbmdlIHRvIHZpcnRpby1jb25zb2xlIGhlcmU/ICBEb2VzIGl0IG1hdHRlcj8K
Ck5vLCBpdCBkb2Vzbid0LiBKdXN0IEknZCBsaWtlIHRvIGJyZWFrIGRvd24gdGhlIGNoYW5nZXMg
aW50byBzbWFsbGVyIApzdGVwcyB0byBtYWtlIGl0IGVhc2llciB0byByZXZpZXcgYW5kIG1lcmdl
IHRoZSBjaGFuZ2VzLgoKQXMgYSBmaXJzdCBzdGVwLCBJIHByb3Bvc2UgYWRkaW5nIGEgc2ltcGxl
c3QgdmlydGlvIGZ1bmN0aW9uIGRyaXZlciB3aXRoIAp0aGUgZXh0ZW5zaW9uIGRlZmluZWQgaW4g
cGNpLWVwZi12aXJ0aW8ue2gsY30uCgo+IEFsbCB2aXJ0aW8tWFhYIHNob3VsZCB3b3JrPwpZZXMs
IHRoZSBleHRlbnNpb24gaXMgZGVzaWduZWQgdG8gdXNlIGFueSB0eXBlIG9mIHZpcnRpbyBkZXZp
Y2UuCj4KPiBZb3UgcmVtb3ZlZCBFRE1BIHN1cHBvcnQgdGhpcyB2ZXJzaW9uPwpJIHBsYW5lZCB0
aGUgc3VwcG9ydCB3aWxsIGJlIGFkZGVkIHdpdGggZXBmIHZpcnRpby1uZXQgcGF0Y2hlcy4KPgo+
PiBJbnRyb2R1Y2VkIGRyaXZlciBpcyBgcGNpIGVwIHZpcnRpbyBjb25zb2xlIGRydmAgaW4gdGhl
IGZpZ3VyZS4gSXQgd29ya3MKPj4gYXMgZXAgZnVuY3Rpb24gZm9yIFBDSWUgcm9vdCBhbmQgdmly
dHVhbCB2aXJ0aW8gY29uc29sZSBkZXZpY2UgZm9yIFBDSWUKPj4gZW5kcG9pbnQuIEVhY2ggc2lk
ZSBvZiB2aXJ0aW8gY29uc29sZSBkcml2ZXIgaGFzIHZpcnRxdWV1ZSwgYW5kCj4+IGludHJvZHVj
ZWQgZHJpdmVyIHRyYW5zZmVycyBkYXRhIG9uIHRoZSB2aXJ0cXVldWUgdG8gZWFjaCBvdGhlci4g
QSBkYXRhCj4+IG9uIHJvb3QgdHggcXVldWUgaXMgdHJhbnNmZXJlZCB0byBlbmRwb2ludCByeCBx
dWV1ZSBhbmQgdmljZSB2ZXJzYS4KPj4KPj4gVGhpcyBwYXRjaHNldCBpcyBkZXBlbmQgZm9sbHdp
bmcgcGF0Y2hlcyB3aGljaCBhcmUgdW5kZXIgZGlzY3Vzc2lvbi4KPj4KPj4gLSBbUkZDIFBBVENI
IDAvM10gRGVhbCB3aXRoIGFsaWdubWVudCByZXN0cmljdGlvbiBvbiBFUCBzaWRlCj4+IGxpbms6
Cj4+IGh0dHBzOi8vbG9yZS5rLwo+PiBlcm5lbC5vcmclMkZsaW51eC1wY2klMkYyMDIzMDExMzA5
MDM1MC4xMTAzNDk0LTEtCj4+IG1pZSU0MGlnZWwuY28uanAlMkYmZGF0YT0wNSU3QzAxJTdDRnJh
bmsuTGklNDBueHAuY29tJTdDZWE2NTEzZGJmCj4+IDQwODRiODBjZWQyMDhkYjNjZTU0MTMzJTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTcKPj4gQzAlN0M2MzgxNzA3Mjc1
NTg4MDA3MjAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3Cj4+IExqQXdNREFp
TENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MK
Pj4gJTdDJTdDJnNkYXRhPWpZZ3klMkJ4azg0WlhaUlZmcW0wR0NYb1JuQ1RMTXJYNHpUZlYlMkJz
NU1tc3ZvCj4+ICUzRCZyZXNlcnZlZD0wCj4+IC0gW1JGQyBQQVRDSCB2MiAwLzddIEludHJvZHVj
ZSBhIHZyaW5naCBhY2Nlc3NvciBmb3IgSU8gbWVtb3J5Cj4+IGxpbms6Cj4+IGh0dHBzOi8vbG9y
ZS5rLwo+PiBlcm5lbC5vcmclMkZ2aXJ0dWFsaXphdGlvbiUyRjIwMjMwMjAyMDkwOTM0LjU0OTU1
Ni0xLQo+PiBtaWUlNDBpZ2VsLmNvLmpwJTJGJmRhdGE9MDUlN0MwMSU3Q0ZyYW5rLkxpJTQwbnhw
LmNvbSU3Q2VhNjUxM2RiZgo+PiA0MDg0YjgwY2VkMjA4ZGIzY2U1NDEzMyU3QzY4NmVhMWQzYmMy
YjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3Cj4+IEMwJTdDNjM4MTcwNzI3NTU4ODAwNzIwJTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0dwo+PiBMakF3TURBaUxDSlFJam9pVjJs
dU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDCj4+ICU3QyU3QyZz
ZGF0YT1LNEVsNzZHU0FHdHNXa05CWEpLNSUyRm43ZmxDTjIwZUVNWnBaWVRYMldJWjAlMwo+PiBE
JnJlc2VydmVkPTAKPj4KPj4gRmlyc3Qgb2YgdGhpcyBwYXRjaHNldCBpcyBpbnRyb2R1Y2UgYSBo
ZWxwZXIgZnVuY3Rpb24gdG8gcmVhbGl6ZSBwY2kKPj4gdmlydGlvIGZ1bmN0aW9uIHVzaW5nIFBD
SWUgZW5kcG9pbnQgZnJhbWV3b3JrLiBUaGUgc2Vjb25kIG9uZSBpcyBhZGRpbmcKPj4gYSBtaXNz
aW5nIGRlZmluaXRpb24gZm9yIHZpcnRpbyBwY2kgaGVhZGVyLiBUaGUgbGFzdCBvbmUgaXMgZm9y
IFBDSWUKPj4gZW5kcG9pbnQgdmlydGlvIGNvbnNvbGUgZHJpdmVyLgo+Pgo+PiBUaGlzIGlzIHRl
c3RlZCBvbiBsaW51eC0yMDIzMDQwNiBhbmQgUkNhciBTNCBib2FyZCBhcyBQQ0llIGVuZHBvaW50
Lgo+Pgo+PiBTaHVuc3VrZSBNaWUgKDMpOgo+PiAgICBQQ0k6IGVuZHBvaW50OiBpbnRyb2R1Y2Ug
YSBoZWxwZXIgdG8gaW1wbGVtZW50IHBjaSBlcCB2aXJ0aW8gZnVuY3Rpb24KPj4gICAgdmlydGlv
X3BjaTogYWRkIGEgZGVmaW5pdGlvbiBvZiBxdWV1ZSBmbGFnIGluIElTUgo+PiAgICBQQ0k6IGVu
ZHBvaW50OiBBZGQgRVAgZnVuY3Rpb24gZHJpdmVyIHRvIHByb3ZpZGUgdmlydGlvLWNvbnNvbGUK
Pj4gICAgICBmdW5jdGlvbmFsaXR5Cj4+Cj4+ICAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL0tjb25maWcgICAgICAgIHwgIDE5ICsKPj4gICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5j
dGlvbnMvTWFrZWZpbGUgICAgICAgfCAgIDIgKwo+PiAgIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLXZjb24uYyB8IDU1NCArKysrKysrKysrKysrKysrKysKPj4gICAuLi4v
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZpcnRpby5jICAgfCA0NjkgKysrKysrKysr
KysrKysrCj4+ICAgLi4uL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12aXJ0aW8uaCAg
IHwgMTIzICsrKysKPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oICAgICAgICAg
ICAgICAgfCAgIDMgKwo+PiAgIDYgZmlsZXMgY2hhbmdlZCwgMTE3MCBpbnNlcnRpb25zKCspCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2kt
ZXBmLXZjb24uYwo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9lbmRwb2ludC9m
dW5jdGlvbnMvcGNpLWVwZi12aXJ0aW8uYwo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12aXJ0aW8uaAo+Pgo+PiAtLQo+PiAyLjI1
LjEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
