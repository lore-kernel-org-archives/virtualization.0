Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3470FC07E9A
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 09:21:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB3A613BE
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 09:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB3A613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DD4E6060A;
	Wed, 14 Jul 2021 09:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJ9urPi2SuBc; Wed, 14 Jul 2021 09:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6D5D6074D;
	Wed, 14 Jul 2021 09:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C78E9C0010;
	Wed, 14 Jul 2021 09:21:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93054C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 09:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8112D4021A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 09:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="vDW7bGOH";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="FFN7W871"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TaMgJaC2Spqw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 09:21:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FEA1400C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 09:21:51 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4E34229FB;
 Wed, 14 Jul 2021 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626254508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sy6PE7HATWBWi34Qlea4lbKHZ+KnRq7LLyXvTID244=;
 b=vDW7bGOHgACaftgmRFKcf2uC85NIjfPs7tQ53GmXvArDj3A+YkZyPX1Ky8NTzoxK+CRrRO
 nWct9nywqfjLai5vHgfqTpoDay5oHoktrdudplrEvF6kuj8aQcrrKsRy2X5m2LwmCYK5fd
 y1mFy/FppTy22dqTuHmvWNkaPojbjpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626254508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sy6PE7HATWBWi34Qlea4lbKHZ+KnRq7LLyXvTID244=;
 b=FFN7W871YuS2QtltDc9AkbXq0vaXp5Tnr7l06lsLAus59nCrB414VZeejuDQTLO9S3p6B2
 dQ1nN46qDv6nblCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6F14C13A79;
 Wed, 14 Jul 2021 09:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id jWIyGays7mCwCwAAGKfGzw
 (envelope-from <tzimmermann@suse.de>); Wed, 14 Jul 2021 09:21:48 +0000
Subject: Re: [PATCH -next] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
References: <20210714083903.205552-1-yangyingliang@huawei.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <e75736ae-dbe0-7422-1b03-72de84755090@suse.de>
Date: Wed, 14 Jul 2021 11:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714083903.205552-1-yangyingliang@huawei.com>
Cc: airlied@linux.ie
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
Content-Type: multipart/mixed; boundary="===============5931891305477754201=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5931891305477754201==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eh8yMvZ2QsKcqPVd8H4Fhlq6BNHbG7ueO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eh8yMvZ2QsKcqPVd8H4Fhlq6BNHbG7ueO
Content-Type: multipart/mixed; boundary="D2w0zk9in6VlbyWGfW2rRh68ZFFcEYAL0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: airlied@linux.ie, kraxel@redhat.com
Message-ID: <e75736ae-dbe0-7422-1b03-72de84755090@suse.de>
Subject: Re: [PATCH -next] drm/bochs: Fix missing pci_disable_device() on
 error in bochs_pci_probe()
References: <20210714083903.205552-1-yangyingliang@huawei.com>
In-Reply-To: <20210714083903.205552-1-yangyingliang@huawei.com>

--D2w0zk9in6VlbyWGfW2rRh68ZFFcEYAL0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 14.07.21 um 10:39 schrieb Yang Yingliang:
> Fix the missing pci_disable_device() before return
> from bochs_pci_probe() in the error handling case.

It's maybe better to replace pci_enable_device() with=20
pcim_enable_device(), [1] so that the release happens automatically.=20
Does this work?

Best regards
Thomas

https://elixir.bootlin.com/linux/v5.13.1/source/drivers/pci/pci.c#L2042

>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/gpu/drm/tiny/bochs.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.=
c
> index a2cfecfa8556..74832b9d3eae 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -666,6 +666,7 @@ static int bochs_pci_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent
>   	return ret;
>  =20
>   err_free_dev:
> +	pci_disable_device(pdev);
>   	drm_dev_put(dev);
>   	return ret;
>   }
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--D2w0zk9in6VlbyWGfW2rRh68ZFFcEYAL0--

--eh8yMvZ2QsKcqPVd8H4Fhlq6BNHbG7ueO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmDurKsFAwAAAAAACgkQlh/E3EQov+Bc
/w//YU2JJd6L4kcRmcl/W7fZNpNN5tzcjL4jMdquWM+H1PKXSRUZAq+YT2RYCDTzJV7hZUhttwXH
pPgYq3bmAhz8tB0sZZcJCMRCWjM6UaTTGKNQSglCEOpXoB+LDPdcl2kd2CcHvKgnOPvtkIqY8QRr
qGla2LBE7dKNi7oqn9G2QQ71Y3PrdtJDQ3hOGBTiq6KfnjfPjflJBCTPZub33XhbBK9rOST5WHrR
s8D4zUlTMk+u33CW7I0n3+NbUA1o0qWYP9gzkS0vf6vMgYyay0eSXp0cqnyTNSluTauKsH/ONI49
YKGzJcfDbuzVMAfKEmLXFMGfjvUclsCutCtokTEDSmASH47P6KmF5GvAREFtFH1T+QJi8kirdCEq
+hV8XfOmv47cFIfRLlTII28gJDcD8YtQhUO7qt7rz4xst4qfh7ua2vXfHQEmzVsX3peizxVBtPC6
5T3nFoW9rZvOdjK4qEMZMxuSY+iznMW0Bi3K62rDh+T7gFBo4k8oo0INKIXo059OrIcUR7yHb0/y
GH+CaVjnWavJAfHf2xLznLymm32AHlFefxiZeZTbIHGVoX3Qumo5D219IQUVbA/QkHDXizEgrdJK
24H9rYbhd9F7qINHgBgOJgWOD4b/QjfRGg8SNwbpAh7EWg34jmo/5Uxtb7GL2v8lAAuRqCn9k2eJ
9as=
=g/fx
-----END PGP SIGNATURE-----

--eh8yMvZ2QsKcqPVd8H4Fhlq6BNHbG7ueO--

--===============5931891305477754201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5931891305477754201==--
