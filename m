From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into drivers
Date: Thu, 12 Dec 2019 01:28:08 +0100
Message-ID: <858768fb-5f79-8259-eb6a-a26f18fb0e04__14101.8569863931$1576110508$gmane$org@redhat.com>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191211180155-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>, Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, y2038@lists.linaro.org, Damien Le Moal <damien.lemoal@wdc.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Doug Gilbert <dgilbert@interlog.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/12/19 00:05, Michael S. Tsirkin wrote:
>> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>>  
>>  static const struct block_device_operations virtblk_fops = {
>>  	.ioctl  = virtblk_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
>> +#endif
>>  	.owner  = THIS_MODULE,
>>  	.getgeo = virtblk_getgeo,
>>  };
> Hmm - is virtio blk lumped in with scsi things intentionally?

I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
sense to lump it in with scsi, but I wouldn't mind getting rid of
CONFIG_VIRTIO_BLK_SCSI altogether.

Paolo
