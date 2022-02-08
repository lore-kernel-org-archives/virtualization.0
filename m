Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5388CC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 06:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEB16401E9;
	Tue,  8 Feb 2022 06:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsOBKoxMvGQf; Tue,  8 Feb 2022 06:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E21F401FA;
	Tue,  8 Feb 2022 06:58:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D9E4C001A;
	Tue,  8 Feb 2022 06:58:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E95D5C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 06:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7EB760C1E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 06:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKUEzd4k4b9q
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 06:58:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6BEA6058F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644303523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75Iq94Dp/tXC9KrSfKdcUkCyJNK+H2fJiYTGUK75R5c=;
 b=B/tj/Sxp82D69frySCssOGGR79Mgl8HiYCeqQ0/lHmsqE7XwnoFJm0eAqLuOWuCVgytBA3
 1fTet7vydc4ThBm7tIVpuJZTLLknn1IfeXpiGeDeFAJvg5AczRe3niwu+mJ9hIVP2eAXdB
 7j2eNhap/dAfzkesWLfAHOz94kI4rNE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-kqAXC-7VNreOfH0PY5tQ0w-1; Tue, 08 Feb 2022 01:58:40 -0500
X-MC-Unique: kqAXC-7VNreOfH0PY5tQ0w-1
Received: by mail-pl1-f199.google.com with SMTP id
 v14-20020a170902e8ce00b0014b48e8e498so6905220plg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 22:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=75Iq94Dp/tXC9KrSfKdcUkCyJNK+H2fJiYTGUK75R5c=;
 b=OvttsjZHUWXnqt7uJI8Iv0MI7pXtgAuck5WAtguCb+NrwQzC/qzsuvtSnZqkF8CwMy
 PNXbxpWtv4liOswReq1EZwKfmRl8AJxkQjewcNjfLofNp6tuvMn3U6Jy7inLcnUgwWIQ
 WiazC+G4enX0wspC8Iitl4tz8NRby9crCK1Jn9cXcLNHDIASXzqzDw3jqZokXPNt1CRw
 7M52wUewCVgUGoUlwtkcTt8dX2EpxD9vpVL5kr/UbjfaUtNfNA5W2l0Qga8XFm96dGN+
 dY4TpFEzbiNNIZLim3mDihV5kM02CdkdhNQRZqGmZ1voz2d4ZGc+eOPrSx6vq8lb8hp7
 tVhw==
X-Gm-Message-State: AOAM53221mX18YvwTV0FTmX0UPrtXcV7pWLWIypAVNWOGTrmeJR7cAgX
 PGFgLShOCAhoWpkLpUDB86Hd8nE9X/xie0QnFMkCO0BEd7k/Ns0UolsSaRKC/kSOLV4udGMhSXb
 gORKgDOFLVJF9TC+vSbjtWaDilU4pNFe70p8Ku2Yyew==
X-Received: by 2002:a17:90b:3ece:: with SMTP id
 rm14mr2876237pjb.220.1644303519089; 
 Mon, 07 Feb 2022 22:58:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1lSSs1vr+wO7cooTPkapSG5GEpiu/r0pjJuh8WXOjGekx015DpYJbEccMJD1ZSDHnD3nXsA==
X-Received: by 2002:a17:90b:3ece:: with SMTP id
 rm14mr2876209pjb.220.1644303518813; 
 Mon, 07 Feb 2022 22:58:38 -0800 (PST)
Received: from [10.72.13.12] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 20sm1439863pjf.15.2022.02.07.22.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 22:58:38 -0800 (PST)
Message-ID: <b3d7f050-b5e1-0751-60ec-d6d81016461f@redhat.com>
Date: Tue, 8 Feb 2022 14:58:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH 16/31] vhost: pass queue index to vhost_vq_get_addr
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-17-eperezma@redhat.com>
 <f0e549eb-3485-01f5-88cb-f5681fc74abc@redhat.com>
 <CAJaqyWexu=VroHQxmtJDQm=iu1va-s1VGR8hqGOreG0SOisjYg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWexu=VroHQxmtJDQm=iu1va-s1VGR8hqGOreG0SOisjYg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzIvMSDkuIrljYgxOjQ0LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gU2F0LCBKYW4gMjksIDIwMjIgYXQgOToyMCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjIvMS8yMiDkuIrljYg0OjI3LCBFdWdlbmlvIFDD
qXJleiDlhpnpgZM6Cj4+PiBEb2luZyB0aGF0IHdheSBhbGxvd3Mgdmhvc3QgYmFja2VuZCB0byBr
bm93IHdoYXQgYWRkcmVzcyB0byByZXR1cm4uCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5p
byBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAgIGh3L3ZpcnRpby92
aG9zdC5jIHwgNiArKystLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC5jIGIv
aHcvdmlydGlvL3Zob3N0LmMKPj4+IGluZGV4IDdiMDNlZmNjZWMuLjY0Yjk1NWJhMGMgMTAwNjQ0
Cj4+PiAtLS0gYS9ody92aXJ0aW8vdmhvc3QuYwo+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LmMK
Pj4+IEBAIC03OTgsOSArNzk4LDEwIEBAIHN0YXRpYyBpbnQgdmhvc3RfdmlydHF1ZXVlX3NldF9h
ZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLAo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaWR4LCBib29sIGVuYWJsZV9sb2cp
Cj4+PiAgICB7Cj4+PiAtICAgIHN0cnVjdCB2aG9zdF92cmluZ19hZGRyIGFkZHI7Cj4+PiArICAg
IHN0cnVjdCB2aG9zdF92cmluZ19hZGRyIGFkZHIgPSB7Cj4+PiArICAgICAgICAuaW5kZXggPSBp
ZHgsCj4+PiArICAgIH07Cj4+PiAgICAgICAgaW50IHI7Cj4+PiAtICAgIG1lbXNldCgmYWRkciwg
MCwgc2l6ZW9mKHN0cnVjdCB2aG9zdF92cmluZ19hZGRyKSk7Cj4+Pgo+Pj4gICAgICAgIGlmIChk
ZXYtPnZob3N0X29wcy0+dmhvc3RfdnFfZ2V0X2FkZHIpIHsKPj4+ICAgICAgICAgICAgciA9IGRl
di0+dmhvc3Rfb3BzLT52aG9zdF92cV9nZXRfYWRkcihkZXYsICZhZGRyLCB2cSk7Cj4+PiBAQCAt
ODEzLDcgKzgxNCw2IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmlydHF1ZXVlX3NldF9hZGRyKHN0cnVj
dCB2aG9zdF9kZXYgKmRldiwKPj4+ICAgICAgICAgICAgYWRkci5hdmFpbF91c2VyX2FkZHIgPSAo
dWludDY0X3QpKHVuc2lnbmVkIGxvbmcpdnEtPmF2YWlsOwo+Pj4gICAgICAgICAgICBhZGRyLnVz
ZWRfdXNlcl9hZGRyID0gKHVpbnQ2NF90KSh1bnNpZ25lZCBsb25nKXZxLT51c2VkOwo+Pj4gICAg
ICAgIH0KPj4KPj4gSSdtIGEgYml0IGxvc3QgaW4gdGhlIGxvZ2ljIGFib3ZlLCBhbnkgcmVhc29u
IHdlIG5lZWQgY2FsbAo+PiB2aG9zdF92cV9nZXRfYWRkcigpIDopID8KPj4KPiBJdCdzIHRoZSB3
YXkgdmhvc3RfdmlydHF1ZXVlX3NldF9hZGRyIHdvcmtzIGlmIHRoZSBiYWNrZW5kIGhhcyBhCj4g
dmhvc3RfdnFfZ2V0X2FkZHIgb3BlcmF0aW9uIChjdXJyZW50bHksIG9ubHkgdmhvc3QtdmRwYSku
IHZob3N0IGZpcnN0Cj4gYXNrIHRoZSBhZGRyZXNzIHRvIHRoZSBiYWNrIGVuZCBhbmQgdGhlbiBz
ZXQgaXQuCgoKUmlnaHQgaXQncyBiZWNhdXNlIHZob3N0LXZkcGEgZG9lc24ndCB1c2UgVkEgYnV0
IEdQQS4gQnV0IEknbSBub3Qgc3VyZSAKaXQncyB3b3J0aCBhIGRlZGljYXRlZCB2aG9zdF9vcHMu
IEJ1dCBjb25zaWRlciB3ZSBpbnRyb2R1Y2Ugc2hhZG93IAp2aXJ0cXVldWUgc3R1ZmZzLCBpdCBz
aG91bGQgYmUgb2sgbm93LgoKKEluIHRoZSBmdXR1cmUsIHdlIG1heSBjb25zaWRlciB0byBnZW5l
cmFsaXplIG5vbiB2aG9zdC12ZHBhIHNwZWNpZmljIApzdHVmZnMgdG8gVmhvc3RTaGFkb3dWaXJ0
cXVldWUsIHRoZW4gd2UgY2FuIGdldCByaWQgb2YgdGhpcyB2aG9zdF9vcHMuCgoKPgo+IFByZXZp
b3VzbHksIGluZGV4IHdhcyBub3QgbmVlZGVkIGJlY2F1c2UgYWxsIHRoZSBpbmZvcm1hdGlvbiB3
YXMgaW4KPiB2aG9zdF92aXJ0cXVldWUuIEhvd2V2ZXIgdG8gZXh0cmFjdCBxdWV1ZSBpbmRleCBm
cm9tIHZob3N0X3ZpcnRxdWV1ZQo+IGlzIHRyaWNreSwgc28gSSB0aGluayBpdCdzIGVhc2llciB0
byBzaW1wbHkgaGF2ZSB0aGF0IGluZm9ybWF0aW9uIGF0Cj4gcmVxdWVzdCwgc29tZXRoaW5nIHNp
bWlsYXIgdG8gZ2V0X2Jhc2Ugb3IgZ2V0X251bSB3aGVuIGFza2luZyB2ZHBhCj4gZGV2aWNlLiBX
ZSBjYW4gZXh0cmFjdCB0aGUgaW5kZXggZnJvbSB2cSAtIGRldi0+dnFzIG9yIHNvbWV0aGluZwo+
IHNpbWlsYXIgaWYgaXQncyBwcmVmZXJlZC4KCgpJdCBsb29rcyBvZGQgZm9yIHRoZSBjYWxsZXIg
dG8gdGVsbCB0aGUgaW5kZXggY29uc2lkZXIgdmhvc3RfdmlydHF1ZXVlIAppcyBhbHJlYWR5IHBh
c3NlZC4gU28gSSB0aGluayB3ZSBuZWVkIGRlZHVjZSBpdCBmcm9tIHZob3N0X3ZpcnRxdWV1ZSBh
cyAKeW91IG1lbnRpb25lZCBoZXJlLgoKVGhhbmtzCgoKPgo+IFRoYW5rcyEKPgo+PiBUaGFua3MK
Pj4KPj4KPj4+IC0gICAgYWRkci5pbmRleCA9IGlkeDsKPj4+ICAgICAgICBhZGRyLmxvZ19ndWVz
dF9hZGRyID0gdnEtPnVzZWRfcGh5czsKPj4+ICAgICAgICBhZGRyLmZsYWdzID0gZW5hYmxlX2xv
ZyA/ICgxIDw8IFZIT1NUX1ZSSU5HX0ZfTE9HKSA6IDA7Cj4+PiAgICAgICAgciA9IGRldi0+dmhv
c3Rfb3BzLT52aG9zdF9zZXRfdnJpbmdfYWRkcihkZXYsICZhZGRyKTsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
