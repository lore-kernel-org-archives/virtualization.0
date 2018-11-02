From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Date: Fri, 2 Nov 2018 08:40:04 +0100
Message-ID: <11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
References: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Kelley <mikelley@microsoft.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "akataria@vmware.com" <akataria@vmware.com>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 01/11/2018 18:30, Michael Kelley wrote:
> pit_shutdown() doesn't work on Hyper-V because of a quirk in the
> PIT emulation. This problem exists in all versions of Hyper-V and
> had not been noticed previously. When the counter register is set
> to zero, the emulated PIT continues to interrupt @18.2 HZ.
> 
> So add a test for running on Hyper-V, and use that test to skip
> setting the counter register when running on Hyper-V.
> 
> This patch replaces a previously proposed patch with a different
> approach. This new approach follows comments from Thomas Gleixner.

Did you consider using a static_key instead? You could set it in
ms_hyperv_init_platform(). This would enable you to support future
Hyper-V versions which don't require avoiding to set the count to zero.


Juergen
