From: Zachary Amsden <zach@vmware.com>
Subject: Re: Vmware crashes if compress/misc.c scrolls?
Date: Thu, 21 Jun 2007 19:34:13 -0700
Message-ID: <467B3525.60500@vmware.com>
References: <4679BBCB.2000202@zytor.com>	<4679C152.8070407@goop.org>	<4679C37E.5020908@zytor.com>	<4679C497.8090500@goop.org>	<4679C595.5010905@zytor.com>	<4679C5DE.7090700@goop.org>
	<4679CA51.3080600@zytor.com> <467AF39D.5020606@vmware.com>
	<467B3276.4060208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <467B3276.4060208@zytor.com>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Zachary Amsden wrote:
>   
>> I'm failing to understand exactly what the failure here is.  Can you
>> provide sample code that generates the problem?  Surely, it should be
>> possible to read the framebuffer.
>>
>>     
>
> The supposed test case was leaving the cursor at the bottommost line on
> the screen before running the Linux kernel.
>   

Do you have a sample bootsector that does this?  I would very much like 
to try booting it rather than writing a mock-up which may or may not 
exhibit the same behavior.  .iso, floppy images greatly would help.

The very good news is that I should be able to tell you exactly why the 
exception occurs.  My first thought was perhaps a GDT foul-up resulted 
in a read-only code segment, and mov %cs:(a000) was faulting or 
something like that, but this is a total stab in the dark.

Thanks,

Zach
