Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5984C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 01:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4387260A9D;
	Thu, 24 Mar 2022 01:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FsJZ_UozCsPJ; Thu, 24 Mar 2022 01:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6FE760A7B;
	Thu, 24 Mar 2022 01:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C905C001A;
	Thu, 24 Mar 2022 01:24:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80606C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A4C64011D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8rBE8g9_3yI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:24:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5719D40101
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:24:21 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 l4-20020a17090a49c400b001c6840df4a3so3656677pjm.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 18:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=3gf8Z0AeygEwFExdE0O7TqboXgYri9LxO9Of64RLfeg=;
 b=6CrMHnqM5dRaJwsgsPiZKeBJBFpOMCLJMcBMIDZV86a0U+/W7qBUxS5uvKeliWRxnk
 xCdMZCjMAD5eFWlqt0+CnAe411fJctiTUWqIxHayXCd3mEuRLpceVh4FbRl0dNGRAzEv
 gHAv78dpS1SNuSqwQdgSDJgCyzdw4jslC1t6gBFxGm4usEKFlCb64/31XtJbUgoqI8N8
 MVyGvIHYOH0sdPgMwF6NwIkFqTVMtuVbQ0zMuQXQc30kMGp4DzbQF7bGksO5HaRbXBXj
 IOBT6B9sJAOoqbzM3p0gSeFrmQ+z5CIKbgiYiaokaRrQOUFqBf/O5zN5+RLlsxTCkkrn
 lhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3gf8Z0AeygEwFExdE0O7TqboXgYri9LxO9Of64RLfeg=;
 b=IhyITo6Lll41f5rjyB8pKLSX4r1eJy/5mDZOMFyKJB3jPNzDp9s2RS0hosuKfh5xsA
 up4LplJ1Wbq53qWYgu9Enhvao15lluo39EVhCBVjrV5jx00oq4N72btaJIt+XE9hUEwl
 +L10tEKhvORhy5xr4LkML13FB7QO5ileUbWZoThLDpK+gemI3AHbXO7RdGJtMmfN3Idr
 KTzIyFVxWrpbb8J7Zm+MbOrxtuhCAORk5kbdA+w7ZZSLmZGmBhkKvpyXFBHdJJSQkNf1
 IxZjf3/FEXb7xUbYGXe64vSgfUEzogN7TUR/XFjzoeUgvIhd47qbs7GGwG3/pWe9dPfo
 l1Nw==
X-Gm-Message-State: AOAM530XA/mLrJJD1jpeLI5HdCKph+P6UM1ymFUdK05tw8cq/+lZWZyO
 0Y81FN7bdPx3jiC8qDoMWV79rw==
X-Google-Smtp-Source: ABdhPJxK7gkGwK2pc51pDttIpNHfQEtRRcUUcTS04EmEfunycLux7XmrvUWP/Z98Qqe0b3FLhmAl7Q==
X-Received: by 2002:a17:90b:4d8c:b0:1c7:61ce:b706 with SMTP id
 oj12-20020a17090b4d8c00b001c761ceb706mr2990093pjb.211.1648085060534; 
 Wed, 23 Mar 2022 18:24:20 -0700 (PDT)
Received: from [10.255.146.117] ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a056a00084700b004faeee0fcdfsm90338pfk.33.2022.03.23.18.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 18:24:19 -0700 (PDT)
Message-ID: <c67381b4-f376-bbe5-cf50-603f0f72e0ae@bytedance.com>
Date: Thu, 24 Mar 2022 09:20:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Re: Re: [PATCH v3 0/6] Support akcipher for virtio-crypto
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <YjqtXFvfDq0kELl7@sol.localdomain>
 <f806c17c-cc7e-e2eb-e187-e83148160322@bytedance.com>
 <Yjtg65rsnrzgyS5a@sol.localdomain>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yjtg65rsnrzgyS5a@sol.localdomain>
Cc: herbert@gondor.apana.org.au, mst@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 3/24/22 02:03, Eric Biggers wrote:
> On Wed, Mar 23, 2022 at 03:32:37PM +0800, zhenwei pi wrote:
>>
>> On 3/23/22 13:17, Eric Biggers wrote:
>>> On Wed, Mar 23, 2022 at 10:49:06AM +0800, zhenwei pi wrote:
>>>> v2 -> v3:
>>>> - Introduce akcipher types to qapi
>>>> - Add test/benchmark suite for akcipher class
>>>> - Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
>>>>     - crypto: Introduce akcipher crypto class
>>>>     - virtio-crypto: Introduce RSA algorithm
>>>>
>>>> v1 -> v2:
>>>> - Update virtio_crypto.h from v2 version of related kernel patch.
>>>>
>>>> v1:
>>>> - Support akcipher for virtio-crypto.
>>>> - Introduce akcipher class.
>>>> - Introduce ASN1 decoder into QEMU.
>>>> - Implement RSA backend by nettle/hogweed.
>>>>
>>>> Lei He (3):
>>>>     crypto-akcipher: Introduce akcipher types to qapi
>>>>     crypto: Implement RSA algorithm by hogweed
>>>>     tests/crypto: Add test suite for crypto akcipher
>>>>
>>>> Zhenwei Pi (3):
>>>>     virtio-crypto: header update
>>>>     crypto: Introduce akcipher crypto class
>>>>     virtio-crypto: Introduce RSA algorithm
>>>
>>> You forgot to describe the point of this patchset and what its use case is.
>>> Like any other Linux kernel patchset, that needs to be in the cover letter.
>>>
>>> - Eric
>> Thanks Eric for pointing this missing part.
>>
>> This feature provides akcipher service offloading capability. QEMU side
>> handles asymmetric requests via virtio-crypto devices from guest side, do
>> encrypt/decrypt/sign/verify operations on host side, and return the result
>> to guest.
>>
>> This patchset implements a RSA backend by hogweed from nettle, it works
>> together with guest patch:
>> https://lkml.org/lkml/2022/3/1/1425
> 
> So what is the use case?
> 
> - Eric
Hi,

In our plan, the feature is designed for HTTPS offloading case and other 
applications which use kernel RSA/ecdsa by keyctl syscall. The full 
picture shows bellow:


                   Nginx/openssl[1] ... Apps
Guest   -----------------------------------------
                    virtio-crypto driver[2]
-------------------------------------------------
                    virtio-crypto backend[3]
Host    -----------------------------------------
                   /          |          \
               builtin[4]   vhost     keyctl[5] ...


[1] User applications can offload RSA calculation to kernel by keyctl 
syscall. There is no keyctl engine in openssl currently, we developed a 
engine and tried to contribute it to openssl upstream, but openssl 1.x 
does not accept new feature. Link:
	https://github.com/openssl/openssl/pull/16689

This branch is available and maintained by Lei <helei.sig11@bytedance.com>
	https://github.com/TousakaRin/openssl/tree/OpenSSL_1_1_1-kctl_engine

We tested nginx(change config file only) with openssl keyctl engine, it 
works fine.

[2] virtio-crypto driver is used to communicate with host side, send 
requests to host side to do asymmetric calculation.
	https://lkml.org/lkml/2022/3/1/1425

[3] virtio-crypto backend handles requests from guest side, and forwards 
request to crypto backend driver of QEMU.

[4] Currently RSA is supported only in builtin driver. This driver is 
supposed to test the full feature without other software(Ex vhost 
process) and hardware dependence. ecdsa is introduced into qapi type 
without implementation, this may be implemented in Q3-2022 or later. If 
ecdsa type definition should be added with the implementation together, 
I'll remove this in next version.

[5] keyctl backend is in development, we will post this feature in 
Q2-2022. keyctl backend can use hardware acceleration(Ex, Intel QAT).

Setup the full environment, tested with Intel QAT on host side, the QPS 
of HTTPS increase to ~200% in a guest.

VS PCI passthrough: the most important benefit of this solution makes 
the VM migratable.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
