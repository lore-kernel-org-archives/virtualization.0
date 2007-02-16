From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Fri, 16 Feb 2007 00:31:37 -0800
Message-ID: <45D56BE9.2070703@vmware.com>
References: <20070216022449.739760547@goop.org>	<20070216022531.570154735@goop.org>
	<45D54BFF.80100@vmware.com>	<m11wkqimjd.fsf@ebiederm.dsl.xmission.com>	<1171613663.20666.30.camel@localhost.localdomain>
	<m1ire2h5n5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m1ire2h5n5.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@XenSource.com>, Ian Campbell <Ian.Campbell@XenSource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Ian Campbell <Ian.Campbell@XenSource.com> writes:
>
>   
>> On Fri, 2007-02-16 at 00:33 -0700, Eric W. Biederman wrote:
>>     
>>> I know there actually has been some work to get kexec actually working under
>>> Xen but I don't know where that has gone.
>>>       
>> kexec/kdump works with Xen 3.0.4 but it's a dom0 only thing so it
>> doesn't appear in this patchset.
>>     
>
> Ok but we still need to get the failure to user space for domU instead
> of trying what works on real hardware and failing.
>
> Eric

Acked-by: Zachary Amsden <zach@vmware.com>
