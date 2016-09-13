From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10] virtio-net: add Max MTU configuration field
Date: Wed, 14 Sep 2016 00:17:28 +0300
Message-ID: <20160914000341-mutt-send-email-mst__48149.2311032072$1473801465$gmane$org@kernel.org>
References: <1473779892-6234-1-git-send-email-aconole@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1473779892-6234-1-git-send-email-aconole@redhat.com>
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

On Tue, Sep 13, 2016 at 11:18:12AM -0400, Aaron Conole wrote:
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
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
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
>  content.tex | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 4b45678..42c0568 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3049,6 +3049,11 @@ features.
>  \item[VIRTIO_NET_F_CTRL_GUEST_OFFLOADS (2)] Control channel offloads
>          reconfiguration support.
>  
> +\item[VIRTIO_NET_F_MTU(3)] Maximum negotiated MTU is supported.

I would say "device MTU reporting" is supported.

> If
> +    offered by the device, device advises driver about the value of
> +    MTU to be used.

about its maximum MTU value.

> If negotiated, the driver uses \field{mtu} as
> +    the maximum MTU value supplied to the driver.

Drop "supplied to the driver" here?

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
> @@ -3153,6 +3163,19 @@ struct virtio_net_config {
>  The device MUST set \field{max_virtqueue_pairs} to between 1 and 0x8000 inclusive,
>  if it offers VIRTIO_NET_F_MQ.
>  
> +The device MUST set \field{mtu} to between 68 and 65535 inclusive,
> +if it offers VIRTIO_NET_F_MTU.

Apropos, IPv6 requires that every link in the internet have an MTU of
1280 octets or greater.  There are also requirements to be able to
accept 576 byte packets.  Maybe add a SHOULD?

> +
> +The device MUST NOT modify \field{mtu} once it has been set.
> +
> +The device MUST NOT pass received packets that exceed \field{mtu} size
> +with \field{gso_type} NONE or ECN after VIRTIO_NET_F_MTU has been successfully
> +negotiated.
> +
> +The device MUST forward transmitted packets of up to MTU size with
> +\field{gso_type} NONE or ECN, and do so without fragmentation, after
> +VIRTIO_NET_F_MTU has been successfully negotiated.
> +

Maybe clarify that this is MTU + ethernet headers.
E.g. up to MTU size (plus low level headers).

>  \drivernormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
>  
>  A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
> @@ -3165,6 +3188,15 @@ If the driver does not negotiate the VIRTIO_NET_F_STATUS feature, it SHOULD
>  assume the link is active, otherwise it SHOULD read the link status from
>  the bottom bit of \field{status}.
>  
> +A driver SHOULD negotiate VIRTIO_NET_F_MTU if the device offers it.
> +
> +If the driver negotiates VIRTIO_NET_F_MTU, it MUST supply enough receive
> +buffers of size \field{mtu}

hmm in fact buffers can and should be bigger, and need to include ethernet headers.
I would say:

> to be able to receive at least one receive
> +packet with \field{gso_type} NONE or ECN.

... of size \field{mtu} (plus low level headers).

> +
> +If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
> +size exceeding the value of \field{mtu} with \field{gso_type} NONE or ECN
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
>  \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.7.4
