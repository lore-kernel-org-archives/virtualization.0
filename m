Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDF4B44B9
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733136; cv=none; b=u6dbso8F4UAhk+/bBZP8lsTXEbYwTi2RkXbRNf3tOBWefpSgnN21cXAukXP/VbJUW05gTRxA6MBdQSyx83JBNfudk22qlfx8VOWXv+9ZeiyGpVQpPld+WYttv+pEIUpVyTgUIz15k4tUnstIbf3pF2YFwawjH0vp9MkRGGkrHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733136; c=relaxed/simple;
	bh=oAS/dNP0xhVGJvVAMg30y5QGudX1+DeRwKsPJ1zBKAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ9g1mGRy/G+M+/4SuEbPK7UKbFUJfep9dcQBsjzUTdKrNGyo5rq/Wpz+KHdHOH2LTlRMc+3pUf/kS/3B6ziymCR9XV5V1BTlVt6d2sUD6dTpZC+YYynrTG4n8U++5TfdzVPh0bbMSx3vhWuCJcwvL1DDC8aqVm6O2ZgJu+rrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RL7Pzzyk; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RL7Pzzyk"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-5328bd04b82so3353981cf.0
        for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 05:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789733133; x=1790337933;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/TvsHVHoEKLZQLYFL+lIVcUsIBtrBSP5W+9UINbcuao=;
        b=thqqkRyM312wrq4NFsVzgVtN4P2JXbM0UKQKi36EG6yYwcXyHQu2Ij+h4N1zYz93wm
         f0qAab8sVs7RIXX1pXxK0fPnfcUVTTjBBX/n3ovLqZ7GZCGk7f5qwTM81BCXPa2y3rc/
         FqKAOYGF30uKKxt7cjwE4Fgfvi1EvtKHs+WA02VbXTJHO7BkdTlLPc69QiB1hqzJq5ri
         eNI+wYp1j7eCDx+unlavAUH80SJRC/WTpqSIAxHLpr8YcbnO/8OWLHIaIEWm8Zv5a/94
         yZsl/BYisycZCSBFYHhxEn13JaokCiuZJIjZSyr8LMZK59YApa201tV1bC6PrMEeo7Tu
         Lt9w==
X-Forwarded-Encrypted: i=1; AKwUvBzn3Vhks7B4a1vB6pf7/e8UZ2LnnoyQ/IJghOQBncsWcGGwtbIvt1cISq3eXXo6clBTqKm87DiVNaHjP9aRng==@lists.linux.dev
X-Gm-Message-State: AFuF++lcrHZ+pXNHhYGoOh1oKBZ7kgFb5MU5Dy6P/WqidCrouanx8oZU
	yDl+rA72XODijQpoVIBw23SQlNrzW1iNGngqh9ciHdko+hsfir8X82RlMGjuIdsdVVoa+IOY2xU
	zg9NCxLqh3hDYxjnzgnSfAf/6clB8oe0gzQmnYhh4fbVkbA/Rn9sZlJ1CRdBNuYNovXQ5x0F3yo
	Z/JVXITFf9Mom/BV5rJ8p8N2FtPxn75KAwLoqIRIGChYoryV9W4lRmLjjV0a62b0rLhIkwxE2Pk
	Zpfk90ooMxEv6IovsU=
X-Gm-Gg: AYBFou3DwQoFKweAtnghNRGMfsbssyqK4KCR2X1AE8XRhLU2NNETqz6aHWNO5E2RBty
	5GWwDe0T10NpE1zcowZ4DFkszDydmJOKDhq6EKNAu9I8Hqa0XXqMt7KbFj/dvZFlXHDMP/cegzx
	Gsp5QblbKU7WTHTLsKvAh7L2tFFEuiTXTdEFrUfcz1gfvOYfXKOqtYZxiXJpTbJXG5SAuP7CtqH
	dieLT7LC+9xvM1a3wh42Cl3DxV/8EzpiauEIzrpoK5WHAudpWjZ19tMszueeLT1UVQvaI6V7+0n
	u1sOWBN28Ao+ej6oqwJ2air3dS7Mc1QmZpOiKZzjSg3S0bIx6/npF6TgvFcMJ+RuVujoq9DKJjR
	mQTwWnuVS5hU3Dvk9oeCBozEO1uJfwqGL1swo/LHoGNKFqTPDl+EHVfLp1rUCLHJivSIF/wOOqI
	p+EskJjGrDSJyNbIZILFvHJbwk8vv9C3em
X-Received: by 2002:ac8:7c44:0:b0:532:9add:50c6 with SMTP id d75a77b69052e-5329e3f73acmr36227611cf.67.1789733132971;
        Fri, 18 Sep 2026 05:05:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-532a1a81655sm141491cf.22.2026.09.18.05.05.31
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2026 05:05:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c29c391bd2fso65394166b.2
        for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789733131; x=1790337931; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TvsHVHoEKLZQLYFL+lIVcUsIBtrBSP5W+9UINbcuao=;
        b=RL7PzzykS0zVPxr0+Mqly7N6dQvHPlOFrPH+l+yS+RIVIVwDFMX28lxdmKDQxknhhD
         E5GDdqnBybGWeKQhTbWFIqC7XPluOR7uKHdnLMZRhcAqGNwo39IYsrzJJ7BTm6qPqieX
         2U7ubMLeG7Onktzb9+ZT/NcqYTrKJ7V54bhnE=
X-Forwarded-Encrypted: i=1; AKwUvBwE4e9aUoAFttXTRAVhEyB12h4W6O5FszVtcH8Il2EW0nNMSwE6WmUdVB1TO+XKePr56E4CggtTT4SK4wzuGw==@lists.linux.dev
X-Received: by 2002:a17:907:3e02:b0:c26:1649:47ad with SMTP id a640c23a62f3a-c2a15b4bcdamr203538866b.35.1789733130574;
        Fri, 18 Sep 2026 05:05:30 -0700 (PDT)
X-Received: by 2002:a17:907:3e02:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c2a15b4bcdamr203535966b.35.1789733130058; Fri, 18 Sep 2026
 05:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
In-Reply-To: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Fri, 18 Sep 2026 05:05:17 -0700
X-Gm-Features: AcwNN1USmiC8Jcu4hjWBau20nRcugooYUK5pY3hETwht2HRZU97rE2YnwQwINHE
Message-ID: <CAF+opq1ZNTAQ=ZdF7qVuS7NuOLh26ott-TRFf-=PMA_4JA4AFw@mail.gmail.com>
Subject: Re: [PATCH] vsock/vmci: harden datagram receive access check (netns
 bypass + cached_peer race)
To: =?UTF-8?Q?Bart=C5=82omiej_Dmitruk?= <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, pv-drivers.linux@broadcom.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000084c473065bc0b7cb"

--00000000000084c473065bc0b7cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:02=E2=80=AFPM Bart=C5=82omiej Dmitruk
<bartlomiej.dmitruk@isec.pl> wrote:
>
> vmci_transport_allow_dgram() gates delivery of incoming VMCI datagrams. I=
t
> has two problems, both in this one function, fixed together here.
>
> 1. Namespace bypass: the send hook vmci_transport_dgram_allow() refuses
>    datagrams when the socket's netns is not in global mode
>    (vsock_net_mode_global()), but the receive path never checks it. A soc=
ket
>    bound in a non-global (local) netns therefore receives datagrams from
>    peers it could never send to, defeating namespace isolation.
>
> 2. Data race / stale ACL: the decision was cached in vsock->cached_peer a=
nd
>    vsock->cached_peer_allow_dgram with an unsynchronized check-then-set.
>    The function is called both from the lockless receive tasklet
>    (vmci_transport_recv_dgram_cb(), no socket lock) and from the lock_soc=
k()
>    send path; lock_sock() does not exclude bottom halves, so the two cont=
exts
>    race on those fields. An interleave can return a stale 'allow' for a
>    VMCI_PRIVILEGE_FLAG_RESTRICTED peer (and it is a plain data race
>    regardless). The in-code comment claiming the fields are never modifie=
d
>    outside create/destruct is contradicted by the send path.
>
> Add the symmetric net-mode check and drop the cache, evaluating the decis=
ion
> on every datagram; there is no shared mutable state left to race. The now
> unused cached_peer{,_allow_dgram} members can be removed in a follow-up.
>
> Signed-off-by: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>
> ---
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -529,18 +529,25 @@
>         if (VMADDR_CID_HYPERVISOR =3D=3D peer_cid)
>                 return true;

Shouldn't this be after the vsock_net_mode_global check below?

Thanks for the fix!

- Vishnu

>
> -       if (vsock->cached_peer !=3D peer_cid) {
> -               vsock->cached_peer =3D peer_cid;
> -               if (!vmci_transport_is_trusted(vsock, peer_cid) &&
> -                   (vmci_context_get_priv_flags(peer_cid) &
> -                    VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
> -                       vsock->cached_peer_allow_dgram =3D false;
> -               } else {
> -                       vsock->cached_peer_allow_dgram =3D true;
> -               }
> -       }
> +       /* Enforce the per-netns mode on the receive path, symmetrically =
with
> +        * the send hook vmci_transport_dgram_allow(): a socket in a non-=
global
> +        * (local) netns must not receive datagrams it could never send.
> +        */
> +       if (!vsock_net_mode_global(vsock))
> +               return false;
>
> -       return vsock->cached_peer_allow_dgram;
> +       /* Evaluate on every datagram instead of caching the decision in
> +        * vsock->cached_peer{,_allow_dgram}: those fields were an
> +        * unsynchronized check-then-set shared between the lockless rece=
ive
> +        * tasklet and the lock_sock() send path, which could return a st=
ale
> +        * 'allow' for a restricted peer.
> +        */
> +       if (!vmci_transport_is_trusted(vsock, peer_cid) &&
> +           (vmci_context_get_priv_flags(peer_cid) &
> +            VMCI_PRIVILEGE_FLAG_RESTRICTED))
> +               return false;
> +
> +       return true;
>  }
>
>  static int

--00000000000084c473065bc0b7cb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
R/NZ5tTafc0SyuWmEVyFR825FbSoi1HwMkY1/lsU/2Ny0PK1+9WamuvV11QKd2dN0bYDXrT9uWC/
Cw+IDnr+5S21lWL9xM3S7htf+QjbSezM58DicE0QLGoXIYZ98zGOum91sMMgq2YfQKCVeOcD/7SL
0tftIn9SftUtPTeRab5qssPI8Aqo18uk3WxLqQRQv57jHWDis/0CAwEAAaOCAdkwggHVMA4GA1Ud
DwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGG
LWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBc
MAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNVHR8EOjA4
MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmww
IwYDVR0RBBwwGoEYdmlzaG51LmRhc2FAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSDkmQlbsGdC/WLbyB/
f4VlMvD+ozANBgkqhkiG9w0BAQsFAAOCAgEAYv4/sGMrazXrWECSGMFJ6YIDir3jLsYCcD/xTMfS
bXSiWFQ/ZiFLbxfVV9JJKkkKR29ow0Eo1fBaZMCDhnax7746XJn6qJ0Iz5MyLKFB2DKt3UO2q1PB
+wh73XKXTx6FDnbFRDjtyam6uKjknIMrZcFVTyFwUiY9zKz5pK40OPx4ZzdWxOCKMnCblGOiqvS+
gHpKXHRfCd9Ul1teGR1+muz+L7fJfrx9WUBNDFFIhwZEevLSVo7wIoyT2PG0fIk2yjKCFOT3CVVy
E5LT/kzQHjq7Y36GeUxozu21FbrNYm4Ivlh1OV9suNl/3iN1j9kFAdgg/8QXh9USKmg2zaS/S9lc
1YYUOS+Epg0WBwhAwWtVym636KWqu4Esgz2XWX1260rHG0sIxkdxzvBwsUYpf3e1axBlOHHr1Jz+
vDtQVeBUS7fBAVDWnBJrKNn+jseGnpcqBDQSSNq1kB44XhKZFApne6lKSCqYkE3qXnr7Dp0CXm+G
pPoyxqxotis4l4Dl4A3btCkYLp/dzOS00M71f185BKufW7S/16rj/jVUzgz2AjGvM/OC0SWvGoB2
tDdyBMmW1/0xK5rKGnmfM07/k8agfS2J6eI1iWB35m1Ni2SoCoLGoLlvUA4OhexyRqMTTjyllKtA
0Z9TF7kzBYUx8Qa7zfaTaIsVorChiSjphpgxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgwcY9XKjV0+TQvViOkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IPUa0+foA81OXV65hrd2cHdozTXuCwRH8n8EaveWF38CMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDkxODEyMDUzMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEscBPT4ivqfHJlM6FOOe2XvEhQs1nyHb4ni
aN7YPSUPfbnziFG3vYhhwdcpHM8MSQkzlDXLbZders1LutTQ3Dy366rK6HgA7qw386EgBizc4PRa
K/zPiWR2EnPHfYLzDmr0kUto0HAJ3Vn+P7e7PBSm2z8mYsZpT8M0P+yG+RWQcKboO0WmTsfVp24/
b9UC+UDK7rSVX7s6wn228mYqFbZ74Vfgc1FIqtsDdTdyblqqMMfjhWnEFGVL/E1L+c99/WTtH9ua
wS4YLeHylgSqAnwc9xfJHhWHjJvHCBqF7iZmtOlO+YuGiH+OwBle1t7bBHj8c6bO1GkAWhRq626h
aJA=
--00000000000084c473065bc0b7cb--
