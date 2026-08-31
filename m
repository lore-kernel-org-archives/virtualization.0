Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6B3BCD27
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215618; cv=none; b=r/PzzWsbgusfHA5kNIK5tKIMmCIEsuudidF3ttdd65cFc/XjtNekrh4J1Hltquqwm2gEMbKTa1gimDl0tCsttpnb8mKdC69uukrJO5gSXeeH1hyE4uyq/jG+oA+92E3ps3B6NWDx4MR0/tzGUgw0r3OBtti/+kNpPpoti5hhvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215618; c=relaxed/simple;
	bh=tndpg9cHmwUhD9igm5wpIhKOUmGoMDk07Ejfmu19jMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mb369XxD1XDrzDSnAssvuzSU1VqYGq730Lef3tU2TnHC3MROHkBdAi5FYxLmd7MwRM8Nvw7WunmbGl2aL3c9mMK/3Q2hxhqkKz6/nRD7RaR+aIJO5ybP2n8lWN6PCtW9TIqquzh7SgX/uK/qvc7m3/0FcF4XHzFA/dQcbMUy5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RbHK/Ahj; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RbHK/Ahj"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso461213a91.2
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 15:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215617; x=1788820417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbXKkSytfyD5ZIUaw9xw1Oytf/OOJ1GNDImboAI8yzs=;
        b=mi7s1ZpXEJe1yMeV+rTe7snFakk+2fRKQUL//3CHGgQCiRGuRBT+FcWhBsSCLemJZm
         KAqKjbjcBMujoRsxXVhFCVEqtSRX3mHPhzOH/2CMj6WivCfrydVIKSdjliqwu9y1JfOp
         2URkaM0GsauxErNZ8fJ/GexCLXamIzdMsRaA/ap//4ciSYL51FtomAmNu/4TgPKgDSM+
         g82WzZR6PhE4fGbb9qAstOhTmgVtguAKwrzOwRFGHiK3fLmhbpUxg01Rie9CpQQatyRK
         DSrICLmTLsSc2ZRNrd16PJ7DqMC6vBHl5Ggf5SOsGSShIWILggBvzx4ObKtBkB/wK3EI
         v9Ow==
X-Forwarded-Encrypted: i=1; AKwUvByMwk/w+tvqzN8hSzDpH5+PVKlxoTK0LMg0ERpjA36m8H4qDdRTr239QxWV1NUq7bDMP/Eq4b0OQjklgT+K6A==@lists.linux.dev
X-Gm-Message-State: AFuF++l/FHZ3mIi7e0D3BY/nNlNoVWcY0lDe2YA8PT+9JSShD9T8tXCX
	n0E6LzmVdflA/AvqHArc7vseuBSO9XRogMZ9EGeT6N/5oyH4/OwMNAElWlt5+M18P0DT5chCfE4
	MHjBBbwFCPSckjwKvU79P47+uYNnNV4wPJW91nvjuAEyt9i7thdHr7qkdB0R1g/YUxiWdsSU/8I
	rcjOonCgsv1w48u1941K9lRxjH/TfIbRxZMKliciOn0Wv8h3wCrdfgVuVfTIBleKLLF9/f52Ltu
	NUGuGo1n1uors+Cf64=
X-Gm-Gg: AYBFou0e1946Zwbty8trxbuEBhXkGE4dg6b295qUcTj5LwTt1gUTmNIsgqJXxxjHAhB
	S7HKAPO7NPESRGjgeRq4EdKCK3l5xBBfA5wz5TLueGq3G6UGM5C7P3flYhaOvRdkC/kZV6pPh2U
	L6EfRePbpGMHm67wgBluX11gLISilzq2d0L81YWoFE/IuEcavgkDctO2Nvse99SR3rgjeDbiTIe
	BnZr794vgGU1TwBrvlt3Tr3UUjhjzcpGIYgFLZZ2K7p0zBMjdZgD1bJAB1Gclw+ufJV+2j7F6HK
	XlsKSYOmi2sYg202bjQ6wAPypAqlHOY7mbIBhujadLQYpqUuP4P2qlN8u8BO62NUMVDnsXrruI/
	lzzClfbUJy1CAjmZYldawSzH23MshXe07nnki8tPYQ3SFIe+iFwCySnTvE/tn87gxNrHyOV2mTA
	KVkq4AGfc+CH23/BPxQJQWviBb9Ptc5GRS
X-Received: by 2002:a17:90b:5102:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-396d0ea862fmr47850264a91.6.1788215616630;
        Mon, 31 Aug 2026 15:33:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-398a4ba4743sm859260a91.4.2026.08.31.15.33.36
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2026 15:33:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c20e5890680so319342666b.1
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788215614; x=1788820414; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbXKkSytfyD5ZIUaw9xw1Oytf/OOJ1GNDImboAI8yzs=;
        b=RbHK/AhjTXEgPECZIo66hHxPkTy4USBsZ9xBEbseIQYoe+i+JgihRH0dYxd4H68rVT
         OTlzQNuhEfYwRur5iDJseCIAsm7e7lXPYnk0PDkUHpIuFFdOG7rphgPl1mTvyrq2J6AL
         6RFke2co+NmKFztL5JSVKHfjf61zrN4g0ZM7U=
X-Forwarded-Encrypted: i=1; AHgh+RoyMEkEjdgCFbNZyQ+epaco3JWsx5s56/4GAtETahtg5HLf+y6mjefUyPte2AvceYIQDiTnPRccHspOT05cnA==@lists.linux.dev
X-Received: by 2002:a17:906:4fc8:b0:c25:2e93:28a6 with SMTP id a640c23a62f3a-c2556be5796mr1757005466b.3.1788215614429;
        Mon, 31 Aug 2026 15:33:34 -0700 (PDT)
X-Received: by 2002:a17:906:4fc8:b0:c25:2e93:28a6 with SMTP id
 a640c23a62f3a-c2556be5796mr1757002166b.3.1788215613904; Mon, 31 Aug 2026
 15:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260826003929.966160-1-4ncienth@gmail.com> <20260826003929.966160-3-4ncienth@gmail.com>
In-Reply-To: <20260826003929.966160-3-4ncienth@gmail.com>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Mon, 31 Aug 2026 15:33:21 -0700
X-Gm-Features: AcwNN1UohuGEOIEsqdIyo2DNfPV6378dBW_fPaBppWjFWBvMgwOd303g94W5MlI
Message-ID: <CAF+opq1DfP1d5RBQwcP6ffiUtsUwxGH3a5twyd9Gct2iHZ3CuQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] vsock/vmci: validate packet source for
 connected sockets
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, stefanha@redhat.com, 
	bobbyeshleman@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	bryan-bt.tan@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007f16d6065a5f6446"

--0000000000007f16d6065a5f6446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:40=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> vmci_transport_recv_stream_cb() looks up sockets first by the full source
> and destination tuple, then by destination only in the bound table. The
> fallback can select a non-listening socket without checking whether the
> packet came from its stored peer.
>
> This was reproduced with two VMCI contexts. A RST from the context not
> stored in a TCP_SYN_SENT socket reset that socket after it was selected b=
y
> the destination-only lookup.
>
> VMCI can process notification packets in bottom-half context when the
> socket is not owned by user context, or defer packets to a workqueue. Use
> vsock_check_source() after taking the socket lock in the bottom-half path=
,
> and recheck after lock_sock() in the workqueue path. Listening sockets
> continue to accept packets from any source.
>
> Reply with a RST addressed from the received packet before dropping a
> source that fails validation. This preserves the existing reset behavior
> for bound non-listening and concurrently closed sockets without directing
> the reset to a connected socket's stored peer.
>
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.k=
ernel.org/
> Cc: stable@vger.kernel.org
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Reviewed-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

Thanks!

> ---
>  net/vmw_vsock/vmci_transport.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 1c4ee039c..1f186e8f8 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -680,11 +680,13 @@ static int vmci_transport_recv_stream_cb(void *data=
, struct vmci_datagram *dg)
>         struct vmci_transport_packet *pkt;
>         struct vsock_sock *vsk;
>         bool bh_process_pkt;
> +       bool drop_pkt;
>         int err;
>
>         sk =3D NULL;
>         err =3D VMCI_SUCCESS;
>         bh_process_pkt =3D false;
> +       drop_pkt =3D false;
>
>         /* Ignore incoming packets from resources that aren't vsock
>          * implementations.
> @@ -765,17 +767,29 @@ static int vmci_transport_recv_stream_cb(void *data=
, struct vmci_datagram *dg)
>         bh_lock_sock(sk);
>
>         if (!sock_owned_by_user(sk)) {
> -               /* The local context ID may be out of date, update it. */
> -               vsk->local_addr.svm_cid =3D dst.svm_cid;
> +               if (sk->sk_state !=3D TCP_LISTEN &&
> +                   !vsock_check_source(vsk, &vmci_transport, &src)) {
> +                       drop_pkt =3D true;
> +                       err =3D VMCI_ERROR_NO_ACCESS;
> +               } else {
> +                       /* The local context ID may be out of date, updat=
e it. */
> +                       vsk->local_addr.svm_cid =3D dst.svm_cid;
>
> -               if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> -                       vmci_trans(vsk)->notify_ops->handle_notify_pkt(
> -                                       sk, pkt, true, &dst, &src,
> -                                       &bh_process_pkt);
> +                       if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> +                               vmci_trans(vsk)->notify_ops->handle_notif=
y_pkt(sk, pkt, true,
> +                                                                        =
      &dst, &src,
> +                                                                        =
      &bh_process_pkt);
> +               }
>         }
>
>         bh_unlock_sock(sk);
>
> +       if (drop_pkt) {
> +               if (vmci_transport_send_reset_bh(&dst, &src, pkt) < 0)
> +                       pr_err("unable to send reset\n");
> +               goto out;
> +       }
> +
>         if (!bh_process_pkt) {
>                 struct vmci_transport_recv_pkt_info *recv_pkt_info;
>
> @@ -900,6 +914,7 @@ static void vmci_transport_recv_pkt_work(struct work_=
struct *work)
>  {
>         struct vmci_transport_recv_pkt_info *recv_pkt_info;
>         struct vmci_transport_packet *pkt;
> +       struct sockaddr_vm src;
>         struct sock *sk;
>
>         recv_pkt_info =3D
> @@ -908,6 +923,12 @@ static void vmci_transport_recv_pkt_work(struct work=
_struct *work)
>         pkt =3D &recv_pkt_info->pkt;
>
>         lock_sock(sk);
> +       vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
> +       if (sk->sk_state !=3D TCP_LISTEN &&
> +           !vsock_check_source(vsock_sk(sk), &vmci_transport, &src)) {
> +               vmci_transport_reply_reset(pkt);
> +               goto out;
> +       }
>
>         /* The local context ID may be out of date. */
>         vsock_sk(sk)->local_addr.svm_cid =3D pkt->dg.dst.context;
> @@ -937,6 +958,7 @@ static void vmci_transport_recv_pkt_work(struct work_=
struct *work)
>                 break;
>         }
>
> +out:
>         release_sock(sk);
>         kfree(recv_pkt_info);
>         /* Release reference obtained in the stream callback when we fetc=
hed

--0000000000007f16d6065a5f6446
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
IL0+KEKWDs1IUl1oWfUPGMIoLX2d1z2ft91D4VXOKojPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDgzMTIyMzMzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAE+6IjpGMo4w2bbYr02StDOjQT8kzAsuPABe
G9YeMt42e2S+FF2Be1SSU+UCRRinTXAR4yjPxHNmtjpEdHDtou1JJ6YjYnsSAQiWzefA50Pj+Kxo
7aQ9fCRFO2l2TVTfP9wWyIfvxCe/tDc91u7p5fFkRafsLQZljqydDgpgk7awH3bT0Laxeo5mu2GT
qNOHSAETwf4Njncw+yi96ueLStpycplvybFu7oAj0eGAFynwF3eiREtjbMh7zy1Qn2F4XXwjmVVz
Ish9xOUIc9rV8BINcq1IE0W/SS+sd08cMMty+wSbxZPXGN6oNM1MAR3ctyMrA65vGaOjjPwI54GU
vYY=
--0000000000007f16d6065a5f6446--
