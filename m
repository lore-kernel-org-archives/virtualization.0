From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2] virtio-spec: set mac address by a new vq command
Date: Fri, 18 Jan 2013 11:43:51 +0100
Message-ID: <20130118104351.GA22481__48204.4593817138$1358505865$gmane$org@stefanha-thinkpad.redhat.com>
References: <1358418347-29496-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358418347-29496-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 17, 2013 at 06:25:47PM +0800, akong@redhat.com wrote:
> From: Amos Kong <akong@redhat.com>
> 
> Virtio-net driver currently programs MAC address byte by byte,
> this means that we have an intermediate step where mac is wrong.
> This patch introduced a new control command to set MAC address
> in one time, and added a new feature flag VIRTIO_NET_F_MAC_ADDR
> for this feature.
> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
> v2: add more detail about new command (Stefan)
> ---
>  virtio-spec.lyx | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index 1ba9992..1ec0cd4 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -56,6 +56,7 @@
>  \html_math_output 0
>  \html_css_as_file 0
>  \html_be_strict false
> +\author -1930653948 "Amos Kong" 
>  \author -608949062 "Rusty Russell,,," 
>  \author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
>  \author 1112500848 "Rusty Russell" rusty@rustcorp.com.au
> @@ -4391,6 +4392,14 @@ VIRTIO_NET_F_GUEST_ANNOUNCE(21) Guest can send gratuitous packets.
>  
>  \change_inserted 1986246365 1352742808
>  VIRTIO_NET_F_MQ(22) Device supports multiqueue with automatic receive steering.
> +\change_inserted -1930653948 1358319033
> +
> +\end_layout
> +
> +\begin_layout Description
> +
> +\change_inserted -1930653948 1358319080
> +VIRTIO_NET_F_CTRL_MAC_ADDR(23) Set MAC address.
>  \change_unchanged
>  
>  \end_layout
> @@ -5284,7 +5293,11 @@ The class VIRTIO_NET_CTRL_RX has two commands: VIRTIO_NET_CTRL_RX_PROMISC
>  \end_layout
>  
>  \begin_layout Subsubsection*
> -Setting MAC Address Filtering
> +Setting MAC Address
> +\change_deleted -1930653948 1358318470
> + Filtering
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Standard
> @@ -5324,6 +5337,17 @@ struct virtio_net_ctrl_mac {
>  \begin_layout Plain Layout
>  
>   #define VIRTIO_NET_CTRL_MAC_TABLE_SET        0 
> +\change_inserted -1930653948 1358318313
> +
> +\end_layout
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted -1930653948 1358318331
> +
> + #define VIRTIO_NET_CTRL_MAC_ADDR_SET         1
> +\change_unchanged
> +
>  \end_layout
>  
>  \end_inset
> @@ -5349,6 +5373,38 @@ T_CTRL_MAC_TABLE_SET.
>   The command-specific-data is two variable length tables of 6-byte MAC addresses.
>   The first table contains unicast addresses, and the second contains multicast
>   addresses.
> +\change_inserted -1930653948 1358318545
> +
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted -1930653948 1358418243
> +The config space 
> +\begin_inset Quotes eld
> +\end_inset
> +
> +mac
> +\begin_inset Quotes erd
> +\end_inset
> +
> + field and the command VIRTIO_NET_CTRL_MAC_ADDR_SET both set the default
> + MAC address which rx filtering accepts.
> + The command VIRTIO_NET_CTRL_MAC_ADDR_SET is atomic whereas the config space
> + 
> +\begin_inset Quotes eld
> +\end_inset
> +
> +mac
> +\begin_inset Quotes erd
> +\end_inset
> +
> + field is not.
> + Therefore, VIRTIO_NET_CTRL_MAC_ADDR_SET is preferred, especially while
> + the NIC is up.
> + The command-specific-data is a 6-byte MAC address.
> +\change_unchanged

The specification must also say that the "mac" field is read-only when
the VIRTIO_NET_CTRL_MAC_ADDR_SET command is supported.

(I think you added this behavior to your patch.)

Stefan
