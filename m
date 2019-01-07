From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/3] virtio-balloon: tweak config_changed
Date: Mon, 7 Jan 2019 14:50:26 +0100
Message-ID: <44f7eca0-1569-2b70-4e6a-027bc1bc4f6e__24010.8060338118$1546868913$gmane$org@de.ibm.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
	<20190107084502-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190107084502-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org



On 07.01.2019 14:45, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 03:01:03PM +0800, Wei Wang wrote:
>> Since virtio-ccw doesn't work with accessing to the config space
>> inside an interrupt context, this patch series avoids that issue by
>> moving the config register accesses to the related workqueue contexts.
> 
> So is this enough to get ccw going again or do we also need
> the patches that deal with NULL VQ names?

This alone does not fix 4.20. You need the other ones as well.(The other patches
fix the memory corruption during boot, this patch fixes the deadlock when actually
changing the balloon size)


> 
>> v2->v3 ChangeLog:
>>     - rename cmd_id_received to cmd_id_received_cache, and have call sites
>>       read the latest value via virtio_balloon_cmd_id_received. (Still
>>       kept Cornelia and Halil's reviewed-by as it's a minor change)
>>     - remove zeroing vb->num_free_page_blocks in probe since vb is
>>       allocated via kzalloc.
>> v1->v2 ChangeLog:
>>     - add config_read_bitmap to indicate to the workqueue callbacks about
>>       the necessity of reading the related config fields.
>>
>> Wei Wang (3):
>>   virtio-balloon: tweak config_changed implementation
>>   virtio-balloon: improve update_balloon_size_func
>>   virtio_balloon: remove the unnecessary 0-initialization
>>
>>  drivers/virtio/virtio_balloon.c | 104 ++++++++++++++++++++++++++--------------
>>  1 file changed, 69 insertions(+), 35 deletions(-)
>>
>> -- 
>> 2.7.4
> 
