From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 00/26] Xen-paravirt_ops: Xen guest
 implementation for paravirt_ops interface
Date: Fri, 16 Mar 2007 09:55:41 -0700
Message-ID: <45FACC0D.3050103@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070316084251.GA23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316084251.GA23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>>  * virtual block device (blockfront)
>>  * virtual network device (netfront)
>>     
>
> note, these drivers should be submitted through the proper block drivers 
> and network drivers review process - not via the x86_64 tree.
>   

Yes; who should look at them?  I posted netfront to net-dev, and Stephen
Hemminger commented on it on the last repost, but I'd love them to get
more scrutiny.

Obviously they're not actually useful without Xen (and vice-versa), so
there's not much point in committing them separately.

    J
