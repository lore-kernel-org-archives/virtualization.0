From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Sun, 17 May 2009 09:27:01 +0300
Message-ID: <4A0FAE35.3040608__41117.804326541$1242541683$gmane$org@redhat.com>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<200905041149.00724.rusty@rustcorp.com.au>
	<1242061838.25337.8.camel@blaa>
	<200905171134.31285.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905171134.31285.rusty@rustcorp.com.au>
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
Cc: Mark McLoughlin <markmc@redhat.com>, Dor Laor <dor@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>  
> +static void adjust_threshold(struct vring_virtqueue *vq,
> +			     unsigned int out, unsigned int in)
> +{
> +	/* There are really two species of virtqueue, and it matters here.
> +	 * If there are no output parts, it's a "normally full" receive queue,
> +	 * otherwise it's a "normally empty" send queue. */
>   

This comment is true for networking, but not for block. ++overkill with 
a ->adjust_threshold op.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
