Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5687C64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 16:03:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007D821D7A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 16:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007D821D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5915987962;
	Wed,  2 Dec 2020 16:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8jKQ81fNOtqp; Wed,  2 Dec 2020 16:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21B6287956;
	Wed,  2 Dec 2020 16:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADCFC0859;
	Wed,  2 Dec 2020 16:03:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA10AC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 16:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C85EF87A3E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 16:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59jSZDTSpJZE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 16:03:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B986987A1A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 16:03:24 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id p126so2063875oif.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b7U+AtH3sHJCwULgF3Ak2zaylddojTI/suVTwKzdZWQ=;
 b=ErkznRm8nwyDwIv/teBX3kIGhYer5ymPEKwvJsdCdOtk8J4E7h/F3yCSi6j6g1DF16
 QNktpzqHai+xd8PZl1R6oZG5x85KWxlLqDYBViXHEnNi/P+B0na/wfRKGm44ZG5N/O9f
 iuVGC/9e8BeIhC2ONpm4mwzqHxjarImNxVGjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b7U+AtH3sHJCwULgF3Ak2zaylddojTI/suVTwKzdZWQ=;
 b=ty1LMkQZHBMlpwVtyuQrvYS+ABUhDnfJZXHaFamR2W8+NVSTEaeIbTkoDVo4jUF/zQ
 nbn1rOvarjnByz9j47gGot8jjNkT5xRnuKJMzoqEtAg19zRlCh4+JtY3L8jPaEmBxgvj
 DXCuPmdVqzEB/8hgfP5jKIKVU3UXgGcfvGtfgQ6GIAfPCIkkHc9Eu5MGgOHwKZ/PAb6y
 rAxBkuLKbmwFYCYRXKmt5DPA4UbsMrkV9MBhtRNGsVXIQ/kMtnXFLRfVYTKKCUABcC0N
 uoNabXiy/w51tK1nQMiNcg9Q2RDZgejmiAWuVRxWZfY6q+D00uH5+zYCuayOsv5n/msM
 ddzw==
X-Gm-Message-State: AOAM530CP52srPI/Hbtl9pr1oQsGvHEmlJbYYqrPxEuRA0fjtig9AnHQ
 LsVKlQ73Qf26BvXFv6qDS+dcvl9aZvAQLc6vyXXM+g==
X-Google-Smtp-Source: ABdhPJx9RB1NjUkHWVxMa5djDpF+EBlvksgp+1DOxJnboQAoZm7YjyEK65yCvt1oK3P9tLuw+YHUz+WWcB0lD2pn7Hg=
X-Received: by 2002:aca:1713:: with SMTP id j19mr2044644oii.101.1606925003642; 
 Wed, 02 Dec 2020 08:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20201124113824.19994-1-tzimmermann@suse.de>
 <20201124113824.19994-15-tzimmermann@suse.de>
 <31E75B1A-AAC0-49E3-985E-2DF5B59CD883@vmware.com>
 <e8102216-edd0-bec3-79af-3925e9668e95@suse.de>
 <d43d06e6-d13c-ef9b-b372-8d30d9494417@suse.de>
 <FBC4840D-C1A8-4492-9E2E-D31E00B8D61A@vmware.com>
In-Reply-To: <FBC4840D-C1A8-4492-9E2E-D31E00B8D61A@vmware.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 2 Dec 2020 17:03:11 +0100
Message-ID: <CAKMK7uFaCVLu9GWR0Jkvf8iXP4RdcG3TmMsLmFVDoERBOk1ZOQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] drm/vmwgfx: Remove references to struct
 drm_device.pdev
To: Zack Rusin <zackr@vmware.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 Roland Scheidegger <sroland@vmware.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>
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

T24gV2VkLCBEZWMgMiwgMjAyMCBhdCA0OjM3IFBNIFphY2sgUnVzaW4gPHphY2tyQHZtd2FyZS5j
b20+IHdyb3RlOgo+Cj4KPgo+ID4gT24gRGVjIDIsIDIwMjAsIGF0IDA5OjI3LCBUaG9tYXMgWmlt
bWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4gd3JvdGU6Cj4gPgo+ID4gSGkKPiA+Cj4gPiBB
bSAwMi4xMi4yMCB1bSAwOTowMSBzY2hyaWViIFRob21hcyBaaW1tZXJtYW5uOgo+ID4+IEhpCj4g
Pj4gQW0gMzAuMTEuMjAgdW0gMjE6NTkgc2NocmllYiBaYWNrIFJ1c2luOgo+ID4+Pgo+ID4+Pgo+
ID4+Pj4gT24gTm92IDI0LCAyMDIwLCBhdCAwNjozOCwgVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+IHdyb3RlOgo+ID4+Pj4KPiA+Pj4+IFVzaW5nIHN0cnVjdCBkcm1fZGV2
aWNlLnBkZXYgaXMgZGVwcmVjYXRlZC4gQ29udmVydCB2bXdnZnggdG8gc3RydWN0Cj4gPj4+PiBk
cm1fZGV2aWNlLmRldi4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLgo+ID4+Pj4KPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgo+ID4+Pj4g
Q2M6IFJvbGFuZCBTY2hlaWRlZ2dlciA8c3JvbGFuZEB2bXdhcmUuY29tPgo+ID4+Pj4gLS0tCj4g
Pj4+PiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9jbWRidWYuYyB8ICA4ICsrKystLS0t
Cj4gPj4+PiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYyAgICB8IDI3ICsrKysr
KysrKysrKystLS0tLS0tLS0tLS0tCj4gPj4+PiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dm
eF9mYi5jICAgICB8ICAyICstCj4gPj4+Cj4gPj4+IFJldmlld2VkLWJ5OiBaYWNrIFJ1c2luIDx6
YWNrckB2bXdhcmUuY29tPgo+ID4+IENvdWxkIHlvdSBhZGQgdGhpcyBwYXRjaCB0byB0aGUgdm13
Z2Z4IHRyZWU/Cj4gPgo+ID4gQU1EIGRldnMgaW5kaWNhdGVkIHRoYXQgdGhleSdkIHByZWZlciB0
byBtZXJnZSB0aGUgcGF0Y2hzZXQgdHJvdWdoIGRybS1taXNjLW5leHQuIElmIHlvdSdyZSBPSyB3
aXRoIHRoYXQsIEknZCBtZXJnZSB0aGUgdm13Z2Z4IHBhdGNoIHRocm91Z2ggZHJtLW1pc2MtbmV4
dCBhcyB3ZWxsLgo+Cj4gU291bmRzIGdvb2QuIEnigJlsbCBtYWtlIHN1cmUgdG8gcmViYXNlIG91
ciBsYXRlc3QgcGF0Y2ggc2V0IG9uIHRvcCBvZiBpdCB3aGVuIGl04oCZcyBpbi4gVGhhbmtzIQoK
YnR3IGlmIHlvdSB3YW50IHRvIGF2b2lkIG11bHRpLXRyZWUgY29vcmRpbmF0aW9uIGhlYWRhY2hl
cywgd2UgY2FuCmFsc28gbWFuYWdlIHZtd2dmeCBpbiBkcm0tbWlzYyBhbmQgZ2l2ZSB5b3UgJiBS
b2xhbmQgY29tbWl0IHJpZ2h0cwp0aGVyZS4gVXAgdG8geW91LiBUaGVyZSBpcyBzb21lIHNjcmlw
dGluZyBpbnZvbHZlZCBmb3Igbm93IChidXQgSSBob3BlCndoZW5ldmVyIHdlIG1vdmUgdG8gZ2l0
bGFiIHdlIGNvdWxkIGRvIHRoZSBjaGVja3Mgc2VydmVyLXNpZGUpOgoKaHR0cHM6Ly9kcm0ucGFn
ZXMuZnJlZWRlc2t0b3Aub3JnL21haW50YWluZXItdG9vbHMvZ2V0dGluZy1zdGFydGVkLmh0bWwK
CkNoZWVycywgRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRl
bCBDb3Jwb3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
