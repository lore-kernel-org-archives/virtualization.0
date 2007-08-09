From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 23/25] [PATCH] paravirt hooks for arch initialization
Date: Thu, 09 Aug 2007 10:43:52 -0700
Message-ID: <46BB5258.8040609__13642.715154174$1186681661$gmane$org@goop.org>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<11865468394005-git-send-email-gcosta@redhat.com>
	<11865468431616-git-send-email-gcosta@redhat.com>
	<200708081144.04119.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708081144.04119.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> -static void discover_ebda(void)
>> +void native_ebda_info(unsigned *addr, unsigned *size)
>>     
>
> I guess it would be better to use the resources frame work here. 
> Before checking EBDA check if it is already reserved. Then lguest/Xen
> can reserve these areas and stop using it.
>   

What's the EBDA actually used for?  The only place which seems to use
ebda_addr is in the e820 code to avoid that area as RAM.

Seems to me that we can just arrange to have the early lguest/xen setup
code set the EBDA_ADDR pointer to NULL and make discover_ebda() special
case that to zero out ebda_addr/size.

>> +/* Overridden in paravirt.c if CONFIG_PARAVIRT */
>> +void __attribute__((weak)) memory_setup(void)
>> +{
>> +       return setup_memory_region();
>> +}
>> +
>> +
>>  void __init setup_arch(char **cmdline_p)
>>  {
>>  	printk(KERN_INFO "Command line: %s\n", boot_command_line);
>> @@ -231,12 +255,19 @@ void __init setup_arch(char **cmdline_p)
>>  	saved_video_mode = SAVED_VIDEO_MODE;
>>  	bootloader_type = LOADER_TYPE;
>>
>> +	/*
>> +	 * By returning non-zero here, a paravirt impl can choose to
>> +	 * skip the rest of the setup process
>> +	 */
>> +	if (paravirt_arch_setup())
>> +		return;
>>     
>
> Sorry, but that's an extremly ugly and clumpsy interface and will lead
> to extensive code duplication in hypervisors because so much code
> is disabled.
>
> This needs to be solved in some better way.
>   

Yeah, it seems a bit hamfisted.  Looks like it would be better to deal
with it by some combination of:

   1. implement pv analogues of existing functions
   2. try to neutralize functions we don't care about in pv-land
   3. refactoring the setup() function to make the pv-friendly and
      pv-hostile parts clearly distinct

and remember: native isn't a special case; its just another pv driver.

    J
