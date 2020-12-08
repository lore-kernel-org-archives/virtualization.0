Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB17AC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:18:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7357723A5B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7357723A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3AB7787590;
	Tue,  8 Dec 2020 08:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iC7sPawHI2L3; Tue,  8 Dec 2020 08:18:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC1108755E;
	Tue,  8 Dec 2020 08:18:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E189C0FA7;
	Tue,  8 Dec 2020 08:18:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 014CBC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DF88A8727C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ezMdaGef1Adc
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:17:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 612AB87271
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:17:59 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id h16so5331042edt.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 00:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BiHatFn29jpCwDDhBSm+X0xUHoMKEAQw9eUj4sTBRlM=;
 b=mQzGDDBdkuRnj6sxJrdTG4VLsqwKNasQhPknV11+Pb27T5zHd8ND5cE/Djp3nCtC+X
 mRSuXJy8UnNQ9MPbDTV9NREs531651euPnlM6X1VV7T1aHhD4lOcB52TgpOijuJoWcmC
 LAWGMzcGgHB0S3Cdol4KEUXm9GqEoBhja1U4G0EWt+WfEMJAmJtXktow0Z6fRyjZfsLT
 rxrLLDJDJMhbscND2z2sjN5ThDAG/+oBWMTE8MK0SvpE5hCJvvQNPI5xDni+TxqIOxMo
 izM4EHrGKVv0m8M2uMTlXlZEfiSnZgExpNv/mQB6dODNYagN4wkxZ6xve+BbCqCOnrSB
 fjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BiHatFn29jpCwDDhBSm+X0xUHoMKEAQw9eUj4sTBRlM=;
 b=XIwsAq7WvhSo7In9uSBHQrdtUV4VZYFpH772i05JGO2sj+fVt0/95hFvi9nQLgU8Mc
 eF8LvpH5l1EROnHmIAs08eVKcfhWHXrQDtYg2MJLhF+B4S1GN+T2UQY7uxpDU52VWmVE
 7u3BEuP6LBjwxvfQtTyAdBBiy50R132yBmBnugMzR3ubyGxnmf22yUmP5NtR4QDjSQ2S
 9ieEGH/+bdFJMIfWiQXPuDMSD91/5dKYyDaNpnFTvHG8tWqjjOxl36CjMfj06PueHyUG
 0wrxzfYd9L31TQsFlEqBwnx765WjenQiKUYy+z2IMz2a7CHckJV8Mefu45QbyT7/gbZD
 jYxA==
X-Gm-Message-State: AOAM531Qu+jitX7jLX7ddvqdRmPl56RyRbhNi1/LGnnLDSGpByipEzXz
 tLQSOpbzHNzhXWuWpen/xrY=
X-Google-Smtp-Source: ABdhPJyHh0yxa7w8t9BjtnS6Zimgt4s5lHthEFOAPhZNJnJ55BjwATBi4HezVl7QtEVqO0Z0JSV7Pg==
X-Received: by 2002:aa7:d459:: with SMTP id q25mr23378343edr.279.1607415477826; 
 Tue, 08 Dec 2020 00:17:57 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id ch30sm16327737edb.8.2020.12.08.00.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:17:56 -0800 (PST)
Date: Tue, 8 Dec 2020 08:17:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 10/27] vhost: Allocate shadow vring
Message-ID: <20201208081755.GS203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-11-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-11-eperezma@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6756270894517065328=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6756270894517065328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Content-Disposition: inline


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:48PM +0100, Eugenio P=E9rez wrote:
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-sw-lm-ring.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-sw-lm-ring.c b/hw/virtio/vhost-sw-lm-ring.c
> index cbf53965cd..cd7b5ba772 100644
> --- a/hw/virtio/vhost-sw-lm-ring.c
> +++ b/hw/virtio/vhost-sw-lm-ring.c
> @@ -16,8 +16,11 @@
>  #include "qemu/event_notifier.h"
> =20
>  typedef struct VhostShadowVirtqueue {
> +    struct vring vring;
>      EventNotifier hdev_notifier;
>      VirtQueue *vq;
> +
> +    vring_desc_t descs[];
>  } VhostShadowVirtqueue;

Looking at later patches I see that this is the vhost hdev vring state,
not the VirtIODevice vring state. That makes more sense.

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PNrMACgkQnKSrs4Gr
c8hJxQf/Xue75u7nedZDTV1CqmKKp32KUzPMlA5zalyXvgqpXIivVnQ97AKeTHt9
vwLbUTVRNrC+5TVoAsyAlBeqFCRzwcdOdxIBFfqHE8bbND4mV+98ka4xPEwwFYQG
zxbcGPKnGwvdUP/ZYk4l/qK2EUwAmqXBq9v9XiBzciMBptG+CVNCOppv4SqaWhdn
IdTLT2m0KevNzqTvF6jOy6zA4BSoKYOZENTh20MSqWEILqCREtS/VkHCiqVW4DuJ
653E63sKml4j2uCGj25Tvs0JV6B+yDDf5jyz97B4qW8ur8cGbxmklBjXrlUSaBfI
m9FnQX/MGv39h7gG9BRaDnGfk7DyMQ==
=d+Ix
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--

--===============6756270894517065328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6756270894517065328==--
