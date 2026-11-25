Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634657;
	b=PlbQ54nU5JLTytzxrTOuOQtgmOgtPCOaEEeRgRfYc2q1PNC1w1dDh0mIlmGwOcMF43La
	 03Ug/4s0u9rJ3v04X+1Lz7I5ZTJHAjc9qOkjbDztNueT2TJNHp+0XBgxeOao2MA/cX+zQ
	 xfAgg60KZLQVsJrCvY7Nj+Z8NZvdPLC5Ql0lGIJKQjn0BU9MUHrdUxVDq7EWNupv2kvk9
	 gvd2HAXIq/6J/q4ljyPFP9bUt9MYA1Are9hCTrIKuQB8/nE++GaB6kOhs/EBy+wtEsFfa
	 Y7LGRq5zSIZKoC1z3NfBzEHNzPrHe76q/HLvjVtIbwYxgK7c/GggOpg19BjrwUFwLdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
	b=uus3ptEGCoIgIW4qFhte8nj5shwzWGR3umC+vaeJLKB86oAE0+YzEfQnWD83JPzVFZdN
	 qjVP2kk6wq3HiE0OydH16P2RRucz20iQMh59dbahw5GVJKDBZj/uI6Mx/yjcT4mZKOUmS
	 MzyOtcZihXiUYl8clCMeHL/Tc9H8gOql03iVx0hl4vaOpRvqyvNvKT4oV0JXnCyE+yKch
	 LUl8VMDd/RJD+G5PAGKOw7161Mv5wEuwvBu9m4BZh0Su8rYJ4iZ18nKGwFdguI2V8bKnT
	 FvwoQ2Ptt9n0foAHFRO7Uzo/o/r41QUp76qb7iLoBrOOZSzu19a8Gu1furUwFNGJS/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QUyf6Mwn;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48878606A680
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 19:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48878606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QUyf6Mwn
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so3290969b3a.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795634656; x=1796239456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
        b=QUyf6MwnyAFghQQnJcBb2epm0eAiEj2fbvcVO+upgH7Kmve7UqKULeuQ6r5qEy0O51
         8pJmCvf3qQQYT+lGs4HaTA/9ffn6laByrXnaGorGHDWbRlmW22NPVJFR0VyripR5sWi5
         ugj4xuNhR5Dju2G9RdSZwtOUdAO+nA0eIP+G7c90GLS8D0dcaJLuSDD/l1g3G9Fwr8Go
         cYJvFGjc7WJ1JtGqh/AGMqFy8JOTDB1EmzBijY4ccCSXETb12u9xl2luxW7AGa+ML4O1
         FdCeVVBzd/5fy2495znQH5MnslRHbq5y7xhxuvYEhd4qiWTHMd/OTRlGHcnE8crcHusc
         tUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634656; x=1796239456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
        b=I6GWsICC39iCCENEP8P2HdNxiywCz5Hv+ZJSo5Ruu35vw9wz2uzwHyje02Hfs6GuwQ
         DjaQv/zqN5hkddHOLvb7We2+v5UizyUFQ4HML/q2rzVCJ/PDh03llIpKvi/GIUwUy+u0
         Vbqq+OobQ9wwbG+O5r7b9bW7B0h5Oo2QybJNVh6ACQl+Nnk9KZtijKP4/PQPrwuWgnpF
         nyqNmiPCmdA9J6yIxGSimuxbb6b/mhP5DnbXyxWMKXvIM4Rl/SXPh/cgTzMZHw1Q7B9b
         qnf/fPUNS/x4M8UjyEuO9eqJQC62cKsMPs6BEegKZH6b4eSWMgzuciCPAqKiOd1UW6fN
         rgfw==
X-Forwarded-Encrypted: i=1; AL+hErHMtAOmyC34sFluhBxeT6h6SPwSMpHYptvrW9FaqBnQ7D2DKGQv1vUhlpUaXWc2j7B6OoAwmSYe6hUqrkLBcQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8igJSegfE8E1f6eON5DMPD6XIOICDycFg2w7anZOowxNaF3/uO
	qNeQDEhSBJcgHjYEIt94Z62lGKwhGgeyMt8cAqUWhsvF/Isa/xfT0FlUw/hN0ngfhg==
X-Gm-Gg: AZFdTZe7QOETVOQ1woVEm626mu/bWuKRveeWQitmri2oScExKL3LpbrYiRSf+A55Ocy
	omdsEFOueDqDMmRls07YnMkEVWVaiIFf2lwNC43JYXqUzF55aF2vVqoOEQShZLwzY4Gj0SL8JWG
	0PMPH4uxNaL2F5qlyx009PkBWZewGXcgCojt0h5PppsmDYTbUoBBLmcBnUeDiGh1QGtBZAP6sKl
	HlR2kbPWFIdSDSjeqEr0clZhWmREhaxerIdt7duOuQyaK6NF89WtLAHm09RQn6YRzdkjYOjnNCB
	x7pT3pXHbrwWRrJcKh8MTZ5kzh7fnrLPml60wmz0TzgYTVWT8CVujaTf7AxxgzMDlR4N+4hXb4r
	2aZQpTSPc/lrDHTTnRAU6HCJ73AG00mWXNUVzBsoOfjmJvtLwF4eAlqd2Zwv5HkITZRPYpDMU03
	hdoy/0Ya+3BFzjPKS3prBSWBFlB2isCxN6c4oUM8g08qyXkIgdOGV/QmDXxwSbdJM5+IqthAp7f
	ASe/PX4cH+8KnfaWH/vz/CKA15xETgZkhDj2EyM7NmEOY0lP6/b7xly7H1zsBJcqTqNNdcLqUnB
	5WkNWHxh5rq0VB/mZU/fWSqPDxVqIA11E2YfQmE2wwaFkmPlHF7mHG4y4Y1Xsg5h2VD5AnlIc8Y
	t1hxyE9UhKhxbpDTnGPzo5N0VfvbM7uyU2Y5/ys/fs5jHi3ahRzFB5zavIIb2McYZvqN2PRehAl
	t0w8UkhOojYg==
X-Received: by 2002:a05:6a00:a908:b0:886:773d:a6a with SMTP id d2e1a72fcca58-8c87c199463mr15925448b3a.28.1795634654761;
        Wed, 25 Nov 2026 11:24:14 -0800 (PST)
Received: from google.com (196.126.197.35.bc.googleusercontent.com. [35.197.126.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bc47sm9717494b3a.6.2026.11.25.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:24:13 -0800 (PST)
Date: Wed, 25 Nov 2026 11:24:10 -0800
From: Benson Leung <bleung@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>, David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev, Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	MPT-FusionLinux.pdl@broadcom.com,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org, Neill Kapron <nkapron@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org, Hans de Goede <hansg@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
	devel@lists.orangefs.org, Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v3 11/12] docs: ioctl-number: update platform entries
Message-ID: <awc12oWB5WDJi8XZ@google.com>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
 <20261125061340.3402300-12-rdunlap@infradead.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kk3dCghKBQNrocaf"
Content-Disposition: inline
In-Reply-To: <20261125061340.3402300-12-rdunlap@infradead.org>


--Kk3dCghKBQNrocaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:13:38PM -0800, Randy Dunlap wrote:
> Update the list of platform/ files where ioctls are defined and update
> the ranges of function numbers that are used.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org> # cros_ec

For cros_ec as well:

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
> v2: no change
> v3: rebase
>=20
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
>=20
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- linux-next-20261123.orig/Documentation/userspace-api/ioctl/ioctl-numb=
er.rst
> +++ linux-next-20261123/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -434,6 +434,7 @@ Code  Seq#    Include File
>  0xBA  00-0F  uapi/linux/liveupdate.h                                   P=
asha Tatashin
>                                                                         <=
mailto:pasha.tatashin@soleen.com>
>  0xC0  00-0F  linux/usb/iowarrior.h
> +0xC4  00-1F  platform/raspberrypi/vchiq-interface/vchiq_ioctl.h
>  0xCA  00-0F  uapi/misc/cxl.h                                           D=
ead since 6.15
>  0xCA  10-2F  uapi/misc/ocxl.h
>  0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h                                D=
ead since 6.15
> @@ -446,7 +447,7 @@ Code  Seq#    Include File
>  0xDD  00-3F                                                            Z=
FCP device driver see drivers/s390/scsi/
>                                                                         <=
mailto:aherrman@de.ibm.com>
>  0xE5  00-3F  linux/fuse.h
> -0xEC  00-01  linux/platform_data/cros_ec_chardev.h                     C=
hromeOS EC driver
> +0xEC  00-02  linux/platform_data/cros_ec_chardev.h                     C=
hromeOS EC driver
>  0xEE  00-09  uapi/linux/pfrut.h                                        P=
latform Firmware Runtime Update and Telemetry
>  0xEF  00-0F  uapi/linux/ntfs.h                                         N=
TFS
>  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       s=
isfb

--Kk3dCghKBQNrocaf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCawc12gAKCRBzbaomhzOw
wuvSAP9FFr45oXAv5Psc3n5xsSYyPFouusI/XwRnWy3tYxQspAD+KIeOTWQfcOeC
TWeqyAANog5rg68r7xNPxeH8I/R6xAQ=
=Fk2v
-----END PGP SIGNATURE-----

--Kk3dCghKBQNrocaf--
