From: Aaron Conole <aconole@redhat.com>
Subject: Re: [virtio-dev] [PATCH v11] virtio-net: add Max MTU configuration
	field
Date: Mon, 19 Sep 2016 13:02:03 -0400
Message-ID: <f7tr38f6cxg.fsf__26641.599488403$1474304543$gmane$org@redhat.com>
References: <1474297826-7642-1-git-send-email-aconole@redhat.com>
	<20160919172619.6dc465c7.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160919172619.6dc465c7.cornelia.huck@de.ibm.com> (Cornelia
	Huck's message of "Mon, 19 Sep 2016 17:26:19 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Victor Kaplansky <vkaplans@redhat.com>, virtio-dev@lists.oasis-open.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:

> On Mon, 19 Sep 2016 11:10:26 -0400
> Aaron Conole <aconole@redhat.com> wrote:
>
>> @@ -3165,6 +3192,16 @@ If the driver does not negotiate the
>> VIRTIO_NET_F_STATUS feature, it SHOULD
>>  assume the link is active, otherwise it SHOULD read the link status from
>>  the bottom bit of \field{status}.
>> 
>> +A driver SHOULD negotiate VIRTIO_NET_F_MTU if the device offers it.
>> +
>> +If the driver negotiates VIRTIO_NET_F_MTU, it MUST supply enough receive
>> +buffers of size \field{mtu} (plus low level ethernet header length) to be
>> +able to receive at least one receive packet with \field{gso_type} NONE or ECN.
>> +
>> +If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
>> +size exceeding the value of \field{mtu} (plus low level ethernet header length)
>> +with \field{gso_type} NONE or ECN
>
> Missing period.

D'oh!

Michael,
  Is this something that requires a new spin of the patch to
correct?  If so, I'll add Cornelia's ACK and repost today.

>> +
>>  \subsubsection{Legacy Interface: Device configuration
>> layout}\label{sec:Device Types / Network Device / Device
>> configuration layout / Legacy Interface: Device configuration
>> layout}
>>  \label{sec:Device Types / Block Device / Feature bits / Device
>> configuration layout / Legacy Interface: Device configuration
>> layout}
>>  When using the legacy interface, transitional devices and drivers
>
> Otherwise,
>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>
>
