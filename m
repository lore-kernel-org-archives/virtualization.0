From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC virt-spec PATCH] only writing out the last byte of MAC
	makes it have effect
Date: Thu, 21 Mar 2013 12:53:33 +0200
Message-ID: <20130321105333.GC30874@redhat.com>
References: <1363834956-9409-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363834956-9409-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 11:02:36AM +0800, Amos Kong wrote:
> The lengcy guests don't have mac programming command, we don't know when
> it's safe to use MAC. We can change QEMU to make MAC change effect when
> the last byte of MAC is written to config space.
> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
>  virtio-spec.lyx | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index dbc4ef0..bb289fb 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -5430,7 +5430,7 @@ T_CTRL_MAC_TABLE_SET.
>  
>  \begin_layout Standard
>  
> -\change_inserted -1930653948 1358506710
> +\change_inserted -1930653948 1363832689
>  The config space 
>  \begin_inset Quotes eld
>  \end_inset
> @@ -5464,6 +5464,15 @@ mac
>   Therefore, VIRTIO_NET_CTRL_MAC_ADDR_SET is preferred, especially while
>   the NIC is up.
>   The command-specific-data is a 6-byte MAC address.
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted -1930653948 1363833477
> +The legacy guests don't support the new command, they still change MAC address
> + in original way, that's not atomic.
> + For more robust, QEMU only makes the MAC change effect when the last byte
> + of MAC address is written to config space.
>  \change_unchanged
>  
>  \end_layout

The wording can be improved, but before that - Rusty, what
do you think about such a hack? Worth supporting or
let's just ask everyone to update drivers?

> -- 
> 1.8.1.4
