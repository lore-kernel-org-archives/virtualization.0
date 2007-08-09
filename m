From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 2/7] Added generic lg.h in lguest directory.
Date: Thu, 09 Aug 2007 14:06:15 +0200
Message-ID: <46BB0337.6040701__20299.662979278$1186661433$gmane$org@sgi.com>
References: <20070809003211.373543702@goodmis.org>	
	<20070809003343.310187242@goodmis.org>
	<5d6222a80708081756r21bbc7e3ifd357c9c548ac57f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80708081756r21bbc7e3ifd357c9c548ac57f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> On 8/8/07, Steven Rostedt <rostedt@goodmis.org> wrote:
>> Add a generic lg.h file to call the architecture specific one.
>>
>> diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
>> new file mode 100644
>> index 0000000..4c4356e
>> --- /dev/null
>> +++ b/drivers/lguest/lg.h
>> @@ -0,0 +1,3 @@
>> +#ifdef CONFIG_X86_32
>> +#include "i386/lg.h"
>> +#endif
> 
> Wouldn't it be cleaner to do something like the asm/ includes?
> I understand that lguest now lives in drivers/ and so we don't put
> headers directly in asm-i386 , but we could come up with a similar
> thing here. 

Yeah, that would be much better, and I don't like having something in
a header file including arch specific files like that. I target to get
lguest going on non x86, so I would like to encourage anyone to think
more than x86 when trying to seperate out something :)

IMHO we should avoid any header files with asm specific code in
drivers/lguest - in a way I prefer having arch/<foo>/lguest to
drivers/lguest/<arch>, would be more esthetically compliant with
the include/asm-<arch> approach too, but thats not a big deal.

Cheers,
Jes
