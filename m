From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 09/27] ia64/xen: implement the arch specific part of
	xencomm.
Date: Thu, 19 Jun 2008 10:15:09 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA306213BE8__33918.7784157277$1213895946$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840434082-git-send-email-yamahata@valinux.co.jp>
	<57C9024A16AD2D4C97DC78E552063EA30621364B@orsmsx505.amr.corp.intel.com>
	<20080619121622.GQ11378%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080619121622.GQ11378%yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: "Dong, Eddie" <eddie.dong@intel.com>, "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Alex Williamson <alex.williamson@hp.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>> +#define is_kernel_addr(x)                                      \
>> +       ((PAGE_OFFSET <= (x) &&                                 \
>> +         (x) < (PAGE_OFFSET + (1UL << IA64_MAX_PHYS_BITS))) || \
>> +        (KERNEL_START <= (x) &&                                \
>> +         (x) < KERNEL_START + KERNEL_TR_PAGE_SIZE))
>>
>> Misleading name.  What does it consider a "kernel_addr"? Just
>> region 7 (up to physical address limit) and the piece of region
>> 5 that is mapped by itr[0]/dtr[0].  Preferebly pick a better name
>> or add a comment here saying what this is testing for.
>
> How about xencomm_is_phys_contiguous()?
> Renaming it requires patches to drivers/xen/xencomm.c.
> If okay, I'll also send the patch to common files.

That sounds a bit more meaningful ... except that such a function
would also require a "size" (or "end") parameter. It makes
no sense to ask whether a solitary address is contiguous.

-Tony
