From: Glauber Costa <gcosta@redhat.com>
Subject: Re: [kvm-devel] [PATCH] fixup 3dnow! support
Date: Tue, 06 May 2008 20:08:39 -0300
Message-ID: <4820E4F7.9000606__2513.91397691823$1210115463$gmane$org@redhat.com>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
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
Probably is that besides that known to work features, there are also 
features that qemu puts in unconditionally. Among them, 3DNOW.

> But I'm pretty sure Dao can tell us a lot more about this.
Sure, it would be welcome.
