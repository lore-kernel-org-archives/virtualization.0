From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 10/21] Xen-paravirt: add hooks to intercept
 mm creation and destruction
Date: Thu, 22 Feb 2007 12:21:33 -0800
Message-ID: <45DDFB4D.9050809@goop.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.267584466@goop.org> <20070222201644.GA4938@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070222201644.GA4938@ucw.cz>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Pavel Machek wrote:
> Hi!
>
>   
>> @@ -126,6 +126,12 @@ struct paravirt_ops
>>  	void (*io_delay)(void);
>>  	void (*const_udelay)(unsigned long loops);
>>  
>> +	void (fastcall *activate_mm)(struct mm_struct *prev,
>> +				     struct mm_struct *next);
>> +	void (fastcall *dup_mmap)(struct mm_struct *oldmm, 
>> +				  struct mm_struct *mm);
>> +	void (fastcall *exit_mmap)(struct mm_struct *mm);
>> +
>>     
>
> Why the fastcall stuff?  Why is io_delay different from activate_mm in
> this regard?
>   

That's crud; I forgot to remove it.  Everything is effectively fastcall
now that -mregparm=3 is always on.

    J
