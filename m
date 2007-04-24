From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 16/25] xen: Use the hvc console infrastructure for Xen
 console
Date: Tue, 24 Apr 2007 13:01:38 -0700
Message-ID: <462E6222.3060302@goop.org>
References: <20070423215638.563901986@goop.org>
	<20070423215712.328111104@goop.org>
	<20070424012111.GA28649@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070424012111.GA28649@lixom.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Olof Johansson <olof@lixom.net>
Cc: Gerd Hoffmann <kraxel@suse.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Olof Johansson wrote:
> On Mon, Apr 23, 2007 at 02:56:54PM -0700, Jeremy Fitzhardinge wrote:
>   
>> Implement a Xen back-end for hvc console.
>>
>> From: Gerd Hoffmann <kraxel@suse.de>
>> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>>
>> ---
>>  arch/i386/xen/Kconfig     |    1 
>>  arch/i386/xen/events.c    |    3 -
>>  drivers/Makefile          |    3 +
>>  drivers/xen/Makefile      |    1 
>>  drivers/xen/hvc-console.c |  134 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/xen/events.h      |    1 
>>  6 files changed, 142 insertions(+), 1 deletion(-)
>>     
>
> If you move the driver to drivers/char/hvc_xen.c instead, you won't have to do...
>
>   
>> +#include "../char/hvc_console.h"
>>     
>
> ...this.
>
> Other single-platform backend hvc drivers are under drivers/char already.

Good point.

    J
