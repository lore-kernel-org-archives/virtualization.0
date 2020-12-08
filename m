Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738CBC4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 07:21:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF63023A6A
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 07:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF63023A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 995B087B13;
	Tue,  8 Dec 2020 07:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lsVV97TKeHxe; Tue,  8 Dec 2020 07:21:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 394BF87AD5;
	Tue,  8 Dec 2020 07:21:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18D4DC0893;
	Tue,  8 Dec 2020 07:21:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51D75C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 34FBC877D5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XgpxNd1+1DWd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C5AAD877BA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:20:55 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id f23so23212220ejk.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 23:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/h2yFiiCakJYZ7C4aOv6n4E6nxXfNP5Jigi5iFmZn4o=;
 b=g9k9EHyyE1hyh4GREJGgliFEA0ACDBQoilZma7WSGUbkrSU12XsZRINIy0PAa2YAbm
 8jIwIAWXmroD/yp7Wlkwg7/4zkF7ReIlTm8yY6vr93wZHRzKNagE5iTQRjbWaWGsmgCx
 IhMXTNfbWrw66OJZzE7QgPlmBO9LxJ31OfPy/jG0lWT06o/3FHubxQoiOaj+M9r9R+q6
 Oi6z+6pP4X6slMLeu0dZCJV4XZ1RrvNaA4yLihSzjdJJJCRmjl02MRaKgVxzDTZbsy4x
 B1N/VhOh/ToqToiS7YxKuFtp5CiTasuTKJTuDUWDgnEkCZTt+4plmE15QfzZ+X1oPCEI
 NBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/h2yFiiCakJYZ7C4aOv6n4E6nxXfNP5Jigi5iFmZn4o=;
 b=tm+5QzEXiF/0MEtwDhrnUqvQNrths8eufWUQP46l7hv5u3slKyXukrx6mjpX0aBsJY
 hg/Z6WDevXSRXwl/IB3Q+88hsCOxuAUrjXgJvN6LalpZuhDEeqBmuYvyF43pbBa/Zfy4
 vLJXbNNJZQ09EelvPb57ciJlCkTDTvwxcQ9GfbRal0gOdYdIQriYeSaMDjVIB5kaMrYz
 qxyTZpAVTHTa3eY6wIYbwU6RT43UNJPP01vVyN81d+iYzNKJNAZdE6A9CFnIZaJ53WOI
 gBQPcPeYorme3ArBJSXrpoV3JrGRo9jvatG0oHwt5M8hoJON/3IuamRWFZYz5UwayNiK
 63Qg==
X-Gm-Message-State: AOAM531OJawxRqA2hhugol+skZQqnctlF1is+owdvzd20m2tDt+Du1pb
 AdeyJDr0/csTloy4QYc9xgs=
X-Google-Smtp-Source: ABdhPJz/JnR5N/NM+ralFbvuipmGWLzBttoSpakMqOYFYSR5Rk/CB0G8LXhZRJBRyhaegtzdavo3sA==
X-Received: by 2002:a17:907:2108:: with SMTP id
 qn8mr22101643ejb.127.1607412054128; 
 Mon, 07 Dec 2020 23:20:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id rl7sm13489164ejb.107.2020.12.07.23.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 23:20:52 -0800 (PST)
Date: Tue, 8 Dec 2020 07:20:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 08/27] vhost: Add a flag for software assisted Live
 Migration
Message-ID: <20201208072051.GO203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-9-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-9-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============0673369048970774659=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0673369048970774659==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="keoAwTxaagou87Dg"
Content-Disposition: inline


--keoAwTxaagou87Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:46PM +0100, Eugenio P=E9rez wrote:
> @@ -1571,6 +1577,13 @@ void vhost_dev_disable_notifiers(struct vhost_dev =
*hdev, VirtIODevice *vdev)
>      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>      int i, r;
> =20
> +    if (hdev->sw_lm_enabled) {
> +        /* We've been called after migration is completed, so no need to
> +           disable it again
> +        */
> +        return;
> +    }
> +
>      for (i =3D 0; i < hdev->nvqs; ++i) {
>          r =3D virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), hdev->vq_in=
dex + i,
>                                           false);

What is the purpose of this?

--keoAwTxaagou87Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PKVMACgkQnKSrs4Gr
c8g4MQgAuHhrnsIoIcFJBG8vM52Q4JFZAfZXRtw2rZr14BSUaoKLRLLesEpWWkwy
xguwLpUJihF1okcf7wSAioIiVkaWPy/+z2Q2Yus4JQGPpZEYCfficmeOVnb1Whxr
6BJKaDQdNEjd7rpKiaegscT9iIyIOOGZErGBZTVBCttrBDbmoYtdtwrvTr0m97Tn
+0O56WNnmRVHZbbFlYpDCp61oH9VQSQbqsRp4nshZVwiaRHptw5PotRSYa9v+SUj
gaJj0DyxrTaOo/PZRzJgfH6ByiePKWy2y41ZVFIeV64aNJWNfPdlYcXgnAyBk3gF
s1qYSxylD703VnKvaWBQTXO8PnJikA==
=1YKg
-----END PGP SIGNATURE-----

--keoAwTxaagou87Dg--

--===============0673369048970774659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0673369048970774659==--
