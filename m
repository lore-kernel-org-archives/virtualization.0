From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 04/10] i386: clean up bzImage generation
Date: Fri, 15 Jun 2007 10:03:20 -0700
Message-ID: <4672C658.2070108__14031.5508972437$1181927055$gmane$org@goop.org>
References: <20070615004818.424726597@goop.org>
	<20070615005012.962196819@goop.org>
	<4672BC3E.6080308@zytor.com> <4672BF82.9050101@goop.org>
	<4672C383.7000304@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4672C383.7000304@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xen-Devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>   
>> H. Peter Anvin wrote:
>>     
>>> Jeremy Fitzhardinge wrote:
>>>   
>>>       
>>>> -setup_move_size: .word  0x8000		# size to move, when setup is not
>>>> +setup_move_size: .word  _setup_size	# size to move, when setup is not
>>>>  					# loaded at 0x90000. We will move setup
>>>>  					# to 0x90000 then just before jumping
>>>>  					# into the kernel. However, only the
>>>>     
>>>>         
>>> This is WRONG and will break 2.00 protocol bootloaders, if any still
>>> exist, and quite possibly some 2.01 protocol bootloaders.  There are
>>> definitiely bootloaders in the field that rely on this implicit value.   
>>>       
>> Ah, I see.  I didn't see any documentation saying that this must be
>> 0x8000.  Or does _setup_size just have to be <= 0x8000?
>>
>>     
>
> The default for unaware bootloaders has been 0x8000 since the boot
> protocol was created, and bootloaders are known to (improperly) rely on
> it.  _setup_size does have to be <= 0x8000, but that's another issue.
>   

Hm, so the worst that could happen is that an old bootloader will
over-copy 0x8000 bytes rather than the specified amount?  How would that
break anything?

> I said it probably wouldn't hurt to drop it.  I don't believe you ever
> actually explained why you wanted it dropped.

Well, I don't specifically care for Xen; I don't really mind either way
in general.  I'll break it into a separate patch and we can handle it
that way.

    J
