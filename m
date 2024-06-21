Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B916C448
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955848; cv=none; b=bUmt6LydpHcD+IMFXnsYkEHENLWQlm5UAo5ty5TitoYE0fzY9foG8Pq1KuJRtXznX1KQEFvrHhvrmbPPvDZc3A4JSd7dY6o7qJq2FSp0Mxe8ThyHnY7PM6kk5tDbOf8kXi5FAjJnyP8XGET8w5IGiS8DcpRk2QW3GnlowGBSLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955848; c=relaxed/simple;
	bh=Sy9ZOn8NK7MnCsuHfevQ7ppL9Y9bZfsvNWY9MkGv39o=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LxuIeo4pn8NupSkaaDo2dKzGNt4kQBoJgXp5Yzr8EKuWENzK2O16/dM5S66CvahTu1v/WUBEVlUyH+pOm5zTpx/0Rn72M911digyFnrvkUlq6r/4ERp1Kv92Pmz6BMbiof8oXh+wI+bHjdBZoQ0Iai6OxAkgZx9+ZlMWfQtwEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iI3tXVpo; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iI3tXVpo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718955843; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=4xIHEedSkR7qBZvF3zyjozrFeMDZlYkrDToG/UgkIKU=;
	b=iI3tXVpo3iEUj7Jz4uDvbJhFBRP3/ldqHseC/sIwKeIb6yHPjwB2BX9iZWVyFyjkKs26hGOdb3+Ab5LM6iay5mduNtSxt04IREYB49Pd+DSzo3ITG8PAfKbsXqzEsFjKMk3IaQP6LvG4YezV2WiPZLVBAMZ2vP33ruTeCxF0U64=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8vWSYq_1718955841;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8vWSYq_1718955841)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 15:44:02 +0800
Message-ID: <1718955706.2555537-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Fri, 21 Jun 2024 15:41:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
 <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620061109-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 06:11:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> > > > > >
> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@r=
edhat.com> wrote:
> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct vi=
rtnet_info *vi)
> > > > > > > >
> > > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > > >     if (vi->has_cvq) {
> > > > > > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > > > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > > > > >             names[total_vqs - 1] =3D "control";
> > > > > > > >     }
> > > > > > > >
> > > > > > >
> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > > performance significantly.
> > > > > > >
> > > > >
> > > > > Why do we need to care about buggy management? I think libvirt has
> > > > > been teached to use 2N+2 since the introduction of the multiqueue=
[1].
> > > >
> > > > And Qemu can calculate it correctly automatically since:
> > > >
> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > >
> > > >     virtio-net: calculating proper msix vectors on init
> > > >
> > > >     Currently, the default msix vectors for virtio-net-pci is 3 whi=
ch is
> > > >     obvious not suitable for multiqueue guest, so we depends on the=
 user
> > > >     or management tools to pass a correct vectors parameter. In fac=
t, we
> > > >     can simplifying this by calculating the number of vectors on re=
alize.
> > > >
> > > >     Consider we have N queues, the number of vectors needed is 2*N =
+ 2
> > > >     (#queue pairs + plus one config interrupt and control vq). We d=
idn't
> > > >     check whether or not host support control vq because it was add=
ed
> > > >     unconditionally by qemu to avoid breaking legacy guests such as=
 Minix.
> > > >
> > > >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Yes, devices designed according to the spec need to reserve an interr=
upt
> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy=
 devices?
> > >
> > > Thanks.
> >
> > These aren't buggy, the spec allows this. So don't fail, but
> > I'm fine with using polling if not enough vectors.
>
> sharing with config interrupt is easier code-wise though, FWIW -
> we don't need to maintain two code-paths.


If we do that, we should introduce a new helper, not to add new function to
find_vqs().

if ->share_irq_with_config:
	->share_irq_with_config(..., vq_idx)

Thanks.


>
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > So no, you can not just do it unconditionally.
> > > > > > >
> > > > > > > The correct fix probably requires virtio core/API extensions.
> > > > > >
> > > > > > If the introduction of cvq irq causes interrupts to become shar=
ed, then
> > > > > > ctrlq need to fall back to polling mode and keep the status quo.
> > > > >
> > > > > Having to path sounds a burden.
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > > >
> > > >
>
