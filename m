Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721641F5437
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285322; cv=none; b=KTJgIbvLYMZXJnZLZdjfKpwWbJ6DXO86J/sflDOenuah7ZVtIe0biSNl+7Ycj1PdTh6jb5MaY4xW3KCPnG6buS0N0x0zej3tlSt6FJuA1qZWm/KnBIFq0S0fSvCO49FVkRzkRNU39qklDFSCjdPwuIxtFtHmRJ6xWOfKvnUylo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285322; c=relaxed/simple;
	bh=zJh6FSKHfp/pgQiEMSbsIqsdTcPSZxObaIopyF4RPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1NTon1YQ+nqxUMbcdPZEjymtsmYUNT41ud/I6Qfl1VEskqN1k3Sx3ymoqvNpOVi4gTfJziTLmK6vEXqim/ciUb6PdFK8MPAu3MUPj7FlZ1PtMzAQR17uHuO9+SuVtSD7uzdxlXwFmlZxmchhC4qE5X8v3lmCLw2y7RoHBD/QCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VZcm9kTr; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VZcm9kTr"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-43587e63a8eso3185673fac.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 06:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285320; x=1779890120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv4JG36su8ush+fHdva1/FuiXO1iTIDH4D/WFVrNa1I=;
        b=lyyj7U3ap9nuN2wic0WBTkyTRUcXnrJxxxRvJZI3wa0lnW6YDAbd9pJqidDFgQTMe0
         PrmzG2hKAbYCnWGqZeIKrlhsfGdRupDmNXuwIMJOHRxDJpbJToAFgYZGtcDQnCwdh3Mc
         mX7iWSCGThY+d1bNEynoWaHQZUpuCD5r2gx1wFtt7cOF950SCUzXQpilE7KilzOpXNsz
         N8ktTwQmz84mBa7xNL7+/Xe74LgC0Ppc+GbfE4GBAcsUHI09DpSZM362VdMj4+KGqtnB
         7WxzZw/REnKCB5tCvvlXMlxOs5awVHfn/mibYoCuH/UDr4tVWuVSSfmfxPrdnOr6SQ/c
         ijlg==
X-Forwarded-Encrypted: i=1; AFNElJ9wReW1MpdqVxWDHLcZuqBn285m8UGxWAmbH7Zp3bopWPuGZb+KS+lgaI9FZwIBpwQRIEBWtFHC/4jQiZ4TZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF27Usp0gDx/qcrN3zBpa6xvvKLgA8O785aDrda/HNUvIB5H/K
	n/c4asz9oKqxSxdO9FYvDSykyVZpr9upgQYdFI3i9EwHMDNnBEhdNQjXGEieAcRBycYTCdG3Y4b
	5KfsEgaogXFjPxvJc9jSEB46spREohUTdHZV0MlpdpmjIPz8nzZBTYNvAvT3NEro5mVAr25iHbI
	nLBqqVZqSWB89GPCLp8RXQihxzFMmg/IxpMHtbUIatq7Mafk7W8YjCOf43xrMYUWqoqSRym4lz7
	jlOcEOpIWiooSp0tRxrjOb8
X-Gm-Gg: Acq92OHT8dZnTMlkNWGmnytOPXTHOK/42qDasn98M6weRNjeOlCmTMnDPGMhkyKDURX
	49D1q1TOsEaURxrS1g/dwkeKZpxhkNAJgbFqB/GmbnrYSn/TErAptRcDB5aL7L19DejEqmX3Gvh
	x+EblPztRpM4+TTE5D7gDAb9venc9W8OJG7H9oxb2SJ4sJpyo7u36AfFE9UYjcAAk+e+fO7Tzs5
	mjoLFYKo8ZZNNGtKhD9HxcLoDw+eNT9OCEDly9JBiCtaAseaFUKnJdOLpwdG484Rem0FMaaJIaY
	nhrBONt1a1yzuwkI83NzRaGxqFvMespEL0mpQawMcmIb9eJ+P8CfcJFb+oIHYRqfsZrg4hIq6vV
	BPpHNs6dk7b0/MNb9kMmd0r1DoNd+JujPEEgo3mD/Z+QhvUqoXwZlmzu8nVwn6bDkAeBi2Z6mGK
	kFOPn7K1ZVJeVH8v1wYY+6xYe4azIad94dlTi92CsmvxlgYsVJI2kIcoYu
X-Received: by 2002:a05:6870:2101:b0:439:ae8f:e4d1 with SMTP id 586e51a60fabf-43a2db439a2mr16109079fac.4.1779285320287;
        Wed, 20 May 2026 06:55:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43a950686bdsm1278423fac.8.2026.05.20.06.55.19
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 06:55:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38e83f0482eso18190701fa.3
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779285318; x=1779890118; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bv4JG36su8ush+fHdva1/FuiXO1iTIDH4D/WFVrNa1I=;
        b=VZcm9kTrau/xRx0J+Q7p1gP73fA1CKh+Up3T7LHzlj1UQWTGsE4Dur8xxbqb3kPrYD
         yve8gR7ghZdaB0tDwd1vpo7dGehWp9wc2Vyznlnuoe/PlEK/Y/o7YeXQN8T/YKe4xg41
         drjFlM4f+R5LKVvsMNuwkrcw9UNQZheDl0bIc=
X-Forwarded-Encrypted: i=1; AFNElJ84fr8QzrV3yhZeXmIUb+8YozlhInrq5Uc4h2G2bKtnbqBW8sBtJTSRxwK8vnqQqPefBj9fKzQShsiHhaSsQg==@lists.linux.dev
X-Received: by 2002:a05:651c:1ca:b0:38f:e9fa:266 with SMTP id 38308e7fff4ca-39561fcff2bmr75940851fa.31.1779285318317;
        Wed, 20 May 2026 06:55:18 -0700 (PDT)
X-Received: by 2002:a05:651c:1ca:b0:38f:e9fa:266 with SMTP id
 38308e7fff4ca-39561fcff2bmr75940671fa.31.1779285317872; Wed, 20 May 2026
 06:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
 <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com> <agwv3YkxYIC7mvyj@sgarzare-redhat>
In-Reply-To: <agwv3YkxYIC7mvyj@sgarzare-redhat>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Wed, 20 May 2026 14:55:06 +0100
X-Gm-Features: AVHnY4KsOadhFPqTYhanc42rDQzi3pOOICpPN-4w7jVbe_h0wb-2f4c0V8ZyS9w
Message-ID: <CAOuBmubrJNFODWq05bzXKWi1GV=UZd2LCrJqMaVuTxUuv_9cNA@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Minh Nguyen <minhnguyen.080505@gmail.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f522506524025aa"

--0000000000005f522506524025aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:41=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Thu, May 14, 2026 at 03:26:28PM +0200, Paolo Abeni wrote:
> >On 5/12/26 4:58 AM, Minh Nguyen wrote:
> >> vmci_transport_recv_connecting_server() jumps to its destroy: label
> >> and performs an unconditional sock_put(pending) to release the
> >> explicit sock_hold() taken by vmci_transport_recv_listen() before
> >> schedule_delayed_work().  The existing comment claimed this was safe
> >> because the listen handler removes pending from the pending list on
> >> the way out, which would prevent vsock_pending_work() from dropping
> >> the same reference later.
> >
>
> [...]
>
> >Sashiko says:
> >
> >---
> >Could this change lead to a socket memory leak if another packet arrives
> >before vsock_pending_work() executes?
> >If a peer RST is received (err =3D=3D 0), the socket stays on the
> >pending_links list with its state set to TCP_CLOSE, and the base
> >reference is kept.
> >If the peer then sends another packet (such as another RST) within the
> >delay window before vsock_pending_work() runs,
> >vmci_transport_get_pending() might find this same socket.
> >Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
> >default switch case, set err =3D -EINVAL, and call vsock_remove_pending(=
).
> >This removes the socket from the list and drops the list reference, but
> >it bypasses vmci_transport_recv_connecting_server(), meaning the base
> >reference is never dropped.
> >When vsock_pending_work() runs later, vsock_is_pending() evaluates to fa=
lse.
> >This sets cleanup =3D false and bypasses the sock_put(sk) call, leaking
> >the pending socket.
> >While not introduced by this patch, does this error path leak
> >sk_ack_backlog slots on failed handshakes?
> >If a handshake fails due to an error, vmci_transport_recv_listen()
> >handles it by calling vsock_remove_pending(). This removes the socket
> >from the pending_links list but does not call sk_acceptq_removed(sk).
> >When vsock_pending_work() runs later, vsock_is_pending() evaluates to
> >false because the socket is no longer in the list. This causes the work
> >function to skip its own sk_acceptq_removed(listener) call, meaning the
> >listener's sk_ack_backlog is never decremented.
> >---
> >
> >it looks like the above is trading an UaF for a leak ?!?
> >
>
> @Minh @Bryan can you check this report?
> It seems a real issue, so the patch was not applied.

Thanks Paolo, Sashiko. We'll fix the sk_ack_backlog handling.

>
> Thanks,
> Stefano
>

--0000000000005f522506524025aa
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
IIcJTSXBXmaeflizD0q3fLuqRVGEesY8/RkiNFQKdtlOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDEzNTUxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADCVo1r9kvwsczkt0fKHfT14SuEiyikqdNFA
FxDPJmGChJYpH4+dLFFpYAIgblbO7JvUJWSHRZtDaY+mcP4xQCFurBqY/bnmIIW1AUwdy3OFPeNH
kttqPLrvYw15FipUFkzgv7+o3PZ7JIJT+4KJVraarsYTjzJo3Oxzdb555jZ7qQ+zJX6y8mW//+N6
HoKk5sznuBweHcVEJhcq3DF0qEWhtQncOXeblCI6v7CcS4eKQJPcr/ntIZ95KO1qjOxNwl0m8yx+
QtII5MyZHhk10r3fjTtrE6wpKgqazuKvoJ+5buPwJtGepohZ0xJqH8s2mUz4xSS1ivXTKm229zEm
z7g=
--0000000000005f522506524025aa--
