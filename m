From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into drivers
Date: Thu, 12 Dec 2019 09:35:22 -0700
Message-ID: <6e265890-23e5-6368-4e36-d59ff47879b2__37696.4983342745$1576168849$gmane$org@kernel.dk>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
 <20191212162729.GB27991@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212162729.GB27991@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>, Arnd Bergmann <arnd@arndb.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, y2038@lists.linaro.org, Damien Le Moal <damien.lemoal@wdc.com>, John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Doug Gilbert <dgilbert@interlog.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Bart Van Assche <bvanassche@acm.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/12/19 9:27 AM, Christoph Hellwig wrote:
> On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
>> I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
>> sense to lump it in with scsi, but I wouldn't mind getting rid of
>> CONFIG_VIRTIO_BLK_SCSI altogether.
> 
> CONFIG_VIRTIO_BLK_SCSI has been broken for about two years, as it
> never set the QUEUE_FLAG_SCSI_PASSTHROUGH flag after that was
> introduced.  I actually have a patch that I plan to send to remove
> this support as it was a really idea to start with (speaking as
> the person who had that idea back in the day).

We had this very discussion two years ago, and we never got it removed.
Let's please get it done.

-- 
Jens Axboe
