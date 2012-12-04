From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH] virtio-spec: serial: english tweak
Date: Tue, 4 Dec 2012 01:08:43 -0500 (EST)
Message-ID: <1493537565.18025348.1354601323962.JavaMail.root@redhat.com>
References: <20120909121116.GA2972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120909121116.GA2972@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

----- Original Message -----
> "A number of virtqueues are created" seems clearer
> than "the number of virtqueues": it's
> virtqueues that are created not the number.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Amos Kong <akong@redhat.com>


Two opposite problem exists:

--- virtio-0.9.5.lyx.orig	2012-12-04 09:29:03.249676649 +0800
+++ virtio-0.9.5.lyx	2012-12-04 09:28:26.272678220 +0800
@@ -8685,7 +8685,7 @@ s on QueueNum, QueueAlign and QueuePFN a
 \begin_inset Newline newline
 \end_inset
 
- Queue size is a number of elements in the queue, therefore size of the
+ Queue size is the number of elements in the queue, therefore size of the
  descriptor table and both available and used rings.
 \begin_inset Newline newline
 \end_inset
@@ -8850,7 +8850,7 @@ reference "sub:Device-Initialization-Seq
 \end_layout
 
 \begin_layout Standard
-Virtual queue size is a number of elements in the queue, therefore size
+Virtual queue size is the number of elements in the queue, therefore size
  of the descriptor table and both available and used rings.
 \end_layout
 


> ---
> 
> I'm not a native english speaker but the below
> seems correct to me. Rusty?
> 
>  virtio-spec.lyx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index d9626a9..a29315c 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -6406,7 +6406,7 @@ If the VIRTIO_CONSOLE_F_MULTIPORT feature is
> negotiated, the driver can
>   spawn multiple ports, not all of which may be attached to a
>   console.
>   Some could be generic ports.
>   In this case, the control virtqueues are enabled and according to
>   the max_nr_po
> -rts configuration-space value, the appropriate number of virtqueues
> are
> +rts configuration-space value, an appropriate number of virtqueues
> are
>   created.
>   A control message indicating the driver is ready is sent to the
>   host.
>   The host can then send control messages for adding new ports to the
>   device.
> --
> MST
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
