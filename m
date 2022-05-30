Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B77C433EF
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 05:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EAF8610E5;
	Mon, 30 May 2022 05:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uZOgoIPZAVSG; Mon, 30 May 2022 05:51:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD54460DFE;
	Mon, 30 May 2022 05:51:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFA5C0032;
	Mon, 30 May 2022 05:51:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19DE6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 05:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7B784197E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 05:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id het3x1NTylH6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 05:50:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98B574197C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 05:50:58 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id s14so9394060plk.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 May 2022 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=BobJJoukDoqDMc7RsnBOslTuYcnA41bZYrPd0qFtxLo=;
 b=HEF7yI75q4/jLPdr8k8FIN79TtOolBn3y8oOoLyjUcQYCeEubGiOVFNCZYHOP2DodO
 U3Wxv75HH2hosZRM/pbXPabBahO3aYxmP0MTfPaO68wLdg/hinLanrclStogNjTTwQet
 TXtPyvEsQ6saNOUa+1mNKc6Jy9BktQiF2Kn9xg0R9GqRE4g7x9dMKt1nuKZKzXbP2761
 E7HNl6lR5tnBzQTLUjEb3ZF82XKABWtVYbmq+1/P/ZQE4Su6qZ7HeRTiNyUXy0u4HbTt
 scgUx+yUTiFQ0fPdV8vmfKAUE6m7EVxKXGJUpVytEDTAHK9P1G/8K5VY6f6E7W6N0KhU
 1qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BobJJoukDoqDMc7RsnBOslTuYcnA41bZYrPd0qFtxLo=;
 b=R1PmVye1uTpTMOZMP9Wb1VKOeV7DBn3jSxRM67uoLkCasOdlySe1qDMd4K1/4gE9Si
 amn+UAhslBIKOT+VJ3+1tZGKngeZ+Y4GfWWYwh+zKbvrHRmsu5O62Tes5dPtyidqYqUx
 B2mdI6x8E5NoNXzcJeu3GIaZatoNPH9mheQsb9JRceKI5LeARw45dk4LAP+jANXrS5AP
 1z+TY3lbjodsdLY5gad52LaRw+6fN3vsVJFxBBPIfK74Td8OsjvKoAOBKyxWoelOJZAt
 O0zUXpx0haUUzk8cazSyeuMJcTuIAo0dZhtNGFoRZcS545FOzHDM1C29cR79etYyLHry
 UaOg==
X-Gm-Message-State: AOAM531OUJeaZXaYZrht6irQWoXtolalo81wvvwdaqDaOgPi9Z3iYiNv
 zQlJOlu0QBwDfdClbseo4kVGAA==
X-Google-Smtp-Source: ABdhPJzcG+Wj6HLqctwFpGM4LHkzUb2FX/9k6M4jkgCUJI4u5NtU/hy1qSKbgIOb5h07et2CFwjE5A==
X-Received: by 2002:a17:90b:224a:b0:1e2:7afb:3367 with SMTP id
 hk10-20020a17090b224a00b001e27afb3367mr16511516pjb.37.1653889857790; 
 Sun, 29 May 2022 22:50:57 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.249])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a170903204b00b00163be997587sm3169891pla.100.2022.05.29.22.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 May 2022 22:50:57 -0700 (PDT)
Message-ID: <286dbd1f-1c62-a171-7453-d772bd98332c@bytedance.com>
Date: Mon, 30 May 2022 13:46:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 2/3] mm/memory-failure.c: support reset PTE during
 unpoison
Content-Language: en-US
To: =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?=
 <naoya.horiguchi@nec.com>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-3-pizhenwei@bytedance.com>
 <20220530050234.GA1036127@hori.linux.bs1.fc.nec.co.jp>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220530050234.GA1036127@hori.linux.bs1.fc.nec.co.jp>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
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

CgpPbiA1LzMwLzIyIDEzOjAyLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykgd3JvdGU6
Cj4gT24gRnJpLCBNYXkgMjAsIDIwMjIgYXQgMDM6MDY6NDdQTSArMDgwMCwgemhlbndlaSBwaSB3
cm90ZToKPj4gT3JpZ2lhbmxseSwgdW5wb2lzb25fbWVtb3J5KCkgaXMgb25seSB1c2VkIGJ5IGh3
cG9pc29uLWluamVjdCwgYW5kCj4+IHVucG9pc29ucyBhIHBhZ2Ugd2hpY2ggaXMgcG9pc29uZWQg
YnkgaHdwb2lzb24taW5qZWN0IHRvby4gVGhlIGtlcm5lbCBQVEUKPj4gZW50cnkgaGFzIG5vIGNo
YW5nZSBkdXJpbmcgc29mdHdhcmUgcG9pc29uL3VucG9pc29uLgo+Pgo+PiBPbiBhIHZpcnR1YWxp
emF0aW9uIHBsYXRmb3JtLCBpdCdzIHBvc3NpYmxlIHRvIGZpeCBoYXJkd2FyZSBjb3JydXB0ZWQg
cGFnZQo+PiBieSBoeXBlcnZpc29yLCB0eXBpY2FsbHkgdGhlIGh5cGVydmlzb3IgcmVtYXBzIHRo
ZSBlcnJvciBIVkEoaG9zdCB2aXJ0dWFsCj4+IGFkZHJlc3MpLiBTbyBhZGQgYSBuZXcgcGFyYW1l
dGVyICdjb25zdCBjaGFyICpyZWFzb24nIHRvIHNob3cgdGhlIHJlYXNvbgo+PiBjYWxsZWQgYnku
Cj4+Cj4+IE9uY2UgdGhlIGNvcnJ1cHRlZCBwYWdlIGdldHMgZml4ZWQsIHRoZSBndWVzdCBrZXJu
ZWwgbmVlZHMgcHV0IHBhZ2UgdG8KPj4gYnVkZHkuIFJldXNlIHRoZSBwYWdlIGFuZCBoaXQgdGhl
IGZvbGxvd2luZyBpc3N1ZShJbnRlbCBQbGF0aW51bSA4MjYwKToKPj4gICBCVUc6IHVuYWJsZSB0
byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzczogZmZmZjg4ODA2MTY0NjAwMAo+PiAgICNQ
Rjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKPj4gICAjUEY6IGVycm9y
X2NvZGUoMHgwMDAyKSAtIG5vdC1wcmVzZW50IHBhZ2UKPj4gICBQR0QgMmMwMTA2NyBQNEQgMmMw
MTA2NyBQVUQgNjFhYWEwNjMgUE1EIDEwMDg5YjA2MyBQVEUgODAwZmZmZmY5ZTliOTA2Mgo+PiAg
IE9vcHM6IDAwMDIgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQo+PiAgIENQVTogMiBQSUQ6IDMxMTA2
IENvbW06IHN0cmVzcyBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcgICBNICAgICAgIE9FICAgICA1
LjE4LjAtcmM2LmJtLjEtYW1kNjQgIzYKPj4gICBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJk
IFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xNi4wLTAtZ2QyMzk1NTJjZTcy
Mi1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0Cj4+ICAgUklQOiAwMDEwOmNsZWFyX3BhZ2Vf
ZXJtcysweDcvMHgxMAo+Pgo+PiBUaGUga2VybmVsIFBURSBlbnRyeSBvZiB0aGUgZml4ZWQgcGFn
ZSBpcyBzdGlsbCB1bmNvcnJlY3RlZCwga2VybmVsIGhpdHMKPj4gcGFnZSBmYXVsdCBkdXJpbmcg
cHJlcF9uZXdfcGFnZS4gU28gYWRkICdib29sIHJlc2V0X2twdGUnIHRvIGdldCBhIGNoYW5nZQo+
PiB0byBmaXggdGhlIFBURSBlbnRyeSBpZiB0aGUgcGFnZSBpcyBmaXhlZCBieSBoeXBlcnZpc29y
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNv
bT4KPj4gLS0tCj4+ICAgaW5jbHVkZS9saW51eC9tbS5oICAgfCAgMiArLQo+PiAgIG1tL2h3cG9p
c29uLWluamVjdC5jIHwgIDIgKy0KPj4gICBtbS9tZW1vcnktZmFpbHVyZS5jICB8IDI2ICsrKysr
KysrKysrKysrKysrKystLS0tLS0tCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+IAo+IERvIHlvdSBuZWVkIHVuZG9pbmcgcmF0ZSBsaW1p
dGluZyBoZXJlPyAgSW4gdGhlIG9yaWdpbmFsIHVucG9pc29uJ3MgdXNhZ2UsCj4gYXZvaWRpbmcg
Zmxvb2Qgb2YgIlVucG9pc29uOiBTb2Z0d2FyZS11bnBvaXNvbmVkIHBhZ2UiIG1lc3NhZ2VzIGlz
IGhlbHBmdWwuCj4gCj4gQW5kIHVucG9pc29uIHNlZW1zIHRvIGJlIGNhbGxlZCBmcm9tIHZpcnRp
by1iYWxsb29uIG11bHRpcGxlIHRpbWVzIHdoZW4KPiB0aGUgYmFja2VuZCBpcyAyTUIgaHVnZXBh
Z2VzLiAgSWYgaXQncyByaWdodCwgcHJpbnRpbmcgb3V0IDUxMiBsaW5lcyBvZgo+ICJVbnBvaXNv
bjogVW5wb2lzb25lZCBwYWdlIDB4WFhYIGJ5IHZpcnRpby1iYWxsb29uIiBtZXNzYWdlcyBtaWdo
dCBub3QgYmUKPiBzbyBoZWxwZnVsPwo+IAoKQWxsIHRoZSBzdWdnZXN0aW9ucyhpbmNsdWRlICdb
UEFUQ0ggMS8zXSBtZW1vcnktZmFpbHVyZTogSW50cm9kdWNlIAptZW1vcnkgZmFpbHVyZSBub3Rp
ZmllcicpIGFyZSByZWFzb25hYmxlLCBJJ2xsIGZpeCB0aGVtIGluIHRoZSBuZXh0IAp2ZXJzaW9u
LiBUaGFua3MgYSBsb3QhCgoKLS0gCnpoZW53ZWkgcGkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
