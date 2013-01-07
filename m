From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] drivers/xen: avoid out-of-range write in
 xen_add_device
Date: Mon, 07 Jan 2013 16:20:01 +0000
Message-ID: <50EB03C102000078000B37E7@nat28.tlf.novell.com>
References: <1357413526-42430-1-git-send-email-nickolai@csail.mit.edu>
	<20130107150816.GC3219@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130107150816.GC3219@phenom.dumpdata.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nickolai Zeldovich <nickolai@csail.mit.edu>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>> On 07.01.13 at 16:08, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> On Sat, Jan 05, 2013 at 02:18:46PM -0500, Nickolai Zeldovich wrote:
>> xen_add_device() in drivers/xen/pci.c allocates a struct
>> physdev_pci_device_add on the stack and then writes to optarr[0].
>> The previous declaration of struct physdev_pci_device_add contained
>> a zero-length optarr[] array, presumably assuming it will be allocated
>> with kmalloc with a suitable number of trailing elements, but the code in
>> xen_add_device() as a result wrote past the end of the (stack-allocated)
>> data structure.
>> 
>> Since xen_add_device() is the only use of struct physdev_pci_device_add
>> in the kernel, turn optarr[] into a single-element array instead.
>> 
> 
> Lets include Jan and Xen-devel on this email - as this is also changing
> the official header that is used in Xen.

Correct - for that reason it is not the header that needs changing
here, but the consumer of the header. I have to admit that I find
it odd that the compiler allows automatic variables of variable size
types without warning - otherwise this wouldn't have gone
unnoticed.

Jan

>> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
>> ---
>>  include/xen/interface/physdev.h |    6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>> 
>> diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
>> index 1844d31..24fd218 100644
>> --- a/include/xen/interface/physdev.h
>> +++ b/include/xen/interface/physdev.h
>> @@ -242,11 +242,7 @@ struct physdev_pci_device_add {
>>          uint8_t bus;
>>          uint8_t devfn;
>>      } physfn;
>> -#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
>> -    uint32_t optarr[];
>> -#elif defined(__GNUC__)
>> -    uint32_t optarr[0];
>> -#endif
>> +    uint32_t optarr[1];
>>  };
>>  
>>  #define PHYSDEVOP_pci_device_remove     26
>> -- 
>> 1.7.10.4
>> 
