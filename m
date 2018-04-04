From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 3/3] virtio_net: make lower netdevs
	for virtio_bypass hidden
Date: Wed, 4 Apr 2018 01:03:53 -0700
Message-ID: <CADGSJ20=yqKTAz3wTV=uUH0zohw+a698FVrgaNvmTTK9TMSj_w__38424.1586587906$1522828935$gmane$org@mail.gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-4-git-send-email-si-wei.liu@oracle.com>
	<20180403151915-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180403151915-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 3, 2018 at 5:20 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Apr 01, 2018 at 05:13:10AM -0400, Si-Wei Liu wrote:
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index aa40664..0827b7e 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -80,6 +80,8 @@ struct virtio_net_config {
>>       __u16 max_virtqueue_pairs;
>>       /* Default maximum transmit unit advice */
>>       __u16 mtu;
>> +     /* Device at bus:slot.function backed up by virtio_net */
>> +     __u16 bsf2backup;
>>  } __attribute__((packed));
>
> I'm not sure this is a good interface.  This isn't unique even on some
> PCI systems, not to speak of non-PCI ones.

Are you suggesting adding PCI address domain besides to make it
universally unique? And what the non-PCI device you envisioned that
the main target, essetially live migration, can/should cover? Or is
there better option in your mind already?

Thanks,
-Siwei
>
>>  /*
>> --
>> 1.8.3.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
