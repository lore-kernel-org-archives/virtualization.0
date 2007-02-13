From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 13/21] Xen-paravirt: Add nosegneg capability
 to the vsyscall page notes
Date: Tue, 13 Feb 2007 14:54:26 -0800
Message-ID: <45D241A2.6000401@vmware.com>
References: <20070213221729.772002682@goop.org>
	<20070213221830.466651996@goop.org>
	<45D23F97.5040907@vmware.com> <45D24066.4070109@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D24066.4070109@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>   
>> I don't like this because now a kernel compiled with both CONFIG_XEN
>> and CONFIG_VMI has "nosegneg" turned on.  We don't actually require
>> this for performance or correctness, so it would be nice to be able to
>> dynamically turn it off instead of having it forced. 
>>     
>
> Any suggestions about how to do this?  It seems hard to have a note
> dynamically appear and disappear in the vsyscall.so.
>
> I wasn't terribly concerned about this, since there is effectively zero
> performance difference between the two library implementations.
>   

I'm not super concerned either, but I still don't like it.  There 
already is dynamic replacement for vsyscall.so, so you could have just 
dropped in an an-note-ated version.

Zach
