From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
 implementation for paravirt_ops interface
Date: Wed, 21 Feb 2007 10:55:36 -0800
Message-ID: <45DC95A8.1090907@vmware.com>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
	<45D61C74.2000601@vmware.com>
	<Pine.LNX.4.64.0702161312460.28871@schroedinger.engr.sgi.com>
	<45D626BB.20007@vmware.com>
	<Pine.LNX.4.64.0702161356380.29218@schroedinger.engr.sgi.com>
	<20070217135112.GA15102@muc.de>
	<Pine.LNX.4.64.0702211036060.24941@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.64.0702211036060.24941@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Lameter wrote:
> On Sat, 17 Feb 2007, Andi Kleen wrote:
>
>   
>> That was always its intention. It's not a direct interface to a hypervisor,
>> but an somewhat abstracted interface to a "hypervisor driver" 
>>     
>
> I thought that hypervisor driver was some binary blob that can be directly
> accessed via paravirt_ops?
>   

There are no more binary blobs being used by paravirt-ops hypervisors.  
I prefer the term "open hypercode layer".


>> But you're right that there are currently still quite a lot of hooks
>> being added. I plan to be much more strict on that in the future.
>>     
>
> And it seems that the hooks are not generic but bound to a particular 
> hypervisor. Should the Xen specific stuff not be in the binary blob?
>   

Xen doesn't use a hypercode layer, and there is no way to do what they 
need to do without hooks in the kernel.

Zach
