From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 04/25] xen: Add XEN config options
Date: Mon, 23 Apr 2007 16:11:45 -0700
Message-ID: <462D3D31.1090702@goop.org>
References: <20070423215638.563901986@goop.org>
	<20070423215709.990824532@goop.org> <200704240100.31011.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704240100.31011.ak@suse.de>
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
Cc: Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Monday 23 April 2007 23:56:42 Jeremy Fitzhardinge wrote:
>   
>> The XEN config option enables the Xen paravirt_ops interface, which is
>> installed when the kernel finds itself running under Xen.
>>
>> Xen is no longer a sub-architecture, so the X86_XEN subarch config
>> option has gone.
>>
>> Xen is currently incompatible with PREEMPT, but this is fixed up later
>> in the series.
>>     
>
> Shouldn't this be after the change that adds arch/i386/xen/Kconfig?
>
> Otherwise you break bisects
>   

It should be OK.  The series should build and run at each patch (though
I have to admit I haven't tested this).  In general I've been adding
config options for each feature as the feature itself is added.

    J
