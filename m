From: Christoph Hellwig <hch@lst.de>
Subject: make SCSI passthrough support optional
Date: Sat, 28 Jan 2017 09:32:48 +0100
Message-ID: <1485592373-29837-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

this series builds on my previous changes in Jens' for-4.11/rq-refactor
branch that split out the BLOCK_PC fields from struct request into a new
struct scsi_request, and makes support for struct scsi_request and the
SCSI passthrough ioctls optional.  It is now only enabled by drivers that
need it.

In addition I've made SCSI passthrough support in the virtio_blk driver an
optional compile time feature, as it's not actually needed for most
common setups.
