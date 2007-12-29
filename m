From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen paravirt frontend block hang
Date: Fri, 28 Dec 2007 22:00:56 -0800
Message-ID: <4775E298.2000505@goop.org>
References: <4772AC8E.7010007@theshore.net> <47758352.5040504@goop.org>
	<47759EFD.5050101@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47759EFD.5050101@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
> Jeremy Fitzhardinge wrote:
>> I'll try to track this down asap.  Have you tried any other kernel
>> versions?  In other words, did it just start happening, or its always
>> done it?  Also, could you try 2.6.24-rc6, just to make sure it hasn't
>> already been fixed (which is possible if its something that happened in
>> a higher layer or something).
>
> I've only just recently started using the paravirt_ops kernels, but
> all the ones I've tried have exhibited the problem, so I'm not sure
> when the hang was introduced.  It doesn't happen with a xensource
> 2.6.18 tree domU.
>
> 2.6.23.8, 2.6.23.12, and 2.6.24-rc6 <-- pv_ops kernels I've tried that
> have the hang.

Yeah, its all fairly new code.  But the pvops blockfront shouldn't have
any functional differences from the 2.6.18 version of the driver, so
something seems to have got broken along the way.

    J
