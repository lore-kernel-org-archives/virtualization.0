Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AFAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 09:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7EE540357;
	Tue, 23 Nov 2021 09:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxOYvsYRtPuw; Tue, 23 Nov 2021 09:52:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67FD5402B9;
	Tue, 23 Nov 2021 09:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE9BC002E;
	Tue, 23 Nov 2021 09:52:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3DC7C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A5EF40197
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07LMj6B03gq0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B323640019
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:52:08 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF49C2171F;
 Tue, 23 Nov 2021 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1637661125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajOZHsKp7ZQkVUpCLoKZo/kkMAi5Cu53dgZV5A7a6to=;
 b=qC2kKbqGgqbDe9Rhp66PjMM8guhttStCcfNu5XIpe7UdHE//SSTEJ4kUmVfrR7At7gKKWE
 7loxzVt5IadV1zXJPmNFlQcPaKwhPxcuJo0kJ5grYdn56lJ6jx+qq9ddQDuG9fM6RdXzxp
 yySGZg+L4+UensBEtWdLhChM/axBnDU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98F4B13DBE;
 Tue, 23 Nov 2021 09:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A+8OJMW5nGEUIgAAMHmgww
 (envelope-from <jgross@suse.com>); Tue, 23 Nov 2021 09:52:05 +0000
Subject: Re: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
To: Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
 <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
 <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
Message-ID: <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>
Date: Tue, 23 Nov 2021 10:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============6858645738247222272=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6858645738247222272==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BIDBiEAw5kGt42EalW9E6rbMZ9WVUvDaM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BIDBiEAw5kGt42EalW9E6rbMZ9WVUvDaM
Content-Type: multipart/mixed; boundary="VCZwzJmkzXEcoQD7Yz1ualSyyA2nj2Ayx";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Deep Shah <sdeep@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>
Message-ID: <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>
Subject: Re: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
 <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
 <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
In-Reply-To: <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>

--VCZwzJmkzXEcoQD7Yz1ualSyyA2nj2Ayx
Content-Type: multipart/mixed;
 boundary="------------6E2EE9EB86E99F5290F1B256"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6E2EE9EB86E99F5290F1B256
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 23.11.21 10:29, Jan Beulich wrote:
> On 05.10.2021 09:43, Juergen Gross wrote:
>> On 30.09.21 14:40, Jan Beulich via Virtualization wrote:
>>> While using a plain (constant) address works, its use needlessly invo=
kes
>>> a SIB addressing mode, making every call site one byte larger than
>>> necessary. Instead of using an "i" constraint with address-of operato=
r
>>> and a 'c' operand modifier, simply use an ordinary "m" constraint, wh=
ich
>>> the 64-bit compiler will translate to %rip-relative addressing. This =
way
>>> we also tell the compiler the truth about operand usage - the memory
>>> location gets actually read, after all.
>>>
>>> 32-bit code generation is unaffected by the change.
>>>
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
>=20
> Thanks. I notice this wasn't part of your 5.16-rc1 pull request, nor
> did it make it into Linus'es tree via any other route. May I ask what
> the plans here are?

I CC-ed you on the related mail I sent to the x86 maintainers:

"Re: Which tree for paravirt related patches?" on Nov 4th, and Thomas
Gleixner promised to look at your patch. Adding him to this response
again in order to remind him.


Juergen

--------------6E2EE9EB86E99F5290F1B256
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------6E2EE9EB86E99F5290F1B256--

--VCZwzJmkzXEcoQD7Yz1ualSyyA2nj2Ayx--

--BIDBiEAw5kGt42EalW9E6rbMZ9WVUvDaM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmGcucUFAwAAAAAACgkQsN6d1ii/Ey/R
7QgAjVvXxJGGW+wU/AocO5HJgAKtVSwHAHfoQHXdHuJKMr76/AEx3YRiNskLsqk/47CtJ/04nTP0
lbVqKctNAqq7K3IJMGKITcE2j9FUfCFcsWjwlTyrBhWl49VR/6sbB7VMwamRl0qmqTc0NlhljTWe
pkIvR3RADlCgYfre3RlVq2svBVdeE+4UtumSQdx5BIZV26faKP1BkQqA5EjBWs2Co1oBqE3N///j
gxJHy4kGR2D9p9t1KlLyxnqgT+vLlOA7s/dEloHt5HMdEmYejHel1pm4LQjOYPH1/ve2zCgoTa8r
sCWN55xsBxwDpJ2qkcgmWMuPaXWM3a9Pm9tpA5Zy4A==
=TwgY
-----END PGP SIGNATURE-----

--BIDBiEAw5kGt42EalW9E6rbMZ9WVUvDaM--

--===============6858645738247222272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6858645738247222272==--
