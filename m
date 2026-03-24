Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4648CFC
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316874; cv=none; b=Gz+eQ5ys3wtO4UY4zrHYE8Kt3beBwZG4xrlCI7SuJpebMqapTjO5Si3g6Jqw8zZ8EZUcxiA/DrMOWgloMIOYIYS0iszkb3j8LZgOhW26uKGKIIQR8W7f+Ej3dlTnWZk81PUfLbAPlnVNkBVDxNxCfsYFMdwK6/j2HL4SzY+9cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316874; c=relaxed/simple;
	bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxciarS6PZ5iy+CkspBSrdp6TkmIHCiEGs+BfwSQ9Zwk28JEBNBKET493kEIyPOOAOZe5yPRXOL0gpIrNY2H6rX6C5ip93LC5q+sqMg2G0979vLv8etuwBt0qCYXoS3QALWAPF5+JNR0dS0X1gBNa7HlF5QHBkf/Czfg0uTGhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLbq131X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLbq131X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
	b=OLbq131XlBW3qHoHN1tmJDaFUiBCfG4wtRYBoauYBEhlYw42h1wL62CryyCFvFt3+nd5A/
	M/tFTfFNGI+aP+8oDUfltGPsylcXSU2FS6wdmziGJfPFJ7TAWSvG+cx5mna8m4rfRwnVFw
	/LnxkdmUdmmZmq+NLRTy+f3taMT4FKw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-g2I02cNNMpeIGVccEFG9aA-1; Mon, 23 Mar 2026 21:47:50 -0400
X-MC-Unique: g2I02cNNMpeIGVccEFG9aA-1
X-Mimecast-MFC-AGG-ID: g2I02cNNMpeIGVccEFG9aA_1774316869
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3568090851aso11376773a91.1
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 18:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316869; x=1774921669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHakrfcm+v2PDRLfzUe4bmyaSfj2RKaJS8LjXRRBJAU=;
        b=CBOWGmTxGndj/WJjuioVnMUz+uDsbRNClAWurvcFeaZPnNIbN15ujPUngfX1S0faYi
         RDBYCIlnQ5JDHahDMWSyR3JxELi6P/zjM7xSrTAGPYwFlcovENH1FTb6BBO8c27PbDG9
         N5cnkBofW4hbdUEefxEXZvGiyMko4mOnOZuL0i/bvnfAG6ggA+qC2m1ltYoBKVMzCDZ8
         Z4dCShUcAwG2yHgHLcWScjr1WtDreHNzFynM+HuCb+MkufILqsBwbGhSTBkYWLG7zAlL
         fKNjJCbIDNex1yzxK2R38TZHU6kVqC1wflzJJDHp8DgLh9bR8c4UFv088Yqz2+oAjvHL
         hyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKvypKM3IvTrPgME3sWZO67QZCKKo5TB9EOlg3zYYWNsnEenOE4u8DAItnhboIzIXEkLZLjXs/Vr1q9Kzcng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkHwNfSY1cf64wGh91DExn3sH/kdzOchbk/nPFNaGgKe3FQ1sZ
	z/kVkaI7Xzw8l162iitt6UDrEI7yMEA2iuO8iTY5KRQd10A3xfC0UTn4V4Vyv+hcuO1TqbWTyeU
	gSlMTmrDck5RvXGAImuu6GFuVmbFNbVXHOUhhQrc5QEHFcWVG/9N+dOZ+ogfCnl1ICH1BGZfWQy
	zy2eSDD76yxlhlu2fya5gmiiUBw/LN3TbO6bdXvQJS+Fw=
X-Gm-Gg: ATEYQzyLVt4FJcOymDqEWk4dfnUCK47XimtK2TFFKl36cb6Cw71M/2iCrD4wHaBgLG2
	CTURRsBcv8bGn2uqe92l1Ay+DrHLq21rIBFYsxcd20QgYYyzZ2XCdegOl+pF+uy8HgXxaDP9KsK
	cH2/s2jGAbh8ohDhwvvkxbCmw8dSyQgB1ZJwWJHIwr78RplGteVAxRv/aoKnUn8A6J33MozPMpC
	UN+Yh8=
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id 98e67ed59e1d1-35bd2c69ef3mr14096625a91.15.1774316869509;
        Mon, 23 Mar 2026 18:47:49 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:343:7714:4ca8 with SMTP id
 98e67ed59e1d1-35bd2c69ef3mr14096600a91.15.1774316869084; Mon, 23 Mar 2026
 18:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-2-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:37 +0800
X-Gm-Features: AaiRm53pbYbqwGT5VS_08JhQ1nrnThR4mTQx66_GOYMi6H_pXUhKS9fZsNHeN9o
Message-ID: <CACGkMEtYD8OL-4XyEFaa4hhBbki_zmcywkqa7Bd-1J2ZMB8RoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/4] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HulmjLSRk3NIARTgL8N8CRURJfkq1bM_Ptzcl2DzLwA_1774316869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
> __tun_wake_queue(). The latter wakes the stopped netdev subqueue once
> half of the ring capacity has been consumed, tracked via the new
> cons_cnt field in tun_file. When the ring is empty the queue is also
> woken to handle potential races.
>
> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes no regression for a tap setup sending
> to a qemu VM: 1.151 Mpps to 1.153 Mpps.
>

Another call to squash this into next patch.

Thanks

