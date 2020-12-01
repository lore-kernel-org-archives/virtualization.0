Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A158C71155
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:53:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70420809
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adfk0FFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA70420809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EDAF1874B7;
	Tue,  1 Dec 2020 10:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L7MuC+iobDH9; Tue,  1 Dec 2020 10:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B2DA870FE;
	Tue,  1 Dec 2020 10:53:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 150D8C163C;
	Tue,  1 Dec 2020 10:53:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F87CC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4DA5886B83
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z6QYk4uzYhvO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3F3EE86B81
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606819987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myXYBD46UvClc6/JcJZBliDe+/db79psyDbz7J+w+P0=;
 b=adfk0FFgK/2tF46CPU65qvuu/j4aY3xf5czxT+JgO8MjymTQEBhb5nlRz2lYe0K46cZPJT
 gDqXGZJ27nAibxtfRgITZoIQSfyzDKyL1rcpEAgsZHjpG5Tp98inuqrefmihaM/3jdYVvI
 815YqfHxIqMVVXMPtYEvg6fikaeeb30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-LLAZ-qmFPPyG0SqoOcJuiQ-1; Tue, 01 Dec 2020 05:53:06 -0500
X-MC-Unique: LLAZ-qmFPPyG0SqoOcJuiQ-1
Received: by mail-wm1-f69.google.com with SMTP id a134so537081wmd.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Dec 2020 02:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=myXYBD46UvClc6/JcJZBliDe+/db79psyDbz7J+w+P0=;
 b=ooaW9rf7lqcXSqXaCeURN2Rt4I/xCZNIH2LIXkKBY2UKFRtY+OvoEZVJRNrxTgqZ+k
 GN+9xYdHv8PHakegUIBE9jrq1i2J8FtD+agtFI4Ca25VOkfkPUKgbdSUvWf7+WrEBTNF
 dnUZW+R8iEm+95Ruo3GmAsJl7QZ83FNqmmAJPcPAgByoWotmwDpavfrWnIZf307YcQxs
 8dKFjWT+c8KgR18FuFpwAxkYZVIxzefxhdEASVrVlFzDadabhoR9dnG+8r9MouUR5mL6
 xylMdMdBhCdXoj/5HSQh4eWWrV7aAEnaavbSt9AAsTGv1evuCXg4y9I/d9Pppd7M3jFr
 p3uw==
X-Gm-Message-State: AOAM531pP5kSXaZdoQT3E4mqaC9+gTh83XfsMA34vKWVmShppNw6gjdY
 iUS4RW9jx1CupyVRqD+cm59r7S5LqlhYNz6Z+BkNSil7LAQYYWHxeKZj2fzHMfMa7ufisGZcYi+
 ND577UWhasnET2x7odimZY8TshXHaegxXE4SlrvLiNg==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr3181007wru.404.1606819983927; 
 Tue, 01 Dec 2020 02:53:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwANHPgmffBjgqLIriYCcA7hDiYfuos66MtUBeFTKqZovjJZ0ZQZMwbUhGDNGn/kirUQjmryw==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr3180319wru.404.1606819975700; 
 Tue, 01 Dec 2020 02:52:55 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id q16sm2490957wrn.13.2020.12.01.02.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 02:52:53 -0800 (PST)
Date: Tue, 1 Dec 2020 11:52:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Message-ID: <20201201105250.a72yxsxmyalio6c3@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
 <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
 <20201130141453.jobe76loyfy4qrdw@steredhat>
 <c2158059-6509-7702-f52a-e497ce899293@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c2158059-6509-7702-f52a-e497ce899293@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gVHVlLCBEZWMgMDEsIDIwMjAgYXQgMTE6NDQ6MTlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8zMCDkuIvljYgxMDoxNCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pk9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjI1OjMxQU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pgo+Pj5PbiAyMDIwLzExLzI2IOS4i+WNiDEwOjQ5LCBTdGVmYW5vIEdhcnphcmVs
bGEgd3JvdGU6Cj4+Pj5UaGUgZ2V0X2NvbmZpZyBjYWxsYmFjayBjYW4gYmUgdXNlZCBieSB0aGUg
ZGV2aWNlIHRvIGZpbGwgdGhlCj4+Pj5jb25maWcgc3RydWN0dXJlLgo+Pj4+VGhlIGNhbGxiYWNr
IHdpbGwgYmUgaW52b2tlZCBpbiB2ZHBhc2ltX2dldF9jb25maWcoKSBiZWZvcmUgY29weWluZwo+
Pj4+Ynl0ZXMgaW50byBjYWxsZXIgYnVmZmVyLgo+Pj4+Cj4+Pj5Nb3ZlIHZEUEEtbmV0IGNvbmZp
ZyB1cGRhdGVzIGZyb20gdmRwYXNpbV9zZXRfZmVhdHVyZXMoKSBpbiB0aGUKPj4+Pm5ldyB2ZHBh
c2ltX25ldF9nZXRfY29uZmlnKCkgY2FsbGJhY2suCj4+Pj4KPj4+PlNpZ25lZC1vZmYtYnk6IFN0
ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4+Pi0tLQo+Pj4+wqBkcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDMzICsrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tCj4+Pj7CoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkKPj4+Pgo+Pj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jIAo+Pj4+Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+Pj4+aW5kZXgg
YzA3ZGRmNmFmNzIwLi44Yjg3Y2UwNDg1YjYgMTAwNjQ0Cj4+Pj4tLS0gYS9kcml2ZXJzL3ZkcGEv
dmRwYV9zaW0vdmRwYV9zaW0uYwo+Pj4+KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMKPj4+PkBAIC01OCw2ICs1OCw4IEBAIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSB7Cj4+
Pj7CoCNkZWZpbmUgVkRQQVNJTV9ORVRfRkVBVFVSRVPCoMKgwqAgKFZEUEFTSU1fRkVBVFVSRVMg
fCBcCj4+Pj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJ
T19ORVRfRl9NQUMpKQo+Pj4+K3N0cnVjdCB2ZHBhc2ltOwo+Pj4+Kwo+Pj4+wqBzdHJ1Y3QgdmRw
YXNpbV9kZXZfYXR0ciB7Cj4+Pj7CoMKgwqDCoCB1NjQgc3VwcG9ydGVkX2ZlYXR1cmVzOwo+Pj4+
wqDCoMKgwqAgc2l6ZV90IGNvbmZpZ19zaXplOwo+Pj4+QEAgLTY1LDYgKzY3LDcgQEAgc3RydWN0
IHZkcGFzaW1fZGV2X2F0dHIgewo+Pj4+wqDCoMKgwqAgdTMyIGlkOwo+Pj4+wqDCoMKgwqAgd29y
a19mdW5jX3Qgd29ya19mbjsKPj4+PivCoMKgwqAgdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2
ZHBhc2ltICp2ZHBhc2ltLCB2b2lkICpjb25maWcpOwo+Pj4+wqB9Owo+Pj4+wqAvKiBTdGF0ZSBv
ZiBlYWNoIHZkcGFzaW0gZGV2aWNlICovCj4+Pj5AQCAtNTIwLDggKzUyMyw2IEBAIHN0YXRpYyB1
NjQgdmRwYXNpbV9nZXRfZmVhdHVyZXMoc3RydWN0IAo+Pj4+dmRwYV9kZXZpY2UgKnZkcGEpCj4+
Pj7CoHN0YXRpYyBpbnQgdmRwYXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhLCB1NjQgCj4+Pj5mZWF0dXJlcykKPj4+PsKgewo+Pj4+wqDCoMKgwqAgc3RydWN0IHZkcGFz
aW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPj4+Pi3CoMKgwqAgc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnICpjb25maWcgPQo+Pj4+LcKgwqDCoMKgwqDCoMKgIChzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWcgKil2ZHBhc2ltLT5jb25maWc7Cj4+Pj7CoMKgwqDCoCAvKiBETUEgbWFwcGlu
ZyBtdXN0IGJlIGRvbmUgYnkgZHJpdmVyICovCj4+Pj7CoMKgwqDCoCBpZiAoIShmZWF0dXJlcyAm
ICgxVUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+QEAgLTUyOSwxNSArNTMw
LDYgQEAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgCj4+Pj52ZHBhX2Rl
dmljZSAqdmRwYSwgdTY0IGZlYXR1cmVzKQo+Pj4+wqDCoMKgwqAgdmRwYXNpbS0+ZmVhdHVyZXMg
PSBmZWF0dXJlcyAmIAo+Pj4+dmRwYXNpbS0+ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzOwo+
Pj4+LcKgwqDCoCAvKiBXZSBnZW5lcmFsbHkgb25seSBrbm93IHdoZXRoZXIgZ3Vlc3QgaXMgdXNp
bmcgdGhlIGxlZ2FjeSAKPj4+PmludGVyZmFjZQo+Pj4+LcKgwqDCoMKgICogaGVyZSwgc28gZ2Vu
ZXJhbGx5IHRoYXQncyB0aGUgZWFybGllc3Qgd2UgY2FuIHNldCBjb25maWcgCj4+Pj5maWVsZHMu
Cj4+Pj4twqDCoMKgwqAgKiBOb3RlOiBXZSBhY3R1YWxseSByZXF1aXJlIFZJUlRJT19GX0FDQ0VT
U19QTEFURk9STSBhYm92ZSB3aGljaAo+Pj4+LcKgwqDCoMKgICogaW1wbGllcyBWSVJUSU9fRl9W
RVJTSU9OXzEsIGJ1dCBsZXQncyBub3QgdHJ5IHRvIGJlIAo+Pj4+Y2xldmVyIGhlcmUuCj4+Pj4t
wqDCoMKgwqAgKi8KPj4+Pi0KPj4+Pi3CoMKgwqAgY29uZmlnLT5tdHUgPSBjcHVfdG9fdmRwYXNp
bTE2KHZkcGFzaW0sIDE1MDApOwo+Pj4+LcKgwqDCoCBjb25maWctPnN0YXR1cyA9IGNwdV90b192
ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9TX0xJTktfVVApOwo+Pj4+LcKgwqDCoCBtZW1j
cHkoY29uZmlnLT5tYWMsIG1hY2FkZHJfYnVmLCBFVEhfQUxFTik7Cj4+Pj7CoMKgwqDCoCByZXR1
cm4gMDsKPj4+PsKgfQo+Pj4+QEAgLTU5Myw4ICs1ODUsMTIgQEAgc3RhdGljIHZvaWQgdmRwYXNp
bV9nZXRfY29uZmlnKHN0cnVjdCAKPj4+PnZkcGFfZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQg
b2Zmc2V0LAo+Pj4+wqB7Cj4+Pj7CoMKgwqDCoCBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZk
cGFfdG9fc2ltKHZkcGEpOwo+Pj4+LcKgwqDCoCBpZiAob2Zmc2V0ICsgbGVuIDwgdmRwYXNpbS0+
ZGV2X2F0dHIuY29uZmlnX3NpemUpCj4+Pj4twqDCoMKgwqDCoMKgwqAgbWVtY3B5KGJ1ZiwgdmRw
YXNpbS0+Y29uZmlnICsgb2Zmc2V0LCBsZW4pOwo+Pj4+K8KgwqDCoCBpZiAob2Zmc2V0ICsgbGVu
ID4gdmRwYXNpbS0+ZGV2X2F0dHIuY29uZmlnX3NpemUpCj4+Pj4rwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOwo+Pj4+Kwo+Pj4+K8KgwqDCoCB2ZHBhc2ltLT5kZXZfYXR0ci5nZXRfY29uZmlnKHZkcGFz
aW0sIHZkcGFzaW0tPmNvbmZpZyk7Cj4+Pj4rCj4+Pj4rwqDCoMKgIG1lbWNweShidWYsIHZkcGFz
aW0tPmNvbmZpZyArIG9mZnNldCwgbGVuKTsKPj4+PsKgfQo+Pj4KPj4+Cj4+Pkkgd29uZGVyIGhv
dyBtdWNoIHZhbHVlIHdlIGNhbiBnZXQgZnJvbSB2ZHBhc2ltLT5jb25maWcgY29uc2lkZXIgCj4+
PndlJ3ZlIGFscmVhZHkgaGFkIGdldF9jb25maWcoKSBtZXRob2QuCj4+Pgo+Pj5JcyBpdCBwb3Nz
aWJsZSB0byBjb3B5IHRvIHRoZSBidWZmZXIgZGlyZWN0bHkgaGVyZT8KPj4KPj5JIGhhZCB0aG91
Z2h0IG9mIGVsaW1pbmF0aW5nIGl0IHRvbywgYnV0IHRoZW4gSSB3YW50ZWQgdG8gZG8gc29tZXRo
aW5nIAo+PnNpbWlsYXIgdG8gd2hhdCB3ZSBkbyBpbiBRRU1VIChody92aXJ0aW8vdmlydGlvLmMp
LCBsZWF2aW5nIGluIHRoZSAKPj5zaW11bGF0b3IgY29yZSB0aGUgYnVmZmVyLCB0aGUgbWVtb3J5
IGNvcHkgKGhhbmRsaW5nIG9mZnNldCBhbmQgbGVuKSwgCj4+YW5kIHRoZSBib3VuZGFyeSBjaGVj
a3MuCj4+Cj4+SW4gdGhpcyB3YXkgZWFjaCBkZXZpY2Ugc2hvdWxkIHNpbXBseSBmaWxsIHRoZSBl
bnRpcmUgY29uZmlndXJhdGlvbiAKPj5hbmQgd2UgY2FuIGF2b2lkIGNvZGUgZHVwbGljYXRpb24u
Cj4+Cj4+U3RvcmluZyB0aGUgY29uZmlndXJhdGlvbiBpbiB0aGUgY29yZSBtYXkgYWxzbyBiZSB1
c2VmdWwgaWYgc29tZSAKPj5kZXZpY2UgbmVlZHMgdG8gc3VwcG9ydCBjb25maWcgd3JpdGVzLgo+
Cj4KPkkgdGhpbmsgaW4gdGhhdCB3YXkgd2UgbmVlZCBzaG91bGQgcHJvdmlkZSBjb25maWdfd3Jp
dGUoKS4KClllcywgSSdsbCBhZGQgc2V0X2NvbmZpZygpIGNhbGxiYWNrLgoKPgo+Cj4+Cj4+RG8g
eW91IHRoaW5rIGl0IG1ha2VzIHNlbnNlLCBvciBpcyBpdCBiZXR0ZXIgdG8gbW92ZSBldmVyeXRo
aW5nIGluIHRoZSAKPj5kZXZpY2U/Cj4KPgo+SSBwcmVmZXIgdG8gZG8gdGhhdCBpbiB0aGUgZGV2
aWNlIGJ1dCBpdCdzIGFsc28gZmluZSBrZWVwIHdoYXQgdGhlIAo+cGF0Y2ggaGFzIGRvbmUuCgpP
a2F5LCBmb3Igbm93IEknbGwga2VlcCBpdCBhbmQgYWRkIHRoZSBzZXRfY29uZmlnKCkgY2FsbGJh
Y2ssIGJ1dCBJJ20gCm9wZW4gdG8gbW92ZSBpdCBpbiB0aGUgZGV2aWNlLgoKVGhhbmtzLApTdGVm
YW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
