Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71237C77B73
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 03:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5F7A400AB;
	Mon,  8 May 2023 03:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5F7A400AB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbMH+Ehn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7CjONRishEV; Mon,  8 May 2023 03:59:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5D09E40150;
	Mon,  8 May 2023 03:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D09E40150
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A08AC0036;
	Mon,  8 May 2023 03:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7F2FC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3D2B4173B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3D2B4173B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbMH+Ehn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYT5hzkZ5A_G
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:59:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA2AA41735
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA2AA41735
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 03:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683518354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhV1HCZuC1ykzH7ZXQCmd5NhspBHpB8ROhzdIJyNs4g=;
 b=YbMH+Ehn+k7pm560I8vtOqimMCkNZcaPUsBxUk6Hya1pjk9Du5qiKTyZEMXfcKJpd0Ry2o
 2cI9lsrUYsPYmGXGKTZvSxbfuMlbrAiKiww9EodAL1XzRzFIuzNS2YeftIbNegc4NI7FEs
 FvxacAextcP+zE9jix9oM1NH9dNnhn8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-FehcGRc9Pge_cYvDBPHXJA-1; Sun, 07 May 2023 23:59:13 -0400
X-MC-Unique: FehcGRc9Pge_cYvDBPHXJA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2a8bba7dd2cso20152441fa.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 20:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683518352; x=1686110352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhV1HCZuC1ykzH7ZXQCmd5NhspBHpB8ROhzdIJyNs4g=;
 b=h43VgReNdtYrGj7bAAjj4vf3l7Dd7iwMmjY1aqGpioxbFIuX3Ci+rpt6ZOXwGH/Jnx
 vyDSocfJlpdqF4ARc4m3Nvx2ic8NA0NJeup+FZLY7S+oqg+PxxKpdcsBjau3F024EtmI
 bib9p0LOxV59MsY8eJiS49gOwwMP6E5sUeOk67/HYKuyc8vfRWV4zzMAHwrEjxA9brl5
 a24j8i3MSTNeJngN1QS8iz1C4uLlc5U76y/mt6GDEIfywuRN4jUnAeMAf8sSWG2cgybP
 dYDwr+eawDx3L+9Wxk5XN/pXaebIW/Hr9j9+X0g4bsB/FW+Yl6/iXR1zwkBAvuppno+B
 ZdBA==
X-Gm-Message-State: AC+VfDybRY23pTPf1v5n/03mlH/xJLa5hJEORc8DvDFzYcYkny+4FxS6
 PUwENWlS2RotMojBzsi9dGJqSgC5bsOKRhmU+tMhoGPfh1NDTd+AgZvwXERvd0DEhVelVWuDmjg
 LQTHPIOIYmRW9Q8iEBbgYZSfgp5H4m3YPV8JzrXwyIlt3UNn2ITjKPG/9pw==
X-Received: by 2002:a2e:9a8c:0:b0:2a8:d021:4121 with SMTP id
 p12-20020a2e9a8c000000b002a8d0214121mr2603319lji.26.1683518351981; 
 Sun, 07 May 2023 20:59:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HJcVoKi2ee89Revfy5S+1yRrWBbXV9kLn9T7LqZGtjxjvcGzOFe2CnWI1zMNd6LM+SIeINluarYhhWMghnT4=
X-Received: by 2002:a2e:9a8c:0:b0:2a8:d021:4121 with SMTP id
 p12-20020a2e9a8c000000b002a8d0214121mr2603307lji.26.1683518351704; Sun, 07
 May 2023 20:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp>
 <20230427104428.862643-3-mie@igel.co.jp>
In-Reply-To: <20230427104428.862643-3-mie@igel.co.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 May 2023 11:59:00 +0800
Message-ID: <CACGkMEsOw08UWdNfhVd8q2-SwCt+jwMbeYwYQ+OMN+2RiHBZag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] virtio_pci: add a definition of queue flag in
 ISR
To: Shunsuke Mie <mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBBcHIgMjcsIDIwMjMgYXQgNjo0NOKAr1BNIFNodW5zdWtlIE1pZSA8bWllQGlnZWwu
Y28uanA+IHdyb3RlOgo+Cj4gQWxyZWFkeSBpdCBoYXMgYmVlZCBkZWZpbmVkIGEgY29uZmlnIGNo
YW5nZWQgZmxhZyBvZiBJU1IsIGJ1dCBub3QgdGhlIHF1ZXVlCgpUeXBvIHNob3VsZCBiZSAiYmVl
biIuCgo+IGZsYWcuIEFkZCBhIG1hY3JvIGZvciBpdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFNodW5z
dWtlIE1pZSA8bWllQGlnZWwuY28uanA+CgpPdGhlciB0aGFuIHRoaXMsCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCj4gLS0tCj4gIGluY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcGNpLmggfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1
ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiBpbmRleCBmNzAzYWZjN2FkMzEuLmQ0MDViZWEy
NzI0MCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gKysr
IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+IEBAIC05NCw2ICs5NCw5IEBACj4K
PiAgI2VuZGlmIC8qIFZJUlRJT19QQ0lfTk9fTEVHQUNZICovCj4KPiArLyogQml0cyBmb3IgSVNS
IHN0YXR1cyBmaWVsZDpvbmx5IHdoZW4gaWYgTVNJLVggaXMgZGlzYWJsZWQgKi8KPiArLyogVGhl
IGJpdCBvZiB0aGUgSVNSIHdoaWNoIGluZGljYXRlcyBhIHF1ZXVlIGVudHJ5IHVwZGF0ZS4gKi8K
PiArI2RlZmluZSBWSVJUSU9fUENJX0lTUl9RVUVVRSAgICAgICAgICAgMHgxCj4gIC8qIFRoZSBi
aXQgb2YgdGhlIElTUiB3aGljaCBpbmRpY2F0ZXMgYSBkZXZpY2UgY29uZmlndXJhdGlvbiBjaGFu
Z2UuICovCj4gICNkZWZpbmUgVklSVElPX1BDSV9JU1JfQ09ORklHICAgICAgICAgIDB4Mgo+ICAv
KiBWZWN0b3IgdmFsdWUgdXNlZCB0byBkaXNhYmxlIE1TSSBmb3IgcXVldWUgKi8KPiAtLQo+IDIu
MjUuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
