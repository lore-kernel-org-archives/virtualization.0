Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92F8C63697
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 08:01:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D82220857
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 08:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlvSeKQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D82220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEF5286F92;
	Fri, 13 Nov 2020 08:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W8I4FQbY9uSU; Fri, 13 Nov 2020 08:01:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD63186F84;
	Fri, 13 Nov 2020 08:01:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1CE4C163C;
	Fri, 13 Nov 2020 08:01:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C366C0FAA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 89F2586F84
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nSulYsi7YNP5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:01:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 206E186F92
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:01:23 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id w13so11978109eju.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 00:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Lyr52ufdV/b1MC5xVn1besXcL9o/KCfo5U+wMIm6Az0=;
 b=tlvSeKQvZPeGZiYvayF9UqMj3iWFzQREPnBUxFcSFGoHHJgC/WMGvEuuoQoXDo8Hgn
 CBi5JjBsXNP27IRB16v0HQL4W4bSI/fgCKB/obcWeDPSlRj8REy7UMDhhNRGb5xSnF/B
 tQfPy/pdBwi1AcWCSa7IbacLMwIc/rW6I966oWYb3qnq7mSkZaVIh3Yil0FMmzaGSh63
 IJe13XakqIDSbOxVoie49vrp7NhgthRAY2SOL2RIWOihi9p65K6Cnl5LxAtjdetKyZmg
 EUKjmiVBUxxWnHgJ1rPfSCFL3XnfpcBgqSlQ0SMbHMYWgIgKskiGpn7if4QIkLEgHY69
 8tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Lyr52ufdV/b1MC5xVn1besXcL9o/KCfo5U+wMIm6Az0=;
 b=PliZif/UH0NIvtV1qPl346xNJ0ZxihZ8Y0HUPwcmqRC6iAFcUoIPOnvC3IRqGIVzdu
 hkfWYcw5aWE7p1sGoa6glrDkCjwnLYMojcOiU9sYTZy80g04hLdcuv+NiwhQ1Zy8F0Pu
 kLoN5AgNso/xUrBsHlX7hP639ci9Zo9hc8a1wJTh2FqzRdVoc7VcSoKncWjo2LSxa+zL
 jt0OSSBLwo3XY1bpJEveQP+9T/so2rGaDbtTyPVWTW0GDjhARiAPpxLbES3Lm3edJBpe
 nsUzretYetoQ2Juw6hrSE95oyqD4/ZURdy1jRfI8eHm0TaeXbavPvs+tMteHgtGNm6fi
 DWqw==
X-Gm-Message-State: AOAM533otv6cBhYKRi7rhpuqQDRKFY2G2ouRlkHhIBfRMyGx0mZbYekZ
 q6AXZ8KSf1141o3TkAHgLjE=
X-Google-Smtp-Source: ABdhPJxHUOAD/Qi1uaQ+F8xY4FLXk/vSS2g27Rw4bEWQW3ZY4XKyQf2cJ3sXIUbOlIAsSP0/Rr6R0g==
X-Received: by 2002:a17:906:a186:: with SMTP id
 s6mr818781ejy.193.1605254481271; 
 Fri, 13 Nov 2020 00:01:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k17sm2477533ejj.1.2020.11.13.00.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 00:01:20 -0800 (PST)
Subject: Re: [PATCH] drm/nouveau: Fix out-of-bounds access when deferencing
 MMU type
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
 Ben Skeggs <skeggsb@gmail.com>
References: <20201110133655.13174-1-tzimmermann@suse.de>
 <85758a6215f74917aee81b18d037fb82@intel.com>
 <f4cedda2-48f6-565c-4154-0975a2d119a0@suse.de>
 <b87d5a2cce4941fe86e89d97bd6b2be4@intel.com>
 <CACAvsv7vZFnFtvcaA8PcRn=V-uH9P7HU6BcZsSUGZSYejZCwQw@mail.gmail.com>
 <0dfc8b9904e94f61a8501fae432b4753@intel.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <838edcd6-cc9a-d2f4-db43-2d8ed43d6be5@gmail.com>
Date: Fri, 13 Nov 2020 09:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0dfc8b9904e94f61a8501fae432b4753@intel.com>
Content-Language: en-US
Cc: "daniel@ffwll.ch" <daniel@ffwll.ch>, "airlied@linux.ie" <airlied@linux.ie>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Roland Scheidegger <sroland@vmware.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "bskeggs@redhat.com" <bskeggs@redhat.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMTIuMTEuMjAgdW0gMTU6MjAgc2NocmllYiBSdWhsLCBNaWNoYWVsIEo6Cj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEJlbiBTa2VnZ3MgPHNrZWdnc2JAZ21haWwuY29t
Pgo+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDIwIDk6MzkgUE0KPj4gVG86IFJ1
aGwsIE1pY2hhZWwgSiA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29tPgo+PiBDYzogVGhvbWFzIFpp
bW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+OyBic2tlZ2dzQHJlZGhhdC5jb207Cj4+IGFp
cmxpZWRAbGludXguaWU7IGRhbmllbEBmZndsbC5jaDsgY2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
OyBhbWQtCj4+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IG5vdXZlYXVAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBkcmktCj4+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IFJvbGFuZAo+PiBTY2hlaWRlZ2dlciA8
c3JvbGFuZEB2bXdhcmUuY29tPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+Owo+PiBI
dWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPjsgVk13YXJlIEdyYXBoaWNzIDxsaW51eC1ncmFw
aGljcy0KPj4gbWFpbnRhaW5lckB2bXdhcmUuY29tPjsgR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJl
ZGhhdC5jb20+OyBzcGljZS0KPj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Owo+PiBEYXZlIEFpcmxpZSA8YWlybGll
ZEByZWRoYXQuY29tPjsgTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT47IEZlbGl4Cj4+IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgSGF3a2luZyBaaGFuZwo+PiA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPgo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vbm91dmVhdTogRml4
IG91dC1vZi1ib3VuZHMgYWNjZXNzIHdoZW4KPj4gZGVmZXJlbmNpbmcgTU1VIHR5cGUKPj4KPj4g
T24gVGh1LCAxMiBOb3YgMjAyMCBhdCAwMjoyNywgUnVobCwgTWljaGFlbCBKIDxtaWNoYWVsLmou
cnVobEBpbnRlbC5jb20+Cj4+IHdyb3RlOgo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
Cj4+Pj4gRnJvbTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4+Pj4g
U2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMSwgMjAyMCA3OjA4IEFNCj4+Pj4gVG86IFJ1aGws
IE1pY2hhZWwgSiA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29tPjsgYnNrZWdnc0ByZWRoYXQuY29t
Owo+Pj4+IGFpcmxpZWRAbGludXguaWU7IGRhbmllbEBmZndsbC5jaDsgY2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tCj4+Pj4gQ2M6IG5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOwo+Pj4+IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVu
Lmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+OyBNYXhpbWUgUmlwYXJkCj4+Pj4gPG1yaXBhcmRA
a2VybmVsLm9yZz47IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+OyBHZXJkIEhvZmZt
YW5uCj4+Pj4gPGtyYXhlbEByZWRoYXQuY29tPjsgQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPjsKPj4+PiBWTXdhcmUgR3JhcGhpY3MgPGxpbnV4LWdyYXBoaWNzLW1haW50
YWluZXJAdm13YXJlLmNvbT47IFJvbGFuZAo+Pj4+IFNjaGVpZGVnZ2VyIDxzcm9sYW5kQHZtd2Fy
ZS5jb20+OyBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPjsKPj4+PiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IEhhd2tpbmcgWmhhbmcKPj4+PiA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBMaWt1bgo+PiBH
YW8KPj4+PiA8TGlrdW4uR2FvQGFtZC5jb20+OyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZzsgc3BpY2UtCj4+Pj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9ub3V2ZWF1OiBGaXggb3V0LW9mLWJvdW5kcyBhY2Nlc3Mgd2hlbgo+Pj4+IGRlZmVyZW5jaW5n
IE1NVSB0eXBlCj4+Pj4KPj4+PiBIaQo+Pj4+Cj4+Pj4gQW0gMTAuMTEuMjAgdW0gMTY6Mjcgc2No
cmllYiBSdWhsLCBNaWNoYWVsIEo6Cj4+Pj4+Cj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+Pj4+Pj4gRnJvbTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+
Cj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMCwgMjAyMCA4OjM3IEFNCj4+Pj4+PiBU
bzogYnNrZWdnc0ByZWRoYXQuY29tOyBhaXJsaWVkQGxpbnV4LmllOyBkYW5pZWxAZmZ3bGwuY2g7
IFJ1aGwsCj4+IE1pY2hhZWwgSgo+Pj4+Pj4gPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT47IGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbQo+Pj4+Pj4gQ2M6IG5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOwo+Pj4+IFRob21hcwo+Pj4+
Pj4gWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT47IE1hYXJ0ZW4gTGFua2hvcnN0Cj4+
Pj4+PiA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgTWF4aW1lIFJpcGFyZAo+
Pj4+Pj4gPG1yaXBhcmRAa2VybmVsLm9yZz47IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5j
b20+OyBHZXJkCj4+IEhvZmZtYW5uCj4+Pj4+PiA8a3JheGVsQHJlZGhhdC5jb20+OyBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Owo+Pj4+Pj4gVk13YXJlIEdyYXBoaWNz
IDxsaW51eC1ncmFwaGljcy1tYWludGFpbmVyQHZtd2FyZS5jb20+OyBSb2xhbmQKPj4+Pj4+IFNj
aGVpZGVnZ2VyIDxzcm9sYW5kQHZtd2FyZS5jb20+OyBIdWFuZyBSdWkKPj4gPHJheS5odWFuZ0Bh
bWQuY29tPjsKPj4+Pj4+IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsg
SGF3a2luZyBaaGFuZwo+Pj4+Pj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEphc29uIEd1bnRo
b3JwZSA8amdnQHppZXBlLmNhPjsgTGlrdW4KPj4+PiBHYW8KPj4+Pj4+IDxMaWt1bi5HYW9AYW1k
LmNvbT47IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOwo+PiBzcGlj
ZS0KPj4+Pj4+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4+Pj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL25vdXZlYXU6IEZpeCBvdXQt
b2YtYm91bmRzIGFjY2VzcyB3aGVuCj4+Pj4gZGVmZXJlbmNpbmcKPj4+Pj4+IE1NVSB0eXBlCj4+
Pj4+Pgo+Pj4+Pj4gVGhlIHZhbHVlIG9mIHN0cnVjdCBkcm1fZGV2aWNlLnR0bS50eXBlX3ZyYW0g
Y2FuIGJlY29tZSAtMSBmb3IKPj4+PiB1bmtub3duCj4+Pj4+PiB0eXBlcyBvZiBtZW1vcnkgKHNl
ZSBub3V2ZWF1X3R0bV9pbml0KCkpLiBUaGlzIGxlYWRzIHRvIGFuIG91dC1vZi0KPj4gYm91bmRz
Cj4+Pj4+PiBlcnJvciB3aGVuIGFjY2Vzc2luZyBzdHJ1Y3QgbnZpZl9tbXUudHlwZVtdOgo+Pj4+
PiBXb3VsZCB0aGlzIG1ha2UgbW9yZSBzZW5zZSB0byBqdXN0IHNldCB0aGUgdHlwZV92cmFtID0g
MCBpbnN0ZWFkIG9mIC0xPwo+Pj4gPkZyb20gd2hhdCBJIHVuZGVyc3RhbmQsIHRoZXNlIGluZGlj
ZXMgcmVmZXIgdG8gYW4gaW50ZXJuYWwgdHlwZSBvZiBNTVUsCj4+Pj4gcnNwIHRoZSBNTVUncyBj
YXBhYmlsaXRpZXMuIEhvd2V2ZXIsIG15IGhhcmR3YXJlIChwcmUtTlY1MCkgZG9lcyBub3QKPj4+
PiBoYXZlIGFuIE1NVSBhdCBhbGwuCj4+PiBZZWFoLCBhbmQgdXBvbiBmdXJ0aGVyIHJldmlldyBJ
IHNlZSB0aGF0IG15IGNvbW1lbnQgd2FzIGNvbXBsZXRlbHkKPj4gd3JvbmcKPj4+ICh2YWx1ZSB2
cy4gaW5kZXgpLgo+Pj4KPj4+IEEgYmV0dGVyIHN1Z2dlc3Rpb24gd291bGQgaGF2ZSBiZWVuLCBj
cmVhdGUgYW4gZW50cnkgaW4gdGhlIGFycmF5IHRoYXQKPj4gbWVhbnMsCj4+PiAidW5zdXBwb3J0
ZWQgdHlwZSIgd2l0aCBhIHZhbHVlIG9mIDAsIGJ1dC4uLgo+Pj4KPj4+PiBJIGFncmVlIHRoYXQg
aXQgd291bGQgYmUgbmljZSB0byBoYXZlIGEgY2xlYW5lciBkZXNpZ24gdGhhdCBpbmNvcnBvcmF0
ZXMKPj4+PiB0aGlzIGNhc2UsIGJ1dCByZXNvbHZpbmcgdGhhdCB3b3VsZCBhcHBhcmVudGx5IHJl
cXVpcmUgbW9yZSB0aGFuIGEgYnVnZml4Lgo+Pj4gSSBhZ3JlZS4gIFRoZSAtMSBpbmRleCBpcyBh
IHNwZWNpYWwgY2FzZSBmb3IgdGhlIHBsYXRmb3JtIHBhdGgKPj4+IChwbGF0Zm9ybSAhPSBOVl9E
RVZJQ0VfSU5GT19WMF9TT0MpLiAgVGhpcyBpcyBhIGZpeCBmb3IgdGhlIGlzc3VlLCBidXQgbm90
Cj4+PiBhIGNvbXBsZXRlIHNvbHV0aW9uLgo+Pj4KPj4+IElmIHlvdSBuZWVkIGl0Ogo+Pj4gUmV2
aWV3ZWQtYnk6IE1pY2hhZWwgSi4gUnVobCA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29tPgo+PiBJ
J3ZlIHB1dCBhbiBhbHRlcm5hdGUgZml4IGZvciB0aGlzIGhlcmVbMV0sIGFuZCB3aWxsIGdldCBp
dCBpbnRvCj4+IGRybS1maXhlcyBsYXRlciB0b2RheS4KPj4KPj4gQmVuLgo+Pgo+PiBbMV0KPj4g
aHR0cHM6Ly9naXRodWIuY29tL3NrZWdnc2Ivbm91dmVhdS9jb21taXQvNDU5MGY3MTIwYzJmMWY0
YWVhOWQ4YjkzYTJkCj4+IGFlNDNiMzEyZDM1YWQKPiBUaGlzIG1ha2VzIGEgbG90IG9mIHNlbnNl
LiAgSSBzcGVudCBzb21lIHRpbWUgdHJ5aW5nIHRvIHJlY29uY2lsZSB0aGUgcGxhdGZvcm0gaW5m
bwo+IHRoYXQgd2FzIG5vdCBiZWluZyB1c2VkIGluIHRoaXMgY2FzZSwgYnV0IGRpZG4ndCBzZWUg
dGhlIHNvbHV0aW9uIGxpa2UgdGhpcy4gICBUaGlzIGlzCj4gcHJldHR5IGNsZWFuLgoKSSB3YXMg
YWxyZWFkeSB3b25kZXJpbmcgd2h5IHRoZSBvbGQgY29kZSBuZXZlciBoaXQgdGhhdCBwcm9ibGVt
LCBidXQgCnRoaXMgZXhwbGFpbnMgaXQgcHJvcGVybHkgYW5kIGFsc28gZml4ZXMgaXQgdXAgY2xl
YW5seS4KCj4KPiBJZiB5b3Ugd291bGQgbGlrZToKPgo+IFJldmlld2VkLWJ5OiBNaWNoYWVsIEou
IFJ1aGwgPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT4KCkZlZWwgZnJlZSB0byBhZGQgYW4gUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGFz
IHdlbGwuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gRm9yIHRoaXMgc29sdXRpb24gYXMgd2Vs
bC4KPgo+IE1pa2UKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
