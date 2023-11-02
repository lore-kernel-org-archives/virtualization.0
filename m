Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B160FC4332F
	for <virtualization@archiver.kernel.org>; Thu,  2 Nov 2023 10:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4101570636;
	Thu,  2 Nov 2023 10:02:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4101570636
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TPuluYLg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGcjqF9VcDbh; Thu,  2 Nov 2023 10:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 74E5D60F66;
	Thu,  2 Nov 2023 10:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74E5D60F66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 482C1C0039;
	Thu,  2 Nov 2023 10:02:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6C6EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 10:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8608142D57
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 10:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8608142D57
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TPuluYLg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ELyILKmFSuYS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 10:02:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78B6342D9E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Nov 2023 10:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78B6342D9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698919329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQZaCcbNvR/vRwvT++3FkZXUSfW2tFLkbmwPh6CE5mI=;
 b=TPuluYLg1B6RYighJ5sUG5s1TExDJ730Gfw/dKHyYhYM7SEqh/cVBJ5IodgJtCEx2iN91t
 0uk3XVbDao/xyHnxBk4gV7JbIqz6O9TNLvrZ7cMsxvxh+WGGl/gQyfHM1BiIO2QQwerFnV
 4qteCLo1P/VN1UE6Tv/P/08PliXmfT8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-vvhcQIiLOMyYneFyplBlXw-1; Thu, 02 Nov 2023 06:02:07 -0400
X-MC-Unique: vvhcQIiLOMyYneFyplBlXw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079630993dso600213e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Nov 2023 03:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919326; x=1699524126;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQZaCcbNvR/vRwvT++3FkZXUSfW2tFLkbmwPh6CE5mI=;
 b=tkAhFIGrYGPzH5DPdowWqtNTKgdFogASWqgsDy4raicRdHisIKxFF172+eqRUtPF59
 FEkfPVotmQIL6Swk1KnZmweTO5f25fYJ+ulDsWe0xfg3j/NCGzP+7jAxqBjNQXU86L0y
 owPx17GrP97Z219YiSvoL51qxBNK+4kiaVFUMIEImd2JJ8UchwAhuEVg7lsu1YxQgNWC
 VCX3GUZy2LJVvZjw02KTDAGBvmQCpb/hbIDt+IqL+abY9BfDlARzA6F678ySKg3xJf9e
 hhmA7RjMoVLV5n7t3BtkQ42Y8zbHWJ/zreh79JR47zskBJ6G2oxYRcmhZhFfvBo3j4rI
 qNLg==
X-Gm-Message-State: AOJu0YxY+XqLY1O3F2WGTrEGQ4Ng2WDwaa+v1xrgvas7bLOeVWXDDyqr
 5fpNN8LTmPPozFYUdRpv03SBsxAfL76tSMEQDmG9AoV4AGqfWcdUJsYo1b9/PNhZbcEZ2/XlR0i
 IUvuFJ6m2ygUurPuljXYfurCoJfi+c7VAUPzHRtlpXw==
X-Received: by 2002:ac2:47fa:0:b0:506:899d:1994 with SMTP id
 b26-20020ac247fa000000b00506899d1994mr12240665lfp.52.1698919326296; 
 Thu, 02 Nov 2023 03:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgzRDP6IedPcxWzyU82zbL27uQuZvFZAmfFO8532rjHoXbxjyP/bbnF/jAQjaUjhe/+z5K+Q==
X-Received: by 2002:ac2:47fa:0:b0:506:899d:1994 with SMTP id
 b26-20020ac247fa000000b00506899d1994mr12240648lfp.52.1698919325964; 
 Thu, 02 Nov 2023 03:02:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adff7d0000000b0032dbf99bf4fsm1812242wrq.89.2023.11.02.03.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:02:05 -0700 (PDT)
Date: Thu, 2 Nov 2023 06:02:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231102060151-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com
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

T24gVGh1LCBPY3QgMjYsIDIwMjMgYXQgMDI6NDg6MDdQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6
Cj4gT24gVGh1LCBPY3QgMjYsIDIwMjMgYXQgMjo0MuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDAx
OjA1OjMzQU0gKzA4MDAsIENpbmR5IEx1IHdyb3RlOgo+ID4gPiBIaSBBbGwKPiA+ID4gUmVhbGx5
IGFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5LCB0aGlzIGlzIHRoZSBkcmFmdCBSRkMgZm9yCj4gPiA+
IGlvbW11ZmQgc3VwcG9ydCBmb3IgdmRwYSwgVGhpcyBjb2RlIHByb3ZpZGVzIHRoZSBiYXNpYyBm
dW5jdGlvbgo+ID4gPiBmb3IgaW9tbXVmZCBzdXBwb3J0Cj4gPiA+Cj4gPiA+IFRoZSBjb2RlIHdh
cyB0ZXN0ZWQgYW5kIHBhc3NlZCBpbiBkZXZpY2UgdmRwYV9zaW1fbmV0Cj4gPiA+IFRoZSBxZW11
IGNvZGUgaXMKPiA+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2x1bHU2L2dpdGxhYnFlbXV0bXAvLS90
cmVlL2lvbW11ZmRSRkMKPiA+ID4gVGhlIGtlcm5lbCBjb2RlIGlzCj4gPiA+IGh0dHBzOi8vZ2l0
bGFiLmNvbS9sdWx1Ni92aG9zdC8tL3RyZWUvaW9tbXVmZFJGQwo+ID4gPgo+ID4gPiBUb0RvCj4g
PiA+IDEuIHRoaXMgY29kZSBpcyBvdXQgb2YgZGF0ZSBhbmQgbmVlZHMgdG8gY2xlYW4gYW5kIHJl
YmFzZSBvbiB0aGUgbGF0ZXN0IGNvZGUKPiA+ID4gMi4gdGhpcyBjb2RlIGhhcyBzb21lIHdvcmth
cm91bmQsIEkgU2tpcCB0aGUgY2hlY2sgZm9yCj4gPiA+IGlvbW11X2dyb3VwIGFuZCBDQUNIRV9D
T0hFUkVOQ1ksIGFsc28gc29tZSBtaXNjIGlzc3VlcyBsaWtlIG5lZWQgdG8gYWRkCj4gPiA+IG11
dGV4IGZvciBpb21tZmQgb3BlcmF0aW9ucwo+ID4gPiAzLiBvbmx5IHRlc3QgaW4gZW11bGF0ZWQg
ZGV2aWNlLCBvdGhlciBtb2RlcyBub3QgdGVzdGVkIHlldAo+ID4gPgo+ID4gPiBBZnRlciBhZGRy
ZXNzZWQgdGhlc2UgcHJvYmxlbXMgSSB3aWxsIHNlbmQgb3V0IGEgbmV3IHZlcnNpb24gZm9yIFJG
Qy4gSSB3aWxsCj4gPiA+IHByb3ZpZGUgdGhlIGNvZGUgaW4gMyB3ZWVrcwo+ID4KPiA+IFdoYXQn
cyB0aGUgc3RhdHVzIGhlcmU/Cj4gPgo+IEhpIE1pY2hhZWwKPiBUaGUgY29kZSBpcyBmaW5pc2hl
ZCwgYnV0IEkgZm91bmQgc29tZSBidWcgYWZ0ZXIgYWRkaW5nIHRoZSBzdXBwb3J0IGZvciBBU0lE
LAo+IHdpbGwgcG9zdCB0aGUgbmV3IHZlcnNpb24gYWZ0ZXIgdGhpcyBidWcgaXMgZml4ZWQsIHNo
b3VsZCBiZSBuZXh0IHdlZWsKPiBUaGFua3MKPiBDaW5keQoKVGhlIHdlZWsgaXMgYWxtb3N0IGdv
bmUsIHdoYXQncyBnb2luZyBvbj8KCgo+ID4gLS0KPiA+IE1TVAo+ID4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
