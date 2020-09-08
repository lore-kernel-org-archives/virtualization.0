Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44EC433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 10:26:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C483C20672
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 10:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsPUQ/TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C483C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59B4C86599;
	Tue,  8 Sep 2020 10:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Trn4uIXiqXIW; Tue,  8 Sep 2020 10:26:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDC4A86888;
	Tue,  8 Sep 2020 10:26:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDC9FC0052;
	Tue,  8 Sep 2020 10:26:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDD6AC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 10:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 93EA0272DF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 10:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q1QHDug6xZr4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 10:26:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id F106322EE7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599560793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mOMtXpC9w9DNODyqnAlcSJZsWHWQ8hOHZ9+OpCpEsMo=;
 b=VsPUQ/TJEY0kFx1NlbCSt6bLZMUOvGYrYfUI4odbdttPvuU3LFevrICYA4/LxIqxKVULlX
 HDbJV3ED1EOstDcHmliQSggFVfftK/tP38rqW08Hr1IlH0HPDCYM2mLPzdMKv8aGiym5ii
 W53t/ZSs4weSVJyYhxJkUs14HNEsAEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-ocpL4LifPeKj0Evr1s394g-1; Tue, 08 Sep 2020 06:26:29 -0400
X-MC-Unique: ocpL4LifPeKj0Evr1s394g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C691007467;
 Tue,  8 Sep 2020 10:26:26 +0000 (UTC)
Received: from [10.36.115.46] (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA7021002D46;
 Tue,  8 Sep 2020 10:26:21 +0000 (UTC)
Subject: Re: [PATCH v1 2/5] kernel/resource: merge_system_ram_resources() to
 merge resources after hotplug
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20200821103431.13481-1-david@redhat.com>
 <20200821103431.13481-3-david@redhat.com>
 <CAM9Jb+hJ8YSB6XZi6CB3jU-LSdVhKGZw=6NESzFhY7bbU9uOSQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <93e5b25b-ff00-b6b7-eb1e-b051ea6dcbe5@redhat.com>
Date: Tue, 8 Sep 2020 12:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+hJ8YSB6XZi6CB3jU-LSdVhKGZw=6NESzFhY7bbU9uOSQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
 Ard Biesheuvel <ardb@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org,
 Julien Grall <julien@xen.org>, Kees Cook <keescook@chromium.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
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

T24gMzEuMDguMjAgMTE6MzUsIFBhbmthaiBHdXB0YSB3cm90ZToKPj4gU29tZSBhZGRfbWVtb3J5
KigpIHVzZXJzIGFkZCBtZW1vcnkgaW4gc21hbGwsIGNvbnRpZ3VvdXMgbWVtb3J5IGJsb2Nrcy4K
Pj4gRXhhbXBsZXMgaW5jbHVkZSB2aXJ0aW8tbWVtLCBoeXBlci12IGJhbGxvb24sIGFuZCB0aGUg
WEVOIGJhbGxvb24uCj4+Cj4+IFRoaXMgY2FuIHF1aWNrbHkgcmVzdWx0IGluIGEgbG90IG9mIG1l
bW9yeSByZXNvdXJjZXMsIHdoZXJlYnkgdGhlIGFjdHVhbAo+PiByZXNvdXJjZSBib3VuZGFyaWVz
IGFyZSBub3Qgb2YgaW50ZXJlc3QgKGUuZy4sIGl0IG1pZ2h0IGJlIHJlbGV2YW50IGZvcgo+PiBE
SU1NcywgZXhwb3NlZCB2aWEgL3Byb2MvaW9tZW0gdG8gdXNlciBzcGFjZSkuIFdlIHJlYWxseSB3
YW50IHRvIG1lcmdlCj4+IGFkZGVkIHJlc291cmNlcyBpbiB0aGlzIHNjZW5hcmlvIHdoZXJlIHBv
c3NpYmxlLgo+Pgo+PiBMZXQncyBwcm92aWRlIGFuIGludGVyZmFjZSB0byB0cmlnZ2VyIG1lcmdp
bmcgb2YgYXBwbGljYWJsZSBjaGlsZAo+PiByZXNvdXJjZXMuIEl0IHdpbGwgYmUsIGZvciBleGFt
cGxlLCB1c2VkIGJ5IHZpcnRpby1tZW0gdG8gdHJpZ2dlcgo+PiBtZXJnaW5nIG9mIHN5c3RlbSBy
YW0gcmVzb3VyY2VzIGl0IGFkZGVkIHRvIGl0cyByZXNvdXJjZSBjb250YWluZXIsIGJ1dAo+PiBh
bHNvIGJ5IFhFTiBhbmQgSHlwZXItViB0byB0cmlnZ2VyIG1lcmdpbmcgb2Ygc3lzdGVtIHJhbSBy
ZXNvdXJjZXMgaW4KPj4gaW9tZW1fcmVzb3VyY2UuCj4+Cj4+IE5vdGU6IFdlIHJlYWxseSB3YW50
IHRvIG1lcmdlIGFmdGVyIHRoZSB3aG9sZSBvcGVyYXRpb24gc3VjY2VlZGVkLCBub3QKPj4gZGly
ZWN0bHkgd2hlbiBhZGRpbmcgYSByZXNvdXJjZSB0byB0aGUgcmVzb3VyY2UgdHJlZSAoaXQgd291
bGQgYnJlYWsKPj4gYWRkX21lbW9yeV9yZXNvdXJjZSgpIGFuZCByZXF1aXJlIHNwbGl0dGluZyBy
ZXNvdXJjZXMgYWdhaW4gd2hlbiB0aGUKPj4gb3BlcmF0aW9uIGZhaWxlZCAtIGUuZy4sIGR1ZSB0
byAtRU5PTUVNKS4KPj4KPj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlv
bi5vcmc+Cj4+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KPj4gQ2M6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+PiBDYzogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+Cj4+IENjOiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4K
Pj4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Cj4+IENjOiBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPj4gQ2M6ICJLLiBZLiBTcmluaXZhc2FuIiA8a3lz
QG1pY3Jvc29mdC5jb20+Cj4+IENjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQu
Y29tPgo+PiBDYzogU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29mdC5jb20+Cj4+
IENjOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+Cj4+IENjOiBCb3JpcyBPc3Ryb3Zza3kg
PGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPgo+PiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3Nz
QHN1c2UuY29tPgo+PiBDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwu
b3JnPgo+PiBDYzogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+Cj4+IENj
OiBKdWxpZW4gR3JhbGwgPGp1bGllbkB4ZW4ub3JnPgo+PiBDYzogUGFua2FqIEd1cHRhIDxwYW5r
YWouZ3VwdGEubGludXhAZ21haWwuY29tPgo+PiBDYzogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5j
b20+Cj4+IENjOiBXZWkgWWFuZyA8cmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20+Cj4+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgo+PiAtLS0K
Pj4gIGluY2x1ZGUvbGludXgvaW9wb3J0LmggfCAgMyArKysKPj4gIGtlcm5lbC9yZXNvdXJjZS5j
ICAgICAgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4g
IDIgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9pb3BvcnQuaCBiL2luY2x1ZGUvbGludXgvaW9wb3J0LmgKPj4gaW5kZXggNTJh
OTFmNWZhMWEzNi4uM2JiMDAyMGNkNmRkYyAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9p
b3BvcnQuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2lvcG9ydC5oCj4+IEBAIC0yNTEsNiArMjUx
LDkgQEAgZXh0ZXJuIHZvaWQgX19yZWxlYXNlX3JlZ2lvbihzdHJ1Y3QgcmVzb3VyY2UgKiwgcmVz
b3VyY2Vfc2l6ZV90LAo+PiAgZXh0ZXJuIHZvaWQgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFi
bGUoc3RydWN0IHJlc291cmNlICosIHJlc291cmNlX3NpemVfdCwKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2Vfc2l6ZV90KTsKPj4gICNlbmRpZgo+
PiArI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVRwo+PiArZXh0ZXJuIHZvaWQgbWVyZ2Vfc3lz
dGVtX3JhbV9yZXNvdXJjZXMoc3RydWN0IHJlc291cmNlICpyZXMpOwo+PiArI2VuZGlmCj4+Cj4+
ICAvKiBXcmFwcGVycyBmb3IgbWFuYWdlZCBkZXZpY2VzICovCj4+ICBzdHJ1Y3QgZGV2aWNlOwo+
PiBkaWZmIC0tZ2l0IGEva2VybmVsL3Jlc291cmNlLmMgYi9rZXJuZWwvcmVzb3VyY2UuYwo+PiBp
bmRleCAxZGNlZjVkNTNkNzZlLi5iNGUwOTYzZWRhZGQyIDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwv
cmVzb3VyY2UuYwo+PiArKysgYi9rZXJuZWwvcmVzb3VyY2UuYwo+PiBAQCAtMTM2MCw2ICsxMzYw
LDU4IEBAIHZvaWQgcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoc3RydWN0IHJlc291cmNl
ICpwYXJlbnQsCj4+ICB9Cj4+ICAjZW5kaWYgLyogQ09ORklHX01FTU9SWV9IT1RSRU1PVkUgKi8K
Pj4KPj4gKyNpZmRlZiBDT05GSUdfTUVNT1JZX0hPVFBMVUcKPj4gK3N0YXRpYyBib29sIHN5c3Rl
bV9yYW1fcmVzb3VyY2VzX21lcmdlYWJsZShzdHJ1Y3QgcmVzb3VyY2UgKnIxLAo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJlc291cmNlICpyMikK
Pj4gK3sKPj4gKyAgICAgICByZXR1cm4gcjEtPmZsYWdzID09IHIyLT5mbGFncyAmJiByMS0+ZW5k
ICsgMSA9PSByMi0+c3RhcnQgJiYKPj4gKyAgICAgICAgICAgICAgcjEtPm5hbWUgPT0gcjItPm5h
bWUgJiYgcjEtPmRlc2MgPT0gcjItPmRlc2MgJiYKPj4gKyAgICAgICAgICAgICAgIXIxLT5jaGls
ZCAmJiAhcjItPmNoaWxkOwo+PiArfQo+PiArCj4+ICsvKgo+PiArICogbWVyZ2Vfc3lzdGVtX3Jh
bV9yZXNvdXJjZXMgLSB0cnkgdG8gbWVyZ2UgY29udGlndW91cyBzeXN0ZW0gcmFtIHJlc291cmNl
cwo+PiArICogQHBhcmVudDogcGFyZW50IHJlc291cmNlIGRlc2NyaXB0b3IKPj4gKyAqCj4+ICsg
KiBUaGlzIGludGVyZmFjZSBpcyBpbnRlbmRlZCBmb3IgbWVtb3J5IGhvdHBsdWcsIHdoZXJlYnkg
bG90cyBvZiBjb250aWd1b3VzCj4+ICsgKiBzeXN0ZW0gcmFtIHJlc291cmNlcyBhcmUgYWRkZWQg
KGUuZy4sIHZpYSBhZGRfbWVtb3J5KigpKSBieSBhIGRyaXZlciwgYW5kCj4+ICsgKiB0aGUgYWN0
dWFsIHJlc291cmNlIGJvdW5kYXJpZXMgYXJlIG5vdCBvZiBpbnRlcmVzdCAoZS5nLiwgaXQgbWln
aHQgYmUKPj4gKyAqIHJlbGV2YW50IGZvciBESU1NcykuIE9ubHkgaW1tZWRpYXRlIGNoaWxkIHJl
c291cmNlcyB0aGF0IGFyZSBidXN5IGFuZAo+PiArICogZG9uJ3QgaGF2ZSBhbnkgY2hpbGRyZW4g
YXJlIGNvbnNpZGVyZWQuIEFsbCBhcHBsaWNhYmxlIGNoaWxkIHJlc291cmNlcwo+PiArICogbXVz
dCBiZSBpbW11dGFibGUgZHVyaW5nIHRoZSByZXF1ZXN0Lgo+PiArICoKPj4gKyAqIE5vdGU6Cj4+
ICsgKiAtIFRoZSBjYWxsZXIgaGFzIHRvIG1ha2Ugc3VyZSB0aGF0IG5vIHBvaW50ZXJzIHRvIHJl
c291cmNlcyB0aGF0IG1pZ2h0Cj4+ICsgKiAgIGdldCBtZXJnZWQgYXJlIGhlbGQgYW55bW9yZS4g
Q2FsbGVycyBzaG91bGQgb25seSB0cmlnZ2VyIG1lcmdpbmcgb2YgY2hpbGQKPj4gKyAqICAgcmVz
b3VyY2VzIHdoZW4gdGhleSBhcmUgdGhlIG9ubHkgb25lIGFkZGluZyBzeXN0ZW0gcmFtIHJlc291
cmNlcyB0byB0aGUKPj4gKyAqICAgcGFyZW50IChiZXNpZGVzIGR1cmluZyBib290KS4KPj4gKyAq
IC0gcmVsZWFzZV9tZW1fcmVnaW9uX2FkanVzdGFibGUoKSB3aWxsIHNwbGl0IG9uIGRlbWFuZCBv
biBtZW1vcnkgaG90dW5wbHVnCj4+ICsgKi8KPj4gK3ZvaWQgbWVyZ2Vfc3lzdGVtX3JhbV9yZXNv
dXJjZXMoc3RydWN0IHJlc291cmNlICpwYXJlbnQpCj4+ICt7Cj4+ICsgICAgICAgY29uc3QgdW5z
aWduZWQgbG9uZyBmbGFncyA9IElPUkVTT1VSQ0VfU1lTVEVNX1JBTSB8IElPUkVTT1VSQ0VfQlVT
WTsKPj4gKyAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKmN1ciwgKm5leHQ7Cj4+ICsKPj4gKyAgICAg
ICB3cml0ZV9sb2NrKCZyZXNvdXJjZV9sb2NrKTsKPj4gKwo+PiArICAgICAgIGN1ciA9IHBhcmVu
dC0+Y2hpbGQ7Cj4+ICsgICAgICAgd2hpbGUgKGN1ciAmJiBjdXItPnNpYmxpbmcpIHsKPj4gKyAg
ICAgICAgICAgICAgIG5leHQgPSBjdXItPnNpYmxpbmc7Cj4+ICsgICAgICAgICAgICAgICBpZiAo
KGN1ci0+ZmxhZ3MgJiBmbGFncykgPT0gZmxhZ3MgJiYKPiAKPiBNYXliZSB0aGlzIGNhbiBiZSBj
aGFuZ2VkIHRvOgo+ICEoY3VyLT5mbGFncyAmIH5mbGFncykKClRoYXQgd291bGQgYmUgZGlmZmVy
ZW50IEkgdGhpbmsuCgooY3VyLT5mbGFncyAmIGZsYWdzKSA9PSBmbGFncwpjaGVja3MgdGhhdCBh
bGwgImZsYWdzIiBhcmUgc2V0IChhZGRpdGlvbmFsIG9uZXMgbWlnaHQgYmUgc2V0KS4KCiEoY3Vy
LT5mbGFncyAmIH5mbGFncykKY2hlY2tzIHRoYXQgbm8gb3RoZXIgZmxhZ3MgYmVzaWRlcyAiZmxh
Z3MiIGFyZSBzZXQgKGFuZCAiZmxhZ3MiIGFyZSBub3QKcmVxdWlyZWQgdG8gYmUgc2V0KS4KCgpX
ZSB1c2UgdGhlIHNhbWUgaGFuZGxpbmcgaW4gZmluZF9uZXh0X2lvbWVtX3JlcygpLCBlLmcuLCBj
YWxsZWQgdmlhCndhbGtfc3lzdGVtX3JhbV9yYW5nZSBhbHNvIHdpdGggSU9SRVNPVVJDRV9TWVNU
RU1fUkFNIHwgSU9SRVNPVVJDRV9CVVNZLgoKVGhhbmtzIGZvciBoYXZpbmcgYSBsb29rIQoKLS0g
ClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
