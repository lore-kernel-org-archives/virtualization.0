Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB492DF13F
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215755; cv=pass; b=S+4RPdvgX6AqHpM8TzOmbv/B3rKN23quTICFUBALM+4gEBHC1Oj+TGUWyv/tvQAzR/0lAsDkAdlcq2PsL5JVnIO067PDULFw82Li8YseBuzTBaYW3W9JcTg3ZUKJN1ogH5G8un597Gm7ljzad3TN+bddqwiwC46LcxHnrALq4ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215755; c=relaxed/simple;
	bh=nwu88c68SFSerBdBKyoRWQXJpcdunzdygAt85WN65B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWfdEXG8r94xqRIo+WMhxBRaQ998Cn7Yb57VSZ0xeWeSKTQzcSsW6+gQnctxwo8JMyfT6ARWUnCI2KjMMsfmK5rVvkskVtD7d+sIwtqc7+OJrOxVBSTSJINLu/emDa+Gn16okxmCYfm/gyXT1Pr4M5SFOkXNmDw5A+VOlOMf8Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c9d6cW3F; arc=pass smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c9d6cW3F"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-649b5f5570fso1561028d50.0
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 06:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215754; x=1770820554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7abMGEotmSJcwmVJcct4s7S6gGRSLepV9wzcKPpKpLU=;
        b=ooSCnkSq3H+lY6NBhi2rcqa9kmQ95aSkpGYfrudmkzCak+gk8P8+WVPoKnTJxpJSl2
         bcOsN66N28wJdVof2fO/NcEoq9xpimXMq224bOgRmuFRVvCsDefj6sHR+o5sKBMssRkp
         KO5Hw2DiGDSS65ZUycrkdV7sJ63TAdw9abMv9h2IpCetdYaonN6iCZRp9lW9noNKKeB0
         w5rptAa8idfVwUpCSkiv6jnL5U8cbUfx1Na38jpMq0L+OeTBHuZDeKdLsh3aqoTOHfcP
         XOx1JcSaaxLv+GT4EqESoda8VelFVm4ltQpfzIw85rJQNCJqg3/VHBJEeQ3fmi36zwbB
         Bjrg==
X-Forwarded-Encrypted: i=2; AJvYcCUunZqWx86/EvKOhBaiQYvPoU//cw29DbVryjBX9cCPTFoK7rXHyCXXgslOyH357tE6s6nX+nOEyzLS0FEowg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb0W5OzioVKGekCf+yTtlvWZtDlzhhUnqaKTeps8NkW6vGiTZ2
	VGBWBS1482VwnUmkhRZ8LekhUmuhvvNnZtVBv6dhScLJzlJSlwOCa+I47JHkQ/41ZrvmNh9+1A5
	+eugfkEGKTSXi0mZrXbKZ2/le45JbGKPh14ymB3t0AgKBpA62Qlr+b5BB0INpsTRfAKNxuIprp+
	IBN07HYaPtxcvMfejdUYtV2BxnKsHoSwF8PFZOfO6PC/TaCQrDF9vX7PKuXAgqb4Cy8XbJ/M8Qu
	uiLaA/fAJ3ZeK1Bs2DnxfBg
X-Gm-Gg: AZuq6aKRPu39H0Wd+qVD5cssCVXePGUOK8ERajiovTgG1wuWVhyxfHsNDbcjHpsq1CT
	YvHEo1LGKjP9W2X/K7jwVxssFdUmDoAeykz14GdNVlswROMtF/TBSXPZYx7GbK5ceOCzO7g6TPX
	qr+jYUjgVEOhx72Oj1CC9vI5+EPHmnKBrZdRYmNl0EBAYZoJXYZRCkqXX3VWEQmoZE9K5GZprtr
	HqtM5RuhT0NaUcatE5LBuD4PwQavsKXQdOv+ow56I6dbukf1/ycNhXJXz3IIaxJpXPcLx1QGBOt
	VpHm0JGXG9G8WS1uCbld4E9yb4O4G5bWK8a2/W2FtmyZCHnFIg2eFnFSK36Pu94P5qi9Crzt6+g
	mLlK7bG6CtwO6OWfewlnSrEABOR4OAdtr7PHMUNmlGq/ScK1+tan6i5w2OiWc+/q5eKu9J4e5ST
	y0T/bAhYFa3vz83hnh/LVDUFz2+nL+5Z+vTvX+ECFALQ==
X-Received: by 2002:a05:690e:d08:b0:649:429a:457c with SMTP id 956f58d0204a3-649dbe001bemr2401336d50.13.1770215753851;
        Wed, 04 Feb 2026 06:35:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-649dc4ba47fsm143128d50.4.2026.02.04.06.35.53
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 06:35:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-382f5ff8a1eso44759171fa.0
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 06:35:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215752; cv=none;
        d=google.com; s=arc-20240605;
        b=L/QPyOIjyp13MkkcX7ruOgPA6WWndjfwpg0LpV+hpJTtIcjngDuPWUInb0IOswWb23
         C/V2kBX6l3SjY5X75JaBK6HR2CIVmlz8qsqf5SRDPhLK/4+oQoeXvJiA5MidlwvntRiT
         HPLMQIHQso+kketo/7tALwgerdoZI+iYqPpYd/BJNHMx7nXxC/wnjUtSKfxOjQxLXwlO
         ddYhq43CBTw9dA4RM76PbEm4hvKNuITnh/tP0gTX5GY57jSZzbnWQHQ4A8EXp/i3wC1C
         tDKSYFsbiHlodX3aUDjPCtSPPEbqr3g6UMz9E08XLrJyBxgHRx+v8qMfUMWGshEOiLac
         AJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7abMGEotmSJcwmVJcct4s7S6gGRSLepV9wzcKPpKpLU=;
        fh=l50hoK/WIMGT+HkBAj1GtJ9jV0VFKFqGTLFw8YPhb3M=;
        b=db0Rdx1SECUwYs69GyeOlvkpBiBDsZalM/10ne/2GTQCSNETKXimA0VooNl3yOlU7G
         +fYt48gCc7SBujtmj8TvVb4jaXxp2Uw3U7mdpDAYys//YVVLj24Uy9LdwjrUZ/O4PUiT
         8zHcqY0njo6Bdlt4gDpQNqnCX7R8x35+H267vDo6OFjpv809QvuSQelaLvTBMZQVTyM7
         DKOXzLyWSi80IWOSYwzfxCpruAy+Q6/ZwerbPFLCqlLAPO2oo0wW6rPmmwBYsjxdc9TW
         y9jcMMhImeX2dRpAT4/K8Vz+e9TMiqESvg6UcIn1zzrA+HiRIhMepE3g7kjwtSokNYsR
         p+Kg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770215752; x=1770820552; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7abMGEotmSJcwmVJcct4s7S6gGRSLepV9wzcKPpKpLU=;
        b=c9d6cW3FWiUYZfqnaWwYPEiNbNq46kWYgDhCJ6DRIiA2Unz4oObSyt4eJVAtYJYHfj
         KN+EZnVz2H6wpQGkH/KbBLCLvU0O1KVGXxt8o5/JMMwM1FempNPCUGvH60oaSI10RVDW
         B1EpisSePRG3foXXj0DZJ3MZibGCokRBJDQzo=
X-Forwarded-Encrypted: i=1; AJvYcCUWcnOp/fHx9v+eI0k3ZtDSIVeI5SSyI9LzrxuO3mSpmS7YDLMloR2DJB3BhucbaTU0NMAtH1ZFV/kMd3WM/g==@lists.linux.dev
X-Received: by 2002:a2e:a541:0:b0:386:9325:228b with SMTP id 38308e7fff4ca-38693252d07mr10245821fa.5.1770215751915;
        Wed, 04 Feb 2026 06:35:51 -0800 (PST)
X-Received: by 2002:a2e:a541:0:b0:386:9325:228b with SMTP id
 38308e7fff4ca-38693252d07mr10245651fa.5.1770215751475; Wed, 04 Feb 2026
 06:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260203163406.2636463-1-arnd@kernel.org>
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Wed, 4 Feb 2026 14:35:38 +0000
X-Gm-Features: AZwV_Qg41O2rRKZlfo4K052mHOgqNH9m_DTbwtaGbYuTAdAW_oY1maGK7XkKKJ8
Message-ID: <CAOuBmuY4qOYUvbGhNbrDiexRmFy1QKHe1vxL24so8SZSM8oCmQ@mail.gmail.com>
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with gcc-16
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Simon Horman <horms@kernel.org>, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000180482064a00792c"

--000000000000180482064a00792c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 4:34=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The gcc-16.0.1 snapshot produces a false-positive warning that turns
> into a build failure with CONFIG_WERROR:
>
> In file included from arch/x86/include/asm/string.h:6,
>                  from net/vmw_vsock/vmci_transport.c:10:
> In function 'vmci_transport_packet_init',
>     inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw=
_vsock/vmci_transport.c:198:2:
> arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non=
-null expected because argument 3 is nonzero [-Werror=3Dnonnull]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcp=
y'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in func=
tion '__builtin_memcpy'
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcp=
y'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
>
> This seems relatively harmless, and it so far the only instance of this
> warning I have found. The __vmci_transport_send_control_pkt function
> is called either with wait=3DNULL or with one of the type values that
> pass 'wait' into memcpy() here, but not from the same caller.
>
> Replacing the memcpy with a struct assignment is otherwise the same
> but avoids the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/vmw_vsock/vmci_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 00f6bbdb035a..a64522be1bad 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_pack=
et *pkt,
>
>         case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
>         case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
> -               memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
> +               pkt->u.wait =3D *wait;
>                 break;
>
>         case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
> --
> 2.39.5
>

Reviewed-by: Bryan Tan <bryan-bt.tan@broadcom.com>

--000000000000180482064a00792c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IDKktijIXGx+3YZx1cZ1Tj6NawZx7l1sVCcse3ZHMZY+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIwNDE0MzU1MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKMbrDobX4LKKYD/Kxqd7v48QJADsf8voMC6
dTb0m77bEoGRZ4HLjWnmeZBeCMz9ikrEFxa9QlR3B/LAnMWmd6gMizsWHqUbla3g4vijl6X67SbQ
r06OzQbo443viZoUZI/KzU1HgCR4WF6HTNILQfyzkrgQ9cFFYa140MoiYkwq1h33WAKmhrp499iZ
zDYSDar7IHto3DCCH5HatJOjZApklzrGe2Cx79lytV5UPqJJ5gTewO92c/e0Dzey6S4kKfDh5il/
qs1OqoQurQzJ3swRate5GrkMa0ojDCUXdxzsuqgsnd2QmJOWGwU8RZ+4ntG8jaNRD7cBi2AmRz5S
Vvc=
--000000000000180482064a00792c--
