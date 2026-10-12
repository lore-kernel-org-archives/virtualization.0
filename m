Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDD475357
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799665; cv=pass; b=jslpuJfSudFouI3Zzr2ToWGZSn/aYR2cLuqiF8h60oNKe6APlUIa46+VVpaaFnK73eCUJ8ofONaX1YLfHvM+H2FIH3Av5Ky5tPyL27QdUpku5DGxx+r4qmLcmmZgjeAOIN0ufmn+XEowOuk6ximAIoTKKVQ+Z4rlAnETenXBVbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799665; c=relaxed/simple;
	bh=ngoSFJKCcMjqIKaYPLntMoiTZq1+aK2iDToLFmsMqUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf87xZoHm2S57eaRSsSnmCj9EBA6/B7S45QPalLAocky1R3hHHlnYcThGVJRcfVfvxobFLFdLuh6/sNQlBjgmxqKTBWVTCHWng6TmqYW0vxNhKQge1A/blY/p45ui377d5Flf1E28xN4n6FDRU4bw5MlVCo6ivRw2FTR5rOzZY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLUuzFVT; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLUuzFVT"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e503815adso116230885a.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 03:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791799652; cv=none;
        d=google.com; s=arc-20260327;
        b=r+UvltIhGbIKAnGzegkQOVJan2r7hrv4K5dGtlgRAGvfE8lHSoXlg3VT+UqmrDW3KH
         AZwhEX2DLFVbPQqHj/DT8BX/XlIVq1VbqelU/n5QED66g2dqDvqKl91wL/X2aK6sEh3N
         4Mg9RrECjh017Ghvuo0sFujC4dXnjpK06G9ESbUCOPmxNL3qc5kDxl3NBdDqVFkMz/N/
         S721p6fClvtdZGliMGcQ2B8K77jnzMhPWUaWERGVB3FLZ6qEMmwYZj7r3XcULW0HNS15
         QKq1275yLGZyyjfAapNiAszfDM0Ry8jmiCUjKsWcObifuILePF8N45Dr711s2WY80Y8K
         u1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        fh=ktpaYWxg8e+lxL6A3qi376iPZfaHQ1hmQd9KkWF4R9w=;
        b=hcH36no8sQMt169drGA9QRq0wlkdBIB2+nUU+++4nskwKGBOIHttdj3k9s9EIYRy5Q
         4+8xdrmmKYv3kGFJAGyf5yQGIsGnideelUD0LxjIJ9tZPkmP6pwCYLcAjpE0v/R0sHLh
         XgLPn2i1quNKAJtM9UfgKpFKJ7smRkSeLcCcetKJ6PDVry3a/yyp1gAi+IWWv1gQDPIt
         BETO9L9vmBqR3muHQfQtco2yqEGUZ2vc/SVeO661p18Yw1Z4dabtg8Wbhl3qbSv/0PP8
         fcMPYRKtXDAGRZ2AZE1H0NWT5r9OGTk3ktJ1IV3cfD4GONHMkDICWpvcB2KkSlNZmwPr
         GqXg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799652; x=1792404452; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        b=PLUuzFVT4pXHCLYwFawF5NVxQ0nRFNixQyotdGmnnCUxiR3XLHCm5Tgckisfgzu1JD
         CjmnLM63N8T2p1vCBAMdz6dG26y4ZZX4OeqDAN6T5zdG7kRFuP/pD1Anixaqfb/M70Od
         aAr3dTZ0vFP2aoTUIVYmMPTglrVb5emeymBwy/B0LOHeGg5SW2WShsyN0LSUjl13daGt
         txxxSDvIYf97MEF2MIaxy7VA+pPGnTy0mwUncbf09lxHKXnsRYR09rgwEkEVk00gyUlx
         qrSAkaTi2xFtOMIwNpz7vQ3leqR7oJniYBnOo7QCka/bzELelgKSjS5ICAczBTUHUSWP
         5U3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799652; x=1792404452;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        b=OeJeq101yf51QD0ATbMc1zEK5x6PmrZbpzJdJSKMwwlsc51ryBxtJVxCtuVdp5iVx/
         Lq5q1skdWXAMmokE08WYLYAXuA5y1ZSz7gkIAEwP3K1fC0/ZNLI9zfiUkpxszftcLR1N
         imrgsFn785KQHabFyQF3f6eqx0dVgGukPDf1TeBHswh14MrDoEJiC+OqpNfTD1shgfFh
         /qiPJHDTQyQdS/63CLeUdlyxOMKmK0FQCtgNMQcgGcMCaHWdvMv5PpXmrK9Ho7N2g55o
         4ZoyOJtF5FjLhgqzjg3sxeu/tLQZkhjCKOtV7LMQQZab2BswHROjDtNx9URZFb16fohg
         kNqw==
X-Forwarded-Encrypted: i=1; AKwUvByiw2w+r/vcpedGq+Qd+3cCvNkAUbNpTMNsJeviYgT0F/PMbHtvIKK44d3Ponkkuyl0BKii9UOi4Fxp8nK9Vw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIea8H2DtBb6mYFkYP8Q3lofuTDhRCRy4txO4pbnsnGmtPpmEX7
	uHIfSFJ4uzwoGeeFPjKWcFRJkpZD8vh6NqUv5KmhIotniyl98h0HlbMx28G9ZHr7VBHUQIX37XF
	nG6/VSNNYlTLX5PmtF2n4Fp3miP4RyAE=
X-Gm-Gg: AYBFou1RP1kjff1rzHtaI+Mva+INW8mGIWX86ZKK3iJx8WRHxmwKbup2dpMB8NYvSzy
	xR2iNLrkmcCOipL+UnAU4OmtsyR9T+Tyjr5ZBBDjUlOqM8Tjn83mMJ/cG22Ram8bUqoZA7mvAPG
	LKGNMk4WSQd3dljaXbsVzyyHMGyQDveVjKSQKovzZcGuaY28B0cxwdAo2hYVnoTFGD3sXqhItUu
	ueneuy4BxdlrZUTXFD5teTFAlMnJeKCZikuXRDpLFmUoviqZz6kkcD0qIDL/AshJdGj/mJvCc6F
	lAU3NJ1lnz4PltA41aWl5Wt68yAjWWVONP45WdIWc4G38ko0ZevuqLw=
X-Received: by 2002:a05:620a:1725:b0:93e:94f2:adaa with SMTP id
 af79cd13be357-93ebd1ff9e0mr1625320185a.32.1791799651780; Mon, 12 Oct 2026
 03:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261011014803.100454-1-physicalmtea@gmail.com> <20261012015950-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261012015950-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 12 Oct 2026 18:06:54 +0800
X-Gm-Features: AclHuK81b6ciDOyZt3Ymreum_6B8T825nAgthHuFC_f3e8ltpzVIpbuECAmYi1w
Message-ID: <CAJwVaM+Lw8kJRbpMrC29QZQeoJUyfCRvic32J2huZFFTyyjekA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Oct 11, 2026 at 09:48:03AM +0800, Jia Jia wrote:
> > vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
> > protection sgl and subtracts those bytes from exp_data_len.  The length
> > passed to TCM is still exp_data_len + prot_bytes.
> >
> > prot_bytes comes from virtio_scsi_cmd_req_pi.  With
> > VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
> > check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
> > data_length from the CDB only when the protect field is non-zero.
> > target_cmd_size_check() leaves a write's data_length unchanged when the
> > CDB size is smaller, so a command that does not get that replacement
> > keeps a data_length larger than the data sgl.
> >
> > The KASAN report is a MODE SELECT whose header had pi_bytesout set.
> > The data sgl held only the parameter list.  spc_emulate_modeselect()
> > walked data_length and read the next physical page.
> >
> > Pass the data sgl length.  Protected READ and WRITE still take their
> > length from the CDB in sbc_check_prot().
> >
> > KASAN reports:
> >
> >   BUG: KASAN: use-after-free in spc_emulate_modeselect+0x145/0x380 [target_core_mod]
> >   Read of size 1
> >
> >   spc_emulate_modeselect
> >   __target_execute_cmd
> >   target_execute_cmd
> >   vhost_scsi_write_pending
> >   transport_generic_new_cmd
> >   __target_submit
> >   target_queued_submit_work
> >   process_one_work
> >   worker_thread
> >   kthread
> >   ret_from_fork
> >   ret_from_fork_asm
> >
> > Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data transfer length")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> > v2:
> >   - Drop the claim that target used to subtract prot_length.
> >     9f977ef7b671 cites 14ef9200, which is not in the tree
> >   - prot_bytes comes from virtio_scsi_cmd_req_pi
>
>
> you can mention the other patches you sent fixing
> security maybe this will calm down sashiko.
>

Will do, thanks.

> >
> >  drivers/vhost/scsi.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..4bd29c2ceed9 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >                * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
> >                */
> >               cmd->tvc_vq_desc = vc.head;
> > +             /*
> > +              * exp_data_len is the data sgl. prot_bytes already sit in
> > +              * the protection sgl. Protected READ and WRITE replace
> > +              * data_length from the CDB in sbc_check_prot().
>
> this is barely readable - could you improve pls? even if that makes it
> a bit more verbose.
>

Thanks for the reminder. I'll improve it.

>
>
>
> > +              */
> >               vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
> > -                                         data_direction,
> > -                                         exp_data_len + prot_bytes);
> > +                                         data_direction, exp_data_len);
> >               ret = 0;
> >  err:
> >               /*
> > --
> > 2.53.0
>
