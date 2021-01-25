Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F5C433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 08:43:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E31D22C9F
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 08:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E31D22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FEBF85E13;
	Mon, 25 Jan 2021 08:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eib20m1zyP9F; Mon, 25 Jan 2021 08:43:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7A2F85C86;
	Mon, 25 Jan 2021 08:43:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3224C1E6F;
	Mon, 25 Jan 2021 08:43:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 219B3C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 037F686851
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puD1W84JuFFo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:43:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 36AF58684F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611564211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgLn7mRLyLa5hY4Q/SNI7yc80bmJUoLZ6qDWh4ZcMp4=;
 b=YngRcebH8jQt5aeqohPn/sIXZvj7NEKbh/fwJgkJm6zo6al3zS+9Es4ZhU7g1gxWtUkLSd
 ahGHQr2QwSexw6LO6l6gg+MrOxFrhAfLVbxkQfN37Bjxk4sE/dVVATl6JCD1ZmY3l4Ouhj
 b7s/j6wfpAivsfev1YNvcdsAqoCVCMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-eg28SkrbPv-pCQq-Pyxj2w-1; Mon, 25 Jan 2021 03:43:27 -0500
X-MC-Unique: eg28SkrbPv-pCQq-Pyxj2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9047959;
 Mon, 25 Jan 2021 08:43:25 +0000 (UTC)
Received: from [10.36.113.217] (ovpn-113-217.ams2.redhat.com [10.36.113.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D143676E16;
 Mon, 25 Jan 2021 08:43:14 +0000 (UTC)
Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
To: Vivek Kumar Gautam <vivek.gautam@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
 <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7ccaa834-0a50-43cc-3da9-7ee13a0c52d2@redhat.com>
Date: Mon, 25 Jan 2021 09:43:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com, mst@redhat.com,
 joro@8bytes.org, will.deacon@arm.com, shameerali.kolothum.thodi@huawei.com,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, robin.murphy@arm.com
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

SGkgVml2ZWssCgpPbiAxLzIxLzIxIDY6MzQgUE0sIFZpdmVrIEt1bWFyIEdhdXRhbSB3cm90ZToK
PiBIaSBFcmljLAo+IAo+IAo+IE9uIDEvMTkvMjEgMjozMyBQTSwgQXVnZXIgRXJpYyB3cm90ZToK
Pj4gSGkgVml2ZWssCj4+Cj4+IE9uIDEvMTUvMjEgMToxMyBQTSwgVml2ZWsgR2F1dGFtIHdyb3Rl
Ogo+Pj4gVGhpcyBwYXRjaC1zZXJpZXMgYWltcyBhdCBlbmFibGluZyBOZXN0ZWQgc3RhZ2UgdHJh
bnNsYXRpb24gaW4gZ3Vlc3RzCj4+PiB1c2luZyB2aXJ0aW8taW9tbXUgYXMgdGhlIHBhcmF2aXJ0
dWFsaXplZCBpb21tdS4gVGhlIGJhY2tlbmQgaXMKPj4+IHN1cHBvcnRlZAo+Pj4gd2l0aCBBcm0g
U01NVS12MyB0aGF0IHByb3ZpZGVzIG5lc3RlZCBzdGFnZS0xIGFuZCBzdGFnZS0yIHRyYW5zbGF0
aW9uLgo+Pj4KPj4+IFRoaXMgc2VyaWVzIGRlcml2ZXMgaXRzIHB1cnBvc2UgZnJvbSB2YXJpb3Vz
IGVmZm9ydHMgaGFwcGVuaW5nIHRvIGFkZAo+Pj4gc3VwcG9ydCBmb3IgU2hhcmVkIFZpcnR1YWwg
QWRkcmVzc2luZyAoU1ZBKSBpbiBob3N0IGFuZCBndWVzdC4gT24gQXJtLAo+Pj4gbW9zdCBvZiB0
aGUgc3VwcG9ydCBmb3IgU1ZBIGhhcyBhbHJlYWR5IGxhbmRlZC4gVGhlIHN1cHBvcnQgZm9yIG5l
c3RlZAo+Pj4gc3RhZ2UgdHJhbnNsYXRpb24gYW5kIGZhdWx0IHJlcG9ydGluZyB0byBndWVzdCBo
YXMgYmVlbiBwcm9wb3NlZCBbMV0uCj4+PiBUaGUgcmVsYXRlZCBjaGFuZ2VzIHJlcXVpcmVkIGlu
IFZGSU8gWzJdIGZyYW1ld29yayBoYXZlIGFsc28gYmVlbiBwdXQKPj4+IGZvcndhcmQuCj4+Pgo+
Pj4gVGhpcyBzZXJpZXMgcHJvcG9zZXMgY2hhbmdlcyBpbiB2aXJ0aW8taW9tbXUgdG8gcHJvZ3Jh
bSBQQVNJRCB0YWJsZXMKPj4+IGFuZCByZWxhdGVkIHN0YWdlLTEgcGFnZSB0YWJsZXMuIEEgc2lt
cGxlIGlvbW11LXBhc2lkLXRhYmxlIGxpYnJhcnkKPj4+IGlzIGFkZGVkIGZvciB0aGlzIHB1cnBv
c2UgdGhhdCBpbnRlcmFjdHMgd2l0aCB2ZW5kb3IgZHJpdmVycyB0bwo+Pj4gYWxsb2NhdGUgYW5k
IHBvcHVsYXRlIFBBU0lEIHRhYmxlcy4KPj4+IEluIEFybSBTTU1VdjMgd2UgcHJvcG9zZSB0byBw
dWxsIHRoZSBDb250ZXh0IERlc2NyaXB0b3IgKENEKSBtYW5hZ2VtZW50Cj4+PiBjb2RlIG91dCBv
ZiB0aGUgYXJtLXNtbXUtdjMgZHJpdmVyIGFuZCBhZGQgdGhhdCBhcyBhIGdsdWUgdmVuZG9yIGxh
eWVyCj4+PiB0byBzdXBwb3J0IGFsbG9jYXRpbmcgQ0QgdGFibGVzLCBhbmQgcG9wdWxhdGluZyB0
aGVtIHdpdGggcmlnaHQgdmFsdWVzLgo+Pj4gVGhlc2UgQ0QgdGFibGVzIGFyZSBlc3NlbnRpYWxs
eSB0aGUgUEFTSUQgdGFibGVzIGFuZCBjb250YWluIHN0YWdlLTEKPj4+IHBhZ2UgdGFibGUgY29u
ZmlndXJhdGlvbnMgdG9vLgo+Pj4gQSByZXF1ZXN0IHRvIHNldHVwIHRoZXNlIENEIHRhYmxlcyBj
b21lIGZyb20gdmlydGlvLWlvbW11IGRyaXZlciB1c2luZwo+Pj4gdGhlIGlvbW11LXBhc2lkLXRh
YmxlIGxpYnJhcnkgd2hlbiBydW5uaW5nIG9uIEFybS4gVGhlIHZpcnRpby1pb21tdQo+Pj4gdGhl
biBwYXNzIHRoZXNlIFBBU0lEIHRhYmxlcyB0byB0aGUgaG9zdCB1c2luZyB0aGUgcmlnaHQgdmly
dGlvIGJhY2tlbmQKPj4+IGFuZCBzdXBwb3J0IGluIFZNTS4KPj4+Cj4+PiBGb3IgdGVzdGluZyB3
ZSBoYXZlIGFkZGVkIG5lY2Vzc2FyeSBzdXBwb3J0IGluIGt2bXRvb2wuIFRoZSBjaGFuZ2VzIGlu
Cj4+PiBrdm10b29sIGFyZSBiYXNlZCBvbiB2aXJ0aW8taW9tbXUgZGV2ZWxvcG1lbnQgYnJhbmNo
IGJ5IEplYW4tUGhpbGlwcGUKPj4+IEJydWNrZXIgWzNdLgo+Pj4KPj4+IFRoZSB0ZXN0ZWQga2Vy
bmVsIGJyYW5jaCBjb250YWlucyBmb2xsb3dpbmcgaW4gdGhlIG9yZGVyIGJvdHRvbSB0byB0b3AK
Pj4+IG9uIHRoZSBnaXQgaGFzaCAtCj4+PiBhKSB2NS4xMS1yYzMKPj4+IGIpIGFybS1zbW11LXYz
IFsxXSBhbmQgdmZpbyBbMl0gY2hhbmdlcyBmcm9tIEVyaWMgdG8gYWRkIG5lc3RlZCBwYWdlCj4+
PiDCoMKgwqAgdGFibGUgc3VwcG9ydCBmb3IgQXJtLgo+Pj4gYykgU21tdSB0ZXN0IGVuZ2luZSBw
YXRjaGVzIGZyb20gSmVhbi1QaGlsaXBwZSdzIGJyYW5jaCBbNF0KPj4+IGQpIFRoaXMgc2VyaWVz
Cj4+PiBlKSBEb21haW4gbmVzdGluZyBpbmZvIHBhdGNoZXMgWzVdWzZdWzddLgo+Pj4gZikgQ2hh
bmdlcyB0byBhZGQgYXJtLXNtbXUtdjMgc3BlY2lmaWMgbmVzdGluZyBpbmZvICh0byBiZSBzZW50
IHRvCj4+PiDCoMKgwqAgdGhlIGxpc3QpLgo+Pj4KPj4+IFRoaXMga2VybmVsIGlzIHRlc3RlZCBv
biBOZW92ZXJzZSByZWZlcmVuY2Ugc29mdHdhcmUgc3RhY2sgd2l0aAo+Pj4gRml4ZWQgdmlydHVh
bCBwbGF0Zm9ybS4gUHVibGljIHZlcnNpb24gb2YgdGhlIHNvZnR3YXJlIHN0YWNrIGFuZAo+Pj4g
RlZQIGlzIGF2YWlsYWJsZSBoZXJlWzhdWzldLgo+Pj4KPj4+IEEgYmlnIHRoYW5rcyB0byBKZWFu
LVBoaWxpcHBlIGZvciBoaXMgY29udHJpYnV0aW9ucyB0b3dhcmRzIHRoaXMgd29yawo+Pj4gYW5k
IGZvciBoaXMgdmFsdWFibGUgZ3VpZGFuY2UuCj4+Pgo+Pj4gWzFdCj4+PiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIwMTExODExMjE1MS4yNTQxMi0xLWVyaWMuYXVnZXJA
cmVkaGF0LmNvbS9ULwo+Pj4KPj4+IFsyXQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3Zt
YXJtLzIwMjAxMTE2MTEwMDMwLjMyMzM1LTEyLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS9ULwo+Pj4K
Pj4+IFszXSBodHRwczovL2pwYnJ1Y2tlci5uZXQvZ2l0L2t2bXRvb2wvbG9nLz9oPXZpcnRpby1p
b21tdS9kZXZlbAo+Pj4gWzRdIGh0dHBzOi8vanBicnVja2VyLm5ldC9naXQvbGludXgvbG9nLz9o
PXN2YS9zbW11dGUKPj4+IFs1XQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzE1OTk3
MzQ3MzMtNjQzMS0yLWdpdC1zZW5kLWVtYWlsLXlpLmwubGl1QGludGVsLmNvbS8KPj4+Cj4+PiBb
Nl0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8xNTk5NzM0NzMzLTY0MzEtMy1naXQt
c2VuZC1lbWFpbC15aS5sLmxpdUBpbnRlbC5jb20vCj4+Pgo+Pj4gWzddCj4+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9rdm0vMTU5OTczNDczMy02NDMxLTQtZ2l0LXNlbmQtZW1haWwteWkubC5s
aXVAaW50ZWwuY29tLwo+Pj4KPj4+IFs4XQo+Pj4gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS90
b29scy1hbmQtc29mdHdhcmUvb3Blbi1zb3VyY2Utc29mdHdhcmUvYXJtLXBsYXRmb3Jtcy1zb2Z0
d2FyZS9hcm0tZWNvc3lzdGVtLWZ2cHMKPj4+Cj4+PiBbOV0KPj4+IGh0dHBzOi8vZ2l0LmxpbmFy
by5vcmcvbGFuZGluZy10ZWFtcy93b3JraW5nL2FybS9hcm0tcmVmZXJlbmNlLXBsYXRmb3Jtcy5n
aXQvYWJvdXQvZG9jcy9yZG4xZWRnZS91c2VyLWd1aWRlLnJzdAo+Pj4KPj4KPj4gQ291bGQgeW91
IHNoYXJlIGEgcHVibGljIGJyYW5jaCB3aGVyZSB3ZSBjb3VsZCBmaW5kIGFsbCB0aGUga2VybmVs
Cj4+IHBpZWNlcy4KPj4KPj4gVGhhbmsgeW91IGluIGFkdmFuY2UKPiAKPiBBcG9sb2dpZXMgZm9y
IHRoZSBkZWxheS4gSXQgdG9vayBhIGJpdCBvZiB0aW1lIHRvIHNvcnQgdGhpbmdzIG91dCBmb3Ig
YQo+IHB1YmxpYyBicmFuY2guCj4gVGhlIGJyYW5jaCBpcyBhdmFpbGFibGUgaW4gbXkgZ2l0aHVi
IG5vdy4gUGxlYXNlIGhhdmUgYSBsb29rLgo+IAo+IGh0dHBzOi8vZ2l0aHViLmNvbS92aXZlay1h
cm0vbGludXgvdHJlZS81LjExLXJjMy1uZXN0ZWQtcGd0YmwtYXJtLXNtbXV2My12aXJ0aW8taW9t
bXUKCm5vIHByb2JsZW0uIFRoYW5rIHlvdSBmb3IgdGhlIGxpbmsuCgpCZXN0IFJlZ2FyZHMKCkVy
aWMKPiAKPiAKPiAKPiBUaGFua3MgYW5kIHJlZ2FyZHMKPiBWaXZlawo+IAo+Pgo+PiBCZXN0IFJl
Z2FyZHMKPj4KPj4gRXJpYwo+Pj4KPj4+IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciAoNik6Cj4+PiDC
oMKgIGlvbW11L3ZpcnRpbzogQWRkIGhlYWRlcnMgZm9yIHRhYmxlIGZvcm1hdCBwcm9iaW5nCj4+
PiDCoMKgIGlvbW11L3ZpcnRpbzogQWRkIHRhYmxlIGZvcm1hdCBwcm9iaW5nCj4+PiDCoMKgIGlv
bW11L3ZpcnRpbzogQWRkIGhlYWRlcnMgZm9yIGJpbmRpbmcgcGFzaWQgdGFibGUgaW4gaW9tbXUK
Pj4+IMKgwqAgaW9tbXUvdmlydGlvOiBBZGQgc3VwcG9ydCBmb3IgSU5WQUxJREFURSByZXF1ZXN0
Cj4+PiDCoMKgIGlvbW11L3ZpcnRpbzogQXR0YWNoIEFybSBQQVNJRCB0YWJsZXMgd2hlbiBhdmFp
bGFibGUKPj4+IMKgwqAgaW9tbXUvdmlydGlvOiBBZGQgc3VwcG9ydCBmb3IgQXJtIExQQUUgcGFn
ZSB0YWJsZSBmb3JtYXQKPj4+Cj4+PiBWaXZlayBHYXV0YW0gKDkpOgo+Pj4gwqDCoCBpb21tdS9h
cm0tc21tdS12MzogQ3JlYXRlIGEgQ29udGV4dCBEZXNjcmlwdG9yIGxpYnJhcnkKPj4+IMKgwqAg
aW9tbXU6IEFkZCBhIHNpbXBsZSBQQVNJRCB0YWJsZSBsaWJyYXJ5Cj4+PiDCoMKgIGlvbW11L2Fy
bS1zbW11LXYzOiBVcGRhdGUgZHJpdmVycyB0byB3b3JrIHdpdGggaW9tbXUtcGFzaWQtdGFibGUK
Pj4+IMKgwqAgaW9tbXUvYXJtLXNtbXUtdjM6IFVwZGF0ZSBDRCBiYXNlIGFkZHJlc3MgaW5mbyBm
b3IgdXNlci1zcGFjZQo+Pj4gwqDCoCBpb21tdS9hcm0tc21tdS12MzogU2V0IHN5bmMgb3AgZnJv
bSBjb25zdW1lciBkcml2ZXIgb2YgY2QtbGliCj4+PiDCoMKgIGlvbW11OiBBZGQgYXNpZF9iaXRz
IHRvIGFybSBzbW11LXYzIHN0YWdlMSB0YWJsZSBpbmZvCj4+PiDCoMKgIGlvbW11L3ZpcnRpbzog
VXBkYXRlIHRhYmxlIGZvcm1hdCBwcm9iaW5nIGhlYWRlcgo+Pj4gwqDCoCBpb21tdS92aXJ0aW86
IFByZXBhcmUgdG8gYWRkIGF0dGFjaCBwYXNpZCB0YWJsZSBpbmZyYXN0cnVjdHVyZQo+Pj4gwqDC
oCBpb21tdS92aXJ0aW86IFVwZGF0ZSBmYXVsdCB0eXBlIGFuZCByZWFzb24gaW5mbyBmb3Igdmlv
bW11IGZhdWx0Cj4+Pgo+Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvTWFrZWZp
bGXCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstCj4+PiDCoCAuLi4vYXJtL2FybS1zbW11LXYzL2Fy
bS1zbW11LXYzLWNkLWxpYi5jwqDCoMKgwqDCoCB8IDI4MyArKysrKysrCj4+PiDCoCAuLi4vaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLXN2YS5jwqDCoCB8wqAgMTYgKy0KPj4+IMKg
IGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmPCoMKgIHwgMjY4ICst
LS0tLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmjC
oMKgIHzCoMKgIDQgKy0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvaW9tbXUtcGFzaWQtdGFibGUuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0MCArKysrCj4+PiDCoCBkcml2ZXJzL2lvbW11L3Zp
cnRpby1pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDY5MiArKysr
KysrKysrKysrKysrKy0KPj4+IMKgIGluY2x1ZGUvdWFwaS9saW51eC9pb21tdS5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQo+Pj4gwqAgaW5jbHVkZS91
YXBpL2xpbnV4L3ZpcnRpb19pb21tdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTU4ICsr
Ky0KPj4+IMKgIDkgZmlsZXMgY2hhbmdlZCwgMTMwMyBpbnNlcnRpb25zKCspLCAyNjIgZGVsZXRp
b25zKC0pCj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMtY2QtbGliLmMKPj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2lvbW11L2lvbW11LXBhc2lkLXRhYmxlLmgKPj4+Cj4+Cj4gCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdAo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo+IAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
