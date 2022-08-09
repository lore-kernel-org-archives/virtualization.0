Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA24AC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 22:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33F63408F0;
	Tue,  9 Aug 2022 22:37:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33F63408F0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYnOKwdu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xpIBCQdryWf; Tue,  9 Aug 2022 22:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DAAA4091E;
	Tue,  9 Aug 2022 22:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DAAA4091E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD18C0033;
	Tue,  9 Aug 2022 22:37:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB3AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD968818D0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD968818D0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYnOKwdu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FnzB062P_VGI
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC00C81551
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC00C81551
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660084646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+wQeleuodMST3oQC0LtED302AnhB/n8k1/IPN1hDEM=;
 b=HYnOKwduRu74VYRdswuCfaJexpvziA3FE4MFIxjQ34mQHxD7+X8c7EhoCGhA8fNHcr9wZG
 DF9i83FVnxHxiCErDfi+DkCdOwdJ6oEyyRsfDobn6ZkGncV6aCw+AX/IlQ+imVzKQYBJjv
 NPUux/lZSiUiGwS8oMd10nrVzzyTbtw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-GJdPnFS_MLiJ-7vBBsSabQ-1; Tue, 09 Aug 2022 18:37:25 -0400
X-MC-Unique: GJdPnFS_MLiJ-7vBBsSabQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 w5-20020a05640234c500b0043dda025648so8025441edc.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 15:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=4+wQeleuodMST3oQC0LtED302AnhB/n8k1/IPN1hDEM=;
 b=F5ut1REQBDhF7u49+3mnyCNNgqhZoyi5Li7XovEh+ZymAGkIT6JQxV+FIVrTBspeSC
 J73c/742ytTuz+OXHOhDveqKdfIqrVdniWtNe1SPIjnRZhI7shFdxo7xKmDWTQwzltJo
 lnffCPv5UQZcRwFzQCnczRMPrb9w7g7itZvY8QtTuiuoZICBK0xLv0gerVx2Op7MFk7r
 +sf05Y4H4ccSFCs97pCuLN0sdms6BLSZn5ws2xKUb+5OfaBXQKcyCW1qzDPVLd83REqZ
 Tm3MSQdx4FJ8hOQLI+MLflEYz0k1pRljkITKOGNZqwOfPjskgO+CFHU8hr4dGxXhFVTk
 XiDQ==
X-Gm-Message-State: ACgBeo0CZwaWNxb6Kb0fuHYZFeAkGoxsXESjuSN4ruZ1c4mUfxZXSbFR
 VEZmCyWP5XBVYLoL8QFUBpgm92iP+jLWl5cuodMYkeuuxGpzbuH6PtA1z4z9YSt24mdHHlF1rBU
 Tq6nGahzrG4WhT0MhxdR8hyHgqBHlZU3yt02W6F/vEw==
X-Received: by 2002:a17:907:6eaa:b0:730:cae8:3088 with SMTP id
 sh42-20020a1709076eaa00b00730cae83088mr19299516ejc.27.1660084644321; 
 Tue, 09 Aug 2022 15:37:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4hCHEkheFPKqjV2UVHS+6nWL7duGST86gwUmNBNsyeaVgdI1lwfjXBbf/QreS0eNuh2xr9Jg==
X-Received: by 2002:a17:907:6eaa:b0:730:cae8:3088 with SMTP id
 sh42-20020a1709076eaa00b00730cae83088mr19299496ejc.27.1660084644081; 
 Tue, 09 Aug 2022 15:37:24 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 y25-20020a170906471900b0072fa24c2ecbsm1602332ejq.94.2022.08.09.15.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 15:37:23 -0700 (PDT)
Date: Tue, 9 Aug 2022 18:37:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809183516-mutt-send-email-mst@kernel.org>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
MIME-Version: 1.0
In-Reply-To: <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

T24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDM6MzI6MjZQTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiA4LzkvMjAyMiAyOjM3IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBUdWUsIEF1ZyAwOSwgMjAyMiBhdCAwNzoxODozMFBNICswMDAwLCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4gPiA+ID4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
Pgo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDM6MDkgUE0KPiA+ID4gPiA+
ID4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gPiA+ID4gPiBT
ZW50OiBUdWVzZGF5LCBBdWd1c3QgOSwgMjAyMiAyOjM5IFBNIEN1cnJlbnRseSBpdCBpcyBub3Qu
IE5vdCBhCj4gPiA+ID4gPiA+IHNpbmdsZSBwYXRjaCBub3IgdGhpcyBwYXRjaCwgYnV0IHRoZSBj
b250ZXh0IGZvciB0aGUgZXZlbnR1YWwgZ29hbCBpcwo+ID4gPiA+ID4gPiB0byBhbGxvdyBYRFAg
b24gYSBNVFU9OTAwMCBsaW5rIHdoZW4gZ3Vlc3QgdXNlcnMgaW50ZW50aW9uYWxseSBsb3dlcgo+
ID4gPiA+ID4gPiBkb3duIE1UVSB0byAxNTAwLgo+ID4gPiA+ID4gV2hpY2ggYXBwbGljYXRpb24g
YmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0byAxNTAwCj4gPiA+
ID4gdG8gc2VuZCBwYWNrZXRzIGJ1dCB3YW50IHRvIHJlY2VpdmUgOUsgcGFja2V0cz8KPiA+ID4g
QmVsb3cgZGV0YWlscyBkb2VzbuKAmXQgYW5zd2VyIHRoZSBxdWVzdGlvbiBvZiBhc3ltbWV0cnku
IDopCj4gPiA+IAo+ID4gPiA+IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZm
ZXJlbnRpYXRlIE1UVSBhbmQgTVJVLCBpbiB3aGljaCBjYXNlCj4gPiA+ID4gdGhlIHJlY2VpdmUg
YnVmZmVyIHdpbGwgYmUgcmVkdWNlZCB0byBmaXQgdGhlIDE1MDBCIHBheWxvYWQgc2l6ZSB3aGVu
IG10dSBpcwo+ID4gPiA+IGxvd2VyZWQgZG93biB0byAxNTAwIGZyb20gOTAwMC4KPiA+ID4gSG93
PyBEcml2ZXIgcmVkdWNlZCB0aGUgbVh1IHRvIDE1MDAsIHNheSBpdCBpcyBpbXByb3ZlZCB0byBw
b3N0IGJ1ZmZlcnMgb2YgMTUwMCBieXRlcy4KPiA+ID4gCj4gPiA+IERldmljZSBkb2Vzbid0IGtu
b3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNwYWNlIGlzIFJPIGZpZWxkLgo+ID4g
PiBEZXZpY2Uga2VlcCBkcm9wcGluZyA5SyBwYWNrZXRzIGJlY2F1c2UgYnVmZmVycyBwb3N0ZWQg
YXJlIDE1MDAgYnl0ZXMuCj4gPiA+IFRoaXMgaXMgYmVjYXVzZSBkZXZpY2UgZm9sbG93cyB0aGUg
c3BlYyAiIFRoZSBkZXZpY2UgTVVTVCBOT1QgcGFzcyByZWNlaXZlZCBwYWNrZXRzIHRoYXQgZXhj
ZWVkIG10dSIuCj4gPiAKPiA+IFRoZSAibXR1IiBoZXJlIGlzIHRoZSBkZXZpY2UgY29uZmlnIGZp
ZWxkLCB3aGljaCBpcwo+ID4gCj4gPiAgICAgICAgICAvKiBEZWZhdWx0IG1heGltdW0gdHJhbnNt
aXQgdW5pdCBhZHZpY2UgKi8KPiA+IAo+ID4gdGhlcmUgaXMgbm8gZ3VhcmFudGVlIGRldmljZSB3
aWxsIG5vdCBnZXQgYSBiaWdnZXIgcGFja2V0Lgo+ID4gQW5kIHRoZXJlIGlzIG5vIGd1YXJhbnRl
ZSBzdWNoIGEgcGFja2V0IHdpbGwgYmUgZHJvcHBlZAo+ID4gYXMgb3Bwb3NlZCB0byB3ZWRnaW5n
IHRoZSBkZXZpY2UgaWYgdXNlcnNwYWNlIGluc2lzdHMgb24KPiA+IGFkZGluZyBzbWFsbGVyIGJ1
ZmZlcnMuCj4gSXQnZCBiZSBuaWNlIHRvIGRvY3VtZW50IHRoaXMgcmVxdWlyZW1lbnQgb3Igc3Rh
dGVtZW50IHRvIHRoZSBzcGVjIGZvcgo+IGNsYXJpdHkgcHVycG9zZS4KCkl0J3Mgbm90IGEgcmVx
dWlyZW1lbnQsIG1vcmUgb2YgYSBidWcuIEJ1dCBpdCdzIGJlZW4gbGlrZSB0aGlzIGZvcgp5ZWFy
cy4KCj4gT3RoZXJ3aXNlIHZhcmlvdXMgZGV2aWNlIGltcGxlbWVudGF0aW9ucyBhcmUgaGFyZCB0
bwo+IGZvbGxvdy4gVGhlIGNhcHR1cmUgaXMgdGhhdCB2aG9zdC1uZXQgZHJvcHMgYmlnZ2VyIHBh
Y2tldHMgd2hpbGUgdGhlIGRyaXZlcgo+IG9ubHkgc3VwcGxpZWQgc21hbGxlciBidWZmZXJzLiBU
aGlzIGlzIHRoZSBzdGF0dXMgcXVvLCBhbmQgdXNlcnMgc2VlbWluZ2x5Cj4gaGF2ZSByZWxpZWQg
b24gdGhpcyBiZWhhdmlvciBmb3Igc29tZSB3aGlsZS4KPiAKPiAtU2l3ZWkKCldlaXJkIHdoZXJl
IGRvIHlvdSBzZWUgdGhpcyBpbiBjb2RlPyBJIHNlZQoKICAgICAgICAgICAgICAgIHNvY2tfbGVu
ID0gdmhvc3RfbmV0X3J4X3BlZWtfaGVhZF9sZW4obmV0LCBzb2NrLT5zaywKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmJ1c3lsb29wX2ludHIp
OwogICAgICAgICAgICAgICAgaWYgKCFzb2NrX2xlbikKICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7CiAgICAgICAgICAgICAgICBzb2NrX2xlbiArPSBzb2NrX2hsZW47CiAgICAgICAgICAg
ICAgICB2aG9zdF9sZW4gPSBzb2NrX2xlbiArIHZob3N0X2hsZW47CiAgICAgICAgICAgICAgICBo
ZWFkY291bnQgPSBnZXRfcnhfYnVmcyh2cSwgdnEtPmhlYWRzICsgbnZxLT5kb25lX2lkeCwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZob3N0X2xlbiwgJmluLCB2cV9s
b2csICZsb2csCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWtlbHko
bWVyZ2VhYmxlKSA/IFVJT19NQVhJT1YgOiAxKTsKICAgICAgICAgICAgICAgIC8qIE9uIGVycm9y
LCBzdG9wIGhhbmRsaW5nIHVudGlsIHRoZSBuZXh0IGtpY2suICovCiAgICAgICAgICAgICAgICBp
ZiAodW5saWtlbHkoaGVhZGNvdW50IDwgMCkpCiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
b3V0OwoKCnNvIGl0IGRvZXMgbm90IGRyb3AgYSBwYWNrZXQsIGl0IGp1c3Qgc3RvcHMgcHJvY2Vz
c2luZyB0aGUgcXVldWUuCgoKCj4gPiAKPiA+IAo+ID4gPiBTbywgSSBhbSBsb3N0IHdoYXQgdmly
dGlvIG5ldCBkZXZpY2UgdXNlciBhcHBsaWNhdGlvbiBpcyB0cnlpbmcgdG8gYWNoaWV2ZSBieSBz
ZW5kaW5nIHNtYWxsZXIgcGFja2V0cyBhbmQgZHJvcHBpbmcgYWxsIHJlY2VpdmUgcGFja2V0cy4K
PiA+ID4gKGl0IGRvZXNu4oCZdCBoYXZlIGFueSByZWxhdGlvbiB0byBtZXJnZWFibGUgb3Igb3Ro
ZXJ3aXNlKS4KPiA+IAo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiBUbyB1bnN1YnNjcmliZSwgZS1tYWls
OiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJlQGxpc3RzLm9hc2lzLW9wZW4ub3JnCj4gPiBGb3IgYWRk
aXRpb25hbCBjb21tYW5kcywgZS1tYWlsOiB2aXJ0aW8tZGV2LWhlbHBAbGlzdHMub2FzaXMtb3Bl
bi5vcmcKPiA+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
