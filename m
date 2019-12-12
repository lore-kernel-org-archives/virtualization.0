From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into drivers
Date: Thu, 12 Dec 2019 08:27:29 -0800
Message-ID: <20191212162729.GB27991__20231.9536054105$1576168087$gmane$org@infradead.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, y2038@lists.linaro.org, Damien Le Moal <damien.lemoal@wdc.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org, Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Doug Gilbert <dgilbert@interlog.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
> I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.

CONFIG_VIRTIO_BLK_SCSI has been broken for about two years, as it
never set the QUEUE_FLAG_SCSI_PASSTHROUGH flag after that was
introduced.  I actually have a patch that I plan to send to remove
this support as it was a really idea to start with (speaking as
the person who had that idea back in the day).
