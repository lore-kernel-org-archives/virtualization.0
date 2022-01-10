Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C8C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 13:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E905980C50;
	Mon, 10 Jan 2022 13:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6bOcOn07a6Z; Mon, 10 Jan 2022 13:26:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9966880C3A;
	Mon, 10 Jan 2022 13:26:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59304C002F;
	Mon, 10 Jan 2022 13:26:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A8CAC001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 13:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47FC3405FA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 13:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TEzomz5ujBxU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 13:26:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F39D5404B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 13:26:21 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4480B1F393;
 Mon, 10 Jan 2022 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641821179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ftxPvsH76ioXgVxK0RuQ2MYRZhERKsXUjEq/6uad5p0=;
 b=Hc0Aw7SyPuCEr9lTcpX3kY3HvnqDItKmAsdn5uNZRrOrk09w4qdatULzMvg6OpFMrBc3db
 a9mBcN+qykn//0ZN4P5p7MC5Ix6aq18eWGCQJ7xO4TrBrYwDsilp36rXFnWLW2T23TLkGD
 xsElvUyoLx23d+TLVryVmnONMgvFgEI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DC3313AFD;
 Mon, 10 Jan 2022 13:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i7fgBfsz3GEvNgAAMHmgww
 (envelope-from <jgross@suse.com>); Mon, 10 Jan 2022 13:26:19 +0000
Subject: Re: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
To: Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
 <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
 <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
 <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>
Message-ID: <46270efe-df82-8d95-8b6b-4603f5be7b60@suse.com>
Date: Mon, 10 Jan 2022 14:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============0233113070434271099=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0233113070434271099==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dL7UcAgxXI3Idr5fqaBSKODHC8rWP2kta"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dL7UcAgxXI3Idr5fqaBSKODHC8rWP2kta
Content-Type: multipart/mixed; boundary="JSi4spfwlIzt3bFOiIyGqM2DyNMIa1uEU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "VMware, Inc." <pv-drivers@vmware.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 X86 ML <x86@kernel.org>
Message-ID: <46270efe-df82-8d95-8b6b-4603f5be7b60@suse.com>
Subject: Re: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
 <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
 <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
 <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>
In-Reply-To: <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>

--JSi4spfwlIzt3bFOiIyGqM2DyNMIa1uEU
Content-Type: multipart/mixed;
 boundary="------------0E23FCBBCD10651422B7DDF8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0E23FCBBCD10651422B7DDF8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 23.11.21 10:52, Juergen Gross via Virtualization wrote:
> On 23.11.21 10:29, Jan Beulich wrote:
>> On 05.10.2021 09:43, Juergen Gross wrote:
>>> On 30.09.21 14:40, Jan Beulich via Virtualization wrote:
>>>> While using a plain (constant) address works, its use needlessly=20
>>>> invokes
>>>> a SIB addressing mode, making every call site one byte larger than
>>>> necessary. Instead of using an "i" constraint with address-of operat=
or
>>>> and a 'c' operand modifier, simply use an ordinary "m" constraint,=20
>>>> which
>>>> the 64-bit compiler will translate to %rip-relative addressing. This=
=20
>>>> way
>>>> we also tell the compiler the truth about operand usage - the memory=

>>>> location gets actually read, after all.
>>>>
>>>> 32-bit code generation is unaffected by the change.
>>>>
>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>
>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>
>> Thanks. I notice this wasn't part of your 5.16-rc1 pull request, nor
>> did it make it into Linus'es tree via any other route. May I ask what
>> the plans here are?
>=20
> I CC-ed you on the related mail I sent to the x86 maintainers:
>=20
> "Re: Which tree for paravirt related patches?" on Nov 4th, and Thomas
> Gleixner promised to look at your patch. Adding him to this response
> again in order to remind him.

Thomas, another ping. Didn't you want to take this patch more than a
month ago? Cc-ing the other x86 maintainers, too.


Juergen

--------------0E23FCBBCD10651422B7DDF8
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

--------------0E23FCBBCD10651422B7DDF8--

--JSi4spfwlIzt3bFOiIyGqM2DyNMIa1uEU--

--dL7UcAgxXI3Idr5fqaBSKODHC8rWP2kta
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmHcM/oFAwAAAAAACgkQsN6d1ii/Ey/y
tQf+LiJBBa3oyNWJwxFTbMX112uSDXd1mlehMSNY/jNBdev5foHf5vZfETwBZaO2F15Si6kf9Zm7
6go8tcyPOn9qFTwh1Nd7mLFgP/soLH+BW/Q43ydy2xotRXoVVfsTFThKtpFdRrIfjKMytoV3xxot
o/qVLDY2TQ3bNIF48msPPHiGDQnQedxeY0LLuK3QTEFklnkChw6IvZ+niRQQRTeLA8W4umwqc5We
ZLcOtBMORtOIpJsbnSY+hyngGQhO7s/+HXthi5IoeXEmpVJL9+1ZTkvQ/3t1Nec3GSJAdAhVkTBL
4Hwcbprf1S5dF/Sfd/xd/jx2+hB2uCnxMj2Pk3OsgA==
=GViA
-----END PGP SIGNATURE-----

--dL7UcAgxXI3Idr5fqaBSKODHC8rWP2kta--

--===============0233113070434271099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0233113070434271099==--
