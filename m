From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 10/10] virtio/s390: make airq summary indicators DMA
Date: Wed, 15 May 2019 15:43:23 +0200
Message-ID: <3a8353e2-97e3-778e-ab2e-ef285ac7027d@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-11-pasic@linux.ibm.com>
	<20190513142010.36c8478f.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190513142010.36c8478f.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org



On 13.05.19 14:20, Cornelia Huck wrote:
> On Fri, 26 Apr 2019 20:32:45 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> Hypervisor needs to interact with the summary indicators, so these
>> need to be DMA memory as well (at least for protected virtualization
>> guests).
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> (...)
> 
>> @@ -237,7 +243,8 @@ static void virtio_airq_handler(struct airq_struct *airq)
>>   	read_unlock(&info->lock);
>>   }
>>   
>> -static struct airq_info *new_airq_info(void)
>> +/* call with drivers/s390/virtio/virtio_ccw.cheld */
> 
> Hm, where is airq_areas_lock defined? If it was introduced in one of
> the previous patches, I have missed it.

There is no airq_areas_lock defined currently. My assumption is that
this will be used in context with the likely race condition this
part of the patch is talking about.

@@ -273,8 +281,9 @@ static unsigned long get_airq_indicator(struct 
virtqueue *vqs[], int nvqs,
  	unsigned long bit, flags;

  	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
+		/* TODO: this seems to be racy */
  		if (!airq_areas[i])
-			airq_areas[i] = new_airq_info();
+			airq_areas[i] = new_airq_info(i);


As this shall be handled by a separate patch I will drop the comment
in regard to airq_areas_lock from this patch as well for v2.

Michael

> 
>> +static struct airq_info *new_airq_info(int index)
>>   {
>>   	struct airq_info *info;
>>   	int rc;
> 
