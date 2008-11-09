From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Sun, 09 Nov 2008 15:03:21 +0200
Message-ID: <4916DF99.6020107__38344.8424553082$1226236108$gmane$org@redhat.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<20081106174741.GC11773@parisc-linux.org>
	<20081106175308.GA17027@kroah.com> <49137255.9010104@codemonkey.ws>
	<20081109064147.GD7123@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081109064147.GD7123@il.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: randy.dunlap@oracle.com, kvm@vger.kernel.org, grundler@parisc-linux.org, achiang@hp.com, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <anthony@codemonkey.ws>, linux-pci@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Muli Ben-Yehuda wrote:
>> We've been talking about avoiding hardware passthrough entirely and
>> just backing a virtio-net backend driver by a dedicated VF in the
>> host.  That avoids a huge amount of guest-facing complexity, let's
>> migration Just Work, and should give the same level of performance.
>>     
>
> I don't believe that it will, and every benchmark I've seen or have
> done so far shows a significant performance gap between virtio and
> direct assignment, even on 1G ethernet. I am willing however to
> reserve judgement until someone implements your suggestion and
> actually measures it, preferably on 10G ethernet.
>   

Right now virtio copies data, and has other inefficiencies.  With a 
dedicated VF, we can eliminate the copies.

CPU utilization and latency will be worse.  If we can limit the 
slowdowns to an acceptable amount, the simplicity and other advantages 
of VF-in-host may outweigh the performance degradation.

> No doubt device assignment---and SR-IOV in particular---are complex,
> but I hardly think ignoring it as you seem to propose is the right
> approach.

I agree.  We should hedge our bets and support both models.

-- 
error compiling committee.c: too many arguments to function
