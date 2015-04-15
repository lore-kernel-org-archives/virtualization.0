From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 0/6] virtio_balloon: virtio 1 support
Date: Wed, 15 Apr 2015 17:32:51 +0200
Message-ID: <20150415173251.08daa268.cornelia.huck__39075.5567270846$1429112003$gmane$org@de.ibm.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<20150412170141-mutt-send-email-mst@redhat.com>
	<87h9sjtsvb.fsf@rustcorp.com.au>
	<20150414102438.11d12347.cornelia.huck@de.ibm.com>
	<20150414103036-mutt-send-email-mst@redhat.com>
	<20150414115053.78189c71.cornelia.huck@de.ibm.com>
	<20150414115440-mutt-send-email-mst@redhat.com>
	<87r3rmrzhb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87r3rmrzhb.fsf@rustcorp.com.au>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 Apr 2015 10:15:20 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> OK, I've merged this with one change:
> 
> +static void stats_sg_init(struct virtio_balloon *vb, struct scatterlist *sg)
> +{
> +	sg_init_one(sg, vb->stats, sizeof(vb->stats));
> +}
> +
> ...
> -	sg_init_one(&sg, vb->stats, sizeof(vb->stats));
> +	stats_sg_init(vb, &sg);
> 
> This is no longer a meaningful change, so I removed it.
> 
> Here's the final result:
> 
> From: Michael S. Tsirkin <mst@redhat.com>
> Subject: virtio_balloon: transitional interface
> 
> Virtio 1.0 doesn't include a modern balloon device.
> But it's not a big change to support a transitional
> balloon device: this has the advantage of supporting
> existing drivers, transparently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
Looks good to me.
