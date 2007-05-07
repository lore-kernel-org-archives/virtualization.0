From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: paravirt_ops queue rebased
Date: Mon, 07 May 2007 11:14:45 -0700
Message-ID: <463F6C95.10103@xensource.com>
References: <463E0E8D.3050806@goop.org>	<1178475147.3760.36.camel@mulgrave.il.steeleye.com>	<463E647A.8060505@goop.org>
	<1178558797.3729.21.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1178558797.3729.21.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

James Bottomley wrote:
> The original one you sent had duplicate smp_call_function...
> definitions.  The interdiff between the one you've attached now and the
> one I sent is pretty tiny:
>   

Huh.  Must have been a mixup somewhere, because this was one was more or
less identical to the last one.  Maybe I'd sent out an earlier borken
one you picked up?  Anyway, doesn't matter.

> +	u32 mask = cpus_addr(cpumask)[0];
>   

Ah, didn't know about that.

    J
