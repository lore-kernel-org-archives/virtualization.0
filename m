From: Will Deacon <will@kernel.org>
Subject: Re: read_barrier_depends() usage in vhost.c
Date: Thu, 17 Oct 2019 00:36:02 +0100
Message-ID: <20191016233602.i2afxb5mb465laq6__11314.4663324178$1571268977$gmane$org@willie-the-truck>
References: <20191016233340.djrr7o7dwueqccac@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191016233340.djrr7o7dwueqccac@willie-the-truck>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: peterz@infradead.org, stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, paulmck@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

[Bah: I typoed the LKML address, so I've fixed it for this one]

On Thu, Oct 17, 2019 at 12:33:40AM +0100, Will Deacon wrote:
> Hi all,
> 
> In an attempt to remove the remaining traces of [smp_]read_barrier_depends()
> following my previous patches to strengthen READ_ONCE() for Alpha [1], I
> ended up trying to decipher the read_barrier_depends() usage in the vhost
> driver:
> 
> --->8
> 
> // drivers/vhost/vhost.c
> static int get_indirect(struct vhost_virtqueue *vq,
> 			struct iovec iov[], unsigned int iov_size,
> 			unsigned int *out_num, unsigned int *in_num,
> 			struct vhost_log *log, unsigned int *log_num,
> 			struct vring_desc *indirect)
> {
> 	[...]
> 
> 	/* We will use the result as an address to read from, so most
> 	 * architectures only need a compiler barrier here. */
> 	read_barrier_depends();
> 
> --->8
> 
> Unfortunately, although the barrier is commented (hurrah!), it's not
> particularly enlightening about the accesses making up the dependency
> chain, and I don't understand the supposed need for a compiler barrier
> either (read_barrier_depends() doesn't generally provide this).
> 
> Does anybody know which accesses are being ordered here? Usually you'd need
> a READ_ONCE()/rcu_dereference() beginning the chain, but I haven't managed
> to find one...
> 
> Thanks,
> 
> Will
> 
> [1] c2bc66082e10 ("locking/barriers: Add implicit smp_read_barrier_depends() to READ_ONCE()")
