From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH 2/2] virtio-net: introduce a new control to set macaddr
Date: Fri, 11 Jan 2013 11:13:04 +1030
Message-ID: <87ip741rdz.fsf__33755.7649742395$1357876570$gmane$org@rustcorp.com.au>
References: <1357829141-25455-1-git-send-email-akong@redhat.com>
	<1357829141-25455-3-git-send-email-akong@redhat.com>
	<20130110152649.GF30731@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130110152649.GF30731@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, akong@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
>> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
>> +		/* Set MAC address by writing config space */
>>  		vdev->config->set(vdev, offsetof(struct virtio_net_config, mac),
>>  		                  dev->dev_addr, dev->addr_len);
>> +	}
>>  
>
> By the way, why don't we fail the command if VIRTIO_NET_F_MAC is off?
> Rusty?

Looked back through the history for this one.  I think the theory is that
if the guest doesn't set VIRTIO_NET_F_MAC, it means it doesn't care:
it's up to the guest.

Cheers,
Rusty.
