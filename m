Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42BCC77B7C
	for <virtualization@archiver.kernel.org>; Sat, 13 May 2023 10:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 252E140164;
	Sat, 13 May 2023 10:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 252E140164
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=U/h7XltH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cos_SsG678VA; Sat, 13 May 2023 10:12:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6CEC4400AB;
	Sat, 13 May 2023 10:12:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CEC4400AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16140C0037;
	Sat, 13 May 2023 10:12:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9872BC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 10:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5EB2A60F48
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 10:12:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EB2A60F48
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=U/h7XltH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8X4kGNMblAmd
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 10:12:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DCA160F65
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DCA160F65
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 10:12:00 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD49B2244D;
 Sat, 13 May 2023 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1683972717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSfp+2Xls3qr1gY7ds9zwXAoQlCLbbksQ7i/+fxkSoA=;
 b=U/h7XltHW4DV8TEZYRaU4YFBxlG48bIB1dBhJcmiTcl3dcAliMZcblOsMIjKKQ+A1uIcNs
 i0VYWLjcsvf3QE8CNHeBXHFoUElmqN4uwXJqf5zsoyDcFx9s9uYRmjenJgzORP6K614gJk
 6xIjSlYOm7AINS0vcbb8JjKUNnG6a94=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33F0D1343E;
 Sat, 13 May 2023 10:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XBfFCm1iX2StFAAAMHmgww
 (envelope-from <jgross@suse.com>); Sat, 13 May 2023 10:11:57 +0000
Message-ID: <9929cbe4-b39f-d93c-a68b-0907f442e3f5@suse.com>
Date: Sat, 13 May 2023 12:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] MAINTAINERS: Update maintainers for paravirt-ops
Content-Language: en-US
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, bp@suse.de,
 tglx@linutronix.de, kuba@kernel.org, davem@davemloft.net,
 richardcochran@gmail.com
References: <20230512164958.575174-1-srivatsa@csail.mit.edu>
In-Reply-To: <20230512164958.575174-1-srivatsa@csail.mit.edu>
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, vsirnapalli@vmware.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, akaher@vmware.com,
 amakhalov@vmware.com
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: multipart/mixed; boundary="===============3004998065046565214=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3004998065046565214==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gr1TJBX10xUsAAYc1jI0aa8g"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gr1TJBX10xUsAAYc1jI0aa8g
Content-Type: multipart/mixed; boundary="------------QV6g03q6BO9x5GtcOKuHP5vR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, bp@suse.de,
 tglx@linutronix.de, kuba@kernel.org, davem@davemloft.net,
 richardcochran@gmail.com
Cc: sdeep@vmware.com, amakhalov@vmware.com, akaher@vmware.com,
 vsirnapalli@vmware.com, pv-drivers@vmware.com,
 virtualization@lists.linux-foundation.org, x86@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <9929cbe4-b39f-d93c-a68b-0907f442e3f5@suse.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Update maintainers for paravirt-ops
References: <20230512164958.575174-1-srivatsa@csail.mit.edu>
In-Reply-To: <20230512164958.575174-1-srivatsa@csail.mit.edu>

--------------QV6g03q6BO9x5GtcOKuHP5vR
Content-Type: multipart/mixed; boundary="------------NqNlg21qQydtfdNH0NhWomd1"

--------------NqNlg21qQydtfdNH0NhWomd1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDUuMjMgMTg6NDksIFNyaXZhdHNhIFMuIEJoYXQgd3JvdGU6DQo+IEZyb206ICJT
cml2YXRzYSBTLiBCaGF0IChWTXdhcmUpIiA8c3JpdmF0c2FAY3NhaWwubWl0LmVkdT4NCj4g
DQo+IEkgaGF2ZSBkZWNpZGVkIHRvIGNoYW5nZSBlbXBsb3llcnMgYW5kIEknbSBub3Qgc3Vy
ZSBpZiBJJ2xsIGJlIGFibGUgdG8NCj4gc3BlbmQgYXMgbXVjaCB0aW1lIG9uIHRoZSBwYXJh
dmlydC1vcHMgc3Vic3lzdGVtIGdvaW5nIGZvcndhcmQuIFNvLCBJDQo+IHdvdWxkIGxpa2Ug
dG8gcmVtb3ZlIG15c2VsZiBmcm9tIHRoZSBtYWludGFpbmVyIHJvbGUgZm9yIHBhcmF2aXJ0
LW9wcy4NCj4gDQo+IFJlbW92ZSBTcml2YXRzYSBmcm9tIHRoZSBtYWludGFpbmVycyBlbnRy
eSBhbmQgYWRkIEFqYXkgS2FoZXIgYXMgYW4NCj4gYWRkaXRpb25hbCByZXZpZXdlciBmb3Ig
cGFyYXZpcnQtb3BzLiBBbHNvLCBhZGQgYW4gZW50cnkgdG8gQ1JFRElUUw0KPiBmb3IgU3Jp
dmF0c2EuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTcml2YXRzYSBTLiBCaGF0IChWTXdhcmUp
IDxzcml2YXRzYUBjc2FpbC5taXQuZWR1Pg0KPiBBY2tlZC1ieTogQWxleGV5IE1ha2hhbG92
IDxhbWFraGFsb3ZAdm13YXJlLmNvbT4NCj4gQWNrZWQtYnk6IEFqYXkgS2FoZXIgPGFrYWhl
ckB2bXdhcmUuY29tPg0KDQpBY2tlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KDQoNCkp1ZXJnZW4NCg0K
--------------NqNlg21qQydtfdNH0NhWomd1
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------NqNlg21qQydtfdNH0NhWomd1--

--------------QV6g03q6BO9x5GtcOKuHP5vR--

--------------gr1TJBX10xUsAAYc1jI0aa8g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmRfYmwFAwAAAAAACgkQsN6d1ii/Ey+D
Ggf/ex4s/Z90KedHZeWJ4xk7rBGR3MR0y+IRDnmOEpTS8RTlaXN7IFfZFS2dZwNPKJOdTb3HlvzA
z6YE4MzdNVJ6ezVLrIz6Aq3yPOy+pbOq4jY9wNsOgQFQJUDW2IuSWNasKE8FQhKs4LmMOxEYUqCl
LvQtSolI9jQyDKseDYZz/km14p0Y09hjzyXI5ZwZLJHeQgZw9ZC0Ocxqfp9oB4+N/Ts+4SqO5/xS
ep6sKqlfkDwjt4UcihZKNTaOqvaFY1IVusexeBXHdfoOrYXZ5/Fa6IQHlli3iigVmf+MirRcxIGo
KYNZ8jcWXLV0yD0mxhAO/EKFvzfmBPhJvd0XPuXcQQ==
=7vAh
-----END PGP SIGNATURE-----

--------------gr1TJBX10xUsAAYc1jI0aa8g--

--===============3004998065046565214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3004998065046565214==--
