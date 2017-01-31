From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH] vhost: fix initialization for vq->is_le
Date: Tue, 31 Jan 2017 16:56:13 +0100
Message-ID: <277ab88f-d073-cf29-e79f-f048d0c4f42b@linux.vnet.ibm.com>
References: <20170130100936.17065-1-pasic@linux.vnet.ibm.com>
	<20170130200658.73f8dab6@bahia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170130200658.73f8dab6@bahia.lan>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <groug@kaod.org>
Cc: "Michael A. Tebolt" <miket@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 01/30/2017 08:06 PM, Greg Kurz wrote:
>> Currently, under certain circumstances vhost_init_is_le does just a part
>> of the initialization job, and depends on vhost_reset_is_le being called
>> too. For this reason vhost_vq_init_access used to call vhost_reset_is_le
>> when vq->private_data is NULL. This is not only counter intuitive, but
>> also real a problem because it breaks vhost_net. The bug was introduced to
>> vhost_net with commit 2751c9882b94 ("vhost: cross-endian support for
>> legacy devices"). The symptom is corruption of the vq's used.idx field
>> (virtio) after VHOST_NET_SET_BACKEND was issued as a part of the vhost
>> shutdown on a vq with pending descriptors.
>>
>> Let us make sure the outcome of vhost_init_is_le never depend on the state
>> it is actually supposed to initialize, and fix virtio_net by removing the
>> reset from vhost_vq_init_access.
>>
>> With the above, there is no reason for vhost_reset_is_le to do just half
>> of the job. Let us make vhost_reset_is_le reinitialize is_le.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reported-by: Michael A. Tebolt <miket@us.ibm.com>
>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Fixes: commit 2751c9882b94 ("vhost: cross-endian support for legacy devices")
>> ---
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 

Thanks! 

We have some tests on s390x (that is BE) running, but I won't be able to
test the change with cross endian and legacy. 

What do you think, should I/we RFT or are we fine without?

Regards,
Halil
