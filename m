Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AF0C4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:25:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE81223A5B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81223A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E8AB87788;
	Tue,  8 Dec 2020 08:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id StUAt+jPnzUs; Tue,  8 Dec 2020 08:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 192C4877AB;
	Tue,  8 Dec 2020 08:25:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E923FC0FA7;
	Tue,  8 Dec 2020 08:25:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29A1DC013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1D46787585
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FRsjxsoOmzOd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:25:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0486B87538
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:25:56 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id cw27so16661735edb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 00:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CRRpx8acZX4QjtTnMIWAXX++AMuePl61ml+xI4XshWU=;
 b=fOK/3HgiuVBZ02q0KOifw6SzUXjBYw5+AuClkdFIgY1bJpmlwwdbHVyVivO0eg+aa2
 JhYZdRbBcHtFNThHnS9vSHXgzNgZeaJEBYXDf+pb/wF3NqwCKtbzTo4BTUNaoLugNuZH
 Pjmhf/0107cUNmr1PnADrcmbvF7Xsg9WQLMYay/4/HoolpX8IO6F7BV0/6z84Ayj6tyC
 t5UJEqv5AmQuY9sKeu1suv8qLhIIZKBjCrXblTOv0AkITuMqGH+5DqYFYgff4E0Yiawv
 voT9qUCZKgkr2A3wCFgycaL2kPM43WHTbx/qHUPsQYjC/mtOwMW7GE/3K/ArfNn4RJWd
 ZhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CRRpx8acZX4QjtTnMIWAXX++AMuePl61ml+xI4XshWU=;
 b=AusDXXLWqTQj5td7XNYejoYQauxlGbQkKmFc1bi0OmidzAVCY+us030xDmE1qRc5BZ
 SwZ1gxby0CwatZMbxEIqrF5xZwaRH8uTQ0SW8pv+uWREPjr68zJUeFg7wlY0P9mxXdit
 33B6VP/PE0JOqWkR1CspBs0RQl5G1wqqnt8HohIolnLT1kcBxHu3JhnGbUSfKLZPeQrR
 R9+xnAfKhIrnZpGdakrCnhu6Tn6RvVco4/CfDU5PP2TrGB8HGWqpzzsYsRjCqZa+sZvr
 IyH2/7tGFZiOusZfkJgtz1K3pbeso28hxvAXOREMArQOkyAAycWBfDefDhfOrKZSgxfZ
 JXxA==
X-Gm-Message-State: AOAM53168bBRWH3YAKYsmKprTpSPKqdodKhET75oe0n/PYqfp9qqFTYb
 BoR0GiJqSmwSbB8ubvwjL30=
X-Google-Smtp-Source: ABdhPJwgXgn+yrMMIjilMjVvsLWwQHozsuf+tTEAZtoyMOYhysd+aHWNX+tUMzVsB8iXuDrM/o5tQA==
X-Received: by 2002:a05:6402:3074:: with SMTP id
 bs20mr23700631edb.365.1607415954491; 
 Tue, 08 Dec 2020 00:25:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id rs27sm15112106ejb.21.2020.12.08.00.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:25:53 -0800 (PST)
Date: Tue, 8 Dec 2020 08:25:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 16/27] virtio: Expose virtqueue_alloc_element
Message-ID: <20201208082552.GT203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-17-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-17-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6444854928177360934=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6444854928177360934==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Content-Disposition: inline


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:54PM +0100, Eugenio P=E9rez wrote:
> Specify VirtQueueElement * as return type makes no harm at this moment.

The reason for the void * return type is that C implicitly converts void
pointers to pointers of any type. The function takes a size_t sz
argument so it can allocate a object of user-defined size. The idea is
that the user's struct embeds a VirtQueueElement field. Changing the
return type to VirtQueueElement * means that callers may need to
explicitly cast to the user's struct type.

It's a question of coding style but I think the void * return type
communicates what is going on better than VirtQueueElement *.

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/POJAACgkQnKSrs4Gr
c8iIOQf/eNAzxK1ncAAJ6gkC5ZN4/DQUgcfZBmB/a4jRwojXtH7Tkr9soSJU/TN+
1mJPWNebsod4iVWGO+yl0y+YL4Iif2d2TSFpiyZvwOyNY1KAXpSgm3TwsbBW1UkG
WduAcNnpl06uIFb+x2w1aQlVE7RMaCFKRSw7GgLxDxuBJipan4LO+cDLlgwJk62z
RMsgHlzhfHZ9Kq2MMbZkwF4Etz1sWFOkn80cbFQT247Mn6Kx0KtU3RM7ubowKDmY
fXsySdAnqcU8fNv+7Oi3lM1zHI2jWTVPbfvmFDK7cYghlUU5lQJlUSC2icXRKm1T
OtyLrwUxDfPwL4895JADTzpPAwngDA==
=Cecc
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--

--===============6444854928177360934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6444854928177360934==--
