Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162D10F1
	for <virtualization@lists.linux.dev>; Tue, 23 Jan 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980500; cv=none; b=jh5DGKtwq1AI8wyKn1HdzpGRWDK0OJsj1WSNIL0+3EshVI2Kd9b8jvnKBDh0rsBWQOV4cdwlQnbvTTwDaUcau27xGSzx8vdrgnK0dZLAqaE2aSpg5/5vn7gAIgrqbowze9+tvcoYjkm5ayXvgv6xLMtEoaRZcWFl3VPB2yRNP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980500; c=relaxed/simple;
	bh=WYhT1KSTjcRFHQZ0dFY+HaX12W5Ope1cBkdGfWhmFm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pErhr9R7MUFLuevn3EIOOD9fi/Am54ZEJScUPiWIDHsP+mcEuUhj6/+B/KPcYkhsJO2rdlgaiqW35dAoFUzXE9+Ob0zUjekUrNt/7qJQsH30pFEj8RuThqMOk+Wl2kVaOvG6EbyM2rfcD+7pGV4rsQ6WoQD6aY1YnPRQjpt0ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SduxInfO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SduxInfO"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so5164792e87.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 19:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705980497; x=1706585297; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBJbKQX0OEBxeprRN+v16JluNv16fHJFSLP63KZqjwQ=;
        b=SduxInfOnpsefJKvyWn0Sci9jfK/EXK/z/SjpXWXKlnP0WwvM/1g3JHo/4AWDbdITj
         ANJmKjCPK5F5qvPcnyG4UmNCsF86O9zxYEzEPNgPGf3WBGVEBr86LMz7y2imFGgyj+68
         2oLcrzq0oVy5QDyWV4ocMXfDxOOO2II9OWmjvCD937/mqb++iOUUrUIsvEffWVXTLfev
         vMrDL8Tq0TCEqJxjoPjJ5mi62MLUcK8VZmTLa2r+2gabwNFNtgIK3FjRielrmJnhc/0l
         QHPu7kzq9NeCLvok3d/6eI1zJP4pnKSCCbuRL5a53JUyliQC3uSWgEMSbk07Bth1xnlX
         Kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705980497; x=1706585297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBJbKQX0OEBxeprRN+v16JluNv16fHJFSLP63KZqjwQ=;
        b=eieyIzH/uorm7AN6f/xGjsJMGthlftnx2Qg5jSFKRcD0VMHmGvuSPVPAl3pklPUNuN
         4W+sYobNf9yYAFGkMiRPJ+lBBNWn1aixc83VvwOqVWQhl2MMKdhfu3BEEbrKDP9KzSpZ
         KLZDZe9nAmcKAsAyIa4xJbYZr9nmL1DpxugZwzvz/Udw2tmvijK0IkF7T/jsVtjviRP8
         k6P4y8eWen9kwYLU7WRInpL63OQOA6ijjWgfILa4sslBOjoSVeOSnsDuvUOqtcN7Njh2
         nDuGWNMtGEur0MpeAgvM/YQAUUVwNMFoEwsUNm66GyfTAUN8RxLTOyl0tNRbDeiXeOIH
         j/qw==
X-Gm-Message-State: AOJu0Yxi+T2usbzVp7/MY1cpvc3chI/Igw4P7Wkm8pOoVgQbEl6k5dYq
	Z98N3F6FcIpr0OXjHK7F9zEZlCiZ3RlAqbud+VPi/ykE1t0W9XB++lSBid+UDb9jLJ20WthXwEw
	DWyMLZgr33A3dWuliJHAQ45ns7MI=
X-Google-Smtp-Source: AGHT+IHzrHeX6AxgLJC298KaOYuxpbO5DUKstT5SH6IZswiIFSfK1NEzNpCYLrou/eJ6ElOxb9uC6K879m4tnEDH8H8=
X-Received: by 2002:a05:6512:6d3:b0:50e:e0af:4efb with SMTP id
 u19-20020a05651206d300b0050ee0af4efbmr2673823lff.104.1705980496515; Mon, 22
 Jan 2024 19:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122110722.690223-1-yi.sun@unisoc.com> <20240122110722.690223-3-yi.sun@unisoc.com>
 <20240122154255.GA389442@fedora>
In-Reply-To: <20240122154255.GA389442@fedora>
From: yi sun <sunyibuaa@gmail.com>
Date: Tue, 23 Jan 2024 11:27:40 +0800
Message-ID: <CALpufv0h-sQ4Qfp-Sxd7wME4onMNAMop_gi-np6Dk2R96sba0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:43=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Jan 22, 2024 at 07:07:22PM +0800, Yi Sun wrote:
> > Ensure no remaining requests in virtqueues before resetting vdev and
> > deleting virtqueues. Otherwise these requests will never be completed.
> > It may cause the system to become unresponsive. So it is better to plac=
e
> > blk_mq_quiesce_queue() in front of virtio_reset_device().
>
> QEMU's virtio-blk device implementation completes all requests during
> device reset. Most device implementations have to do the same to avoid
> leaving dangling requests in flight across device reset.
>
> Which device implementation are you using and why is it safe for the
> device is simply drop requests across device reset?
>
> Stefan

Virtio-blk device implementation completes all requests during device reset=
, but
this can only ensure that the device has finished using virtqueue. We shoul=
d
also consider the driver's use of virtqueue.

I caught such an example. Before del_vqs, the request had been processed by
the device, but it had not been processed by the driver. Although I am
using kernel5.4,
I think this problem may also occur with the latest version of kernel.

The debug code I added is as follows:
virtblk_freeze()
{
        vdev reset();
        quiesce queue();
        if (virtqueue->num_free !=3D 1024) //1024 is the init value.
                BUG_ON(1);
        vdev del_vqs();
}

BUG_ON triggered the dump, the analysis is as follows:

There is one request left in request_queue.
crash_arm64> struct request ffffff81f0560000 | grep -e state -e __data_len
  __data_len =3D 20480,
  state =3D MQ_RQ_IN_FLIGHT,

crash_arm64> vring_virtqueue.packed,last_used_idx,broken,vq 0xffffff8086f92=
900 |
grep -e num -e used_wrap_counter -e last_used_idx -e broken -e
num_free -e desc_state -e "desc =3D"
        num =3D 1024,
        desc =3D 0xffffff8085ff8000,
      used_wrap_counter =3D false,
      desc_state =3D 0xffffff8085610000,
  last_used_idx =3D 487,
  broken =3D false,
    num_free =3D 1017,

Find desc based on last_used_idx. Through flags, we can know that the reque=
st
has been processed by the device, but it is still in flight state
because it has not
had time to run virtblk_done().
crash_arm> vring_packed_desc ffffff8085ff9e70
struct vring_packed_desc {
  addr =3D 10474619192,
  len =3D 20481,
  id =3D 667,
  flags =3D 2
}

I'm using a closed source virtual machine, so I can't see the source
code for it,
but I'm guessing it's similar to qemu.

After the device completes the request, we must also ensure that the driver=
 can
complete the request in virtblk_done().
