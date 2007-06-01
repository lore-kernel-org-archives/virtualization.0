From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 01 Jun 2007 14:57:10 -0700
Message-ID: <46609636.4050208@zytor.com>
References: <4656FB8F.4090604@goop.org>
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
	<466087CF.70708@goop.org> <4660924A.2070009@zytor.com>
	<466093E3.4010701@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <466093E3.4010701@goop.org>
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
> H. Peter Anvin wrote:
>>> Do we care particularly? If 8 bytes is enough for the subarch, do we
>>> care whether its a pointer or literal? After all, this is just a private
>>> channel between the bootloader and some subarch-specific piece of code
>>> in the kernel.
>>>
>>>     
>> I see two options: either we make it a pointer *and a length* so that a
>> loader can reshuffle it at will (that also implies no absolute pointers
>> within the data), or it's an opaque cookie anyway.
> 
> No, it has to be completely opaque.  It might be a pointer to some
> special shared memory or something, and not movable.
> 

Well, if we define is as a movable object then it has to be treated as
such.  It's a protocol definition issue.  If we define it opaque, though
-- of for that matter, if we don't -- we should define what memory it
can live in, though.  Right now, the only "available" memory we have is
end of setup to 0xa0000; the command line is defined to be allocated
from this memory.

	-hpa
