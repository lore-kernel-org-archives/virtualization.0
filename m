Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172332;
	b=wEa7SvibRduSnyKZ3ZkBAmhWGtXo+tgFDKneGr9a6vPkIa9bRyscOoRSSR/uHDsdx9hI
	 TmxSEn2EdX1EvY1CxxVbijYZMZqEHFkVmb3jPKY/CQNXgvGkbeZsHyERD/orCjUjSaUlO
	 y9VPVy0YFyK9jWm3oKUyOHvo1ml8PAjJZxGZVvei0aqlTKt9QtNGHSySW5ma9l/zVHzxd
	 gRUykuch9UgyKjGPFsRj/Km7AnFHt0RnsxCY4OCgZkM3YPVaVGO/neL5eronu8twIj2WW
	 3aRCrcJkob30CLi/0uqjO67pY/AXUPObavbHN3RKLwOO5dSFFgOQ0vINh6Eiow45TVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172332;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=zPMRJyajft4jjbY41Nxe/rP6bNlBhq8ckrsRNJI0j7w=;
	b=eM+qOHBF/XQTyXbMczDA+CMHLiC0n/AMKcs8lagYJHgzq4uNiVvWQbywcZiokRs6LZXx
	 CO4DV++B2ge/OPtV5ILobvWFXUXTTk+KxTOJXxO4Lg9qatNxAEiv4Nrhv6Oug1orlC1Mw
	 HjSR7NakCmIgPbNkIjcOxSD+pPiSzrTCXRxTrpez/uumlM53BTzkOKHuZee2UUwXjWR7x
	 H8uVCEY/m+fEC54RqHmudX5blxyAxerC7BgPO6hGjZ7YkPq6j+h8+I1Uulzbt93D8u+HB
	 N/0b7lF63Rt9k83tnOM+OaWZNQlvN9nTWkLy8Eb3NSY4rjifc+Nn827h0naQUdcd6kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E6EdroYo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C8606A32A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 015C8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E6EdroYo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795172331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPMRJyajft4jjbY41Nxe/rP6bNlBhq8ckrsRNJI0j7w=;
	b=E6EdroYopbIeVH7Cz/tU9NcAGcAVArb4AvfDTgsrVgzVSNNRaQX1GarzvmwrzKDC/1fAfK
	Bh2be21xVS+kEats97PG4FPYxfzSBTJhYV35xMuyPsuzbrAaMEYO+vlvN5fFQkG+f/PV6d
	NIEMtHQn1jTyJCEjRwdcHoC3ah6TKOs=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-pdEA3A8vOeecfVQfbpTK4A-1; Fri, 20 Nov 2026 10:58:48 +0000
X-MC-Unique: pdEA3A8vOeecfVQfbpTK4A-1
X-Mimecast-MFC-AGG-ID: pdEA3A8vOeecfVQfbpTK4A_1795172328
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67935d0ddcdso1470379d50.3
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 02:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172328; x=1795777128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPMRJyajft4jjbY41Nxe/rP6bNlBhq8ckrsRNJI0j7w=;
        b=uWDXEzOSTjqgXZ4f3jRHHmAd6nmqIUXPPv7YA7r1QOgpetl91ir8rX/hdKY3wqUZxk
         EJ0euw2cLUGO7t4mMtA/GpmV5+t/krmCVJrmIfKIMvfMNWwLD8TpT8ndOaD9aGSd6Oyi
         ECzbZUZhQdJ84Iz4qe5G8EIUyE0cIhbXlMRpHqyjAI3pBmEffkBA9RoRWhXMMvxV+6KF
         zs4/m+EvB7QgzyEBMti45tPM2EN6AwbHdh1g/yC6IPDIx5qsrc5OTpN8mbdJUphChWKA
         wl7AaSSLVilRj4RodUaosP9WUaeKlLSVwoYPDBgpq9j+uN1sPbk+SmRYYyy+Y8tDgBdU
         Xdhg==
X-Forwarded-Encrypted: i=1; AL+hErHD842MetyedF+irhVHWbb+H+mseO3HAcqfVIifStB8A6qqTSPfgS+1pPpAri8kt4Euysxhz2+wxistTTxHzA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9P953PCUJX0i3zdfWcPYfHQKHgih5BlE1vgjMmI7fz5W8Cuu3r
	UASh3gAScOuHrz2rbw9jvor6i0VyVcI8NBVOOlrrZbgF690/97oCCVt1rs2OCW4dSai3L7G1ZDQ
	HgWhehXXZqe6E+R3hHKs4yhicI6cvt+PXIbMuUCvH2n2S/DdoLWR43QjdocycBU8ftOGh2OESig
	4id5CUdKWuT/YzrqLw73cmELpG+M2L2W6q46nhCcaIkfM=
X-Gm-Gg: AZFdTZcoNmjBZgxJcxN8UCa1j8kHXZ3vzOZ2bbl+RuW0BbGTDol3s5N4GG6c3o4BYn0
	RMFUH5xxRdwgBoHH4B3AkdO5KvJvdzdGpki40boWocfcJSVwMaZTDSTIu+g96NBO/K4KvCykGcY
	nYB89D5H9JQnBH9OgShrVsr8q9+d84BDV2oWEz45OZWnaMg9vA/C20GtKeJoOg9toCH3/Xg+S9R
	HV4acHkFdCBEAFn8vE92xD1ohZEJKQFBxvUIT4vfrnIC7O2S5SYDS/x0uw=
X-Received: by 2002:a05:690e:169e:b0:676:eb57:bba6 with SMTP id 956f58d0204a3-67df4413e34mr1509287d50.58.1795172327541;
        Fri, 20 Nov 2026 02:58:47 -0800 (PST)
X-Received: by 2002:a05:690e:169e:b0:676:eb57:bba6 with SMTP id
 956f58d0204a3-67df4413e34mr1509268d50.58.1795172327021; Fri, 20 Nov 2026
 02:58:47 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
 <20251109164528-mutt-send-email-mst@kernel.org> <CAJaqyWdwF5UM+rS7EB9gG5VJMPW0MvwtkNWXdDAkdurFO3zHRg@mail.gmail.com>
 <CAJaqyWcCF0bzwMhQk6L=LPvc=S7yHoWB7xZ+MmPWwhi4kqGEfA@mail.gmail.com>
 <20260313080611-mutt-send-email-mst@kernel.org> <CAJaqyWdaMb0EABOL4WB8+PVKPeU4vzD3V22z63N10jzNESO1sQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdaMb0EABOL4WB8+PVKPeU4vzD3V22z63N10jzNESO1sQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 20 Nov 2026 11:58:08 +0100
X-Gm-Features: AclHuK-NDIHtS9B0yASNCqkQIbmx2erYDBBaY0IjV6H0kij0EOQA_NnpGaS3fg4
Message-ID: <CAJaqyWe=ye4mytvkxqA1CSA_M9qKJv1Cy14aBoZTm27Dq1KRUA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, 
	Jason Wang <jasowangio@gmail.com>, netdev <netdev@vger.kernel.org>, sdf.kernel@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b3kxGG8b4pR740KovJIFi9vLj4BsFN-AaZbfrs4obek_1795172328
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:26=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Mar 13, 2026 at 1:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Mar 13, 2026 at 12:32:18PM +0100, Eugenio Perez Martin wrote:
> > > On Fri, Mar 13, 2026 at 12:31=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Sun, Nov 9, 2025 at 10:47=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wr=
ote:
> > > > > > On Tue, Oct 28, 2025 at 3:57=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Mar=
tin wrote:
> > > > > > > > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirki=
n <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez=
 Martin wrote:
> > > > > > > > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Ts=
irkin <mst@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio P=
erez Martin wrote:
> > > > > > > > > > > > > Let me switch to MQ as I think it illustrates the=
 point better.
> > > > > > > > > > > > >
> > > > > > > > > > > > > IIUC the workflow:
> > > > > > > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the devi=
ce
> > > > > > > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > > > > c) VDUSE CVQ sends the command to the VDUSE devic=
e
> > > > > > > > > > > > > d) Now the virtio-net driver sends virtio-net sen=
ds MQ_VQ_PAIRS_SET 1
> > > > > > > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > > > >
> > > > > > > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 c=
ommand at this point,
> > > > > > > > > > > > > so it potentially uses the second rx queue. But, =
by the standard:
> > > > > > > > > > > > >
> > > > > > > > > > > > > The device MUST NOT queue packets on receive queu=
es greater than
> > > > > > > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET=
_CTRL_MQ_VQ_PAIRS_SET
> > > > > > > > > > > > > command in a used buffer.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So the driver does not expect rx buffers on that =
queue at all. From
> > > > > > > > > > > > > the driver's POV, the device is invalid, and it c=
ould mark it as
> > > > > > > > > > > > > broken.
> > > > > > > > > > > >
> > > > > > > > > > > > ok intresting. Note that if userspace processes vqs=
 it should process
> > > > > > > > > > > > cvq too. I don't know what to do in this case yet, =
I'm going on
> > > > > > > > > > > > vacation, let me ponder this a bit.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Sure.
> > > > > > > > > >
> > > > > > > > > > So let me ask you this, how are you going to handle dev=
ice reset?
> > > > > > > > > > Same issue, it seems to me.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Well my proposal is to mark it as broken so it needs to b=
e reset
> > > > > > > > > manually.
> > > > > > > >
> > > > > > > >
> > > > > > > > Heh but guest assumes after reset device does not poke at g=
uest
> > > > > > > > memory, and will free up and reuse that memory.
> > > > > > > > If userspace still pokes at it -> plus plus ungood.
> > > > > > > >
> > > > > > >
> > > > > > > I don't get this part. Once the device is reset, the device s=
hould not
> > > > > > > poke at guest memory (unless it is malicious or similar). Why=
 would it
> > > > > > > do it?
> > > > > >
> > > > > > Friendly ping.
> > > > >
> > > > >
> > > > >
> > > > > OK I thought about it a bunch. A lot of net drivers actually
> > > > > just queue ethtool commands and finish them asynchronously.
> > > > > Thinkably virtio could expose an API on whether it is safe to
> > > > > wait for buffers to be used. virtio-net would then either
> > > > > send commands directly or do the asynchronous thing.
> > > > > Hmm?
> > > > >
> > > >
> > > > I think it's the best solution too, yes. The series [1] implements =
for
> > > > set_rx_mode. We can do it for all the CVQ commands and then whiteli=
st
> > > > them in VDUSE code. Am I missing something? Does anyone foresee any
> > > > command that will not be possible to convert?
> > > >
> > >
> > > Adding the [1] link...
> > >
> > > [1] https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiy=
yappan@gmail.com/
> >
> > what's the status of that one?
> >
>
> Still under review.
>
> Aleksandr Loktionov <aleksandr.loktionov@intel.com> added the
> Reviewed-by tag to most of patches but he spotted a sync issue in the
> realtek 8139cp driver.
>
> https://lore.kernel.org/lkml/IA3PR11MB8986856F0C1BC5A02F29B32EE540A@IA3PR=
11MB8986.namprd11.prod.outlook.com/

Ok,  that one is merged now but it still does not solve the rtnl issue
:(. It just moves the driver call to set rx mode to a place where it
can sleep while holding the rtnl.

In the case of the mac address change it actually takes the lock way
earlier, as soon as rtnl_newlink. I'm trying to remove the rtnl when
the CVQ command is issued, but that complicates the scenario quickly.
The plan is to get the callers of
net/core/dev.c:netif_set_mac_address() not have the rtnl taken, only
the device one. And then some polished version of this:

@@ -10223,16 +10223,21 @@ int netif_set_mac_address(struct net_device
*dev, struct sockaddr_storage *ss,
                return -EINVAL;
        if (!netif_device_present(dev))
                return -ENODEV;
+       rtnl_lock();
        err =3D netif_pre_changeaddr_notify(dev, ss->__data, extack);
        if (err)
                return err;
        if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
+               rtnl_unlock();
                err =3D ops->ndo_set_mac_address(dev, ss);
                if (err)
                        return err;
+               rtnl_lock();
        }
        dev->addr_assign_type =3D NET_ADDR_SET;
        call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
+       rtnl_unlock();
        add_device_randomness(dev->dev_addr, dev->addr_len);
        return 0;
 }

However syncrhronizing the NETDEV_PRE_CHANGEADDR notifications to the
actual CVQ command seems hard, as new notifiers can be added in the
middle. It checks if any listener objects to the MAC address change.
As far as I can see, only Nvidia's spectrum driver can deny that MAC
address change if there are too many MAC addresses, so maybe we can
just adapt it, but I might be missing something [1].

If my guess is right, setting the MAc address out of rtnl and run the
PRE_CHANGEADDR notifiers again with rtnl taken could be a step
forward. If the notifiers fail (the Nvidia device denies the address
change), we can trigger a rollback of the MAC address outside the
rtnl.

Ccing netdev and Stanislav who added the set_rx_mode_async to check if
this is the right direction or if there are efforts / attempt to make
this happen.

Rx mode, the number of enabled virtqueues, etc., have similar
problems, but maybe we can start with the MAC address.

[1]
$ git grep -n  'NETDEV_PRE_CHANGEADDR'
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9921:
case NETDEV_PRE_CHANGEADDR:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9949:
case NETDEV_PRE_CHANGEADDR:
drivers/net/ipvlan/ipvlan_main.c:867:        case NETDEV_PRE_CHANGEADDR:
include/linux/netdevice.h:3255:        NETDEV_PRE_CHANGEADDR,
/* notify before the address change */
net/bridge/br.c:76:         case NETDEV_PRE_CHANGEADDR:
net/core/dev.c:10192: * netif_pre_changeaddr_notify() - Call
NETDEV_PRE_CHANGEADDR.
net/core/dev.c:10209:        rc =3D
call_netdevice_notifiers_info(NETDEV_PRE_CHANGEADDR, &info.info);
net/core/lock_debug.c:35:         case NETDEV_PRE_CHANGEADDR:

$ git grep -n -A9 'case NETDEV_PRE_CHANGEADDR' net/bridge/br.c
net/bridge/br.c:76:         case NETDEV_PRE_CHANGEADDR:
net/bridge/br.c:77:                 if (br->dev->addr_assign_type =3D=3D
NET_ADDR_SET)
net/bridge/br.c:78:                         break;
net/bridge/br.c:79:                 prechaddr_info =3D ptr;
net/bridge/br.c:80:                 err =3D netif_pre_changeaddr_notify(br-=
>dev,
net/bridge/br.c:81:
prechaddr_info->dev_addr,
net/bridge/br.c:82:                                                   extac=
k);
net/bridge/br.c:83:                 if (err)
net/bridge/br.c:84:                         return notifier_from_errno(err)=
;
net/bridge/br.c:85:                 break;

drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9736:static int
mlxsw_sp_router_port_pre_changeaddr_event(struct mlxsw_sp_rif *rif,
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9737:
                struct netdev_notifier_pre_changeaddr_info *info)
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9738:{
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9739:
struct mlxsw_sp *mlxsw_sp =3D rif->mlxsw_sp;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9740:
struct mlxsw_sp_rif_mac_profile *profile;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9741:
struct netlink_ext_ack *extack;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9742:        u8
max_rif_mac_profiles;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9743:        u64 occ;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9744:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9745:
extack =3D netdev_notifier_info_to_extack(&info->info);
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9746:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9747:
profile =3D mlxsw_sp_rif_mac_profile_find(mlxsw_sp, info->dev_addr);
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9748:        if (prof=
ile)
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9749:
    return 0;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9750:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9751:
max_rif_mac_profiles =3D mlxsw_sp->router->max_rif_mac_profile;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9752:        occ
=3D mlxsw_sp_rif_mac_profiles_occ_get(mlxsw_sp);
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9753:        if
(occ < max_rif_mac_profiles)
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9754:
    return 0;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9755:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9756:        if
(!mlxsw_sp_rif_mac_profile_is_shared(rif))
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9757:
    return 0;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9758:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9759:
NL_SET_ERR_MSG_MOD(extack, "Exceeded number of supported router
interface MA
C profiles");
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9760:
return -ENOBUFS;
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:9761:}

