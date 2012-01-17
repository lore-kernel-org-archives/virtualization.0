From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Tue, 17 Jan 2012 13:57:58 -0800
Message-ID: <4F15EEE6.5020207@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<20120116142014.GA10155@linux.vnet.ibm.com>
	<B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
	<4F146EA5.3010106@linux.vnet.ibm.com>
	<E9F33AFD-F051-4D68-84FF-D259FD6AD19D@suse.de>
	<4F15AF9E.9000907@linux.vnet.ibm.com>
	<1485A122-9D48-46E3-A01E-E37B5C9EC54A@suse.de>
	<4F15BFAE.7060500@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F15BFAE.7060500@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Suzuki Poulose <suzuk>
List-Id: virtualization@lists.linuxfoundation.org

On 01/17/2012 10:36 AM, Raghavendra K T wrote:
> It was a quick test.  two iteration of kernbench (=6runs) and had
> ensured cache is cleared.
> 
> echo "1" > /proc/sys/vm/drop_caches
> ccache -C. Yes may be I can run test as you mentioned..

echo 3 > /proc/sys/vm/drop_caches

is better.  1 will only do page cache, but 3 also does dentries fwiw.
