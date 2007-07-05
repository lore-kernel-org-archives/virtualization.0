From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/3] Virtio draft IV: the block driver
Date: Thu, 5 Jul 2007 09:32:50 +0200
Message-ID: <200707050932.50110.borntraeger@de.ibm.com>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183522765.6110.40.camel@localhost.localdomain>
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
To: virtualization@lists.linux-foundation.org
Cc: Carsten Otte <cotte@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 4. Juli 2007 schrieb Rusty Russell:
> +		vbr = mempool_alloc(vblk->pool, GFP_ATOMIC);
> +		if (!vbr)
> +			goto stop;
[...]
> +		BUG_ON(req->nr_phys_segments > ARRAY_SIZE(vblk->sg));
> +		vbr->req = req;
> +		if (!do_req(q, vblk, vbr))
> +			goto stop;
[...]
> +stop:
> +	/* Queue full?  Wait. */
> +	blk_stop_queue(q);
> +	mempool_free(vbr, vblk->pool);


Hmm, can mempool_free really handle NULL as its first argument? (first goto). 
As far as I can see we have a problem here. Our pool has preallocated 1 
element. So what about:
- first alloc fails in mempool_alloc fails -> we get the pre-allocated 
element, no more elements left
- second alloc fails in mempool_alloc fails -> we get NULL -> we return NULL 
to mempool_free which adds NULL back to the pool as the pool is empty. Now 
the pool has an NULL entry, no? 


Christian
