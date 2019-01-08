From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Date: Tue, 8 Jan 2019 02:09:06 +0100
Message-ID: <20190108010906.GA26465__16691.1874119707$1546909644$gmane$org@nautica>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
	<20180719205545.16512-24-pasha.tatashin@oracle.com>
	<20181106054212.GA31768@nautica>
	<95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
	<20190102202032.GA1034@eldamar.local>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
	<20190103234339.GA17457@nautica>
	<CA+CK2bDj1f=VpT+k-e8kSSaoLJ3W9-JPPq9udFdDwd6ijXi28g@mail.gmail.com>
	<20190107234839.GA15269@nautica>
	<CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+CK2bD3kbcNvkVf2kiKQYs+srcw7BdWngqt_wM7Z-QsBJyH6w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: gnomes@lxorguk.ukuu.org.uk, feng.tang@intel.com, kvm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Steven Sistare <steven.sistare@oracle.com>, hpa@zytor.com, boris.ostrovsky@oracle.com, prarit@redhat.com, linux-s390@vger.kernel.org, x86@kernel.org, linux@armlinux.org.uk, Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@redhat.com, Pavel Tatashin <pavel.tatashin@microsoft.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Salvatore Bonaccorso <carnil@debian.org>, jgross@suse.com, douly.fnst@cn.fujitsu.com, sboyd@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Pavel Tatashin wrote on Mon, Jan 07, 2019:
> I did exactly the same sequence on Kaby Lake CPU and could not
> reproduce it. What is your host CPU?

skylake consumer laptop CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz

I don't have any kaby lake around; I have access to older servers though...
-- 
Dominique
