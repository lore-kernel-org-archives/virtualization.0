From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 20/26] Xen-paravirt_ops: Core Xen
	implementation
Date: Mon, 19 Mar 2007 11:13:14 -0700
Message-ID: <45FED2BA.5050207@goop.org>
References: <20070301232443.195603797@goop.org>	<20070301232528.812011702@goop.org>
	<20070316091411.GF23174@elte.hu>	<20070316171250.GM10574@sequoia.sous-sol.org>
	<m1aby9xg5s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m1aby9xg5s.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
>>>>  ENTRY(swapper_pg_dir)
>>>> +	.align PAGE_SIZE_asm
>>>>  	.fill 1024,4,0
>>>>         
>>>
> Shouldn't the align be before the label.  Otherwise padding
> would be inserted between the label and the data.


Good point.

Thanks,
    J
