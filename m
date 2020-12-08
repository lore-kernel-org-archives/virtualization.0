Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C432BC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 09:37:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D186233EE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 09:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D186233EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 746F586E4E;
	Tue,  8 Dec 2020 09:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sA6OGYQoaayv; Tue,  8 Dec 2020 09:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7E7E86C5A;
	Tue,  8 Dec 2020 09:37:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A23C0C0FA7;
	Tue,  8 Dec 2020 09:37:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D7CBC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E40C586DB1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXSegpyLWixr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:37:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BDCA886D96
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:37:19 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id ce23so19907936ejb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 01:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H04qlmtb8GOVjHbIauAjHp3hL9z0pEZLzsG11VbZlh0=;
 b=dbSZqkFRwScVwXkqKBtCdq0l8wchyeL1jNiwWURQzX0ET32g2KLjJv9FnzY6Eg9DMg
 RdWQUAloKjkiMsK/bLUJx4w+25ypM4iUa5geUif7X5EKHkm2nxmj+iz4/WZYjd29b6vW
 E53uvmjJI32tgj+DBIvM2jWrJgZMLxpttRJw72TMpOs4iUTf56tGzCjYPxPZX7cKWXb5
 H92AcRpoTzotdovrGdPzL5wOrdspybZu5lQ0CTJzka2MAzWHBP3Wn0AEhd/EaiTtFEeO
 7yBcmLe/D7w1aROsuB97aDhI8ql+nc5KUXA6iEyzfe25f50N1EWV6yQNM9aA1CrnYqoH
 CgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H04qlmtb8GOVjHbIauAjHp3hL9z0pEZLzsG11VbZlh0=;
 b=KbNHoVUaDK28hBxDtkuWiSNqVIfF3kWnRB3q5s+TigNvcXg1GQJLY9WfAfF0Z0we6h
 BPep5fN0GWVIkIi5UQQq81dC4ZqGsMenDpQHJ85WZyn/EfavBHmANGi4YyOW3Yi6KQfG
 NLH21ZEkNyjhS1+ESQ2Nh9M5P7zlgUn0sPLvxQbds14FUGLuOXJ4iQaZ0H5SgtCQKCVV
 wj4kuVgnwm3072jkV2angecPLG9PoM9GIwQUjaPhgZpUvSHcy8Um3GuyApw7J7padE5V
 S/AEMpiLm1PdcrI2W34SmtqauQg4pAx4Qk9P+7P+oKjkOVyc0Wh1UzZdVktEsPTnTl3s
 j3Gw==
X-Gm-Message-State: AOAM530PRRQ1zzIiuE1YDfmp2se7X9ZaOFomcArSK7nZwTVVneXsKn+e
 P1J/zaTP2dkpwSEMYfZyji8=
X-Google-Smtp-Source: ABdhPJxZVOdT5V/bGQkbT7kDiYMKS1OUX76aAlA687e08yXRtJiX1YkBPrTrqfOklwYbJY8kqXBsKw==
X-Received: by 2002:a17:906:c24b:: with SMTP id
 bl11mr22185341ejb.3.1607420238209; 
 Tue, 08 Dec 2020 01:37:18 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id bn21sm12914808ejb.47.2020.12.08.01.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 01:37:17 -0800 (PST)
Date: Tue, 8 Dec 2020 09:37:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
Message-ID: <20201208093715.GX203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-1-eperezma@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2536571106443515571=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2536571106443515571==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="je0mZywpqEo4t1RU"
Content-Disposition: inline


--je0mZywpqEo4t1RU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:38PM +0100, Eugenio P=E9rez wrote:
> This series enable vDPA software assisted live migration for vhost-net
> devices. This is a new method of vhost devices migration: Instead of
> relay on vDPA device's dirty logging capability, SW assisted LM
> intercepts dataplane, forwarding the descriptors between VM and device.

Pros:
+ vhost/vDPA devices don't need to implement dirty memory logging
+ Obsoletes ioctl(VHOST_SET_LOG_BASE) and friends

Cons:
- Not generic, relies on vhost-net-specific ioctls
- Doesn't support VIRTIO Shared Memory Regions
  https://github.com/oasis-tcs/virtio-spec/blob/master/shared-mem.tex
- Performance (see below)

I think performance will be significantly lower when the shadow vq is
enabled. Imagine a vDPA device with hardware vq doorbell registers
mapped into the guest so the guest driver can directly kick the device.
When the shadow vq is enabled a vmexit is needed to write to the shadow
vq ioeventfd, then the host kernel scheduler switches to a QEMU thread
to read the ioeventfd, the descriptors are translated, QEMU writes to
the vhost hdev kick fd, the host kernel scheduler switches to the vhost
worker thread, vhost/vDPA notifies the virtqueue, and finally the
vDPA driver writes to the hardware vq doorbell register. That is a lot
of overhead compared to writing to an exitless MMIO register!

If the shadow vq was implemented in drivers/vhost/ and QEMU used the
existing ioctl(VHOST_SET_LOG_BASE) approach, then the overhead would be
reduced to just one set of ioeventfd/irqfd. In other words, the QEMU
dirty memory logging happens asynchronously and isn't in the dataplane.

In addition, hardware that supports dirty memory logging as well as
software vDPA devices could completely eliminate the shadow vq for even
better performance.

But performance is a question of "is it good enough?". Maybe this
approach is okay and users don't expect good performance while dirty
memory logging is enabled. I just wanted to share the idea of moving the
shadow vq into the kernel in case you like that approach better.

Stefan

--je0mZywpqEo4t1RU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PSUsACgkQnKSrs4Gr
c8gQ+gf+PZB8RHKqu3nzT0rmAbtlme76xGY3u9UIr5jckuQ1ZTVVztqZEneemNB+
Z4YWhLni7IRYc+vDZbv1gnch2+DCElbbQIq4loGpKp8QDuuOCZVrcFCMtHElPGoV
ND4eMy7TWVkUM1cVEDHxbwyfZAswrLg3Q2vpYw/ysMTX3E2ddjplSw6ILWRj0YYX
L0fy0Hkp2mB8QGa/tIpXLqBXyfj+L9GhOZZEoskfnyGTfAlZK3/NsosrLit/h/GL
5z/GkL/Yvx4jmu/v+FlubhLrJ1YZfiU8yOyuCxXIMdVFNWXS71/KBG+nXiV+DaLt
+tylyKz0CuSBHwe3TXpp29Y6bkGRcA==
=NkoN
-----END PGP SIGNATURE-----

--je0mZywpqEo4t1RU--

--===============2536571106443515571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2536571106443515571==--
