Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17775C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 03:01:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97F860ED5
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 03:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A97F860ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7069A4043C;
	Wed, 18 Aug 2021 03:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxFmpW1YR6ky; Wed, 18 Aug 2021 03:01:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04B3A402DF;
	Wed, 18 Aug 2021 03:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D76E8C001A;
	Wed, 18 Aug 2021 03:01:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B007DC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89366401D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RebphlkuXuP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:01:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4127A40019
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 03:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629255680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8abgT4OMbQkDmW+JFU/gLD7f3GzcDwpJrA21w7JgCyA=;
 b=HyNplaFsp8U4WN03ZJ5RxwvW9tw1ER02MOkDoPtqmRY/ZSQFEIzUm7VlA+QlrVpVCdkx0N
 KtAsr41pcYFkyWPhKzzziHMEg+MkhJ9kwIVMDaErhYj3VobpvZm3pvEt8/dbbl+4KhcCf5
 CDJx13ekVJiwZVkdWplyyKlmfuiTUls=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-_UNqsk3TMkSF-eCJcA2TKw-1; Tue, 17 Aug 2021 23:01:19 -0400
X-MC-Unique: _UNqsk3TMkSF-eCJcA2TKw-1
Received: by mail-lf1-f71.google.com with SMTP id
 c22-20020a0565121056b02903c8d745ff5cso236815lfb.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 20:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8abgT4OMbQkDmW+JFU/gLD7f3GzcDwpJrA21w7JgCyA=;
 b=U9i/VP5Pg1aC0zITgJdGrJmiiKAXvDKekkhHpDlK5BlnnAMkStnxLEQycKFyM1/q4b
 OalT30MoqMHxc6X1iqBbGw3x8Nr+4KgOut4YK3qVocVXjOIKf1BtrtVQpe3p43+6Sx/X
 Z03golutolPdfsYmcvnJ8FVdK/rBQCtHvkHc3HrvCm3sb1KkcSclQ3/pR/NAbakPTlTC
 O6nGpcsNhTz/1pbZEjE89Z4YIVlE3FtJccx6DgfRtpUtfFFzKEmfWerUrrRqiw4/RKwX
 HW/al7Zdb0a7ieT6/kcjSqeqZUKqYHD1zQ4QgH3J2r7CyjRdJhGUdCAGzZXaHJf1fTTl
 ttZA==
X-Gm-Message-State: AOAM5335vHfnE6bz/0+c4+G2AybMBH2lEsK2Xe2tO5qb4+/RbMC5nCvH
 DF56WHoctRQCMy0k5sUSQ6d67P5bX95gryHcSexwaf9+8GcIDfQn8O07vr7ZSbwL/J18U2eXyh4
 HPP4i3W5jnBZl83rhASdLDbItdcwG+cQ5olzyGjRBIDPHBASXUNkJG56beA==
X-Received: by 2002:a2e:2414:: with SMTP id k20mr5873845ljk.482.1629255678029; 
 Tue, 17 Aug 2021 20:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7WvBIWCDHz8A6jpCzPR6jA3hAAQdEyVQdArLCho+mKfNLty+F4b4Wii1ay7ZqoIMIUz1pIwpXflATWmqFOGU=
X-Received: by 2002:a2e:2414:: with SMTP id k20mr5873825ljk.482.1629255677756; 
 Tue, 17 Aug 2021 20:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
 <PH0PR12MB5481B0AC416186D7B20FCB26DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d54f2e9b-1a04-7118-5c39-c93997eb2afd@redhat.com>
 <20210817052644.GB74703@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEssyoArFmGhHL_sT0mNW_mvd-e9HeJXCMrUnzZggMr8yA@mail.gmail.com>
 <20210817060136.GA75939@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEtj6KRGSJFdqrSEmEktkDN5RPec9nc46p+SQjjUeLM2sQ@mail.gmail.com>
In-Reply-To: <CACGkMEtj6KRGSJFdqrSEmEktkDN5RPec9nc46p+SQjjUeLM2sQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Aug 2021 11:01:06 +0800
Message-ID: <CACGkMEvJUQaUB68CUMibJZRQdXvb9VWDukj=iPti8UTzJAW73g@mail.gmail.com>
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgNDo1NyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgQXVnIDE3LCAyMDIxIGF0IDI6MDEgUE0gRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwgQXVnIDE3LCAyMDIx
IGF0IDAxOjQ4OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgQXVn
IDE3LCAyMDIxIGF0IDE6MjYgUE0gRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+IHdyb3RlOgo+
ID4gPiA+Cj4gPiA+ID4gT24gVHVlLCBBdWcgMTcsIDIwMjEgYXQgMTI6MTk6NTVQTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiDlnKggMjAyMS84LzE3IOS4i+WN
iDEyOjAzLCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+ID4gPiA+ID4gPiA+IEZyb206IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgQXVn
dXN0IDE3LCAyMDIxIDk6MjYgQU0KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwg
QXVnIDE3LCAyMDIxIGF0IDM6MzcgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT4KPiA+ID4gPiA+ID4gPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDE2LCAy
MDIxIGF0IDA3OjU2OjU5UE0gKzAzMDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
ID4gT24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDE6NTg6MDZQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiDlnKggMjAyMS84LzE2IOS4i+WNiDE6NDcsIEVsaSBD
b2hlbiDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBNb24sIEF1ZyAxNiwgMjAyMSBh
dCAxMjoxNjoxNFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiDlnKggMjAyMS84LzEyIOS4i+WNiDU6NTAsIEVsaSBDb2hlbiDlhpnpgZM6Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMDM6MDQ6MzVQTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IOWcqCAyMDIx
LzgvMTIg5LiL5Y2IMzowMSwgRWxpIENvaGVuIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMDI6NDc6MDZQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAx
MiwgMjAyMSBhdCAxMjo1NSBQTSBFbGkgQ29oZW4KPiA+ID4gPiA+ID4gPiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVn
IDEyLCAyMDIxIGF0IDExOjE5OjE5QU0gKzA4MDAsIEphc29uIFdhbmcKPiA+ID4gPiA+ID4gPiB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMSDk
uIvljYg3OjA0LCBFbGkgQ29oZW4g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDA0OjM3OjQ0UE0gKzA4MDAsIEphc29u
Cj4gPiA+ID4gPiA+ID4gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IOWcqCAyMDIxLzgvMTEg5LiL5Y2IMzo1MywgRWxpIENvaGVuIOWGmemBkzoKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBPbmUgdGhpbmcgbmVlZCB0
byBzb2x2ZSBmb3IgbXEgaXMgdGhhdCB0aGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK3N0YXRpYyB1
MTYgY3RybF92cV9pZHgoc3RydWN0Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiArbWx4NV92ZHBhX2RldiAqbXZkZXYpIHsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgIHJldHVybiAyICoKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICttbHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+
bWF4X3Zxcyk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAr
fQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdlIHNob3VsZCBo
YW5kbGUgdGhlIGNhc2Ugd2hlbiBNUSBpcwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlIGJ1dCBub3QgdGhlIGRyaXZlci4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEUuZyBpbiB0aGUgY2FzZSB3aGVuIHdlIGhh
dmUgMiBxdWV1ZSBwYWlyczoKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoZW4gTVEg
aXMgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFdoZW4gTVEgaXMgbm90IGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSAyCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gVGhlcmUncyBzb21lIGlzc3VlIHdpdGggdGhpcy4gSSBnZXQKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2FsbGJhY2tzIHRhcmdldGluZyBzcGVj
aWZpYyB2aXJ0cXVldWVzIGJlZm9yZQo+ID4gPiA+ID4gPiA+IGZlYXR1cmVzIG5lZ290aWF0aW9u
IGhhcyBiZWVuIGNvbXBsZXRlZC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gU3BlY2lmaWNhbGx5LCBJIGdldCBzZXRfdnFfY2IoKSBjYWxscy4gQXQKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdGhpcyBwb2ludCBJIG11c3Qga25vdyB0
aGUgY29udHJvbCB2cSBpbmRleC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IFNvIEkgdGhpbmsgd2UgbmVlZCBkbyBib3RoOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDEp
IEF0IG9uZSBoYW5kLCBpdCdzIGEgYnVnIGZvciB0aGUgdXNlcnNwYWNlCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0byB1c2UgdnFfaW5kZXggYmVmb3JlIGZlYXR1cmUg
aXMgbmVnb3RpYXRlZAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IChsb29rcyBsaWtlIGEgYnVnIGlu
IG15IGN2cSBzZXJpZXMgdGhhdCB3aWxsCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBjYWxsIFNFVF9WUklOR19DQUxMIGJlZm9yZSBmZWF0dXJlIGlzIG5lZ290aWF0ZSwK
PiA+ID4gPiA+ID4gPiB3aGljaCBJIHdpbGwgbG9vaykuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiAyKSBBdCB0aGUgb3RoZXIgaGFuZCwgdGhlIGRyaXZlciBzaG91bGQg
YmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGFibGUgdG8gZGVhbCB3
aXRoIHRoYXQKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWxsIEkgY2FuIGRvIGlzIGRyb3AgY2FsbGJh
Y2tzIGZvciBWUXMgYmVmb3JlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
ZmVhdHVyZXMgbmVnb3RhdGlvbiBoYXMgYmVlbiBjb21wbGV0ZWQuCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IE9yIGp1c3QgbGVhdmUgcXVldWUgaW5kZXggMCwgMSB3b3JrLgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBTaW5jZSBpdCBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgY2hhbmdlZC4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFJpZ2h0LCB3aWxsIGRvLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSB0aGluayB0aGUg
Q1ZRIGluZGV4IG11c3Qgbm90IGRlcGVuZCBvbiB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gbmVnb3RpYXRlZCBmZWF0dXJlcyBidXQgcmF0aGVyIGRlcGVuZCBv
ZiB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gdmFsdWUgdGhl
IGRldmljZSBkcml2ZXIgcHJvdmlkZXMgaW4gdGhlIGNhbGwgdG8KPiA+ID4gPiA+ID4gPiBfdmRw
YV9yZWdpc3Rlcl9kZXZpY2UoKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IEF0IHRoZSB2aXJ0aW8gbGV2ZWwsIGl0J3MgdG9vIGxhdGUgdG8gY2hhbmdlCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGF0IGFuZCBpdCBicmVha3MgdGhlIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQnV0IGF0IHRoZSB2
RFBBIGxldmVsLCB0aGUgdW5kZXIgbGF5ZXIgZGV2aWNlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBjYW4gbWFwIHZpcnRpbyBjdnEgdG8gYW55IG9mIGl0J3MgdmlydHF1
ZXVlLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEUuZyBtYXAgY3ZxIChpbmRleCAyKSB0byBtbHg1
IGN2cSAodGhlIGxhc3QpLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFtIG5vdCBmb2xsb3dpbmcg
eW91IGhlcmUuIEkgc3RpbGwgZG9uJ3Qga25vdyB3aGF0Cj4gPiA+ID4gPiA+ID4gaW5kZXggaXMg
Y3ZxLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBSaWdodCwgd2Ugc3RpbGwg
bmVlZCB0byB3YWl0IGZvciB0aGUgZmVhdHVyZSBiZWluZwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBuZWdvdGlhdGVkIGluIG9yZGVyIHRvIHByb2NlZWQuCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBTbyB0byBzdW1tYXJpc2UsIGJlZm9yZSBmZWF0dXJlIG5lZ290aWF0aW9uCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjb21wbGV0ZSwgSSBhY2NlcHQgY2FsbHMgcmVmZXJyaW5n
IHRvIFZRcyBvbmx5IGZvciBpbmRpY2VzIDAKPiA+ID4gPiA+ID4gPiBhbmQgMS4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEFmdGVyIGZlYXR1cmUgbmVnb3RpYXRpb24gY29tcGxl
dGUgSSBrbm93IENWUSBpbmRleAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYW5k
IHdpbGwgYWNjZXB0IGluZGljZXMgMCB0byBjdnEgaW5kZXguCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gSSBkb24ndCBnZXQgdGhpcyAiYWNjZXB0IGluZGljZXMgMCB0byBjdnEgaW5k
ZXgiLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGF0IEkgbWVhbnQgdG8gc2F5IGlz
IHRoYXQgdGhlcmUgYXJlIHNldmVyYWwgY2FsbGJhY2tzCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHRoYXQgcmVmZXIgdG8gc3BlY2lmaWMgdmlydHF1ZXVlcywgZS5nLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBzZXRfdnFfYWRkcmVzcygpLCBzZXRfdnFfbnVtKCkgZXRjLiBU
aGV5IGFsbCBhY2NlcHQgdmlydHF1ZXVlCj4gPiA+ID4gPiA+ID4gaW5kZXggYXMgYW4gYXJndW1l
bnQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgd2Ugd2FudCB0byBkbyBpcyB2
ZXJpZnkgd2hlYXRoZXIgdGhlIGluZGV4IHByb3ZpZGVkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IGlzIHZhbGlkIG9yIG5vdC4gSWYgaXQgaXMgbm90IHZhbGlkLCBlaXRoZXIgcmV0dXJu
IGVycm9yCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IChpZiB0aGUgY2FsbGJhY2sgY2Fu
IHJldHVybiBhIHZhbHVlKSBvciBqdXN0IGF2b2lkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IHByb2Nlc3NpbmcgaXQuIElmIHRoZSBpbmRleCBpcyB2YWxpZCB0aGVuIHdlIHByb2Nlc3Mg
aXQgbm9ybWFsbHkuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IE5vdyB3ZSBuZWVkIHRvIGRlY2lkZSB3aGljaCBpbmRleCBpcyB2YWxp
ZCBvciBub3QuIFdlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5lZWQgc29tZXRoaW5n
IGxpa2UgdGhpcyB0byBpZGVudGlmaXkgdmFsaWQgaW5kZXhlcyByYW5nZToKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ1ZRIGNsZWFy
OiAwIGFuZCAxCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENWUSBzZXQsIE1RIGNsZWFy
OiAwLCAxIGFuZCAyIChmb3IgQ1ZRKS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQ1ZR
IHNldCwgTVEgc2V0OiAwLi5udnEgd2hlcmUgbnZxIGlzIHdoYXRldmVyIHByb3ZpZGVkCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRvCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBZZXMu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFVu
Zm9ydHVuYXRlbHkgaXQgZG9lcyBub3Qgd29yay4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBz
ZXRfdnFfY2IoKSBmb3IgYWxsIHRoZSBtdWx0aXF1ZXVlcyBpcyBjYWxsZWQgYmVvZnJlIGZlYXR1
cmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBuZWdvdGlhdGlvbi4gSWYgSSBhcHBseSB0aGUg
YWJvdmUgbG9naWMsIEkgd2lsbCBsb3NlIHRoZXNlIHNldHRpbmdzLgo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gSSBjYW4gbWFrZSBhbiBleGNlcHRp
b24gZm9yIHNldF92cV9jYigpLCBzYXZlIGNhbGxiYWNrcyBhbmQKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiByZXN0b3JlIHRoZW0gYWZ0ZXJ3YXJkcy4gVGhpcyBsb29rcyB0b28gY29udm9sdXRl
ZCBhbmQgbWF5YmUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB3ZSBzaG91bGQgc2VlayBhbm90
aGVyIHNvbHV0aW9uLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIGFncmVlLgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBSZXRoaW5rIGFib3V0IHRoaXMgaXNzdWUuIEl0IGxvb2tzIHRvIHRoZSBvbmx5IGlzc3VlIHdl
IGZhY2UKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXMgdGhlIHNldF92cV9jYigpLgo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaXRoIHRoZSBhc3N1bXB0
aW9uIHRoYXQgdGhlIHVzZXJzcGFjZSBjYW4gdXNlIHRoZSBpbmRleAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBjb3JyZWN0bHkgKGV2ZW4gYmVmb3JlIHNldF9mZWF0dXJlcykuIEkgd29uZGVyIHRo
ZSBmb2xsb3dpbmcgd29ya3MuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IEluc3RlYWQgb2YgY2hlY2tpbmcgd2hldGhlciB0aGUgaW5kZXggaXMgY3ZxIGlu
IHNldF92cV9jYigpIGhvdwo+ID4gPiA+ID4gPiA+IGFib3V0Ogo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAxKSBkZWNvdXBsZSBldmVudF9jYiBvdXQgb2YgbWx4NV92ZHBhX3ZpcnRxdWV1ZSBhbmQK
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbWx4NV9jb25ncm9fdnEKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gMikgaGF2ZSBhIGRlZGljYXRlZCBldmVudF9jYiBhcnJheSBpbiBtbHg1X3ZkcGFfbmV0
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDMpIHRoZW4gd2UgY2FuIGRvCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG5kZXYtPmV2ZW50X2Nic1tpbmRleF0g
PSAqY2I7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBTbyBh
Y3R1YWxseSB5b3UncmUgc3VnZ2VzdGluZyB0byBzYXZlIGFsbCB0aGUgY2FsbGFiY2sKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb25zIGluIGFuIGFycmF5IGFuZCBldmFsdWF0ZSBj
dnEgaW5kZXggYWZ0ZXIgZmVhdHVyZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbmVnb3RpYXRpb24g
aGFzIGJlZW4gY29tcGxldGVkLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
ID4gWWVzLgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IEkgdGhpbmsgdGhhdCBjb3VsZCB3b3JrLiBJIHdpbGwgY29kZSB0aGlzIGFu
ZCB1cGRhdGUuCj4gPiA+ID4gPiA+ID4gPiA+IEl0IHdvcmtzIGZpbmUgd2hlbiBJIGFtIHdvcmtp
bmcgd2l0aCB5b3VyIHZlcnNpb24gb2YgcWVtdSB3aXRoCj4gPiA+ID4gPiA+ID4gPiA+IHN1cHBv
cnQgZm9yIG11bHRpIHF1ZXVlLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiBU
aGUgcHJvYmxlbSBpcyB0aGF0IGl0IGlzIGJyb2tlbiBvbiBxZW11IHY2LjAuMC4gSWYgSSByZWdp
c3RlciBteQo+ID4gPiA+ID4gPiA+ID4gPiB2ZHBhIGRldmljZSB3aXRoIG1vcmUgdGhhbiAyIGRh
dGEgdmlydHF1ZXVlcywgcWVtdSB3b24ndCBldmVuIGNyZWF0ZQo+ID4gPiA+ID4gPiA+ID4gPiBh
IG5ldGRldmljZSBpbiB0aGUgVk0uCj4gPiA+ID4gPiA+ID4gUWVtdSBzaG91bGQgaGlkZSBNUSBm
ZWF0dXJlIGluIHRoaXMgY2FzZSBidXQgbG9va3MgbGlrZSBpdCBkb2Vzbid0Lgo+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gV2lsbCBoYXZlIGEgbG9vay4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gPiBJIGFtIG5vdCBzdXJlIGhvdyB0byBoYW5kbGUgdGhpcy4gSXMgdGhlcmUgc29t
ZSBraW5kIG9mIGluZGljYXRpb24gSQo+ID4gPiA+ID4gPiA+ID4gPiBjYW4gZ2V0IGFzIHRvIHRo
ZSB2ZXJzaW9uIG9mIHFlbXUgc28gSSBjYW4gYXZvaWQgdXNpbmcgbXVsdGlxdWV1ZQo+ID4gPiA+
ID4gPiA+ID4gPiBmb3IgdmVyc2lvbnMgSSBrbm93IGFyZSBwcm9ibGVtYXRpYz8KPiA+ID4gPiA+
ID4gPiA+IE5vIHZlcnNpb25zIDspIFRoaXMgaXMgd2hhdCBmZWF0dXJlIGJpdHMgYXJlIGZvciAu
Li4KPiA+ID4gPiA+ID4gPiBZZXMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBTbyBkb2Vz
IGl0IHdvcmsgaWYgIm1xPW9mZiIgaXMgc3BlY2lmaWVkIGluIHRoZSBjb21tYW5kIGxpbmU/Cj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2Ugc2hvdWxkIG5vdCBhZGQgZHJpdmVyIG1vZHVsZSBw
YXJhbWV0ZXIuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IE5vdGUgdGhhdCwgaXQncyBu
b3QgYSBtb2R1bGUgcGFyYW1ldGVyIGJ1dCBhIHFlbXUgY29tbWFuZCBsaW5lIHRvIGRpc2FibGUg
bXEKPiA+ID4gPiA+IGZlYXR1cmUuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2Ug
YW55d2F5IG5lZWQgbnVtYmVyIG9mIFZRcyB0byBiZSBkcml2ZW4gYnkgdGhlIG51bWJlciBvZiB2
Y3B1cyB1c2VkIGJ5IHRoZSBWTS4KPiA+ID4gPiA+ID4gU28gd2h5IG5vdCBzcGVjaWZ5IHRoaXMg
d2hlbiBjcmVhdGluZyBhIHZkcGEgZGV2aWNlPwo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBZZXMsIEkgdGhpbmsgaXQgc2hvdWxkIHdvcmsgYXMgd2VsbC4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBTbyBtYW5hZ2VtZW50IG5lZWQgZWl0aGVyOgo+ID4gPiA+ID4KPiA+ID4gPiA+IDEpIGRpc2Fi
bGUgbXVsdGlxdWV1ZSB2aWEgIm1xPW9mZiIKPiA+ID4gPiA+Cj4gPiA+ID4gPiBvcgo+ID4gPiA+
ID4KPiA+ID4gPiA+IDIpIHVzaW5nIG5ldGxpbmsgQVBJIHRvIGNyZWF0ZSBhIHNpbmdsZSBxdWV1
ZSBwYWlyIGRldmljZQo+ID4gPiA+ID4KPiA+ID4gPiA+IGZvciB0aGUgcWVtdSA8PTYuMS4KPiA+
ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBXaGljaCBtYW5hZ2VtZW50IGVudGl0eSBhcmUgeW91IHJl
ZmVycmluZyB0byBoZXJlPwo+ID4gPgo+ID4gPiBUaGUgb25lIHRoYXQgbGF1bmNoZXMgUWVtdS4g
KEUuZyBsaWJ2aXJ0IG9yIG90aGVyKS4KPiA+ID4KPiA+Cj4gPiBCdXQgd2Ugd2FudCB0byBmaW5k
IGEgc29sdXRpb24gd2l0aCBleGlzdGluZyBwYWNrYWdlcy4gSWYgbW9kaWZ5aW5nIGNvZGUKPiA+
IGV4aXN0aW5nIGNvZGUgaXMgdGhlIHNvbHV0aW9uLCB3ZSBjb3VsZCBmaXggcWVtdS4KPgo+IFJp
Z2h0Lgo+Cj4gPgo+ID4gQXMgSSByZXBvcnRlZCBpbiBhbm90aGVyIGVtYWlsLCBtcT1vZmYgYXZv
aWRzIHRoaXMgcHJvYmxlbS4gU28gdXNlcnMKPiA+IHdpbGwgaGF2ZSB0byB1c2UgdGhpcyB3aGVu
IHVzaW5nIG5ldyBkcml2ZXIgd2l0aCBvbGQgcWVtdS4KPgo+IFllcywgc28gdGhpcyBpcyBhY3R1
YWxseSB0aGUgb3B0aW9uIDEpIGFib3ZlLgoKTm90ZSB0aGF0IGFjdHVhbGx5LCBtcT1vZmYgaXMg
dGhlIGRlZmF1bHQgb3B0aW9uLiBTbyB3ZSBhcmUgcHJvYmFibHkgZmluZSBoZXJlLgoKVGhhbmtz
Cgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiBU
aGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+
ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
