From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v37 1/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Fri, 28 Dec 2018 11:12:05 +0800
Message-ID: <5C259485.2030809__38690.1644677438$1545966285$gmane$org@intel.com>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
	<1535333539-32420-2-git-send-email-wei.w.wang@intel.com>
	<49d706f7-a0ee-e571-7d02-bcadac5ce742@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49d706f7-a0ee-e571-7d02-bcadac5ce742@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: yang.zhang.wz@gmail.com, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, pbonzini@redhat.com, nilal@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/27/2018 08:03 PM, Christian Borntraeger wrote:
> On 27.08.2018 03:32, Wei Wang wrote:
>>   static int init_vqs(struct virtio_balloon *vb)
>>   {
>> -	struct virtqueue *vqs[3];
>> -	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
>> -	static const char * const names[] = { "inflate", "deflate", "stats" };
>> -	int err, nvqs;
>> +	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>> +	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>> +	const char *names[VIRTIO_BALLOON_VQ_MAX];
>> +	int err;
>>
>>   	/*
>> -	 * We expect two virtqueues: inflate and deflate, and
>> -	 * optionally stat.
>> +	 * Inflateq and deflateq are used unconditionally. The names[]
>> +	 * will be NULL if the related feature is not enabled, which will
>> +	 * cause no allocation for the corresponding virtqueue in find_vqs.
>>   	 */
> This might be true for virtio-pci, but it is not for virtio-ccw.

Hi Christian,


Please try the fix patches: https://lkml.org/lkml/2018/12/27/336

Best,
Wei
