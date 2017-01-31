From: Jens Axboe <axboe@kernel.dk>
Subject: Re: make SCSI passthrough support optional
Date: Tue, 31 Jan 2017 09:56:59 -0800
Message-ID: <eef9850f-07f7-ef61-22b6-246fc44fbfc0@kernel.dk>
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/28/2017 12:32 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series builds on my previous changes in Jens' for-4.11/rq-refactor
> branch that split out the BLOCK_PC fields from struct request into a new
> struct scsi_request, and makes support for struct scsi_request and the
> SCSI passthrough ioctls optional.  It is now only enabled by drivers that
> need it.
> 
> In addition I've made SCSI passthrough support in the virtio_blk driver an
> optional compile time feature, as it's not actually needed for most
> common setups.

Appled.

-- 
Jens Axboe
