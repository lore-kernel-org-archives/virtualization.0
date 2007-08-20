From: "John Stoffel" <john@stoffel.org>
Subject: Re: [PATCH 0/4] Virtual Machine Time Accounting
Date: Mon, 20 Aug 2007 09:43:17 -0400
Message-ID: <18121.39541.790665.686081__45517.6989235499$1187618365$gmane$org@stoffel.org>
References: <46C99371.7070705@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C99371.7070705@bull.net>
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



Laurent> The aim of these four patches is to introduce Virtual Machine
Laurent> time accounting.

So what does this buy us?  What increased functionality?  

Laurent> [PATCH 1/4] as recent CPUs introduce a third running state,
Laurent> after "user" and "system", we need a new field, "guest", in
Laurent> cpustat to store the time used by the CPU to run virtual
Laurent> CPU. Modify /proc/stat to display this new field.

What happens when you have multiple guests, is this state cummulative?  

I've glanced over these patches and the #ifdefs are ugly..., esp since
the overhead seems to exist even if you don't run any Guest CPUs.  Or
whatever you're doing here.

Please justify this patch more in terms of what it provides and why
it's a good thing to have.  

Thanks,
John
