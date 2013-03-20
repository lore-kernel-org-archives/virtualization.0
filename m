From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V2 11/22] virtio-scsi: use virtqueue_add_sgs for command
	buffers
Date: Wed, 20 Mar 2013 11:05:50 +1030
Message-ID: <87620mrjq1.fsf@rustcorp.com.au>
References: <20130319065131.GA31573@hj.localdomain>
	<1363686539-13326-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363686539-13326-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>, asias@redhat.com
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Wanlong Gao <gaowanlong@cn.fujitsu.com> writes:
> Using the new virtqueue_add_sgs function lets us simplify the queueing
> path.  In particular, all data protected by the tgt_lock is just gone
> (multiqueue will find a new use for the lock).
>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Asias He <asias@redhat.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks... and I agree with Paulo: this is nice.

I've replaced the patch I posted with this one.

Cheers,
Rusty.
