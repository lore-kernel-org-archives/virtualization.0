From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] virtio_blk: unlock vblk->lock during kick
Date: Mon, 04 Jun 2012 08:02:16 +0200
Message-ID: <4FCC4F68.4020304@de.ibm.com>
References: <1338383963-17910-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<4FC622F9.2070506@de.ibm.com> <877gvn3kks.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877gvn3kks.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, khoa@us.ibm.com, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 04/06/12 03:57, Rusty Russell wrote:
> Unfortunately, this conflicts with Asias He's deadlock fix, which has
> us just using the block-layer-supplied spinlock.
> 
> If we drop the lock around the kick as you suggest, we're playing with
> fire.  All the virtio backends have an atomic notify, so they're OK,
> and the block layer *looks* safe at a glance, but there's no assurances.

Well, the kick itself returns early, but in the host every other action
is already asynchronously running - not caring about the guest locks at all.
So if removing the lock around the kick causes a problem, then the problem
is already present, no?

Christian
