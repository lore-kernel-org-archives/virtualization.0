Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B2BC433EF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 15:52:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A9D61166
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 15:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0A9D61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54B286083F;
	Tue,  9 Nov 2021 15:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRL4VD7uNIUZ; Tue,  9 Nov 2021 15:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C753660732;
	Tue,  9 Nov 2021 15:52:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A8D7C0019;
	Tue,  9 Nov 2021 15:52:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E83AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F3ED380EF3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lzNewklydLP6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:52:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF6E280EF2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2jLWUxWVafTg6XNbuqQwSi/vlAJC5JC6VJT4lSLReA=; b=iPEDjmY4B+l5EgynojlyxUZtqa
 PYzpXHGLgun/+/iMFbKBQV1JftMh5fgtt+xl+IqF8Hn5oPfzXT0808tCeg+nrjsdnVcVSYJRrjS6i
 IGu8iiyCBaCgfpWei3QoRMC0cw6X7kREadu+SB+PumNhHBWjj0MkUM/YskCwqpRjvvaD0z22IcDSa
 vFldWUMNvxp3Rzu84TUUtnw+Wjnkh+6MWaKFJvHqOzSNgpVXztYTQFhwJB51P1Zo2ucmHsrD3AtUG
 sydZM8HYnflVH6XQsn5QbhWZMUa+CnHIeo7AMr6+7dRjrag0VVJXnLR4I4KB4o17e7h+yIaRaP86U
 /PuF/a/g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:60908
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mkTQH-0004KK-6r; Tue, 09 Nov 2021 16:52:33 +0100
Subject: Re: [PATCH v2 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-8-tzimmermann@suse.de>
 <974e10bb-ae58-d1c1-a89e-881b39da4930@tronnes.org>
 <b5e514a7-74f3-d072-cfba-80ff05c2669c@suse.de>
 <1b1e8a38-2ad6-406e-0d07-bd28dcba08a3@tronnes.org>
 <bb71f9a7-9fd0-ac91-749d-b9241290c45d@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <6caaace4-27e5-2ac9-9c84-40d7b8ffcb1e@tronnes.org>
Date: Tue, 9 Nov 2021 16:52:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bb71f9a7-9fd0-ac91-749d-b9241290c45d@suse.de>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
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

CgpEZW4gMDkuMTEuMjAyMSAxNS41Niwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gSGksCj4g
Cj4gdGhhbmtzIGZvciBsb29raW5nIHRocm91Z2ggYWxsIHRoaXMgY29kZS4KPiAKPiBBbSAwOS4x
MS4yMSB1bSAxNDowNCBzY2hyaWViIE5vcmFsZiBUcsO4bm5lczoKPj4KPj4KPj4gRGVuIDA5LjEx
LjIwMjEgMTMuMzgsIHNrcmV2IFRob21hcyBaaW1tZXJtYW5uOgo+Pj4KPj4+Cj4+PiBBbSAwOC4x
MS4yMSB1bSAyMTo1NSBzY2hyaWViIE5vcmFsZiBUcsO4bm5lczoKPj4+Pgo+Pj4+Cj4+Pj4gRGVu
IDAxLjExLjIwMjEgMTUuMTUsIHNrcmV2IFRob21hcyBaaW1tZXJtYW5uOgo+Pj4+PiBFbmFibGUg
dGhlIEZCX0RBTUFHRV9DTElQUyBwcm9wZXJ0eSB0byByZWR1Y2UgZGlzcGxheS11cGRhdGUKPj4+
Pj4gb3ZlcmhlYWQuIEFsc28gZml4ZXMgYSB3YXJuaW5nIGluIHRoZSBrZXJuZWwgbG9nLgo+Pj4+
Pgo+Pj4+PiDCoMKgwqAgc2ltcGxlLWZyYW1lYnVmZmVyIHNpbXBsZS1mcmFtZWJ1ZmZlci4wOiBb
ZHJtXQo+Pj4+PiBkcm1fcGxhbmVfZW5hYmxlX2ZiX2RhbWFnZV9jbGlwcygpIG5vdCBjYWxsZWQK
Pj4+Pj4KPj4+Pj4gRml4IHRoZSBjb21wdXRhdGlvbiBvZiB0aGUgYmxpdCByZWN0YW5nbGUuIFRo
aXMgd2Fzbid0IGFuIGlzc3VlIHNvCj4+Pj4+IGZhciwgYXMgc2ltcGxlZHJtIGFsd2F5cyBibGl0
dGVkIHRoZSBmdWxsIGZyYW1lYnVmZmVyLiBUaGUgY29kZSBub3cKPj4+Pj4gc3VwcG9ydHMgZGFt
YWdlIGNsaXBwaW5nIGFuZCB2aXJ0dWFsIHNjcmVlbiBzaXplcy4KPj4+Pj4KPj4+Pj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4+Pj4+IC0t
LQo+Pj4+PiDCoMKgIGRyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jIHwgMzAKPj4+Pj4g
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYwo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS90aW55L3NpbXBsZWRybS5jCj4+Pj4+IGluZGV4IDU3MWY3MTZmZjQyNy4uZTg3MjEyMWU5ZmIw
IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYwo+Pj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYwo+Pj4+PiBAQCAtNjQyLDcg
KzY0Miw3IEBAIHNpbXBsZWRybV9zaW1wbGVfZGlzcGxheV9waXBlX2VuYWJsZShzdHJ1Y3QKPj4+
Pj4gZHJtX3NpbXBsZV9kaXNwbGF5X3BpcGUgKnBpcGUsCj4+Pj4+IMKgwqDCoMKgwqDCoCB2b2lk
ICp2bWFwID0gc2hhZG93X3BsYW5lX3N0YXRlLT5kYXRhWzBdLnZhZGRyOyAvKiBUT0RPOiBVc2UK
Pj4+Pj4gbWFwcGluZyBhYnN0cmFjdGlvbiAqLwo+Pj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0IGRy
bV9kZXZpY2UgKmRldiA9ICZzZGV2LT5kZXY7Cj4+Pj4+IMKgwqDCoMKgwqDCoCB2b2lkIF9faW9t
ZW0gKmRzdCA9IHNkZXYtPnNjcmVlbl9iYXNlOwo+Pj4+PiAtwqDCoMKgIHN0cnVjdCBkcm1fcmVj
dCBjbGlwOwo+Pj4+PiArwqDCoMKgIHN0cnVjdCBkcm1fcmVjdCBzcmNfY2xpcCwgZHN0X2NsaXA7
Cj4+Pj4+IMKgwqDCoMKgwqDCoCBpbnQgaWR4Owo+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgaWYgKCFm
YikKPj4+Pj4gQEAgLTY1MSwxMCArNjUxLDE0IEBAIHNpbXBsZWRybV9zaW1wbGVfZGlzcGxheV9w
aXBlX2VuYWJsZShzdHJ1Y3QKPj4+Pj4gZHJtX3NpbXBsZV9kaXNwbGF5X3BpcGUgKnBpcGUsCj4+
Pj4+IMKgwqDCoMKgwqDCoCBpZiAoIWRybV9kZXZfZW50ZXIoZGV2LCAmaWR4KSkKPj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+PiDCoMKgIC3CoMKgwqAgZHJtX3JlY3RfaW5p
dCgmY2xpcCwgMCwgMCwgZmItPndpZHRoLCBmYi0+aGVpZ2h0KTsKPj4+Pj4gK8KgwqDCoCBkcm1f
cmVjdF9mcF90b19pbnQoJnNyY19jbGlwLCAmcGxhbmVfc3RhdGUtPnNyYyk7Cj4+Pj4+IMKgwqAg
LcKgwqDCoCBkc3QgKz0gZHJtX2ZiX2NsaXBfb2Zmc2V0KHNkZXYtPnBpdGNoLCBzZGV2LT5mb3Jt
YXQsICZjbGlwKTsKPj4+Pj4gLcKgwqDCoCBkcm1fZmJfYmxpdF90b2lvKGRzdCwgc2Rldi0+cGl0
Y2gsIHNkZXYtPmZvcm1hdC0+Zm9ybWF0LCB2bWFwLAo+Pj4+PiBmYiwgJmNsaXApOwo+Pj4+PiAr
wqDCoMKgIGRzdF9jbGlwID0gcGxhbmVfc3RhdGUtPmRzdDsKPj4+Pgo+Pj4+IEkgYXNzdW1lIHRo
YXQgc3JjX2NsaXAgYW5kIGRzdF9jbGlwIGFyZSBvZiB0aGUgc2FtZSBzaXplLCBzaW5jZSBzY2Fs
aW5nCj4+Pj4gaXMgbm90IHN1cHBvcnRlZC4gV2hhdCBwcmV2ZW50cyBkc3RfY2xpcCBmcm9tIGJl
aW5nIGJpZ2dlciB0aGFuIHRoZQo+Pj4+IGJ1ZmZlciB0aGF0J3MgYmVpbmcgYmxpdHRlZCBpbnRv
PyBXaGVyZSBpcyB0aGF0IGJvdW5kcyBjaGVja2luZyBkb25lPwo+Pj4KPj4+IFRoZSB2YWx1ZSBv
ZiBkc3RfY2xpcCBjb21lcyBmcm9tIHBsYW5lX3N0YXRlLT5kc3QsIHdoaWNoIGdldHMKPj4+IGlu
aXRpYWxpemVkIGluIGRybV9hdG9taWNfaGVscGVyX2NoZWNrX3BsYW5lX3N0YXRlKCkuIFsxXSBU
aGUgZmllbGRzIGFyZQo+Pj4gdGFrZW4gZnJvbSB0aGUgY3J0Y197eCx5LHcsaH0gdmFsdWVzIGJ5
IGRybV9wbGFuZV9nZXRfZGVzdCgpLiBbMl0gRm9yCj4+PiBwcmltYXJ5IHBsYW5lcywgdGhlIGNy
dGNfe3gseSx3LGh9IHZhbHVlcyBhcmUgaW5pdGlhbGl6ZWQgaW4KPj4+IF9fZHJtX2F0b21pY19o
ZWxwZXJfc2V0X2NvbmZpZygpIHRvIHRoZSBzaXplIG9mIHRoZSBkaXNwbGF5LiBbM10gVGhhdAo+
Pj4gc2l6ZSBjb21lcyBkaXJlY3RseSBmcm9tIHRoZSBjdXJyZW50IHZpZGVvIG1vZGUuIFs0XSBG
cm9tIGFsbCBJIGNhbiBzZWUKPj4+IHRoaXMgY2Fubm90IG92ZXJmbG93Lgo+Pj4KPj4KPj4gT2ss
IHRoYXQgdGFrZXMgY2FyZSBvZiB0aGUgdXBwZXIgYm91bmQuCj4+Cj4+IFRoZXJlJ3MgdGhpcyBp
biBkcm1fYXRvbWljX2hlbHBlcl9jaGVja19wbGFuZV9zdGF0ZSgpOgo+Pgo+PiDCoMKgwqDCoHBs
YW5lX3N0YXRlLT52aXNpYmxlID0gZHJtX3JlY3RfY2xpcF9zY2FsZWQoc3JjLCBkc3QsICZjbGlw
KTsKPj4KPj4gwqDCoMKgwqBpZiAoIXBsYW5lX3N0YXRlLT52aXNpYmxlKQo+PiDCoMKgwqDCoMKg
wqDCoCAvKgo+PiDCoMKgwqDCoMKgwqDCoMKgICogUGxhbmUgaXNuJ3QgdmlzaWJsZTsgc29tZSBk
cml2ZXJzIGNhbiBoYW5kbGUgdGhpcwo+PiDCoMKgwqDCoMKgwqDCoMKgICogc28gd2UganVzdCBy
ZXR1cm4gc3VjY2VzcyBoZXJlLsKgIERyaXZlcnMgdGhhdCBjYW4ndAo+PiDCoMKgwqDCoMKgwqDC
oMKgICogKGluY2x1ZGluZyB0aG9zZSB0aGF0IHVzZSB0aGUgcHJpbWFyeSBwbGFuZSBoZWxwZXIn
cwo+PiDCoMKgwqDCoMKgwqDCoMKgICogdXBkYXRlIGZ1bmN0aW9uKSB3aWxsIHJldHVybiBhbiBl
cnJvciBmcm9tIHRoZWlyCj4+IMKgwqDCoMKgwqDCoMKgwqAgKiB1cGRhdGVfcGxhbmUgaGFuZGxl
ci4KPj4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4K
Pj4gZHJtX2F0b21pY19oZWxwZXJfZGFtYWdlX21lcmdlZCgpIGNoZWNrcyAtPnZpc2libGUgYW5k
IHJldHVybnMgZmFsc2UgaWYKPj4gaXQgaXMgbm90IHNldCBzbyB1cGRhdGUoKSBpcyBnb29kIG9u
IHRoZSBsb3dlciBib3VuZC4KPj4KPj4gTWF5YmUgaXQncyBuZWNlc3NhcnkgdG8gY2hlY2sgLT52
aXNpYmxlIGhlcmUgaW4gZW5hYmxlKCkgYmVmb3JlIGRvaW5nCj4+IHRoZSBibGl0Pwo+IAo+IElz
IGl0IGV2ZW4gcG9zc2libGUgdG8gY3JlYXRlIGFuIGludmlzaWJsZSBwcmltYXJ5IHBsYW5lIGhl
cmU/IFdlIGNhbm5vdAo+IHNjYWxlIFsxXSBhbmQgaWYgdGhlIHByaW1hcnkgcGxhbmUgaXMgc21h
bGxlciB0aGFuIHRoZSBmcmFtZWJ1ZmZlciwgd2UKPiBoaXQgdGhlIGNhc2UgYXQgWzJdLiBUaGUg
b25seSB3YXkgSSBjYW4gc2VlIHRoaXMgaXMgdGhhdCB0aGUgdmlzaWJpbGl0eQo+IHRlc3QgYXQg
WzNdIHN1Y2NlZWRzLiBUaGF0IHdvdWxkIHJlcXVpcmUgYSBmcmFtZWJ1ZmZlciBvZiBzaXplIDAu
IFRoYXQncwo+IGltcG9zc2libGUgZnJvbSB0aGUgY29kZSBpbiBmcmFtYnVmZmVyX2NoZWNrKCku
IFs0XSBVbmxlc3MgdGhlcmUncyBzb21lCj4gY29ybmVyIGNhc2UsIHdlJ3JlIGdvb2QgaGVyZS4K
Ck9rLCB0aGFua3MuCgpOb3JhbGYuCgo+IAo+IEhvd2V2ZXIsIEkgdGhpbmsgdGhhdCBkcm1fYXRv
bWljX2NoZWNrX3BsYW5lX3N0YXRlKCkgY291bGQgbGF0ZXIgYmUKPiBpbXByb3ZlZCB0byBoYW5k
bGUgdGhlICd2aXNpYmxlJyBmaWVsZCBpbiBhIG1vcmUgc29waGlzdGljYXRlZCB3YXkuCj4gCj4g
QmVzdCByZWdhcmRzCj4gVGhvbWFzCj4gCj4gWzFdCj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0vZHJtX3NpbXBsZV9rbXNfaGVs
cGVyLmMjTDIyNwo+IAo+IFsyXQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xh
dGVzdC9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMjTDg1NAo+IAo+
IFszXQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJp
dmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMjTDg0NAo+IAo+IFs0XQo+IGh0dHBzOi8v
ZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2Ry
bV9mcmFtZWJ1ZmZlci5jI0wxODUKPiAKPiAKPj4KPj4gTm9yYWxmLgo+Pgo+Pj4gQmVzdCByZWdh
cmRzCj4+PiBUaG9tYXMKPj4+Cj4+PiBbMV0KPj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMj
TDgwNwo+Pj4KPj4+Cj4+PiBbMl0KPj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L2xhdGVzdC9zb3VyY2UvaW5jbHVkZS9kcm0vZHJtX3BsYW5lLmgjTDI1Nwo+Pj4KPj4+IFszXQo+
Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJz
L2dwdS9kcm0vZHJtX2F0b21pYy5jI0wxNTkwCj4+Pgo+Pj4KPj4+IFs0XQo+Pj4gaHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0vZHJt
X21vZGVzLmMjTDc4OAo+Pj4KPj4+Cj4+Pgo+Pj4+Cj4+Pj4gTm9yYWxmLgo+Pj4+Cj4+Pj4+ICvC
oMKgwqAgaWYgKCFkcm1fcmVjdF9pbnRlcnNlY3QoJmRzdF9jbGlwLCAmc3JjX2NsaXApKQo+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgZHN0ICs9IGRy
bV9mYl9jbGlwX29mZnNldChzZGV2LT5waXRjaCwgc2Rldi0+Zm9ybWF0LCAmZHN0X2NsaXApOwo+
Pj4+PiArwqDCoMKgIGRybV9mYl9ibGl0X3RvaW8oZHN0LCBzZGV2LT5waXRjaCwgc2Rldi0+Zm9y
bWF0LT5mb3JtYXQsIHZtYXAsCj4+Pj4+IGZiLCAmc3JjX2NsaXApOwo+Pj4+PiDCoMKgIMKgwqDC
oMKgwqAgZHJtX2Rldl9leGl0KGlkeCk7Cj4+Pj4+IMKgwqAgfQo+Pj4+PiBAQCAtNjg2LDIwICs2
OTAsMjggQEAgc2ltcGxlZHJtX3NpbXBsZV9kaXNwbGF5X3BpcGVfdXBkYXRlKHN0cnVjdAo+Pj4+
PiBkcm1fc2ltcGxlX2Rpc3BsYXlfcGlwZSAqcGlwZSwKPj4+Pj4gwqDCoMKgwqDCoMKgIHN0cnVj
dCBkcm1fZnJhbWVidWZmZXIgKmZiID0gcGxhbmVfc3RhdGUtPmZiOwo+Pj4+PiDCoMKgwqDCoMKg
wqAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9ICZzZGV2LT5kZXY7Cj4+Pj4+IMKgwqDCoMKgwqDC
oCB2b2lkIF9faW9tZW0gKmRzdCA9IHNkZXYtPnNjcmVlbl9iYXNlOwo+Pj4+PiAtwqDCoMKgIHN0
cnVjdCBkcm1fcmVjdCBjbGlwOwo+Pj4+PiArwqDCoMKgIHN0cnVjdCBkcm1fcmVjdCBkYW1hZ2Vf
Y2xpcCwgc3JjX2NsaXAsIGRzdF9jbGlwOwo+Pj4+PiDCoMKgwqDCoMKgwqAgaW50IGlkeDsKPj4+
Pj4gwqDCoCDCoMKgwqDCoMKgIGlmICghZmIpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybjsKPj4+Pj4gwqDCoCAtwqDCoMKgIGlmICghZHJtX2F0b21pY19oZWxwZXJfZGFtYWdlX21l
cmdlZChvbGRfcGxhbmVfc3RhdGUsCj4+Pj4+IHBsYW5lX3N0YXRlLCAmY2xpcCkpCj4+Pj4+ICvC
oMKgwqAgaWYgKCFkcm1fYXRvbWljX2hlbHBlcl9kYW1hZ2VfbWVyZ2VkKG9sZF9wbGFuZV9zdGF0
ZSwKPj4+Pj4gcGxhbmVfc3RhdGUsICZkYW1hZ2VfY2xpcCkpCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm47Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBkcm1fcmVjdF9mcF90b19pbnQoJnNyY19j
bGlwLCAmcGxhbmVfc3RhdGUtPnNyYyk7Cj4+Pj4+ICvCoMKgwqAgaWYgKCFkcm1fcmVjdF9pbnRl
cnNlY3QoJnNyY19jbGlwLCAmZGFtYWdlX2NsaXApKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgZHN0X2NsaXAgPSBwbGFuZV9zdGF0ZS0+ZHN0Owo+
Pj4+PiArwqDCoMKgIGlmICghZHJtX3JlY3RfaW50ZXJzZWN0KCZkc3RfY2xpcCwgJnNyY19jbGlw
KSkKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+PiDCoMKgIMKgwqDCoMKg
wqAgaWYgKCFkcm1fZGV2X2VudGVyKGRldiwgJmlkeCkpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybjsKPj4+Pj4gwqDCoCAtwqDCoMKgIGRzdCArPSBkcm1fZmJfY2xpcF9vZmZzZXQo
c2Rldi0+cGl0Y2gsIHNkZXYtPmZvcm1hdCwgJmNsaXApOwo+Pj4+PiAtwqDCoMKgIGRybV9mYl9i
bGl0X3RvaW8oZHN0LCBzZGV2LT5waXRjaCwgc2Rldi0+Zm9ybWF0LT5mb3JtYXQsIHZtYXAsCj4+
Pj4+IGZiLCAmY2xpcCk7Cj4+Pj4+ICvCoMKgwqAgZHN0ICs9IGRybV9mYl9jbGlwX29mZnNldChz
ZGV2LT5waXRjaCwgc2Rldi0+Zm9ybWF0LCAmZHN0X2NsaXApOwo+Pj4+PiArwqDCoMKgIGRybV9m
Yl9ibGl0X3RvaW8oZHN0LCBzZGV2LT5waXRjaCwgc2Rldi0+Zm9ybWF0LT5mb3JtYXQsIHZtYXAs
Cj4+Pj4+IGZiLCAmc3JjX2NsaXApOwo+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgZHJtX2Rldl9leGl0
KGlkeCk7Cj4+Pj4+IMKgwqAgfQo+Pj4+PiBAQCAtNzk0LDYgKzgwNiw4IEBAIHN0YXRpYyBpbnQg
c2ltcGxlZHJtX2RldmljZV9pbml0X21vZGVzZXQoc3RydWN0Cj4+Pj4+IHNpbXBsZWRybV9kZXZp
Y2UgKnNkZXYpCj4+Pj4+IMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+PiDCoMKgICvCoMKgwqAgZHJtX3BsYW5lX2VuYWJsZV9m
Yl9kYW1hZ2VfY2xpcHMoJnBpcGUtPnBsYW5lKTsKPj4+Pj4gKwo+Pj4+PiDCoMKgwqDCoMKgwqAg
ZHJtX21vZGVfY29uZmlnX3Jlc2V0KGRldik7Cj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCByZXR1cm4g
MDsKPj4+Pj4KPj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
