Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48434C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 10:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C3BF6404CC;
	Wed, 23 Mar 2022 10:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WExQZne02rQk; Wed, 23 Mar 2022 10:27:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 097934028D;
	Wed, 23 Mar 2022 10:27:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4F2BC0012;
	Wed, 23 Mar 2022 10:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39DACC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 278416119A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WeimjP5tbACZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:26:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A6D561199
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:26:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94AEBD6E;
 Wed, 23 Mar 2022 03:26:58 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 172953F73B;
 Wed, 23 Mar 2022 03:26:56 -0700 (PDT)
Message-ID: <cfd7b57e-0573-db04-3692-acedd20fb51e@arm.com>
Date: Wed, 23 Mar 2022 10:26:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/2] drm/qxl: replace ioremap by ioremap_cache on arm64
Content-Language: en-GB
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20220322093444.1236582-1-liucong2@kylinos.cn>
 <e2bc20e4-41e1-7162-257c-f2ad3309f1cb@amd.com>
 <a6acb2ce-2465-6619-e3fd-ac34ddf07d35@arm.com>
 <20220323101138.7oiwefh7ofcxojgq@sirius.home.kraxel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220323101138.7oiwefh7ofcxojgq@sirius.home.kraxel.org>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, ray.huang@amd.com,
 Cong Liu <liucong2@kylinos.cn>, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org, airlied@redhat.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMjAyMi0wMy0yMyAxMDoxMSwgR2VyZCBIb2ZmbWFubiB3cm90ZToKPiBPbiBXZWQsIE1hciAy
MywgMjAyMiBhdCAwOTo0NToxM0FNICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIw
MjItMDMtMjMgMDc6MTUsIENocmlzdGlhbiBLw6/Cv8K9bmlnIHdyb3RlOgo+Pj4gQW0gMjIuMDMu
MjIgdW0gMTA6MzQgc2NocmllYiBDb25nIExpdToKPj4+PiBxeGwgdXNlIGlvcmVtYXAgdG8gbWFw
IHJhbV9oZWFkZXIgYW5kIHJvbSwgaW4gdGhlIGFybTY0IGltcGxlbWVudGF0aW9uLAo+Pj4+IHRo
ZSBkZXZpY2UgaXMgbWFwcGVkIGFzIERFVklDRV9uR25SRSwgaXQgY2FuIG5vdCBzdXBwb3J0IHVu
YWxpZ25lZAo+Pj4+IGFjY2Vzcy4KPj4+Cj4+PiBXZWxsIHRoYXQgc29tZSBBUk0gYm9hcmRzIGRv
ZXNuJ3QgYWxsb3cgdW5hbGlnbmVkIGFjY2VzcyB0byBNTUlPIHNwYWNlCj4+PiBpcyBhIHdlbGwg
a25vd24gYnVnIG9mIHRob3NlIEFSTSBib2FyZHMuCj4+Pgo+Pj4gU28gYXMgZmFyIGFzIEkga25v
dyB0aGlzIGlzIGEgaGFyZHdhcmUgYnVnIHlvdSBhcmUgdHJ5aW5nIHRvIHdvcmthcm91bmQKPj4+
IGhlcmUgYW5kIEknbSBub3QgMTAwJSBzdXJlIHRoYXQgdGhpcyBpcyBjb3JyZWN0Lgo+Pgo+PiBO
bywgdGhpcyBvbmUncyBub3QgYSBidWcuIFRoZSBEZXZpY2UgbWVtb3J5IHR5cGUgdXNlZCBmb3Ig
aW9tZW0gbWFwcGluZ3MgaXMKPj4gKmFyY2hpdGVjdHVyYWxseSogZGVmaW5lZCB0byBlbmZvcmNl
IHByb3BlcnRpZXMgbGlrZSBhbGlnbmVkIGFjY2Vzc2VzLCBubwo+PiBzcGVjdWxhdGlvbiwgbm8g
cmVvcmRlcmluZywgZXRjLiBJZiBzb21ldGhpbmcgd2FudHMgdG8gYmUgdHJlYXRlZCBtb3JlIGxp
a2UKPj4gUkFNIHRoYW4gYWN0dWFsIE1NSU8gcmVnaXN0ZXJzLCB0aGVuIGlvcmVtYXBfd2MoKSBv
ciBpb3JlbWFwX2NhY2hlKCkgaXMgdGhlCj4+IGFwcHJvcHJpYXRlIHRoaW5nIHRvIGRvIGluIGdl
bmVyYWwgKHdpdGggdGhlIGZvcm1lciBiZWluZyBhIGJpdCBtb3JlCj4+IHBvcnRhYmxlIGFjY29y
ZGluZyB0byBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZGV2aWNlLWlvLnJzdCkuCj4gCj4gV2Vs
bCwgcXhsIGlzIGEgdmlydHVhbCBkZXZpY2UsIHNvIGl0ICppcyogcmFtLgo+IAo+IEknbSB3b25k
ZXJpbmcgd2hlbmV2ZXIgcXhsIGFjdHVhbGx5IHdvcmtzIG9uIGFybT8gIEFzIGZhciBJIGtub3cg
YWxsCj4gdmlydHVhbCBkaXNwbGF5IGRldmljZXMgd2l0aCAodmlydHVhbCkgcGNpIG1lbW9yeSBi
YXJzIGZvciB2cmFtIGRvIG5vdAo+IHdvcmsgb24gYXJtIGR1ZSB0byB0aGUgZ3Vlc3QgbWFwcGlu
ZyB2cmFtIGFzIGlvIG1lbW9yeSBhbmQgdGhlIGhvc3QKPiBtYXBwaW5nIHZyYW0gYXMgbm9ybWFs
IHJhbSBhbmQgdGhlIG1hcHBpbmcgYXR0cmlidXRlIG1pc21hdGNoIGNhdXNlcwo+IGNhY2hpbmcg
dHJvdWJsZXMgKG9ubHkgbm90aWNlYWJsZSBvbiByZWFsIGFybSBoYXJkd2FyZSwgbm90IGluCj4g
ZW11bGF0aW9uKS4gIERpZCBzb21ldGhpbmcgY2hhbmdlIGhlcmUgcmVjZW50bHk/CgpJbmRlZWQs
IEFybXY4LjQgaW50cm9kdWNlZCB0aGUgUzJGV0IgZmVhdHVyZSB0byBjb3BlIHdpdGggc2l0dWF0
aW9ucyAKbGlrZSB0aGlzIC0gZXNzZW50aWFsbHkgaXQgYWxsb3dzIHRoZSBoeXBlcnZpc29yIHRv
IHNoYXJlIFJBTS1iYWNrZWQgCnBhZ2VzIHdpdGggdGhlIGd1ZXN0IHdpdGhvdXQgbG9zaW5nIGNv
aGVyZW5jeSByZWdhcmRsZXNzIG9mIGhvdyB0aGUgCmd1ZXN0IG1hcHMgdGhlbS4KClJvYmluLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
