Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B68C43460
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 22:33:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294CF613C3
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 22:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294CF613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9F9760BFC;
	Tue, 13 Apr 2021 22:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kOQfu8ql6S-w; Tue, 13 Apr 2021 22:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66B760C2D;
	Tue, 13 Apr 2021 22:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D860C000C;
	Tue, 13 Apr 2021 22:33:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7307CC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FE5E40EF5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jhORRoik-F8J
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:33:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52EBA40EE8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:33:08 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 p6-20020a9d69460000b029028bb7c6ff64so1518822oto.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p1ePcMHRiUHLqxmNB1ISxMsad9RE0A3Rj2w0thaVuAM=;
 b=sc3Iy3Io/zqAZ1NI1n2LzcYMRbU2Hma6K4SwDp4iga7kYT+vQraryaQQvCIjMiJhH6
 /2Mr0xEIB3Og5qIFkgBaW9+KVTq+NpAGdu3qPIDma23CpGF64AjixfPfM7vn0nGrustq
 mu/8Buy/oWwuGB+dHSiP+PCo6vACvJgwSbDg8GeWlHznDKnOm///BErcT//t4uhwjmeE
 MNaA8j3EYnAH3J7C1OCLgni7yE22riSLdJzD64DRHYaitRi70c3mFImQnmwNzQIcc2WG
 Vk3E0YMudZxsgINQXCx9rNRKFcP09rCtGCdkhaM0eIqATqH9W4DwuBNVx8MP4d8/PM1l
 LW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p1ePcMHRiUHLqxmNB1ISxMsad9RE0A3Rj2w0thaVuAM=;
 b=JFskbq+xJuDZeuxnAMBfiXOIo/0l+NPjNfaHmYMIXPNSo7uDwtuvaRQyRyhE4O5fXt
 8xdMZSblj/8QW52yK9eDCodknOIFZvEQ3qJSjs+YQgA1KtXmiz+IwZXpd7hD+oysjX8+
 CJuzJ1ikx0+rBTjqMW+KSPoNvdp9h3RCmnZgSg0ygzTmG9wCiJiiXy2A4hJHk07da/AU
 4ChDiVW2r2oixWc2V13tZ6rJItXT6wYAj7WfPeZhRmh0qXU5b3h6axrEYI4v9Fx9/xF2
 TlJ7UGCeynluRXtgYIlwgCBwaNXZdzcf0X9Sg1uuUssN9whcZE6THUvvxt5XVrfsCh7U
 jY8A==
X-Gm-Message-State: AOAM531KCXuCBE8Oec9RmtD8RASpYCR3/0assRwhwHBWe5uBtcFWhk2K
 AZyGlsNo6Amct3Wy5M7+SMfF3zhb1xQMcLeH+yomfQ==
X-Google-Smtp-Source: ABdhPJyJi2RekjwUCi3f9BBegVtt9gF6yyk5dHlwVdmGKFv4Q3NOtFEaSkK8Ue82hymvSus3Wmj7/c1lCdBXCZTZHVE=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr29399427otk.279.1618353187987; 
 Tue, 13 Apr 2021 15:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210406183112.1150657-1-jiang.wang@bytedance.com>
 <1D46A084-5B77-4803-8B5F-B2F36541DA10@vmware.com>
 <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
 <4FE66B72-E16B-474D-9A17-70B3BCCD5A19@vmware.com>
In-Reply-To: <4FE66B72-E16B-474D-9A17-70B3BCCD5A19@vmware.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 13 Apr 2021 15:32:57 -0700
Message-ID: <CAP_N_Z8Jp4jbEZ5MjDO7Cj=WsPgB=rZ-ANcPW=4vfpsrDryBRw@mail.gmail.com>
Subject: Re: [RFC] vsock: add multiple transports support for dgram
To: Jorgen Hansen <jhansen@vmware.com>
Cc: "cong.wang@bytedance.com" <cong.wang@bytedance.com>,
 "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
 Andra Paraschiv <andraprs@amazon.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMjowMiBBTSBKb3JnZW4gSGFuc2VuIDxqaGFuc2VuQHZt
d2FyZS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4gT24gNyBBcHIgMjAyMSwgYXQgMjA6MjUsIEppYW5n
IFdhbmcgLiA8amlhbmcud2FuZ0BieXRlZGFuY2UuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQs
IEFwciA3LCAyMDIxIGF0IDI6NTEgQU0gSm9yZ2VuIEhhbnNlbiA8amhhbnNlbkB2bXdhcmUuY29t
PiB3cm90ZToKPiA+Pgo+ID4+Cj4gPj4+IE9uIDYgQXByIDIwMjEsIGF0IDIwOjMxLCBKaWFuZyBX
YW5nIDxqaWFuZy53YW5nQGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+ID4+Pgo+ID4+PiBGcm9tOiAi
amlhbmcud2FuZyIgPGppYW5nLndhbmdAYnl0ZWRhbmNlLmNvbT4KPiA+Pj4KPiA+Pj4gQ3VycmVu
dGx5LCBvbmx5IFZNQ0kgc3VwcG9ydHMgZGdyYW0gc29ja2V0cy4gVG8gc3VwcG9ydGVkCj4gPj4+
IG5lc3RlZCBWTSB1c2UgY2FzZSwgdGhpcyBwYXRjaCByZW1vdmVzIHRyYW5zcG9ydF9kZ3JhbSBh
bmQKPiA+Pj4gdXNlcyB0cmFuc3BvcnRfZzJoIGFuZCB0cmFuc3BvcnRfaDJnIGZvciBkZ3JhbSB0
b28uCj4gPj4KPiA+PiBDb3VsZCB5b3UgcHJvdmlkZSBzb21lIGJhY2tncm91bmQgZm9yIGludHJv
ZHVjaW5nIHRoaXMgY2hhbmdlIC0gYXJlIHlvdQo+ID4+IGxvb2tpbmcgYXQgaW50cm9kdWNpbmcg
ZGF0YWdyYW1zIGZvciBhIGRpZmZlcmVudCB0cmFuc3BvcnQ/IFZNQ0kgZGF0YWdyYW1zCj4gPj4g
YWxyZWFkeSBzdXBwb3J0IHRoZSBuZXN0ZWQgdXNlIGNhc2UsCj4gPgo+ID4gWWVzLCBJIGFtIHRy
eWluZyB0byBpbnRyb2R1Y2UgZGF0YWdyYW0gZm9yIHZpcnRpbyB0cmFuc3BvcnQuIEkgd3JvdGUg
YQo+ID4gc3BlYyBwYXRjaCBmb3IKPiA+IHZpcnRpbyBkZ3JhbSBzdXBwb3J0IGFuZCBhbHNvIGEg
Y29kZSBwYXRjaCwgYnV0IHRoZSBjb2RlIHBhdGNoIGlzIHN0aWxsIFdJUC4KPgo+IE9oIG9rLiBD
b29sLiBJIG11c3QgaGF2ZSBtaXNzZWQgdGhlIHNwZWMgcGF0Y2ggLSBjb3VsZCB5b3UgcHJvdmlk
ZSBhIHJlZmVyZW5jZSB0bwo+IGl0PwoKU3VyZS4gaGVyZSBpcyB0aGUgbGluazoKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL3BpcGVybWFpbC92aXJ0dWFsaXphdGlvbi8yMDIxLUFw
cmlsLzA1MzU0My5odG1sCgo+ID4gV2hlbiBJIHdyb3RlIHRoaXMgY29tbWl0IG1lc3NhZ2UsIEkg
d2FzIHRoaW5raW5nIG5lc3RlZCBWTSBpcyB0aGUgc2FtZSBhcwo+ID4gbXVsdGlwbGUgdHJhbnNw
b3J0IHN1cHBvcnQuIEJ1dCBub3csIEkgcmVhbGl6ZSB0aGV5IGFyZSBkaWZmZXJlbnQuCj4gPiBO
ZXN0ZWQgVk1zIG1heSB1c2UKPiA+IHRoZSBzYW1lIHZpcnR1YWxpemF0aW9uIGxheWVyKEtWTSBv
biBLVk0pLCBvciBkaWZmZXJlbnQgdmlydHVhbGl6YXRpb24gbGF5ZXJzCj4gPiAoS1ZNIG9uIEVT
WGkpLiBUaGFua3MgZm9yIGxldHRpbmcgbWUga25vdyB0aGF0IFZNQ0kgYWxyZWFkeSBzdXBwb3J0
ZWQgbmVzdGVkCj4gPiB1c2UgY2FzZXMuIEkgdGhpbmsgeW91IG1lYW4gVk1DSSBvbiBWTUNJLCBy
aWdodD8KPgo+IFJpZ2h0LCBvbmx5IFZNQ0kgb24gVk1DSS4KCkdvdCBpdC4gdGhhbmtzLgoKPiBJ
4oCZbGwgcmVzcG9uZCB0byBTdGVmYW5v4oCZcyBlbWFpbCBmb3IgdGhlIHJlc3Qgb2YgdGhlIGRp
c2N1c3Npb24uCj4KPiBUaGFua3MsCj4gSm9yZ2VuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
