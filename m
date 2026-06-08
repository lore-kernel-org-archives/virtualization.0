Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92B30170F
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940786; cv=pass; b=T3SUNg8WEo4DfB8KI4iUSOyTOBrgp8rqHSgsoSYx5rpgEx8JMVWfcaSoRoStLWqHsu+Q/MJ2iqk7Gz2ExKhoweHYuHcZqeqi4vuVhnIZ2/EuiFjV6t1ses+B+5Ifsosp1g1+KK2gVDHHtfskaKhbquplW6Gx3YpIFd3tf8F1fvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940786; c=relaxed/simple;
	bh=0uT9yNIgAk/8+RqiGIhyhgxr89MaPNXDMlEgD8xjAWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+5kuvAyN1jJQxOI/GyypxfSukSCYuuiLCEGCtI/8dPPEvoHMC0gASVujr7KDw5eHSSNx8ga28rWicoyQPtpHbl7NYTlSLlbU17CYaxOYoCiT6DOX9ij1ZQ3BqlCX4f9JV9B4ASwQc06gmo70pMQvv2ibEE/P0KkxUfwMjZODrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=HMUq6AiX; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="HMUq6AiX"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69e84c9d196so683129eaf.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 10:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780940784; cv=none;
        d=google.com; s=arc-20240605;
        b=iBYt8TNn2Frk0ddMq6cjF4W7h4v+HYBI5yqwpNjkueTZIueHtj5JSIhY6jway+AuxK
         acUPzgbWEf32koBfHfhhyB49KOxdY/jb9Bf+W7jIclSJzeOYb9gJgVC1hILT+4S2KXj6
         rnCaCutilxs7rXB6gORv4uL7zBMXvDDOLnbuvyJqOwjxCuj71ZVqd1jxwbApk9+RRZ2J
         Z1CYTRxB9xSCU4kMZcRw4RbOq1FF+asIoBoYBB4OIM8EiIfN9uDnPB8QUzHIeeF4/TzJ
         ZURM0FxW40JsR5O25PNuYvZH2K0QQ06IPw2tOii9sv+GpbJ9UuwtKFBWHLQ3ZLNrrBoA
         q+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nurm0VcFWadxHMGIIRZaG/YNpWN0YfQDmN6L/EoaYoA=;
        fh=QmB6AGflpEl+/qBU45GRXe2J0VgDPDRZq3adesqnbV0=;
        b=J0vJQ3Fb6nTXJ2t0Cujy7y89S8Bh+LUgrdBuWYSQ9fLN5AHnT1Z7apYs+aZC29ab8n
         a8cNNxxYOIFnTjHcnWQeY/8KNYHwY6EaGfq8Gf3/la9WuTJBK3aEh+62wMcW//ReF4wd
         bQ/CoA/YxEm0VovuoYLffT3GAsYSTYCMlpb1nlkF2no26/t+fm1SK4qgMOexBX6IglN+
         G4M2azNyAt9j+U6IeUHpbNKhq1UM7NOZFnFVdMNgu8Lu5l3KaLwuVcHk3u1bfV45bo0+
         OS2L0c6GNlz8KLgU0c0N33AV+8ir+yz5ct0S0FLK1SQedWabDbM5EKGsVxG1MSyxH8TR
         zLzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1780940784; x=1781545584; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nurm0VcFWadxHMGIIRZaG/YNpWN0YfQDmN6L/EoaYoA=;
        b=HMUq6AiXSfggCLoXrM8D847xusmRP3ehUouk0FJG07y2L9CfyKemngViV12Ed6Q0Xx
         hijTN4RBSDZPjNwOsNvx9NFDHONU2URMtJYRzc10eycq806Pi0ZlPc4Rx5pAJwFmJO3N
         nWSikEyLJSLbj8Gd/S15bJ1jaW39cqAKZ4HmaVYlIt1SVm9DGmJO/+6H6YzBkJcXC1+X
         kJVqEzqna9WXz0P5SE7vy3ZH33hYzv9XOaLe3ULk7sQ11MQNpYOdkp2cnpvkoyxhFlvk
         O03usDBl5nlEzQh02Gy9+yDvUK2/+H1rTMxxm248liIpAlaUdDcQLDe9HumLVSYSOoGa
         AE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940784; x=1781545584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nurm0VcFWadxHMGIIRZaG/YNpWN0YfQDmN6L/EoaYoA=;
        b=LAaydxuGSwDs3OvVN6gl2sjRzkS0FwcQGHXDi2JvvJI+kgNZa0SegXEMsbAquo3UO+
         J/u6Y2LTF0B1IYYcIgKRFLTj2lhbFgH8utKNAQPdO06fqAU7GNYVLJBZ+QCHSTnYt/eC
         3V0XNKp4RVpoGa6ZhqYhueXFHzltwygUZO1sjWp+BWX+f4wDBEK6x0R07AV3YHhKGsmM
         pGkKyYus/s7S0vbsbeDUHJ26uXwEVQr/vNSEw5aF/zSlJyGaAxe7UfQa7Z0R3HsH2I6R
         O30UNkRkVJxg9TEy1MifKjfVFvJBUx9IIUswfZ6K0QhkJhXrpISAp1NP7wMS8LjcREy4
         wNCA==
X-Forwarded-Encrypted: i=1; AFNElJ/PxQLGSFh3Ts3yFbHHtgPIzCgZeMcT3hUOfwSIcIrqVLlVx/J5ame92wVhdO400ipt/jEi8HMUUNUoNTAPIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZq3GdX+aOTHr8wj33duQAzkbabS9ZSeylGBFj+9AEKJnr8xvf
	wC4RMOrQw66A59UC5IHnUxMNgElhyl61FAeSDfAUWnLl+BZ5jPVDzmKJJqOUIbZFiN57XsCY1qH
	qzpT2MTIAH73sDrSyamvXvmbJkis2TuLSgrKFS9gv
X-Gm-Gg: Acq92OHKyTUCnD4TOpOboWLdBPao10dd9GrxSEpTUt4cMNunlZvQ1keRIKs8/MKYyBE
	tlZLn+hIfralXy8rQQY+2WyveG9dLbY6Eo0vapdLmHIMif/xgLPNAzanKndzEQS79ft/vg6pUc2
	lq0opXPFXW8ls3dq4qGN/pn6Ebv8JQxbQ9eoMVBNX2Q68STOyKjBkerUWKKo87CF8kdbTKrb/ZJ
	tXIHC/TKdtdj+uY/2D7eHrFGHgCu9szlrEBE4kSwzGnhcu0gukP1QOGxlGVRNfzCPXd/wouWqWo
	rwxdycMvrFdnWWMugXpxzdKPwSzzLRHHmNvX+5hK54P249ya
X-Received: by 2002:a4a:edc8:0:b0:69e:2f7c:693a with SMTP id
 006d021491bc7-69e68b5096amr8980344eaf.20.1780940783613; Mon, 08 Jun 2026
 10:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260607143608.76122-1-gavin.li@samsara.com> <ars6vptfsifv3zvdbx2p7ihcw4rbwbgkvft3xpqyjbvkdckfzy@zxx2exbtuib4>
In-Reply-To: <ars6vptfsifv3zvdbx2p7ihcw4rbwbgkvft3xpqyjbvkdckfzy@zxx2exbtuib4>
From: Gavin Li <gavin.li@samsara.com>
Date: Mon, 8 Jun 2026 13:46:12 -0400
X-Gm-Features: AVVi8CcLftJeS8P3lA2_hIyMST_fRgbgPwFISVUdQEQq81kVuHGgYJacZdtgjks
Message-ID: <CAKvMnUUuqPPrPzkktdDmmwqjgiw2RquYEktoxGahNSGRJAzWpw@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: virtio: wait uninterruptibly for completions to
 avoid UAF
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Noted. I have sent a v2 patch that allows a hung process to be killed.

On Sun, Jun 7, 2026 at 11:44=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 07-06-26, 10:36, Gavin Li wrote:
> > virtio_i2c_complete_reqs() uses wait_for_completion_interruptible() and=
 stops
> > waiting when a signal arrives. virtio_i2c_xfer() then frees reqs and th=
e
> > per-request DMA bounce buffers while the device may still hold virtqueu=
e tokens
> > pointing at &reqs[i] and DMA into read bounce buffers. Additionally, wh=
en the
> > device later completes those requests, virtio_i2c_msg_done() calls comp=
lete()
> > on freed memory and can corrupt the slab freelist.
> >
> > Wait uninterruptibly for every completion before freeing reqs. This
> > matches how other virtio drivers retain request storage until the devic=
e
> > completes it. The virtio spec unfortunately does not provide a way to
> > cancel an in-flight request, so waiting uninterruptibly is required.
> >
> > Signed-off-by: Gavin Li <gavin.li@samsara.com>
> > ---
> >  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
>
> This is a revert of (and maybe better if that is mentioned in the logs):
>
> commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible comp=
letion wait")
>
> I don't think this is the right approach here. We shouldn't hang the kern=
el
> indefinitely if the other side is dead.
>
> --
> viresh
