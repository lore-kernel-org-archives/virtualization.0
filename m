From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] S390: take a full byte as ext_param indicator
Date: Tue, 24 Aug 2010 14:06:25 +0200
Message-ID: <4C73B5C1.5040603__16857.992221094$1282651638$gmane$org@suse.de>
References: <1282599077-29857-1-git-send-email-agraf@suse.de>
	<4C736EAF.9020107@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C736EAF.9020107@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Carsten Otte <carsteno@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am 23.08.2010 23:31, schrieb Alexander Graf:
>   
>> Currenty the ext_param field only distinguishes between "config change" and
>> "vring interrupt". We can do a lot more with it though, so let's enable a
>> full byte of possible values and constants to #defines while at it.
>>     
>
> Makes a lot of sense.
> [...]
>
>   
>>  #define VIRTIO_SUBCODE_64 0x0D00
>> +#define VIRTIO_PARAM_MASK		0xff
>> +#define VIRTIO_PARAM_VRING_INTERRUPT	0x0
>> +#define VIRTIO_PARAM_CONFIG_CHANGED	0x1
>>     
>
> Maybe this should be exported in a header, something like 
> arch/s390/include/asm/kvm_virtio.h? In that case this file
> must be added to Kbuild for make headers_install.
>   

While that thought sounds good at first, it's really no use for anyone,
right? I mean - in qemu we need to define the defines manually anyways
because we need to potentially be able to build the s390x target on
non-s390x, possibly on non-Linux.


Alex
