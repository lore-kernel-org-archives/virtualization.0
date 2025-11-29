Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A11DE8BF
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 02:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764384051; cv=none; b=VYilNTsFbkV0nUO0vHN4Lko3H5Wwh8vbT0BtRieV3Mvj4ZFgPwJKPdd4StSOqdl/Sp9kImYpP+L+MVgAE+Q52MeE5Q3/0vPhlF7q5FdN+jIq/qjfUoOd2OszKu33Db8zhkVM33VzhBrq7hp/L4idqAp+v2BK4Ss+8+EB8ixpm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764384051; c=relaxed/simple;
	bh=zHvwDf5Xq+iEVnjbasw1OMjmqc8Je/9Bg17U+6o9Pt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djZU61TWAm9p6oZXnkeNsXLz4jdCjI8grxsbBXO0vMcXe8mnoz/SoylJHePgJX4VR5qgg/4CBjquwzSGoDp0ljH+yn3yCA++zqqHVuYm79shJEVcXTDd1UF7/xgrIMH+TrbA9/k9QvKuHR1vgMpS57PaA0tk6l06kBaNm5fpytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgZL8W47; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgZL8W47"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edaf8773c4so28165491cf.1
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 18:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764384048; x=1764988848; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=;
        b=EgZL8W47vVSLSqHiH/oSc1B3SJpVh5EGfzOpAQCGTUiMWOO8mCVyksEdon+nLwoQVC
         +2NQaFSgscVtwJJ77K3wTj+54Eee3LLAwpuvLQ0f7c15kQaVwqXs5RyNFCyDXAaNq9RV
         psW511VozzM9bpoKniBxnkuMsSSDsMUXso6Pfe/cLLVM3etjidxQhxHDe2wgsbHdP7v/
         8ZBsXckhSFp+xuo1SvZhezfAZsWn/Eo09b2HOMJJu1zo+VAO+6OKaORNM5EiKwmd1iYJ
         C/NW0QN07fwYrVNQRIkRe28uueUg4fybgeExUEkRXlpHpRjUQ2uPIutCmYurxvJWMdEj
         BYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764384048; x=1764988848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAPySlCz6W7rFB53xcBPcWM3i1+fAM460YdX4Fw6oEA=;
        b=RLloazqwOmWBgj2t5LSO05stJ1b4kO9s/nvl/0eIxga3R3IPQDSpDKEhecivEmFVoh
         Syl7Khp1+z7cFhtxE4G7hn3EMvWRcAIvR4fAePMKRlZYBRurHY5pJH+TB6Aeo+w9DT1S
         jSN5EZt3wwp9isDORsgsdPEv4Jb+MMFdL5dAmRSq814YnEkwg8RwRF3LHKJLo2ifY9qF
         rq5gCqf/as4Hv9aHPxFR0ycvdrVTTr33drGJFwOQFji3ah3CYf8Dvszj3KHdWq/yx/2C
         LwyXvBNLTFeBQSY45hxRvLGGbI6g4QpS50lu1GFe6+WM979NzI9wQN3iKQrxFc/ZqQPw
         MIYA==
X-Forwarded-Encrypted: i=1; AJvYcCXiveR7smXAgzzegHymsabbewXJVwv+2fF9peCu/IXJOJDMDxYTPuLCypL9bqIyt+aQLUdwuk7CUHXm4DbYfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY6YdQqZrGR3ctg3ukFmRkedrsLYKm999epf3vbgIhgArPJyl6
	JDLassSAmLPTMB2IdSIiulJ7rErxaGtnkRCnxwQt/XyG/rt0GzuirCoKZJz5prx4YHaZ5FS+4Zd
	zppkcm1VkryYxUg9HdVUmj0sLz6pPlmk=
X-Gm-Gg: ASbGncsHjIvKhRHJ6vieGAf5czPh9o/SMAXoOuOWwycEghl5AuBnipMJyGtq5wB1KtT
	qOKmYp1Pos23JRA1H6ET0TtAP2Js1VGboeuMYgc7UPTrBthJzXhAB9HVJGu4IZ5oYQXqjzFS2XF
	JHtKpyL4JU7UkUBvQQJtYR+gKNOSMdqu5/VInsj0mAtHB6G4fbDze7mumiZPGzzO67NY7w/r/6l
	AwqfcCoiUKAm5LWKJWCRIjPmdMk/+S0gWFWvRxb9H5ATY+HWFnAsBeeohAzXUYiK8SIlg==
X-Google-Smtp-Source: AGHT+IEc3jQjTSh2wGwA1eyD2xP/eWtKWxB49pbTJ6uDNzgYaFeaO9lvwOhTEy0qjR7rLP4x3OvjjW+3HSCvva4PQqk=
X-Received: by 2002:ac8:5753:0:b0:4ee:1b36:b5c2 with SMTP id
 d75a77b69052e-4ee58af12d0mr418152811cf.68.1764384048425; Fri, 28 Nov 2025
 18:40:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-7-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-7-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 10:40:12 +0800
X-Gm-Features: AWmQ_bkvl1bn1ab0FbiQv1s_-KpnO8A0jbXWmROhOJd-0tcEov6J9fzUaa8ydUI
Message-ID: <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Replace duplicate bio chaining logic with the common
> bio_chain_and_submit helper function.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/gfs2/lops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 9c8c305a75c..0073fd7c454 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, u=
nsigned int nr_iovecs)
>         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOI=
O);
>         bio_clone_blkg_association(new, prev);
>         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> -       bio_chain(new, prev);
> -       submit_bio(prev);
> +       bio_chain_and_submit(prev, new);

This one should also be dropped because the 'prev' and 'new' are in
the wrong order.

Thanks,
Shida

>         return new;
>  }
>
> --
> 2.34.1
>
