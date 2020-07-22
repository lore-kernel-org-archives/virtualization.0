From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 02/10] block: virtio-blk: check logical block size
Date: Tue, 21 Jul 2020 22:55:07 -0400
Message-ID: <yq1zh7sfedj.fsf@ca-mkp.ca.oracle.com>
References: <20200721105239.8270-1-mlevitsk@redhat.com>
 <20200721105239.8270-3-mlevitsk@redhat.com>
 <20200721151437.GB10620@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200721151437.GB10620@lst.de> (Christoph Hellwig's message of
 "Tue, 21 Jul 2020 17:14:37 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "open list:NVM EXPRESS
 DRIVER" <linux-nvme@lists.infradead.org>, "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux-foundation.org>, Hou Tao <houtao1@huawei.com>, Satya Tangirala <satyat@google.com>, Sagi Grimberg <sagi@grimberg.me>, "open list:SCSI CDROM DRIVER" <linux-scsi@vger.kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Ajay Joshi <ajay.joshi@wdc.com>, Alex Dubov <oakad@yahoo.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Colin Ian King <colin.king@canonical.com>, Keith Busch <kbusch@kernel.org>, "open list:NETWORK BLOCK DEVICE (NBD)" <nbd@other.debian.org>, Bart Van Assche <bvanassche@acm.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Jen
List-Id: virtualization@lists.linuxfoundation.org


Christoph,

> Hmm, I wonder if we should simply add the check and warning to
> blk_queue_logical_block_size and add an error in that case.  Then
> drivers only have to check the error return, which might add a lot
> less boiler plate code.

Yep, I agree.

-- 
Martin K. Petersen	Oracle Linux Engineering
