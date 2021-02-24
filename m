Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5136C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:48:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D50864E05
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D50864E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9434443089;
	Wed, 24 Feb 2021 06:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4jEtWtfKRra; Wed, 24 Feb 2021 06:48:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C687643084;
	Wed, 24 Feb 2021 06:48:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3439C000A;
	Wed, 24 Feb 2021 06:48:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B567CC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A27084EBB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mldVrurs6ly8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:48:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4607A4EB9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614149292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66ucE3xxAUBgeHQc2W+xDbouWd2JXR+g+qFxokJjKqg=;
 b=hrWPDAwYefNybwtOmZxIxYCQkR+yLuV+XbcCdUzKG6rSeOw4ulOZtKJro3rh6ykfpvtf4Z
 Abqyp4OL/q+2acfLuySpacEp4185KIXtRaVQR7pAa19sUkvwTCst4l7wXAO/2We7m17xyg
 z/eQZJ0KnGcUJ8Mu8BA3OIZg2A3PdFo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-ZTBEffkSOe-shUCGHJgKSg-1; Wed, 24 Feb 2021 01:47:58 -0500
X-MC-Unique: ZTBEffkSOe-shUCGHJgKSg-1
Received: by mail-wr1-f70.google.com with SMTP id d10so592356wrq.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 22:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=66ucE3xxAUBgeHQc2W+xDbouWd2JXR+g+qFxokJjKqg=;
 b=AziWUMHa+twUpSd+9pjGQdoAoud4C/Cd0lFuLpUQ5PdJcG8TSHI6LmBoxvCJ6W+Znf
 kmNHO4rksS9GjIC6PueImh4fvfD8Wqku5vm+yL9OVlaEobPyh8EEW0xIxjh5z2Bpqcj5
 hjT0pZlezbVXKI6MPBQfOzOH9tY450RtaC25jWdG4wa1HZ6ySjM+I64Lam4GSl1bqfB5
 yvKooiPNo4No/r1gb0s4+yaWP7f6LYygr7B583PKwV82LMd7DeXUOg2tsFPI2S78B2Ej
 dPmpPsiQgjjhCApmThJ6+LCjJ/AjKb80dbbUNlBpwuuqPmS7Cz0usDf4l6vIGD5P3HMb
 hfxA==
X-Gm-Message-State: AOAM531TSifyk+JqvBe3Ted8/LeOmj6Ei7in8EXT3smuScFROebYH6hN
 hdt6FQx92pFv3VciuniNbgta3jZRLTqp6ncyLfSjif2eveKMOq51I4E1jCo+5zgKmlVnChbT3WN
 5QFctP+dC/BVtzpGI3INlHAdw6QDSHqGsPUbX43PmuQ==
X-Received: by 2002:a5d:474a:: with SMTP id o10mr11010274wrs.176.1614149277313; 
 Tue, 23 Feb 2021 22:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHmk07H0FV/uDXyG0qesj49GzCbo9GTuE2GBwvVvEaBsUcqAVG3zBagp2srivDOwUzwNpDNA==
X-Received: by 2002:a5d:474a:: with SMTP id o10mr11010260wrs.176.1614149277168; 
 Tue, 23 Feb 2021 22:47:57 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id 4sm2210009wrr.27.2021.02.23.22.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 22:47:56 -0800 (PST)
Date: Wed, 24 Feb 2021 01:47:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224014700-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <7e6291a4-30b1-6b59-a2bf-713e7b56826d@redhat.com>
 <20210224000528-mutt-send-email-mst@kernel.org>
 <20210224064520.GA204317@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210224064520.GA204317@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMDg6NDU6MjBBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDEyOjE3OjU4QU0gLTA1MDAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDExOjIwOjAxQU0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IAo+ID4gPiBPbiAyMDIxLzIvMjQgMzozNSDkuIrl
jYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gT24gMi8yMy8y
MDIxIDU6MjYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwg
RmViIDIzLCAyMDIxIGF0IDEwOjAzOjU3QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+
ID4gPiA+IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBPbiAyLzIxLzIwMjEgMTE6MzQgUE0sIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgRmViIDIyLCAyMDIxIGF0IDEy
OjE0OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIDIw
MjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
PiBDb21taXQgNDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBp
bnZva2VkCj4gPiA+ID4gPiA+ID4gPiA+ID4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9u
IGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZXMg
dG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4gPiA+
ID4gPiA+ID4gPiA+ID4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZlcmlmeV9taW5f
ZmVhdHVyZXMoKSBjaGVjawo+ID4gPiA+ID4gPiA+ID4gPiA+IGFuZCBhbGxvdyBmZWF0dXJlcyBy
ZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNv
dWxkIGFjY2Vzcwo+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVy
ZXMgYXJlIHNldC4gRm9yIGluc3RhbmNlLCB3aGVuCj4gPiA+ID4gPiA+ID4gPiA+ID4gZmVhdHVy
ZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4gPiA+
ID4gPiA+ID4gPiA+ID4gd2lsbCB0cnkgdG8gYWNjZXNzIGFuZCB2YWxpZGF0ZSB0aGUgTVRVIHBy
ZXNlbnQgaW4gdGhlIGNvbmZpZwo+ID4gPiA+ID4gPiA+ID4gPiA+IHNwYWNlIGJlZm9yZSB2aXJ0
aW8gZmVhdHVyZXMgYXJlIHNldC4KPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBsb29rcyBsaWtlIGEg
c3BlYyB2aW9sYXRpb246Cj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiAiCj4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBUaGUgZm9sbG93aW5nIGRyaXZlci1y
ZWFkLW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZgo+ID4gPiA+ID4gPiA+ID4gPiBWSVJU
SU9fTkVUX0ZfTVRVIGlzCj4gPiA+ID4gPiA+ID4gPiA+IHNldC4KPiA+ID4gPiA+ID4gPiA+ID4g
VGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRVIGZvciB0aGUgZHJpdmVyIHRvIHVz
ZS4KPiA+ID4gPiA+ID4gPiA+ID4gIgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+
ID4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29ya2Fyb3VuZCB0aGlzPwo+ID4gPiA+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPiA+ID4gPiBBbmQgYWxzbzoKPiA+
ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlz
IHNlcXVlbmNlIHRvIGluaXRpYWxpemUgYSBkZXZpY2U6Cj4gPiA+ID4gPiA+ID4gPiAxLiBSZXNl
dCB0aGUgZGV2aWNlLgo+ID4gPiA+ID4gPiA+ID4gMi4gU2V0IHRoZSBBQ0tOT1dMRURHRSBzdGF0
dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzCj4gPiA+ID4gPiA+ID4gPiBub3RpY2VkIHRoZSBkZXZp
Y2UuCj4gPiA+ID4gPiA+ID4gPiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vl
c3QgT1Mga25vd3MgaG93IHRvIGRyaXZlIHRoZQo+ID4gPiA+ID4gPiA+ID4gZGV2aWNlLgo+ID4g
PiA+ID4gPiA+ID4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRzLCBhbmQgd3JpdGUgdGhlIHN1
YnNldCBvZiBmZWF0dXJlIGJpdHMKPiA+ID4gPiA+ID4gPiA+IHVuZGVyc3Rvb2QgYnkgdGhlIE9T
IGFuZCBkcml2ZXIgdG8gdGhlCj4gPiA+ID4gPiA+ID4gPiBkZXZpY2UuIER1cmluZyB0aGlzIHN0
ZXAgdGhlIGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKQo+ID4gPiA+ID4gPiA+
ID4gdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uCj4gPiA+ID4gPiA+ID4gPiBmaWVs
ZHMgdG8gY2hlY2sgdGhhdCBpdCBjYW4gc3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRp
bmcgaXQuCj4gPiA+ID4gPiA+ID4gPiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQu
IFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldwo+ID4gPiA+ID4gPiA+ID4gZmVhdHVyZSBi
aXRzIGFmdGVyIHRoaXMgc3RlcC4KPiA+ID4gPiA+ID4gPiA+IDYuIFJlLXJlYWQgZGV2aWNlIHN0
YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6Cj4gPiA+ID4g
PiA+ID4gPiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPiA+ID4gPiA+ID4gPiA+IHN1
cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4K
PiA+ID4gPiA+ID4gPiA+IDcuIFBlcmZvcm0gZGV2aWNlLXNwZWNpZmljIHNldHVwLCBpbmNsdWRp
bmcgZGlzY292ZXJ5IG9mIHZpcnRxdWV1ZXMKPiA+ID4gPiA+ID4gPiA+IGZvciB0aGUgZGV2aWNl
LCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+ID4gPiA+ID4gPiA+ID4gcmVhZGluZyBhbmQgcG9z
c2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlvbgo+ID4gPiA+
ID4gPiA+ID4gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4gPiA+ID4gPiA+
ID4gPiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBk
ZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+ID4gPiBzbyBhY2Nlc3NpbmcgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19P
SyBpcyBhIHNwZWMKPiA+ID4gPiA+ID4gPiA+IHZpb2xhdGlvbiwgcmlnaHQ/Cj4gPiA+ID4gPiA+
ID4gSXQgaXMsIGJ1dCBpdCdzIG5vdCByZWxldmFudCB0byB3aGF0IHRoaXMgY29tbWl0IHRyaWVz
IHRvIGFkZHJlc3MuIEkKPiA+ID4gPiA+ID4gPiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vlc3Qgc3Rp
bGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IEhh
dmluZyBzYWlkLCBhIHNlcGFyYXRlIHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBn
dWVzdCBkcml2ZXIKPiA+ID4gPiA+ID4gPiBpc3N1ZSB3aGVyZSB0aGlzIGRpc2NyZXBhbmN5IGlz
IGludHJvZHVjZWQgdG8KPiA+ID4gPiA+ID4gPiB2aXJ0bmV0X3ZhbGlkYXRlKCkgKHNpbmNlCj4g
PiA+ID4gPiA+ID4gY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQgaXQncyBub3QgdGVjaG5pY2FsbHkg
cmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IC1TaXdl
aQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSSB0aGluayBpdCdzIGEgYnVnIHRvIHJlYWQgY29u
ZmlnIHNwYWNlIGluIHZhbGlkYXRlLCB3ZSBzaG91bGQKPiA+ID4gPiA+ID4gbW92ZSBpdCB0bwo+
ID4gPiA+ID4gPiB2aXJ0bmV0X3Byb2JlKCkuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBUaGFu
a3MKPiA+ID4gPiA+IEkgdGFrZSBpdCBiYWNrLCByZWFkaW5nIGJ1dCBub3Qgd3JpdGluZyBzZWVt
cyB0byBiZSBleHBsaWNpdGx5Cj4gPiA+ID4gPiBhbGxvd2VkIGJ5IHNwZWMuCj4gPiA+ID4gPiBT
byBvdXIgd2F5IHRvIGRldGVjdCBhIGxlZ2FjeSBndWVzdCBpcyBib2d1cywgbmVlZCB0byB0aGlu
ayB3aGF0IGlzCj4gPiA+ID4gPiB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMuCj4gPiA+ID4g
VGhlbiBtYXliZSByZXZlcnQgY29tbWl0IGZlMzZjYmUwNjcgYW5kIGZyaWVuZHMsIGFuZCBoYXZl
IFFFTVUgZGV0ZWN0Cj4gPiA+ID4gbGVnYWN5IGd1ZXN0PyBTdXBwb3NlZGx5IG9ubHkgY29uZmln
IHNwYWNlIHdyaXRlIGFjY2VzcyBuZWVkcyB0byBiZQo+ID4gPiA+IGd1YXJkZWQgYmVmb3JlIHNl
dHRpbmcgRkVBVFVSRVNfT0suCj4gPiA+IAo+ID4gPiAKPiA+ID4gSSBhZ3JlZS4gTXkgdW5kZXJz
dGFuZGluZyBpcyB0aGF0IGFsbCB2RFBBIG11c3QgYmUgbW9kZXJuIGRldmljZSAoc2luY2UKPiA+
ID4gVklSSVRPX0ZfQUNDRVNTX1BMQVRGT1JNIGlzIG1hbmRhdGVkKSBpbnN0ZWFkIG9mIHRyYW5z
aXRpb25hbCBkZXZpY2UuCj4gPiA+IAo+ID4gPiBUaGFua3MKPiA+IAo+ID4gV2VsbCBtbHg1IGhh
cyBzb21lIGNvZGUgdG8gaGFuZGxlIGxlZ2FjeSBndWVzdHMgLi4uCj4gPiBFbGksIGNvdWxkIHlv
dSBjb21tZW50PyBJcyB0aGF0IHN1cHBvcnQgdW51c2VkIHJpZ2h0IG5vdz8KPiA+IAo+IAo+IElm
IHlvdSBtZWFuIHN1cHBvcnQgZm9yIHZlcnNpb24gMS4wLCB3ZWxsIHRoZSBrbm9iIGlzIHRoZXJl
IGJ1dCBpdCdzIG5vdAo+IHNldCBpbiB0aGUgZmlybXdhcmUgSSB1c2UuIE5vdGUgc3VyZSBpZiB3
ZSB3aWxsIHN1cHBvcnQgdGhpcy4KCkhtbSB5b3UgbWVhbiBpdCdzIGxlZ2FjeSBvbmx5IHJpZ2h0
IG5vdz8KV2VsbCBhdCBzb21lIHBvaW50IHlvdSB3aWxsIHdhbnQgYWR2YW5jZWQgZ29vZGllcyBs
aWtlIFJTUwphbmQgYWxsIHRoYXQgaXMgZ2F0ZWQgb24gMS4wIDspCgo+ID4gCj4gPiA+IAo+ID4g
PiA+IAo+ID4gPiA+IC1TaXdpZQo+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gPiA+ID4gUmVqZWN0aW5nIHJlc2V0IHRvIDAKPiA+ID4gPiA+ID4gPiA+ID4gPiBwcmVtYXR1
cmVseSBjYXVzZXMgY29ycmVjdCBNVFUgYW5kIGxpbmsgc3RhdHVzIHVuYWJsZSB0byBsb2FkCj4g
PiA+ID4gPiA+ID4gPiA+ID4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3Ms
IHJlbmRlcmluZyBpc3N1ZXMgbGlrZQo+ID4gPiA+ID4gPiA+ID4gPiA+IGd1ZXN0IHNob3dpbmcg
aW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gb3V0LW9mLXJhbmdlIE1UVS4KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g
PiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIg
Zm9yCj4gPiA+ID4gPiA+ID4gPiA+ID4gc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gPiA+ID4g
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUu
Y29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCBk
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0tLS0KPiA+
ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
NCBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+
ID4gPiA+ID4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4g
PiA+ID4gPiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gPiA+
ID4gPiA+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAgc3RhdGljIHU2NAo+ID4gPiA+ID4gPiA+ID4g
PiA+IG1seDVfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ID4g
PiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBtdmRldi0+bWx4X2ZlYXR1cmVz
Owo+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCB9Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLXN0YXRp
YyBpbnQgdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4g
PiA+ID4gPiA+ID4gPiA+ID4gdTY0IGZlYXR1cmVzKQo+ID4gPiA+ID4gPiA+ID4gPiA+IC17Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBpZiAoIShmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElP
X0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU9QTk9UU1VQUDsKPiA+ID4gPiA+ID4gPiA+ID4gPiAtCj4gPiA+ID4gPiA+ID4g
PiA+ID4gLcKgwqDCoCByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiA+ID4gPiAtfQo+ID4gPiA+ID4g
PiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqAgc3RhdGljIGludCBzZXR1cF92
aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ID4gPiA+ID4gPiA+ID4gPiA+
IMKgwqDCoCB7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgaW50IGVycjsKPiA+
ID4gPiA+ID4gPiA+ID4gPiBAQCAtMTU1OCwxOCArMTU1MCwxMyBAQCBzdGF0aWMgaW50Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gbWx4NV92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHU2NAo+ID4gPiA+ID4gPiA+ID4gPiA+IGZlYXR1cmVzKQo+ID4gPiA+ID4gPiA+ID4g
PiA+IMKgwqDCoCB7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFf
bmRldihtdmRldik7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBpbnQgZXJyOwo+ID4gPiA+
ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJl
cywgdHJ1ZSk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBlcnIgPSB2ZXJpZnlfbWluX2Zl
YXR1cmVzKG12ZGV2LCBmZWF0dXJlcyk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gLcKgwqDCoCBpZiAo
ZXJyKQo+ID4gPiA+ID4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+ID4g
PiA+ID4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBuZGV2
LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgPSBmZWF0dXJlcyAmCj4gPiA+ID4gPiA+ID4gPiA+ID4g
bmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzOwo+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgIG5kZXYtPmNvbmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1
KTsKPiA+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVz
IHw9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LAo+ID4gPiA+ID4gPiA+ID4gPiA+IFZJUlRJT19O
RVRfU19MSU5LX1VQKTsKPiA+ID4gPiA+ID4gPiA+ID4gPiAtwqDCoMKgIHJldHVybiBlcnI7Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoCByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiA+ID4gPiDC
oMKgwqAgfQo+ID4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFf
c2V0X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZpY2UKPiA+ID4gPiA+ID4gPiA+ID4gPiAqdmRl
diwgc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKQo+ID4gPiA+IAo+ID4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
