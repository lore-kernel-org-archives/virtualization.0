From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed implementation
Date: Tue, 08 Jan 2019 13:35:04 +0800
Message-ID: <5C343688.2060609__33979.9242363826$1546925277$gmane$org@intel.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
	<1546844466-38079-2-git-send-email-wei.w.wang@intel.com>
	<4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 01/07/2019 09:49 PM, Christian Borntraeger wrote:
>
> On 07.01.2019 08:01, Wei Wang wrote:
>> virtio-ccw has deadlock issues with reading the config space inside the
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
>> The config_read_bitmap is used as a flag to the workqueue callbacks
>> about the related config fields that need to be read.
>>
>> The cmd_id_received is also renamed to cmd_id_received_cache, and
>> the value should be obtained via virtio_balloon_cmd_id_received.
>>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Together with
>    virtio_pci: use queue idx instead of array idx to set up the vq
>    virtio: don't allocate vqs when names[i] = NULL
>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

OK. I don't plan to send a new version of the above patches as no 
changes needed so far.

Michael, if the above two patches look good to you, please help add the 
related tested-by
and reviewed-by tags. Thanks.

Best,
Wei
