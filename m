From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: fix typo in vring_need_event() doc comment
Date: Mon, 20 Apr 2015 08:03:15 +0200
Message-ID: <20150420080229-mutt-send-email-mst@redhat.com>
References: <1429101336-13100-1-git-send-email-stefanha@redhat.com>
	<878udor9k1.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878udor9k1.fsf@rustcorp.com.au>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Apr 19, 2015 at 02:36:38PM +0930, Rusty Russell wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> > Here the "other side" refers to the guest or host.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Applied.
> 
> Thanks!
> Rusty.

Just to make sure, are you applying this for 4.1?

> > ---
> >  include/uapi/linux/virtio_ring.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index a3318f3..915980a 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -155,7 +155,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
> >  }
> >  
> >  /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
> > -/* Assuming a given event_idx value from the other size, if
> > +/* Assuming a given event_idx value from the other side, if
> >   * we have just incremented index from old to new_idx,
> >   * should we trigger an event? */
> >  static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
> > -- 
> > 2.1.0
