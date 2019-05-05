From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 03/10] virtio/s390: enable packed ring
Date: Sun, 5 May 2019 17:13:21 +0200
Message-ID: <6743e19d-9824-5533-03e9-b7aa4e0e2cc1@redhat.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
	<20190426183245.37939-4-pasic@linux.ibm.com>
	<20190503114450.2512b121.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190503114450.2512b121.cohuck@redhat.com>
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
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/05/2019 11.44, Cornelia Huck wrote:
> On Fri, 26 Apr 2019 20:32:38 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> Nothing precludes to accepting  VIRTIO_F_RING_PACKED any more.
> 
> "precludes us from accepting"
> 
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>  drivers/s390/virtio/virtio_ccw.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
>> index 42832a164546..6d989c360f38 100644
>> --- a/drivers/s390/virtio/virtio_ccw.c
>> +++ b/drivers/s390/virtio/virtio_ccw.c
>> @@ -773,10 +773,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>>  static void ccw_transport_features(struct virtio_device *vdev)
>>  {
>>  	/*
>> -	 * There shouldn't be anything that precludes supporting packed.
>> -	 * TODO: Remove the limitation after having another look into this.
>> +	 * Currently nothing to do here.
>>  	 */
>> -	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
>>  }
>>  
>>  static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> 
> Not sure whether we should merge this into the previous patch instead.

In case you respin, I'd vote for squashing this into the previous patch
instead, especially since you've just added the comment in that patch.

Also, what about removing that function now completely? It's a static
function and only called once in this file, so IMHO it does not make
much sense to keep an empty function around. Or do you plan to add new
code here in the near future?

 Thomas
