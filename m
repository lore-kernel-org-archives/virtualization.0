From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] drivers/s390/virtio: Remove the old KVM virtio transport
Date: Wed, 27 Sep 2017 15:06:55 +0200
Message-ID: <66822fa4-f7fe-565a-bc51-9fe1493378f9__16540.3157509447$1509079518$gmane$org@redhat.com>
References: <1506512521-2244-1-git-send-email-thuth@redhat.com>
	<20170927125530.GE4032@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170927125530.GE4032@osiris>
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
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 27.09.2017 14:55, Heiko Carstens wrote:
> On Wed, Sep 27, 2017 at 01:42:01PM +0200, Thomas Huth wrote:
>> diff --git a/drivers/s390/virtio/Makefile b/drivers/s390/virtio/Makefile
>> index df40692..d9942e0 100644
>> --- a/drivers/s390/virtio/Makefile
>> +++ b/drivers/s390/virtio/Makefile
>> @@ -7,7 +7,4 @@
>>  # as published by the Free Software Foundation.
>>
>>  s390-virtio-objs := virtio_ccw.o
>> -ifdef CONFIG_S390_GUEST_OLD_TRANSPORT
>> -s390-virtio-objs += kvm_virtio.o
>> -endif
>>  obj-$(CONFIG_S390_GUEST) += $(s390-virtio-objs)
> 
> Would you mind to simplify the Makefile to just the single line
> 
> obj-$(CONFIG_S390_GUEST) += virtio_ccw.o
> 
> while you are touching it anyway?

Sure ... I'll send a v2 ... or do you rather want to fix it when picking
up the patch?

 Thomas
