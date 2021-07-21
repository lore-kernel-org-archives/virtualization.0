Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78728C12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 09:33:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275FE60E08
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 09:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275FE60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBCA4403F0;
	Wed, 21 Jul 2021 09:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id no4-R8z4s-7W; Wed, 21 Jul 2021 09:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CEAF40265;
	Wed, 21 Jul 2021 09:33:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D94C001A;
	Wed, 21 Jul 2021 09:33:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F2F1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3041782909
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLsmFRd1un1p
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:33:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A6D9826DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:33:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94CFD61181;
 Wed, 21 Jul 2021 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626859987;
 bh=Ugfx0SLzjHVJOXOYrQ6di8BvRX/xV7sv48IdSOw9ZyY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dRBpow7Zp5CnRW8JDVuBsfZ/qRKkDPziZDOOFaq+2VQzvemV+PiuxGEyFbSVnwT7H
 UYPymfrdxJzK/rPY0jkVVYp0BRTKy/yOXARUiOLH7jEBOAne59Wrg49pvo369+L2Y5
 0fAj94XKe1pY5nok/O0HfPiozcVoTwVblgrZZMn0=
Date: Wed, 21 Jul 2021 11:33:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPfp0Ff6KuyPlyrc@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
 <YPfiNuKonyTIKcDL@kroah.com>
 <6344A6B0-F7B7-450C-9BDF-AF9056D211F3@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6344A6B0-F7B7-450C-9BDF-AF9056D211F3@vmware.com>
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gV2VkLCBKdWwgMjEsIDIwMjEgYXQgMDk6MjY6MTVBTSArMDAwMCwgSm9yZ2VuIEhhbnNlbiB3
cm90ZToKPiAKPiAKPiA+IE9uIDIxIEp1bCAyMDIxLCBhdCAxMTowMCwgR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+ID4gCj4gPiBPbiBXZWQsIEp1bCAyMSwgMjAy
MSBhdCAwODo0NjoxNUFNICswMDAwLCBKb3JnZW4gSGFuc2VuIHdyb3RlOgo+ID4+IAo+ID4+IAo+
ID4+PiBPbiAyMCBKdWwgMjAyMSwgYXQgMTI6MzksIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToKPiA+Pj4gCj4gPj4+IE9uIFR1ZSwgSnVsIDIwLCAyMDIxIGF0IDAz
OjI5OjAxQU0gLTA3MDAsIEpvcmdlbiBIYW5zZW4gd3JvdGU6Cj4gPj4+PiBBZGQgbWFpbnRhaW5l
ciBpbmZvIGZvciB0aGUgVk13YXJlIFZNQ0kgZHJpdmVyLgo+ID4+Pj4gCj4gPj4+PiBTaWduZWQt
b2ZmLWJ5OiBKb3JnZW4gSGFuc2VuIDxqaGFuc2VuQHZtd2FyZS5jb20+Cj4gPj4+PiAtLS0KPiA+
Pj4+IE1BSU5UQUlORVJTIHwgOCArKysrKysrKwo+ID4+Pj4gMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQo+ID4+Pj4gCj4gPj4+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUwo+ID4+Pj4gaW5kZXggYTYxZjRmMy4uN2U3YzZmYSAxMDA2NDQKPiA+Pj4+IC0tLSBh
L01BSU5UQUlORVJTCj4gPj4+PiArKysgYi9NQUlOVEFJTkVSUwo+ID4+Pj4gQEAgLTE5NzkyLDYg
KzE5NzkyLDE0IEBAIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKPiA+Pj4+IFM6CVN1cHBvcnRl
ZAo+ID4+Pj4gRjoJZHJpdmVycy9wdHAvcHRwX3Ztdy5jCj4gPj4+PiAKPiA+Pj4+ICtWTVdBUkUg
Vk1DSSBEUklWRVIKPiA+Pj4+ICtNOglKb3JnZW4gSGFuc2VuIDxqaGFuc2VuQHZtd2FyZS5jb20+
Cj4gPj4+PiArTToJVmlzaG51IERhc2EgPHZkYXNhQHZtd2FyZS5jb20+Cj4gPj4+PiArTToJIlZN
d2FyZSwgSW5jLiIgPHB2LWRyaXZlcnNAdm13YXJlLmNvbT4KPiA+Pj4gCj4gPj4+IFBsZWFzZSBk
byBub3QgdXNlIGdlbmVyaWMgYWxpYXNlcyBhcyB0aGV5IHByb3ZpZGUgbm8gcGVyc29uYWwKPiA+
Pj4gcmVzcG9uc2liaWxpdHkuICBKdXN0IHN0aWNrIHdpdGggcmVhbCBwZW9wbGUuCj4gPj4gCj4g
Pj4gVGhhdCBtYWtlcyBzZW5zZS4gSG93ZXZlciwgdGhlIHB2LWRyaXZlcnMgbGlzdCBpcyB1c2Vk
IGZvciBrZWVwaW5nIG1hbmFnZXJzCj4gPj4gYW5kIHBlb3BsZSBoZWxwaW5nIHdpdGggdGVzdGlu
ZyBpbiB0aGUgbG9vcC4gU28gd291bGQgYWRkaW5nIHB2LWRyaXZlcnMgYXMgYQo+ID4+IHNlY29u
ZCBMOiBlbnRyeSBiZSBPSz8KPiA+IAo+ID4gSXMgaXQgcmVhbGx5IGEgbGlzdD8gIElmIG5vdCwg
dGhlbiB0aGF0IHdvdWxkIG5vdCBtYWtlIG11Y2ggc2Vuc2UuCj4gCj4gSXQgaXMgLSB3aXRoIFZN
d2FyZSBzdWJzY3JpYmVycyBvbmx5IGJ1dCBhbnlvbmUgY2FuIHBvc3QgdG8gaXQuIElmIHRoZSBp
bnRlbnQgb2YgdGhlCj4gTDogZW50cmllcyBpcyB0byBhbGxvdyBmb2xrcyB0byBzdWJzY3JpYmUg
dG8gcmVsZXZhbnQgaW5mb3JtYXRpb24sIHRoZW4gaXQgaXNu4oCZdAo+IGFwcHJvcHJpYXRlLgoK
VGhlbiBtYXJrIGl0IGFzIGEgcHJpdmF0ZSBsaXN0LgoKPiBBbGwgZXhpc3Rpbmcgdm13IGRyaXZl
ciBtYWludGFpbmVyIGVudHJpZXMgaGF2ZSBwdi1kcml2ZXJzIGFzIGFuIE06IGVudHJ5LAo+IHNv
IGhhcyB0aGVyZSBiZWVuIGEgY2hhbmdlIGluIHBvbGljeSByZWdhcmRpbmcgdGhpcz8gVGhlIGFw
cHJvYWNoIGhhcwo+IGJlZW4gcXVpdGUgdXNlZnVsIGZvciB1cy4KCkl0J3MgYSBoaXQtb3ItbWlz
cyBwb2xpY3ksIHNvbWUgb2YgdXMgbm90aWNlIGl0LCBvdGhlcnMgZG8gbm90LiAgbm90aGluZwpv
ZmZpY2lhbCBhdCBhbGwsIGp1c3QgdGhvc2Ugb2YgdXMgd2l0aCBtb3JlIGV4cGVyaWVuY2Uga25v
dyB0aGF0IGFsaWFzZXMKbGlrZSB0aGlzIHVzdWFsbHkgYXRyb3BoeSBhbmQgYmVjb21lIHVzZWxl
c3MuICBUaGVyZSBhcmUgbWFueSBzdWNoCmV4YW1wbGVzIG9mIHVzZWxlc3Mgb25lcyBpbiB0aGUg
TUFJTlRBSU5FUlMgZmlsZSByaWdodCBub3cgOigKCnRoYW5rcywKCmdyZWcgay1oCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
