Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FDDC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 23:57:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C8F610A4
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 23:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56C8F610A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16F4460668;
	Thu, 28 Oct 2021 23:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2GLIuyMETE1i; Thu, 28 Oct 2021 23:57:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E61A6063B;
	Thu, 28 Oct 2021 23:57:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52B9EC0019;
	Thu, 28 Oct 2021 23:57:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C4A3C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 23:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6393640621
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 23:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canb.auug.org.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3_QAQJ-lZ6_H
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 23:57:34 +0000 (UTC)
X-Greylist: delayed 00:05:44 by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BB6040620
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 23:57:33 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HgMlw4DB8z4xYy;
 Fri, 29 Oct 2021 10:51:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
 s=201702; t=1635465102;
 bh=BBq1Yspji0vJm9R7zIGdVaVx2DU7+FD6B6UrqSLpbPg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YD23+cizlmSgewjdmhU7noKEZETmDps4i3fEy4IW/h0x6VStpgpxY1SvfXRmhLtgC
 R73C2AZR/Zrym+A1IeFvOgQbitR7EGkFxQf2ORBS1apsKDtBt+EQj4fHovArvkT+kf
 nxR1Bm0IAGIfvB3B4H1UIssoHggQZvP8YWpJU7ptHk1b99ZDJ8zxYcQOkZ6KEP84P1
 vmYaqwCIDQ6FGWqA0g1ZhEHfTSfvaWL9UZW2oNOXFweire0ERYucF3+NhB82qjA5Id
 NJ/2F+0+PVhmuDV3uC5qLEVXNIGPdBL1KvnMm3S66zK15p/TeHFQGImQ+t3EncV3RW
 XO4GmcNhtz05g==
Date: Fri, 29 Oct 2021 10:51:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211029105139.1194bb7f@canb.auug.org.au>
In-Reply-To: <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <CAPcyv4iEt78-XSsKjTWcpy71zaduXyyigTro6f3fmRqqFOG98Q@mail.gmail.com>
MIME-Version: 1.0
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============3849330128532653743=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3849330128532653743==
Content-Type: multipart/signed; boundary="Sig_/SsoWmhnAUHONY.PedkLs.lt";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/SsoWmhnAUHONY.PedkLs.lt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, 27 Oct 2021 13:46:31 -0700 Dan Williams <dan.j.williams@intel.com> =
wrote:
>
> My merge resolution is here [1]. Christoph, please have a look. The
> rebase and the merge result are both passing my test and I'm now going
> to review the individual patches. However, while I do that and collect
> acks from DM and EROFS folks, I want to give Stephen a heads up that
> this is coming. Primarily I want to see if someone sees a better
> strategy to merge this, please let me know, but if not I plan to walk
> Stephen and Linus through the resolution.

It doesn't look to bad to me (however it is a bit late in the cycle :-(
).  Once you are happy, just put it in your tree (some of the conflicts
are against the current -rc3 based version of your tree anyway) and I
will cope with it on Monday.

You could do a test merge against next-<date>^^ (that leaves out
Andrew's patch series) and if you think there is anything tricky please
send me a "git diff-tree --cc HEAD" after you have resolved the
conflicts to your satisfaction and committed the test merge or just
point me at the test merge in a tree somewhere (like this one).

--=20
Cheers,
Stephen Rothwell

--Sig_/SsoWmhnAUHONY.PedkLs.lt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmF7N4sACgkQAVBC80lX
0Gxw2gf/TsRhRytrNIQkXZwCrlHR+hjJ895jJhg4Hp+ig2QzzYRjM/GrSPzXAXF3
s5SscPXv7egnMo+fHKY9d/CscYD6kDg4FtBuvoJqx/ApGN4PQLme5S3KbxrNRgd2
2vpBRjXN+26toUw0W2PK1gzHRJXaB6waOFbA6crbuWU1BDzVZoeRHfjKtlBMax7Q
g6pzcvDzs7ia50KBJvi6hNkxCy7xuNAsLlm96930v/bLvnUYo6dOGrzZ6/Kjzjcw
LpWIuVQGxkzBiILaGSiHuNfzZEbSvoSXMfMRJ5KBpAhB8M1dhuyqP4QBWMwe7+Tn
Oo6WLOwKx89LL+uStt4yje6yx9483w==
=+eTD
-----END PGP SIGNATURE-----

--Sig_/SsoWmhnAUHONY.PedkLs.lt--

--===============3849330128532653743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3849330128532653743==--
