Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CF7C4708D
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 18:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBF7460C0A;
	Mon,  5 Dec 2022 18:24:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBF7460C0A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=UBAKgIuu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwXNstFLkCL2; Mon,  5 Dec 2022 18:24:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D9A56068F;
	Mon,  5 Dec 2022 18:24:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D9A56068F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C1DC0033;
	Mon,  5 Dec 2022 18:24:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE88BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97F8041603
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97F8041603
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
 header.i=@kernel-dk.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=UBAKgIuu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMLCEnsCn5NV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:24:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DFB2415E3
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DFB2415E3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 18:24:04 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id c7so8827788pfc.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 10:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MiaU0h+bdhLcyz46u9rPXY7SBRUUk1LjjV2sWNv5RLY=;
 b=UBAKgIuuOhTG3tpp18QArd1BLiZIqIsmrc+4/lD5AsoySzR1qItFUrsUCuFBWW+V7W
 NN2KIHP7x2TpFYLEpDAVnAYN+9qZ+/AX/nXjLFuLwIwASDZ5TCrrY6Icl9kLCXsJnFp2
 2nI8qClHrISNzrvTysGS6mWOe77CE/lEituW6eRdhOSEvyhqLcQtgnSDhdmtwzRZq3H3
 t9gh6367wtD+fMwzVdZQHcjkEtEIZUGmsUbF+1sZ059635xeS4MW7dzCg2dwPJ9UAzdV
 UHJpkdFPOBH9kWrxNGtG9EH15d6tA7E5U5gRClOLHJ2QLOn49p6zl6y4+YgaYg17wO/n
 Dyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MiaU0h+bdhLcyz46u9rPXY7SBRUUk1LjjV2sWNv5RLY=;
 b=Q8ePggmD1+07PG69WLdmhHU9J1ALkBNHLKp5Ph3zURI/k3uSHu/nd/BDuJAxdwmJni
 43IH7PxJjToeouMPpRcU9qRK3an1gN2em/riM0n1wZW19Lh2xnn/KoHH7WVXLoxR1LQK
 dE9DoJPZ3/F5jtsiTE2zEeot/m3O2/uTLvwKBLW3oNUZICeX90FZWaoUmANV0uZ8CNZZ
 tAQeXPbrPgKpKr8Zcp8otHsF8ABgPPdg+m4y10Xd7juQZqlvkTuutd/9WyAFS2J+b7CF
 84qU/xI8+ZjsTG3B9haMTonXah7iHCWwAyM/N/Be+OdF6pSlrB/ALMD4TBCL94pf+FIW
 lz4Q==
X-Gm-Message-State: ANoB5pkZiWVmfBk/WduV9xbLBwluGzU28Rqz3hUd3r/s8Rj+b5MD1DtE
 9DH9VOIdI8rVHh2plvY3+n0AiA==
X-Google-Smtp-Source: AA0mqf6jZL7CMm0mQFuDdI6JgmGYYwGjfVoJPowXsYQWIx6DQ5YO6ZYAjPvSltOjb7zYJtxe7LeLEA==
X-Received: by 2002:a05:6a00:2396:b0:56c:318a:f808 with SMTP id
 f22-20020a056a00239600b0056c318af808mr68347160pfc.11.1670264643685; 
 Mon, 05 Dec 2022 10:24:03 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a?
 ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
 by smtp.gmail.com with ESMTPSA id
 72-20020a62154b000000b0056283e2bdbdsm4726356pfv.138.2022.12.05.10.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Dec 2022 10:24:03 -0800 (PST)
Message-ID: <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
Date: Mon, 5 Dec 2022 11:24:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux-foundation.org
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Cc: linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

T24gMTIvNS8yMiA5OjIw4oCvQU0sIEFsdmFybyBLYXJzeiB3cm90ZToKPiBJbXBsZW1lbnQgdGhl
IFZJUlRJT19CTEtfRl9MSUZFVElNRSBmZWF0dXJlIGZvciBWaXJ0SU8gYmxvY2sgZGV2aWNlcy4K
PiAKPiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgbmV3IGlvY3RsIGNvbW1hbmQsIFZCTEtfTElG
RVRJTUUuCj4gCj4gVkJMS19MSUZFVElNRSBpb2N0bCBhc2tzIGZvciB0aGUgYmxvY2sgZGV2aWNl
IHRvIHByb3ZpZGUgbGlmZXRpbWUKPiBpbmZvcm1hdGlvbiBieSBzZW5kaW5nIGEgVklSVElPX0JM
S19UX0dFVF9MSUZFVElNRSBjb21tYW5kIHRvIHRoZSBkZXZpY2UuCj4gCj4gbGlmZXRpbWUgaW5m
b3JtYXRpb24gZmllbGRzOgo+IAo+IC0gcHJlX2VvbF9pbmZvOiBzcGVjaWZpZXMgdGhlIHBlcmNl
bnRhZ2Ugb2YgcmVzZXJ2ZWQgYmxvY2tzIHRoYXQgYXJlCj4gCQljb25zdW1lZC4KPiAJCW9wdGlv
bmFsIHZhbHVlcyBmb2xsb3dpbmcgdmlydGlvIHNwZWM6Cj4gCQkqKSAwIC0gdW5kZWZpbmVkLgo+
IAkJKikgMSAtIG5vcm1hbCwgPCA4MCUgb2YgcmVzZXJ2ZWQgYmxvY2tzIGFyZSBjb25zdW1lZC4K
PiAJCSopIDIgLSB3YXJuaW5nLCA4MCUgb2YgcmVzZXJ2ZWQgYmxvY2tzIGFyZSBjb25zdW1lZC4K
PiAJCSopIDMgLSB1cmdlbnQsIDkwJSBvZiByZXNlcnZlZCBibG9ja3MgYXJlIGNvbnN1bWVkLgo+
IAo+IC0gZGV2aWNlX2xpZmV0aW1lX2VzdF90eXBfYTogdGhpcyBmaWVsZCByZWZlcnMgdG8gd2Vh
ciBvZiBTTEMgY2VsbHMgYW5kCj4gCQkJICAgICBpcyBwcm92aWRlZCBpbiBpbmNyZW1lbnRzIG9m
IDEwdXNlZCwgYW5kIHNvCj4gCQkJICAgICBvbiwgdGhydSB0byAxMSBtZWFuaW5nIGVzdGltYXRl
ZCBsaWZldGltZQo+IAkJCSAgICAgZXhjZWVkZWQuIEFsbCB2YWx1ZXMgYWJvdmUgMTEgYXJlIHJl
c2VydmVkLgo+IAo+IC0gZGV2aWNlX2xpZmV0aW1lX2VzdF90eXBfYjogdGhpcyBmaWVsZCByZWZl
cnMgdG8gd2VhciBvZiBNTEMgY2VsbHMgYW5kIGlzCj4gCQkJICAgICBwcm92aWRlZCB3aXRoIHRo
ZSBzYW1lIHNlbWFudGljcyBhcwo+IAkJCSAgICAgZGV2aWNlX2xpZmV0aW1lX2VzdF90eXBfYS4K
PiAKPiBUaGUgZGF0YSByZWNlaXZlZCBmcm9tIHRoZSBkZXZpY2Ugd2lsbCBiZSBzZW50IGFzIGlz
IHRvIHRoZSB1c2VyLgo+IE5vIGRhdGEgY2hlY2svZGVjb2RlIGlzIGRvbmUgYnkgdmlydGJsay4K
CklzIHRoaXMgYmFzZWQgb24gc29tZSBzcGVjPyBCZWNhdXNlIGl0IGxvb2tzIHByZXR0eSBvZGQg
dG8gbWUuIFRoZXJlCmNhbiBiZSBhIHByZXR0eSB3aWRlIHJhbmdlIG9mIHR3by90aHJlZS9ldGMg
bGV2ZWwgY2VsbHMgd2l0aCB3aWxkbHkKZGlmZmVyZW50IHJhbmdlcyBvZiBkdXJhYmlsaXR5LiBB
bmQgdGhlcmUncyByZWFsbHkgbm90IGEgbG90IG9mIHNsYwpmb3IgZ2VuZXJpYyBkZXZpY2VzIHRo
ZXNlIGRheXMsIGlmIGFueS4KCi0tIApKZW5zIEF4Ym9lCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
