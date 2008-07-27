From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/2] Paravirt loops per jiffy calculation
Date: Sun, 27 Jul 2008 10:59:54 +0300
Message-ID: <488C2AFA.2030806__8121.03796420178$1217145901$gmane$org@qumranet.com>
References: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1216743328-3213-1-git-send-email-gcosta@redhat.com>
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
Cc: aliguori@codemonkey.ws, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber Costa wrote:
> Hey,
>
> Over the last weeks, there has been some discussion regarding paravirt
> lpj calculation for kvm. Here's my shot at that.
>
> KVM hypervisor already put the right value in our pvclock structures,
> as part of the xen compatibility efforts.
>
> So the first patch moves the respective xen code to pvclock.c (since
> we'll be doing the same calculation anyway), while the second, implements
> functions for kvm that makes use of it.
>
> Turns out that only implementing a pv get_tsc_khz is not enough, since
> it will only do the right thing for cpu0, which is not what we desire.
>
> So we set preset_lpj. Recall this code is run before arch parameter setup,
> so if we pass lpj=xx in the command line, it'll still work.
>
> Have a good (paravirtual) time!
>
>   

I only have this email out of the patchset.  Please resend.


-- 
error compiling committee.c: too many arguments to function
