Return-Path: <SRS0=fPht=DW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A1C4363A
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 13:57:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A9F2080A
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWAhsjFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A9F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 726D1880BB;
	Thu, 15 Oct 2020 13:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25C0KSeCWgRY; Thu, 15 Oct 2020 13:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D2D3F87FAF;
	Thu, 15 Oct 2020 13:57:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B40C8C0052;
	Thu, 15 Oct 2020 13:57:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D95A0C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BD54E880BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A0qOUBpX32jF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:57:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CF73687FAF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:57:26 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id t25so3713898ejd.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=eqy7Jg2fPCw6JKPfho3FMkiXLNsZ2vOMeF3B2A8Mojc=;
 b=rWAhsjFjxNV2tSGmRZgmV07f7lkrurQgCx9bPljwSM5dlr+cFdfNcNP8TqDYr6RpmV
 kJKrteO6A0BWcah5RksBap2thah0f3FCug6g9rOyet2tvKS6wLurIXPy+sSprVRdDpXO
 IOnftXETFpeSKiWgWdWvXjoSMVSdBSpoxhozwHThiDlqjFFzd9Q9u5Oejc6caqTfdyr4
 wAOCXRStBQxEeLEOZzM3R4MwjLF5LE07MQ+q90DEXSJbdui7Ftt93dj8CphKOBSXE/1U
 TA9yRTGiIYdnvyfGyrO3NxXvENUg3bN9B4wUskFws67k2dcY70IkWJVmV0uurT9DwBTX
 hYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=eqy7Jg2fPCw6JKPfho3FMkiXLNsZ2vOMeF3B2A8Mojc=;
 b=r4WbPAAsk/MjqAZo9Vk4ssYkzF4vrgeg4xCnik1lbQV1fJJwwqyV0RWsy6/8OvdoqW
 sddxhBGXvsWZfeLZNOgW6GIcGKNN9AbayXIDqCBuA6nRuFC6GSkicqpc8Kr8ngYiRr/n
 I8RuV6jRemm+cv7nv/SaPLbEWkwUJKIWcWfkrVsAHzlsdYnsMmyxM+gL4RCTQYDiUPqN
 EnOZ2S7Pp05ApxG7tBUveTw1hLz5fyqRVmq9dPUEK0wtba18AApgkoHAMalliD4sIyd3
 1EmgYTyeVlmaPJSrByZBb/OkNEeaic3+tpohYYcGXg/AZ1ZKI2MZKlYgWfTifmDwM6q0
 2YQw==
X-Gm-Message-State: AOAM532xt9DwGqs8pXWOeIg61mssct0/0nhUwm2/6nfD+bnaSNzq2gwp
 NVqv724RkdaK6HRn48wVkqI=
X-Google-Smtp-Source: ABdhPJzF6r3Ll5i0gnC5JVk814gY1eCy0pl3+e4WV+JpVGbNy1VCb75/aaDOiQbf2OJV/MzOqd48ag==
X-Received: by 2002:a17:906:f4f:: with SMTP id
 h15mr4501249ejj.17.1602770245105; 
 Thu, 15 Oct 2020 06:57:25 -0700 (PDT)
Received: from [192.168.137.56] (tmo-123-114.customers.d1-online.com.
 [80.187.123.114])
 by smtp.gmail.com with ESMTPSA id i8sm1619354ejg.84.2020.10.15.06.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 06:57:24 -0700 (PDT)
Subject: Re: [PATCH v4 01/10] drm/vram-helper: Remove invariant parameters
 from internal kmap function
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, sam@ravnborg.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, kraxel@redhat.com, l.stach@pengutronix.de,
 linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
 inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
 yuq825@gmail.com, bskeggs@redhat.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, hjc@rock-chips.com, heiko@sntech.de,
 hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 oleksandr_andrushchenko@epam.com, ray.huang@amd.com,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, luben.tuikov@amd.com,
 apaneers@amd.com, linus.walleij@linaro.org, melissa.srw@gmail.com,
 chris@chris-wilson.co.uk, miaoqinglang@huawei.com
References: <20201015123806.32416-1-tzimmermann@suse.de>
 <20201015123806.32416-2-tzimmermann@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <06cab96a-5224-46dc-dbd2-8eb4950946cc@gmail.com>
Date: Thu, 15 Oct 2020 15:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015123806.32416-2-tzimmermann@suse.de>
Content-Language: en-US
Cc: linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>, xen-devel@lists.xenproject.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

QW0gMTUuMTAuMjAgdW0gMTQ6Mzcgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoKPiBUaGUgcGFy
YW1ldGVycyBtYXAgYW5kIGlzX2lvbWVtIGFyZSBhbHdheXMgb2YgdGhlIHNhbWUgdmFsdWUuIFJl
bW92ZWQgdGhlbQo+IHRvIHByZXBhcmVzIHRoZSBmdW5jdGlvbiBmb3IgY29udmVyc2lvbiB0byBz
dHJ1Y3QgZG1hX2J1Zl9tYXAuCj4KPiB2NDoKPiAJKiBkb24ndCBjaGVjayBmb3IgIWttYXAtPnZp
cnR1YWw7IHdpbGwgYWx3YXlzIGJlIGZhbHNlCj4KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmlt
bWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRl
ciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ry
bV9nZW1fdnJhbV9oZWxwZXIuYyB8IDE4ICsrKystLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9k
cm1fZ2VtX3ZyYW1faGVscGVyLmMKPiBpbmRleCAzMjEzNDI5Zjg0NDQuLjJkNWVkMzA1MThmMSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV92cmFtX2hlbHBlci5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIuYwo+IEBAIC0zODIsMzIgKzM4
MiwyMiBAQCBpbnQgZHJtX2dlbV92cmFtX3VucGluKHN0cnVjdCBkcm1fZ2VtX3ZyYW1fb2JqZWN0
ICpnYm8pCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MKGRybV9nZW1fdnJhbV91bnBpbik7Cj4gICAK
PiAtc3RhdGljIHZvaWQgKmRybV9nZW1fdnJhbV9rbWFwX2xvY2tlZChzdHJ1Y3QgZHJtX2dlbV92
cmFtX29iamVjdCAqZ2JvLAo+IC0JCQkJICAgICAgYm9vbCBtYXAsIGJvb2wgKmlzX2lvbWVtKQo+
ICtzdGF0aWMgdm9pZCAqZHJtX2dlbV92cmFtX2ttYXBfbG9ja2VkKHN0cnVjdCBkcm1fZ2VtX3Zy
YW1fb2JqZWN0ICpnYm8pCj4gICB7Cj4gICAJaW50IHJldDsKPiAgIAlzdHJ1Y3QgdHRtX2JvX2tt
YXBfb2JqICprbWFwID0gJmdiby0+a21hcDsKPiArCWJvb2wgaXNfaW9tZW07Cj4gICAKPiAgIAlp
ZiAoZ2JvLT5rbWFwX3VzZV9jb3VudCA+IDApCj4gICAJCWdvdG8gb3V0Owo+ICAgCj4gLQlpZiAo
a21hcC0+dmlydHVhbCB8fCAhbWFwKQo+IC0JCWdvdG8gb3V0Owo+IC0KPiAgIAlyZXQgPSB0dG1f
Ym9fa21hcCgmZ2JvLT5ibywgMCwgZ2JvLT5iby5udW1fcGFnZXMsIGttYXApOwo+ICAgCWlmIChy
ZXQpCj4gICAJCXJldHVybiBFUlJfUFRSKHJldCk7Cj4gICAKPiAgIG91dDoKPiAtCWlmICgha21h
cC0+dmlydHVhbCkgewo+IC0JCWlmIChpc19pb21lbSkKPiAtCQkJKmlzX2lvbWVtID0gZmFsc2U7
Cj4gLQkJcmV0dXJuIE5VTEw7IC8qIG5vdCBtYXBwZWQ7IGRvbid0IGluY3JlbWVudCByZWYgKi8K
PiAtCX0KPiAgIAkrK2diby0+a21hcF91c2VfY291bnQ7Cj4gLQlpZiAoaXNfaW9tZW0pCj4gLQkJ
cmV0dXJuIHR0bV9rbWFwX29ial92aXJ0dWFsKGttYXAsIGlzX2lvbWVtKTsKPiAtCXJldHVybiBr
bWFwLT52aXJ0dWFsOwo+ICsJcmV0dXJuIHR0bV9rbWFwX29ial92aXJ0dWFsKGttYXAsICZpc19p
b21lbSk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIGRybV9nZW1fdnJhbV9rdW5tYXBfbG9j
a2VkKHN0cnVjdCBkcm1fZ2VtX3ZyYW1fb2JqZWN0ICpnYm8pCj4gQEAgLTQ1Miw3ICs0NDIsNyBA
QCB2b2lkICpkcm1fZ2VtX3ZyYW1fdm1hcChzdHJ1Y3QgZHJtX2dlbV92cmFtX29iamVjdCAqZ2Jv
KQo+ICAgCXJldCA9IGRybV9nZW1fdnJhbV9waW5fbG9ja2VkKGdibywgMCk7Cj4gICAJaWYgKHJl
dCkKPiAgIAkJZ290byBlcnJfdHRtX2JvX3VucmVzZXJ2ZTsKPiAtCWJhc2UgPSBkcm1fZ2VtX3Zy
YW1fa21hcF9sb2NrZWQoZ2JvLCB0cnVlLCBOVUxMKTsKPiArCWJhc2UgPSBkcm1fZ2VtX3ZyYW1f
a21hcF9sb2NrZWQoZ2JvKTsKPiAgIAlpZiAoSVNfRVJSKGJhc2UpKSB7Cj4gICAJCXJldCA9IFBU
Ul9FUlIoYmFzZSk7Cj4gICAJCWdvdG8gZXJyX2RybV9nZW1fdnJhbV91bnBpbl9sb2NrZWQ7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
