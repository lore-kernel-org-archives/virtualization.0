From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH 1/3] x86/vmware: Use tsc_khz value for
	calibrate_cpu()
Date: Thu, 27 Oct 2016 23:44:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610272244060.4913__20013.7432002977$1477604881$gmane$org@nanos>
References: <alpine.DEB.2.20.1610262247030.5013@nanos>
	<20161027194454.9729-1-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161027194454.9729-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Makhalov <amakhalov@vmware.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, pv-drivers@vmware.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Oct 2016, Alexey Makhalov wrote:

> [RESEND PATCH 1/3] x86/vmware: Use tsc_khz value for calibrate_cpu()

Please don't do that. RESEND is a keyword, when the same patch (series) is
sent again without any modification vs. the first patch (series). A
possible reason to do so is when a patch (series) fell through the cracks
and the author wants to bring it to attention again for the next merge
window.

If you send an updated patch (series) then please add Vn after PATCH, where
n is the version number of the patch (series).

While at it, please add a cover letter [PATCH Vn 0/n] the next time you send a
patch series. git send-email supports that.

> After aa297292d708, there are separate native calibrations for cpu_khz and

What is aa297292d708? 

Please make that:

commit aa297292d708 ("x86/tsc: Enumerate SKL cpu_khz and tsc_khz via
CPUID") .....

> tsc_khz. The code sets x86_platform.calibrate_cpu to native_calibrate_cpu()
> which looks in cpuid leaf 0x16 or msrs for the cpu frequency.

Which code? And what has the leaf and the msrs to do with your patch?

> Since we keep the tsc_khz constant (even after vmotion), the cpu_khz and
> tsc_khz may start diverging.

Now you talk about vmware related stuff, right?

> tsc_init() now does
> 
> 	cpu_khz = x86_platform.calibrate_cpu();
> 	tsc_khz = x86_platform.calibrate_tsc();
> 	if (tsc_khz == 0)
> 		tsc_khz = cpu_khz;
> 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
> 		cpu_khz = tsc_khz;

And here you copy from the referenced commit. How is that helpful?

> 
> We want the cpu_khz and tsc_khz to be sync even if they diverge less then
> 10%.

We? We as kernel developers, users, guest running in vmware ????

> This patch resolves this issue by setting x86_platform.calibrate_cpu to

"This patch" is just bad. We already know that this is a patch, otherwise
you wouldn't have sent it as a patch.

"this issue" - which issue? Your explanation above does not tell anything
what the issue is.

> vmware_get_tsc_khz().

Here is an example of a proper changelog for this (except for my potential
misinterpretation of the crypto message above):

  Commit aa297292d708 ("x86/tsc: Enumerate SKL cpu_khz and tsc_khz via
  CPUID") seperated the calibration mechanisms for cpu_khz and tsc_khz.

  In a vmware guest this change can lead to divergence between the tsc and
  the cpu frequency, because <Insert reason> .This causes <INSERT observed
  malfunction>.

  Due to the internal design of the vmware hypervisor <Replace that by real
  reason> it's required to keep tsc and cpu frequency in sync.

  Solve this by overriding the x86 platform cpu calibration callback with the
  vmware specific tsc calibration function.

So this describes very clearly:

   1) The change which causes the problem

   2) The problem itself and the resulting malfunction

   3) What needs to be achieved to solve the problem

   4) A short explanation what the solution is

Documentation/SubmittingPatches has further information about proper change
logs.

> @@ -83,6 +83,7 @@ static void __init vmware_platform_setup(void)
>  
>  		vmware_tsc_khz = tsc_khz;
>  		x86_platform.calibrate_tsc = vmware_get_tsc_khz;

A comment explaining why you set the cpu calibration to vmware_get_tsc_khz
might be helpful for casual readers and yourself when you look at that code
5 month from now.

> +		x86_platform.calibrate_cpu = vmware_get_tsc_khz;

Thanks,

	tglx
