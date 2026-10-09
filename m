Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D6339394
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510913; cv=pass; b=hyZxZYbJmzSmSRJYfrSUsvsuxjLucxz6t4l+z/9N5eKKaK5Pd/LLzZ47sJkdvc6dC8bZlEHP4XnP45J0jKHz1C8TdG9eMU6ho6GCClVHJan7qWpe/MR5t5yVhQTtUymPbqgt3KxYLSguhVqtunZh8NLv0NsYiA2tW959keakILA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510913; c=relaxed/simple;
	bh=7FfE+Gjv/oitWMZfuNkc5CF1K6v6lHM3CtNTQ6IgqBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmhOMVbm4bxHWUnp8rTDfNRKvxGCf4MpnRKSJtW8qczyuGcDR7VsMbLfjvj52lVlqYasDVmcaoWRopeAijACjlVbRgk4THkdxOF2R038ABBno5AurycZw4TOQsWIdNya9E1W92CuP6NVcKSiPVJyADJnfaSBczGZYLh6WYzq5Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR0VDBTw; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR0VDBTw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-535179e995bso39582341cf.0
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 18:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791510911; cv=none;
        d=google.com; s=arc-20260327;
        b=Lcd9BBwudCxcZ6Pl52TD+F2Yb3f7B7pr6LZ9yloczAb/kqRrfjFyi4XqEB7jOdn5HS
         NKNzhqAZOnsYolTUjh7xVEhRFd2GizFcl4vlrVKj0YLWy3H68T/QVh0NpgnHDYbN4P+Q
         FhMHyornAd42StA4V1VzZ3uR7nbADfJ494M1SRbx+cdcMCqiPUXG52B9xGwYkOC9KQQU
         kRuDDxjGzj7geAtCjfSiM5rjG4ywJFjEB7sVLA0GAHc1EmezyN3RyjOt52IE9R97WCv9
         NNFE+HnNV6aLeYP/I48XcBTp0w+F0+9aT8zySHfRsTQIMaJyGppCVBTxl1WSKgdWxsrm
         UO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        fh=RQSrGB8qPe/KVZzIWPeumIJwcbmKIc4bwGILkSEyp1o=;
        b=IJ7ffEz8RDp0nhU1BQCBHnfwRZiLWXks2mDvLg8UMGklPRVTacJTOd9dTCZel3OIS7
         jy1xsM6sN4xPEanQomFSCcUoFOtq726m6LFl/qjgm9LyC9R5FhYBUg9I4BkFyxokw4cD
         z/Fu8jmTVD3kyXaxkXiNpjPYzyAdnU1HnvdlMXyKWTi5W73guDB5wTultCrbCQ/A5NF1
         OfTzTREZLZ0bIWIgu6H+BBE2gIbs3PQLKnbtwyKAyOFs8TPpqh1DjzCkpqhPieeJnd5J
         iWIX0Tz5FvAIVzoRN9ynFOQ3zZi+f7Lo04jpyBy2BiTWO175HLglbBFPinMLvFkSBBYU
         CHKA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510911; x=1792115711; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        b=OR0VDBTw/i4dalB/GpZmMPmcy0MbpH9OgrDfuCV9i8FpJJmeM0vHOHdaNfToe4FZuw
         IOuElWH9e9B3qSfjoIuk60n/2a6xhaXkpvA+W77MkE0DMcQSgVCb9g+MBuwkWAAYlilI
         oIIQoJnBoK4Qz+BrzaUyg/ISGypSpifJHmOlxwLsnjM+gDdGSeS9NWya5OrIWSGcna4s
         CHlPvlZFfJC5WEVh2+cSF/iJl/Jwd1o+nAhYMozeK3AX31ySrdocq0LL4brG7wZhSxe0
         z6XAQ4p+Asp3xAL4sPHKyfLBWLN5GvogDUIzYOAnua/FmmidWZgyXNSknt9vrIcfBu0x
         D9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510911; x=1792115711;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=irH5WtAUt7osstUCIXJbKMQBkmRxwYnXlK49ZN1iZhw=;
        b=EVqNydGMbFUm9uc+HJCbGwS83/JEGJ6sT0Nf1pf8JhlJuiFf+/dMks5fffj98IvY9/
         QPfDiERtfZM4lH6lzzCraeMZdbmyG62zp5rTdaEX5oe0EgjLd4CcHDUqY3SCRKD5A/ER
         ESwIR+IRGzuCHaJPOvJ5ChHvNt6Qm1NkaTR5y8oUBoFMuAyiJveVuVQskGkPVx9UazAn
         7BusrnLvGiGrZAnSlFyqHR+GYBbz4j9wIr+F6Iy1p36hjqmfpPoLSiWxIbYq2VYwYWkB
         sQSJX+H6LVHDHlzAMKaTJtTsKLynuVpPVRjL08fLmH1dvxNdReoYm48AyB3Y6doaunQT
         vKTQ==
X-Forwarded-Encrypted: i=1; AKwUvBynz2jb6Kx7zqHz3mu5K7bjrsxRWE7TlWbMcOAwsI1RsTvjGVppDzOIsX1O4pmoB5udvIlqSjrwBg3I9Vrwig==@lists.linux.dev
X-Gm-Message-State: AFuF++kUMXFseXATBWalL9tkkl7jOuaE7/xAJ+vpde/5SpW6//IpLlmf
	YDBug/fKRrBdwdHkUeD7DWOWIHK9rh3D7p7YfxQFlR8AZY4T97f0Co8rr3+agQi5Ykbkk9hvh9H
	NKewa7XlOOGhrjpLQjSff0V2xw0GBHmA=
X-Gm-Gg: AYBFou25xWSBn+Y21g4OcaXa9P8B+6rHNJ1T8vS0jlJ2JjtOLkxW1pYF338JaT+MT/n
	Gpjw4Q3CkNFnJnZZPyvvkYSyzg9d397fdkpPfSTBL4tH2CSa6SapLro3FBxYLe0iDWqMm+284Ki
	aop+CXtzU48WcUC03fs8k3XtZlW3HtYjX85qOI4Cc2Opoct0Be8amsugbGL1HCKvvG0dJnYYDuI
	a8s0MTXqPEa6r6XqJGV4j2c0WejA1TOcP7SjBroao6pZ+ZE7XbKSJp0ifYDO3CC7xnaz40liiW1
	zBmtxyxozvRg2lP1C9bzmHu95pQddchdNdMgwxjz9wSz6sN/Opf++kU=
X-Received: by 2002:a05:620a:4146:b0:93b:d79e:18ff with SMTP id
 af79cd13be357-93ebd4b3751mr66750985a.66.1791510910201; Thu, 08 Oct 2026
 18:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261006082102.27085-1-physicalmtea@gmail.com> <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
In-Reply-To: <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 9 Oct 2026 09:54:33 +0800
X-Gm-Features: AclHuK_8ZpspQbr1VUz--jCkNxAVH4PyEVkIwHKuXxRYnqVazc-zqTuVcZPApWY
Message-ID: <CAJwVaMJCgJYJP3Mr5V69cxFe9mNGmG+SNAeP6Bv9+cYc0vnr=Q@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: do not count PI bytes in the data length
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On 10/6/26 3:21 AM, Jia Jia wrote:
> > vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
> > protection sgl and subtracts them from exp_data_len.  The length passed
> > to TCM is still exp_data_len + prot_bytes.
> >
> > That sum matched an older target path which subtracted prot_length
> > again.  sbc_check_prot() now replaces data_length from the CDB only
>
> What patch changed this? Did all the drivers except vhost-scsi get fixed?
>

I had that wrong.  9f977ef7b671 says target would subtract prot_length
and points at 14ef9200.  That commit is not in the tree, and the target
code never subtracts prot_length.  The in-tree behavior is
e2a4f55c6498: if protect is non-zero, sbc_check_prot() sets
data_length from the CDB.  The vhost add has been there since
9f977ef7b671, in the same pull.  Nothing later changed it.

> > when the protect field is non-zero, and only for READ and WRITE.
> > target_cmd_size_check() leaves a write's data_length unchanged when the
> > CDB size is smaller.
> >
> > MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
> > the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter
>
> Can you have prot_bytes > 0 with those commands?

I did not describe this clearly.  MODE SELECT is not where prot_bytes
comes from.
With VIRTIO_SCSI_F_T10_PI negotiated, pi_bytesout can be set in
virtio_scsi_cmd_req_pi, and vhost does not check that the CDB is a
READ or WRITE. .
A MODE SELECT sent with that field set hits this.  That is what I ran.
