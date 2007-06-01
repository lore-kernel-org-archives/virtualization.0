From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 14:40:26 -0700
Message-ID: <4660924A.2070009@zytor.com>
References: <4656FB8F.4090604@goop.org>
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
	<466087CF.70708@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466087CF.70708@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> 
>> +Protocol:	2.07+
>> +
>> +  A pointer to data that is specific to hardware subarch
>>   
> 
> Do we care particularly? If 8 bytes is enough for the subarch, do we
> care whether its a pointer or literal? After all, this is just a private
> channel between the bootloader and some subarch-specific piece of code
> in the kernel.
> 

I see two options: either we make it a pointer *and a length* so that a
loader can reshuffle it at will (that also implies no absolute pointers
within the data), or it's an opaque cookie anyway.

	-hpa
