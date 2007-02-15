From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 15/21] Xen-paravirt: Add Xen interface
	header files
Date: Wed, 14 Feb 2007 16:10:50 -0800
Message-ID: <45D3A50A.9090303@goop.org>
References: <20070213221729.772002682@goop.org>	<20070213221830.619562494@goop.org>
	<m1k5ykpiwv.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m1k5ykpiwv.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>
>   
>> Add Xen interface header files. These are taken fairly directly from
>> the Xen tree and hence the style is not entirely in accordance with
>> Linux guidelines. There is a tension between fitting with Linux coding
>> rules and ease of maintenance.
>>
>> Define macros and inline functions for doing hypercalls into the
>> hypervisor.
>>
>> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
>> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
>> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
>>
>>
>> --
>>  include/asm-i386/hypercall.h          |  416 +++++++++++++++++++++++++++++
>>  include/asm-i386/hypervisor.h         |   72 +++++
>>     
>
> Are hypercall.h and hypervisor.h generic or are they Xen specific.
> If they are Xen specific (as it appears) then are inappropriately
> named.
>   

Thanks for the reminder; I've been meaning to move/rename these.

>>  include/xen/interface/arch-x86_32.h   |  187 +++++++++++++
>>     
> Why isn't this file include-asm-i386/xen/arch-x86_32.h ?
>   

Those files are more or less directly copied from the Xen tree, and its
easier if they don't drift too far in name and directory structure.

    J
