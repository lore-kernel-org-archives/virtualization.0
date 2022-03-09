Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5896FC43217
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 02:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E404381985;
	Wed,  9 Mar 2022 02:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGvA-vfYwYH0; Wed,  9 Mar 2022 02:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F33D818D4;
	Wed,  9 Mar 2022 02:01:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E361C0012;
	Wed,  9 Mar 2022 02:01:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74CE7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5348040103
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=bytedance-com.20200927.dkim.feishu.cn
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zX54F1LH4HwR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:00:59 +0000 (UTC)
X-Greylist: delayed 00:05:04 by SQLgrey-1.8.0
Received: from u05.bc.larksuite.com (u05.bc.larksuite.com [130.44.212.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF69B400EA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 02:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bytedance-com.20200927.dkim.feishu.cn; t=1646790949;
 h=mime-version:from:date:message-id:subject:to;
 bh=W24xtRqZxYnqDNMK0po1dFS17vemVy1G1cLLcfvPYIE=;
 b=QBR+8HyDc2HFjV67b75NiTyjBhFs3vgLP9/dQYDMnxZpgcYxtNpd9ey/4AmxTeTCq4WQgy
 9UwENMZrnzKTiq2/7+rCd0aD7Y+DrOmkqEAtB7zOz73ECZyJCT0XA2UYJBIif7o/PzPRj2
 +jEA2Uv8nuH75GBojUG2Zd02lyxSPVMgVC0sRNIItX39yDOVGHG/twUU4/HldyBYuOeiaO
 JaJQ4ds05VdpIH1UA6q9WyUTd70rihoMouuh7s972f+u/ea0asQ2pmDz6ZG5xjVBOTYsUI
 WJsgkONT4nyhx+RtIhiYtoNZ5xzr2J0FM94Mv3WP/T6AtpnjwNHckXX1F/I4VA==
From: "zhenwei pi" <pizhenwei@bytedance.com>
In-Reply-To: <20220308161153-mutt-send-email-mst@kernel.org>
References: <20220308205309.2192502-1-nathan@kernel.org>
 <20220308161153-mutt-send-email-mst@kernel.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:91.0) Gecko/20100101 Thunderbird/91.5.0
Mime-Version: 1.0
Content-Language: en-US
Subject: Re: Re: [PATCH -next] crypto: virtio - Select new dependencies
Date: Wed, 09 Mar 2022 09:55:49 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Message-Id: <9c5b7985-85fd-d09e-ff40-1105268a76cd@bytedance.com>
Cc: lei he <helei.sig11@bytedance.com>, patches@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============4758969613027878159=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4758969613027878159==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative;
 boundary=a1630a9cb5d591803da6928e0450446c366d6c52841d8912fb9f0d1eb386
Content-Language: en-US

--a1630a9cb5d591803da6928e0450446c366d6c52841d8912fb9f0d1eb386
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On 3/9/22 05:12, Michael S. Tsirkin wrote:
> On Tue, Mar 08, 2022 at 01:53:09PM -0700, Nathan Chancellor wrote:
>> With ARCH=3Driscv defconfig, there are errors at link time:
>>
>>    virtio_crypto_akcipher_algs.c:(.text+0x3ea): undefined reference to `=
mpi_free'
>>    virtio_crypto_akcipher_algs.c:(.text+0x48a): undefined reference to `=
rsa_parse_priv_key'
>>    virtio_crypto_akcipher_algs.c:(.text+0x4bc): undefined reference to `=
rsa_parse_pub_key'
>>    virtio_crypto_akcipher_algs.c:(.text+0x4d0): undefined reference to `=
mpi_read_raw_data'
>>    virtio_crypto_akcipher_algs.c:(.text+0x960): undefined reference to `=
crypto_register_akcipher'
>>    virtio_crypto_akcipher_algs.c:(.text+0xa3a): undefined reference to `=
crypto_unregister_akcipher'
>>
>> The virtio crypto driver started making use of certain libraries and
>> algorithms without selecting them. Do so to fix these errors.
>>
>> Fixes: 8a75f36b5d7a ("virtio-crypto: implement RSA algorithm")
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Thanks! I'll squash this into the original commit so we don't
> have a broken commit during bisect.
> zhenwei pi, ack pls?
>=20
It looks good to me, thanks a lot.

>> ---
>>   drivers/crypto/virtio/Kconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconf=
ig
>> index b894e3a8be4f..5f8915f4a9ff 100644
>> --- a/drivers/crypto/virtio/Kconfig
>> +++ b/drivers/crypto/virtio/Kconfig
>> @@ -3,8 +3,11 @@ config CRYPTO_DEV_VIRTIO
>>   	tristate "VirtIO crypto driver"
>>   	depends on VIRTIO
>>   	select CRYPTO_AEAD
>> +	select CRYPTO_AKCIPHER2
>>   	select CRYPTO_SKCIPHER
>>   	select CRYPTO_ENGINE
>> +	select CRYPTO_RSA
>> +	select MPILIB
>>   	help
>>   	  This driver provides support for virtio crypto device. If you
>>   	  choose 'M' here, this module will be called virtio_crypto.
>>
>> base-commit: c5f633abfd09491ae7ecbc7fcfca08332ad00a8b
>> --=20
>> 2.35.1
--a1630a9cb5d591803da6928e0450446c366d6c52841d8912fb9f0d1eb386
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>On 3/9/22 05:12, Michael S. Tsirkin wrote:
<br>> On Tue, Mar 08, 2022 at 01:53:09PM -0700, Nathan Chancellor wrote:
<br>>> With ARCH=3Driscv defconfig, there are errors at link time:
<br>>>
<br>>>    virtio_crypto_akcipher_algs.c:(.text+0x3ea): undefined reference =
to `mpi_free'
<br>>>    virtio_crypto_akcipher_algs.c:(.text+0x48a): undefined reference =
to `rsa_parse_priv_key'
<br>>>    virtio_crypto_akcipher_algs.c:(.text+0x4bc): undefined reference =
to `rsa_parse_pub_key'
<br>>>    virtio_crypto_akcipher_algs.c:(.text+0x4d0): undefined reference =
to `mpi_read_raw_data'
<br>>>    virtio_crypto_akcipher_algs.c:(.text+0x960): undefined reference =
to `crypto_register_akcipher'
<br>>>    virtio_crypto_akcipher_algs.c:(.text+0xa3a): undefined reference =
to `crypto_unregister_akcipher'
<br>>>
<br>>> The virtio crypto driver started making use of certain libraries and
<br>>> algorithms without selecting them. Do so to fix these errors.
<br>>>
<br>>> Fixes: 8a75f36b5d7a ("virtio-crypto: implement RSA algorithm")
<br>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
<br>>=20
<br>> Thanks! I'll squash this into the original commit so we don't
<br>> have a broken commit during bisect.
<br>> zhenwei pi, ack pls?
<br>>=20
<br>It looks good to me, thanks a lot.
<br>
<br>>> ---
<br>>>   drivers/crypto/virtio/Kconfig | 3 +++
<br>>>   1 file changed, 3 insertions(+)
<br>>>
<br>>> diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/K=
config
<br>>> index b894e3a8be4f..5f8915f4a9ff 100644
<br>>> --- a/drivers/crypto/virtio/Kconfig
<br>>> +++ b/drivers/crypto/virtio/Kconfig
<br>>> @@ -3,8 +3,11 @@ config CRYPTO_DEV_VIRTIO
<br>>>   	tristate "VirtIO crypto driver"
<br>>>   	depends on VIRTIO
<br>>>   	select CRYPTO_AEAD
<br>>> +	select CRYPTO_AKCIPHER2
<br>>>   	select CRYPTO_SKCIPHER
<br>>>   	select CRYPTO_ENGINE
<br>>> +	select CRYPTO_RSA
<br>>> +	select MPILIB
<br>>>   	help
<br>>>   	  This driver provides support for virtio crypto device. If you
<br>>>   	  choose 'M' here, this module will be called virtio_crypto.
<br>>>
<br>>> base-commit: c5f633abfd09491ae7ecbc7fcfca08332ad00a8b
<br>>> --=20
<br>>> 2.35.1</p>
--a1630a9cb5d591803da6928e0450446c366d6c52841d8912fb9f0d1eb386--

--===============4758969613027878159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4758969613027878159==--
