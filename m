From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Tue, 14 Feb 2017 15:56:08 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702141552360.3635@nanos>
References: <20170214124408.25931-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170214124408.25931-1-vkuznets@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Feb 2017, Vitaly Kuznetsov wrote:

> Hi,
> 
> while we're still waiting for a definitive ACK from Microsoft that the
> algorithm is good for SMP case (as we can't prevent the code in vdso from
> migrating between CPUs) I'd like to send v2 with some modifications to keep
> the discussion going.

Migration is irrelevant. The TSC page is guest global so updates will
happen on some (random) host CPU and therefor you need the usual barriers
like we have them in our seqcounts unless an access to the sequence will
trap into the host, which would defeat the whole purpose of the TSC page.

Thanks,

	tglx
