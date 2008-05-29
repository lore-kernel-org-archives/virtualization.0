From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH/RFC] virtio_blk: check for hardsector size from host
Date: Thu, 29 May 2008 10:12:55 +0200
Message-ID: <20080529081255.GO25504__9063.77697033367$1212049107$gmane$org@kernel.dk>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<200805291804.11550.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805291804.11550.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 29 2008, Rusty Russell wrote:
> On Tuesday 27 May 2008 19:04:59 Christian Borntraeger wrote:
> > Rusty, Jens,
> >
> > I need your opinion on the following patch. It seems to work, but I would
> > like to get some feedback if this patch is the right approach:
> 
> Looks like the right approach to me.  Don't know about the block side
> of it...

Looks good to me, definitely an improvement for eg loop backed
storage.

> Just that u64 seems like overkill: u32?

Definitely, u32 would be just fine, u64 is way overkill :-)

-- 
Jens Axboe
