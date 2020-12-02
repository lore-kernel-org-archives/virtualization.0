Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96DC64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:07:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426AA2222C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426AA2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6A3462E15A;
	Wed,  2 Dec 2020 13:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WT7yLT4KKi8X; Wed,  2 Dec 2020 13:07:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 86CCF20425;
	Wed,  2 Dec 2020 13:07:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B04BC0859;
	Wed,  2 Dec 2020 13:07:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3504AC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 23ED1878DA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJi+bD8RTwwq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:07:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 188F5878D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606914450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwmepWJZ82mHWubEQCiQLkOjArglUR6CIUVSWTYE16U=;
 b=VtwOq0axIpU9UGb/In+ie6aq94RryXA6PoQcOM5MV81gvRaHXAWdcdaWqeDq4NXASWZ8qO
 yk+GCorCQlrhk19WBtyflSz0jGu05anqdHUBHPAf27dArRyESQ3fUdwAr0DO33afufKQGI
 EVCnI0FRLqHmpgWTAXKOgNLpwdtfyMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-eaDm0FX8OV-HHhVhMr8MjA-1; Wed, 02 Dec 2020 08:07:29 -0500
X-MC-Unique: eaDm0FX8OV-HHhVhMr8MjA-1
Received: by mail-wr1-f71.google.com with SMTP id d1so3953593wrn.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 05:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qwmepWJZ82mHWubEQCiQLkOjArglUR6CIUVSWTYE16U=;
 b=PUBKOvAd8/PqJzaPD6/UGe1STWqYgqe51I5ImNTP6JB7BhTuQ9a82s5qhvAdK5Pp50
 NNyn1LT7kXD9W1TSIeL2GoV7wJr0caDer6qxk7NP2ptzEmKN8XGi82cVkVZCFN+jP7Ei
 T1MIAvXDdh6cWHpfnRtXAUVJWkwN5sF56n1HhFLoKj7v/etiTZJT80d9yPm773x2WAFN
 SzlCvmWlsLllFQu1aKUxWhh7SX869wS2Tp4DW9mQl26QgcYwm5u4HvB7mU1UoSeb3SOx
 9UIyaK5X0NDya0EDHJd0NS2HRrAVC2a4l5goqIfKqE1HpDyngssX0GF27fe7h7BJ7Fp6
 j8sg==
X-Gm-Message-State: AOAM533/wQfbnnGGz7h/ZNt1nsV8cxcdRqXcIWRYJRj82mSfjiGUl4X6
 2MNHajjAmBLqLUlKpo8Fjor0g00y1MhlFcEUFpOpcLYBQBiVpgIjherUBf5PM+xVqDUrUMTsQbu
 /BBSdZlEZiufnhV1u6FvtHONgqEk7wjrIjKZx2ADy1w==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr3414749wro.58.1606914447737; 
 Wed, 02 Dec 2020 05:07:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2W4U0R8wN7xe9RrchLeBR2GC9s0cgaHhVoJYfH5cJ172A9+XRdO6WGDYcm4XFi8rriK7RAQ==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr3414719wro.58.1606914447440; 
 Wed, 02 Dec 2020 05:07:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id h83sm2230715wmf.9.2020.12.02.05.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 05:07:26 -0800 (PST)
Date: Wed, 2 Dec 2020 08:07:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201202080533-mutt-send-email-mst@kernel.org>
References: <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <20201202121241.GA228811@mtl-vdi-166.wap.labs.mlnx>
 <20201202071414-mutt-send-email-mst@kernel.org>
 <13d33e2c-ea99-6625-83fd-6cb223dd103b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <13d33e2c-ea99-6625-83fd-6cb223dd103b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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

T24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDk6MDA6MDdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEyLzIg5LiL5Y2IODoxNywgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDI6MTI6NDFQTSArMDIwMCwgRWxpIENvaGVu
IHdyb3RlOgo+ID4gPiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAwNDoyMzoxMUFNIC0wNTAwLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gT24gV2VkLCBEZWMgMDIsIDIwMjAgYXQg
MDc6NTc6MTRBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCBEZWMg
MDIsIDIwMjAgYXQgMTI6MTg6MzZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+
ID4gT24gMjAyMC8xMi8xIOS4i+WNiDU6MjMsIENpbmR5IEx1IHdyb3RlOgo+ID4gPiA+ID4gPiA+
IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbjxtc3RA
cmVkaGF0LmNvbT4gIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAg
YXQgMDY6NDE6NDVQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9u
IE1vbiwgTm92IDMwLCAyMDIwIGF0IDU6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRo
YXQuY29tPiAgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAg
YXQgMTE6Mjc6NTlBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDQ6MDA6NTFBTSAtMDUwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIE5vdiAzMCwgMjAy
MCBhdCAwODoyNzo0NkFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gT24gU3VuLCBOb3YgMjksIDIwMjAgYXQgMDM6MDg6MjJQTSAtMDUwMCwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gU3VuLCBO
b3YgMjksIDIwMjAgYXQgMDg6NDM6NTFBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXZSBzaG91bGQgbm90IHRyeSB0byB1c2UgdGhlIFZGIE1B
QyBhZGRyZXNzIGFzIHRoYXQgaXMgdXNlZCBieSB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gcmVndWxhciAoZS5nLiBtbHg1X2NvcmUpIE5JQyBpbXBsZW1lbnRhdGlvbi4gSW5zdGVh
ZCwgdXNlIGEgcmFuZG9tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGdlbmVyYXRlZCBN
QUMgYWRkcmVzcy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IFN1Z2dlc3RlZCBieTogQ2luZHkgTHU8bHVsdUByZWRoYXQuY29tPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9t
bHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW48ZWxpY0Budmlk
aWEuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSBkaWRuJ3QgcmVhbGlzZSBpdCdz
IHBvc3NpYmxlIHRvIHVzZSBWRiBpbiB0d28gd2F5cwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gd2l0aCBhbmQgd2l0aG91dCB2ZHBhLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFVzaW5n
IGEgVkYgeW91IGNhbiBjcmVhdGUgcXVpdGUgYSBmZXcgcmVzb3VyY2VzLCBlLmcuIHNlbmQgcXVl
dWVzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gcmVjaWV2ZSBxdWV1ZXMsIHZpcnRpb19uZXQg
cXVldWVzIGV0Yy4gU28geW91IGNhbiBwb3NzaWJseSBjcmVhdGUKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBzZXZlcmFsIGluc3RhbmNlcyBvZiB2ZHBhIG5ldCBkZXZpY2VzIGFuZCBuaWMgbmV0
IGRldmljZXMuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBDb3VsZCB5b3UgaW5jbHVkZSBhIGJpdCBtb3JlIGRlc2NyaXB0aW9uIG9uIHRoZSBm
YWlsdXJlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBtb2RlPwo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFdlbGwsIHVzaW5nIHRoZSBNQUMgYWRkcmVzcyBvZiB0aGUgbmljIHZwb3J0IGlz
IHdyb25nIHNpbmNlIHRoYXQgaXMgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTUFDIG9m
IHRoZSByZWd1bGFyIE5JQyBpbXBsZW1lbnRhdGlvbiBvZiBtbHg1X2NvcmUuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IFJpZ2h0IGJ1dCBBVE0gaXQgZG9lc24ndCBjb2V4aXN0IHdpdGggdmRwYSBz
byB3aGF0J3MgdGhlIHByb2JsZW0/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gVGhpcyBjYWxsIGlzIHdyb25nOiAgbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFj
X2FkZHJlc3MoKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiBJcyBzd2l0Y2hpbmcgdG8gYSByYW5kb20gbWFjIGZvciBzdWNoIGFuIHVudXN1YWwKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb24gcmVhbGx5IGp1c3RpZmllZD8K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTaW5jZSBJIGNhbid0IHVzZSB0aGUgTklDJ3MgTUFD
IGFkZHJlc3MsIEkgaGF2ZSB0d28gb3B0aW9uczoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAx
LiBUbyBnZXQgdGhlIE1BQyBhZGRyZXNzIGFzIHdhcyBjaG9zZW4gYnkgdGhlIHVzZXIgYWRtaW5p
c3RlcmluZyB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgIE5JQy4gVGhpcyBzaG91
bGQgaW52b2tlIHRoZSBzZXRfY29uZmlnIGNhbGxiYWNrLiBVbmZvcnR1bmF0ZWx5IHRoaXMKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgIGlzIG5vdCBpbXBsZW1lbnRlZCB5ZXQuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMi4gVXNlIGEg
cmFuZG9tIE1BQyBhZGRyZXNzLiBUaGlzIGlzIE9LIHNpbmNlIGlmICgxKSBpcyBpbXBsZW1lbnRl
ZCBpdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgY2FuIGFsd2F5cyBvdmVycmlkZSB0
aGlzIHJhbmRvbSBjb25maWd1cmF0aW9uLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXQgbG9va3MgbGlrZSBjaGFuZ2luZyBhIE1BQyBjb3Vs
ZCBicmVhayBzb21lIGd1ZXN0cywKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbiBpdCBu
b3Q/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBObywgaXQgd2lsbCBub3QuIFRoZSBjdXJyZW50IHZlcnNpb24gb2YgbWx4NSBWRFBBIGRvZXMg
bm90IGFsbG93IHJlZ3VsYXIKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBOSUMgZHJpdmVyIGFu
ZCBWRFBBIHRvIGNvLWV4aXN0LiBJIGhhdmUgcGF0Y2hlcyByZWFkeSB0aGF0IGVuYWJsZSB0aGF0
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZnJvbSBzdGVlcmluZyBwb2ludCBvZiB2aWV3LiBJ
IHdpbGwgcG9zdCB0aGVtIGhlcmUgb25jZSBvdGhlciBwYXRjaGVzIG9uCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gd2hpY2ggdGhleSBkZXBlbmQgd2lsbCBiZSBtZXJnZWQuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9wYXRjaC8yMDIwMTEyMDIzMDMzOS42NTE2MDkt
MTItc2FlZWRtQG52aWRpYS5jb20vCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENvdWxkIHlvdSBi
ZSBtb3JlIGV4cGxpY2l0IG9uIHRoZSBmb2xsb3dpbmcgcG9pbnRzOgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAtIHdoaWNoIGNvbmZpZ3VyYXRpb24gaXMgYnJva2VuIEFUTSAoYXMgaW4sIHR3byBk
ZXZpY2UgaGF2ZSBpZGVudGljYWwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgIG1hY3M/IGFu
eSBvdGhlciBpc3N1ZXMpPwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhlIG9ubHkgd3JvbmcgdGhp
bmcgaXMgdGhlIGNhbGwgdG8gIG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKCkuCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBJdCdzIG5vdCBicmVha2luZyBhbnl0aGluZyB5ZXQgaXMgd3Jv
bmcuIFRoZSByYW5kb20gTUFDIGFkZHJlc3Mgc2V0dGluZwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
aXMgcmVxdWlyZWQgZm9yIHRoZSBzdGVlcmluZyBwYXRjaGVzLgo+ID4gPiA+ID4gPiA+ID4gPiA+
IE9rYXkgc28gSSdtIG5vdCBzdXJlIHRoZSBGaXhlcyB0YWcgYXQgbGVhc3QgaXMgYXBwcm9wcmlh
dGUgaWYgaXQncyBhCj4gPiA+ID4gPiA+ID4gPiA+ID4gZGVwZW5kZW5jeSBvZiBhIG5ldyBmZWF0
dXJlLgo+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtIHdoeSB3
b24ndCBkZXZpY2UgTUFDIGNoYW5nZSBmcm9tIGd1ZXN0IHBvaW50IG9mIHZpZXc/Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSXQncyBsYWNrIG9mIGltcGxl
bWVudGF0aW9uIGluIHFlbXUgYXMgZmFyIGFzIEkga25vdy4KPiA+ID4gPiA+ID4gPiA+ID4gPiBT
b3JyeSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQuIFdoYXQncyBub3QgaW1wbGVtZW50ZWQgaW4gUUVN
VT8KPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gSEkgTWljaGFlbCwgdGhl
cmUgYXJlIHNvbWUgYnVnIGluIHFlbXUgdG8gc2V0X2NvbmZpZywgdGhpcyB3aWxsIGZpeCBpbiBm
dXR1cmUsCj4gPiA+ID4gPiA+ID4gPiA+IEJ1dCB0aGlzIHBhdGNoIGlzIHN0aWxsIG5lZWRlZCwg
YmVjYXVzZSB3aXRob3V0IHRoaXMgcGF0Y2ggdGhlIG1seAo+ID4gPiA+ID4gPiA+ID4gPiBkcml2
ZXIgd2lsbCBnaXZlIGFuIDAgbWFjIGFkZHJlc3MgdG8gcWVtdQo+ID4gPiA+ID4gPiA+ID4gPiBh
bmQgcWVtdSB3aWxsIG92ZXJ3cml0ZSB0aGUgZGVmYXVsdCBtYWMgYWRkcmVzcy4gIFRoaXMgd2ls
bCBjYXVzZSB0cmFmZmljIGRvd24uCj4gPiA+ID4gPiA+ID4gPiBIbW0gdGhlIHBhdGNoIGRlc2Ny
aXB0aW9uIHNheXMgVkYgbWFjIGFkZHJlc3MsIG5vdCAwIGFkZHJlc3MuIENvbmZ1c2VkLgo+ID4g
PiA+ID4gPiA+ID4gSWYgdGhlcmUncyBubyBtYWMgd2UgY2FuIGNsZWFyIFZJUlRJT19ORVRfRl9N
QUMgYW5kIGhhdmUgZ3Vlc3QKPiA+ID4gPiA+ID4gPiA+IHVzZSBhIHJhbmRvbSB2YWx1ZSAuLi4K
PiA+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIHRoaXMgY2FuIHdvcmsgZm9yIGFsbCB0eXBlcyBvZiB2
RFBBIChlLmcgaXQgY291bGQgbm90IGJlIGEKPiA+ID4gPiA+ID4gbGVhcm5pbmcgYnJpZGdlIGlu
IHRoZSBzd3RpY2gpLgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gaGkg
TWljaGFlbO+8jAo+ID4gPiA+ID4gPiA+IEkgaGF2ZSB0cmllZCBhcyB5b3VyIHN1Z2dlc3Rpb24s
IHNlZW1zIGV2ZW4gcmVtb3ZlIHRoZQo+ID4gPiA+ID4gPiA+IFZJUlRJT19ORVRfRl9NQUMgdGhl
IHFlbXUgd2lsbCBzdGlsbCBjYWxsIGdldF9jaW5maWcgYW5kIG92ZXJ3cml0ZSB0aGUKPiA+ID4g
PiA+ID4gPiBkZWZhdWx0IGFkZHJlc3MgaW4gIFZNLAo+ID4gPiA+ID4gPiBUaGlzIGxvb2tzIGEg
YnVnIGluIHFlbXUsIGluIGd1ZXN0IGRyaXZlciB3ZSBoYWQ6Cj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiAgwqDCoMKgIC8qIENvbmZpZ3VyYXRpb24gbWF5IHNwZWNpZnkgd2hhdCBNQUMgdG8gdXNl
LsKgIE90aGVyd2lzZSByYW5kb20uICovCj4gPiA+ID4gPiA+ICDCoMKgwqAgaWYgKHZpcnRpb19o
YXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTUFDKSkKPiA+ID4gPiA+ID4gIMKgwqDCoCDC
oMKgwqAgdmlydGlvX2NyZWFkX2J5dGVzKHZkZXYsCj4gPiA+ID4gPiA+ICDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoCBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIG1h
YyksCj4gPiA+ID4gPiA+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoCBkZXYtPmRl
dl9hZGRyLCBkZXYtPmFkZHJfbGVuKTsKPiA+ID4gPiA+ID4gIMKgwqDCoCBlbHNlCj4gPiA+ID4g
PiA+ICDCoMKgwqAgwqDCoMKgIGV0aF9od19hZGRyX3JhbmRvbShkZXYpOwo+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gdGhpcyBwcm9jZXNzIGlzIGxpa2UKPiA+ID4gPiA+
ID4gPiB2ZHBhIF9pbml0IC0tPnFlbXUgY2FsbCBnZXRfY29uZmlnIC0+bWx4IGRyaXZlciB3aWxs
IGdpdmUgIGFuIG1hYwo+ID4gPiA+ID4gPiA+IGFkZHJlc3Mgd2l0aCBhbGwgMC0tPgo+ID4gPiA+
ID4gPiA+IHFlbXUgd2lsbCBub3QgY2hlY2sgdGhpcyBtYWMgYWRkcmVzcyBhbmQgdXNlIGl0IC0t
PiBvdmVyd3JpdGUgdGhlIG1hYwo+ID4gPiA+ID4gPiA+IGFkZHJlc3MgaW4gcWVtdQo+ID4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFNvIGZvciBteSB1bmRlcnN0YW5kaW5nIHRoZXJlIGFyZSBz
ZXZlcmFsIG1ldGhvZCB0byBmaXggdGhpcyBwcm9ibGVtCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gMSwgcWVtdSBjaGVjayB0aGUgbWFjIGFkZHJlc3MsIGlmIHRoZSBtYWMgYWRkcmVzcyBp
cyBhbGwgMCwgcWVtdSB3aWxsCj4gPiA+ID4gPiA+ID4gaWdub3JlIGl0IGFuZCBzZXQgdGhlIHJh
bmRvbSBtYWMgYWRkcmVzcyB0byBtbHggZHJpdmVyLgo+ID4gPiA+ID4gPiBTbyBteSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQsIGlmIG1hYyBhZGRyZXNzIGlzIGFsbCAwLCB2RFBBIHBhcmVudCBzaG91
bGQgbm90Cj4gPiA+ID4gPiA+IGFkdmVydGlzZSBWSVJUSU9fTkVUX0ZfTUFDLiBBbmQgcWVtdSBz
aG91bGQgZW11bGF0ZSB0aGlzIGZlYXR1cmUgYXMgeW91IGRpZDoKPiA+ID4gPiA+IFRoaW5raW5n
IGl0IG92ZXIsIGF0IGxlYXN0IGluIG1seDUsIEkgc2hvdWxkIGFsd2F5cyBhZHZlcnRpc2UKPiA+
ID4gPiA+IFZJUlRJT19ORVRfRl9NQUMgYW5kIHNldCBhIG5vbiB6ZXJvIE1BQyB2YWx1ZS4gVGhl
IHNvdXJjZSBvZiB0aGUgTUFDIGNhbgo+ID4gPiA+ID4gYmUgZWl0aGVyIHJhbmRvbWx5IGdlbmVy
YXRlZCB2YWx1ZSBieSBtbHg1X3ZkcGEgb3IgYnkgYSBtYW5hZ2VtZW50IHRvb2wuCj4gPiA+ID4g
PiBUaGlzIGlzIGltcG9ydGFudCBiZWNhdWFzZSB3ZSBzaG91bGQgbm90IGxldCB0aGUgVk0gbW9k
aWZ5IHRoZSBNQUMuIElmCj4gPiA+ID4gPiB3ZSBkbyBpdCBjYW4gc2V0IGEgTUFDIHZhbHVlIGlk
ZW50aWNhbCB0byB0aGUgbWx4NSBOSUMgZHJpdmVyIGFuZCBjYW4KPiA+ID4gPiA+IGtpZG5hcCB0
cmFmZmljIHRoYXQgd2FzIG5vdCBkZXN0aW5lZCB0byBpdC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4g
SW4gYWRkaXRpb24sIHdoZW4gVklSVElPX05FVF9GX01BQyBpcyBwdWJsaXNoZWQsIGF0dGVtcHRz
IHRvIGNoYW5nZSB0aGUKPiA+ID4gPiA+IE1BQyBhZGRyZXNzIGZyb20gdGhlIFZNIHNob3VsZCBy
ZXN1bHQgaW4gZXJyb3IuCj4gPiA+ID4gVGhhdCBpcyBub3Qgd2hhdCB0aGUgc3BlYyBzYXlzIHRo
b3VnaC4KPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTUFDIG9ubHkgc2F5cyB3aGV0aGVyIG1hYyBpcyB2
YWxpZCBpbiB0aGUgY29uZmlnIHNwYWNlLgo+ID4gPiA+IFdoZXRoZXIgZ3Vlc3QgY2FuIGNvbnRy
b2wgdGhhdCBkZXBlbmRzIG9uIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSOgo+ID4gPiA+IAo+
ID4gPiA+IAlUaGUgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBjb21tYW5kIGlzIHVzZWQg
dG8gc2V0IHRoZSBkZWZhdWx0IE1BQyBhZGRyZXNzIHdoaWNoIHJ4Cj4gPiA+ID4gCWZpbHRlcmlu
ZyBhY2NlcHRzIChhbmQgaWYgVklSVElPX05FVF9GX01BQ19BRERSIGhhcyBiZWVuIG5lZ290aWF0
ZWQsIHRoaXMgd2lsbCBiZSByZWZsZWN0ZWQgaW4gbWFjIGluCj4gPiA+ID4gCWNvbmZpZyBzcGFj
ZSkuCj4gPiA+ID4gCVRoZSBjb21tYW5kLXNwZWNpZmljLWRhdGEgZm9yIFZJUlRJT19ORVRfQ1RS
TF9NQUNfQUREUl9TRVQgaXMgdGhlIDYtYnl0ZSBNQUMgYWRkcmVzcy4KPiA+ID4gVHdvIHF1ZXN0
aW9ucyBoZXJlOgo+ID4gPiAxLiBOb3cgd2UgZG9uJ3QgaGF2ZSBzdXBwb3J0IGZvciBjb250cm9s
IHZpcnRxdWV1ZS4gWWV0LCB3ZSBtdXN0IGZpbHRlcgo+ID4gPiBwYWNrZXRzIGJhc2VkIG9uIE1B
Qywgd2hhdCBkbyB5b3Ugc3VnZ2VzdCB0byBkbyBoZXJlPwo+ID4gSG93IGFib3V0IGFuIGlvY3Rs
IHRvIHBhc3MgdGhlIG1hYyB0byB0aGUgZGV2aWNlPwo+ID4gTWF5YmUgbWlycm9yaW5nIHRoZSBj
b250cm9sIHZxIHN0cnVjdCBmb3JtYXQgLi4uCj4gCj4gCj4gSSB0aGluayB3ZSdkIGJldHRlciBh
dm9pZCBzdWNoIGFkLWhvYyBpb2N0bHMgdG8gbWFrZSB2aG9zdC12RFBBIHR5cGUKPiBpbmRlcGVu
ZGVudC4KCkZ1bmRhbWVudGFsbHkgdGhpcyBpcyBhYm91dCBoYW5kbGluZyBzb21lIFZRcyBpbiBR
RU1VLCByaWdodD8KTWF5YmUgYSBnZW5lcmljIGlvY3RsIGFsb25nIHRoZSBsaW5lcyBvZiAiQ1RS
TF9WUSIgcGFzc2luZwp2cSBudW1iZXIgYW5kIGEgY29tbWFuZCBidWZmZXIgZnJvbSBndWVzdD8K
U2VlbXMgZ2VuZXJpYyBlbm91Z2ggZm9yIHlvdT8KCj4gQW5kIGRvaW5nIHRoaXMgbWVhbnMgd2Ug
bmVlZCB0byBzZWVrIGFub3RoZXIgd2F5IGZvcgo+IHZpcnRpby12ZHBhIGRyaXZlcnMuCj4gCj4g
VGhhbmtzCj4gCj4gCj4gPiAKPiA+ID4gMi4gV2hlbiBjb250cm9sIHZpcnRxdWV1ZSBpcyBpbXBs
ZW1lbnRlZCwgd2hpY2ggYWRtaW4gZW50aXR5IGlzIGFsbG93ZWQKPiA+ID4gdG8gY2hhbmdlIHRo
ZSBNQUMgZmlsdGVyaW5nIHRhYmxlPwo+ID4gSXQncyB1cCB0byB0aGUgaHlwZXJ2aXNvcjogaWYg
VklSVElPX05FVF9GX0NUUkxfTUFDX0FERFIKPiA+IGlzIGVuYWJsZWQgdGhpcyBtZWFucyBoeXBl
cnZpc29yIHRydXN0cyB0aGUgZ3Vlc3Qgd2l0aCBmdWxsCj4gPiBhY2Nlc3MgdG8gTklDIG5ldHdv
cmsuCj4gPiBJZiBpdCdzIGNsZWFyIHRoZW4gbWFjIG11c3QgYmUgc2V0IGJ5IGhhcmR3YXJlIG9y
IHRoZSBoeXBlcnZpc29yLgo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
