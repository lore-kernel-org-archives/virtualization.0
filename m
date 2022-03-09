Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3F8C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 07:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E58840147;
	Wed,  9 Mar 2022 07:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZA5YIXi3G6Lw; Wed,  9 Mar 2022 07:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E24CD4002B;
	Wed,  9 Mar 2022 07:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A95C001D;
	Wed,  9 Mar 2022 07:30:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 690A2C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 420AA40147
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3rTLolPLgLK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:30:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0C4B4002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646811047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdIMgO+vW+ACu+cUR3GEWxDDEWwgLBRVaOHcVnSPSVs=;
 b=i2g55pJ4IAcMjx4EzZeR4qkIgLwKfbMLCPCGPgThYmexlAb05D+nyL36X0OQJeLtry+RUM
 W/WBK/QPLKozHpoG//8EquD0L6Fv4OF+ClI9pXyw4gCRdawQaO5wEou8HtDd31PrPBWOFS
 LeFD2Gtg9tK6T4z3jwc999AnpDQvLn4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-OB-l2YKLPvmYGzG8DHuM2Q-1; Wed, 09 Mar 2022 02:30:46 -0500
X-MC-Unique: OB-l2YKLPvmYGzG8DHuM2Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 x15-20020a5d6b4f000000b001ee6c0aa287so438422wrw.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 23:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BdIMgO+vW+ACu+cUR3GEWxDDEWwgLBRVaOHcVnSPSVs=;
 b=Mv3O9Hgw9Zs4qSeGgPgn0ZiYHWBmjOCeRc1XpjmYefGFPqWH6tCMcaAaIsAWM32yZO
 TQ83FwwqNu7I3DRSoQ0BfoxPWe5QXO2X4A9X8hHTU3FkTF37sQJjqUs25rEE+pr3tsrH
 LU4dZkUfO4EOtLx5RWARXJ9ji06E2SOOQEeY9KjrUzw+0GJ5oKgVRbwnmrWNJLV5gbrn
 3QoGajhrwfF5kLmQcNwuOlApi5c/2qFqiK4QWJbyYbB5Sxmk3RKjfwnzJ4B4xhxBazs5
 /j60W9bOmYe7Ni4UYzI859Xb4Kl6z9CnTIP99pDaqHSHpykJyQhM3Nt3nPMPXlFiui4H
 e+Nw==
X-Gm-Message-State: AOAM5330u0EYUSqDlhK9ZscZCdX932rPI5qqngiqJ0NBa8qUW2LFk4L3
 htxRhEB+vD6Lt8gWdFTHOIMnQwOU4eqHxbyrBAvZ2cErvfD23aalUZI16uiuc1WTb/2NIjMNDMz
 kLYGFWyPMXbYcdZG8dP+PCGjWd+SGODbdsAAyjhsrNQ==
X-Received: by 2002:a5d:49c9:0:b0:1f0:16b2:584f with SMTP id
 t9-20020a5d49c9000000b001f016b2584fmr14912281wrs.710.1646811045088; 
 Tue, 08 Mar 2022 23:30:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnotz408aC23A9IZAD87LSAQWy359msZHiQrQ7WqskF3fUEstezB9Epmp0u54T+VlgDtCoow==
X-Received: by 2002:a5d:49c9:0:b0:1f0:16b2:584f with SMTP id
 t9-20020a5d49c9000000b001f016b2584fmr14912264wrs.710.1646811044873; 
 Tue, 08 Mar 2022 23:30:44 -0800 (PST)
Received: from redhat.com ([2.55.46.250]) by smtp.gmail.com with ESMTPSA id
 f13-20020adff8cd000000b001f03439743fsm877350wrq.75.2022.03.08.23.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 23:30:43 -0800 (PST)
Date: Wed, 9 Mar 2022 02:30:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v5 00/15] vDPA shadow virtqueue
Message-ID: <20220309023020-mutt-send-email-mst@kernel.org>
References: <20220308020348-mutt-send-email-mst@kernel.org>
 <CACGkMEvY-+XpPWbtiX9dy+fwDxPp7sHFhH_LY0PB2YuusEugyw@mail.gmail.com>
 <20220308022300-mutt-send-email-mst@kernel.org>
 <CACGkMEvuTPCRk7Ng7CbgpPSPgs_QYijzc5fU+cV3kW09W1R7Qg@mail.gmail.com>
 <20220308024724-mutt-send-email-mst@kernel.org>
 <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
 <20220308054623-mutt-send-email-mst@kernel.org>
 <CAJaqyWcuitG+01pjO__tYERN9910fL_JGiHG88xU=fTG3KmpJw@mail.gmail.com>
 <20220308071253-mutt-send-email-mst@kernel.org>
 <56b837a6-c67d-5ffc-bd70-ba51d996a6c2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56b837a6-c67d-5ffc-bd70-ba51d996a6c2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Lingshan <lingshan.zhu@intel.com>
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

T24gV2VkLCBNYXIgMDksIDIwMjIgYXQgMTE6Mzg6MzVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi8zLzgg5LiL5Y2IODoxNiwgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiA+IE9uIFR1ZSwgTWFyIDA4LCAyMDIyIGF0IDEyOjM3OjMzUE0gKzAxMDAsIEV1Z2VuaW8g
UGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiBPbiBUdWUsIE1hciA4LCAyMDIyIGF0IDExOjQ4IEFN
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFR1
ZSwgTWFyIDA4LCAyMDIyIGF0IDA0OjIwOjUzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4g
PiA+ID4gPiA+IE5vdCBieSBpdHNlbGYgYnV0IEknbSBub3Qgc3VyZSB3ZSBjYW4gZ3VhcmFudGVl
IGd1ZXN0IHdpbGwgbm90Cj4gPiA+ID4gPiA+IGF0dGVtcHQgdG8gdXNlIHRoZSBJT1ZBIGFkZHJl
c3NlcyB3ZSBhcmUgcmVzZXJ2aW5nIGRvd24KPiA+ID4gPiA+ID4gdGhlIHJvYWQuCj4gPiA+ID4g
PiBUaGUgSU9WQSBpcyBhbGxvY2F0ZWQgdmlhIHRoZSBsaXN0ZW5lcnMgYW5kIHN0b3JlZCBpbiB0
aGUgaW92YSB0cmVlCj4gPiA+ID4gPiBwZXIgR1BBIHJhbmdlIGFzIElPVkEtPihHUEEpLT5IVkEu
R3Vlc3RzIHdpbGwgb25seSBzZWUgR1BBLCBRZW11Cj4gPiA+ID4gPiB2aXJ0aW8gY29yZSBzZWUg
R1BBIHRvIEhWQSBtYXBwaW5nLiBBbmQgd2UgZG8gYSByZXZlcnNlIGxvb2t1cCB0byBmaW5kCj4g
PiA+ID4gPiB0aGUgSFZBLT5JT1ZBIHdlIGFsbG9jYXRlZCBwcmV2aW91c2x5LiAgU28gd2UgaGF2
ZSBkb3VibGUgY2hlY2sgaGVyZToKPiA+ID4gPiA+IAo+ID4gPiA+ID4gMSkgUWVtdSBtZW1vcnkg
Y29yZSB0byBtYWtlIHN1cmUgdGhlIEdQQSB0aGF0IGd1ZXN0IHVzZXMgaXMgdmFsaWQKPiA+ID4g
PiA+IDIpIHRoZSBJT1ZBIHRyZWUgdGhhdCBndWFyYW50ZWVzIHRoZXJlIHdpbGwgYmUgbm8gSFZB
IGJleW9uZCB3aGF0Cj4gPiA+ID4gPiBndWVzdCBjYW4gc2VlIGlzIHVzZWQKPiA+ID4gPiA+IAo+
ID4gPiA+ID4gU28gdGVjaG5pY2FsbHksIHRoZXJlJ3Mgbm8gd2F5IGZvciB0aGUgZ3Vlc3QgdG8g
dXNlIHRoZSBJT1ZBIGFkZHJlc3MKPiA+ID4gPiA+IGFsbG9jYXRlZCBmb3IgdGhlIHNoYWRvdyB2
aXJ0cXVldWUuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+IEkgbWVhbiwgSU9W
QSBpcyBwcm9ncmFtbWVkIGluIHRoZSBob3N0IGhhcmR3YXJlIHRvIHRyYW5zbGF0ZSB0byBIUEEs
IHJpZ2h0Pwo+ID4gPiA+IAo+ID4gPiBZZXMsIHRoYXQncyByaWdodCBpZiB0aGUgZGV2aWNlIHVz
ZXMgcGh5c2ljYWwgbWFwcy4gQWxzbyB0byBub3RlLCBTVlEKPiA+ID4gdnJpbmcgaXMgYWxsb2Nh
dGVkIGluIG11bHRpcGxlcyBvZiBob3N0IGh1Z2UgcGFnZXMgdG8gYXZvaWQgZ2FyYmFnZSBvcgo+
ID4gPiB1bmludGVuZGVkIGFjY2VzcyBmcm9tIHRoZSBkZXZpY2UuCj4gPiA+IAo+ID4gPiBJZiBh
IHZkcGEgZGV2aWNlIHVzZXMgcGh5c2ljYWwgYWRkcmVzc2VzLCBrZXJuZWwgdmRwYSB3aWxsIHBp
biBxZW11Cj4gPiA+IG1lbW9yeSBmaXJzdCBhbmQgdGhlbiB3aWxsIHNlbmQgSU9WQSB0byBIUEEg
dHJhbnNsYXRpb24gdG8gaGFyZHdhcmUuCj4gPiA+IEJ1dCB0aGlzIElPVkEgc3BhY2UgaXMgbm90
IGNvbnRyb2xsZWQgYnkgdGhlIGd1ZXN0LCBidXQgYnkgU1ZRLiBJZiBhCj4gPiA+IGd1ZXN0J3Mg
dmlydHF1ZXVlIGJ1ZmZlciBjYW5ub3QgYmUgdHJhbnNsYXRlZCBmaXJzdCB0byBHUEEsIGl0IHdp
bGwKPiA+ID4gbm90IGJlIGZvcndhcmRlZC4KPiA+ID4gCj4gPiA+IFRoYW5rcyEKPiA+IFJpZ2h0
LiBTbyBpZiBndWVzdHMgc2VuZCBhIGJ1ZmZlciB3aGVyZSBidWZmZXIgYWRkcmVzcyBvdmVybGFw
cyB0aGUKPiA+IHJhbmdlIHdlIHVzZWQgZm9yIHRoZSBTVlEsIHRoZW4gSSB0aGluayBhdCB0aGUg
bW9tZW50IGd1ZXN0IHdvbid0IHdvcmsuCj4gCj4gCj4gVGhlcmUncyBubyB3YXkgZm9yIGEgZ3Vl
c3QgdG8gZG8gdGhpcywgaXQgY2FuIG9ubHkgdXNlIEdQQQoKV2l0aCBhIHZJT01NVSBpdCBjYW4u
Cgo+IGJ1dCB0aGUgUWVtdQo+IHdvbid0IGxldCB2RFBBIHRvIHVzZSBHUEEgYXMgSU9WQS4gRGVk
aWNhdGVkIElPVkEgcmFuZ2VzIHdlcmUgYWxsb2NhdGVkIGZvcgo+IHRob3NlIEdQQSByYW5nZXMg
c28gU1ZRIHdvbid0IHVzZSBJT1ZBIHRoYXQgaXMgb3ZlcmxhcHBlZCB3aXRoIHdoYXQgR3Vlc3QK
PiB1c2UuCj4gCj4gVGhhbmtzCj4gCj4gCj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
