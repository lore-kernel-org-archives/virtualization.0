Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C2C433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:42:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55053239E5
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55053239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA51C86463;
	Tue,  8 Dec 2020 08:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HI0xB3nm1FL; Tue,  8 Dec 2020 08:42:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BAEA864C3;
	Tue,  8 Dec 2020 08:42:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A866C0FA7;
	Tue,  8 Dec 2020 08:42:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3CCEC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8FCCE203A2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnVKGwwkhW3s
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 4A3E720396
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:42:02 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id r5so16669826eda.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dv5042T5Xl5anFxys9y89AYgrw+q8hp4hTeeMVqbfNM=;
 b=Wff6CoaMW3uX4r9WwTxFp+jpDE9pAduxRRSz4rVxEnS3miF+JZ5aS9POcaEvPBDpQz
 xXbitemYl5dTVKfKNkNxEU7WDwvcrfENEAVtPFtR9Cn0auNaRG8YJ9LDw41E/bwIBDos
 no7fegFtVm8SeEp8tLDpXgwXQ2mKUfL1Zymw1sn3DINpWzHt4irS9t/LQ6zXzsxRjiYL
 ZXw+AP9aHRwBDaRb8jHEcqgoWOnUV5aJpV64PykkpG0XMVbj8bXQtwVmroIefb/pSfyO
 2NR0mGnXYp/Nm1p1ydo3umt/7Juo4vr31PatUjq6dSribOltlKSB8LIlq0LSOK758U/H
 3zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dv5042T5Xl5anFxys9y89AYgrw+q8hp4hTeeMVqbfNM=;
 b=JO9SfD5tejRTgkglQDf/qDFKG5Uu5wDCQwUTQZPJZSFA0sgCINc7v8iuKstNBJxHP8
 dGTZBf5oTytmgLdUUUT6vuZN/z9+FKS85p5s+SXyGxUcZCBLaGp2EzKT1koauUro+WYD
 J7zcU5jlGVJJmqB3RQCK8YtcjGxQimQwFl8q37PqAHXXWEsaxtkAQ37ry23tqq2LLj0r
 clW7OPK7iq8Un5LF/HX0Z+cpnbF8uT7K1KyQx5HldaDkwBry/k7DjwxWjNGVnlC5Eao7
 sXnghdsWfGAtjQHwjU0Y7N/s/w1WJtqAYnfnOTlyeZ7ZaqsuSC+9ViTyV0qKu9tDvwA6
 32Pw==
X-Gm-Message-State: AOAM531WRf0ELWRPbDyYw+FdRuY4AxTIifyf6MlX14qZ4VsWqjxRSIwH
 zX2nuxz8C8mGxcwr+M9yU5I=
X-Google-Smtp-Source: ABdhPJxKX9FUD+oYHW+oUA4G+bzORQxT3oENR+iOmlg23ZJuzgV75RiXV2XUS+CIPltJfjfZPeW9YQ==
X-Received: by 2002:a05:6402:a45:: with SMTP id
 bt5mr23987529edb.130.1607416920727; 
 Tue, 08 Dec 2020 00:42:00 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m1sm13292254ejg.41.2020.12.08.00.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:41:59 -0800 (PST)
Date: Tue, 8 Dec 2020 08:41:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 18/27] vhost: add vhost_vring_poll_rcu
Message-ID: <20201208084158.GU203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-19-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-19-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============0277814981316283725=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0277814981316283725==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sDhuxz86kt5qlkuV"
Content-Disposition: inline


--sDhuxz86kt5qlkuV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:56PM +0100, Eugenio P=E9rez wrote:
> @@ -83,6 +89,18 @@ void vhost_vring_set_notification_rcu(VhostShadowVirtq=
ueue *vq, bool enable)
>      smp_mb();
>  }
> =20
> +bool vhost_vring_poll_rcu(VhostShadowVirtqueue *vq)

A name like "more_used" is clearer than "poll".

--sDhuxz86kt5qlkuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PPFYACgkQnKSrs4Gr
c8i/SQf/TvTgWv3whWVp5Emvh9/XNPEraByggX/NHutQ/7KU68p2ij7mFjVhwXoA
S6Cga7m5aygc3dDUoTF2rsp1uhontJMnUxLtq7glV2eUFpg/DqxfwBjU9uAYziyo
yqr4PaBlhgqJbNO9lsLXpwHX+KZwGDDsm+eiAPgOsKVltCQaHMCE3LETr3MX6JwU
ZHwC9DSppMxi7LXWqiTiHMwP006UxKxQQQfHiUpYYkZQ2qBpNpGXfQoebtyDgbUm
/lb3vNSJzsqrusZvv7j1LMVXFjPnpGdsry9w9q+ia9B68VPFQJp9CYwJxVIBA3DS
mOsdXqFq6+bwjli4YUG16be6Oc3rOg==
=k8Qa
-----END PGP SIGNATURE-----

--sDhuxz86kt5qlkuV--

--===============0277814981316283725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0277814981316283725==--
