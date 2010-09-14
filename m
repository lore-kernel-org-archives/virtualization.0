From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/4] x86: remove cast from void*
Date: Tue, 14 Sep 2010 11:20:49 -0700
Message-ID: <4C8FBD01.40900@zytor.com>
References: <1284441511-11511-1-git-send-email-mfm@muteddisk.com>
	<4C8FB5C3.3050806@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4C8FB5C3.3050806@goop.org>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@xensource.com>, matt mooney <mfm@muteddisk.com>, x86@kernel.org, kernel-janitors@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ian Campbell <ian.campbell@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/14/2010 10:49 AM, Jeremy Fitzhardinge wrote:
>  On 09/13/2010 10:18 PM, matt mooney wrote:
>> Unnecessary cast from void* in assignment.
> 
> Not very keen on this.  The cast may not be strictly required, but it
> does document what's going on there.
> 

But unnecessary casts are problematic in that if the type changes, they
can hide a real bug in the future.
	
	-hpa
