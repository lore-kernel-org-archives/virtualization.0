From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Sun, 17 May 2009 23:46:12 +0930
Message-ID: <200905172346.14498.rusty__25676.2750949294$1242569850$gmane$org@rustcorp.com.au>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<200905171134.31285.rusty@rustcorp.com.au>
	<4A0FAE35.3040608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A0FAE35.3040608@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, Dor Laor <dor@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 17 May 2009 03:57:01 pm Avi Kivity wrote:
> Rusty Russell wrote:
> > +static void adjust_threshold(struct vring_virtqueue *vq,
> > +			     unsigned int out, unsigned int in)
> > +{
> > +	/* There are really two species of virtqueue, and it matters here.
> > +	 * If there are no output parts, it's a "normally full" receive queue,
> > +	 * otherwise it's a "normally empty" send queue. */
>
> This comment is true for networking, but not for block. ++overkill with
> a ->adjust_threshold op.

No, it's true for block.  It has output parts, so we should reduce threshold 
when it's full.  Network recvq is an example which should reduce threshold 
when it's empty.

->adjust_threshold is better as an arg to vring_new_virtqueue, but it's still 
not clear what the answer would be.

Rusty.
