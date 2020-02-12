From: Johannes Hirte <johannes.hirte@datenkhaos.de>
Subject: Re: [PATCH v3 13/22] compat_ioctl: scsi: move ioctl handling into
 drivers
Date: Wed, 12 Feb 2020 22:14:52 +0100
Message-ID: <20200212211452.GA5726@latitude>
References: <20200102145552.1853992-1-arnd@arndb.de>
 <20200102145552.1853992-14-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200102145552.1853992-14-arnd@arndb.de>
Sender: linux-block-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, Doug Gilbert <dgilbert@interlog.com>, Kai =?utf-8?B?TcOka2lzYXJh?= <Kai.Makisara@kolumbus.fi>, Alexander Viro <viro@zeniv.linux.org.uk>, Dongli Zhang <dongli.zhang@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>, John Garry <john.garry@huawei.com>, Martin Wilck <mwilck@suse.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Gustavo A. R. Silva" <gustavo@embedded>
List-Id: virtualization@lists.linuxfoundation.org

On 2020 Jan 02, Arnd Bergmann wrote:
> Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
> handler that implements the same commands by calling scsi_compat_ioctl().
> 
> The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
> at this point, so any driver that calls those can do so for both native
> and compat mode, with the argument passed through compat_ptr().
> 
> With this, we can remove the entries from fs/compat_ioctl.c.  The new
> code is larger, but should be easier to maintain and keep updated with
> newly added commands.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/virtio_blk.c |   3 +
>  drivers/scsi/ch.c          |   9 ++-
>  drivers/scsi/sd.c          |  50 ++++++--------
>  drivers/scsi/sg.c          |  44 ++++++++-----
>  drivers/scsi/sr.c          |  57 ++++++++++++++--
>  drivers/scsi/st.c          |  51 ++++++++------
>  fs/compat_ioctl.c          | 132 +------------------------------------
>  7 files changed, 142 insertions(+), 204 deletions(-)
> 

This breaks libcdio. cd-info now results in:

cd-info version 2.1.0 x86_64-pc-linux-gnu
Copyright (c) 2003-2005, 2007-2008, 2011-2015, 2017 R. Bernstein
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
CD location   : /dev/cdrom
CD driver name: GNU/Linux
   access mode: IOCTL

Error in getting drive hardware properties
Error in getting drive reading properties
Error in getting drive writing properties
__________________________________

Disc mode is listed as: CD-DA
++ WARN: error in ioctl CDROMREADTOCHDR: Bad address

cd-info: Can't get first track number. I give up.


-- 
Regards,
  Johannes Hirte
