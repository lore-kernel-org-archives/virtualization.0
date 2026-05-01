Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393D35F5E1
	for <virtualization@lists.linux.dev>; Fri,  1 May 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621185; cv=pass; b=S/gnxmR78FRxDp/WmXTRytK5xZhcQ1h3cfABsGjXCDWyEnAsIvdqn82IKj4IqGVsnoM+mf4FWI+eeGCyqMVgByKXamTtX/AtFpm/VE8SJfgVTCWWYyNKxIDdjn31VuKZAddrUdjwbXZJzbA7yIho9ji0SvX/jzcavle7+GAzwyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621185; c=relaxed/simple;
	bh=TbLaoWYohHPqj/XG/w1dzsXdf6YqFfSZc9edl1STeRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqDIG+/3WkunAIYGD7D57D2CHPdNw/eXF1rRe+yVxppW3ihU+SdzYYAt6aGBWBOlPfDp+TJAMjygeF//vZ+s7w77GGFTxS3ieVP7Cx+iQfZCozoon2xpXS5EgXajgl7HW4Jagmop70JNwpC12x6oGK83elCAbkP6F5/Vu9deXnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCtFCJcE; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCtFCJcE"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso16027061fa.2
        for <virtualization@lists.linux.dev>; Fri, 01 May 2026 00:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777621182; cv=none;
        d=google.com; s=arc-20240605;
        b=FUicbjBBbZ/lIZJkb9G2sbkoeIKKCeBfL8ILnzDHKLcqpcLwdHX7bZjIhR6Uov4zHe
         DV4XtEEkRPHAL54rb609cAurbzJh9hXzInO+ygA6VqsDagmYPdQXr5a+8MldPthfYZ4g
         Ubr85DsDO0dqqUvRQwzBfAJcmWJpSvNCNAXmMEinJl47FLzSU3ItuDd/VNYDXxXTkNxH
         wacypfTz/4XYdwtrlex5XkwTP2E5Y6EEI8KBPgHH3f0iEe+YVXfxuxniJAazokThviQN
         HKvx+Y6TmprbQvf4z/N5yJqJ0EsJ0YpBmOpIV46qYx8iXW1zwJXE3EJnXaNj2D/5GEd4
         HjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        fh=JauHZwb0XIk02YA3gwZV0TM6SHAOoi91qYXVaAe+/+c=;
        b=DVv+0/NzhaRUI3gooKt1QQ9eYT/FSQQlbPnuC3IK9G3hnEo1EfDbVLaspMBKHiN9we
         fxlbqyLc3+PbRbBY1RbdWyUNUWW6YG6L9Yq2mx+WWW5GA10Vm3q6/mQBGPezR/2wLmXl
         lXN70qp/pPdY4Ec6FQ3jCutc+PBrY4KQCGImkSr8L4gI3rgj+TX5I620qqGmL/TJlR8R
         uCiRA+2DBouUgErIcQBewP5fRqshphOS2CwKei4BdaBP4lZtU63SElLROvkDW1vd6nUK
         wjPavbY8bqUBpRtsHr/2pbunQQc4Stp47JqDsaIJ/IcX3KWb8eLg5vQDL7+5Faj5bm64
         W/OQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777621182; x=1778225982; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        b=eCtFCJcEg+7ySP4oPKEhP7sCzAeoYErBfC/gRpu3boBqDJCeDzqliAkaTBtPGZOQMD
         4gDdBXZw6S1ACn0WOcjrJCntZfjaMc9Fo1+qaVFLGl5El16mOUpTXheb70pSxbmzYkUR
         p1WI8W/875q8VngVWjqfHFDvurJSQsAUrFIrkelTyseHMzK6LtMUb/pW5RbaKiQlWF7/
         DLLC18Vi/7vABStUHq5Z+Lsd5OTPOkJmO57FB30ci8xm0GAQieOt26JWsIOe2esjmhR8
         sxQcIzXec+WFTDHvEhfojkBZAQXz9p8SPa37UnfLUWe+hcPlr/rEoE/R3O7ZcXJYyMnN
         nG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621182; x=1778225982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        b=iBwAKWle++aZHfz4TNMeOOKdAp75ys+OAMRTZkLgcX7vYtMPHjHRSWxBoeWPKUoDBy
         XprVtJnLr9pw6LIVus+xFgcagoTQOxxkuETou6kxXhH8i4DnU0nSmPlP8bh5Au6RTQc6
         CQJOSP4ctoiHqNf7EcseZjz6swHrm+pQHNN81uumm+mi/xDCkidrWdQaeym+V/HouVZ3
         qw1NsWU8M/2P85WGGOwFw9/+mVBFVjcWMyksO9IhiERcmOaxXhc/MsGzWzBWCxBpftuF
         uXs1gqw1MEr/mti/cXfXMRWYvrrwhRwsgcoB+IsGZ+xVvoKQlZL0AFj12FTJMW5kVDi2
         n7nA==
X-Forwarded-Encrypted: i=1; AFNElJ/+Ym4qoJEKWZ5hdOVUQZ7zQ6LHJ9e5mO4fyl/EeBrunzMd+XsGmAkIBU0mq9JGMX27m7ga4LpgCwEUH7oe6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrBp50pV1ILOfrYRues9WF0Mni2QhYwkrraioKLVeFvcj1nxsb
	JkcxfCHZmqq10ytSHb2HD5jdJBappifBDyg5jBhywhtIwF7F9DxwFqhH776Yzm2ort0MUNCq1WN
	QGg1ftxqewfpWlgT63iob1zCBr4DJ0OrHT9WFaYTe
X-Gm-Gg: AeBDievVjSFwwjg3GYFm7NiPE6QAs3K9o5pEIhoXK1UDHFZtBh0HgIkjtXJl2r8/VL5
	S1nGqYx0o4oaBcU1pblkogeWjh7TNeVzNPzQzhUeTST/oGeCg9xgQ5qA3eeywMOzF/ot5NSRFGl
	tAH5UAdyRtZmaTJu7uPdveBjh78odOynIOL58dZpiMtZ+bml0JzaCR6TledjviOZUmjSnl+ogPm
	V+TaCq4jIkdoTGg2u9T+JJzK/R5Jj4GWNKP7ZI2EmRx5OkQIi0tOJAy3+XMx/itGPRyl31fFI9a
	wGhafuz9eRcd8yVGJPRcjd5Ue9i4yHKUm4P7DSaD9zSzQoAi0JdSNShtulCBjiwGzUuJ3c14zRG
	pLVWnpFSKT5meFT12cg==
X-Received: by 2002:a05:651c:2114:b0:38e:186e:350e with SMTP id
 38308e7fff4ca-3934dec7039mr26121991fa.7.1777621181309; Fri, 01 May 2026
 00:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 May 2026 09:39:30 +0200
X-Gm-Features: AVHnY4LuOCyhbkG_hl8Sa5NNYS1SbIPwYG33VO-fKmuVe5zr0rpNYf2arYcAEvU
Message-ID: <CACT4Y+ZMJs0-9N+tcAa7Yi9-r5wshy0BAD1cdYRxBBPvOtMpZQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: refactor common handle ID into kcov_common_handle_id
To: Jann Horn <jannh@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Apr 2026 at 16:15, Jann Horn <jannh@google.com> wrote:
>
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> ---
>  drivers/usb/usbip/usbip_common.h | 29 +----------------------------
>  drivers/usb/usbip/vhci_rx.c      |  4 ++--
>  drivers/usb/usbip/vhci_sysfs.c   |  2 +-
>  drivers/vhost/vhost.h            |  2 +-
>  include/linux/kcov.h             | 12 ++++++------
>  include/linux/skbuff.h           | 14 +++-----------
>  include/linux/types.h            |  6 ++++++
>  kernel/kcov.c                    |  6 +++---
>  8 files changed, 23 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index 282efca64a01..be4c5e65a7f8 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -282,9 +282,7 @@ struct usbip_device {
>                 void (*unusable)(struct usbip_device *);
>         } eh_ops;
>
> -#ifdef CONFIG_KCOV
> -       u64 kcov_handle;
> -#endif
> +       struct kcov_common_handle_id kcov_handle;
>  };
>
>  #define kthread_get_run(threadfn, data, namefmt, ...)                     \
> @@ -339,29 +337,4 @@ static inline int interface_to_devnum(struct usb_interface *interface)
>         return udev->devnum;
>  }
>
> -#ifdef CONFIG_KCOV
> -
> -static inline void usbip_kcov_handle_init(struct usbip_device *ud)
> -{
> -       ud->kcov_handle = kcov_common_handle();
> -}
> -
> -static inline void usbip_kcov_remote_start(struct usbip_device *ud)
> -{
> -       kcov_remote_start_common(ud->kcov_handle);
> -}
> -
> -static inline void usbip_kcov_remote_stop(void)
> -{
> -       kcov_remote_stop();
> -}
> -
> -#else /* CONFIG_KCOV */
> -
> -static inline void usbip_kcov_handle_init(struct usbip_device *ud) { }
> -static inline void usbip_kcov_remote_start(struct usbip_device *ud) { }
> -static inline void usbip_kcov_remote_stop(void) { }
> -
> -#endif /* CONFIG_KCOV */
> -
>  #endif /* __USBIP_COMMON_H */
> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> index a75f4a898a41..a678e7c89837 100644
> --- a/drivers/usb/usbip/vhci_rx.c
> +++ b/drivers/usb/usbip/vhci_rx.c
> @@ -261,9 +261,9 @@ int vhci_rx_loop(void *data)
>                 if (usbip_event_happened(ud))
>                         break;
>
> -               usbip_kcov_remote_start(ud);
> +               kcov_remote_start_common(ud->kcov_handle);
>                 vhci_rx_pdu(ud);
> -               usbip_kcov_remote_stop();
> +               kcov_remote_stop();
>         }
>
>         return 0;
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index 5bc8c47788d4..b98d14c43d13 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -425,7 +425,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>         vdev->ud.tcp_rx     = tcp_rx;
>         vdev->ud.tcp_tx     = tcp_tx;
>         vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> -       usbip_kcov_handle_init(&vdev->ud);
> +       vdev->ud.kcov_handle = kcov_common_handle();
>
>         spin_unlock(&vdev->ud.lock);
>         spin_unlock_irqrestore(&vhci->lock, flags);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 4fe99765c5c7..0192ade6e749 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -44,7 +44,7 @@ struct vhost_worker {
>         /* Used to serialize device wide flushing with worker swapping. */
>         struct mutex            mutex;
>         struct llist_head       work_list;
> -       u64                     kcov_handle;
> +       struct kcov_common_handle_id kcov_handle;
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 0143358874b0..cdb72b3859d8 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -43,11 +43,11 @@ do {                                                \
>  /* See Documentation/dev-tools/kcov.rst for usage details. */
>  void kcov_remote_start(u64 handle);
>  void kcov_remote_stop(void);
> -u64 kcov_common_handle(void);
> +struct kcov_common_handle_id kcov_common_handle(void);
>
> -static inline void kcov_remote_start_common(u64 id)
> +static inline void kcov_remote_start_common(struct kcov_common_handle_id id)
>  {
> -       kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
> +       kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id.val));
>  }
>
>  static inline void kcov_remote_start_usb(u64 id)
> @@ -99,11 +99,11 @@ static inline void kcov_prepare_switch(struct task_struct *t) {}
>  static inline void kcov_finish_switch(struct task_struct *t) {}
>  static inline void kcov_remote_start(u64 handle) {}
>  static inline void kcov_remote_stop(void) {}
> -static inline u64 kcov_common_handle(void)
> +static inline struct kcov_common_handle_id kcov_common_handle(void)
>  {
> -       return 0;
> +       return (struct kcov_common_handle_id){};
>  }
> -static inline void kcov_remote_start_common(u64 id) {}
> +static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
>  static inline void kcov_remote_start_usb(u64 id) {}
>  static inline void kcov_remote_start_usb_softirq(u64 id) {}
>  static inline void kcov_remote_stop_softirq(void) {}
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b..a3fe418f7ced 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1082,9 +1082,7 @@ struct sk_buff {
>         __u16                   network_header;
>         __u16                   mac_header;
>
> -#ifdef CONFIG_KCOV
> -       u64                     kcov_handle;
> -#endif
> +       struct kcov_common_handle_id kcov_handle;
>
>         ); /* end headers group */
>
> @@ -5437,20 +5435,14 @@ static inline void skb_reset_csum_not_inet(struct sk_buff *skb)
>  }
>
>  static inline void skb_set_kcov_handle(struct sk_buff *skb,
> -                                      const u64 kcov_handle)
> +                                      struct kcov_common_handle_id kcov_handle)
>  {
> -#ifdef CONFIG_KCOV
>         skb->kcov_handle = kcov_handle;
> -#endif
>  }
>
> -static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
> +static inline struct kcov_common_handle_id skb_get_kcov_handle(struct sk_buff *skb)
>  {
> -#ifdef CONFIG_KCOV
>         return skb->kcov_handle;
> -#else
> -       return 0;
> -#endif
>  }
>
>  static inline void skb_mark_for_recycle(struct sk_buff *skb)
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 608050dbca6a..93166b0b0617 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -224,6 +224,12 @@ struct ustat {
>         char                    f_fpack[6];
>  };
>
> +struct kcov_common_handle_id {
> +#ifdef CONFIG_KCOV
> +       u64 val;
> +#endif
> +};
> +
>  /**
>   * struct callback_head - callback structure for use with RCU and task_work
>   * @next: next update requests in a list
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 0b369e88c7c9..a43e33a28adb 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -1083,11 +1083,11 @@ void kcov_remote_stop(void)
>  EXPORT_SYMBOL(kcov_remote_stop);
>
>  /* See the comment before kcov_remote_start() for usage details. */
> -u64 kcov_common_handle(void)
> +struct kcov_common_handle_id kcov_common_handle(void)
>  {
>         if (!in_task())
> -               return 0;
> -       return current->kcov_handle;
> +               return (struct kcov_common_handle_id){ .val = 0 };
> +       return (struct kcov_common_handle_id){ .val = current->kcov_handle };
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>
>
> ---
> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
> change-id: 20260430-kcov-refactor-common-handle-25178495b2eb
>
> --
> Jann Horn <jannh@google.com>
>
