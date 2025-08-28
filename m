Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82E18E3F
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340200; cv=none; b=iQGskhS2zXZuAA27OHJoSaVMsUCikEBNF2gMZGSU0Q0o0FNt5zz843pQuuXUVzCDio3j2cfBZbA/tzGm+3kuZxCsfQSzYt/8aQBe5oL/DFrnVEiAEmBMAEGCoh5VPXy8jVFS/3XYSXjpanQhLC7Cv7umUPh2b0FY9ZvmhdTMA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340200; c=relaxed/simple;
	bh=DRQULrR+FB4VYruNOuA3H9WZd2yskdckg89UGJxtXNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkNg5fPzCguieuOoI1JFtl8+lCcfXIUySrz8IqLASjkUcg0fumwwAfz1M+bj0C3Uu1QrtCEqwZNwCUhUWJ9mKtQUoAcrZBe5gxlS/4+YgoNJmFDZbIExkVhmsRYA7BTz074I3dJdRuIeYS0NZU1ki7XLj12IV2movaPM4GQHMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwvOPlJ5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwvOPlJ5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2461c537540so4778105ad.0
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 17:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340197; x=1756944997; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN/JTBUQGojSDyUMvLZLw43SnOlQ5Fr1I8L6kd4ekdw=;
        b=UwvOPlJ5MRFGcHKk7llnIdBb6ye3pxzECZYTI4JNrq/aAXd39dtDFBw4VJu9qfJmDZ
         M+WjzvVDZrqc2dpkg4MBNoO5OissUW6ToRoA4s+0edFsTfDPgrg7wgDyxZR+sNpccowW
         NPYS5QjdNFuoD7GKcqZA0AvvdcAVLszRXF0d52ct9gypT6Ld3co/4VFTca9bkj9NREv6
         YZaZyakJNck3RMrIz5FtXEhVJOmr8L8f9ag6OlSe1N1+W3iQkTffSNiSx7dqPmG2HdOL
         2A8iyYGRctVTF3HEdZakI3wWHLzNmQl9DSBgQ+7MM9Izk6OsosHfdpMsdWDAIyYNGF+8
         af1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340197; x=1756944997;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gN/JTBUQGojSDyUMvLZLw43SnOlQ5Fr1I8L6kd4ekdw=;
        b=l3lphKZtdGa2sop/fbvDbtJRccrytgaEux4CnNRFFCFG7FHm3NnfokCncbGIp9cKp5
         TZCnpuYGWEMHDRcNo3oTGiicrQLJQAPbjJDHCKC08H8EK+mYjBcp5hnrb6GT2QI+4fE8
         qy28LKKuFN1739yrHW1SV5CbQf0qRETOfqFMM+IpYPuqu8FzEmUhlI2Aawq86KqTW55Z
         JSFC/TkRFWXwTflAqX7ah6omr/g10pcnRd4Xa7cIbGWPDNkqUsnDNPmpTX3GEfZZHu0U
         NH+aMYX8bjhA0rVZ2LU9+NnxHEoZhOCtnzTjYJUVPS+2ru3VZkTwvoYJbrCMkFePZwZz
         Jgcg==
X-Forwarded-Encrypted: i=1; AJvYcCXbt/CEV0bk+l7SOmZhwHtssB092X3twl92yhsD7IxPzTaAK5Dx7unWl7RGz/PUrerBIJRBrWrYq4A2CFYtFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO6gsk751RaBlE2SqQzGclOO0gNc1wEHDKF0mTJ/J8mguNRv1S
	iSQjn+6yXMs8+O17hSf7fNDPj3HW6o+BKAqF4DE1hd/DRHEUK+IrPXpxinlUeQtXF3CSsjwFbrf
	/sZfpmw==
X-Google-Smtp-Source: AGHT+IEeaZ+vZ1azz2+/JevayRHNowIgRsI1vZgWUZcfRT1k7jmZ4DcsJTv92NsfT4neFY+yGzMEa3j4/Ro=
X-Received: from pjxx6.prod.google.com ([2002:a17:90b:58c6:b0:324:ed49:6c92])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:246:ae6e:e5db
 with SMTP id d9443c01a7336-246ae6ee847mr198532435ad.42.1756340196775; Wed, 27
 Aug 2025 17:16:36 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:16:35 -0700
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
Message-ID: <aK-f45qszH2VEzV7@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
>=20
> Sean,
>=20
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical=E2=80=A6

Gah, sorry, I flagged your earlier mail and then forgot to circle back to i=
t
(for whatever reason, I didn't entirely grok what you were suggesting).

> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
>  		return ERR_CAST(tsk);
>  	}
> =20
> -	vtsk->task =3D tsk;
> +	vtsk->task =3D get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);

Nice!  This fixes things too.  Either solution works for me.  Or maybe do b=
oth?
Attempting to wake a task that vhost_task knows has exited (is exiting?) is=
 a
bit gross, but even with that hardening, guarding against UAF is very nice =
to
have too.

Tested-by: Sean Christopherson <seanjc@google.com>
