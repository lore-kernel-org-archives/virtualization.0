From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional
Date: Mon, 12 Nov 2012 19:03:08 +0200
Message-ID: <20121112170308.GB18220@redhat.com>
References: <20120909113650.GA2775@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120909113650.GA2775@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 09, 2012 at 02:36:50PM +0300, Michael S. Tsirkin wrote:
> Drivers treat MUST_TELL_HOST as optional: windows drivers do not ack it
> and expect this means they can tell host *after* deflate.  This was not
> the intent but the documentation was not very clear on this point.
> 
> Luckily hyprevisors did not implement this feature yet so to provide
> guidance for future devices make spec match drivers expectations, and
> clarify that this feature only has effect if negotiated.
> This is needed as recent developments in kvm (memory
> region rework and the addition of vfio) finally make
> it practical to implement this in devices.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

ping


> ---
> 
> OK how about this minimal patch for starters?
> Other changes are possible on top but I think
> both me and Paolo agree on this one.
> Paolo?
> 
>  virtio-spec.lyx | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index d801aa6..d9626a9 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -6331,8 +6331,13 @@ VIRTIO_CONSOLE_F_SIZE
>  
>  \begin_layout Description
>  VIRTIO_CONSOLE_F_MULTIPORT(1) Device has support for multiple ports; configurati
> -on fields nr_ports and max_nr_ports are valid and control virtqueues will
> - be used.
> +on fields nr_ports and max_nr_ports are valid
> +\change_inserted 1986246365 1347188404
> +; if this bit is negotiated,
> +\change_deleted 1986246365 1347188406
> + and
> +\change_unchanged
> + control virtqueues will be used.
>  \end_layout
>  
>  \end_deeper
> @@ -6840,9 +6845,14 @@ The driver constructs an array of addresses of memory pages it has previously
>  \end_layout
>  
>  \begin_layout Enumerate
> -If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the guest may not
> - use these requested pages until that descriptor in the deflateq has been
> - used by the device.
> +If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is 
> +\change_inserted 1986246365 1347188540
> +negotiated
> +\change_deleted 1986246365 1347188542
> +set
> +\change_unchanged
> +, the guest may not use these requested pages until that descriptor in the
> + deflateq has been used by the device.
>  \end_layout
>  
>  \begin_layout Enumerate
> -- 
> MST
