Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31838C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 04:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFD3060EC0;
	Wed,  9 Feb 2022 04:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id leOwosKq0CxV; Wed,  9 Feb 2022 04:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 505E960E33;
	Wed,  9 Feb 2022 04:41:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A3ACC001A;
	Wed,  9 Feb 2022 04:41:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64796C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 471C960E33
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igK6wxnSIkRp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5038360E2A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644381679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFWmdw6agML5Lvp7n8TEaUNHHxhduLe2TaxIAnf1RnY=;
 b=gmTDkMKmulECKYgzrohblBcU3EUJFTA0AddFv1AL+Aue40zRnEA18g1Scj9WzKu53fxpIg
 ueFATF9kNDMJ3L7ZjBuwLJ8mCE4Ie9JaSLrFI8DEtymitZV3Xr4HEbH2c4ArTV9+v0pZ/P
 mPFxmD1M7qGd7mgfgKTzbmzFuXFvriQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-bS4_Ll0KNW66hTIRjV_uBQ-1; Tue, 08 Feb 2022 23:41:16 -0500
X-MC-Unique: bS4_Ll0KNW66hTIRjV_uBQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 v20-20020a1709028d9400b0014ca63d0f10so950866plo.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 20:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MFWmdw6agML5Lvp7n8TEaUNHHxhduLe2TaxIAnf1RnY=;
 b=na5j2V5dDFe2SyfXVlQ9RsW7gTDDd8J8ijCFBezPg3OI8NcwxBx/tga2Tf+GqKwK/+
 WlPXHnBdj7tfRolq6O01VJXyMKnNFAEFgHYi/+lwGsgQI/k2xhaR0JG3AXF/E0Pmc7kC
 2SQS88OysLdTT0At7dhYYtd8tVrNTYBvE32ygktRu1dyQl/etRYK3+QazVbzkmsyDkio
 ItCJUhdjh2RMx+sJnf6s6d0OrKY8tiv0N0CTiaD5X2rDl5Emy7y4IsX42Y8B4KEzltDr
 MukQcQrwty+ir19cM1/BjQC7EfSpm49lQMxT26KLrO483IulOjlVrOj+wccRLBw3856R
 fEdA==
X-Gm-Message-State: AOAM533FDHiJq46zs+xPeqY8cya1fSxQqAv5XKjrInHQI/4AyfQKb6wM
 Kvmlr6+BSg3wvqGSa4zZ2BlZrPaWgjEFETMzexh0PV4DUwa4DIrUNiM4aDoCyXJrC1mRQ2w15Du
 pgb6Ad8/k4vGt1G9IyGkjlKj/uooxzKTempCgS5MBqA==
X-Received: by 2002:a17:902:ce04:: with SMTP id
 k4mr488612plg.153.1644381674855; 
 Tue, 08 Feb 2022 20:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziDDW40ufTvoa4ZTNyDLcixnRVfaKgHb5Pf+PMQoswgukJOyKCv3mwEFbssbYa6ZkDWq3aMg==
X-Received: by 2002:a17:902:ce04:: with SMTP id
 k4mr488594plg.153.1644381674587; 
 Tue, 08 Feb 2022 20:41:14 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q16sm17640261pfu.194.2022.02.08.20.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 20:41:13 -0800 (PST)
Message-ID: <158bf351-9ffd-39d0-8658-52d4667f781d@redhat.com>
Date: Wed, 9 Feb 2022 12:41:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 3/5] uapi/linux/virtio_net.h: Added USO types.
To: Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-4-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-4-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

CuWcqCAyMDIyLzEvMjUg5LiL5Y2INDo0NywgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBB
ZGRlZCBuZXcgR1NPIHR5cGUgZm9yIFVTTzogVklSVElPX05FVF9IRFJfR1NPX1VEUF9MNC4KPiBG
ZWF0dXJlIFZJUlRJT19ORVRfRl9IT1NUX1VTTyBhbGxvd3MgdG8gZW5hYmxlIE5FVElGX0ZfR1NP
X1VEUF9MNC4KPiBTZXBhcmF0ZWQgVklSVElPX05FVF9GX0dVRVNUX1VTTzQgJiBWSVJUSU9fTkVU
X0ZfR1VFU1RfVVNPNiBmZWF0dXJlcwo+IHJlcXVpcmVkIGZvciBXaW5kb3dzIGd1ZXN0cy4KPgo+
IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNZWxueWNoZW5rbyA8YW5kcmV3QGRheW5peC5jb20+Cj4g
LS0tCj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHwgNCArKysrCj4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19uZXQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPiBp
bmRleCAzZjU1YTQyMTVmMTEuLjYyMGFkZGM1NzY3YiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX25ldC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19u
ZXQuaAo+IEBAIC01Niw2ICs1Niw5IEBACj4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9NUQkyMgkv
KiBEZXZpY2Ugc3VwcG9ydHMgUmVjZWl2ZSBGbG93Cj4gICAJCQkJCSAqIFN0ZWVyaW5nICovCj4g
ICAjZGVmaW5lIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSIDIzCS8qIFNldCBNQUMgYWRkcmVz
cyAqLwo+ICsjZGVmaW5lIFZJUlRJT19ORVRfRl9HVUVTVF9VU080CTU0CS8qIEd1ZXN0IGNhbiBo
YW5kbGUgVVNPdjQgaW4uICovCj4gKyNkZWZpbmUgVklSVElPX05FVF9GX0dVRVNUX1VTTzYJNTUJ
LyogR3Vlc3QgY2FuIGhhbmRsZSBVU092NiBpbi4gKi8KPiArI2RlZmluZSBWSVJUSU9fTkVUX0Zf
SE9TVF9VU08JNTYJLyogSG9zdCBjYW4gaGFuZGxlIFVTTyBpbi4gKi8KCgpJIHRoaW5rIGl0J3Mg
YmV0dGVyIHRvIGJlIGNvbnNpc3RlbnQgaGVyZS4gRWl0aGVyIHdlIHNwbGl0IGluIGJvdGggZ3Vl
c3QgCmFuZCBob3N0IG9yIG5vdC4KClRoYW5rcwoKCj4gICAKPiAgICNkZWZpbmUgVklSVElPX05F
VF9GX0hBU0hfUkVQT1JUICA1NwkvKiBTdXBwb3J0cyBoYXNoIHJlcG9ydCAqLwo+ICAgI2RlZmlu
ZSBWSVJUSU9fTkVUX0ZfUlNTCSAgNjAJLyogU3VwcG9ydHMgUlNTIFJYIHN0ZWVyaW5nICovCj4g
QEAgLTEzMCw2ICsxMzMsNyBAQCBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjEgewo+ICAgI2RlZmlu
ZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjQJMQkvKiBHU08gZnJhbWUsIElQdjQgVENQIChUU08p
ICovCj4gICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19VRFAJCTMJLyogR1NPIGZyYW1lLCBJ
UHY0IFVEUCAoVUZPKSAqLwo+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjYJNAkv
KiBHU08gZnJhbWUsIElQdjYgVENQICovCj4gKyNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1VE
UF9MNAk1CS8qIEdTTyBmcmFtZSwgSVB2NCAmIElQdjYgVURQIChVU08pICovCj4gICAjZGVmaW5l
IFZJUlRJT19ORVRfSERSX0dTT19FQ04JCTB4ODAJLyogVENQIGhhcyBFQ04gc2V0ICovCj4gICAJ
X191OCBnc29fdHlwZTsKPiAgIAlfX3ZpcnRpbzE2IGhkcl9sZW47CS8qIEV0aGVybmV0ICsgSVAg
KyB0Y3AvdWRwIGhkcnMgKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
