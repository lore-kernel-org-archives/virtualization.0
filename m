From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver (V2)
Date: Wed, 18 Nov 2009 12:00:39 +1030
Message-ID: <200911181200.39971.rusty__43695.316653657$1258507980$gmane$org@rustcorp.com.au>
References: <1258488996.2820.35.camel@aglitke>
	<1258490189.2820.37.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258490189.2820.37.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 18 Nov 2009 07:06:29 am Adam Litke wrote:
> virtio: Add memory statistics reporting to the balloon driver (V2)
> 
> Changes since V1:
>  - Use a virtqueue instead of the device config space

Hi Adam,

    If Anthony's happy, I'm happy with this approach.

Couple of minor points:

> +static inline void update_stat(struct virtio_balloon *vb, int idx,
> +				unsigned int tag, unsigned long val)
> +{
> +	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
> +	vb->stats[idx].tag = tag;
> +	vb->stats[idx].val = cpu_to_le32(val);
> +}

The little-endian conversion of the balloon driver is a historical mistake
(no other driver does this).  Let's not extend it to the stats.

Here you've done one and not the other, which is even worse.  (Sparse would
have found this, I assume).

> +struct virtio_balloon_stat
> +{
> +	__le16 tag;
> +	__le32 val;
> +};

Is 32 bits sufficient?  A big machine might get over 4bn faults, and certainly
4 TB of memory isn't that far away.

Thanks,
Rusty.
