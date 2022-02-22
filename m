Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7358CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 03:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF89060B6A;
	Tue, 22 Feb 2022 03:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfOOFjwbfInd; Tue, 22 Feb 2022 03:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEDA960A84;
	Tue, 22 Feb 2022 03:18:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94C0AC001A;
	Tue, 22 Feb 2022 03:18:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D8FEC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED1F94049E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QjC-UfJhn4g4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:18:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6ED80401D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645499908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sbbbtab3VaMxO4yQFX5W0jTsH+JrGVx3U7saZmDLd/E=;
 b=T+04mZM1ysLsPMjenxgoOaBA0+KvwpIKSTM0NbRBaBDU4dehAzOFUh0Qzlz7+PKaLwF29a
 4CrOw8zBKTKDKhp4GgwsuQUxyxR/wX443ITMTH6ogOmWsUPqtwiWZhMWvAIRj9Bx/X2F5b
 X31UvXhrHCg9L9xHaD/cltjZgdPR1qM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-wJMwMp90NcGlnS4nTBbIVw-1; Mon, 21 Feb 2022 22:18:27 -0500
X-MC-Unique: wJMwMp90NcGlnS4nTBbIVw-1
Received: by mail-lj1-f199.google.com with SMTP id
 20-20020a05651c009400b002462f08f8d2so3282975ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 19:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Sbbbtab3VaMxO4yQFX5W0jTsH+JrGVx3U7saZmDLd/E=;
 b=zmfGf0SQvA64uYW/3vb2CuMoBwrDs4LP4pfXRzw2yiqZw6ltyDOUmJY6lgGdbIN3wN
 PlYslc7396LQxZVM0LBtpvnGBT/zaxZSzcWe8kgwQskFmxXtNuWF2H88j/35Fpj9Benh
 +p7PsVVuX3n6FlTieXPTHVBKmdK6mmCxsnal/RNPm1Z5F0GUzxsh0J41/YGQ8MZT15gk
 U7GWfWAMznK+aaO7zrKohu24RVtOVhBVjgutZows4U11bN5LC0881MWnXPQC1QArPUR9
 SWt4Mjgz1b9U4/H9u1G9+/535sqcqnuv25ahuYK4VR8L6WhhzLplOOIIOZmKReprJRQ6
 ORjA==
X-Gm-Message-State: AOAM532RvLVnr+DZscxgKIDBk7fDfc1Hdlw6dAwELXiLLr+hrdthb/mk
 8fNotr9XdP+or6VfgeEAehjBqUJmkrTLXPvoZ/m3EQXcPTupb9vig6bedYFDn35Sfj1zhZWMmJ9
 vH1e8CH5zNR9k7J5yzx91hQZ/XEFZ1kAMliNp+4cPixvDWJFXmozQbJPwlg==
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr16095464lji.420.1645499905589; 
 Mon, 21 Feb 2022 19:18:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj4rAFN7oU2652DYiUiHQjMAOymxuksQuEOj7cP10UVlSS/mziWcvTT/SdqGjsQBVmBeSn4sxUUtH8SwLrrJ4=
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr16095449lji.420.1645499905411; Mon, 21
 Feb 2022 19:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20220221132020.198171-1-elic@nvidia.com>
 <CAJaqyWeOCs=QJkTU-GNYftgkbAk1XB=aLnJTxhJNMDh6_VaXsA@mail.gmail.com>
In-Reply-To: <CAJaqyWeOCs=QJkTU-GNYftgkbAk1XB=aLnJTxhJNMDh6_VaXsA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 11:18:14 +0800
Message-ID: <CACGkMEtZTFrw9Gp-YuvhuTDF5Taeum7zDRa_52NmCkvqSajkFA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Enlarge queue size to 512 entries
To: Eugenio Perez Martin <eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgMzowMCBBTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEZlYiAyMSwgMjAyMiBhdCAyOjIw
IFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3cm90ZToKPiA+Cj4gPiBDdXJyZW50bHkg
d2UgY2FuIHdvcmsgd2l0aCA1MTIgZW50cmllcyB3aXRoIGFueSBNVFUgc2l6ZS4gQ2hhbmdlCj4g
PiBNTFg1X1ZEUEFfTUFYX1ZRX0VOVFJJRVMgYWNjb3JkaW5nbHkuCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4gaW5kZXggYmUwOTVkYzExMzRlLi5kZTExNWUzZmU3NjEgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gQEAgLTIwNjIsNyArMjA2Miw3IEBAIHN0YXRpYyB2b2lk
IG1seDVfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0
IHZkcGFfY2FsbGJhCj4gPiAgICAgICAgIG5kZXYtPmNvbmZpZ19jYiA9ICpjYjsKPiA+ICB9Cj4g
Pgo+ID4gLSNkZWZpbmUgTUxYNV9WRFBBX01BWF9WUV9FTlRSSUVTIDI1Ngo+ID4gKyNkZWZpbmUg
TUxYNV9WRFBBX01BWF9WUV9FTlRSSUVTIDUxMgoKSSdkIGV4cGVjdCB0aGlzIHNob3VsZCBiZSBz
b21ldGhpbmcgdGhhdCBjYW4gYmUgcmVhZCBmcm9tIHRoZSBmdyBvcgpodz8gT3RoZXJ3aXNlIHdl
IGNhbid0IGluY3JlYXNlIGl0IGluIHRoZSBmdXR1cmUuCgpUaGFua3MKCj4gPiAgc3RhdGljIHUx
NiBtbHg1X3ZkcGFfZ2V0X3ZxX251bV9tYXgoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ID4g
IHsKPiA+ICAgICAgICAgcmV0dXJuIE1MWDVfVkRQQV9NQVhfVlFfRU5UUklFUzsKPiA+IC0tCj4g
PiAyLjM1LjEKPiA+Cj4KPiBBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
