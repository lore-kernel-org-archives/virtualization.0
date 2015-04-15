From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] virtio_balloon: virtio 1 support
Date: Wed, 15 Apr 2015 17:45:11 +0200
Message-ID: <20150415174415-mutt-send-email-mst__49740.4072470546$1429112755$gmane$org@redhat.com>
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
Content-Disposition: inline
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
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 15, 2015 at 10:15:20AM +0930, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Tue, Apr 14, 2015 at 11:50:53AM +0200, Cornelia Huck wrote:
> >> On Tue, 14 Apr 2015 11:21:11 +0200
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> >> > index f81b220..164e0c2 100644
> >> > --- a/include/uapi/linux/virtio_balloon.h
> >> > +++ b/include/uapi/linux/virtio_balloon.h
> >> > @@ -52,15 +52,31 @@ struct virtio_balloon_config {
> >> >  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> >> >  #define VIRTIO_BALLOON_S_NR       6
> >> > 
> >> > +/*
> >> > + * Memory statistics structure.
> >> > + * Driver fills an array of these structures and passes to device.
> >> > + *
> >> > + * NOTE: fields are laid out in a way that would make compiler add padding
> >> > + * between and after fields, so we have to use compiler-specific attributes to
> >> > + * pack it, to disable this padding. This also often causes compiler to
> >> > + * generate suboptimal code.
> >> > + *
> >> > + * We maintain this for backwards compatibility, but don't follow this example.
> >> 
> >> s/this/the existing statistics structure/
> >
> > existing seems redundant. What else? non-existing?
> >
> >> > + *
> >> > + * Do something like the below instead:
> >> 
> >> If you want to implement a similar structure, do...
> >> 
> >> Just that nobody gets the idea that they are supposed to implement new
> >> balloon statistics ;)
> >> 
> >> > + *     struct virtio_balloon_stat {
> >> > + *         __virtio16 tag;
> >> > + *         __u8 reserved[6];
> >> > + *         __virtio64 val;
> >> > + *     };
> >> 
> >> (...)
> >> 
> >> > @@ -225,13 +219,8 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
> >> >  			       u16 tag, u64 val)
> >> >  {
> >> >  	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
> >> > -	if (virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1)) {
> >> > -		vb->stats[idx].tag = cpu_to_le32(tag);
> >> > -		vb->stats[idx].val = cpu_to_le64(val);
> >> > -	} else {
> >> > -		vb->legacy_stats[idx].tag = tag;
> >> > -		vb->legacy_stats[idx].val = val;
> >> > -	}
> >> > +	vb->stats[idx].tag = cpu_to_virtio16(vb->vdev, tag);
> >> 
> >> Seems that nobody seemed to care much about statistics...
> >
> > Or about BE guests ;)
> >
> >> > +	vb->stats[idx].val = cpu_to_virtio64(vb->vdev, val);
> >> >  }
> >> > 
> >> >  #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
> >> > 
> >> 
> >> With these changes merged in:
> >> 
> >> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> >
> >
> > OK, here's an updated incremental patch: only comment
> > changed.
> 
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

Fine by me.


> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 6a356e344f82..9db546ebe5a1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -214,8 +219,8 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
>  			       u16 tag, u64 val)
>  {
>  	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
> -	vb->stats[idx].tag = tag;
> -	vb->stats[idx].val = val;
> +	vb->stats[idx].tag = cpu_to_virtio16(vb->vdev, tag);
> +	vb->stats[idx].val = cpu_to_virtio64(vb->vdev, val);
>  }
>  
>  #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
> @@ -283,18 +288,27 @@ static void virtballoon_changed(struct virtio_device *vdev)
>  
>  static inline s64 towards_target(struct virtio_balloon *vb)
>  {
> -	__le32 v;
>  	s64 target;
> +	u32 num_pages;
>  
> -	virtio_cread(vb->vdev, struct virtio_balloon_config, num_pages, &v);
> +	virtio_cread(vb->vdev, struct virtio_balloon_config, num_pages,
> +		     &num_pages);
>  
> -	target = le32_to_cpu(v);
> +	/* Legacy balloon config space is LE, unlike all other devices. */
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
> +		num_pages = le32_to_cpu((__force __le32)num_pages);
> +
> +	target = num_pages;
>  	return target - vb->num_pages;
>  }
>  
>  static void update_balloon_size(struct virtio_balloon *vb)
>  {
> -	__le32 actual = cpu_to_le32(vb->num_pages);
> +	u32 actual = vb->num_pages;
> +
> +	/* Legacy balloon config space is LE, unlike all other devices. */
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
> +		actual = (__force u32)cpu_to_le32(actual);
>  
>  	virtio_cwrite(vb->vdev, struct virtio_balloon_config, actual,
>  		      &actual);
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 4b0488f20b2e..984169a819ee 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -25,6 +25,7 @@
>   * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
>   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>   * SUCH DAMAGE. */
> +#include <linux/types.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
>  
> @@ -38,9 +39,9 @@
>  
>  struct virtio_balloon_config {
>  	/* Number of pages host wants Guest to give up. */
> -	__le32 num_pages;
> +	__u32 num_pages;
>  	/* Number of pages we've actually got in balloon. */
> -	__le32 actual;
> +	__u32 actual;
>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -51,9 +52,32 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>  #define VIRTIO_BALLOON_S_NR       6
>  
> +/*
> + * Memory statistics structure.
> + * Driver fills an array of these structures and passes to device.
> + *
> + * NOTE: fields are laid out in a way that would make compiler add padding
> + * between and after fields, so we have to use compiler-specific attributes to
> + * pack it, to disable this padding. This also often causes compiler to
> + * generate suboptimal code.
> + *
> + * We maintain this statistics structure format for backwards compatibility,
> + * but don't follow this example.
> + *
> + * If implementing a similar structure, do something like the below instead:
> + *     struct virtio_balloon_stat {
> + *         __virtio16 tag;
> + *         __u8 reserved[6];
> + *         __virtio64 val;
> + *     };
> + *
> + * In other words, add explicit reserved fields to align field and
> + * structure boundaries at field size, avoiding compiler padding
> + * without the packed attribute.
> + */
>  struct virtio_balloon_stat {
> -	__u16 tag;
> -	__u64 val;
> +	__virtio16 tag;
> +	__virtio64 val;
>  } __attribute__((packed));
>  
>  #endif /* _LINUX_VIRTIO_BALLOON_H */
