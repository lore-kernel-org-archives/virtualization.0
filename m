From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Wed, 22 Aug 2007 14:47:12 +0300
Message-ID: <46CC2240.30400__23182.8696480536$1187783416$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>	<1187714864.4363.358.camel@ghaskins-t60p.haskins.net>	<1187753365.6174.26.camel@localhost.localdomain>	<200708221118.00990.borntraeger@de.ibm.com>	<64F9B87B6B770947A9F8391472E032160D503D81@ehost011-8.exch011.intermedia.net>
	<1187779205.6174.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187779205.6174.87.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, Christian Borntraeger <borntraeger@de.ibm.com>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wed, 2007-08-22 at 02:26 -0700, Dor Laor wrote:
>   
>> Actually while playing with virtio for kvm Avi saw that and recommended
>> to do the following:
>> struct desc_pages
>> {
>> 	/* Page of descriptors. */
>> 	union {
>> 		struct virtio_desc desc[NUM_DESCS];
>> 		char pad1[PAGE_SIZE];
>> 	};
>>
>> 	/* Next page: how we tell other side what buffers are available. */
>> 	union {
>> 		struct {
>> 			unsigned int avail_idx;
>> 			unsigned int available[NUM_DESCS];
>> 		};
>> 		char pad2[PAGE_SIZE];
>> 	};
>>
>> 	/* Third page: how other side tells us what's used. */
>> 	union {
>> 		struct {
>> 			unsigned int used_idx;
>> 			struct virtio_used used[NUM_DESCS];
>> 		};
>> 		char pad3[PAGE_SIZE];
>> 	};
>> };
>>
>> It saves useless pointer arithmetic.
>>     
>
> Hi Dor!
>
> Please consider moving the "used" field into the descriptor (maybe as a
> ptr for cache reasons, 'cept I'd really like to trim descriptor size).
> That makes the avail and used rings identical, plus the current model
> means we can't trust the used length if we don't trust the other side
> (this is one of my FIXMEs).
>
> Of course, we could go further and break the fixed structure: there's no
> reason for the first and second part to be on separate pages, nor for
> the third to be consecutive.  But there is no need until be have an
> untrusted demonstration...
>
>   

Another thing that occurs to me is that alignment should be explicit to 
64 bits, so that mixed 32/64 bit guest/hosts can be used.


-- 
error compiling committee.c: too many arguments to function
