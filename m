Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8736C433F5
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 03:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5914860B62;
	Fri, 13 May 2022 03:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qd7fi5w3w2m; Fri, 13 May 2022 03:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02E3B60808;
	Fri, 13 May 2022 03:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE856C0039;
	Fri, 13 May 2022 03:54:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0866DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC80C60B4D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xuDei-t2SyyL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:54:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D265E60808
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:54:17 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id x23so6598081pff.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 20:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Sdy4JWVMgzouLiUuz2tCTiM3qS000Ug614pPLg974GQ=;
 b=vqmu5UC4sY7X1lyXBtg1p5wMTx2LVa+3jvsaYuBa7srCB3GpZmRcvIFiQp2vfTU7Pv
 eSvBoLoNz/ttuBceOcbDJC3+hDuAwLxsCp84eOjzJHNlfPdk8s9z4Eym7jLPQEVplVzD
 ldq1aPWqSRKQjTCK5w610yr6sbWTa9OV1zGehsH9rGw7raf15KRqvPAbvreobdWWtmWz
 A6251J8zMKkeyYW/XLUXPgFW3QYz9ZXSixbZChOvA8jL040euOQVEf7DRqiHKKNlvGf/
 GbrxwHbx//ztt7/1T8MiZ2NIGZI9GV6Ryv4afc0ypp+fzj/32u8mZndEvSzZb+POdiWz
 Vodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Sdy4JWVMgzouLiUuz2tCTiM3qS000Ug614pPLg974GQ=;
 b=L23pKu+9smRFVYriOM0sJfF3O+jO8pMyGc8tu6e0R21YVv2LFDIHYly/l5v/EYQs3Y
 sCef8T/S1JozP0GNFfIjifjQ4Rjx6TWRkK3RygSMitrOh6buhj+QO5pBp46JEq/XgkXg
 BwsDw+x3cGdjbu2wdE1XnediMuP+8FgrI7M25s88vTJFvokuJGdF7WXx/ehank0wQ8hw
 +gJZk0d60/Fzw5LAoTLlEK01tXQCtUP/ZKyOeaRUp8CDc3ZfLcXZZ0EV6FGtuS4bKktr
 2QYIvd59GT0+WY9iGa///V6yxJFFmDDBGol+Q5ur9SZri+Fa/WXcEXKQsdk6h23FON8N
 +BKA==
X-Gm-Message-State: AOAM531E54CDgPRYeAEqIN0r893ux5ooPspyOKKTYsPs30S43VdLF/1F
 SoBRQUFA2xR8AD7vHZURCLuqCg==
X-Google-Smtp-Source: ABdhPJyMwqzVGhhlXUsB2d/mXiL8fGEDAMUZIgY+YPHRDqo7t6DyFSdT21UUHdeLYUoWnpc5riIUeQ==
X-Received: by 2002:a65:6e82:0:b0:381:71c9:9856 with SMTP id
 bm2-20020a656e82000000b0038171c99856mr2357297pgb.316.1652414056895; 
 Thu, 12 May 2022 20:54:16 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 y124-20020a62ce82000000b0050dc76281f9sm566919pfg.211.2022.05.12.20.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 20:54:16 -0700 (PDT)
Message-ID: <67aedc07-96d7-4078-611e-a01b3a93904f@bytedance.com>
Date: Fri, 13 May 2022 11:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH v5 1/9] virtio-crypto: header update
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
 <20220428135943.178254-2-pizhenwei@bytedance.com>
 <YnzZhjwbD6PaKx+2@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <YnzZhjwbD6PaKx+2@redhat.com>
Cc: helei.sig11@bytedance.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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

SGksIERhbmllbAoKU29tZXRoaW5nIEkgZG8gaW4gbXkgbG9jYWwgYnJhbmNoKGZvciB0aGUgdjYg
c2VyaWVzKToKLSBbUEFUQ0ggdjUgMS85XSB2aXJ0aW8tY3J5cHRvOiBoZWFkZXIgdXBkYXRlCi0g
W1BBVENIIHY1IDMvOV0gY3J5cHRvOiBJbnRyb2R1Y2UgYWtjaXBoZXIgY3J5cHRvIGNsYXNzCiAg
IEFkZCAnUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5j
b20+JwoKLSBbUEFUQ0ggdjUgNC85XSBjcnlwdG86IGFkZCBBU04uMSBERVIgZGVjb2RlcgotIFtQ
QVRDSCB2NSA3LzldIHRlc3QvY3J5cHRvOiBBZGQgdGVzdCBzdWl0ZSBmb3IgY3J5cHRvIGFrY2lw
aGVyCiAgIEZpeGVkIHRoZSBpc3N1ZXMgeW91IHBvaW50ZWQgb3V0LgoKRG8geW91IGhhdmUgc3Vn
Z2VzdGlvbnMgYWJvdXQgdGhlIG90aGVyIHBhdGNoZXM/IE9yIEknbGwgc2VuZCB0aGUgdjYgc2Vy
aWVzPwoKT24gNS8xMi8yMiAxNzo1NSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToKPiBPbiBU
aHUsIEFwciAyOCwgMjAyMiBhdCAwOTo1OTozNVBNICswODAwLCB6aGVud2VpIHBpIHdyb3RlOgo+
PiBVcGRhdGUgaGVhZGVyIGZyb20gbGludXgsIHN1cHBvcnQgYWtjaXBoZXIgc2VydmljZS4KPj4K
Pj4gUmV2aWV3ZWQtYnk6IEdvbmdsZWkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBsZWkgaGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4+IFNpZ25lZC1v
ZmYtYnk6IHpoZW53ZWkgcGkgPHBpemhlbndlaUBieXRlZGFuY2UuY29tPgo+PiAtLS0KPj4gICAu
Li4vc3RhbmRhcmQtaGVhZGVycy9saW51eC92aXJ0aW9fY3J5cHRvLmggICAgfCA4MiArKysrKysr
KysrKysrKysrKystCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBJIHNlZSB0aGVzZSBjaGFuZ2VzIHdlcmUgbm93IG1lcmdlZCBpbiBsaW51
eC5naXQgd2l0aAo+IAo+ICAgIGNvbW1pdCAyNGUxOTU5MDYyOGI1ODU3ODc0OGVlYWVjODE0MGJm
OWM5ZGMwMGQ5Cj4gICAgQXV0aG9yOiAgICAgemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5j
ZS5jb20+Cj4gICAgQXV0aG9yRGF0ZTogV2VkIE1hciAyIDExOjM5OjE1IDIwMjIgKzA4MDAKPiAg
ICBDb21taXQ6ICAgICBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ICAgIENv
bW1pdERhdGU6IE1vbiBNYXIgMjggMTY6NTI6NTggMjAyMiAtMDQwMAo+IAo+ICAgICAgdmlydGlv
LWNyeXB0bzogaW50cm9kdWNlIGFrY2lwaGVyIHNlcnZpY2UKPiAgICAgIAo+ICAgICAgSW50cm9k
dWNlIGFzeW1tZXRyaWMgc2VydmljZSBkZWZpbml0aW9uLCBhc3ltbWV0cmljIG9wZXJhdGlvbnMg
YW5kCj4gICAgICBzZXZlcmFsIHdlbGwga25vd24gYWxnb3JpdGhtcy4KPiAgICAgIAo+ICAgICAg
Q28tZGV2ZWxvcGVkLWJ5OiBsZWkgaGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gICAg
ICBTaWduZWQtb2ZmLWJ5OiBsZWkgaGUgPGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb20+Cj4gICAg
ICBTaWduZWQtb2ZmLWJ5OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4KPiAg
ICAgIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjAzMDIwMzM5MTcuMTI5NTMz
NC0zLXBpemhlbndlaUBieXRlZGFuY2UuY29tCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ICAgICAgUmV2aWV3ZWQtYnk6IEdvbmdsZWkg
PGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPgo+IAo+IAo+IEFuZCB0aGUgY2hhbmdlcyBwcm9wb3Nl
ZCBoZXJlIG1hdGNoIHRoYXQsIHNvCj4gCj4gICAgUmV2aWV3ZWQtYnk6IERhbmllbCBQLiBCZXJy
YW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+Cj4gCj4gCj4gV2l0aCByZWdhcmRzLAo+IERhbmll
bAoKLS0gCnpoZW53ZWkgcGkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
