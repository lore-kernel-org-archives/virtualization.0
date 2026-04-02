Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1818D658
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157748; cv=pass; b=RgAkTh5B6W/fVDOe9ODDZ6T950C2p9eFPHs3CuPu3Ma1z812U8J3KzDAxTjqOoRkSti+9PYKdSgJHnmetHIrSlFdLwW+T76kaH1SPpc7dfP0b4SgODlpVlISdsyvUkXMGY8TpElQWbOO2QEN7oabqTtj6PFh5gdwwxu0UvnnBCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157748; c=relaxed/simple;
	bh=cQrixCzgQ4H0I5sRm31clp6klAihQ3kGYJ6qIWoBe9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPn+4X5LUEKObC4uWJjLd+ASZjSqe71PmPxabojdR1ytNpXfQ4EPbiq1VDJg8YYKGuJnp11aSbMqbXK7ngFNSrNG5tpQJofrMxr/wNlZQB61F7VMlJNtMjqxQIYbxFx82bVxkMNMk6Hg/4aL1o6HSWinhvHt5hdwCMuDYz3XS2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIbWU8CU; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIbWU8CU"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66e192ce6efso1736617a12.3
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 12:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157746; cv=none;
        d=google.com; s=arc-20240605;
        b=k/kgpVftnu/eWXaLAaLh1C1o1P3L//d/Emm+HofS1Tk0B/Ejwi7nbeVNW5Md1R8GOK
         idOaCiTup1CLZSOWfdaIRX82jrygR5znf9occaPDVeq5TTCdURJb6Nb+tFemQDFusc+z
         KcKZMiuZohZ30pvJ/WzlhjulddmQs9/vVdLinPeEkLyZYV4hpBwhrAosY4S7PMFPPfEe
         Blpo/g86Jq/TsqgSQTHG6imygOlKeqI4RZtBB+U++uJQsLhyuJRF/j3F2ThR1Cs0/yLy
         FNhBQA6BIjtBPrHacChyrqzP9tNmnRL8D3/K8laEaCwJq9Us6tOJUfcCLPmGlfdQmYfv
         1u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZCpjsHBmVImyRAJmholf3kR9HDLjfsy2HnHxQeXb1U=;
        fh=LH0XHQ5VSc0M1nnnyry7/zfrHrz6qFSJIs79VQ+uic4=;
        b=XlrFMQqHKpM+YUHd86TM+tGE7l419JiOowFa3nQEHmL6EHr9P1Cln01sogCycuZuJp
         55aSwGwyVGgG9HPJ9DAL6zLisfnmaDUY+cDmOyPkpGyNk/lBRa0ddcYYu56WY7rvFXKB
         80fKRjzCxBnUb2Vir6t82FxlFOxIw4q27vESsJ3RPajjBB2ef7VItN0y+rDFxVKiURbI
         x114sS5oGCmeJK6zEMyucyGrWnCxYR2qI953Mb+vaJQg/Ds20r4D6jaRT7Mq5nNe8GbJ
         oIGiSXWb044HWnr6U22sXyQkvRrvN2m8TQ3+5oxy5QqF4cWAbdfNbC/XE5QeTJLoYAR1
         r60A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775157746; x=1775762546; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZCpjsHBmVImyRAJmholf3kR9HDLjfsy2HnHxQeXb1U=;
        b=fIbWU8CUlcoHyQlMtKX4ktgMxceFf19TuGLbPdPX1HM6YS2REmZKd87qKNNEce4I3m
         4wH9nZr58KWtAq8UIF+x/xHOOxVLHk4hEawBgBq1wuAhCcLlRi/udVG6/tEvdXPIQaDc
         XDEKKOSnRkVgXYCZNlIuvL1dObvWal2gWHjJk9mSiYFJX0sFlgyxMWO6uooD+zKqsPUo
         CcWV8+j1HUUq06GTNNeE7JQbJFoU/EiVMgCNrPzhj4nrRSsyp6ojVtlzY1FssPqKlJch
         PazA/Z1H6xoxRxh+PhlWL5u6hJOOWmmydJ40G8EVjND3wt8HXAMXH0legQqXYZUC5fxh
         +wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157746; x=1775762546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZCpjsHBmVImyRAJmholf3kR9HDLjfsy2HnHxQeXb1U=;
        b=FyWNSU77cZnQtmLNI1LSPiPStZNKPZb3EaaPcHQT3elfhksFkMLtz3+Gp1ul/P8FKF
         pu+0OvfN8jL5X8kBU8Aq9R6TuICLm5NiGF5qScu3zmi9oTqKfq4sZVhFlCBCiFttoqJf
         S3huOcS8ukA4dfmM+PV00BwZemhy0HoasVcn9lAc/tUjRWoig8u52l43wUiWECJ2JxDd
         D+z9Bx7betyUgsnRuVZozpfHk5sm60Hs5c2d+Ll/XyliUrz7mZPExnphDo2kMmsSc4wJ
         mXemgxzsI1EIRFc+8NE0tG9xYfPcWNJpzHBchuzn0JqlYn1y3ZIg+ztes+Paw/k5TKmS
         xxdg==
X-Gm-Message-State: AOJu0YyXDVuRL0cWCbzyMY2A/MVCseQP/LYvIn0g99NhyW7zGn/ReYxX
	4XJM9UgZ6g1LpD3co/455AIcW9fVp0BOjrsoJF2/5y3wn8rfBltjXoKgLXCbH4d1wHUuKsWTXkp
	qPfh3VLJFuxqOcRNaknj9RJ9KTsmtIjA=
X-Gm-Gg: AeBDievffbtQ1r8j2vPVzTBx46MxVpAIZqGnhsKzFnD9bAbsrxjD3YSHg00AbIG+Kaz
	bbx72k3/r7/D6n9bNQTnr11Wyg8XLDuxiocwa87DZC5vHwiJkAuzubHZKROgVGgnsK35wM2G8bl
	sXlylvRGKqXs9f5edJsTdAhAc1qGW/R4VK5TncsGY6XX+Xr0NbuknCVSva0RqIOCVU11g9n0zo5
	lpY0TO4Uc+8ERPemwCGQVijt/ijufERbKtf5gNmbvTZ7UpPacKrn6o1bSBtL253bz5uqUrQlw4R
	enNDn3DedRCLet0uHA==
X-Received: by 2002:a05:6402:3719:b0:66c:5a46:b7fa with SMTP id
 4fb4d7f45d1cf-66e3f2bde49mr169822a12.5.1775157745469; Thu, 02 Apr 2026
 12:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260402044637.73531-1-laurencerowe@gmail.com> <ac47PYPeL0IyRtY6@sgarzare-redhat>
In-Reply-To: <ac47PYPeL0IyRtY6@sgarzare-redhat>
From: Laurence Rowe <laurencerowe@gmail.com>
Date: Thu, 2 Apr 2026 12:22:12 -0700
X-Gm-Features: AQROBzB2-Dau1-MNR3xqc_SHA8HQW_z28I2FNnIn6XVrVmtXCPSjbV8KbrcIedU
Message-ID: <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with empty backlog
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:03=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:

> >Scheduling a timeout for a non-blocking accept with an empty backlog
> >meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> >of microseconds of additional latency per accept loop compared to
> >AF_INET or AF_UNIX sockets.
>
> Not related to this patch, but should we do something similar (in
> another patch) also in vsock_connect() or doesn't matter since usually
> it's always blocking?

Looking at vsock_connect it's not immediately obvious to me whether it
is affected
in the same way. I'll capture some ftraces and follow up after
updating this patch.

> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 2f7d94d682..483889b6d8 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, str=
uct socket *newsock,
> >        * created upon connection establishment.
> >        */
> >       timeout =3D sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
> >-      prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
> >
> >       while ((connected =3D vsock_dequeue_accept(listener)) =3D=3D NULL=
 &&
> >-             listener->sk_err =3D=3D 0) {
> >+             listener->sk_err =3D=3D 0 && timeout !=3D 0) {
> >               release_sock(listener);
> >+              prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPT=
IBLE);
>
> Is it okay to move prepare_to_wait() after `release_sock(listener)`?
>
> I'm worried if we can miss any wakeup. BTW if this change is okay, we
> should document that at least in the commit description.

I'm not sure. I'll swap them around so they are the same order as before.

>  From checkpatch:
> CHECK: Comparison to NULL could be written "!connected"
> #58: FILE: net/vmw_vsock/af_vsock.c:1870:
> +       } else if (timeout =3D=3D 0 && connected =3D=3D NULL) {
>
> >+              err =3D -EAGAIN;
> >+              goto out;
> >+      }
>
> What about simplifying this with (not a strong opinion):
>
>         } else if (connected =3D=3D NULL) {
>                 err =3D -EAGAIN;
>         }

That definitely seems cleaner.

> Also
> https://patchwork.kernel.org/project/netdevbpf/patch/20260402044637.73531=
-1-laurencerowe@gmail.com/
> suggests to specify a tree (net-next I think for this change) and be
> sure to CC other maintainers (scripts/get_maintainer.pl can help).

Sorry about that, first kernel patch submission. Will do so when I
send the updated patch.

Laurence
