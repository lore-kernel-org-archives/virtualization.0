Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F808C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 04:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 030F140153;
	Tue, 28 Jun 2022 04:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 030F140153
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PzFbshg6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6s7qk6bc8M9; Tue, 28 Jun 2022 04:01:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E78C40017;
	Tue, 28 Jun 2022 04:01:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E78C40017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 539A9C0039;
	Tue, 28 Jun 2022 04:01:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4229C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A827C60BCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A827C60BCF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PzFbshg6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ecSwGhzmiZ-z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:01:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0447607FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0447607FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656388877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdLK+h8IXLKnhKITMkQq24+hZBcrSjQqvNBN3RS5ans=;
 b=PzFbshg6BaRqkkjZOGk5gqZU45KNHNYRg80gMSAIUlo/vmJBv4llXscHrNy7zlmgbmKPqT
 l5u+H51V9n94ezo7PMzMu3kQ++G88MB2Hneu39muUZ00LNi2mXqJPNWIvME+wn0kt7GHc/
 FN2pVPvJ06gZ8S63iKWf64ItyTQ+oPI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-mdw6vsDjNkaWWq02ZQOEQQ-1; Tue, 28 Jun 2022 00:01:15 -0400
X-MC-Unique: mdw6vsDjNkaWWq02ZQOEQQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 bp15-20020a056512158f00b0047f603e5f92so5632993lfb.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 21:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rdLK+h8IXLKnhKITMkQq24+hZBcrSjQqvNBN3RS5ans=;
 b=05vJJOI4mrTkFBWHgxszqhCFvvUvjmZciW4f04CO4F+lxv8CZk6UDzNyT4Q77Ep+fE
 zKxTIlvwBxA6oWJV+j8IVJErZeWprHPJWDAl13Lx8RFdwog/sGuYX2r7bf747lL5Xxtb
 7lTwcXYICZscCc0BqlxCJNLQBVl9DyO5h71EQ8s/XzKHB/We+4apzAyXAYllEfAlVYPo
 Chdp44EcuyPV8l5wqzxXtdnaK8pES3lntuEW6H/s6TH67sPtPCCPzoEHbruWWKdtNG2A
 77YWhSFbbz47XRQpF3mKEeTa/BOuApVWnOK15d8iUbLhyGEMRCXvwmwZ8p2ZFoOaPBfl
 TDtw==
X-Gm-Message-State: AJIora+gF3M36TiDIUF91xruH+FmJVmOvt/ifT3NSbbIhx5rA2sMrNj4
 aYi0OtqVxODfuW7+r+zLCZdEYRhu21e6ob2DQo7Febow0L8fcF0FZWtTcyIKxd8tqVglL9RCQtu
 eOedcGCootIkE2gfi+ac+/EE/uPM4esjv39H1xFb6u1OB2zvu+ETbfoovAg==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr10025577lfa.124.1656388873994; 
 Mon, 27 Jun 2022 21:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEdcPj8h62S0wPUyO4y7EMiYdlRlcfqE+a+UWDr4hc96LAvzQ7xs0iHnAaZMvpywR5M5d6TAH2PYCfZdpL6qs=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr10025565lfa.124.1656388873794; Mon, 27
 Jun 2022 21:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621160859.196646-3-sgarzare@redhat.com>
 <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
 <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
In-Reply-To: <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Jun 2022 12:01:02 +0800
Message-ID: <CACGkMEvH-LFW3dvcaKNSmKyFG_SeBbTrPKtJOCwJHKMdtormJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per
 batch
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVGh1LCBKdW4gMjMsIDIwMjIgYXQgNDo1OCBQTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdW4gMjMsIDIwMjIgYXQgMTE6NTA6
MjJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+T24gV2VkLCBKdW4gMjIsIDIwMjIgYXQg
MTI6MDkgQU0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToK
PiA+Pgo+ID4+IExpbWl0IHRoZSBudW1iZXIgb2YgcmVxdWVzdHMgKDQgcGVyIHF1ZXVlIGFzIGZv
ciB2ZHBhX3NpbV9uZXQpIGhhbmRsZWQKPiA+PiBpbiBhIGJhdGNoIHRvIHByZXZlbnQgdGhlIHdv
cmtlciBmcm9tIHVzaW5nIHRoZSBDUFUgZm9yIHRvbyBsb25nLgo+ID4+Cj4gPj4gU3VnZ2VzdGVk
LWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPj4gLS0tCj4g
Pj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDE1ICsrKysrKysrKysr
KysrLQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9i
bGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+ID4+IGluZGV4IGE4
M2E1Yzc2ZjYyMC4uYWM4NjQ3ODg0NWI2IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmRwYS92
ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwo+ID4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbV9ibGsuYwo+ID4+IEBAIC0xOTcsNiArMTk3LDcgQEAgc3RhdGljIGJvb2wgdmRwYXNp
bV9ibGtfaGFuZGxlX3JlcShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwKPiA+PiAgc3RhdGljIHZv
aWQgdmRwYXNpbV9ibGtfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gPj4gIHsKPiA+
PiAgICAgICAgIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltID0gY29udGFpbmVyX29mKHdvcmssIHN0
cnVjdCB2ZHBhc2ltLCB3b3JrKTsKPiA+PiArICAgICAgIGJvb2wgcmVzY2hlZHVsZSA9IGZhbHNl
Owo+ID4+ICAgICAgICAgaW50IGk7Cj4gPj4KPiA+PiAgICAgICAgIHNwaW5fbG9jaygmdmRwYXNp
bS0+bG9jayk7Cj4gPj4gQEAgLTIwNiwxMSArMjA3LDE1IEBAIHN0YXRpYyB2b2lkIHZkcGFzaW1f
YmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4+Cj4gPj4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgVkRQQVNJTV9CTEtfVlFfTlVNOyBpKyspIHsKPiA+PiAgICAgICAgICAgICAg
ICAgc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlICp2cSA9ICZ2ZHBhc2ltLT52cXNbaV07Cj4gPj4g
KyAgICAgICAgICAgICAgIGJvb2wgdnFfd29yayA9IHRydWU7Cj4gPj4gKyAgICAgICAgICAgICAg
IGludCByZXFzID0gMDsKPiA+Pgo+ID4+ICAgICAgICAgICAgICAgICBpZiAoIXZxLT5yZWFkeSkK
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+Pgo+ID4+IC0gICAgICAg
ICAgICAgICB3aGlsZSAodmRwYXNpbV9ibGtfaGFuZGxlX3JlcSh2ZHBhc2ltLCB2cSkpIHsKPiA+
PiArICAgICAgICAgICAgICAgd2hpbGUgKHZxX3dvcmspIHsKPiA+PiArICAgICAgICAgICAgICAg
ICAgICAgICB2cV93b3JrID0gdmRwYXNpbV9ibGtfaGFuZGxlX3JlcSh2ZHBhc2ltLCB2cSk7Cj4g
Pj4gKwo+ID4KPiA+SXMgaXQgYmV0dGVyIHRvIGNoZWNrIGFuZCBleGl0IHRoZSBsb29wIGVhcmx5
IGhlcmU/Cj4KPiBNYXliZSwgYnV0IEknbSBub3Qgc3VyZS4KPgo+IEluIHZkcGFfc2ltX25ldCB3
ZSBjYWxsIHZyaW5naF9jb21wbGV0ZV9pb3RsYigpIGFuZCBzZW5kIG5vdGlmaWNhdGlvbgo+IGFs
c28gaW4gdGhlIGVycm9yIHBhdGgsCgpMb29rcyBub3Q/CgogICAgICAgICAgICAgICAgcmVhZCA9
IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmY3ZxLT52cmluZywgJmN2cS0+aW5faW92LCAmY3RybCwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGN0cmwp
KTsKICAgICAgICAgICAgICAgIGlmIChyZWFkICE9IHNpemVvZihjdHJsKSkKICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7CgpXZSBicmVhayB0aGUgbG9vcC4KClRoYW5rcwoKPiBzbyBJIHRo
b3VnaHQgd2FzIGJldHRlciB0byBzZW5kIG5vdGlmaWNhdGlvbgo+IGFsc28gd2hlbiB2ZHBhc2lt
X2Jsa19oYW5kbGVfcmVxKCkgcmV0dXJuIGZhbHNlLCBzaW5jZSB3ZSB3aWxsIHVwZGF0ZQo+IHRo
ZSB1c2VkLmlkeC4KPgo+IEhvd2V2ZXIsIEkgZG9uJ3QgdGhpbmsgaXQncyBhIGNvbW1vbiBwYXRo
LCBzbyBpZiB5b3UgdGhpbmsgaXQncyBiZXR0ZXIKPiB0byBleGl0IHRoZSBsb29wIGVhcmx5LCBJ
IGNhbiBkbyBpdC4KPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
