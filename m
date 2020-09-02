Return-Path: <SRS0=yxq9=CL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA0FC433E2
	for <virtualization@archiver.kernel.org>; Wed,  2 Sep 2020 10:34:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD6B2071B
	for <virtualization@archiver.kernel.org>; Wed,  2 Sep 2020 10:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2B1P7FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD6B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 51B70204E6;
	Wed,  2 Sep 2020 10:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2B+NoXfejXFW; Wed,  2 Sep 2020 10:34:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DD1DC20462;
	Wed,  2 Sep 2020 10:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACAECC07FF;
	Wed,  2 Sep 2020 10:34:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1BAC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2AA6C87130
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xn201hH56Xzt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:34:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 403D0856CA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXBhtaRI8GbK37HD3MQj1XXzIUWZBG4uV41KUm49E4E=;
 b=F2B1P7FW9d6ZPl6fO64DmVce41HtfH8+Lgbtt60PqftsG1RyO94j58cDZpNCcOD8jksW7e
 BYl4VwHf9DBf9muq3YNqZ0hIDP2PeB1k0L4lFjTFc/xZSROd6kSLm+Twa1FHIvhISzfPBG
 3xF4hFfSSAXNPFL+TBHkUNwl0wCu8sI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-iN1Cxq4BNam-v97Cn-mr_w-1; Wed, 02 Sep 2020 06:34:15 -0400
X-MC-Unique: iN1Cxq4BNam-v97Cn-mr_w-1
Received: by mail-ej1-f69.google.com with SMTP id m24so1960005eje.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Sep 2020 03:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=6YbE9ocgSEbs212dC/3NaXleeyro7z5HehKfcKWSbBA=;
 b=gjJEX+lpbfWK5oVDV+W1a7I1nSHlBqcI+P5+bKXwyo1BX9dSNLRay9BC4koXD0AX8r
 C895FYPiE/gMXb9nweF3fXrv3csIrkwyOHKFfBQmxWwka+hkuZJXE2hu/3FeRI3+csLn
 g3xKIGwaDKqiGrSg6u4ul/fSkp/CtK6MaUUNB2AOkTC3b/2HzFBwNHmYCxb4YzDm/c3K
 zJ4q0ZgD0UDLcB7JUhpoTq9hRSZv1L67KjQHMlzWL6dUiJ5qQ3uOtdSz4RZLvvDC9rLM
 l65uGJhP77vGKWnVHy1w20YpAZXlnCWV1IZX7KbhHHwnk33XyjED0ioxmAwtXhZqxQZD
 z6Pg==
X-Gm-Message-State: AOAM533zb4e6Sz5tJ3VGXAyYrEY4od+aGxxzySVJr7eY84BUJZH0vlG1
 9dcWJISM/gtTEfibtr4GSWaDf078lTOdWR0+4rap+i/H8HM3++Qrs3PCfxc8y+MkoTgldftw1z1
 c0yjRH21NDXXVii/cR4sm8QxPGYcGSijPDGX8HmZ4IA==
X-Received: by 2002:a50:8e52:: with SMTP id 18mr5951895edx.28.1599042853961;
 Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyfvB2OEfbLYHiQ0iuRWX5RnGHRm0NO4ryqac7O6KtUoD1XTteJLc6sk4G2sRZytr3cwXHFA==
X-Received: by 2002:a50:8e52:: with SMTP id 18mr5951872edx.28.1599042853725;
 Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
Received: from ?IPv6:2003:c2:2f12:bb04:81d3:a22d:db7e:2eac?
 (p200300c22f12bb0481d3a22ddb7e2eac.dip0.t-ipconnect.de.
 [2003:c2:2f12:bb04:81d3:a22d:db7e:2eac])
 by smtp.gmail.com with ESMTPSA id x1sm3831470ejc.119.2020.09.02.03.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 4/5] xen/balloon: try to merge system ram resources
Date: Wed, 2 Sep 2020 12:34:12 +0200
Message-Id: <24371321-8A12-4EBD-864C-A2B50E886BF7@redhat.com>
References: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
In-Reply-To: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
To: =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
X-Mailer: iPhone Mail (17G68)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0.503
X-Mimecast-Originator: redhat.com
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Julien Grall <julien@xen.org>,
 Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wei Yang <richardw.yang@linux.intel.com>, xen-devel@lists.xenproject.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 =?utf-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
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

Cgo+IEFtIDAyLjA5LjIwMjAgdW0gMTI6MTUgc2NocmllYiBKw7xyZ2VuIEdyb8OfIDxqZ3Jvc3NA
c3VzZS5jb20+Ogo+IAo+IO+7v09uIDIxLjA4LjIwIDEyOjM0LCBEYXZpZCBIaWxkZW5icmFuZCB3
cm90ZToKPj4gTGV0J3MgcmV1c2UgdGhlIG5ldyBtZWNoYW5pc20gdG8gbWVyZ2Ugc3lzdGVtIHJh
bSByZXNvdXJjZXMgYmVsb3cgdGhlCj4+IHJvb3QuIFdlIGFyZSB0aGUgb25seSBvbmUgaG90cGx1
Z2dpbmcgc3lzdGVtIHJhbSAoZS5nLiwgRElNTXMgZG9uJ3QgYXBwbHkpLAo+PiBzbyB0aGlzIGlz
IHNhZmUgdG8gYmUgdXNlZC4KPj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRh
dGlvbi5vcmc+Cj4+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KPj4gQ2M6IEJv
cmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+Cj4+IENjOiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+Cj4+IENjOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFi
ZWxsaW5pQGtlcm5lbC5vcmc+Cj4+IENjOiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0
cml4LmNvbT4KPj4gQ2M6IEp1bGllbiBHcmFsbCA8anVsaWVuQHhlbi5vcmc+Cj4+IENjOiBQYW5r
YWogR3VwdGEgPHBhbmthai5ndXB0YS5saW51eEBnbWFpbC5jb20+Cj4+IENjOiBCYW9xdWFuIEhl
IDxiaGVAcmVkaGF0LmNvbT4KPj4gQ2M6IFdlaSBZYW5nIDxyaWNoYXJkdy55YW5nQGxpbnV4Lmlu
dGVsLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhh
dC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy94ZW4vYmFsbG9vbi5jIHwgNCArKysrCj4+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9i
YWxsb29uLmMgYi9kcml2ZXJzL3hlbi9iYWxsb29uLmMKPj4gaW5kZXggMzdmZmNjZGE4YmI4Ny4u
NWVjNzNmNzUyYjhhNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy94ZW4vYmFsbG9vbi5jCj4+ICsr
KyBiL2RyaXZlcnMveGVuL2JhbGxvb24uYwo+PiBAQCAtMzM4LDYgKzMzOCwxMCBAQCBzdGF0aWMg
ZW51bSBicF9zdGF0ZSByZXNlcnZlX2FkZGl0aW9uYWxfbWVtb3J5KHZvaWQpCj4+ICAgICAgaWYg
KHJjKSB7Cj4+ICAgICAgICAgIHByX3dhcm4oIkNhbm5vdCBhZGQgYWRkaXRpb25hbCBtZW1vcnkg
KCVpKVxuIiwgcmMpOwo+PiAgICAgICAgICBnb3RvIGVycjsKPj4gKyAgICB9IGVsc2Ugewo+PiAr
ICAgICAgICByZXNvdXJjZSA9IE5VTEw7Cj4+ICsgICAgICAgIC8qIFRyeSB0byByZWR1Y2UgdGhl
IG51bWJlciBvZiBzeXN0ZW0gcmFtIHJlc291cmNlcy4gKi8KPj4gKyAgICAgICAgbWVyZ2Vfc3lz
dGVtX3JhbV9yZXNvdXJjZXMoJmlvbWVtX3Jlc291cmNlKTsKPj4gICAgICB9Cj4gCj4gSSBkb24n
dCBzZWUgdGhlIG5lZWQgZm9yIHNldHRpbmcgcmVzb3VyY2UgdG8gTlVMTCBhbmQgdG8gdXNlIGFu
ICJlbHNlIgo+IGNsYXVzZSBoZXJlLgo+IAoKSSBzZXQgaXQgdG8gTlVMTCBiZWNhdXNlIHRoZSBw
b2ludGVyIG1heSBiZSBzdGFsZSBhZnRlciB0aGF0IGNhbGwgLSB0byBhdm9pZCBmdXR1cmUgYnVn
cy4gQnV0IEkgY2FuIGRyb3AgaXQuCgpBY2sgdG8gdGhlIOKAnmVsc2XigJwgY2FzZS4KClRoYW5r
cyBmb3IgaGF2aW5nIGEgbG9vayEKCj4gCj4gSnVlcmdlbgo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
