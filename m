From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: Re: kernel BUG at drivers/block/virtio_blk.c:172
Date: Mon, 10 Nov 2014 14:05:41 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1411101404240.24699@localhost.localdomain>
References: <54524D50.50509@kernel.dk> <54524D68.7080509@kernel.dk>
	<CACVXFVPVdTqJ7X6xokq-8X8CTh3A59xwGNdwTm+SW1dOB-xxLQ@mail.gmail.com>
	<alpine.LFD.2.00.1411101252110.24699@localhost.localdomain>
	<CACVXFVOakGobOqJFAM=SZX+nkv9rf_R9y5h+jnTMgAnqWU_7fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1897968098-1415624744=:24699"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACVXFVOakGobOqJFAM=SZX+nkv9rf_R9y5h+jnTMgAnqWU_7fg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1897968098-1415624744=:24699
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2014, Ming Lei wrote:

> Date: Mon, 10 Nov 2014 20:18:32 +0800
> From: Ming Lei <tom.leiming@gmail.com>
> To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>,
>     Linux Virtualization <virtualization@lists.linux-foundation.org>,
>     Christoph Hellwig <hch@lst.de>
> Subject: Re: Re: kernel BUG at drivers/block/virtio_blk.c:172
>=20
> On Mon, Nov 10, 2014 at 7:59 PM, Luk=C3=A1=C5=A1 Czerner <lczerner@redh=
at.com> wrote:
> >
> > Hi,
> >
> > so I encountered it again on 3.17.0-rc4. This output is from the
> > run with your patch.
> >
> > I am using libvirt (virt-manager) to configure and run the virtual
> > machine, but looking at the xml, I do not think it's passing
> > 'scsi=3Doff' at all.
> >
> > Btw, that xfs file system is a root file system.
> >
> >
> > [    3.667553] blk_recount_segments: 1-0-1 vcnt-0 segs-128
> > [    3.668692] blk_recount_segments: 1-0-1 vcnt-0 segs-128
> > [    3.669897] blk_recount_segments: 1-0-1 vcnt-0 segs-128
> > [    3.671083] blk_recount_segments: 1-0-1 vcnt-0 segs-128
>=20
> Hamm, I should have used bi_phys_segments to decide if
> merge is needed, and attached patch should fix the problem.

Thanks for the patch, unfortunately it does not fix the issue for
me. I am willing to try something else though :)

-Lukas

>=20
>=20
> Thanks,
> Ming Lei
>=20
--8323328-1897968098-1415624744=:24699
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323328-1897968098-1415624744=:24699--
