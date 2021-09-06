Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDEFC433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 05:07:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AB860F13
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 05:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24AB860F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D357A4022B;
	Mon,  6 Sep 2021 05:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfHLD5d80i49; Mon,  6 Sep 2021 05:07:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 14B2C400A8;
	Mon,  6 Sep 2021 05:07:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D994DC0010;
	Mon,  6 Sep 2021 05:07:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76D1BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 05:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EB3E400BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 05:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3PfruDGHwU0g
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 05:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62C0C400A8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 05:07:52 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3FF222107;
 Mon,  6 Sep 2021 05:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1630904869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TH6OfFtjTmh4CNomOOib+IRjdnTDcva6E6Fs/nvFLw0=;
 b=H8XVEDULdmGPWg/boLzln+5OyQ3P8xBafBgkcjMy1cSS0OJkzSKQfr+3Qn1VS4LfbsWfhE
 WudnpzJIQCnofwPGsEur2eMRKxCJXGul6l/XvzX8EwjXUCFAEgk/823D+bJiGgzxh/ZpEH
 6xeZmZl9uxGCNyqIB8PWWlZZjTW26ME=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 397B51363C;
 Mon,  6 Sep 2021 05:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 5moCCiWiNWGqRQAAGKfGzw
 (envelope-from <jgross@suse.com>); Mon, 06 Sep 2021 05:07:49 +0000
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>, Joerg Roedel <joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-43-joro@8bytes.org>
 <CAJhGHyA-GXrBgOxEu0sqN_+LMd7qUot=_2J1g6yGTvo-Mei6xA@mail.gmail.com>
Subject: Re: [PATCH v6 42/76] x86/sev-es: Setup early #VC handler
Message-ID: <52255968-a158-6f03-0e6b-bcee9a96e37e@suse.com>
Date: Mon, 6 Sep 2021 07:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJhGHyA-GXrBgOxEu0sqN_+LMd7qUot=_2J1g6yGTvo-Mei6xA@mail.gmail.com>
Cc: Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
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
Content-Type: multipart/mixed; boundary="===============7146489619371248255=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7146489619371248255==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qQkOCDwMXPJsYvVTbBIa9Au6lmlsdDs5D"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qQkOCDwMXPJsYvVTbBIa9Au6lmlsdDs5D
Content-Type: multipart/mixed; boundary="nSGf89KVhPYoi2nASdXhGRdln0u8Ae52o";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Lai Jiangshan <jiangshanlai+lkml@gmail.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>,
 Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Martin Radev <martin.b.radev@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Message-ID: <52255968-a158-6f03-0e6b-bcee9a96e37e@suse.com>
Subject: Re: [PATCH v6 42/76] x86/sev-es: Setup early #VC handler
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-43-joro@8bytes.org>
 <CAJhGHyA-GXrBgOxEu0sqN_+LMd7qUot=_2J1g6yGTvo-Mei6xA@mail.gmail.com>
In-Reply-To: <CAJhGHyA-GXrBgOxEu0sqN_+LMd7qUot=_2J1g6yGTvo-Mei6xA@mail.gmail.com>

--nSGf89KVhPYoi2nASdXhGRdln0u8Ae52o
Content-Type: multipart/mixed;
 boundary="------------8D0CE617CBAAB7288BC36DCB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8D0CE617CBAAB7288BC36DCB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 04.09.21 11:39, Lai Jiangshan wrote:
>> @@ -363,6 +370,33 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
>>          jmp restore_regs_and_return_to_kernel
>>   SYM_CODE_END(early_idt_handler_common)
>>
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +/*
>> + * VC Exception handler used during very early boot. The
>> + * early_idt_handler_array can't be used because it returns via the
>> + * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.=

>=20
> Hello Joerg, Juergen
>=20
> The commit ae755b5a4548 ("x86/paravirt: Switch iret pvops to ALTERNATIV=
E")
> ( https://lore.kernel.org/lkml/20210311142319.4723-12-jgross@suse.com/ =
)
> had been merged and the paravirt_iret is deferenced based via %rip.
>=20
> Can INTERRUPT_RETURN still be a problem if early_idt_handler_array
> is used instead for bringup IDT?

Even before my patch the dereferencing was done via %rip.

I vaguely remember having discussed the pvops usage with Joerg when he
wrote the SEV support. I'm not sure why pvops shouldn't have worked, but
I'm sure its usage makes no sense at all, as long as we don't have SEV
support for Xen PV guests.


Juergen

--------------8D0CE617CBAAB7288BC36DCB
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

--------------8D0CE617CBAAB7288BC36DCB--

--nSGf89KVhPYoi2nASdXhGRdln0u8Ae52o--

--qQkOCDwMXPJsYvVTbBIa9Au6lmlsdDs5D
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmE1oiQFAwAAAAAACgkQsN6d1ii/Ey9N
yAf9F8VcYE5+Gd3XEqxmHB+3BsmewMZgLRsraDtfWXlnIRVUZ7zqs+rCW+9zckVh8CZxSF3diq/h
SXkw8qNkN4ZnI9SrlbLgLvzTzdInolo2Zmf9Dr8miDsrlFNO/ENeMQEFReK23UlAJ7AxLNRYFYns
Dw5uouXmfMO5k1CfNTRnLuPeCGONdtFr2/pFa8NCH6NiT18lv65Fzpao6OnZg2ChWxAXSvkp79hg
5PDnaoWWdJedF7FOfcDjwz6RhdhSYkDLElGQ1/hwV5L2LcIbbXnxTkox9LVLmKbgtpc4Bhw7Fpjn
ves54TclpXN86OnjOS3u916ASYrw6JLLd0BmMP7QIg==
=Ewmf
-----END PGP SIGNATURE-----

--qQkOCDwMXPJsYvVTbBIa9Au6lmlsdDs5D--

--===============7146489619371248255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7146489619371248255==--
