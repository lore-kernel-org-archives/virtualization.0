From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] virtio_blk: check for hardsector size from host
Date: Fri, 30 May 2008 13:41:45 +1000
Message-ID: <200805301341.46175.rusty__49052.8797651224$1212119038$gmane$org@rustcorp.com.au>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<20080529083004.GQ25504@kernel.dk>
	<200805291108.26375.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805291108.26375.borntraeger@de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 29 May 2008 19:08:26 Christian Borntraeger wrote:
> Currently virtio_blk assumes a 512 byte hard sector size. This can cause
> trouble / performance issues if the backing has a different block size
> (like a file on an ext3 file system formatted with 4k block size or a
> dasd).
>
> Lets add a feature flag that tells the guest to use a different hard sector
> size than 512 byte.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks.  I've queued this for next kernel (the other two will go 
striaght-away).

Cheers,
Rusty.
