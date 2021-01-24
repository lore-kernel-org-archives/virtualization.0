Return-Path: <SRS0=rEPQ=G3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DBC433E0
	for <virtualization@archiver.kernel.org>; Sun, 24 Jan 2021 16:53:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A4722CA2
	for <virtualization@archiver.kernel.org>; Sun, 24 Jan 2021 16:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A4722CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 87ADA852F6;
	Sun, 24 Jan 2021 16:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rv__t6-ogMxo; Sun, 24 Jan 2021 16:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B80985E27;
	Sun, 24 Jan 2021 16:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04710C0FA7;
	Sun, 24 Jan 2021 16:53:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E44BDC013A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DFE2F865D4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkCqm6hN57BH
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:53:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2B48F864DF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:53:55 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id BB5BBA146E;
 Sun, 24 Jan 2021 17:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=zVAxrdkhit9I
 bjy8t7Lnq5mScOnP9BWAqNpKmerQ0tc=; b=hKAZ2uYI256rzdDpkFJZo7mJjxhX
 ZmzR209I64z8o3hDC4mBegCGHc0ljSJ7IUgMh+VxOke+A7UndD6xP3nYrF2gcM2q
 a6/Gk+Ey1AxjfYN3/6w+rO06OHpeRVo2wfAGHLsgkaNkcgfKFijsc+EAzZI/TVVG
 nck3iaEr3ym2ploUHcorPkKTESW7D703tqGrlpfDMgyfpS4EO9+f4TENUo3LGzkY
 l+ilYGEYJoGSoo4mJbU+mARKnAIOiHvYTqsH22Q54oYIwh6F5kKJ0nLl9lTprSY3
 4EZcCEvQWrXIOCoyaBOSFhYdQ8A8IJ1Nb5oMWkmbU/KtGGLcQFIBCB0A2w==
Subject: Re: [PATCH 0/7] ALSA: add virtio sound driver
To: "Girdwood, Liam R" <liam.r.girdwood@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
 <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <52efab17-d6e2-c3f4-c3de-73338b811534@opensynergy.com>
Date: Sun, 24 Jan 2021 17:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <3ac230040630c3b6695f8a091e000f5b4f90b3ce.camel@intel.com>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: "tiwai@suse.com" <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

SGksIExpYW0hCgoKT24gMjAuMDEuMjAyMSAxMToxMCwgR2lyZHdvb2QsIExpYW0gUiB3cm90ZToK
PiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdh
bml6YXRpb24uCj4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLgo+
IAo+IAo+IEhpIEFudG9uLAo+IAo+IE9uIFdlZCwgMjAyMS0wMS0yMCBhdCAwMTozNiArMDEwMCwg
QW50b24gWWFrb3ZsZXYgd3JvdGU6Cj4+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgYSBkcml2ZXIg
cGFydCBvZiB0aGUgdmlydGlvIHNvdW5kIGRldmljZQo+PiBzcGVjaWZpY2F0aW9uIHY4IFsxXS4K
Pj4KPj4gVGhlIGRyaXZlciBzdXBwb3J0cyBQQ00gcGxheWJhY2sgYW5kIGNhcHR1cmUgc3Vic3Ry
ZWFtcywgamFjayBhbmQKPj4gY2hhbm5lbCBtYXAgY29udHJvbHMuIEEgbWVzc2FnZS1iYXNlZCB0
cmFuc3BvcnQgaXMgdXNlZCB0byB3cml0ZS9yZWFkCj4+IFBDTSBmcmFtZXMgdG8vZnJvbSBhIGRl
dmljZS4KPj4KPj4gVGhlIHNlcmllcyBpcyBiYXNlZCAoYW5kIHdhcyBhY3R1YWxseSB0ZXN0ZWQp
IG9uIExpbnVzJ3MgbWFzdGVyCj4+IGJyYW5jaCBbMl0sIG9uIHRvcCBvZgo+Pgo+PiBjb21taXQg
MWUyYTE5OWY2Y2NkICgiTWVyZ2UgdGFnICdzcGktZml4LXY1LjExLXJjNCcgb2YgLi4uIikKPj4K
Pj4gQXMgYSBkZXZpY2UgcGFydCB3YXMgdXNlZCBPcGVuU3luZXJneSBwcm9wcmlldGFyeSBpbXBs
ZW1lbnRhdGlvbi4KPj4KPj4gQW55IGNvbW1lbnRzIGFyZSB2ZXJ5IHdlbGNvbWUuCj4+Cj4gCj4g
VGhpcyBqdXN0IGxvb2tzIGxpa2UgdGhlIGd1ZXN0IGZyb250IGVuZCBoZXJlLCBkbyB5b3UgaGF2
ZSBhIGZvbGxvdyB1cAo+IHNlcmllcyBmb3IgdGhlIGhvc3QgYmFja2VuZCA/CgpBcyBJIG1lbnRp
b25lZCBpbiB0aGUgY292ZXIgbWVzc2FnZSwgYXMgYSBkZXZpY2UgcGFydCB3YXMgdXNlZCBvdXIg
b3duCnByb3ByaWV0YXJ5IGltcGxlbWVudGF0aW9uLiBBbmQgdGhlcmUgYXJlIG5vIHBsYW5zIHRv
IHVwc3RyZWFtIHRoYXQKcGFydC4KCgo+IFRoYW5rcwo+IAo+IExpYW0KPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiBJbnRlbCBDb3Jwb3JhdGlvbiAoVUspIExpbWl0ZWQKPiBSZWdpc3RlcmVkIE5vLiAxMTM0OTQ1
IChFbmdsYW5kKQo+IFJlZ2lzdGVyZWQgT2ZmaWNlOiBQaXBlcnMgV2F5LCBTd2luZG9uIFNOMyAx
UkoKPiBWQVQgTm86IDg2MCAyMTczIDQ3Cj4gCj4gVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yCj4gdGhlIHNvbGUgdXNl
IG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9u
Cj4gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZAo+IHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRl
IGFsbCBjb3BpZXMuCj4gCgotLSAKQW50b24gWWFrb3ZsZXYKU2VuaW9yIFNvZnR3YXJlIEVuZ2lu
ZWVyCgpPcGVuU3luZXJneSBHbWJIClJvdGhlcnN0ci4gMjAsIDEwMjQ1IEJlcmxpbgoKUGhvbmU6
ICs0OSAzMCA2MCA5OCA1NCAwCkUtTWFpbDogYW50b24ueWFrb3ZsZXZAb3BlbnN5bmVyZ3kuY29t
Cgp3d3cub3BlbnN5bmVyZ3kuY29tCgpIYW5kZWxzcmVnaXN0ZXIvQ29tbWVyY2lhbCBSZWdpc3Ry
eTogQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcsIEhSQiAxMDg2MTZCCkdlc2Now6RmdHNmw7xo
cmVyL01hbmFnaW5nIERpcmVjdG9yOiBSZWdpcyBBZGphbWFoCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
