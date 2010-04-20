From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [Qemu-devel] [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 20 Apr 2010 02:46:35 +0100
Message-ID: <20100420014635.GE21899__29788.4341366172$1271728154$gmane$org@shareable.org>
References: <20100218222220.GA14847@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100218222220.GA14847@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, hch@lst.de, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> I took a stub at documenting CMD and FLUSH request types in virtio
> block.  Christoph, could you look over this please?
> 
> I note that the interface seems full of warts to me,
> this might be a first step to cleaning them.
> 
> One issue I struggled with especially is how type
> field mixes bits and non-bit values. I ended up
> simply defining all legal values, so that we have
> CMD = 2, CMD_OUT = 3 and so on.
> 
> I also avoided instroducing inhdr/outhdr structures
> that virtio blk driver in linux uses, I was concerned
> that nesting tables will confuse the reader.
> 
> Comments welcome.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> --
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index d16104a..ed35893 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -67,7 +67,11 @@ IBM Corporation
>  \end_layout
>  
>  \begin_layout Standard
> +
> +\change_deleted 0 1266531118
>  FIXME: virtio block scsi passthrough section
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Standard
> @@ -4376,7 +4380,7 @@ struct virtio_net_ctrl_mac {
>  The device can filter incoming packets by any number of destination MAC
>   addresses.
>  \begin_inset Foot
> -status open
> +status collapsed
>  
>  \begin_layout Plain Layout
>  Since there are no guarentees, it can use a hash filter orsilently switch
> @@ -4549,6 +4553,22 @@ blk_size
>  \end_inset
>  
>  .
> +\change_inserted 0 1266444580
> +
> +\end_layout
> +
> +\begin_layout Description
> +
> +\change_inserted 0 1266471229
> +VIRTIO_BLK_F_SCSI (7) Device supports scsi packet commands.
> +\end_layout
> +
> +\begin_layout Description
> +
> +\change_inserted 0 1266444605
> +VIRTIO_BLK_F_FLUSH (9) Cache flush command support.
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Description
> @@ -4700,17 +4720,25 @@ struct virtio_blk_req {
>  
>  \begin_layout Plain Layout
>  
> +\change_deleted 0 1266472188
> +
>  #define VIRTIO_BLK_T_IN          0
>  \end_layout
>  
>  \begin_layout Plain Layout
>  
> +\change_deleted 0 1266472188
> +
>  #define VIRTIO_BLK_T_OUT         1
>  \end_layout
>  
>  \begin_layout Plain Layout
>  
> +\change_deleted 0 1266472188
> +
>  #define VIRTIO_BLK_T_BARRIER	 0x80000000
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Plain Layout
> @@ -4735,11 +4763,15 @@ struct virtio_blk_req {
>  
>  \begin_layout Plain Layout
>  
> +\change_deleted 0 1266472204
> +
>  #define VIRTIO_BLK_S_OK        0
>  \end_layout
>  
>  \begin_layout Plain Layout
>  
> +\change_deleted 0 1266472204
> +
>  #define VIRTIO_BLK_S_IOERR     1
>  \end_layout
>  
> @@ -4759,32 +4791,481 @@ struct virtio_blk_req {
>  \end_layout
>  
>  \begin_layout Standard
> -The type of the request is either a read (VIRTIO_BLK_T_IN) or a write (VIRTIO_BL
> -K_T_OUT); the high bit indicates that this request acts as a barrier and
> - that all preceeding requests must be complete before this one, and all
> - following requests must not be started until this is complete.
> +
> +\change_inserted 0 1266472490
> +If the device has VIRTIO_BLK_F_SCSI feature, it can also support scsi packet
> + command requests, each of these requests is of form:
> +\begin_inset listings
> +inline false
> +status open
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472395
> +
> +struct virtio_scsi_pc_req {
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472375
> +
> +	u32 type;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472375
> +
> +	u32 ioprio;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266474298
> +
> +	u64 sector;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266474308
> +
> +    char cmd[];
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266505809
> +
> +	char data[][512];
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266505825
> +
> +#define SCSI_SENSE_BUFFERSIZE   96
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266505848
> +
> +    u8 sense[SCSI_SENSE_BUFFERSIZE];
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472969
> +
> +    u32 errors;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472979
> +
> +    u32 data_len;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472984
> +
> +    u32 sense_len;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472987
> +
> +    u32 residual;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472375
> +
> +	u8 status;
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266472375
> +
> +};
> +\end_layout
> +
> +\end_inset
> +
> +
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Standard
> -The ioprio field is a hint about the relative priorities of requests to
> - the device: higher numbers indicate more important requests.
> +The 
> +\emph on
> +type
> +\emph default
> + of the request is either a read (VIRTIO_BLK_T_IN)
> +\change_inserted 0 1266495815
> +,
> +\change_unchanged
> + 
> +\change_deleted 0 1266495817
> +or
> +\change_unchanged
> + a write (VIRTIO_BLK_T_OUT)
> +\change_inserted 0 1266497316
> +, a scsi packet command (VIRTIO_BLK_T_SCSI_CMD or VIRTIO_BLK_T_SCSI_CMD_OUT
> +\begin_inset Foot
> +status open
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266497390
> +the SCSI_CMD and SCSI_CMD_OUT types are equivalent, the device does not
> + distinguish between them
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +
> +) or a flush (VIRTIO_BLK_T_FLUSH or VIRTIO_BLK_T_FLUSH_OUT
> +\begin_inset Foot
> +status open
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1266497402
> +the FLUSH and FLUSH_OUT types are equivalent, the device does not distinguish
> + between them
> +\change_unchanged
> +
> +\end_layout
> +
> +\end_inset
> +
> +)
> +\change_deleted 0 1266503753
> +;
> +\change_inserted 0 1266503758
> +.
> +
> +\change_unchanged
> + 
> +\change_inserted 0 1266497301
> +If the device has VIRTIO_BLK_F_BARRIER feature
> +\begin_inset space ~
> +\end_inset
> +
> +
> +\change_unchanged
> +the high bit
> +\change_inserted 0 1266497301

> + (VIRTIO_BLK_T_BARRIER)
> +\change_unchanged
> + indicates that this request acts as a barrier and that all preceeding requests
> + must be complete before this one, and all following requests must not be
> + started until this is complete.
> +
> +\change_inserted 0 1266504385
> + Note that a barrier does not flush caches in the underlying backend device
> + in host, and thus does not serve as data consistency guarantee.
> + Driver must use FLUSH request to flush the host cache.
> +\change_unchanged
> +

Does this mean that virtio-blk supports all three combinations?

   1. FLUSH that isn't a barrier
   2. FLUSH that is also a barrier
   3. Barrier that is not a flush

1 is good for fsync-like operations;
2 is good for journalling-like ordered operations.
3 sounds like it doesn't mean a lot as the host cache provides no
guarantees and has no ordering facility that can be used.

-- Jamie
