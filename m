From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into drivers
Date: Thu, 12 Dec 2019 10:17:44 +0100
Message-ID: <CAK8P3a2hxD9aaabf2sK3ozqVdr2pbDS10W+Z6oT4idk=AitwVQ__17155.639727001$1576142298$gmane$org@mail.gmail.com>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, y2038 Mailman List <y2038@lists.linaro.org>, Damien Le Moal <damien.lemoal@wdc.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, John Garry <john.garry@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>, linux-block <linux-block@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Doug Gilbert <dgilbert@interlog.com>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-scsi <linux-scsi@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 12, 2019 at 1:28 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/12/19 00:05, Michael S. Tsirkin wrote:
> >> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> >>
> >>  static const struct block_device_operations virtblk_fops = {
> >>      .ioctl  = virtblk_ioctl,
> >> +#ifdef CONFIG_COMPAT
> >> +    .compat_ioctl = blkdev_compat_ptr_ioctl,
> >> +#endif
> >>      .owner  = THIS_MODULE,
> >>      .getgeo = virtblk_getgeo,
> >>  };
> > Hmm - is virtio blk lumped in with scsi things intentionally?
>
> I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.

It currently calls scsi_cmd_blk_ioctl(), which implements a bunch of ioctl
commands, including some that are unrelated to SG_IO:

                case SG_GET_VERSION_NUM:
                case SCSI_IOCTL_GET_IDLUN:
                case SCSI_IOCTL_GET_BUS_NUMBER:
                case SG_SET_TIMEOUT:
                case SG_GET_TIMEOUT:
                case SG_GET_RESERVED_SIZE:
                case SG_SET_RESERVED_SIZE:
                case SG_EMULATED_HOST:
                case SG_IO: {
                case CDROM_SEND_PACKET:
                case SCSI_IOCTL_SEND_COMMAND:
                case CDROMCLOSETRAY:
                case CDROMEJECT:

My patch changes all callers of this function, and the idea is
to preserve the existing behavior through my series, so I think
it makes sense to keep my patch as is.

I would assume that calling scsi_cmd_blk_ioctl() is harmless
here, but if you want to remove it or limit the set of supported
commands, that should be independent of my change.

       Arnd
