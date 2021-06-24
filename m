Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4320C49EAB
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 13:02:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BF261C6B
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 13:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BF261C6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4482B403A1;
	Mon, 28 Jun 2021 13:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SsWykXyPelS; Mon, 28 Jun 2021 13:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17D4340391;
	Mon, 28 Jun 2021 13:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD04C001C;
	Mon, 28 Jun 2021 13:02:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC9ACC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B993A6058D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0-qYC9JPOhu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:02:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C58E26058B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624885338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNDTi50C/I3z0zGPjPUY0PC1vqjdyHJdKwJ5ive2urU=;
 b=E+85I1WljBCP4mfY+yjRZDZS8HgEDxn4viaTyTI3Jq/SaB/vt4xYkOxK5DwxOXk8lFaLYS
 ly1wL3gzgzWrZ12Fk5G9gj1vfQmq2AkLw0lbFvA9KbVIBv+6iz0EWnAtgpNseFFqfqQiJY
 hI3dFOnmmakZ9hQkhR0+faRi1wztucc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-nMz5OLACMdmjwSI-na1RPA-1; Mon, 28 Jun 2021 09:01:59 -0400
X-MC-Unique: nMz5OLACMdmjwSI-na1RPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E599C1018738;
 Mon, 28 Jun 2021 13:01:56 +0000 (UTC)
Received: from localhost (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE1F2101F965;
 Mon, 28 Jun 2021 13:01:49 +0000 (UTC)
Date: Thu, 24 Jun 2021 14:01:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
Message-ID: <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210615141331.407-11-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210615141331.407-11-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, viro@zeniv.linux.org.uk, songmuchun@bytedance.com,
 axboe@kernel.dk, gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mika.penttila@nextfour.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3635088574019489231=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3635088574019489231==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I4spE8BfCHxxKtuA"
Content-Disposition: inline


--I4spE8BfCHxxKtuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 10:13:31PM +0800, Xie Yongji wrote:
> VDUSE (vDPA Device in Userspace) is a framework to support
> implementing software-emulated vDPA devices in userspace. This
> document is intended to clarify the VDUSE design and usage.
>=20
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  Documentation/userspace-api/index.rst |   1 +
>  Documentation/userspace-api/vduse.rst | 222 ++++++++++++++++++++++++++++=
++++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/userspace-api/vduse.rst
>=20
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/usersp=
ace-api/index.rst
> index 0b5eefed027e..c432be070f67 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -27,6 +27,7 @@ place where this information is gathered.
>     iommu
>     media/index
>     sysfs-platform_profile
> +   vduse
> =20
>  .. only::  subproject and html
> =20
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/usersp=
ace-api/vduse.rst
> new file mode 100644
> index 000000000000..2f9cd1a4e530
> --- /dev/null
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -0,0 +1,222 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +VDUSE - "vDPA Device in Userspace"
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +vDPA (virtio data path acceleration) device is a device that uses a
> +datapath which complies with the virtio specifications with vendor
> +specific control path. vDPA devices can be both physically located on
> +the hardware or emulated by software. VDUSE is a framework that makes it
> +possible to implement software-emulated vDPA devices in userspace. And
> +to make it simple, the emulated vDPA device's control path is handled in
> +the kernel and only the data path is implemented in the userspace.
> +
> +Note that only virtio block device is supported by VDUSE framework now,
> +which can reduce security risks when the userspace process that implemen=
ts
> +the data path is run by an unprivileged user. The Support for other devi=
ce
> +types can be added after the security issue is clarified or fixed in the=
 future.
> +
> +Start/Stop VDUSE devices
> +------------------------
> +
> +VDUSE devices are started as follows:
> +
> +1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> +   /dev/vduse/control.
> +
> +2. Begin processing VDUSE messages from /dev/vduse/$NAME. The first
> +   messages will arrive while attaching the VDUSE instance to vDPA bus.
> +
> +3. Send the VDPA_CMD_DEV_NEW netlink message to attach the VDUSE
> +   instance to vDPA bus.
> +
> +VDUSE devices are stopped as follows:
> +
> +1. Send the VDPA_CMD_DEV_DEL netlink message to detach the VDUSE
> +   instance from vDPA bus.
> +
> +2. Close the file descriptor referring to /dev/vduse/$NAME
> +
> +3. Destroy the VDUSE instance with ioctl(VDUSE_DESTROY_DEV) on
> +   /dev/vduse/control
> +
> +The netlink messages metioned above can be sent via vdpa tool in iproute2
> +or use the below sample codes:
> +
> +.. code-block:: c
> +
> +	static int netlink_add_vduse(const char *name, enum vdpa_command cmd)
> +	{
> +		struct nl_sock *nlsock;
> +		struct nl_msg *msg;
> +		int famid;
> +
> +		nlsock =3D nl_socket_alloc();
> +		if (!nlsock)
> +			return -ENOMEM;
> +
> +		if (genl_connect(nlsock))
> +			goto free_sock;
> +
> +		famid =3D genl_ctrl_resolve(nlsock, VDPA_GENL_NAME);
> +		if (famid < 0)
> +			goto close_sock;
> +
> +		msg =3D nlmsg_alloc();
> +		if (!msg)
> +			goto close_sock;
> +
> +		if (!genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, famid, 0, 0, cmd, 0))
> +			goto nla_put_failure;
> +
> +		NLA_PUT_STRING(msg, VDPA_ATTR_DEV_NAME, name);
> +		if (cmd =3D=3D VDPA_CMD_DEV_NEW)
> +			NLA_PUT_STRING(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse");
> +
> +		if (nl_send_sync(nlsock, msg))
> +			goto close_sock;
> +
> +		nl_close(nlsock);
> +		nl_socket_free(nlsock);
> +
> +		return 0;
> +	nla_put_failure:
> +		nlmsg_free(msg);
> +	close_sock:
> +		nl_close(nlsock);
> +	free_sock:
> +		nl_socket_free(nlsock);
> +		return -1;
> +	}
> +
> +How VDUSE works
> +---------------
> +
> +Since the emuldated vDPA device's control path is handled in the kernel,

s/emuldated/emulated/

> +a message-based communication protocol and few types of control messages
> +are introduced by VDUSE framework to make userspace be aware of the data
> +path related changes:
> +
> +- VDUSE_GET_VQ_STATE: Get the state for virtqueue from userspace
> +
> +- VDUSE_START_DATAPLANE: Notify userspace to start the dataplane
> +
> +- VDUSE_STOP_DATAPLANE: Notify userspace to stop the dataplane
> +
> +- VDUSE_UPDATE_IOTLB: Notify userspace to update the memory mapping in d=
evice IOTLB
> +
> +Userspace needs to read()/write() on /dev/vduse/$NAME to receive/reply
> +those control messages from/to VDUSE kernel module as follows:
> +
> +.. code-block:: c
> +
> +	static int vduse_message_handler(int dev_fd)
> +	{
> +		int len;
> +		struct vduse_dev_request req;
> +		struct vduse_dev_response resp;
> +
> +		len =3D read(dev_fd, &req, sizeof(req));
> +		if (len !=3D sizeof(req))
> +			return -1;
> +
> +		resp.request_id =3D req.request_id;
> +
> +		switch (req.type) {
> +
> +		/* handle different types of message */
> +
> +		}
> +
> +		if (req.flags & VDUSE_REQ_FLAGS_NO_REPLY)
> +			return 0;
> +
> +		len =3D write(dev_fd, &resp, sizeof(resp));
> +		if (len !=3D sizeof(resp))
> +			return -1;
> +
> +		return 0;
> +	}
> +
> +After VDUSE_START_DATAPLANE messages is received, userspace should start=
 the
> +dataplane processing with the help of some ioctls on /dev/vduse/$NAME:
> +
> +- VDUSE_IOTLB_GET_FD: get the file descriptor to the first overlapped io=
va region.
> +  Userspace can access this iova region by passing fd and corresponding =
size, offset,
> +  perm to mmap(). For example:
> +
> +.. code-block:: c
> +
> +	static int perm_to_prot(uint8_t perm)
> +	{
> +		int prot =3D 0;
> +
> +		switch (perm) {
> +		case VDUSE_ACCESS_WO:
> +			prot |=3D PROT_WRITE;
> +			break;
> +		case VDUSE_ACCESS_RO:
> +			prot |=3D PROT_READ;
> +			break;
> +		case VDUSE_ACCESS_RW:
> +			prot |=3D PROT_READ | PROT_WRITE;
> +			break;
> +		}
> +
> +		return prot;
> +	}
> +
> +	static void *iova_to_va(int dev_fd, uint64_t iova, uint64_t *len)
> +	{
> +		int fd;
> +		void *addr;
> +		size_t size;
> +		struct vduse_iotlb_entry entry;
> +
> +		entry.start =3D iova;
> +		entry.last =3D iova + 1;

Why +1?

I expected the request to include *len so that VDUSE can create a bounce
buffer for the full iova range, if necessary.

> +		fd =3D ioctl(dev_fd, VDUSE_IOTLB_GET_FD, &entry);
> +		if (fd < 0)
> +			return NULL;
> +
> +		size =3D entry.last - entry.start + 1;
> +		*len =3D entry.last - iova + 1;
> +		addr =3D mmap(0, size, perm_to_prot(entry.perm), MAP_SHARED,
> +			    fd, entry.offset);
> +		close(fd);
> +		if (addr =3D=3D MAP_FAILED)
> +			return NULL;
> +
> +		/* do something to cache this iova region */

How is userspace expected to manage iotlb mmaps? When should munmap(2)
be called?

Should userspace expect VDUSE_IOTLB_GET_FD to return a full chunk of
guest RAM (e.g. multiple gigabytes) that can be cached permanently or
will it return just enough pages to cover [start, last)?

> +
> +		return addr + iova - entry.start;
> +	}
> +
> +- VDUSE_DEV_GET_FEATURES: Get the negotiated features

Are these VIRTIO feature bits? Please explain how feature negotiation
works. There must be a way for userspace to report the device's
supported feature bits to the kernel.

> +- VDUSE_DEV_UPDATE_CONFIG: Update the configuration space and inject a c=
onfig interrupt

Does this mean the contents of the configuration space are cached by
VDUSE? The downside is that the userspace code cannot generate the
contents on demand. Most devices doin't need to generate the contents
on demand, so I think this is okay but I had expected a different
interface:

kernel->userspace VDUSE_DEV_GET_CONFIG
userspace->kernel VDUSE_DEV_INJECT_CONFIG_IRQ

I think you can leave it the way it is, but I wanted to mention this in
case someone thinks it's important to support generating the contents of
the configuration space on demand.

> +- VDUSE_VQ_GET_INFO: Get the specified virtqueue's metadata
> +
> +- VDUSE_VQ_SETUP_KICKFD: set the kickfd for virtqueue, this eventfd is u=
sed
> +  by VDUSE kernel module to notify userspace to consume the vring.
> +
> +- VDUSE_INJECT_VQ_IRQ: inject an interrupt for specific virtqueue

This information is useful but it's not enough to be able to implement a
userspace device. Please provide more developer documentation or at
least refer to uapi header files, published documents, etc that contain
the details.

--I4spE8BfCHxxKtuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDUgh8ACgkQnKSrs4Gr
c8iq0gf+MttuBSbGdiR42Y0KTKP08u+x6dI4kws0Q3+47jwN/3K8/1STobbpQAO/
JHuFkqNm/f/qi6rDnxfFhja4pbPqfQ4Wf3PVN7FZRNmOEK3jArmjMYVaAWbhZDcz
/ILoCXxWM9EC/5mJo1x6qBISXDbOud3ZUYcqQgguxryN4DVHCF91W5DVTlyTACPx
h7nMES7/lFQj14wtgHpPbAZJ32bp2+7vGxgVh7jSZPA40ix2RzNgDoQ1TZSv+LBC
CjI6DvDsuBWQZkhNTpS6rMPyw6zZ+bdfUjegksxL7j5oGwrfpNxYIm3fnHNYtN2s
I1jhSQXC2vq9SxAQGTUWG41UNjdZGw==
=inFF
-----END PGP SIGNATURE-----

--I4spE8BfCHxxKtuA--


--===============3635088574019489231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3635088574019489231==--

