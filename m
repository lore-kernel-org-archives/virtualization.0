Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D3475341
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099688; cv=none; b=NWUYCojNo39AX8btbgEv25KOQQrgNyAoyani8Jd9UiP5U/+yzc6CmrdXpTriht0xX7hw7B2JN85FwGcZ6ORel5jMCnTNVMxunqtvKqsuokf0T7GjsXUfAa+xoqj3b+rxpqNBV4YVqH1qay4cZpxU3cU7FkC9QrhixzVxvBnHJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099688; c=relaxed/simple;
	bh=XGhdONqCSQLgaoSRHzO9ryAh1SWBKXgSz551iDT7c/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPz+c4SX+qSPxf2pHyoxIpn1AgVJquKXODqcZ7EzlFeFzFaBysa8thwr24kU9LGM/EskzjgqYRwsLzlUx484t5OZz2Zb7I4L13SqwbhestfIpaVKEGOR9uUPVMtkNnzyUTb9EpShyB5IsztDHM8ikOwNtqY3z43lkITSzy5/BQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dzNUO34K; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dzNUO34K"
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-475920b9ca2so9614fac.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 10:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790099685; x=1790704485;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/hxb6JUsSHXY2tvjmestPS7iRJeRJN3ZxmSVDOrXZQ=;
        b=iwJQ8gR2o051DfeQy5AAXZk7+jtOdzJipIPMdwQa31cRygbGVHfbbGDA2pTx9fg2YO
         x6T8u8P2ErXAY9AkQ0iuHRsNf0ceTumQG+jZKHmM10Rnk+/9ROk97Z44HHncIXvoVLOG
         SDGNjrwF2OBwZy+emVbX7GUBjN/1fomdhu1v2P2c/Xn3VAlm3oxriiKXmYE+5gPXi8Tk
         0LKJHpyoonLe4gLAy0Th7ygMhPlNm/yNCxC+SXePoCqAPyb/vjQQwwAZklBvpnzKYe/m
         z+HGKC6kPRCJ4sr/BFB4WCfEKH9z2PTNLgLnZaiAqnTa57r4kcUjuFjM+aUYDg263Byu
         +Z7A==
X-Forwarded-Encrypted: i=1; AKwUvByzma70KbmjYIN/J/BMjoz7UhyKl1OSi1c0Q5XLUzaNfrMYjPEEyXaDCt0eCskV7usQxCC9N4ZdM6cbKaQaxw==@lists.linux.dev
X-Gm-Message-State: AFuF++l4zJs6tEQqxRIJKFjiDNFbK0Mo/VtUDlWaSdJ0XNA/HLBBielM
	dtqstJ7sECdafDqlUD8op27+eYM9Hd+8PbyrGNxq3gwGDfT5822azifRGvkEB83gOLrSg8vPioz
	8jaR25/dy4Db6uutpY/C8hSUXeSPCtYrsqDGq+b64vc27o/NXTHLZiLtzr+X8nzInCFx+KYXsbC
	N5z/Jxg/q94cYOu8RhP8A84P/Ooz0NQ0kAT4/pMh6PfzGDDEfV8mStvyZiQbovkGTes2U1YedrF
	KHeX/ojw5cGPsKI9Tc=
X-Gm-Gg: AYBFou2HyL5iQ4a7ga4Omr8FH3YA9LJ+kCtVcuRW8R7qfrg5R2n+RqNhpNLrK4piYAV
	wKj2dJYqvy9krCFeYd8tKBCDVRWfXyZDN6ZpvtT4uUrTaIcBGKoX7XnFdL4S3Dltm3V6RFyta2O
	On6DlUkJinb8VkMHk97wF/6Q9TMMRLnthKNJcryd5ywLRxjGQ2hcfmkVBaWTSikR2AJWuHYySvy
	5gsiPFBaUteo8lMdSY/0IXPVEjLvCJpL+RC0A/JLFO8IuM4kRhiKdD36F3cCBypQBC8xmnBeGR5
	woZjBHqldJr+y4xkgCJGuLo+92Xj4vQRI5ouLtPV3UOOKl46hrsOjqCzX9q403bUQ/eyT4dWl+y
	uvMew7JoKIvyyytyEfGp3OC/C4YDPnU7Wi8l/M2qPkM/QFHu4SDmZAfbmIujRI5cyIDTkhmVH4X
	dBrbMOp+RHHdh7OXYb9XO3+7fUMAsU8YBjug4=
X-Received: by 2002:a05:6870:c18e:b0:48f:e21c:cd73 with SMTP id 586e51a60fabf-4908c3dbc14mr390469fac.58.1790099685080;
        Tue, 22 Sep 2026 10:54:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4908f1ee2a3sm9478fac.11.2026.09.22.10.54.44
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:54:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c252b87e9a2so4639166b.3
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790099683; x=1790704483; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/hxb6JUsSHXY2tvjmestPS7iRJeRJN3ZxmSVDOrXZQ=;
        b=dzNUO34KnBvzr8ot2peWi2FjqQ+3UIw53itaFOrOuMtev4FDPAa7VwgrqLpw0J1F+C
         ji3J+rI8RGUKljqsH2uMVaEHbh7QOzhzI2jaC59NHMTSCl+Tf+Wvu3VwSOL2hfSYauf9
         ic9w3i+txhu8Q6FF8RYlGnSSAW4gyvgTeUHxg=
X-Forwarded-Encrypted: i=1; AKwUvBzJtLBs+b3TVtOsBxEoYLV/wgIciTdWIiVZkukkGcsudh4Igx/yJQC/P57/Xarq37hsFhb3U8du+/HULNtXgQ==@lists.linux.dev
X-Received: by 2002:a17:906:6a0e:b0:c28:f9e4:836c with SMTP id a640c23a62f3a-c2a157c36c4mr1359937166b.28.1790099683308;
        Tue, 22 Sep 2026 10:54:43 -0700 (PDT)
X-Received: by 2002:a17:906:6a0e:b0:c28:f9e4:836c with SMTP id
 a640c23a62f3a-c2a157c36c4mr1359934866b.28.1790099682926; Tue, 22 Sep 2026
 10:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl> <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
In-Reply-To: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Tue, 22 Sep 2026 10:54:30 -0700
X-Gm-Features: AcwNN1VxZOQcFFCm7caZKqYMY5PSHL2XX9LEeKhSmLyKVEfu0HCiGbBZkwyQ0Bg
Message-ID: <CAF+opq12yFHNZXUoWn24GnBozm7Zvfwh3FiCZRsDypLw7WY-pA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the datagram
 receive path
To: =?UTF-8?Q?Bart=C5=82omiej_Dmitruk?= <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c051e9065c160f7c"

--000000000000c051e9065c160f7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:32=E2=80=AFAM Bart=C5=82omiej Dmitruk
<bartlomiej.dmitruk@isec.pl> wrote:
>
> The send hook vmci_transport_dgram_allow() refuses datagrams when the soc=
ket's
> netns is not in global mode (vsock_net_mode_global()), but the receive pa=
th
> (vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not,=
 so a
> socket bound in a non-global (local) netns received datagrams from peers =
it
> could never send to, defeating namespace isolation.
>
> Add the check at the start of the receive decision, before the
> VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
> (matching the send side).
>
> This was found by code inspection; I do not have VMCI hardware to test on
> (compile-tested only).
>
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Signed-off-by: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>
> Assisted-by: Claude (Anthropic)

Reviewed-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

> ---
> v2: perform the netns check first (before the hypervisor early return) so
>     hypervisor datagrams are also gated in local mode -- the Sashiko AI r=
eview
>     noted v1 left that path partially bypassed.
> v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmit=
ruk@isec.pl/
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -532,6 +532,14 @@
>  static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 pee=
r_cid)
>  {
>         u64 access;
> +
> +       /* Enforce the per-netns mode first, symmetrically with the send =
hook
> +        * vmci_transport_dgram_allow(): a socket in a non-global (local)=
 netns
> +        * must not receive datagrams it could never send (this also cove=
rs the
> +        * hypervisor CID).
> +        */
> +       if (!vsock_net_mode_global(vsock))
> +               return false;
>
>         if (VMADDR_CID_HYPERVISOR =3D=3D peer_cid)
>                 return true;

--000000000000c051e9065c160f7c
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
IBH5FrfexFJpoUypchQyJdKqPeYwm/tqaEEeiTGt+JXWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDkyMjE3NTQ0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALqfqsiC6fm6mwjwUoFvh3tMT6f6XRPuYOBv
fwpB5HTT2RbZU56ciRKn3vZyOLXL313AktH3XYnbQvBhwPAlRJ8RmYkWJm26yq+oBF+Le13RjfNE
nYfgzWvvATG0KA861ig77tfTcnwfN/5r3V6LwDVhhfzkUR79iowdHkT0UD20SH7aJ55eq5USmpHz
j32UWU85xKCy2sz3gqI9PCQ/15RSKmvrOcJjRcL34lVYXpCzyTaOnwqiGFmSKxZZpqWIHX9Eb7nO
8kWBWquj2d6fFi8TQOMBfEPNz8rCRVt+qXdybP6FTXKdVCKQaFiFgbhYQyZtHQ42SUI+blZpkEHc
TnU=
--000000000000c051e9065c160f7c--
