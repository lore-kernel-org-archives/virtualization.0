Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D015DBBA
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388388; cv=none; b=FCKiGCsC2V80PqvckaBlXYQ+pXgQnv6lzM7UGY/ygB7q1jjx0aIJMCD1DExjHAFzoSAOna4TknSBICN3RE+ZtoZayEntZocHDURpr9m4g9HM10f6hKAd/A1SZUIOCsw9a0u7DLHX5Q+GlRtySqQLz2TdYRJ5PefClgDCDzwaYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388388; c=relaxed/simple;
	bh=JuAsj2Tbl/OWer8t2wU6SWUjZ2uesn3d9LqNBzezlyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAbCAn5eYj6Qw2JdVdWMRWRub1/cG32xL2DjsX6D/zUG6elOlRyfia6nsa4I/sOogdyIw5RRgCgPNpo8mlcwGOwdpwCeg/WxV7QrSfmUARFLvZCnwbVt2R7Yc8HKwNIfEzg6DRuMebqWfF6emGSC/z5AEjhr0g1wZw6k7gpc4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tv7qUYp/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tv7qUYp/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-361785bfa71so4875795f8f.2
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719388383; x=1719993183; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7TrvJDXFsC7eGcJQl8nHDqo9X0QhZtH7cZCOFIZc/50=;
        b=tv7qUYp/wjYvWkO/MZV+XUzkM8Fz5Is4+AZXs5kxm5mTDmIEcjaTMrBY5mZUIszmtd
         NJ8isOweaaaqlVrsQuRYaiGbL5m7/zBWHSO3vAkZnNku4BA2+EHGDP0EYbhtStWCanCs
         6t7aB3va1v+azv0ynY7PgXyU/RzNrx64Ov+rZUeKCf/uaamnc+hYcMgrABXF+GQA2g7+
         E1i8F010PIaGGmGZo8+KiI8A005AT1QNJnu5AA5SZZQRo1fMB2ujTtJaCsEtMBZG27m3
         v+N1iVNFBmbi88eUS75EHqrhrKLgvMaBt7O3KcLYwKIQguO8mwZVQXuDas9HXkc21HGj
         sjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388383; x=1719993183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TrvJDXFsC7eGcJQl8nHDqo9X0QhZtH7cZCOFIZc/50=;
        b=wm081YAKHb9j7RQ4elwbIUD/WGfz0/WJBdGl2/BPOY6ktynfNeMDRxga9U9FakCg5I
         /XvGvXh+EsjcoDMvXUhesx+eB+Jlk8iSJlkV/kggf7pBB7AW1lOUiZtrgZJ/mGO2tcSW
         NKjJZKPN+5A0ENBg4DSrBpVyr2dd1z4B3cR0qZpoeNslj8m276YmVZlpG+Nf4fDJS37f
         EsT8cuCzXZKqC48s9hnL1T/blfq2QkRKYAFc/qljC1/QDlxHP7PtP4HOZfbcaH+e3MBF
         F4Ub9dhCWAj90Jo51yBONStOnEpkYpkTktT7dqrX4RNMSthVpxOM0zMl1eCnP9ayHUZh
         RtLA==
X-Forwarded-Encrypted: i=1; AJvYcCWxptr3529MBW/FaYBJtFpY4U8AhYCrzOVAkK1jR8KJtL60l2od96Oq8Se9kRC48rXm9qh+bjh+IKRAPNp85O6rPtyMCnu1zOXs2bkJv0M=
X-Gm-Message-State: AOJu0Yy9YWonX79SboVrHV5oQECK8GBDNfFoj6S9BNhJYYlZYWjfuC1C
	9kUQiRD9uaKf5o+ylRkdWYLA5alTYcBaZD+N5MeqvQhJj9ierhLAIdxZluXqJiw=
X-Google-Smtp-Source: AGHT+IG8FPsJSB3R5gF4WSL1UV1bRgfY3GbKguC1d8Rk3TSB8Q6MCONCjhNXMIl53aORvwlWy3y6NQ==
X-Received: by 2002:a5d:6551:0:b0:35f:20eb:cae3 with SMTP id ffacd0b85a97d-366e7a51ea9mr7173376f8f.67.1719388383028;
        Wed, 26 Jun 2024 00:53:03 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36647e7eb4fsm14979151f8f.18.2024.06.26.00.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:53:02 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:52:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <ZnvI2hJXPJZyveAv@nanopsycho.orion>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
 <1718879494.952194-11-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1718879494.952194-11-hengqi@linux.alibaba.com>

Thu, Jun 20, 2024 at 12:31:34PM CEST, hengqi@linux.alibaba.com wrote:
>On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
>> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
>> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> > > > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
>> > > > >
>> > > > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> > > > > >
>> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
>> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>> > > > > > > >
>> > > > > > > >     /* Parameters for control virtqueue, if any */
>> > > > > > > >     if (vi->has_cvq) {
>> > > > > > > > -           callbacks[total_vqs - 1] = NULL;
>> > > > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
>> > > > > > > >             names[total_vqs - 1] = "control";
>> > > > > > > >     }
>> > > > > > > >
>> > > > > > >
>> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
>> > > > > > > this will cause irq sharing between VQs which will degrade
>> > > > > > > performance significantly.
>> > > > > > >
>> > > > >
>> > > > > Why do we need to care about buggy management? I think libvirt has
>> > > > > been teached to use 2N+2 since the introduction of the multiqueue[1].
>> > > > 
>> > > > And Qemu can calculate it correctly automatically since:
>> > > > 
>> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
>> > > > Author: Jason Wang <jasowang@redhat.com>
>> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
>> > > > 
>> > > >     virtio-net: calculating proper msix vectors on init
>> > > > 
>> > > >     Currently, the default msix vectors for virtio-net-pci is 3 which is
>> > > >     obvious not suitable for multiqueue guest, so we depends on the user
>> > > >     or management tools to pass a correct vectors parameter. In fact, we
>> > > >     can simplifying this by calculating the number of vectors on realize.
>> > > > 
>> > > >     Consider we have N queues, the number of vectors needed is 2*N + 2
>> > > >     (#queue pairs + plus one config interrupt and control vq). We didn't
>> > > >     check whether or not host support control vq because it was added
>> > > >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>> > > > 
>> > > >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
>> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
>> > > 
>> > > Yes, devices designed according to the spec need to reserve an interrupt
>> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
>> > > 
>> > > Thanks.
>> > 
>> > These aren't buggy, the spec allows this. So don't fail, but
>> > I'm fine with using polling if not enough vectors.
>> 
>> sharing with config interrupt is easier code-wise though, FWIW -
>> we don't need to maintain two code-paths.
>
>Yes, it works well - config change irq is used less before - and will not fail.

Please note I'm working on such fallback for admin queue. I would Like
to send the patchset by the end of this week. You can then use it easily
for cvq.

Something like:
/* the config->find_vqs() implementation */
int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
                struct virtqueue *vqs[], vq_callback_t *callbacks[],
                const char * const names[], const bool *ctx,
                struct irq_affinity *desc)
{
        int err;

        /* Try MSI-X with one vector per queue. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
                               VP_VQ_VECTOR_POLICY_EACH, ctx, desc);
        if (!err)
                return 0;
        /* Fallback: MSI-X with one shared vector for config and
         * slow path queues, one vector per queue for the rest. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
                               VP_VQ_VECTOR_POLICY_SHARED_SLOW, ctx, desc);
        if (!err)
                return 0;
        /* Fallback: MSI-X with one vector for config, one shared for queues. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names,
                               VP_VQ_VECTOR_POLICY_SHARED, ctx, desc);
        if (!err)
                return 0;
        /* Is there an interrupt? If not give up. */
        if (!(to_vp_device(vdev)->pci_dev->irq))
                return err;
        /* Finally fall back to regular interrupts. */
        return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
}




>
>Thanks.
>
>> 
>> > > > 
>> > > > Thanks
>> > > > 
>> > > > >
>> > > > > > > So no, you can not just do it unconditionally.
>> > > > > > >
>> > > > > > > The correct fix probably requires virtio core/API extensions.
>> > > > > >
>> > > > > > If the introduction of cvq irq causes interrupts to become shared, then
>> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
>> > > > >
>> > > > > Having to path sounds a burden.
>> > > > >
>> > > > > >
>> > > > > > Thanks.
>> > > > > >
>> > > > >
>> > > > >
>> > > > > Thanks
>> > > > >
>> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
>> > > > >
>> > > > > > >
>> > > > > > > --
>> > > > > > > MST
>> > > > > > >
>> > > > > >
>> > > > 
>> 
>
