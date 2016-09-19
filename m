From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11] virtio-net: add Max MTU configuration field
Date: Mon, 19 Sep 2016 20:35:07 +0300
Message-ID: <20160919202905-mutt-send-email-mst@kernel.org>
References: <1474297826-7642-1-git-send-email-aconole@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1474297826-7642-1-git-send-email-aconole@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Aaron Conole <aconole@redhat.com>
Cc: Victor Kaplansky <vkaplans@redhat.com>, virtio-dev@lists.oasis-open.org, Maxime Coquelin <maxime.coquelin@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 19, 2016 at 11:10:26AM -0400, Aaron Conole wrote:
> It is helpful for a host to indicate it's MTU to be set on guest NICs
> other than the assumed 1500 byte value.  This helps in situations where
> the host network is using Jumbo Frames, or aiding in PMTU discovery by
> configuring a homogenous network.  It is also helpful for sizing receive
> buffers correctly.
> 
> The change adds a new field to configuration area of network
> devices.  It will be used to pass a maximum MTU from the device to
> the driver.  This will be used by the driver as a maximum value for
> packet sizes during transmission, without segmentation offloading.
> 
> In addition, in order to support backward and forward compatibility,
> we introduce a new feature bit called VIRTIO_NET_F_MTU.
> 
> VIRTIO-152
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> Cc: Victor Kaplansky <victork@redhat.com>
> Reviewed-by: Hannes Reiencke <hare@suse.de>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>    Note: should this proposal be accepted and approved, one or more
>    claims disclosed to the TC admin and listed on the Virtio TC
>    IPR page https://www.oasis-open.org/committees/virtio/ipr.php
>    might become Essential Claims.
> 
> v1:
> This is an attempt at continuing the work done by Victor Kaplansky on
> mtu negiotiation for virtio-net devices. It attempts to pick up from
> https://lists.oasis-open.org/archives/virtio-dev/201508/msg00007.html
> and is just a minor blurb from the first patch along with the 2nd patch
> from the series, and some of the feedback integrated.
> 
> v2:
> Rephrase and provide a mechanism for guest->host and host->guest
> communication through a driver read-only and driver write-only field.
> 
> v3:
> Converted to just support initial MTU. Guest->host and Host->guest MTU
> changes are outside the scope of this change.
> 
> v4:
> Removed references to 'initial', since that condition cannot be tested.
> Simply state that if the driver will use the mtu field, it must
> negotiate the feature bit, and if not, it must not.
> 
> v5:
> After feedback from Michael S. Tsirkin
> 
> v6:
> Bit has to change to bit 25 due to an undocumented bit 24 being taken.
> 
> v7:
> Partial rewrite with feedback from MST.  Additional conformance statements
> added.
> 
> v8:
> Clarified the new conformance statements.
> 
> v9:
> Updated the commit log for correctness.  Added ACKs from
> Michael S. Tsirkin, and Maxime Coquelin.  Included the virtio
> issue id.
> 
> v10:
> Update the conformance statement wordings from previous 'offered' form
> to 'succesfully negotiated' form.
> 
> v11:
> Clarified size w.r.t. MTU - buffer sizes must also add extra space for ethernet
> headers.  Also updated the feature bit description.
> 
>  content.tex | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 4b45678..45b94c6 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3049,6 +3049,11 @@ features.
>  \item[VIRTIO_NET_F_CTRL_GUEST_OFFLOADS (2)] Control channel offloads
>          reconfiguration support.
>  
> +\item[VIRTIO_NET_F_MTU(3)] Device maximum MTU reporting is supported. If
> +    offered by the device, device advises driver about the value of
> +    its maximum MTU. If negotiated, the driver uses \field{mtu} as
> +    the maximum MTU value.
> +
>  \item[VIRTIO_NET_F_MAC (5)] Device has given MAC address.
>  
>  \item[VIRTIO_NET_F_GUEST_TSO4 (7)] Driver can receive TSOv4.
> @@ -3140,11 +3145,16 @@ of each of transmit and receive virtqueues (receiveq1\ldots receiveqN
>  and transmitq1\ldots transmitqN respectively) that can be configured once VIRTIO_NET_F_MQ
>  is negotiated.
>  
> +The following driver-read-only field, \field{mtu} only exists if
> +VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driver to
> +use.
> +
>  \begin{lstlisting}
>  struct virtio_net_config {
>          u8 mac[6];
>          le16 status;
>          le16 max_virtqueue_pairs;
> +        le16 mtu;
>  };
>  \end{lstlisting}
>  
> @@ -3153,6 +3163,23 @@ struct virtio_net_config {
>  The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000 inclusive,
>  if it offers VIRTIO_NET_F_MQ.
>  
> +The device MUST set \field{mtu} to between 68 and 65535 inclusive,
> +if it offers VIRTIO_NET_F_MTU.
> +
> +The device SHOULD set \field{mtu} to at least 1280, if it offers
> +VIRTIO_NET_F_MTU.
> +
> +The device MUST NOT modify \field{mtu} once it has been set.
> +
> +The device MUST NOT pass received packets that exceed \field{mtu} (plus low
> +level ethernet header length) size with \field{gso_type} NONE or ECN
> +after VIRTIO_NET_F_MTU has been successfully negotiated.
> +
> +The device MUST forward transmitted packets of up to \field{mtu} (plus low
> +level ethernet header length) size with \field{gso_type} NONE or ECN, and do
> +so without fragmentation, after VIRTIO_NET_F_MTU has been successfully
> +negotiated.
> +
>  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>  
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> @@ -3165,6 +3192,16 @@ If the driver does not negotiate the VIRTIO_NET_F_STATUS feature, it SHOULD
>  assume the link is active, otherwise it SHOULD read the link status from
>  the bottom bit of \field{status}.
>  
> +A driver SHOULD negotiate VIRTIO_NET_F_MTU if the device offers it.
> +
> +If the driver negotiates VIRTIO_NET_F_MTU, it MUST supply enough receive
> +buffers of size \field{mtu} (plus low level ethernet header length) to be
> +able to receive at least one receive packet with \field{gso_type} NONE or ECN.

I think this should be

 If the driver negotiates VIRTIO_NET_F_MTU, it MUST supply enough receive
 buffers to be able to receive at least one receive packet
 of size \field{mtu} (plus low level ethernet header length)
 with \field{gso_type} NONE or ECN.


The difference being that (IMO) we do not need to dictate buffer size,
individual buffers can be smaller than MTU, as long as
the driver supplies many of these.


> +
> +If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
> +size exceeding the value of \field{mtu} (plus low level ethernet header length)
> +with \field{gso_type} NONE or ECN
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.7.4
