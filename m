Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B538B7D8
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790405040; cv=pass; b=AQ2Uzpir+/7pDoq1OJMrZJOozsaZmgDCTHp8mWgax92iLEQzSnX53bEBpNA/0k/afLNpOqr+ppAS2N3JnFGlkpajFJhrBW0Ddb2aFyFTZsza5Ah9jmwgXkNnBKXDwCSQIirtOaj9oXYkxyILnc7gSPRGHarU+j8Kdczbtys4JLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790405040; c=relaxed/simple;
	bh=L/x/MsSpsPMPwv6hmc9szKtWP8yzSBXJpWyuSwDuuXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvtb74dLQUlzyTEX9Gy6Ycv5E43ZEdOOq1lriZq04miW2xA8j8HHygOj/tDy3ISEEmzfsZdzq4At3Ov8KAlsnc/AG3tvGrwzEcWtTPCZ5n67kPzSBcdSnHADsIqN1qAuLCt+cP2z+oBemgHP1tGeIqoi49Wh3ndiYMEC6vaOhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY+Adeiw; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY+Adeiw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29d50b7cf9so243885166b.2
        for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 23:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790405035; cv=none;
        d=google.com; s=arc-20260327;
        b=CAVW0a+KhOia6Mlfqfh55jexxw4D6xhoKI8b/kzA49tqEA7J8eQGdgC4OfL9BFnrX5
         /G2hav/bPM3W0zt2YbdhtsWOC8mmPf4oL5cGG3hKbZXfmbi6FRAdRiz3calleM2EI8NW
         XZ/d1+QGddYqsFrUT4KXOcbj3sgCrtfcs3qoPL/ye7+WTwrfIRTyLy5u35QCsRYaqLyz
         I+hGOfHcrCxw+QsWCnk8Q15i6UmtzOBtC5HMuC/wXjd9uD0AFMiJsw+q/yE4rhfOZ9r3
         I7NUqHtMyOrLWwS/yPKSHR1VLf6zjvq8KhPq8TEE/xPM46ASTbInJe8mwYN6YZFO5VBe
         pJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        fh=5ryWwBeAZ5EiW7xSoXQhiBT/S0aYrXdLGB6WEU6HcsE=;
        b=ZKlRqcL2RobFizF+s7qeRQzPImLKDGCiB5mxJXonoHhGeAfxCKKWVqLpT3iyJHsFVY
         cRsM60BF9IWfbAHGAz8XsgcRr2Nlpyg6VHB6OoeHOiSEH1q0Jmi/2Oqk8p67a2b5a0I2
         NiEFmGFEy9C4mNomCoMWMGYncuczhHMmV6h07YMEohiodrWSEwG0FEhJgbHOXPVw5bxP
         kBBnw6a9z/sdqgZQ3Pus2cc2K5aK7Nm2Gz0UO1d+68gG5GHkV2Uo6R6oMsmUjpXRTlOk
         Be2mmxOlkCrTAMpHHitvqownHEFTGlzewPueXC/GroisUY3OtsHB838ooaOLQgRNW9Fk
         vjaQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790405035; x=1791009835; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=MY+AdeiwQ1RNuoOCqxbytc3JXQnTxKqTIbNUyidRpWMzFJXkT3XkAZE1G2ioak2sVr
         iTQAsqlyexvNUS1QECGi4tPYUhdXkREqRpAjIV8GnUgTTRKnK0KHgrFRlQwam1HN8ot/
         BYX2P1sMgnT6YlumsXccXM2ACnjnUVRZ1vWr6dbLdF49UjURP8zmvC+a+gXktYwF6g9/
         oXxdwbkpQI4k9vyWsyhvK8RGLvUyK+SCqKlD5YKkMasF8OjuLxvAoFCsvnKHlHScenRD
         eu81UgBhiNiKzJv+6p4KVAOf/2TtXU0jiND39zYyciVulPNDYZ+/T5PI92/wHzw2sknp
         SIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790405035; x=1791009835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m19pIzxq/CLGg8+DYWn+q04ehTCniHZwasxO+AvM9gw=;
        b=oUgfGhdE2QnPq0FZuvm0xgCFZOyy7bCnpX+lmp/lopIlE5ohEtGsMOPqw5dePgSEED
         pyj6M42uA21idkJDyoF8S6BcUS3U2MAODxK3jaoL9DIR93U86vUK1PnO1Tmxuc9bWETW
         t6VkN9QxBIkFffjlrVxOKcResAywdHJay3Yo6RfQv576G5PFfFJfttSFYrEKUFJXLgmy
         xClMP2AmiSwQGGrAkBELYWpd9MX3FzQ71SKhpwrpoyUwTpC69gQBHsKj4RC0Drz73Csy
         sGQS/UM1I5r3ZeG5MsCuKxj2gfP4P6AjxQleNyqxXblsDqolqqPEwCCFOFqIaJABtES+
         833g==
X-Forwarded-Encrypted: i=1; AKwUvBznbHEMPkgHLgbMWcSOz1mCGBBbh7r+bs1fG4GR+ENkYZprLTT96QbhQosGkiTYI0biNAU3P8zMe0rSlunAjw==@lists.linux.dev
X-Gm-Message-State: AFuF++mS/7vm52iidls3JLzwkGrnpYnyfL/FK7fQBNISXTOJFQGPcyM0
	TnSkIfASgbYnAZpmDgXz1HgCHpBGnzvQOv56QJx2rOR0BZEO2eol+LBIiWFPOfbMtqI/CRje1Jv
	Mp9XUlJZSHEVdsJRAwNre3nFtrUdnLV4=
X-Gm-Gg: AYBFou3gbXLttpQrBQ7R3py0WXUbl4pfuDsm7/ilUFkYZJ5MR05CKZIjUhIaLeThelY
	nR3L60x97a9cUTKvsRWgL8SYaAfpzz20rwRx/I/X2LPYKyksM3F4GwH/XG0ErCEfLULmw7loM7U
	FULJXLsVAhRk5V3ajH60uVejiL077P+Fzi/ezHIgJFGgcVTFajWS8rrUuriP/Q7WVPQIClrZwAy
	SEFKXDO+xJcKj1iM3/TdQVPDtjA3B5boLRjS78n1FeOsn1YR+6KiB7jzxMpCI1rLmXO/LuuyHjW
	ZEusZJ3uRUDb27e46B629iUxqU3wYMrUSxlM8KYxecW8dAEEtFxJG0L+jln/B76TywZ/VdqFcgM
	HNGCwo+Hk5c0JnIWhhws2JXE=
X-Received: by 2002:a17:907:d408:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c2ac2606943mr702009466b.37.1790405034922; Fri, 25 Sep 2026
 23:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922122955.69433-1-fangxy@xiaopeng.com> <20260922122955.69433-3-fangxy@xiaopeng.com>
In-Reply-To: <20260922122955.69433-3-fangxy@xiaopeng.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Sat, 26 Sep 2026 14:43:42 +0800
X-Gm-Features: AclHuK8xFsvc4j73hXtI-ilJ3XzgO5FqQXk1LCo83q1Fcp__nagIQq7skCOkqq4
Message-ID: <CAAf7B_NbjMu-9CEPwN2HD8+P=L4Nkk=tYO7Ga5-dHq=CVneBwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: add regression test for cyclic indirect descriptor
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	stable@vger.kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 8:30=E2=80=AFPM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> Add a case to tools/virtio/vringh_test.c that builds a top-level
> indirect descriptor whose NEXT points back at itself and checks that
> vringh_getdesc_user() rejects it with -ELOOP.
>
> Without the preceding fix, the walk re-enters the same top-level
> descriptor without making forward progress: count stays flat, so the
> traversal limit is never reached and -ELOOP is never returned. With the
> fix, the top-level count advances on each re-entry and
> vringh_getdesc_user() returns -ELOOP once the traversal limit is reached.
>
> Use index 1 rather than 0 for the self-cycle, since returning from an
> indirect table is only performed for a positive up_next value. A
> self-cycle at index 0 would instead terminate the walk and would not
> reproduce the bug.
>
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
>  tools/virtio/vringh_test.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 84961b9..2a5d7f7 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -458,6 +458,8 @@ int main(int argc, char *argv[])
>         int err;
>         unsigned i;
>         void *ret;
> +       struct vring_desc *ind;
> +       char *data;
>         bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_rang=
e *r);
>         bool fast_vringh =3D false, parallel =3D false;
>
> @@ -755,6 +757,45 @@ int main(int argc, char *argv[])
>                 vringh_iov_cleanup(&riov);
>         }
>
> +       /*
> +        * Regression test: a top-level indirect descriptor whose NEXT
> +        * points back to itself must be rejected with -ELOOP instead of
> +        * looping forever. Use index 1 rather than 0 so that returning
> +        * from the indirect table re-enters the same top-level descripto=
r.
> +        */
> +       ind =3D __user_addr_max - USER_MEM/2;
> +       data =3D __user_addr_max - USER_MEM/4;
> +
> +       /* Fresh ring and host state; resets last_avail_idx to 0. */
> +       vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
> +       vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
> +                        vrh.vring.desc, vrh.vring.avail, vrh.vring.used)=
;
> +
> +       /* Single-entry indirect table pointing at valid data. */
> +       ind[0].addr =3D (unsigned long)data;
> +       ind[0].len =3D 1;
> +       ind[0].flags =3D 0;
> +
> +       /* Top-level desc[1]: INDIRECT, and NEXT loops back to itself. */
> +       vrh.vring.desc[1].addr =3D (unsigned long)ind;
> +       vrh.vring.desc[1].len =3D sizeof(*ind);
> +       vrh.vring.desc[1].flags =3D VRING_DESC_F_INDIRECT | VRING_DESC_F_=
NEXT;
> +       vrh.vring.desc[1].next =3D 1;
> +
> +       /* Publish head 1 on the avail ring. */
> +       vrh.vring.avail->ring[0] =3D 1;
> +       vrh.vring.avail->idx =3D 1;
> +
> +       vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
> +       vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
> +
> +       err =3D vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
> +       if (err !=3D -ELOOP)
> +               errx(1, "self-referential indirect: %i not -ELOOP", err);
> +
> +       vringh_iov_cleanup(&riov);
> +       vringh_iov_cleanup(&wiov);
> +
>         /* Don't leak memory... */
>         vring_del_virtqueue(vq);
>         free(__user_addr_min);
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowangio@gmail.com>

Thanks
