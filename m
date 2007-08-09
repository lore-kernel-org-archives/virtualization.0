From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 4/7] Moved the io struct up to the generic lg.h
Date: Thu, 09 Aug 2007 14:26:55 +0200
Message-ID: <46BB080F.4040905__37913.174663163$1186662673$gmane$org@sgi.com>
References: <20070809003211.373543702@goodmis.org>	<20070809003343.664528532@goodmis.org>
	<20070809115156.ef5fdc6c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809115156.ef5fdc6c.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Stephen Rothwell wrote:
> On Wed, 08 Aug 2007 20:32:15 -0400 Steven Rostedt <rostedt@goodmis.org>
> wrote:
>> diff --git a/drivers/lguest/i386/lg.h b/drivers/lguest/i386/lg.h
>> index 64f0abe..c5ea14c 100644
>> --- a/drivers/lguest/i386/lg.h
>> +++ b/drivers/lguest/i386/lg.h
>> @@ -20,6 +20,8 @@
>>  #include <linux/err.h>
>>  #include <asm/semaphore.h>
>>  #include "irq_vectors.h"
>> +/* some files include this, some include the parent */
>> +#include "../lg.h"
> 
> Surely everything should just include the parent which allows for easier
> consolidation over time. (as you are doing here)

Whats wrong with introducing an include/asm-<arch>/lg.h and have the
parent do #include <asm/lg.h> ? Seems much cleaner to me.

Cheers,
Jes
