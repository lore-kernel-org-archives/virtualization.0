From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: tweak wording for console control vq
Date: Tue, 21 May 2013 16:18:11 +0930
Message-ID: <87vc6cygk4.fsf@rustcorp.com.au>
References: <20130520122051.GA11581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130520122051.GA11581@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> control vq is only used if feature bit is
> negotiated - it's not enough that device supports
> it. Clarify this in the spec.

Thanks, applied.

Cheers,
Rusty.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  virtio-spec.lyx | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index 921388b..3ef96a9 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -6833,8 +6833,13 @@ VIRTIO_CONSOLE_F_SIZE
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
>  \change_inserted 1112500848 1368412890
>  
>  \end_layout
> -- 
> MST
