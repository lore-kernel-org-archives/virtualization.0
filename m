Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54B4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 10:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DF57405BD;
	Tue, 12 Apr 2022 10:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tMFDHn1QXZW4; Tue, 12 Apr 2022 10:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F38FE400EF;
	Tue, 12 Apr 2022 10:25:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFAC9C0033;
	Tue, 12 Apr 2022 10:25:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09FE7C002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 10:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECC5782F6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 10:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pWOKnVDhU-fr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 10:25:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7934825E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 10:25:10 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id s10so8867966plg.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=vo+e8XwHkTEoVxz5IEpTN/1YQf55sAfVJWv5HhomO6Y=;
 b=c3HOTK0Ri/tKw2z2Fc1QWLTxIKKObZPCobJOQxkL/ogtWB2wssWLFLyq/NoBj7ACjb
 jv+meEkQ4CCMsKJEq5FlQwtVKju1h/WcvPNLMgQTZ9QWj5MCsc10um3vrjz1HbUkH8w2
 sSJJDdC8ETgxsGMpcFDvbtGwLG91x5UMdlSU3c/UO+FjsqEOzCbVNQUbE9cPY6MQwE0l
 exGpMoVoSGLR246HrlKRo1Yc+McwtVb20siAwQhxydwmFjEa8J3AToxoT6LXx8SdTy4Y
 E1hJSa+wmNW7S8pO2wpmgvcIYKF1bScAjtiOZfZuYdUkeVg1HRMZ+Yo5Abjk6e1vQnCE
 CxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vo+e8XwHkTEoVxz5IEpTN/1YQf55sAfVJWv5HhomO6Y=;
 b=M2ofV2ttS+6CJNvF/BpVwkwgr9BxSloTaBEbZn7DDw8TG/aXinF3WA6oeVQu+m+jD8
 NQjmTRJ3rdsXZnkgdaNZuD6yyUKawr5tDGShWDuE/c3vd9cCbb8JH3lhhi3ha0fwnb/N
 xK/5yuFZvJs9/0j7Ojb0UyTBQtVnYW2XB50IpE9YL7rn504gqgw9ilkL/67Ucmgngu1m
 Vxwx/0BmkTsHdNOql2j6Xi+P938a7PvGmr8y2rKy/l+R2nV/MAZEcTYibsHPC7jFUFVB
 kUd+Q/MlMdetqDVuzqD8hGLNNua6g0EQzd310yu+KxkP9kXT+GBL2004H1LJZUQt+k27
 aioA==
X-Gm-Message-State: AOAM530caFQVMwjLjW2Iz0wnHZ0rPKH75nbZGoUyEqHPqKBK3zQ27wY3
 AfW11Tt9WaJrBr0IOGHIXhc4/A==
X-Google-Smtp-Source: ABdhPJw5zpOGNlLWF2IyuBkyt9JwXLfL2DtYY/Me9NmOeJBUW3JZzYQAcn6hfyQ4z7sCO2wEuNUr3Q==
X-Received: by 2002:a17:90b:1bc8:b0:1c7:443:3ffb with SMTP id
 oa8-20020a17090b1bc800b001c704433ffbmr4187757pjb.84.1649759110165; 
 Tue, 12 Apr 2022 03:25:10 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a635117000000b0039d4f859738sm2400249pgb.71.2022.04.12.03.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 03:25:09 -0700 (PDT)
Message-ID: <6a4202bf-6595-a60d-369d-3b943fb98bdd@bytedance.com>
Date: Tue, 12 Apr 2022 18:21:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH v4 0/8] Introduce akcipher service for virtio-crypto
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
 <df758c80-ea85-d324-ad05-9bf07bb569e3@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <df758c80-ea85-d324-ad05-9bf07bb569e3@redhat.com>
Cc: berrange@redhat.com, helei.sig11@bytedance.com, mst@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 Simo Sorce <simo@redhat.com>
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

CgpPbiA0LzEyLzIyIDE3OjQ3LCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IAo+PiBJbiBvdXIgcGxh
biwgdGhlIGZlYXR1cmUgaXMgZGVzaWduZWQgZm9yIEhUVFBTIG9mZmxvYWRpbmcgY2FzZSBhbmQK
Pj4gb3RoZXIgYXBwbGljYXRpb25zIHdoaWNoIHVzZSBrZXJuZWwgUlNBL2VjZHNhIGJ5IGtleWN0
bCBzeXNjYWxsLgo+IAo+IEhpIFpoZW53ZWksCj4gCj4gd2hhdCBpcyB0aGUgJSBvZiB0aW1lIHNw
ZW50IGRvaW5nIGFzeW1tZXRyaWMga2V5IG9wZXJhdGlvbnMgaW4geW91cgo+IGJlbmNobWFyaz/C
oCBJIGFtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggY3J5cHRvIGFjY2VsZXJhdGlvbiBidXQgbXkK
PiB1bmRlcnN0YW5kaW5nIGhhcyBhbHdheXMgYmVlbiB0aGF0IG1vc3QgdGltZSBpcyBzcGVudCBk
b2luZyBlaXRoZXIKPiBoYXNoaW5nIChmb3Igc2lnbmluZykgb3Igc3ltbWV0cmljIGtleSBvcGVy
YXRpb25zIChmb3IgZW5jcnlwdGlvbikuCj4gCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwg
d2l0aG91dCBzdXBwb3J0IGZvciBhY2NlbGVyYXRpb24gdGhlc2UgCj4gcGF0Y2hlcyBhcmUgbW9y
ZSBvZiBhIGRlbW9uc3RyYXRpb24gb2YgdmlydGlvLWNyeXB0bywgb3IgdXNhYmxlIGZvciAKPiB0
ZXN0aW5nIHB1cnBvc2VzLgo+IAoKSGksIFBhb2xvCgpUaGlzIGlzIHRoZSBwZXJmIHJlc3VsdCBv
ZiBuZ2lueCtvcGVuc3NsIENQVSBjYWxjdWxhdGlvbiwgdGhlIGhlYXZ5IGxvYWQgCmZyb20gb3Bl
bnNzbCB1c2VzIHRoZSBtb3N0IHRpbWUoYXMgc2FtZSBhcyB5b3UgbWVudGlvbmVkKS4KMjcuMzcl
ICAgIDI2LjAwJSAgbmdpbnggICAgICAgICAgICBsaWJjcnlwdG8uc28uMS4xICAgICAgICAgIFsu
XSAKX19ibl9zcXJ4OHhfcmVkdWN0aW9uCjIwLjU4JSAgICAxOS41MiUgIG5naW54ICAgICAgICAg
ICAgbGliY3J5cHRvLnNvLjEuMSAgICAgICAgICBbLl0gCm11bHg0eF9pbnRlcm5hbAoxNi43MyUg
ICAgMTUuODklICBuZ2lueCAgICAgICAgICAgIGxpYmNyeXB0by5zby4xLjEgICAgICAgICAgWy5d
IApibl9zcXJ4OHhfaW50ZXJuYWwKICA4Ljc5JSAgICAgMC4wMCUgIG5naW54ICAgICAgICAgICAg
W3Vua25vd25dICAgICAgICAgICAgICAgICBba10gCjAwMDAwMDAwMDAwMDAwMDAKICA3LjI2JSAg
ICAgMC4wMCUgIG5naW54ICAgICAgICAgICAgW3Vua25vd25dICAgICAgICAgICAgICAgICBbLl0g
CjB4ODkzODg2Njk5OTJhMGNiYwogIDcuMDAlICAgICAwLjAwJSAgbmdpbnggICAgICAgICAgICBb
dW5rbm93bl0gICAgICAgICAgICAgICAgIFtrXSAKMHg0NWYwZTQ4MGQ1ZjJhNThlCiAgNi43NiUg
ICAgIDAuMDIlICBuZ2lueCAgICAgICAgICAgIFtrZXJuZWwua2FsbHN5bXNdICAgICAgICAgW2td
IAplbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUKICA2Ljc0JSAgICAgMC4wMiUgIG5naW54
ICAgICAgICAgICAgW2tlcm5lbC5rYWxsc3ltc10gICAgICAgICBba10gCmRvX3N5c2NhbGxfNjQK
ICA2LjYxJSAgICAgMC4wMCUgIG5naW54ICAgICAgICAgICAgW3Vua25vd25dICAgICAgICAgICAg
ICAgICBbLl0gCjB4YTc1YTYwZDc4MjBmOWZmYgogIDYuNDclICAgICAwLjAwJSAgbmdpbnggICAg
ICAgICAgICBbdW5rbm93bl0gICAgICAgICAgICAgICAgIFtrXSAKMHhlOTEyMjNmNmRhMzYyNTRj
CiAgNS41MSUgICAgIDAuMDElICBuZ2lueCAgICAgICAgICAgIFtrZXJuZWwua2FsbHN5bXNdICAg
ICAgICAgW2tdIAphc21fY29tbW9uX2ludGVycnVwdAogIDUuNDYlICAgICAwLjAxJSAgbmdpbngg
ICAgICAgICAgICBba2VybmVsLmthbGxzeW1zXSAgICAgICAgIFtrXSAKY29tbW9uX2ludGVycnVw
dAogIDUuMTYlICAgICAwLjA0JSAgbmdpbnggICAgICAgICAgICBba2VybmVsLmthbGxzeW1zXSAg
ICAgICAgIFtrXSAKX19zb2Z0aXJxZW50cnlfdGV4dF9zdGFydAogIDQuOTIlICAgICAwLjAxJSAg
bmdpbnggICAgICAgICAgICBba2VybmVsLmthbGxzeW1zXSAgICAgICAgIFtrXSAKaXJxX2V4aXRf
cmN1CiAgNC45MSUgICAgIDAuMDQlICBuZ2lueCAgICAgICAgICAgIFtrZXJuZWwua2FsbHN5bXNd
ICAgICAgICAgW2tdIApuZXRfcnhfYWN0aW9uCgoKVGhpcyBpcyB0aGUgcmVzdWx0IG9mIG5naW54
K29wZW5zc2wga2V5Y3RsIG9mZmxvYWQodmlydGlvIGNyeXB0byArIGhvc3QgCmtleWN0bCArIElu
dGVsIFFBVCk6CjMwLjM4JSAgICAgMC4wOCUgIG5naW54ICAgICAgICAgICAgW2tlcm5lbC5rYWxs
c3ltc10gICAgICAgICBba10gCmVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZQozMC4yOSUg
ICAgIDAuMDclICBuZ2lueCAgICAgICAgICAgIFtrZXJuZWwua2FsbHN5bXNdICAgICAgICAgW2td
IApkb19zeXNjYWxsXzY0CjIzLjg0JSAgICAgMC4wMCUgIG5naW54ICAgICAgICAgICAgW3Vua25v
d25dICAgICAgICAgICAgICAgICBba10gCjAwMDAwMDAwMDAwMDAwMDAKMTQuMjQlICAgICAwLjAz
JSAgbmdpbnggICAgICAgICAgICBba2VybmVsLmthbGxzeW1zXSAgICAgICAgIFtrXSAKYXNtX2Nv
bW1vbl9pbnRlcnJ1cHQKMTQuMDYlICAgICAwLjA1JSAgbmdpbnggICAgICAgICAgICBba2VybmVs
LmthbGxzeW1zXSAgICAgICAgIFtrXSAKY29tbW9uX2ludGVycnVwdAoxMi45OSUgICAgIDAuMTEl
ICBuZ2lueCAgICAgICAgICAgIFtrZXJuZWwua2FsbHN5bXNdICAgICAgICAgW2tdIApfX3NvZnRp
cnFlbnRyeV90ZXh0X3N0YXJ0CjEyLjI3JSAgICAgMC4xMiUgIG5naW54ICAgICAgICAgICAgW2tl
cm5lbC5rYWxsc3ltc10gICAgICAgICBba10gCm5ldF9yeF9hY3Rpb24KMTIuMTMlICAgICAwLjAz
JSAgbmdpbnggICAgICAgICAgICBba2VybmVsLmthbGxzeW1zXSAgICAgICAgIFtrXSBfX25hcGlf
cG9sbAoxMi4wNiUgICAgIDAuMDYlICBuZ2lueCAgICAgICAgICAgIFtrZXJuZWwua2FsbHN5bXNd
ICAgICAgICAgW2tdIAppcnFfZXhpdF9yY3UKMTAuNDklICAgICAwLjE0JSAgbmdpbnggICAgICAg
ICAgICBsaWJzc2wuc28uMS4xICAgICAgICAgICAgIFsuXSAKdGxzX3Byb2Nlc3NfY2xpZW50X2tl
eV9leGNoYW5nZQoxMC4yMSUgICAgIDAuMTIlICBuZ2lueCAgICAgICAgICAgIFt2aXJ0aW9fbmV0
XSAgICAgICAgICAgICAgW2tdIAp2aXJ0bmV0X3BvbGwKMTAuMTMlICAgICAwLjA0JSAgbmdpbngg
ICAgICAgICAgICBsaWJjLTIuMjguc28gICAgICAgICAgICAgIFsuXSBzeXNjYWxsCjEwLjEyJSAg
ICAgMC4wMyUgIG5naW54ICAgICAgICAgICAga2N0bC1lbmdpbmUuc28gICAgICAgICAgICBbLl0g
CmtjdGxfcnNhX3ByaXZfZGVjCjEwLjAyJSAgICAgMC4wMiUgIG5naW54ICAgICAgICAgICAga2N0
bC1lbmdpbmUuc28gICAgICAgICAgICBbLl0gCmtjdGxfaHdfcnNhX3ByaXZfZnVuYwogIDkuOTgl
ICAgICAwLjAxJSAgbmdpbnggICAgICAgICAgICBsaWJrZXl1dGlscy5zby4xLjEwICAgICAgIFsu
XSAKa2V5Y3RsX3BrZXlfZGVjcnlwdAogIDkuOTUlICAgICAwLjAyJSAgbmdpbnggICAgICAgICAg
ICBsaWJrZXl1dGlscy5zby4xLjEwICAgICAgIFsuXSBrZXljdGwKICA5Ljc3JSAgICAgMC4wMyUg
IG5naW54ICAgICAgICAgICAgW2tlcm5lbC5rYWxsc3ltc10gICAgICAgICBba10gCmtleWN0bF9w
a2V5X2VfZF9zCiAgOC45NyUgICAgIDAuMDAlICBuZ2lueCAgICAgICAgICAgIFt1bmtub3duXSAg
ICAgICAgICAgICAgICAgW2tdIAoweDAwMDA3ZjRhZGJiODFmMGIKICA4Ljc4JSAgICAgMC4wOCUg
IG5naW54ICAgICAgICAgICAgbGlicHRocmVhZC0yLjI4LnNvICAgICAgICBbLl0gCl9fbGliY193
cml0ZQogIDguNDklICAgICAwLjA1JSAgbmdpbnggICAgICAgICAgICBba2VybmVsLmthbGxzeW1z
XSAgICAgICAgIFtrXSAKbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9pbnRlcm5hbAoKVGhlIFJTQSBw
YXJ0IGdldHMgcmVkdWNlZCwgYW5kIHRoZSBRUFMgb2YgaHR0cHMgaW1wcm92ZXMgdG8gfjIwMCUu
CgpTb21ldGhpbmcgbWF5IGJlIGlnbm9yZWQgaW4gdGhpcyBjb3ZlciBsZXR0ZXI6Cls0XSBDdXJy
ZW50bHkgUlNBIGlzIHN1cHBvcnRlZCBvbmx5IGluIGJ1aWx0aW4gZHJpdmVyLiBUaGlzIGRyaXZl
ciBpcyAKc3VwcG9zZWQgdG8gdGVzdCB0aGUgZnVsbCBmZWF0dXJlIHdpdGhvdXQgb3RoZXIgc29m
dHdhcmUoRXggdmhvc3QgCnByb2Nlc3MpIGFuZCBoYXJkd2FyZSBkZXBlbmRlbmNlLgotPiBZZXMs
IHRoaXMgcGF0Y2ggaXMgYSBkZW1vbnN0cmF0aW9uIG9mIHZpcnRpby1jcnlwdG8uCgpbNV0ga2V5
Y3RsIGJhY2tlbmQgaXMgaW4gZGV2ZWxvcG1lbnQsIHdlIHdpbGwgcG9zdCB0aGlzIGZlYXR1cmUg
aW4gClEyLTIwMjIuIGtleWN0bCBiYWNrZW5kIGNhbiB1c2UgaGFyZHdhcmUgYWNjZWxlcmF0aW9u
KEV4LCBJbnRlbCBRQVQpLgotPiBUaGlzIGlzIG91ciBwbGFuLiBDdXJyZW50bHkgaXQncyBzdGls
bCBpbiBkZXZlbG9waW5nLgoKCj4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gZXh0ZW5kIHZpcnRp
by1jcnlwdG8gdG8gdXNlIGtleXMgYWxyZWFkeSBpbiB0aGUKPiBob3N0IGtleWN0bCwgb3IgaW4g
YSBQS0NTIzExIHNtYXJ0Y2FyZCwgc28gdGhhdCB2aXJ0aW8tY3J5cHRvIGNvdWxkIGFsc28KPiBw
cm92aWRlIHRoZSBmdW5jdGlvbmFsaXR5IG9mIGFuIEhTTT/CoCBPciBkb2VzIHRoZSBzdGFuZGFy
ZCByZXF1aXJlIHRoYXQKPiB0aGUga2V5cyBhcmUgcHJvdmlkZWQgYnkgdGhlIGd1ZXN0Pwo+IAo+
IFBhb2xvCgpJJ20gdmVyeSBpbnRlcmVzdGVkIGluIHRoaXMsIEknbGwgdHJ5IGluIFEzLTIwMjIg
b3IgbGF0ZXIuCgotLSAKemhlbndlaSBwaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
