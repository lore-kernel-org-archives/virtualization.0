From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/6] virtio block driver
Date: Sun, 23 Sep 2007 16:47:31 +1000
Message-ID: <1190530051.27805.103.camel__8979.88308356634$1190530237$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
	<20070920122713.GK2367@kernel.dk>
	<1190376007.27805.19.camel@localhost.localdomain>
	<20070921122746.GO2367@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070921122746.GO2367@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-21 at 14:27 +0200, Jens Axboe wrote:
> On Fri, Sep 21 2007, Rusty Russell wrote:
> > I shall look through the code and see if I can figure out how to fix it.
> > I'm assuming from your response that there's not some strange reason to
> > preserve current behaviour.
> 
> It surely sounds like a bug, if you issue ioctl(fd, CDROMEJECT), the
> driver sees it and returns -ENOTTY, but userland sees a 0 retval. So if
> you have time, please do poke at it a bit.

OK, error (-ENOTTY) gets to blk_end_sync_rq(), but nothing happens to
it.  This patch makes the ioctl return -EIO: I can't see a way to pass
the errno back properly.

diff -r 99e125262d6a block/ll_rw_blk.c
--- a/block/ll_rw_blk.c	Sat Sep 22 15:37:22 2007 +1000
+++ b/block/ll_rw_blk.c	Sun Sep 23 16:43:42 2007 +1000
@@ -2792,6 +2792,9 @@ void blk_end_sync_rq(struct request *rq,
 	rq->end_io_data = NULL;
 	__blk_put_request(rq->q, rq);
 
+	if (error)
+		rq->errors++;
+
 	/*
 	 * complete last, if this is a stack request the process (and thus
 	 * the rq pointer) could be invalid right after this complete()
