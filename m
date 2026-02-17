Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D736923F
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343363; cv=pass; b=m9mzlTDIR6kbPxwJoPKLMXSND2aTbkx4Qkc+wLkzmEUECqQCSQYSe3zw9+yZzuTaEpOBZSSm6/HSET0/erbruG6MAKcqcvGra6quEGd86ECXpkNKb45VNMijPUUj7/xCPaKC6owPqkcryDTyFmkRpmQNMpm2CH4tKgCRWLWE9LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343363; c=relaxed/simple;
	bh=DL6R2tKFdN0Uez29EBRpEPY21UQJIMPKZkH7N6S2saM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3TRCaHC1MWkTikUjdaeOtfCLvwY/ymcRNPCsLeSgOuMjstGtRS/7uBhnvVq6vQbK54rSMvC0nGxmb5WLYRfpQSQ51Tji0W2VGNY4+8P3/CuthFvtvWlAk+xo/e3XGPiR0zAH2cU4Sz7IZN9m+wMWBBxj/SSZKipOsnLTV8fUfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgpGRSxk; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgpGRSxk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8860d6251bso532930966b.3
        for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 07:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771343361; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWumXcJqDNbbjepELmHwRiUKzX83RPOIFub1odnqSrTOeaAzeOjUZcRCzNMGfRTplO
         K5NUydzSdpNLByp3/aS4llSX5cQyRaYyQESqKszKib/eI3UCSZD22/+iKZ6IuqEE4/Za
         woiWAGzdVR3+cJSbSlbqbeLIcwLNlTpyoF52ZPBKLsZVS5YMJQHhf3kDwI0fADllwatg
         U3tuhHjpx7l57Yr0NcznzIak6z/CZ/7KPv10lN3ZZKmSnSQy+PIjf6PY4fuoY2cUgWXV
         g4oH6mQOpYtmQ8cNH7i6tIMM78h60eUKk+LZIFuyKI5LMjnUFtsUEWV7aYZUmhWSd7u6
         y4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoan/39HjVF3qt9+NYCQepGk7by5yTHWKMyqzAPnThk=;
        fh=4rRuYFDwaUdP/q4vONEn+CUtbL+YU7IyEg0+MgnlURY=;
        b=dqL59XNHBeYZDk8O7n5cbu/z95gcGvr4U0HiNIx7fyfRBTcDpaZQgeF7HkIdJodOGH
         blNNh81oelBUc6qWb/MsMd3ABjzbxEpvW+nWC+788SZsIhslYtCWtytIf5J4fFOZbl4R
         97kWTmgmlOoQOZVwgJuU4tOI1APUW/yyc9f1s6TAdzLVuGCAhUr+A4ItZgZJkeDTPMGX
         ragrE21QRUpH7yS5PLfzO6k4Q4+Qr7TRpyp8Gc/vnkIxO6VG3YCh1jTeloUd1oA/q4ur
         dtUgOQO0lohBwDbmtTi9EZqD6nO64lMXxuDNEWZFoKUtm5VM3knTSyhSgIW63oxrSnBb
         FsBA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771343361; x=1771948161; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoan/39HjVF3qt9+NYCQepGk7by5yTHWKMyqzAPnThk=;
        b=HgpGRSxkqmz6a30vx0i83YdpqLuPN9/fQnA2EvSR+S1Bgc3IK9aPbnwweiSAErHFr/
         SkkK9jiJmwc48vaYYXV0L8OXJUVtfr0isQ13AYt/VgrhX9HWO5WIZ5yFEhjxT+LrnEcV
         e1RySdSCTZOg0a2npz9vmwZc2WxCwQQWdW+OGdZlIBRWiJVGc89nqOo+pKw/+wsHFlDN
         YNkk/Q1vHOJ20xsdK0fExqEoPwCImmMPCbFYyy4Qb/cjpjYHcMGab6XKpxNE1292URxR
         PtU8SQ++RF0gUBWbHWrXLon46B182nDKL/vRufvLh08uHgRa0XvqYq5loT5INipmYuPx
         OF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771343361; x=1771948161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eoan/39HjVF3qt9+NYCQepGk7by5yTHWKMyqzAPnThk=;
        b=WmM3MhEUpPJHqh2NKeWm7fUHHwXAl4goHs6WxBV3jPt7nqOOoKfmkCDLWLlXlVTCr9
         7MsyfefvY981vObxdiFcaWwWTLyufgn1UjxZ2xIeOHW6thChkv9E5Xk8YgP0h3YtheKm
         WWl3UMPlqE/2/1fXNyp1Gtnkpj+a21sWW+3rqMIMWjyS5NXKR45bAjzZRIXi1LvVM1Je
         uymVumO6XVyM6X0Upz491TvhlT2VFa5PlKZ/SupQP/fy/s0xX3UWlk0kBCdAD9664+l0
         haAXAQ1yPhYGLP1oNeRA92sCIZ1tjxTuX2D38s7g2DrKG4ndwpMr807VCvI3rDZEozCX
         j5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVlus22dqy4OCvvWJR9zTvPum/tJIWWayaovd77sQHwl1obbv2lpf9vdIvhx4pJJnlrMaAughhvlG1EF6wJ+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWU+Jp1uSZIirwrTpAEq2/DY9N/Yj3Jip/na8pa+Lmw+8yTlxf
	ljxuN2HvNK25OZXTjm+eFzcKlb3+ahY86ka3GuRyI8by12+lM5BwG+INpoq5+uXHTezlSX7cC0m
	i5OR8TUQV1uDpBy8eN0zGqeo6O9U6Jyk=
X-Gm-Gg: AZuq6aLLA90lJ1CXZHsvibnJSnhy3SgxXu5FiEXK63IULQ4tTo0CpOF19Kv8xw0Ql7N
	7lQOtdJeYOfBEOeVxogDdntjcEvcT7MRfIn5H3EpA8Cn/Ctbb4CAg3e0AEjtbbT4qcC+lFnOjQF
	O0f7YR87n6uBFdaP6WYJQ0ZKfgQiYbb5szK/tMf6gaR0FscxVE52Uc7Sa0/BHDJlC+WuZokf9q7
	Mwez2JlvsdYC3z7vFEf8wyH7gP2iII7piRgNcjo7t35TLzWoq96SyYZiWkOZ5M7xnnnWKOHytxl
	wgG2Pw==
X-Received: by 2002:a17:907:e158:b0:b87:38e0:4403 with SMTP id
 a640c23a62f3a-b8fb4476ceamr514132166b.40.1771343360318; Tue, 17 Feb 2026
 07:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260216073158.75151-1-ytohnuki@amazon.com>
In-Reply-To: <20260216073158.75151-1-ytohnuki@amazon.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Feb 2026 10:49:08 -0500
X-Gm-Features: AaiRm52u51kxwpNseipcjIXVCf67FJxEQOVcnJ2EWlVmF9xXSFDFWy0iRQcKQZ4
Message-ID: <CAJSP0QWjbQh2XxNaY4+POf-auBTjW8SG4Fk1TRpP2fpT0_hf8w@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: add FUSE protocol validation
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 2:32=E2=80=AFAM Yuto Ohnuki <ytohnuki@amazon.com> w=
rote:
>
> Add virtio_fs_verify_response() to validate that the server properly
> follows the FUSE protocol by checking:
>
> - Response length is at least sizeof(struct fuse_out_header).
> - oh.len matches the actual response length.
> - oh.unique matches the request's unique identifier.
>
> On validation failure, set error to -EIO and normalize oh.len to prevent
> underflow in copy_args_from_argbuf().
>
> Addresses the TODO comment in virtio_fs_request_complete().
>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
>  fs/fuse/virtio_fs.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
