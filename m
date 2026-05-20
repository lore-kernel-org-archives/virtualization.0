Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA661F5437
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285115; cv=none; b=XhAo1LDPo3pKMbfjyfOQB1HCqg/OysZrcnQbLzvtyLmT6T2qGacx65zDZ+QXp91/HHbtOxOMfZTy48CKJ3pWI205N8sYMumm5kutn+HI22RC8gjkolhigNE0M1kwCVtZuLrYIGYfN3o99Xg/znilQiTPHwPbTCQ60/ucDeaoSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285115; c=relaxed/simple;
	bh=aPMmbiDsOq7Sx16htsxcLmzMDPuR4CPEeXDfbGVZEZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHVdy+zW7AalkRvnQxr17HME6vL47vwBVaNbUlMCZ0Q6a0w+FQ2G31H4GJMfC7sDgZUd3mI1xBvYr2RF1q2hgx6rOzDOAxDl4rTA9mD6uRH9jiiHBvDhA4cEb60i9WGRq6nTZa6n2j/nfUryBtQ2wqwrntoMXoPOFRIGc1dABWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=REReq5F3; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="REReq5F3"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7c58e6eb3edso44097617b3.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 06:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285113; x=1779889913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkV4PKiW6G5XIeFlF2mBw+0yF2ttKBELA8+E8ZCk71M=;
        b=mXgxGSHBE6lR6nNBaHPdppeIN5snth/R1BXhOkQcS7wA4etPEEu6W3aD7mK3cwj5Su
         GRfIgVOwhkopQdBaE2eoEpv4U6rx2RBxOPj3Yldc2H2x+998y+GN/p5irQE715l9BLiX
         SZHsIZdxopslIlEmFfPyyfG5BDl379kW2BmhTUh+nlpXZXQKdCP7+GjorKGbX4bLxzzt
         TkBuwCdnZRZAsSNRzpaOF/6rsScWpfG3ER4J7rBkOA022OGS3yLGFjWwxyQsXlZSYmT2
         EV3mt9SE7ZsYFeqJjMRYBVCRNT4OEVewnOUMgmqjNcg0lUUYyx0JsmGEH8zugmHVT0fy
         WeTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CUZZ9ix/PPt3hzySQ5HVXiJkVT+X68PvjSaK8P+GJWZlZ5JSIJsGsi7D+cuMQELLp7hHWsZEaolmOmjWm9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvySn3rBWW2qf10sCnxHjsLNEc6LFqd9PxadkRdjeqP2QT3aWw
	54jDuke1CVIl5NAjeiFMNI8ePQnKZPJ1Jq85Is17BxOi3GsW6Acn4xIWg3uS35Q+yj/9Q/5cRkL
	L9ZD7v9mrgU4ABMIRKRrEsmME0PKAjly9oAba/8ry6t/x4crBl7stu+3PTOK92RrDEy7MDpDeEq
	kP3ereqUQSWJg1fCNyeiGq/drr7xGq4BOlVLwgN7+ghC0+WwvAH64Wu7RT8DMjNTFCki0YKlrmr
	46kqG7Kec9GNW1KbsSZPO6g
X-Gm-Gg: Acq92OE8F202mXbCxIqqoaTe4cZF4e5KuwknDEL5qKAHxFy+aEQL2AtC1GttwacPNZJ
	uCcF5AKl4uglGUv+QgFRDEvtCqCBZc0CE/dMBkYT+Hw8u7O+68TXg0NMoBo5VAeAtMJspJuMiCl
	BGAOzAPNHIUJDzuy+mY6XR/n6nGDKAwkEh9hj8GgwhbQ0mBShzHZEiSpC6vzju+TQjHH3Jxv/Hd
	T0zgZgdqk1Zx7/jtFEbscfyFuiUIoXVnpAuFy7oC0ex1YJAsCY22vRBGFG8kEnn8ILUPRqlRzwi
	Qj1Od98g6tyQScaUehCHzVQxKxSKYaxJjJolUikwa/8zbmv9Q60Sb8yF/xuV109/7vn9y1YGnqO
	PP5PUboxsWtj9knIUXIVtxjXW7g2tZOAMzK8zWpK4Ugp8ZEPZquT17ygDz7fx+h7QJERSUUcg91
	JoT2+XNsBo5tAHVNaH4WpvpzM9B1NxhBog5RcMTg7fLzCPn9ZYhQz7ttJRQdA=
X-Received: by 2002:a05:690e:418a:b0:654:5d65:9ff4 with SMTP id 956f58d0204a3-65e22674e00mr20890912d50.10.1779285112606;
        Wed, 20 May 2026 06:51:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65e8ee26bd9sm208406d50.26.2026.05.20.06.51.52
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 06:51:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-393adad635dso30535261fa.3
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779285111; x=1779889911; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vkV4PKiW6G5XIeFlF2mBw+0yF2ttKBELA8+E8ZCk71M=;
        b=REReq5F3sbhpC8EgKg/cFSzkWOZm1QZ8ikXzN6AoIyi8aDIVM4Zk2tjBd273EgVYqG
         xBSmxgXJq3b4kOfd40s97gETkf0JZB2mQ/qbVZ4v0XapMjUXJWIYQRhLxdQT3liC2Qe6
         bz2WXCRpTyM2NGjPl+fdHwyipTnv2/VBcydBw=
X-Forwarded-Encrypted: i=1; AFNElJ+KBmM5IDS6K2fIv8M/BgEJ5nQoX0TR9wsD2zkYvKD6K9ngP8EfgTYhL5FEtYb2nCH0bhc/TwPUTzjK/SdtLA==@lists.linux.dev
X-Received: by 2002:a05:651c:987:b0:393:c254:20c6 with SMTP id 38308e7fff4ca-39561c04d52mr76572171fa.1.1779285110679;
        Wed, 20 May 2026 06:51:50 -0700 (PDT)
X-Received: by 2002:a05:651c:987:b0:393:c254:20c6 with SMTP id
 38308e7fff4ca-39561c04d52mr76572091fa.1.1779285110211; Wed, 20 May 2026
 06:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Wed, 20 May 2026 14:51:38 +0100
X-Gm-Features: AVHnY4Lj4twVB9bPJ2sY9gZT5RkqQB77iMFrkQTMYdpfgXCvej8miR3ijvgbEwc
Message-ID: <CAOuBmuZRxEMm=H6Xy3PWh1O5h30PV=jpQxHYXXCyZSJwf1GHsw@mail.gmail.com>
Subject: Re: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: pabeni@redhat.com, sgarzare@redhat.com, vishnu.dasa@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000060c8065240190e"

--0000000000000060c8065240190e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:23=E2=80=AFAM Minh Nguyen
<minhnguyen.080505@gmail.com> wrote:
>
> vmci_transport_recv_connecting_server() returned err =3D 0 for a peer
> RST in its default switch arm:
>
>         err =3D pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EI=
NVAL;
>
> That made vmci_transport_recv_listen() skip vsock_remove_pending(),
> leaving the pending socket on the listener's pending_links with
> sk_state =3D TCP_CLOSE while destroy: still dropped the explicit
> reference taken before schedule_delayed_work().
>
> One second later vsock_pending_work() observed is_pending=3Dtrue and
> performed full cleanup: vsock_remove_pending() then the two trailing
> sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
> the socket, and the second wrote into the freed object:
>
>   BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>   Write of size 4 at addr ffff88800b1cac80 by task kworker
>   Workqueue: events vsock_pending_work
>
> Treat peer RST like any other unexpected packet type (err =3D -EINVAL).
> All destroy: arms now return err < 0, so vmci_transport_recv_listen()
> removes pending from pending_links synchronously and
> vsock_pending_work() takes the is_pending=3Dfalse / !rejected branch,
> dropping only its own work reference.  This also closes the
> multi-packet race Sashiko reported on v2: pending is removed from
> the list before any subsequent packet can find it.
>
> The pre-existing sk_acceptq_removed() gap on the err < 0 path of
> vmci_transport_recv_listen() that Sashiko also noted is not
> introduced or changed by this patch.
>
> Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.
>
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v4:
>   - Resend as an independent thread per netdev workflow (v3 was
>     incorrectly posted in-reply-to the v2 thread).
>   - Drop the inline comment expansion; keep the original
>     /* Close and cleanup the connection. */.  No functional change.
>
> v3:
>   - Different approach to Sashiko/Paolo's "trading UAF for leak"
>     concern: normalize RST to err =3D -EINVAL so all destroy: arms
>     take the same err < 0 cleanup path -- no special case, no
>     multi-packet race.
>   - Sashiko's secondary observation ("while not introduced by this
>     patch, does this error path leak sk_ack_backlog slots on failed
>     handshakes?") is correct: the sk_acceptq_removed() gap on the
>     err < 0 branch of vmci_transport_recv_listen() is pre-existing
>     and is not introduced or changed by this patch.  A separate fix
>     for that gap is needed and would be welcome.
>
> v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080=
505@gmail.com/
>
> v1 was sent to security@kernel.org on 2026-05-10 (not on lore).
>
>  net/vmw_vsock/vmci_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Bryan Tan <bryan-bt.tan@broadcom.com>

>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 4296ca1..d257938 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1164,7 +1164,7 @@ vmci_transport_recv_connecting_server(struct sock *=
listener,
>                 /* Close and cleanup the connection. */
>                 vmci_transport_send_reset(pending, pkt);
>                 skerr =3D EPROTO;
> -               err =3D pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST ?=
 0 : -EINVAL;
> +               err =3D -EINVAL;
>                 goto destroy;
>         }
>
>
> base-commit: be48e5fe51a5864566307998286a699d6b986934
> --
> 2.54.0
>

--0000000000000060c8065240190e
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
ILDAnCmVZLW4gqfDqkJQ2XAvcDzjyPBluBCb9Ki10VFqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDEzNTE1MVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFZSTMZKHDSzW1r6kAPFhYWWqk74YqAvRey6
Us6ujwaIn8FPahu2l8IUFZk5BCGerpOiDmdScWmPltpLgj2PBCE3rijWImqfoss2WnN6trH9bIwW
XZrr3mrOl9AmQRGpzPKAGQmqgGl1k3zdDie3NOAxyF1hdbOocNQ2j2B52LMQdVDHjy5T4GfsmlUy
xgogJLD/NNVG4Sb8bL3/0M7+8LvGd2tmyOoix+rXG57xslCYqqFmFsqf9a/LAUo4lwQD644sRm6C
WYZmuPKNAyBREQsU4WLhu8pSOAT5IroCtIFnGqUqy+lEBX0KtQaspPpH5irmO5AGBdqOxiB9bGSl
MF8=
--0000000000000060c8065240190e--
