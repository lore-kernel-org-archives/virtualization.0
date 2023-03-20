Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68716C7618A
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 06:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0B5C40376;
	Mon, 20 Mar 2023 06:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0B5C40376
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QYcKsBXw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veI6dQiKoKCs; Mon, 20 Mar 2023 06:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34DB1402F7;
	Mon, 20 Mar 2023 06:44:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34DB1402F7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E85B9C0071;
	Mon, 20 Mar 2023 06:44:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86281C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 06:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 541C3607A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 06:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 541C3607A4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QYcKsBXw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m_jlwhFFAeqd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 06:44:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F8F060767
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F8F060767
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679294666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFW9ym38dAzt4E+PCdeerQXpugtReukjNIJ02CPfYNc=;
 b=QYcKsBXwwd2RtMyW/IrB/FpMTx2jszpElZRMjeuluNDOyAH8Y/kDt5xkUkhp/IA//SzS+n
 S12FtJoy8OtIZ9Z+k4xgAq1Qkbz+IXKLT1f8r5UwRcUwgVTzjxeQBcYBvpsCOX4mW0qA4c
 uGKVxXD+3QQXiOHvKe2DFJDcv3dmOEA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-I5ZFhJB_PMK2BNRw2jb3gg-1; Mon, 20 Mar 2023 02:44:24 -0400
X-MC-Unique: I5ZFhJB_PMK2BNRw2jb3gg-1
Received: by mail-oi1-f200.google.com with SMTP id
 w11-20020a0568080d4b00b00386d5b8445dso2946673oik.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Mar 2023 23:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679294663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFW9ym38dAzt4E+PCdeerQXpugtReukjNIJ02CPfYNc=;
 b=gFnMdQ3mBtZ9w/CJE4hVfY8tLH49MeU0g8TWNq+Of3MOrCiT1zRgyNM2T4gQoFLHAu
 jteBt5vpdQTDjKCWs6MP4Lz8HeiuijcnSYPkcSNcunrRt0Eg9AFRjxH+sAE5SA9f1zym
 hgoHOuhcjjFGj25EjwgWRX2dF7b3OBi9soXfCoG7F8eDa7wdpK+MI+lt+2CbMuZTLazV
 kCdf/H6UkMXs5uuIDYPuZ4Rfd1EB0p7TgPopK1+8h3njt+19Xsim1FWDVEv+JSV/ioLK
 fbLBTmTnd+X2ITDqrUQ0uWeNvskHVcI3rs/hflvaWlc6ug56iLPzkvDvnNhhQTMPV+1q
 iz1w==
X-Gm-Message-State: AO0yUKVkUIOT5PFVoMLf5QgroF9obU0KCb6AjjZtSL/IVsfqs7PpXZoO
 wAL2uZKna7TvJ1JvUu4EdWKpre5xwwtdWbeCDAMryPkk0jiScYLofhRJaC7zgzEeOaelZijgrKQ
 TDX2EWZNZcs/BWgblyTv5fT9+Ny7et7HhLXPqPadxvdrYI+Vhv3N+ZMSpIw==
X-Received: by 2002:a05:6808:6149:b0:384:27f0:bd0a with SMTP id
 dl9-20020a056808614900b0038427f0bd0amr4550096oib.9.1679294663779; 
 Sun, 19 Mar 2023 23:44:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set8/x5v4RJAHfHMpElqM9DBkhd3MrwwIvBh66K8WacEukeIsbm7oWzKAc7EdD3d7CGFmUOnH4B7PiFeeSbqvCpk=
X-Received: by 2002:a05:6808:6149:b0:384:27f0:bd0a with SMTP id
 dl9-20020a056808614900b0038427f0bd0amr4550091oib.9.1679294663501; Sun, 19 Mar
 2023 23:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230315072802.2400337-1-elic@nvidia.com>
 <20230315072802.2400337-2-elic@nvidia.com>
 <DM8PR12MB5480F5579E6305EB3A0AA61DDCBD9@DM8PR12MB5480.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5480F5579E6305EB3A0AA61DDCBD9@DM8PR12MB5480.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Mar 2023 14:44:12 +0800
Message-ID: <CACGkMEu-VtMPUBRbw+NYUwB85RZQ5g_psuT-dB-V6-gYcdUdrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa/mlx5: Extend driver support for new features
To: Parav Pandit <parav@mellanox.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

T24gRnJpLCBNYXIgMTcsIDIwMjMgYXQgOTo1OOKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVs
bGFub3guY29tPiB3cm90ZToKPgo+Cj4KPiA+IEZyb206IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPgo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxNSwgMjAyMyAzOjI4IEFNCj4gPgo+ID4g
RXh0ZW5kIHRoZSBwb3NzaWJsZSBsaXN0IGZvciBmZWF0dXJlcyB0aGF0IGNhbiBiZSBzdXBwb3J0
ZWQgYnkgZmlybXdhcmUuCj4gPiBOb3RlIHRoYXQgZGlmZmVyZW50IHZlcnNpb25zIG9mIGZpcm13
YXJlIG1heSBvciBtYXkgbm90IHN1cHBvcnQgdGhlc2UKPiA+IGZlYXR1cmVzLiBUaGUgZHJpdmVy
IGlzIG1hZGUgYXdhcmUgb2YgdGhlbSBieSBxdWVyeWluZyB0aGUgZmlybXdhcmUuCj4gPgo+ID4g
V2hpbGUgZG9pbmcgdGhpcywgaW1wcm92ZSB0aGUgY29kZSBzbyB3ZSB1c2UgZW51bSBuYW1lcyBp
bnN0ZWFkIG9mIGhhcmQKPiA+IGNvZGVkIG51bWVyaWNhbCB2YWx1ZXMuCj4gPgo+ID4gVGhlIG5l
dyBmZWF0dXJlcyBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlciBhcmUgdGhlIGZvbGxvd2luZzoKPiA+
Cj4gPiBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGCj4gPiBWSVJUSU9fTkVUX0ZfSE9TVF9VRk8KPiBV
Rk8gaXMgZGVwcmVjYXRlZCBpbiBMaW51eCBrZXJuZWwsIHRoZXJlIGFyZSBubyBrbm93biB1c2Vy
IGVpdGhlciBhbmQgd2UgZG8gbm90IHBsYW4gdG8gc3VwcG9ydCBpdC4KCk5vdGUgdGhhdCB0aGVy
ZSdzIGFuIGVtdWxhdGlvbiBjb2RlIGZvciBwcmVzZXJ2aW5nIG1pZ3JhdGlvbgpjb21wYXRpYmls
aXR5IGluIHRoZSBrZXJuZWwuCgo+IFBsZWFzZSByZW1vdmUgdGhpcyBlbnRyeSBhbG9uZyB3aXRo
IGJlbG93IEdVRVNUX1VGTy4KCklmIHRoZXJlJ3Mgbm8gcGxhbiBmb3Igc3VwcG9ydGluZyBtaWdy
YXRpb24gZnJvbSBleGlzdGluZyBzb2Z0d2FyZQpiYWNrZW5kcywgd2UgY2FuIHJlbW92ZSB0aGlz
LgoKVGhhbmtzCgo+Cj4gPiBWSVJUSU9fTkVUX0ZfSE9TVF9FQ04KPiA+IFZJUlRJT19ORVRfRl9H
VUVTVF9VRk8KPiA+IFZJUlRJT19ORVRfRl9HVUVTVF9FQ04KPiA+IFZJUlRJT19ORVRfRl9HVUVT
VF9UU082Cj4gPiBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNAo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
