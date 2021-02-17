Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CA0C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 15:26:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E9264DA1
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E9264DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BB696F5C6
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 15:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXVk-2K8NDGq for <virtualization@archiver.kernel.org>;
	Wed, 17 Feb 2021 15:26:50 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 34E8E6F4DE; Wed, 17 Feb 2021 15:26:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9242D6F4BC;
	Wed, 17 Feb 2021 15:26:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61622C0174;
	Wed, 17 Feb 2021 15:26:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10943C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 15:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 09F62867A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 15:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GWJEBQaKgfpM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 15:26:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E0958673B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613575604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ecY4yNIrgjKzSNwRMISeJ/qxpef/5XZk23de/J/fLls=;
 b=b5SDN0jCMQP45+M/UqBblTJR3lG/QUtHLJkzJE+9FzwpmpV/WCEsJMtJzSXLw3qj8GYRzQ
 EPnjRZJ5j8cB4fm44+Xps0awaRbZRhL7Ay/PAvbWR7s2HZIMtwvEkjuAnOemwQCzm0dpIg
 5ve+SnZvw/Tk5UG0j3rBdp9568TDJv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-vJnBQjXrPrqlOWkaYb0jYw-1; Wed, 17 Feb 2021 10:26:40 -0500
X-MC-Unique: vJnBQjXrPrqlOWkaYb0jYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB4CD192CC43;
 Wed, 17 Feb 2021 15:26:38 +0000 (UTC)
Received: from localhost (ovpn-115-102.ams2.redhat.com [10.36.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C115D719;
 Wed, 17 Feb 2021 15:26:34 +0000 (UTC)
Date: Wed, 17 Feb 2021 15:26:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v2 5/7] vhost: Add x-vhost-enable-shadow-vq qmp
Message-ID: <20210217152633.GG269203@stefanha-x1.localdomain>
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-6-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210209153757.1653598-6-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Rob Miller <rob.miller@broadcom.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>
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
Content-Type: multipart/mixed; boundary="===============9164122708025688211=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9164122708025688211==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline

--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 04:37:55PM +0100, Eugenio P=E9rez wrote:
> diff --git a/qapi/net.json b/qapi/net.json
> index c31748c87f..a1cdffb0f9 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -77,6 +77,28 @@
>  ##
>  { 'command': 'netdev_del', 'data': {'id': 'str'} }
> =20
> +##
> +# @x-vhost-enable-shadow-vq:
> +#
> +# Use vhost shadow virtqueue.

Is this command for testing only or do you expect it to be invoked by
libvirt in production? I think the shadow virtqueue can be an internal
QEMU feature that is hidden from management tools.

> +#
> +# @name: the device name of the virtual network adapter
> +#
> +# @enable: true to use he alternate shadow VQ notification path
> +#
> +# Returns: Error if failure, or 'no error' for success
> +#
> +# Since: 6.0

Is this a generic feature for any vhost or vDPA device? If yes, please
replace "virtual network adapter" in the doc comment.

Does this only apply to vhost-net devices? If so, please put "vhost-net"
in the name since there are other non-net vhost devices.

> +#
> +# Example:
> +#
> +# -> { "execute": "x-vhost-enable-shadow-vq", "arguments": {"enable": tr=
ue} }

Missing "name" field?

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAtNakACgkQnKSrs4Gr
c8iLXQf+PKxYtC65+omdA8zsrOELcr89AvloccdW5a6OvoHu5oowlCSAFPKmEDon
N1HwfyKuwH6mWP9HvntWr4a35LRPDghDTf/cvuJeG3w2hqUJr9kadWoBL9HICr1T
2/U8FB66ialGkE+yG0BIrHcZpIKOZy4vv+JlzwHUoj2ctRJ7biys2Zj1dyYjPr8Q
aD6dWsw7L6ttLG8kL9GaA6Vid9L9Y8k4qoa7KIRYd0skVNvdXqLvqXqoja0Ue9Mv
5vv29Ty6k2C2i94DFOeR5uboWoahvugS63nTX5M/ExvLAdAY3vENCB62/ljQa2br
hRtNUfU/U1/bEWsONrP4LtdpCez6Jw==
=L2vh
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--


--===============9164122708025688211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9164122708025688211==--

