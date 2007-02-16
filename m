From: Zachary Amsden <zach@vmware.com>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config options
	and disable unsupported config options.
Date: Fri, 16 Feb 2007 02:55:04 -0800
Message-ID: <45D58D88.5020801@vmware.com>
References: <C1FB3B72.98E5%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FB3B72.98E5%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Steven Hand <steven.hand@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> On 16/2/07 10:19, "Zachary Amsden" <zach@vmware.com> wrote:
>
>   
>> Doesn't stop_machine_run already take care of getting you out of all
>> kernel threads?  So you can only be sleeping, not preempted, in which
>> case, this might not be an issue?
>>     
>
> It ensures that no (non-stopmachine) threads are running on any of the other
> CPUs, but it doesn't guarantee that all threads are at any form of quiescent
> point. They can certainly have private references to machine addresses.
>
> Otherwise, what would be the point of the process freezer? :-)
>   

Yeah, I was over-hoping on that one.  At least thought it was worth 
suggesting as a starting point.  I had similar issues considering 
loading VMI as a module at runtime.

Zach
