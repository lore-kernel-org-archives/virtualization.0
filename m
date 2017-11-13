From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: add virtio-ccw.h to virtio/s390 section
Date: Mon, 13 Nov 2017 14:35:16 +0100
Message-ID: <b7061d97-6c70-2a80-9822-96a7e512175d__46296.2241298102$1510580268$gmane$org@linux.vnet.ibm.com>
References: <20171110145611.15306-1-cohuck@redhat.com>
	<20171110181558.GB3028@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171110181558.GB3028@osiris>
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
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 11/10/2017 07:15 PM, Heiko Carstens wrote:
> On Fri, Nov 10, 2017 at 03:56:11PM +0100, Cornelia Huck wrote:
>> The file arch/s390/include/uapi/asm/virtio-ccw.h belongs to the
>> s390 virtio drivers as well.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

>> ---
>>
>> Martin, Heiko: It's probably best to take this through your tree.
>>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6671f375f7fc..48c6f1179b9b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14312,6 +14312,7 @@ L:	virtualization@lists.linux-foundation.org
>>  L:	kvm@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/s390/virtio/
>> +F:	arch/s390/include/uapi/asm/virtio-ccw.h
> 
> Applied, thanks.
> 
