From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Sat, 26 May 2007 13:42:53 -0700
Message-ID: <46589BCD.4040807@zytor.com>
References: <4656FB8F.4090604@goop.org>	 <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com> <1180174691.650.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764282AbXEZUnV@vger.kernel.org>
In-Reply-To: <1180174691.650.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>>
>> +  Bit 6 (write): KEEP_SEGMENTS
>> +	Protocol: 2.07+
>> +	- if 0, reload the segment registers in the 32bit entry point.
>> +	- if 1, do not reload the segment registers in the 32bit entry point.
>> +		Assume that %cs %ds %ss %es are all set to flat segments with
>> +		a base of 0 (or the equivalent for their environment).
> 
> You also want to skip the cli: perhaps a separate flag for this is
> appropriate though.
> 

Do we have *any* environment that enters the 32-bit code with interrupts
enabled?  I would think that is unsafe no matter how you do it.

	-hpa
