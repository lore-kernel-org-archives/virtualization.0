Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F020297C
	for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763867691; cv=none; b=tsJqYb42x64eBRqnfb10luys7blOIOh8Qm9De/RX3g2SV4Ye0QIKH93VPKrJj6Wyz1OXjL7Ww5Gb3yDdXIbYnENyJoYeLWiuzV4xLMtwntppcbtUFx4SMdm9r1B9KA4QiSc0Uez+RpSCxo4CmYa88nQ0NKL2XFLwrm0zTNKcFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763867691; c=relaxed/simple;
	bh=nRs19Xsq1ucV508Y+KpD0MmfKZJfnRugxP+r8Pey/Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CE+ptbdCH832Ud1AMQFtgLaUiwioC4q3qLBEpkhUUdfbeyTDVkZydgrr05nXt9bc5I75yEJHBWTq2eXRXRKR6d/Xv/mDYi8UdcpCKrtZnbHw64CC15sdohpwOlEIc7oKyJASe+h5xRl+NFLYG9cMk/eOFDqI5K5dG9beBdfrrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlY48KEJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlY48KEJ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda6c385c0so26341681cf.3
        for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 19:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763867688; x=1764472488; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSUmOlF3E259ASbJ7NKM/1Z38SFWeY0yp8l6jgM+Ktg=;
        b=RlY48KEJb7h19notnzeJZc6kLLr0kVQngkibFc+3ebpRO1pZDfwxVXDZA8/X+orMGo
         pUhNoXqwHVomftIA2CwwjKBI9SZeIw+gNkiLiQg1pTQlnO2A4uZNmwEoWKE5kiTziJRr
         F+KLtnR3V4knUJ6GIPYdiLofqLS+W6Xt2zpmavjdCGKG9Q8/TUxKFZ9V/gvgmxZmRTUW
         T0EdxFS14mr8Oe14ipcXHGgU9huFF9qRLViid6BK0s0Gik8U2wQrGbh8bLn4ccW4Flvo
         mEQShyRtyoUDHSxn1WfF4oFoXFSAv6pK7X+FgcN2YtiQ7KtzOUUcOIKbu+sYo6knBs7a
         5PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763867689; x=1764472489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSUmOlF3E259ASbJ7NKM/1Z38SFWeY0yp8l6jgM+Ktg=;
        b=Orvljv/UrWS+L4sdAW79GLNw/kLcT6Qg8wrcH8S1CDCb1wNq8D3uLclTIfzv9x/PTv
         4bb074aBXEWJRdsxFmnxGaw2mIKlrFYyVEZHPM99PlkTt6q3pkmPr4AjCJy9C66f93GB
         lBYnPOwoHPFgLqanmPLRYnL3atS5uno5+xF7xBCLCvdwBmrm1uTSxokmhQ76aQh9KC3f
         +T0zuIUonCgxaF0xBzTaKy+5Jnq0YPfGwqGs2TYY+cxETV3yErX+ibVV0briDzwJrPnh
         1phSycils2fuvg/NkzJAFri0E8DyCeyTUuZfTHmv2q1yGrBwsUsfMnO84ZMaktjJyRmk
         0fPA==
X-Forwarded-Encrypted: i=1; AJvYcCV/DPivMEfV0SnXDyGRasz8B3M683uDBMxwH5ClyL4NC5dBC656oKcmW9hRtLvD4lbXhJHGDT+K78xBB+1qhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YylHWu45h04u4/YxBs9cVPbZUM2JX8OevNNplakD/iEaeR3Oasj
	TksYVfpAo5kmKXQHQiK8NVW7PIJBmxRKHbsOngbrBfmWpRnKbyg1AOVF1TNwUtUwhn58R4xP12q
	pOIfGJV5Fq0/tS3WUM87sT+3Kr8trL5Y=
X-Gm-Gg: ASbGnctStzB6vX4LMUq/FV00Asg+mFEzigxEPYuTCPXhu36onGl5jo9n18kcg6wi3gv
	Q5Z0/WIHCjIwK8GuNauxUvVC037tnkJirsE8181yNFAuxJFXyOYXBSww1Lig2k8fOIX6fF1R5G8
	yUKSDW7PX2ct3KccEq4tWlcx/VbI7+OqEjmP3NNasnLgiA2kAO6A+LOr8TQp8sNE8lr8qNfEfFq
	ohRqWJVXVoL1jhdV0R6NvJLUoSYX1K00cbfhRqWmbAMgyj7UdymsUNlSwXdC1nhH08Sjn0=
X-Google-Smtp-Source: AGHT+IGdga/kzhdwCVG7yVfSoR3Y4Mpj0tXp1Phothz1pnN4zZDpqFPu9X4DmFfSbiDItMnyiKDLP9Ui4prcpSBpeyE=
X-Received: by 2002:a05:622a:409:b0:4ec:ef62:8c81 with SMTP id
 d75a77b69052e-4ee588cb739mr81789031cf.47.1763867688428; Sat, 22 Nov 2025
 19:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
In-Reply-To: <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sun, 23 Nov 2025 11:14:12 +0800
X-Gm-Features: AWmQ_bkhV3WFHcWH6ezrZh5TyYLHctF2XYDfyBPe3dT3HiPXGugPAFouComClV0
Message-ID: <CANubcdXOZvW9HjG4NA0DUWjKDbG4SspFnEih_RyobpFPXn2jWQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E5=85=AD 22:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> > > static void bio_chain_endio(struct bio *bio)
> > > {
> > >         bio_endio(__bio_chain_endio(bio));
> > > }
> >
> > bio_chain_endio() never gets called really, which can be thought as `fl=
ag`,
>
> That's probably where this stops being relevant for the problem
> reported by Stephen Zhang.
>
> > and it should have been defined as `WARN_ON_ONCE(1);` for not confusing=
 people.
>
> But shouldn't bio_chain_endio() still be fixed to do the right thing
> if called directly, or alternatively, just BUG()? Warning and still
> doing the wrong thing seems a bit bizarre.
>
> I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> are at least confusing.
>
> Thanks,
> Andreas
>

Thank you, Ming and Andreas, for the detailed explanation. I will
remember to add the `WARN()`/`BUG()` macros in `bio_chain_endio()`.

Following that discussion, I have identified a similar and suspicious
call in the
bcache driver.

Location:`drivers/md/bcache/request.c`
```c
static void detached_dev_do_request(struct bcache_device *d, struct bio *bi=
o,
                                    struct block_device *orig_bdev,
unsigned long start_time)
{
    struct detached_dev_io_private *ddip;
    struct cached_dev *dc =3D container_of(d, struct cached_dev, disk);

    /*
     * no need to call closure_get(&dc->disk.cl),
     * because upper layer had already opened bcache device,
     * which would call closure_get(&dc->disk.cl)
     */
    ddip =3D kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
    if (!ddip) {
        bio->bi_status =3D BLK_STS_RESOURCE;
        bio->bi_end_io(bio); // <-- POTENTIAL ISSUE
        return;
    }
    // ...
}
```
Scenario Description:
1.  A chained bio is created in the block layer.
2.  This bio is intercepted by the bcache layer to be routed to the appropr=
iate
backing disk.
3.  The code path determines that the backing device is in a detached state=
,
leading to a call to `detached_dev_do_request()` to handle the I/O.
4.  The memory allocation for the `ddip` structure fails.
5.  In the error path, the function directly invokes `bio->bi_end_io(bio)`.

The Problem:
For a bio that is part of a chain, the `bi_end_io` function is likely set t=
o
`bio_chain_endio`. Directly calling it in this context would corrupt the
`bi_remaining` reference count, exactly as described in our previous
discussion.

Is it  a valid theoretical scenario?

And there is another call:
```
static void detached_dev_end_io(struct bio *bio)
{
        struct detached_dev_io_private *ddip;

        ddip =3D bio->bi_private;
        bio->bi_end_io =3D ddip->bi_end_io;
        bio->bi_private =3D ddip->bi_private;

        /* Count on the bcache device */
        bio_end_io_acct_remapped(bio, ddip->start_time, ddip->orig_bdev);

        if (bio->bi_status) {
                struct cached_dev *dc =3D container_of(ddip->d,
                                                     struct cached_dev, dis=
k);
                /* should count I/O error for backing device here */
                bch_count_backing_io_errors(dc, bio);
        }

        kfree(ddip);
        bio->bi_end_io(bio);
}
```

Would you mind me adding the bcache to the talk?
[Adding the bcache list to the CC]

Thanks,
Shida
