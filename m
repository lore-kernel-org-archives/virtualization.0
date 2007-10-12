From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC REPOST 1/2] paravirt: refactor struct paravirt_ops
 into smaller pv_*_ops
Date: Fri, 12 Oct 2007 12:16:04 -0700
Message-ID: <470FC7F4.1030300@goop.org>
References: <470BC758.1030504@goop.org>
	<200710101635.10139.rusty@rustcorp.com.au>
	<470D13CA.3000202@goop.org>
	<200710120001.52456.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710120001.52456.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> 	Sure, but this can actually be a temporary thing inside the patch code (or at 
> least static to that file if it's too big for the stack).
>
> 	struct paravirt_ops patch_template = { .pv_info = pv_info, .pv_cpu_ops = 
> pv_cpu_ops, ... };
>
> 	Then you can even rename struct paravirt_ops to "struct patch_template" and 
> we're well on the way to making this a generic function-call patching 
> mechanism, rather than something paravirt-specific.
>   

Hm, I see.  I'm not quite sure that's the best way to achieve a generic
result, but I see your point.

> Hope that clarifies my thinking...

Well, I'd agree with making the code more generic if another user
appears, but I'd rather not do it prematurely.

Sorry, I forgot to update lguest.  I'll do that and repost (but I won't
have had a chance to test it).

Are you otherwise happy with the patch in its current form?  And are you
happy with the lazymode changes?

    J
