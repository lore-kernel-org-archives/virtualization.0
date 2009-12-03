From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] virtio spec: add virtio-blk max sectors feature
Date: Thu, 03 Dec 2009 11:58:38 +0200
Message-ID: <4B178BCE.7030003__20561.4203274765$1259834404$gmane$org@redhat.com>
References: <OF38B713F7.02DD66D1-ONC2257681.002F3CAD-C2257681.002FDEA6@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <OF38B713F7.02DD66D1-ONC2257681.002F3CAD-C2257681.002FDEA6@il.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avishay Traeger1 <AVISHAY@il.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/03/2009 10:42 AM, Avishay Traeger1 wrote:
> I previously submitted a patch to have the guest virtio-blk driver get the
> value for the maximum I/O size from the host bdrv, rather than assume that
> there is no limit.  Avi requested that I first patch the virtio spec
> (http://ozlabs.org/~rusty/virtio-spec/).  Below is that patch.
>
> Please CC me on replies, as I am not subscribed.
>
>    

Copying Rusty and virtualization@.

> Thank you,
> Avishay
>
> Signed-off-by: Avishay Traeger<avishay@il.ibm.com>
>
> --- virtio-spec-0.8.2.lyx     2009-11-30 16:34:16.000000000 +0200
> +++ virtio-spec-0.8.2-mod.lyx 2009-12-01 16:04:36.000000000 +0200
> @@ -3999,6 +3999,20 @@
>   \end_inset
>
>   .
> +\change_inserted 0 1259672174
> +
> +\end_layout
> +
> +\begin_layout Description
> +
> +\change_inserted 0 1259672252
> +VIRTIO_BLK_F_SECTOR_MAX
> +\begin_inset space ~
> +\end_inset
> +
> +(10) Maximum sectors in an I/O.
> +\change_unchanged
> +
>   \end_layout
>
>   \end_deeper
> @@ -4068,6 +4082,17 @@
>   \begin_layout Plain Layout
>
>        u32 blk_size;
> +\change_inserted 0 1259672274
> +
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 0 1259672305
> +
> +     u32 sectors_max;
> +\change_unchanged
> +
>   \end_layout
>
>   \begin_layout Plain Layout
> @@ -4107,6 +4132,18 @@
>   \begin_layout Enumerate
>   If the VIRTIO_BLK_F_RO feature is set by the device, any write requests
>    will fail.
> +\change_inserted 0 1259672345
> +
> +\end_layout
> +
> +\begin_layout Enumerate
> +
> +\change_inserted 0 1259672454
> +If the VIRTIO_BLK_F_SECTOR_MAX feature is negotiated, the sectors_max
> field
> + should be read to determine the maximum I/O size for the driver to use.
> + No requests should be submitted which go beyond this limit.
> +\change_unchanged
> +
>   \end_layout
>
>   \begin_layout Section*
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    


-- 
error compiling committee.c: too many arguments to function
