From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: [Xen-devel] Re: Xen paravirt frontend block hang
Date: Mon, 24 Mar 2008 21:37:42 -0400
Message-ID: <47E85766.7020108__10653.2650221654$1206409330$gmane$org@theshore.net>
References: <4772AC8E.7010007@theshore.net>
	<47C712EF.1060703@goop.org>	<47C9F818.4020200@theshore.net>
	<47CAC931.1000107@goop.org> <47CACFBE.5010007@theshore.net>
	<47DFE75B.7080404@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47DFE75B.7080404@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xming <xmingske@gmail.com>, Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Christopher S. Aker wrote:
>> Jeremy Fitzhardinge wrote:
>>> Are you running an SMP or UP domain?  I found I could get hangs very 
>>> easily with UP (but I need confirm it isn't a result of some other 
>>> very experimental patches).
>>
>> The hang occurs with both SMP and UP compiled pv_ops kernels.  SMP 
>> kernels are still slightly responsive after the hang occurs, which 
>> makes me think only one proc gets stuck at a time, not the entire kernel. 
> 
> The patch I posted yesterday - "xen: fix RMW when unmasking events" - 
> should definitively fix the hanging-under-load bugs (I hope). 

Confirmed-by: caker@theshore.net

Nice work!

-Chris
