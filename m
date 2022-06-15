Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83030C43334
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 06:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32B4040A93;
	Wed, 15 Jun 2022 06:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OkNm-Y_wkY5B; Wed, 15 Jun 2022 06:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D8E4340253;
	Wed, 15 Jun 2022 06:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCAB7C0039;
	Wed, 15 Jun 2022 06:24:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC46EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA86C60DF9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6LYC0K5V4ufQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:24:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02BD660BC2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 06:24:06 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-30fdbe7467cso51382307b3.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LshRSzq22wtp4qhXs+/iZas8+X4eeCgZ5sV4MhFsw2w=;
 b=luyrFMQUtVOGazWD1iq3vMXmKdEc5Z9Js2dg0RzKB7UAOL8BZ52UtgL/CXxEVKZVuw
 Lk4Uf50DB2KCN4AdmvHrHj1dL0buHpaWhvQP2ITrsXjzfMfLafIeW+ByvnE87ylrbN96
 NwgiKQIz2gnpUTJtwkHDdaMyi+OtlkO+HpgYQJA1Xb2gbQ0wx/i1jppcWMwFNPIic/BL
 gHYZPBNIQEnouIR/kcjreA0RJP6sNCa0Cj7vrEecr1j2QTQoDizmKigSbHDaJYHag7vx
 4kk8G8Q4AJJasQv7l8ujLQaoEfvqb6jDOCcGYTrSjw5pjx5idMc+9lQHaLuotaWJ/2ID
 lxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LshRSzq22wtp4qhXs+/iZas8+X4eeCgZ5sV4MhFsw2w=;
 b=yTKb2aJbr0jW/veQnYNrMeZA0WBbs6hzjdUvam5qyc8CSqXLaYHM/FAGf6d00IIT8g
 gScvgWE3zs1c37kGFvZmoClv6uzq66M4zx4SMJmgTG9UgJibQe8qPZLLtOoSO1BpoK2l
 HWhxudJjNz3NGvsGo1gC2e3iIYtlUfOOVGhJ+jWMydoyexJiAYJovpVRQkyIuPcsEqgJ
 C1a2zAjVb4vV9vl1Z9BRHkVELhjS3ErqaR9GRwZpgP22gkKkoSY9mPBtrQ4RsfzmH86I
 TZjKZ1KHjQMzxOIHUQF5QiJx8S4be+j4vO6hyjvknWmPMk9H/fkobNQbF+4IGerUWnYn
 RyOw==
X-Gm-Message-State: AJIora/TloNmQVdEBBac6u+Qz5weXeJ+giWjHHTiOxIltfflPRwg1Mgd
 bQEgHwlBw/nla0vHQCbX9ZGM5/Aq9GWJG/qkWys=
X-Google-Smtp-Source: AGRyM1tAM6ElCRQ+uq7vQIdf64vAqhTVQNLn5SJ7tZ9sRuvacanhNpyrrq71qFzPCPyW5IbmrgmbXDkARvs8jenWC3E=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr10019086ywk.209.1655274245807; Tue, 14
 Jun 2022 23:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
In-Reply-To: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 15 Jun 2022 11:53:54 +0530
Message-ID: <CAOh2x=kxpdisV+tqcYOoZGSKA8YjPMej+7u19Jpa1jmVcZCaxA@mail.gmail.com>
Subject: Re: [PATCH V4 0/8] virtio: Solution to restrict memory access under
 Xen using xen-grant DMA-mapping layer
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Henry Wang <Henry.Wang@arm.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Wei Chen <Wei.Chen@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, x86@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jiamei Xie <Jiamei.Xie@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Kaly Xin <Kaly.Xin@arm.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Bertrand Marquis <bertrand.marquis@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

SGkgT2xla3NhbmRyLAoKT24gTW9uLCBKdW4gNiwgMjAyMiBhdCAxMDoxNiBBTSBPbGVrc2FuZHIg
VHlzaGNoZW5rbwo8b2xla3N0eXNoQGdtYWlsLmNvbT4gd3JvdGU6Cj4gVGhlIGhpZ2ggbGV2ZWwg
aWRlYSBpcyB0byBjcmVhdGUgbmV3IFhlbuKAmXMgZ3JhbnQgdGFibGUgYmFzZWQgRE1BLW1hcHBp
bmcgbGF5ZXIgZm9yIHRoZSBndWVzdCBMaW51eCB3aG9zZSBtYWluCj4gcHVycG9zZSBpcyB0byBw
cm92aWRlIGEgc3BlY2lhbCA2NC1iaXQgRE1BIGFkZHJlc3Mgd2hpY2ggaXMgZm9ybWVkIGJ5IHVz
aW5nIHRoZSBncmFudCByZWZlcmVuY2UgKGZvciBhIHBhZ2UKPiB0byBiZSBzaGFyZWQgd2l0aCB0
aGUgYmFja2VuZCkgd2l0aCBvZmZzZXQgYW5kIHNldHRpbmcgdGhlIGhpZ2hlc3QgYWRkcmVzcyBi
aXQgKHRoaXMgaXMgZm9yIHRoZSBiYWNrZW5kIHRvCj4gYmUgYWJsZSB0byBkaXN0aW5ndWlzaCBn
cmFudCByZWYgYmFzZWQgRE1BIGFkZHJlc3MgZnJvbSBub3JtYWwgR1BBKS4gRm9yIHRoaXMgdG8g
d29yayB3ZSBuZWVkIHRoZSBhYmlsaXR5Cj4gdG8gYWxsb2NhdGUgY29udGlndW91cyAoY29uc2Vj
dXRpdmUpIGdyYW50IHJlZmVyZW5jZXMgZm9yIG11bHRpLXBhZ2UgYWxsb2NhdGlvbnMuIEFuZCB0
aGUgYmFja2VuZCB0aGVuIG5lZWRzCj4gdG8gb2ZmZXIgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
IGFuZCBWSVJUSU9fRl9WRVJTSU9OXzEgZmVhdHVyZSBiaXRzIChpdCBtdXN0IHN1cHBvcnQgdmly
dGlvLW1taW8gbW9kZXJuCj4gdHJhbnNwb3J0IGZvciA2NC1iaXQgYWRkcmVzc2VzIGluIHRoZSB2
aXJ0cXVldWUpLgoKSSB3YXMgdHJ5aW5nIHlvdXIgc2VyaWVzLCBmcm9tIExpbnVzJ3MgdHJlZSBu
b3cgYW5kIHN0YXJ0ZWQgc2VlaW5nCmJvb3QgZmFpbHVyZXMsCmZhaWxlZCB0byBtb3VudCByb290
ZnMuIEFuZCB0aGUgcmVhc29uIHByb2JhYmx5IGlzIHRoZXNlIG1lc3NhZ2VzOgoKWyAxLjIyMjQ5
OF0gdmlydGlvX3Njc2kgdmlydGlvMTogZGV2aWNlIG11c3QgcHJvdmlkZSBWSVJUSU9fRl9BQ0NF
U1NfUExBVEZPUk0KWyAxLjMxNjMzNF0gdmlydGlvX25ldCB2aXJ0aW8wOiBkZXZpY2UgbXVzdCBw
cm92aWRlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQoKSSB1bmRlcnN0YW5kIGZyb20geW91ciBl
bWFpbCB0aGF0IHRoZSBiYWNrZW5kcyBuZWVkIHRvIG9mZmVyClZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSBmbGFnIG5vdywgYnV0IHNob3VsZCB0aGlzIHJlcXVpcmVtZW50IGJlIGEKYml0IHNvZnQg
PyBJIG1lYW4gc2hvdWxkbid0IHdlIGFsbG93IGJvdGggdHlwZXMgb2YgYmFja2VuZHMgdG8gcnVu
IHdpdGggdGhlIHNhbWUKa2VybmVsLCBvbmVzIHRoYXQgb2ZmZXIgdGhpcyBmZWF0dXJlIGFuZCBv
dGhlcnMgdGhhdCBkb24ndCA/IFRoZSBvbmVzIHRoYXQgZG9uJ3QKb2ZmZXIgdGhlIGZlYXR1cmUs
IHNob3VsZCBjb250aW51ZSB0byB3b3JrIGxpa2UgdGhleSB1c2VkIHRvLCBpLmUuCndpdGhvdXQg
dGhlIHJlc3RyaWN0ZWQKbWVtb3J5IGFjY2VzcyBmZWF0dXJlLgoKSSBhbSB0ZXN0aW5nIFhlbiBj
dXJyZW50bHkgd2l0aCBoZWxwIG9mIFFlbXUgIG92ZXIgbXkgeDg2IGRlc2t0b3AgYW5kCnRoZXNl
IGJhY2tlbmRzCihzY3NpIGFuZCBuZXQpIGFyZSBwYXJ0IG9mIFFFTVUgaXRzZWxmIEkgdGhpbmss
IGFuZCBJIGRvbid0IHJlYWxseQp3YW50IHRvIGdvIGFuZCBtYWtlIHRoZQpjaGFuZ2UgdGhlcmUu
CgpUaGFua3MuCgotLQpWaXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
