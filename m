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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BDC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:52:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D857823884
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D857823884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8EB6487933;
	Mon,  7 Dec 2020 16:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2xpxLNxthB9C; Mon,  7 Dec 2020 16:52:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDAEF87881;
	Mon,  7 Dec 2020 16:52:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD910C0FA7;
	Mon,  7 Dec 2020 16:52:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F82EC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2582687634
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIyUmMVwGRgN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:52:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DF73D875F7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:52:19 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id x16so20442356ejj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OTQRBjUe2TNjYMgJefl7n0HpBavaiUEtwmxJsr1/2t4=;
 b=erKmXltJIFGXdOQcph/EmLbnMRY6RChItOwpRyiu8mFYM+wjLN9CHS8NfD8l6oT6qJ
 1f/szmE8g+MJAyGMfg78p8iPicMlWeScTuFEWULsmGKKsuAlilIgx6fw334H1Q6/1R2r
 qFRDGMSE6bgWNv5M5iOHiqZOmFzj+zS2s/4VInI1sJuZOADPtUs8x7MlwhR1+oGPruEG
 ydJKuWQ1H76nsoemtOULbMSmbVQAUW1rsuwvKPl4VoUrKRtyPt1353Tsr2CsusdN1oij
 t/UNHMJUgc6F8336mbycNpSenKA4XbUZoHoG4eaWiwmHcftSFe8ZoQZgiCadTLdwYC3w
 L1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OTQRBjUe2TNjYMgJefl7n0HpBavaiUEtwmxJsr1/2t4=;
 b=UsR/qE9VQ22dusCySk+7bPlvSPoAlBelT97XUO5Q4av+KytLXlPDR5ulOHXJ8BaUpu
 ttO7wfRQRpf/SH890AJymQ34AnxiEVSRzTnyMAcrWz9XyUQxJ5J3tWDzyeDddVwVASRi
 YT36cqgzCyZHGNE+91oYt/W8MX+s6441RVu5BCQM539ijK7VZ3kyhBstSetWIKFSaTLp
 QZAUDgAUwhLlbAjxzKQSw/jMnDNqmbrx9MMFy83YuG98Cd7Ber4LgmjNVGF5VjoAj9qr
 KInzKoSZQY6NM3vQRotoLtMaIrrhndY5BKsr99F1v8rrdebyQs2PElsvLgt5zz/+IRvj
 kkNg==
X-Gm-Message-State: AOAM530/4vPMCf256EnoUQky6eqB3lkC7U8mcT237U8IU3aUywAgrwhu
 yKipNPHCpaRJ/pCEv05PKiA=
X-Google-Smtp-Source: ABdhPJycsLY1gSAtaotTfUaJl7iKx3GhozpQNix9ydMBC5YVDHoyAJwcCg7JB0Eipy1M7eJ+9OyCCg==
X-Received: by 2002:a17:907:28d4:: with SMTP id
 en20mr19944431ejc.196.1607359938454; 
 Mon, 07 Dec 2020 08:52:18 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q4sm10641523ejc.78.2020.12.07.08.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 08:52:17 -0800 (PST)
Date: Mon, 7 Dec 2020 16:52:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 05/27] vhost: Add hdev->dev.sw_lm_vq_handler
Message-ID: <20201207165216.GL203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-6-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-6-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4993227844110866042=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4993227844110866042==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:43PM +0100, Eugenio P=E9rez wrote:
> Only virtio-net honors it.
>=20
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  include/hw/virtio/vhost.h |  1 +
>  hw/net/virtio-net.c       | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 4a8bc75415..b5b7496537 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -83,6 +83,7 @@ struct vhost_dev {
>      bool started;
>      bool log_enabled;
>      uint64_t log_size;
> +    VirtIOHandleOutput sw_lm_vq_handler;

sw =3D=3D software?
lm =3D=3D live migration?

Maybe there is a name that is clearer. What are these virtqueues called?
Shadow vqs? Logged vqs?

Live migration is a feature that uses dirty memory logging, but other
features may use dirty memory logging too. The name should probably not
be associated with live migration.

>      Error *migration_blocker;
>      const VhostOps *vhost_ops;
>      void *opaque;
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9179013ac4..9a69ae3598 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2628,24 +2628,32 @@ static void virtio_net_tx_bh(void *opaque)
>      }
>  }
> =20
> -static void virtio_net_add_queue(VirtIONet *n, int index)
> +static void virtio_net_add_queue(VirtIONet *n, int index,
> +                                 VirtIOHandleOutput custom_handler)
>  {

We talked about the possibility of moving this into the generic vhost
code so that devices don't need to be modified. It would be nice to hide
this feature inside vhost.

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/OXb8ACgkQnKSrs4Gr
c8h0zgf/Y8KuZmHAiJe/VBJicMVsGgLkqfkqKp7+bL8u8nU75Wm24ECd47sAbvWK
q/BQs7t9VxQ0KBH8DJBGviwxG4bfoAtzXpSKgHRgbvd0AWHqJqfbEcKP+yZ0mKwB
uSAsQqNU/K9DxvNiJSzzklUvKmvKPrWXwgWsP2jRKOTAxn2nvNrCO+X9sAveTmEk
ZMfFOsHVNVxc4nJIwRsySTnpUz4ADJvzrhGk8cvjIIg/9Gq28EsYiMLWhtQymrj6
iEIZnfg5REWv/w3KzvwqVBaBqVF/QkFk0w8naAuT+KHbr+fKZLtMVC6ebY44vqZN
+iQr7fQg3dfy8ba7WFxyYHnVGmZMEQ==
=GegK
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--

--===============4993227844110866042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4993227844110866042==--
