From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 00/22] virtqueue_add_sgs, virtqueue_add_outbuf,
	virtqueue_add_inbuf
Date: Wed, 20 Mar 2013 14:01:44 +0800
Message-ID: <20130320060144.GA28683@hj.localdomain>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<87mwtyprz2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mwtyprz2.fsf@rustcorp.com.au>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 20, 2013 at 03:50:33PM +1030, Rusty Russell wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> > Add virtqueue_add_sgs which is more general than virtqueue_add_buf,
> > which makes virtio-scsi and virtio-blk nicer, then add virtqueue_add_inbuf
> > and virtqueue_add_outbuf which handle the more general case, and finally
> > delete virtqueue_add_buf().
> >
> > I'm hoping this will be the final post of the whole series, and it can
> > move from my pending-rebases tree into virtio-next.
> 
> OK, thanks for the feedback, reviews and corrections everyone.
> 
> I folded the following patches into one commit:
> 
>  Subject: [PATCH 02/22] virtio_ring: virtqueue_add_sgs, to add multiple sgs.
>  Subject: [PATCH 03/22] virtio_ring: don't count elements twice for add_buf path.
>  Subject: [PATCH 04/22] virtio_ring: inline internal vring functions more aggres
> 
> I've put it into virtio-next, so please send any further fixes as diffs
> against that.

Cheers!

-- 
Asias
