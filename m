Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ACAC636D6
	for <virtualization@archiver.kernel.org>; Thu, 23 Feb 2023 02:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8753C403EA;
	Thu, 23 Feb 2023 02:41:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8753C403EA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mp65G9O7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ei-QmGGCaGNZ; Thu, 23 Feb 2023 02:41:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 03790400D6;
	Thu, 23 Feb 2023 02:41:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03790400D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDF10C0033;
	Thu, 23 Feb 2023 02:41:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1018C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7846D41907
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7846D41907
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mp65G9O7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WKpv2P_xrQds
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3885C418FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3885C418FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677120102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ziz5MxFU0ZrUNvw6PLY1Gqtxr/ofFXWOuihWXRLcoBI=;
 b=Mp65G9O7SDMXbg0KxlYMG3Q77yGZWqdDuX1yZUBLbSXNsr+KEk+Yj1pL3iLEcJk8fQSEnX
 9O/f0rj98IlffRQDHJB6iq64NcGaO/Sypcd2sU8mKL870TivtEVzTFeq2BekaAuN7SI2mz
 ZRQLkvDl3RQqMYcHb9jXb0HTnUf8d9Y=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-qBDq__6YPqK_QFR1HGKZSQ-1; Wed, 22 Feb 2023 21:41:40 -0500
X-MC-Unique: qBDq__6YPqK_QFR1HGKZSQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 e127-20020a636985000000b004bbc748ca63so3850321pgc.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 18:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ziz5MxFU0ZrUNvw6PLY1Gqtxr/ofFXWOuihWXRLcoBI=;
 b=LYRoQX85zpz9N3P+pKqhukt7Fz4CM1HGqFC6gVIu6/NcNB7zXDUm72nUtnEH3w3Q/v
 iouSTPZ1EVNzXUZOOzTROkTku3Poo1Iw8Sv9WBkHvtq5juPBragugHsC/wyWaq+A6F4l
 YRX/+PrBIWTpwzr1ASuJdUojKRUeGufEmE9hhN1lkh/Zt3uP1mfBlpWj/jBm5Liiq4c2
 4ntbHTGJ68/pYAaobqM56Ze2SzXUClI1rZHBhimz53ffj18oE54xu5jkXjZh+8TrXjNJ
 k42WBsZWkvzF5RoFweAMVV18txy7rGLRiWyTs/URUTi3zjqKSKW4+yVm1BYjDnlge8if
 O7Xw==
X-Gm-Message-State: AO0yUKVjswK9MvuVcRmf8O5NdQGqQq+7Fyb7IPmPhpoktSMPbq7tzIB2
 /SOQM+xb+xLUE1f9PbwArWZd1FW244dhG1GtQUHrPkh6yj3dd7oN/UHssxXdw1II/UPPhL1+Qsl
 wnyliM0Prb2yWil3rjaVBtwVV/XJKf2Yvecip+LIqew==
X-Received: by 2002:a17:903:1205:b0:19a:b151:bf68 with SMTP id
 l5-20020a170903120500b0019ab151bf68mr11723320plh.38.1677120099775; 
 Wed, 22 Feb 2023 18:41:39 -0800 (PST)
X-Google-Smtp-Source: AK7set91CxZzolnqQ10iVScbBV52Sq6CkIbngY8R4svNhYX2VR5X3w7K4p6fC8Ue2grKjZB35HdVmw==
X-Received: by 2002:a17:903:1205:b0:19a:b151:bf68 with SMTP id
 l5-20020a170903120500b0019ab151bf68mr11723289plh.38.1677120099501; 
 Wed, 22 Feb 2023 18:41:39 -0800 (PST)
Received: from [10.72.13.176] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001966d94cb2esm7911505plq.288.2023.02.22.18.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Feb 2023 18:41:39 -0800 (PST)
Message-ID: <c0505c7c-c3d1-372f-c8df-2a4b84ec7fce@redhat.com>
Date: Thu, 23 Feb 2023 10:41:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 09/13] vdpa net: block migration if the device has CVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-10-eperezma@redhat.com>
 <de141eaa-6cc4-e942-9fff-de4dcee8625f@redhat.com>
 <CAJaqyWerBtkw1KxiAThXza0htxV=PkJZGtoAxeHKKd5p_Dq55g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWerBtkw1KxiAThXza0htxV=PkJZGtoAxeHKKd5p_Dq55g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CuWcqCAyMDIzLzIvMjIgMTU6MjgsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiBPbiBX
ZWQsIEZlYiAyMiwgMjAyMyBhdCA1OjAxIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Pgo+PiDlnKggMjAyMy8yLzggMTc6NDIsIEV1Z2VuaW8gUMOpcmV6IOWGmemB
kzoKPj4+IERldmljZXMgd2l0aCBDVlEgbmVlZHMgdG8gbWlncmF0ZSBzdGF0ZSBiZXlvbmQgdnEg
c3RhdGUuICBMZWF2aW5nIHRoaXMKPj4+IHRvIGZ1dHVyZSBzZXJpZXMuCj4+Cj4+IEkgbWF5IG1p
c3Mgc29tZXRoaW5nIGJ1dCB3aGF0IGlzIG1pc3NlZCB0byBzdXBwb3J0IENWUS9NUT8KPj4KPiBU
byByZXN0b3JlIGFsbCB0aGUgZGV2aWNlIHN0YXRlIHNldCBieSBDVlEgaW4gdGhlIG1pZ3JhdGlv
biBzb3VyY2UKPiAoTUFDLCBNUSwgLi4uKSBiZWZvcmUgZGF0YSB2cXMgc3RhcnQuIFdlIGRvbid0
IGhhdmUgYSByZWxpYWJsZSB3YXkgdG8KPiBub3Qgc3RhcnQgZGF0YSB2cXMgdW50aWwgdGhlIGRl
dmljZSBbMV0uCj4KPiBUaGFua3MhCj4KPiBbMV0gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hp
dmUvaHRtbC9xZW11LWRldmVsLzIwMjMtMDEvbXNnMDI2NTIuaHRtbAoKClJpZ2h0LiBJdCBtaWdo
dCBiZSBtZW50aW9uIHRoaXMgZGVmZWN0IGluIGVpdGhlciB0aGUgY2hhbmdlIGxvZyBvciAKc29t
ZXdoZXJlIGluIHRoZSBjb2RlIGFzIGEgY29tbWVudC4KCihCdHcsIEkgdGhpbmsgd2Ugc2hvdWxk
IGZpeCB0aG9zZSB2RFBBIGRyaXZlcnMpLgoKVGhhbmtzCgoKPgo+PiBUaGFua3MKPj4KPj4KPj4+
IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+Pj4g
LS0tCj4+PiAgICBuZXQvdmhvc3QtdmRwYS5jIHwgNiArKysrKysKPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXZkcGEu
YyBiL25ldC92aG9zdC12ZHBhLmMKPj4+IGluZGV4IGJjYTEzZjk3ZmQuLjMwOTg2MWU1NmMgMTAw
NjQ0Cj4+PiAtLS0gYS9uZXQvdmhvc3QtdmRwYS5jCj4+PiArKysgYi9uZXQvdmhvc3QtdmRwYS5j
Cj4+PiBAQCAtOTU1LDExICs5NTUsMTcgQEAgaW50IG5ldF9pbml0X3Zob3N0X3ZkcGEoY29uc3Qg
TmV0ZGV2ICpuZXRkZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4+PiAgICAgICAgfQo+Pj4KPj4+ICAg
ICAgICBpZiAoaGFzX2N2cSkgewo+Pj4gKyAgICAgICAgVmhvc3RWRFBBU3RhdGUgKnM7Cj4+PiAr
Cj4+PiAgICAgICAgICAgIG5jID0gbmV0X3Zob3N0X3ZkcGFfaW5pdChwZWVyLCBUWVBFX1ZIT1NU
X1ZEUEEsIG5hbWUsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZHBh
X2RldmljZV9mZCwgaSwgMSwgZmFsc2UsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBvcHRzLT54X3N2cSwgaW92YV9yYW5nZSk7Cj4+PiAgICAgICAgICAgIGlmICghbmMp
Cj4+PiAgICAgICAgICAgICAgICBnb3RvIGVycjsKPj4+ICsKPj4+ICsgICAgICAgIHMgPSBET19V
UENBU1QoVmhvc3RWRFBBU3RhdGUsIG5jLCBuYyk7Cj4+PiArICAgICAgICBlcnJvcl9zZXRnKCZz
LT52aG9zdF92ZHBhLmRldi0+bWlncmF0aW9uX2Jsb2NrZXIsCj4+PiArICAgICAgICAgICAgICAg
ICAgICJuZXQgdmRwYSBjYW5ub3QgbWlncmF0ZSB3aXRoIE1RIGZlYXR1cmUiKTsKPj4+ICAgICAg
ICB9Cj4+Pgo+Pj4gICAgICAgIHJldHVybiAwOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
