Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C8C07E9B
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 03:30:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2690A61178
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 03:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2690A61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF18482D45;
	Wed, 21 Jul 2021 03:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSO2M2xplvg6; Wed, 21 Jul 2021 03:30:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 568F782D14;
	Wed, 21 Jul 2021 03:30:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27D06C0010;
	Wed, 21 Jul 2021 03:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0D2BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 03:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA8A682D14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 03:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwXxkdnfHLK6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 03:30:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D3B982D12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 03:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626838210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k05rJ04IU9dEG8xbaeJSAOzZNy8JTOVIRfo0vVOjOCg=;
 b=jJJZ6hkO+9CUej3+OQ/FgMMLnOTzaT/0Oai6Ibdm/W4id9Pn6Sm3RzEB3FwLHFImApKBc/
 qp6WJa4Z9LAi4MICsWmJdg56HGb0IwHAOXPICuXNNQnqf0TXhgR+Yz1B69/UkYQJVGxdms
 t8zB+lRLMiiTERIhjrIfesgaTziQnXU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-yMQt2lBsNxGHMOvAe6wc2Q-1; Tue, 20 Jul 2021 23:30:07 -0400
X-MC-Unique: yMQt2lBsNxGHMOvAe6wc2Q-1
Received: by mail-pf1-f197.google.com with SMTP id
 g17-20020a6252110000b029030423e1ef64so933515pfb.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 20:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=k05rJ04IU9dEG8xbaeJSAOzZNy8JTOVIRfo0vVOjOCg=;
 b=S8J49DKXq8uxS04fq7aN9St6Pf+++85iY8ZB7NFZBsrZ4LeELDB2MwN1wzZQRHrmgN
 rQw79NtfKlaPB1g1Z6LFojI4kGAaAAN0PZJt3aFRFI7klOCieY3WyXK9yZDBdd8CBJrX
 /pxG/z4zqh7oXzvboKWVgt1QPmhrOcPRauRro2PCAS1DGkLOuumrGDjEM7JYMqBAtYI/
 7l8x6sJFj0hi9mYHHgWKJKMdgIkxpVvOXKLO2caJcdYieZbVMn/lR7EJtI7DcIsXXTr9
 DnzZR977+8UFDFAlLppqjLDmBlqoFOvN2qx0V/fF9r36Lts3QS8jD2DyCFlaDzQ6otj+
 8VIA==
X-Gm-Message-State: AOAM532PmUzcjI+aRiRX+95isRNXqnhn4dQXueEcdRpdb+uVJkSEx5WF
 c6HJciyGXb40h0eqpwCjZ+W89ZM4LY/84CYnEXFNvVbpVAkLsaTCTREBkScTCzpK2D2l5rvvZpP
 9JfovkgL9WdqSP2BMuO48Ogpbeafd2B6bUo8uGN1uAA==
X-Received: by 2002:a17:90a:17eb:: with SMTP id
 q98mr1637493pja.183.1626838206005; 
 Tue, 20 Jul 2021 20:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyESsAEWCDLWvcTfXZOmxCYVAakGzjamKbkQkgTTty1VuN8o5+HezI8WKMk3qXoufEpH/sFbw==
X-Received: by 2002:a17:90a:17eb:: with SMTP id
 q98mr1637476pja.183.1626838205751; 
 Tue, 20 Jul 2021 20:30:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w14sm30244343pgo.75.2021.07.20.20.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jul 2021 20:30:05 -0700 (PDT)
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To: Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org
References: <20210713161906.457857-1-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
Date: Wed, 21 Jul 2021 11:29:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210713161906.457857-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzcvMTQg5LiK5Y2IMTI6MTksIFN0ZWZhbiBIYWpub2N6aSDlhpnpgZM6Cj4gVGhl
c2UgcGF0Y2hlcyBhcmUgbm90IHBvbGlzaGVkIHlldCBidXQgSSB3b3VsZCBsaWtlIHJlcXVlc3Qg
ZmVlZGJhY2sgb24gdGhpcwo+IGFwcHJvYWNoIGFuZCBzaGFyZSBwZXJmb3JtYW5jZSByZXN1bHRz
IHdpdGggeW91Lgo+Cj4gSWRsZSBDUFVzIHRlbnRhdGl2ZWx5IGVudGVyIGEgYnVzeSB3YWl0IGxv
b3AgYmVmb3JlIGhhbHRpbmcgd2hlbiB0aGUgY3B1aWRsZQo+IGhhbHRwb2xsIGRyaXZlciBpcyBl
bmFibGVkIGluc2lkZSBhIHZpcnR1YWwgbWFjaGluZS4gVGhpcyByZWR1Y2VzIHdha2V1cAo+IGxh
dGVuY3kgZm9yIGV2ZW50cyB0aGF0IG9jY3VyIHNvb24gYWZ0ZXIgdGhlIHZDUFUgYmVjb21lcyBp
ZGxlLgo+Cj4gVGhpcyBwYXRjaCBzZXJpZXMgZXh0ZW5kcyB0aGUgY3B1aWRsZSBidXN5IHdhaXQg
bG9vcCB3aXRoIHRoZSBuZXcgcG9sbF9zb3VyY2UKPiBBUEkgc28gZHJpdmVycyBjYW4gcGFydGlj
aXBhdGUgaW4gcG9sbGluZy4gU3VjaCBwb2xsaW5nLWF3YXJlIGRyaXZlcnMgZGlzYWJsZQo+IHRo
ZWlyIGRldmljZSdzIGlycSBkdXJpbmcgdGhlIGJ1c3kgd2FpdCBsb29wIHRvIGF2b2lkIHRoZSBj
b3N0IG9mIGludGVycnVwdHMuCj4gVGhpcyByZWR1Y2VzIGxhdGVuY3kgZnVydGhlciB0aGFuIHJl
Z3VsYXIgY3B1aWRsZSBoYWx0cG9sbCwgd2hpY2ggc3RpbGwgcmVsaWVzCj4gb24gaXJxcy4KPgo+
IFZpcnRpbyBkcml2ZXJzIGFyZSBtb2RpZmllZCB0byB1c2UgdGhlIHBvbGxfc291cmNlIEFQSSBz
byBhbGwgdmlydGlvIGRldmljZQo+IHR5cGVzIGdldCB0aGlzIGZlYXR1cmUuIFRoZSBmb2xsb3dp
bmcgdmlydGlvLWJsayBmaW8gYmVuY2htYXJrIHJlc3VsdHMgc2hvdyB0aGUKPiBpbXByb3ZlbWVu
dDoKPgo+ICAgICAgICAgICAgICAgSU9QUyAobnVtam9icz00LCBpb2RlcHRoPTEsIDQgdmlydHF1
ZXVlcykKPiAgICAgICAgICAgICAgICAgYmVmb3JlICAgcG9sbF9zb3VyY2UgICAgICBpb19wb2xs
Cj4gNGsgcmFuZHJlYWQgICAgMTY3MTAyICAxODYwNDkgKCsxMSUpICAxODY2NTQgKCsxMSUpCj4g
NGsgcmFuZHdyaXRlICAgMTYyMjA0ICAxODEyMTQgKCsxMSUpICAxODE4NTAgKCsxMiUpCj4gNGsg
cmFuZHJ3ICAgICAgMTU5NTIwICAxNzcwNzEgKCsxMSUpICAxNzc5MjggKCsxMSUpCj4KPiBUaGUg
Y29tcGFyaXNvbiBhZ2FpbnN0IGlvX3BvbGwgc2hvd3MgdGhhdCBjcHVpZGxlIHBvbGxfc291cmNl
IGFjaGlldmVzCj4gZXF1aXZhbGVudCBwZXJmb3JtYW5jZSB0byB0aGUgYmxvY2sgbGF5ZXIncyBp
b19wb2xsIGZlYXR1cmUgKHdoaWNoIEkKPiBpbXBsZW1lbnRlZCBpbiBhIHNlcGFyYXRlIHBhdGNo
IHNlcmllcyBbMV0pLgo+Cj4gVGhlIGFkdmFudGFnZSBvZiBwb2xsX3NvdXJjZSBpcyB0aGF0IGFw
cGxpY2F0aW9ucyBkbyBub3QgbmVlZCB0byBleHBsaWNpdGx5IHNldAo+IHRoZSBSV0ZfSElQUkkg
SS9PIHJlcXVlc3QgZmxhZy4gVGhlIHBvbGxfc291cmNlIGFwcHJvYWNoIGlzIGF0dHJhY3RpdmUg
YmVjYXVzZQo+IGZldyBhcHBsaWNhdGlvbnMgYWN0dWFsbHkgdXNlIFJXRl9ISVBSSSBhbmQgaXQg
dGFrZXMgYWR2YW50YWdlIG9mIENQVSBjeWNsZXMgd2UKPiB3b3VsZCBoYXZlIHNwZW50IGluIGNw
dWlkbGUgaGFsdHBvbGwgYW55d2F5Lgo+Cj4gVGhlIGN1cnJlbnQgc2VyaWVzIGRvZXMgbm90IGlt
cHJvdmUgdmlydGlvLW5ldC4gSSBoYXZlbid0IGludmVzdGlnYXRlZCBkZWVwbHksCj4gYnV0IGl0
IGlzIHBvc3NpYmxlIHRoYXQgTkFQSSBhbmQgcG9sbF9zb3VyY2UgZG8gbm90IGNvbWJpbmUuIFNl
ZSB0aGUgZmluYWwKPiBwYXRjaCBmb3IgYSBzdGFydGluZyBwb2ludCBvbiBtYWtpbmcgdGhlIHR3
byB3b3JrIHRvZ2V0aGVyLgo+Cj4gSSBoYXZlIG5vdCB0cmllZCB0aGlzIG9uIGJhcmUgbWV0YWwg
YnV0IGl0IG1pZ2h0IGhlbHAgdGhlcmUgdG9vLiBUaGUgY29zdCBvZgo+IGRpc2FibGluZyBhIGRl
dmljZSdzIGlycSBtdXN0IGJlIGxlc3MgdGhhbiB0aGUgc2F2aW5ncyBmcm9tIGF2b2lkaW5nIGly
cQo+IGhhbmRsaW5nIGZvciB0aGlzIG9wdGltaXphdGlvbiB0byBtYWtlIHNlbnNlLgo+Cj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzIwMjEwNTIwMTQxMzA1LjM1NTk2
MS0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCgoKSGkgU3RlZmFuOgoKU29tZSBxdWVzdGlvbnM6Cgox
KSBXaGF0J3MgdGhlIGFkdmFudGFnZXMgb2YgaW50cm9kdWNpbmcgcG9sbGluZyBhdCB2aXJ0aW8g
bGV2ZWwgaW5zdGVhZCAKb2YgZG9pbmcgaXQgYXQgZWFjaCBzdWJzeXN0ZW1zPyBQb2xsaW5nIGlu
IHZpcnRpbyBsZXZlbCBtYXkgb25seSB3b3JrIAp3ZWxsIGlmIGFsbCAob3IgbW9zdCkgb2YgdGhl
IGRldmljZXMgYXJlIHZpcnRpbwoyKSBXaGF0J3MgdGhlIGFkdmFudGFnZXMgb2YgdXNpbmcgY3B1
aWRsZSBpbnN0ZWFkIG9mIHVzaW5nIGEgdGhyZWFkIChhbmQgCmxldmVyYWdlIHRoZSBzY2hlZHVs
ZXIpPwozKSBBbnkgcmVhc29uIGl0J3MgdmlydGlvX3BjaSBzcGVjaWZpYyBub3QgYSBnZW5lcmFs
IHZpcnRpbyBvbmU/CgpUaGFua3MKCihCdHcsIGRvIHdlIG5lZWQgdG8gY2Mgc2NoZWR1bGVyIGd1
eXM/KQoKCj4KPiBTdGVmYW4gSGFqbm9jemkgKDMpOgo+ICAgIGNwdWlkbGU6IGFkZCBwb2xsX3Nv
dXJjZSBBUEkKPiAgICB2aXJ0aW86IGFkZCBwb2xsX3NvdXJjZSB2aXJ0cXVldWUgcG9sbGluZwo+
ICAgIHNvZnRpcnE6IHBhcnRpY2lwYXRlIGluIGNwdWlkbGUgcG9sbGluZwo+Cj4gICBkcml2ZXJz
L2NwdWlkbGUvTWFrZWZpbGUgICAgICAgICAgIHwgICAxICsKPiAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmggfCAgIDcgKysKPiAgIGluY2x1ZGUvbGludXgvaW50ZXJydXB0Lmgg
ICAgICAgICAgfCAgIDIgKwo+ICAgaW5jbHVkZS9saW51eC9wb2xsX3NvdXJjZS5oICAgICAgICB8
ICA1MyArKysrKysrKysrKysrKysKPiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAg
ICAgfCAgIDIgKwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggICAgICB8ICAgMiAr
Cj4gICBkcml2ZXJzL2NwdWlkbGUvcG9sbF9zb3VyY2UuYyAgICAgIHwgMTAyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL2NwdWlkbGUvcG9sbF9zdGF0ZS5jICAgICAg
IHwgICA2ICsrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW8uYyAgICAgICAgICAgIHwgIDM0ICsr
KysrKysrKysKPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAgODYgKysr
KysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bi5jIHwgICAyICsKPiAgIGtlcm5lbC9zb2Z0aXJxLmMgICAgICAgICAgICAgICAgICAgfCAgMTQg
KysrKwo+ICAgMTIgZmlsZXMgY2hhbmdlZCwgMzExIGluc2VydGlvbnMoKykKPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3BvbGxfc291cmNlLmgKPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL2NwdWlkbGUvcG9sbF9zb3VyY2UuYwo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
