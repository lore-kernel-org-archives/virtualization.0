Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992A1C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:12:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B48064E79
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 07:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B48064E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5AEB83C74;
	Wed, 24 Feb 2021 07:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4RAWSmxv4fb; Wed, 24 Feb 2021 07:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01C6283C02;
	Wed, 24 Feb 2021 07:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9DAC000B;
	Wed, 24 Feb 2021 07:12:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA9E4C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C903E606AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ol1nvsMPzhRi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:12:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF5AF6065C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614150729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5urpx7+14Nbuik1VeRNoEiZMhIyaDIyvE6g+cvtgSs=;
 b=MYCX9OmQswbn/zXLXzvNS9mUSOV3wdIi0YCtQi+GvtsqvuKWO9smzOCEUN+Z0wxSCkhf/v
 gzgIYIIgBNzggOVqoW3XDr2gN9fs7+YWOnYoAgirGvjTKfd8kMxpyK453q2INhMVanLkI6
 pAa0P8mCXZpeXsLodvYet3mRx19TIF0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-4bVzP5SXM5WcogAHdKIX5w-1; Wed, 24 Feb 2021 02:12:05 -0500
X-MC-Unique: 4bVzP5SXM5WcogAHdKIX5w-1
Received: by mail-wm1-f69.google.com with SMTP id j204so176498wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 23:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=s5urpx7+14Nbuik1VeRNoEiZMhIyaDIyvE6g+cvtgSs=;
 b=nHvmVBBhSn+3Yev/4pExnv0lI/OxGQH4S7kn/TWsv2sS4qvgmGc92LVJhyRsyTeH5m
 fKJWkRUNMQro05MPYie/KIicWcdnSjotDKnsNXKrHIsKelp7CBU3NcGcnhfwIW0iyAVC
 8mHG6ICmVSqzNAPEwql81IrlbzlV9BKZmy/6rn+LN3XEPheJXn9jvXwWODfvmo6c/pct
 XUf/E+xY9uyJNmTm3zRcyvnYnoBQpmjwnE8OCfnOPnzLg9QHvicbm+u0hREZ+yqihDuv
 6SkZwAh84DIe97RZiD2A4rz6zG+HC8L3x89dLxIbCl2k2YCR2ciU3Hat+5zQWCk48TEW
 x/tg==
X-Gm-Message-State: AOAM530+qUInM56E9583ADO8VACW45ucRaV+8s95BY2lIXSD4RDhqvm2
 IOBrXyLdw2F/OBIn2xUrWDAiF98q39zc5vwFEZ9DS739qo/oaVWx7p+Dn2MBPwCnl5rkwzCHAyh
 OjGUJqf96i/QeMPgv0i1n3dJfZ5dp3CeFCwlxylnQcQ==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr2340658wma.22.1614150724365; 
 Tue, 23 Feb 2021 23:12:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwadgw2sbmpJNGXYqDbem1Ufvnw+j0n4YzrCFoLPNbR6eiG3H/7UMUwjHA8tQWn5GnaAdb2QA==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr2340640wma.22.1614150724189; 
 Tue, 23 Feb 2021 23:12:04 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id p12sm1269626wmq.1.2021.02.23.23.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 23:12:03 -0800 (PST)
Date: Wed, 24 Feb 2021 02:12:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224021054-mutt-send-email-mst@kernel.org>
References: <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
 <20210224000528-mutt-send-email-mst@kernel.org>
 <20210224064520.GA204317@mtl-vdi-166.wap.labs.mlnx>
 <20210224014700-mutt-send-email-mst@kernel.org>
 <ef775724-b5fb-ca70-ed2f-f23d8fbf4cd8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ef775724-b5fb-ca70-ed2f-f23d8fbf4cd8@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMDI6NTU6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjQgMjo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDA4OjQ1OjIwQU0gKzAyMDAsIEVsaSBDb2hl
biB3cm90ZToKPiA+ID4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTI6MTc6NThBTSAtMDUwMCwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0
IDExOjIwOjAxQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBPbiAyMDIxLzIv
MjQgMzozNSDkuIrljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiBPbiAyLzIzLzIwMjEgNToyNiBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+
ID4gPiA+IE9uIFR1ZSwgRmViIDIzLCAyMDIxIGF0IDEwOjAzOjU3QU0gKzA4MDAsIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBPbiAyMDIxLzIvMjMgOToxMiDkuIrljYgsIFNpLVdl
aSBMaXUgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIDIvMjEvMjAyMSAxMTozNCBQTSwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgRmViIDIy
LCAyMDIxIGF0IDEyOjE0OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBPbiAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1
cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZm9yIGxl
Z2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFj
Y2Vzc2VkIGJlZm9yZSBmZWF0dXJlcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhcmUgc2V0LiBX
ZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNldCB0byAwIGZvciB0aGlzIGNh
c2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJdCdz
IHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNl
dC4gRm9yIGluc3RhbmNlLCB3aGVuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmUgVklS
VElPX05FVF9GX01UVSBpcyBhZHZlcnRpc2VkIHNvbWUgbW9kZXJuIGRyaXZlcgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJl
c2VudCBpbiB0aGUgY29uZmlnCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNwYWNlIGJlZm9yZSB2
aXJ0aW8gZmVhdHVyZXMgYXJlIHNldC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgbG9va3Mg
bGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiAiCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkgZXhpc3RzIGlm
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTVRVIGlzCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBzZXQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0
aGUgbWF4aW11bSBNVFUgZm9yIHRoZSBkcml2ZXIgdG8gdXNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gIgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBEbyB3ZSBy
ZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+ID4gPiA+IEFuZCBhbHNvOgo+
ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSBkcml2ZXIgTVVTVCBm
b2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+ID4gPiA+ID4gPiA+
ID4gPiA+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gMi4gU2V0IHRo
ZSBBQ0tOT1dMRURHRSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzCj4gPiA+ID4gPiA+ID4g
PiA+ID4gbm90aWNlZCB0aGUgZGV2aWNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+IDMuIFNldCB0aGUg
RFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBrbm93cyBob3cgdG8gZHJpdmUgdGhlCj4g
PiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlLgo+ID4gPiA+ID4gPiA+ID4gPiA+IDQuIFJlYWQgZGV2
aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBzdWJzZXQgb2YgZmVhdHVyZSBiaXRzCj4g
PiA+ID4gPiA+ID4gPiA+ID4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUK
PiA+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAgdGhlIGRyaXZlciBN
QVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBkZXZp
Y2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbgo+ID4gPiA+ID4gPiA+ID4gPiA+IGZpZWxkcyB0byBj
aGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBkZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBpdC4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRo
ZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldwo+ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmUg
Yml0cyBhZnRlciB0aGlzIHN0ZXAuCj4gPiA+ID4gPiA+ID4gPiA+ID4gNi4gUmUtcmVhZCBkZXZp
Y2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDoKPiA+
ID4gPiA+ID4gPiA+ID4gPiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPiA+ID4gPiA+
ID4gPiA+ID4gPiBzdXBwb3J0IG91ciBzdWJzZXQgb2YgZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2Ug
aXMgdW51c2FibGUuCj4gPiA+ID4gPiA+ID4gPiA+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lm
aWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1ZXVlcwo+ID4gPiA+ID4gPiA+
ID4gPiA+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+ID4gPiA+ID4g
PiA+ID4gPiA+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmly
dGlvIGNvbmZpZ3VyYXRpb24KPiA+ID4gPiA+ID4gPiA+ID4gPiBzcGFjZSwgYW5kIHBvcHVsYXRp
b24gb2YgdmlydHF1ZXVlcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA4LiBTZXQgdGhlIERSSVZFUl9P
SyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPiA+
ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4g
PiBzbyBhY2Nlc3NpbmcgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSyBpcyBhIHNwZWMK
PiA+ID4gPiA+ID4gPiA+ID4gPiB2aW9sYXRpb24sIHJpZ2h0Pwo+ID4gPiA+ID4gPiA+ID4gPiBJ
dCBpcywgYnV0IGl0J3Mgbm90IHJlbGV2YW50IHRvIHdoYXQgdGhpcyBjb21taXQgdHJpZXMgdG8g
YWRkcmVzcy4gSQo+ID4gPiA+ID4gPiA+ID4gPiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vlc3Qgc3Rp
bGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+ID4gSGF2aW5nIHNhaWQsIGEgc2VwYXJhdGUgcGF0Y2ggaGFzIHRvIGJlIHBvc3RlZCB0byBm
aXggdGhlIGd1ZXN0IGRyaXZlcgo+ID4gPiA+ID4gPiA+ID4gPiBpc3N1ZSB3aGVyZSB0aGlzIGRp
c2NyZXBhbmN5IGlzIGludHJvZHVjZWQgdG8KPiA+ID4gPiA+ID4gPiA+ID4gdmlydG5ldF92YWxp
ZGF0ZSgpIChzaW5jZQo+ID4gPiA+ID4gPiA+ID4gPiBjb21taXQgZmUzNmNiZTA2NykuIEJ1dCBp
dCdzIG5vdCB0ZWNobmljYWxseSByZWxhdGVkIHRvIHRoaXMgcGF0Y2guCj4gPiA+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ID4gPiAtU2l3ZWkKPiA+ID4gPiA+ID4gPiA+IEkgdGhpbmsgaXQn
cyBhIGJ1ZyB0byByZWFkIGNvbmZpZyBzcGFjZSBpbiB2YWxpZGF0ZSwgd2Ugc2hvdWxkCj4gPiA+
ID4gPiA+ID4gPiBtb3ZlIGl0IHRvCj4gPiA+ID4gPiA+ID4gPiB2aXJ0bmV0X3Byb2JlKCkuCj4g
PiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+IEkgdGFr
ZSBpdCBiYWNrLCByZWFkaW5nIGJ1dCBub3Qgd3JpdGluZyBzZWVtcyB0byBiZSBleHBsaWNpdGx5
Cj4gPiA+ID4gPiA+ID4gYWxsb3dlZCBieSBzcGVjLgo+ID4gPiA+ID4gPiA+IFNvIG91ciB3YXkg
dG8gZGV0ZWN0IGEgbGVnYWN5IGd1ZXN0IGlzIGJvZ3VzLCBuZWVkIHRvIHRoaW5rIHdoYXQgaXMK
PiA+ID4gPiA+ID4gPiB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuCj4gPiA+ID4gPiA+IFRo
ZW4gbWF5YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2Y2JlMDY3IGFuZCBmcmllbmRzLCBhbmQgaGF2ZSBR
RU1VIGRldGVjdAo+ID4gPiA+ID4gPiBsZWdhY3kgZ3Vlc3Q/IFN1cHBvc2VkbHkgb25seSBjb25m
aWcgc3BhY2Ugd3JpdGUgYWNjZXNzIG5lZWRzIHRvIGJlCj4gPiA+ID4gPiA+IGd1YXJkZWQgYmVm
b3JlIHNldHRpbmcgRkVBVFVSRVNfT0suCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEkgYWdyZWUuIE15
IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBhbGwgdkRQQSBtdXN0IGJlIG1vZGVybiBkZXZpY2UgKHNp
bmNlCj4gPiA+ID4gPiBWSVJJVE9fRl9BQ0NFU1NfUExBVEZPUk0gaXMgbWFuZGF0ZWQpIGluc3Rl
YWQgb2YgdHJhbnNpdGlvbmFsIGRldmljZS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhhbmtzCj4g
PiA+ID4gV2VsbCBtbHg1IGhhcyBzb21lIGNvZGUgdG8gaGFuZGxlIGxlZ2FjeSBndWVzdHMgLi4u
Cj4gPiA+ID4gRWxpLCBjb3VsZCB5b3UgY29tbWVudD8gSXMgdGhhdCBzdXBwb3J0IHVudXNlZCBy
aWdodCBub3c/Cj4gPiA+ID4gCj4gPiA+IElmIHlvdSBtZWFuIHN1cHBvcnQgZm9yIHZlcnNpb24g
MS4wLCB3ZWxsIHRoZSBrbm9iIGlzIHRoZXJlIGJ1dCBpdCdzIG5vdAo+ID4gPiBzZXQgaW4gdGhl
IGZpcm13YXJlIEkgdXNlLiBOb3RlIHN1cmUgaWYgd2Ugd2lsbCBzdXBwb3J0IHRoaXMuCj4gPiBI
bW0geW91IG1lYW4gaXQncyBsZWdhY3kgb25seSByaWdodCBub3c/Cj4gPiBXZWxsIGF0IHNvbWUg
cG9pbnQgeW91IHdpbGwgd2FudCBhZHZhbmNlZCBnb29kaWVzIGxpa2UgUlNTCj4gPiBhbmQgYWxs
IHRoYXQgaXMgZ2F0ZWQgb24gMS4wIDspCj4gCj4gCj4gU28gaWYgbXkgdW5kZXJzdGFuZGluZyBp
cyBjb3JyZWN0IHRoZSBkZXZpY2UvZmlybXdhcmUgaXMgbGVnYWN5IGJ1dCByZXF1aXJlCj4gVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNIHNlbWFuaWM/IExvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlv
bj8KPiAKPiBUaGFua3MKCkxlZ2FjeSBtb2RlIGRlc2NyaXB0aW9uIGlzIHRoZSBzcGVjIGlzIG5v
bi1ub3JtYXRpdmUuIEFzIHN1Y2ggYXMgbG9uZyBhcwpndWVzdHMgd29yaywgdGhleSB3b3JrIDsp
Cgo+IAo+ID4gCj4gPiA+ID4gPiA+IC1TaXdpZQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gUmVqZWN0aW5nIHJlc2V0IHRvIDAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcHJl
bWF0dXJlbHkgY2F1c2VzIGNvcnJlY3QgTVRVIGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8gbG9h
ZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmb3IgdGhlIHZlcnkgZmlyc3QgY29uZmlnIHNwYWNl
IGFjY2VzcywgcmVuZGVyaW5nIGlzc3VlcyBsaWtlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGd1
ZXN0IHNob3dpbmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG91dC1vZi1yYW5nZSBNVFUuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRw
YS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHN1cHBv
cnRlZCBtbHg1IGRldmljZXMiKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgwqDCoMKgIGRyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAgwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25z
KC0pCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGluZGV4IDdjMWY3ODkuLjU0MGRkNjcgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTE0OTAsMTQgKzE0OTAsNiBAQCBzdGF0aWMgdTY0
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1seDVfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKg
wqAgfQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1
cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
dTY0IGZlYXR1cmVzKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtewo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAtwqDCoMKgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9BQ0NFU1Nf
UExBVEZPUk0pKSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRU9QTk9UU1VQUDsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAtwqDCoMKgIHJldHVybiAwOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtfQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAtCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqAgc3Rh
dGljIGludCBzZXR1cF92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiAgwqDCoMKgIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIMKg
wqDCoMKgwqDCoMKgIGludCBlcnI7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEBAIC0xNTU4LDE4
ICsxNTUwLDEzIEBAIHN0YXRpYyBpbnQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbWx4NV92ZHBh
X3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBmZWF0dXJlcykKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIMKgwqDCoCB7Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYo
bXZkZXYpOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIGludCBlcnI7Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoCBwcmludF9mZWF0dXJlcyhtdmRldiwgZmVh
dHVyZXMsIHRydWUpOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIGVyciA9IHZlcmlm
eV9taW5fZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
LcKgwqDCoCBpZiAoZXJyKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGVycjsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVy
ZXMgJgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcubXR1ID0g
Y3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ICDCoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1dmRw
YTE2KG12ZGV2LAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBWSVJUSU9fTkVUX1NfTElOS19VUCk7
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqAgcmV0dXJuIGVycjsKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gK8KgwqDCoCByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIMKg
wqDCoCB9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICDCoMKgwqAgc3RhdGljIHZvaWQgbWx4NV92
ZHBhX3NldF9jb25maWdfY2Ioc3RydWN0IHZkcGFfZGV2aWNlCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ICp2ZGV2LCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqY2IpCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
