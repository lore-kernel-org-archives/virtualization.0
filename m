From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: read_barrier_depends() usage in vhost.c
Date: Wed, 18 Dec 2019 17:19:07 +0800
Message-ID: <20191218091906.cmzgqnwyekak5dzv__45589.8803238355$1576662059$gmane$org@gondor.apana.org.au>
References: <20191016233602.i2afxb5mb465laq6@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191016233602.i2afxb5mb465laq6@willie-the-truck>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Will Deacon <will@kernel.org>
Cc: paulmck@kernel.org, mst@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stern@rowland.harvard.edu
List-Id: virtualization@lists.linuxfoundation.org

Will Deacon <will@kernel.org> wrote:
>
>> --->8
>> 
>> // drivers/vhost/vhost.c
>> static int get_indirect(struct vhost_virtqueue *vq,
>>                       struct iovec iov[], unsigned int iov_size,
>>                       unsigned int *out_num, unsigned int *in_num,
>>                       struct vhost_log *log, unsigned int *log_num,
>>                       struct vring_desc *indirect)
>> {
>>       [...]
>> 
>>       /* We will use the result as an address to read from, so most
>>        * architectures only need a compiler barrier here. */
>>       read_barrier_depends();
>> 
>> --->8
>> 
>> Unfortunately, although the barrier is commented (hurrah!), it's not
>> particularly enlightening about the accesses making up the dependency
>> chain, and I don't understand the supposed need for a compiler barrier
>> either (read_barrier_depends() doesn't generally provide this).
>> 
>> Does anybody know which accesses are being ordered here? Usually you'd need
>> a READ_ONCE()/rcu_dereference() beginning the chain, but I haven't managed
>> to find one...

I think what it's trying to separate is using indirect->addr as a
base and then reading from that through copy_from_iter.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
