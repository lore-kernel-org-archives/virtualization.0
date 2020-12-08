Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56DDC4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:50:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F7B23A79
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F7B23A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C63C586644;
	Tue,  8 Dec 2020 08:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJuX0ElSHalD; Tue,  8 Dec 2020 08:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BE82864B5;
	Tue,  8 Dec 2020 08:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58EC0C0893;
	Tue,  8 Dec 2020 08:50:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAD5CC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B524C8720A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNpSOnbljMLT
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:50:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2DDF2871AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:50:13 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id jx16so23476594ejb.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TZXwYDaCWS7e1DN18P4hTw8qRki8SYJYAh/bIEvt7VA=;
 b=FZ0lHPANfEWsj+/iVtzHykLTQO6ijRLMLun67MC83GxuH1p2GZvrYjVFI3LNftNYmi
 /WF/Ppj7Wq5wn6x5qlhZ7poOpmvIzR9WmdgY8pxNF30wGY0Co7IAbS2881d+bH0E6Byn
 bpioRfSGZZ4HMfmUGGDYIBx8I9lWUbAfa90kVnGyoX+TsCLBzuOSbLyiDTiWf1LMert8
 UgTYEKxN95dU+dYig9SnYr/1zjEk7X1WFDFui6Zn9YsLNmnCV9FZ9w0tvEVe2ihnVf8w
 L9O0G22F2V+wSKewS6KowfEZDIuF/m1OLAcCf+VIX9oZBeQmp9GyjwPdaUayPjCGVMO+
 P38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TZXwYDaCWS7e1DN18P4hTw8qRki8SYJYAh/bIEvt7VA=;
 b=P3TVnQIIlvXzANOqWd+QuvIMvjQDxzqrjBNPUTyJOP7s3UxUTTvTIOpWBfQvXCUuuq
 hgy9MUDAcLMZN/Ug/lBCm4qIpUmN6cfHCLcm8LTa4uAvdiha0ustSzaWsCIbmpl2J+IP
 udwuVSUJYOcmB0fFdgVEQiGiHvqGvh4L00P+GOw9VycuPqUKv7F36aYh1BEIIpe6K2Nh
 rNYomMYuTZNTfoO3fmoN+LmXhtdK7rC9OEK9JU2aLbbxhQP8p0qriEu3r4jtsnSaStQX
 d7gBCGZo5WabeC4jBaeaM1rXaZso0x8rs5vksxDKnzKtnT2i/WspbZg89YTIcgnbtrdt
 XlFA==
X-Gm-Message-State: AOAM5317XPX0G/0H9grptibu3C1PzN8EfJt8+xOyUciVnyvpwvkNSPzc
 sAopnMuav9ammLoGJ/k6pws=
X-Google-Smtp-Source: ABdhPJww+kwZb8018JvYoa53FIBJf92vPUO/fyV4DEOGl5s9UG9EkjlxM/dxQWfVsgIsKRCS5yIpUg==
X-Received: by 2002:a17:906:3c11:: with SMTP id
 h17mr21899491ejg.20.1607417411619; 
 Tue, 08 Dec 2020 00:50:11 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d6sm14878522ejy.114.2020.12.08.00.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:50:10 -0800 (PST)
Date: Tue, 8 Dec 2020 08:50:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 20/27] vhost: Return used buffers
Message-ID: <20201208085009.GV203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-21-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-21-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============0583181825994252544=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0583181825994252544==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YnIutncTLXsDZs5t"
Content-Disposition: inline


--YnIutncTLXsDZs5t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:58PM +0100, Eugenio P=E9rez wrote:
> @@ -1028,6 +1061,7 @@ static int vhost_sw_live_migration_start(struct vho=
st_dev *dev)
> =20
>      for (idx =3D 0; idx < dev->nvqs; ++idx) {
>          struct vhost_virtqueue *vq =3D &dev->vqs[idx];
> +        unsigned num =3D virtio_queue_get_num(dev->vdev, idx);
>          struct vhost_vring_addr addr =3D {
>              .index =3D idx,
>          };
> @@ -1044,6 +1078,12 @@ static int vhost_sw_live_migration_start(struct vh=
ost_dev *dev)
>          r =3D dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
>          assert(r =3D=3D 0);
> =20
> +        r =3D vhost_backend_update_device_iotlb(dev, addr.used_user_addr,
> +                                              addr.used_user_addr,
> +                                              sizeof(vring_used_elem_t) =
* num,
> +                                              IOMMU_RW);

I don't remember seeing iotlb setup for the rest of the vring or guest
memory. Maybe this should go into a single patch so it's easy to review
the iova space layout.

--YnIutncTLXsDZs5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PPkEACgkQnKSrs4Gr
c8jbGwf+OqBpKYq3vRs1xwb03191eAU1RZXGSRe283/ocJlVX8EMuoRMZPbbEXgt
+OqCILt/QQuvQloLfm23ggS9XXUgKfQSPG16bFM0RE6j5lDUqDWESbduxFWxWl5k
YAZhTPElTlaGeJbRpW4Ls2bqKSIkd77wtZu+AdPGGfr6IiZxE2rC3Rut3qhzl6A4
C2dhtR3TPweeG5bL8ls6tv3t9+J0n4tap8b93aX920+9ksgj1uYEZNjRk6jEWiMG
2vy5eEgE/SJcaNSFafSgYQGGscP3nAHCcwgkUs7MjiGyVXiMNi0xDGunPdQ1R/f/
/Sto7Mj12OlDF0kbMRUuNi5FfF3wOA==
=vcmP
-----END PGP SIGNATURE-----

--YnIutncTLXsDZs5t--

--===============0583181825994252544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0583181825994252544==--
