From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	ring	itself
Date: Thu, 06 May 2010 13:00:00 +0300
Message-ID: <4BE29320.5090506__22676.5784355395$1273140140$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505205814.GA7090@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/05/2010 11:58 PM, Michael S. Tsirkin wrote:
> +	/* We publish the last-seen used index at the end of the available ring.
> +	 * It is at the end for backwards compatibility. */
> +	vr->last_used_idx =&(vr)->avail->ring[num];
> +	/* Verify that last used index does not spill over the used ring. */
> +	BUG_ON((void *)vr->last_used_idx +
> +	       sizeof *vr->last_used_idx>  (void *)vr->used);
>   }
>    

Shouldn't this be on its own cache line?

One way to achieve this is to allocate it at the end.

-- 
error compiling committee.c: too many arguments to function
