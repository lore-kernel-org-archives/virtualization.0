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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA0EC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:07:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E890B23741
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E890B23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6F22E2E210;
	Mon,  7 Dec 2020 16:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24kazRDEJiN5; Mon,  7 Dec 2020 16:07:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C07E42E16B;
	Mon,  7 Dec 2020 16:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B25A5C0893;
	Mon,  7 Dec 2020 16:07:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5BF4C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4C8C87622
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c8L6gGL786Gx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:07:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 586B9875BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:07:34 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id bo9so20148425ejb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WM/4xKSlXYVQWjEHfbWD8YX/luYlEiJYgCc/oLAT72M=;
 b=qKgDPJDPA18nffgQ211xSgkPcAycCzVVcqW7ZbuMWzxFCl++LQpCcZ0C8J9T4DBrb6
 p2DyTpTDyOyGEmGwTleB4Bx0L0GLAX5iez4RwZzXoWT1pdfjAq/co6NNNvtB7OLGfOKI
 1uX0OOQSymZjTgwxQdxqYq/qFmw5H3489UCNx2Z2BRcY0cSZQVaZhYcWNkZ9TAhWc1K5
 QuRFZclmSDh7OabGFcl1oAqmMQL9EuZqUQ6WGjkmo192doqD6wBVw4b1H/xZ3ctMDW7n
 OWOuLFt2ht5DYzcpHSswwkatv6rFQKTbuggtu44/Ptnhuxws2wgN22HqGQOxjgpyOA8u
 lW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WM/4xKSlXYVQWjEHfbWD8YX/luYlEiJYgCc/oLAT72M=;
 b=OOWVvugoOIMzwUGN84DdDget/FBFrDr0OizzA9hnzbtd//AD/4wqorpdfdfEB8YYLp
 UQTTb9R5EB2v25k17hKtpBRireo8L8EZYXY5rJVopOQdbq2uxxKeKB50YgtbAktp8oBY
 HLqEtQ7DJSbvdmqTccdq7GceD9m0qehX/t2hv+5lCqx8VcuL3RwVp6I/di8C25fmdsxj
 5wq4SweqFDw+giXobo0Y9rDu2Wmwg3h6gEWqz7paq+Zx05elRmPUEb6TEJJagOkZ1SBt
 9C67oMEBtoOlIjVNwX7tQsfisj7B/y+czXe0k6jj2tGApVo73iD7XDCoYI4tyVBJNpnr
 sjog==
X-Gm-Message-State: AOAM530agWbHTAnqV5sb33jB8hyXdzI7ftNEhZbkflwP4Y22PHcoGBz4
 TrX3JPYe8XOxWv897OliknI=
X-Google-Smtp-Source: ABdhPJzwCMTqsxTqqO4VotBrTjalTBZGvqcXJVYEDpt0nKWW3uuKzpE893tD69cUr19XrpsPZQAWzg==
X-Received: by 2002:a17:906:c1c6:: with SMTP id
 bw6mr20020182ejb.199.1607357252890; 
 Mon, 07 Dec 2020 08:07:32 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e21sm13941813edv.96.2020.12.07.08.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 08:07:31 -0800 (PST)
Date: Mon, 7 Dec 2020 16:07:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: Re: [PATCH] vhost scsi: fix error return code in
 vhost_scsi_set_endpoint()
Message-ID: <20201207160730.GI203660@stefanha-x1.localdomain>
References: <1607071411-33484-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1607071411-33484-1-git-send-email-zhangchangzhong@huawei.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============3077436698870256802=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3077436698870256802==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2020 at 04:43:30PM +0800, Zhang Changzhong wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> ---
>  drivers/vhost/scsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/OU0IACgkQnKSrs4Gr
c8gAeQf+MEz4NCEr2G4ywg8AHw7rf050IHblQEjkZBazrQQ706YvtfGZssxTae9f
psRCnNLjHsZ2mFYWbtyPqI91egzIyJTNuu7odm3ILPfrXA7Lv8Uo2vZ9TNMN4+ZG
L060RA9br9G2+DYTn7yC6M9B1a6mKdDS68rzDQSMAHns29WLSoRLYXIJBsoxd/sv
Q9hxE1Sns6QVw/zOGCD9bre1pEWU2der61Qa4SfblpZgY9c9hXYNeKztrnznYufl
TsFTa02ME99jRC71/mG/qoT+Nh1OEtpcJ6ZqkU2lHEaYAng800NpNTIOaqEMmEZV
DfiQZ9kcrCzp+QXcuRpFFk/5rcaGdg==
=tZ45
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--

--===============3077436698870256802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3077436698870256802==--
