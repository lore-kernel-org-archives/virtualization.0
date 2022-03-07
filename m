Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E31C433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 10:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A4C240225;
	Mon,  7 Mar 2022 10:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T1m3xofennDe; Mon,  7 Mar 2022 10:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C72F740204;
	Mon,  7 Mar 2022 10:58:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98052C0012;
	Mon,  7 Mar 2022 10:58:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3E73C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE40C81BB2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kWdiJYTwiX2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:58:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D028681BB0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:58:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EB071F37D;
 Mon,  7 Mar 2022 10:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1646650701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCHMjY+ZPjiNIpWBX9vPX8pxE8O3mm4NFvjAqDMCwDA=;
 b=ePF8+laPogCunbljm3E0kk+a6ExGKTEIKOO0gEUvMD3VvpUmfSWzK14c0pIWu9HNiI/NuE
 hH85ECjaSu03dKP+zoa7OYBNmJFcJe66TqL2taJ/1DBqC0O2uqvd3dY4Az4XoREjo2vQ0+
 GMvl0TMyFKG4cS6+IefvwRNqEMbV3gk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ABC013AD8;
 Mon,  7 Mar 2022 10:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id djM+HEzlJWJ5PAAAMHmgww
 (envelope-from <jgross@suse.com>); Mon, 07 Mar 2022 10:58:20 +0000
Message-ID: <b3d6e048-6922-ce00-7c1f-3702695c2974@suse.com>
Date: Mon, 7 Mar 2022 11:58:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds as
 a perf event clock
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
References: <20220214110914.268126-1-adrian.hunter@intel.com>
 <20220214110914.268126-4-adrian.hunter@intel.com>
 <YiIXFmA4vpcTSk2L@hirez.programming.kicks-ass.net>
 <853ce127-25f0-d0fe-1d8f-0b0dd4f3ce71@intel.com>
 <YiXVgEk/1UClkygX@hirez.programming.kicks-ass.net>
 <f40937c9-35f6-ce86-f07b-5cea09a963af@suse.com>
 <YiXgirw1kFOPgBgY@hirez.programming.kicks-ass.net>
In-Reply-To: <YiXgirw1kFOPgBgY@hirez.programming.kicks-ass.net>
Cc: kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, H Peter Anvin <hpa@zytor.com>,
 Jiri Olsa <jolsa@redhat.com>, sthemmin@microsoft.com, x86@kernel.org,
 pv-drivers@vmware.com, Ingo Molnar <mingo@redhat.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew.Cooper3@citrix.com,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, seanjc@google.com,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 Leo Yan <leo.yan@linaro.org>, pbonzini@redhat.com
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: multipart/mixed; boundary="===============9056114250645005507=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============9056114250645005507==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------E3fHmzravdxJ5wg2RM8eMWCa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------E3fHmzravdxJ5wg2RM8eMWCa
Content-Type: multipart/mixed; boundary="------------i8OSTNlIs3fqr6qkIPVWLXyW";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 kvm@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@linaro.org>,
 sdeep@vmware.com, pv-drivers@vmware.com, pbonzini@redhat.com,
 seanjc@google.com, kys@microsoft.com, sthemmin@microsoft.com,
 virtualization@lists.linux-foundation.org, Andrew.Cooper3@citrix.com
Message-ID: <b3d6e048-6922-ce00-7c1f-3702695c2974@suse.com>
Subject: Re: [PATCH V2 03/11] perf/x86: Add support for TSC in nanoseconds as
 a perf event clock
References: <20220214110914.268126-1-adrian.hunter@intel.com>
 <20220214110914.268126-4-adrian.hunter@intel.com>
 <YiIXFmA4vpcTSk2L@hirez.programming.kicks-ass.net>
 <853ce127-25f0-d0fe-1d8f-0b0dd4f3ce71@intel.com>
 <YiXVgEk/1UClkygX@hirez.programming.kicks-ass.net>
 <f40937c9-35f6-ce86-f07b-5cea09a963af@suse.com>
 <YiXgirw1kFOPgBgY@hirez.programming.kicks-ass.net>
In-Reply-To: <YiXgirw1kFOPgBgY@hirez.programming.kicks-ass.net>

--------------i8OSTNlIs3fqr6qkIPVWLXyW
Content-Type: multipart/mixed; boundary="------------hMbD6nOPQ14JFkw0B4c45F9t"

--------------hMbD6nOPQ14JFkw0B4c45F9t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDMuMjIgMTE6MzgsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIE1h
ciAwNywgMjAyMiBhdCAxMTowNjo0NkFNICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvcGFyYXZpcnQuYw0KPj4+IGluZGV4IDQ0MjA0OTlmN2JiNC4uYTFmMTc5
ZWQzOWJmIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9wYXJhdmlydC5jDQo+
Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL3BhcmF2aXJ0LmMNCj4+PiBAQCAtMTQ1LDYgKzE0
NSwxNSBAQCBERUZJTkVfU1RBVElDX0NBTEwocHZfc2NoZWRfY2xvY2ssIG5hdGl2ZV9zY2hl
ZF9jbG9jayk7DQo+Pj4gICAgdm9pZCBwYXJhdmlydF9zZXRfc2NoZWRfY2xvY2sodTY0ICgq
ZnVuYykodm9pZCkpDQo+Pj4gICAgew0KPj4+ICsJLyoNCj4+PiArCSAqIEFueXRoaW5nIHdp
dGggQVJUIG9uIHByb21pc2VzIHRvIGhhdmUgc2FuZSBUU0MsIG90aGVyd2lzZSB0aGUgd2hv
bGUNCj4+PiArCSAqIEFSVCB0aGluZyBpcyB1c2VsZXNzLiBJbiBvcmRlciB0byBtYWtlIEFS
VCB1c2VmdWwgZm9yIGd1ZXN0cywgd2UNCj4+PiArCSAqIHNob3VsZCBjb250aW51ZSB0byB1
c2UgdGhlIFRTQy4gQXMgc3VjaCwgaWdub3JlIGFueSBwYXJhdmlydA0KPj4+ICsJICogbXVj
a2VyeS4NCj4+PiArCSAqLw0KPj4+ICsJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZF
QVRVUkVfQVJUKSkNCj4+PiArCQlyZXR1cm47DQo+Pj4gKw0KPj4+ICAgIAlzdGF0aWNfY2Fs
bF91cGRhdGUocHZfc2NoZWRfY2xvY2ssIGZ1bmMpOw0KPj4+ICAgIH0NCj4+Pg0KPj4NCj4+
IE5BSywgdGhpcyB3aWxsIGJyZWFrIGxpdmUgbWlncmF0aW9uIG9mIGEgZ3Vlc3QgY29taW5n
IGZyb20gYSBob3N0DQo+PiB3aXRob3V0IHRoaXMgZmVhdHVyZS4NCj4gDQo+IEkgdGhvdWdo
dCB0aGUgd2hvbGUgbGl2ZS1taWdyYXRpb24gbm9uc2Vuc2UgbWFkZSBzdXJlIHRvIGVxdWFs
aXplIGNydWQNCj4gbGlrZSB0aGF0LiBUaGF0IGlzLCB0aGVuIGRvbid0IGV4cG9zZSBBUlQg
dG8gdGhlIGd1ZXN0Lg0KDQpPaCwgcmlnaHQuIEkgbWFuYWdlZCB0byBjb25mdXNlIGhvc3Qt
c2lkZSBhbmQgZ3Vlc3Qtc2lkZSB1c2FnZS4NCg0KU29ycnkgZm9yIHRoZSBub2lzZS4NCg0K
DQpKdWVyZ2VuDQo=
--------------hMbD6nOPQ14JFkw0B4c45F9t
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------hMbD6nOPQ14JFkw0B4c45F9t--

--------------i8OSTNlIs3fqr6qkIPVWLXyW--

--------------E3fHmzravdxJ5wg2RM8eMWCa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmIl5UsFAwAAAAAACgkQsN6d1ii/Ey+l
nwf+P5PI/iiKDcEHE7/irYMs9uf9Oo2kAcgdy2+YvEEZXdsLTR4/v6y+ALFQAF940ROkKclH9Byf
h8MIpq5zDbgYQUh8zGvJIrJVDaularN2ge8sUJxT1hMTNBC5ZssFKEWUFMzYEm7zXFhdWews+ptE
bH95AJ/6NsXsVJ+KO3yU+SxDPfBmBs+rGIv61THrwGYiIDtwZD8Wqlq6C7oA1SYGFr5zAnO0UJ3J
VF2g333pEzb7qOFbCQhKfF1M4Q9OzPpd4y/1B1MUuHhpGg+qay3TYVpoYurlx72piiqKC+iqf5It
s1Tqp5TtA0zXw91OkKlttA6haoHUCHZeLJTScuR7qg==
=ZJzJ
-----END PGP SIGNATURE-----

--------------E3fHmzravdxJ5wg2RM8eMWCa--

--===============9056114250645005507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9056114250645005507==--
