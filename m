Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0563CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 12:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71AB260EC8;
	Tue, 12 Jul 2022 12:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71AB260EC8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PWFn4lTd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 89tOKrFRMpDp; Tue, 12 Jul 2022 12:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6DE860A6B;
	Tue, 12 Jul 2022 12:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6DE860A6B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB244C0033;
	Tue, 12 Jul 2022 12:30:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02C16C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 12:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D080860BFB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 12:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D080860BFB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WynzmugjUuGt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 12:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB1B060A6B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB1B060A6B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657629034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ozgUhvIWKASvsf5a+WUmynagIG9hnmSOEkRHQEhJ0I=;
 b=PWFn4lTdzz3jW2FJ7ylmabNyNr6rmAG6nXvDRHOXYie1XziDK0KjJrb+jrwyCbpIG4Mtpw
 Ro0+cYIzqUfiIfD7HZv3jitZNLZaxATk0gOEX0r2cT/iqe8IFFPzJEgyE33O9+dUyzC5R4
 mqNpvTyYA9QL+ADvw8DfCN2qwFQUwvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-eSXD1qowP0So1wWOtkQzBA-1; Tue, 12 Jul 2022 08:30:32 -0400
X-MC-Unique: eSXD1qowP0So1wWOtkQzBA-1
Received: by mail-wm1-f69.google.com with SMTP id
 bg6-20020a05600c3c8600b003a03d5d19e4so3703233wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 05:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=8ozgUhvIWKASvsf5a+WUmynagIG9hnmSOEkRHQEhJ0I=;
 b=F5mTDC+AxLCO7TMqQFvN4N39If9+B8TTC4M78DOC6Cl4z/mS9/PCVntz+8kxzBjWiI
 BWSU2iGJ+XbE8islDxvZWlnlNhgQsONCzrAXiTqNXe0ernZYyPmBg5dy78u/NtoBcyld
 ZW604D5PovP8z3gbi10dl8T9L/aolusEzjJC5KfDo+Fe6i/JOwDRVVhsHpwfugSZ6C+y
 3TPoNxMU9PVJ0femi9hpnEXJsjGikxiQARg9hQDxenbPclLTvoc49WPgTJppSzVcpoK8
 l0VOPHLZdzFQ7k5m/gtcfKL2iGuYBzry26p8MEiGAvX+1Y2COyDEpKtxJRRgBt3KdSi0
 nzFQ==
X-Gm-Message-State: AJIora9R5GTdUQHY8IVn0oFoyp+l/unLRDZ4cgpCLNFsnka9YJK96WkS
 RbacKq7b8zTwzyY3zIvJjp97t2f7VxJtC5Q9T3/cy4CitH2zlPsVj6eiIFwwrHOsXY2eNhEQOVR
 pbQsi7hKNxkl3FKSCFcSkCNTYNcuXnL+Fqc2jE9ilrw==
X-Received: by 2002:adf:c6c1:0:b0:21d:976e:6e87 with SMTP id
 c1-20020adfc6c1000000b0021d976e6e87mr15888244wrh.140.1657629031445; 
 Tue, 12 Jul 2022 05:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWGX4QWbrSslFM8amOOZY3A7QRzMxODKWapi8+CUV0gLy4qUHfsp5AT5HZp7ImMobcuttpmA==
X-Received: by 2002:adf:c6c1:0:b0:21d:976e:6e87 with SMTP id
 c1-20020adfc6c1000000b0021d976e6e87mr15888222wrh.140.1657629031178; 
 Tue, 12 Jul 2022 05:30:31 -0700 (PDT)
Received: from redhat.com ([2.52.24.42]) by smtp.gmail.com with ESMTPSA id
 k1-20020a05600c0b4100b003a2d45472b6sm12627225wmr.28.2022.07.12.05.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 05:30:30 -0700 (PDT)
Date: Tue, 12 Jul 2022 08:30:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] tools/virtio: drop phys_addr_t typedef
Message-ID: <20220712083021-mutt-send-email-mst@kernel.org>
References: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
 <CACGkMEtnXPBvv1W8SdT0Hv4riShQP3Du+EMv0XNgOGNmmfS6ng@mail.gmail.com>
 <DU0PR04MB94176F8C95FB297B4FCAD4D988869@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DU0PR04MB94176F8C95FB297B4FCAD4D988869@DU0PR04MB9417.eurprd04.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

V2lsbCBkby4KCk9uIFR1ZSwgSnVsIDEyLCAyMDIyIGF0IDA0OjU5OjQ0QU0gKzAwMDAsIFBlbmcg
RmFuIHdyb3RlOgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gdG9vbHMvdmlydGlvOiBkcm9wIHBo
eXNfYWRkcl90IHR5cGVkZWYKPiAKPiBXb3VsZCBhbnlvbmUgcGljayB1cCB0aGlzIHBhdGNoPyBP
ciBhbnkgY29tbWVudHM/Cj4gCj4gVGhhbmtzLAo+IFBlbmcuCj4gCj4gPiAKPiA+IE9uIE1vbiwg
QXByIDExLCAyMDIyIGF0IDk6MzkgQU0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAu
Y29tPgo+ID4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPgo+ID4gPgo+ID4gPiBXaXRoIGNvbW1pdCA4ODRlZTFlNTg1Y2EgKCJ0b29scy9pbmNsdWRl
OiBBZGQgcGh5c19hZGRyX3QgdG8KPiA+ID4gdHlwZXMuaCIpLAo+ID4gPgo+ID4gPiBXaGVuIGJ1
aWxkaW5nIHZpcnRpbyB0b29scywgdGhlcmUgaXMgYSB0eXBlIGNvbmZpY3RpbmcgZXJyb3I6Cj4g
PiA+Cj4gPiA+ICIKPiA+ID4gLi9saW51eC9rZXJuZWwuaDozMjoyODogZXJyb3I6IGNvbmZsaWN0
aW5nIHR5cGVzIGZvciDigJhwaHlzX2FkZHJfdOKAmQo+ID4gPiAgICAzMiB8IHR5cGVkZWYgdW5z
aWduZWQgbG9uZyBsb25nIHBoeXNfYWRkcl90Owo+ID4gPiAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+Cj4gPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNy
L2luY2x1ZGUvbGludXgvdmlydGlvX2Jsay5oOjI4LAo+ID4gPiAgICAgICAgICAgICAgICAgIGZy
b20gdmlydGlvLWl2c2htZW0tYmxvY2suYzoyOToKPiA+ID4gLi4vaW5jbHVkZS9saW51eC90eXBl
cy5oOjY5OjEzOiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhwaHlzX2FkZHJfdOKA
mQo+ID4gd2FzIGhlcmUKPiA+ID4gICAgNjkgfCB0eXBlZGVmIHUzMiBwaHlzX2FkZHJfdDsKPiA+
ID4gICAgICAgfCAgICAgICAgICAgICBefn5+fn5+fn5+fgo+ID4gPiAiCj4gPiA+Cj4gPiA+IExl
dCdzIGRyb3AgdGhlIHR5cGVkZWYgaW4gdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oCj4gPiA+
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPgo+ID4gCj4g
PiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+IAo+ID4gPiAt
LS0KPiA+ID4gIHRvb2xzL3ZpcnRpby9saW51eC9rZXJuZWwuaCB8IDEgLQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Zp
cnRpby9saW51eC9rZXJuZWwuaCBiL3Rvb2xzL3ZpcnRpby9saW51eC9rZXJuZWwuaAo+ID4gPiBp
bmRleCAwYjQ5MzU0MmU2MWEuLjFkMzI0OGUzZjI3MCAxMDA2NDQKPiA+ID4gLS0tIGEvdG9vbHMv
dmlydGlvL2xpbnV4L2tlcm5lbC5oCj4gPiA+ICsrKyBiL3Rvb2xzL3ZpcnRpby9saW51eC9rZXJu
ZWwuaAo+ID4gPiBAQCAtMjksNyArMjksNiBAQAo+ID4gPiAgI2RlZmluZSBSRUFEICAgICAgICAg
ICAgICAgICAgICAwCj4gPiA+ICAjZGVmaW5lIFdSSVRFICAgICAgICAgICAgICAgICAgIDEKPiA+
ID4KPiA+ID4gLXR5cGVkZWYgdW5zaWduZWQgbG9uZyBsb25nIHBoeXNfYWRkcl90OyAgdHlwZWRl
ZiB1bnNpZ25lZCBsb25nIGxvbmcKPiA+ID4gZG1hX2FkZHJfdDsgIHR5cGVkZWYgc2l6ZV90IF9f
a2VybmVsX3NpemVfdDsgIHR5cGVkZWYgdW5zaWduZWQgaW50Cj4gPiA+IF9fd3N1bTsKPiA+ID4g
LS0KPiA+ID4gMi4yNS4xCj4gPiA+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
