From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 3/8] Allow a kernel to not be in ring 0.
Date: Fri, 04 Aug 2006 21:26:23 -0700
Message-ID: <44D41DEF.7040301@vmware.com>
References: <200608042045_MC3-1-C721-8608@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200608042045_MC3-1-C721-8608@compuserve.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Xen-devel <xen-devel@lists.xensource.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chuck Ebbert wrote:
> In-Reply-To: <20060803002518.190834642@xensource.com>
>
> On Wed, 02 Aug 2006 17:25:13 -0700, Jeremy Fitzhardinge wrote:
>
>   
>> We allow for the fact that the guest kernel may not run in ring 0.
>> This requires some abstraction in a few places when setting %cs or
>> checking privilege level (user vs kernel).
>>     
>
> I made some changes:
>
> a. Added some comments about the SEGMENT_IS_*_CODE() macros.
> b. Added a USER_RPL macro.  (You were comparing a value to a mask
>    in some places and to the magic number 3 in other places.)
> c. Changed the entry.S tests for LDT stack segment to use the macros.
>   

These changes look great.  Ack-ed.  I had some similar ones before that 
never made it from my tree, as I got carried away and tried to unify the 
user descriptor conversion functions... someday I'll get to it again.

Zach
