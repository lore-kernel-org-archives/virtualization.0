Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922EBC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3593F40BD9;
	Wed,  8 Mar 2023 14:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3593F40BD9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBmEQxuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGEM4E8Gw7TE; Wed,  8 Mar 2023 14:47:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A37F540242;
	Wed,  8 Mar 2023 14:47:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A37F540242
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 829E3C0071;
	Wed,  8 Mar 2023 14:47:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 954A0C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6354280DA8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6354280DA8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WBmEQxuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cLhyW9iYXbRj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A207880D5A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A207880D5A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678286859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PS5jT0CNQPZJmT10uJr0OjUciVwKWJpOiCnqquTWRWE=;
 b=WBmEQxuTJcQzUb5UcRnXebusSkS7p4nDrQ+SUWVXW4dL9DJZWwBc88h/jN7egpBLfxty1u
 rZ3XsW8VY948PPAg0OapYxtgHL8huGdkOVBp3JTLoHpt7pGZcSC29NrT5FXR9ZAMjGykDA
 ubh7yOZsgyv9F8zbE5SlmEAyY/g3KXY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Y0ik383GO2CMvC4KH1ddmw-1; Wed, 08 Mar 2023 09:47:38 -0500
X-MC-Unique: Y0ik383GO2CMvC4KH1ddmw-1
Received: by mail-ed1-f71.google.com with SMTP id
 w7-20020a056402268700b004bbcdf3751bso23961361edd.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678286857;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PS5jT0CNQPZJmT10uJr0OjUciVwKWJpOiCnqquTWRWE=;
 b=u49nY+NnZrLGVW6HRlO5e7yCZ4MDBSihjT/YlQOraXWER7Jw7U7A1V+I/XDUaQ+b/c
 fbs837z9o1ZHsNPA/wLg5SqV1NRBAw+Y3ZHRY6hkr6exIRe7wAJ/aN09w3+Q/SxCUz0O
 oCxwBiL/iIELsv53vA+x2hPW8BBC/37Qaf+2NPo6kAUitqgZPcKQr/WS8S4kPZS8wWr/
 drNktw4CT/X/OYymPWEv3kPYdaoMpiTGXw1feMP8L0p/kooLOQm6AgESS1GppUXzyXl2
 LZ71YoY3lw9334q4qlSeAxWEYiQ5R6rB2G7+5nNZaMiPAVFV7IaswxvUMICPHTnRF9UG
 WQcA==
X-Gm-Message-State: AO0yUKVnZyCGmH7rKLaJn/RvkCEWltmZ2k0YHUwabfmX69ncMiV7yq+x
 np5ayyQLhMfgwKJDQDpms+78GsOSiPBP5AsX9+j/npz8NFbRqGxl9yKlND7ukaE4Gu4W3GAPsrZ
 N9USRakL+kTYPdWuXUtYdD9/YWpUrmDCH3EkkrGsN/A==
X-Received: by 2002:a17:906:9744:b0:900:a150:cea3 with SMTP id
 o4-20020a170906974400b00900a150cea3mr23254541ejy.9.1678286857289; 
 Wed, 08 Mar 2023 06:47:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9qxzHK4VwKE67hDsOPOemEUZaY11NB3S7RKZ3Y0mRMUbvbj3CXgycQ6yZXKjnMJSYRFSIkkg==
X-Received: by 2002:a17:906:9744:b0:900:a150:cea3 with SMTP id
 o4-20020a170906974400b00900a150cea3mr23254523ejy.9.1678286857013; 
 Wed, 08 Mar 2023 06:47:37 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 n2-20020a50c202000000b004f0e11e071dsm2006358edf.73.2023.03.08.06.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:47:36 -0800 (PST)
Date: Wed, 8 Mar 2023 09:47:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230308094115-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
 <20230308091442-mutt-send-email-mst@kernel.org>
 <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
 <20230308092541-mutt-send-email-mst@kernel.org>
 <cc5de402-ad79-7bce-74d3-77356a6fb66a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <cc5de402-ad79-7bce-74d3-77356a6fb66a@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

T24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMDk6NDA6MDNBTSAtMDUwMCwgRmVuZyBMaXUgd3JvdGU6
Cj4gSW4gZmFjdCwgSSBjb21waWxlZCBhbmQgdGVzdGVkIGxvY2FsbHkuIEkganVzdCBsb29rZWQg
aXQgdXAgYW5kIGl0IG1pZ2h0IGJlCj4gdGhhdCBJIHdhcyBtaXNzaW5nIGEg4oCcZ2l0IGFkZOKA
nSBhY3Rpb24gd2hpY2ggY2F1c2VkIHRoZSBwcm9ibGVtLiBCZWZvcmUgSQo+IHBvc3QgdGhlIHBh
dGNoIGluIGZ1dHVyZSwgSSB3aWxsIGZpbmQgYSBjbGVhbiBrZXJuZWwgc291cmNlIGFuZCBhcHBs
eSBteQo+IHBhdGNoIGZvciB0ZXN0aW5nIGluc3RlYWQgb2Ygb24gdGhlIGJyYW5jaCB3aGVyZSB0
aGUgY29kZSBpcyBtb2RpZmllZCwgc28gYXMKPiB0byBhdm9pZCB0aGlzIGtpbmQgb2YgcHJvYmxl
bSBmcm9tIGhhcHBlbmluZyBhZ2Fpbi4gVmVyeSBzb3JyeSBmb3IgdGhpcwo+IHByb2JsZW0sIEkg
d2lsbCBiZSBjYXJlZnVsIGFuZCBwYXkgYXR0ZW50aW9uIHRvIGl0IGxhdGVyCgpJIGhhdmUgYSBw
cmUtcHVzaCBob29rIHNpbmNlIGl0IHdhcyBoYXBwZW5pbmcgdG8gbWUgYSBsb3Qgd2l0aCBwdXNo
ZXM6CgoKIyEvYmluL3NoCgojIEFuIGV4YW1wbGUgaG9vayBzY3JpcHQgdG8gdmVyaWZ5IHdoYXQg
aXMgYWJvdXQgdG8gYmUgcHVzaGVkLiAgQ2FsbGVkIGJ5ICJnaXQKIyBwdXNoIiBhZnRlciBpdCBo
YXMgY2hlY2tlZCB0aGUgcmVtb3RlIHN0YXR1cywgYnV0IGJlZm9yZSBhbnl0aGluZyBoYXMgYmVl
bgojIHB1c2hlZC4gIElmIHRoaXMgc2NyaXB0IGV4aXRzIHdpdGggYSBub24temVybyBzdGF0dXMg
bm90aGluZyB3aWxsIGJlIHB1c2hlZC4KIwojIFRoaXMgaG9vayBpcyBjYWxsZWQgd2l0aCB0aGUg
Zm9sbG93aW5nIHBhcmFtZXRlcnM6CiMKIyAkMSAtLSBOYW1lIG9mIHRoZSByZW1vdGUgdG8gd2hp
Y2ggdGhlIHB1c2ggaXMgYmVpbmcgZG9uZQojICQyIC0tIFVSTCB0byB3aGljaCB0aGUgcHVzaCBp
cyBiZWluZyBkb25lCiMKIyBJZiBwdXNoaW5nIHdpdGhvdXQgdXNpbmcgYSBuYW1lZCByZW1vdGUg
dGhvc2UgYXJndW1lbnRzIHdpbGwgYmUgZXF1YWwuCiMKIyBJbmZvcm1hdGlvbiBhYm91dCB0aGUg
Y29tbWl0cyB3aGljaCBhcmUgYmVpbmcgcHVzaGVkIGlzIHN1cHBsaWVkIGFzIGxpbmVzIHRvCiMg
dGhlIHN0YW5kYXJkIGlucHV0IGluIHRoZSBmb3JtOgojCiMgICA8bG9jYWwgcmVmPiA8bG9jYWwg
c2hhMT4gPHJlbW90ZSByZWY+IDxyZW1vdGUgc2hhMT4KIwojIFRoaXMgc2FtcGxlIHNob3dzIGhv
dyB0byBwcmV2ZW50IHB1c2ggb2YgY29tbWl0cyB3aGVyZSB0aGUgbG9nIG1lc3NhZ2Ugc3RhcnRz
CiMgd2l0aCAiV0lQIiAod29yayBpbiBwcm9ncmVzcykuCgpyZW1vdGU9IiQxIgp1cmw9IiQyIgoK
ZWNobyAiUHJlIHB1c2ggaG9vayBmb3IgcmVtb3RlICR1cmwiCgojaWYKIwllY2hvICR1cmwgfGdy
ZXAgXnJvb3RAdmlydGxhYiA+IC9kZXYvbnVsbAojdGhlbgojCWVjaG8gIkxhYiBwdXNoIG5vIG5l
ZWQgdG8gY2hlY2siCiMJZXhpdCAwCiNmaQojCiNpZgojCWVjaG8gJHVybCB8Z3JlcCBeLyA+IC9k
ZXYvbnVsbAojdGhlbgojCWVjaG8gIkxvY2FsIHB1c2ggbm8gbmVlZCB0byBjaGVjayIKIwlleGl0
IDAKI2ZpCgpjaGVja2VkPTAKSEVBRD1gZ2l0IHJldi1saXN0IC0xIEhFQURgCklGUz0nICcKd2hp
bGUgcmVhZCBsb2NhbF9yZWYgbG9jYWxfc2hhIHJlbW90ZV9yZWYgcmVtb3RlX3NoYQpkbwogICAg
aWYgWyAkY2hlY2tlZCA9IDAgXQogICAgdGhlbgoJaWYgWyAiJGxvY2FsX3NoYSIgPSAkSEVBRCBd
Cgl0aGVuCgkJZWNobyAiUHVzaGluZyBIRUFEIHRvIHJlbW90ZS4gQ2hlY2tpbmcgdGhhdCB0cmVl
IGlzIGNsZWFuLiIKCQlpZgoJCQlnaXQgZGlmZi1pbmRleCAtLXF1aWV0IEhFQUQKCQl0aGVuCgkJ
CWVjaG8gLW4gIyBObyBkaWZmZXJlbmNlcwoJCWVsc2UKCQkJZWNobyAiRElGRiBpbiBIRUFELiBO
b3QgcHVzaGVkLCBzdGFzaCBvciAtbm8tdmVyaWZ5ISIKCQkJZXhpdCAxCgkJZmkKCQljaGVja2Vk
PTEKCWZpCiAgICBmaQpkb25lCgpleGl0IDAKCgoKQ29uc2lkZXIgc3RpY2tpbmcgdGhpcyBpbiBh
IHBvc3QgY29tbWl0IGhvb2sgbWF5YmU/CgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
