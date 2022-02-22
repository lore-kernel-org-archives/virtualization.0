Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19163C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 13:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A55A0410B7;
	Tue, 22 Feb 2022 13:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1HwZbTgmNZM; Tue, 22 Feb 2022 13:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F422410A0;
	Tue, 22 Feb 2022 13:14:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0499DC0021;
	Tue, 22 Feb 2022 13:14:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16511C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA1D0410B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhIO553-F1uR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:14:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52F79410A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:14:55 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 i10-20020a4aab0a000000b002fccf890d5fso17419134oon.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CEerrz21cbosvpLV95NRyIff4EV45dk3/IMZ19l1mpI=;
 b=MYcI+sOXGRtToSec1JNnWD66yy1q0es9zhN+oL36gOb/Hu4+7wh/Pa1XfmSaoSSix9
 1nOcIApEvHjHTYH8dN78QQduPQkbCzC6j0vOyQ23VlQtL9S4gP+B/LDNt/gTwnCjskmH
 cqD45Ozrf/uG+AHj91OaeuXR8cy0SysEfuOWS4FGCv11uISFfgtzy+pC8zYPUxfZ7tEx
 QSLLqgRVljcO28Qoy7llIGxinK0jfrV2vj6YzSCPsGSpl1QMc0Ovbe/IrkT+3ioXqmbQ
 MxOoOIWr0WF60Tfgx9toC5/p1XkyDv25Wila7Xl96aze7/KHxKP+Jn1ktiCkut+aSWsA
 F9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CEerrz21cbosvpLV95NRyIff4EV45dk3/IMZ19l1mpI=;
 b=rGshLv2Cmd3n2nWa2Hn7UilvH0sFik2B2WGhD95ZK0Nqgqd2OvnXOXypNYlEPcY7Tw
 810toKpEMw2k3gFEd3PSe1rWStisubmmVKP4IOKMTi4gmlJ7Rpo3bx5Xu/OFACCR9p1z
 nSiO9OFvvIZ+S83fVqraNSqkWtz1CQZ6dv23BEqpnJjwXK4JFnM/skMyqRTEtXXd4gYG
 8xkMidYmTWMMMKwiX5uvXgyWOzLSQ2GBOvpRMwUHSJf25g1yPqcD8KZQkx7j4mmw57rZ
 N40PeLr6P96Yf/y42KbpDODE+sv9XbL5NZX4j4eRnT6jH44nvT1ER68u4uGdiCnlYbUM
 xecA==
X-Gm-Message-State: AOAM532Wxb0gHnn0pZkezbz0RNMFQpxPqzRE/jLdTQWEd2c3xlSQaKp5
 JzLMzfasZPaXkyvOne6+8SxbuKUW9SxFWb35tB3phQ==
X-Google-Smtp-Source: ABdhPJzzMUNAaPhJBgVrHvZGRzZ8MtWaaLKCnyy9cfxZkQsuxRulZ5I865w9LO7+zeY/fxq84ZXXKr0g749GxGoldwM=
X-Received: by 2002:a05:6870:6106:b0:d4:473f:7671 with SMTP id
 s6-20020a056870610600b000d4473f7671mr1500451oae.327.1645535695116; Tue, 22
 Feb 2022 05:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-4-andrew@daynix.com>
 <158bf351-9ffd-39d0-8658-52d4667f781d@redhat.com>
In-Reply-To: <158bf351-9ffd-39d0-8658-52d4667f781d@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 22 Feb 2022 15:14:44 +0200
Message-ID: <CABcq3pF=_ocbk=GaNZqr5YRSzFt11F508Fb76JxKRXFzfh1D2w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] uapi/linux/virtio_net.h: Added USO types.
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgYWxsLAoKCgpPbiBXZWQsIEZlYiA5LCAyMDIyIGF0IDY6NDEgQU0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIyLzEvMjUg5LiL5Y2INDo0Nywg
QW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiA+IEFkZGVkIG5ldyBHU08gdHlwZSBmb3IgVVNP
OiBWSVJUSU9fTkVUX0hEUl9HU09fVURQX0w0Lgo+ID4gRmVhdHVyZSBWSVJUSU9fTkVUX0ZfSE9T
VF9VU08gYWxsb3dzIHRvIGVuYWJsZSBORVRJRl9GX0dTT19VRFBfTDQuCj4gPiBTZXBhcmF0ZWQg
VklSVElPX05FVF9GX0dVRVNUX1VTTzQgJiBWSVJUSU9fTkVUX0ZfR1VFU1RfVVNPNiBmZWF0dXJl
cwo+ID4gcmVxdWlyZWQgZm9yIFdpbmRvd3MgZ3Vlc3RzLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZHJldyBNZWxueWNoZW5rbyA8YW5kcmV3QGRheW5peC5jb20+Cj4gPiAtLS0KPiA+ICAgaW5j
bHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCB8IDQgKysrKwo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oCj4gPiBpbmRl
eCAzZjU1YTQyMTVmMTEuLjYyMGFkZGM1NzY3YiAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC92aXJ0aW9fbmV0LmgKPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9f
bmV0LmgKPiA+IEBAIC01Niw2ICs1Niw5IEBACj4gPiAgICNkZWZpbmUgVklSVElPX05FVF9GX01R
ICAgICAyMiAgICAgIC8qIERldmljZSBzdXBwb3J0cyBSZWNlaXZlIEZsb3cKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogU3RlZXJpbmcgKi8KPiA+ICAgI2RlZmlu
ZSBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNfQUREUiAyMyAgICAgICAvKiBTZXQgTUFDIGFkZHJlc3Mg
Ki8KPiA+ICsjZGVmaW5lIFZJUlRJT19ORVRfRl9HVUVTVF9VU080ICAgICAgNTQgICAgICAvKiBH
dWVzdCBjYW4gaGFuZGxlIFVTT3Y0IGluLiAqLwo+ID4gKyNkZWZpbmUgVklSVElPX05FVF9GX0dV
RVNUX1VTTzYgICAgICA1NSAgICAgIC8qIEd1ZXN0IGNhbiBoYW5kbGUgVVNPdjYgaW4uICovCj4g
PiArI2RlZmluZSBWSVJUSU9fTkVUX0ZfSE9TVF9VU08gICAgICAgIDU2ICAgICAgLyogSG9zdCBj
YW4gaGFuZGxlIFVTTyBpbi4gKi8KPgo+Cj4gSSB0aGluayBpdCdzIGJldHRlciB0byBiZSBjb25z
aXN0ZW50IGhlcmUuIEVpdGhlciB3ZSBzcGxpdCBpbiBib3RoIGd1ZXN0Cj4gYW5kIGhvc3Qgb3Ig
bm90Lgo+Cj4gVGhhbmtzCj4KClRoZSBtYWluIHJlYXNvbiB0aGF0IHJlY2VpdmVzIFVTTyBwYWNr
ZXRzIGRlcGVuZHMgb24gdGhlIGtlcm5lbCwgd2hlcmUKdHJhbnNtaXR0aW5nIHRoZSBmZWF0dXJl
IHRoYXQgVmlydElPIGltcGxlbWVudHMuCldpbmRvd3Mgc3lzdGVtcyBoYXZlIHRoZSBvcHRpb24g
dG8gbWFuaXB1bGF0ZSByZWNlaXZlIG9mZmxvYWQuIFRoYXQncwp3aHkgdGhlcmUgYXJlIHR3byBH
VUVTVF9VU08gZmVhdHVyZXMuCkZvciBIT1NUX1VTTyAtIHRlY2huaWNhbGx5IHRoZXJlIGlzIG5v
IHBvaW50IGluICJzcGxpdCIgaXQsIGFuZCB0aGVyZQppcyBzaG91bGQgbm90IGJlIGFueSBkaWZm
ZXJlbmNlIGJldHdlZW4gSVB2NC9JUHY2LgpUZWNobmljYWxseSwgd2UgZWl0aGVyIHN1cHBvcnQg
dHJhbnNtaXR0aW5nIGJpZyBVRFAgcGFja2V0cyBvciBub3QuCgo+Cj4gPgo+ID4gICAjZGVmaW5l
IFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCAgNTcgICAgICAgIC8qIFN1cHBvcnRzIGhhc2ggcmVw
b3J0ICovCj4gPiAgICNkZWZpbmUgVklSVElPX05FVF9GX1JTUyAgICAgIDYwICAgIC8qIFN1cHBv
cnRzIFJTUyBSWCBzdGVlcmluZyAqLwo+ID4gQEAgLTEzMCw2ICsxMzMsNyBAQCBzdHJ1Y3Qgdmly
dGlvX25ldF9oZHJfdjEgewo+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19UQ1BWNCAg
ICAxICAgICAgIC8qIEdTTyBmcmFtZSwgSVB2NCBUQ1AgKFRTTykgKi8KPiA+ICAgI2RlZmluZSBW
SVJUSU9fTkVUX0hEUl9HU09fVURQICAgICAgICAgICAgICAzICAgICAgIC8qIEdTTyBmcmFtZSwg
SVB2NCBVRFAgKFVGTykgKi8KPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjYg
ICAgNCAgICAgICAvKiBHU08gZnJhbWUsIElQdjYgVENQICovCj4gPiArI2RlZmluZSBWSVJUSU9f
TkVUX0hEUl9HU09fVURQX0w0ICAgIDUgICAgICAgLyogR1NPIGZyYW1lLCBJUHY0ICYgSVB2NiBV
RFAgKFVTTykgKi8KPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fRUNOICAgICAgICAg
ICAgICAweDgwICAgIC8qIFRDUCBoYXMgRUNOIHNldCAqLwo+ID4gICAgICAgX191OCBnc29fdHlw
ZTsKPiA+ICAgICAgIF9fdmlydGlvMTYgaGRyX2xlbjsgICAgIC8qIEV0aGVybmV0ICsgSVAgKyB0
Y3AvdWRwIGhkcnMgKi8KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
