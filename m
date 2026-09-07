Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF633612F4
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788824601; cv=pass; b=eDALLrLW3m1jrixv5Q7ZqWG9AmcJmGwfQHXNRpyBdAuXeBXblEZrP6q/9bPAsrl4C/1Ktms0qkdQt4Gd697Ht1htqD/iUTUsbH/1bTXqNdIZNNYEO90+gMpw/s6H861vl/E58BO+8xn/FlhWfYOvRV64HFj9Otumn93IGXwS/uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788824601; c=relaxed/simple;
	bh=bp+y/xqf7Ay1nNogINVSSczJwWAzJ9Xme8eB2Onekgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4lN/yWH5opoz4/YNUg5fqlRv1iYDEJG62BU9Q3Y0GAjr8y/Blp9WGAXzdrQSnNffMJ4VKn71hgooforTOzwtIXTbpRMgZqsk/te6iKqgaq0cJ0IpUv9LrPUABKK9gCawvjS+kI+3Sw8a6apftL80m7+4FAcPGC2I+uJbBnREac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=stellman-greene-com.20251104.gappssmtp.com header.i=@stellman-greene-com.20251104.gappssmtp.com header.b=aNiK/rLs; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stellman-greene-com.20251104.gappssmtp.com header.i=@stellman-greene-com.20251104.gappssmtp.com header.b="aNiK/rLs"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90cbff85fa9so48224386d6.2
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 16:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788824598; cv=none;
        d=google.com; s=arc-20260327;
        b=ZnPeJoQ3VpEvAgOaoV0MqYOLGB861yswPwIepKhRP37LrTDb2HD99v6B28qmEDs41u
         3WSF/Xg10Xi0Fg/AQv0y8HW3ktx/CBf88mE+JlCM4FEVTKESxNkKVFeDQ2KI2fSp0zGs
         6ZEX7Z9DXsVMFgSjEfVeRgw9aBm4KA4j+rwSIj7NXT00AZpXtd19EMshN+ZMOWSiZoO6
         htiRaaD4eXsKCE3ujDq8ydxGofyJVT3vgIjHctThhKDnknqORt7+Ijjl7PKz9PkBnGHY
         taBDKgfqEHNU6KpvgvYOoSOQ5AfxQ0Ttp0vCkhp/fVYvm5V1X/SY8SQU5Kz2J3aih1yq
         er1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDvQvRYKsjAddeL6GV3BdKG9dlLviBRCTvmRDdqMCts=;
        fh=MombrwciQnrfSDbizQdmLb4vutLExc/QhP7AFY5j6Bw=;
        b=Ep4sYyOvpk+2/6V2Lt3AaZzo+P8b23v90fwtrohpMZn6h7eebrCBIZO+qH/XYjAdIw
         FU4nZFhjh7q+7JJyc9HHkRF9kMO4dkYf36ijBp6Z6Ecs8RaZJn1oKwWTjUbVMqLBlB8D
         a80myulERCsotWuWq5Qu9HGFZv7zuVVLi3U9Y/fOFHExY7xHQfANEmiiQEeU4mIsfEKi
         H+cSVFUtCRxHbqRKd6zJKJKlsVCJQxO3rNTpDuQpo5Okm0ukSC/AoX6JgsQ1bcJhSwiR
         G9zwuXaHxeCtQMMnJ85ok4BXJySniYc4V2I3d8MsYJVl1J5sJd1oVeMNYiKHKevCdSnn
         cO9g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stellman-greene-com.20251104.gappssmtp.com; s=20251104; t=1788824598; x=1789429398; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WDvQvRYKsjAddeL6GV3BdKG9dlLviBRCTvmRDdqMCts=;
        b=aNiK/rLsM4evebCx/cwCwO5EnURrEC/8emVmRdXKtabevMYPKwVa+tuCP8WDu4LHc/
         snAByvYpUE7b2skr10T0jHxjl2H/Q+3Qmr5VksbcunlAONkBJpQMH/Z7/6NOHQSSpsV4
         xPSC95F4C13Q0MZKFoz1dHdTZo+ZdlcW/D5EvbFTXQZpqq9xh4e5TJtxXNG/fsiBZ9ty
         HvXQzn31Clv7dRCRzw4pz1+DsrJotpvuiJ/ZFPzfq0X+eeZd5C1jj4eD29uDDd/T+pSD
         7MH7zWT9ktXU1FFDMGO12+rwkwLxQoyJ8N5JJY8ejTbDp+rkVFaF01jnnJCZbrYDXm1A
         lgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788824598; x=1789429398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDvQvRYKsjAddeL6GV3BdKG9dlLviBRCTvmRDdqMCts=;
        b=Yc7L4qt7tHdmZNqXgi8rojLCQyWfEJvo3dE9AB2vasVXkEqhG+GY0RS0m/fmM2cTgN
         Xcu2U9JVdYwxxxEwfKDaTBvZIbjXy6xzPBENHXea3gLLGMMJXjE2IOX0F7P7iaevTAIe
         h4UU9VL1/g+CwjnATAPp7wzMsWbxRkKC7GCbqzeKBZqlj9DfZgRFVoNM71V7RYEjPEI4
         cSZ4jQnz5NSGoc9g/r54YwVIhC+5Of3BGkdylw1qYU5Q0LoGl3Tl32YSkJZl/1/rwsvX
         mhRlV3iGyDBRCY2gMDamyQQuK3Act2/s47+L6E9uvrBgYgdkSnU1X4AVjs6dr7nwbYPl
         Wgzw==
X-Forwarded-Encrypted: i=1; AKwUvBwSC86rg4pHg+OLqsqp4lcAwdI5w2GjF+o6dg3Xwgyad8NK/FpBA9P8OGGrsTbPBxAFigJ3tZxaOTCgYQrnzQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k/PsRdqVF9jDaL2K5csUje3Zy/xTaVj2SYu2AiVt1DLQToaFXp
	RoZMCKUxfyjtQX9A2iV/9m9H9cpwdsZjHwb19Dbg8FJ6pEsnSqidEzdYu1AZT6dYuYBwWxy6UWc
	Vm9yzSyHlB6sU/dfC2V/zw9i6n6K6lqo=
X-Gm-Gg: AYBFou3LRHtMB9xuv9djMBlX9a1PiAbZNq6UBbv60tY5n30B9C/SDijcNJW4Fr/zuaN
	Zk/DgTOHBsweRo+J5BsT+DvABldTsu115JRU/bgoTjhrj7hGOBRDPoLppYJhMrB0bTIMtvVY/qM
	Y7zOUl6fuAkvuJBpSSvgD+8p1MrPdunqw/dQmwEFE03/neTUnvnxl/U60oWygf2Su5tQt1tXAsO
	g7pOSs0IcEufwrbJDSJlomVAuNdNXTXRPBcUINEUTNXnY54IuoN8AEIyQhD3oZB6LyBgyh7p0E4
	RFxyj+YL8haagVETXQUlQiXKH8PxFSxejc0djjNHJ6neCJrSjGs/rcykmliXR7hbssNKu1AX0ft
	agI68Pk1Nise1U+73ByIK7WUPxqCBsaNP+2w4cZEsLjfWngBocHS6yC/7VTELJUzNLzVQsF6HXI
	8v/3T6V2AZaVKKrdc6euOF
X-Received: by 2002:a0c:f119:0:b0:90e:9690:2c96 with SMTP id
 6a1803df08f44-9103ef894e3mr258777306d6.23.1788824598131; Mon, 07 Sep 2026
 16:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260904141318.30278-1-astellman@stellman-greene.com> <20260907174523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260907174523-mutt-send-email-mst@kernel.org>
From: Andrew Stellman <astellman@stellman-greene.com>
Date: Mon, 7 Sep 2026 19:43:06 -0400
X-Gm-Features: AcwNN1Vr6aokeJ70RLTa0bKePsQdGSScAWJo8sHRhYeyU3-lbwbLscwa2SYbqZ4
Message-ID: <CAChPuV8M9EU1ji27Xfd66Vr9N=mV6Nsem-6CdWKi3tAwNUj_cA@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-pci: return IRQ_HANDLED after non-zero ISR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LLM was Claude Opus 5, agent was Quality Playbook
<https://github.com/andrewstellman/quality-playbook>, an open-source
code quality agent I maintain.

One request: unless your version is already queued, would you take a
corrected patch from me so the commit keeps my authorship? Having an
upstream Linux commit trace directly to a Quality Playbook finding
would mean a lot for the project.


On Mon, Sep 7, 2026 at 5:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Sep 04, 2026 at 10:13:18AM -0400, Andrew Stellman wrote:
> > vp_interrupt() reads the ISR before dispatching config-change and
> > vring handling. Reading the ISR also clears it, so once the read
> > returns non-zero the interrupt was from this device and has already
> > been consumed.
> >
> > Currently vp_interrupt() returns the result of vp_vring_interrupt().
> > For a config-change interrupt with no vring work, that can return
> > IRQ_NONE even though the ISR was non-zero and the interrupt was
> > handled.
> >
> > Call vp_vring_interrupt() for any queue work, but once the ISR is
> > non-zero return IRQ_HANDLED.
> >
> > Tested with QEMU virtio-blk-pci forced to INTx using vectors=3D0 and
> > pci=3Dnomsi. On an idle device, 200 config-change interrupts were
> > generated using QMP block_resize.
> >
> > Before this change, irq_handler_exit reported ret=3Dunhandled and
> > /proc/irq/11/spurious increased from 0 to 200 unhandled interrupts.
> > After this change, irq_handler_exit reported ret=3Dhandled and the
> > unhandled count remained at 0.
> >
> > The issue was found during an LLM-assisted Quality Playbook review.
> >
> > Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: LLM
>
> tell us which llm and which agent pls
>
> > Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> > ---
> > Changes from v2:
> > - Repost as a standalone patch in a new thread, per maintainer request.
> > - Add LLM-assistance disclosure.
> > - No code changes.
> >
> > Changes from v1:
> > - Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
> > - Add Fixes and Suggested-by tags.
> > - Test the change with virtio-blk forced to legacy INTx under QEMU.
> >
> > Full red/green test logs and the tested v2 patch:
> > https://github.com/andrewstellman/quality-playbook/tree/11ba61d/evidenc=
e/virtio-pci-intx
> >
> >  drivers/virtio/virtio_pci_common.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index 10371ecbc054..b90c174450b2 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -120,7 +120,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaq=
ue)
> >       if (isr & VIRTIO_PCI_ISR_CONFIG)
> >               vp_config_changed(irq, opaque);
> >
> > -     return vp_vring_interrupt(irq, opaque);
> > +     vp_vring_interrupt(irq, opaque);
> > +
> > +     return IRQ_HANDLED;
> >  }
> >
> >  static int vp_request_msix_vectors(struct virtio_device *vdev, int nve=
ctors,
> > base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
> >
> > --
> > 2.43.0
>
