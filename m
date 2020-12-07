Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F96C4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:19:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5F523750
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5F523750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21E6D87814;
	Mon,  7 Dec 2020 16:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-fHzgGap1BX; Mon,  7 Dec 2020 16:19:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 67DCB877E1;
	Mon,  7 Dec 2020 16:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF9DC0FA7;
	Mon,  7 Dec 2020 16:19:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8EC6C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D036B8791A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M32ep4khwf72
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 16AEE87916
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:19:43 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id qw4so20268043ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 08:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/eSi/KSMttHPQgAIpGGrtrzzrv7ZxXO1mG7WIUe69XI=;
 b=XBQhYfKoE1vDdmR6R6aw3GslMvqVhMHR+mWPKtK7kFF2S2NzpY3QDbR3B6hc6uqB2E
 nS5Bx6SFAYDqdy/fjDiMPPqUVPc+FyRfT0Mx9I/PnAGu/JGo6420yHTKjXAI/83QoJOL
 KXW9KklObO+mMR2gx5SZMQ93dzL4aK86V3M06gRdD4Ycqegs37yDDNaOPBmd/SWAPiaN
 vjufootHqk+B7uY3S9qON91bzw2uV6jqjyhc5iolXZGBNiYZyorBkZ5P6gngcVB/eGIf
 Qd51RPCKHOL9iMwHe2rnG3dEWHa1S+/v+HWZK75ObhxIlKBH84bLAR3t++wW7yZgMvYR
 ah4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/eSi/KSMttHPQgAIpGGrtrzzrv7ZxXO1mG7WIUe69XI=;
 b=Z9Js593L89GA6UOznvb0vhPm8BKrOQRzA98jcLH39nL5gWhjjhGzyyVZLAVQaOuid2
 b/6grKaqm/PaVUOvy1x9FHhMlWCkhogbAdSGTQPCNFyQ1f31ymFmbM4MXoRFTOQvXA7P
 RTBX5gP6Pmi0uTM/cvUY7d0T2PsoIGxRePTfmQcLAM0wIcpc9CRz7m1gcCjNhj19rOYh
 uwyO1lweTCfmT349r0ghTJ4wtjfXpLBjBX0kjwIU9yw5FLE7XlZGNmCcfNYWq9DR6SYR
 qugj6yHTWTAsX2JEt0cHW5N7cRKrH+YHiz/xKxtFRl8GBTLnLRUrv3KXrKy2Rj5RLiE2
 UEcw==
X-Gm-Message-State: AOAM532rhebboopg7RbeQUEWrrrOJHdTh+HwOosoGdau2Yy2M9rjyPBw
 /zfv4RWrDGhrReVp1WaLBK8=
X-Google-Smtp-Source: ABdhPJwKqNkLOxHgzPO8kSnC1Cb3/OofXxUefrdmsY4FNYlS+ZjB5jXyTOtCYTslSsyc6ct9KuXq4A==
X-Received: by 2002:a17:906:7146:: with SMTP id
 z6mr19613913ejj.379.1607357981469; 
 Mon, 07 Dec 2020 08:19:41 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u3sm12762018eje.33.2020.12.07.08.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 08:19:40 -0800 (PST)
Date: Mon, 7 Dec 2020 16:19:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 02/27] vhost: Add device callback in
 vhost_migration_log
Message-ID: <20201207161938.GJ203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-3-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============8574866694185540185=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8574866694185540185==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:40PM +0100, Eugenio P=E9rez wrote:
> This allows code to reuse the logic to not to re-enable or re-disable
> migration mechanisms. Code works the same way as before.
>=20
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2bd8cdf893..2adb2718c1 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -862,7 +862,9 @@ err_features:
>      return r;
>  }
> =20
> -static int vhost_migration_log(MemoryListener *listener, bool enable)
> +static int vhost_migration_log(MemoryListener *listener,
> +                               bool enable,
> +                               int (*device_cb)(struct vhost_dev *, bool=
))

Please document the argument. What is the callback function supposed to
do ("device_cb" is not descriptive so I'm not sure)?

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/OVhoACgkQnKSrs4Gr
c8gwwgf+I95GBsEKHODfWsFkV4okONNvzPrm37wdLDLPOul1sVnt6WLfrSCIsaMV
JOtZ9+/JvsQFtyPkRSK8+rZhnj9hCnPpDeyHgi7L4w46JZsJDlxJTbu0cGOmg7N7
M3b/q3g6WY3uH2vDG7s47bQbzT+cLO9VTRRiD8G7Vww4r9gG2i0KAtAcnohsfDTQ
jPi3NnuwisOT8xYnj7+av7mVKgT1QhGFgGXp03qASF+KyLT/SCh8h7fOgYo/vrDb
JzDowD77/K9l4bsGOvPi3bpIJu0VPPQ7aTVxWjALnBRIqCce8yeY5angbK+aUjPZ
GLHd2rLH3KnQlEclmuCx0N8nCCvc1Q==
=P6IF
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--

--===============8574866694185540185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8574866694185540185==--
