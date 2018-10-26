From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Date: Fri, 26 Oct 2018 10:47:16 -0400
Message-ID: <20181026104636-mutt-send-email-mst@kernel.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20181012210628.226361-1-dverkamp@chromium.org>
	<20181026080838.GB4234@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181026080838.GB4234@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Changpeng Liu <changpeng.liu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 26, 2018 at 09:08:38AM +0100, Stefan Hajnoczi wrote:
> On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> > +		range[n].flags = cpu_to_le32(flags);
> > +		range[n].num_sectors = cpu_to_le32(num_sectors);
> > +		range[n].sector = cpu_to_le64(sector);
> ...
> > +/* Discard/write zeroes range for each request. */
> > +struct virtio_blk_discard_write_zeroes {
> > +	/* discard/write zeroes start sector */
> > +	__virtio64 sector;
> > +	/* number of discard/write zeroes sectors */
> > +	__virtio32 num_sectors;
> > +	/* flags for this range */
> > +	__virtio32 flags;
> 
> cpu_to_le32() is being used on __virtio32 fields instead of cpu_to_virtio32().
> 
> From include/uapi/linux/virtio_types.h:
> 
>   /*
>    * __virtio{16,32,64} have the following meaning:
>    * - __u{16,32,64} for virtio devices in legacy mode, accessed in native endian
>    * - __le{16,32,64} for standard-compliant virtio devices
>    */
> 
> From the VIRTIO specification:
> 
>   struct virtio_blk_discard_write_zeroes {
>          le64 sector;
>          le32 num_sectors;
>          struct {
>                  le32 unmap:1;
>                  le32 reserved:31;
>          } flags;
>   };
> 
> 
> Since the VIRTIO spec says these fields are little-endian, I think these
> fields should be declared just __u32 and __u64 instead of __virtio32 and
> __virtio64.
> 
> Stefan


__le32/__le64 rather?
