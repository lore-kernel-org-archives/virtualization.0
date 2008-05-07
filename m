From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] fixup 3dnow! support
Date: Wed, 07 May 2008 11:13:01 +0300
Message-ID: <4821648D.2090706__10994.571229867$1210148151$gmane$org@qumranet.com>
References: <12100912622893-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12100912622893-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <gcosta@redhat.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber Costa wrote:
> qemu recently added support for 3dnow instructions. Because of
> that, 3dnow will be featured among cpuid bits. But this will
> break kvm in cpus that don't have those instructions (which includes
> my laptop). So we fixup our cpuid before exposing it to the guest.
>
>   

I've already fixed this in userspace.

In general I don't like silently modifying cpuid options in the kernel, 
since that means we cannot be confident as to what the cpuid the guest 
sees actually is, and so we can't be sure that migration will succeed.  
Instead, the preferred path is to query what cpuid bits the host 
support, pass that to the management app in order to compute the 
greatest common subset, and tell the kernel to use that set.

nx is handled differently due to compatibility issues.  In time we can 
remove the special handling.

-- 
error compiling committee.c: too many arguments to function
