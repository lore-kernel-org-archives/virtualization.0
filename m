Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD6C433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 01:33:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F3961925
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 01:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F3961925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2319845B9;
	Wed, 12 May 2021 01:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9D2fqNemgZh; Wed, 12 May 2021 01:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C3BC845B1;
	Wed, 12 May 2021 01:33:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B560C000D;
	Wed, 12 May 2021 01:33:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4669AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D468845B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id imsC-7aXC5Ek
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:33:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61BF5845B1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 01:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620783203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DG4/tk483cnbSJ3ONzjX6O6bMM+E3eYFHY3G4cqhSY=;
 b=BmleRHTLGBrT08h6C35MHn1tgswT6FVDdACFESK2QtB/pKhA5pM0SHaMf9dmH1LBMGPYPZ
 D++ndrH6fyGIwXqWLEoDmGd7/BHRCzW0hGyFdYvUEHsml1+Z4zTJnrpPAIdvh63fiUt5fq
 swl88ZD9RAhMAhAlQj1hbj6DycjbR9E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-qm74DFuwNdaDWfozDNavPA-1; Tue, 11 May 2021 21:33:21 -0400
X-MC-Unique: qm74DFuwNdaDWfozDNavPA-1
Received: by mail-pj1-f70.google.com with SMTP id
 c13-20020a17090aa60db029015c73ea2ce5so2651386pjq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 18:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5DG4/tk483cnbSJ3ONzjX6O6bMM+E3eYFHY3G4cqhSY=;
 b=tvYGeWZY2vSCynpJUaSv+diT3w7yM+/iD7roesVrfX42jlbv531A36Z+s8Wb864LfC
 D53avy+5a1tkBOHPNWQ6Fls+nV3wmyxfb/ahiLcDeLvzMrTUFJgceBM5c8toI05XH2tP
 RGeMlhJ3bEnC8czA7aPUjmwY8c0AK867RfyLKkviNSFP9nuSZ0iafnaS+XaN9mcnCDZD
 Obj0Q5vtluTdey259p7ZoAi4I01NJsGbGg3JgilWOo2vOG6jhrscja6iPxG3D+vNC+lC
 B0z0FwnmAh/nqV+xMlhYlz/Umt6L+I70YLD6cnZ1eF0mMr8RaFcnBvaKAxnoBRCgsNr2
 Wo2w==
X-Gm-Message-State: AOAM530TjkQnZms5lrH2wCXSI5evk945Msac/KsM0Ci8Gog2B5LSbwuu
 NQXp9Mmot0wKgLiSDt5l/h58PdYJeBdi6QRLbAmrl7T/+XDXgB/p2U9ZZSlJI0ATvfN1c3sSLBw
 hYZeB5jpwWL8h9iz7M7XTRmzih/oSAskmU18V/qllOw==
X-Received: by 2002:a17:902:7847:b029:ef:4421:6a2e with SMTP id
 e7-20020a1709027847b02900ef44216a2emr9969698pln.44.1620783200673; 
 Tue, 11 May 2021 18:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnOWQX4Mk3jCxH5ECtdPMzPH8hqjnoRf3edC55nxhKlgPAZIcSRNEJvASEQmVclxALyMDBHQ==
X-Received: by 2002:a17:902:7847:b029:ef:4421:6a2e with SMTP id
 e7-20020a1709027847b02900ef44216a2emr9969662pln.44.1620783200008; 
 Tue, 11 May 2021 18:33:20 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m14sm15181976pff.17.2021.05.11.18.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 18:33:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
Date: Wed, 12 May 2021 09:33:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIxLzUvMTEg5LiL5Y2INDozMywgWXVyaSBCZW5kaXRvdmljaCDlhpnpgZM6Cj4gT24g
VHVlLCBNYXkgMTEsIDIwMjEgYXQgOTo1MCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8xMSDkuIvljYgxMjo0MiwgWXVyaSBCZW5kaXRv
dmljaCDlhpnpgZM6Cj4+PiBTaWduZWQtb2ZmLWJ5OiBZdXJpIEJlbmRpdG92aWNoIDx5dXJpLmJl
bmRpdG92aWNoQGRheW5peC5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0L3R1bi5jIHwg
MiArLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3R1bi5jIGIvZHJpdmVycy9uZXQvdHVu
LmMKPj4+IGluZGV4IDg0ZjgzMjgwNjMxMy4uYTM1MDU0ZjlkOTQxIDEwMDY0NAo+Pj4gLS0tIGEv
ZHJpdmVycy9uZXQvdHVuLmMKPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3R1bi5jCj4+PiBAQCAtMjgx
Miw3ICsyODEyLDcgQEAgc3RhdGljIGludCBzZXRfb2ZmbG9hZChzdHJ1Y3QgdHVuX3N0cnVjdCAq
dHVuLCB1bnNpZ25lZCBsb25nIGFyZykKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgYXJnICY9
IH4oVFVOX0ZfVFNPNHxUVU5fRl9UU082KTsKPj4+ICAgICAgICAgICAgICAgIH0KPj4+Cj4+PiAt
ICAgICAgICAgICAgIGFyZyAmPSB+VFVOX0ZfVUZPOwo+Pj4gKyAgICAgICAgICAgICBhcmcgJj0g
fihUVU5fRl9VRk98VFVOX0ZfVVNPKTsKPj4KPj4gSXQgbG9va3MgdG8gbWUga2VybmVsIGRvZXNu
J3QgdXNlICJVU08iLCBzbyBUVU5fRl9VRFBfR1NPX0w0IGlzIGEgYmV0dGVyCj4+IG5hbWUgZm9y
IHRoaXMKPiBObyBwcm9ibGVtLCBJIGNhbiBjaGFuZ2UgaXQgaW4gdjIKPgo+ICAgYW5kIEkgZ3Vl
c3Mgd2Ugc2hvdWxkIHRvZ2dsZSBORVRJRl9GX1VEUF9HU09fbDQgaGVyZT8KPgo+IE5vLCB3ZSBk
byBub3QsIGJlY2F1c2UgdGhpcyBpbmRpY2F0ZXMgb25seSB0aGUgZmFjdCB0aGF0IHRoZSBndWVz
dCBjYW4KPiBzZW5kIGxhcmdlIFVEUCBwYWNrZXRzIGFuZCBoYXZlIHRoZW0gc3BsaXR0ZWQgdG8g
VURQIHNlZ21lbnRzLgoKCkFjdHVhbGx5IHRoZSByZXZlcnNlLiBUaGUgc2V0X29mZmxvYWQoKSBj
b250cm9scyB0aGUgdHVudGFwIFRYIHBhdGggCihndWVzdCBSWCBwYXRoKS4KCldoZW4gVklSVElP
X05FVF9GX0dVRVNUX1hYWCB3YXMgbm90IG5lZ290aWF0ZWQsIHRoZSBjb3JyZXNwb25kaW5nIG5l
dGRldiAKZmVhdHVyZXMgbmVlZHMgdG8gYmUgZGlzYWJsZWQuIFdoZW4gaG9zdCB0cmllcyB0byBz
ZW5kIHRob3NlIHBhY2tldHMgdG8gCmd1ZXN0LCBpdCBuZWVkcyB0byBkbyBzb2Z0d2FyZSBzZWdt
ZW50YXRpb24uCgpTZWUgdmlydGlvX25ldF9hcHBseV9ndWVzdF9vZmZsb2FkcygpLgoKVGhlcmUn
cyBjdXJyZW50bHkgbm8gd2F5IChvciBub3QgbmVlZCkgdG8gcHJldmVudCB0dW50YXAgZnJvbSBy
ZWNlaXZpbmcgCkdTTyBwYWNrZXRzLgoKVGhhbmtzCgoKPgo+PiBBbmQgaG93IGFib3V0IG1hY3Z0
YXA/Cj4gV2Ugd2lsbCBjaGVjayBob3cgdG8gZG8gdGhhdCBmb3IgbWFjdnRhcC4gV2Ugd2lsbCBz
ZW5kIGEgc2VwYXJhdGUKPiBwYXRjaCBmb3IgbWFjdnRhcCBvciBhc2sgZm9yIGFkdmljZS4KPgo+
PiBUaGFua3MKPj4KPj4KPj4+ICAgICAgICB9Cj4+Pgo+Pj4gICAgICAgIC8qIFRoaXMgZ2l2ZXMg
dGhlIHVzZXIgYSB3YXkgdG8gdGVzdCBmb3IgbmV3IGZlYXR1cmVzIGluIGZ1dHVyZSBieQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
