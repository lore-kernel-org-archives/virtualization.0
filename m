From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Mon, 30 Apr 2007 22:28:55 -0700
Message-ID: <4636D017.5060108@zytor.com>
References: <20070428758.455116000@suse.de>	
	<20070428175909.1D09D151CA@wotan.suse.de>
	<46338D72.70402@garzik.org>	
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>
	<4634483E.9030307@goop.org>	
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>	
	<1177902195.30071.203.camel@localhost.localdomain>	
	<463572B7.90202@zytor.com>	
	<1177909434.30071.216.camel@localhost.localdomain>	
	<m1ejm16flv.fsf@ebiederm.dsl.xmission.com>	
	<1177990722.28659.39.camel@localhost.localdomain>	
	<4636B7DE.5050005@zytor.com> <4636BB6B.9070300@zytor.com>
	<1177995014.28659.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177995014.28659.54.camel@localhost.localdomain>
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> 
> BTW, wrt. a new "platform type" field, should it go something like this?
> 
> -0235/3	N/A	pad2		Unused
> +0235/1	2.07+	platform_type	Runtime platform (see below)
> +0236/2	N/A	pad2		Unused
> ...
> +  platform_type:
> +	For kernels which can boot on multiple platforms.  Currently
> +	0 == native (normal), 1 == lguest (paravirtualized).
> 

Well, yes, but we need to think about if there is more things that
should be added.  There *definitely* should be space for a platform data
pointer, to start out with.  I would also like to see a platform data
field, as well as a bootloader extension field (we're going to have that
problem soon enough.)

	-hpa
