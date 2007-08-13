From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 11:01:05 +0300
Message-ID: <46C00FC1.1070306__33230.1434515559$1186992175$gmane$org@qumranet.com>
References: <46BC8B39.6050202@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BC8B39.6050202@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:
> The aim of these two patches is to measure the CPU time used by a virtual
> machine. All comments are welcome... I'm not sure it's the good way to do that.
>
> [PATCH 1/2] introduce a new field, "guest", in cpustat to store the time used by
> the CPU to run virtual CPU. Modify /proc/stat to display this new field.
>
> [PATCH 2/2] modify account_system_time() to add cputime to cpustat->guest if we
> are running a VCPU. We add this cputime to  cpustat->user instead of
> cpustat->system because this part of KVM code is in fact user code although it
> is executed in the kernel. We duplicate VCPU time between guest and user to
> allow an unmodified "top(1)" to display correct value. A modified "top(1)" is
> able to display good cpu user time and cpu guest time by subtracting cpu guest
> time from cpu user time.
>   

[copying Ingo and Rusty]

The patches look good.  A couple of comments:

- perhaps the new fields should be guarded by a #ifdef CONFIG_HYPERVISOR 
(selected by CONFIG_KVM)?  that way the (minor) additional overhead is 
only incurred if it can possibly be used.  I imagine that our canine 
cousin will want to use this as well.

- I think that there is per-task accounting of user time and system 
time; that should be extended as well.



-- 
error compiling committee.c: too many arguments to function
