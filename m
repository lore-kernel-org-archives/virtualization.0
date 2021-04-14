Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E3DC43462
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 14:15:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11862611EE
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 14:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11862611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD4DA8445A;
	Wed, 14 Apr 2021 14:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6lOxYE2SnFHK; Wed, 14 Apr 2021 14:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AC5D8446E;
	Wed, 14 Apr 2021 14:15:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 277CAC000C;
	Wed, 14 Apr 2021 14:15:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCB28C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DF896068A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1rh4-Mm-X7OK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:15:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4066A6063A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618409706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JOWJDfwxWBSnU6F6WuBZ7JaBtVqAeLmps6k0L0IgMY=;
 b=GF/QPzK+qMvJyHjnq8FfhNxd74nCV9ODUn7R9z/cg1wkjSFCt0DtgKEYpxrPzHuYPuWmH5
 Xs1zaBZCVFbbMCtf9NhbHm7Ia3Fb5pUZe34zTKgDVPwXV/Lc0z/cLPBbTGSgbJOP5KdlSq
 FpjjKAOBI3oX9JqoGqZ25+vEcOhF+Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-f5b934_WPZSsjss-1GwwtA-1; Wed, 14 Apr 2021 10:15:02 -0400
X-MC-Unique: f5b934_WPZSsjss-1GwwtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2315107ACE4;
 Wed, 14 Apr 2021 14:14:59 +0000 (UTC)
Received: from localhost (ovpn-114-209.ams2.redhat.com [10.36.114.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05A8319C78;
 Wed, 14 Apr 2021 14:14:58 +0000 (UTC)
Date: Wed, 14 Apr 2021 15:14:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v6 10/10] Documentation: Add documentation for VDUSE
Message-ID: <YHb44R4HyLEUVSTF@stefanha-x1.localdomain>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-11-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210331080519.172-11-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 christian.brauner@canonical.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, dan.carpenter@oracle.com,
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
Content-Type: multipart/mixed; boundary="===============2641726395258958040=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2641726395258958040==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+8CNRb8u7kJfIjoT"
Content-Disposition: inline


--+8CNRb8u7kJfIjoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 04:05:19PM +0800, Xie Yongji wrote:
> VDUSE (vDPA Device in Userspace) is a framework to support
> implementing software-emulated vDPA devices in userspace. This
> document is intended to clarify the VDUSE design and usage.
>=20
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  Documentation/userspace-api/index.rst |   1 +
>  Documentation/userspace-api/vduse.rst | 212 ++++++++++++++++++++++++++++=
++++++
>  2 files changed, 213 insertions(+)
>  create mode 100644 Documentation/userspace-api/vduse.rst

Just looking over the documentation briefly (I haven't studied the code
yet)...

> +How VDUSE works
> +------------
> +Each userspace vDPA device is created by the VDUSE_CREATE_DEV ioctl on
> +the character device (/dev/vduse/control). Then a device file with the
> +specified name (/dev/vduse/$NAME) will appear, which can be used to
> +implement the userspace vDPA device's control path and data path.

These steps are taken after sending the VDPA_CMD_DEV_NEW netlink
message? (Please consider reordering the documentation to make it clear
what the sequence of steps are.)

> +	static int netlink_add_vduse(const char *name, int device_id)
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
> +		if (!genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, famid, 0, 0,
> +		    VDPA_CMD_DEV_NEW, 0))
> +			goto nla_put_failure;
> +
> +		NLA_PUT_STRING(msg, VDPA_ATTR_DEV_NAME, name);
> +		NLA_PUT_STRING(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse");
> +		NLA_PUT_U32(msg, VDPA_ATTR_DEV_ID, device_id);

What are the permission/capability requirements for VDUSE?

How does VDUSE interact with namespaces?

What is the meaning of VDPA_ATTR_DEV_ID? I don't see it in Linux
v5.12-rc6 drivers/vdpa/vdpa.c:vdpa_nl_cmd_dev_add_set_doit().

> +MMU-based IOMMU Driver
> +----------------------
> +VDUSE framework implements an MMU-based on-chip IOMMU driver to support
> +mapping the kernel DMA buffer into the userspace iova region dynamically.
> +This is mainly designed for virtio-vdpa case (kernel virtio drivers).
> +
> +The basic idea behind this driver is treating MMU (VA->PA) as IOMMU (IOV=
A->PA).
> +The driver will set up MMU mapping instead of IOMMU mapping for the DMA =
transfer
> +so that the userspace process is able to use its virtual address to acce=
ss
> +the DMA buffer in kernel.
> +
> +And to avoid security issue, a bounce-buffering mechanism is introduced =
to
> +prevent userspace accessing the original buffer directly which may conta=
in other
> +kernel data. During the mapping, unmapping, the driver will copy the dat=
a from
> +the original buffer to the bounce buffer and back, depending on the dire=
ction of
> +the transfer. And the bounce-buffer addresses will be mapped into the us=
er address
> +space instead of the original one.

Is mmap(2) the right interface if memory is not actually shared, why not
just use pread(2)/pwrite(2) to make the copy explicit? That way the copy
semantics are clear. For example, don't expect to be able to busy wait
on the memory because changes will not be visible to the other side.

(I guess I'm missing something here and that mmap(2) is the right
approach, but maybe this documentation section can be clarified.)

--+8CNRb8u7kJfIjoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB2+OEACgkQnKSrs4Gr
c8jpugf+NHnGf6o2QvHFiSjjcoe0QPBmiySO4mz+2/oqmyL0YElWKcuyJJ16uxOx
p1SCMSYhoSE4EVZ1zWXMy18X6Lc3WjfU5s4dyo1dy4qrumXxGDj8Q93Togh8UL1Q
URNKuVbUBZp8anAt5KUXQt+fW/kw6luipS8XDrpszHN1mGVPrs8o0oORCwcD/8u9
95gfUL+acvkfocg6F//QpNUi1/BE7F6iTTRJhZ0UG0GHaVeJ/U0D7z0NrnaZLpgP
VPBvWxdqfOwiX3ABCVHIS18tafCmkLfadpmH0dxwZgVIC/hmE0gs96/7tDhQqZLg
1RAejoIQX/MqVpzh3XGHjGqnDW8e6w==
=hqt0
-----END PGP SIGNATURE-----

--+8CNRb8u7kJfIjoT--


--===============2641726395258958040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2641726395258958040==--

