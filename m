From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] fixup 3dnow! support
Date: Wed, 07 May 2008 11:19:26 +0300
Message-ID: <4821660E.40903__21542.3788912178$1210148508$gmane$org@qumranet.com>
References: <12100912622893-git-send-email-gcosta@redhat.com>
	<6CF4ABCF-B131-41E0-AAFE-2928E01DDAAF@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6CF4ABCF-B131-41E0-AAFE-2928E01DDAAF@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org, Glauber Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Alexander Graf wrote:
>
> On May 6, 2008, at 6:27 PM, Glauber Costa wrote:
>
>> qemu recently added support for 3dnow instructions. Because of
>> that, 3dnow will be featured among cpuid bits. But this will
>> break kvm in cpus that don't have those instructions (which includes
>> my laptop). So we fixup our cpuid before exposing it to the guest.
>
> I actually don't see where the problem is here. As far as I read the 
> code, the CPUID feature function gets received from the host CPU and 
> bitwise ANDed with a bunch of features that are known to work. What's 
> wrong with that approach?

Nothing.  Note that "known to work" needs to be queried from the kernel, 
since userspace and the kernel are not guaranteed to match.

> But I'm pretty sure Dao can tell us a lot more about this. Has there 
> been any progress in getting the new CPUID code in? I think I could 
> review this sometime soon.

Who's Dao?  Do you mean Dan?

-- 
error compiling committee.c: too many arguments to function
