From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: merge S/G list entries by default
Date: Sun, 7 Sep 2014 20:47:45 +0200
Message-ID: <20140907184745.GA23026@lst.de>
References: <1410044994-14943-1-git-send-email-hch@lst.de>
	<20140907114153.GB26569@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140907114153.GB26569@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 07, 2014 at 02:41:53PM +0300, Michael S. Tsirkin wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> OK so this is an optimization patch right?
> What kind of performance gain is observed with it?

None.  I actually wrote it when the block layer had a bug when dm was
used on top of the !merge case, and I decided to send it out as there had been
no discussion about disabling this by default on the existing blk-mq
drivers.

At least for my qemu/kvm setup it doesn't make a difference either way,
although not doing the cheap merge doesn't like the right kind of optimization
to me.
