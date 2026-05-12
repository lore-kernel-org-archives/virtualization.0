Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375643812DB
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591571; cv=none; b=hHtwNwa5mHi7SCYKVwPBLCYJUuZ9+ye8v0KF0eFTat4E+l0cy7Q5mIIIImHkgk9j73bOgnuE6n8kM3k1RNiPd3hwqeT1rnWaQi13JvVmwI5PCzDJyg6rPHm2JUdHHMgPOVx2WoU2EskZBbHvDoP1AMnz3Tfhj28DoyzN7LE3ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591571; c=relaxed/simple;
	bh=rqyV46txNLLnHmMW7EP0vMA9iksVyVL6PEvEjlOBlIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHGfuzQyl1rrWN7MnHFa1MKup4MWiZxeTE8mTGD3OfE4+jGtlGZMpoEo4SsSuR2Rm3VJbP+ohHS+66Yraz5Nb9KPjYF+6LDyfAA2IYQROhgBONP7C0GZgq1HcDLR62gmH8U4tBjCDWOcQ8ax92/njMa2vKL+hf93JqIJD38CwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OSztf1Dp; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OSztf1Dp"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6949f3eeaf6so2508926eaf.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 06:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591568; x=1779196368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJjaR1ANX/PfJSZswCuIlfPYdDowHReebRMNqy5fR5o=;
        b=tUd43wslVrtFlIpqK5hc0Jl2OrX9x4Ywu0WnOve5Fh9Ve4q/0hf2TglLlWIBwHnLpw
         PG0zBFMNdZpqr69DDUDVeZgXTRozJL/CWs7dFGTnlbbY0c/HG33S4P8HTwrZOq94gCQx
         9d/LOgJW6OhIHEGlcwnATjxk2cuALESvhrcY/HnhtWsgyfxZgXPiHIFa107w6hIZIvTb
         u7GtAZqMe31/SyZ33geLw4RdezBlrRB/XK7n2MMGq6uKKZlGGxW2h4pqp/nyivsILTEW
         2DOpzBwWzxeWWG7uC33/WdCinICDgLRweLGj3z/jE4VwZfloUbcfKbD2AQUFwWTKvL8b
         B8dw==
X-Forwarded-Encrypted: i=1; AFNElJ/0jIh60rlZuveX+qzlKvNO96hqtU+CF5VjaDXoGquAIRn8jxCm6haQmbGC2eJAo7AGGFQXH5bkBxOXAwjIVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSCg/FfooidLkRDQ7ogBVU0cW55tywW/HICoVoijERAZc4abcN
	4XKrRW/mNaMg5zTsahNHL1nYaDI6J+6r7B7MD1nl1UU9huLr0twnZmIoZBynr/d9WHBpjWckYqw
	rQ93sg55BBh3vHR5NK5IBgXmlOtG1XNyD67tizpvSMV5HX2Bfq5UWBCeO35ZIzBCRvdre4goUkz
	XEIgPWdDMem5TMxcJVjndHak3dJZat1YX5zB84Rc7rE0P/FStL+YRPi1uvwSQo6gUgsT9B5wy2Z
	C36zRs+NBXlhj5XrZvhA5Xn
X-Gm-Gg: Acq92OEtF9GQlGtCbUwP8nIrI0JArWbcykrESMbN/HB0vIW06EFJT/3jUG2Sim8HQvj
	qMJoj7v2zqbG76hoFh8P9VWLbJnjw7klHWTWoP01jGrdz7J34IuiwUSUXoWGsC2Ts5VPc+QyB/o
	+CN82+x8uSvw7fKGiDptoT+kcKYTuojpSJSV4nfuDUUsdPr1bPPaPoXswyGQB9k2CupTVbpwqOP
	a79/j2l4Z3hF6uMf3fWRwlryRggSmWsAsSP0AIEXtNaUwuSbQaC1l0kL2v7pkf3OzGkPUouBFtp
	5te39DBNpOVWDrTvCq0xZgJOEiTnj98LISO7cZGJCz60e+u3s2YeN0LCvmByQUV6Ckkl6ytJY5r
	BBfZa/d5Uki11HrVI64FoW9NUi57aWYIchyg5lG8dC4PaSYneXTav6XIqDxX0lwxEU4eM6Mglvz
	KjG/vxWLr0ByaMjUN7WGKe8U+mv+qFk1+gWN4k+lRIFGsZ/XS0us6dUmds
X-Received: by 2002:a05:6820:1a07:b0:69b:4186:1a0 with SMTP id 006d021491bc7-69b677cdb1emr1779059eaf.14.1778591567937;
        Tue, 12 May 2026 06:12:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69b25c26293sm575736eaf.4.2026.05.12.06.12.47
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 06:12:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38df95ce2e9so36215161fa.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778591566; x=1779196366; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJjaR1ANX/PfJSZswCuIlfPYdDowHReebRMNqy5fR5o=;
        b=OSztf1DpdpVS3Lukspa7BKo4MJED4z9YkO1W82pYSXKT4JDjOX8m0N0rz1sboaBK+y
         Itpw0j63R/azc+xd8ZNNkCSsZs+tcRJ1klslDgEDi6XD34AGbU5Fw3D2jI/aIHG434mV
         mceX67hP1dWgPdsKtiz4QkhJH/DcpxO5s8dLQ=
X-Forwarded-Encrypted: i=1; AFNElJ/U+NI0AJzpurUi9SJpMFVIH33nqNdIQ8jQY0ectN7Ox+qcB5F3APGFX9B2XRqOvbUnOo6oFUrNizc73u0FCw==@lists.linux.dev
X-Received: by 2002:a05:6512:691:b0:5a8:950f:e92e with SMTP id 2adb3069b0e04-5a8950fe96amr7209614e87.23.1778591565922;
        Tue, 12 May 2026 06:12:45 -0700 (PDT)
X-Received: by 2002:a05:6512:691:b0:5a8:950f:e92e with SMTP id
 2adb3069b0e04-5a8950fe96amr7209595e87.23.1778591565364; Tue, 12 May 2026
 06:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Tue, 12 May 2026 14:12:33 +0100
X-Gm-Features: AVHnY4JaHYtrFk7C3Gzaaq5WjUZyW7kD6ZyNBupTar3Gjfb-zbg1FAqP6O5Y-2s
Message-ID: <CAOuBmub=XEwqy8LJxx7_=__OHzGuRcg-nQpF1o37L8+ZOwyesQ@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008365e806519e9e17"

--0000000000008365e806519e9e17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:59=E2=80=AFAM Minh Nguyen <minhnguyen.080505@gmai=
l.com> wrote:
>
> vmci_transport_recv_connecting_server() jumps to its destroy: label
> and performs an unconditional sock_put(pending) to release the
> explicit sock_hold() taken by vmci_transport_recv_listen() before
> schedule_delayed_work().  The existing comment claimed this was safe
> because the listen handler removes pending from the pending list on
> the way out, which would prevent vsock_pending_work() from dropping
> the same reference later.
>
> That assumption breaks for a peer RST.  The default arm of the packet
> switch sets:
>
>         err =3D pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EI=
NVAL;
>
> and vmci_transport_recv_listen() only calls vsock_remove_pending()
> when err < 0:
>
>         if (err < 0)
>                 vsock_remove_pending(sk, pending);
>
> For RST (err =3D=3D 0) the socket stays on the pending list, so when
> vsock_pending_work() fires it takes the is_pending=3Dtrue path and
> drops all three references itself: the pending-list reference via
> vsock_remove_pending(), then the two trailing sock_put(sk) calls.
> The unconditional sock_put() in destroy: had already dropped the
> explicit sock_hold() reference, so the second trailing sock_put(sk)
> in vsock_pending_work() is a write into the freed AF_VSOCK slab
> object.  KASAN reports a slab-use-after-free write of 4 bytes from
> refcount_warn_saturate() on the workqueue path:
>
>   BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>   Write of size 4 at addr ffff88800b1cac80 by task kworker
>   Workqueue: events vsock_pending_work
>   Call Trace:
>    refcount_warn_saturate
>    vsock_pending_work
>    process_one_work
>    worker_thread
>
> Triggering the bug requires only the ability to open a VSOCK
> connection to the target and send a RST before the listener accepts.
>
> Skip the sock_put() in destroy: when err =3D=3D 0 so it only compensates
> the cases where vmci_transport_recv_listen() actually calls
> vsock_remove_pending().  RST is the only path that reaches destroy:
> with err =3D=3D 0; every other path produces a negative value, so their
> behaviour is unchanged.
>
> Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=3Dy,
> kasan_multi_shot): same trigger binary, same VM, 100 iterations:
> without this patch 52 KASAN slab-use-after-free reports fire; with
> this patch applied, 0 reports.
>
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v2:
>   - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>   - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>     enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>     same VM, 100 iterations); test summary captured in the commit
>     message.
>   - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>     bug is no longer embargoed.
>   - Rebased onto net/main (no functional change to the diff).
>
> v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
> no public link available).  v1 review summary, for reference:
>   - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>     vmware guys on this that know this code better."  Asked for retest
>     and resubmission via the net tree workflow.
>   - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>     me."  Also noted that no modern VMware product allows guest-to-guest
>     VMCI communication, so the practical attack surface is host -> guest.
>
>  net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Bryan Tan <bryan-bt.tan@broadcom.com>

>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 4296ca1..88d7128 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock=
 *listener,
>  destroy:
>         pending->sk_err =3D skerr;
>         pending->sk_state =3D TCP_CLOSE;
> -       /* As long as we drop our reference, all necessary cleanup will h=
andle
> -        * when the cleanup function drops its reference and our destruct
> -        * implementation is called.  Note that since the listen handler =
will
> -        * remove pending from the pending list upon our failure, the cle=
anup
> -        * function won't drop the additional reference, which is why we =
do it
> -        * here.
> +       /* Drop the reference taken by vmci_transport_recv_listen() befor=
e
> +        * schedule_delayed_work() only on real errors.  For a peer RST
> +        * (err =3D=3D 0) the listener leaves pending on the pending list=
, and
> +        * vsock_pending_work() will drop that reference itself when it
> +        * later cleans the socket up.  Calling sock_put() here in that
> +        * case would be a double-put and free the socket while
> +        * vsock_pending_work() still holds it.
>          */
> -       sock_put(pending);
> +       if (err < 0)
> +               sock_put(pending);
>
>         return err;
>  }
>
> base-commit: be48e5fe51a5864566307998286a699d6b986934
> --
> 2.54.0
>

--0000000000008365e806519e9e17
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVJQYJKoZIhvcNAQcCoIIVFjCCFRICAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKSMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGWzCCBEOg
AwIBAgIMfmyL7UtgKwUfUWpJMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDUwNloXDTI2MTEyOTA2NDUwNlowgaYxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjESMBAGA1UEAxMJQnJ5YW4gVGFuMSgwJgYJKoZI
hvcNAQkBFhlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAtnDfEBTP+8BpUYXDnl2RR6diPVyZP+OXe26wz2P72s7LDPppHJCGg+szN/XvjzOq
Qti/18aO+LxEceP3KxE2YkHy7ypitSOrF0rsDAVotZx76YVMLJ3xvBrm2ApOHYQfRvzHk5pNWPwz
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
IEpkaUONAsOygFvcB8jIOtP2zmmgUtq3e6SHK32KqxzaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMjEzMTI0NlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHzP3T4WPue/akYrPLRFH0TBNfxlTaABeN2K
pUTDK+W1b5atddPW77XtFCtt0K6PAC8qK7qySauCc/hlUDGt/tAJ+vZ57lLzA6Ra9Ekc5GuHldZI
V/UXR+IIJtF4pNWh7ptL4oSt8ZTyi3JJ6jIejaBQQJ9x7OcZfF/5GwhPlguv8C/Krc/o+dnMOXes
maqKJzP075e6mlI1rqHpJg/DOJbS6W2rGHETcrBRDgVBuyuawDRzcD7hvspMLWykUTesgvNjQlwu
4X9KCi15/15SO+FiNa/++7Zb8GUIG1Sq7HuAje4ztQJmxwVu0Ih1rYXfGrLnNR2dB4EYJobZyknI
V0M=
--0000000000008365e806519e9e17--
